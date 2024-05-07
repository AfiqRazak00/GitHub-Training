Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Net
Imports System.Net.Mail
Imports System.Data
Imports System.Data.Entity.Core
Imports System.IO
Imports System.Net.Http
Imports System.Threading

' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PengesahanPenjamin_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim queryRB As New Query

    '-------------------- REFERENCE TABLE START -----------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPengesahanPenjaminData() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadPengesahanPenjaminData()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadPengesahanPenjaminData() As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"SELECT DISTINCT
	A.Status AS Status,
	A.No_Staf AS NoStaf,
    B.No_Staf AS NoStafPeminjam,
	A.No_Pinj AS NoPinjaman2,
	A.Setuju AS Setuju,
	A.Tarikh_Setuju AS TarikhSetuju,
	A.Bil AS Bilangan,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM15') AND Kod_Detail = A.Kategori_Pinj) As  KategoriPinjaman,
	LOWER((SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM15') AND Kod_Detail = A.Kategori_Pinj)) AS KategoriPinjaman2,
	B.No_Staf AS NoStafPenjamin,
	B.No_Pinj AS NoPinjaman,
	B.Jenis_Pinj AS JenisPinjaman,
	CONVERT(varchar, B.Tkh_Mohon, 103) AS TarikhMohon,
	C.Nama AS NamaPeminjam,
	C.Email AS EmailPeminjam,
	D.Butiran AS Butiran,
	C.JGiliran AS Jawatan,
	C.NPejabat AS Jabatan,
	I.No_Enjin AS NoEnjin,
	I.No_Casis AS NoCasis,
	FORMAT(I.Harga_Bersih, '#,0') AS HargaKenderaan,
	I.Sukat_Silinder AS SukatanSilinder,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM05') AND Kod_Detail = I.Kod_Buatan) As  BuatanKenderaan,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM19') AND Kod_Detail = I.Kod_Model) As  ModelKenderaan,
	FORMAT(J.Harga, '#,0') AS HargaKomputer,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM09') AND Kod_Detail = J.Jenama) AS Jenama,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM08') AND Kod_Detail = J.Ingatan) AS Ingatan,
	J.Pemacu_Cakera AS PemacuCakera,
	J.Modem AS Modem,
	J.Kad_Bunyi AS KadBunyi,
	J.Tetikus AS Tetikus,
	J.No_Siri_Komputer AS NoSiriKomputer,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM20') AND Kod_Detail = J.Monitor) AS Monitor,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM21') AND Kod_Detail = J.Nama_Pencetak) AS NamaPencetak,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM27') AND Kod_Detail = J.Papan_Kekunci) AS PapanKekunci,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM07') AND Kod_Detail = J.Cakera_Keras) AS CakeraKeras,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM08') AND Kod_Detail = J.Jenis_Pinj_Komputer) AS JenisPinjamanKomputer,
	FORMAT(K.Harga, '#,0') AS HargaSukan,
    FORMAT(B.Amaun_Mohon, '#,0') AS HargaMohon,
	(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM13') AND Kod_Detail = K.Jenis_Sukan) AS JenisSukan
	FROM
    SMKB_Pinjaman_Penjamin A
INNER JOIN
    SMKB_Pinjaman_Hdr B ON A.No_Pinj = B.No_Pinj
FULL OUTER JOIN
    SMKB_Pinjaman_Dtl_Kenderaan I ON A.No_Pinj = I.No_Pinj
FULL OUTER JOIN
    SMKB_Pinjaman_Dtl_Komputer J ON A.No_Pinj = J.No_Pinj
FULL OUTER JOIN
    SMKB_Pinjaman_Dtl_Sukan K ON A.No_Pinj = K.No_Pinj
INNER JOIN
   VPeribadi12 C ON B.No_Staf = C.NoStaf
INNER JOIN
SMKB_Lookup_Detail D ON D.Kod_Detail = B.Jenis_Pinj 
WHERE A.No_Staf = '{Session("ssusrID")}' AND A.Setuju IS NULL AND D.Kod = 'PJM01' AND A.Status = '1' AND B.Status = 'A'
ORDER BY NoPinjaman desc"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("No_Staf", Session("ssusrID")))

        Return db.Read(query)
        'WHERE A.No_Staf = '{Session("ssusrID")}' AND A.Setuju IS NULL AND D.Kod = 'PJM01' AND A.Status = '1' AND B.Status = 'A'
    End Function
    '-------------------- REFERENCE TABLE END -------------------------
    '-------------------- REFERENCE btnSimpan START   -----------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan(mohonPengesahan As pengesahanInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPengesahan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query

        If InsertPengesahan(mohonPengesahan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(mohonPengesahan.NoStafPeminjam) Then
            resp.Failed("Gagal menghantar notifikasi")
        Else
            notificationMyUtem(mohonPengesahan.NoStafPeminjam)
        End If

        Dim ID_Token As String = Session("ID_Token")
        If String.IsNullOrEmpty(ID_Token) Then

        Else
            If UpdateEmelAuth(ID_Token) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal Kemaskini ID Token")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If


        queryRB.finish()
        resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
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
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveAndUploadFileUlasan() As String
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim nostafValue As String = HttpContext.Current.Request.Form("nostafPengesahan")
        Dim noPinjamanValue As String = HttpContext.Current.Request.Form("nopinjPengesahan")
        Dim butiranValue As String = HttpContext.Current.Request.Form("butiranPengesahan")
        Dim bilanganValue As String = HttpContext.Current.Request.Form("bilanganPengesahan")
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileSize As Long = postedFile.ContentLength
        Dim fileExtension As String = Path.GetExtension(fileName).ToLower()

        Try

            ' Specify the file path where you want to save the uploaded file
            Dim folderPath As String = Server.MapPath("~/Upload/Document/PINJAMAN/")
            Dim saveFileName As String = $"{noPinjamanValue}_{nostafValue}_{bilanganValue}{fileExtension}"
            Dim savePath As String = Path.Combine(folderPath, saveFileName)

            ' Check if the folder for No_Mohon exists, create it if not
            If Not Directory.Exists(folderPath) Then
                Directory.CreateDirectory(folderPath)
            End If

            ' Check file extension on the server side
            If Not IsFileExtensionValid(fileExtension) Then
                ' Delete the file if the extension is not valid
                File.Delete(savePath)
                Return "Invalid file format. Only PDF files are allowed."
            End If

            Dim query As String = "INSERT INTO SMKB_Pinjaman_Dokumen (No_Pinj, Nama_Fail, Status, Butiran, Tkh_Dokumen) VALUES (@noPinjamanValue, @Nama_Fail, 1, @butiranValue, GETDATE())"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@noPinjamanValue", noPinjamanValue))
            param.Add(New SqlParameter("@butiranValue", butiranValue))
            param.Add(New SqlParameter("@Nama_Fail", saveFileName))

            Dim db As New DBKewConn
            Dim result As String = db.Process(query, param)

            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            Return "File uploaded successfully. " & result
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function
    Private Function IsFileExtensionValid(extension As String) As Boolean
        ' Check if the file extension is valid (e.g., only allow PDF files)
        Return extension = ".pdf"
    End Function
    Private Function InsertPengesahan(mohonPengesahan As pengesahanInsertDetail) As String
        Dim db As New DBKewConn

        ' Insertion query
        Dim insertQuery As String = "UPDATE SMKB_Pinjaman_Penjamin SET Setuju = @setujuPengesahan, Tarikh_Setuju = @tarikhPengesahan
                                 WHERE No_Pinj = @nopinjPengesahan AND Bil = @bilPengesahan;"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@setujuPengesahan", mohonPengesahan.setujuPengesahan))
        insertParam.Add(New SqlParameter("@tarikhPengesahan", mohonPengesahan.tarikhPengesahan))
        insertParam.Add(New SqlParameter("@nopinjPengesahan", mohonPengesahan.nopinjPengesahan))
        insertParam.Add(New SqlParameter("@bilPengesahan", mohonPengesahan.bilPengesahan))
        insertParam.Add(New SqlParameter("@namapinjPengesahan", mohonPengesahan.namapinjPengesahan))
        insertParam.Add(New SqlParameter("@emailPengesahan", mohonPengesahan.emailPengesahan))
        insertParam.Add(New SqlParameter("@kategoriPengesahan", mohonPengesahan.kategoriPengesahan))

        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmd("No_Pinj", mohonPengesahan.nopinjPengesahan, insertQuery, insertParam)

        ' Check if the insertion was successful before proceeding with the SELECT query
        If insertResult = "OK" Then
            ' Determine email content based on @setujuPengesahan value  
            Dim subject As String
            Dim body As String

            If mohonPengesahan.setujuPengesahan = "1" Then
                ' Email content for setujuPengesahan = '0'
                subject = "PERCUBAAN - PERMOHONAN SKIM PEMBIAYAAN " & UCase(mohonPengesahan.kategoriPengesahan) & " STAF UTEM"
                body = "<html><body>" &
                           "<p style='font-size:16px; font-weight:bold;'>PENGESAHAN PENJAMIN BAGI SKIM PEMBIAYAAN " & UCase(mohonPengesahan.kategoriPengesahan) & " STAF UTEM</p>" &
                           "<p>Dimaklumkan bahawa, penjamin bagi pembiayaan " & LCase(mohonPengesahan.kategoriPengesahan) & " " & mohonPengesahan.namapinjPengesahan & ",</p>" &
                           "<p>telah membuat pengesahan.</p>" &
                           "<p>Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu.</p>" &
                           "<p>Anda tidak perlu membalas email ini.</p>" &
                       "</body></html>"

            Else
                ' Email content for setujuPengesahan = '0'
                If mohonPengesahan.setujuPengesahan = "0" Then
                    subject = "PERCUBAAN - PERMOHONAN SKIM PEMBIAYAAN " & UCase(mohonPengesahan.kategoriPengesahan) & " STAF UTEM"
                    body = "<html><body>" &
                               "<p style='font-size:16px; font-weight:bold;'>PENGESAHAN PENJAMIN BAGI SKIM PEMBIAYAAN " & UCase(mohonPengesahan.kategoriPengesahan) & " STAF UTEM</p>" &
                               "<p>Dimaklumkan bahawa, penjamin bagi pembiayaan " & LCase(mohonPengesahan.kategoriPengesahan) & " " & mohonPengesahan.namapinjPengesahan & ",</p>" &
                               "<p style='color:red;'>gagal membuat pengesahan.</p>" &
                               "<p>Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu.</p>" &
                               "<p>Anda tidak perlu membalas email ini.</p>" &
                           "</body></html>"
                End If

            End If

            ' Send the email
            myEmel(mohonPengesahan.emailPengesahan, subject, body)
        End If

        Return insertResult
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Async Function notificationMyUtem(NoStafPeminjam As String) As Tasks.Task(Of String)
        Dim db As New DBKewConn

        Dim resp As New ResponseRepository
        Dim response = New Response
        'Notification API
        'API EndPoint URL
        Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Pengesahan Penjamin bagi permohonan pembiayaan. Penjamin telah membuat pengesahan./" + NoStafPeminjam

        Using client As New HttpClient()
            Dim content = New FormUrlEncodedContent(New Dictionary(Of String, String)())
            Dim response1 As HttpResponseMessage = Await client.PostAsync(apiUrl, content)

            If response1.IsSuccessStatusCode Then
                'resp.Success("Permohonan perolehan berjaya dihantar.", "00", txtNoMohonR)
                'response = resp.GetResult()
            Else
                resp.Failed("gagal.")
            End If
        End Using


        resp.Success("Notifikasi berjaya dihantar.", "00")
        response = resp.GetResult()
    End Function

    Private Function UpdateEmelAuth(IDToken As String) As String
        Dim db As New DBKewConn

        ' Insertion query
        Dim updQuery As String = "UPDATE SMKB_Emel_Auth SET Status_Tindakan = 'DONE' WHERE ID_Token = @ID_Token;"

        Dim updParam As New List(Of SqlParameter)
        updParam.Add(New SqlParameter("@ID_Token", IDToken))

        Dim updResult As String = RbQueryCmd("ID_Token", IDToken, updQuery, updParam)
        Return updResult
    End Function
    '-------------------- REFERENCE btnSimpan END   --------------------
    Public Function RbQueryCmd(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value.ToString()
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
