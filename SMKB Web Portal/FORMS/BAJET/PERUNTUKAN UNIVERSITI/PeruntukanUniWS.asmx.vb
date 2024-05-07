Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic

Imports System.Drawing
Imports System.Globalization

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PeruntukanUniWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord() As String

        Dim resp As New ResponseRepository

        dt = GetOrder_Senarai()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Senarai() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT Tahun_Bajet, SUM(Jumlah_Asal) AS Jumlah_Asal, SUM(Jumlah_TBH) AS Jumlah_TBH, SUM(Jumlah_KG) AS Jumlah_KG, SUM(Jumlah_BF) AS Jumlah_BF , SUM(Jumlah_Besar) AS Jumlah_Besar
                                FROM
                                (
                                SELECT 
                                    COALESCE(A.Tahun_Bajet, B.Tahun_Bajet, C.Tahun_Bajet, D.Tahun) AS Tahun_Bajet,
                                    COALESCE(A.Jumlah_Asal, 0.00) AS Jumlah_Asal,
                                    COALESCE(B.Jumlah_TBH, 0.00) AS Jumlah_TBH,
                                    COALESCE(C.Jumlah_KG, 0.00) AS Jumlah_KG,
                                    COALESCE(D.Jumlah_BF, 0.00) AS Jumlah_BF,
	                                (COALESCE(A.Jumlah_Asal, 0.00) + COALESCE(B.Jumlah_TBH, 0.00) - COALESCE(C.Jumlah_KG, 0.00) +  COALESCE(D.Jumlah_BF, 0.00)) AS Jumlah_Besar
                                FROM 
                                    (SELECT Tahun_Bajet, SUM(Jumlah_LPU) as Jumlah_Asal FROM SMKB_Agihan_Bajet_Hdr 
                                     WHERE Kod_Agih = 'AL' and Status_Dok = '11' GROUP BY Tahun_Bajet) AS A
                                FULL OUTER JOIN
                                    (SELECT Tahun_Bajet, SUM(Jumlah_Bendahari) as Jumlah_TBH FROM SMKB_Agihan_Bajet_Hdr 
                                     WHERE Kod_Agih = 'BJTTAMBAH' and Status_Dok = '03' GROUP BY Tahun_Bajet) AS B
                                ON A.Tahun_Bajet = B.Tahun_Bajet
                                FULL OUTER JOIN
                                    (SELECT Tahun_Bajet, SUM(Jumlah_Bendahari) as Jumlah_KG FROM SMKB_Agihan_Bajet_Hdr 
                                     WHERE Kod_Agih = 'BJTKURANG' and Status_Dok = '03' GROUP BY Tahun_Bajet) AS C
                                ON A.Tahun_Bajet = C.Tahun_Bajet
                                FULL OUTER JOIN
                                    (SELECT Tahun, SUM(Debit) AS Jumlah_BF FROM smkb_bajet_bf GROUP BY Tahun) AS D
                                ON A.Tahun_Bajet = D.Tahun
                                ) AS A
                                GROUP BY Tahun_Bajet"

        Return db.Read(query)
    End Function

End Class