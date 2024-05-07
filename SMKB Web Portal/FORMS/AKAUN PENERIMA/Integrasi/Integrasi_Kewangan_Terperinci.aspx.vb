Public Class Integrasi_Kewangan_Terperinci
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim penghutang As String = Request.QueryString("kodpenghutang")
        lblhidkodpenghutang.Text = penghutang
    End Sub

End Class