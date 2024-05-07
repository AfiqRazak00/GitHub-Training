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
Imports System.Threading
Imports Microsoft.Ajax.Utilities
Imports AjaxControlToolkit
Imports System.Data.Entity.Core.Mapping

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Pinj_BayarBalik_WS
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    'senarai invois yg belum ada atau masih draf baucar
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function loadListPermohonanData(ByVal DateStart As String, ByVal DateEnd As String) As String
        'Dim userID As String = Session("ssusrID")
        Dim req As Response = getListPermohonan(DateStart, DateEnd)
        Return JsonConvert.SerializeObject(req)
    End Function

    Private Function getListPermohonan(DateStart As String, DateEnd As String) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                'Dim sqlText As String = "SELECT ROW_NUMBER() OVER (ORDER BY A.No_Pinj) AS Bil,
                '                        A.No_Pinj, A.No_Staf, B.MS01_Nama, A.Tkh_Mohon, FORMAT(CONVERT(datetime, A.Tkh_Mohon), 'dd/MM/yyyy') AS FormattedDate, A.Jenis_Pinj, 
                '                        (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' AND Kod_Detail = A.Jenis_Pinj) AS Jenis_Pinj_Desc, 
                '                        FORMAT(Amaun, 'N2') AS Amaun
                '                        FROM SMKB_Pinjaman_Hdr A
                '                        INNER JOIN {DBStaf}MS01_Peribadi B ON B.MS01_NoStaf = A.No_Staf
                '                        WHERE A.Status_Dok = '14'  
                '                        And A.Status = 'A' 
                '                        "
                Dim sqlText As String = "
                                        SELECT ROW_NUMBER() OVER (ORDER BY A.No_Pinj) AS Bil,
                                        A.No_Pinj, A.No_Staf, B.MS01_Nama, A.Tkh_Mohon, FORMAT(CONVERT(datetime, A.Tkh_Mohon), 'dd/MM/yyyy') AS FormattedDate, A.Jenis_Pinj, 
                                        (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' AND Kod_Detail = A.Jenis_Pinj) AS Jenis_Pinj_Desc, 
                                        FORMAT(Amaun, 'N2') AS Amaun
                                        FROM SMKB_Pinjaman_Hdr A
                                        INNER JOIN VPeribadi B ON B.MS01_NoStaf = A.No_Staf
                                        WHERE A.Status_Dok = '14'  
                                        And A.Status = 'A'"

                If DateStart IsNot Nothing And DateStart <> "" Then
                    sqlText += " AND A.Tkh_Mohon >= @DateStart "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateStart", DateStart))
                End If

                If DateEnd IsNot Nothing And DateEnd <> "" Then
                    sqlText += " AND A.Tkh_Mohon <= @DateEnd "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateEnd", DateEnd))
                End If

                sqlText += " ORDER BY A.Tkh_Mohon DESC;"

                'sqlcmd.Parameters.Add(New SqlParameter("@kodpejabat", kodpejabat))
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMaklumatPinjaman(ByVal No_Pinj As String) As String
        Dim pinj As Response = GetMaklumatPinjaman(No_Pinj)
        If pinj.Code <> "200" Then
            Return JsonConvert.SerializeObject(pinj)
        End If

        Dim data As New Dictionary(Of String, Object)()
        data.Add("hdr", pinj.Payload)

        Return JsonConvert.SerializeObject(pinj)
    End Function

    Private Function GetMaklumatPinjaman(No_Pinj As String) As Response
        Dim res As New Response
        res.Code = 200
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn
                'sqlcmd.CommandText = "SELECT A.No_Staf,B.MS01_Nama AS Nama,A.No_Pinj,A.No_Baucer,A.Tkh_Baucer,A.No_Cek, A.Tkh_Cek,
                '                    B.MS01_KpB AS nokp, B.MS01_TkhLahir, 
                '                    CONVERT(VARCHAR, DATEDIFF(YEAR, CONVERT(DATETIME, b.MS01_TkhLahir, 103), GETDATE())) + ' TAHUN DAN ' +
                '                    CONVERT(VARCHAR, DATEDIFF(MONTH, CONVERT(DATETIME, b.MS01_TkhLahir, 103), GETDATE()) % 12) + ' BULAN' AS AgeFormatted,
                '                    C.MS02_Taraf, (SELECT TarafKhidmat FROM {DBStaf}MS_TarafKhidmat WHERE KodTarafKhidmat = C.MS02_Taraf) AS Taraf,
                '                    C.MS02_Kumpulan, (SELECT Kumpulan FROM {DBStaf}MS_Kumpulan WHERE KodKumpulan = C.MS02_Kumpulan) AS Kumpulan,c.MS02_GredGajiS, 
                '                    C.MS02_JawSandang, (SELECT JawGiliran FROM {DBStaf}MS_Jawatan WHERE KodJawatan = C.MS02_JawSandang) AS Jawatan,FORMAT(c.MS02_JumlahGajiS, 'N2') AS MS02_JumlahGajiS,
                '                    D.MS08_Pejabat,(SELECT Pejabat FROM {DBStaf}MS_Pejabat WHERE KodPejabat = D.MS08_Pejabat) AS Pejabat,b.MS01_VoIP,
                '                    C.MS02_TkhLapor, C.MS02_TkhSah, E.No_Lesen, E.Kod_Kelas_Lesen, E.Tkh_Tmt_Lesen,FORMAT(CONVERT(datetime, E.Tkh_Tmt_Lesen), 'dd/MM/yyyy') AS Tkh_Tmt_Lesen_Formatted,
                '                    A.Kategori_Pinj,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15' AND Kod_Detail = A.Kategori_Pinj) AS Kat_Pinj_Desc,
                '                    A.Tkh_Mohon,FORMAT(CONVERT(datetime, A.Tkh_Mohon), 'dd/MM/yyyy') AS Tkh_Mohon_Formatted,A.Amaun_Mohon,FORMAT(A.Amaun_Mohon, 'N2') AS Amaun_Mohon_Formatted,
                '                    A.Jenis_Pinj,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' AND Kod_Detail = A.Jenis_Pinj) AS Jenis_Pinj_Desc,
                '                    A.Tkh_Lulus,FORMAT(CONVERT(datetime, A.Tkh_Lulus), 'dd/MM/yyyy') AS Tkh_Lulus_Formatted,Amaun,FORMAT(A.Amaun, 'N2') AS Amaun_Formatted,A.Tempoh_Pinj,
                '                    (SELECT Ansuran FROM SMKB_Pinjaman_Jadual WHERE Kategori_Pinj = A.Kategori_Pinj AND Tempoh = A.Tempoh_Pinj AND Amaun = A.Amaun_Mohon) AS Ansuran,
                '                    FORMAT((SELECT Ansuran FROM SMKB_Pinjaman_Jadual WHERE Kategori_Pinj = A.Kategori_Pinj AND Tempoh = A.Tempoh_Pinj AND Amaun = A.Amaun_Mohon),'N2') AS Ansuran_Formatted,
                '                    A.Status_Layak,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM25' AND Kod_Detail = A.Status_Layak) AS Status_Layak_Desc,E.Jwtn_Perlu_Kereta, E.Kend_Sediada,
                '                    E.Kod_Model,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM19' AND Kod_Detail = E.Kod_Model) AS Model,
                '                    E.Kod_Buatan,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM05' AND Kod_Detail = E.Kod_Buatan) AS Buatan,
                '                    FORMAT(E.Harga_Bersih, 'N2') AS Harga_Bersih,
                '                    E.Sukat_Silinder,E.No_Casis,E.No_Enjin,
                '                    (SELECT Faedah FROM SMKB_Pinjaman_Kawalan WHERE Kategori_Pinj = A.Kategori_Pinj AND Jenis_Pinj = A.Jenis_Pinj) AS faedahpercent,
                '                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM10' And Kod_Detail = F.Jenis_Pinj_Komputer) As jenispinjkomp,
                '                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM09') AND Kod_Detail = F.Jenama) AS jenamakomp,
                '                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM07' And Kod_Detail = F.Cakera_Keras) As kapasiticakera,
                '                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM08' And Kod_Detail = F.Ingatan) As ram,
                '                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM20' And Kod_Detail = F.Monitor) As jenamamonitor,
                '                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM21' And Kod_Detail = F.Nama_Pencetak) As jenamapencetak,
                '                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM27' And Kod_Detail = F.Papan_Kekunci) As papankekunci,
                '                    F.Modem As jenamamodem,
                '                    F.Kad_Bunyi As kadbunyi,
                '                    F.Pemacu_Cakera As pemacucakera,
                '                    F.Tetikus As tetikus,
                '                    FORMAT(F.Harga, 'N2') As hargakomp,
                '                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM13' And Kod_Detail = G.Jenis_Sukan) As jenispinjsukan,
                '                    FORMAT(G.Harga, 'N2') As hargasukan
                '                    FROM SMKB_Pinjaman_Hdr A
                '                    INNER JOIN {DBStaf}MS01_Peribadi B ON B.MS01_NoStaf = A.No_Staf
                '                    INNER JOIN {DBStaf}MS02_Perjawatan C ON C.MS01_NoStaf = A.No_Staf
                '                    INNER JOIN {DBStaf}MS08_Penempatan D ON D.MS01_NoStaf = A.No_Staf AND D.MS08_StaTerkini = 1
                '                    FULL OUTER JOIN SMKB_Pinjaman_Dtl_Kenderaan E ON A.No_Pinj = E.No_Pinj
                '                    FULL OUTER JOIN SMKB_Pinjaman_Dtl_Komputer F ON A.No_Pinj = F.No_Pinj
                '                    FULL OUTER JOIN SMKB_Pinjaman_Dtl_Sukan G ON A.No_Pinj = G.No_Pinj
                '                    WHERE A.No_Pinj = @No_Pinj
                '                    "

                sqlcmd.CommandText = $"SELECT A.No_Staf,B.MS01_Nama AS Nama,A.No_Pinj,A.No_Baucer,A.Tkh_Baucer,A.No_Cek, A.Tkh_Cek,
                                    B.MS01_KpB AS nokp, B.MS01_TkhLahir, 
                                    CONVERT(VARCHAR, DATEDIFF(YEAR, CONVERT(DATETIME, b.MS01_TkhLahir, 103), GETDATE())) + ' TAHUN DAN ' +
                                    CONVERT(VARCHAR, DATEDIFF(MONTH, CONVERT(DATETIME, b.MS01_TkhLahir, 103), GETDATE()) % 12) + ' BULAN' AS AgeFormatted,
                                    C.MS02_Taraf, (SELECT TarafKhidmat FROM {DBStaf}MS_TarafKhidmat WHERE KodTarafKhidmat = C.MS02_Taraf) AS Taraf,
                                    C.MS02_Kumpulan, (SELECT Kumpulan FROM {DBStaf}MS_Kumpulan WHERE KodKumpulan = C.MS02_Kumpulan) AS Kumpulan,c.MS02_GredGajiS, 
                                    C.MS02_JawSandang, (SELECT JawGiliran FROM {DBStaf}MS_Jawatan WHERE KodJawatan = C.MS02_JawSandang) AS Jawatan,FORMAT(c.MS02_JumlahGajiS, 'N2') AS MS02_JumlahGajiS,
                                    D.MS08_Pejabat,(SELECT Pejabat FROM {DBStaf}MS_Pejabat WHERE KodPejabat = D.MS08_Pejabat) AS Pejabat,b.MS01_VoIP,
                                    C.MS02_TkhLapor, C.MS02_TkhSah, E.No_Lesen, E.Kod_Kelas_Lesen, E.Tkh_Tmt_Lesen,FORMAT(CONVERT(datetime, E.Tkh_Tmt_Lesen), 'dd/MM/yyyy') AS Tkh_Tmt_Lesen_Formatted,
                                    A.Kategori_Pinj,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15' AND Kod_Detail = A.Kategori_Pinj) AS Kat_Pinj_Desc,
                                    A.Tkh_Mohon,FORMAT(CONVERT(datetime, A.Tkh_Mohon), 'dd/MM/yyyy') AS Tkh_Mohon_Formatted,A.Amaun_Mohon,FORMAT(A.Amaun_Mohon, 'N2') AS Amaun_Mohon_Formatted,
                                    A.Jenis_Pinj,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' AND Kod_Detail = A.Jenis_Pinj) AS Jenis_Pinj_Desc,
                                    A.Tkh_Lulus,FORMAT(CONVERT(datetime, A.Tkh_Lulus), 'dd/MM/yyyy') AS Tkh_Lulus_Formatted,Amaun,FORMAT(A.Amaun, 'N2') AS Amaun_Formatted,A.Tempoh_Pinj,
                                    (SELECT Ansuran FROM SMKB_Pinjaman_Jadual WHERE Kategori_Pinj = A.Kategori_Pinj AND Tempoh = A.Tempoh_Pinj AND Amaun = A.Amaun_Mohon) AS Ansuran,
                                    FORMAT((SELECT Ansuran FROM SMKB_Pinjaman_Jadual WHERE Kategori_Pinj = A.Kategori_Pinj AND Tempoh = A.Tempoh_Pinj AND Amaun = A.Amaun_Mohon),'N2') AS Ansuran_Formatted,
                                    A.Status_Layak,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM25' AND Kod_Detail = A.Status_Layak) AS Status_Layak_Desc,E.Jwtn_Perlu_Kereta, E.Kend_Sediada,
                                    E.Kod_Model,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM19' AND Kod_Detail = E.Kod_Model) AS Model,
                                    E.Kod_Buatan,(SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM05' AND Kod_Detail = E.Kod_Buatan) AS Buatan,
                                    FORMAT(E.Harga_Bersih, 'N2') AS Harga_Bersih,
                                    E.Sukat_Silinder,E.No_Casis,E.No_Enjin,
                                    (SELECT Faedah FROM SMKB_Pinjaman_Kawalan WHERE Kategori_Pinj = A.Kategori_Pinj AND Jenis_Pinj = A.Jenis_Pinj) AS faedahpercent,
                                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM10' And Kod_Detail = F.Jenis_Pinj_Komputer) As jenispinjkomp,
                                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod IN ('PJM09') AND Kod_Detail = F.Jenama) AS jenamakomp,
                                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM07' And Kod_Detail = F.Cakera_Keras) As kapasiticakera,
                                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM08' And Kod_Detail = F.Ingatan) As ram,
                                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM20' And Kod_Detail = F.Monitor) As jenamamonitor,
                                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM21' And Kod_Detail = F.Nama_Pencetak) As jenamapencetak,
                                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM27' And Kod_Detail = F.Papan_Kekunci) As papankekunci,
                                    F.Modem As jenamamodem,
                                    F.Kad_Bunyi As kadbunyi,
                                    F.Pemacu_Cakera As pemacucakera,
                                    F.Tetikus As tetikus,
                                    FORMAT(F.Harga, 'N2') As hargakomp,
                                    (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM13' And Kod_Detail = G.Jenis_Sukan) As jenispinjsukan,
                                    FORMAT(G.Harga, 'N2') As hargasukan
                                    FROM SMKB_Pinjaman_Hdr A
                                    INNER JOIN {DBStaf}MS01_Peribadi B ON B.MS01_NoStaf = A.No_Staf
                                    INNER JOIN {DBStaf}MS02_Perjawatan C ON C.MS01_NoStaf = A.No_Staf
                                    INNER JOIN {DBStaf}MS08_Penempatan D ON D.MS01_NoStaf = A.No_Staf AND D.MS08_StaTerkini = 1
                                    FULL OUTER JOIN SMKB_Pinjaman_Dtl_Kenderaan E ON A.No_Pinj = E.No_Pinj
                                    FULL OUTER JOIN SMKB_Pinjaman_Dtl_Komputer F ON A.No_Pinj = F.No_Pinj
                                    FULL OUTER JOIN SMKB_Pinjaman_Dtl_Sukan G ON A.No_Pinj = G.No_Pinj
                                    WHERE A.No_Pinj = @No_Pinj
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
    Public Function loadInfoPotonganGaji(ByVal no_staf As String) As String
        Dim req As Response = getInfoPotonganGaji(no_staf)
        Return JsonConvert.SerializeObject(req)
    End Function

    Private Function getInfoPotonganGaji(ByVal no_staf As String) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = "SELECT ROW_NUMBER() OVER (ORDER BY a.Kod_Trans) AS Bil,a.Amaun,FORMAT(a.Amaun, 'N2') AS AmaunFormatted,b.Butiran
                                        FROM SMKB_Gaji_Master a
	                                    INNER JOIN SMKB_Gaji_Kod_Trans b ON b.Kod_Trans = a.Kod_Trans
                                        WHERE a.No_Staf = @no_staff AND (a.Jenis_Trans = 'P' OR a.Kod_Trans IN ('KWSP','SOCP','TAX'))
                                        AND a.Tkh_Tamat > CURRENT_TIMESTAMP AND a.Status = 'A'"
                sqlcmd.Parameters.Add(New SqlParameter("@no_staff", no_staf))
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function loadSummaryPotonganGaji(ByVal no_staf As String) As String
        Dim req As Response = getSummaryPotonganGaji(no_staf)
        Return JsonConvert.SerializeObject(req)
    End Function

    Private Function getSummaryPotonganGaji(ByVal no_staf As String) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = "SELECT 
                                            FORMAT(SUM(CASE WHEN Jenis_Trans = 'E' THEN Amaun ELSE 0 END),'N2') AS totelaun,
                                            FORMAT(SUM(CASE WHEN (Jenis_Trans = 'P' OR Kod_Trans IN ('KWSP','SOCP','TAX')) THEN Amaun ELSE 0 END),'N2') AS totpotongan,
                                            FORMAT(SUM(CASE WHEN Kod_Trans = 'GAJI' THEN Amaun ELSE 0 END),'N2') AS gaji,
                                            FORMAT(SUM(CASE WHEN Kod_Trans = 'GAJI' THEN Amaun ELSE 0 END) + 
                                            SUM(CASE WHEN Jenis_Trans = 'E'  THEN Amaun ELSE 0 END),'N2') AS gajipluselaun,
	                                        FORMAT((SUM(CASE WHEN (Jenis_Trans = 'P' OR Kod_Trans IN ('KWSP','SOCP','TAX')) THEN Amaun ELSE 0 END) / (SUM(CASE WHEN Kod_Trans = 'GAJI' THEN Amaun ELSE 0 END) + 
                                            SUM(CASE WHEN Jenis_Trans = 'E'  THEN Amaun ELSE 0 END)) * 100),'N2') AS potonganpercent
                                        FROM 
                                            SMKB_Gaji_Master
                                        WHERE 
                                            No_Staf = @no_staff AND Status = 'A' AND Tkh_Tamat > CURRENT_TIMESTAMP"
                sqlcmd.Parameters.Add(New SqlParameter("@no_staff", no_staf))
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function loadInfoPenjamin(ByVal No_Pinj As String) As String
        Dim req As Response = getInfoPenjamin(No_Pinj)
        Return JsonConvert.SerializeObject(req)
    End Function

    Private Function getInfoPenjamin(ByVal No_Pinj As String) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                'Dim sqlText As String = "SELECT a.Bil, a.No_Staf, b.MS01_Nama, c.MS08_Pejabat, (SELECT Pejabat FROM {DBStaf}MS_Pejabat WHERE KodPejabat = c.MS08_Pejabat) AS Pejabat,
                '                        CASE WHEN a.Setuju = '1' THEN 'SETUJU'
                '                          WHEN a.Setuju = '0' THEN 'TIDAK SETUJU'
                '                          ELSE 'TIADA PENGESAHAN' END AS pengesahan
                '                        FROM SMKB_Pinjaman_Penjamin a
                '                        INNER JOIN {DBStaf}MS01_Peribadi b ON b.MS01_NoStaf = a.No_Staf
                '                        INNER JOIN {DBStaf}MS08_Penempatan c ON c.MS01_NoStaf = a.No_Staf AND c.MS08_StaTerkini = '1'
                '                        WHERE No_Pinj = @no_pinj
                '                        ORDER BY a.Bil"

                Dim sqlText As String = "SELECT a.Bil, a.No_Staf, b.MS01_Nama, b.Pejabat AS Pejabat,
                                        CASE WHEN a.Setuju = '1' THEN 'SETUJU'
	                                            WHEN a.Setuju = '0' THEN 'TIDAK SETUJU'
	                                            ELSE 'TIADA PENGESAHAN' END AS pengesahan
                                        FROM SMKB_Pinjaman_Penjamin a
                                        INNER JOIN VPeribadi b ON b.MS01_NoStaf = a.No_Staf
                                        WHERE No_Pinj = @no_pinj
                                        ORDER BY a.Bil
                                        "
                sqlcmd.Parameters.Add(New SqlParameter("@no_pinj", No_Pinj))
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMaklumatPenjamin(ByVal No_Staf As String) As String
        Dim resp As New ResponseRepository

        Dim tmpDT As DataTable = GetMaklumatPenjamin(No_Staf)
        resp.SuccessPayload(tmpDT)
        Return JsonConvert.SerializeObject(resp.GetResult())
        'Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetMaklumatPenjamin(No_Staf As String) As DataTable
        Dim db = New DBSMConn

        Dim query As String = "SELECT a.MS01_NoStaf, a.MS01_Nama, a.MS01_TkhLahir, b.MS02_TkhSah, 
                                b.MS02_Taraf, (SELECT TarafKhidmat FROM MS_TarafKhidmat WHERE KodTarafKhidmat = b.MS02_Taraf) AS tarafkhidmat,
                                b.MS02_Kumpulan, (SELECT Kumpulan FROM MS_Kumpulan WHERE KodKumpulan = b.MS02_Kumpulan) AS kumpulan,
                                b.MS02_JawSandang, (SELECT JawGiliran FROM MS_Jawatan WHERE KodJawatan = b.MS02_JawSandang) AS jawatan,
                                c.MS08_Pejabat, (SELECT Pejabat FROM MS_Pejabat WHERE KodPejabat = c.MS08_Pejabat) AS pejabat, '-' AS butiranhutang 
                                FROM MS01_Peribadi a
                                INNER JOIN MS02_Perjawatan b ON b.MS01_NoStaf = a.MS01_NoStaf
                                INNER JOIN MS08_Penempatan c ON c.MS01_NoStaf = a.MS01_NoStaf AND MS08_StaTerkini = '1'
                                WHERE a.MS01_NoStaf = @No_Staf
                                "
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Staf", No_Staf))
        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function saveProsesBayarBalik(pinjaman As PinjamanJadualBayarBalik, startingMonth As Integer, startingYear As Integer) As String
        Dim response As New Response
        response.Code = 200
        response.Message = "Proses Bayar Balik berjaya"

        Dim userID As String = HttpContext.Current.Session("ssusrID")
        Dim query As New Query
        Dim multikey As New Dictionary(Of String, String)

        pinjaman.Status_Dok = "08"

        Dim tempoh As Integer = pinjaman.Tempoh_Pinj
        Dim amaun As Decimal = pinjaman.Amaun
        pinjaman.Baki_Pokok = pinjaman.Amaun
        Dim ansuran As Decimal = pinjaman.Ansuran
        Dim faedah As Decimal = 0
        Dim baki_pokok As Decimal = pinjaman.Amaun
        Dim nextDate As DateTime = New DateTime(startingYear, startingMonth, 1)
        Dim stDate As DateTime = nextDate
        Dim edDate As DateTime
        Dim laststDate As DateTime
        Dim lastedDate As DateTime

        'check jika gaji dah proses untuk bulan potongan yang dipilih 
        Dim kod_param As String = startingYear.ToString() + startingMonth.ToString("00")
        If Not String.IsNullOrEmpty(kod_param) Then
            If (checkProsesGaji(kod_param)) Then
                response.Code = 500
                response.Message = "Gaji telah proses untuk bulan tersebut. Mohon pilih bulan berikutnya."
                Return JsonConvert.SerializeObject(response)
            End If
        End If


        'generate jadual bayar balik
        For i As Integer = 1 To tempoh
            Dim nextMonth As Integer = nextDate.Month
            Dim nextYear As Integer = nextDate.Year
            pinjaman.Bln_GJ = nextYear.ToString() & nextMonth.ToString("00")
            pinjaman.Bulan_Byrn = nextMonth.ToString("00")
            pinjaman.Tahun_Byrn = nextYear.ToString()

            If (i.Equals(tempoh)) Then
                'last payment
                'ld_ansuran = ld_amaun_pinj + ld_faedah
                faedah = (pinjaman.Baki_Pokok * pinjaman.faedahpercent) / 12
                pinjaman.Faedah = faedah / 100
                pinjaman.Ansuran = pinjaman.Baki_Pokok + pinjaman.Faedah
                pinjaman.Pokok = pinjaman.Ansuran - pinjaman.Faedah
                pinjaman.Baki_Pokok = pinjaman.Baki_Pokok - pinjaman.Pokok

                laststDate = nextDate
                lastedDate = nextDate.AddMonths(1).AddDays(-1)
            Else
                faedah = (pinjaman.Baki_Pokok * pinjaman.faedahpercent) / 12
                pinjaman.Faedah = faedah / 100
                pinjaman.Pokok = ansuran - pinjaman.Faedah
                pinjaman.Baki_Pokok = pinjaman.Baki_Pokok - pinjaman.Pokok

                edDate = nextDate.AddMonths(1).AddDays(-1)
            End If

            multikey.Clear()
            multikey.Add("No_Pinj", pinjaman.No_Pinj)
            multikey.Add("Bil_Byr", i)

            If query.execute(multikey, pinjaman.insertCommand(i)) < 0 Then
                response.Message = "Jadual bayar balik gagal di simpan"
                response.Code = 500
                query.rollback()
                Return JsonConvert.SerializeObject(response)
            End If
            nextDate = New DateTime(startingYear, startingMonth, 1).AddMonths(i)
        Next

        'insert SMKB_Gaji_Master
        Dim Kod_Trans As String
        If pinjaman.Kategori_Pinj.Equals("K00001") Then
            Kod_Trans = "PK01"
        ElseIf pinjaman.Kategori_Pinj.Equals("K00002") Then
            Kod_Trans = "PO01"
        Else
            Kod_Trans = "PR01"
        End If
        multikey.Clear()
        multikey.Add("No_Staf", pinjaman.No_Staf)
        multikey.Add("Kod_Sumber", "PNJM")
        multikey.Add("Catatan", pinjaman.No_Pinj)
        multikey.Add("No_Trans", (tempoh - 1))
        If query.execute(multikey, insertGajiMaster(pinjaman.No_Staf, Kod_Trans, ansuran, stDate, edDate, pinjaman.No_Pinj, (tempoh - 1))) < 0 Then
            response.Message = "Gaji Master gagal di simpan"
            response.Code = 500
            query.rollback()
            Return JsonConvert.SerializeObject(response)
        End If

        'insert SMKB_Gaji_Master last payment
        multikey.Clear()
        multikey.Add("No_Staf", pinjaman.No_Staf)
        multikey.Add("Kod_Sumber", "PNJM")
        multikey.Add("Catatan", pinjaman.No_Pinj)
        multikey.Add("No_Trans", tempoh)
        If query.execute(multikey, insertGajiMaster(pinjaman.No_Staf, Kod_Trans, pinjaman.Ansuran, laststDate, lastedDate, pinjaman.No_Pinj, tempoh)) < 0 Then
            response.Message = "Gaji Master gagal di simpan"
            response.Code = 500
            query.rollback()
            Return JsonConvert.SerializeObject(response)
        End If

        'update SMKB_Pinjaman_Hdr
        If query.execute(pinjaman.No_Pinj, "No_Pinj", updatePinjamanHdr(pinjaman.No_Pinj)) < 0 Then
            response.Code = 500
            response.Message = "Maklumat pinjaman header gagal di simpan"
            query.rollback()
            Return JsonConvert.SerializeObject(response)
        End If

        'insert SMKB_Status_Dok
        multikey.Clear()
        multikey.Add("No_Rujukan", pinjaman.No_Pinj)
        multikey.Add("Kod_Status_Dok", pinjaman.Status_Dok)
        If query.execute(multikey, logInvoisDok(pinjaman.No_Pinj, userID, pinjaman.Status_Dok)) > 0 Then
            query.finish()
        Else
            response.Code = 500
            response.Message = "Maklumat status dok gagal di simpan"
            query.rollback()
            Return JsonConvert.SerializeObject(response)
        End If

        Return JsonConvert.SerializeObject(response)
    End Function
    Private Function checkProsesGaji(st_yearmonth) As String
        Dim db As New DBKewConn
        Dim dbsm As New DBSMConn
        Dim dtbl As DataTable

        'kak chen tukar table on 19/04/2024
        'Dim query As String = "SELECT * FROM SMKB_Gaji_Param WHERE status = '04' AND Kod_Param = @Kod_Param"  

        Dim query As String = "SELECT * FROM SMKB_Gaji_Status_Dok WHERE Status_Dok = '04' AND Kod_Param = @Kod_Param"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod_Param", st_yearmonth))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Function updatePinjamanHdr(No_Pinj As String) As SqlCommand
        If No_Pinj Is Nothing Then
            Throw New Exception("No Pinjaman tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "UPDATE SMKB_Pinjaman_Hdr SET Status_Dok = @Status_Dok "

        cmd.CommandText = sql + " WHERE No_Pinj = @No_Pinj"
        cmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
        cmd.Parameters.Add(New SqlParameter("@Status_Dok", "08"))

        Return cmd
    End Function

    Private Function logInvoisDok(No_Rujukan As String, userID As String, Status_Dok As String) As SqlCommand
        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Status_Dok (Kod_Modul,Kod_Status_Dok,No_Rujukan,No_Staf,Tkh_Tindakan,Tkh_Transaksi,Status_Transaksi,Status,Ulasan)
                VALUES (@Kod_Modul,@Kod_Status_Dok,@No_Rujukan,@No_Staf,getdate(),getdate(),@Status_Transaksi,@Status,@Ulasan)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@Kod_Modul", "13"))
        'cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", "03uyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyttttttt"))
        cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Status_Dok))
        cmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        cmd.Parameters.Add(New SqlParameter("@No_Staf", userID))
        cmd.Parameters.Add(New SqlParameter("@Status_Transaksi", "1"))
        cmd.Parameters.Add(New SqlParameter("@Status", "1"))
        cmd.Parameters.Add(New SqlParameter("@Ulasan", "-"))

        Return cmd
    End Function

    Private Function insertGajiMaster(No_Staf As String, Kod_Trans As String, Amaun As Decimal, Tkh_Mula As DateTime, Tkh_Tamat As DateTime, No_Pinj As String, Bil As Integer) As SqlCommand
        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Gaji_Master (No_Staf,Kod_Sumber,Jenis_Trans,Kod_Trans,Amaun,Tkh_Mula,Tkh_Tamat,Status,Bayar_Drpd,Catatan,No_Trans)
                VALUES (@No_Staf,@Kod_Sumber,@Jenis_Trans,@Kod_Trans,@Amaun,@Tkh_Mula,@Tkh_Tamat,@Status,@Bayar_Drpd,@Catatan,@No_Trans)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@No_Staf", No_Staf))
        cmd.Parameters.Add(New SqlParameter("@Kod_Sumber", "PNJM"))
        cmd.Parameters.Add(New SqlParameter("@Jenis_Trans", "P"))
        cmd.Parameters.Add(New SqlParameter("@Kod_Trans", Kod_Trans))
        cmd.Parameters.Add(New SqlParameter("@Amaun", Amaun))
        cmd.Parameters.Add(New SqlParameter("@Tkh_Mula", Tkh_Mula))
        cmd.Parameters.Add(New SqlParameter("@Tkh_Tamat", Tkh_Tamat))
        cmd.Parameters.Add(New SqlParameter("@Status", "A"))
        cmd.Parameters.Add(New SqlParameter("@Bayar_Drpd", "P"))
        cmd.Parameters.Add(New SqlParameter("@Catatan", No_Pinj))
        cmd.Parameters.Add(New SqlParameter("@No_Trans", Bil))

        Return cmd
    End Function

