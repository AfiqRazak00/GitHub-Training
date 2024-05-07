Public Class Daftar_Jawatankuasa
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Public Class JawatankuasaHeader
        Public Property ddlMod As String
        Public Property ddlKategori As String
        Public Property txtKodJawatankuasa As String
        Public Property txtNamaJawatankuasa As String
        Public Property DokumenType As String

        Public Property no_lantikan As String
        Public Property txtTarikhMula As String
        Public Property txtTarikhTamat As String
        Public Property ddlPtj As String
        Public Property ddlStaf As String
        Public Property ddlJawatan As String
        Public Property ddlKodJawatankuasa As String

    End Class


    Public Class UpdateAhJKHeader
        Public Property txtTarikhMulaR As String
        Public Property txtTarikhTamatR As String
        Public Property ddlPtjR As String
        Public Property ddlStafR As String
        Public Property ddlJawatanR As String
        Public Property noLantikanR As String
        Public Property id As String






    End Class


End Class