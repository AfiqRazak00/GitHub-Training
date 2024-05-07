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
Imports SMKB_Web_Portal.Maklumat_Cawangan
Imports SMKB_Web_Portal.Mklmt_Vendor
Imports SMKB_Web_Portal.Sijil_Pendaftaran
Imports WebGrease.Css.Extensions
Imports System.Data.Entity.Core
Imports System

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class DaftarSyarikat_WS
    Inherits System.Web.Services.WebService

    Dim queryRB As New Query()

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataSya(IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetDataSya(IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetDataSya(IdSya As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.ID_Sykt as IdSya, Kod_Bank as kodBank, Kod_Kategori_Sykt as KatSya, No_Akaun as NoAkaun,
                               (SELECT (kod_Detail + ' - ' + Butiran ) FROM SMKB_Lookup_Detail lp WHERE a.Kod_Bank = lp.Kod_Detail AND lp.Kod = '0097') as ButiranBank,
                               A.Bekalan as Bekalan, A.Perkhidmatan as Perkhidmatan, A.Kerja as Kerja, A.Flag_Sah, A.Status_Aktif,
							   B.Nama_Dok, B.Jenis_Dok, B.Path, B.Bil
                               FROM SMKB_Syarikat_Master A
							   INNER JOIN SMKB_Syarikat_Lampiran B ON A.No_Sykt = B.ID_Sykt 
                               WHERE A.Status = @Status AND (No_Sykt = @NoSya OR A.ID_Sykt = @IdSya) AND (B.Jenis_Dok = @JenisDok1 OR B.Jenis_Dok = @JenisDok2) AND B.Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@NoSya", IdSya))
        param.Add(New SqlParameter("@JenisDok1", "PS"))
        param.Add(New SqlParameter("@JenisDok2", "PB"))

        Return db.Read(query, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataAlmtSya(IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetDataAlmtSya(IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetDataAlmtSya(IdSya As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT  Almt_Semasa_1 as Almt1,
	                           Almt_Semasa_2 as Almt2, Bandar_Semasa as KodBandar, Poskod_Semasa as Poskod, Kod_Negeri_Semasa as KodNegeri, Kod_Negara_Semasa as KodNegara,
	                           Tel_Pej_Semasa as TelPejSya, Tel_Bimbit_Semasa as TelBimbit, Faks_Semasa as NoFaxSya, Web_Semasa as Web,Emel_Semasa as EmailSya,
							   (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE Bandar_Semasa = lp.Kod_Detail AND lp.Kod = '0003') as ButiranBandar,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE Kod_Negeri_Semasa = lp.Kod_Detail AND lp.Kod = '0002') as ButiranNegeri,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE Kod_Negara_Semasa = lp.Kod_Detail AND lp.Kod = '0001') as ButiranNegara
							   FROM SMKB_Syarikat_Master
							   WHERE (ID_Sykt = @IdSya OR No_Sykt = @NoSya) AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@NoSya", IdSya))

        Return db.Read(query, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataPegSya(IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetDataPegSya(IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetDataPegSya(IdSya As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT ID_Rujukan as IdPeg, ID_Sykt, Nama as NamaPegawai1, Jawatan as JwtPegawai1, Tel_Pejabat as TelPejPeg1, Tel_Bimbit as TelPeg1, Emel as EmailPeg1
							   FROM SMKB_Syarikat_Rujukan 
                               WHERE ID_Sykt = @IdSya AND ID_Cwgn = @IdCaw AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@IdCaw", "01"))

        Return db.Read(query, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePegSya(pegSya As MklmtSyarikat) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        queryRB = New Query

        If pegSya Is Nothing Then
            resp.Failed("Sila Lengkapkan Maklumat Yang DiPerlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try

            For Each dataPeg As MklmtSyaPegawai In pegSya.ListPegawai
                'dataPeg.NoBil = GenerateBilPeg(pegSya.IdSya)
                If InsertMklmtPeg(dataPeg.IdPeg, pegSya.IdSya, pegSya.IdCaw, "NULL", dataPeg.KatPegawai, "NULL", dataPeg.NamaPegawai, "NULL", "NULL", dataPeg.JwtPegawai, dataPeg.NoTelPejPeg, dataPeg.NoTelPeg, dataPeg.EmailPegawai) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Alamat Syarikat")
                End If
            Next

            Success += 1
            queryRB.finish()

        Catch ex As Exception

            Success = 0
            queryRB.rollback()

        End Try

        If Success = 0 Then
            resp.Failed("Maklumat Pegawai Gagal Di Simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Pegawai Berjaya Di simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertMklmtPeg(idPeg As String, idSya As String, idCaw As String, noDok As String, katPegawai As String, Bil As String, namaPeg As String, noIcPeg As String, gelpeg As String, jwtPeg As String, noTelPejPeg As String, noTelPeg As String, emailPeg As String)
        Dim db = New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_Rujukan (ID_Rujukan,ID_Sykt ,ID_Cwgn, No_Dokumen, Kod_Kategori, No_Bil, Nama, No_Kad_Pengenalan, Kod_Gelaran,Jawatan,Tel_Pejabat,Tel_Bimbit,Status,Emel) 
                               VALUES(@idPeg,@idsya,@idCaw, @noDok, @katPegawai, @Bil, @namaPeg, @noIcPeg, @gelaran, @jwtPeg, @noTelPejPeg, @noTelPeg, @status, @emailPeg)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPeg", idPeg))
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@idCaw", idCaw))
        param.Add(New SqlParameter("@noDok", noDok))
        param.Add(New SqlParameter("@katPegawai", katPegawai))
        param.Add(New SqlParameter("@Bil", Bil))
        param.Add(New SqlParameter("@namaPeg", namaPeg))
        param.Add(New SqlParameter("@noIcPeg", noIcPeg))
        param.Add(New SqlParameter("@gelaran", gelpeg))
        param.Add(New SqlParameter("@jwtPeg", jwtPeg))
        param.Add(New SqlParameter("@noTelPejPeg", noTelPejPeg))
        param.Add(New SqlParameter("@noTelPeg", noTelPeg))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@emailPeg", emailPeg))

        'Return db.Process(query, param)
        Dim Key As New Dictionary(Of String, String)
        Key.Add("ID_Sykt", idSya)
        Key.Add("ID_Cwgn", idCaw)
        Key.Add("Status", "1")

        Return RbQueryCmdMulti(Key, query, param)
        'Return RbQueryCmd("No_Bil", Bil, query, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveAlmtSya(almtSya As AlmtSyarikat) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        queryRB = New Query

        If almtSya Is Nothing Then
            resp.Failed("Sila Lengkapkan Ruang Yang Disediakan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try
            If UpdateAlmtSya(almtSya, Session("ssusrID")) <> "OK" Then
                Throw New Exception("Gagal Menyimpan Alamat Syarikat")
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            Success = 0
            queryRB.rollback()
        End Try

        If Success = 0 Then
            resp.Failed("Alamat syarikat gagal di simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Alamat Syarikat Berjaya Di simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateAlmtSya(almtSya As AlmtSyarikat, IdSya As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Master SET Almt_Semasa_1 = @Almt1, Almt_Semasa_2 = @Almt2,
                                Bandar_Semasa = @Bandar, Poskod_Semasa = @Poskod,Kod_Negeri_Semasa = @Negeri, Kod_Negara_Semasa = @Negara, Tel_Pej_Semasa = @TelPejSya, 
                                Tel_Bimbit_Semasa = @TelBimbitSya, Faks_Semasa = @NoFaxSya,
                                Web_Semasa = @Web, Emel_Semasa = @EmailSya WHERE No_Sykt = @NoSya "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Almt1", almtSya.Almt1))
        param.Add(New SqlParameter("@Almt2", almtSya.Almt2))
        param.Add(New SqlParameter("@Bandar", almtSya.Bandar))
        param.Add(New SqlParameter("@Poskod", almtSya.Poskod))
        param.Add(New SqlParameter("@Negeri", almtSya.Negeri))
        param.Add(New SqlParameter("@Negara", almtSya.Negara))
        param.Add(New SqlParameter("@Web", almtSya.Web))
        param.Add(New SqlParameter("@EmailSya", almtSya.EmailSya))
        param.Add(New SqlParameter("@TelBimbitSya", almtSya.TelBimbitSya))
        param.Add(New SqlParameter("@TelPejSya", almtSya.TelPejSya))
        param.Add(New SqlParameter("@NoFaxSya", almtSya.NoFaxSya))
        param.Add(New SqlParameter("@NoSya", IdSya))

        Return RbQueryCmd("No_Sykt", IdSya, query, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveMklmtSya(mklmtSya As MklmtSyarikat) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        queryRB = New Query

        If mklmtSya Is Nothing Then
            resp.Failed("Sila Lengkapkan Ruang Yang Bertanda *")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If mklmtSya.NoSya = "" Then
            resp.Failed("Maaf, Syarikat anda Tidak Sah")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try

            If IsSyktExist(mklmtSya.NoSya) <> "OK" Then

                If UpdateMklmtSyarikat(mklmtSya.NoSya, mklmtSya.IdSya, mklmtSya.KodBank, mklmtSya.KatSya, mklmtSya.NoAkaun, mklmtSya.Bekalan, mklmtSya.Perkhidmatan, mklmtSya.Kerja) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat Syarikat")
                End If

            Else

                If InsertMklmtSya(mklmtSya.NoSya, mklmtSya.IdSya, mklmtSya.KodBank, mklmtSya.KatSya, mklmtSya.NoAkaun, mklmtSya.Bekalan, mklmtSya.Perkhidmatan, mklmtSya.Kerja) <> "OK" Then
                    Throw New Exception("Gsgsl Mryimpn MklmtSya")
                End If

            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            queryRB.rollback()
            Success = 0
        End Try

        If Success = 0 Then
            resp.Failed("Maklumat syarikat gagal di simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Syarikat Berjaya Di simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function IsSyktExist(NoSya As String) As String
        Dim db As New DBKewConn
        Dim dt As New DataTable

        Dim Status As String

        Dim query As String = "SELECT No_Sykt From SMKB_Syarikat_Master WHERE No_Sykt = @NoSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoSya", NoSya))

        dt = db.Read(query, param)

        If dt.Rows.Count() > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status

    End Function

    Private Function InsertMklmtSya(IdSya As String, NoSya As String, KodBank As String, KatSya As String, NoAkaun As String, Bekalan As String, Perkhidmatan As String, Kerja As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_Master (ID_Sykt, No_Sykt, Kod_Bank,Kod_Kategori_Sykt, No_Akaun,
                               Bekalan, Perkhidmatan, kerja, Status, Status_Aktif, Tkh_Daftar, Flag_Daftar)
                               VALUES (@idSya, @noSya, @kodBank, @katSya, @noAkaun,
                               @bekalan,@perkhidmatan,@kerja, @status, @statAktif, CONVERT(smallDateTime, GETDATE()) , @flagDaftar) "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@noSya", NoSya))
        param.Add(New SqlParameter("@kodBank", KodBank))
        param.Add(New SqlParameter("@katSya", KatSya))
        param.Add(New SqlParameter("@noAkaun", NoAkaun))
        param.Add(New SqlParameter("@bekalan", Bekalan))
        param.Add(New SqlParameter("@perkhidmatan", Perkhidmatan))
        param.Add(New SqlParameter("@kerja", Kerja))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@statAktif", "00"))
        param.Add(New SqlParameter("@tkhDaftar", "CONVERT(smallDateTime, GETDATE())"))
        param.Add(New SqlParameter("@flagDaftar", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateMklmtSyarikat(NoSya As String, IdSya As String, KodBank As String, KatSya As String, NoAkaun As String, Bekalan As String, Perkhidmatan As String, Kerja As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Master 
                               SET ID_Sykt = @IdSya, Kod_bank = @KodBank, Kod_Kategori_Sykt = @KatSya, No_Akaun = @NoAkaun, Bekalan = @Bekalan, 
                               Perkhidmatan = @Perkhidmatan, Kerja = @Kerja, Status = @Status, Status_Aktif = @StatAktif,
                               Tkh_Daftar = CONVERT(smallDateTime, GETDATE()), Flag_Daftar = @FlagDaftar
                               WHERE No_Sykt = @NoSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoSya", NoSya))
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@KodBank", KodBank))
        param.Add(New SqlParameter("@KatSya", KatSya))
        param.Add(New SqlParameter("@NoAkaun", NoAkaun))
        param.Add(New SqlParameter("@Bekalan", Bekalan))
        param.Add(New SqlParameter("@Perkhidmatan", Perkhidmatan))
        param.Add(New SqlParameter("@Kerja", Kerja))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@StatAktif", "00"))
        param.Add(New SqlParameter("@TkhDaftar", "CONVERT(smallDateTime, GETDATE())"))
        param.Add(New SqlParameter("@FlagDaftar", "1"))

        Return RbQueryCmd("No_Sykt", NoSya, query, param)
    End Function

    'Upload file profil syarikat
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileProfilSya()
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/MS/")
        Return result
    End Function

    ' Upload file penyata bank
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileBank()
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/BANK/")
        Return result
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFile(ByVal uploadFolder As String) As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim fileExtension As String = HttpContext.Current.Request.Form("fileExtension")
        Dim kodDaftar As String = HttpContext.Current.Request.Form("kodDaftar")
        Dim resp As New ResponseRepository
        Dim IdSya As String
        Dim Bil As String
        Dim response As New Response
        queryRB = New Query

        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

            ' Specify the file path where you want to save the uploaded file
            'Dim savePath As String = Server.MapPath($"{uploadFolder}\{IdDok}\{fileName}")
            'IdDok = SelectIdDokLampiran(kodDaftar, Session("ssusrID"))
            IdSya = Session("ssusrID")
            'Bil = SelectBilLampiran(kodDaftar, IdSya)
            Bil = GenerateBilFile(IdSya)
            Dim specificFolder As String = Path.Combine(uploadFolder, IdSya)
            Dim directoryPath As String = Path.Combine(specificFolder, Bil)
            'Dim savePath As String = Path.Combine(specificFolder, fileName)
            Dim savePath As String = Server.MapPath($"{directoryPath}\{fileName}")
            'Dim savePath As String = Path.Combine(directoryPath, fileName)

            If Not Directory.Exists(directoryPath) Then
                Directory.CreateDirectory(Server.MapPath(directoryPath))
            End If

            Try

                If IsFileExist(IdSya, kodDaftar) = 1 Then
                    If UpdateStatFile(IdSya, kodDaftar) <> "OK" Then
                        Throw New Exception("Gagal Menyimpan Lampiran: Gagal Mengemaskini Fail")
                    End If

                    If InsertLampiran(IdSya, "", kodDaftar, fileName, Bil, directoryPath, fileExtension) <> "OK" Then
                        Throw New Exception("Gagal Menyimpan Lampiran: Gagal Memasukkan Fail")
                    End If
                Else
                    If InsertLampiran(IdSya, "", kodDaftar, fileName, Bil, directoryPath, fileExtension) <> "OK" Then
                        Throw New Exception("Gagal Menyimpan Lampiran: Gagal Memasukkan Fail")
                    End If
                End If

                queryRB.finish()
                ' Save the file to the specified path
                postedFile.SaveAs(savePath)
                response.Code = "200"
                response.Message = "berjaya disimpan"

            Catch ex As Exception
                queryRB.rollback()
                response.Message = ex.Message
                response.Code = 500
            End Try

            Debug.WriteLine("Path : " & savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            'Dim payloads As New List(Of String)()
            'payloads.Add(savePath)
            'payloads.Add(Bil)

            'response.Code = "00"
            'response.Payload = payloads
            'response.Message = "Fail Berjaya Di MuatNaik"
            response.Code = 200
            response.Message = "berjaya disimpan"

        Catch ex As Exception
            response.Code = 500
            response.Message = $"Unexpected error uploading file: {ex.Message}"

        End Try

        Return JsonConvert.SerializeObject(response)

    End Function

    Private Function SelectBilLampiran(kodDaftar As String, Idsya As String)
        Dim db = New DBKewConn
        Dim dt As DataTable
        Dim Bil As Integer

        Dim query As String = "Select Bil FROM SMKB_Syarikat_Lampiran WHERE Jenis_Dok = @kodDaftar AND ID_Sykt = @idSya AND status = @status ORDER BY Bil DESC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@idSya", Idsya))
        param.Add(New SqlParameter("@status", 1))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("Bil")) Then
            Bil = Convert.ToInt32(dt.Rows(0)("Bil"))
        End If

        Return Bil
    End Function

    Private Function GenerateBilFile(idSya As String)
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Bil As Integer = 1

        Dim query As String = "SELECT MAX(CONVERT(INT, Bil)) + 1  AS LatestBil FROM SMKB_Syarikat_Lampiran WHERE ID_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("LatestBil")) Then
            Bil = Convert.ToInt32(dt.Rows(0)("LatestBil"))
        End If

        Return Bil
    End Function

    Private Function GenerateBilPeg(idSya As String)
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Bil As Integer = 1

        Dim query As String = "SELECT MAX(CONVERT(INT, Bil)) + 1  AS LatestBil FROM SMKB_Syarikat_Rujukan WHERE ID_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("LatestBil")) Then
            Bil = Convert.ToInt32(dt.Rows(0)("LatestBil"))
        End If

        Return Bil
    End Function

    Private Function InsertLampiran(idSya As String, noRujukan As String, jenDok As String, fileName As String, bil As String, filePath As String, jenFile As String)
        Dim db = New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_Lampiran (ID_Sykt, No_Rujukan, Jenis_Dok, Nama_Dok, Bil, Path, Content_Type, Status) 
                               VALUES (@idSya, @noRujukan, @jenDok, @namadok, @bil, @filePath, @jenFile, @status)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@JenDok", jenDok))
        param.Add(New SqlParameter("@namaDok", fileName))
        param.Add(New SqlParameter("@bil", bil))
        param.Add(New SqlParameter("@filePath", filePath))
        param.Add(New SqlParameter("@jenFile", jenFile))

        'If String.IsNullOrEmpty(idDok) Then
        '    param.Add(New SqlParameter("@idDok", DBNull.Value))
        'Else
        '    param.Add(New SqlParameter("@idDok", idDok))
        'End If

        If String.IsNullOrEmpty(noRujukan) Then
            param.Add(New SqlParameter("@noRujukan", DBNull.Value))
        Else
            param.Add(New SqlParameter("@noRujukan", noRujukan))
        End If

        param.Add(New SqlParameter("@status", 1))

        'Return db.Process(query, param)

        Return RbQueryCmd("Bil", bil, query, param)
    End Function

    Private Function IsFileExist(idSya As String, JenDok As String)
        Dim Db = New DBKewConn
        Dim dt As DataTable
        Dim query As String = "SELECT COUNT(Jenis_Dok) as BilDok FROM SMKB_Syarikat_Lampiran WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenDok AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@jenDok", JenDok))
        param.Add(New SqlParameter("@Status", "1"))

        dt = Db.Read(query, param)

        If dt.Rows(0).Item("BilDok") > 0 Then
            Return 1
        Else
            Return 0
        End If
    End Function
    Private Function UpdateStatFile(IdSya As String, JenDok As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Lampiran SET Status = @statBaru WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenDok AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@jenDok", JenDok))
        param.Add(New SqlParameter("@statBaru", "0"))
        param.Add(New SqlParameter("@status", "1"))

        Dim Key As New Dictionary(Of String, String)
        Key.Add("ID_Sykt", IdSya)
        Key.Add("Jenis_Dok", JenDok)
        Key.Add("Status", "1")

        'Return db.Process(query, param)
        Return RbQueryCmdMulti(Key, query, param)
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

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmdMulti(idKey As Dictionary(Of String, String), strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        Dim key As New Dictionary(Of String, String)

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        Return If(queryRB.execute(idKey, cmd) < 0, "X", "OK")
    End Function
End Class