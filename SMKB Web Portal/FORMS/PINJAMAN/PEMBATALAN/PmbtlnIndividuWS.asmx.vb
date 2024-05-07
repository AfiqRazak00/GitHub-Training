Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports Org.BouncyCastle.Ocsp
Imports SMKB_Web_Portal.ModMain
Imports Org.BouncyCastle.Utilities
Imports Microsoft.Build.Framework.XamlTypes
Imports System.IO
Imports Newtonsoft
Imports Microsoft.Reporting.Chart.WebForms
Imports Microsoft.Reporting.WebForms
Imports Newtonsoft.Json.Linq
Imports System.Data.Entity.Core
Imports System.Collections.Generic
Imports System

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PmbtlnIndividuWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim queryRB As New Query()

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FetchSenarai(postData As String) As String
        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim req As Response = GetSenaraiData(postDt)
        Return JsonConvert.SerializeObject(req)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSenaraiData(postDt) As Response
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)
        Dim db = New DBKewConn
        Dim dt As New DataTable
        Dim res As New Response
        Dim category_filter As String = postDt("category_filter")
        Dim tkhMula As String = postDt("tkhMula")
        Dim tkhTamat As String = postDt("tkhTamat")

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tkh_Mohon >= @tkhMula AND Tkh_Mohon <= @tkhTamat "
        End If

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@TkhTamat", tkhTamat))

        res.Code = 200
        Try
            Dim sqlText As String = $"SELECT ROW_NUMBER() OVER (ORDER BY Tkh_Mohon Desc) AS RowNum, 
                                        No_Pinj As NoPinj,
                                        FORMAT(Tkh_Mohon, 'dd/MM/yyyy') as TkhMohon,
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15' And Kod_Detail = Kategori_Pinj) As TxtKatPinj, 
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM24' And Kod_Detail = Status_Dok) As StatusDok,
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM23' And Kod_Detail = SMKB_Pinjaman_Hdr.Status) As StatusPinj
                                        From SMKB_Pinjaman_Hdr Where Status_Dok In ('01','28') And Status = 'A' And  No_Staf = '{Session("ssusrID")}'
                                        " & tarikhQuery & "Order By Tkh_Mohon Desc"

            res.Payload = db.Read(sqlText, param)
        Catch ex As Exception
            Dim strex As String = ex.Message
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function GetSelectedPermohonan(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        Dim NoPinj As String = postDt("TargetId")
        Dim query As String = $"SELECT DISTINCT
                            A.No_Pinj AS NoPinjaman,
                            A.No_Staf AS NoStaf,
                            C.MS01_KpB AS KadPengenalan,
                            FORMAT(CONVERT(DATETIME, C.MS01_TkhLahir, 103), 'dd/MM/yyyy') AS TarikhLahir,
                            A.Tempoh_Pinj AS TempohPinjaman,
                            CONCAT(A.Tempoh_Pinj, ' bulan') AS TempohPinjaman2,
                            C.MS01_Nama AS NamaPeminjam,
                            CASE 
                            WHEN CHARINDEX('BIN ', C.MS01_Nama) > 0 THEN SUBSTRING(C.MS01_Nama, 1, CHARINDEX('BIN ', C.MS01_Nama) - 1)
                            WHEN CHARINDEX('BINTI ', C.MS01_Nama) > 0 THEN SUBSTRING(C.MS01_Nama, 1, CHARINDEX('BINTI ', C.MS01_Nama) - 1)
                            WHEN CHARINDEX('A/L ', C.MS01_Nama) > 0 THEN SUBSTRING(C.MS01_Nama, 1, CHARINDEX('A/L ', C.MS01_Nama) - 1)
                            WHEN CHARINDEX('A/P ', C.MS01_Nama) > 0 THEN SUBSTRING(C.MS01_Nama, 1, CHARINDEX('A/P ', C.MS01_Nama) - 1)
                            ELSE C.MS01_Nama
                            END AS NamaPeminjam2,
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
                            B.MS02_GredGajiS AS GredGaji,
                            FORMAT(B.MS02_JumlahGajiS, 'N2') AS GajiPokok,
                            J.Kumpulan AS Kumpulan,
                            B.MS02_TkhSah AS TarikhSah,
                            G.JGiliran AS Jawatan,
                            G.NPejabat AS Jabatan,
                            B.MS02_TkhSah AS TarikhSah,
                            G.TelPej AS SambunganTelifon,
                            F.TarafKhidmat AS TarafKhidmat,
                            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM05') AND Kod_Detail = H.Kod_Buatan) AS BuatanKenderaan,
                            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM19') AND Kod_Detail = H.Kod_Model) AS ModelKenderaan,
                            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM01') AND Kod_Detail = A.Jenis_Pinj) AS JenisPinjaman2,
                            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM25') AND Kod_Detail = A.Status_Layak) AS Kelayakan,
                            H.Sukat_Silinder AS SukatanSilinder,
                            H.No_Casis AS NoCasis,
                            H.No_Enjin AS NoEnjin,
                            FORMAT(H.Harga_Bersih, 'N2') AS HargaBersih,
                            FORMAT(G.MS02_TkhLapor, 'dd/MM/yyyy') AS TarikhLantikan,
                            CONCAT(
                            DATEDIFF(YEAR, CONVERT(DATETIME, C.MS01_TkhLahir, 103), A.Tkh_Mohon), ' Tahun ',
                            DATEDIFF(MONTH, CONVERT(DATETIME, C.MS01_TkhLahir, 103), A.Tkh_Mohon) % 12, ' Bulan'
                            ) AS Umur,
                            I.Ansuran AS Ansuran,
                            (SELECT Butiran FROM SMKB_Lookup_Detail D WHERE D.Kod IN ('PJM15') AND D.Kod_Detail = A.Kategori_Pinj) AS KategoriPinjaman,
                            CASE
                            WHEN (SELECT Butiran FROM SMKB_Lookup_Detail D WHERE D.Kod IN ('PJM15') AND D.Kod_Detail = A.Kategori_Pinj) = 'KENDERAAN' THEN '71301'
                            WHEN (SELECT Butiran FROM SMKB_Lookup_Detail D WHERE D.Kod IN ('PJM15') AND D.Kod_Detail = A.Kategori_Pinj) = 'KOMPUTER' THEN '71401'
                            WHEN (SELECT Butiran FROM SMKB_Lookup_Detail D WHERE D.Kod IN ('PJM15') AND D.Kod_Detail = A.Kategori_Pinj) = 'SUKAN' THEN '71801'
                            ELSE NULL
                            END AS VOT,
                            A.Tkh_Mohon AS TkhMohon
                            FROM SMKB_Pinjaman_Hdr A 
                            INNER JOIN {DBStaf}MS01_Peribadi C ON A.No_Staf = C.MS01_NoStaf
                            INNER JOIN {DBStaf}MS02_Perjawatan B ON B.MS01_NoStaf = A.No_Staf
                            --INNER JOIN SMKB_Pinjaman_Ulasan_backup E ON E.Kat_Pinj = A.Kategori_Pinj
                            INNER JOIN {DBStaf}MS_TarafKhidmat F ON F.KodTarafKhidmat = B.MS02_Taraf
                            INNER JOIN {DBStaf}vPeribadi12 G ON A.No_Staf = G.NoStaf
                            FULL OUTER JOIN SMKB_Pinjaman_Dtl_Kenderaan H ON H.No_Pinj = A.No_Pinj
                            FULL OUTER JOIN SMKB_Pinjaman_Jadual I ON (I.Kategori_Pinj = A.Kategori_Pinj And I.Tempoh = A.Tempoh_Pinj And I.Amaun = A.Amaun_Mohon)
                            INNER JOIN {DBStaf}MS_Kumpulan J ON J.KodKumpulan = B.MS02_Kumpulan
                            WHERE A.No_Pinj = '{NoPinj}'"

        dtbl = db.Read(query)

        If dtbl.Rows.Count > 0 Then
            resp.Success("Rekod ditemui", "00", dtbl)
        Else
            resp.Failed("Tiada rekod ditemui")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_SecondTableData(postData As String) As String
        ' Deserialize JSON data
        Dim resp As New ResponseRepository
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim noStaf As String = Session("ssusrID")
        Dim tmpDT As DataTable = Get_KodSecondTableData(noStaf)
        resp.Success("Senarai data", "00", tmpDT)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Public Function Get_KodSecondTableData(noStaf As String) As DataTable
        ' Your query logic for the second table based on noStaf
        Dim query As String = $"SELECT 
                                DISTINCT ROW_NUMBER() OVER (ORDER BY b.Butiran Asc) AS RowNum, 
                                b.Butiran AS Butiran,
                                FORMAT(a.Amaun , 'N2', 'en-us') AS Amaun,
                               FORMAT(((
                                    SELECT SUM(Amaun)
                                    FROM SMKB_Gaji_Master 
                                    WHERE No_Staf = '{noStaf}'
                                    AND (Jenis_Trans = 'P' OR Kod_Trans IN ('KWSP', 'SOCP', 'TAX')) 
                                    AND Tkh_Tamat > CURRENT_TIMESTAMP
                                    AND Status = 'A'
                                ) * 100) / (d.MS02_JumlahGajiS + (
                                    SELECT SUM(c.Amaun) 
                                    FROM SMKB_Gaji_Master c 
                                    WHERE c.Jenis_Trans = 'E' 
                                    AND c.Status = 'A' 
                                    AND c.Tkh_Tamat > CURRENT_TIMESTAMP 
                                    AND c.No_Staf = a.No_Staf)), 'N2', 'en-us') AS PeratusPotongan,
                                FORMAT((d.MS02_JumlahGajiS + (
                                    SELECT SUM(c.Amaun) 
                                    FROM SMKB_Gaji_Master c 
                                    WHERE c.Jenis_Trans = 'E' 
                                    AND c.Status = 'A' 
                                    AND c.Tkh_Tamat > CURRENT_TIMESTAMP 
                                    AND c.No_Staf = a.No_Staf)), 'N2', 'en-us') AS GajiPlusElaun,
                                FORMAT((
                                    SELECT SUM(Amaun)
                                    FROM SMKB_Gaji_Master 
                                    WHERE No_Staf = '{noStaf}'
                                    AND (Jenis_Trans = 'P' OR Kod_Trans IN ('KWSP', 'SOCP', 'TAX')) 
                                    AND Tkh_Tamat > CURRENT_TIMESTAMP
                                    AND Status = 'A'
                                ), 'N2', 'en-us') AS TotalAmaun
                            FROM 
                                SMKB_Gaji_Master a
                            INNER JOIN 
                                SMKB_Gaji_Kod_Trans b ON a.Kod_Trans = b.Kod_Trans
                            INNER JOIN
                                {DBStaf}vPeribadi12 d ON d.NoStaf = a.No_Staf
                            WHERE 
                                a.No_Staf = '{noStaf}' 
                                AND (a.Jenis_Trans = 'P' OR a.Kod_Trans IN ('KWSP', 'SOCP', 'TAX')) 
                                AND a.Tkh_Tamat > CURRENT_TIMESTAMP
                                AND a.Status = 'A' 
                            ORDER BY 
                                b.Butiran Asc"

        Dim param As New List(Of SqlParameter) From {New SqlParameter("@NoStaf", noStaf)}

        Dim db = New DBKewConn
        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetInfoSpecs(postData As String) As String
        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim resp As New ResponseRepository
        Dim tmpDT As DataTable = GetInfoSpecsData(postDt)
        resp.Success("Senarai data", "00", tmpDT)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Public Function GetInfoSpecsData(postDt) As DataTable
        Dim db = New DBKewConn
        Dim query As String = ""
        Dim param = New List(Of SqlParameter)

        If postDt("KatPinj") = "K00002" Then
            query = $"Select 
                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM10' And Kod_Detail = Jenis_Pinj_Komputer) As jenispinjkomp,
                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM09') AND Kod_Detail = Jenama) AS jenamakomp,
                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM07' And Kod_Detail = Cakera_Keras) As kapasiticakera,
                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM08' And Kod_Detail = Ingatan) As ram,
                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM20' And Kod_Detail = Monitor) As jenamamonitor,
                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM21' And Kod_Detail = Nama_Pencetak) As jenamapencetak,
                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM27' And Kod_Detail = Papan_Kekunci) As papankekunci,
                    Modem As jenamamodem,
                    Pemacu_Cakera As pemacucakera,
                    Tetikus As tetikus,
                    FORMAT(Harga, 'N2', 'en-us') As hargakomp
                    From SMKB_Pinjaman_Dtl_Komputer Where No_Pinj = @nopinj"

        ElseIf postDt("KatPinj") = "K00003" Then

            query = $"Select 
                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM13' And Kod_Detail = Jenis_Sukan) As jenispinjsukan,
                    FORMAT(Harga, 'N2', 'en-us') As hargasukan
                    From SMKB_Pinjaman_Dtl_Sukan Where No_Pinj = @nopinj"
        End If

        param.Add(New SqlParameter("@nopinj", postDt("NoPinj")))
        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function BatalPermohonan(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim resp As New ResponseRepository

        queryRB = New Query()
        Dim query As String = $"UPDATE SMKB_Pinjaman_Hdr
                                Set Status = 'B', Status_Dok = '21'
                                Where No_Pinj = '{postDt("NoPinj")}'"

        Dim query2 As String = $"INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status) 
                                VALUES ('13', '21', '{postDt("NoPinj")}', '{Session("ssusrID")}', @Tkh_Tindakan, @Tkh_Transaksi, '1', '1')"

        ' Update SMKB_Pinjaman_Hdr
        If RbQueryCmd("No_Pinj", postDt("NoPinj"), query, param) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal membatalkan permohonan")
        End If

        param.Add(New SqlParameter("@Tkh_Tindakan", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))

        ' Update SMKB_Status_Dok
        If RbQueryCmd("No_Rujukan", postDt("NoPinj"), query2, param) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Berlaku ralat, pembatalan tidak berjaya")
        End If

        queryRB.finish()
        resp.Success("Permohonan telah dibatalkan", "00")

        Return JsonConvert.SerializeObject(resp.GetResult())
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