Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json
Public Class Penilaian_Harga
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
End Class

Public Class Penilaian_Harga_EP
    Public Property noMohonValue As String
    Public Property txtUlasanHarga As String
    Public Property ckdUlasanSyor As String
    Public Property kodPembuka As String
    Public Property txtUlasanPembuka As String
    Public Property txtKuantiti As String
    Public Property ddlUkuran As String
    Public Property txtAngHrgSeunit As String
    Public Property txtJumAngHrg As String
    Public Property txtRankHarga As String
    Public Property txtStatusHarga As String
    Public Property kodSyarikat As String
    Public Property txtHargaSyarikat As String
    Public Property txtTkhTmtPerolehan As String
    Public Property txtUlasanHargaDtl As String
    Public Property IDPembelianDtl As String
    Public Property IDSyarikat As String
    Public Property txtRankHargaDtl As String
    Public Property txtNoLantikan As String
    Public Property idPembelian As String
    Public Property IDMesy As String


    Public Sub New()
    End Sub
    Public Sub New(noMohonValue_ As String, txtUlasanHarga_ As String, ckdUlasanSyor_ As String, kodPembuka_ As String, txtUlasanPembuka_ As String,
                   txtKuantiti_ As String, txtAngHrgSeunit_ As String, txtJumAngHrg_ As String, txtRankHarga_ As String, txtStatusHarga_ As String,
                   kodSyarikat_ As String, txtHargaSyarikat_ As String, txtTkhTmtPerolehan_ As String, txtUlasanHargaDtl_ As String,
                   IDPembelianDtl_ As String, IDSyarikat_ As String, txtRankHargaDtl_ As String, txtNoLantikan_ As String, idPembelian_ As String, IDMesy_ As String)

        noMohonValue = noMohonValue_
        txtUlasanHarga = txtUlasanHarga_
        ckdUlasanSyor = ckdUlasanSyor_
        kodPembuka = kodPembuka_
        txtUlasanPembuka = txtUlasanPembuka_
        txtKuantiti = txtKuantiti_
        txtAngHrgSeunit = txtAngHrgSeunit_
        txtJumAngHrg = txtJumAngHrg_
        txtRankHarga = txtRankHarga_
        txtStatusHarga = txtStatusHarga_
        kodSyarikat = kodSyarikat_
        txtHargaSyarikat = txtHargaSyarikat_
        txtTkhTmtPerolehan = txtTkhTmtPerolehan_
        txtUlasanHargaDtl = txtUlasanHargaDtl_
        IDPembelianDtl = IDPembelianDtl_
        IDSyarikat = IDSyarikat_
        txtRankHargaDtl = txtRankHargaDtl_
        txtNoLantikan = txtNoLantikan_
        idPembelian = idPembelian_
        IDMesy = IDMesy_
    End Sub

End Class