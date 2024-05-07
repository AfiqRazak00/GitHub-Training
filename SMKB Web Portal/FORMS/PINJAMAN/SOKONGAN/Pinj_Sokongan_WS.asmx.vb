Imports System.ComponentModel
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Newtonsoft.Json
' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Pinj_Sokongan_WS
    Inherits System.Web.Services.WebService

    'test api
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=True)>
    Public Function ping() As String

        Return "helo"
    End Function

    'senarai invois yg belum ada atau masih draf baucar
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function loadSokonganData(ByVal DateStart As String, ByVal DateEnd As String) As String
        Dim userID As String = Session("ssusrID")
        Dim req As Response = getListPinjamanBelumSokong(DateStart, DateEnd, userID)
        Return JsonConvert.SerializeObject(req)
    End Function

    Private Function getListPinjamanBelumSokong(DateStart As String, DateEnd As String, userID As String) As Response
        Dim kodpejabat As String
        Dim tarafpkhd As String
        Dim dtinfo As New DataTable
        dtinfo = fGetUserInfo(userID)
        If dtinfo.Rows.Count > 0 Then
            kodpejabat = dtinfo.Rows.Item(0).Item("KodPejabat")
            tarafpkhd = dtinfo.Rows.Item(0).Item("MS02_Taraf")
        End If

        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"SELECT 
                                            ROW_NUMBER() OVER (ORDER BY A.Tkh_Mohon DESC) AS bil,
                                            A.Status_Dok,
                                            A.No_Pinj, 
                                            A.No_Staf,
                                            C.MS01_Nama AS Nama,
                                            D.MS02_Taraf AS taraf,
                                            A.Tkh_Mohon, 
                                            FORMAT(CONVERT(datetime, A.Tkh_Mohon), 'dd/MM/yyyy') AS FormattedDate,
                                            A.Jenis_Pinj, 
                                            E.Butiran AS Jenis_Pinj_Desc,
                                            FORMAT(A.Amaun_Mohon, 'N2') AS Amaun_Mohon, 
                                            B.MS08_Pejabat
                                        FROM 
                                            SMKB_Pinjaman_Hdr A
                                        INNER JOIN 
                                            {DBStaf}MS08_Penempatan B ON B.MS01_NoStaf = A.No_Staf AND B.MS08_StaTerkini = 1
                                        LEFT JOIN 
                                            {DBStaf}MS01_Peribadi C ON C.MS01_NoStaf = A.No_Staf
                                        LEFT JOIN 
                                            {DBStaf}MS02_perjawatan D ON D.MS01_NoStaf = A.No_Staf
                                        LEFT JOIN 
                                            SMKB_Lookup_Detail E ON E.Kod_Detail = A.Jenis_Pinj AND E.Kod = 'PJM01'
                                        WHERE 
                                            B.MS08_Pejabat = @kodpejabat
                                            AND A.Status_Dok IN ('01','29')
                                         AND NOT EXISTS (
                                                SELECT 1
                                                FROM SMKB_Pinjaman_Penjamin P
                                                WHERE P.No_Pinj = A.No_Pinj
                                                AND P.Setuju IS NULL
                                            )
                                            AND A.Status = 'A' 
                                            AND A.Amaun_Mohon > 0 
                                    "

                If DateStart IsNot Nothing And DateStart <> "" Then
                    sqlText += " AND A.Tkh_Mohon >= @DateStart "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateStart", DateStart))
                End If

                If DateEnd IsNot Nothing And DateEnd <> "" Then
                    sqlText += " AND A.Tkh_Mohon <= @DateEnd "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateEnd", DateEnd))
                End If

                sqlText += " ORDER BY A.Tkh_Mohon DESC;"

                sqlcmd.Parameters.Add(New SqlParameter("@kodpejabat", kodpejabat))
                sqlcmd.CommandText = sqlText

                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using
        Catch ex As Exception
            Dim strex As String = ex.Message
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res

    End Function

    'get modal pinjaman data
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getFullSokonganData(ByVal No_Pinj As String) As String
        Dim hdr As Response = fetchSokonganHdrFull(No_Pinj)
        If hdr.Code <> "200" Then
            Return JsonConvert.SerializeObject(hdr)
        End If

        Dim data As New Dictionary(Of String, Object)()
        data.Add("hdr", hdr.Payload)

        Dim response As New Response
        response.Code = "200"
        response.Payload = data

        Return JsonConvert.SerializeObject(response)

    End Function

    'query modal pinjaman
    Private Function fetchSokonganHdrFull(No_Pinj As String) As Response
        Dim res As New Response
        res.Code = 200
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn
                sqlcmd.CommandText = $"SELECT a.No_Pinj,a.No_Staf,b.MS01_Nama, b.MS01_KpB, c.MS02_GredGajiS, 
                                        c.MS02_Taraf, (SELECT TarafKhidmat FROM {DBStaf}MS_TarafKhidmat WHERE KodTarafKhidmat = c.MS02_Taraf) AS Taraf,
                                        c.MS02_JawSandang, (SELECT JawGiliran FROM {DBStaf}MS_Jawatan WHERE KodJawatan = c.MS02_JawSandang) AS Jawatan,
                                        d.MS08_Pejabat,(SELECT Pejabat FROM {DBStaf}MS_Pejabat WHERE KodPejabat = d.MS08_Pejabat) AS Pejabat,
                                        MS02_Kumpulan, (SELECT Kumpulan FROM {DBStaf}MS_Kumpulan WHERE KodKumpulan = MS02_Kumpulan) AS Kumpulan,
                                        b.MS01_TkhLahir, 
                                        CONVERT(VARCHAR, DATEDIFF(YEAR, CONVERT(DATETIME, b.MS01_TkhLahir, 103), GETDATE())) + ' TAHUN DAN ' +
                                        CONVERT(VARCHAR, DATEDIFF(MONTH, CONVERT(DATETIME, b.MS01_TkhLahir, 103), GETDATE()) % 12) + ' BULAN' AS AgeFormatted,
                                        c.MS02_TkhLapor, c.MS02_TkhSah, FORMAT(c.MS02_JumlahGajiS, 'N2') AS MS02_JumlahGajiS,b.MS01_VoIP,
                                        a.Kategori_Pinj,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15' AND Kod_Detail = a.Kategori_Pinj) AS KatPinj,
                                        FORMAT(a.Amaun_Mohon, 'N2') AS Amaun_Mohon,a.Tkh_Mohon,FORMAT(CONVERT(datetime, A.Tkh_Mohon), 'dd/MM/yyyy') AS TkhMohon,
                                        a.Jenis_Pinj,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' AND Kod_Detail = a.Jenis_Pinj) AS JenisPinj,
                                        a.Tempoh_Pinj + ' BULAN' AS TempohPinj, 
                                        FORMAT((SELECT Ansuran FROM SMKB_Pinjaman_Jadual WHERE Kategori_Pinj = a.Kategori_Pinj AND Tempoh = a.Tempoh_Pinj AND Amaun = a.Amaun_Mohon),'N2') AS Ansuran,
                                        a.Status_Layak,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM25' AND Kod_Detail = a.Status_Layak) AS Kelayakan,
                                        a.IK01_No_Mohon AS no_insentif, FORMAT(a.IK01_Amaun,'N2') AS amaun_insentif, a.Status_Dok
                                        FROM SMKB_Pinjaman_Hdr a
                                        INNER JOIN {DBStaf}MS01_Peribadi AS b ON b.MS01_NoStaf = a.No_Staf
                                        INNER JOIN {DBStaf}MS02_Perjawatan AS c ON c.MS01_NoStaf = a.No_Staf
                                        INNER JOIN {DBStaf}MS08_Penempatan AS d ON d.MS01_NoStaf = a.No_Staf AND d.MS08_StaTerkini = 1
                                        WHERE a.No_Pinj = @No_Pinj
                                     "
                sqlcmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using

        Catch ex As Exception
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function loadUlasanSokongan(ByVal Kategori_Pinj As String) As String
        Dim req As Response = getUlasanSokongan(Kategori_Pinj)
        Return JsonConvert.SerializeObject(req)
    End Function

    Private Function getUlasanSokongan(ByVal Kategori_Pinj As String) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = "SELECT A.ID_Rujukan,A.ID_Ulasan,B.Butiran,A.Kat_Pinj 
                                        FROM SMKB_Pinjaman_Ulasan_Sokongan A
                                        INNER JOIN SMKB_Lookup_Detail B ON B.Kod = 'PJM30' AND B.Kod_Detail = A.ID_Ulasan
                                        WHERE Kat_Pinj = @Kategori_Pinj AND A.Status = 1"
                sqlcmd.Parameters.Add(New SqlParameter("@Kategori_Pinj", Kategori_Pinj))
                sqlcmd.CommandText = sqlText

                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using
        Catch ex As Exception
            Dim strex As String = ex.Message
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res

    End Function

    Public Class ChecklistItem
        Public Property ID As String
        Public Property isChecked As Boolean
    End Class

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function saveSokonganPTJ(pinjamanHdr As SokonganPinjamanHdr, ulasan As String, checklistData As ChecklistItem(), buttonId As String) As String
        Dim response As New Response
        response.Code = 200
        response.Message = "Berjaya Di Simpan"

        Dim userID As String = HttpContext.Current.Session("ssusrID")
        Dim query As New Query

        pinjamanHdr.New_Status_Dok = If(buttonId.Equals("btnXLulus"), "22", "03")

        'update SMKB_Pinjaman_Hdr
        If query.execute(pinjamanHdr.No_Pinj, "No_Pinj", pinjamanHdr.updateCommand()) < 0 Then
            response.Code = 500
            response.Message = "Maklumat pinjaman gagal di simpan"
            query.rollback()
        End If

        'insert SMKB_Pinjaman_Dtl_UlasanSokongan
        For Each item As Object In checklistData
            Try
                Dim id As String = item.ID
                Dim isChecked As Integer = If(item.isChecked, 1, 0)
                If query.execute(pinjamanHdr.No_Pinj, "No_Pinj", saveChecklistDtl(pinjamanHdr.No_Pinj, id, isChecked)) < 0 Then
                    Throw New Exception("Maklumat ulasan checklist gagal di simpan")
                End If
            Catch ex As Exception
                response.Code = 500
                response.Message = ex.Message
                query.rollback()
            End Try
        Next

        'insert SMKB_Status_Dok
        If query.execute(pinjamanHdr.No_Pinj, "No_Rujukan", logInvoisDok(pinjamanHdr.No_Pinj, ulasan, userID, pinjamanHdr.New_Status_Dok)) > 0 Then
            query.finish()
        Else
            response.Code = 500
            response.Message = "Maklumat status dok gagal di simpan"
            query.rollback()
        End If
        Return JsonConvert.SerializeObject(response)
    End Function

    Private Function saveChecklistDtl(No_Rujukan As String, ID_Ulasan As String, Status As String) As SqlCommand
        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Pinjaman_Dtl_UlasanSokongan (ID_Ulasan,No_Pinj,Tarikh,Status)
                VALUES (@ID_Ulasan,@No_Pinj,getdate(),@Status)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@ID_Ulasan", ID_Ulasan))
        cmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Rujukan))
        cmd.Parameters.Add(New SqlParameter("@Status", Status))

        Return cmd
    End Function
    Private Function logInvoisDok(No_Rujukan As String, Ulasan As String, userID As String, New_Status_Dok As String) As SqlCommand
        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Status_Dok (Kod_Modul,Kod_Status_Dok,No_Rujukan,No_Staf,Tkh_Tindakan,Tkh_Transaksi,Status_Transaksi,Status,Ulasan)
                VALUES (@Kod_Modul,@Kod_Status_Dok,@No_Rujukan,@No_Staf,getdate(),getdate(),@Status_Transaksi,@Status,@Ulasan)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@Kod_Modul", "13"))
        'cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", "03uyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyttttttt"))
        cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", New_Status_Dok))
        cmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        cmd.Parameters.Add(New SqlParameter("@No_Staf", userID))
        cmd.Parameters.Add(New SqlParameter("@Status_Transaksi", "1"))
        cmd.Parameters.Add(New SqlParameter("@Status", "1"))
        cmd.Parameters.Add(New SqlParameter("@Ulasan", Ulasan))

        Return cmd
    End Function


End Class

<Serializable>
Public Class SokonganPinjamanHdr
    Public Property No_Pinj As String
    Public Property No_Staf As String
    Public Property Status_Dok As String
    Public Property Status As String
    Public Property New_Status_Dok As String
    'Public Property details As List(Of SokonganPinjamanHdr)

    Public Function updateCommand() As SqlCommand
        If No_Pinj Is Nothing Then
            Throw New Exception("No Pinjaman tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "UPDATE SMKB_Pinjaman_Hdr SET Status_Dok = @Status_Dok "

        cmd.CommandText = sql + " WHERE No_Pinj = @No_Pinj"
        cmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
        cmd.Parameters.Add(New SqlParameter("@Status_Dok", New_Status_Dok))

        Return cmd
    End Function
End Class
