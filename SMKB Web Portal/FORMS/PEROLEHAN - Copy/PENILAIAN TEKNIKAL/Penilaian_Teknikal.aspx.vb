Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json
Public Class Penilaian_Teknikal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
End Class

Public Class Penilaian_Teknikal_EP
    Public Property noMohonValue As String
    Public Property txtUlasanTeknikal As String
    Public Property txtUlasanHarga As String
    Public Property ckdUlasanTeknikal As String
    Public Property kodPembuka As String
    Public Property txtTkhTamatPembuka As String
    Public Property idMohonDtl As String
    Public Property kodSyarikat As String
    Public Property IDMesy As String
    Public Property No_Lantik As String
    Public Property SkorTeknikal As String
    Public Property txtKodSpek As String
    Public Property IdAmJawapan As String
    Public Property txtTotalWajaran As String
    Public Property percentAm As String
    Public Property percentTek As String
    Public Property skorSpekAm As String
    Public Property skorAmTab As String
    Public Property skorSpekTeknikal As String
    Public Property idPembelian As String
    Public Property idTeknikal As String
    Public Property idAm As String
    Public Property jumTotalWajaran As String
    Public Property txtNoLantikan As String
    Public Property idSyarikat As String


    Public Sub New()
        End Sub
    Public Sub New(noMohonValue_ As String, txtUlasanTeknikal_ As String, ckdUlasanTeknikal_ As String, kodPembuka_ As String, txtTkhTamatPembuka_ As String, idMohonDtl_ As String, IDMesy_ As String,
                   No_Lantik_ As String, SkorTeknikal_ As String, txtKodSpek_ As String, IdAmJawapan_ As String, txtTotalWajaran_ As String, percentAm_ As String, skorSpekAm_ As String, kodSyarikat_ As String,
                   idPembelian_ As String, idTeknikal_ As String, skorSpekTeknikal_ As String, jumTotalWajaran_ As String, percentTek_ As String, skorAmTab_ As String, txtUlasanHarga_ As String, idAm_ As String,
                   txtNoLantikan_ As String, idSyarikat_ As String)

        noMohonValue = noMohonValue_
        txtUlasanTeknikal = txtUlasanTeknikal_
        txtUlasanHarga = txtUlasanHarga_
        ckdUlasanTeknikal = ckdUlasanTeknikal_
        kodPembuka = kodPembuka_
        txtTkhTamatPembuka = txtTkhTamatPembuka_
        idMohonDtl = idMohonDtl_
        kodSyarikat = kodSyarikat_
        IDMesy = IDMesy_
        No_Lantik = No_Lantik_
        SkorTeknikal = SkorTeknikal_
        txtKodSpek = txtKodSpek_
        IdAmJawapan = IdAmJawapan_
        txtTotalWajaran = txtTotalWajaran_
        percentAm = percentAm_
        percentTek = percentTek_
        skorSpekAm = skorSpekAm_
        skorAmTab = skorAmTab_
        skorSpekTeknikal = skorSpekTeknikal_
        idPembelian = idPembelian_
        idTeknikal = idTeknikal_
        idAm = idAm_
        jumTotalWajaran = jumTotalWajaran_
        txtNoLantikan = txtNoLantikan_
        idSyarikat = idSyarikat_
    End Sub

End Class