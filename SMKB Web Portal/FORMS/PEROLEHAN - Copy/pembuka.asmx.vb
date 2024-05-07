Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.EnterpriseServices
Imports System.IO
Imports iTextSharp.text.log
Imports System.Collections.Generic

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class pembuka1
    Inherits System.Web.Services.WebService

    'Dim sqlcmd As SqlCommand
    'Dim sqlcon As SqlConnection
    'Dim sqlread As SqlDataReader
    Dim dt As DataTable

    '===============================================================================================================================================================================
    'webservice (PEMBUKA)
    '===============================================================================================================================================================================


    '<WebMethod()> _
    'Public Function HelloWorld() As String
    '    Return "Hello World"
    'End Function


    ' Fateen Code Start

    'Load DataTable PenilaianHarga
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMesyPH(category_filter As String, isClicked8 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked8 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetRecordLoadMesyPH(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadMesyPH(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Daftar >= DATEADD(month, -1, getdate()) and a.Tarikh_Daftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Daftar >= DATEADD(month, -2, getdate()) and a.Tarikh_Daftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Daftar >= @tkhMula and a.Tarikh_Daftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "SELECT a.Tarikh_Daftar, a.No_Sebut_Harga, c.Tujuan, a.No_Mohon
                                FROM SMKB_Perolehan_Naskah_Jualan a
                                --join SMKB_Perolehan_Pembuka_Hdr b on b.JualanID = a.Id_Jualan
                                join SMKB_Perolehan_Permohonan_Hdr c on c.No_Mohon = a.No_Mohon " & tarikhQuery & "
                                group by a.No_Sebut_Harga, a.Tarikh_Daftar, c.Tujuan, a.No_Mohon"

        Return db.Read(query, param)
    End Function

    'insert data Proses Pembuka
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Test(mohonPoTest As Pembuka_EP) As String
        Dim resp As New ResponseRepository
        Dim hasFailed As Boolean = False ' Flag to track failure

        resp.Success("Data telah disimpan")

        If mohonPoTest Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertTest(mohonPoTest) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'hasFailed = True ' Set flag to true
        End If

        If Update_FlagSemak(mohonPoTest.noMohonValue) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        resp.Success("Rekod berjaya disimpan", "00", mohonPoTest)
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Function Update_FlagSemak(noMohonValue As String) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Flag_Semak = '1' , Status_Dok = '48' WHERE No_Mohon = @noMohonValue"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Private Function InsertTest(mohonPoTest As Pembuka_EP) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembuka_Hdr (JualanID, NoMohon, JenisPenilaian, NoStaf, JawStaf, TarikhMasaMula, MasaBuka, TarikhMasaBuka, dStafHantar, Tempat) 
                                VALUES (@txtNoJualan, @noMohonValue, @JnsPenilaian, @txtNoStaf, @txtJawStaf, @lblTarikhMasaMula, @lblMasaBuka, @lblTarikhMasaBuka, @txtNoStaf, @txtTempat)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoJualan", mohonPoTest.txtNoJualan))
        param.Add(New SqlParameter("@noMohonValue", mohonPoTest.noMohonValue))
        param.Add(New SqlParameter("@JnsPenilaian", mohonPoTest.JnsPenilaian))
        param.Add(New SqlParameter("@lblTarikhMasaMula", mohonPoTest.lblTarikhMasaMula))
        param.Add(New SqlParameter("@lblMasaBuka", mohonPoTest.lblMasaBuka))
        param.Add(New SqlParameter("@lblTarikhMasaBuka", mohonPoTest.lblTarikhMasaBuka))
        param.Add(New SqlParameter("@txtTempat", mohonPoTest.txtTempat))
        param.Add(New SqlParameter("@txtNoStaf", Session("ssusrID"))) 'masuk dalam column NoStaf
        param.Add(New SqlParameter("@txtJawStaf", Session("ssusrPost")))
        param.Add(New SqlParameter("@txtDStafHantar", Session("ssusrID"))) 'masuk dalam column dStafHantar

        Return db.Process(query, param)
    End Function

    'insert data save Kehadiran
    Function InsertHadir(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String
        Dim result As String = ""
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembuka_Dtl (JualanID, NoStaf, NamaStaf, JawStaf, KodPTJStaf, EmailStaf, rkMasaSah, Hadir) VALUES (@txtNoJualan, @txtNoStaf, @txtNamaStaf, @txtJawStaf, @txtPTJStaf, @txtEmailStaf, @rkMasaSah, 1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoStaf", Perolehan_Mesyuarat_JKD.txtNoStaf))
        param.Add(New SqlParameter("@txtNamaStaf", Perolehan_Mesyuarat_JKD.txtNamaStaf))
        param.Add(New SqlParameter("@txtJawStaf", Perolehan_Mesyuarat_JKD.txtJawStaf))
        param.Add(New SqlParameter("@txtPTJStaf", Perolehan_Mesyuarat_JKD.txtPTJStaf))
        param.Add(New SqlParameter("@txtEmailStaf", Perolehan_Mesyuarat_JKD.txtEmailStaf))
        param.Add(New SqlParameter("@txtNoJualan", Perolehan_Mesyuarat_JKD.txtNoJualan))
        param.Add(New SqlParameter("@rkMasaSah", Perolehan_Mesyuarat_JKD.rkMasaSah))

        result = db.Process(query, param)

        Return result
    End Function

    Function UpdateInsert(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn
        'Dim query As String = "UPDATE SMKB_Perolehan_Pembuka SET StatusHantar = '1', TarikhMasaTamat = @lblTarikhMasaTamat, TarikhMasaHantar = @lblTarikhMasaHantar WHERE PembukaID = @txtPembukaID"
        Dim query As String = "UPDATE SMKB_Perolehan_Pembuka_Hdr SET StatusHantar = '1', TarikhMasaTamat = @lblTarikhMasaTamat, TarikhMasaHantar = @lblTarikhMasaHantar WHERE PembukaID = '2024-01-15 09:34:54.1870000'"
        'Dim query As String = "UPDATE SMKB_Perolehan_Pembuka SET StatusHantar = '1' WHERE PembukaID = '2024-01-15 09:19:41.9670000'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@lblTarikhMasaTamat", SqlDbType.DateTime) With {.Value = Perolehan_Mesyuarat_JKD.lblTarikhMasaTamat})
        param.Add(New SqlParameter("@lblTarikhMasaHantar", SqlDbType.DateTime) With {.Value = Perolehan_Mesyuarat_JKD.lblTarikhMasaHantar})
        'param.Add(New SqlParameter("@lblTarikhMasaTamat", Perolehan_Mesyuarat_JKD.lblTarikhMasaTamat))
        'param.Add(New SqlParameter("@lblTarikhMasaHantar", Perolehan_Mesyuarat_JKD.lblTarikhMasaHantar))
        'param.Add(New SqlParameter("@txtPembukaID", Perolehan_Mesyuarat_JKD.txtPembukaID))

        result = db.Process(query, param)

        Return result
    End Function

    Function UpdateHadir(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembuka_Dtl
                                SET PembukaID = a.a_pk
                                FROM (
                                    SELECT a.PembukaID, a.JualanID, a.NoMohon, b.JualanID as b_jualan, b.PembukaDtID as b_pk, CAST(DATEDIFF(SECOND, '1970-01-01 00:00:00', a.PembukaID) AS bigint) as a_pk, b.PembukaID as b_fk
                                    FROM SMKB_Perolehan_Pembuka_Hdr a
                                    JOIN SMKB_Perolehan_Pembuka_Dtl b ON a.JualanID = b.JualanID
                                    WHERE a.JualanID = @txtNoJualan
                                ) AS a
                                WHERE SMKB_Perolehan_Pembuka_Dtl.JualanID = a.b_jualan;"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoJualan", Perolehan_Mesyuarat_JKD.txtNoJualan))

        result = db.Process(query, param)

        Return result
    End Function

    'Load DataTable tbl attachment
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMesyTest() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadMesyTest()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadMesyTest() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Sebut_Harga, a.Tarikh_Daftar, b.MasaBuka, c.Tujuan FROM SMKB_Perolehan_Naskah_Jualan a
                                inner join SMKB_Perolehan_Pembuka_Hdr b on b.JualanID = a.Id_Jualan
                                inner join SMKB_Perolehan_Permohonan_Hdr c on c.No_Mohon = a.No_Mohon
                                where a.No_Sebut_Harga = 'UTeM/SH/001/2024'
                                group by a.No_Sebut_Harga, a.Tarikh_Daftar, b.MasaBuka, c.Tujuan"

        Return db.Read(query)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiMesy(category_filter As String, isClicked7 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked7 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SenaraiMesy(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SenaraiMesy(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -1, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -2, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.TarikhDaftar >= @tkhMula and a.TarikhDaftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        'Dim query As String = "SELECT a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
        '                        FROM SMKB_Perolehan_Mesyuarat_Hdr a
        '                        INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
        'where a.status='1' " & tarikhQuery & "
        'ORDER BY TarikhDaftar DESC"

        Dim query As String = " SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, d.No_Perolehan,b.Mod_Jawatankuasa,b.Kategori
                                FROM SMKB_Perolehan_Mesyuarat_Hdr a
                                INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
								inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
								inner join SMKB_Perolehan_Permohonan_Hdr d on d.No_Mohon = c.No_Mohon
								WHERE d.Status_Dok = '47' and b.Mod_Jawatankuasa = 'UNI' and b.Kategori='P' " & tarikhQuery & " 
								GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon, d.No_Perolehan,b.Mod_Jawatankuasa,b.Kategori
								ORDER BY TarikhDaftar DESC "

        '--where c.Status_Dok = '47'

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_Pengesyoran(category_filter As String, isClicked1 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked1 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SahPengesyoran(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SahPengesyoran(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -1, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -2, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.TarikhDaftar >= @tkhMula and a.TarikhDaftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        'Dim query As String = "SELECT a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
        '                        FROM SMKB_Perolehan_Mesyuarat_Hdr a
        '                        INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
        'where a.status='1' " & tarikhQuery & "
        'ORDER BY TarikhDaftar DESC"

        'Dim query As String = "SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
        '                        FROM SMKB_Perolehan_Mesyuarat_Hdr a
        '                        INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
        'inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
        'where c.Status_Dok = '48' " & tarikhQuery & "
        'GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon
        'ORDER BY TarikhDaftar DESC"

        Dim query As String = "
                            SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
                                FROM SMKB_Perolehan_Mesyuarat_Hdr a
                                INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
								inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
								inner join SMKB_Perolehan_Permohonan_Hdr d on d.No_Mohon = c.No_Mohon
                                WHERE c.Status_Dok = '53' and d.Status_Dok = '52' " & tarikhQuery & " 
								GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon
								ORDER BY TarikhDaftar DESC
        "

        '--where c.Status_Dok = '47'

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_SahPembuka(category_filter As String, isClicked3 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked3 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SahPembuka(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SahPembuka(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -1, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -2, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.TarikhDaftar >= @tkhMula and a.TarikhDaftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        'Dim query As String = "SELECT a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
        '                        FROM SMKB_Perolehan_Mesyuarat_Hdr a
        '                        INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
        'where a.status='1' " & tarikhQuery & "
        'ORDER BY TarikhDaftar DESC"

        'Dim query As String = "SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
        '                        FROM SMKB_Perolehan_Mesyuarat_Hdr a
        '                        INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
        'inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
        'where c.Status_Dok = '48' " & tarikhQuery & "
        'GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon
        'ORDER BY TarikhDaftar DESC"

        Dim query As String = "SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
                                FROM SMKB_Perolehan_Mesyuarat_Hdr a
                                INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
								inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
								inner join SMKB_Perolehan_Permohonan_Hdr d on d.No_Mohon = c.No_Mohon
                                WHERE c.Status_Dok = '49' and d.Status_Dok = '48' " & tarikhQuery & " 
								GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon
								ORDER BY TarikhDaftar DESC"

        '--where c.Status_Dok = '50'

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_SahPembuka_Teknikal(category_filter As String, isClicked3 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked3 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SahPembuka_Teknikal(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SahPembuka_Teknikal(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -1, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -2, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.TarikhDaftar >= @tkhMula and a.TarikhDaftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        'Dim query As String = "SELECT a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
        '                        FROM SMKB_Perolehan_Mesyuarat_Hdr a
        '                        INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
        'where a.status='1' " & tarikhQuery & "
        'ORDER BY TarikhDaftar DESC"

        'Dim query As String = "SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
        '                        FROM SMKB_Perolehan_Mesyuarat_Hdr a
        '                        INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
        'inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
        'where c.Status_Dok = '48' " & tarikhQuery & "
        'GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon
        'ORDER BY TarikhDaftar DESC"

        Dim query As String = "SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
                                FROM SMKB_Perolehan_Mesyuarat_Hdr a
                                INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
								inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
								inner join SMKB_Perolehan_Permohonan_Hdr d on d.No_Mohon = c.No_Mohon
                                WHERE c.Status_Dok = '51' and d.Status_Dok = '48' " & tarikhQuery & " 
								GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon
								ORDER BY TarikhDaftar DESC"

        '--where c.Status_Dok = '50'

        Return db.Read(query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiLantik(category_filter As String, isClicked9 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked9 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SahLantik(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SahLantik(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -1, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -2, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.TarikhDaftar >= @tkhMula and a.TarikhDaftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
                                FROM SMKB_Perolehan_Mesyuarat_Hdr a
                                INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
								inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
								inner join SMKB_Perolehan_Permohonan_Hdr d on d.No_Mohon = c.No_Mohon
                                WHERE c.Status_Dok = '55' and d.Status_Dok = '54' " & tarikhQuery & " 
								GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon
								ORDER BY TarikhDaftar DESC"

        '--where c.Status_Dok = '47'

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_Pembuka(category_filter As String, isClicked2 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked2 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SenaraiPembuka(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SenaraiPembuka(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhDaftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -1, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.TarikhDaftar >= DATEADD(month, -2, getdate()) and a.TarikhDaftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.TarikhDaftar >= @tkhMula and a.TarikhDaftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "SELECT a.IDMesy, c.No_Mohon, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK
                                FROM SMKB_Perolehan_Mesyuarat_Hdr a
                                INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
								inner join SMKB_Perolehan_Mesyuarat_Dtl c on c.ID_Mesy = a.IDMesy
								where 1=1 " & tarikhQuery & "
								GROUP BY a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, b.Butiran, a.Kod_JK, c.No_Mohon
								ORDER BY TarikhDaftar DESC"

        '--where c.Status_Dok = '47'

        Return db.Read(query, param)
    End Function

    'Delete Row DataTable attachment
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteAttachment(ByVal id As String, noMohonValue1 As String, NamaFailPdf As String) As String

        Dim resp As New ResponseRepository
        Dim namaFail As String = NamaFailPdf
        Dim noMohonValue As String = noMohonValue1

        If Query_deleteAttachment(id, noMohonValue1, NamaFailPdf) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim filePath As String = Server.MapPath("~/UPLOAD/DOCUMENT/PEROLEHAN/PENILAIAN_HARGA/") & noMohonValue & "/" & namaFail
        If System.IO.File.Exists(filePath) Then
            System.IO.File.Delete(filePath)
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deleteAttachment(ByVal id As String, noMohonValue1 As String, NamaFailPdf As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM SMKB_Perolehan_Lampiran WHERE Id_Lampiran = @Id_Lampiran"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Lampiran", id))

        Return db.Process(query, param)
    End Function

    ''Load DataTable tblHadir
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiStaf() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadStaf()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadStaf() As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "SELECT a.MS01_NoStaf as NoStaf , a.MS01_Nama as NamaStaf, a.MS01_Email as EmailStaf, c.JawGiliran as JawStaf, c.Jawatan as PerananStaf, d.Pejabat as PejStaf, d.KodPejPBU as PTJStaf
        '                        FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_PERIBADI as a
        '                        join [DEVMIS\SQL_INS01].dbStaf.dbo.MS02_PERJAWATAN as b on a.MS01_NoStaf = b.MS01_NoStaf
        '                        join [DEVMIS\SQL_INS01].dbStaf.dbo.MS_JAWATAN as c on b.MS02_JawSandang = c.KodJawatan
        '                        join [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT as d on b.MS02_Taraf = d.KodPejabat
        '                        --WHERE a.MS01_NoStaf = '00841' 
        '                        WHERE d.Status = '1' ORDER BY a.MS01_NoStaf"

        Dim query As String = "SELECT a.MS01_NoStaf as NoStaf , a.MS01_Nama as NamaStaf, a.MS01_Email as EmailStaf, b.NJawatan as JawStaf , c.JawatanS as PerananStaf, d.Pejabat as PejStaf, b.MS08_Unit as PTJStaf
                                FROM VPeribadi as a
                                inner join VPeribadi12 as b on a.MS01_NoStaf = b.NoStaf
                                inner join VPeribadi01 as c on b.JGiliran = c.JawatanS
                                inner join VPejabat as d on b.MS02_Taraf = d.KodPejabat
                                --WHERE a.MS01_NoStaf = '00841' 
                                WHERE C.Status_Staf = 'AKTIF'
								group by a.MS01_NoStaf,a.MS01_Nama,a.MS01_Email, b.NJawatan,c.JawatanS,d.Pejabat, b.MS08_Unit ORDER BY a.MS01_NoStaf"


        Return db.Read(query)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveAndUploadFileUlasan() As String
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim noMohonValue As String = HttpContext.Current.Request.Form("noMohonValue")
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileSize As Long = postedFile.ContentLength
        Dim fileExtension As String = Path.GetExtension(fileName).ToLower()

        Try

            ' Specify the file path where you want to save the uploaded file
            Dim folderPath As String = Server.MapPath("~/UPLOAD/DOCUMENT/PEROLEHAN/PEMBUKA/" & noMohonValue)
            Dim savePath As String = Path.Combine(folderPath, postedFile.FileName)

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

            Dim query As String = "INSERT INTO SMKB_Perolehan_Lampiran (No_Mohon, Lampiran, Nama_Fail, Jenis_Dokumen, Status) VALUES (@noMohonValue, 'Lampiran Pembuka' ,@Nama_Fail, 'UP', 1)"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@noMohonValue", noMohonValue))
            param.Add(New SqlParameter("@Nama_Fail", postedFile.FileName))

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

    'Load DataTable tbl pembuka
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMesyPembuka(IDMesy As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadMesyPmbuka(IDMesy)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadMesyPmbuka(IDMesy As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "	select b.No_Mohon, b.ID_Mesy, e.No_Sebut_Harga, e.Id_Jualan, e.Tarikh_Masa_Mula_Iklan, e.Tarikh_Masa_Tamat_Perolehan ,
                                c.Tujuan, c.Justifikasi, c.Status_Dok, c.No_Perolehan,
                                FORMAT(SUM(d.Jumlah_Harga),'0.00') AS Total_Harga,  c.Jenis_Barang, kategori.Butiran AS kategori_butiran, 
                                (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = c.status_dok) AS Butiran, 
                                (select KodPejabat + '0000' + ' - ' + Pejabat  from vpejabat where KodPejabat = left (c.Kod_Ptj_Mohon,2)) AS Ptj_Mohon,
                                SUM(Jumlah_Harga) as value, MIN(f.Kategori_Perolehan) AS Kaedah from SMKB_Perolehan_Mesyuarat_Hdr a
                                join SMKB_Perolehan_Mesyuarat_Dtl b on a.IDMesy = b.ID_Mesy
                                join SMKB_Perolehan_Permohonan_Hdr c on b.No_Mohon = c.No_Mohon
                                join SMKB_Perolehan_Permohonan_Dtl d on c.No_Mohon = d.No_Mohon
                                join SMKB_Perolehan_Naskah_Jualan e on e.No_Mohon = d.No_Mohon
                                INNER JOIN SMKB_Lookup_Detail AS kategori ON c.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                                LEFT JOIN SMKB_Perolehan_Kaedah f ON d.Jumlah_Harga BETWEEN f.Min_Harga AND f.Max_Harga
                                --where ID_Mesy = 'TM4100000000070124'
                                where b.ID_Mesy = @IDMesy
                                group by ID_Mesy, Jenis_Barang, c.Jenis_Barang, kategori.Butiran, b.No_Mohon, c.Tujuan, c.Justifikasi, e.No_Sebut_Harga, c.No_Perolehan,
                                e.Id_Jualan, e.Tarikh_Masa_Mula_Iklan, e.Tarikh_Masa_Tamat_Perolehan, c.Status_Dok, c.Kod_Ptj_Mohon"

        '(SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = c.status_dok) AS Butiran, 
        '(SELECT KodPejPBU + ' - ' + Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT WHERE KodPejPBU = c.Kod_Ptj_Mohon) AS Ptj_Mohon,

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IDMesy", IDMesy))
        Dim dt As DataTable = db.Read(query, param)
        Return dt

        Return db.Read(query, param)
    End Function

    'Save KEHADIRAN V2
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SaveKehadiran(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String
        Dim resp As New ResponseRepository
        ' Declare and initialize the isUpdatePerformed variable
        Dim isUpdatePerformed As Boolean = False
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Perolehan_Mesyuarat_JKD.txtIDMesy = Session("sessionIDMesy")
        If Load_GetSaveKehadiran(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If

        ' UPDATE TABLE SMKB_Perolehan_Pembuka_Dtl STORE pembukaid
        If UpdateHadir(Perolehan_Mesyuarat_JKD) <> "OK" Then
            'resp.Failed("Gagal Menyimpan order")
            resp.Failed("Rekod disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If

        ' Check if the update has not been performed yet
        If Not isUpdatePerformed Then
            ''UPDATE Table SMKB_Perolehan_Pembuka_Hdr
            If UpdateInsert(Perolehan_Mesyuarat_JKD) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            ' Set the flag to true indicating that the update has been performed
            isUpdatePerformed = True
        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_JKD)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function Load_GetSaveKehadiran(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        'Private Function Load_GetSaveKehadiran(txtNoJualan As String, txtNoStaf As String, txtNamaStaf As String, txtJawStaf As String, txtKodPTjStaf As String,
        '                                           txtEmailStaf As String, rkMasaSah As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembuka_Dtl (JualanID, NoStaf, NamaStaf, JawStaf, KodPTJStaf, EmailStaf, rkMasaSah, Hadir)
        VALUES(@txtNoJualan, @txtNoStaf, @txtNamaStaf, @txtJawStaf, @txtKodPTjStaf, @txtEmailStaf, @rkMasaSah, '1')"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoJualan", Perolehan_Mesyuarat_JKD.txtNoJualan))
        param.Add(New SqlParameter("@txtNoStaf", Perolehan_Mesyuarat_JKD.txtNoStaf))
        param.Add(New SqlParameter("@txtNamaStaf", Perolehan_Mesyuarat_JKD.txtNamaStaf))
        param.Add(New SqlParameter("@txtJawStaf", Perolehan_Mesyuarat_JKD.txtJawStaf))
        param.Add(New SqlParameter("@txtKodPTjStaf", Perolehan_Mesyuarat_JKD.txtKodPTjStaf))
        param.Add(New SqlParameter("@txtEmailStaf", Perolehan_Mesyuarat_JKD.txtEmailStaf))
        param.Add(New SqlParameter("@rkMasaSah", SqlDbType.DateTime) With {.Value = Perolehan_Mesyuarat_JKD.rkMasaSah})
        'param.Add(New SqlParameter("@rkMasaSah", Perolehan_Mesyuarat_JKD.rkMasaSah))

        Return db.Process(query, param)
    End Function

    '//load data untuk list kehadiran
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_PembukaJK(ByVal IDMesy As String, txtNoLantikan As String) As String
        Dim resp As New ResponseRepository
        'Dim No_Lantik As String = GetNoLantik(IDMesy)

        dt = GetRecord_LoadPembukaJK(IDMesy, txtNoLantikan)
        resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_LoadPembukaJK(ByVal IDMesy As String, txtNoLantikan As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            query = "select a.IDMesy, d.JawGiliran as Jawatan, d.MS01_Nama as Nama, d.Pejabat, d.MS01_Email as Emel, d.MS01_NoStaf as No_Staf, f.Jawatan as Peranan, f.KodPTj, a.Kod_JK 
                        from SMKB_Perolehan_Mesyuarat_Hdr a
            --JOIN VPeribadi d ON a.No_Staf = d.MS01_NoStaf
            --join SMKB_Perolehan_Mesyuarat_JK e on  e.ID_Mesy =  a.IDMesy
            JOIN SMKB_Perolehan_JawatankuasaDT f ON a.Kod_JK = f.Kod_JawatanKuasa
            JOIN VPeribadi d ON f.No_Staf = d.MS01_NoStaf
            --join SMKB_Perolehan_Jawatankuasa e on a.Kod_JawatanKuasa = e.Kod_Jawatankuasa
            where a.IDMesy = @IDMesy and a.Kod_JK = @txtNoLantikan"

            '       query = "SELECT b.JawGiliran as Jawatan, b.MS01_Nama as Nama, b.Pejabat, b.MS01_Email as Emel, b.MS01_NoStaf as No_Staf, a.Jawatan as Peranan, 
            'a.KodPTj, a.Kod_JawatanKuasa
            '               FROM SMKB_Perolehan_JawatankuasaDT a
            '               INNER JOIN VPeribadi b ON a.No_Staf = b.MS01_NoStaf
            '               where a.Kod_JawatanKuasa  = @txtNoLantikan
            '               ORDER BY 
            '               CASE
            '                  WHEN a.jawatan = 'PENGERUSI' THEN 1
            '                  WHEN a.jawatan = 'SETIAUSAHA' THEN 2
            '                  WHEN a.jawatan = 'AHLI' THEN 3
            '               END"

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IDMesy", IDMesy))
            cmd.Parameters.Add(New SqlParameter("@txtNoLantikan", txtNoLantikan))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'load datatables list attachement penilaian harga
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadAttachment_PenilaianHarga(ByVal noMohonValue As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_PenilaianHarga(noMohonValue)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_PenilaianHarga(noMohonValue As String) As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "SELECT * FROM SMKB_Perolehan_Lampiran a WHERE a.Jenis_Dokumen = 'LPH' OR a.Jenis_Dokumen = 'JPH' and No_Mohon = 'BS4100000002140923'"
        Dim query As String = "SELECT * FROM SMKB_Perolehan_Lampiran a
                                WHERE No_Mohon = @noMohonValue and (a.Jenis_Dokumen = 'LPH' OR a.Jenis_Dokumen = 'JPH' or a.Jenis_Dokumen = 'UP')
                                order by Id_Lampiran asc"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    'Load DataTable tbl pembuka
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMesyPenilaianHarga(IDMesy As String) As String
        Dim resp As New ResponseRepository

        If String.IsNullOrEmpty(IDMesy) Then
            Return JsonConvert.SerializeObject(New DataTable())
        End If

        Dim dt As DataTable = GetRecordLoadMesyPenilaianHarga(IDMesy)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRecordLoadMesyPenilaianHarga(IDMesy As String) As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "select b.No_Mohon, b.ID_Mesy, e.No_Sebut_Harga, e.Id_Jualan ,c.Tujuan, c.Justifikasi, FORMAT(SUM(d.Jumlah_Harga),'0.00') AS Total_Harga,  c.Jenis_Barang, kategori.Butiran AS kategori_butiran, 
        '                        SUM(Jumlah_Harga) as value, MIN(f.Kategori_Perolehan) AS Kaedah, (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = c.status_dok) AS Butiran, e.Tarikh_Masa_Tamat_Perolehan, 
        '                        (SELECT KodPejPBU + ' - ' + Pejabat
        '                        FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT
        '                        WHERE KodPejPBU = c.Kod_Ptj_Mohon) AS Ptj_Mohon, g.TarikhMasaHantar
        '                        from SMKB_Perolehan_Mesyuarat_Hdr a
        '                        join SMKB_Perolehan_Mesyuarat_Dtl b on a.IDMesy = b.ID_Mesy
        '                        join SMKB_Perolehan_Permohonan_Hdr c on b.No_Mohon = c.No_Mohon
        '                        join SMKB_Perolehan_Permohonan_Dtl d on c.No_Mohon = d.No_Mohon
        '                        join SMKB_Perolehan_Naskah_Jualan e on e.No_Mohon = d.No_Mohon
        '                        INNER JOIN SMKB_Lookup_Detail AS kategori ON c.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
        '                        LEFT JOIN SMKB_Perolehan_Kaedah f ON d.Jumlah_Harga BETWEEN f.Min_Harga AND f.Max_Harga
        '                        LEFT JOIN SMKB_Perolehan_Pembuka_Hdr g on g.JualanID = e.Id_Jualan
        '                        where b.ID_Mesy = @IDMesy
        '                        --where ID_Mesy = 'TM4100000000070124'
        '                        group by ID_Mesy, Jenis_Barang, c.Jenis_Barang, kategori.Butiran, b.No_Mohon, c.Tujuan, c.Justifikasi, e.No_Sebut_Harga, e.Id_Jualan, 
        '                        c.Status_Dok, e.Tarikh_Masa_Tamat_Perolehan, c.Kod_Ptj_Mohon, g.TarikhMasaHantar"

        Dim query As String = "select b.No_Mohon, b.ID_Mesy, e.No_Sebut_Harga, e.Id_Jualan, e.Tarikh_Masa_Mula_Iklan, e.Tarikh_Masa_Tamat_Perolehan ,c.Tujuan, c.Justifikasi, c.Status_Dok, c.No_Perolehan,
                                FORMAT(SUM(d.Jumlah_Harga),'0.00') AS Total_Harga,  c.Jenis_Barang, kategori.Butiran AS kategori_butiran, 
                                (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = c.status_dok) AS Butiran, 
                                (select KodPejabat + '0000' + ' - ' + Pejabat  from vpejabat where KodPejabat = left (c.Kod_Ptj_Mohon,2)) AS Ptj_Mohon,
                                SUM(Jumlah_Harga) as value, MIN(f.Kategori_Perolehan) AS Kaedah from SMKB_Perolehan_Mesyuarat_Hdr a
                                join SMKB_Perolehan_Mesyuarat_Dtl b on a.IDMesy = b.ID_Mesy
                                join SMKB_Perolehan_Permohonan_Hdr c on b.No_Mohon = c.No_Mohon
                                join SMKB_Perolehan_Permohonan_Dtl d on c.No_Mohon = d.No_Mohon
                                join SMKB_Perolehan_Naskah_Jualan e on e.No_Mohon = d.No_Mohon
                                INNER JOIN SMKB_Lookup_Detail AS kategori ON c.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                                LEFT JOIN SMKB_Perolehan_Kaedah f ON d.Jumlah_Harga BETWEEN f.Min_Harga AND f.Max_Harga
                                where b.ID_Mesy = @IDMesy
                                group by ID_Mesy, Jenis_Barang, c.Jenis_Barang, kategori.Butiran, b.No_Mohon, c.Tujuan, c.Justifikasi, e.No_Sebut_Harga, c.No_Perolehan,
                                e.Id_Jualan, e.Tarikh_Masa_Mula_Iklan, e.Tarikh_Masa_Tamat_Perolehan, c.Status_Dok, c.Kod_Ptj_Mohon"
        '(SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = c.status_dok) AS Butiran, 
        '(SELECT KodPejPBU + ' - ' + Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT WHERE KodPejPBU = c.Kod_Ptj_Mohon) AS Ptj_Mohon,

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IDMesy", IDMesy))
        Dim dt As DataTable = db.Read(query, param)
        Return dt

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveAndUploadFilePenilaianHarga() As String
        Dim dokumenType As String
        'Dim namaFail As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim namaFailValue As String = HttpContext.Current.Request.Form("namaFail")
        Dim fileSize As Long = postedFile.ContentLength
        Dim fileExtension As String = Path.GetExtension(fileName).ToLower()
        Dim noMohonValue As String = HttpContext.Current.Request.Form("noMohonValue")
        dokumenType = HttpContext.Current.Request.Form("dokumenType")
        'namaFail = HttpContext.Current.Request.Form("namaFail")

        Try

            ' Specify the file path where you want to save the uploaded file
            Dim folderPath As String = Server.MapPath("~/UPLOAD/DOCUMENT/PEROLEHAN/PENILAIAN_HARGA/" & noMohonValue)
            Dim savePath As String = Path.Combine(folderPath, postedFile.FileName)

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

            Dim query As String = "INSERT INTO SMKB_Perolehan_Lampiran(No_Mohon, Lampiran, Nama_Fail, Jenis_Dokumen, Status) VALUES (@noMohonValue, @Lampiran, @Nama_Fail, @Jenis_Dokumen, 1)"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@noMohonValue", noMohonValue))
            param.Add(New SqlParameter("@Lampiran", namaFailValue))
            param.Add(New SqlParameter("@Nama_Fail", postedFile.FileName))
            param.Add(New SqlParameter("@Jenis_Dokumen", dokumenType))

            Dim db As New DBKewConn
            Dim result As String = db.Process(query, param)

            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            Return "File uploaded successfully. " & result
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    'Load DataTable tblDataPerolehanDtl
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadKelulusanPo(ByVal noMohonValue As String, idSyarikat As String, noSebutHarga As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadKelulusanPo(noMohonValue, idSyarikat, noSebutHarga)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadKelulusanPo(noMohonValue As String, idSyarikat As String, noSebutHarga As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "								
                               select d.No_Sebut_Harga, Sum(e.Jumlah_Harga) as totalHarga, c.Tujuan, a.ID_Syarikat, c.No_Mohon, a.Tempoh, a.Jenis_Tempoh,
                                b.Nama_Sykt,b.No_Sykt,f.No_Daftar, FORMAT(f.Tkh_Mula,'dd/MM/yyyy') As Tkh_Mula , FORMAT(f.Tkh_Tamat,'dd/MM/yyyy')As Tkh_Tamat ,f.Kod_Daftar, 
                                b.Emel_Semasa, b.Almt_Semasa_1, b.Almt_Semasa_2, b.Bandar_Semasa, b.Poskod_Semasa, b.Kod_Negeri_Semasa,
                                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0003' AND Kod_Detail = b.Bandar_Semasa ) As Bandar_name,
                                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0002' AND Kod_Detail = b.Kod_Negeri_Semasa ) As Negeri_name,
                                (select Butiran from SMKB_Lookup_Detail where Kod ='PO05' and Kod_Detail = a.Jenis_Tempoh) as Jenis_Tempoh_butiran,
                                (select No_Daftar from SMKB_Syarikat_Daftar where Kod_Daftar ='KEW' and ID_Sykt = b.No_Sykt and Status='1' ) as Kod_Daftar_KEW,
                                (select FORMAT(tkh_tamat,'dd/MM/yyyy') from SMKB_Syarikat_Daftar where Kod_Daftar ='KEW' and ID_Sykt = b.No_Sykt and Status='1' ) as Tarikh_tamat_KEW,
                                (select FORMAT(Tkh_Mula,'dd/MM/yyyy') from SMKB_Syarikat_Daftar where Kod_Daftar ='KEW' and ID_Sykt = b.No_Sykt and Status='1' ) as Tarikh_Mula_KEW,
                                (select Kod_Daftar from SMKB_Syarikat_Daftar where Kod_Daftar ='BUMI' and ID_Sykt = b.No_Sykt and Status='1' ) as Taraf,
                                (select FORMAT(tkh_tamat,'dd/MM/yyyy') from SMKB_Syarikat_Daftar where Kod_Daftar ='KEW' and ID_Sykt = b.No_Sykt and Status='1' ) as Tarikh_tamat_BUMI,
                                (select FORMAT(Tkh_Mula,'dd/MM/yyyy') from SMKB_Syarikat_Daftar where Kod_Daftar ='KEW' and ID_Sykt = b.No_Sykt and Status='1' ) as Tarikh_Mula_BUMI
                                from SMKB_Perolehan_Pembelian_Hdr a
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Perolehan_Permohonan_Hdr c on c.No_Mohon = a.No_Mohon
                                inner join SMKB_Perolehan_Naskah_Jualan d on d.Id_Jualan = a.Id_Jualan
                                inner join SMKB_Perolehan_Pembelian_Dtl e on e.Id_Pembelian = a.Id_Pembelian
                                inner join SMKB_Syarikat_Daftar f on f.ID_Sykt = b.No_Sykt 
                                Where d.No_Sebut_Harga = @noSebutHarga
                                and a.ID_Syarikat = @idSyarikat
                                and c.No_Mohon = @noMohonValue
                                and (f.Kod_Daftar ='SSM' ) 
                                and f.Status='1'
                                group by d.No_Sebut_Harga, c.Tujuan, a.ID_Syarikat, c.No_Mohon, b.Nama_Sykt,b.No_Sykt, 
                                f.No_Daftar, f.Tkh_Mula, f.Tkh_Tamat,f.Kod_Daftar, a.Tempoh, a.Jenis_Tempoh,
                                b.Emel_Semasa, b.Almt_Semasa_1, b.Almt_Semasa_2, b.Bandar_Semasa, b.Poskod_Semasa, b.Kod_Negeri_Semasa

        "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))
        param.Add(New SqlParameter("@noSebutHarga", noSebutHarga))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_Testing(ByVal noMohonValue As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_Testing(noMohonValue)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_Testing(noMohonValue As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select *, e.Butiran AS Bandar ,d.Butiran AS Negeri, b.No_Mohon from SMKB_Syarikat_Master a
								inner join SMKB_Perolehan_Pembelian_Hdr b on a.ID_Sykt = b.ID_Syarikat
								inner join SMKB_Perolehan_Naskah_Jualan c on b.Id_Jualan = c.Id_Jualan
								inner join SMKB_Lookup_Detail d on d.Kod_Detail = a.Kod_Negeri_Semasa
								inner join SMKB_Lookup_Detail e on e.Kod_Detail = a.Bandar_Semasa
								where c.No_Mohon = @noMohonValue and d.Kod = '0002' and e.Kod = '0003'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SyarikatInfo(ByVal idSyarikat As String, noSebutHarga As String, noMohonValue As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_SyarikatInfo(idSyarikat, noSebutHarga, noMohonValue)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_SyarikatInfo(idSyarikat As String, noSebutHarga As String, noMohonValue As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select *, e.Butiran AS Bandar ,d.Butiran AS Negeri from SMKB_Syarikat_Master a
								inner join SMKB_Perolehan_Pembelian_Hdr b on a.ID_Sykt = b.ID_Syarikat
								inner join SMKB_Perolehan_Naskah_Jualan c on b.Id_Jualan = c.Id_Jualan
								inner join SMKB_Lookup_Detail d on d.Kod_Detail = a.Kod_Negeri_Semasa
								inner join SMKB_Lookup_Detail e on e.Kod_Detail = a.Bandar_Semasa
								--where a.ID_Sykt = @idSyarikat and c.No_Sebut_Harga = @noSebutHarga and c.No_Mohon = @noMohonValue and d.Kod = '0002' and e.Kod = '0003'
                                where a.ID_Sykt = 'RC000001' and c.No_Sebut_Harga = 'UTEM/SH/001/2024' and c.No_Mohon = 'BS4100000002140923' and d.Kod = '0002' and e.Kod = '0003'"

        Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        'param.Add(New SqlParameter("@idSyarikat", idSyarikat))
        'param.Add(New SqlParameter("@noSebutHarga", noSebutHarga))

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_PerolehanSyarikat() As String
        Dim resp As New ResponseRepository

        dt = GetRecord_PerolehanSyarikat()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_PerolehanSyarikat() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select *, c.Butiran as Tempoh_Bekal from SMKB_Perolehan_Pembelian_Hdr a 
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Lookup_Detail c on c.Kod_Detail = a.Jenis_Tempoh
                                where a.ID_Syarikat = 'RC000001' and c.Kod = 'PO05' and a.No_Mohon = 'BS4100000002140923'"

        Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_ButiranKontrak() As String
        Dim resp As New ResponseRepository

        dt = GetRecord_ButiranKontrak()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_ButiranKontrak() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select a.*, b.*, d.*, e.*, f.No_Daftar as SSM, f.Tkh_Mula as tkhMula_SSM, f.Tkh_Tamat AS tkhTamat_SSM, g.No_Daftar AS MOF, g.Tkh_Mula as tkhMula_KEW, g.Tkh_Tamat AS tkhTamat_KEW from SMKB_Syarikat_Master a
								inner join SMKB_Perolehan_Pembelian_Hdr b on a.ID_Sykt = b.ID_Syarikat
								inner join SMKB_Perolehan_Naskah_Jualan c on b.Id_Jualan = c.Id_Jualan
								inner join SMKB_Lookup_Detail d on d.Kod_Detail = a.Kod_Negeri_Semasa
								inner join SMKB_Lookup_Detail e on e.Kod_Detail = a.Bandar_Semasa
								inner join SMKB_Syarikat_Daftar f on f.ID_Sykt = a.No_Sykt
								inner join SMKB_Syarikat_Daftar g on g.ID_Sykt = a.No_Sykt
								where a.ID_Sykt = 'RC000001' and c.No_Sebut_Harga = 'UTeM/SH/001/2024' and c.No_Mohon = 'BS4100000002140923' and d.Kod = '0002' and e.Kod = '0003' AND f.Kod_Daftar = 'SSM' AND g.Kod_Daftar = 'KEW'"

        Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function ViewStatus_Bumi() As String
        Dim resp As New ResponseRepository

        dt = PaparStatus_BumiSyarikat()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function PaparStatus_BumiSyarikat() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select e.*, f.Butiran as Status_Bumi from SMKB_Syarikat_Master a
								inner join SMKB_Perolehan_Pembelian_Hdr b on a.ID_Sykt = b.ID_Syarikat
								inner join SMKB_Perolehan_Naskah_Jualan c on b.Id_Jualan = c.Id_Jualan
								inner join SMKB_Syarikat_Daftar e on e.ID_Sykt = a.No_Sykt
								inner join SMKB_Lookup_Detail f on f.Kod_Detail = e.Kod_Daftar
								where a.ID_Sykt = 'RC000001' and c.No_Sebut_Harga = 'UTeM/SH/001/2024' and c.No_Mohon = 'BS4100000002140923' AND e.Kod_Daftar = 'BUMI'"

        Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function ViewShow_PageAkuan(ByVal noMohonValue As String) As String
        Dim resp As New ResponseRepository

        ' Fetch data from the database
        Dim dt As DataTable = ShowPage_AkuanPembida(noMohonValue)

        ' Check if the Flag_Ebidding is 1
        If dt.Rows.Count > 0 AndAlso dt.Rows(0)("Flag_Ebidding").ToString() = "2" Then
            ' If Flag_Ebidding is 1, include <div class="flagBid">
            resp.SuccessPayload(dt)
            Return JsonConvert.SerializeObject(dt)
        Else
            ' If Flag_Ebidding is not 1, return an empty string (hide <div class="flagBid">)
            Return ""
        End If
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function ShowPage_AkuanPembida(noMohonValue As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select * from SMKB_Perolehan_Permohonan_Hdr where Flag_Ebidding = '1' and No_Mohon = @noMohonValue"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PaparStatusBidang(ByVal noMohonValue As String) As String
        Dim db = New DBKewConn
        Dim ayat As String = ""
        Dim counter As Integer = 0
        Dim query As String = "SELECT Kod_Bidang, Syarat, Urutan FROM SMKB_Perolehan_Bidang WHERE No_mohon = @noMohonValue ORDER BY CASE WHEN Syarat <> '0' THEN 1 ELSE 0 END desc,
        CAST(URUTAN as integer)  ASC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Dim prevKod As String = ""
        Dim prevSyarat As String = ""
        Dim flag As Integer = 0
        Dim dt As DataTable = db.Read(query, param)
        Dim response As New Response

        '1 - dan
        '2 - atau
        '0 - terakhir
        '(010101 ATAU 010303) DAN 010699 DAN (010102 ATAU 020199 ATAU 020103 ATAU 060101) DAN 020299
        For Each dr As DataRow In dt.Rows
            If prevKod = "" Then
                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")
                If ayat = "" And dr.Item("Syarat") = "2" Then
                    ayat = " ( "
                    flag = 4
                End If
                Continue For
            End If

            If prevSyarat = "2" Then
                If flag = 4 Then
                    ayat &= " " & prevKod
                End If
                ayat &= " ATAU " & dr.Item("Kod_Bidang")

                If dr.Item("Syarat") = "1" Then
                    ayat &= " ) "
                End If

                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")

                If dr.Item("Syarat") = "0" Then
                    ayat &= " ) "
                End If

                flag = 1

            ElseIf prevSyarat = "1" Then
                If flag = 0 Then
                    ayat &= " " & prevKod
                End If

                If prevSyarat = "2" Then
                    ayat &= " ) "
                End If
                ayat &= " DAN "
                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")
                flag = 0

                If dr.Item("Syarat") = "2" Then
                    ayat &= " ( "
                    flag = 4
                ElseIf dr.Item("Syarat") = "0" Then
                    ayat &= dr.Item("Kod_Bidang")
                End If
            End If


            counter += 1
        Next
        response.Payload = ayat
        response.Status = True
        response.Code = "00"


        Return JsonConvert.SerializeObject(response)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasi_Pembuka(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetSpeksifikasi_PerolehanPembuka(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Public Function GetSpeksifikasi_PerolehanPembuka(noMohonValue As String) As DataTable
        Dim db As New DBKewConn()
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)()

        'Dim query As String = "WITH Total_Jumlah_Harga_CTE AS (
        '                        SELECT b.Semak_Buku1, b.Semak_Buku2, b.ID_Syarikat, b.Kod_Pembuka, b.Id_Pembelian, b.Tempoh, b.Ulasan_Pembuka, b.No_Mohon, b.Peratus_Am, 
        '                        b.Peratus_Teknikal, b.Ulasan_Harga, FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga
        '                        FROM SMKB_Perolehan_Pembelian_Dtl a
        '                        JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
        '                        WHERE b.No_Mohon = @noMohonValue
        '                        GROUP BY b.Semak_Buku1, b.Semak_Buku2, b.ID_Syarikat, Kod_Pembuka, b.Id_Pembelian, b.Tempoh, b.Ulasan_Pembuka, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, 
        '                        b.Ulasan_Harga
        '                    )
        '                    SELECT Semak_Buku1, Semak_Buku2, ID_Syarikat, Kod_Pembuka, Id_Pembelian, Tempoh, Ulasan_Pembuka, No_Mohon, Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,
        '                    ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga DESC) AS Ranking
        '                    FROM Total_Jumlah_Harga_CTE;"

        Dim query As String = "	WITH Total_Jumlah_Harga_CTE AS (
                                SELECT a.Semak_Buku1, a.Semak_Buku2, a.ID_Syarikat, a.Kod_Pembuka, b.Id_Pembelian, a.Tempoh, a.Ulasan_Pembuka, a.No_Mohon, a.Peratus_Am, c.No_Sykt,
                                a.Peratus_Teknikal, a.Ulasan_Harga, FORMAT(SUM(b.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga,  (SELECT TOP 1 d.Butiran FROM SMKB_Perolehan_Pembelian_Hdr b
                                    INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh WHERE b.No_Mohon = @noMohonValue AND d.Kod = 'PO05') AS Jenis_Tempoh
                                FROM SMKB_Perolehan_Pembelian_Hdr a
                                INNER JOIN SMKB_Perolehan_Pembelian_Dtl b ON b.Id_Pembelian = a.Id_Pembelian
								INNER JOIN SMKB_Syarikat_Master c on c.ID_Sykt = a.ID_Syarikat
                                WHERE a.No_Mohon = @noMohonValue
                                GROUP BY a.Semak_Buku1, a.Semak_Buku2, a.ID_Syarikat, Kod_Pembuka, b.Id_Pembelian, a.Tempoh, a.Ulasan_Pembuka, a.No_Mohon, a.Peratus_Am, a.Peratus_Teknikal,  c.No_Sykt,
                                a.Ulasan_Harga
                            )
                            SELECT Semak_Buku1, Semak_Buku2, ID_Syarikat, Kod_Pembuka, Id_Pembelian, Tempoh, Jenis_Tempoh, Ulasan_Pembuka, No_Mohon, Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga, No_Sykt, 
                            ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga DESC) AS Ranking
                            FROM Total_Jumlah_Harga_CTE;"
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        Return db.Read(query, param)
    End Function

    '<System.Web.Services.WebMethod(EnableSession:=True)>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function GetSpeksifikasi_Pembuka() As String

    '    Dim resp As New ResponseRepository

    '    dt = GetSpeksifikasi_PerolehanPembuka()
    '    'resp.SuccessPayload(dt)

    '    Return JsonConvert.SerializeObject(dt)
    'End Function

    'Public Function GetSpeksifikasi_PerolehanPembuka() As DataTable
    '    Dim db = New DBKewConn
    '    Dim param As List(Of SqlParameter)

    '    Dim query As String = "WITH Total_Jumlah_Harga_CTE AS (
    '                                SELECT b.Semak_Buku, b.ID_Syarikat, b.Kod_Pembuka, b.Id_Pembelian, b.Tempoh, b.Ulasan_Pembuka, b.No_Mohon, b.Peratus_Am, 
    '					b.Peratus_Teknikal, b.Ulasan_Harga,FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga--, c.Kod_Gred, c.No_Sykt,
    '                                FROM SMKB_Perolehan_Pembelian_Dtl a
    '                                JOIN  SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
    '                             --JOIN SMKB_Syarikat_Master c on c.ID_Sykt = b.ID_Syarikat
    '                                WHERE b.No_Mohon = 'BS4100000002140923'
    '                                GROUP BY b.Semak_Buku, b.ID_Syarikat, Kod_Pembuka, b.Id_Pembelian, b.Tempoh, b.Ulasan_Pembuka, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, 
    '					b.Ulasan_Harga--, c.Kod_Gred, c.No_Sykt
    '                            )
    '                            SELECT Semak_Buku, ID_Syarikat, Kod_Pembuka, Id_Pembelian, Tempoh, Ulasan_Pembuka, No_Mohon, Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga, --Kod_Gred, No_Sykt,
    '                            ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga ASC) AS Ranking
    '                            FROM Total_Jumlah_Harga_CTE;"

    '    param = New List(Of SqlParameter)
    '    'param.Add(New SqlParameter("@noMohonValue", noMohonValue))
    '    Return db.Read(query, param)
    'End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPenilaian_Harga(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetPenilaian_RecordHarga(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetPenilaian_RecordHarga(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""

        'Dim query As String = "WITH Total_Jumlah_Harga_CTE AS (
        '                        SELECT b.ID_Syarikat, b.Kod_Pembuka, b.Tempoh, (SELECT TOP 1 d.Butiran FROM SMKB_Perolehan_Pembelian_Hdr b
        '                            INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh WHERE b.No_Mohon = @noMohonValue AND d.Kod = 'PO05') AS Jenis_Tempoh,
        '                            b.Ulasan_Pembuka, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, b.Semak_Buku1, b.Semak_Buku2,
        '                            FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga, a.Id_Pembelian AS ID_Pembelian, 
        '                            (SELECT FORMAT(SUM(a.Jumlah_Harga), '0.00') FROM SMKB_Perolehan_Permohonan_Dtl a WHERE a.No_Mohon = @noMohonValue) AS Harga_Bajet
        '                        FROM SMKB_Perolehan_Pembelian_Dtl a
        '                        INNER JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
        '                        WHERE b.No_Mohon = @noMohonValue
        '                        GROUP BY b.ID_Syarikat, Kod_Pembuka, b.Tempoh, b.Ulasan_Pembuka, b.Semak_Buku1, b.Semak_Buku2, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, a.Id_Pembelian
        '                    ), 
        '                    Calculated_Tolakb AS (
        '                        SELECT ID_Syarikat, Kod_Pembuka, Tempoh, 
        '                            Semak_Buku1, Semak_Buku2, Ulasan_Pembuka, No_Mohon, Peratus_Am, ID_Pembelian,Peratus_Teknikal, Ulasan_Harga, Jenis_Tempoh, Total_Jumlah_Harga, Harga_Bajet,
        '                            FORMAT((CAST(Harga_Bajet AS DECIMAL(18,2)) - CAST(Total_Jumlah_Harga AS DECIMAL(18,2))), '0.00') AS Harga_Tolak
        '                        FROM Total_Jumlah_Harga_CTE
        '                    ) 
        '                    SELECT ID_Syarikat, Kod_Pembuka,Tempoh, Ulasan_Pembuka, Semak_Buku1, Semak_Buku2, No_Mohon, 
        '                        Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet, Harga_Tolak,
        '                        Jenis_Tempoh, FORMAT((CAST(Harga_Tolak AS DECIMAL(18,2)) / CAST(Harga_Bajet AS DECIMAL(18,2)) * 100), '0.00') AS Harga_Percent, 
        '                        ID_Pembelian,ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga ASC) AS Ranking 
        '                    FROM Calculated_Tolakb;"

        Dim query As String = "WITH Total_Jumlah_Harga_CTE AS (
                                SELECT b.ID_Syarikat,c.No_Sykt, b.Kod_Pembuka, b.Tempoh, (SELECT TOP 1 d.Butiran FROM SMKB_Perolehan_Pembelian_Hdr b
                                    INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh WHERE b.No_Mohon = @noMohonValue AND d.Kod = 'PO05') AS Jenis_Tempoh,
                                    b.Ulasan_Pembuka, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, b.Semak_Buku1, b.Semak_Buku2,
                                    FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga, a.Id_Pembelian AS ID_Pembelian, 
                                    (SELECT FORMAT(SUM(a.Jumlah_Harga), '0.00') FROM SMKB_Perolehan_Permohonan_Dtl a WHERE a.No_Mohon = @noMohonValue) AS Harga_Bajet
                                FROM SMKB_Perolehan_Pembelian_Dtl a
                                INNER JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
								INNER JOIN SMKB_Syarikat_Master c on c.ID_Sykt = b.ID_Syarikat
                                WHERE b.No_Mohon = @noMohonValue
                                GROUP BY b.ID_Syarikat,c.No_Sykt, Kod_Pembuka, b.Tempoh, b.Ulasan_Pembuka, b.Semak_Buku1, b.Semak_Buku2, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, a.Id_Pembelian
                            ), 
                            Calculated_Tolakb AS (
                                SELECT ID_Syarikat, Kod_Pembuka, No_Sykt, Tempoh, 
                                    Semak_Buku1, Semak_Buku2, Ulasan_Pembuka, No_Mohon, Peratus_Am, ID_Pembelian,Peratus_Teknikal, Ulasan_Harga, Jenis_Tempoh, Total_Jumlah_Harga, Harga_Bajet,
                                    FORMAT((CAST(Harga_Bajet AS DECIMAL(18,2)) - CAST(Total_Jumlah_Harga AS DECIMAL(18,2))), '0.00') AS Harga_Tolak
                                FROM Total_Jumlah_Harga_CTE
                            ) 
                            SELECT ID_Syarikat, Kod_Pembuka, No_Sykt, Tempoh, Ulasan_Pembuka, Semak_Buku1, Semak_Buku2, No_Mohon, 
                                Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet, Harga_Tolak,
                                Jenis_Tempoh, FORMAT((CAST(Harga_Tolak AS DECIMAL(18,2)) / CAST(Harga_Bajet AS DECIMAL(18,2)) * 100), '0.00') AS Harga_Percent, 
                                ID_Pembelian,ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga ASC) AS Ranking 
                            FROM Calculated_Tolakb;"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPenilaian_Teknikal(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetPenilaian_EPTeknikal(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetPenilaian_EPTeknikal(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        'Dim query As String = "SELECT a.No_Mohon, a.Id_Pembelian, a.Kod_Syarikat, a.Kod_Pembuka,a.Tempoh, a.Peratus_Am, a. Peratus_Teknikal,
        '                        RANK() OVER (ORDER BY SUM(b.Jumlah_Harga) ASC) AS RankingHdr, 
        '                        ((SELECT FORMAT(SUM(Jumlah_Harga), '0.00') as Total_Jumlah_Harga FROM SMKB_Perolehan_Pembelian_Dtl WHERE Id_Pembelian = 'PB01')) as Harga_Syarikat, a.Ulasan_Teknikal,
        '                        FORMAT(SUM(b.Jumlah_Harga), '0.00') AS Total_Harga, 
        '                        --(CONVERT(DECIMAL(18, 2), SUM(b.Jumlah_Harga)) - CONVERT(DECIMAL(18, 2), (SELECT SUM(Jumlah_Harga) FROM SMKB_Perolehan_Pembelian_Dtl WHERE Id_Pembelian = 'PB01'), 0)) AS HargaBarang, 
        '                        FORMAT((CONVERT(DECIMAL(18, 2), SUM(b.Jumlah_Harga)) - CONVERT(DECIMAL(18, 2), (SELECT SUM(Jumlah_Harga) FROM SMKB_Perolehan_Pembelian_Dtl WHERE Id_Pembelian = 'PB01'), 0)), '0.00') AS HargaBarang,
        '                        ROUND(((CONVERT(DECIMAL(18, 2), SUM(b.Jumlah_Harga)) - CONVERT(DECIMAL(18, 2), (SELECT SUM(Jumlah_Harga) FROM SMKB_Perolehan_Pembelian_Dtl WHERE Id_Pembelian = 'PB01'))) / NULLIF(CONVERT(DECIMAL(18, 2), SUM(b.Jumlah_Harga)), 0)) * 100, 2) AS Percentage_HargaBarang 
        '                        FROM SMKB_Perolehan_Pembelian_Hdr a 
        '                        JOIN SMKB_Perolehan_Permohonan_Dtl b ON a.No_Mohon = b.No_Mohon 
        '                        --WHERE a.No_Mohon = @noMohonValue AND a.Kod_Syarikat = @kodSyarikat 
        '                        WHERE a.No_Mohon = @noMohonValue
        '                        GROUP BY  a.Id_Pembelian, a.Kod_Syarikat, a.Kod_Pembuka, a.Tempoh, a.No_Mohon, a.Peratus_Am, a. Peratus_Teknikal,a.Ulasan_Teknikal
        '                        ORDER BY RankingHdr"

        Dim query As String = "WITH Total_Jumlah_Harga_CTE AS ( SELECT b.ID_Syarikat, b.Kod_Pembuka, b.Tempoh, b.Ulasan_Teknikal, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, 
                                FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga, a.Id_Pembelian as ID_Pembelian, 
                                (SELECT FORMAT(SUM(a.Jumlah_Harga), '0.00') 
                                FROM SMKB_Perolehan_Permohonan_Dtl a 
                                WHERE a.No_Mohon = @noMohonValue) AS Harga_Bajet
                                FROM SMKB_Perolehan_Pembelian_Dtl a
                                JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
                                INNER JOIN SMKB_Syarikat_Master c on c.ID_Sykt = b.ID_Syarikat
                                --JOIN SMKB_Syarikat_Master c ON c.ID_Sykt = b.ID_Syarikat
                                WHERE b.No_Mohon = @noMohonValue
                                GROUP BY 
                                b.ID_Syarikat, Kod_Pembuka, b.Tempoh, b.Ulasan_Teknikal, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, a.Id_Pembelian), 
                                Calculated_Tolakb AS ( SELECT ID_Syarikat, Kod_Pembuka, Tempoh, Ulasan_Teknikal, No_Mohon, Peratus_Am, ID_Pembelian,
                                Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet,FORMAT((CAST(Harga_Bajet AS DECIMAL(18,2)) - CAST(Total_Jumlah_Harga AS DECIMAL(18,2))), '0.00') AS Harga_Tolak
                                FROM Total_Jumlah_Harga_CTE ) 
                                SELECT ID_Syarikat, Kod_Pembuka, Tempoh, Ulasan_Teknikal, No_Mohon, Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet, Harga_Tolak,
                                FORMAT((CAST(Harga_Tolak AS DECIMAL(18,2)) / CAST(Harga_Bajet AS DECIMAL(18,2)) * 100), '0.00') AS Harga_Percent, ID_Pembelian,
                                ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga ASC) AS Ranking FROM Calculated_Tolakb;"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        'param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPenilaian_Pengesyoran(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetPenilaian_RecordPengesyoran(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetPenilaian_RecordPengesyoran(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        'Dim query As String = "WITH Total_Jumlah_Harga_CTE AS ( SELECT b.ID_Syarikat, b.Kod_Pembuka, b.Tempoh, b.Syor_Nilai_Harga, b.Syor_Teknikal, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, b.Ulasan_Teknikal, b.Ulasan_Syor, b.Semak_Buku1, b.Semak_Buku2,
        '                        FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga, a.Id_Pembelian as ID_Pembelian, (SELECT TOP 1 d.Butiran FROM SMKB_Perolehan_Pembelian_Hdr b
        '                            INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh WHERE b.No_Mohon = @noMohonValue AND d.Kod = 'PO05') AS Jenis_Tempoh,
        '                        (SELECT FORMAT(SUM(a.Jumlah_Harga), '0.00') 
        '                        FROM SMKB_Perolehan_Permohonan_Dtl a 
        '                        WHERE a.No_Mohon = @noMohonValue) AS Harga_Bajet
        '                        FROM SMKB_Perolehan_Pembelian_Dtl a
        '                        JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
        '                        --JOIN SMKB_Syarikat_Master c ON c.ID_Sykt = b.ID_Syarikat
        '--INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh
        '                        WHERE b.No_Mohon = @noMohonValue --AND d.Kod = 'PO05'
        '                        GROUP BY 
        '                        b.ID_Syarikat, Kod_Pembuka, b.Tempoh, b.Semak_Buku1, b.Semak_Buku2, Jenis_Tempoh, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, b.Syor_Nilai_Harga, b.Syor_Teknikal, b.Ulasan_Teknikal, b.Ulasan_Syor, a.Id_Pembelian), 
        '                        Calculated_Tolakb AS ( SELECT ID_Syarikat, Kod_Pembuka, Tempoh, Semak_Buku1, Semak_Buku2, Jenis_Tempoh, Ulasan_Teknikal, Syor_Nilai_Harga, Ulasan_Syor, Syor_Teknikal, No_Mohon, Peratus_Am, ID_Pembelian,
        '                        Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet,FORMAT((CAST(Harga_Bajet AS DECIMAL(18,2)) - CAST(Total_Jumlah_Harga AS DECIMAL(18,2))), '0.00') AS Harga_Tolak
        '                        FROM Total_Jumlah_Harga_CTE ) 
        '                        SELECT ID_Syarikat, Kod_Pembuka, Tempoh, Jenis_Tempoh, Ulasan_Teknikal, Ulasan_Syor, Semak_Buku1, Semak_Buku2, No_Mohon, Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet, Harga_Tolak, Syor_Nilai_Harga, Syor_Teknikal,
        '                        FORMAT((CAST(Harga_Tolak AS DECIMAL(18,2)) / CAST(Harga_Bajet AS DECIMAL(18,2)) * 100), '0.00') AS Harga_Percent, ID_Pembelian,
        '                        ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga DESC) AS Ranking FROM Calculated_Tolakb;"

        Dim query As String = "WITH Total_Jumlah_Harga_CTE AS ( SELECT b.ID_Syarikat, c.No_Sykt, b.Kod_Pembuka, b.Tempoh, b.Syor_Nilai_Harga, b.Syor_Teknikal, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, b.Ulasan_Teknikal, b.Ulasan_Syor, b.Semak_Buku1, b.Semak_Buku2,
                                FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga, a.Id_Pembelian as ID_Pembelian, (SELECT TOP 1 d.Butiran FROM SMKB_Perolehan_Pembelian_Hdr b
                                INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh WHERE b.No_Mohon = @noMohonValue AND d.Kod = 'PO05') AS Jenis_Tempoh,
                                (SELECT FORMAT(SUM(a.Jumlah_Harga), '0.00') 
                                FROM SMKB_Perolehan_Permohonan_Dtl a 
                                WHERE a.No_Mohon = @noMohonValue) AS Harga_Bajet
                                FROM SMKB_Perolehan_Pembelian_Dtl a
                                JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
                                INNER JOIN SMKB_Syarikat_Master c on c.ID_Sykt = b.ID_Syarikat
								--INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh
                                WHERE b.No_Mohon = @noMohonValue --AND d.Kod = 'PO05'
                                GROUP BY 
                                b.ID_Syarikat, c.No_Sykt, Kod_Pembuka, b.Tempoh, b.Semak_Buku1, b.Semak_Buku2, Jenis_Tempoh, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Harga, b.Syor_Nilai_Harga, b.Syor_Teknikal, b.Ulasan_Teknikal, b.Ulasan_Syor, a.Id_Pembelian), 
                                Calculated_Tolakb AS ( SELECT ID_Syarikat, Kod_Pembuka,No_Sykt, Tempoh, Semak_Buku1, Semak_Buku2, Jenis_Tempoh, Ulasan_Teknikal, Syor_Nilai_Harga, Ulasan_Syor, Syor_Teknikal, No_Mohon, Peratus_Am, ID_Pembelian,
                                Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet,FORMAT((CAST(Harga_Bajet AS DECIMAL(18,2)) - CAST(Total_Jumlah_Harga AS DECIMAL(18,2))), '0.00') AS Harga_Tolak
                                FROM Total_Jumlah_Harga_CTE ) 
                                SELECT ID_Syarikat, Kod_Pembuka, No_Sykt, Tempoh, Jenis_Tempoh, Ulasan_Teknikal, Ulasan_Syor, Semak_Buku1, Semak_Buku2, No_Mohon, Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet, Harga_Tolak, Syor_Nilai_Harga, Syor_Teknikal,
                                FORMAT((CAST(Harga_Tolak AS DECIMAL(18,2)) / CAST(Harga_Bajet AS DECIMAL(18,2)) * 100), '0.00') AS Harga_Percent, ID_Pembelian,
                                ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga DESC) AS Ranking FROM Calculated_Tolakb;"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPenilaian_Perlantikan(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetPenilaian_RecordPerlantikan(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetPenilaian_RecordPerlantikan(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        'Dim query As String = "WITH Total_Jumlah_Harga_CTE AS ( SELECT b.ID_Syarikat, b.Kod_Pembuka, b.Tempoh, d.Butiran, b.Syor_Nilai_Harga, b.Syor_Teknikal, b.Keputusan_Syor, b.Ulasan_Lantik, b.No_Mohon, b.Peratus_Am, 
        'b.Peratus_Teknikal, b.Ulasan_Harga, b.Ulasan_Teknikal, b.Ulasan_Syor, b.Semak_Buku1, b.Semak_Buku2, 
        '                        FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga, a.Id_Pembelian as ID_Pembelian, 
        '                        (SELECT FORMAT(SUM(a.Jumlah_Harga), '0.00') 
        '                        FROM SMKB_Perolehan_Permohonan_Dtl a 
        '                        WHERE a.No_Mohon = @noMohonValue) AS Harga_Bajet
        '                        FROM SMKB_Perolehan_Pembelian_Dtl a
        '                        JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
        '                        JOIN SMKB_Syarikat_Master c ON c.ID_Sykt = b.ID_Syarikat
        'INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh
        '                        WHERE d.Kod = 'PO05' AND b.No_Mohon = @noMohonValue AND b.Keputusan_Syor = '1'
        '                        GROUP BY b.ID_Syarikat, Kod_Pembuka, b.Tempoh, d.Butiran, b.Semak_Buku1, b.Semak_Buku2, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Lantik,
        'b.Ulasan_Harga, b.Syor_Nilai_Harga, b.Syor_Teknikal, b.Keputusan_Syor, b.Ulasan_Teknikal, b.Ulasan_Syor, a.Id_Pembelian), 
        '                        Calculated_Tolakb AS ( SELECT ID_Syarikat, Kod_Pembuka, Tempoh, Semak_Buku1, Semak_Buku2, Butiran, Ulasan_Teknikal, Syor_Nilai_Harga, Ulasan_Lantik,
        'Ulasan_Syor, Syor_Teknikal, Keputusan_Syor, No_Mohon, Peratus_Am, ID_Pembelian, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet,
        'FORMAT((CAST(Harga_Bajet AS DECIMAL(18,2)) - CAST(Total_Jumlah_Harga AS DECIMAL(18,2))), '0.00') AS Harga_Tolak
        '                        FROM Total_Jumlah_Harga_CTE ) 
        '                        SELECT ID_Syarikat, Kod_Pembuka, Tempoh, Butiran, Ulasan_Teknikal, Ulasan_Syor, Semak_Buku1, Semak_Buku2, No_Mohon, Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Ulasan_Lantik,
        'Total_Jumlah_Harga,Harga_Bajet, Harga_Tolak, Syor_Nilai_Harga, Syor_Teknikal, Keputusan_Syor,
        '                        FORMAT((CAST(Harga_Tolak AS DECIMAL(18,2)) / CAST(Harga_Bajet AS DECIMAL(18,2)) * 100), '0.00') AS Harga_Percent, ID_Pembelian,
        '                        ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga DESC) AS Ranking FROM Calculated_Tolakb;"

        Dim query As String = "	WITH Total_Jumlah_Harga_CTE AS ( SELECT b.ID_Syarikat, c.No_Sykt, b.Kod_Pembuka, b.Tempoh, d.Butiran, b.Syor_Nilai_Harga, b.Syor_Teknikal, b.Keputusan_Syor, b.Ulasan_Lantik, b.No_Mohon, b.Peratus_Am, 
								b.Peratus_Teknikal, b.Ulasan_Harga, b.Ulasan_Teknikal, b.Ulasan_Syor, b.Semak_Buku1, b.Semak_Buku2, 
                                FORMAT(SUM(a.Jumlah_Harga), '0.00') AS Total_Jumlah_Harga, a.Id_Pembelian as ID_Pembelian, 
                                (SELECT FORMAT(SUM(a.Jumlah_Harga), '0.00') 
                                FROM SMKB_Perolehan_Permohonan_Dtl a 
                                WHERE a.No_Mohon = @noMohonValue) AS Harga_Bajet
                                FROM SMKB_Perolehan_Pembelian_Dtl a
                                JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.Id_Pembelian = a.Id_Pembelian
                               INNER JOIN SMKB_Syarikat_Master c on c.ID_Sykt = b.ID_Syarikat
								INNER JOIN SMKB_Lookup_Detail d ON d.Kod_Detail = b.Jenis_Tempoh
                                WHERE d.Kod = 'PO05' AND b.No_Mohon = @noMohonValue AND b.Keputusan_Syor = '1'
                                GROUP BY b.ID_Syarikat, Kod_Pembuka, c.No_Sykt, b.Tempoh, d.Butiran, b.Semak_Buku1, b.Semak_Buku2, b.No_Mohon, b.Peratus_Am, b.Peratus_Teknikal, b.Ulasan_Lantik,
								b.Ulasan_Harga, b.Syor_Nilai_Harga, b.Syor_Teknikal, b.Keputusan_Syor, b.Ulasan_Teknikal, b.Ulasan_Syor, a.Id_Pembelian), 
                                Calculated_Tolakb AS ( SELECT ID_Syarikat, Kod_Pembuka,No_Sykt, Tempoh, Semak_Buku1, Semak_Buku2, Butiran, Ulasan_Teknikal, Syor_Nilai_Harga, Ulasan_Lantik,
								Ulasan_Syor, Syor_Teknikal, Keputusan_Syor, No_Mohon, Peratus_Am, ID_Pembelian, Peratus_Teknikal, Ulasan_Harga, Total_Jumlah_Harga,Harga_Bajet,
								FORMAT((CAST(Harga_Bajet AS DECIMAL(18,2)) - CAST(Total_Jumlah_Harga AS DECIMAL(18,2))), '0.00') AS Harga_Tolak
                                FROM Total_Jumlah_Harga_CTE ) 
                                SELECT ID_Syarikat, Kod_Pembuka,No_Sykt, Tempoh, Butiran, Ulasan_Teknikal, Ulasan_Syor, Semak_Buku1, Semak_Buku2, No_Mohon, Peratus_Am, Peratus_Teknikal, Ulasan_Harga, Ulasan_Lantik,
								Total_Jumlah_Harga,Harga_Bajet, Harga_Tolak, Syor_Nilai_Harga, Syor_Teknikal, Keputusan_Syor,
                                FORMAT((CAST(Harga_Tolak AS DECIMAL(18,2)) / CAST(Harga_Bajet AS DECIMAL(18,2)) * 100), '0.00') AS Harga_Percent, ID_Pembelian,
                                ROW_NUMBER() OVER (ORDER BY Total_Jumlah_Harga DESC) AS Ranking FROM Calculated_Tolakb;"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasiDetail(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        'If isClicked = False Then
        '    Return JsonConvert.SerializeObject(New DataTable)
        'End If


        dt = GetSpeksifikasi_PerolehanDetail(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasi_PerolehanDetail(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""

        Dim query As String = "SELECT B.No_Mohon,a.Id_Dtl,a.Id_Mohon_Dtl,a.Jenama,a.Kod_Negara_Pembuat,a.Model,FORMAT(a.Jumlah_Harga, '0.00') AS Jumlah_Harga,FORMAT(a.Harga_Seunit, '0.00') AS Harga_Seunit,
                                c.Butiran,CONVERT(INT, c.Kuantiti) AS Kuantiti,d.Butiran AS Ukuran,(SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE a.Kod_Negara_Pembuat = lp.Kod_Detail AND Kod = '0001') AS ButiranNegara,a.Id_Pembelian
                                FROM SMKB_Perolehan_Pembelian_Dtl a
                                JOIN SMKB_Perolehan_Permohonan_Dtl c ON c.Id_Mohon_Dtl = a.Id_Mohon_Dtl 
                                JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.No_Mohon = c.No_Mohon
                                JOIN SMKB_Lookup_Detail d ON c.Ukuran = d.Kod_Detail
                                WHERE d.Kod = 'PO06' AND b.No_Mohon = @noMohonValue
                                GROUP BY a.Jenama, a.Kod_Negara_Pembuat, a.Model, a.Jumlah_Harga, a.Harga_Seunit, c.Butiran, c.Kuantiti, d.Butiran, a.Id_Mohon_Dtl, a.Id_Dtl, a.Id_Pembelian, B.No_Mohon;"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasi_Pengesyoran(ByVal IDPembelianDtl As String, IDSyarikat As String) As String

        Dim resp As New ResponseRepository

        'If isClicked = False Then
        '    Return JsonConvert.SerializeObject(New DataTable)
        'End If


        dt = GetSpeksifikasi_PengesyoranDetail(IDPembelianDtl, IDSyarikat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasi_PengesyoranDetail(IDPembelianDtl As String, IDSyarikat As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""

        Dim query As String = ""

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@IDPembelianDtl", IDPembelianDtl))
        param.Add(New SqlParameter("@IDSyarikat", IDSyarikat))


        Return db.Read(query, param)
    End Function

    'Load DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadKelulusan() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadKelulusan()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadKelulusan() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT  a.No_Mohon,
		                        FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, 
		                        a.Tujuan,
		                        a.Skop,
		                        a.Jenis_Barang, kategori.Butiran AS kategori_butiran, 
		                        a.Kod_Ptj_Mohon,
		                        FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, 
		                        FORMAT(a.Perolehan_Terdahulu,'0.00') AS Perolehan_Terdahulu,
		                        a.Justifikasi,
		                        FORMAT(SUM(b.Jumlah_Harga),'0.00') AS Total_Harga
                        FROM SMKB_Perolehan_Permohonan_Hdr AS a
                        INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                        INNER JOIN SMKB_Perolehan_Permohonan_Dtl AS b ON a.No_Mohon = b.No_Mohon
                        WHERE a.Flag_Lulus IS NULL
                        GROUP BY a.No_Mohon, a.Tujuan, a.Justifikasi, a.Skop, a.Kod_Ptj_Mohon, a.Jenis_Barang, kategori.Butiran, 
                        FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy'), FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy'),FORMAT(a.Perolehan_Terdahulu,'0.00')
                        ORDER BY No_Mohon DESC"

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanHargaDetail(Perolehan_Mesyuarat_JKD As Penilaian_Harga_EP) As String
        Dim resp As New ResponseRepository
        'Dim hasFailed As Boolean = False ' Flag to track failure

        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePenilaianHarga(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            'hasFailed = True ' Set flag to true
        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_JKD)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanFlag_PenilaianHarga(Perolehan_Mesyuarat_JKD As Penilaian_Harga_EP) As String
        Dim resp As New ResponseRepository

        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Update_FlagHarga(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Update_MesyuaratDtl_Harga(Perolehan_Mesyuarat_JKD.IDMesy, Perolehan_Mesyuarat_JKD.noMohonValue) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.", "00", Perolehan_Mesyuarat_JKD)
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Function Update_FlagHarga(Perolehan_Mesyuarat_JKD As Penilaian_Harga_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Flag_PHarga = '1' WHERE No_Mohon = @noMohonValue"

        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@noMohonValue", Perolehan_Mesyuarat_JKD.noMohonValue))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Function Update_MesyuaratDtl_Harga(IDMesy As String, noMohonValue As String)
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Mesyuarat_Dtl SET Status_Dok='50' WHERE No_Mohon = @noMohonValue AND ID_Mesy = @IDMesy"

        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@IDMesy", IDMesy))
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Function UpdatePenilaianHarga(Perolehan_Mesyuarat_JKD As Penilaian_Harga_EP) As String
        Dim db As New DBKewConn
        'Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Syor_Nilai_Harga = '1', Ulasan_Harga = @txtUlasanHarga 
        '                        WHERE Kod_Pembuka = '2/2'"

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Syor_Nilai_Harga = '1', Ulasan_Harga = @txtUlasanHarga, 
                                Rank_Nilai_Harga = @txtRankHarga, Status_Harga = '1'
                                WHERE Kod_Pembuka = @kodPembuka and Id_Pembelian = @IDPembelianDtl"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@txtUlasanHarga", Perolehan_Mesyuarat_JKD.txtUlasanHarga))
        param.Add(New SqlParameter("@kodPembuka", Perolehan_Mesyuarat_JKD.kodPembuka))
        param.Add(New SqlParameter("@txtRankHarga", Perolehan_Mesyuarat_JKD.txtRankHarga))
        param.Add(New SqlParameter("@IDPembelianDtl", Perolehan_Mesyuarat_JKD.IDPembelianDtl))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Function UpdatePenilaianHargaDtl(Perolehan_Mesyuarat_JKD As Penilaian_Harga_EP) As String
        Dim db As New DBKewConn
        'Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Syor_Nilai_Harga = '1', Ulasan_Harga = @txtUlasanHarga 
        '                        WHERE Kod_Pembuka = '2/2'"

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dtl SET Ulasan_Harga = @txtUlasanHargaDtl, 
                                Rank_Harga = @txtRankHargaDtl, Status = '1'
                                WHERE Id_Pembelian = @IDPembelianDtl"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@txtUlasanHargaDtl", Perolehan_Mesyuarat_JKD.txtUlasanHargaDtl))
        param.Add(New SqlParameter("@txtRankHargaDtl", Perolehan_Mesyuarat_JKD.txtRankHargaDtl))
        param.Add(New SqlParameter("@IDPembelianDtl", Perolehan_Mesyuarat_JKD.IDPembelianDtl))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanTeknikalDetail(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim resp As New ResponseRepository
        'Dim hasFailed As Boolean = False ' Flag to track failure

        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePenilaianTeknikal(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            'hasFailed = True ' Set flag to true
            Return JsonConvert.SerializeObject(resp.GetResult()) ' Return immediately
        End If

        '' Continue only if UpdatePenilaianTeknikal succeeds
        'If Update_FlagTeknikal(Perolehan_Mesyuarat_JKD) <> "OK" Then
        '    resp.Failed("Gagal Menyimpan order")
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        'End If

        ' If both updates succeed, return success response
        resp.Success("Rekod berjaya dikemaskini", "00", Perolehan_Mesyuarat_JKD)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanFlag_PenilaianTeknikal(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim resp As New ResponseRepository

        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Update_FlagTeknikal(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")

        End If


        resp.Success("Data berjaya dikemaskini.")


        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function Update_FlagTeknikal(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Flag_PTeknikal = '1', Status_Dok = '52' WHERE No_Mohon = @noMohonValue"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@noMohonValue", Perolehan_Mesyuarat_JKD.noMohonValue))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Function UpdatePenilaianTeknikal(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Syor_Teknikal = '1', Ulasan_Teknikal = @txtUlasanTeknikal, Status_Teknikal = '1',
                                Peratus_Am = @percentAm, Peratus_Teknikal = @percentTek WHERE Kod_Pembuka = @kodPembuka AND Id_Pembelian = @idPembelian"

        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@txtUlasanTeknikal", Perolehan_Mesyuarat_JKD.txtUlasanTeknikal))
        param.Add(New SqlParameter("@kodPembuka", Perolehan_Mesyuarat_JKD.kodPembuka))
        param.Add(New SqlParameter("@percentAm", Perolehan_Mesyuarat_JKD.percentAm))
        param.Add(New SqlParameter("@percentTek", Perolehan_Mesyuarat_JKD.percentTek))
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanTeknikalDetailItem(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePenilaian_TeknikalUlasan(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePenilaian_ItemTeknikal(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        'resp.Success("Rekod berjaya dikemaskini", "00", Perolehan_Mesyuarat_JKD)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdatePenilaian_ItemTeknikal(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr Syor_Teknikal = '1', Status_Teknikal = '1',
                                Peratus_Am = @percentAm, Peratus_Teknikal = @percentTek WHERE Kod_Pembuka = @kodPembuka"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        'param.Add(New SqlParameter("@txtUlasanTeknikal", Perolehan_Mesyuarat_JKD.txtUlasanTeknikal))
        param.Add(New SqlParameter("@kodPembuka", Perolehan_Mesyuarat_JKD.kodPembuka))
        param.Add(New SqlParameter("@percentAm", Perolehan_Mesyuarat_JKD.percentAm))
        param.Add(New SqlParameter("@percentTek", Perolehan_Mesyuarat_JKD.percentTek))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Function UpdatePenilaian_TeknikalUlasan(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dtl SET Syor_Harga = '1', Ulasan_Harga = @txtUlasanHarga WHERE Id_Mohon_Dtl = @idMohonDtl"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@txtUlasanHarga", Perolehan_Mesyuarat_JKD.txtUlasanHarga))
        param.Add(New SqlParameter("@idMohonDtl", Perolehan_Mesyuarat_JKD.idMohonDtl))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanTeknikalDetailQA(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateSkorAm(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        resp.Success("Data berjaya dikemaskini.")
        'resp.Success("Rekod berjaya dikemaskini", "00", Perolehan_Mesyuarat_JKD)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateSkorAm(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Jawapan_Am SET Skor = @skorSpekAm WHERE Id_Am = @IdAmJawapan"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@skorSpekAm", Perolehan_Mesyuarat_JKD.skorSpekAm))
        param.Add(New SqlParameter("@IdAmJawapan", Perolehan_Mesyuarat_JKD.IdAmJawapan))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanTeknikalDetailSkor(Perolehan_Teknikal_Skor As Penilaian_Teknikal_EP) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Teknikal_Skor Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateSkorTeknikal(Perolehan_Teknikal_Skor) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        resp.Success("Data berjaya dikemaskini.")
        'resp.Success("Rekod berjaya dikemaskini", "00", Perolehan_Mesyuarat_JKD)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateSkorTeknikal(Perolehan_Teknikal_Skor As Penilaian_Teknikal_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Jawapan_Teknikal SET Skor = @skorSpekTeknikal WHERE Id_Teknikal = @idTeknikal"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@skorSpekTeknikal", Perolehan_Teknikal_Skor.skorSpekTeknikal))
        param.Add(New SqlParameter("@idTeknikal", Perolehan_Teknikal_Skor.idTeknikal))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanPembukaDetail(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePenilaianPembuka(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_JKD)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdatePenilaianPembuka(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Kod_Pembuka = @sequenceNumber, Ulasan_Pembuka = @txtUlasanPembuka
                               WHERE ID_Syarikat = @noSyarikat AND Id_Pembelian = @idPembelian"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@sequenceNumber", Perolehan_Mesyuarat_JKD.sequenceNumber))
        param.Add(New SqlParameter("@txtUlasanPembuka", Perolehan_Mesyuarat_JKD.txtUlasanPembuka))
        param.Add(New SqlParameter("@noSyarikat", Perolehan_Mesyuarat_JKD.noSyarikat))
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))

        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasiTeknikal() As String

        Dim resp As New ResponseRepository

        dt = GetSpeksifikasi_PerolehanTeknikal()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasi_PerolehanTeknikal() As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "select a.*, b.Butiran as Ukuran_Nama from SMKB_Perolehan_Permohonan_Dtl a
        '                        join SMKB_Lookup_Detail b on b.Kod_Detail = a.Ukuran
        '                        where Id_Mohon_Dtl = '2023-09-18 23:29:32.6900000' AND b.Kod = 'PO06'"

        'Dim query As String = "select a.*,a.Id_Mohon_Dtl, b.Butiran as Ukuran_Nama, d.Skor from SMKB_Perolehan_Permohonan_Dtl a
        '                        join SMKB_Lookup_Detail b on b.Kod_Detail = a.Ukuran
        '                        join SMKB_Perolehan_Pembelian_Dtl c on c.Id_Mohon_Dtl = a.Id_Mohon_Dtl
        '                        join SMKB_Perolehan_Jawapan_Am d on d.Id_Pembelian = c.Id_Pembelian
        '                        where a.Id_Mohon_Dtl = '2023-09-18 23:29:32.6900000' AND b.Kod = 'PO06'"

        'Dim query As String = "select a.*,a.Id_Mohon_Dtl, b.Butiran as Ukuran_Nama, d.Skor from SMKB_Perolehan_Permohonan_Dtl a
        '                        join SMKB_Lookup_Detail b on b.Kod_Detail = a.Ukuran
        '                        join SMKB_Perolehan_Pembelian_Dtl c on c.Id_Mohon_Dtl = a.Id_Mohon_Dtl
        '                        join SMKB_Perolehan_Jawapan_Am d on d.Id_Pembelian = c.Id_Pembelian
        '                        where a.Id_Mohon_Dtl = '2023-09-18 23:29:32.6900000' AND b.Kod = 'PO06'"

        Dim query As String = "SELECT a.*, CONVERT(INT, a.Kuantiti) AS Kuantiti, b.*, e.Id_Teknikal, c.Butiran as Ukuran_Nama, d.Butiran As Negara, e.Skor FROM SMKB_Perolehan_Permohonan_Dtl a 
								join SMKB_Perolehan_Pembelian_Dtl b on b.Id_Mohon_Dtl = a.Id_Mohon_Dtl
								join SMKB_Lookup_Detail c on c.Kod_Detail = a.Ukuran
								join SMKB_Lookup_Detail d on d.Kod_Detail = b.Kod_Negara_Pembuat
								JOIN SMKB_Perolehan_Jawapan_Teknikal e on e.Id_Pembelian = b.Id_Pembelian
								where c.Kod = 'PO06' and e.Id_Teknikal = '2024-02-08 18:01:56.9830000'"


        Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@idMohonDtl", idMohonDtl))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasiAmSyarikat(ByVal noMohonValue As String, idPembelian As String) As String

        Dim resp As New ResponseRepository

        dt = GetSpeksifikasiDtl_PerolehanAm(noMohonValue, idPembelian)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasiDtl_PerolehanAm(noMohonValue As String, idPembelian As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        'Dim query As String = "SELECT DISTINCT A.No_Mohon, A.Kod_Spesifikasi, B.Butiran
        '                                     FROM SMKB_Perolehan_Spesifikasi_Am A
        '                                     INNER JOIN SMKB_Perolehan_Spesifikasi B ON B.Kod = A.Kod_Spesifikasi
        '                                     WHERE No_Mohon = @noMohonValue"

        Dim query As String = "SELECT DISTINCT A.No_Mohon, A.Kod_Spesifikasi, B.Butiran, SUM(CONVERT(int, c.Skor)) as JumSkor
        FROM SMKB_Perolehan_Spesifikasi_Am A
        INNER JOIN SMKB_Perolehan_Spesifikasi B ON B.Kod = A.Kod_Spesifikasi
        left join SMKB_Perolehan_Jawapan_Am C on c.Id_Am = a.Id_Am
        WHERE A.No_Mohon = @noMohonValue and c.Id_Pembelian = @idPembelian
        GROUP BY A.No_Mohon, A.Kod_Spesifikasi, B.Butiran"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        'param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        Return db.Read(query, param)
    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasi_TeknikalSyarikat(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetRecordSpeksifikasi_TeknikalSyarikat(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecordSpeksifikasi_TeknikalSyarikat(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        'Dim query As String = "SELECT DISTINCT A.Id_Mohon_Dtl, A.No_Mohon, A.Butiran, A.Jumlah_Harga, B.Jenama, B.Model, B.Kod_Negara_Pembuat, CONVERT(INT, A.Kuantiti) AS Kuantiti,
        '                        (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE B.Kod_Negara_Pembuat = lp.Kod_Detail AND Kod = '0001') AS ButiranNegara,
        '(SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Ukuran = lp.Kod_Detail AND Kod = 'PO06') AS Ukuran
        '                        FROM SMKB_Perolehan_Permohonan_Dtl A
        '                        INNER JOIN SMKB_Perolehan_Pembelian_Dtl B ON B.Id_Mohon_Dtl = A.Id_Mohon_Dtl
        '                        INNER JOIN SMKB_Perolehan_Spesifikasi_Teknikal C ON C.Id_Mohon_Dtl = B.Id_Mohon_Dtl
        '                        WHERE C.No_Mohon = @noMohonValue"

        Dim query As String = "SELECT A.Id_Mohon_Dtl, A.No_Mohon, A.Butiran, A.Jumlah_Harga, B.Jenama, B.Model, B.Kod_Negara_Pembuat, CONVERT(INT, A.Kuantiti) AS Kuantiti,
        SUM(CONVERT(int, d.Skor)) as JumSkorTek,
        (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE B.Kod_Negara_Pembuat = lp.Kod_Detail AND Kod = '0001') AS ButiranNegara,
        (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Ukuran = lp.Kod_Detail AND Kod = 'PO06') AS Ukuran
        FROM SMKB_Perolehan_Permohonan_Dtl A
        INNER JOIN SMKB_Perolehan_Pembelian_Dtl B ON B.Id_Mohon_Dtl = A.Id_Mohon_Dtl
        INNER JOIN SMKB_Perolehan_Spesifikasi_Teknikal C ON C.Id_Mohon_Dtl = B.Id_Mohon_Dtl
        left join SMKB_Perolehan_Jawapan_Teknikal D on D.Id_Teknikal = c.Id_Teknikal
        WHERE C.No_Mohon = @noMohonValue 
        GROUP BY A.Id_Mohon_Dtl, A.No_Mohon, A.Butiran, A.Jumlah_Harga, B.Jenama, B.Model, B.Kod_Negara_Pembuat, A.Kuantiti, a.Ukuran"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        'param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasiAmChildSyarikat(ByVal noMohonValue As String, txtKodSpek As String, idPembelian As String) As String
        Dim resp As New ResponseRepository
        dt = GetSpeksifikasiDtl_PerolehanAmChild(noMohonValue, txtKodSpek, idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasiDtl_PerolehanAmChild(noMohonValue As String, txtKodSpek As String, idPembelian As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        Dim query As String = "SELECT A.id_am, A.no_mohon,kod_spesifikasi,Butiran,Wajaran, B.Jawapan, b.Skor, b.Id_Jawapan_Am, C.Id_Pembelian,  ((SELECT SUM(Wajaran) as TotalWajaran FROM SMKB_Perolehan_Spesifikasi_Am WHERE No_Mohon = @noMohonValue)) as Total_Wajaran
                                FROM SMKB_Perolehan_Spesifikasi_Am A
                                LEFT JOIN SMKB_Perolehan_Jawapan_Am B ON B.Id_Am = A.Id_Am
								JOIN SMKB_Perolehan_Pembelian_Hdr c ON  A.no_mohon = c.No_Mohon
                                WHERE kod_spesifikasi = @txtKodSpek and A.no_mohon = @noMohonValue and c.Id_Pembelian = @idPembelian
                                ORDER by A.id_am"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@txtKodSpek", txtKodSpek))
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        param.Add(New SqlParameter("@idPembelian", idPembelian))
        'param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasiTeknikalDtl(ByVal idMohonDtl As String) As String

        Dim resp As New ResponseRepository

        dt = GetSpeksifikasiDtl_PerolehanTeknikal(idMohonDtl)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasiDtl_PerolehanTeknikal(idMohonDtl As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        'Dim query As String = "select a.Kod_Pembuka, a.Kod_Syarikat,a.No_Mohon, b.Id_Mohon_Dtl, b.Jenama, b.Kod_Negara_Pembuat, b.Model, e.Butiran As Negara, d.Butiran as Ukuran, 
        '                        CONVERT(INT, c.Kuantiti) AS Kuantiti, b.Id_Dtl, b.Id_Mohon_Dtl, a.Ulasan_Teknikal
        '                        from SMKB_Perolehan_Pembelian_Hdr a
        '                        join SMKB_Perolehan_Pembelian_Dtl b on b.Id_Pembelian = a.Id_Pembelian
        '                        join SMKB_Perolehan_Permohonan_Dtl c on c.Id_Mohon_Dtl = b.Id_Mohon_Dtl
        '                        join SMKB_Lookup_Detail e on e.Kod_Detail = b.Kod_Negara_Pembuat
        '                        join SMKB_Lookup_Detail d on d.Kod_Detail = c.Ukuran
        '                        where b.Id_Mohon_Dtl = '2023-09-18 23:29:32.6900000' AND d.Kod = 'PO06'"

        Dim query As String = "select a.*, b.*, e.Butiran As Negara, b.Ulasan_Harga as Ulasan4Teknikal from SMKB_Perolehan_Pembelian_Hdr a
								inner join SMKB_Perolehan_Pembelian_Dtl b on a.Id_Pembelian = b.Id_Pembelian
								join SMKB_Lookup_Detail e on e.Kod_Detail = b.Kod_Negara_Pembuat
								where b.Id_Mohon_Dtl = @idMohonDtl and a.Kod_Syarikat = 'AB01'"


        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@idMohonDtl", idMohonDtl))
        'param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSKorAm(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetSkor_SpekAm(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSkor_SpekAm(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        'Dim query As String = "select a.Kod_Spesifikasi, a.Wajaran, b.Butiran, a.Butiran as Butiran_Am, d.Skor, d.Jawapan from SMKB_Perolehan_Spesifikasi_Am a
        '                        JOIN SMKB_Perolehan_Spesifikasi b on b.Kod = a.Kod_Spesifikasi
        '                        join SMKB_Perolehan_Pembelian_Hdr c on c.No_Mohon = a.No_Mohon
        '                        join SMKB_Perolehan_Jawapan_Am d on d.Id_Pembelian = c.Id_Pembelian
        '                        WHERE a.No_Mohon = 'BS4100000002140923' AND c.Kod_Syarikat = 'AB01'"

        Dim query As String = "select b.No_Mohon, MIN(CONVERT(smalldatetime, b.Id_Am)) AS Id_Am_Jawapan, f.Butiran as Butiran_Spek, b.Kod_Spesifikasi, b.Wajaran, c.Id_Pembelian FROM SMKB_Perolehan_Spesifikasi_Am b 
                                JOIN SMKB_Perolehan_Jawapan_Am d ON CONVERT(smalldatetime, b.Id_Am) = d.Id_Am
							    join SMKB_Perolehan_Spesifikasi f on f.Kod = b.Kod_Spesifikasi
	                            JOIN SMKB_Perolehan_Pembelian_Hdr c ON b.No_Mohon = c.No_Mohon
								--WHERE c.Kod_Syarikat = @kodSyarikat AND b.No_Mohon = @noMohonValue
								WHERE b.No_Mohon = @noMohonValue
								group by b.Kod_Spesifikasi, f.Butiran, b.Wajaran, b.No_Mohon, c.Id_Pembelian"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSKorAmChild(ByVal noMohonValue As String, txtKodSpek As String) As String

        Dim resp As New ResponseRepository

        dt = GetSkor_SpekAmChild(noMohonValue, txtKodSpek)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSkor_SpekAmChild(noMohonValue As String, txtKodSpek As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""

        'Dim query As String = "select a.Kod_Spesifikasi, a.Wajaran, b.Butiran, a.Butiran as Butiran_Am, d.Skor, d.Jawapan from SMKB_Perolehan_Spesifikasi_Am a
        '                        JOIN SMKB_Perolehan_Spesifikasi b on b.Kod = a.Kod_Spesifikasi
        '                        join SMKB_Perolehan_Pembelian_Hdr c on c.No_Mohon = a.No_Mohon
        '                        join SMKB_Perolehan_Jawapan_Am d on d.Id_Pembelian = c.Id_Pembelian
        '                        WHERE a.No_Mohon = 'BS4100000002140923' --AND c.Kod_Syarikat = 'AB01' "

        Dim query As String = "SELECT b.*, d.*, CONVERT(smalldatetime, b.Id_Am) as Id_Am_Jawapan,
                                ((SELECT SUM(Wajaran) as TotalWajaran FROM SMKB_Perolehan_Spesifikasi_Am WHERE No_Mohon = @noMohonValue)) as Total_Wajaran
                                FROM SMKB_Perolehan_Spesifikasi_Am b 
                                JOIN SMKB_Perolehan_Jawapan_Am d ON CONVERT(smalldatetime, b.Id_Am) = d.Id_Am
                                WHERE b.No_Mohon = @noMohonValue AND b.Kod_Spesifikasi = @txtKodSpek"

        'Dim query As String = "select a.Kod_Spesifikasi, a.Wajaran, b.Butiran, a.Butiran as Butiran_Am, d.Skor, d.Jawapan from SMKB_Perolehan_Spesifikasi_Am a
        '                        JOIN SMKB_Perolehan_Spesifikasi b on b.Kod = a.Kod_Spesifikasi
        '                        join SMKB_Perolehan_Pembelian_Hdr c on c.No_Mohon = a.No_Mohon
        '                        join SMKB_Perolehan_Jawapan_Am d on d.Id_Pembelian = c.Id_Pembelian
        '                        WHERE a.No_Mohon = 'BS4100000002140923' AND c.Kod_Syarikat = 'AB01' "

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@txtKodSpek", txtKodSpek))
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSkor_SyarikatTeknikalDtl(ByVal noMohonValue As String, idMohonDtl As String) As String

        Dim resp As New ResponseRepository

        dt = GetSkorDtl_SyarikatTeknikal(noMohonValue, idMohonDtl)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSkorDtl_SyarikatTeknikal(noMohonValue As String, idMohonDtl As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        'Dim query As String = "select b.ID_Syarikat, c.Id_Mohon_Dtl, a.Jawapan, a.Skor, a.Id_Pembelian, a.Id_Jawapan_Teknikal, c.Butiran as Butiran_Teknikal,  d.Butiran, c.Wajaran, CONVERT(INT, d.Kuantiti) AS Kuantiti ,((SELECT SUM(Wajaran) as TotalWajaran 
        '                        FROM SMKB_Perolehan_Spesifikasi_Teknikal WHERE No_Mohon = @noMohonValue)) as Total_Wajaran  from SMKB_Perolehan_Jawapan_Teknikal a 
        '                        JOIN SMKB_Perolehan_Pembelian_Hdr b on b.Id_Pembelian = a.Id_Pembelian
        '                        join SMKB_Perolehan_Spesifikasi_Teknikal c on c.Id_Teknikal = a.Id_Teknikal
        '                        inner join SMKB_Perolehan_Permohonan_Dtl d on CONVERT(smalldatetime, d.Id_Mohon_Dtl) = CONVERT(smalldatetime, c.Id_Mohon_Dtl)
        '                        where a.Id_Pembelian = @idPembelian and c.Id_Mohon_Dtl  = @idMohonDtl"

        Dim query As String = "SELECT Distinct A.Id_Teknikal, A.Id_Mohon_Dtl, A.Butiran, B.Id_Pembelian, B.Jawapan, B.Sampel, B.Katalog, b.Id_Jawapan_Teknikal, b.Skor, a.Wajaran,
								((SELECT SUM(Wajaran) as TotalWajaran 
                                FROM SMKB_Perolehan_Spesifikasi_Teknikal WHERE No_Mohon = @noMohonValue)) as Total_Wajaran
                                FROM SMKB_Perolehan_Spesifikasi_Teknikal A
                                LEFT JOIN SMKB_Perolehan_Jawapan_Teknikal B ON B.Id_Teknikal = A.Id_Teknikal
                                WHERE A.No_Mohon = @noMohonValue AND A.Id_Mohon_Dtl = @idMohonDtl"

        'Dim query As String = "sELECT 
        '                        B.No_Mohon,
        '                        a.Id_Dtl,
        '                        a.Id_Mohon_Dtl,
        '                        c.Butiran, g.Butiran AS Butiran_Teknikal , g.Wajaran, f.Jawapan, b.ID_Syarikat,
        '                        CONVERT(INT, c.Kuantiti) AS Kuantiti,
        '                        a.Id_Pembelian, ((SELECT SUM(Wajaran) as TotalWajaran FROM SMKB_Perolehan_Spesifikasi_Teknikal WHERE No_Mohon = @noMohonValue)) as Total_Wajaran,
        '                        f.Skor  -- Add skor from SMKB_Perolehan_Jawapan_Teknikal table
        '                       FROM 
        '                        SMKB_Perolehan_Pembelian_Dtl a
        '                    INNER JOIN 
        '                        SMKB_Perolehan_Permohonan_Dtl c ON c.Id_Mohon_Dtl = a.Id_Mohon_Dtl 
        '                     INNER JOIN 
        '                        SMKB_Perolehan_Pembelian_Hdr b ON b.No_Mohon = c.No_Mohon
        '                    INNER JOIN 
        '                        SMKB_Perolehan_Jawapan_Teknikal f ON f.Id_Pembelian = b.Id_Pembelian  -- Add join to SMKB_Perolehan_Jawapan_Teknikal table
        '  INNER JOIN 
        '                        SMKB_Perolehan_Spesifikasi_Teknikal g ON g.Id_Teknikal = f.Id_Teknikal  -- Add join to SMKB_Perolehan_Jawapan_Teknikal table
        '                        WHERE  
        '                            b.ID_Syarikat = @kodSyarikat
        '                            AND b.Id_Pembelian = @idPembelian
        '                            AND a.Id_Pembelian = @idPembelian
        '                        GROUP BY 
        '                            c.Butiran, 
        '                            c.Kuantiti, 
        '                            a.Id_Mohon_Dtl, 
        '                            a.Id_Dtl, 
        '                            a.Id_Pembelian,
        '                            B.No_Mohon, g.Butiran , g.Wajaran, f.Jawapan, b.ID_Syarikat,
        '                         f.Skor;"


        param = New List(Of SqlParameter)
        'param.Add(New SqlParameter("@idPembelian", idPembelian))
        param.Add(New SqlParameter("@idMohonDtl", idMohonDtl))
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasiAmDtlChilddd(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetSpeksifikasiDtl_PerolehanAmChilddd(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasiDtl_PerolehanAmChilddd(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        Dim query As String = "SELECT a.No_Mohon, a.Id_Pembelian, a.Kod_Syarikat, a.Kod_Pembuka, a.Tempoh, a.Peratus_Am, a. Peratus_Teknikal,
                                RANK() OVER (ORDER BY SUM(b.Jumlah_Harga) ASC) AS RankingHdr, 
                                ((SELECT FORMAT(SUM(Jumlah_Harga), '0.00') as Total_Jumlah_Harga FROM SMKB_Perolehan_Pembelian_Dtl WHERE Id_Pembelian = 'PB01')) as Harga_Syarikat, a.Ulasan_Teknikal,
                                FORMAT(SUM(b.Jumlah_Harga), '0.00') AS Total_Harga, 
                                --(CONVERT(DECIMAL(18, 2), SUM(b.Jumlah_Harga)) - CONVERT(DECIMAL(18, 2), (SELECT SUM(Jumlah_Harga) FROM SMKB_Perolehan_Pembelian_Dtl WHERE Id_Pembelian = 'PB01'), 0)) AS HargaBarang, 
                                FORMAT((CONVERT(DECIMAL(18, 2), SUM(b.Jumlah_Harga)) - CONVERT(DECIMAL(18, 2), (SELECT SUM(Jumlah_Harga) FROM SMKB_Perolehan_Pembelian_Dtl WHERE Id_Pembelian = 'PB01'), 0)), '0.00') AS HargaBarang,
                                ROUND(((CONVERT(DECIMAL(18, 2), SUM(b.Jumlah_Harga)) - CONVERT(DECIMAL(18, 2), (SELECT SUM(Jumlah_Harga) FROM SMKB_Perolehan_Pembelian_Dtl WHERE Id_Pembelian = 'PB01'))) / NULLIF(CONVERT(DECIMAL(18, 2), SUM(b.Jumlah_Harga)), 0)) * 100, 2) AS Percentage_HargaBarang 
                                FROM SMKB_Perolehan_Pembelian_Hdr a 
                                JOIN SMKB_Perolehan_Permohonan_Dtl b ON a.No_Mohon = b.No_Mohon 
                                --WHERE a.No_Mohon = @noMohonValue AND a.Kod_Syarikat = @kodSyarikat 
                                WHERE a.No_Mohon = @noMohonValue
                                GROUP BY  a.Id_Pembelian, a.Kod_Syarikat, a.Kod_Pembuka, a.Tempoh, a.No_Mohon, a.Peratus_Am, a. Peratus_Teknikal,a.Ulasan_Teknikal
                                ORDER BY RankingHdr"


        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanAmTabSkor(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateSkorAmTab(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        'resp.Success("Rekod berjaya dikemaskini", "00", Perolehan_Mesyuarat_JKD)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateSkorAmTab(Perolehan_Mesyuarat_JKD As Penilaian_Teknikal_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Jawapan_Am SET Skor = @skorAmTab WHERE Id_Am = @IdAmJawapan"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@skorAmTab", Perolehan_Mesyuarat_JKD.skorAmTab))
        param.Add(New SqlParameter("@IdAmJawapan", Perolehan_Mesyuarat_JKD.IdAmJawapan))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTeknikal_Skor(ByVal noMohonValue As String, idMohonDtl As String) As String

        Dim resp As New ResponseRepository

        dt = GetRecordTeknikal_Skor(noMohonValue, idMohonDtl)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecordTeknikal_Skor(noMohonValue As String, idMohonDtl As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        Dim query As String = "select CONVERT(smalldatetime, c.Id_Mohon_Dtl) as idMohonDtl, a.*, c.*, d.Jawapan, d.Skor, 
								((SELECT SUM(Wajaran) as TotalWajaran FROM SMKB_Perolehan_Spesifikasi_Teknikal WHERE No_Mohon = @noMohonValue)) as Total_Wajaran 
								from SMKB_Perolehan_Spesifikasi_Teknikal a
                                join SMKB_Perolehan_Permohonan_Dtl c on CONVERT(smalldatetime, c.Id_Mohon_Dtl) = CONVERT(smalldatetime, a.Id_Mohon_Dtl)
                                join SMKB_Perolehan_Jawapan_Teknikal d on d.Id_Teknikal = a.Id_Teknikal
                                --where d.Id_Teknikal = '2024-02-08 18:01:56.9830000'
								where CONVERT(smalldatetime, c.Id_Mohon_Dtl) = @idMohonDtl
								--WHERE a.No_Mohon = 'BS4100000002140923'"


        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@idMohonDtl", idMohonDtl))
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function TxtIdTextChanged(skorSpekAm As String, idAm As String) As String
        Dim db As New DBKewConn

        ' Update the database
        Dim query As String = "UPDATE SMKB_Perolehan_Jawapan_Am SET Skor = @skorSpekAm WHERE Id_Jawapan_Am = @idAm"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@skorSpekAm", skorSpekAm))
        param.Add(New SqlParameter("@idAm", idAm)) ' Make sure IdAmJawapan is declared or obtained properly

        Dim result As String = db.Process(query, param)
        ' Optionally, you can handle the result or perform any additional operations here
        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function TxtIdChangedText(skorSpekTeknikal As String, idTeknikal As String) As String
        Dim db As New DBKewConn

        ' Update the database
        Dim query As String = "UPDATE SMKB_Perolehan_Jawapan_Teknikal SET Skor = @skorSpekTeknikal WHERE Id_Jawapan_Teknikal = @idTeknikal"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@skorSpekTeknikal", skorSpekTeknikal))
        param.Add(New SqlParameter("@idTeknikal", idTeknikal))

        Dim result As String = db.Process(query, param)
        ' Optionally, you can handle the result or perform any additional operations here
        Return result
    End Function

    'PROFIL SYARIKAT
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_ProfilSyarikat(ByVal kodSyarikat As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_ProfilSyarikat(kodSyarikat)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_ProfilSyarikat(kodSyarikat As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " Select * from SMKB_Syarikat_Lampiran A
                                Inner Join SMKB_Syarikat_Master As B On A.ID_Sykt = B.No_Sykt
                                where A.ID_Sykt = @kodSyarikat and a.Jenis_Dok ='PS' and a.status = '1'"

        'where a.ID_Syarikat = @noSyarikat and b.No_Sykt = @kodSyarikat and c.Jenis_Dok = 'PS'

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))
        'param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))

        Return db.Read(query, param)
    End Function

    'PENGALAMAN SYARIKAT
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_PengalamanSyarikat(ByVal noSyarikat As String, kodSyarikat As String, idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_PengalamanSyarikat(noSyarikat, kodSyarikat, idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_PengalamanSyarikat(noSyarikat As String, kodSyarikat As String, idPembelian As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "	select a.Kod_Syarikat, b.ID_Sykt, c.Tajuk_Projek, c.Jabatan, c.Nilai_Jualan, c.Tkh_Mula, c.Tkh_Tamat from SMKB_Perolehan_Pembelian_Hdr a
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Syarikat_Pengalaman c On c.ID_Sykt = b.No_Sykt
                                where (a.ID_Syarikat=@noSyarikat or a.ID_Syarikat= @kodSyarikat)and a.Id_Pembelian = @idPembelian"

        'where (c.ID_Sykt = @noSyarikat or c.ID_Sykt=@kodSyarikat) and a.Id_Pembelian = @idPembelian
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noSyarikat", noSyarikat))
        param.Add(New SqlParameter("@idPembelian", idPembelian))
        param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))


        Return db.Read(query, param)
    End Function

    'JADUAL HARGA
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_JadualHarga(ByVal noMohonValue As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_JadualHarga(noMohonValue)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_JadualHarga(noMohonValue As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "	SELECT B.No_Mohon,a.Id_Dtl,a.Id_Mohon_Dtl,a.Jenama,a.Kod_Negara_Pembuat,a.Model,FORMAT(a.Jumlah_Harga, '0.00') AS Jumlah_Harga,FORMAT(a.Harga_Seunit, '0.00') AS Harga_Seunit,
c.Butiran,CONVERT(INT, c.Kuantiti) AS Kuantiti,d.Butiran AS Ukuran,(SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE a.Kod_Negara_Pembuat = lp.Kod_Detail AND Kod = '0001') AS ButiranNegara,a.Id_Pembelian
FROM SMKB_Perolehan_Pembelian_Dtl a
JOIN SMKB_Perolehan_Permohonan_Dtl c ON c.Id_Mohon_Dtl = a.Id_Mohon_Dtl 
JOIN SMKB_Perolehan_Pembelian_Hdr b ON b.No_Mohon = c.No_Mohon
JOIN SMKB_Lookup_Detail d ON c.Ukuran = d.Kod_Detail
WHERE d.Kod = 'PO06' AND b.No_Mohon = @noMohonValue
GROUP BY a.Jenama, a.Kod_Negara_Pembuat, a.Model, a.Jumlah_Harga, a.Harga_Seunit, c.Butiran, c.Kuantiti, d.Butiran, a.Id_Mohon_Dtl, a.Id_Dtl, a.Id_Pembelian, B.No_Mohon;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    'SIJIL SYARIKAT
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_SijilSalinan(ByVal noSyarikat As String, idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_SijilSalinan(noSyarikat, idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_SijilSalinan(noSyarikat As String, idPembelian As String) As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "select b.ID_Sykt as ID_Sykt, c.Nama_Dok, c.ID_Dok from SMKB_Perolehan_Pembelian_Hdr a
        '                        inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
        '                        inner join SMKB_Syarikat_Lampiran c on c.ID_Sykt = b.No_Sykt
        '                        where a.ID_Syarikat = @noSyarikat and c.Jenis_Dok = 'PBC' and c.status = '1'
        '                        group by a.ID_Syarikat, b.ID_Sykt, c.Nama_Dok, c.ID_Dok"

        Dim query As String = "	select c.Id_Pembelian, b.ID_Sykt as ID_Sykt, c.Nama_Dok, c.Jenis_Dok from SMKB_Perolehan_Pembelian_Hdr a
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Perolehan_Jawapan_Lampiran c on c.Id_Pembelian = a.Id_Pembelian
                                where b.ID_Sykt =  @noSyarikat AND c.Jenis_Dok = 'BANK' and c.Id_Pembelian = @idPembelian
                                group by a.ID_Syarikat, b.ID_Sykt, c.Nama_Dok, c.Jenis_Dok, c.Id_Pembelian;"

        'where a.ID_Syarikat = @noSyarikat and b.No_Sykt = @kodSyarikat and c.Jenis_Dok = 'PS'

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noSyarikat", noSyarikat))
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_PenyataBank(ByVal noSyarikat As String, kodSyarikat As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_PenyataBank(noSyarikat, kodSyarikat)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_PenyataBank(noSyarikat As String, kodSyarikat As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select b.ID_Sykt as ID_Sykt, c.Nama_Dok, c.ID_Dok from SMKB_Perolehan_Pembelian_Hdr a
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Syarikat_Lampiran c on c.ID_Sykt = b.No_Sykt
                                where a.ID_Syarikat = @noSyarikat and b.No_Sykt = @kodSyarikatAND c.Jenis_Dok = 'PBC'
                                group by a.ID_Syarikat, b.ID_Sykt, c.Nama_Dok, c.ID_Dok;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noSyarikat", noSyarikat))
        param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_LetterAuth(ByVal noSyarikat As String, idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_LetterAuth(noSyarikat, idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_LetterAuth(noSyarikat As String, idPembelian As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select c.Id_Pembelian, b.ID_Sykt as ID_Sykt, c.Nama_Dok, c.Jenis_Dok from SMKB_Perolehan_Pembelian_Hdr a
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Perolehan_Jawapan_Lampiran c on c.Id_Pembelian = a.Id_Pembelian
                                where b.ID_Sykt = @noSyarikat AND c.Jenis_Dok = 'AL' and c.Id_Pembelian = @idPembelian
                                group by a.ID_Syarikat, b.ID_Sykt, c.Nama_Dok, c.Jenis_Dok, c.Id_Pembelian;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noSyarikat", noSyarikat))
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_JadualKerja(ByVal noSyarikat As String, idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_JadualKerja(noSyarikat, idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_JadualKerja(noSyarikat As String, idPembelian As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select c.Id_Pembelian, b.ID_Sykt as ID_Sykt, c.Nama_Dok, c.Jenis_Dok from SMKB_Perolehan_Pembelian_Hdr a
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Perolehan_Jawapan_Lampiran c on c.Id_Pembelian = a.Id_Pembelian
                                where b.ID_Sykt = @noSyarikat AND c.Jenis_Dok = 'JK' and c.Id_Pembelian = @idPembelian
                                group by a.ID_Syarikat, b.ID_Sykt, c.Nama_Dok, c.Jenis_Dok, c.Id_Pembelian;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noSyarikat", noSyarikat))
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_Katalog(ByVal noSyarikat As String, idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_Katalog(noSyarikat, idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_Katalog(noSyarikat As String, idPembelian As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select c.Id_Pembelian, b.ID_Sykt as ID_Sykt, c.Nama_Dok, c.Katalog from SMKB_Perolehan_Pembelian_Hdr a
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Perolehan_Jawapan_Teknikal c on c.Id_Pembelian = a.Id_Pembelian
                                where b.ID_Sykt =  @noSyarikat AND c.Katalog = '1' and c.Id_Pembelian = @idPembelian
                                group by a.ID_Syarikat, b.ID_Sykt, c.Nama_Dok, c.Katalog, c.Id_Pembelian;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noSyarikat", noSyarikat))
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Display_Sample(ByVal noSyarikat As String, idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_Sample(noSyarikat, idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_Sample(noSyarikat As String, idPembelian As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select c.Id_Pembelian, b.ID_Sykt as ID_Sykt, c.Nama_Dok, c.Sampel from SMKB_Perolehan_Pembelian_Hdr a
                                inner join SMKB_Syarikat_Master b on b.ID_Sykt = a.ID_Syarikat
                                inner join SMKB_Perolehan_Jawapan_Teknikal c on c.Id_Pembelian = a.Id_Pembelian
                                where b.ID_Sykt =  @noSyarikat AND c.Sampel = '1' and c.Id_Pembelian = @idPembelian
                                group by a.ID_Syarikat, b.ID_Sykt, c.Nama_Dok, c.Sampel, c.Id_Pembelian;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noSyarikat", noSyarikat))
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        Return db.Read(query, param)
    End Function

    'testing query
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function TestProfil() As String
        Dim resp As New ResponseRepository

        dt = TestProfil_Sya()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function TestProfil_Sya() As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "SELECT * FROM SMKB_Perolehan_Lampiran a WHERE a.Jenis_Dokumen = 'LPH' OR a.Jenis_Dokumen = 'JPH' and No_Mohon = 'BS4100000002140923'"
        Dim query As String = "SELECT * FROM SMKB_Perolehan_Lampiran a
                                WHERE a.Jenis_Dokumen = 'LPH' OR a.Jenis_Dokumen = 'JPH' or a.Jenis_Dokumen = 'UP' and No_Mohon = 'BS4100000002140923' 
                                order by Id_Lampiran asc"

        Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRecord_Buku1(ByVal idPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable = DisplayRecord_Buku1(idPembelian)
        'dt = DisplayRecord_Buku1(idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function DisplayRecord_Buku1(idPembelian As String) As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "SELECT * FROM SMKB_Perolehan_Lampiran a WHERE a.Jenis_Dokumen = 'LPH' OR a.Jenis_Dokumen = 'JPH' and No_Mohon = 'BS4100000002140923'"
        Dim query As String = "select a.Id_Pembelian, c.Butiran as Butiran_Dokumen, b.Kod_Buku, b.Kod_Dokumen, b.Status_Simpan, b.Status_Hantar, b.Status_Pembuka, a.* from SMKB_Perolehan_Pembelian_Hdr a
                                join SMKB_Perolehan_Pembelian_Dokumen b on a.Id_Pembelian = b.Id_Pembelian
                                join SMKB_Lookup_Detail c on c.Kod_Detail = b.Kod_Dokumen
                                WHERE b.Id_Pembelian = @idPembelian AND c.Kod = 'VDR10' AND b.Kod_Buku = 'BK1' and b.Status_Hantar = '1'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRecord_Buku2(ByVal idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = DisplayRecord_Buku2(idPembelian)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function DisplayRecord_Buku2(idPembelian As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select a.Id_Pembelian, c.Butiran as Butiran_Dokumen, b.Kod_Buku, b.Kod_Dokumen, b.Status_Simpan, b.Status_Hantar, b.Status_Pembuka, a.* from SMKB_Perolehan_Pembelian_Hdr a
                                join SMKB_Perolehan_Pembelian_Dokumen b on a.Id_Pembelian = b.Id_Pembelian
                                join SMKB_Lookup_Detail c on c.Kod_Detail = b.Kod_Dokumen
                                WHERE b.Id_Pembelian = @idPembelian AND c.Kod = 'VDR10' AND b.Kod_Buku = 'BK2' and b.Status_Hantar = '1'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_ProfilSya(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck01(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck01(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='01'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_SyaratAm(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck02(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck02(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='02'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_JadualHarga(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck03(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck03(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='03'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_JaminanPembekal(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck04(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck04(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='04'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_AkuanPembida(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck05(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck05(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='05'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_PengalamanSya(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck06(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck06(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='06'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_MTD(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck07(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck07(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='07'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_SijilTerkini(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck08(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck08(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='08'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_BorangTeknikal(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck09(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck09(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='13'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_Buku1(idPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dtBuku1 As DataTable
        Dim Success As Integer = 0
        resp.Success("Data telah disimpan")

        If idPembelian Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        dtBuku1 = DisplayRecord_Buku1(idPembelian) ' cari status_Simpan = 0

        If dtBuku1.Rows.Count > 0 Then
            Dim incompleteCount As Integer = 0

            For Each row As DataRow In dtBuku1.Rows
                Dim statusPembuka As String = row("Status_Pembuka").ToString()
                Dim kodDokumen As String = row("Kod_Dokumen").ToString()

                If kodDokumen = "07" Then
                    Continue For ' Skip processing if Kod_Dokumen is '07'
                End If

                If statusPembuka = "0" OrElse String.IsNullOrEmpty(statusPembuka) Then
                    incompleteCount += 1
                End If
            Next

            If incompleteCount > 0 Then
                resp.Failed("Sila Lengkapkan Dan Simpan Maklumat Di Buku 1")
                Return JsonConvert.SerializeObject(resp.GetResult())
            Else
                ' Call the UpdateCheck_Buku1 function
                Try
                    If UpdateCheck_Buku1(idPembelian) <> "OK" Then
                        Throw New Exception("Hantar Jawapan Tidak Berjaya")
                    End If

                    Success += 1

                Catch ex As Exception
                    Success = 0
                End Try

                If Success > 0 Then
                    resp.Success("Rekod berjaya disimpan", "00", idPembelian)
                    Return JsonConvert.SerializeObject(resp.GetResult())
                Else
                    resp.Success("Rekod gagal disimpan", "01", idPembelian)
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If
        Else
            ' Handle case where dtBuku1 has no rows
            resp.Failed("No records found")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function
    Function UpdateCheck_Buku1(idPembelian As String) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Semak_Buku1 = '1' WHERE Id_Pembelian = @idPembelian"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", idPembelian))

        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_JadualKerja(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck10(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck10(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='09'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_AuthLetter(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck11(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck11(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='10'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_Katalog(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck12(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck12(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='11'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_Sample(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim updateResult As String = UpdateCheck13(Perolehan_Mesyuarat_JKD)
        If updateResult <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function UpdateCheck13(Perolehan_Mesyuarat_JKD As Pembuka_EP) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Pembuka = '1' WHERE Id_Pembelian = @idPembelian AND Kod_Dokumen='12'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", Perolehan_Mesyuarat_JKD.idPembelian))
        result = db.Process(query, param)

        ' Trigger function changeIconProfilSya after updating the database
        If result = "OK" Then
        End If

        Return result
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanChecking_Buku2(idPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dtBuku2 As DataTable
        Dim Success As Integer = 0
        resp.Success("Data telah disimpan")

        If idPembelian Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        dtBuku2 = DisplayRecord_Buku2(idPembelian) ' cari status_Simpan = 0

        If dtBuku2.Rows.Count > 0 Then
            Dim incompleteCount As Integer = 0

            For Each row As DataRow In dtBuku2.Rows
                Dim statusPembuka As String = row("Status_Pembuka").ToString()
                Dim kodDokumen As String = row("Kod_Dokumen").ToString()

                If kodDokumen = "11" OrElse kodDokumen = "12" OrElse kodDokumen = "13" Then
                    ' Skip the process for Kod_Dokumen 11, 12, or 13
                    Continue For
                End If

                If statusPembuka = "0" OrElse String.IsNullOrEmpty(statusPembuka) Then
                    incompleteCount += 1
                End If
            Next

            If incompleteCount > 0 Then
                resp.Failed("Sila Lengkapkan Dan Simpan Maklumat Di Buku 2")
                Return JsonConvert.SerializeObject(resp.GetResult())
            Else
                ' Call the UpdateCheck_Buku1 function
                Try
                    If UpdateCheck_Buku2(idPembelian) <> "OK" Then
                        Throw New Exception("Hantar Jawapan Tidak Berjaya")
                    End If

                    Success += 1

                Catch ex As Exception
                    Success = 0
                End Try

                If Success > 0 Then
                    resp.Success("Rekod berjaya disimpan", "00", idPembelian)
                    Return JsonConvert.SerializeObject(resp.GetResult())
                Else
                    resp.Success("Rekod gagal disimpan", "01", idPembelian)
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If
        Else
            ' Handle case where dtBuku1 has no rows
            resp.Failed("No records found")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

    End Function

    Function UpdateCheck_Buku2(idPembelian As String) As String

        Dim result As String = ""
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Semak_Buku2 = '1' WHERE Id_Pembelian = @idPembelian"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idPembelian", idPembelian))
        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)

        'Return result
    End Function

    '---------------------------------PENGESYORAN------------------------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanSyorDetail(Perolehan_Syor As Penilaian_Pengesyoran_EP) As String
        Dim resp As New ResponseRepository
        Dim hasFailed As Boolean = False ' Flag to track failure

        resp.Success("Data telah disimpan")

        'If Perolehan_Syor Is Nothing Then
        '    resp.Failed("Tidak disimpan")
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        'End If

        If UpdatePenilaianSyor(Perolehan_Syor) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            hasFailed = True ' Set flag to true
        End If

        If Not hasFailed AndAlso Update_FlagSyor_Bid(Perolehan_Syor) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            hasFailed = True ' Set flag to true
        End If

        If Not hasFailed Then
            resp.Success("Data berjaya dikemaskini.")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanFlag_Pengesyoran(Perolehan_Mesyuarat_JKD As Penilaian_Pengesyoran_EP) As String
        Dim resp As New ResponseRepository

        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Update_FlagSyor(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")

        End If

        resp.Success("Data berjaya dikemaskini.")

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function Update_FlagSyor(Perolehan_Mesyuarat_JKD As Penilaian_Pengesyoran_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Flag_Syor = '1', Status_Dok = '54' WHERE No_Mohon = @noMohonValue"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@noMohonValue", Perolehan_Mesyuarat_JKD.noMohonValue))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Function Update_FlagSyor_Bid(Perolehan_Syor As Penilaian_Pengesyoran_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Flag_Ebidding = @chkBid WHERE No_Mohon = @noMohonValue"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@noMohonValue", Perolehan_Syor.noMohonValue))
        param.Add(New SqlParameter("@chkBid", Perolehan_Syor.chkBid))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Function UpdatePenilaianSyor(Perolehan_Syor As Penilaian_Pengesyoran_EP) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Keputusan_Syor = @chkSyor, Ulasan_Syor = @txtUlasanSyor
                                WHERE No_Mohon = @noMohonValue AND Kod_Pembuka = @kodPembuka AND Id_Pembelian = @idPembelian"

        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@txtUlasanSyor", Perolehan_Syor.txtUlasanSyor))
        param.Add(New SqlParameter("@noMohonValue", Perolehan_Syor.noMohonValue))
        param.Add(New SqlParameter("@idPembelian", Perolehan_Syor.idPembelian))
        param.Add(New SqlParameter("@kodPembuka", Perolehan_Syor.kodPembuka))
        param.Add(New SqlParameter("@chkSyor", Perolehan_Syor.chkSyor))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    '---------------------------------PERLANTIKAN VENDOR------------------------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanLantikDetail(Perolehan_Lantik As Perlantikan_Vendor_EP) As String
        Dim resp As New ResponseRepository
        'Dim hasFailed As Boolean = False ' Flag to track failure

        resp.Success("Data telah disimpan")

        If Perolehan_Lantik Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePerlantikan(Perolehan_Lantik) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            'hasFailed = True ' Set flag to true
        End If

        'If Not hasFailed AndAlso Update_FlagLantik(Perolehan_Lantik) <> "OK" Then
        '    resp.Failed("Gagal Menyimpan order")
        '    hasFailed = True ' Set flag to true
        'End If

        'If Not hasFailed Then
        resp.Success("Data berjaya dikemaskini.")
        'End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanFlag_Perlantikan(Perolehan_Mesyuarat_JKD As Perlantikan_Vendor_EP) As String
        Dim resp As New ResponseRepository

        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Update_FlagLantik(Perolehan_Mesyuarat_JKD) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")

        End If

        resp.Success("Data berjaya dikemaskini.")

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function Update_FlagLantik(Perolehan_Lantik As Perlantikan_Vendor_EP) As String
        Dim db As New DBKewConn
        'Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Syor_Nilai_Harga = '1', Ulasan_Harga = @txtUlasanHarga 
        '                        WHERE Kod_Pembuka = '2/2'"

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Flag_Lantikan = '1', Status_Dok = '40' WHERE No_Mohon = @noMohonValue"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@noMohonValue", Perolehan_Lantik.noMohonValue))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    Function UpdatePerlantikan(Perolehan_Lantik As Perlantikan_Vendor_EP) As String
        Dim db As New DBKewConn
        'Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Syor_Nilai_Harga = '1', Ulasan_Harga = @txtUlasanHarga 
        '                        WHERE Kod_Pembuka = '2/2'"

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Keputusan_Lantik = @chkLantik, Ulasan_Lantik = @txtUlasanLantik
                                WHERE Kod_Pembuka = @kodPembuka"
        Dim param As New List(Of SqlParameter)

        ' Add parameters to the SqlCommand
        param.Add(New SqlParameter("@txtUlasanLantik", Perolehan_Lantik.txtUlasanLantik))
        param.Add(New SqlParameter("@kodPembuka", Perolehan_Lantik.kodPembuka))
        param.Add(New SqlParameter("@chkLantik", Perolehan_Lantik.chkLantik))

        ' Execute the query using the Process method of the DBKewConn class
        Return db.Process(query, param)
    End Function

    '---------------MESYUARAT DAFTAR PEMBUKA PTJ & UNI -----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMesy_PembukaPTJ(IdMohon As String) As String
        Dim resp As New ResponseRepository


        dt = GetRecord_PembukaPTJ(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_PembukaPTJ(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                       
                        select C.No_Mohon, C.Tujuan, C.Kod_Ptj_Mohon, C.No_Perolehan, D.No_Sebut_Harga from 
                        SMKB_Perolehan_Pembelian_Hdr As A
                        inner join SMKB_Perolehan_Pembelian_Dokumen As B On A.Id_Pembelian = B.Id_Pembelian
                        inner join SMKB_Perolehan_Permohonan_Hdr As C On A.No_Mohon = C.No_Mohon
                        inner join SMKB_Perolehan_Naskah_Jualan as D on C.No_Mohon = D.No_Mohon
                        where B.Status_Hantar ='1'
                        AND (No_Perolehan LIKE ('PL%') OR No_Perolehan LIKE ('PS%'))
                        group by C.No_Mohon, C.Tujuan, C.Kod_Ptj_Mohon, C.No_Perolehan, D.No_Sebut_Harga

                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'Load DataTable PenilaianHarga
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_CetakPembuka(category_filter As String, isClicked9 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked9 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetRecord_CetakPembuka(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_CetakPembuka(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Daftar >= DATEADD(month, -1, getdate()) and a.Tarikh_Daftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Daftar >= DATEADD(month, -2, getdate()) and a.Tarikh_Daftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Daftar >= @tkhMula and a.Tarikh_Daftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "	SELECT a.Tarikh_Daftar, a.No_Sebut_Harga, c.Tujuan, a.No_Mohon, d.ID_Syarikat, Sum(f.Jumlah_Harga) as totalHarga, e.Nama_Sykt
                                FROM SMKB_Perolehan_Naskah_Jualan a
                                join SMKB_Perolehan_Permohonan_Hdr c on c.No_Mohon = a.No_Mohon
								join SMKB_Perolehan_Pembelian_Hdr d on a.Id_Jualan = d.Id_Jualan
								join SMKB_Syarikat_Master e on e.ID_Sykt = d.ID_Syarikat 
								 inner join SMKB_Perolehan_Pembelian_Dtl f on f.Id_Pembelian = d.Id_Pembelian
								" & tarikhQuery & "
                                group by a.No_Sebut_Harga, a.Tarikh_Daftar, c.Tujuan, a.No_Mohon, d.ID_Syarikat, e.Nama_Sykt"

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRecord_SST(category_filter As String, isClicked3 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked3 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetRecord_DisplaySST(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_DisplaySST(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Daftar AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Daftar >= DATEADD(month, -1, getdate()) and a.Tarikh_Daftar <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Daftar >= DATEADD(month, -2, getdate()) and a.Tarikh_Daftar <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Daftar >= @tkhMula and a.Tarikh_Daftar <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "
                                SELECT b.No_Perolehan, b.No_Mohon, a.No_Sebut_Harga, a.Tarikh_Daftar, d.Nama_Sykt, d.ID_Sykt, b.No_Mohon, Sum(f.Jumlah_Harga) as totalHarga, b.Tujuan FROM SMKB_Perolehan_Naskah_Jualan a
                                inner join SMKB_Perolehan_Permohonan_Hdr b on b.No_Mohon = a.No_Mohon
                                inner join SMKB_Perolehan_Pembelian_Hdr c on c.Id_Jualan = a.Id_Jualan
                                inner join SMKB_Syarikat_Master d on d.ID_Sykt = c.ID_Syarikat
                                inner join SMKB_Perolehan_Pembelian_Dtl f on f.Id_Pembelian = c.Id_Pembelian
                                where b.Flag_Lantikan = '1' " & tarikhQuery & "
                                group by b.No_Perolehan, a.No_Sebut_Harga, a.Tarikh_Daftar, d.Nama_Sykt, b.No_Mohon, d.ID_Sykt, b.Tujuan, b.No_Mohon
        "

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTeknikal_Buku2(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetRecordTeknikal_Buku2(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecordTeknikal_Buku2(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        Dim query As String = "SELECT DISTINCT A.Id_Mohon_Dtl, A.No_Mohon, A.Butiran, A.Jumlah_Harga, B.Jenama, B.Model, B.Kod_Negara_Pembuat, CONVERT(INT, A.Kuantiti) AS Kuantiti,
                                (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE B.Kod_Negara_Pembuat = lp.Kod_Detail AND Kod = '0001') AS ButiranNegara,
								(SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE A.Ukuran = lp.Kod_Detail AND Kod = 'PO06') AS Ukuran
                                FROM SMKB_Perolehan_Permohonan_Dtl A
                                INNER JOIN SMKB_Perolehan_Pembelian_Dtl B ON B.Id_Mohon_Dtl = A.Id_Mohon_Dtl
                                INNER JOIN SMKB_Perolehan_Spesifikasi_Teknikal C ON C.Id_Mohon_Dtl = B.Id_Mohon_Dtl
                                WHERE C.No_Mohon = @noMohonValue"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        'param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTeknikalDtl_Buku2(ByVal noMohonValue As String, idMohonDtl As String) As String

        Dim resp As New ResponseRepository

        dt = GetRecordTeknikalDtl_Buku2(noMohonValue, idMohonDtl)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecordTeknikalDtl_Buku2(noMohonValue As String, idMohonDtl As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        Dim query As String = "SELECT Distinct A.Id_Teknikal, A.Id_Mohon_Dtl, A.Butiran, B.Id_Pembelian, B.Jawapan, B.Sampel, B.Katalog, b.Id_Jawapan_Teknikal, b.Nama_Dok
                                FROM SMKB_Perolehan_Spesifikasi_Teknikal A
                                LEFT JOIN SMKB_Perolehan_Jawapan_Teknikal B ON B.Id_Teknikal = A.Id_Teknikal
                                WHERE A.No_Mohon = @noMohonValue AND A.Id_Mohon_Dtl = @idMohonDtl"

        param = New List(Of SqlParameter)
        'param.Add(New SqlParameter("@idPembelian", idPembelian))
        param.Add(New SqlParameter("@idMohonDtl", idMohonDtl))
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAm_Buku2(ByVal noMohonValue As String) As String

        Dim resp As New ResponseRepository

        dt = GetRecordAm_Buku2(noMohonValue)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecordAm_Buku2(noMohonValue As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        Dim query As String = "SELECT DISTINCT A.No_Mohon, A.Kod_Spesifikasi, B.Butiran
                                             FROM SMKB_Perolehan_Spesifikasi_Am A
                                             INNER JOIN SMKB_Perolehan_Spesifikasi B ON B.Kod = A.Kod_Spesifikasi
                                             WHERE No_Mohon = @noMohonValue"
        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAmDtl_Buku2(ByVal noMohonValue As String, txtKodSpek As String) As String
        Dim resp As New ResponseRepository
        dt = GetRecordAmDtl_Buku2(noMohonValue, txtKodSpek)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecordAmDtl_Buku2(noMohonValue As String, txtKodSpek As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)

        Dim query As String = "SELECT A.id_am, A.no_mohon,kod_spesifikasi,Butiran,Wajaran, B.Jawapan, b.Skor, b.Id_Jawapan_Am, C.Id_Pembelian,  ((SELECT SUM(Wajaran) as TotalWajaran FROM SMKB_Perolehan_Spesifikasi_Am WHERE No_Mohon = @noMohonValue)) as Total_Wajaran
                                FROM SMKB_Perolehan_Spesifikasi_Am A
                                LEFT JOIN SMKB_Perolehan_Jawapan_Am B ON B.Id_Am = A.Id_Am
								JOIN SMKB_Perolehan_Pembelian_Hdr c ON  A.no_mohon = c.No_Mohon
                                WHERE kod_spesifikasi = @txtKodSpek and A.no_mohon = @noMohonValue
                                ORDER by A.id_am"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@txtKodSpek", txtKodSpek))
        param.Add(New SqlParameter("@noMohonValue", noMohonValue))
        'param.Add(New SqlParameter("@idPembelian", idPembelian))
        'param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))

        Return db.Read(query, param)
    End Function

    'end fateen

End Class
