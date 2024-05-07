Public Class Maklumat_Pengalaman
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class PengalamanSyarikat
    Public Property IdPengalaman As String
    Public Property IdSemSya As String
    Public Property OrderID As String
    Public Property Tajuk As String
    Public Property NamaSyarikat As String
    Public Property TkhMula As String
    Public Property TkhTamat As String
    Public Property NilaiProjek As Decimal?
End Class