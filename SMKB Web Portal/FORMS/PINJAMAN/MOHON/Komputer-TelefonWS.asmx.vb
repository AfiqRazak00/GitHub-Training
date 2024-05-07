Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System
Imports System.Collections.Generic

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Komputer_TelefonWS
    Inherits System.Web.Services.WebService

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiPermohonan() As String
        Dim dok As New List(Of String) From {"03"}
        Dim req As Response = getSenaraiPermohonan()
        Return JsonConvert.SerializeObject(req)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSenaraiPermohonan() As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = "SELECT ROW_NUMBER() OVER (ORDER BY No_Pinj) AS row_num, FORMAT(a.Tkh_Mohon, 'dd/MM/yyyy') AS Tkh_Mohon, a.No_Pinj, a.Jen_Pinj, b.Butiran, a.Status_Dok
		                                 From SMKB_Pinjaman_Master a
		                                 Inner join SMKB_Lookup_Detail b on a.Status_Dok = b.Kod_Detail And b.Kod = 'PJM24'
                                         WHERE
                                         a.Kod_Stat_Mohon = 'A'
                                         And a.Jen_Pinj In ('J00009')
		                                 And a.No_Staf = @noStaff"

                sqlcmd.Parameters.Add(New SqlParameter("@noStaff", "00020"))

                'If DateStart IsNot Nothing And DateStart <> "" Then
                '    sqlText += " AND hdr.Tarikh_Daftar >= @DateStart "
                '    sqlcmd.Parameters.Add(New SqlParameter("@DateStart", DateStart))
                'End If

                'If DateEnd IsNot Nothing And DateEnd <> "" Then
                '    sqlText += " AND hdr.Tarikh_Daftar <= @DateEnd "
                '    sqlcmd.Parameters.Add(New SqlParameter("@DateEnd", DateEnd))
                'End If

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