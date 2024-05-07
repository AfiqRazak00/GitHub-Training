Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Globalization
'Imports System.Globalization
Imports System.Threading
Imports System
Imports SMKB_Web_Portal.Mklmt_Vendor

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class SyarikatBerdaftar_WS
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_SyarikatDaftar(Tindakan As String, category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetList_SyarikatDaftar(Tindakan, category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_SyarikatDaftar(Tindakan As String, category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery = ""
        Dim tindakanQuery = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)()

        If category_filter = "1" Then
            tarikhQuery = "AND CAST(Tkh_Daftar AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then
            tarikhQuery = "AND CAST(Tkh_Daftar AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then
            tarikhQuery = "AND Tkh_Daftar >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND Tkh_Daftar < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then
            tarikhQuery = "AND Tkh_Daftar >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND Tkh_Daftar < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then
            tarikhQuery = "AND Tkh_Daftar >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND Tkh_Daftar < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then
            tarikhQuery = "AND Tkh_Daftar >= @TkhMula AND A.Tkh_Mohon <= @TkhTamat "
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        If Tindakan = "1" Then 'Semakan
            tindakanQuery = "Flag_Daftar = '1' AND Flag_Sah = '1' AND Status_Aktif = '00'"
            'after confirm 02 drpd status apa
            'param.Add(New SqlParameter("@flagDaftar", "1"))
            'param.Add(New SqlParameter("@flagSah", "1"))
            'param.Add(New SqlParameter("@statAktif", "00"))

        ElseIf Tindakan = "2" Then 'Kemaskini
            tindakanQuery = "Status_Aktif = '01' AND Flag_Kemaskini = '1'"
        ElseIf Tindakan = "3" Then 'Penamatan
            tindakanQuery = "Status_Aktif = '01'"
        ElseIf Tindakan = "4" Then 'Digantung
            tindakanQuery = "Status_Lulus = '1' "
        End If

        Dim query As String = "SELECT No_Sykt, ID_Sykt, Nama_Sykt, Bekalan, Perkhidmatan, Kerja, FORMAT(Tkh_Daftar, 'dd/MM/yyyy') AS Tkh_Daftar, FORMAT(Tkh_Hantar, 'dd/MM/yyyy') AS Tkh_Hantar, FORMAT(Tkh_Lulus, 'dd/MM/yyyy') AS Tkh_Lulus, Status_Aktif
                               FROM SMKB_Syarikat_master WHERE 
                               Status ='1' " & tarikhQuery & " AND " & tindakanQuery & "
							   ORDER BY Tkh_Hantar"

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_KelulusanSyarikatDaftar(Tindakan As String, category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetList_KelulusanSyarikatDaftar(Tindakan, category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_KelulusanSyarikatDaftar(Tindakan As String, category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery = ""
        Dim tindakanQuery = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)()

        If category_filter = "1" Then
            tarikhQuery = "AND CAST(Tkh_Daftar AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then
            tarikhQuery = "AND CAST(Tkh_Daftar AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then
            tarikhQuery = "AND Tkh_Daftar >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND Tkh_Daftar < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then
            tarikhQuery = "AND Tkh_Daftar >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND Tkh_Daftar < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then
            tarikhQuery = "AND Tkh_Daftar >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND Tkh_Daftar < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then
            tarikhQuery = "AND Tkh_Daftar >= @TkhMula AND A.Tkh_Mohon <= @TkhTamat "
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        If Tindakan = "1" Then 'Semakan
            tindakanQuery = "Status_Lulus = '3'"
            'after confirm 02 drpd status apa
            'param.Add(New SqlParameter("@flagDaftar", "1"))
            'param.Add(New SqlParameter("@flagSah", "1"))
            'param.Add(New SqlParameter("@statAktif", "00"))

        ElseIf Tindakan = "2" Then 'Kemaskini
            tindakanQuery = "Status_Lulus = '4'"
        End If

        Dim query As String = "SELECT No_Sykt, ID_Sykt, Nama_Sykt, Bekalan, Perkhidmatan, Kerja, FORMAT(Tkh_Daftar, 'dd/MM/yyyy') AS Tkh_Daftar, FORMAT(Tkh_Hantar, 'dd/MM/yyyy') AS Tkh_Hantar, FORMAT(Tkh_Lulus, 'dd/MM/yyyy') AS Tkh_Lulus, Status_Aktif
                               FROM SMKB_Syarikat_master WHERE 
                               Status ='1' " & tarikhQuery & " AND " & tindakanQuery & "
							   ORDER BY Tkh_Hantar"

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_SyarikatDaftarById(IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_SyarikatDaftarById(IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_SyarikatDaftarById(idSya As String)
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim query As String = "SELECT Distinct 
							  A.ID_Sykt as IdSya, 
							  A.No_Sykt,
							  A.Nama_Sykt,
							  A.Kod_Bank as kodBank, 
							  A.Kod_Kategori_Sykt as KatSya, 
							  A.No_Akaun as NoAkaun, 
							  A.Almt_Semasa_1 as Almt1,
	                           A.Almt_Semasa_2 as Almt2, 
							   A.Bandar_Semasa as KodBandar, 
							   A.Poskod_Semasa as Poskod, 
							   A.Kod_Negeri_Semasa as KodNegeri, 
							   A.Kod_Negara_Semasa as KodNegara,
	                           A.Tel_Pej_Semasa as TelPejSya, 
							   A.Tel_Bimbit_Semasa as TelBimbit, 
							   A.Faks_Semasa as NoFaxSya, 
							   A.Web_Semasa as Web,
							   A.Emel_Semasa as EmailSya,
	                           A.Bekalan as Bekalan, 
							   A.Perkhidmatan as Perkhidmatan,
							   A.Kerja as Kerja, 
							   A.Status_Bumi As statBumi,
							   A.Status_Aktif As StatAktif,
							   A.Status_Lulus AS StatLulus,
							   B.Kod_Detail, 
	                           (SELECT (kod_Detail + ' - ' + Butiran ) FROM SMKB_Lookup_Detail lp WHERE a.Kod_Bank = lp.Kod_Detail AND lp.Kod = '0097') as ButiranBank,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE a.Bandar_Semasa = lp.Kod_Detail AND lp.Kod = '0003') as ButiranBandar,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE a.Kod_Negeri_Semasa = lp.Kod_Detail AND lp.Kod = '0002') as ButiranNegeri,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE a.Kod_Negara_Semasa = lp.Kod_Detail AND lp.Kod = '0001') as ButiranNegara,
							   (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Status_Aktif = lp.Kod_Detail AND lp.Kod = 'VDR08') As ButiranStatAktif,
							   (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Status_Lulus = lp.Kod_Detail AND lp.Kod = 'VDR09') As ButiranStatLulus,
	                           C.ID_Rujukan as IdRujukan, 
							   C.Nama as NamaPegawai1, 
							   C.Jawatan as JwtPegawai1, 
							   C.Tel_Pejabat as TelPejPeg1, 
							   C.Tel_Bimbit as TelPeg1, 
							   C.Emel as EmailPeg1,
							   E.Kod_Gred
	                           FROM SMKB_Syarikat_Master A 
	                           INNER JOIN SMKB_Lookup_Detail B ON A.Kod_Negara_Semasa = B.Kod_Detail 
                               INNER JOIN SMKB_Syarikat_Rujukan C ON A.No_Sykt = C.ID_Sykt
							   INNER JOIN SMKB_Syarikat_Daftar D ON A.No_Sykt = D.ID_Sykt
							   INNER JOIN SMKB_Syarikat_Daftar_CIDB E ON E.ID_Daftar = D.No_Daftar
	                           WHERE A.No_Sykt = @idSya AND A.Status = @status AND C.Status = @status AND D.Status = @status AND E.Status = @status AND C.ID_Rujukan = @IdRujukan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@IdRujukan", " "))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_PendaftaranSijil(IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_PendaftaranSijil(IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_PendaftaranSijil(idSya As String)
        Dim db As New DBKewConn
        'Dim dt As DataTable
        Dim query As String = "SELECT A.ID_Sykt, A.Kod_Daftar, A.No_Daftar, FORMAT(A.Tkh_Mula,'dd/MM/yyyy') As TkhMula, FORMAT(A.Tkh_Tamat, 'dd/MM/yyyy') AS TkhTamat, B.Nama_Dok, B.Path, B.Bil
                               FROM SMKB_Syarikat_Daftar A
                               INNER JOIN SMKB_Syarikat_Lampiran B ON B.No_Rujukan = FORMAT(CONVERT(DATETIME2, A.ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff')
                               WHERE A.ID_Sykt = '02634' AND A.Status = '1' AND B.Status = '1' --AND Flag_Hantar = @flagDaftar"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@flagDaftar", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveStatSemak(mklmtSemakan As MklmtSemak) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        'check value is nothing
        If mklmtSemakan Is Nothing Then
            resp.Failed("Sila Isi Ruang Yang disediakan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'update status Lulus
        If UpdateStatLulusSemakan(mklmtSemakan.NoSya, mklmtSemakan.StatLulus) <> "OK" Then
            resp.Failed("Gagal Mengemaskini Status Lulus.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'email
        Dim subject As String
        Dim body As String

        Dim subject1 As String
        Dim body1 As String

        'Double Confirm content email
        If mklmtSemakan.StatLulus = "3" Then
            ' Email content for setujuPengesahan = '0'
            subject = " PERCUBAAN - KELULUSAN PENDAFTARAN VENDOR"
            body = "SEMAKAN PENDAFTARAN VENDOR OLEH PEJABAT BENDAHARI UTEM" _
                           & "<br><br>" _
                           & vbCrLf & "Dimaklumkan bahawa, permohonan Pendaftaran Syarikat " & mklmtSemakan.NamaSya & "," _
                           & "<br><br>" _
                           & vbCrLf & "telah disemak dan bakal diluluskan di masa terdekat." _
                           & "<br><br>" _
                           & vbCrLf & "Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu." _
                           & "<br><br>" _
                           & vbCrLf & "Anda tidak perlu membalas email ini."
        Else
            ' Email content for setujuPengesahan = '0'
            subject = " PERCUBAAN - PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM"
            body = "PENGESAHAN PENJAMIN BAGI PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM" _
                           & "<br><br>" _
                           & vbCrLf & "Dimaklumkan bahawa, penjamin bagi permohonan kenderaan " & mklmtSemakan.NamaSya & "," _
                           & "<br><br>" _
                           & vbCrLf & "gagal membuat pengesahan." _
                           & "<br><br>" _
                           & vbCrLf & "Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu." _
                           & "<br><br>" _
                           & vbCrLf & "Anda tidak perlu membalas email ini."
        End If

        subject1 = " PERCUBAAN - PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM"
        body1 = "PENGESAHAN PENJAMIN BAGI PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM" _
                           & "<br><br>" _
                           & vbCrLf & "Dimaklumkan bahawa, penjamin bagi permohonan kenderaan " & mklmtSemakan.NamaAdmin & "," _
                           & "<br><br>" _
                           & vbCrLf & "telah membuat pengesahan." _
                           & "<br><br>" _
                           & vbCrLf & "Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu." _
                           & "<br><br>" _
                           & vbCrLf & "Anda tidak perlu membalas email ini."

        ' Send the email
        If myEmel(mklmtSemakan.EmailSya, subject, body) = "0" Then
            resp.Failed("Gagal Mengemaskini Maklumat Sijil")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If myEmel(mklmtSemakan.EmailAdmin, subject1, body1) = "0" Then
            resp.Failed("Gagal Mengemaskini Maklumat Sijil")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveStatKelulusan(mklmtSemakan As MklmtSemak) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        'check value is nothing
        If mklmtSemakan Is Nothing Then
            resp.Failed("Sila Isi Ruang Yang disediakan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'update status Lulus
        If UpdateStatLulus(mklmtSemakan.NoSya, mklmtSemakan.StatLulus) <> "OK" Then
            resp.Failed("Gagal Mengemaskini Status Lulus.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If mklmtSemakan.IdSya = "" Then
            mklmtSemakan.IdSya = GenerateSyarikatID()
            If UpdateIDSykt(mklmtSemakan.NoSya, mklmtSemakan.IdSya) <> "OK" Then
                resp.Failed("Gagal Mengemaskini ID Syarikat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If

        'email
        Dim subject As String
        Dim body As String

        Dim subject1 As String
        Dim body1 As String

        'Double Confirm content email
        If mklmtSemakan.StatLulus = "3" Then
            ' Email content for setujuPengesahan = '0'
            subject = " PERCUBAAN - PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM"
            body = "PENGESAHAN PENJAMIN BAGI PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM" _
                           & "<br><br>" _
                           & vbCrLf & "Dimaklumkan bahawa, penjamin bagi permohonan kenderaan " & mklmtSemakan.NamaSya & "," _
                           & "<br><br>" _
                           & vbCrLf & "telah membuat pengesahan." _
                           & "<br><br>" _
                           & vbCrLf & "Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu." _
                           & "<br><br>" _
                           & vbCrLf & "Anda tidak perlu membalas email ini."
        Else
            ' Email content for setujuPengesahan = '0'
            subject = " PERCUBAAN - PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM"
            body = "PENGESAHAN PENJAMIN BAGI PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM" _
                           & "<br><br>" _
                           & vbCrLf & "Dimaklumkan bahawa, penjamin bagi permohonan kenderaan " & mklmtSemakan.NamaSya & "," _
                           & "<br><br>" _
                           & vbCrLf & "gagal membuat pengesahan." _
                           & "<br><br>" _
                           & vbCrLf & "Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu." _
                           & "<br><br>" _
                           & vbCrLf & "Anda tidak perlu membalas email ini."
        End If

        subject1 = " PERCUBAAN - PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM"
        body1 = "PENGESAHAN PENJAMIN BAGI PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM" _
                           & "<br><br>" _
                           & vbCrLf & "Dimaklumkan bahawa, penjamin bagi permohonan kenderaan " & mklmtSemakan.NamaAdmin & "," _
                           & "<br><br>" _
                           & vbCrLf & "telah membuat pengesahan." _
                           & "<br><br>" _
                           & vbCrLf & "Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu." _
                           & "<br><br>" _
                           & vbCrLf & "Anda tidak perlu membalas email ini."

        ' Send the email
        If myEmel(mklmtSemakan.EmailSya, subject, body) = "0" Then
            resp.Failed("Gagal Menghantar Emel Pengesahan Kepada Vendor")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If myEmel(mklmtSemakan.EmailAdmin, subject1, body1) = "0" Then
            resp.Failed("Gagal Menghantar Emel Pengesahan Kepada PIC Bendahari")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateStatLulusSemakan(noSya As String, statLulus As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE FROM SMKB_Syarikat_Master SET Status_Lulus = @StatLulus WHERE No_Sykt = @noSya AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@StatLulus", statLulus))
        param.Add(New SqlParameter("@noSya", noSya))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateStatLulus(noSya As String, statLulus As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE FROM SMKB_Syarikat_Master SET Status_Lulus = @StatLulus, Tkh_Lulus = @tkhLulus, Status_Aktif = @statAktif WHERE No_Sykt = @noSya AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@StatLulus", statLulus))
        param.Add(New SqlParameter("@tkhLulus", "getDate()"))
        param.Add(New SqlParameter("@statAktif", "01"))
        param.Add(New SqlParameter("@noSya", noSya))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateIDSykt(noSya As String, IdSya As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE FROM SMKB_Syarikat_Master SET ID_Sykt = @IdSya WHERE No_Sykt = @noSya AND Status_Aktif = @statusAktif"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@noSya", noSya))
        param.Add(New SqlParameter("@statusAktif", "01"))

        Return db.Process(query, param)
    End Function

    Public strConEmail As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    Public Function myEmel(alamat, subject, body)
        Dim cnExec As OleDb.OleDbConnection
        Dim cmdExec As OleDb.OleDbCommand

        Try
            cnExec = New OleDb.OleDbConnection(strConEmail)
            cnExec.Open()

            cmdExec = New OleDb.OleDbCommand("EXEC msdb.dbo.sp_send_dbmail @profile_name= 'EmailSmkb', @recipients= '" & alamat & "', @subject = '" & subject & "', " &
                  "@body= '" & Replace(body, "'", "''") & "', @body_format='HTML';", cnExec)
            cmdExec.ExecuteNonQuery()
            cmdExec.Dispose()
            cmdExec = Nothing
            cnExec.Dispose()
            cnExec.Close()
            cnExec = Nothing

            Return 1    'Proses Berjaya
        Catch ex As Exception
            ' Show the exception's message.
            MsgBox(ex.Message)
            Return 0    'Proses Gagal
        End Try

    End Function

    Private Function GenerateSyarikatID() As String
        Dim db As New DBKewConn
        Dim dt As New DataTable

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newSyarikatID As String = ""

        Dim query As String = "SELECT TOP 1 No_Akhir as id FROM SMKB_No_Akhir WHERE Kod_Modul ='20' AND Prefix ='RC' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("20", "RC", year, lastID)
        Else

            InsertNoAkhir("20", "RC", year, lastID)
        End If
        newSyarikatID = "RC" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newSyarikatID
    End Function

    Private Function UpdateNoAkhir(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))

        Return db.Process(query, param)
    End Function

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "VENDOR"))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))


        Return db.Process(query, param)
    End Function

End Class