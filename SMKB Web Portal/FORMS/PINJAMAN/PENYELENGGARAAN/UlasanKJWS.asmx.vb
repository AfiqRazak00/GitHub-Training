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

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class UlasanKJWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim dt As DataTable
    Dim queryRB As New Query()

    '-------------------- REFERENCE TABLE START -----------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPengesahanUlasanData() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadPengesahanUlasanData()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadPengesahanUlasanData() As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"select
	                                (Select Butiran from SMKB_Lookup_Detail where Kod IN ('PJM15') AND Kod_Detail = A.Kat_Pinj) AS ButiranKenderaan,
	                                C.Butiran AS ButiranUlasan,
	                                A.Kat_Pinj AS KategoriPinjaman,
	                                A.ID_Ulasan AS IDUlasan,
	                                A.Status AS Status,
                                    A.ID_Rujukan AS Rujukan
                                from SMKB_Pinjaman_Ulasan_Sokongan A
                                inner join SMKB_Lookup_Detail C on C.Kod_Detail = A.ID_Ulasan
                                where C.Kod = 'PJM30';"

        Dim insertParam As New List(Of SqlParameter)

        Return db.Read(query)
    End Function
    '-------------------- REFERENCE TABLE END -------------------------
    '-------------------- REFERENCE DROPDOWN ULAS START -----------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function ulasanPinjaman(ByVal q As String) As String
        Dim tmpDT As DataTable = GetulasanPinjaman(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetulasanPinjaman(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Detail AS value, Butiran AS text FROM SMKB_Lookup_Detail WHERE Kod = 'PJM30'"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " AND Butiran LIKE '%' + @kod + '%' "
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE DROPDOWN ULAS END -------------------
    '-------------------- REFERENCE DROPDOWN KAT START -----------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function kategoriPinjaman(ByVal q As String) As String
        Dim tmpDT As DataTable = GetkategoriPinjaman(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetkategoriPinjaman(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Detail AS value, Butiran AS text FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15'"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " AND Butiran LIKE '%' + @kod + '%' "
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    '-------------------- REFERENCE DROPDOWN KAT END -------------------
    '-------------------- REFERENCE btnSimpaN1 START   ------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan1(mohonPengesahan As UlasanInsertDetail) As String
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

    Private Function InsertPengesahan1(mohonPengesahan As UlasanInsertDetail) As String

        Dim insertQuery As String = $"UPDATE SMKB_Pinjaman_Ulasan_Sokongan SET ID_Ulasan = '{mohonPengesahan.ulasanPengesahan}', Kat_Pinj = '{mohonPengesahan.kategoripinjPengesahan}', Status = '{mohonPengesahan.statusPengesahan}' WHERE ID_Rujukan = '{mohonPengesahan.rujukanPengesahan}' ;"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@ulasanPengesahan", mohonPengesahan.ulasanPengesahan))
        insertParam.Add(New SqlParameter("@kategoripinjPengesahan", mohonPengesahan.kategoripinjPengesahan))
        insertParam.Add(New SqlParameter("@statusPengesahan", mohonPengesahan.statusPengesahan))
        insertParam.Add(New SqlParameter("@rujukanPengesahan", mohonPengesahan.rujukanPengesahan))

        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmd("ID_Rujukan", mohonPengesahan.rujukanPengesahan, insertQuery, insertParam)

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
    '-------------------- REFERENCE btnSimpan1 END   ------------------------
    '-------------------- REFERENCE btnSimpan2 START   ------------------
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Save_Pengesahan2(mohonPengesahan As UlasanInsertDetail) As String
        Dim resp As New ResponseRepository
        Dim db = New DBKewConn

        resp.Success("Data telah disimpan")

        If mohonPengesahan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
        Dim queryTest As String = $"Select * from SMKB_Pinjaman_Ulasan_Sokongan Where Kat_Pinj = '{mohonPengesahan.kategoripinjPengesahan}' AND ID_Ulasan = '{mohonPengesahan.ulasanPengesahan}'"
        Dim insertParam As New List(Of SqlParameter)

        dtbl = db.Read(queryTest, insertParam)

        If dtbl.Rows.Count > 0 Then
            resp.Failed("Maklumat gagal disimpan, rekod telah wujud")
        Else
            queryRB = New Query

            If InsertPengesahan2(mohonPengesahan) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
            queryRB.finish()
            resp.Success("Rekod berjaya disimpan", "00", mohonPengesahan)
        End If


        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPengesahan2(mohonPengesahan As UlasanInsertDetail) As String

        Dim insertQuery As String = $"INSERT INTO SMKB_Pinjaman_Ulasan_Sokongan (ID_Ulasan, Kat_Pinj, Status, ID_Rujukan)
                                        VALUES ('{mohonPengesahan.ulasanPengesahan}', '{mohonPengesahan.kategoripinjPengesahan}', '{mohonPengesahan.statusPengesahan}', 
                                                (SELECT COALESCE(MAX(CAST(ID_Rujukan AS INT)), 0) + 1 FROM SMKB_Pinjaman_Ulasan_Sokongan));"

        Dim insertParam As New List(Of SqlParameter)

        insertParam.Add(New SqlParameter("@ulasanPengesahan", mohonPengesahan.ulasanPengesahan))
        insertParam.Add(New SqlParameter("@kategoripinjPengesahan", mohonPengesahan.kategoripinjPengesahan))
        insertParam.Add(New SqlParameter("@statusPengesahan", mohonPengesahan.statusPengesahan))

        Dim key As New Dictionary(Of String, String)
        key.Add("ID_Ulasan", mohonPengesahan.ulasanPengesahan)
        key.Add("Kat_Pinj", mohonPengesahan.kategoripinjPengesahan)

        ' Execute the insertion query
        Dim insertResult As String = RbQueryCmdMulti(key, insertQuery, insertParam)

        Return insertResult
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
    '-------------------- REFERENCE btnSimpan1 END   ------------------------
End Class