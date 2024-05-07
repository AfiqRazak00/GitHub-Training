Public Class Daftar_Pesanan_Belian
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class PembelianPoDtl

    Public Property id_mohonDtl As String
    Public Property coa_vot As String
    Public Property ddlKW As String
    Public Property ddlKodOperasi As String
    Public Property ddlKodProjek As String
    Public Property txtPerkara As String
    Public Property txtKuantiti As String
    Public Property ddlUkuran As String
    Public Property txtAngHrgSeunit As String
    Public Property txtJumAngHrg As String
    Public Property txtKadar_SST_update As String
    Public Property txtModal_update As String
    Public Property txtJenama_update As String
    Public Property ddlNegara_Pembuat_update As String
    Public Property txtFlag_sst As String
    Public Property txtHarga_Seunit_Tanpa_GST_update As String
    Public Property ddlPTj As String
    Public Property id_MohonDTL_PB As String
    Public Property ddlId_Pembelian As String
    Public Property txtAngHrgSeunitSST As String
    Public Property txtJumAngHrgSST As String


End Class


Public Class PembelianPoHdr

    Public Property ddlId_Pembelian As String
    Public Property ddlNo_Mohon As String
    Public Property ddlKod_Syarikat As String
    Public Property ddlTempoh As String
    Public Property ddlJenis_Tempoh As String
    Public Property ddlTarikh_Terima As String
    Public Property ddlTarikh_Hantar As String
    Public Property ddlID_Syarikat As String
    Public Property txtPTJ_Mohon As String
    Public Property ddlTarikh_Beli As String
    Public Property ddlKod_Pemiutang As String
    Public Property ddlPelulus_PO As String

End Class

Public Class LulusPBHdr
    Public Property txtNoMohon As String
    Public Property NoPt As String
    Public Property kPemiutang As String
    Public Property Kod_Kump_Wang As String
    Public Property Kod_Operasi As String
    Public Property Kod_Projek As String
    Public Property Kod_Ptj As String
    Public Property Kod_Vot As String
    Public Property Jumlah_Harga As String

End Class