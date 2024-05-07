Public Class DaftarPtPtj
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Class DaftarPTHdr
        Public Property txtNoMohon As String
        Public Property idSyarikat As String
        Public Property kodSyarikat As String
        Public Property NoPt As String
        Public Property kodPemiutang As String
        Public Property idMohonDtl As String()


    End Class

    Public Class Butiran
        Public Property idMohonDtl As String
        Public Property ddlListPembekal As String
        Public Property Id_Mohon_Dtl As String
        Public Property Kod_Kump_Wang As String
        Public Property Kod_Operasi As String
        Public Property Kod_Ptj As String
        Public Property Kod_Projek As String
        Public Property Kod_Vot As String
        Public Property Butiran As String
        Public Property Ukuran As String
        Public Property Kuantiti As String
        Public Property Kadar_Harga As String
        Public Property Jumlah_Harga As String
    End Class

End Class