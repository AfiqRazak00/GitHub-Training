Public Class Daftar_GRN_SRN
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class GRN

    Public Property idPembelian As String
    Public Property txtTujuan As String
    Public Property txtTujuanDisplay As String
    Public Property noMohonValue As String
    Public Property noSebutHarga As String
    Public Property totalHarga As String
    Public Property idSyarikat As String
    Public Property txtNoGrn As String
    Public Property txtNoGrnDtl As String
    Public Property idMohonDtl As String
    Public Property txtNoPT As String
    Public Property txtBekalKepada As String
    Public Property txtKodBekalKepada As String
    Public Property txtTkhDO As String
    Public Property txtNoDO As String
    Public Property txtTkhTerimaDO As String
    Public Property itemTerima As String
    Public Property txtUlasanDO As String
    Public Property itemBakiTinggal As String
    Public Property itemKuantiti As String
    Public Property txtFailDO As String
    Public Property totalhargaGRN As String

    Public Sub New()
    End Sub
    Public Sub New(idPembelian_ As String, txtTujuan_ As String, txtTujuanDisplay_ As String, noMohonValue_ As String, noSebutHarga_ As String, totalHarga_ As String, idSyarikat_ As String,
                   txtNoGrn_ As String, idMohonDtl_ As String, txtNoPT_ As String, txtBekalKepada_ As String, txtKodBekalKepada_ As String, itemBakiTinggal_ As String, txtTkhDO_ As String,
                   txtNoDO_ As String, txtTkhTerimaDO_ As String, itemTerima_ As String, txtUlasanDO_ As String, itemKuantiti_ As String, txtNoGrnDtl_ As String, txtFailDO_ As String,
                   totalhargaGRN_ As String)

        idPembelian = idPembelian_
        noMohonValue = noMohonValue_
        txtTujuan = txtTujuan_
        txtTujuanDisplay = txtTujuanDisplay_
        noSebutHarga = noSebutHarga_
        totalHarga = totalHarga_
        idSyarikat = idSyarikat_
        txtNoGrn = txtNoGrn_
        idMohonDtl = idMohonDtl_
        txtNoPT = txtNoPT_
        txtBekalKepada = txtBekalKepada_
        txtKodBekalKepada = txtKodBekalKepada_
        txtTkhDO = txtTkhDO_
        txtNoDO = txtNoDO_
        txtTkhTerimaDO = txtTkhTerimaDO_
        itemTerima = itemTerima_
        txtUlasanDO = txtUlasanDO_
        txtUlasanDO = txtUlasanDO_
        itemBakiTinggal = itemBakiTinggal_
        itemKuantiti = itemKuantiti_
        txtNoGrnDtl = txtNoGrnDtl_
        txtFailDO = txtFailDO_
        totalhargaGRN = totalhargaGRN_

    End Sub

End Class

Public Class GrnItem
    Public Property idMohonDtl As String
    Public Property txtNoGrn As String
    Public Property itemTerima As String
    Public Property itemKuantiti As String
    Public Property itemBakiTinggal As String
    Public Property amaunGRNTerima As String
    Public Property itemSemasa As String
    Public Property amaunSemasa As String
    Public Property beza As String
    Public Property beza2 As String

End Class