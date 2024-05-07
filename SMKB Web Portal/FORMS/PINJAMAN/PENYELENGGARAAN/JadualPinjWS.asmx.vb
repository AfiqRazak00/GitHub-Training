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
Public Class JadualPinjWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim queryRB As New Query()

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FetchSenarai() As String
        'Dim dok As New List(Of String) From {"03"}
        Dim req As Response = GetSenarai()
        Return JsonConvert.SerializeObject(req)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSenarai() As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"SELECT ROW_NUMBER() OVER (ORDER BY CONVERT(INT, Jadual_ID) ASC) AS RowNum,
                                        Jadual_ID As Id,
                                        Tempoh,
                                        (Select Butiran From SMKB_Lookup_Detail Where Kod = 'PJM15' And Kod_Detail = Kategori_Pinj ) As KatPinj, 
                                        FORMAT(Amaun , 'N2', 'en-us') As Amaun,
                                        FORMAT(Ansuran , 'N2', 'en-us') As Ansuran,
                                        Status
                                        From SMKB_Pinjaman_Jadual"

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

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function GetSelectedRow(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        Dim query As String = $"SELECT Kategori_Pinj As KodKatPinj,
                            (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM15' And Kod_Detail = Kategori_Pinj) As TxtKatPinj, 
                            FORMAT(Ansuran , 'N2', 'en-us') As Ansuran,
                            FORMAT(Amaun , 'N2', 'en-us') As Amaun,
                            Tempoh As Tempoh,
                            Status,
                            Status from SMKB_Pinjaman_Jadual Where Jadual_ID = '{postDt("id")}'"

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
    Function KemaskiniJdlPinjaman(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim resp As New ResponseRepository

        queryRB = New Query()
        Dim query As String = $"UPDATE SMKB_Pinjaman_Jadual
                                Set Amaun = '{postDt("Amaun")}', Ansuran = '{postDt("Ansuran")}', Tempoh = '{postDt("Tempoh")}', Status = '{postDt("Status")}'
                                Where Jadual_ID = '{postDt("TargetId")}'"

        ' Update SMKB_Pinjaman_Kelayakan
        If RbQueryCmd("Jadual_ID", postDt("TargetId"), query, param) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Maklumat jadual pembiayaan gagal di simpan")
        Else
            queryRB.finish()
            resp.Success("Data berjaya di kemaskini", "00")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function TambahJadualPinjaman(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim db As New DBKewConn
        Dim resp As New ResponseRepository
        Dim dtbl2 As DataTable

        'Check Jenis_Pinj Is Available Or Not

        Dim query As String = $"Select * from SMKB_Pinjaman_Jadual Where Kategori_Pinj = '{postDt("KatPinj")}' And Tempoh = '{postDt("Tempoh")}' And Amaun = '{postDt("Amaun")}'"

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            resp.Failed("Maklumat gagal disimpan, rekod telah wujud")
        Else
            Dim lastID As Integer = 1
            Dim query2 As String = $" SELECT TOP 1 CONVERT(INT, Jadual_ID) AS Id FROM SMKB_Pinjaman_Jadual ORDER BY CONVERT(INT, Jadual_ID) DESC"

            dtbl2 = db.Read(query2, param)
            If dtbl2.Rows.Count > 0 Then
                lastID = CInt(dtbl2.Rows(0).Item("Id")) + 1
            End If

            queryRB = New Query()
            Dim query3 As String = $"INSERT INTO SMKB_Pinjaman_Jadual
                                (Jadual_ID, Kategori_Pinj, Tempoh, Kadar_Tempoh, Amaun, Ansuran, Status) 
                                VALUES ('{CStr(lastID)}','{postDt("KatPinj")}','{postDt("Tempoh")}','T00002','{postDt("Amaun")}','{postDt("Ansuran")}','{postDt("Status")}')"

            Dim key As New Dictionary(Of String, String)
            key.Add("Kategori_Pinj", postDt("KatPinj"))
            key.Add("Tempoh", postDt("Tempoh"))
            key.Add("Amaun", postDt("Amaun"))

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