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

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class JadualKelayakanWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim queryRB As New Query()

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FetchSenaraiKelayakan() As String
        'Dim dok As New List(Of String) From {"03"}
        Dim req As Response = GetDataKelayakan()
        Return JsonConvert.SerializeObject(req)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataKelayakan() As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"SELECT ROW_NUMBER() OVER (ORDER BY Jenis_Pinj) AS RowNum, 
                                        Jenis_Pinj As NoPinj,
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' And Kod_Detail = Jenis_Pinj) As JnsPinj, 
                                        FORMAT(Gaji_Dari , 'N2', 'en-us') As GajiDari,
                                        FORMAT(Gaji_Hingga , 'N2', 'en-us') As GajiHingga,
                                        Max_Tempoh As MxTmph,
                                        FORMAT(Max_Amaun , 'N2', 'en-us') As MxAmaun,
                                        Tahun_Layak As ThnLyk,
                                        Status
                                        From SMKB_Pinjaman_Kelayakan"

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

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function GetSelectedKelayakan(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        Dim query As String = $"SELECT Jenis_Pinj As KodJnsPinj,
                            (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' And Kod_Detail = Jenis_Pinj) As TxtJnsPinj, 
                            FORMAT(Gaji_Dari , 'N2', 'en-us') As GajiDari,
                            FORMAT(Gaji_Hingga , 'N2', 'en-us') As GajiHingga,
                            Max_Tempoh As MxTmph,
                            FORMAT(Max_Amaun , 'N2', 'en-us') As MxAmaun,
                            Tahun_Layak As ThnLyk,
                            Status from SMKB_Pinjaman_Kelayakan Where Jenis_Pinj = '{postDt("id")}'"

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
    Function KemaskiniKelayakan(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim resp As New ResponseRepository

        queryRB = New Query()
        Dim query As String = $"UPDATE SMKB_Pinjaman_Kelayakan
                                Set Gaji_Dari = '{postDt("GajiDari")}', Gaji_Hingga = '{postDt("GajiHingga")}', Max_Tempoh = '{postDt("MxTmph")}', Max_Amaun = '{postDt("MxAmaun")}', Status = '{postDt("Status")}'
                                Where Jenis_Pinj = '{postDt("JnsPinj")}'"

        ' Update SMKB_Pinjaman_Kelayakan
        If RbQueryCmd("Jenis_Pinj", postDt("JnsPinj"), query, param) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Maklumat kelayakan gagal di simpan")
        Else
            queryRB.finish()
            resp.Success("Data berjaya di kemaskini", "00")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function TambahKelayakan(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim db As New DBKewConn
        Dim resp As New ResponseRepository

        'Check Jenis_Pinj Is Available Or Not

        Dim query As String = $"Select * from SMKB_Pinjaman_Kelayakan Where Jenis_Pinj = '{postDt("JnsPinj")}'"

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            resp.Failed("Maklumat gagal disimpan, rekod telah wujud")
        Else
            queryRB = New Query()
            Dim query2 As String = $"INSERT INTO SMKB_Pinjaman_Kelayakan
                                    (Jenis_Pinj, Gaji_Dari, Gaji_Hingga, Max_Tempoh, Max_Amaun, Tahun_Layak, Status) 
                                    VALUES ('{postDt("JnsPinj")}','{postDt("GajiDari")}','{postDt("GajiHingga")}','{postDt("MxTmph")}','{postDt("MxAmaun")}','{postDt("ThnLyk")}','{postDt("Status")}')"
            ' Update SMKB_Pinjaman_Kelayakan
            If RbQueryCmd("Jenis_Pinj", postDt("JnsPinj"), query2, param) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Maklumat kelayakan gagal di simpan")
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