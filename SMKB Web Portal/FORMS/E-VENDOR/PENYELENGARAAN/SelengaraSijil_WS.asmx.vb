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
Imports System.Data.Entity.Core

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class SelengaraSijil_WS
    Inherits System.Web.Services.WebService

    Dim queryRB As New Query()

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_SijilDaftar() As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SijilDaftar()

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_SijilDaftar() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail As Kod, Butiran 
                               FROM SMKB_Lookup_Detail 
                               WHERE kod = @Kod AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod", "VDR03"))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_Sijil(KodSijil As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_Sijil(KodSijil)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_Sijil(KodSijil As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail As Kod, Butiran 
                               FROM SMKB_Lookup_Detail 
                               WHERE Kod_Detail = @KodSijil AND kod = @kod
                               AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodSijil", KodSijil))
        param.Add(New SqlParameter("@Kod", "VDR03"))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveSijilDaftar(SijilDaftar As SijilPendaftaran) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Dihantar")
        Dim Success As Integer = 0
        queryRB = New Query()

        Try
            If SijilDaftar Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsSijilExist(SijilDaftar.KodSijil) = "OK" Then
                resp.Failed("Maklumat Telah Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If InsertSijil(SijilDaftar.KodSijil, SijilDaftar.ButiranSijil) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat Sijil Pendaftaran")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Sijil Pendaftaran Gagal Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If Success = 0 Then
            resp.Failed("Maklumat Sijil Pendaftaran Gagal Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Sijil Pendaftaran Berjaya Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function EditSijilDaftar(SijilDaftar As SijilPendaftaran) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Disimpan")
        Dim Success As Integer = 0
        queryRB = New Query()

        Try
            If SijilDaftar Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsSijilExist(SijilDaftar.KodSijil) <> "OK" Then
                resp.Failed("Maklumat Tidak Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If UpdateSijil(SijilDaftar.KodSijil, SijilDaftar.ButiranSijil) <> "OK" Then
                resp.Failed("Maklumat Sijil Pendaftaran Gagal Dikemaskini")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Sijil Pendaftaran Gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If Success = 0 Then
            resp.Failed("Maklumat Sijil Pendaftaran Gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Sijil Pendaftaran Berjaya Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

    End Function

    Private Function IsSijilExist(KodSijil As String) As String
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query As String = "SELECT Kod_Detail FROM SMKB_Lookup_Detail 
                               WHERE Kod_Detail = @KodSijil AND Kod = @Kod
                               AND Status = @Status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodSijil", KodSijil))
        param.Add(New SqlParameter("@Kod", "VDR03"))
        param.Add(New SqlParameter("@Status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status
    End Function

    Private Function InsertSijil(KodSijil As String, ButiranSijil As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Lookup_Detail (Kod, Kod_Detail, Butiran, Keutamaan, Tarikh_Mula, Tarikh_Tamat, Status, Dibuat_Oleh, Tarikh_Dibuat, Kod_Korporat) 
                               VALUES (@Kod, @KodSijil, @Butiran, @keutamaan, @TkhMula, @TkhTamat, @Status, @User, @TkhBuat, @KodKoperat)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod", "VDR03"))
        param.Add(New SqlParameter("@KodSijil", KodSijil))
        param.Add(New SqlParameter("@Butiran", ButiranSijil))
        param.Add(New SqlParameter("@keutamaan", "0"))
        param.Add(New SqlParameter("@TkhMula", DateTime.Now))
        param.Add(New SqlParameter("@TkhTamat", 2030 - 12 - 31))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@User", Session("ssusrID")))
        param.Add(New SqlParameter("@TkhBuat", DateTime.Now))
        param.Add(New SqlParameter("@KodKoperat", "UTeM"))

        'Return db.Process(query, param)
        Return RbQueryCmd("Kod_Detail", KodSijil, query, param)
    End Function

    Private Function UpdateSijil(KodSijil As String, ButiranSijil As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Lookup_Detail SET Butiran = @ButiranSijil WHERE Kod = @Kod AND Kod_Detail = @KodSijil"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodSijil", KodSijil))
        param.Add(New SqlParameter("@Kod", "VDR03"))
        param.Add(New SqlParameter("@ButiranSijil", ButiranSijil))

        'Return db.Process(query, param)
        Return RbQueryCmd("Kod_Detail", KodSijil, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteSijil(KodSijil As String) As String
        Dim resp As New ResponseRepository
        Dim success As Integer

        queryRB = New Query()

        Try
            If DeleteKodSijil(KodSijil) <> "OK" Then
                resp.Failed("Gagal Dipadam Maklumat Sijil")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Gagal Dipadam Maklumat Sijil")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If success = 0 Then
            resp.Failed("Maklumat Sijil Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Sijil Berjaya Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DeleteKodSijil(KodSijil As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Lookup_Detail 
                               SET Status = @StatusBaru 
                               WHERE Kod = @Kod AND Kod_Detail = @KodSijil 
                               AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodSijil", KodSijil))
        param.Add(New SqlParameter("@Kod", "VDR03"))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@StatusBaru", "0"))

        Return RbQueryCmd("Kod_Detail", KodSijil, query, param)
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