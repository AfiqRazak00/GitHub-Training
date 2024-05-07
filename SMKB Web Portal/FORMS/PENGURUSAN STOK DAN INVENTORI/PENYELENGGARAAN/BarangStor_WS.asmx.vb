Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Data.Entity.Core
Imports Newtonsoft.Json.Linq

' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class BarangStor_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim dtbl As DataTable
    Dim dtbl2 As DataTable
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

        Dim query As String = "SELECT distinct
    B.Butiran AS ButiranBarang,
	B.Kod_Kategori AS KategoriStok,
	(
        SELECT B.Kod_Detail + ' - ' + B.Butiran
        FROM SMKB_Lookup_Master A
        JOIN SMKB_Lookup_Detail B ON A.Kod = B.Kod
        WHERE A.Kod_Modul = '28' AND B.Kod = 'SI001' AND B.Status = '1'
    ) as keteranganKategori,
    A.Kod_Brg AS KodBarang,
    A.Takat_Max AS TakatMax,
    A.Takat_Menokok AS TakatMenokok,
    A.Takat_Min AS TakatMin,
    A.Kat_Stor AS KategoriStor,
    A.Kod_Lokasi AS KodLokasi,
	A.Kod_Ptj AS KodPtj,
	(Select Pejabat from vPejabat Where KodPejabat + '0000' = A.Kod_Ptj) As TxtPtj,
    STUFF((
        SELECT ', ' + Kod_Lokasi_Dtl
        FROM SMKB_SI_Barang_Stor B2
        WHERE A.Kod_Brg = B2.Kod_Brg 
            AND A.Kat_Stor = B2.Kat_Stor 
            AND A.Kod_Lokasi = B2.Kod_Lokasi
        FOR XML PATH('')), 1, 2, '') AS KodLokasiDetail,
    C.Butiran AS ButiranKategoriStor,
    D.Butiran AS ButiranLokasi,
	CASE 
            WHEN LEN(A.Kod_Ptj) >= 4 THEN LEFT(A.Kod_Ptj, LEN(A.Kod_Ptj) - 4) 
            ELSE A.Kod_Ptj 
        END AS Kod_Ptj
FROM 
    SMKB_SI_Barang_Stor A
INNER JOIN 
    SMKB_SI_Barang_Master B ON B.Kod_Brg = A.Kod_Brg
INNER JOIN 
    SMKB_Lookup_Detail C ON C.Kod_Detail = A.Kat_Stor
INNER JOIN 
    SMKB_SI_Lokasi D ON D.Kod_Lokasi = A.Kod_Lokasi
WHERE 
    C.Kod = 'SI002'
ORDER BY 
    A.Kod_Brg ASC;"
        Return db.Read(query)
    End Function
    '-------------------- REFERENCE tblBarang END -------------------------
    '-------------------- REFERENCE senaraiBarang END -------------------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetsenaraiBarang(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodsenaraiBarang(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodsenaraiBarang(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "select 
A.Kod_Brg AS value,
A.Butiran AS text
from SMKB_SI_Barang_Master A where Status = '1'"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(kod) Then
            query &= "AND (A.Butiran LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & kod & "%"))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE senaraiBarang END -------------------------
    '-------------------- REFERENCE barangKategori START   ----------------
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
    '-------------------- REFERENCE Barang Stor 1 START -------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_SecondTableData(value1 As String, value2 As String) As String
        Dim tmpDT As DataTable = Get_KodSecondTableData(value1, value2)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Public Function Get_KodSecondTableData(value1 As String, value2 As String) As DataTable
        Dim query As String = "SELECT 
    A.Kod_Lokasi_Dtl AS KodLokasiDtl,
	A.Kod_Lokasi AS KodLokasi,
    A.Butiran,
    B.Kat_Stor,
    CASE 
        WHEN LEN(B.Kod_Ptj) >= 4 THEN LEFT(B.Kod_Ptj, LEN(B.Kod_Ptj) - 4) 
        ELSE B.Kod_Ptj 
    END AS Kod_Ptj
