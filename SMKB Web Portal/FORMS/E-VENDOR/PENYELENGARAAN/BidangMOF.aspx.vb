Public Class BidangMOF
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class BidangUtama
    Public Property KodBU As String
    Public Property ButiranBU As String
End Class

Public Class SubBidang

    Public Property KodBU As String
    Public Property KodSB As String
    Public Property ButiranSB As String

End Class

Public Class Bidang
    Public Property KodBdg As String
    Public Property KodSB As String
    Public Property ButiranBdg As String
End Class