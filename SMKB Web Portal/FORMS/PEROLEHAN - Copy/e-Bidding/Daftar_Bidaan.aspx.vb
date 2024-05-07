Public Class Daftar_Bidaan
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Class BidaanHeader
        Public Property txtTarikhMula As String
        Public Property txtMasaMula As String
        Public Property txtTarikhTamat As String
        Public Property txtMasaTamat As String
        Public Property txtIdBidaan As String
        Public Property noSebutHarga5 As String
        Public Property Id_Jualan As String
        Public Property No_Mohon As String
        Public Property txtHargaMula As String
        Public Property kenaikanBidaanMinima As String


    End Class


    Public Class UpdateBidaan
        Public Property txtTarikhMula As String
        Public Property txtMasaMula As String
        Public Property txtTarikhTamat As String
        Public Property txtMasaTamat As String
        Public Property txtIdBidaan As String
        Public Property noSebutHarga5 As String
        Public Property Id_Jualan As String
        Public Property No_Mohon As String
        Public Property txtHargaMula As String
        Public Property kenaikanBidaanMinima As String

    End Class

    Public Class Pembelian_Hdr
        Public Property ddlIdPembelian As String
        Public Property ddlIdJualan As String
        Public Property dllNamaSykt As String
        Public Property ddlEmelSemasa As String
        Public Property ddLIDSyarikat As String
        Public Property dllNameSubMenu As String
        Public Property dllKodSubMenu As String
    End Class

End Class