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


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Pendaftaran_WS
    Inherits System.Web.Services.WebService

    Dim dt As DataTable

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetUserID() As String
        Dim idUser As String = String.Empty

        If Session("ssusrID") IsNot Nothing Then
            idUser = Session("ssusrID").ToString()
        End If

        Return JsonConvert.SerializeObject(idUser)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCodeBank(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodBank(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetNegeri(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodNegeri(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetNegara(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodNegara(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBandar(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodBandar(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPoskod(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodPoskod(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBidang(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodBidang(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSubBidang(ByVal q As String, ByVal p As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodSubBidang(q, p)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKatCIDB(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodKategori(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetGredKerja(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodGredKerja(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenDaftar(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodDaftar(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetEmailSyarikat(NoSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetEmelSyarikat(NoSya)
        'resp.SuccessPayload(dt)

        'Return JsonConvert.SerializeObject(resp.GetResult())

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetEmelSyarikat(NoSya As String)
        Dim db As New DBKewConn
        Dim query As String = "SELECT Nama_Sykt, Emel_Semasa From SMKB_Syarikat_Master WHERE No_Sykt = @NoSya and Status = @status "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noSya", NoSya))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataSyarikat(idSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetDataSyarikat(idSya)
        'resp.SuccessPayload(dt)

        'Return JsonConvert.SerializeObject(resp.GetResult())

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SyarikatSetuju(pengesahan As Pengesahan) As String
        Dim resp As New ResponseRepository
        resp.Success("Data Berjaya Dihantar")
        Dim success As Integer = 0

        If UpdateSetuju(pengesahan.NoSya, pengesahan.Setuju) <> "OK" Then
            resp.Failed("Gagal")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            success += 1
        End If

        'Emel Kepada vendor dan bendahari
        Dim subject As String
        Dim body As String

        Dim subject1 As String
        Dim body1 As String

        'Double Confirm content email
        If pengesahan.Setuju = "true" Then
            ' Email content for setujuPengesahan = '0'
            subject = " PERCUBAAN - PENGESAHAN PENDAFTARAN SYARIKAT"
            body = "PENGESAHAN PERMOHONAN PENDAFTARAN SYARIKAT KEPADA UTEM" _
                           & "<br><br>" _
                           & vbCrLf & "Dimaklumkan bahawa, permohonan pendaftaran syarikat " & pengesahan.NamaSya & "," _
                           & "<br><br>" _
                           & vbCrLf & "telah membuat pengesahan dan proses kelulusan bakal mengambil masa." _
                           & "<br><br>" _
                           & vbCrLf & "Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu." _
                           & "<br><br>" _
                           & vbCrLf & "Anda tidak perlu membalas email ini."
        Else
            ' Email content for setujuPengesahan = '0'
            subject = " PERCUBAAN - PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM"
            body = "PENGESAHAN PENJAMIN BAGI PERMOHONAN SKIM JUAL BELI KENDERAAN STAF UTEM" _
                           & "<br><br>" _
                           & vbCrLf & "Dimaklumkan bahawa, penjamin bagi permohonan kenderaan " & pengesahan.NamaSya & "," _
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
                           & vbCrLf & "Dimaklumkan bahawa, penjamin bagi permohonan kenderaan " & pengesahan.NamaAdmin & "," _
                           & "<br><br>" _
                           & vbCrLf & "telah membuat pengesahan." _
                           & "<br><br>" _
                           & vbCrLf & "Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu." _
                           & "<br><br>" _
                           & vbCrLf & "Anda tidak perlu membalas email ini."

        If myEmel(pengesahan.EmelSya, subject, body) = "0" Then
            resp.Failed("Gagal Menghantar Emel Pengesahan Kepada Vendor")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If myEmel(pengesahan.EmelAdmin, subject1, body1) = "0" Then
            resp.Failed("Gagal Menghantar Emel Pengesahan Kepada PIC Bendahari")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If success = 0 Then
            resp.Failed("Gagal Menghantar Pengesahan Syarikat")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Berjaya Menghantar Pengesahan Syarikat")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Return JsonConvert.SerializeObject(resp.GetResult())
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

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveSyarikat(mklmtSya As MklmtSyarikat) As String

        Dim resp As New ResponseRepository

        resp.Success("Data Berjaya Dihantar")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If mklmtSya Is Nothing Then
            resp.Failed("Tiada Simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If mklmtSya.NoSya = "" Then
            resp.Failed("Syarikat Tidak Pernah berdaftar")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If mklmtSya.IdSya = "" Then
            mklmtSya.IdSya = GenerateSyarikatID()

            'insert almt Syarikat
            For Each almtSya As AlmtSyarikat In mklmtSya.AlmtSya
                If InsertMklmtSya(mklmtSya.IdSya, mklmtSya.NoSya, mklmtSya.KodBank, mklmtSya.KatSya, mklmtSya.NoAkaun, almtSya.Almt1, almtSya.Almt2, almtSya.Bandar, almtSya.Poskod, almtSya.Negeri, almtSya.Negara, almtSya.TelPejSya,
                             almtSya.TelBimbitSya, almtSya.NoFaxSya, almtSya.Web, almtSya.EmailSya, mklmtSya.Bekalan, mklmtSya.Perkhidmatan, mklmtSya.Kerja) <> "OK" Then
                    resp.Failed("Gagal menyimpan maklumat syarikat")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    Exit Function
                End If
            Next
            'insert data pegawai
            For Each dataPeg As MklmtSyaPegawai In mklmtSya.ListPegawai
                If dataPeg.IdPeg = "" Then
                End If
                If InsertMklmtPeg(dataPeg.IdPeg, mklmtSya.IdSya, mklmtSya.IdCaw, dataPeg.KatPegawai, dataPeg.NamaPegawai, "NULL", "NULL", dataPeg.JwtPegawai, dataPeg.NoTelPejPeg, dataPeg.NoTelPeg, dataPeg.EmailPegawai) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Maklumat Pegawai")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    Exit Function
                End If
            Next
            'insert lampiran
            For Each dataFile As MklmtFile In mklmtSya.ListFile
                dataFile.Bil = GenerateBilFile(dataFile.IdSya)
                If InsertLampiran(dataFile.IdSya, "NULL", dataFile.JenDok, dataFile.FileName, dataFile.Bil, dataFile.filePath, dataFile.JenFile) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Maklumat lampiran")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    Exit Function
                End If
            Next

            success += 1

        Else
            'update Almt Syarikat
            For Each almtSya As AlmtSyarikat In mklmtSya.AlmtSya
                If UpdateMklmtSya(mklmtSya.IdSya, mklmtSya.NoSya, mklmtSya.KodBank, mklmtSya.KatSya, mklmtSya.NoAkaun, almtSya.Almt1, almtSya.Almt2, almtSya.Bandar, almtSya.Poskod, almtSya.Negeri, almtSya.Negara, almtSya.TelPejSya,
                             almtSya.TelBimbitSya, almtSya.NoFaxSya, almtSya.Web, almtSya.EmailSya, mklmtSya.Bekalan, mklmtSya.Perkhidmatan, mklmtSya.Kerja) <> "OK" Then
                    resp.Failed("Gagal Mengemaskini Maklumat Syarikat")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next
            'update mklmt pegawai
            For Each dataPeg As MklmtSyaPegawai In mklmtSya.ListPegawai
                If UpdateMklmtPeg(dataPeg.IdPeg, mklmtSya.IdSya, mklmtSya.IdCaw, dataPeg.KatPegawai, dataPeg.NamaPegawai, "NULL", "NULL", dataPeg.JwtPegawai, dataPeg.NoTelPejPeg, dataPeg.NoTelPeg, dataPeg.EmailPegawai) <> "OK" Then
                    resp.Failed("Gagal Mengemaskini Maklumat Pegawai")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next
            'update Lampiran
            For Each dataFile As MklmtFile In mklmtSya.ListFile
                If IsFileExist(mklmtSya.IdSya, dataFile.JenDok) = 1 Then
                    If UpdateStatFile(mklmtSya.IdSya, dataFile.JenDok) <> "OK" Then
                        resp.Failed("Gagal Mengemaskini Maklumat File")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If

                    If InsertLampiran(dataFile.IdSya, "NULL", dataFile.JenDok, dataFile.FileName, dataFile.Bil, dataFile.filePath, dataFile.JenFile) <> "OK" Then
                        resp.Failed("Gagal Menyimpan Maklumat lampiran")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                        Exit Function
                    End If

                End If
            Next

            success += 1

        End If

        If success = 0 Then
            resp.Failed("Maklumat syarikat gagal dihantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Syarikat Berjaya Dihantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    'SaveCawangan
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveCawangan(cawangan As MklmtCawangan) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If cawangan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Check all required field is not empty
        If cawangan Is Nothing Then
            resp.Failed("Sila isi semua ruangan yang diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        If cawangan.IdCaw = "" Then
            cawangan.IdCaw = GenerateIdCwgn()
            For Each almtCaw As AlmtSyarikat In cawangan.AlmtCaw
                If InsertCawangan(cawangan.IdSya, cawangan.IdCaw, cawangan.NamaCaw, almtCaw.Almt1, almtCaw.Almt2, almtCaw.Bandar, almtCaw.Poskod, almtCaw.Negeri, almtCaw.Negara, almtCaw.TelBimbitSya, almtCaw.TelPejSya, almtCaw.NoFaxSya, almtCaw.Web, cawangan.Kodbank, cawangan.NoAkaun) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Maklumat Cawangan")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    Exit Function
                End If
            Next

            'data tak lepas sb length db intuk idCaw dlm Syarikat_Rujukan x cukup
            For Each dataPeg As MklmtSyaPegawai In cawangan.ListPegawai
                If cawangan.IdCaw <> "" Then
                    If InsertMklmtPeg(dataPeg.IdPeg, cawangan.IdSya, cawangan.IdCaw, dataPeg.KatPegawai, dataPeg.NamaPegawai, "NULL", "NULL", dataPeg.JwtPegawai, dataPeg.NoTelPejPeg, dataPeg.NoTelPeg, dataPeg.EmailPegawai) <> "OK" Then
                        resp.Failed("Gagal Menyimpan Maklumat Pegawai Pertama")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If
                End If
            Next

            For Each dataFile As MklmtFile In cawangan.ListFile
                dataFile.Bil = GenerateBilFile(cawangan.IdSya)
                If InsertLampiran(cawangan.IdSya, cawangan.IdCaw, dataFile.JenDok, dataFile.FileName, dataFile.Bil, dataFile.filePath, dataFile.JenFile) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Maklumat lampiran")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next

            success += 1

        Else

            For Each almtCaw As AlmtSyarikat In cawangan.AlmtCaw
                If UpdateCawagan(cawangan.IdSya, cawangan.IdCaw, cawangan.NamaCaw, almtCaw.Almt1, almtCaw.Almt2, almtCaw.Bandar, almtCaw.Poskod, almtCaw.Negeri, almtCaw.Negara, almtCaw.TelBimbitSya, almtCaw.TelPejSya, almtCaw.NoFaxSya, almtCaw.Web, cawangan.Kodbank, cawangan.NoAkaun) <> "OK" Then
                    resp.Failed("Gagal Mengemaskini Maklumat Cawangan")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next

            For Each DataPeg As MklmtSyaPegawai In cawangan.ListPegawai
                If UpdateMklmtPeg("NULL", cawangan.IdSya, cawangan.IdCaw, DataPeg.KatPegawai, DataPeg.NamaPegawai, "NULL", "NUll", DataPeg.JwtPegawai, DataPeg.NoTelPeg, DataPeg.NoTelPejPeg, DataPeg.EmailPegawai) <> "OK" Then
                    resp.Failed("Gagal Mengemaskini Maklumat Pegawai")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next

            For Each DataFile As MklmtFile In cawangan.ListFile
                If isFileExistBankCaw(cawangan.IdSya, cawangan.IdCaw, DataFile.JenFile) = 1 Then
                    If UpdateStatFileBankCaw(cawangan.IdSya, cawangan.IdCaw, DataFile.JenFile) <> "OK" Then
                        resp.Failed("Gagal Mengemaskini Maklumat File")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If

                    If InsertLampiran(cawangan.IdSya, cawangan.IdCaw, DataFile.JenDok, DataFile.FileName, DataFile.Bil, DataFile.filePath, DataFile.JenFile) <> "OK" Then
                        resp.Failed("Gagal Mengemaskini Maklumat lampiran")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If
                End If
            Next

            success += 1

        End If

        If success = 0 Then
            resp.Failed("Maklumat Cawangan gagal dihantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Cawangan Berjaya Dihantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    'SavePengalaman
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePengalaman(pengalaman As PengalamanSyarikat) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If pengalaman Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Check all required field is not empty
        If pengalaman.Tajuk = "" Or pengalaman.NamaSyarikat = "" Or pengalaman.TkhMula = "" Or pengalaman.TkhTamat = "" Or pengalaman.NilaiProjek Is Nothing Then
            resp.Failed("Sila isi semua ruangan yang diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        If pengalaman.IdPengalaman = "" Then
            pengalaman.IdPengalaman = GenerateIdPengalaman(pengalaman.IdSemSya)
            If InsertPengalaman(pengalaman.IdSemSya, pengalaman.IdPengalaman, pengalaman.Tajuk, pengalaman.NamaSyarikat, pengalaman.TkhMula, pengalaman.TkhTamat, pengalaman.NilaiProjek, pengalaman.OrderID) <> "OK" Then
                resp.Failed("Gagal Menyimpan Pengalaman")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            Else
                success += 1
            End If
        Else
            If UpdatePengalaman(pengalaman.IdPengalaman, pengalaman.IdSemSya, pengalaman.Tajuk, pengalaman.NamaSyarikat, pengalaman.TkhMula, pengalaman.TkhTamat, pengalaman.NilaiProjek, pengalaman.OrderID) <> "OK" Then
                resp.Failed("Gagal Menyimpan Pengalaman")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            Else
                success += 1
            End If
        End If

        If success = 0 Then
            resp.Failed("Pengalaman gagal dihantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Pengalaman Berjaya Dihantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    'Save Maklumat Sijil
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveMklmtSijil(mklmtSijil As MklmtSijil) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If mklmtSijil Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If mklmtSijil.IdDaftar = "" Then

            If IsSijilAktifExist(mklmtSijil.NoDaftar) = "OK" Then
                If UpdateStatSijilAktif(mklmtSijil.IdSya, mklmtSijil.KodDaftar) <> "OK" Then
                    resp.Failed("Gagal Mengemaskini Status Sijil")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            If InsertDaftarSijil(mklmtSijil.IdSya, mklmtSijil.KodDaftar, mklmtSijil.NoDaftar, mklmtSijil.TkhMula, mklmtSijil.TkhTamat) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat Sijil")
                Return JsonConvert.SerializeObject(resp.GetResult())

            End If

            For Each lampiran As MklmtFile In mklmtSijil.ListFile
                lampiran.Bil = GenerateBilFile(lampiran.IdSya)
                lampiran.NoRujukan = SelectIdDaftarSijil(lampiran.IdSya, mklmtSijil.NoDaftar)
                If InsertLampiran(lampiran.IdSya, lampiran.NoRujukan, lampiran.JenDok, lampiran.FileName, lampiran.Bil, lampiran.filePath, lampiran.JenFile) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Maklumat lampiran")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next

        Else

            If UpdateDaftarSijil(mklmtSijil.IdDaftar, mklmtSijil.IdSya, mklmtSijil.KodDaftar, mklmtSijil.NoDaftar, mklmtSijil.TkhMula, mklmtSijil.TkhTamat) <> "OK" Then
                resp.Failed("Gagal Mengemaskini Maklumat Sijil")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            For Each lampiran As MklmtFile In mklmtSijil.ListFile
                lampiran.NoRujukan = mklmtSijil.IdDaftar
                If UpdateSijilLampiran(lampiran.FileName, lampiran.filePath, lampiran.JenFile, lampiran.NoRujukan) <> "OK" Then
                    resp.Failed("Gagal Mengemaskini Maklumat Sijil")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next

        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertDaftarSijil(idSya As String, kodDaftar As String, noDaftar As String, tkhMula As String, tkhTamat As String)
        Dim db = New DBKewConn
        Dim query = "INSERT INTO SMKB_Syarikat_Daftar (ID_Sykt, Kod_Daftar, No_Daftar, Tkh_Mula, Tkh_Tamat, Status) VALUES (@idSya, @kodDaftar, @NoDaftar, @tkhMula, @tkhTamat, @status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@NoDaftar", noDaftar))
        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateStatSijilAktif(idSya As String, kodDaftar As String)
        Dim db = New DBKewConn
        Dim query = "UPDATE SMKB_Syarikat_Daftar SET Status = @statBaru WHERE ID_Sykt = @idSya AND Kod_Daftar = @kodDaftar AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@statBaru", "0"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateDaftarSijil(IdDaftar As String, idSya As String, kodDaftar As String, noDaftar As String, tkhMula As String, tkhTamat As String)
        Dim db = New DBKewConn
        Dim query = "UPDATE SMKB_Syarikat_Daftar SET ID_Sykt = @idSya, Kod_Daftar = @kodDaftar, No_Daftar = @NoDaftar, Tkh_Mula = @tkhMula, Tkh_Tamat = @tkhTamat, Status = @status WHERE ID_Daftar = @idDaftar"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idDaftar", IdDaftar))
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@NoDaftar", noDaftar))
        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateSijilLampiran(namaFile As String, filePath As String, JenFile As String, noRujukan As String)
        Dim db = New DBKewConn
        Dim query = "UPDATE SMKB_Syarikat_Lampiran SET Nama_Dok = @namaDok, Path = @path, Content_Type = @jenFile WHERE No_Rujukan = @noRujukan AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@namaDok", namaFile))
        param.Add(New SqlParameter("@path", filePath))
        param.Add(New SqlParameter("@jenFile", JenFile))
        param.Add(New SqlParameter("@noRujukan", noRujukan))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function SelectIdDaftarSijil(idSya As String, noDaftar As String)
        Dim db = New DBKewConn
        Dim parsedDate As DateTime
        Dim idDaftar As DateTime
        Dim query = "SELECT ID_Daftar FROM SMKB_Syarikat_Daftar WHERE ID_Sykt = @idSya AND No_Daftar = @noDaftar And Status = @status "
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@noDaftar", noDaftar))
        param.Add(New SqlParameter("@status", "1"))

        dt = db.Read(query, param)
        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("ID_Daftar")) Then
            idDaftar = DirectCast(dt.Rows(0)("ID_Daftar"), DateTime)
            ' Convert the DateTime object to the desired format
            Dim formattedDate As String = idDaftar.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
            Return formattedDate
        End If

        Return String.Empty
    End Function

    Private Function IsSijilAktifExist(noDaftar As String) As String
        Dim db = New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query = "SELECT No_Daftar From SMKB_Syarikat_Daftar WHERE No_Daftar = @noDaftar AND Status = @status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", noDaftar))
        param.Add(New SqlParameter("@Status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            ' Rows exist, perform your logic here
            Status = "OK"
        Else
            ' No rows found, perform alternative logic if needed
            Status = "X"
        End If

        Return Status
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_DaftarSijil(IdSya As String, KodDaftar As String, ActiveTabs As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_DaftarSijil(IdSya, KodDaftar, ActiveTabs)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_DaftarSijil(IdSya As String, KodDaftar As String, ActiveTabs As String) As DataTable
        Dim db = New DBKewConn
        Dim kodDaftarQuery As String = ""


        If ActiveTabs = "#lainLain" Then
            kodDaftarQuery = " ,(SELECT Butiran FROM SMKB_Lookup_Detail LP WHERE Kod = 'VDR03' AND LP.Kod_Detail IN ('BP','KSM','PKK', 'SPAN') AND LP.Kod_Detail = @kodDaftar) As ButiranJenDaftar"
        Else
            kodDaftarQuery = ""
        End If

        Dim query As String = "SELECT FORMAT(CONVERT(DATETIME2, ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff') AS ID_Daftar, A.Kod_Daftar AS KodDaftar, A.No_Daftar AS NoDaftar, FORMAT(A.Tkh_Mula, 'yyyy-MM-dd') As TkhMula, FORMAT(A.Tkh_Tamat, 'yyyy-MM-dd') As TkhTamat 
                               " & kodDaftarQuery & "
                               FROM SMKB_Syarikat_Daftar A
                               WHERE ID_Sykt = @idSya AND Kod_Daftar = @kodDaftar AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@kodDaftar", KodDaftar))
        param.Add(New SqlParameter("@status", 1))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_DaftarSijilById(IdDaftar As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_DaftarSijilById(IdDaftar)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_DaftarSijilById(IdDaftar As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT FORMAT(CONVERT(DATETIME2, A.ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff') AS ID_Daftar, A.Kod_Daftar AS KodDaftar, (B.Kod_Detail + ' - ' + B.Butiran) As ButiranJenDaftar, A.No_Daftar AS NoDaftar, FORMAT(A.Tkh_Mula, 'yyyy-MM-dd') As TkhMula, FORMAT(A.Tkh_Tamat, 'yyyy-MM-dd') As TkhTamat 
                               FROM SMKB_Syarikat_Daftar A
							   INNER JOIN SMKB_Lookup_Detail B ON A.Kod_Daftar = B.Kod_Detail
                               WHERE B.Kod = @kod AND A.ID_Daftar = @idDaftar AND A.Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idDaftar", IdDaftar))
        param.Add(New SqlParameter("@kod", "VDR03"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    'Save Maklumat Bidang
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveBidangMOF(mklmtBidangList As List(Of MKlmtBidangMOF)) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If mklmtBidangList Is Nothing OrElse mklmtBidangList.Count = 0 Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        ' You can loop through the array and process each MKlmtBidangMOF object as needed
        For Each mklmtBidang In mklmtBidangList

            If mklmtBidang.NoDaftar = "" Then
                resp.Failed("Sila Isi nombor Pendaftaran")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsBidangExist(mklmtBidang.NoDaftar, mklmtBidang.KodBidang) <> "OK" Then
                resp.Failed("Maklumat Bidang telah wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            End If

            If mklmtBidang.Bil = "" Then
                mklmtBidang.Bil = GenerateIdBilBidang(mklmtBidang.NoDaftar)
                If InsertMklmtBidang(mklmtBidang) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Maklumat Bidang")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If
            ' Additional processing for each item in the array
        Next

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertMklmtBidang(mklmtBidang As MKlmtBidangMOF)
        Dim db = New DBKewConn
        Dim query = "INSERT INTO SMKB_Syarikat_Daftar_Bidang (No_Daftar, Bil, Kod_Bidang, Status) VALUES (@noDaftar, @bil, @kodBidang, @status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", mklmtBidang.NoDaftar))
        param.Add(New SqlParameter("@bil", mklmtBidang.Bil))
        param.Add(New SqlParameter("@kodBidang", mklmtBidang.KodBidang))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_PicMof(IdRujukan As String, IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_PicMof(IdRujukan, IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_PicMof(IdRujukan As String, IdSya As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT ID_Rujukan, ID_Sykt, Nama, No_Kad_Pengenalan, Kod_Gelaran, Jawatan, Tel_Pejabat, Tel_Bimbit 
                               FROM SMKB_Syarikat_Rujukan WHERE ID_Rujukan = @IdRujukan AND ID_Sykt = @idSya AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@IdRujukan", IdRujukan))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_PicCidb(IdRujukan As String, IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_PicCidb(IdRujukan, IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_PicCidb(IdRujukan As String, IdSya As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT ID_Rujukan, ID_Sykt, Nama, No_Kad_Pengenalan, Kod_Gelaran, Jawatan, Tel_Pejabat, Tel_Bimbit 
                               FROM SMKB_Syarikat_Rujukan WHERE ID_Rujukan = @IdRujukan AND ID_Sykt = @idSya AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@IdRujukan", IdRujukan))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePicSijilMOF(mklmtPicMof As MklmtPicMof) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If mklmtPicMof Is Nothing Then
            resp.Failed("Sila Isi di ruang yang ditetapkan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If mklmtPicMof.NoICPegMof <> "" Then
            If InsertMklmtPeg(mklmtPicMof.IdRujukan, mklmtPicMof.IdSya, "NULL", "NULL", mklmtPicMof.NamaPegMof, mklmtPicMof.NoICPegMof, mklmtPicMof.Gelaran, mklmtPicMof.JawatanMof, "NULL", mklmtPicMof.NoTelPegMof, "NULL") <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat Pegawai")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_Bumi(IdDaftar As String, IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_Bumi(IdDaftar, IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_Bumi(IdDaftar As String, IdSya As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT FORMAT(CONVERT(DATETIME2, ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff') AS ID_Daftar, Kod_Daftar, No_Daftar, FORMAT(Tkh_Mula, 'dd/MM/yyyy') As Tkh_Mula, FORMAT(Tkh_Tamat, 'dd/MM/yyyy') AS Tkh_Tamat FROM SMKB_Syarikat_Daftar WHERE ID_Sykt = @idSya AND ID_Daftar = @idDaftar AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@idDaftar", IdDaftar))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveTarafBumi(mklmtBumi As MklmtTarafBumi) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If mklmtBumi Is Nothing Then
            resp.Failed("Sila Isi di ruang yang ditetapkan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If mklmtBumi.NoDaftar = "" Then
            resp.Failed("Sila isi Maklumat Nombor Sijil Pendaftaran Bumi")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If mklmtBumi.StatBumi = "BUMI" Then
            If UpdateStatBumi(mklmtBumi.IdSya) <> "OK" Then
                resp.Failed("Taraf Bumiputera Tidak Dapat DiSimpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Else
            If UpdateStatBukanBumi(mklmtBumi.IdSya) <> "OK" Then
                resp.Failed("Taraf Bumiputera Tidak Dapat DiSimpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If

        If mklmtBumi.IdDaftar = "" Then
            If InsertDaftarSijil(mklmtBumi.IdSya, mklmtBumi.StatBumi, mklmtBumi.NoDaftar, mklmtBumi.TkhMula, mklmtBumi.TkhTamat) <> "OK" Then
                resp.Failed("Taraf Bumiputera Tidak Dapat Disimpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            For Each lampiran As MklmtFile In mklmtBumi.ListFile
                lampiran.Bil = GenerateBilFile(lampiran.IdSya)
                lampiran.NoRujukan = SelectIdDaftarSijil(lampiran.IdSya, mklmtBumi.NoDaftar)
                If InsertLampiran(lampiran.IdSya, lampiran.NoRujukan, lampiran.JenDok, lampiran.FileName, lampiran.Bil, lampiran.filePath, lampiran.JenFile) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Maklumat lampiran")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next

        Else
            If UpdateDaftarSijil(mklmtBumi.IdDaftar, mklmtBumi.IdSya, mklmtBumi.StatBumi, mklmtBumi.NoDaftar, mklmtBumi.TkhMula, mklmtBumi.TkhTamat) <> "OK" Then
                resp.Failed("Gagal Mengemaskini Maklumat Taraf Bumi")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            For Each lampiran As MklmtFile In mklmtBumi.ListFile
                lampiran.NoRujukan = mklmtBumi.IdDaftar
                If UpdateSijilLampiran(lampiran.FileName, lampiran.filePath, lampiran.JenFile, lampiran.NoRujukan) <> "OK" Then
                    resp.Failed("Gagal Mengemaskini Maklumat Sijil")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Next
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateStatBumi(idSya As String) As String
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Master SET Status_Bumi = 1 WHERE No_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        'param.Add(New SqlParameter("@status", "NULL"))

        Return db.Process(query, param)
    End Function
    Private Function UpdateStatBukanBumi(idSya As String) As String
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Master SET Status_Bumi = 0 WHERE No_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        'param.Add(New SqlParameter("@status", "NULL"))

        Return db.Process(query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_Pengkhusus(idSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_Khusus(idSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_Khusus(idSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT A.ID_Daftar, 
                               (SELECT Butiran AS ButiranGred FROM SMKB_Syarikat_CIDB_Gred KG WHERE KG.Kod_Gred = A.Kod_Gred) As KodGred,
                               (SELECT (Kod_Detail + '-' + Butiran) as text FROM SMKB_Lookup_Detail LP WHERE Kod = 'VDR05' AND LP.Kod_Detail = A.Kod_Kategori) As Kategori,
                               A.Kod_Khusus, (SELECT Butiran FROM SMKB_Syarikat_CIDB_Pengkhususan KK WHERE KK.KodKhusus = A.Kod_Khusus) As ButiranKhusus
                               FROM SMKB_Syarikat_Daftar_CIDB A
                               INNER JOIN SMKB_Syarikat_Daftar B ON A.ID_Daftar = B.No_Daftar
                               WHERE A.Status = @status AND B.Status = @status AND B.ID_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@status", 1))

        Return db.Read(query, param)
    End Function

    'Save Maklumat Pengkhususan CIDB
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveKatCIDB(KhususList As List(Of MklmtKatCIDB)) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If KhususList Is Nothing OrElse KhususList.Count = 0 Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        ' You can loop through the array and process each MKlmtBidangMOF object as needed
        For Each mklmtKhusus In KhususList
            If mklmtKhusus.NoDaftar = "" Then
                resp.Failed("Sila Isi Nombor Pendaftaran")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If IsKodKhususExist(mklmtKhusus.NoDaftar, mklmtKhusus.KodKhusus) <> "OK" Then
                resp.Failed("Maklumat Pengkhususan telah wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            End If

            If mklmtKhusus.Bil = "" Then
                mklmtKhusus.Bil = GenerateIdBilKhusus(mklmtKhusus.NoDaftar)
                If InsertMklmtKatCIDB(mklmtKhusus) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Maklumat Kategori CIDB")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

        Next

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function InsertMklmtKatCIDB(mklmtKhusus As MklmtKatCIDB)
        Dim db = New DBKewConn
        Dim query = "INSERT INTO SMKB_Syarikat_Daftar_CIDB ( ID_Daftar, Bil, Kod_Kategori, Kod_Khusus, Status, Kod_Gred) 
                     VALUES(@noDaftar, @bil, @kodKategori, @kodKhusus, @status, @kodGred)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", mklmtKhusus.NoDaftar))
        param.Add(New SqlParameter("@bil", mklmtKhusus.Bil))
        param.Add(New SqlParameter("@kodKategori", mklmtKhusus.KodKategori))
        param.Add(New SqlParameter("@kodKhusus", mklmtKhusus.KodKhusus))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kodGred", mklmtKhusus.KodGred))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePicSijilCIDB(mklmtPicCIDB As MklmtPicCIDB) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If mklmtPicCIDB Is Nothing Then
            resp.Failed("Sila Isi di ruang yang ditetapkan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If mklmtPicCIDB.NoICPeg <> "" Then
            If InsertMklmtPeg(mklmtPicCIDB.IdRujukan, mklmtPicCIDB.IdSya, "NULL", "NULL", mklmtPicCIDB.NamaPeg, mklmtPicCIDB.NoICPeg, mklmtPicCIDB.Gelaran, mklmtPicCIDB.Jawatan, "NULL", mklmtPicCIDB.NoTelPeg, "NULL") <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat Pegawai")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Else
            If UpdateMklmtPeg(mklmtPicCIDB.IdRujukan, mklmtPicCIDB.IdSya, "NULL", "NULL", mklmtPicCIDB.NamaPeg, mklmtPicCIDB.NoICPeg, mklmtPicCIDB.Gelaran, mklmtPicCIDB.Jawatan, "NULL", mklmtPicCIDB.NoTelPeg, "NULL") Then
                resp.Failed("Gagal Mengemaskini Maklumat Pegawai")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFile(ByVal uploadFolder As String) As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim kodDaftar As String = HttpContext.Current.Request.Form("kodDaftar")
        Dim resp As New ResponseRepository
        Dim IdSya As String
        Dim Bil As String

        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

            ' Specify the file path where you want to save the uploaded file
            'Dim savePath As String = Server.MapPath($"{uploadFolder}\{IdDok}\{fileName}")
            'IdDok = SelectIdDokLampiran(kodDaftar, Session("ssusrID"))
            IdSya = Session("ssusrID")
            Bil = SelectBilLampiran(kodDaftar, IdSya)
            Dim specificFolder As String = Path.Combine(uploadFolder, IdSya)
            Dim directoryPath As String = Path.Combine(specificFolder, Bil)
            'Dim savePath As String = Path.Combine(specificFolder, fileName)
            Dim savePath As String = Server.MapPath($"{directoryPath}\{fileName}")
            'Dim savePath As String = Path.Combine(directoryPath, fileName)

            If Not Directory.Exists(directoryPath) Then
                Directory.CreateDirectory(Server.MapPath(directoryPath))
            End If


            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            Debug.WriteLine("Path : " & savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            Return "OK"
            'Catch ex As HttpException
            '    Return $"Error uploading file: {ex.Message}"
        Catch ex As Exception
            Return $"Unexpected error uploading file: {ex.Message}"
        End Try

    End Function

    Private Function SelectIdDokLampiran(kodDaftar As String, idSya As String)
        Dim db = New DBKewConn
        Dim dt As DataTable
        Dim IdDok As String = ""

        Dim query As String = "Select ID_Dok FROM SMKB_Syarikat_Lampiran WHERE Jenis_Dok = @kodDaftar AND ID_Sykt = @idSya AND status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@status", 1))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("ID_Dok")) Then
            ' Assuming the date is in the first column of the first row
            Dim originalDate As DateTime = Convert.ToDateTime(dt.Rows(0)("ID_Dok"))

            ' Format the date as per your requirement
            IdDok = originalDate.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
        End If

        Return IdDok

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
    Public Function UploadFileSijilSSM()
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/SSM/")
        Return result
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileSijilMOF()
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/MOF/")
        Return result
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileSijilCIDB()
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/CIDB/")
        Return result
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileSijilLain()
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/LAIN/")
        Return result
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileSijilBumi()
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/BUMI/")
        Return result
    End Function

    <WebMethod>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function ResolveAppUrl(relativeUrl As String) As String
        ' Get the base URL of your web application
        'Dim baseUrl As String = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) & HttpContext.Current.Request.ApplicationPath.TrimEnd("/"c)

        '' Combine the base URL with the relative URL
        'Dim resolvedUrl As String = New Uri(New Uri(baseUrl), relativeUrl).AbsoluteUri

        '' Return the resolved URL as JSON
        'Return resolvedUrl

        Dim curURL As Uri = HttpContext.Current.Request.Url
        Dim scheme As String = curURL.Scheme
        Dim host As String = curURL.Host
        Dim port As Integer = curURL.Port
        Dim segments As String() = curURL.Segments

        If port <> 80 Then
            host = host + ":" + port.ToString()
        End If

        Return scheme + "://" + host + "/" + segments(1) + relativeUrl.Trim("~")

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecordDaftar(idDaftar As String) As String
        Dim resp As New ResponseRepository
        Dim JumRecord = 0

        If DelRecordLampiranSijil(idDaftar) <> "OK" Then
            resp.Failed("Gagal Dipadam Maklumat Lampiran")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'JumRecord += 1

        If DelRecordSijil(idDaftar) <> "OK" Then
            resp.Failed("Maklumat Sijil Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        'JumRecord += 1

        'If JumRecord > 0 Then
        '    resp.Failed("Maklimat Sijil Berjaya dipadam")
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        'End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DelRecordSijil(idDaftar As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Daftar SET Status = 0 WHERE ID_Daftar = @idDaftar"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idDaftar", idDaftar))

        Return db.Process(query, param)
    End Function

    Private Function DelRecordLampiranSijil(idDaftar As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Lampiran SET Status = 0 WHERE No_Rujukan = @idDaftar"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idDaftar", idDaftar))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecordPicMof(IdRujukan As String, IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim JumRecord = 0

        If DelRecordPicMof(IdRujukan, IdSya) <> "OK" Then
            resp.Failed("Gagal Dipadam Maklumat Lampiran")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DelRecordPicMof(IdRujukan As String, IdSya As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Rujukan SET Status = 0 WHERE ID_Rujukan = @IdRujukan AND ID_Sykt = @IdSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdRujukan", IdRujukan))
        param.Add(New SqlParameter("@idSya", IdSya))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecordPicCidb(IdRujukan As String, IdSya As String) As String
        Dim resp As New ResponseRepository
        Dim JumRecord = 0

        If DelRecordPicCidb(IdRujukan, IdSya) <> "OK" Then
            resp.Failed("Gagal Dipadam Maklumat Lampiran")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DelRecordPicCidb(IdRujukan As String, IdSya As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Rujukan SET Status = 0 WHERE ID_Rujukan = @IdRujukan AND ID_Sykt = @IdSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdRujukan", IdRujukan))
        param.Add(New SqlParameter("@idSya", IdSya))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecordBidang(NoDaftar As String, KodBidang As String) As String
        Dim resp As New ResponseRepository

        If DeleteKodBidang(NoDaftar, KodBidang) <> "OK" Then
            resp.Failed("Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Berjaya Dipadam")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DeleteKodBidang(nodaftar As String, kodBidang As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Daftar_Bidang SET Status = 0 WHERE No_Daftar = @noDaftar AND Kod_Bidang = @kodBidang"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", nodaftar))
        param.Add(New SqlParameter("@kodBidang", kodBidang))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecordKhusus(noDaftar As String, kodKhusus As String) As String
        Dim resp As New ResponseRepository

        If DeleteKodKhusus(noDaftar, kodKhusus) <> "OK" Then
            resp.Failed("Gagal Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Berjaya Dipadam")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DeleteKodKhusus(nodaftar As String, kodKhusus As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Daftar_CIDB SET Status = 0 WHERE ID_Daftar = @noDaftar AND Kod_Khusus = @kodKhusus"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", nodaftar))
        param.Add(New SqlParameter("@kodKhusus", kodKhusus))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecordPeg(ByVal id As String, NoSya As String) As String
        Dim resp As New ResponseRepository
        If DeleteDetailPeg(id, NoSya) = "OK" Then
            resp.Success("Berjaya")
        Else
            resp.Failed("Gagal")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecordCawangan(idCaw As String, NoSya As String) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer

        If idCaw <> "" Then

            If DeleteCawangan(idCaw, NoSya) = "OK" Then

                If DeleteDetailPeg(idCaw, NoSya) <> "OK" Then 'Prob it return x tp jalan

                    If DeletelampiranByNoRujukan(idCaw) <> "OK" Then
                        resp.Failed("Gagal Memadam Data Ini")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If

                Else

                    resp.Failed("Gagal Memadam Data Pegawai Cawangan Ini")
                    Return JsonConvert.SerializeObject(resp.GetResult())

                End If
            Else

                resp.Failed("Gagal Memadam Data Cawangan Ini")
                Return JsonConvert.SerializeObject(resp.GetResult())

            End If

            success += 1

        Else

            resp.Failed("Tiada ID Cawangan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        If success = 0 Then
            resp.Failed("Maklumat Cawangan gagal Padam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Makluamt Cawangan Berjaya Dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DeletelampiranByNoRujukan(noRujukan As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Lampiran SET Status = @StatusBaru WHERE No_Rujukan = @NoRujukan AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoRujukan", noRujukan))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@StatusBaru", "0"))

        Return db.Process(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecordPengalaman(IdPengalaman As String, IdSya As String) As String
        Dim resp As New ResponseRepository
        If DeletePengalaman(IdPengalaman, IdSya) = "OK" Then
            resp.Success("Berjaya")
        Else
            resp.Failed("Gagal")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataPengalaman(IdSya As String, idPengalaman As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetDataPengalaman(IdSya, idPengalaman)
        'resp.SuccessPayload(dt)

        'Return JsonConvert.SerializeObject(resp.GetResult())

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetDataPengalaman(idSya As String, idPengalaman As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Bil as IdPengalaman, ID_Sykt as IdSemSya , Tajuk_Projek as TajukProjek, Jabatan as NamaSyarikat, CASE WHEN Tkh_Mula <> '' THEN FORMAT(Tkh_Mula, 'yyyy-MM-dd') END AS  TarikhMula,
                                CASE WHEN Tkh_Tamat <> '' THEN FORMAT(Tkh_Tamat, 'yyyy-MM-dd') END AS TarikhTamat, Nilai_Jualan as NilaiJualan FROM SMKB_Syarikat_Pengalaman WHERE ID_Sykt = @idSya AND Bil = @idPengalaman AND Status = @status"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idPengalaman", idPengalaman))
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataCawangan(NoSya As String, idCaw As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetDataCawangan(NoSya, idCaw)
        'resp.SuccessPayload(dt)

        'Return JsonConvert.SerializeObject(resp.GetResult())

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetDataCawangan(NoSya As String, idCaw As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT DISTINCT A.ID_Sykt As idSya, A.ID_Cwgn AS IdCaw,
							  A.Nama_Cwgn as NamaCaw,
							  (SELECT (kod_Detail + ' - ' + Butiran ) FROM SMKB_Lookup_Detail lp WHERE A.Kod_Bank = lp.Kod_Detail AND lp.Kod = '0097') as ButiranBank,
							  A.Almt_1 as Almt1, 
							  A.Almt_2 as Almt2,
							  A.Bandar as KodBandar,
                              (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Bandar = lp.Kod_Detail AND lp.Kod = '0003') as ButiranBandar,
                              A.Poskod as Poskod, A.Kod_Negeri as Negeri , A.Kod_Negara as Negara , 
                              (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Kod_Negeri = lp.Kod_Detail AND lp.Kod = '0002') as ButiranNegeri,
                              (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Kod_Negara = lp.Kod_Detail AND lp.Kod = '0001') as ButiranNegara, 
                              A.Tel_Pejabat As Tel1, A.Tel_Bimbit as Tel2, A.Faks As Faks, A.Web as Web,B.ID_Rujukan as IdPeg,
							  A.Kod_bank As KodBank,
							  A.No_Akaun As NoAkaun,
                              B.Nama As NamaPeg, B.Jawatan as JwtPeg, B.Tel_Pejabat As TelPejPeg, B.Tel_Bimbit as TelBimbit,
                              B.Emel as EmelPeg,
							  D.Nama_Dok as NamaDok,
							  D.Path,
							  D.Bil
                              FROM SMKB_Syarikat_Cawangan A 
                              INNER JOIN SMKB_Syarikat_Rujukan B ON A.ID_Cwgn = B.ID_Cwgn 
                              INNER JOiN SMKB_Lookup_Detail C ON A.Kod_Negara = C.Kod_Detail
							  INNER JOIn SMKB_Syarikat_Lampiran D ON A.ID_Cwgn = D.No_Rujukan
                              WHERE A.ID_Cwgn = @idCaw AND A.ID_Sykt = @NoSya AND A.Status = @status AND B.Status = @status AND D.Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idCaw", idCaw))
        param.Add(New SqlParameter("@NoSya", NoSya))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_SenaraiPengalaman(idSemSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiPengalaman(idSemSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiPengalaman(idSemSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Bil as IdPengalaman, ID_Sykt as IdSemSya , Tajuk_Projek as TajukProjek, Jabatan as NamaSyarikat, FORMAT(Tkh_Mula, 'dd/MM/yyyy') as TarikhMula, Nilai_Jualan as NilaiJualan FROM SMKB_Syarikat_Pengalaman WHERE ID_Sykt = @idSemSya AND Status = @status"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idSemSya", idSemSya))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_SenaraiCawangan(idSemSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiCawangan(idSemSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiCawangan(idSemSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT DISTINCT A.ID_Sykt As idSya, 
							   A.ID_Cwgn,
							   A.Nama_Cwgn As NamaCaw, 
							   A.Kod_Negeri, A.Kod_Negara,
							   A.Kod_Bank,
							   (SELECT (kod_Detail + ' - ' + Butiran ) FROM SMKB_Lookup_Detail lp WHERE A.Kod_Bank = lp.Kod_Detail AND lp.Kod = '0097') as ButiranBank,
							   A.No_Akaun,
							   B.Kod_Detail,
                               (SELECT Butiran From SMKB_Lookup_Detail lp WHERE A.Kod_Negeri = lp.Kod_Detail AND lp.Kod = '0002') AS ButiranNegeri,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Kod_Negara = lp.Kod_Detail AND lp.Kod = '0001') AS ButiranNegara,
                               C.Nama as NamaPeg1,
							   C.Tel_Bimbit as TelPeg1,
							   D.Nama_Dok,
							   D.Bil,
							   D.Path
                               FROM SMKB_Syarikat_Cawangan A
                               INNER JOIN SMKB_Lookup_Detail B ON A.Kod_Negara = B.Kod_Detail
                               INNER JOIN SMKB_Syarikat_Rujukan C ON  A.ID_Cwgn = C.ID_Cwgn
							   INNER JOIN SMKB_Syarikat_lampiran D ON A.ID_Cwgn = D.No_Rujukan
                               WHERE A.ID_Sykt = @idSemSya AND C.Kod_Kategori = @KatPeg AND A.Status = @status
                               ORDER BY ID_Cwgn"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idSemSya", idSemSya))
        param.Add(New SqlParameter("@KatPeg", "P1"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_MklmtSSM(idSya As String, kodDaftar As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiSSM(idSya, kodDaftar)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiSSM(idsya As String, kodDaftar As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT B.ID_Dok, B.Bil, FORMAT(CONVERT(DATETIME2, A.ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff') AS ID_Daftar, A.Kod_Daftar, A.No_Daftar, FORMAT(A.Tkh_Mula, 'dd/MM/yyyy') AS TkhMula, FORMAT(A.Tkh_Tamat, 'dd/MM/yyyy') As TkhTamat, B.Nama_Dok As Lampiran
                               FROM SMKB_Syarikat_Daftar A 
                               INNER JOIN SMKB_Syarikat_Lampiran B ON CONVERT(VARCHAR, B.No_Rujukan, 120) =  FORMAT(CONVERT(DATETIME2, ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff')
                               WHERE A.ID_Sykt = @idSya AND A.Kod_Daftar = @kodDaftar AND A.Status = @status AND B.Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idsya))
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_MklmtMOF(idSya As String, kodDaftar As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiMOF(idSya, kodDaftar)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiMOF(idsya As String, kodDaftar As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT B.ID_Dok, B.Bil, FORMAT(CONVERT(DATETIME2, A.ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff') AS ID_Daftar, A.Kod_Daftar, A.No_Daftar, FORMAT(A.Tkh_Mula, 'dd/MM/yyyy') AS TkhMula, FORMAT(A.Tkh_Tamat, 'dd/MM/yyyy') As TkhTamat, B.Nama_Dok As Lampiran
                               FROM SMKB_Syarikat_Daftar A 
                               INNER JOIN SMKB_Syarikat_Lampiran B ON CONVERT(VARCHAR, B.No_Rujukan, 120) =  FORMAT(CONVERT(DATETIME2, ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff')
                               WHERE A.ID_Sykt = @idSya AND A.Kod_Daftar = @kodDaftar AND A.Status = @status AND B.Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idsya))
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_SenaraiBidang(kodSubBdg As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiBidang(kodSubBdg)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiBidang(kodSubBdg As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT KodBidang, Butiran, kodSubBidang FROM SMKB_Syarikat_Bidang WHERE KodSubBidang = @kodSubBdg"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kodSubBdg", kodSubBdg))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_Bidang(idSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_Bidang(idSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_Bidang(idSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = " SELECT A.No_Daftar, A.Bil, A.Kod_Bidang, C.Butiran
                                FROM SMKB_Syarikat_Daftar_Bidang A
                                INNER JOIN SMKB_Syarikat_Daftar B ON B.No_Daftar = A.No_Daftar
                                INNER JOIN SMKB_Syarikat_Bidang C ON C.KodBidang = A.Kod_Bidang
                                WHERE B.ID_Sykt = @idSya AND A.Status = @status AND B.Status = @status
                                ORDER BY A.No_Daftar"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@status", 1))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_PicMof(noDaftar As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        If String.IsNullOrEmpty(noDaftar) Then
            resp.Failed("Tiada Maklumat")
            ' Return nothing (null) when noDaftar is empty
            Return Nothing
        Else
            dt = GetList_SenaraiPicMof(noDaftar)
        End If

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_SenaraiPicMof(noDaftar As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT ID_Rujukan, Kod_Gelaran, Nama, No_Kad_Pengenalan, Jawatan, Tel_Bimbit FROM SMKB_Syarikat_Rujukan Where ID_Rujukan = @noDaftar AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", noDaftar))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_MklmtBumi(idSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiMklmtBumi(idSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_SenaraiMklmtBumi(idSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT B.Bil, FORMAT(CONVERT(DATETIME2, A.ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff') AS ID_Daftar, A.Kod_Daftar, A.No_Daftar, FORMAT(A.Tkh_Mula, 'dd/MM/yyyy') As Tkh_Mula, FORMAT(A.Tkh_Tamat, 'dd/MM/yyyy') AS Tkh_Tamat, A.Status, B.Nama_Dok
                              FROM SMKB_Syarikat_Daftar A,SMKB_Syarikat_Lampiran B
                              WHERE CONVERT(VARCHAR, B.No_Rujukan, 120) =  FORMAT(CONVERT(DATETIME2, A.ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff')
                              AND A.ID_Sykt = @idSya AND A.Status = @status AND Kod_Daftar IN ('BUMI', 'BUKAN BUMI')"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_MklmtCIDB(idSya As String, kodDaftar As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiCIDB(idSya, kodDaftar)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiCIDB(idsya As String, kodDaftar As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT B.ID_Dok, B.Bil, FORMAT(CONVERT(DATETIME2, A.ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff') AS ID_Daftar, A.Kod_Daftar, A.No_Daftar, FORMAT(A.Tkh_Mula, 'dd/MM/yyyy') AS TkhMula, FORMAT(A.Tkh_Tamat, 'dd/MM/yyyy') As TkhTamat, B.Nama_Dok As Lampiran
                               FROM SMKB_Syarikat_Daftar A 
                               INNER JOIN SMKB_Syarikat_Lampiran B ON CONVERT(VARCHAR, B.No_Rujukan, 120) =  FORMAT(CONVERT(DATETIME2, ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff')
                               WHERE A.ID_Sykt = @idSya AND A.Kod_Daftar = @kodDaftar AND A.Status = @status AND B.Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idsya))
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_PicCidb(noDaftar As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        If String.IsNullOrEmpty(noDaftar) Then
            resp.Failed("Tiada Maklumat")
            ' Return nothing (null) when noDaftar is empty
            Return Nothing
        Else
            dt = GetList_SenaraiPicCidb(noDaftar)
        End If

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_SenaraiPicCidb(noDaftar As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT ID_Rujukan, Kod_Gelaran, Nama, No_Kad_Pengenalan, Jawatan, Tel_Bimbit FROM SMKB_Syarikat_Rujukan Where ID_Rujukan = @noDaftar AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", noDaftar))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_MklmtSijilLain(idSya As String, kodDaftar As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiSijilLain(idSya, kodDaftar)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiSijilLain(idSya As String, kodDaftar As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT B.ID_Dok, B.Bil, FORMAT(CONVERT(DATETIME2, A.ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff') AS ID_Daftar, A.Kod_Daftar, A.No_Daftar, FORMAT(A.Tkh_Mula, 'dd/MM/yyyy') AS TkhMula, FORMAT(A.Tkh_Tamat, 'dd/MM/yyyy') As TkhTamat, B.Nama_Dok As Lampiran
                               FROM SMKB_Syarikat_Daftar A 
                               INNER JOIN SMKB_Syarikat_Lampiran B ON CONVERT(VARCHAR, B.No_Rujukan, 120) =  FORMAT(CONVERT(DATETIME2, ID_Daftar), 'yyyy-MM-dd HH:mm:ss.fffffff')
                               WHERE A.ID_Sykt = @idSya AND A.Kod_Daftar IN ('BP','KSM','PKK', 'SPAN') AND A.Status = @status AND B.Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        'param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_Khusus(kodKat As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiKhusus(kodKat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiKhusus(kodKat As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT KodKhusus, Butiran, KodKategori FROM SMKB_Syarikat_CIDB_Pengkhususan WHERE KodKategori = @KodKat"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kodKat", kodKat))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetLogoUtem() As Byte()
        Dim db = New DBKewConn
        Dim query As String = "SELECT Logo FROM SMKB_Korporat WHERE No_GST = '001910734848'"
        Using connection As New SqlConnection(db.ConnectionString)
            Using command As New SqlCommand(query, connection)
                connection.Open()
                Dim imageBytes As Byte() = DirectCast(command.ExecuteScalar(), Byte())
                Return imageBytes
            End Using
        End Using
    End Function

    Private Function GetKodBandar(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE kod = '0003'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodBank(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT kod_Detail as value, (kod_Detail + ' - ' + Butiran ) as text FROM SMKB_Lookup_Detail WHERE kod = '0097'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND ( kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%')"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodNegeri(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE kod='0002'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodNegara(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE kod = '0001'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodPoskod(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail as text FROM SMKB_Lookup_Detail WHERE Kod='0079'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Kod_Detail LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If
        query &= " ORDER BY Kod_Detail ASC"
        Return db.Read(query, param)
    End Function

    Private Function GetKodBidang(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod as value, (Kod + ' - ' + Butiran) as text FROM SMKB_Syarikat_Bidang_Utama"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " WHERE Kod LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%'"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodSubBidang(kod As String, kod2 As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod as value, (Kod + ' - ' + Butiran ) as text FROM SMKB_Syarikat_Sub_Bidang WHERE Kod_Bdg_Utama = @kod2 "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod2", kod2))

        If kod <> "" Then
            query &= "AND Kod LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If
        query &= "ORDER BY Kod ASC"
        Return db.Read(query, param)
    End Function

    Private Function GetKodKategori(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, (Kod_Detail + '-' + Butiran) as text FROM SMKB_Lookup_Detail WHERE Kod = 'VDR05'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "WHERE Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%' "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If
        Return db.Read(query, param)
    End Function

    Private Function GetKodGredKerja(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Gred as value, Butiran as text FROM SMKB_Syarikat_CIDB_Gred "

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "WHERE Kod_Gred LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%' "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If
        query &= " ORDER BY Kod_Gred ASC"
        Return db.Read(query, param)
    End Function

    Private Function GetKodDaftar(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value ,(Kod_Detail + ' - ' + Butiran) as text FROM SMKB_Lookup_Detail WHERE Kod = 'VDR03' AND Kod_detail IN ('BP','KSM','PKK', 'SPAN') "

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND KodDaftar LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%' "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetDataSyarikat(idSya As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.ID_Sykt as IdSya, A.Kod_Bank as kodBank, A.Kod_Kategori_Sykt as KatSya, A.No_Akaun as NoAkaun, A.Almt_Semasa_1 as Almt1,
	                           A.Almt_Semasa_2 as Almt2, A.Bandar_Semasa as KodBandar, A.Poskod_Semasa as Poskod, A.Kod_Negeri_Semasa as KodNegeri, A.Kod_Negara_Semasa as KodNegara,
	                           A.Tel_Pej_Semasa as TelPejSya, A.Tel_Bimbit_Semasa as TelBimbit, A.Faks_Semasa as NoFaxSya, A.Web_Semasa as Web,A.Emel_Semasa as EmailSya,
	                           A.Bekalan as Bekalan, A.Perkhidmatan as Perkhidmatan, A.Kerja as Kerja, B.Kod_Detail, 
	                           (SELECT (kod_Detail + ' - ' + Butiran ) FROM SMKB_Lookup_Detail lp WHERE a.Kod_Bank = lp.Kod_Detail AND lp.Kod = '0097') as ButiranBank,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE a.Bandar_Semasa = lp.Kod_Detail AND lp.Kod = '0003') as ButiranBandar,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE a.Kod_Negeri_Semasa = lp.Kod_Detail AND lp.Kod = '0002') as ButiranNegeri,
                               (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE a.Kod_Negara_Semasa = lp.Kod_Detail AND lp.Kod = '0001') as ButiranNegara,
	                           C.ID_Rujukan as IdPeg, C.ID_Sykt, C.Nama as NamaPegawai1, C.Jawatan as JwtPegawai1, C.Tel_Pejabat as TelPejPeg1, C.Tel_Bimbit as TelPeg1, C.Emel as EmailPeg1
	                           FROM SMKB_Syarikat_Master A 
	                           INNER JOIN SMKB_Lookup_Detail B ON A.Kod_Negara_Semasa = B.Kod_Detail 
                               INNER JOIN SMKB_Syarikat_Rujukan C ON A.No_Sykt = C.ID_Sykt
	                           WHERE A.No_Sykt = @idSya AND A.Status = @status AND C.Status = @status AND C.ID_Rujukan = @idRujukan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@idRujukan", " "))

        Return db.Read(query, param)
    End Function

    Private Function GenerateIdRujukan() As String
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim query As String = "SELECT TOP 1 ID_Rujukan FROM SMKB_Syarikat_Rujukan ORDER BY ID_Rujukan DESC"
        Dim idPeg As Integer = 1

        dt = db.Read(query)

        If dt.Rows.Count > 0 Then
            idPeg = CInt(dt.Rows(0).Item("ID_Rujukan")) + 1
        End If

        Return idPeg
    End Function

    Private Function GenerateIdRujukan2(idPeg) As String
        Dim idPeg1 As String = idPeg
        Dim idPeg2 As String = idPeg1 + 2
        Return idPeg2
    End Function

    Private Function GenerateIdCwgn() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newSyarikatID As String = ""

        Dim query As String = "SELECT TOP 1 No_Akhir as id FROM SMKB_No_Akhir WHERE Kod_Modul ='20' AND Prefix ='BR' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("20", "BR", year, lastID)
        Else

            InsertNoAkhir("20", "BR", year, lastID)
        End If
        newSyarikatID = "BR" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newSyarikatID
    End Function

    Private Function GenerateSyarikatID() As String
        Dim db As New DBKewConn

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
        'newSyarikatID = "RC" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)
        newSyarikatID = "RC" + Format(lastID, "000000").ToString

        Return newSyarikatID
    End Function

    Private Function GenerateCawanganID() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String = ""

        Dim query As String = "SELECT TOP 1 No_Akhir as id FROM SMKB_No_Akhir WHERE Kod_Modul ='20' AND Prefix ='BR' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("20", "BR", year, lastID)
        Else

            InsertNoAkhir("20", "BR", year, lastID)
        End If
        newOrderID = "BR" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newOrderID
    End Function

    Private Function InsertMklmtSya(idSya As String, noSya As String, kodBank As String, KatSya As String, noAkaun As String, almtp1 As String, almtp2 As String, bandar As String, poskod As String, negeri As String, negara As String,
                                    telPej As String, telBimbit As String, noFaxSya As String, webSya As String, emailSya As String, bekalan As String, perkhidmatan As String, kerja As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_Master (ID_Sykt, No_Sykt, Kod_Bank,Kod_Kategori_Sykt, No_Akaun, Almt_Semasa_1, Almt_Semasa_2, Bandar_Semasa, Poskod_Semasa, Kod_Negeri_Semasa,
         Kod_Negara_Semasa, Tel_Pej_Semasa, Tel_Bimbit_Semasa, Faks_Semasa, Web_Semasa, Emel_Semasa, Bekalan, Perkhidmatan, kerja, Status, Status_Aktif, Tkh_Daftar, Flag_Daftar)
         VALUES (@idSya, @noSya, @kodBank, @katSya, @noAkaun,@almt1,@almt2,@bandar,@poskod,@negeri,@negara,@telPej,@telBimbit,
         @noFax,@Web,@emailSya,@bekalan,@perkhidmatan,@kerja, @status, @statAktif, @tkhDaftar, @flagDaftar) "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@noSya", noSya))
        param.Add(New SqlParameter("@kodBank", kodBank))
        param.Add(New SqlParameter("@katSya", KatSya))
        param.Add(New SqlParameter("@noAkaun", noAkaun))
        param.Add(New SqlParameter("@almt1", almtp1))
        param.Add(New SqlParameter("@almt2", almtp2))
        param.Add(New SqlParameter("@bandar", bandar))
        param.Add(New SqlParameter("@poskod", poskod))
        param.Add(New SqlParameter("@negeri", negeri))
        param.Add(New SqlParameter("@negara", negara))
        param.Add(New SqlParameter("@telPej", telPej))
        param.Add(New SqlParameter("@telBimbit", telBimbit))
        param.Add(New SqlParameter("@noFax", noFaxSya))
        param.Add(New SqlParameter("@Web", webSya))
        param.Add(New SqlParameter("@emailSya", emailSya))
        param.Add(New SqlParameter("@bekalan", bekalan))
        param.Add(New SqlParameter("@perkhidmatan", perkhidmatan))
        param.Add(New SqlParameter("@kerja", kerja))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@statAktif", "00"))
        param.Add(New SqlParameter("@tkhDaftar", "getDate()"))
        param.Add(New SqlParameter("@flagDaftar", "1"))

        Return db.Process(query, param)
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

        Return db.Process(query, param)
    End Function

    Private Function UpdateMklmtSya(idSya As String, noSya As String, kodBank As String, KatSya As String, noAkaun As String, almtp1 As String, almtp2 As String, bandar As String, poskod As String, negeri As String, negara As String,
                                    telPej As String, telBimbit As String, noFaxSya As String, webSya As String, emailSya As String, bekalan As String, perkhidmatan As String, kerja As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Master SET Kod_Bank = @kodBank, Kod_Kategori_Sykt = @katSya, No_Akaun = @noAkaun ,Almt_Semasa_1 = @almt1, Almt_Semasa_2 = @almt2,
        Bandar_Semasa = @bandar, Poskod_Semasa = @poskod,Kod_Negeri_Semasa = @negeri, Kod_Negara_Semasa = @negara, Tel_Pej_Semasa = @telPej, Tel_Bimbit_Semasa = @telBimbit,Faks_Semasa = @noFax,
        Web_Semasa = @Web, Emel_Semasa = @emailSya, bekalan = @bekalan, Perkhidmatan = @perkhidmatan, kerja = @kerja, Status = 1 WHERE ID_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kodBank", kodBank))
        param.Add(New SqlParameter("@katSya", KatSya))
        param.Add(New SqlParameter("@noAkaun", noAkaun))
        param.Add(New SqlParameter("@almt1", almtp1))
        param.Add(New SqlParameter("@almt2", almtp2))
        param.Add(New SqlParameter("@bandar", bandar))
        param.Add(New SqlParameter("@poskod", poskod))
        param.Add(New SqlParameter("@negeri", negeri))
        param.Add(New SqlParameter("@negara", negara))
        param.Add(New SqlParameter("@telPej", telPej))
        param.Add(New SqlParameter("@telBimbit", telBimbit))
        param.Add(New SqlParameter("@noFax", noFaxSya))
        param.Add(New SqlParameter("@Web", webSya))
        param.Add(New SqlParameter("@emailSya", emailSya))
        param.Add(New SqlParameter("@bekalan", bekalan))
        param.Add(New SqlParameter("@perkhidmatan", perkhidmatan))
        param.Add(New SqlParameter("@kerja", kerja))
        param.Add(New SqlParameter("@idSya", idSya))

        Return db.Process(query, param)
    End Function

    Private Function UpdateMklmtPeg(idPeg As String, idSya As String, idCaw As String, katPegawai As String, namaPeg As String, noIcPeg As String, gelpeg As String, jwtPeg As String, noTelPejPeg As String, noTelPeg As String, emailPeg As String)

        Dim db = New DBKewConn
        Dim query As String = "Update SMKB_Syarikat_Rujukan 
                               Set Nama = @namaPeg , Jawatan = @jwtPeg , Tel_Pejabat = @noTelPejPeg, Tel_Bimbit = @noTelPeg, Emel = @emailPeg
                               WHERE ID_Rujukan = @idPeg"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@namaPeg", namaPeg))
        param.Add(New SqlParameter("@jwtPeg", jwtPeg))
        param.Add(New SqlParameter("@emailPeg", emailPeg))
        param.Add(New SqlParameter("@noTelPeg", noTelPeg))
        param.Add(New SqlParameter("@noTelPejPeg", noTelPejPeg))
        param.Add(New SqlParameter("@idPeg", idPeg))

        Return db.Process(query, param)

    End Function

    Private Function InsertMklmtPeg(idPeg As String, idSya As String, idCaw As String, katPegawai As String, namaPeg As String, noIcPeg As String, gelpeg As String, jwtPeg As String, noTelPejPeg As String, noTelPeg As String, emailPeg As String)
        Dim db = New DBKewConn
        Dim query As String = "INSERT INTO Smkb_Syarikat_Rujukan(ID_Rujukan,ID_Sykt ,ID_Cwgn, Kod_Kategori, Nama, No_Kad_Pengenalan, Kod_Gelaran,Jawatan,Tel_Pejabat,Tel_Bimbit,Status,Emel) 
                               VALUES(@idPeg,@idsya,@idCaw,@katPegawai, @namaPeg, @noIcPeg, @gelaran, @jwtPeg, @noTelPejPeg, @noTelPeg, @status, @emailPeg)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPeg", idPeg))
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@idCaw", idCaw))
        param.Add(New SqlParameter("@katPegawai", katPegawai))
        param.Add(New SqlParameter("@namaPeg", namaPeg))
        param.Add(New SqlParameter("@noIcPeg", noIcPeg))
        param.Add(New SqlParameter("@gelaran", gelpeg))
        param.Add(New SqlParameter("@jwtPeg", jwtPeg))
        param.Add(New SqlParameter("@noTelPejPeg", noTelPejPeg))
        param.Add(New SqlParameter("@noTelPeg", noTelPeg))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@emailPeg", emailPeg))

        Return db.Process(query, param)
    End Function

    Private Function InsertPengalaman(idSemSya As String, Bil As String, Tajuk As String, NamaSyarikat As String, TkhMula As String, TkhTamat As String, NilaiProjek As Decimal, OrderID As String)
        Dim db = New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_Pengalaman (ID_Sykt,Bil,Tajuk_Projek,Jabatan,Tkh_Mula,Tkh_Tamat, Nilai_Jualan, Order_ID, Status) VALUES (@idSemSya, @Bil,@tajuk,@namaSya,@tkhMula,@tkhTamat,@nilaiProjek,@orderID,@status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSemSya", idSemSya))
        param.Add(New SqlParameter("@Bil", Bil))
        param.Add(New SqlParameter("@tajuk", Tajuk))
        param.Add(New SqlParameter("@namaSya", NamaSyarikat))
        param.Add(New SqlParameter("@tkhMula", TkhMula))
        param.Add(New SqlParameter("@tkhTamat", TkhTamat))
        param.Add(New SqlParameter("@nilaiProjek", NilaiProjek))
        param.Add(New SqlParameter("@orderID", OrderID))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdatePengalaman(IdPengalaman As String, idSemSya As String, Tajuk As String, NamaSyarikat As String, TkhMula As String, TkhTamat As String, NilaiProjek As String, OrderID As String) As String
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Pengalaman SET Tajuk_Projek = @tajuk, Jabatan = @namaSya ,Tkh_Mula = @tkhMula ,Tkh_Tamat = @tkhTamat, Nilai_Jualan = @nilaiProjek, Order_ID = @orderID WHERE Bil = @idPengalaman AND ID_Sykt = @idSemSya AND Status = @status "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPengalaman", IdPengalaman))
        param.Add(New SqlParameter("@idSemSya", idSemSya))
        param.Add(New SqlParameter("@tajuk", Tajuk))
        param.Add(New SqlParameter("@namaSya", NamaSyarikat))
        param.Add(New SqlParameter("@tkhMula", TkhMula))
        param.Add(New SqlParameter("@tkhTamat", TkhTamat))
        param.Add(New SqlParameter("@nilaiProjek", NilaiProjek))
        param.Add(New SqlParameter("@orderID", OrderID))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateStatFile(IdSya As String, JenDok As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Lampiran SET Status = @statBaru WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenDok AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@jenDok", JenDok))
        param.Add(New SqlParameter("@statBaru", "0"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateStatFileBankCaw(IdSya As String, idCaw As String, JenDok As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Lampiran SET Status = @statBaru WHERE ID_Sykt = @idSya AND No_Rujukan = @idCaw AND Jenis_Dok = @jenDok AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@idCaw", idCaw))
        param.Add(New SqlParameter("@jenDok", JenDok))
        param.Add(New SqlParameter("@statBaru", "0"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Process(query, param)
    End Function

    Private Function UpdateSetuju(idSya As String, isSetuju As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Master 
                               SET Flag_Sah = @isSetuju, Tkh_Hantar = CONVERT(smallDateTime, GETDATE()), Status_Lulus = @statLulus 
                               WHERE No_Sykt = @idSya"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@isSetuju", "1"))
        param.Add(New SqlParameter("@tkhHantar", "getDate()"))
        param.Add(New SqlParameter("@statLulus", "3"))
        param.Add(New SqlParameter("@idSya", idSya))

        Return db.Process(query, param)
    End Function

    Private Function DeleteCawangan(idCaw As String, NoSya As String)
        Dim db = New DBKewConn
        'Dim query As String = "Delete FROM SMKB_Syarikat_Cawangan WHERE ID_Cwgn = @idCaw AND ID_Sykt = @NoSya "
        Dim query As String = "UPDATE SMKB_Syarikat_Cawangan SET Status = 0 WHERE ID_Cwgn = @idCaw AND ID_Sykt = @NoSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idCaw", idCaw))
        param.Add(New SqlParameter("@NoSya", NoSya))

        Return db.Process(query, param)
    End Function

    Private Function DeletePengalaman(IdPengalaman As String, IdSya As String)
        Dim db = New DBKewConn
        'Dim query As String = "Delete FROM SMKB_Syarikat_Pengalaman WHERE Bil = @idPengalaman "
        Dim query As String = "UPDATE SMKB_Syarikat_Pengalaman SET Status = 0 WHERE Bil = @idPengalaman AND ID_Sykt = @IdSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPengalaman", IdPengalaman))
        param.Add(New SqlParameter("@IdSya", IdSya))

        Return db.Process(query, param)
    End Function

    Private Function InsertCawangan(idSya As String, idCaw As String, namaCaw As String, almt1 As String, almt2 As String, bandar As String, poskod As String, negeri As String, negara As String, tel1 As String, tel2 As String, noFax As String, web As String, kodBank As String, NoAkaun As String)
        Dim db = New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_Cawangan 
                               (ID_Sykt,ID_Cwgn ,Nama_Cwgn, Almt_1,Almt_2,Bandar,Poskod,Kod_Negeri,Kod_Negara,Tel_Pejabat,Tel_Bimbit,Faks,Web,Status, Kod_bank, No_Akaun) 
                               VALUES (@idSya, @idCaw, @namaCaw, @almt1, @almt2, @bandar, @poskod, @negeri, @negara, @tel1, @tel2, @noFax,@web, @status, @kodBank, @NoAkaun)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@idCaw", idCaw))
        param.Add(New SqlParameter("@namaCaw", namaCaw))
        param.Add(New SqlParameter("@almt1", almt1))
        param.Add(New SqlParameter("@almt2", almt2))
        param.Add(New SqlParameter("@bandar", bandar))
        param.Add(New SqlParameter("@poskod", poskod))
        param.Add(New SqlParameter("@negeri", negeri))
        param.Add(New SqlParameter("@negara", negara))
        param.Add(New SqlParameter("@tel1", tel1))
        param.Add(New SqlParameter("@tel2", tel2))
        param.Add(New SqlParameter("@noFax", noFax))
        param.Add(New SqlParameter("@web", web))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@KodBank", kodBank))
        param.Add(New SqlParameter("@NoAkaun", NoAkaun))

        Return db.Process(query, param)

    End Function

    Private Function UpdateCawagan(idSya As String, idCaw As String, namaCaw As String, almt1 As String, almt2 As String, bandar As String, poskod As String, negeri As String, negara As String, telPej As String, telBimbit As String, noFax As String, web As String, kodbank As String, NoAkaun As String) As String
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Cawangan SET Nama_Cwgn = @namaCaw, Almt_1 = @almt1 ,Almt_2 = @almt2 ,Bandar = @bandar, Poskod = @poskod, Kod_Negeri = @negeri, Kod_Negara = @negara, 
                               Tel_Pejabat = @telPej,Tel_Bimbit = @telBimbit, Faks = @noFax, Web = @web, Status = @status, Kod_Bank = @kodBank, No_Akaun = @noAkaun WHERE ID_Sykt = @idSya AND ID_Cwgn = @idCaw "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@namaCaw", namaCaw))
        param.Add(New SqlParameter("@almt1", almt1))
        param.Add(New SqlParameter("@almt2", almt2))
        param.Add(New SqlParameter("@bandar", bandar))
        param.Add(New SqlParameter("@poskod", poskod))
        param.Add(New SqlParameter("@negeri", negeri))
        param.Add(New SqlParameter("@negara", negara))
        param.Add(New SqlParameter("@telPej", telPej))
        param.Add(New SqlParameter("@telBimbit", telBimbit))
        param.Add(New SqlParameter("@noFax", noFax))
        param.Add(New SqlParameter("@web", web))
        param.Add(New SqlParameter("@status", 1))
        param.Add(New SqlParameter("@kodbank", kodbank))
        param.Add(New SqlParameter("@noAkaun", NoAkaun))
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@idCaw", idCaw))


        Return db.Process(query, param)
    End Function

    Private Function DeleteDetailPeg(IdCaw As String, NoSya As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Syarikat_Rujukan SET Status = @status WHERE ID_Cwgn = @idCaw AND ID_Sykt = @NoSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idCaw", IdCaw))
        param.Add(New SqlParameter("@NoSya", NoSya))
        param.Add(New SqlParameter("@status", "0"))

        Return db.Process(query, param)
    End Function


    'Private Function DeleteDetailPeg(Optional kod As String = "", Optional idCaw As String = "")
    '    Dim db = New db
    '    Dim query As String = "DELETE FROM SMKB_Syarikat_Rujukan WHERE"
    '    Dim param As New List(Of SqlParameter)

    '    If kod <> "" Then
    '        query &= "ID_Sykt = @id"
    '        param.Add(New SqlParameter("@id", kod))
    '    Else
    '        query &= "ID_Cwgn = @idCaw"
    '        param.Add(New SqlParameter("@idCaw", idCaw))
    '    End If

    '    Return db.Process(query, param)
    'End Function

    Private Function GenerateIdPengalaman(IdSya As String)
        Dim db As New DBKewConn
        Dim Bil As Integer = 1
        Dim query As String = "SELECT MAX(CONVERT(INT, Bil)) + 1  AS LatestBil FROM SMKB_Syarikat_Pengalaman WHERE ID_Sykt = @idSya"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("LatestBil")) Then
            Bil = Convert.ToInt32(dt.Rows(0)("LatestBil"))
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

    Private Function GenerateIdBilBidang(noDaftar As String) As String
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Bil As Integer = 1

        Dim query As String = "SELECT MAX(CONVERT(INT, Bil)) + 1  AS LatestBil FROM SMKB_Syarikat_Daftar_Bidang WHERE No_Daftar = @noDaftar"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", noDaftar))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("LatestBil")) Then
            Bil = Convert.ToInt32(dt.Rows(0)("LatestBil"))
        End If

        Return Bil
    End Function

    Private Function GenerateIdBilKhusus(noDaftar As String) As String
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Bil As Integer = 1

        Dim query As String = "SELECT MAX(CONVERT(INT, Bil)) + 1 AS LatestBil FROM SMKB_Syarikat_Daftar_CIDB WHERE ID_Daftar = @noDaftar"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", noDaftar))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("LatestBil")) Then
            Bil = Convert.ToInt32(dt.Rows(0)("LatestBil"))
        End If

        Return Bil

    End Function

    Private Function IsIdPengalamanExists(idPengalaman As String) As Boolean
        ' Perform a database query to check if the IdPengalaman exists
        Dim db = New DBKewConn
        Dim dt As DataTable
        Dim query As String = " SELECT COUNT(Bil) FROM SMKB_Syarikat_Pengalaman WHERE Bil = @idPengalaman AND Status = @status"

        ' Create a parameter for the IdPengalaman value
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPengalaman", idPengalaman))
        param.Add(New SqlParameter("@status", "1"))

        dt = db.Read(query, param)

        If dt.Rows.Count = 0 Then
            Return 1
        Else
            Return 0
        End If

    End Function

    Private Function IsBidangExist(noDaftar As String, kodBidang As String)
        Dim Db = New DBKewConn
        Dim dt As DataTable
        Dim Status As String
        Dim query As String = "SELECT COUNT(Bil) AS BilBidang FROM SMKB_Syarikat_Daftar_Bidang  WHERE No_Daftar = @noDaftar AND Kod_Bidang = @kodBidang AND status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", noDaftar))
        param.Add(New SqlParameter("@kodBidang", kodBidang))
        param.Add(New SqlParameter("@status", "1"))

        dt = Db.Read(query, param)

        If dt.Rows(0)("BilBidang") > 0 Then
            Status = "X"
            Return Status
        Else
            Status = "OK"
            Return Status
        End If
    End Function
    Private Function IsKodKhususExist(noDaftar As String, kodKhusus As String)
        Dim Db = New DBKewConn
        Dim dt As DataTable
        Dim Status As String
        Dim query As String = "SELECT COUNT(Bil) As KodKhusus FROM SMKB_Syarikat_Daftar_CIDB WHERE ID_Daftar = @noDaftar AND Kod_Khusus = @kodKhusus AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noDaftar", noDaftar))
        param.Add(New SqlParameter("@kodKhusus", kodKhusus))
        param.Add(New SqlParameter("@status", "1"))

        dt = Db.Read(query, param)

        If dt.Rows(0)("KodKhusus") > 0 Then
            Status = "X"
            Return Status
        Else
            Status = "OK"
            Return Status
        End If
    End Function

    Private Function IsFileExist(idSya As String, JenDok As String)
        Dim Db = New DBKewConn
        Dim dt As DataTable
        Dim query As String = "SELECT COUNT(Jenis_Dok) FROM SMKB_Syarikat_Lampiran WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenDok"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@jenDok", JenDok))

        dt = Db.Read(query, param)

        If dt.Rows.Count > 0 Then
            Return 1
        Else
            Return 0
        End If
    End Function

    Private Function IsFileExistBankCaw(idSya As String, idCaw As String, JenDok As String)
        Dim Db = New DBKewConn
        Dim dt As DataTable
        Dim query As String = "SELECT COUNT(Jenis_Dok) FROM SMKB_Syarikat_Lampiran WHERE ID_Sykt = @idSya AND No_Rujukan = @idCaw AND Jenis_Dok = @jenDok"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@idCaw", idCaw))
        param.Add(New SqlParameter("@jenDok", JenDok))

        dt = Db.Read(query, param)

        If dt.Rows.Count > 0 Then
            Return 1
        Else
            Return 0
        End If
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

    'Private Function InsertStatusDok() As String
    '    Dim db As New DBKewConn
    '    Dim query As String = ""

    '    'Dim param As New List(Of SqlParameter)
    '    'param.Add(New SqlParameter("",))
    '    'param.Add(New SqlParameter("",))
    '    'param.Add(New SqlParameter("",))
    '    'param.Add(New SqlParameter("",))
    '    'param.Add(New SqlParameter("",))
    '    'param.Add(New SqlParameter("",))
    '    'param.Add(New SqlParameter("",))
    '    'param.Add(New SqlParameter("",))
    'End Function

End Class