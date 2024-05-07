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
Public Class KawalanPinjWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim queryRB As New Query()

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FetchSenaraiKawalanPinj() As String
        'Dim dok As New List(Of String) From {"03"}
        Dim req As Response = GetDataKawalanPinj()
        Return JsonConvert.SerializeObject(req)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataKawalanPinj() As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"SELECT ROW_NUMBER() OVER (ORDER BY ID) AS RowNum, 
                                        ID,
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15' And Kod_Detail = Kategori_Pinj) As TxtKatPinj, 
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' And Kod_Detail = Jenis_Pinj) As TxtJnsPinj, 
                                        (Vot + ' - ' + (Select Butiran FROM SMKB_Vot WHERE Kod_Vot = Vot)) As TxtVot, 
                                        (Select Butiran FROM SMKB_Gaji_Kod_Trans WHERE Kod_Trans = Kod_Potongan) As TxtPotongan, 
                                        FORMAT(Faedah, 'N2') As Faedah
                                        From SMKB_Pinjaman_Kawalan"

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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKategoriPinjaman(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataKategoriPinjaman(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataKategoriPinjaman(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select Kod_Detail As value, Butiran As text FROM SMKB_Lookup_Detail WHERE Kod = @kod"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM15"))

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisPinjaman(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataJenisPinjaman(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisPinjaman(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select Kod_Detail As value, Butiran As text FROM SMKB_Lookup_Detail WHERE Kod = @kod"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM01"))

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVot(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataVot(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataVot(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select Kod_Vot As value, (Kod_Vot + ' - ' + Butiran) As text FROM SMKB_Vot"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(q) Then
            query &= " Where (Kod_Vot LIKE @kod2 OR Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        Return db.Read(query, param)

    End Function

        <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPotongan(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataPotongan(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataPotongan(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select Kod_Trans As value, (Kod_Trans + ' - ' + Butiran) As text FROM SMKB_Gaji_Kod_Trans"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(q) Then
            query &= " Where (Kod_Trans LIKE @kod2 OR Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        Return db.Read(query, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function GetSelectedRow(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        Dim query As String = $"SELECT 
                                Kategori_Pinj As KodKatPinj,
                                (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15' And Kod_Detail = Kategori_Pinj) As TxtKatPinj, 
                                Jenis_Pinj As KodJenPinj,
                                (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' And Kod_Detail = Jenis_Pinj) As TxtJenPinj, 
                                Vot As KodVot,
                                (Select Butiran FROM SMKB_Vot WHERE Kod_Vot = Vot) As TxtVot, 
                                Kod_Potongan As KodPotongan,
                                (Select Butiran FROM SMKB_Gaji_Kod_Trans WHERE Kod_Trans = Kod_Potongan) As TxtPotongan, 
                                FORMAT(Faedah, 'N2') As Faedah
                                From SMKB_Pinjaman_Kawalan Where ID = '{postDt("id")}'"

        dtbl = db.Read(query)

        If dtbl.Rows.Count > 0 Then
            resp.Success("Rekod ditemui", "00", dtbl)
        Else
            resp.Failed("Tiada rekod ditemui")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function TambahData(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim db As New DBKewConn
        Dim resp As New ResponseRepository
        Dim dtbl2 As DataTable

        'Check Jenis_Pinj Is Available Or Not

        Dim query As String = $"Select * From SMKB_Pinjaman_Kawalan Where Kategori_Pinj = '{postDt("KatPinj")}' And Jenis_Pinj = '{postDt("JenPinj")}'"

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            resp.Failed("Maklumat gagal disimpan, rekod telah wujud")
        Else
            Dim lastID As Integer = 1
            Dim query2 As String = $"SELECT TOP 1 CONVERT(INT, ID) AS Id FROM SMKB_Pinjaman_Kawalan ORDER BY CONVERT(INT, ID) DESC"

            dtbl2 = db.Read(query2, param)
            If dtbl2.Rows.Count > 0 Then
                lastID = CInt(dtbl2.Rows(0).Item("Id")) + 1
            End If

            queryRB = New Query()
            Dim query3 As String = $"INSERT INTO SMKB_Pinjaman_Kawalan
                                (Kategori_Pinj, Jenis_Pinj, Vot, Kod_Potongan, Faedah, ID) 
                                VALUES ('{postDt("KatPinj")}','{postDt("JenPinj")}','{postDt("Vot")}','{postDt("Potongan")}','{postDt("Faedah")}', '{lastID}')"

            Dim key As New Dictionary(Of String, String)
            key.Add("Kategori_Pinj", postDt("KatPinj"))
            key.Add("Jenis_Pinj", postDt("JenPinj"))

            If RbQueryCmdMulti(key, query3, param) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Maklumat jadual pembiayaan gagal di simpan")
            Else
                queryRB.finish()
                resp.Success("Data berjaya di disimpan", "00")
            End If
        End If
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function KemaskiniData(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn

        queryRB = New Query()
        Dim query As String = $"UPDATE SMKB_Pinjaman_Kawalan
                            Set Jenis_Pinj = '{postDt("JenPinj")}', Vot = '{postDt("Vot")}', Kod_Potongan = '{postDt("Potongan")}', Faedah = '{postDt("Faedah")}'
                            Where Id = '{postDt("Id")}'"

        ' Update SMKB_Pinjaman_Kelayakan
        If RbQueryCmd("ID", postDt("Id"), query, param) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Maklumat kelayakan gagal di simpan")
        Else
            queryRB.finish()

            Dim query2 As String = $"Select (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' And Kod_Detail = Jenis_Pinj) As TxtJenPinj, 
                                ( Vot + ' - ' + (Select Butiran FROM SMKB_Vot WHERE Kod_Vot = Vot)) As TxtVot, 
                                (Select Butiran FROM SMKB_Gaji_Kod_Trans WHERE Kod_Trans = Kod_Potongan) As TxtPotongan
                                From SMKB_Pinjaman_Kawalan Where ID = '{postDt("Id")}'"

            dtbl = db.Read(query2, param)

            resp.Success("Data berjaya di kemaskini", "00", dtbl)
        End If

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