Public Class Tawaran_Iklan
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
End Class

Public Class TawaranIklan
    Public Property OrderNaskahID As String
    Public Property NoMohon As String

End Class

Public Class LesenTamatTempah
    Public Property KodDaftar As String
    Public Property tamatDate As DateTime
    Public Property Status As String
End Class