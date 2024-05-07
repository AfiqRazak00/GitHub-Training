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
Imports AjaxControlToolkit
Imports System.Reflection
Imports System

<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Tutup_WS
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateTutup(bln As String, thn As String, nextbln As String, nextthn As String)
        'Public Function SimpanAK(No_Arahan As String, No_Surat As String, No_Staf_Peg_AK As String, Kod_PTJ As String, KW As String, Kod_Vot As String, Tkh_Mula As String Tkh_Tamat As String, Lokasi As String, PeneranganK As String,  Jen_Dok as string, File_Name as string) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        Dim strSql = "select count(*) from smkb_gaji_bulan  where bulan =  '" & bln & "' and tahun =  '" & thn & "'"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt <= 0 Then
            resp.Failed("Tiada rekod untuk disimpan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If fUpdateTutup(nextbln, nextthn) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If


        If success = 1 Then

            resp.Success("Proses penetapan bulan gaji berjaya diproses.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function
    Private Function fUpdateTutup(nextbln As String, nextthn As String)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal = 0
        Dim staMaster As String = ""


        Dim query As String = "UPDATE SMKB_Gaji_Bulan SET bulan = @bulan, tahun = @tahun"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@bulan", nextbln))
        param.Add(New SqlParameter("@tahun", nextthn))

        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fProsesTutup(bln As String, thn As String, nextbln As String, nextthn As String, param As String)

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim counter As Integer = 0
        Dim sqlComm As New SqlCommand
        Dim cmd = New SqlCommand
        Dim dt As New DataTable
        Dim problem As String = ""
        Dim dbconn As New DBKewConn

        'dt = dbconn.Read("SELECT status FROM SMKB_Gaji_Status_Dok where kod_param='" & param & "' and status_dok='12'")
        'If dt.Rows.Count <= 0 Then
        '    resp.Success("Penyediaan baucar di Modul Pembayaran belum selesai. Proses tidak dapat diteruskan.")
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        '    Exit Function
        'End If

        Using sqlcon = New SqlConnection(strCon)
            sqlComm.Connection = sqlcon
            sqlComm.CommandTimeout = 1000
            sqlComm.CommandText = "USP_PROSESAKHIRBULAN"
            sqlComm.CommandType = CommandType.StoredProcedure

            sqlComm.Parameters.Clear()

            sqlComm.Parameters.AddWithValue("@iBulan", bln)
            sqlComm.Parameters.AddWithValue("@iTahun", thn)
            sqlComm.Parameters.AddWithValue("@iNextBulan", nextbln)
            sqlComm.Parameters.AddWithValue("@iNextTahun", nextthn)
            sqlComm.Parameters.AddWithValue("@idProses", Session("ssusrID"))



            sqlcon.Open()

            'sqlComm.ExecuteNonQuery()
            'Dim rowsAffected As Integer = sqlComm.ExecuteNonQuery()
            Dim X = sqlComm.ExecuteNonQuery()
            If X > 0 Then
                success = 1
            Else

                success = 0
            End If
        End Using

        If success = 1 Then
            resp.Success("Proses penetapan bulan gaji berjaya diproses.")
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTotalTutup(bln As String, thn As String) As String
        Dim db = New DBKewConn

        Dim query As String = $"SELECT  COUNT(DISTINCT No_Staf) as Total
        From SMKB_GAJI_Lejar WHERE Bulan ={bln} and Tahun = {thn}"

        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetProgressTutup(bln As String, thn As String) As String
        Dim db = New DBKewConn

        Dim query As String = $"SELECT  COUNT(distinct no_staf)  as JumlahSelesai
        FROM SMKB_Gaji_Lejar_his WHERE Bulan ={bln} and Tahun = {thn}"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetStatusTutup(param As String) As String
        Dim db = New DBKewConn

        Dim query As String = $"SELECT Status_dok FROM SMKB_Gaji_Status_Dok WHERE Status = '05' AND Kod_Param = '{param}'"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function
End Class