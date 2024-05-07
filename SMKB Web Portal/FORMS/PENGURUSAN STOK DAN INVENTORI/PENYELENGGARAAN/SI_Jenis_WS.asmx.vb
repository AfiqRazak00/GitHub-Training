Imports System.ComponentModel
Imports System.Data.Entity.Core
Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Net.NetworkInformation
Imports System.Threading.Tasks
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Xml
Imports iTextSharp.text
Imports Microsoft.Ajax.Utilities
Imports Newtonsoft.Json
Imports Org.BouncyCastle.Asn1
Imports Org.BouncyCastle.Bcpg
Imports SMKB_Web_Portal.SI_Jenis
Imports WebGrease.Css.Extensions

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class SI_Jenis_WS
    Inherits System.Web.Services.WebService
    Dim dt As DataTable
    Dim tbl As DataTable
    Dim queryRB As New Query()

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function



    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKategori(ByVal q As String) As String


        Dim tmpDT As DataTable = GetKodKategori(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    'SaveJenis
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveJenisStok(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim db As New DBKewConn
        Dim resp As New ResponseRepository
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        Dim query As String = $"Select * from SMKB_SI_JENIS A, SMKB_LOOKUP_DETAIL B where A.Kod_Kategori = B.Kod_Detail AND B.Kod_Detail='{postDt("Ketegori")}' AND A.Butiran= '{postDt("Butiran")}'"
        tbl = db.Read(query, param)

        If tbl.Rows.Count > 0 Then
            resp.Failed("Maklumat gagal disimpan, rekod telah wujud")
        Else
            Dim lastID As String
            Dim query2 As String = $"SELECT MAX(CAST(SUBSTRING(Kod_Jenis, 2, LEN(Kod_Jenis)) AS INT)) AS Max_Kod_Jenis FROM SMKB_SI_Jenis"

            tbl = db.Read(query2, param)

            Dim nextId As String
            If tbl.Rows.Count > 0 Then
                ' Extract the numeric part of the last Kod_Jenis starting with "J"
                lastID = tbl.Rows(0)("Max_Kod_Jenis").ToString()
                'Dim numericPart As Integer = Integer.Parse(lastId.Substring(1))

                ' Increment the numeric part by 1 and concatenate with "J"
                nextId = "J" & (Integer.Parse(lastID) + 1)
            Else
                ' If no Kod_Jenis starting with "J" exists, start with "J1"
                nextId = "J1"
            End If

            queryRB = New Query()
            Dim query3 As String = $"INSERT INTO SMKB_SI_Jenis 
                                        (Kod_Jenis, Kod_Kategori, Butiran, Status) 
                                        VALUES ('{nextId}','{postDt("Ketegori")}','{postDt("Butiran")}','{postDt("Status")}')"


            Dim key As New Dictionary(Of String, String)
            key.Add("Kod_Kategori", postDt("Ketegori"))
            key.Add("Butiran", postDt("Butiran"))

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

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function Update_JenisStok(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim resp As New ResponseRepository

        queryRB = New Query()
        Dim query As String = $"UPDATE SMKB_SI_Jenis
                                Set  Kod_Kategori = '{postDt("Ketegori")}', Butiran = '{postDt("Butiran")}',Status = '{postDt("Status")}'
                                Where Kod_Jenis = '{postDt("Jenis")}'"

        ' Update SMKB_Pinjaman_Kelayakan
        If RbQueryCmd("Kod_Jenis", postDt("Jenis"), query, param) <> "OK" Then
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

    Private Function GetKodKategori(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran FROM SMKB_Lookup_Detail WHERE kod='SI001' AND Status ='1'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function ResolveAppUrl(relativeUrl As String) As String
        ' Get the base URL of your web application
        Dim baseUrl As String = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) & HttpContext.Current.Request.ApplicationPath.TrimEnd("/"c)

        ' Combine the base URL with the relative URL
        Dim resolvedUrl As String = New Uri(New Uri(baseUrl), relativeUrl).AbsoluteUri

        ' Return the resolved URL as JSON
        Return resolvedUrl
    End Function

    Private Function checkexist(Jenis As String)
        Dim db = New DBKewConn
        Dim query_check As String
        Dim param As New List(Of SqlParameter)

        query_check = "SELECT Kod_Jenis FROM SMKB_SI_Jenis WHERE Kod_Kategori=@ketegori"
        param.Add(New SqlParameter("@ketegori", Jenis))
        Return db.Read(query_check, param)

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

        Dim query As String = $"SELECT Kod_Jenis as Id,A.Butiran,A.Kod_Kategori, B.Butiran As ButiranKat,  A.Status
                          FROM SMKB_SI_Jenis A, SMKB_Lookup_Detail B
                          WHERE A.Kod_Kategori = B.Kod_Detail
                          AND Kod_Jenis='{postDt("kod")}' AND B.Kod = 'SI001'"

        tbl = db.Read(query)

        If tbl.Rows.Count > 0 Then
            resp.Success("Rekod ditemui", "00", tbl)
        Else
            resp.Failed("Tiada rekod ditemui")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

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

                Dim sqlText As String = $"SELECT A.Kod_Jenis as Id, A.Butiran, A.Kod_Kategori, B.Butiran As ButiranKat,  A.Status
                          FROM SMKB_SI_Jenis A, SMKB_Lookup_Detail B
                          WHERE A.Kod_Kategori = B.Kod_Detail
                          AND B.kod='SI001' ORDER BY (CAST(SUBSTRING(Kod_Jenis, 2, LEN(Kod_Jenis)) AS INT)) "

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
End Class