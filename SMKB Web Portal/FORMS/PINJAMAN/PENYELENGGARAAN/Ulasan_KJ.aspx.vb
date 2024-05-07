Public Class Ulasan_KJ
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class UlasanInsertDetail
    Public Property ulasanPengesahan As String
    Public Property kategoripinjPengesahan As String
    Public Property statusPengesahan As String
    Public Property rujukanPengesahan As String


    Public Sub New()
    End Sub
    Public Sub New(ulasanPengesahan_ As String, kategoripinjPengesahan_ As String, statusPengesahan_ As String, rujukanPengesahan_ As String)
        ulasanPengesahan = ulasanPengesahan_
        statusPengesahan = statusPengesahan_
        rujukanPengesahan = rujukanPengesahan_
    End Sub
End Class