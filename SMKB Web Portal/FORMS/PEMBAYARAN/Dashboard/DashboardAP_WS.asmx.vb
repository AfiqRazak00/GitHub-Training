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
Public Class DashboardAP_WS
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
    Public Function LoadJumInvois() As String

        Dim tmpDT As DataTable = GetJumInvois()
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
                                (SELECT COUNT(ID_Rujukan) AS DAFTAR_INVOIS FROM SMKB_Pembayaran_Invois_Hdr WHERE Status_Dok=@STATUS_1 ) AS DAFTAR_INVOIS,
                                (SELECT COUNT(ID_Rujukan) AS TERIMA_PERMOHONAN_PEMBAYARAN FROM SMKB_Pembayaran_Invois_Hdr WHERE Status_Dok=@STATUS_2 ) AS TERIMA_PERMOHONAN_PEMBAYARAN"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@STATUS_1", "01"))
        param.Add(New SqlParameter("@STATUS_2", "07"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumBill() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT COUNT(ID_Rujukan) as Jum_Invois FROM SMKB_Pembayaran_Invois_Hdr 
                               WHERE Status_Dok=@kod"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "07"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumTerimaByYear() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT SUM(A.Jumlah_Sebenar) AS JUMLAH_AKAUN_BELUM_TERIMA,YEAR(Tarikh_Daftar) AS TAHUN
                                FROM SMKB_Pembayaran_Invois_Hdr A
                                WHERE Status_Dok=@Status_Dok
                                GROUP BY YEAR(Tarikh_Daftar)
                                ORDER BY YEAR(Tarikh_Daftar) DESC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status_Dok", "07"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumInvois() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT COUNT(ID_Rujukan) AS JUMLAH 
                                FROM SMKB_Pembayaran_Invois_Hdr  
                                WHERE Status_Dok=@kod"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "07"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumTunggak() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT SUM(Jumlah_Sebenar) AS JUMLAH 
                                FROM SMKB_Pembayaran_Invois_Hdr 
                                WHERE Status_Dok ='07'"

        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@kod", "03"))

        Return db.Read(query)
    End Function

    Private Function GetJumTunggakPeratus(totalBill As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT SUM(A.Jumlah_Bayar) AS JUMLAH
                                FROM SMKB_Pembayaran_Invois_Hdr A,
                                SMKB_Pembayaran_Baucar_Hdr B
                                WHERE A.ID_Rujukan=B.ID_Rujukan AND B.Status_Dok=@Status_Dok"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status_Dok", "12"))

        Return db.Read(query, param)
    End Function

    Private Function GetJumTunai() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT SUM(A.Jumlah_Bayar) AS JUMLAH
                                FROM SMKB_Pembayaran_Invois_Hdr A,
                                SMKB_Pembayaran_Baucar_Hdr B
                                WHERE A.ID_Rujukan=B.ID_Rujukan AND B.Status_Dok=@Status_Dok"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status_Dok", "12"))

        Return db.Read(query, param)
    End Function

End Class