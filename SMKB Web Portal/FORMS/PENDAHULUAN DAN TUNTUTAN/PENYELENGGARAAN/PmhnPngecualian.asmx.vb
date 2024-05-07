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
Public Class PmhnPngecualian
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
        Dim req As Response = GetDataSenarai()
        Return JsonConvert.SerializeObject(req)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataSenarai() As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"
                                            SELECT ROW_NUMBER() OVER (ORDER BY ID) AS RowNum, 
                                            ID, NoStaf,
                                            (Select Top 1 Nama FROM VPeribadi12 a WHERE a.NoStaf = b.NoStaf) As Nama, 
                                            PTj, (Select Top 1 NPejabat FROM VPeribadi12 a WHERE a.KodPejabat = PTj) As TxtPtj, 
                                            FORMAT(Tkh_Mula, 'dd/MM/yyyy') As Tkh_Mula, FORMAT(Tkh_Tamat, 'dd/MM/yyyy') As Tkh_Tamat
                                            From SMKB_Pendahuluan_Mohon_Kecuali b

                                        "

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
    Public Function GetStaff(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataStaff(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataStaff(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select NoStaf As value, Nama As text, Nama, NPejabat As PTj, KodPejabat As KodPtj FROM VPeribadi12"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(q) Then
            query &= " WHERE (NoStaf LIKE @kod2 OR Nama LIKE @kod2) "
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

        Dim query As String = $"SELECT NoStaf,
                            (Select Top 1 Nama FROM VPeribadi12 a WHERE a.NoStaf = b.NoStaf) As Nama, 
                            PTj, (Select Top 1 NPejabat FROM VPeribadi12 a WHERE a.KodPejabat = PTj) As TxtPtj, 
                            FORMAT(Tkh_Mula, 'yyyy-MM-dd') As Tkh_Mula, FORMAT(Tkh_Tamat, 'yyyy-MM-dd') As Tkh_Tamat
                            From SMKB_Pendahuluan_Mohon_Kecuali b Where ID = @id 
                            Order By ID Desc"

        param.Add(New SqlParameter("@id", postDt("id")))

        dtbl = db.Read(query, param)

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

        Dim query As String = $"Select Top 1 * From SMKB_Pendahuluan_Mohon_Kecuali Where NoStaf = @nostaf"

        param.Add(New SqlParameter("@nostaf", postDt("NoStaff")))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            resp.Failed("Maklumat gagal disimpan, rekod telah wujud [Error: 01]")
        Else
            queryRB = New Query()
            Dim query3 As String = $"INSERT INTO SMKB_Pendahuluan_Mohon_Kecuali
                                (ID, NoStaf, PTj, Tkh_Mula, Tkh_Tamat) 
                                VALUES (@id, @nostaf, @ptj, @tkhmula, @tkhtamat)"

            param.Clear()
            Dim newID As String = Date.Now.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
            param.Add(New SqlParameter("@id", newID))
            param.Add(New SqlParameter("@nostaf", postDt("NoStaff")))
            param.Add(New SqlParameter("@ptj", postDt("KodPtj")))
            param.Add(New SqlParameter("@tkhmula", postDt("TkhMula")))
            param.Add(New SqlParameter("@tkhtamat", postDt("TkhTamat")))

            If RbQueryCmd("ID", newID, query3, param) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Maklumat jadual pembiayaan gagal di simpan [Error: 02]")
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
        Dim query As String = $"UPDATE SMKB_Pendahuluan_Mohon_Kecuali
                            Set NoStaf = @nostaf, PTj = @ptj, Tkh_Mula = @tkhmula, Tkh_Tamat = @tkhtamat
                            Where Id = @id"

        param.Add(New SqlParameter("@id", ParseDtId(postDt("Id"), "yyyy-MM-ddTHH:mm:ss.fffffff")))
        param.Add(New SqlParameter("@nostaf", postDt("NoStaff")))
        param.Add(New SqlParameter("@ptj", postDt("Ptj")))
        param.Add(New SqlParameter("@tkhmula", postDt("TkhMula")))
        param.Add(New SqlParameter("@tkhtamat", postDt("TkhTamat")))

        ' Update SMKB_Pinjaman_Kelayakan
        If RbQueryCmd("ID", postDt("Id"), query, param) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Maklumat kelayakan gagal di simpan")
        Else
            queryRB.finish()

            Dim query2 As String = $"SELECT NoStaf,
                            (Select Top 1 Nama FROM VPeribadi12 a WHERE a.NoStaf = b.NoStaf) As Nama, 
                            PTj, (Select Top 1 NPejabat FROM VPeribadi12 a WHERE a.KodPejabat = PTj) As TxtPtj, 
                            FORMAT(Tkh_Mula, 'dd/MM/yyyy') As Tkh_Mula, FORMAT(Tkh_Tamat, 'dd/MM/yyyy') As Tkh_Tamat
                            From SMKB_Pendahuluan_Mohon_Kecuali b Where ID = @id 
                            Order By ID Desc"

            param.Clear()
            param.Add(New SqlParameter("@id", postDt("Id")))
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

        Return If(queryRB.execute(idValue, idKey, cmd) < 0, "X", "OK")
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

    'Faiz
    Function ParseDtId(stringValue As String, BaseFormat As String) As String
        Dim formattedDateTime As String = $"{stringValue.Substring(0, 19)}.{stringValue.Substring(20).PadRight(7, "0"c)}" 'Bagi ada 7 digit di akhir no id, termasuk trailing 0
        Dim parsedDate As DateTime = DateTime.ParseExact(formattedDateTime, BaseFormat, System.Globalization.CultureInfo.InvariantCulture)
        Return parsedDate.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
    End Function


End Class