FROM 
    SMKB_SI_Lokasi_Dtl A
INNER JOIN 
    SMKB_SI_Lokasi B ON B.Kod_Lokasi = A.Kod_Lokasi
WHERE 
    B.Kat_Stor = @value1 AND 
    (CASE 
        WHEN LEN(B.Kod_Ptj) >= 4 THEN LEFT(B.Kod_Ptj, LEN(B.Kod_Ptj) - 4) 
        ELSE B.Kod_Ptj 
    END) = @value2;"

        Dim param As New List(Of SqlParameter) From {New SqlParameter("@value1", value1), New SqlParameter("@value2", value2)}

        Dim db = New DBKewConn
        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE Barang Stor 1 END -------------------
    '-------------------- REFERENCE Barang Stor 2 START -----------------
    ' Server-side code
    '    <WebMethod(EnableSession:=True)>
    '    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    '    Public Function Get_CombinedTableData(value1 As String, value2 As String, value3 As String) As String
    '        Dim thirdTableData As DataTable = Get_KodThirdTableData(value1, value2)
    '        Dim thirdTable2Data As DataTable = Get_KodThirdTable2Data(value1, value2, value3)
    '        thirdTableData.Columns.Add("HasMatch", GetType(String))

    '        ' Set "HasMatch" based on matching rows in second table
    '        For Each row As DataRow In thirdTableData.Rows
    '            Dim hasMatch = False
    '            For Each row2 As DataRow In thirdTable2Data.Rows
    '                If row("KodLokasiDtl").ToString = row2("KodLokasiDtl2").ToString Then
    '                    hasMatch = True
    '                    Exit For
    '                End If
    '            Next
    '            row("HasMatch") = hasMatch.ToString
    '        Next

    '        ' Serialize the first table with "HasMatch" set
    '        Return JsonConvert.SerializeObject(thirdTableData)
    '    End Function

    '    Public Function Get_KodThirdTableData(value1 As String, value2 As String) As DataTable
    '        Dim query As String = "SELECT 
    '                            A.Kod_Lokasi_Dtl AS KodLokasiDtl,
    '                            A.Kod_Lokasi AS KodLokasi,
    '                            A.Butiran,
    '                            B.Kat_Stor,
    '                            CASE 
    '                                WHEN LEN(B.Kod_Ptj) >= 4 THEN LEFT(B.Kod_Ptj, LEN(B.Kod_Ptj) - 4) 
    '                                ELSE B.Kod_Ptj 
    '                            END AS Kod_Ptj
    '                        FROM 
    '                            SMKB_SI_Lokasi_Dtl A
    '                        INNER JOIN 
    '                            SMKB_SI_Lokasi B ON B.Kod_Lokasi = A.Kod_Lokasi
    '                        WHERE 
    '                            B.Kat_Stor = @value1 AND 
    '                            (CASE 
    '                                WHEN LEN(B.Kod_Ptj) >= 4 THEN LEFT(B.Kod_Ptj, LEN(B.Kod_Ptj) - 4) 
    '                                ELSE B.Kod_Ptj 
    '                            END) = @value2;"

    '        Dim param As New List(Of SqlParameter) From {New SqlParameter("@value1", value1), New SqlParameter("@value2", value2)}

    '        Dim db = New DBKewConn
    '        Dim dataTable As DataTable = db.Read(query, param)
    '        dataTable.TableName = "thirdTableData" ' Set table name for identification
    '        Return dataTable
    '    End Function

    '    Public Function Get_KodThirdTable2Data(value1 As String, value2 As String, value3 As String) As DataTable
    '        Dim query As String = "SELECT DISTINCT
    '    A.Kod_Ptj AS Original_Kod_Ptj,
    '    A.Kod_Lokasi_Dtl AS KodLokasiDtl2,
    '    A.Kod_Lokasi AS KodLokasi,
    '    A.Kod_Brg AS KodBarang,
    '    B.Butiran,
    '    C.Kat_Stor
    'FROM 
    '    SMKB_SI_Barang_Stor A
    'RIGHT OUTER JOIN 
    '    SMKB_SI_Lokasi_Dtl B ON A.Kod_Lokasi_Dtl = B.Kod_Lokasi_Dtl
    'FULL OUTER JOIN
    '    SMKB_SI_Lokasi C ON C.Kod_Lokasi = A.Kod_Lokasi
    'WHERE 
    '    B.Status = 1
    '    AND 
    '    (
    '        (RIGHT(A.Kod_Ptj, 4) = '0000' AND LEFT(A.Kod_Ptj, LEN(A.Kod_Ptj) - 4) = @value2) 
    '        OR 
    '        (RIGHT(A.Kod_Ptj, 4) <> '0000' AND A.Kod_Ptj = @value2)
    '    )
    '    AND C.Kat_Stor = @value1
    '    AND A.Kod_Brg = @value3;"

    '        Dim param As New List(Of SqlParameter) From {New SqlParameter("@value1", value1), New SqlParameter("@value2", value2), New SqlParameter("@value3", value3)}

    '        Dim db = New DBKewConn
    '        Dim dataTable As DataTable = db.Read(query, param)
    '        dataTable.TableName = "thirdTable2Data" ' Set table name for identification
    '        Return dataTable
    '    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_CombinedTableData(value1 As String, value2 As String, value3 As String) As String
        Dim tmpDT As DataTable = Get_KodCombinedTableData(value1, value2, value3)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Public Function Get_KodCombinedTableData(value1 As String, value2 As String, value3 As String) As DataTable
        Dim query As String = "SELECT 
    A.Kod_Lokasi_Dtl AS KodLokasiDtl,
	A.Kod_Lokasi AS KodLokasi,
    C.Butiran,
    B.Kat_Stor,
	A.Status,
    CASE 
        WHEN LEN(B.Kod_Ptj) >= 4 THEN LEFT(B.Kod_Ptj, LEN(B.Kod_Ptj) - 4) 
        ELSE B.Kod_Ptj 
    END AS Kod_Ptj
