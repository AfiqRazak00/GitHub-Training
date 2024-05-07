Imports System.ComponentModel
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlTypes
Imports System.Drawing.Imaging
Imports System.Globalization
Imports System.IO
Imports System.Security.Policy
Imports System.Threading.Tasks
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Xml
Imports EnvDTE
Imports iTextSharp.text
Imports Microsoft.Ajax.Utilities
Imports Newtonsoft.Json
Imports Org.BouncyCastle.Asn1
Imports Org.BouncyCastle.Bcpg
Imports WebGrease.Css.Extensions
Imports System.Collections.Generic

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class SelengaraYuran_WS
    Inherits System.Web.Services.WebService

    Dim queryRB As New Query()

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_YuranDaftar() As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_YuranDaftar()

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_YuranDaftar() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod, Butiran, Amaun, Status
                               FROM SMKB_Syarikat_Yuran"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_Yuran(KodYuran As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_Yuran(KodYuran)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_Yuran(KodYuran As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod, Butiran, Amaun, Status
                               FROM SMKB_Syarikat_Yuran WHERE Kod = @KodYuran"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodYuran", KodYuran))
        'param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveYuranDaftar(YuranDaftar As YuranPendaftaran) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Dihantar")
        Dim Success As Integer = 0
        queryRB = New Query()

        Try
            If YuranDaftar Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsYuranExist(YuranDaftar.KodYuran) = "OK" Then
                resp.Failed("Maklumat Telah Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If InsertYuran(YuranDaftar) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat Yuran Pendaftaran")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan Maklumat Yuran")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try



        If Success = 0 Then
            resp.Failed("Maklumat Yuran Pendaftaran Gagal Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Yuran Pendaftaran Berjaya Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function EditYuranDaftar(YuranDaftar As YuranPendaftaran) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Disimpan")
        Dim Success As Integer = 0
        queryRB = New Query()

        Try
            If YuranDaftar Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsYuranExist(YuranDaftar.KodYuran) <> "OK" Then
                resp.Failed("Maklumat Tidak Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If UpdateYuran(YuranDaftar) <> "OK" Then
                resp.Failed("Maklumat Yuran Gagal Dikemaskini")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Yuran Gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If Success = 0 Then
            resp.Failed("Maklumat Yuran Pendaftaran Gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Yuran Pendaftaran Berjaya Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    Private Function IsYuranExist(KodYuran As String) As String
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query As String = "SELECT Kod
                               FROM SMKB_Syarikat_Yuran 
                               WHERE Kod = @KodYuran"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodYuran", KodYuran))
        'param.Add(New SqlParameter("@Status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status
    End Function

    Private Function InsertYuran(YuranDaftar As YuranPendaftaran) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_Yuran (Kod, Butiran, Amaun, Status)
                               VALUES (@KodYuran, @ButiranYuran, @AmaunYuran, @StatYuran)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@KodYuran", YuranDaftar.KodYuran))
        param.Add(New SqlParameter("@ButiranYuran", YuranDaftar.ButiranYuran))
        param.Add(New SqlParameter("@AmaunYuran", YuranDaftar.AmaunYuran))
        param.Add(New SqlParameter("@StatYuran", YuranDaftar.StatYuran))

        'Return db.Process(query, param)
        Return RbQueryCmd("Kod", YuranDaftar.KodYuran, query, param)
    End Function

    Private Function UpdateYuran(YuranDaftar As YuranPendaftaran) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Yuran SET Butiran = @ButiranYuran, Amaun = @Amaun, Status = @status
                               WHERE Kod = @kodYuran"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodYuran", YuranDaftar.KodYuran))
        param.Add(New SqlParameter("@ButiranYuran", YuranDaftar.ButiranYuran))
        param.Add(New SqlParameter("@Amaun", YuranDaftar.AmaunYuran))
        param.Add(New SqlParameter("@status", YuranDaftar.StatYuran))

        'Return db.Process(query, param)
        Return RbQueryCmd("Kod", YuranDaftar.KodYuran, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteYuran(KodYuran As String) As String
        Dim resp As New ResponseRepository
        Dim success As Integer
        queryRB = New Query

        Try
            If DeleteKodYuran(KodYuran) <> "OK" Then
                resp.Failed("Maklumat Yuran Gagal Dipadam")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Yuran Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If success = 0 Then
            resp.Failed("Maklumat Yuran Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Yuran Berjaya Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DeleteKodYuran(KodYuran As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Yuran
                               SET Status = @StatusBaru 
                               WHERE Kod = @KodYuran
                               AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodYuran", KodYuran))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@StatusBaru", "0"))

        'Return db.Process(query, param)

        Return RbQueryCmd("Kod", KodYuran, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmd(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        If queryRB.execute(idValue, idKey, cmd) < 0 Then
            Return "X"
        Else
            Return "OK"
        End If
    End Function

End Class