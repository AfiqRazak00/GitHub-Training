Imports System.Data.SqlClient
Public Class Proses_Gaji_EOT
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        fBindPTJ()
        fBindStaf()
    End Sub
    Private Sub fBindPTJ()
        Try
            Dim dbconn As New DBKewConn("smsm")
            Dim strsql As String
            Dim bilptj As Integer


            strsql = $"select KodPejabat AS kod, Pejabat as butiran, Singkatan,KodPejabat + ' - ' + Pejabat as butirptj from MS_Pejabat_prod WHERE Status = 1 and KodPejabat not in ('50','-') order by KodPejabat"
            'Dim ds As New DataSet
            'Dim dt As New DataTable
            Dim ds = dbconn.fselectCommand(strsql)
            Using dt = ds.Tables(0)
                bilptj = dt.Rows.Count
            End Using
            ' Dim strKod = Trim(ds.Tables(0).Rows(0)("Kod").ToString)

            ddlPtjDr.DataSource = ds
            ddlPtjDr.DataTextField = "butirptj"
            ddlPtjDr.DataValueField = "Kod"
            ddlPtjDr.DataBind()


            ddlPtjDr.Items.Insert(0, New ListItem("- SILA PILIH -", 0))
            ddlPtjDr.SelectedIndex = 1


            ddlPtjHg.DataSource = ds
            ddlPtjHg.DataTextField = "butirptj"
            ddlPtjHg.DataValueField = "Kod"
            ddlPtjHg.DataBind()


            ddlPtjHg.Items.Insert(0, New ListItem("- SILA PILIH -", 0))
            ddlPtjHg.SelectedIndex = bilptj
            'If kodKlasifikasi = "" Then
            '    ddlPTJ.SelectedIndex = 0
            'Else
            '    ddlPTJ.Items.FindByValue(kodKlasifikasi.Trim()).Selected = True
            'End If

        Catch ex As Exception

        End Try
    End Sub
    Private Sub fBindStaf()
        Try
            Dim dbconn As New DBKewConn("smsm")
            Dim strsql As String
            Dim bilstaf As Integer


            strsql = $"select ms01_nostaf,ms01_nama,ms01_nostaf + ' - ' + ms01_nama as nmstaf from ms01_peribadi order by ms01_nostaf"
            'Dim ds As New DataSet
            'Dim dt As New DataTable
            Dim ds = dbconn.fselectCommand(strsql)
            Using dt = ds.Tables(0)
                bilstaf = dt.Rows.Count
            End Using
            ' Dim strKod = Trim(ds.Tables(0).Rows(0)("Kod").ToString)

            ddlStafDr.DataSource = ds
            ddlStafDr.DataTextField = "nmstaf"
            ddlStafDr.DataValueField = "ms01_nostaf"
            ddlStafDr.DataBind()


            ddlStafDr.Items.Insert(0, New ListItem("- SILA PILIH -", 0))
            ddlStafDr.SelectedIndex = 1

            ddlStafHg.DataSource = ds
            ddlStafHg.DataTextField = "nmstaf"
            ddlStafHg.DataValueField = "ms01_nostaf"
            ddlStafHg.DataBind()


            ddlStafHg.Items.Insert(0, New ListItem("- SILA PILIH -", 0))
            ddlStafHg.SelectedIndex = bilstaf
            'If kodKlasifikasi = "" Then
            '    ddlPTJ.SelectedIndex = 0
            'Else
            '    ddlPTJ.Items.FindByValue(kodKlasifikasi.Trim()).Selected = True
            'End If

        Catch ex As Exception

        End Try
    End Sub
End Class