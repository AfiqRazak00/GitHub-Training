Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Globalization
Imports System.IO
Imports System.Collections
Imports System.Web.HttpFileCollection

Public Class Pembayaran
    Inherits System.Web.UI.Page

    Private dbconn As New DBKewConn

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'SetActiveView(View7)
        mvSyarikat.SetActiveView(View7)
        fLoadView5()

    End Sub

    Private Sub fLoadView5()

        Dim NoSya = Session("ssusrID")
        Dim str = $"SELECT ID_Sykt, No_Sykt, Nama_Sykt, Emel_Semasa, Status_Bayar, Tahun_Aktif
                    FROM SMKB_Syarikat_Master 
                    WHERE No_Sykt = '{NoSya}'"

        Using dt = dbconn.fSelectCommandDt(str)

            If dt.Rows.Count > 0 Then
                Dim idSem = dt.Rows(0)("ID_Sykt")
                Dim OrderID = GenerateUpdatedID(idSem)
                Dim tahunAktif = dt.Rows(0)("Tahun_Aktif")
                Dim StatusBayar = dt.Rows(0)("Status_Bayar")
                Dim StatusIcon As String

                If tahunAktif IsNot DBNull.Value And tahunAktif <> "" Then
                    If tahunAktif = Now.Year Then
                        divStatusBayar.Visible = True
                        divBayar.Visible = False

                        'lblThnAktif.Text = StatAktif.ToString
                        If CBool(StatusBayar) = True Then
                            'lblStatusBayar.Text = "Berjaya"
                            MsgStatusBayar.Text = "Pembayaran Berjaya"
                            StatusIcon = "<i class='fas fa-check-circle circle-icon'></i>"
                            divStatusIcon.InnerHtml = StatusIcon

                        Else
                            'lblStatusBayar.Text = "Tidak Berjaya"
                            StatusIcon = "<i class='fas fa-times-circle circle-icon' style='color: red;'></i>"
                            divStatusIcon.InnerHtml = StatusIcon
                            MsgStatusBayar.Text = "Pembayaran Tidak Berjaya"
                            divStatusBayar.Visible = False
                            divBayar.Visible = True
                            'frame1.Attributes("src") = $"https://migs.utem.edu.my/migs_bookonline/PendaftaranSyarikat/Bayar2.php?IdSya={hdNoIDSemSya.Value}"
                            'frame1.Attributes("src") = $"https://epayment.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya={hdNoIDSemSya.Value}"
                            frame1.Attributes("src") = $"https://evendor.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya={OrderID}"
                            'frame1.Attributes("src") = $"https://evendor.utem.edu.my/mail.php?"
                        End If
                    Else
                        divStatusBayar.Visible = False
                        divBayar.Visible = True
                        'frame1.Attributes("src") = $"https://migs.utem.edu.my/migs_bookonline/PendaftaranSyarikat/Bayar2.php?IdSya={hdNoIDSemSya.Value}"
                        'frame1.Attributes("src") = $"https://epayment.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya={hdNoIDSemSya.Value}"
                        frame1.Attributes("src") = $"https://evendor.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya={OrderID}"
                        'frame1.Attributes("src") = $"https://evendor.utem.edu.my/mail.php?"
                    End If
                Else
                    divStatusBayar.Visible = False
                    divBayar.Visible = True
                    'frame1.Attributes("src") = $"https://migs.utem.edu.my/migs_bookonline/PendaftaranSyarikat/Bayar2.php?IdSya={hdNoIDSemSya.Value}"
                    'frame1.Attributes("src") = $"https://epayment.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya={hdNoIDSemSya.Value}"
                    frame1.Attributes("src") = $"https://evendor.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya={OrderID}"
                    'frame1.Attributes("src") = $"https://evendor.utem.edu.my/mail.php?"
                End If
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showModal", "$('#maklumanModal').modal('show'); document.getElementById('detailMakluman').innerText = 'Pembayaran Masih Tidak Terlaksana';", True)
            End If

        End Using
    End Sub

    Private Function GenerateUpdatedID(ByVal IdSya As String) As String
        Dim currentYear As Integer = Now.Year
        Dim lastTwoDigitsOfYear As Integer = currentYear Mod 100 ' Get last two digits of the year
        Dim updatedID As String = IdSya & lastTwoDigitsOfYear.ToString("D2") ' Append last two digits of year to original ID
        Return updatedID
    End Function

End Class