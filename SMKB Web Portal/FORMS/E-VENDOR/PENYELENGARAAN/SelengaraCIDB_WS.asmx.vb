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
Public Class SelengaraCIDB
    Inherits System.Web.Services.WebService

    Dim queryRB As New Query()

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodKategoriCIDB(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodKat(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodKat(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, (Kod_Detail + ' - ' + Butiran ) as text, Butiran FROM SMKB_Lookup_Detail WHERE Kod = @KodLP AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%')"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        param.Add(New SqlParameter("@KodLP", "VDR05"))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_GredKerja() As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_GredKerja()

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_GredKerja() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Gred, Had_Upaya, Butiran From SMKB_Syarikat_CIDB_Gred WHERE Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_GredKerja(KodGred As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_GredKerja(KodGred)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_GredKerja(KodGred As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Gred, Had_Upaya, Butiran From SMKB_Syarikat_CIDB_Gred WHERE Kod_Gred = @KodGred"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodGred", KodGred))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_KategoriSyarikat() As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_KategoriSyarikat()

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_KategoriSyarikat() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail, Butiran FROM SMKB_Lookup_Detail WHERE Kod = @kod AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "VDR05"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_KategoriSyarikat(KodDetail As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_KategoriSyarikat(KodDetail)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_KategoriSyarikat(KodDetail As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail, Butiran FROM SMKB_Lookup_Detail WHERE kod = @kod AND Kod_Detail = @KodDetail AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", "VDR05"))
        param.Add(New SqlParameter("@KodDetail", KodDetail))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_Pengkhususan(IsClicked As String, categoryFilter As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        If IsClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetList_KodKhusus(categoryFilter)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_KodKhusus(categoryFilter As String) As DataTable
        Dim db As New DBKewConn
        Dim KatQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)()

        If categoryFilter <> "" Then
            KatQuery = " AND KodKategori = @KodKat"
        End If
        Dim query As String = "SELECT DISTINCT A.KodKhusus, A.Butiran, A.KodKategori, B.Butiran As KodButiran 
                               FROM SMKB_Syarikat_CIDB_Pengkhususan A
                               INNER JOIN SMKB_Lookup_Detail B ON B.Kod_Detail = A.KodKategori
                               WHERE A.Status = @status" & KatQuery & ""

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@KodKat", categoryFilter))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_Pengkhususan(KodKhusus As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_KodKhusus(KodKhusus)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_KodKhusus(KodKhusus As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT A.KodKhusus , A.Butiran, B.Kod_Detail As value, (B.Kod_Detail + ' - ' + B.Butiran) As text
                               FROM SMKB_Syarikat_CIDB_Pengkhususan A
                               INNER JOIN SMKB_Lookup_Detail B ON B.Kod_Detail = A.KodKategori
                               WHERE A.KodKhusus = @KodKhusus AND A.Status = @status AND B.Status = @status
                               ORDER BY A.KodKhusus"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodKhusus", KodKhusus))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveGredKerja(gredKerja As GredKerja) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Dihantar")
        Dim Success As Integer = 0
        queryRB = New Query

        Try
            If gredKerja Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsGKExist(gredKerja.KodGred) = "OK" Then
                resp.Failed("Maklumat Telah Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If InsertGk(gredKerja.KodGred, gredKerja.HadUpaya, gredKerja.Butiran) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat Gred Kerja")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Gred Kerja Gagal Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If Success = 0 Then
            resp.Failed("Maklumat Gred Kerja Gagal Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Gred Kerja Berjaya Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function EditGredKerja(gredKerja As GredKerja) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Disimpan")
        Dim Success As Integer = 0
        queryRB = New Query

        Try
            If gredKerja Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsGKExist(gredKerja.KodGred) <> "OK" Then
                resp.Failed("Maklumat Gred Kerja Tidak Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If UpdateGk(gredKerja.KodGred, gredKerja.HadUpaya, gredKerja.Butiran) <> "OK" Then
                resp.Failed("Maklumat Gred Kerja Gagal Dikemaskini")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Gred Kerja Gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If Success = 0 Then
            resp.Failed("Maklumat Gred Kerja Gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Gred Kerja Berjaya Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveKatCIDB(KatCIDB As KatCIDB) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Dihantar")
        Dim success As Integer = 0
        queryRB = New Query

        Try
            If KatCIDB Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsKatExist(KatCIDB.KodKat) = "OK" Then
                resp.Failed("Maklumat KAtegori CIDB Telah Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If InsertKatCIDB(KatCIDB.KodKat, KatCIDB.Butiran) <> "OK" Then
                resp.Failed("Maklumat Kategori CIDB Gagal Di Simpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Kategori CIDB Gagal Di Simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If success = 0 Then
            resp.Failed("Maklumat Kategori CIDB Gagal Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Kategori CIDB Berjaya DiSimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function EditKatCIDB(KatCIDB As KatCIDB) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Disimpan")
        Dim Success As Integer = 0
        queryRB = New Query

        Try
            If KatCIDB Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsKatExist(KatCIDB.KodKat) <> "OK" Then
                resp.Failed("Maklumat kkategori CIDB Tidak Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If UpdateKat(KatCIDB.KodKat, KatCIDB.Butiran) <> "OK" Then
                resp.Failed("Maklumat Kategori CIDB Gagal Dikemaskini")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Kategori CIDB gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If Success = 0 Then
            resp.Failed("Maklumat Kategori CIDB Gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Kategori CIDB Berjaya Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveKhusus(DataKhusus As Pengkhususan) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Dihantar")
        Dim success As Integer = 0

        queryRB = New Query

        Try
            If DataKhusus Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsKodKhususExist(DataKhusus.KodKhusus) = "OK" Then
                resp.Failed("Maklumat Telah Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If InsertKhusus(DataKhusus.KodKhusus, DataKhusus.ButiranKhusus, DataKhusus.KodKat, DataKhusus.ButiranKat) <> "OK" Then
                resp.Failed("Maklumat Gagal Disimpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Kategori CIDB Gagal Di simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If success = 0 Then
            resp.Failed("Maklumat Kategori CIDB Gagal Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Kategori CIDB Berjaya DiSimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function EditKhusus(DataKhusus As Pengkhususan) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Disimpan")
        Dim Success As Integer = 0
        queryRB = New Query

        Try
            If DataKhusus Is Nothing Then
                resp.Failed("Sila Isi Maklumat Yang Diperlukan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsKodKhususExist(DataKhusus.KodKhusus) <> "OK" Then
                resp.Failed("Maklumat Tidak Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If UpdateKhusus(DataKhusus.KodKhusus, DataKhusus.ButiranKhusus, DataKhusus.KodKat) <> "OK" Then
                resp.Failed("Maklumat Gagal Dikemaskini")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Pengkhususan Gagal Di SImpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If Success = 0 Then
            resp.Failed("Maklumat Pengkususan Gagal Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Pengkususan Berjaya Dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    Private Function IsGKExist(KodGred As String) As String
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query As String = "SELECT Kod_Gred FROM SMKB_Syarikat_CIDB_Gred WHERE Kod_Gred = @KodGred AND Status = @Status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodGred", KodGred))
        param.Add(New SqlParameter("@Status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status

    End Function

    Private Function IsKatExist(Kod As String) As String
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query As String = "SELECT Kod_Detail FROM SMKB_Lookup_Detail WHERE Kod_Detail = @KodDtl AND Kod = @Kod AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodDtl", Kod))
        param.Add(New SqlParameter("@Kod", "VDR05"))
        param.Add(New SqlParameter("@Status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status

    End Function

    Private Function IsKodKhususExist(Kod As String) As String
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query As String = "SELECT KodKhusus FROM SMKB_Syarikat_CIDB_Pengkhususan WHERE KodKhusus = @KodKhusus AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodKhusus", Kod))
        param.Add(New SqlParameter("@Status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status

    End Function

    Private Function InsertGk(KodGred As String, HadUpaya As String, Butiran As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_CIDB_Gred (Kod_Gred, Had_Upaya, Butiran, Status) 
                               VALUES (@KodGred, @HadUpaya ,@Butiran, @Status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodGred", KodGred))
        param.Add(New SqlParameter("@HadUpaya", HadUpaya))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@Status", "1"))

        'Return db.Process(query, param)
        Return RbQueryCmd("Kod_Gred", KodGred, query, param)
    End Function

    Private Function InsertKatCIDB(KodKat As String, Butiran As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Lookup_Detail (Kod, Kod_Detail, Butiran, Keutamaan, Tarikh_Mula, Tarikh_Tamat, Status, Dibuat_Oleh, Tarikh_Dibuat, Kod_Korporat) 
                               VALUES (@Kod, @KodKat, @Butiran, @keutamaan, @TkhMula, @TkhTamat, @Status, @User, @TkhBuat, @KodKoperat)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod", "VDR05"))
        param.Add(New SqlParameter("@KodKat", KodKat))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@keutamaan", "0"))
        param.Add(New SqlParameter("@TkhMula", DateTime.Now))
        param.Add(New SqlParameter("@TkhTamat", 2030 - 12 - 31))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@User", Session("ssusrID")))
        param.Add(New SqlParameter("@TkhBuat", DateTime.Now))
        param.Add(New SqlParameter("@KodKoperat", "UTeM"))

        'Return db.Process(query, param)
        Return RbQueryCmd("Kod_Detail", KodKat, query, param)
    End Function

    Private Function InsertKhusus(KodKhusus As String, ButiranKhusus As String, KodKat As String, ButiranKat As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_CIDB_Pengkhususan (KodKhusus, Butiran, KodKategori, KodButiran, Status) 
                               VALUES (@KodKhusus, @Butiran, @KodKategori, @ButiranKat, @Status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodKhusus", KodKhusus))
        param.Add(New SqlParameter("@Butiran", ButiranKhusus))
        param.Add(New SqlParameter("@KodKategori", KodKat))
        param.Add(New SqlParameter("@ButiranKat", ButiranKat))
        param.Add(New SqlParameter("@Status", "1"))

        'Return db.Process(query, param)
        Return RbQueryCmd("KodKhusus", KodKhusus, query, param)
    End Function

    Private Function UpdateGk(KodGred As String, HadUpaya As String, Butiran As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_CIDB_Gred 
                               SET Had_Upaya = @HadUpaya, Butiran = @Butiran, Status = @status 
                               WHERE Kod_Gred = @KodGred"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodGred", KodGred))
        param.Add(New SqlParameter("@HadUpaya", HadUpaya))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@status", "1"))

        'Return db.Process(query, param)
        Return RbQueryCmd("Kod_Gred", KodGred, query, param)
    End Function

    'update return x
    Private Function UpdateKat(KodKat As String, Butiran As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Lookup_Detail 
                               SET Kod_Detail = @KodKat, Butiran = @Butiran
                               WHERE Kod = @Kod AND Kod_Detail = @KodKat"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodKat", KodKat))
        param.Add(New SqlParameter("@Kod", "VDR05"))
        param.Add(New SqlParameter("@Butiran", Butiran))

        'Return db.Process(query, param)

        Return RbQueryCmd("Kod_Detail", KodKat, query, param)
    End Function

    Private Function UpdateKhusus(KodKhusus As String, ButiranKhusus As String, KodKat As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_CIDB_Pengkhususan 
                               SET Butiran = @Butiran, KodKategori = @kodKat 
                               WHERE KodKhusus = @KodKhusus"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodKhusus", KodKhusus))
        param.Add(New SqlParameter("@Butiran", ButiranKhusus))
        param.Add(New SqlParameter("@KodKat", KodKat))
        'param.Add(New SqlParameter("@ButiranKat", ButiranKat))

        'Return db.Process(query, param)

        Return RbQueryCmd("KodKhusus", KodKhusus, query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteGred(KodGred As String) As String
        Dim resp As New ResponseRepository
        Dim success As New Integer
        queryRB = New Query

        Try
            If DeleteKodGred(KodGred) <> "OK" Then
                resp.Failed("Gagal Dipadam Maklumat Lampiran")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Gred Kerja Gagal Dipadam")
        End Try

        If success = 0 Then
            resp.Failed("Maklumat Gred Kerja Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Gred KErja Berjaya Di Padam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DeleteKodGred(KodGred As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_CIDB_Gred SET Status = @StatusDelete WHERE Kod_Gred = @KodGred AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodGred", KodGred))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@StatusDelete", "0"))

        'Return db.Process(query, param)

        Return RbQueryCmd("Kod_Gred", KodGred, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteKatCIDB(KodKat As String) As String
        Dim resp As New ResponseRepository
        Dim success As Integer
        queryRB = New Query


        Try
            If DeleteKat(KodKat) <> "OK" Then
                resp.Failed("Gagal Dipadam Maklumat Lampiran")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Kategori CIDB Gagal Dipadam")
        End Try

        If success = 0 Then
            resp.Failed("Maklumat Kategori CIDB Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Kategori CIDB Berjaya Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function DeleteKat(KodKat As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Lookup_Detail SET Status = @StatusBaru WHERE Kod = @Kod AND Kod_Detail = @KodDtl AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodDtl", KodKat))
        param.Add(New SqlParameter("@Kod", "VDR05"))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@StatusBaru", "0"))

        'Return db.Process(query, param)
        Return RbQueryCmd("Kod_Detail", KodKat, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteKhusus(KodKhusus As String) As String
        Dim resp As New ResponseRepository
        Dim success As Integer
        queryRB = New Query

        Try
            If DeleteKodKhusus(KodKhusus) <> "OK" Then
                resp.Failed("Gagal Dipadam Maklumat Lampiran")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            resp.Failed("Maklumat Pengkhususan Gagal Di Padam")
        End Try

        If success = 0 Then
            resp.Failed("Maklumat Pengkhususan Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Pengkhususan Berjaya Di Padam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DeleteKodKhusus(KodKhusus As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_CIDB_Pengkhususan 
                               SET Status = @statusBaru 
                               WHERE KodKhusus = @kod AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod", KodKhusus))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@StatusBaru", "0"))

        'Return db.Process(query, param)

        Return RbQueryCmd("KodKhusus", KodKhusus, query, param)
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