End Class

<Serializable>
Public Class PinjamanJadualBayarBalik
    Public Property No_Pinj As String
    Public Property Bil_Byr As Integer
    Public Property Pokok As Decimal
    Public Property Faedah As Decimal
    Public Property Ansuran As Decimal
    Public Property Baki_Pokok As Decimal
    Public Property Status_Byrn As String
    Public Property Bln_GJ As String
    Public Property Status_GJ As String
    Public Property Status As String
    Public Property Bulan_Byrn As String
    Public Property Tahun_Byrn As String
    Public Property Amaun As Decimal
    Public Property Tempoh_Pinj As String
    Public Property faedahpercent As Decimal
    Public Property Status_Dok As String
    Public Property No_Staf As String
    Public Property Kategori_Pinj As String
    'Public Property details As List(Of SokonganPinjamanHdr)

    Public Function insertCommand(Bil As Integer) As SqlCommand
        If No_Pinj Is Nothing Then
            Throw New Exception("No Pinjaman tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Pinjaman_Jadual_Bayar_Balik (No_Pinj,Bil_Byr,Pokok,Faedah,Ansuran,Baki_Pokok,Status_Byrn,Bln_GJ,Status_GJ,Status,Bulan_Byrn,Tahun_Byrn)
                VALUES (@No_Pinj,@Bil_Byr,@Pokok,@Faedah,@Ansuran,@Baki_Pokok,@Status_Byrn,@Bln_GJ,@Status_GJ,@Status,@Bulan_Byrn,@Tahun_Byrn)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
        cmd.Parameters.Add(New SqlParameter("@Bil_Byr", Bil))
        cmd.Parameters.Add(New SqlParameter("@Pokok", Pokok))
        cmd.Parameters.Add(New SqlParameter("@Faedah", Faedah))
        cmd.Parameters.Add(New SqlParameter("@Ansuran", Ansuran))
        cmd.Parameters.Add(New SqlParameter("@Baki_Pokok", Baki_Pokok))
        cmd.Parameters.Add(New SqlParameter("@Status_Byrn", "A"))
        cmd.Parameters.Add(New SqlParameter("@Bln_GJ", Bln_GJ))
        cmd.Parameters.Add(New SqlParameter("@Status_GJ", "N"))
        cmd.Parameters.Add(New SqlParameter("@Status", "1"))
        cmd.Parameters.Add(New SqlParameter("@Bulan_Byrn", Bulan_Byrn))
        cmd.Parameters.Add(New SqlParameter("@Tahun_Byrn", Tahun_Byrn))

        Return cmd
    End Function
End Class