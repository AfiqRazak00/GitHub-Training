Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports System.Data.Entity.Core
Imports Microsoft.Ajax.Utilities

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class StorMohonWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim queryRB As New Query 'Query rollback

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchUserDetails() As String
        Using dtUserInfo = fGetUserDetails(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function
    <WebMethod()>
    Public Function fGetUserDetails(strStaffID) As DataTable
        Dim dbconn As New DBSMConn
        Dim strSql As String = $"Select a.MS01_Nama as Nama, 
                                a.MS01_NoStaf as NoStaf,
                                a.MS01_KpB as NoKp,
                                DATEDIFF(YEAR, CONVERT(DATE, a.MS01_TkhLahir, 103), GETDATE()) -
                                        IIF(MONTH(CONVERT(DATE, a.MS01_TkhLahir, 103)) > MONTH(GETDATE()) OR 
                                            (MONTH(CONVERT(DATE, a.MS01_TkhLahir, 103)) = MONTH(GETDATE()) AND 
                                             DAY(CONVERT(DATE, a.MS01_TkhLahir, 103)) > DAY(GETDATE())), 1, 0) AS AgeYear,
                                DATEDIFF(MONTH, CONVERT(DATE, a.MS01_TkhLahir, 103), GETDATE()) % 12 AS AgeMonth,
                                a.MS01_TkhLahir as TkhLahir, 
                                e.Pejabat, 
                                e.KodPejabat, 
                                d.MS08_Bahagian as Bahagian, 
								f.KodTarafKhidmat,
                                f.TarafKhidmat,
                                d.MS08_Unit as Unit, 
                                a.MS01_Email as Email, 
                                c.JawGiliran,
								b.MS02_Kumpulan As Kumpulan,
                                b.MS02_GredGajiS as GredGajiS,
                                a.MS01_TelPejabat as NoTel,
                                a.MS01_NoTelBimbit as NoHp,
                                b.MS02_JumlahGajiS as GajiS,
                                a.MS01_NoLesen as NoLesen,
                                a.MS01_KelasLesen as KelasLesen,
                                FORMAT(b.MS02_TkhLantikKUTKM, 'dd/MM/yyyy') as TkhLantik,
                                b.MS02_TkhSah as TkhSah,
                                a.MS01_AlamatSurat1 as AlamatSurat1,
                                a.MS01_AlamatSurat2 as AlamatSurat2,
                                a.MS01_PoskodSurat as PoskodSurat,
                                (Select NamaNegeri From MS_Negeri Where KodNegeri = a.MS01_NegeriSurat) As Negeri,
                                (Select NamaNegara From MS_Negara Where KodNegara = a.MS01_NegaraSurat) As Negara
                                FROM MS01_Peribadi a, 
                                ms02_perjawatan b, 
                                MS_Jawatan c,
                                MS08_Penempatan d, 
                                MS_Pejabat e,
                                MS_TarafKhidmat f
                                WHERE a.MS01_NoStaf = '{strStaffID}'
                                AND b.MS01_NoStaf = a.MS01_NoStaf
                                AND b.ms02_jawsandang = c.KodJawatan
                                AND e.KodPejabat = d.MS08_Pejabat
                                AND d.MS01_NoStaf = a.MS01_NoStaf
                                ANd f.KodTarafKhidmat = b.MS02_Taraf
                                AND d.MS08_StaTerkini = 1"

        Using dt = dbconn.fselectCommandDt(strSql)
            Return dt
        End Using
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchDdlPtj() As String
        Using dtUserInfo = fGetDdlPtj(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function
    <WebMethod()>
    Public Function fGetDdlPtj(strStaffID) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"IF EXISTS (
                                    SELECT *
                                    FROM SMKB_Lookup_Detail
                                    WHERE Kod = 'SI007' AND Kod_Detail = '{strStaffID}'
                                )
                                BEGIN
                                    SELECT Pejabat, CONCAT(KodPejabat, '0000') AS KodPejabat
                                    FROM VPejabat
                                END
                                ELSE
                                BEGIN
	                                SELECT CONCAT(MS08_Pejabat, '0000') AS KodPejabat, Pejabat
                                    FROM VPeribadi
                                    WHERE MS01_NoStaf = '{strStaffID}'
                                    AND MS01_Status = 1
                                END"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchBarang(ByVal kodPtj As String) As String
        Using dtUserInfo = fGetBarang(kodPtj)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetBarang(kodPtj) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"select A.Kod_Brg,A.Takat_Min,A.Takat_Max,A.Takat_Menokok, b.Butiran,
                                ISNULL((SELECT SUM(Baki_Unit) FROM SMKB_SI_Inventori WHERE Kod_Brg = A.Kod_Brg AND Kod_Ptj = '500000'),0) AS Baki_Unit_Pusat,
                                ISNULL((SELECT SUM(Baki_Unit) FROM SMKB_SI_Inventori WHERE Kod_Brg = A.Kod_Brg AND Kod_Ptj = A.Kod_Ptj),0) AS Baki_Unit_PTJ,
                                ISNULL((SELECT SUM(Kuantiti_Mohon) 
	                                FROM SMKB_SI_Order_Dtl c
	                                INNER JOIN SMKB_SI_Order_Hdr d ON d.no_mohon = c.No_Mohon 
	                                WHERE d.Kod_Ptj = A.Kod_Ptj and c.Kod_Brg = A.Kod_Brg and d.Status_Dok NOT IN ('07', '08') and d.Status = '1' and d.Kat_Mohon = 'S'),0) 
                                AS Kuantiti_PTJ_Sedang_Dipohon
                                FROM SMKB_SI_Barang_Stor A
                                INNER JOIN  SMKB_SI_Barang_Master b ON a.Kod_Brg = b.Kod_Brg
                                WHERE A.Kod_Ptj = '{kodPtj}'"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchBarangTbl(ByVal noMohon As String, ByVal kodPtj As String) As String
        Using dtUserInfo = fGetBarangTbl(noMohon, kodPtj)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetBarangTbl(noMohon, kodPtj) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"select A.Kod_Brg,A.Takat_Min,A.Takat_Max,A.Takat_Menokok, b.Butiran,
                                ISNULL((SELECT SUM(Baki_Unit) FROM SMKB_SI_Inventori WHERE Kod_Brg = A.Kod_Brg AND Kod_Ptj = '500000'),0) AS Baki_Unit_Pusat,
                                ISNULL((SELECT SUM(Baki_Unit) FROM SMKB_SI_Inventori WHERE Kod_Brg = A.Kod_Brg AND Kod_Ptj = A.Kod_Ptj),0) AS Baki_Unit_PTJ,
                                ISNULL((SELECT SUM(Kuantiti_Mohon) 
	                                FROM SMKB_SI_Order_Dtl c
	                                INNER JOIN SMKB_SI_Order_Hdr d ON d.no_mohon = c.No_Mohon 
	                                WHERE d.Kod_Ptj = A.Kod_Ptj and c.Kod_Brg = A.Kod_Brg and d.Status_Dok NOT IN ('07', '08') and d.Status = '1' and d.Kat_Mohon = 'S'),0)
                                AS Kuantiti_PTJ_Sedang_Dipohon,
                                COALESCE((
                                    SELECT c.Kuantiti_Mohon
                                    FROM SMKB_SI_Order_Dtl c
                                    WHERE a.Kod_Brg = c.Kod_Brg AND c.No_Mohon = '{noMohon}'
                                ), 0) AS Kuantiti_Mohon
                                FROM SMKB_SI_Barang_Stor A
                                INNER JOIN  SMKB_SI_Barang_Master b ON a.Kod_Brg = b.Kod_Brg
                                WHERE A.Kod_Ptj = '{kodPtj}'"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiPermohonan(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String, kodPtj As String) As String
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        Using dtUserInfo = fGetSenaraiPermohonan(category_filter, tkhMula, tkhTamat, kodPtj)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetSenaraiPermohonan(category_filter As String, tkhMula As String, tkhTamat As String, kodPtj As String) As DataTable
        Dim dbconn As New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(a.Tkh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(a.Tkh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND a.Tkh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND a.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND a.Tkh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND a.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND a.Tkh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND a.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND CAST(a.Tkh_Mohon AS DATE) >= @tkhMula AND CAST(a.Tkh_Mohon AS DATE) <= @tkhTamat"
        End If

        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))

        Dim query As String = $"SELECT a.No_Mohon, a.Tkh_Mohon, a.No_Staf, c.MS01_Nama, a.Status, d.Butiran As Status_Dok,
                                    (SELECT COALESCE(SUM(b.Kuantiti_Mohon), 0) FROM SMKB_SI_Order_Dtl b WHERE a.No_Mohon = b.No_Mohon )AS Total_Kuantiti_Mohon
                                    FROM SMKB_SI_Order_Hdr a
                                    INNER JOIN VPeribadi c ON a.No_Staf = c.MS01_NoStaf
                                    INNER JOIN SMKB_Lookup_Detail d ON a.Status_Dok = d.Kod_Detail
                                    WHERE a.Kod_Ptj = '{kodPtj}'
                                    AND a.Kat_Stor = 'SU'
                                    AND a.Kat_Mohon = 'S'
                                    AND d.Kod = 'SI008'" & tarikhQuery

        Return dbconn.Read(query, param)
    End Function
    Private Function GenerateOrderID(kodModul, prefix, butiran, ptj) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='{kodModul}' AND Prefix ='{prefix}' AND Tahun =@year AND Kod_PTJ = '{ptj}' "
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dtbl = db.Read(query, param)

        queryRB = New Query()

        If dtbl.Rows.Count > 0 Then
            lastID = CInt(dtbl.Rows(0).Item("id")) + 1
            Dim resultId As String = UpdateNoAkhir($"{kodModul}", $"{prefix}", year, lastID, $"{ptj}")
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        Else
            Dim resultId As String = InsertNoAkhir($"{kodModul}", $"{prefix}", year, lastID, butiran, $"{ptj}")
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        End If
        queryRB.finish()
        newOrderID = $"{prefix}" + $"{ptj}" + Format(lastID, "0000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newOrderID
    End Function

    Private Function UpdateNoAkhir(kodModul As String, prefix As String, year As String, ID As String, kodPtj As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun and Kod_PTJ =@kodPtj"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@kodPtj", kodPtj))

        Dim key As New Dictionary(Of String, String)
        key.Add("No_Akhir", ID)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("Tahun", year)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String, Butiran As String, kodPtj As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@Kod_PTJ", kodPtj))

        Dim key As New Dictionary(Of String, String)
        key.Add("No_Akhir", ID)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("Tahun", year)
        key.Add("Kod_PTJ", kodPtj)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanPermohonanStok(formDataArray As List(Of OrderDtl), kodPtj As String) As String
        Dim resp As New ResponseRepository

        ' Generate New Prefix
        Dim NoPermohonan As String = GenerateOrderID("28", "PS", "Mohon Stor Pusat", $"{kodPtj}")

        If NoPermohonan = "" Then
            resp.Failed("Permohonan tidak berjaya\nSistem gagal memproses pembiayaan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query() 'New Query

        'Insert Data Ke SMKB_SI_Order_Hdr
        If InsertPermohonanStor($"{kodPtj}", NoPermohonan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Insert Data Ke SMKB_SI_Order_Dtl
        For Each formData In formDataArray
            If InsertPermohonanDetail(formData.IdBarang, formData.KuantitiDipohon, NoPermohonan) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal menyimpan rekod ‼️")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Next


        'Insert Data Ke SMKB_Pinjaman_Status_Dok
        If InsertStatusDok(Session("ssusrID"), NoPermohonan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        ' Add some sample data to the array
        Dim rsData As New With {
            .noPermohonan = NoPermohonan
        }
        resp.Success("Rekod telah berjaya disimpan.", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPermohonanStor(kodPtj, noPermohonan) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_SI_Order_Hdr 
                                (No_Mohon, Kat_Mohon, Tkh_Mohon, Kat_Stor, Kod_Ptj, No_Staf, Status_Dok, Status) 
                                VALUES (@No_Mohon, @Kat_Mohon, @Tkh_Mohon, @Kat_Stor, @Kod_Ptj, @No_Staf, @Status_Dok, @Status)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", noPermohonan))
        param.Add(New SqlParameter("@Kat_Mohon", "S"))
        param.Add(New SqlParameter("@Tkh_Mohon", Date.Now))
        param.Add(New SqlParameter("@Kat_Stor", "SU"))
        param.Add(New SqlParameter("@Kod_Ptj", kodPtj))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Status_Dok", "02"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("No_Mohon", noPermohonan, query, param)
    End Function

    Private Function InsertPermohonanDetail(IdBarang, KuantitiDipohon, NoPermohonan) As String
        Dim db As New DBKewConn
        Dim query As String
        Dim param As New List(Of SqlParameter)
        query = "INSERT INTO SMKB_SI_Order_Dtl (No_Mohon, ID_Mohon_Dtl, Kod_Brg, Kuantiti_Mohon, Tujuan) VALUES (@No_Mohon, @ID_Mohon_Dtl, @Kod_Brg, @Kuantiti_Mohon, @Tujuan)"

        param.Add(New SqlParameter("@No_Mohon", NoPermohonan))
        param.Add(New SqlParameter("@ID_Mohon_Dtl", DateTime.Now))
        param.Add(New SqlParameter("@Kod_Brg", IdBarang))
        param.Add(New SqlParameter("@Kuantiti_Mohon", KuantitiDipohon))
        param.Add(New SqlParameter("@Tujuan", "Tambah Stok"))

        Return RbQueryCmd("No_Mohon", NoPermohonan, query, param)
    End Function

    Private Function InsertStatusDok(staffId, noPermohonan) As String
        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status) 
                                VALUES (@Kod_Modul, @Kod_Status_Dok, @No_Rujukan, @No_Staf, @Tkh_Tindakan, @Tkh_Transaksi, @Status_Transaksi, @Status)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "28"))
        param.Add(New SqlParameter("@Kod_Status_Dok", "02"))
        param.Add(New SqlParameter("@No_Rujukan", noPermohonan))
        param.Add(New SqlParameter("@No_Staf", staffId))
        param.Add(New SqlParameter("@Tkh_Tindakan", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Status_Transaksi", "1"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("No_Rujukan", noPermohonan, query, param)
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
    Public Class OrderDtl
        Public Property IdBarang As String
        Public Property KuantitiDipohon As String
    End Class
End Class
