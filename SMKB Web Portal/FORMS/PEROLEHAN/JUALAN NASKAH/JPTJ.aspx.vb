Public Class JPTJ
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Class HantarNaskah_Jualan


        Public Property txtNoMohon As String
        Public Property txtIdJualan As String
        Public Property txtTarikh_Daftar As String
        Public Property txtNo_Sebut_Harga As String
        Public Property txtHarga As String
        Public Property txtGred_CIDB As String
        Public Property txtLawatan_Tapak As String
        Public Property txtTempat_Lawatan_Tapak As String
        Public Property txtTarikh_Masa_Lawatan_Tapak As String
        Public Property txtTarikh_Masa_Mula_Iklan As String
        Public Property txtTarikh_Masa_Mula_Perolehan As String
        Public Property txtTarikh_Masa_Tamat_Perolehan As String
        Public Property txtTempat_Hantar As String
        Public Property txtNo_Staf As String
        Public Property txtSyarat_Perolehan As String
        Public Property txtStatus_Lanjut As String
        Public Property txtStatus As String
        Public Property ddlKodPTj As String

    End Class

    Public Class HantarLesen


        Public Property txtNoMohon As String
        Public Property txtIdJualan As String
        Public Property txtKod_Lesen As String
        Public Property txtStatus As String

    End Class

End Class