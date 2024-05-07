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
Imports System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder
Imports System.Data.Entity.Core
Imports System.Web.Http.Results
Imports System.Net.Http
Imports System.Threading

' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class KelulusanPinjaman_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim dtbl As DataTable
    Dim queryRB As New Query

    '-------------------- REFERENCE TABLE START -----------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai(category_filter As String, isClicked7 As Boolean, tkhMula As String, tkhTamat As String) As String
        Dim resp As New ResponseRepository


        Dim dt2 As DataTable

        If isClicked7 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Senarai(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_Senarai(category_filter As String, tkhMula As String, tkhTamat As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(A.Tkh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(A.Tkh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND A.Tkh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND A.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND A.Tkh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND A.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND A.Tkh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND A.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND A.Tkh_Mohon >= @tkhMula AND A.Tkh_Mohon <= @tkhTamat "
        End If

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@TkhTamat", tkhTamat))

        Dim query As String = "Select

A.No_Pinj AS NoPinjaman,
A.No_Staf AS NoStaf,
B.MS01_KpB AS KadPengenalan,
FORMAT(CONVERT(DATETIME, B.MS01_TkhLahir, 103), 'dd/MM/yyyy') AS TarikhLahir,
A.Tempoh_Pinj AS TempohPinjaman,
A.Kod_Pemiutang AS KodPemiutang,
B.Nama AS NamaPeminjam,
A.Jenis_Pinj AS JenisPinjaman,
 A.Kategori_Pinj AS KategoriPinjaman2,
FORMAT(A.Amaun, 'N2') AS Amaun,
FORMAT(A.Amaun_Mohon, 'N2') AS AmaunMohon,
A.Fail_Ruj AS FailRujukan,
A.No_RujFail AS NoFailRujukan,
FORMAT(A.Tkh_Mesy_LPU, 'dd/MM/yyyy') AS TarikhMesyuarat,
FORMAT(A.Tkh_Mohon, 'dd/MM/yyyy') AS TarikhMohon,
FORMAT(A.Tkh_Mohon, 'dd/MM/yyyy') AS TarikhMohon2,
A.Tmpt_Mesy_LPU AS TempatMesyuarat,
A.Bil_Mesy_LPU AS BilMesyuarat,
(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM22') AND Kod_Detail = A.Kod_Skim) AS SkimPinjaman,
(SELECT Kod_Detail FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM22') AND Kod_Detail = A.Kod_Skim) AS Kod_Skim,
B.GredGaji AS GredGaji,
FORMAT(B.MS02_JumlahGajiS, 'N2') AS GajiPokok,
B.KumpStaf AS Kumpulan,
B.MS02_TkhSah AS TarikhSah,
B.JGiliran AS Jawatan,
B.NPejabat AS Jabatan,
B.TelPej AS SambunganTelifon,
B.TarafKhidmat AS TarafKhidmat,
(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM05') AND Kod_Detail = C.Kod_Buatan) AS BuatanKenderaan,
(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM19') AND Kod_Detail = C.Kod_Model) AS ModelKenderaan,
(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM01') AND Kod_Detail = A.Jenis_Pinj) AS JenisPinjaman2,
(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM25') AND Kod_Detail = A.Status_Layak) AS Kelayakan,
C.Sukat_Silinder AS SukatanSilinder,
C.No_Casis AS NoCasis,
C.No_Enjin AS NoEnjin,
FORMAT(C.Harga_Bersih, 'N2') AS HargaBersih,
FORMAT(B.MS02_TkhLapor, 'dd/MM/yyyy') AS TarikhLantikan,
CONCAT(
        DATEDIFF(YEAR, CONVERT(DATETIME, B.MS01_TkhLahir, 103), A.Tkh_Mohon), ' Tahun ',
        DATEDIFF(MONTH, CONVERT(DATETIME, B.MS01_TkhLahir, 103), A.Tkh_Mohon) % 12, ' Bulan'
    ) AS Umur,
(SELECT Ansuran FROM SMKB_Pinjaman_Jadual WHERE Kategori_Pinj = A.Kategori_Pinj AND Tempoh = A.Tempoh_Pinj AND Amaun = A.Amaun_Mohon) AS Ansuran,
(SELECT Butiran FROM SMKB_Lookup_Detail D WHERE D.Kod IN ('PJM15') AND D.Kod_Detail = A.Kategori_Pinj) AS KategoriPinjaman,
(SELECT TOP 1 Vot FROM SMKB_Pinjaman_Kawalan WHERE Kategori_Pinj = A.Kategori_Pinj AND Jenis_Pinj = A.Jenis_Pinj) As VOT,
A.Tkh_Mohon AS TkhMohon

From SMKB_Pinjaman_Hdr A
INNER JOIN VPeribadi12 B ON B.NoStaf = A.No_Staf
FULL OUTER JOIN SMKB_Pinjaman_Dtl_Kenderaan C ON C.No_Pinj = A.No_Pinj
WHERE A.Status_Dok = '03'

                            " & tarikhQuery & "ORDER BY TkhMohon DESC"

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE TABLE END   ---------------------------
    '-------------------- REFERENCE POTONGAN GAJI START -------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_SecondTableData(noStaf As String) As String
        Dim tmpDT As DataTable = Get_KodSecondTableData(noStaf)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Public Function Get_KodSecondTableData(noStaf As String) As DataTable
        ' Your query logic for the second table based on noStaf
        Dim query As String = "SELECT DISTINCT
                                    CAST(a.Amaun AS DECIMAL(10, 2)) AS Amaun, 
                                    b.Butiran AS Butiran,
                                    d.MS02_JumlahGajiS AS JumlahGaji,
                                    (SELECT SUM(c.Amaun) FROM SMKB_Gaji_Master c WHERE c.Jenis_Trans = 'E' AND c.Status = 'A' AND c.Tkh_Tamat > CURRENT_TIMESTAMP AND c.No_Staf = a.No_Staf) AS TotalElaun,
                                    (d.MS02_JumlahGajiS + (SELECT SUM(c.Amaun) FROM SMKB_Gaji_Master c WHERE c.Jenis_Trans = 'E' AND c.Status = 'A' AND c.Tkh_Tamat > CURRENT_TIMESTAMP AND c.No_Staf = a.No_Staf)) AS GajiPlusElaun
                                FROM 
                                    SMKB_Gaji_Master a
                                INNER JOIN 
                                    SMKB_Gaji_Kod_Trans b ON a.Kod_Trans = b.Kod_Trans
                                INNER JOIN
                                    VPeribadi12 d ON d.NoStaf = a.No_Staf
                                WHERE 
                                    a.No_Staf = @noStaf AND 
                                    (a.Jenis_Trans = 'P' OR a.Kod_Trans IN ('KWSP', 'SOCP', 'TAX')) AND 
                                    a.Tkh_Tamat > CURRENT_TIMESTAMP
                                    AND a.Status = 'A';"

        Dim param As New List(Of SqlParameter) From {New SqlParameter("@NoStaf", noStaf)}

        Dim db = New DBKewConn
        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE POTONGAN GAJI END -------------------
    '-------------------- REFERENCE ULASAN KJ START ---------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_ThirdTableData(NoPinjaman As String) As String
        Dim tmpDT As DataTable = Get_KodThirdTableData(NoPinjaman)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Public Function Get_KodThirdTableData(NoPinjaman As String) As DataTable
        ' Your query logic for the second table based on noStaf
        Dim query As String = "SELECT 
                                A.Status AS CheckedStatus,
                                (SELECT butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM30' AND Kod_Detail = A.ID_Ulasan) AS Butiran
                            FROM 
                                SMKB_Pinjaman_Dtl_UlasanSokongan A
                            WHERE 
                                A.No_Pinj = @NoPinjaman"
        Dim param As New List(Of SqlParameter) From {New SqlParameter("@NoPinjaman", NoPinjaman)}

        Dim db = New DBKewConn
        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE ULASAN KJ END -----------------------
    '-------------------- REFERENCE DROPDOWN SKIM START -----------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SkimPinjaman(ByVal q As String) As String
        Dim tmpDT As DataTable = GetSkimPinjaman(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetSkimPinjaman(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "	select Kod_Detail as value, Butiran as text from SMKB_Lookup_Detail where Kod = 'PJM22'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Butiran as text LIKE '%' + @kod + '%' "
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE DROPDOWN SKIM END -------------------
    '-------------------- REFERENCE DROPDOWN TEMPOH START ---------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function TempohPinjaman(ByVal q As String, ByVal jenisPinjaman As String) As String
        Dim tmpDT As DataTable = GetSTempohPinjaman(q, jenisPinjaman)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetSTempohPinjaman(ByVal kod As String, ByVal jenisPinjaman As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "WITH RecursiveCTE AS (
                              SELECT TOP 1 Max_Tempoh
                              FROM SMKB_Pinjaman_Kelayakan
                              WHERE Jenis_Pinj = @kod
                              ORDER BY Max_Tempoh DESC

                              UNION ALL

                              SELECT Max_Tempoh - 6
                              FROM RecursiveCTE
                              WHERE Max_Tempoh > 6
                            )
                            SELECT Max_Tempoh
                            FROM RecursiveCTE
                            ORDER BY Max_Tempoh ASC
                            OPTION (MAXRECURSION 0);
                            "
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", jenisPinjaman))

        If kod <> "" Then
            query &= " AND Jenis_Pinj LIKE '%' + @kod + '%' "

        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE DROPDOWN TEMPOH END -----------------
    '-------------------- REFERENCE DROPDOWN VOT START ------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVotCOA(ByVal q As String, ByVal vot As String) As String
        Dim tmpDT As DataTable = GetKodCOAList(q, vot)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodCOAList(kodCariVot As String, vot As String) As DataTable
        Dim db = New DBKewConn
        'Dim query As String = "SELECT CONCAT(a.Kod_Vot, ' - ', vot.Butiran, ', ', a.Kod_Operasi, ' - ', ko.Butiran, ' , ', a.Kod_Projek, ' - ', kp.Butiran, ', ', a.Kod_Kump_Wang, ' - ',
        '                   REPLACE(kw.Butiran, 'KUMPULAN WANG', 'KW'), ', ', LEFT(a.Kod_PTJ,2), ' - ', mj.Pejabat) AS text,
        '                   a.Kod_Vot AS value ,
        '                   mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO ,  kp.Butiran as colKp ,
        '                   a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
        '                   FROM SMKB_COA_Master AS a
        '                   JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
        '                   JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
        '                   JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
        '                   JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
        '                   JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_PTJ,2)
        '                   WHERE a.status = 1 AND a.Kod_Vot = @kod"

        Dim query As String = "SELECT CONCAT(a.Kod_Vot, ' - ', vot.Butiran, ', ', a.Kod_Operasi, ' - ', ko.Butiran, ' , ', a.Kod_Projek, ' - ', kp.Butiran, ', ', a.Kod_Kump_Wang, ' - ',
                           REPLACE(kw.Butiran, 'KUMPULAN WANG', 'KW'), ', ', LEFT(a.Kod_PTJ,2), ' - ', mj.Pejabat) AS text,
                           a.Kod_Vot AS value ,
                           mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO ,  kp.Butiran as colKp ,
                           a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
                           FROM SMKB_COA_Master AS a
                           JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                           JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                           JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                           JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
                           JOIN VPejabat AS mj ON mj.kodpejabat = left(a.Kod_PTJ,2)
                           WHERE a.status = 1 AND a.Kod_Vot = @kod"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", vot))

        If kodCariVot <> "" Then
            query &= " AND (a.Kod_Operasi LIKE '%' + @kod2 + '%' OR a.Kod_Projek LIKE '%' + @kod3 + '%' OR a.Kod_Kump_Wang LIKE '%' + @kod4 + '%' OR a.Kod_PTJ LIKE '%' + @kod5 + '%' OR vot.Butiran LIKE '%' + @kodButir + '%' OR ko.Butiran LIKE '%' + @kodButir1 + '%' OR kw.Butiran LIKE '%' + @kodButir2 + '%' OR mj.pejabat LIKE '%' + @kodButir3 + '%')"

            param.Add(New SqlParameter("@kod2", kodCariVot))
            param.Add(New SqlParameter("@kod3", kodCariVot))
            param.Add(New SqlParameter("@kod4", kodCariVot))
            param.Add(New SqlParameter("@kod5", kodCariVot))
            param.Add(New SqlParameter("@kodButir", kodCariVot))
            param.Add(New SqlParameter("@kodButir1", kodCariVot))
            param.Add(New SqlParameter("@kodButir2", kodCariVot))
            param.Add(New SqlParameter("@kodButir3", kodCariVot))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE DROPDOWN VOT END --------------------
    '-------------------- REFERENCE btnSimpan YA START   ----------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan(mohonPengesahan As KelulusanInsertDetail) As String
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

        If InsertPengesahan2(mohonPengesahan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(mohonPengesahan.nostafpeminjamPengesahan) Then
            resp.Failed("Gagal menghantar notifikasi")
        Else
            notificationMyUtem(mohonPengesahan.nostafpeminjamPengesahan)
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

        'queryRB.finish()

        If mohonPengesahan.confirmPengesahan.Equals("05") Then
            Try
                Dim data As New AP_Order()
                Dim dataDetails As New AP_Order_Dtl()
                Dim jumlah As Double? = Convert.ToDouble(mohonPengesahan.amaunPengesahan)
                data.Kod_Transaksi = "001" 'transaksi mohon
                data.ID_Rujukan = mohonPengesahan.nopinjamanPengesahan
                If jumlah IsNot Nothing Then
                    data.Jumlah_Keseluruhan = jumlah
                Else
                    data.Jumlah_Keseluruhan = 0
                End If
                data.Pengirim = "PINJ"
                data.Pengirim_Mohon = "TRANSAKSI" 'BUTIRAN VOT
                data.Jumlah_Item = "1"
                data.Status = "1"
                data.details = New List(Of AP_Order_Dtl)()
                dataDetails.No_Dokumen = mohonPengesahan.kodpemiutangPengesahan 'Kod_pemiutang
                dataDetails.Kod_Kump_Wang = mohonPengesahan.kumpulanwangPengesahan 'KW
                dataDetails.Kod_Operasi = mohonPengesahan.operasiPengesahan 'KO
                dataDetails.Kod_Ptj = mohonPengesahan.ptjPengesahan 'KPTJ
                dataDetails.Kod_Projek = mohonPengesahan.projekPengesahan 'KP
                dataDetails.Kod_Vot = mohonPengesahan.novotPengesahan 'VOT
                dataDetails.Jumlah = Convert.ToDouble(mohonPengesahan.amaunPengesahan)
                data.details.Add(dataDetails)

                'CALLING API
                If SMKB_API.MakeHttpPostRequestAP(Session("ssusrID"), data) Then
                    Console.WriteLine("Success")
                    queryRB.finish()
                    resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
                    Return JsonConvert.SerializeObject(resp.GetResult())
                Else
                    Console.WriteLine("Fail")
                    queryRB.rollback()
                    resp.Failed("Gagal Menyimpan order api")
                End If

            Catch ex As Exception
                queryRB.rollback()
                resp.Failed("Gagal Menyimpan order api")
            End Try
        Else
            queryRB.finish()
            resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
        End If


        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPengesahan(mohonPengesahan As KelulusanInsertDetail) As String
        ' Insertion query
        Dim tarikhMesyuarat As String

        If String.IsNullOrEmpty(mohonPengesahan.tarikhmesyuaratPengesahan) OrElse mohonPengesahan.tarikhmesyuaratPengesahan = "NaN-NaN-NaN NaN:NaN:NaN" Then
            tarikhMesyuarat = ""
        Else
            tarikhMesyuarat = mohonPengesahan.tarikhmesyuaratPengesahan
        End If

        Dim insertQuery As String = $"UPDATE SMKB_Pinjaman_Hdr SET Status_Dok = '{mohonPengesahan.confirmPengesahan}', Tkh_Lulus = '{mohonPengesahan.tarikhPengesahan}', Kod_Skim = '{mohonPengesahan.skimPengesahan}', Fail_Ruj = '{mohonPengesahan.filePengesahan}', Tempoh_Pinj = '{mohonPengesahan.tempohPengesahan}', Tmpt_Mesy_LPU = '{mohonPengesahan.tempatPengesahan}', Tkh_Mesy_LPU = '{tarikhMesyuarat}', Amaun = '{mohonPengesahan.amaunPengesahan}' WHERE No_Pinj = '{mohonPengesahan.nopinjamanPengesahan}';"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@confirmPengesahan", mohonPengesahan.confirmPengesahan))
        insertParam.Add(New SqlParameter("@tarikhPengesahan", mohonPengesahan.tarikhPengesahan))
        insertParam.Add(New SqlParameter("@skimPengesahan", mohonPengesahan.skimPengesahan))
        insertParam.Add(New SqlParameter("@amaunPengesahan", mohonPengesahan.amaunPengesahan))
        insertParam.Add(New SqlParameter("@tempatPengesahan", mohonPengesahan.tempatPengesahan))
        insertParam.Add(New SqlParameter("@tarikhmesyuaratPengesahan", tarikhMesyuarat))
        insertParam.Add(New SqlParameter("@filePengesahan", mohonPengesahan.filePengesahan))
        insertParam.Add(New SqlParameter("@tempohPengesahan", mohonPengesahan.tempohPengesahan))
        'insertParam.Add(New SqlParameter("@bilPengesahan", mohonPengesahan.bilPengesahan))
        insertParam.Add(New SqlParameter("@nopinjamanPengesahan", mohonPengesahan.nopinjamanPengesahan))

        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmd("No_Pinj", mohonPengesahan.nopinjamanPengesahan, insertQuery, insertParam)

        Return insertResult
    End Function

    Private Function InsertPengesahan2(mohonPengesahan As KelulusanInsertDetail) As String
        ' Insertion query
        Dim insertQuery As String = $"INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status, Ulasan, No_Dokumen) VALUES ('13', @confirmPengesahan, @nopinjamanPengesahan, '{Session("ssusrID")}', @tarikhPengesahan, @tarikhPengesahan, '1', '1', @setujuPengesahan, NULL)"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@setujuPengesahan", mohonPengesahan.setujuPengesahan))
        insertParam.Add(New SqlParameter("@confirmPengesahan", mohonPengesahan.confirmPengesahan))
        insertParam.Add(New SqlParameter("@tarikhPengesahan", mohonPengesahan.tarikhPengesahan))
        insertParam.Add(New SqlParameter("@nopinjamanPengesahan", mohonPengesahan.nopinjamanPengesahan))
        insertParam.Add(New SqlParameter("No_Staf", Session("ssusrID")))


        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmd("No_Rujukan", mohonPengesahan.nopinjamanPengesahan, insertQuery, insertParam)

        Return insertResult
    End Function

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

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Async Function notificationMyUtem(NoStafPeminjam As String) As Tasks.Task(Of String)
        Dim db As New DBKewConn

        Dim resp As New ResponseRepository
        Dim response = New Response
        'Notification API
        'API EndPoint URL
        Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Kelulusan bagi pembiayaan anda telah diperiksa. Penjamin telah membuat pengesahan./" + NoStafPeminjam

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
    '-------------------- REFERENCE btnSimpan YA END   ------------------
    '-------------------- REFERENCE btnSimpan TIDAK START   -------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan2(mohonPengesahan As KelulusanInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPengesahan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query

        If InsertPengesahan3(mohonPengesahan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertPengesahan4(mohonPengesahan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'queryRB.finish()

        If mohonPengesahan.confirmPengesahan.Equals("23") Then
            Try
                Dim data As New AP_Order()
                Dim dataDetails As New AP_Order_Dtl()
                Dim jumlah As Double? = Convert.ToDouble(mohonPengesahan.amaunPengesahan)
                data.Kod_Transaksi = "001" 'transaksi mohon
                data.ID_Rujukan = mohonPengesahan.nopinjamanPengesahan
                If jumlah IsNot Nothing Then
                    data.Jumlah_Keseluruhan = jumlah
                Else
                    data.Jumlah_Keseluruhan = 0
                End If
                data.Pengirim = "PINJ"
                data.Pengirim_Mohon = "TRANSAKSI" 'BUTIRAN VOT
                data.Jumlah_Item = "1"
                data.Status = "1"
                data.details = New List(Of AP_Order_Dtl)()
                dataDetails.No_Dokumen = mohonPengesahan.kodpemiutangPengesahan 'Kod_pemiutang
                dataDetails.Kod_Kump_Wang = mohonPengesahan.kumpulanwangPengesahan 'KW
                dataDetails.Kod_Operasi = mohonPengesahan.operasiPengesahan 'KO
                dataDetails.Kod_Ptj = mohonPengesahan.ptjPengesahan 'KPTJ
                dataDetails.Kod_Projek = mohonPengesahan.projekPengesahan 'KP
                dataDetails.Kod_Vot = mohonPengesahan.novotPengesahan 'VOT
                dataDetails.Jumlah = Convert.ToDouble(mohonPengesahan.amaunPengesahan)
                data.details.Add(dataDetails)

                'CALLING API
                If SMKB_API.MakeHttpPostRequestAP(Session("ssusrID"), data) Then
                    Console.WriteLine("Success")
                    queryRB.finish()
                    resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
                    Return JsonConvert.SerializeObject(resp.GetResult())
                Else
                    Console.WriteLine("Fail")
                    queryRB.rollback()
                    resp.Failed("Gagal Menyimpan order api")
                End If

            Catch ex As Exception
                queryRB.rollback()
                resp.Failed("Gagal Menyimpan order api")
            End Try
        Else
            queryRB.finish()
            resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
        End If

        If String.IsNullOrEmpty(mohonPengesahan.setujuPengesahan) Then
            resp.Failed("Gagal menghantar notifikasi")
        Else
            notificationMyUtem2(mohonPengesahan.setujuPengesahan)
        End If

        Dim ID_Token As String = Session("ID_Token")
        If String.IsNullOrEmpty(ID_Token) Then

        Else
            If UpdateEmelAuth2(ID_Token) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal Kemaskini ID Token")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPengesahan3(mohonPengesahan As KelulusanInsertDetail) As String
        ' Insertion query
        Dim tarikhMesyuarat As String

        If String.IsNullOrEmpty(mohonPengesahan.tarikhmesyuaratPengesahan) OrElse mohonPengesahan.tarikhmesyuaratPengesahan = "NaN-NaN-NaN NaN:NaN:NaN" Then
            tarikhMesyuarat = ""
        Else
            tarikhMesyuarat = mohonPengesahan.tarikhmesyuaratPengesahan
        End If

        Dim insertQuery As String = $"UPDATE SMKB_Pinjaman_Hdr SET Status_Dok = '{mohonPengesahan.confirmPengesahan}', Tkh_Lulus = '{mohonPengesahan.tarikhPengesahan}', Kod_Skim = '{mohonPengesahan.skimPengesahan}', Fail_Ruj = '{mohonPengesahan.filePengesahan}', Tempoh_Pinj = '{mohonPengesahan.tempohPengesahan}', Tmpt_Mesy_LPU = '{mohonPengesahan.tempatPengesahan}', Tkh_Mesy_LPU = '{tarikhMesyuarat}', Amaun = '{mohonPengesahan.amaunPengesahan}' WHERE No_Pinj = '{mohonPengesahan.nopinjamanPengesahan}';"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@confirmPengesahan", mohonPengesahan.confirmPengesahan))
        insertParam.Add(New SqlParameter("@tarikhPengesahan", mohonPengesahan.tarikhPengesahan))
        insertParam.Add(New SqlParameter("@skimPengesahan", mohonPengesahan.skimPengesahan))
        insertParam.Add(New SqlParameter("@amaunPengesahan", mohonPengesahan.amaunPengesahan))
        insertParam.Add(New SqlParameter("@tempatPengesahan", mohonPengesahan.tempatPengesahan))
        insertParam.Add(New SqlParameter("@tarikhmesyuaratPengesahan", tarikhMesyuarat))
        insertParam.Add(New SqlParameter("@filePengesahan", mohonPengesahan.filePengesahan))
        insertParam.Add(New SqlParameter("@tempohPengesahan", mohonPengesahan.tempohPengesahan))
        'insertParam.Add(New SqlParameter("@bilPengesahan", mohonPengesahan.bilPengesahan))
        insertParam.Add(New SqlParameter("@nopinjamanPengesahan", mohonPengesahan.nopinjamanPengesahan))

        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmd2("No_Pinj", mohonPengesahan.nopinjamanPengesahan, insertQuery, insertParam)

        Return insertResult
    End Function

    Private Function InsertPengesahan4(mohonPengesahan As KelulusanInsertDetail) As String
        ' Insertion query
        Dim insertQuery As String = $"INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status, Ulasan, No_Dokumen) VALUES ('13', @confirmPengesahan, @nopinjamanPengesahan, '{Session("ssusrID")}', @tarikhPengesahan, @tarikhPengesahan, '1', '1', @setujuPengesahan, NULL)"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@setujuPengesahan", mohonPengesahan.setujuPengesahan))
        insertParam.Add(New SqlParameter("@confirmPengesahan", mohonPengesahan.confirmPengesahan))
        insertParam.Add(New SqlParameter("@tarikhPengesahan", mohonPengesahan.tarikhPengesahan))
        insertParam.Add(New SqlParameter("@nopinjamanPengesahan", mohonPengesahan.nopinjamanPengesahan))
        insertParam.Add(New SqlParameter("No_Staf", Session("ssusrID")))


        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmd2("No_Rujukan", mohonPengesahan.nopinjamanPengesahan, insertQuery, insertParam)

        Return insertResult
    End Function

    Public Function RbQueryCmd2(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
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

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Async Function notificationMyUtem2(NoStafPeminjam As String) As Tasks.Task(Of String)
        Dim db As New DBKewConn

        Dim resp As New ResponseRepository
        Dim response = New Response
        'Notification API
        'API EndPoint URL
        Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Kelulusan bagi pembiayaan anda telah diperiksa. Penjamin telah membuat pengesahan./" + NoStafPeminjam

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

    Private Function UpdateEmelAuth2(IDToken As String) As String
        Dim db As New DBKewConn

        ' Insertion query
        Dim updQuery As String = "UPDATE SMKB_Emel_Auth SET Status_Tindakan = 'DONE' WHERE ID_Token = @ID_Token;"

        Dim updParam As New List(Of SqlParameter)
        updParam.Add(New SqlParameter("@ID_Token", IDToken))

        Dim updResult As String = RbQueryCmd("ID_Token", IDToken, updQuery, updParam)
        Return updResult
    End Function
    '-------------------- REFERENCE btnSimpan TIDAK END   ---------------
End Class
