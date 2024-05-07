Imports System.Web.Services
Imports Newtonsoft.Json

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration

Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports clsMail
Imports System.Reflection


Public Class Permohonan_Bajet
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

Public Class ItemList
    Public Property text As String
    Public Property value As String

    Public Sub New()

    End Sub

    Public Sub New(text_, val_)
        text = text_
        value = val_
    End Sub
End Class

Public Class order_Bajet
    Public Property OrderID As String
    Public Property Tarikh As String
    Public Property PTJ As String
    Public Property Bahagian As String
    Public Property Unit As String
    Public Property PTJPusatBajet As String
    Public Property Dasar As String
    Public Property KumpWang As String
    Public Property KodKO As String
    Public Property KodKP As String
    Public Property Program As String
    Public Property Justifikasi As String
    Public Property Jumlah As Decimal
    Public Property OrderDetails As List(Of orderDetail_Bajet)

    Public Sub New()

    End Sub

    Public Sub New(orderId_ As String, Tarikh_ As String, PTJ_ As String, Bahagian_ As String, Unit_ As String, PTJPusatBajet_ As String, Dasar_ As String, KumpWang_ As String, KodKO_ As String, KodKP_ As String, Program_ As String, Justifikasi_ As String, Jumlah_ As Decimal, lOrderDetails_ As List(Of orderDetail_Bajet))
        OrderID = orderId_
        Tarikh = Tarikh_
        PTJ = PTJ_
        Bahagian = Bahagian_
        Unit = Unit_
        PTJPusatBajet = PTJPusatBajet_
        Dasar = Dasar_
        KumpWang = KumpWang_
        KodKO = KodKO_
        KodKP = KodKP_
        Program = Program_
        Justifikasi = Justifikasi_
        Jumlah = Jumlah_

        OrderDetails = lOrderDetails_


    End Sub
End Class

Public Class orderDetail_Bajet
    Public Property id As String
    Public Property OrderID As String
    Public Property Tarikh As String
    Public Property ddlObjAm As String
    Public Property Butiran As String
    Public Property Jumlah As Decimal

    Public Sub New()

    End Sub

    Public Sub New(Optional id_ As String = "", Optional orderId_ As String = "", Optional ddlObjAm_ As String = "", Optional Butiran_ As String = "",
                   Optional Jumlah_ As Decimal = 0.00, Optional Tarikh_ As String = "")
        id = id_
        OrderID = orderId_
        ddlObjAm = ddlObjAm_
        Butiran = Butiran_
        Jumlah = Jumlah_
        Tarikh = Tarikh_

    End Sub





End Class