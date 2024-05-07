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


Public Class Kelulusan_Viremen_Bendahari
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

'Public Class ItemListVirenen
'    Public Property text As String
'    Public Property value As String

'    Public Sub New()

'    End Sub

'    Public Sub New(text_, val_)
'        text = text_
'        value = val_
'    End Sub
'End Class

'Public Class order_Viremen
'    Public Property OrderID As String
'    Public Property Tujuan As String
'    Public Property Rujukan As String
'    Public Property Jumlah As String
'    Public Property KW As String
'    Public Property KO As String
'    Public Property KP As String
'    Public Property PTJ As String
'    Public Property VOT As String

'    Public Property KW_Drpd As String
'    Public Property KO_Drpd As String
'    Public Property KP_Drpd As String
'    Public Property Ptj_Drpd As String
'    Public Property Vot_Drpd As String

'    Public Property KW_Kpd As String
'    Public Property KO_Kpd As String
'    Public Property KP_Kpd As String
'    Public Property Ptj_Kpd As String
'    Public Property Vot_Kpd As String

'    Public Sub New()

'    End Sub

'    Public Sub New(orderId_ As String, Tujuan_ As String, Rujukan_ As String, Jumlah_ As String, KW_ As String, KO_ As String, KP_ As String, PTJ_ As String, VOT_ As String,
'                   KW_Drpd_ As String, KO_Drpd_ As String, KP_Drpd_ As String, Ptj_Drpd_ As String, Vot_Drpd_ As String,
'                   KW_Kpd_ As String, KO_Kpd_ As String, KP_Kpd_ As String, Ptj_Kpd_ As String, Vot_Kpd_ As String)

'        OrderID = orderId_
'        Tujuan = Tujuan_
'        Rujukan = Rujukan_
'        KW = KW_
'        KO = KO_
'        KP = KP_
'        PTJ = PTJ_
'        VOT = VOT_

'        KW_Drpd = KW_Drpd_
'        KO_Drpd = KO_Drpd_
'        KP_Drpd = KP_Drpd_
'        Ptj_Drpd = Ptj_Drpd_
'        Vot_Drpd = Vot_Drpd_

'        KW_Kpd = KW_Kpd_
'        KO_Kpd = KO_Kpd_
'        KP_Kpd = KP_Kpd_
'        Ptj_Kpd = Ptj_Kpd_
'        Vot_Kpd = Vot_Kpd_

'    End Sub
'End Class

