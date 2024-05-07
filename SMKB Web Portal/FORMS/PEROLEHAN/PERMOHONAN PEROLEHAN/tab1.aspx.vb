Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class tab1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class PoItemList
    Public Property text As String
    Public Property value As String

    Public Sub New()

    End Sub

    Public Sub New(text_, val_)
        text = text_
        value = val_
    End Sub
End Class


Public Class PermohonanPoHeader
    Public Property txtNoMohon As String
    Public Property lblTarikhPO As String
    Public Property lblStatus1 As String
    Public Property txtNoPO As String
    Public Property ddlTahun As String
    Public Property txtTujuan As String
    Public Property txtSkop As String
    Public Property ddlkategoriPO As String
    Public Property ddlPTJPemohon As String
    Public Property txtPemohon As String
    Public Property txtTkh As String
    Public Property txtAmaun As String
    Public Property txtJustifikasi As String
    Public Property ddlListPtj As String

    Public Property txtTarikh_Mula_Perolehan As String
    Public Property txtTempoh As String
    Public Property txtJenis_tempoh As String
    Public Property txtTarikh_Tamat_Perolehan As String
    Public Property tahapPerolehan As String

End Class

Public Class HantarPermohonan
    Public Property txtNoMohonR As String

End Class


Public Class PermohonanPoDetail
    Public Property id_mohonDtl As String
    Public Property bilangan As String
    Public Property No_MohonDTL As String
    Public Property coa_vot As String
    Public Property ddlPTj As String
    Public Property ddlKW As String
    Public Property ddlKodOperasi As String
    Public Property ddlKodProjek As String
    Public Property txtBakiPeruntukan As Decimal
    Public Property txtPerkara As String
    Public Property txtKuantiti As String
    Public Property ddlUkuran As String
    Public Property txtAngHrgSeunit As String
    Public Property txtJumAngHrg As String

    Public Sub New()
    End Sub
    Public Sub New(id_mohonDtl_ As String, bilangan_ As String, No_MohonDTL_ As String, coa_vot_ As String, ddlPTj_ As String, ddlKW_ As String, ddlKodOperasi_ As String, ddlKodProjek_ As String,
                   txtBakiPeruntukan_ As Decimal, txtPerkara_ As String, txtKuantiti_ As String, ddlUkuran_ As String,
                   txtAngHrgSeunit_ As String, txtJumAngHrg_ As String)
        id_mohonDtl = id_mohonDtl_
        bilangan = bilangan_
        No_MohonDTL = No_MohonDTL_
        coa_vot = coa_vot_
        ddlPTj = ddlPTj_
        ddlKW = ddlKW_
        ddlKodOperasi = ddlKodOperasi_
        ddlKodProjek = ddlKodProjek_
        txtBakiPeruntukan = txtBakiPeruntukan_
        txtPerkara = txtPerkara_
        txtKuantiti = txtKuantiti_
        ddlUkuran = ddlUkuran_
        txtAngHrgSeunit = txtAngHrgSeunit_
        txtJumAngHrg = txtJumAngHrg_
    End Sub


End Class


Public Class PermohonanPoSpekTeknikal
    Public Property idTeknikal As String
    Public Property no_MohonSpekTeknikal As String
    Public Property id_mohon_dtl As String
    Public Property butiran As String
    Public Property bilangan As String
    Public Property wajaran As String
    Public Property katPerolehan As String


    Public Sub New()
    End Sub

    Public Sub New(idTeknikal_ As String, no_MohonSpekTeknikal_ As String, id_mohon_dtl_ As String, butiran_ As String, bilangan_ As String, wajaran_ As String)
        idTeknikal = idTeknikal_
        no_MohonSpekTeknikal = no_MohonSpekTeknikal_
        id_mohon_dtl = id_mohon_dtl_
        butiran = butiran_
        bilangan = bilangan_
        wajaran = wajaran_
    End Sub
End Class


Public Class SimpanBidangMof
    Public Property idJualan As String
    Public Property kodBidang As String
    Public Property noMohon As String
    Public Property syarat As String
    Public Property urutan As String

    Public Sub New()
    End Sub

    Public Sub New(idJualan_ As String, kodBidang_ As String, noMohon_ As String, syarat_ As String, urutan_ As String)
        idJualan = idJualan_
        kodBidang = kodBidang_
        noMohon = noMohon_
        syarat = syarat_
        urutan = urutan_
    End Sub


End Class


Public Class SimpanBidangCidb
    Public Property idJualan As String
    Public Property kodkhusus As String
    Public Property noMohon As String
    Public Property situasiCidb As String
    Public Property urutan As String
    Public Property syarat As String
    Public Property kodkategori As String



    Public Sub New()
    End Sub

    Public Sub New(idJualan_ As String, kodkhusus_ As String, noMohon_ As String, situasiCidb_ As String, syarat_ As String, urutan_ As String, kodkategori_ As String)
        idJualan = idJualan_
        kodkhusus = kodkhusus_
        noMohon = noMohon_
        situasiCidb = situasiCidb_
        syarat = syarat_
        urutan = urutan_
        kodkategori = kodkategori_
    End Sub


End Class