Public Class Perlantikan
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class Perlantikan_Vendor_EP
    Public Property noMohonValue As String
    Public Property kodPembuka As String
    Public Property txtKuantiti As String
    Public Property ddlUkuran As String
    Public Property txtAngHrgSeunit As String
    Public Property txtJumAngHrg As String
    Public Property kodSyarikat As String
    Public Property txtHargaSyarikat As String
    Public Property IDPembelianDtl As String
    Public Property IDSyarikat As String
    Public Property txtNoLantikan As String
    Public Property idPembelian As String
    Public Property txtUlasanSyor As String
    Public Property chkLantik As String
    Public Property txtUlasanLantik As String


    Public Sub New()
    End Sub
    Public Sub New(noMohonValue_ As String, kodPembuka_ As String, txtKuantiti_ As String, txtAngHrgSeunit_ As String, txtJumAngHrg_ As String,
                   kodSyarikat_ As String, txtHargaSyarikat_ As String, IDPembelianDtl_ As String, IDSyarikat_ As String, txtNoLantikan_ As String,
                   idPembelian_ As String, txtUlasanSyor_ As String, chkLantik_ As String, txtUlasanLantik_ As String)

        noMohonValue = noMohonValue_
        kodPembuka = kodPembuka_
        txtKuantiti = txtKuantiti_
        txtAngHrgSeunit = txtAngHrgSeunit_
        txtJumAngHrg = txtJumAngHrg_
        kodSyarikat = kodSyarikat_
        txtHargaSyarikat = txtHargaSyarikat_
        IDPembelianDtl = IDPembelianDtl_
        IDSyarikat = IDSyarikat_
        txtNoLantikan = txtNoLantikan_
        idPembelian = idPembelian_
        txtUlasanSyor = txtUlasanSyor_
        chkLantik = chkLantik_
        txtUlasanLantik = txtUlasanLantik_
    End Sub
End Class