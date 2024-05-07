﻿
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
    Imports System.Net.NetworkInformation

    ' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
    <System.Web.Script.Services.ScriptService()>
    <System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
    <System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class DashboardPO
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumTerima() As String

        Dim tmpDT As DataTable = GetJumTerima()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumTunggak() As String

        Dim tmpDT As DataTable = GetJumTunggak()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumTunggakPeratus(ByVal TotalTerima As String) As String

        Dim tmpDT As DataTable = GetJumTunggakPeratus(TotalTerima)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadTunai() As String

        Dim tmpDT As DataTable = GetJumTunai()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJum_Bill() As String

        Dim tmpDT As DataTable = GetJumBill()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumTerima_Tahunan() As String

        Dim tmpDT As DataTable = GetJumTerimaByYear()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataStatusPie() As String

        Dim tmpDT As DataTable = GetDataStatusPie()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataStatusPie() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT 
                               ((SELECT COUNT(No_Bil) FROM SMKB_Bil_Hdr A INNER JOIN SMKB_Terima_Hdr C ON A.No_Bil=C.No_Rujukan WHERE A.Kontrak='0' AND A.Kod_Status_Dok='03' AND C.Kod_Status_Dok='06') + 
                               (SELECT COUNT(A.No_Bil) FROM SMKB_Bil_Hdr A INNER JOIN SMKB_Terima_Hdr C ON A.No_Bil=C.No_Rujukan WHERE Kontrak='1' AND A.Tkh_Tamat>C.Tkh_Daftar)) As Bayaran_TepatWaktu,
                               (SELECT COUNT(A.No_Bil) FROM SMKB_Bil_Hdr A INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil AND Status_Bayaran IS NULL AND B.Status='1' WHERE Kod_Status_Dok='03' AND DATEDIFF(day, Tkh_Bil, GETDATE()) > 365 ) As Hutang_lapuk,
                               (SELECT COUNT(A.No_Bil) FROM SMKB_Bil_Hdr A INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil WHERE Kontrak='0' AND Kod_Status_Dok='03') as JumBilTertunggak,
                               COUNT(A.No_Bil) As JumBil
                               FROM SMKB_Bil_Hdr A
                               INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                               WHERE Kod_Status_Dok=@kod"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "03"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumBill() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT COUNT(A.No_Bil) as Jum_Bil FROM SMKB_Bil_Hdr A
                               INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                               WHERE Kod_Status_Dok=@kod"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "03"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumTerimaByYear() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT SUM(A.Jumlah) AS JUMLAH_AKAUN_BELUM_TERIMA, B.Tahun
                               FROM SMKB_Bil_Hdr A
                               INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                               WHERE Kod_Status_Dok=@kod
                               GROUP BY B.Tahun 
                               ORDER BY B.Tahun DESC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "03"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumTerima() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT SUM(A.Jumlah) AS JUMLAH_AKAUN_BELUM_TERIMA 
                               FROM SMKB_Bil_Hdr A
                               INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                               WHERE Kod_Status_Dok=@kod"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "03"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumTunggak() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT 
                               ((SELECT CASE WHEN SUM(A.Jumlah) IS NULL THEN '0.00' ELSE SUM(A.Jumlah) END AS JUMLAH FROM SMKB_Bil_Hdr A
                               INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                               WHERE Kontrak='1' AND Tkh_Tamat<GETDATE() AND Kod_Status_Dok='03') + (SELECT SUM(A.Jumlah)-
                               (SELECT SUM(C.Jumlah_Bayar) FROM SMKB_Bil_Hdr A
                               INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                               INNER JOIN SMKB_Terima_Hdr C ON A.No_Bil=C.No_Rujukan
                               WHERE A.Kontrak ='0' AND C.Kod_Status_Dok='06') AS JUMLAH
                               FROM SMKB_Bil_Hdr A
                               INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                               WHERE Kontrak='0' AND Kod_Status_Dok='03')) As Total_Tunggak"

        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@kod", "03"))

        Return db.Read(query)
    End Function

    Private Function GetJumTunggakPeratus(totalBill As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT 
                              (((SELECT CASE WHEN SUM(A.Jumlah) IS NULL THEN '0.00' ELSE SUM(A.Jumlah) END AS JUMLAH FROM SMKB_Bil_Hdr A
                              INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                              WHERE Kontrak='1' AND Tkh_Tamat<GETDATE() AND Kod_Status_Dok='03') + (SELECT SUM(A.Jumlah)-
                              (SELECT SUM(C.Jumlah_Bayar) FROM SMKB_Bil_Hdr A
                              INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                              INNER JOIN SMKB_Terima_Hdr C ON A.No_Bil=C.No_Rujukan
                              WHERE A.Kontrak ='0' AND C.Kod_Status_Dok='06') AS JUMLAH
                              FROM SMKB_Bil_Hdr A
                              INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                              WHERE Kontrak='0' AND Kod_Status_Dok='03')) * 100 / @totalBill) As PeratusTunggakan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@totalBill", totalBill))

        Return db.Read(query, param)
    End Function

    Private Function GetJumTunai() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT SUM(A.Jumlah_Harga) AS TotalJumlah
                               FROM SMKB_Perolehan_Permohonan_Dtl A
                               INNER JOIN SMKB_Perolehan_Permohonan_Hdr B ON B.No_Mohon = A.No_Mohon
                               WHERE B.Status_Dok IN (@value1, @value2)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@value1", "07"))
        param.Add(New SqlParameter("@value2", "08"))

        Return db.Read(query, param)
    End Function



    'baru 

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumPermohonan() As String

        Dim tmpDT As DataTable = GetJumPermohonan()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetJumPermohonan() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "select count(no_mohon) As JumlahPermohonan
                               from SMKB_Perolehan_Permohonan_Hdr"

        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@kod", "03"))
        'Return db.Read(query, param)

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function JumlahKategoriPO() As String

        Dim tmpDT As DataTable = GetJumlahKategoriPO()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetJumlahKategoriPO() As DataTable
        Dim db As New DBKewConn

        Dim currentYear As Integer = DateTime.Now.Year
        Dim query As String = "SELECT A.Jenis_Barang, COUNT(A.Jenis_Barang) AS JumlahPermohonan,B.Butiran
                                FROM SMKB_Perolehan_Permohonan_Hdr A
                                Inner Join SMKB_Lookup_Detail B ON A.Jenis_Barang = B.Kod_Detail
                                where A.Tahun_Perolehan = @year And B.Kod = 'PO03'
                                GROUP BY A.Jenis_Barang,B.Butiran
                                ORDER BY B.Butiran ASC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", currentYear))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataBP() As String

        Dim tmpDT As DataTable = GetDataBP()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetDataBP() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT 
                             ((SELECT COUNT(No_Bil) FROM SMKB_Bil_Hdr A INNER JOIN SMKB_Terima_Hdr C ON A.No_Bil=C.No_Rujukan WHERE A.Kontrak='0' AND A.Kod_Status_Dok='03' AND C.Kod_Status_Dok='06') + 
                             (SELECT COUNT(A.No_Bil) FROM SMKB_Bil_Hdr A INNER JOIN SMKB_Terima_Hdr C ON A.No_Bil=C.No_Rujukan WHERE Kontrak='1' AND A.Tkh_Tamat>C.Tkh_Daftar)) As Bayaran_TepatWaktu,
                             (SELECT COUNT(A.No_Bil) FROM SMKB_Bil_Hdr A INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil AND Status_Bayaran IS NULL AND B.Status='1' WHERE Kod_Status_Dok='03' AND DATEDIFF(day, Tkh_Bil, GETDATE()) > 365 ) As Hutang_lapuk,
                             (SELECT COUNT(A.No_Bil) FROM SMKB_Bil_Hdr A INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil WHERE Kontrak='0' AND Kod_Status_Dok='03') as JumBilTertunggak,
                             COUNT(A.No_Bil) As JumBil
                             FROM SMKB_Bil_Hdr A
                             INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil 
                             WHERE Kod_Status_Dok=@kod"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "03"))

        Return db.Read(query, param)
    End Function
End Class