FROM 
    SMKB_SI_Barang_Stor A
INNER JOIN 
    SMKB_SI_Lokasi B ON B.Kod_Lokasi = A.Kod_Lokasi
INNER JOIN
	SMKB_SI_Lokasi_Dtl C ON C.Kod_Lokasi_Dtl = A.Kod_Lokasi_Dtl
WHERE 
    B.Kat_Stor = @value1 AND 
	(CASE 
    WHEN LEN(B.Kod_Ptj) >= 4 THEN LEFT(B.Kod_Ptj, LEN(B.Kod_Ptj) - 4) 
    ELSE B.Kod_Ptj 
END) = @value2 AND
	A.Kod_Brg = @value3;"

        Dim param As New List(Of SqlParameter) From {New SqlParameter("@value1", value1), New SqlParameter("@value2", value2), New SqlParameter("@value3", value3)}

        Dim db = New DBKewConn
        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE Barang Stor 3 END -------------------
    '-------------------- REFERENCE addBarang START   ----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan2(mohonPengesahan As BarangStorInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPengesahan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query

        If InsertPengesahan2(mohonPengesahan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB.finish()

        resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPengesahan2(mohonPengesahan As BarangStorInsertDetail) As String
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim lokasiValues As String() = mohonPengesahan.pejabatLokasiDetailPengesahan.Split(","c)
        Dim kodLokasiValues As String() = mohonPengesahan.kodLokasiPengesahan.Split(","c)
        Dim statusValues As String() = mohonPengesahan.statusPengesahan.Split(","c)

        ' Check if the lengths of both arrays are equal
        If lokasiValues.Length <> kodLokasiValues.Length Then
            Return "X" ' Return error if lengths are not equal
        End If

        For i As Integer = 0 To lokasiValues.Length - 1
            Dim lokasiDetail As String = lokasiValues(i).Trim()
            Dim kodLokasi As String = kodLokasiValues(i).Trim()
            Dim status As String = statusValues(i).Trim()

            Dim query As String = $"INSERT INTO SMKB_SI_Barang_Stor (Kat_Stor, Kod_Ptj, Takat_Min, Takat_Max, Takat_Menokok, Kod_Brg, Kod_Lokasi_Dtl, Kod_Lokasi, Status) VALUES 
                    ('{mohonPengesahan.kategoriStorPengesahan}', '{mohonPengesahan.pejabatLokasiPengesahan}' + '0000', '{mohonPengesahan.takatMinimaPengesahan}', '{mohonPengesahan.takatMaksimaPengesahan}', '{mohonPengesahan.takatMenokokPengesahan}', '{mohonPengesahan.senaraiBarangPengesahan}', '{lokasiDetail}', '{kodLokasi}','{status}')"

            param.Clear()
            ' Prepare parameters for the query
            param.Add(New SqlParameter("@kategoriStor", mohonPengesahan.kategoriStorPengesahan))
            param.Add(New SqlParameter("@pejabatLokasi", mohonPengesahan.pejabatLokasiPengesahan))
            param.Add(New SqlParameter("@kategoriBarang", mohonPengesahan.kategoriBarangPengesahan))
            param.Add(New SqlParameter("@senaraiBarang", mohonPengesahan.senaraiBarangPengesahan))
            param.Add(New SqlParameter("@takatMinima", mohonPengesahan.takatMinimaPengesahan))
            param.Add(New SqlParameter("@takatMaksima", mohonPengesahan.takatMaksimaPengesahan))
            param.Add(New SqlParameter("@takatMenokok", mohonPengesahan.takatMenokokPengesahan))
            param.Add(New SqlParameter("@pejabatLokasiDetail", lokasiDetail))
            param.Add(New SqlParameter("@kodLokasi", kodLokasi))
            param.Add(New SqlParameter("@status", status))

            Dim key As New Dictionary(Of String, String)
            key.Add("Kod_Brg", mohonPengesahan.senaraiBarangPengesahan)
            key.Add("Kod_Ptj", mohonPengesahan.pejabatLokasiPengesahan)
            key.Add("Kod_Lokasi_Dtl", lokasiDetail)

            Dim result As String = RbQueryCmdMulti(key, query, param)
            If result <> "OK" Then
                Return "X"
            End If
        Next

        Return "OK"
    End Function

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
    '-------------------- REFERENCE addBarang END   ------------------------
    '-------------------- REFERENCE updateBarang END   -----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Update_Barang(mohonPengesahan As BarangStorInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        queryRB = New Query

        If mohonPengesahan Is Nothing Then
            resp.Failed("Tidak disimpan")
            queryRB.rollback()
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If UpdateBarang(mohonPengesahan) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            queryRB.rollback()
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB.finish()

        resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    'Private Function UpdateBarang(mohonPengesahan As BarangStorInsertDetail) As String
    '    Dim db As New DBKewConn
    '    Dim param As New List(Of SqlParameter)

    '    ' Split pejabatLokasiDetailPengesahan and statusPengesahan into arrays
    '    Dim pejabatLokasiDetailArray As String() = mohonPengesahan.pejabatLokasiDetailPengesahan.Split(", ")
    '    Dim statusPengesahanArray As String() = mohonPengesahan.statusPengesahan.Split(", ")

    '    For i As Integer = 0 To pejabatLokasiDetailArray.Length - 1
    '        ' Check existence of data
    '        Dim queryCheckExistence As String = $"SELECT COUNT(*) FROM SMKB_SI_Barang_Stor WHERE Kat_Stor = '{mohonPengesahan.kategoriStorPengesahan}' AND Kod_Ptj = '{mohonPengesahan.pejabatLokasiPengesahan}' AND Kod_Brg = '{mohonPengesahan.senaraiBarangPengesahan}' AND Kod_Lokasi_Dtl = '{pejabatLokasiDetailArray(i)}"
    '        Dim paramCheckExistence As New List(Of SqlParameter)
    '        Dim dtbl2 As DataTable = db.Read(queryCheckExistence, paramCheckExistence)

    '        Dim queryUpdate As String = ""

    '        Dim key As New Dictionary(Of String, String)
    '        key.Add("Kod_Ptj", mohonPengesahan.pejabatLokasiPengesahan)
    '        key.Add("Kod_Lokasi_Dtl", pejabatLokasiDetailArray(i))

    '        If dtbl2.Rows.Count > 0 Then
    '            ' Row exists, perform UPDATE
    '            queryUpdate = $"UPDATE SMKB_SI_Barang_Stor SET Status = '{statusPengesahanArray(i)}', Takat_Min = '{mohonPengesahan.takatMinimaPengesahan}', Takat_Max = '{mohonPengesahan.takatMaksimaPengesahan}', Takat_Menokok = '{mohonPengesahan.takatMenokokPengesahan}' WHERE Kat_Stor = '{mohonPengesahan.kategoriStorPengesahan}' AND Kod_Ptj = '{mohonPengesahan.pejabatLokasiPengesahan}' AND Kod_Lokasi_Dtl = '{pejabatLokasiDetailArray(i)}'"

    '            Dim result As String = RbQueryCmdMulti2(key, queryUpdate, param)
    '            If result <> "OK" Then
    '                Return "X"
    '            End If
    '        Else
    '            ' Row does not exist, perform INSERT
    '            queryUpdate = $"INSERT INTO SMKB_SI_Barang_Stor (Kat_Stor, Kod_Ptj, Kod_Brg, Takat_Min, Takat_Max, Takat_Menokok, Status, Lod_Lokasi_Dtl) 
    '        VALUES ('{mohonPengesahan.kategoriStorPengesahan}', '{mohonPengesahan.pejabatLokasiPengesahan}', '{mohonPengesahan.senaraiBarangPengesahan}', '{mohonPengesahan.takatMinimaPengesahan}', '{mohonPengesahan.takatMaksimaPengesahan}', '{mohonPengesahan.takatMenokokPengesahan}', '{statusPengesahanArray(i)}'), '{pejabatLokasiDetailArray(i)}'"

    '            Dim result As String = RbQueryCmdMulti2(key, queryUpdate, param)
    '            If result <> "OK" Then
    '                Return "X"
    '            End If
    '        End If
    '    Next

    '    Return "OK"
    'End Function

    Private Function UpdateBarang(mohonPengesahan As BarangStorInsertDetail) As String
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        ' Split pejabatLokasiDetailPengesahan and statusPengesahan into arrays
        Dim pejabatLokasiDetailArray As String() = mohonPengesahan.pejabatLokasiDetailPengesahan.Split(",")
        Dim statusPengesahanArray As String() = mohonPengesahan.statusPengesahan.Split(",")

        ' Check existence of data
        Dim queryCheckExistence As String = $"Select * from SMKB_SI_Barang_Stor"
        Dim paramCheckExistence As New List(Of SqlParameter)
        Dim dtbl2 As DataTable = db.Read(queryCheckExistence, paramCheckExistence)

        For i As Integer = 0 To pejabatLokasiDetailArray.Length - 1
            Dim queryUpdate As String = ""
            Dim key As New Dictionary(Of String, String)
            key.Add("Kod_Ptj", mohonPengesahan.pejabatLokasiPengesahan)
            key.Add("Kod_Lokasi_Dtl", pejabatLokasiDetailArray(i))

            If dtbl2.Rows.Count > 0 Then
                Dim ck As Boolean = dtbl2.AsEnumerable().Any(Function(row) row.Field(Of String)("Kat_Stor") = mohonPengesahan.kategoriStorPengesahan And row.Field(Of String)("Kod_Ptj") = mohonPengesahan.pejabatLokasiPengesahan And row.Field(Of String)("Kod_Brg") = mohonPengesahan.senaraiBarangPengesahan And row.Field(Of String)("Kod_Lokasi_Dtl") = pejabatLokasiDetailArray(i))
                'Dim ck2 As Boolean = dtbl2.AsEnumerable().Any(Function(row) row.Field(Of String)("Kod_Ptj") = mohonPengesahan.pejabatLokasiPengesahan)
                'Dim ck3 As Boolean = dtbl2.AsEnumerable().Any(Function(row) row.Field(Of String)("Kod_Brg") = mohonPengesahan.senaraiBarangPengesahan)
                'Dim ck4 As Boolean = dtbl2.AsEnumerable().Any(Function(row) row.Field(Of String)("Kod_Lokasi_Dtl") = pejabatLokasiDetailArray(i))

                If ck Then
                    ' Value found
                    ' Row exists, perform UPDATE
                    queryUpdate = $"UPDATE SMKB_SI_Barang_Stor SET Status = '{statusPengesahanArray(i)}', Takat_Min = '{mohonPengesahan.takatMinimaPengesahan}', Takat_Max = '{mohonPengesahan.takatMaksimaPengesahan}', Takat_Menokok = '{mohonPengesahan.takatMenokokPengesahan}' WHERE Kat_Stor = '{mohonPengesahan.kategoriStorPengesahan}' AND Kod_Ptj = '{mohonPengesahan.pejabatLokasiPengesahan}' AND Kod_Lokasi_Dtl = '{pejabatLokasiDetailArray(i)}' AND Kod_Brg = '{mohonPengesahan.senaraiBarangPengesahan}'"

                    Dim result As String = RbQueryCmdMulti2(key, queryUpdate, param)
                    If result <> "OK" Then
                        Return "X"
                    End If
                Else
                    ' Row does not exist, perform INSERT
                    queryUpdate = $"INSERT INTO SMKB_SI_Barang_Stor (Kat_Stor, Kod_Ptj, Kod_Brg, Takat_Min, Takat_Max, Takat_Menokok, Status, Kod_Lokasi_Dtl) 
            VALUES ('{mohonPengesahan.kategoriStorPengesahan}', '{mohonPengesahan.pejabatLokasiPengesahan}', '{mohonPengesahan.senaraiBarangPengesahan}', '{mohonPengesahan.takatMinimaPengesahan}', '{mohonPengesahan.takatMaksimaPengesahan}', '{mohonPengesahan.takatMenokokPengesahan}', '{statusPengesahanArray(i)}', '{pejabatLokasiDetailArray(i)}')"

                    Dim result As String = RbQueryCmdMulti2(key, queryUpdate, param)
                    If result <> "OK" Then
                        Return "X"
                    End If
                End If
            Else
                ' Row does not exist, perform INSERT
                queryUpdate = $"INSERT INTO SMKB_SI_Barang_Stor (Kat_Stor, Kod_Ptj, Kod_Brg, Takat_Min, Takat_Max, Takat_Menokok, Status, Kod_Lokasi_Dtl) 
            VALUES ('{mohonPengesahan.kategoriStorPengesahan}', '{mohonPengesahan.pejabatLokasiPengesahan}', '{mohonPengesahan.senaraiBarangPengesahan}', '{mohonPengesahan.takatMinimaPengesahan}', '{mohonPengesahan.takatMaksimaPengesahan}', '{mohonPengesahan.takatMenokokPengesahan}', '{statusPengesahanArray(i)}', '{pejabatLokasiDetailArray(i)}')"

                Dim result As String = RbQueryCmdMulti2(key, queryUpdate, param)
                If result <> "OK" Then
                    Return "X"
                End If
            End If
        Next

        Return "OK"
    End Function

    Public Function RbQueryCmdMulti2(idKey As Dictionary(Of String, String), strQuery As String, paramDt As List(Of SqlParameter)) As String
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

    '-------------------- REFERENCE updateBarang END   -----------------------

End Class
