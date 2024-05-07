Imports System.Web.Services
Imports Newtonsoft.Json

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration

Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports clsMail
Imports System.Reflection



Public Class semakanbendahari
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("DariEmel") = "Ya" Then
            ClientScript.RegisterStartupScript(Me.GetType(), "CallMyFunction", "showModalAndReadSessionData();", True)
        Else
            Session("NoRujukan") = ""
        End If
    End Sub


    Public strConEmail As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    'Public Function myEmel(alamat, subject, body)
    '    Dim cnExec As OleDb.OleDbConnection
    '    Dim cmdExec As OleDb.OleDbCommand

    '    Try
    '        cnExec = New OleDb.OleDbConnection(strConEmail)
    '        cnExec.Open()

    '        cmdExec = New OleDbCommand("EXEC msdb.dbo.sp_send_dbmail @profile_name= 'EmailSmkb', @recipients= '" & alamat & "', @subject = '" & subject & "', " &
    '              "@body= '" & Replace(body, "'", "''") & "', @body_format='HTML';", cnExec)
    '        cmdExec.ExecuteNonQuery()
    '        cmdExec.Dispose()
    '        cmdExec = Nothing
    '        cnExec.Dispose()
    '        cnExec.Close()
    '        cnExec = Nothing

    '        Return 1    'Proses Berjaya
    '    Catch ex As Exception
    '        ' Show the exception's message.
    '        MsgBox(ex.Message)
    '        Return 0    'Proses Gagal
    '    End Try

    'End Function


End Class