Public Class Cukai_Daftar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class DataCukaiHeader

    Public Property Kod As String
    Public Property Butiran As String

End Class
Public Class DataCukaiDet

    Public Property KodDet As String
    Public Property AmaunDet As String
    Public Property AmaunPek As String
    Public Property AmaunMaj As String

End Class