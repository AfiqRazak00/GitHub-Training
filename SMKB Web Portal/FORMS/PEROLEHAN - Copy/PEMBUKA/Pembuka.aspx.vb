Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json
Public Class Pembuka
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class Pembuka_EP
    Public Property noMohonValue As String
    Public Property txtKaedahPerolehan As String
    Public Property txtNoJualan As String
    Public Property lblMasaBuka As String
    Public Property JnsPenilaian As String
    Public Property txtJawStaf As String
    Public Property txtPTJStaf As String
    Public Property txtEmailStaf As String
    Public Property txtNoStaf As String
    Public Property txtNamaStaf As String
    Public Property txtDStafHantar As String
    Public Property txtHadir As String
    Public Property lblTarikhMasaBuka As String
    Public Property lblTarikhMasaTamat As String
    Public Property lblTarikhMasaHantar As String
    Public Property txtStatusHantar As String
    Public Property txtTempat As String
    Public Property lblTarikhMasaMula As String
    Public Property rkMasaSah As String
    Public Property txtPembukaID As String
    Public Property IDMesy As String
    Public Property txtKodPTjStaf As String
    Public Property txtPeranan As String
    Public Property sequenceNumber As String
    Public Property kodPembuka As String
    Public Property txtUlasanPembuka As String
    Public Property kodSyarikat As String
    Public Property txtNoLantikan As String
    Public Property noSyarikat As String
    Public Property idPembelian As String
    Public Property KodDokumen As String
    Public Property statusPembuka As String
    Public Property syarikatCode As String



    'Public Property txtHadir As List(Of String)
    'Public Property Total_Harga As String

    'Public Property txtHadir As List(Of Integer)

    Public Sub New()
    End Sub
    Public Sub New(noMohonValue_ As String, txtNoJualan_ As String, JnsPenilaian_ As String, txtNoStaf_ As String, txtJawStaf_ As String, txtNamaStaf_ As String, txtHadir_ As String, txtPeranan_ As String,
                   lblTarikhMasaMula_ As String, txtPTJStaf_ As String, txtEmailStaf_ As String, txtDStafHantar_ As String, txtStatusHantar_ As String, txtTempat_ As String, txtKaedahPerolehan_ As String,
                   lblMasaBuka_ As String, lblTarikhMasaBuka_ As String, lblTarikhMasaHantar_ As String, lblTarikhMasaTamat_ As String, txtPembukaID_ As String, rkMasaSah_ As String, IDMesy_ As String,
                   txtKodPTjStaf_ As String, sequenceNumber_ As String, kodPembuka_ As String, txtUlasanPembuka_ As String, kodSyarikat_ As String, txtNoLantikan_ As String, noSyarikat_ As String,
                   idPembelian_ As String, KodDokumen_ As String, statusPembuka_ As String)

        noMohonValue = noMohonValue_
        txtKaedahPerolehan = txtKaedahPerolehan_
        txtNoJualan = txtNoJualan_
        JnsPenilaian = JnsPenilaian_
        txtHadir = txtHadir_
        txtNoStaf = txtNoStaf_
        txtDStafHantar = txtDStafHantar_
        txtJawStaf = txtJawStaf_
        txtPTJStaf = txtPTJStaf_
        txtPeranan = txtPeranan_
        txtKodPTjStaf = txtKodPTjStaf_
        txtEmailStaf = txtEmailStaf_
        txtNamaStaf = txtNamaStaf_
        txtTempat = txtTempat_
        lblTarikhMasaMula = lblTarikhMasaMula_
        lblMasaBuka = lblMasaBuka_
        lblTarikhMasaBuka = lblTarikhMasaBuka_
        lblTarikhMasaTamat = lblTarikhMasaTamat_
        lblTarikhMasaHantar = lblTarikhMasaHantar_
        txtPembukaID = txtPembukaID_
        txtStatusHantar = txtStatusHantar_
        rkMasaSah = rkMasaSah_
        IDMesy = IDMesy_
        sequenceNumber = sequenceNumber_
        kodPembuka = kodPembuka_
        txtUlasanPembuka = txtUlasanPembuka_
        kodSyarikat = kodSyarikat_
        txtNoLantikan = txtNoLantikan_
        noSyarikat = noSyarikat_
        idPembelian = idPembelian_
        KodDokumen = KodDokumen_
        statusPembuka = statusPembuka_
    End Sub

End Class
