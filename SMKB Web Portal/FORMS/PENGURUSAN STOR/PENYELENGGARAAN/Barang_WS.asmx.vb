Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic

' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Barang_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    '-------------------- REFERENCE tblBarang START -----------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBarangData() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadBarangData()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadBarangData() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT
    c.*,
    b.butiran,
    (c.kod_ukuran + ' - ' + b.butiran) as keteranganUkuran,
    (
        SELECT B.Kod_Detail + ' - ' + B.Butiran
        FROM SMKB_Lookup_Master A
        JOIN SMKB_Lookup_Detail B ON A.Kod = B.Kod
        WHERE A.Kod_Modul = '28' AND B.Kod = 'SI001' AND B.Status = '1'
    ) as keteranganKategori
FROM
    SMKB_SI_Barang_Master c
INNER JOIN
    SMKB_Lookup_Detail b ON c.kod_ukuran = b.kod_detail
WHERE
    b.Kod = 'SI003' AND b.Status = '1';"

        Return db.Read(query)
    End Function
    '-------------------- REFERENCE tblBarang END -------------------------

    '-------------------- REFERENCE barangUkuran START --------------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBarangUkuran(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodBarangUkuran(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodBarangUkuran(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT B.Kod_Detail AS value,B.Kod_Detail+'-'+B.Butiran AS text
                                FROM SMKB_Lookup_Master A
                                JOIN SMKB_Lookup_Detail B ON A.Kod=B.Kod
                                WHERE A.Kod_Modul='28' AND B.Kod='SI003' AND B.Status='1'"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(kod) Then
            query &= "AND (B.Butiran LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & kod & "%"))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE barangUkuran END   --------------------

    '-------------------- REFERENCE barangKategori START ------------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBarangKategori(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodBarangKategori(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodBarangKategori(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT B.Kod_Detail AS value,B.Kod_Detail+'-'+B.Butiran AS text
                               FROM SMKB_Lookup_Master A
                               JOIN SMKB_Lookup_Detail B ON A.Kod=B.Kod
                               WHERE A.Kod_Modul='28' AND B.Kod='SI001' AND B.Status='1'"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(kod) Then
            query &= "AND (B.Butiran LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & kod & "%"))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE barangKategori END   ---------------------


    '-------------------- REFERENCE barangKategori START   -------------------
    'insert data Proses Pembuka
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Test(barangInsert As barangInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If barangInsert Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertTest(barangInsert) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", barangInsert)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertTest(barangInsert As barangInsertDetail) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_SI_Barang_Master(Kod_Brg, Butiran, Kod_Ukuran, Kod_Kategori) VALUES (@kodBarang, @ukuranBarang, @butiranBarang, @kategoriBarang, @statusBarang)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kodBarang", barangInsert.kodBarang))
        param.Add(New SqlParameter("@butiranBarang", barangInsert.butiranBarang))
        param.Add(New SqlParameter("@ukuranBarang", barangInsert.ukuranBarang))
        param.Add(New SqlParameter("@kategoriBarang", barangInsert.kategoriBarang))
        param.Add(New SqlParameter("@statusBarang", barangInsert.statusBarang))

        Return db.Process(query, param)
    End Function
    '-------------------- REFERENCE barangKategori END   ---------------------
    '-------------------- REFERENCE mohonBarang START   ----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Barang(mohonBarang As barangInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonBarang Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertBarang(mohonBarang) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", mohonBarang)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertBarang(mohonBarang As barangInsertDetail) As String
        Dim db As New DBKewConn
        'Dim query As String = "INSERT INTO SMKB_SI_Barang_Master(Kod_Brg, Kod_Ukuran, Butiran, Kod_Kategori) VALUES (@kodBarang, @ukuranBarang, @butiranBarang, @kategoriBarang)"
        Dim query As String = "INSERT INTO SMKB_SI_Barang_Master(Kod_Brg, Kod_Ukuran, Butiran, Kod_Kategori, Status) VALUES (@kodBarang, @ukuranBarang, @butiranBarang, @kategoriBarang, @statusBarang)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kodBarang", mohonBarang.kodBarang))
        param.Add(New SqlParameter("@ukuranBarang", mohonBarang.ukuranBarang))
        param.Add(New SqlParameter("@butiranBarang", mohonBarang.butiranBarang))
        param.Add(New SqlParameter("@kategoriBarang", mohonBarang.kategoriBarang))
        param.Add(New SqlParameter("@statusBarang", mohonBarang.statusBarang))

        Return db.Process(query, param)
    End Function
    '-------------------- REFERENCE mohonBarang END   ------------------------
    '-------------------- REFERENCE updateBarang END   -----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Update_Barang(mohonBarang As barangInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonBarang Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateBarang(mohonBarang) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", mohonBarang)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateBarang(mohonBarang As barangInsertDetail) As String
        Dim db As New DBKewConn
        'Dim query As String = "UPDATE SMKB_SI_Barang_Master SET Kod_Penghutang=@Kod_Penghutang,Tkh_Mula=@Tkh_Mula,Tkh_Tamat=@Tkh_Tamat,Kontrak=@Kontrak,Kod_Urusniaga=@Kod_Urusniaga,Tujuan=@Tujuan,Jumlah=@Jumlah WHERE No_Bil=@no_bil"
        Dim query As String = "UPDATE SMKB_SI_Barang_Master SET Kod_Brg=@kodBarang, Butiran=@butiranBarang, Kod_Ukuran=@ukuranBarang, Kod_Kategori=@kategoriBarang, Status=@statusBarang WHERE Kod_Brg=@kodBarang"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kodBarang", mohonBarang.kodBarang))
        param.Add(New SqlParameter("@ukuranBarang", mohonBarang.ukuranBarang))
        param.Add(New SqlParameter("@butiranBarang", mohonBarang.butiranBarang))
        param.Add(New SqlParameter("@kategoriBarang", mohonBarang.kategoriBarang))
        param.Add(New SqlParameter("@statusBarang", mohonBarang.statusBarang))

        Return db.Process(query, param)
    End Function
    '-------------------- REFERENCE updateBarang END   -----------------------

End Class
