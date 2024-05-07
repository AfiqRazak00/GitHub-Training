Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports SMKB_Web_Portal.KPT
Imports SMKB_Web_Portal.JU
Imports System.IO

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class KemaskiniWS
    Inherits System.Web.Services.WebService
    Dim dtbl As DataTable
    Dim queryRB As New Query 'Query rollback

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiPinjaman() As String

        Using dtUserInfo = fGetSenaraiPinjaman(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetSenaraiPinjaman(strStaffID) As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = $"SELECT No_Pinj, 
                                    Tkh_Mohon,
                                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod_Detail = a.Kategori_Pinj AND Kod = 'PJM15') AS Kategori_Pinj,
                                    Tempoh_Pinj, 
                                    FORMAT(ISNULL(Amaun, 0.00),'N2') AS Amaun, 
                                    b.Butiran 
                                FROM 
                                    SMKB_Pinjaman_Hdr a
                                INNER JOIN 
                                    SMKB_Lookup_Detail b ON a.Status_Dok = b.Kod_Detail AND b.Kod = 'pjm24'
                                WHERE 
                                    No_Staf = '{strStaffID}'
                                ORDER BY 
                                    a.Tkh_Mohon DESC"

        param.Add(New SqlParameter("@No_Staf", strStaffID))

        Return dbconn.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchMaklumat(No_Pinj) As String

        Using dtUserInfo = fGetMaklumat(No_Pinj)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetMaklumat(No_Pinj) As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = $"SELECT a.No_Pinj,a.No_Staf,b.MS01_Nama, b.MS01_KpB, c.MS02_GredGajiS, 
                                        c.MS02_Taraf, (SELECT TarafKhidmat FROM {DBStaf}MS_TarafKhidmat WHERE KodTarafKhidmat = c.MS02_Taraf) AS Taraf,
                                        c.MS02_JawSandang, (SELECT JawGiliran FROM {DBStaf}MS_Jawatan WHERE KodJawatan = c.MS02_JawSandang) AS Jawatan,
                                        d.MS08_Pejabat,(SELECT Pejabat FROM VPejabat WHERE KodPejabat = d.MS08_Pejabat) AS Pejabat,
                                        b.MS02_Kumpulan, (SELECT Kumpulan FROM {DBStaf}MS_Kumpulan WHERE KodKumpulan = b.MS02_Kumpulan) AS Kumpulan,
                                        b.MS01_TkhLahir, 
                                        CONVERT(VARCHAR, DATEDIFF(YEAR, CONVERT(DATETIME, b.MS01_TkhLahir, 103), GETDATE())) + ' TAHUN DAN ' +
                                        CONVERT(VARCHAR, DATEDIFF(MONTH, CONVERT(DATETIME, b.MS01_TkhLahir, 103), GETDATE()) % 12) + ' BULAN' AS AgeFormatted,
                                        c.MS02_TkhLapor, c.MS02_TkhSah, FORMAT(c.MS02_JumlahGajiS, 'N2') AS MS02_JumlahGajiS,b.MS01_VoIP,
                                        a.Kategori_Pinj,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15' AND Kod_Detail = a.Kategori_Pinj) AS KatPinj,
                                        FORMAT(a.Amaun_Mohon, 'N2') AS Amaun_Mohon,FORMAT(CONVERT(datetime, A.Tkh_Mohon), 'dd/MM/yyyy') AS TkhMohon,
                                        (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' AND Kod_Detail = a.Jenis_Pinj) AS JenisPinj,
                                        a.Tempoh_Pinj + ' BULAN' AS TempohPinj, 
                                        FORMAT((SELECT Ansuran FROM SMKB_Pinjaman_Jadual WHERE Kategori_Pinj = a.Kategori_Pinj AND Tempoh = a.Tempoh_Pinj AND Amaun = a.Amaun_Mohon),'N2') AS Ansuran,
                                        a.Status_Layak,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM25' AND Kod_Detail = a.Status_Layak) AS Kelayakan,
                                        a.IK01_No_Mohon AS no_insentif, FORMAT(a.IK01_Amaun,'N2') AS amaun_insentif, a.Status_Dok
                                        FROM SMKB_Pinjaman_Hdr a
                                        INNER JOIN VPeribadi AS b ON b.MS01_NoStaf = a.No_Staf
                                        INNER JOIN {DBStaf}MS02_Perjawatan AS c ON c.MS01_NoStaf = a.No_Staf
                                        INNER JOIN {DBStaf}MS08_Penempatan AS d ON d.MS01_NoStaf = a.No_Staf AND d.MS08_StaTerkini = 1
                                        WHERE a.No_Pinj = '{No_Pinj}'"

        param.Add(New SqlParameter("@No_Pinj", No_Pinj))

        Return dbconn.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanDokumen() As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn

        queryRB = New Query() 'New Query

        If HttpContext.Current.Request.Files.Count > 0 Then
            'Update Data Ke SMKB_SI_Inventori
            If TambahDokumen() <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal menyimpan fail ‼️")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Else
            resp.Failed("Tiada fail disimpan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        resp.Success("Fail berjaya disimpan di pangkalan data.", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function TambahDokumen() As String
        Dim db As New DBKewConn

        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim butiranFail = HttpContext.Current.Request.Form("butiranFail")
        Dim No_Pinj = HttpContext.Current.Request.Form("No_Pinj")
        Dim tkhMula = HttpContext.Current.Request.Form("tkhMula")
        Dim tkhTamat = HttpContext.Current.Request.Form("tkhTamat")

        Dim newFileName As String = No_Pinj & "_" & DateTime.Now.ToString("ddMMyy") & "_" & fileName

        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        ' Your existing file processing logic here
        Dim folderPath As String = Server.MapPath("~/UPLOAD/PINJAMAN/KEMASKINI PERMOHONAN/")
        Dim savePath As String = Path.Combine(folderPath, newFileName)

        ' Check if the folder for No_Mohon exists, create it if not
        If Not Directory.Exists(folderPath) Then
            Directory.CreateDirectory(folderPath)
        End If

        Dim query As String = "INSERT INTO SMKB_Pinjaman_Dokumen (No_Pinj, Nama_Fail, Butiran, Tkh_Dokumen, Status, Tkh_Mula, Tkh_Tamat) VALUES (@No_Pinj, @Nama_Fail, @Butiran, @Tkh_Dokumen, @Status, @Tkh_Mula, @Tkh_Tamat)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Pinj", No_Pinj))
        param.Add(New SqlParameter("@Nama_Fail", newFileName))
        param.Add(New SqlParameter("@Butiran", butiranFail))
        param.Add(New SqlParameter("@Tkh_Dokumen", DateTime.Now)) ' Use DateTime.Now instead of Date.Now
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@Tkh_Mula", tkhMula))
        param.Add(New SqlParameter("@Tkh_Tamat", tkhTamat))

        ' Save the file to the specified path
        postedFile.SaveAs(savePath)

        Return RbQueryCmd("No_Pinj", No_Pinj, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiDokumen(No_Pinj) As String

        Using dtUserInfo = fGetSenaraiDokumen(No_Pinj)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetSenaraiDokumen(No_Pinj) As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = $"SELECT Nama_Fail, Butiran, Tkh_Dokumen FROM SMKB_Pinjaman_Dokumen WHERE No_Pinj = @No_Pinj AND Status = '1'"

        param.Add(New SqlParameter("@No_Pinj", No_Pinj))

        Return dbconn.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteDokumen(Nama_Fail, No_Pinj) As String
        Dim resp As New ResponseRepository

        If UpdateStatusDokumen(Nama_Fail, No_Pinj) <> "OK" Then
            resp.Failed("Gagal memadam fail.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim filePath As String = Server.MapPath("~/UPLOAD/PINJAMAN/KEMASKINI PERMOHONAN/") & Nama_Fail
        If File.Exists(filePath) Then
            File.Delete(filePath)
        End If

        resp.Success("Fail berjaya dipadam.", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateStatusDokumen(Nama_Fail, No_Pinj) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Pinjaman_Dokumen
                                SET Status = @Status
                                WHERE Nama_Fail = @Nama_Fail AND No_Pinj = @No_Pinj"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Status", "0"))
        param.Add(New SqlParameter("@Nama_Fail", Nama_Fail))
        param.Add(New SqlParameter("@No_Pinj", No_Pinj))

        Dim key As New Dictionary(Of String, String)
        key.Add("Nama_Fail", Nama_Fail)
        key.Add("No_Pinj", No_Pinj)

        Return RbQueryCmdMulti(key, query, param)
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