Imports System.Web.Services
Imports Newtonsoft.Json

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration

Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports clsMail
Imports System.Reflection

Imports System.Data


Public Class Permohonan_TK
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Public strConEmail As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    Public Function myEmel(alamat, subject, body)
        Dim cnExec As OleDb.OleDbConnection
        Dim cmdExec As OleDb.OleDbCommand

        Try
            cnExec = New OleDb.OleDbConnection(strConEmail)
            cnExec.Open()

            cmdExec = New OleDbCommand("EXEC msdb.dbo.sp_send_dbmail @profile_name= 'EmailSmkb', @recipients= '" & alamat & "', @subject = '" & subject & "', " &
                  "@body= '" & Replace(body, "'", "''") & "', @body_format='HTML';", cnExec)
            cmdExec.ExecuteNonQuery()
            cmdExec.Dispose()
            cmdExec = Nothing
            cnExec.Dispose()
            cnExec.Close()
            cnExec = Nothing

            Return 1    'Proses Berjaya
        Catch ex As Exception
            ' Show the exception's message.
            MsgBox(ex.Message)
            Return 0    'Proses Gagal
        End Try

    End Function

    Protected Sub EmailJurnal3_Click(sender As Object, e As EventArgs) Handles EmailJurnal3.ServerClick

        Dim fullName As String = "Zulfa Wahida Binti Ahmad"
        Dim email As String = "zulfaw@utem.edu.my"

        'Send the New password to the user's email
        Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
        Dim body As String = "Semakan Permohonan Bajet " &
                     "<br><br>" &
                     vbCrLf & "Assalamualaikum Dan Salam Sejahtera " & fullName & "," &
                     "<br><br>" &
                     vbCrLf & "Memerlukan kelulusan anda untuk transaksi jurnal. " &
                     "<br><br>" &
                     vbCrLf & "Sila klik di link ini untuk menyemak permohonan bajet melalui <a href=""https://devmis.utem.edu.my/iutem/"">https://devmis.utem.edu.my/iutem/</a>" &
                     "<br>" &
                     "<br><br>" &
                     vbCrLf & "Email dijanakan secara automatik daripada UTeM - Sistem Maklunat Kewangan Bersepadu. " &
                     "<br><br>" &
                     vbCrLf & "Email ini tidak perlu dibalas."

        myEmel(email, subject, body)
    End Sub




End Class

Public Class ItemListTK
    Public Property text As String
    Public Property value As String

    Public Sub New()

    End Sub

    Public Sub New(text_, val_)
        text = text_
        value = val_
    End Sub
End Class

Public Class order_TK
    Public Property OrderID As String
    Public Property Tahun As String
    Public Property Butiran As String
    Public Property Amaun As String
    Public Property Dasar As String
    Public Property KategoriAgih As String
    Public Property KW As String
    Public Property KO As String
    Public Property KP As String
    Public Property Ptj As String
    Public Property Vot As String



    Public Sub New()

    End Sub

    Public Sub New(orderId_ As String, Tahun_ As String, Butiran_ As String, Amaun_ As String, Dasar_ As String, KategoriAgih_ As String,
                   KW_ As String, KO_ As String, KP_ As String, Ptj_ As String, Vot_ As String)

        OrderID = orderId_
        Tahun = Tahun_
        Butiran = Butiran_
        Amaun = Amaun_
        Dasar = Dasar_
        KategoriAgih = KategoriAgih_
        KW = KW_
        KO = KO_
        KP = KP_
        Ptj = Ptj_
        Vot = Vot_


    End Sub
End Class

