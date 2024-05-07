Public Class CIDB
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class GredKerja
    Public Property KodGred As String
    Public Property HadUpaya As String
    Public Property Butiran As String
End Class

Public Class KatCIDB
    Public Property KodKat As String
    Public Property Butiran As String

End Class

Public Class Pengkhususan
    Public Property KodKhusus As String
    Public Property ButiranKhusus As String
    Public Property KodKat As String
    Public Property ButiranKat As String

End Class