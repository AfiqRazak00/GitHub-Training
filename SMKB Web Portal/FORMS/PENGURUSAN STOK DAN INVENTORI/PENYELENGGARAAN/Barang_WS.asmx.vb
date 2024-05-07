Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Data.Entity.Core

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
    Dim dtbl As DataTable
    Dim queryRB As New Query()

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
    b.butiran as ButiranBarang,
    (c.kod_ukuran + ' - ' + b.butiran) as keteranganUkuran,
    (
        SELECT B.Kod_Detail + ' - ' + B.Butiran
        FROM SMKB_Lookup_Master A
        JOIN SMKB_Lookup_Detail B ON A.Kod = B.Kod
        WHERE A.Kod_Modul = '28' AND B.Kod = 'SI001' AND B.Status = '1'
    ) as keteranganKategori,
	(
        SELECT B.Butiran
        FROM SMKB_Lookup_Master A
        JOIN SMKB_Lookup_Detail B ON A.Kod = B.Kod
        WHERE A.Kod_Modul = '28' AND B.Kod = 'SI001' AND B.Status = '1'
    ) as keteranganKategori2
FROM
    SMKB_SI_Barang_Master c
INNER JOIN
    SMKB_Lookup_Detail b ON c.kod_ukuran = b.kod_detail
WHERE
    b.Kod = 'SI003' AND b.Status = '1'"
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
        Dim query As String = "SELECT B.Kod_Detail AS value,
B.Kod_Detail+'-'+B.Butiran AS text
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
    '-------------------- REFERENCE senaraiBarang START   --------------------

    '-------------------- REFERENCE senaraiBarang END   ----------------------





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

        queryRB = New Query

        If InsertBarang(mohonBarang) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB.finish()

        resp.Success("Rekod berjaya disimpan", "00", mohonBarang)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertBarang(mohonBarang As barangInsertDetail) As String
        Dim db As New DBKewConn

        Dim query As String = "SELECT CAST(COALESCE(MAX(CAST(SUBSTRING(Kod_Brg, 2, LEN(Kod_Brg) - 1) AS INT)), 0) + 1 AS VARCHAR) AS Kod_Brg 
FROM SMKB_SI_Barang_Master;"

        Dim param As New List(Of SqlParameter)
        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Dim insertQuery As String = $"INSERT INTO SMKB_SI_Barang_Master(Kod_Ukuran, Butiran, Kod_Kategori, Status, Kod_Brg)
                                        VALUES ('{mohonBarang.ukuranBarang}', '{mohonBarang.butiranBarang}'
                                        ,'{mohonBarang.kategoriBarang}', '{mohonBarang.statusBarang}','B{dtbl.Rows(0).Item("Kod_Brg")}');"

            Dim insertParam As New List(Of SqlParameter)

            'insertParam.Add(New SqlParameter("@kodBarang", mohonBarang.kodBarang))
            insertParam.Add(New SqlParameter("@ukuranBarang", mohonBarang.ukuranBarang))
            insertParam.Add(New SqlParameter("@butiranBarang", mohonBarang.butiranBarang))
            insertParam.Add(New SqlParameter("@kategoriBarang", mohonBarang.kategoriBarang))
            insertParam.Add(New SqlParameter("@statusBarang", mohonBarang.statusBarang))

            Dim key As New Dictionary(Of String, String)
            key.Add("Butiran", mohonBarang.butiranBarang)
            key.Add("Kod_Ukuran", mohonBarang.ukuranBarang)
            ' Execute the insertion query
            Dim insertResult As String = RbQueryCmdMulti(key, insertQuery, insertParam)

            Return insertResult
        Else
            Return "X"
        End If
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
