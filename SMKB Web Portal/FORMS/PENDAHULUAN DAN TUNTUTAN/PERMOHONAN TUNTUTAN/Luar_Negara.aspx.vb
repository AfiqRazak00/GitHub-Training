Imports System.Web.Services
Imports Newtonsoft.Json
Imports SMKB_Web_Portal.Dalam_Negara

Public Class Luar_Negara
    Inherits System.Web.UI.Page
    Public dsKod As New DataSet
    Public dvKodKW As New DataView
    Dim dbconn As New DBKewConn

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Class MhnLuarNegara
        Public Property OrderID As String
        Public Property StafID As String
        Public Property noTel As String
        Public Property Tahun As String
        Public Property Bulan As String
        Public Property TkhMohon As String
        Public Property KumpWang As String
        Public Property KodOperasi As String
        Public Property KodPtj As String
        Public Property KodProjek As String
        Public Property Tujuan As String
        Public Property MasaBertolak As String
        Public Property BertolakDari As String
        Public Property TkhTolak As String
        Public Property hidPtjPemohon As String
        Public Property staPemohon As String
        Public Property NoPemohon As String
        Public Property noPendahuluan As String
        Public Property jumlahBaucer As Decimal
        Public Property Jumlah As Decimal
        Public Property JnsTuntutan As String
        Public Property File_Name As String
        Public Property Folder As String
        Public Property sebabLewat As String
        Public Property JumTuntut As Decimal
        Public Property JumGantiRugi As Decimal
        Public Property JumBakiTuntut As Decimal
        Public Property JumBelanjaSendiri As Decimal
        Public Property bilItem As Integer



        Public Property GroupKenyataanLN As List(Of tblKenyataanLN)

        Public Property GroupElaunMakan As List(Of ElaunMakanLN)

        Public Property GroupSumbangan As List(Of tblSumbanganLN)

    End Class
    Public Class BatalHotel
        Public Property mohonID As String
        Public Property stafID As String
        Public Property statusDok As String
        Public Property idItem As String
        Public Property jumlahTabHotel As Decimal


    End Class



    Public Class UploadResitLojingLN

        Public Property idItem As String
        Public Property mohonID As String
        Public Property Lojing_jnsTugas As String
        Public Property Lojing_MataWang As String
        Public Property Lojing_Negara As String
        Public Property Lojing_noResit As String
        Public Property Lojing_bilHari As String
        Public Property Lojing_KdrPertukaran As Decimal
        Public Property Lojing_ElaunHarian As Decimal
        Public Property Lojing_Jumlah As Decimal
        Public Property TotalAllTab As Decimal
    End Class
    Public Class UploadResitHotelLN

        Public Property idItem As String
        Public Property mohonID As String
        Public Property Hotel_jnsTugas As String
        Public Property Hotel_MataWang As String
        Public Property Hotel_Negara As String
        Public Property Hotel_noResit As String
        Public Property Hotel_bilHari As String
        Public Property Hotel_KdrPertukaran As Decimal
        Public Property Hotel_ElaunHarian As Decimal
        Public Property Hotel_Jumlah As Decimal
        Public Property TotalAllTab As Decimal
    End Class
    Public Class UploadResitTblBP
        Public Property idItem As String
        Public Property mohonID As String
        Public Property ResitNo As String
        Public Property Tkh_Upload As String
        Public Property FlagResit As String
        Public Property JenisBelanjaP As String
        Public Property JnsNegara As String
        Public Property JnsMataWang As String

        Public Property Jumlah As Decimal
        Public Property JumlahAll As Decimal
    End Class

    Public Class tblSumbanganLN
        Public Property idbil As Integer
        Public Property mohonID As String
        Public Property KodTabung As String
        Public Property Jumlah As Decimal
        Public Property JumSumbangan As Decimal

    End Class

    Public Class tblKenyataanLN
        Public Property idbil As Integer
        Public Property mohonID As String
        Public Property JnsTugas As String
        Public Property JnsNegara As String
        Public Property Bandar As String
        Public Property tarikhTolak As String
        Public Property MasaTolakJam As String
        Public Property MasaTolakMinit As String
        Public Property tarikhSampai As String
        Public Property MasaSampaiJam As String
        Public Property MasaSampaiMinit As String
        Public Property TotalTuntut As Decimal



    End Class

    Public Class ElaunMakanLN

        Public Property EM_mohonID As String
        Public Property EM_bilHari As Integer
        Public Property EM_hidID As Nullable(Of Integer)
        Public Property EM_MataWang As String
        Public Property EM_Negara As String
        Public Property EM_JnsTugas As String
        Public Property EM_KadarMWang As Decimal
        Public Property EM_Rujukan As String
        Public Property EM_TkhMula As String
        Public Property EM_JamMula As String
        Public Property EM_MinitMula As String
        Public Property EM_TkhAkhir As String
        Public Property EM_JamSampai As String
        Public Property EM_MinitSampai As String
        Public Property EM_MknPagi As String
        Public Property EM_MknTghri As String
        Public Property EM_MknMlm As String
        Public Property EM_StaElaunHarian As String
        Public Property EM_TkhTransit As String
        Public Property EM_TkhTransitTolak As String
        Public Property EM_staTransit As String
        Public Property EM_JamTTiba As String
        Public Property EM_MinitTTiba As String
        Public Property EM_JamTTolak As String
        Public Property EM_MinitTTolak As String
        Public Property EM_HargaElaunHarian As Decimal
        Public Property EM_Jumlah As Decimal
        Public Property EM_Total As Decimal
        Public Property EM_Folder As String
        Public Property EM_File_Name As String

    End Class



End Class