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
Imports Newtonsoft.Json.Linq
Imports Org.BouncyCastle.Asn1.Sec

Imports System



' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class LaporanBajetWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiLulusTransaksiAwalBajet() As String
        Dim resp As New ResponseRepository

        dt = GetOrder_SenaraiLulusTransaksiAwalBajet()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiLulusTransaksiAwalBajet() As DataTable
        Dim db = New DBKewConn

        Dim param As New List(Of SqlParameter)
        Dim query As String = "select a.No_Mohon, a.Program, a.Justifikasi, b.Kod_Vot_Sbg as Kod_Vot, b.Butiran  ,  FORMAT (A.Created_Date, 'dd-MM-yyyy')  as Tarikh ,  b.Jumlah_NC as Jumlah 
                from  SMKB_Agihan_Bajet_Hdr A, SMKB_Agihan_Bajet_Dtl B  
                where A.Kod_Agih = 'AL'          
				and b.Kod_Agih = 'AL'
				AND A.No_Mohon = B.No_Mohon
                AND A.Kod_PTJ = @ptj      
				AND Tahun_Bajet ='2025'
                and b.Jumlah_Bendahari <> 0  and a.Status_Dok >= '07'"

        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiLulusTransaksiAgihanBajet() As String
        Dim resp As New ResponseRepository

        dt = GetOrder_SenaraiLulusTransaksiAgihanBajet()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiLulusTransaksiAgihanBajet() As DataTable
        Dim db = New DBKewConn

        Dim param As New List(Of SqlParameter)
        Dim query As String = "select a.No_Mohon, a.Program, a.Justifikasi, b.Kod_Vot_Sbg as Kod_Vot, b.Butiran  ,  FORMAT (A.Created_Date, 'dd-MM-yyyy')  as Tarikh ,  b.Jumlah_NC as Jumlah 
                from  SMKB_Agihan_Bajet_Hdr A, SMKB_Agihan_Bajet_Dtl B  
                where A.Kod_Agih = 'AL'          
				and b.Kod_Agih = 'AL'
				AND A.No_Mohon = B.No_Mohon
                AND A.Kod_PTJ = @ptj      
				AND Tahun_Bajet ='2025'
                and b.Jumlah_Bendahari <> 0  and a.Status_Dok = '11'"

        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))

        Return db.Read(query, param)
    End Function


End Class