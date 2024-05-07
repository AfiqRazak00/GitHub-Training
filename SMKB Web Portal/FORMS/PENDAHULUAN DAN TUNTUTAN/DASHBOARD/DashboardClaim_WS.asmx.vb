Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.IO
Imports System.Collections.Generic
Imports System.Drawing
Imports System.Globalization
Imports System.Web.Configuration

Imports System.Web
Imports System.Net
Imports System.Net.Mail
Imports System.ValueTuple

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class DashboardClaim_WS
    Inherits System.Web.Services.WebService
    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim sqlquery As New Query

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOTLulusDB(ByVal Tahun As String) As String
        Dim resp As New ResponseRepository

        dt = GetOTLulusDB(Tahun)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetOTLulusDB(Tahun As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "SELECT SUM(jumlah) AS JUMLAH_KESELURUHAN  FROM (select a.Kod_Kump_Wang, b.Butiran KUMP_WANG, a.jenis_pendahuluan, c.butiran AS JENIS, year(a.tkh_adv_perlu) as tahun, sum(a.Jum_Lulus) as jumlah 
                                from SMKB_Pendahuluan_Hdr a, SMKB_Kump_Wang b, SMKB_Pendahuluan_Jenis_ADV c
                                where a.Jum_Lulus is not null and a.Jum_Lulus <> '0.00'
                                and a.Kod_Kump_Wang = b.Kod_Kump_Wang
                                and a.Jenis_Pendahuluan = c.Kod AND YEAR(Tarikh_Mohon)=@Tahun
                                group by year(a.tkh_adv_perlu), a.jenis_pendahuluan, a.Kod_Kump_Wang, b.Butiran, c.butiran) AS ABC"

        param.Add(New SqlParameter("@Tahun", Tahun))


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOTBlmLulusDB(ByVal Tahun As String) As String
        Dim resp As New ResponseRepository

        dt = GetOTBlmLulusDB(Tahun)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetOTBlmLulusDB(Tahun As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "SELECT SUM(jumlah) AS JUMLAH_KESELURUHAN  FROM (select a.Kod_Kump_Wang, b.Butiran AS KUMP_WANG, a.Jenis_Tuntutan, c.butiran AS JENIS, year(a.tarikh_mohon) as tahun, sum(a.Jum_Tuntut_Lulus) as jumlah
                                from SMKB_Tuntutan_Hdr a, SMKB_Kump_Wang b, SMKB_Lookup_Detail c
                                where Jum_Tuntut_Lulus is not null and Jum_Tuntut_Lulus <> '0.00'
                                and a.Kod_Kump_Wang = b.Kod_Kump_Wang
                                and a.Jenis_Tuntutan = c.Kod AND YEAR(Tarikh_Mohon)='2023'
                                group by year(a.tarikh_mohon), a.Jenis_Tuntutan, a.Kod_Kump_Wang, b.Butiran, c.butiran) AS ABC"

        param.Add(New SqlParameter("@Tahun", Tahun))


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadlinechtJumMohonOPTJ(Tahun As String) As String
        Dim resp As New ResponseRepository

        dt = GetLoadlinechtJumMohonOPTJ(Tahun)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetLoadlinechtJumMohonOPTJ(Tahun As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select count(a.no_pendahuluan) as jumlah_mohon, a.Kod_PTJ, b.pejabat, year(a.tkh_adv_perlu) as tahun, a.Jenis_Pendahuluan, c.butiran 
                                from SMKB_Pendahuluan_Hdr a, VPejabat b, SMKB_Pendahuluan_Jenis_ADV c
                                where a.Jum_Lulus is not null and a.Jum_Lulus <> '0.00'
                                and LEFT(a.Kod_PTJ,2) = b.kodpejabat
                                and a.Jenis_Pendahuluan = c.Kod AND YEAR(a.tkh_adv_perlu)=@Tahun
                                group by a.Kod_PTJ, year(a.tkh_adv_perlu), a.Jenis_Pendahuluan, b.pejabat, c.butiran"
        param.Add(New SqlParameter("@Tahun", Tahun))


        Return db.Read(query, param)


    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadlinechtJumMohonOPTJ_1(Tahun As String) As String
        Dim resp As New ResponseRepository

        dt = GetLoadlinechtJumMohonOPTJ_1(Tahun)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetLoadlinechtJumMohonOPTJ_1(Tahun As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        'query asal
        '"select count(a.No_Tuntutan), a.PTj, b.pejabat, year(a.tarikh_mohon) as tahun, a.Jenis_Tuntutan, c.butiran
        'from SMKB_Tuntutan_Hdr a, VPejabat b, SMKB_Lookup_Detail c
        'where a.Jum_Tuntut_Lulus is not null and a.Jum_Tuntut_Lulus <> '0.00'
        'and LEFT(a.Kod_PTJ,2) = b.kodpejabat
        'and a.Jenis_Tuntutan = c.Kod_Detail and c.Kod='AC08' AND YEAR(a.tarikh_mohon)='2023'
        'group by a.PTj, year(a.tarikh_mohon), a.Jenis_Tuntutan, b.pejabat, c.butiran"
        Dim query As String = "select count(a.No_Tuntutan) as jumlah_mohon, a.PTj, b.pejabat, year(a.tarikh_mohon) as tahun, a.Jenis_Tuntutan, c.butiran
                                from SMKB_Tuntutan_Hdr a, VPejabat b, SMKB_Lookup_Detail c
                                where LEFT(a.Kod_PTJ,2) = b.kodpejabat
                                and a.Jenis_Tuntutan = c.Kod_Detail and c.Kod='AC08' AND YEAR(a.tarikh_mohon)=@Tahun
                                group by a.PTj, year(a.tarikh_mohon), a.Jenis_Tuntutan, b.pejabat, c.butiran"
        param.Add(New SqlParameter("@Tahun", Tahun))


        Return db.Read(query, param)


    End Function
End Class