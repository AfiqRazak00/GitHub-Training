Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports System

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class KawalanElaunWS
    Inherits System.Web.Services.WebService

    Dim queryRB As New Query()

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchDdlElaun(ByVal q As String) As String
        Dim tmpDT As DataTable = fGetDdlElaun(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function fGetDdlElaun(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Butiran FROM SMKB_Gaji_Kod_Trans WHERE Jenis_Trans = @Jenis_Trans"

        ' Create a list to hold SQL parameters
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Jenis_Trans", "E"))

        ' Check if the search query is provided
        If Not String.IsNullOrEmpty(q) Then
            ' Add the condition for searching by Butiran to the WHERE clause
            query &= " AND (Butiran LIKE @kod2) "
            ' Add the search parameter
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        ' Add ORDER BY clause
        query &= " ORDER BY Butiran ASC"

        ' Execute the query with parameters
        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchElaunDetail(selectedElaun As String) As String
        Dim tmpDT As DataTable = fGetElaunDetail(selectedElaun)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function fGetElaunDetail(selectedElaun As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Trans FROM SMKB_Gaji_Kod_Trans WHERE Butiran = @Butiran"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Butiran", selectedElaun))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanKawalanElaun(butiranElaun, kodElaun, statusValue, isEdit) As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn

        queryRB = New Query() 'New Query
        If isEdit = False Then
            'Tambah Data Ke SMKB_LookUp_Detail
            If TambahElaun($"{butiranElaun}", $"{kodElaun}", $"{statusValue}") <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal menyimpan rekod ‼️")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Else
            If UpdateElaun($"{kodElaun}", $"{statusValue}") <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal menyimpan rekod ‼️")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        resp.Success("Rekod telah berjaya disimpan.", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function TambahElaun(butiranElaun, kodElaun, statusValue) As String
        Dim db As New DBKewConn

        Dim tarikhTamat As DateTime = DateTime.Now.AddYears(10)

        Dim query As String = "INSERT INTO SMKB_Lookup_Detail 
                                (Kod, Kod_Detail, Butiran, Keutamaan, Tarikh_Mula, Tarikh_Tamat, Status, Dibuat_oleh, Tarikh_Dibuat, Kod_Korporat) 
                                VALUES (@Kod, @Kod_Detail, @Butiran, @Keutamaan, @Tarikh_Mula, @Tarikh_Tamat, @Status, @Dibuat_oleh, @Tarikh_Dibuat, @Kod_Korporat)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod", "PJM31"))
        param.Add(New SqlParameter("@Kod_Detail", kodElaun))
        param.Add(New SqlParameter("@Butiran", butiranElaun))
        param.Add(New SqlParameter("@Keutamaan", "-"))
        param.Add(New SqlParameter("@Tarikh_Mula", Date.Now))
        param.Add(New SqlParameter("@Tarikh_Tamat", tarikhTamat))
        param.Add(New SqlParameter("@Status", statusValue))
        param.Add(New SqlParameter("@Dibuat_oleh", Session("ssusrID")))
        param.Add(New SqlParameter("@Tarikh_Dibuat", Date.Now))
        param.Add(New SqlParameter("@Kod_Korporat", "UTeM"))

        Return RbQueryCmd("Kod_Detail", kodElaun, query, param)
    End Function

    Private Function UpdateElaun(kodElaun, statusValue) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Lookup_Detail
                                SET Status = @Status
                                WHERE Kod_Detail = @Kod_Detail"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Status", statusValue))
        param.Add(New SqlParameter("@Kod_Detail", kodElaun))

        Return RbQueryCmd("Kod_Detail", kodElaun, query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function CheckDataExists(kodElaun As String) As String
        Dim tmpDT As DataTable = CheckElaun(kodElaun)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function CheckElaun(kodElaun As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "select * from SMKB_Lookup_Detail where Kod = @Kod AND Kod_Detail = @Kod_Detail"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod", "PJM31"))
        param.Add(New SqlParameter("@Kod_Detail", kodElaun))

        Return db.Read(query, param)
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
    Public Function fetchSenaraiElaun() As String
        Using dtUserInfo = fGetSenaraiElaun()
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetSenaraiElaun() As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = $"select * from SMKB_Lookup_Detail where Kod = @Kod"

        param.Add(New SqlParameter("@Kod", "PJM31"))

        Return dbconn.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchElaunRow(kodElaun) As String
        Using dtUserInfo = fGetElaunRow(kodElaun)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetElaunRow(kodElaun) As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = $"select * from SMKB_Lookup_Detail where Kod = @Kod AND Kod_Detail = @Kod_Detail"

        param.Add(New SqlParameter("@Kod", "PJM31"))
        param.Add(New SqlParameter("@Kod_Detail", kodElaun))

        Return dbconn.Read(query, param)
    End Function
End Class