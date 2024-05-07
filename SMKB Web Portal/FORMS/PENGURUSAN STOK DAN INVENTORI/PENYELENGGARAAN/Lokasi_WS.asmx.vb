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
Public Class Lokasi_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim dtbl2 As DataTable
    Dim dt As DataTable
    Dim queryRB As New Query()

    '-------------------- REFERENCE tblLokasi START -----------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadLokasiData() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadLokasiData()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadLokasiData() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT 
    A.Kod_Lokasi AS KodLokasi, 
    A.Butiran AS Butiran, 
    A.Kod_Ptj,
    B.Pejabat,
    A.Kat_Stor, 
    A.Status,
    C.Butiran AS ButiranKategoriStor
FROM 
    SMKB_SI_Lokasi A
INNER JOIN 
    VPejabat B ON CONCAT(B.KodPejabat, '0000') = A.Kod_Ptj -- Adding three zeroes to B.KodPejabat
INNER JOIN 
    SMKB_Lookup_Detail C ON C.Kod_Detail = A.Kat_Stor
WHERE 
    C.Kod = 'SI002'
ORDER BY 
    CAST(SUBSTRING(A.Kod_Lokasi, 2, LEN(A.Kod_Lokasi) - 1) AS INT) ASC"

        Return db.Read(query)
    End Function
    '-------------------- REFERENCE tblLokasi END -------------------------
    '-------------------- REFERENCE tblLokasi2 START -----------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadLokasiData2() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadLokasiData2()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadLokasiData2() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select 
	                                A.Kod_Lokasi_Dtl AS KodLokasiDetail2,
	                                A.Kod_Lokasi AS KodLokasi2,
	                                A.Butiran AS Butiran2,
	                                A.Status AS Status2
	                                from SMKB_SI_Lokasi_Dtl A
	                                inner join SMKB_SI_Lokasi B on B.Kod_Lokasi = A.Kod_Lokasi"

        Return db.Read(query)
    End Function
    '-------------------- REFERENCE tblLokasi END -------------------------
    '-------------------- REFERENCE pejabatLokasi START -------------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetLokasiPejabat(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodLokasiPejabat(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodLokasiPejabat(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "select 
                                KodPejabat as value,
                                Pejabat as text
                                from VPejabat"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(kod) Then
            query &= "AND (Pejabat LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & kod & "%"))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE pejabatLokasi END   -------------------
    '-------------------- REFERENCE pejabatLokasi START -------------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetLokasiPejabat2(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodLokasiPejabat2(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodLokasiPejabat2(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "select 
                                KodPejabat as value,
                                Pejabat as text
                                from VPejabat"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(kod) Then
            query &= "AND (Pejabat LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & kod & "%"))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE pejabatLokasi END   -------------------
    '-------------------- REFERENCE kategoriStor START -------------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKategoriStor(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodKategoriStor(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodKategoriStor(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "Select 
                                Kod_Detail AS value,
                                Butiran AS text
                                from SMKB_Lookup_Detail where Kod = 'SI002'"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(kod) Then
            query &= "AND (Butiran LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & kod & "%"))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE kategoriStor END   -------------------
    '-------------------- REFERENCE kodLokasi2 START ----------------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetkodLokasi(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodkodLokasi(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodkodLokasi(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT 
                                Kod_Lokasi as value,
                                Kod_Lokasi as text 
                                FROM SMKB_SI_Lokasi
                                WHERE Status = '1' 
                                ORDER BY CAST(SUBSTRING(Kod_Lokasi, 2, LEN(Kod_Lokasi) - 1) AS INT) ASC"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(kod) Then
            query &= "AND (Kod_Lokasi LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & kod & "%"))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE kodLokasi2 END   ---------------------
    '-------------------- REFERENCE updateLokasi START   -----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan1(mohonPengesahan As LokasiInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPengesahan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query

        If InsertPengesahan1(mohonPengesahan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB.finish()

        resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPengesahan1(mohonPengesahan As LokasiInsertDetail) As String

        'Dim insertQuery As String = $"UPDATE SMKB_Pinjaman_Ulasan_Sokongan SET ID_Ulasan = '{mohonPengesahan.ulasanPengesahan}', Kat_Pinj = '{mohonPengesahan.kategoripinjPengesahan}', Status = '{mohonPengesahan.statusPengesahan}' WHERE ID_Rujukan = '{mohonPengesahan.rujukanPengesahan}' ;"
        Dim insertQuery As String = $"update SMKB_SI_Lokasi SET Butiran = '{mohonPengesahan.butiranLokasiPengesahan}', Kod_Ptj = '{mohonPengesahan.pejabatLokasiPengesahan}', Kat_Stor = '{mohonPengesahan.kategoriStorPengesahan}', Status = '{mohonPengesahan.statusLokasiPengesahan}' where Kod_Lokasi = '{mohonPengesahan.kodLokasiPengesahan}';"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@butiranLokasiPengesahan", mohonPengesahan.butiranLokasiPengesahan))
        insertParam.Add(New SqlParameter("@pejabatLokasiPengesahan", mohonPengesahan.pejabatLokasiPengesahan))
        insertParam.Add(New SqlParameter("@statusLokasiPengesahan", mohonPengesahan.statusLokasiPengesahan))
        insertParam.Add(New SqlParameter("@kategoriStorPengesahan", mohonPengesahan.kategoriStorPengesahan))
        insertParam.Add(New SqlParameter("@kodLokasiPengesahan", mohonPengesahan.kodLokasiPengesahan))

        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmd("Kod_Lokasi", mohonPengesahan.kodLokasiPengesahan, insertQuery, insertParam)

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
    '-------------------- REFERENCE updateLokasi END   -----------------------
    '-------------------- REFERENCE updateLokasi2 START   -----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan3(mohonPengesahan As LokasiInsertDetail) As String
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

        queryRB.finish()

        resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPengesahan3(mohonPengesahan As LokasiInsertDetail) As String

        'Dim insertQuery As String = $"UPDATE SMKB_Pinjaman_Ulasan_Sokongan SET ID_Ulasan = '{mohonPengesahan.ulasanPengesahan}', Kat_Pinj = '{mohonPengesahan.kategoripinjPengesahan}', Status = '{mohonPengesahan.statusPengesahan}' WHERE ID_Rujukan = '{mohonPengesahan.rujukanPengesahan}' ;"
        Dim insertQuery As String = $"update SMKB_SI_Lokasi_Dtl SET Butiran = '{mohonPengesahan.butiranLokasiPengesahan}', Status = '{mohonPengesahan.statusLokasiPengesahan}', Kod_Lokasi_Dtl = '{mohonPengesahan.KodLokasiDetailPengesahan}' where Kod_Lokasi = '{mohonPengesahan.kodLokasiPengesahan}';"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@butiranLokasiPengesahan", mohonPengesahan.butiranLokasiPengesahan))
        insertParam.Add(New SqlParameter("@statusLokasiPengesahan", mohonPengesahan.statusLokasiPengesahan))
        insertParam.Add(New SqlParameter("@kodLokasiPengesahan", mohonPengesahan.kodLokasiPengesahan))
        insertParam.Add(New SqlParameter("@kodLokasiDetailPengesahan", mohonPengesahan.KodLokasiDetailPengesahan))

        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmd3("Kod_Lokasi", mohonPengesahan.kodLokasiPengesahan, insertQuery, insertParam)

        Return insertResult
    End Function

    Public Function RbQueryCmd3(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
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
    '-------------------- REFERENCE updateLokasi2 END   -----------------------
    '-------------------- REFERENCE addLokasi START    -----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan2(mohonPengesahan As LokasiInsertDetail) As String
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

    Private Function InsertPengesahan2(mohonPengesahan As LokasiInsertDetail) As String
        Dim db As New DBKewConn

        Dim query As String = "SELECT CAST(COALESCE(MAX(CAST(SUBSTRING(Kod_Lokasi, 2, LEN(Kod_Lokasi) - 1) AS INT)), 0) + 1 AS VARCHAR) AS Kod_Lokasi 
    FROM SMKB_SI_Lokasi
"
        Dim param As New List(Of SqlParameter)
        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Dim insertQuery As String = $"INSERT INTO SMKB_SI_Lokasi (Butiran, Kod_Ptj, Kat_Stor, Status, Kod_Lokasi)
                                        VALUES ('{mohonPengesahan.butiranLokasiPengesahan}', '{mohonPengesahan.pejabatLokasiPengesahan}' + '0000', '{mohonPengesahan.kategoriStorPengesahan}'
                                        ,'{mohonPengesahan.statusLokasiPengesahan}','L' + '{dtbl.Rows(0).Item("Kod_Lokasi")}');"
            'Dim insertQuery As String = $"update SMKB_SI_Lokasi SET Butiran = '{mohonPengesahan.butiranLokasiPengesahan}', Kod_Ptj = '{mohonPengesahan.pejabatLokasiPengesahan}', Kat_Stor = '{mohonPengesahan.kategoriStorPengesahan}', Status = '{mohonPengesahan.statusLokasiPengesahan}' where Kod_Lokasi = '{mohonPengesahan.kodLokasiPengesahan}';"

            Dim insertParam As New List(Of SqlParameter)

            insertParam.Add(New SqlParameter("@butiranLokasiPengesahan", mohonPengesahan.butiranLokasiPengesahan))
            insertParam.Add(New SqlParameter("@pejabatLokasiPengesahan", mohonPengesahan.pejabatLokasiPengesahan))
            insertParam.Add(New SqlParameter("@statusLokasiPengesahan", mohonPengesahan.statusLokasiPengesahan))
            insertParam.Add(New SqlParameter("@kategoriStorPengesahan", mohonPengesahan.kategoriStorPengesahan))
            'insertParam.Add(New SqlParameter("@kodLokasiPengesahan", mohonPengesahan.kodLokasiPengesahan))

            ' Execute the insertion query
            Dim insertResult As String = RbQueryCmd2("Kod_Lokasi", dtbl.Rows(0).Item("Kod_Lokasi"), insertQuery, insertParam)

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
    '-------------------- REFERENCE addLokasi END   -----------------------
    '-------------------- REFERENCE addLokasi2 START    -----------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan4(mohonPengesahan As LokasiInsertDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPengesahan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query

        If InsertPengesahan4(mohonPengesahan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB.finish()

        resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPengesahan4(mohonPengesahan As LokasiInsertDetail) As String
        Dim db As New DBKewConn

        Dim query As String = "SELECT COALESCE(MAX(CAST(SUBSTRING(Kod_Lokasi_Dtl, 3, LEN(Kod_Lokasi_Dtl) - 2) AS INT)), 0) + 1 as Kod_Lokasi_Dtl 
FROM SMKB_SI_Lokasi_Dtl"
        Dim param As New List(Of SqlParameter)
        dtbl2 = db.Read(query, param)

        If dtbl2.Rows.Count > 0 Then
            Dim insertQuery As String = $"INSERT INTO SMKB_SI_Lokasi_Dtl (Butiran, Kod_Lokasi_Dtl, Status, Kod_Lokasi)
                                            VALUES ('{mohonPengesahan.butiranLokasiPengesahan}','LD' + '{dtbl2.Rows(0).Item("Kod_Lokasi_Dtl")}', '{mohonPengesahan.statusLokasiPengesahan}'
                                            ,'{mohonPengesahan.kodLokasiPengesahan}');"
            'Dim insertQuery As String = $"update SMKB_SI_Lokasi SET Butiran = '{mohonPengesahan.butiranLokasiPengesahan}', Kod_Ptj = '{mohonPengesahan.pejabatLokasiPengesahan}', Kat_Stor = '{mohonPengesahan.kategoriStorPengesahan}', Status = '{mohonPengesahan.statusLokasiPengesahan}' where Kod_Lokasi = '{mohonPengesahan.kodLokasiPengesahan}';"

            Dim insertParam As New List(Of SqlParameter)

            insertParam.Add(New SqlParameter("@butiranLokasiPengesahan", mohonPengesahan.butiranLokasiPengesahan))
            insertParam.Add(New SqlParameter("@statusLokasiPengesahan", mohonPengesahan.statusLokasiPengesahan))
            insertParam.Add(New SqlParameter("@kodLokasiPengesahan", mohonPengesahan.kodLokasiPengesahan))
            'insertParam.Add(New SqlParameter("@kodLokasiDetailPengesahan", mohonPengesahan.KodLokasiDetailPengesahan))

            ' Execute the insertion query
            Dim insertResult As String = RbQueryCmd4("Kod_Lokasi_Dtl", dtbl2.Rows(0).Item("Kod_Lokasi_Dtl"), insertQuery, insertParam)
            Return insertResult
        Else
            Return "X"
        End If

    End Function

    Public Function RbQueryCmd4(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
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
    '-------------------- REFERENCE addLokasi2 END   -----------------------
End Class
