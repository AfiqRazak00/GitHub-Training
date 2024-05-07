Imports SMKB_Web_Portal.Dalam_Negara

Public Class PenerimaanDN
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Class PenerimaDN
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
        Public Property hidPtjPemohon As String
        Public Property staPemohon As String
        Public Property NoPemohon As String
        Public Property noPendahuluan As String
        Public Property jumlahBaucer As String
        Public Property Jumlah As String
        Public Property JnsTuntutan As String
        Public Property JumElaunMkn As Decimal
        Public Property JumSewaHotel As Decimal
        Public Property JumElaunPjln As Decimal
        Public Property JumTambangAwam As Decimal
        Public Property JumPelbagai As Decimal
        Public Property sebabLewat As String
        Public Property JumAllTuntutan As Decimal
        Public Property JumPendahuluan As Decimal
        Public Property JumSumbangan As Decimal
        Public Property JumBelanjaSendiri As Decimal
        Public Property Folder As String
        Public Property File_Name As String
        Public Property JumBersihTuntut As Decimal


        Public Property GroupKenyataan As List(Of MaklKenyataan)
        Public Property GroupItemTabElaunPjln As List(Of ElaunPjln_ItemDN)
        Public Property GroupItemKendAwam As List(Of TambangAwam)
        Public Property GroupElaunMakan As List(Of ElaunMakanDN)
        Public Property GroupSewaHotel As List(Of SewaHotelTbl)
        Public Property GroupSewaLojing As List(Of SewaLojingTbl)
        Public Property ItemGroupPelbagai As List(Of BelanjaPelbagai)
        Public Property GroupSumbanganDN As List(Of tblSumbanganDN)

    End Class
    Public Class TerimaDN
        Public Property mohonID As String
        Public Property stafID As String
        Public Property statusDok As String
        Public Property catatan As String
        Public Property Email As String
    End Class

    Public Class ElaunPjln_ItemDN

        Public Property strhidKM As Integer  'pembilang 
        Public Property mohonID As String
        Public Property strKiraKM As Integer
        Public Property strKenderaan As String
        Public Property strFlagKend As String
        Public Property strHidJnsK As String
        Public Property strJumJarak As String

        Public Property strKadarKM As Decimal
        Public Property strKM As String
        Public Property strJumlahEP As Decimal
        Public Property strTotalEP As Decimal


    End Class

    Public Class ElaunMakanDN
        Public Property EM_hidID As Integer
        Public Property EM_mohonID As String
        Public Property EM_bilHari As Integer
        Public Property EM_JnsPerjalanan As String
        Public Property EM_MknPagi As String
        Public Property EM_MknTghri As String
        Public Property EM_MknMlm As Decimal
        Public Property EM_harga As Decimal
        Public Property EM_tempat As String
        Public Property EM_ElaunHarian As Integer
        Public Property EM_Jumlah As Decimal
        Public Property EM_Total As Decimal

    End Class
    Public Class UploadResitTblSewaHotelDN

        Public Property idItem As String
        Public Property mohonID As String
        Public Property Hotel_jnsTugas As String
        Public Property Hotel_JnsTempat As String
        Public Property Hotel_noResit As String
        Public Property Hotel_bilHari As Integer
        Public Property Hotel_ElaunHarian As Decimal
        Public Property Hotel_Jumlah As Decimal
        Public Property totalTabSewaHotel As Decimal
        Public Property namafile As String
    End Class

    Public Class UploadTblLojingDN
        Public Property idItem As String
        Public Property mohonID As String
        Public Property Lojing_jnsTugas As String
        Public Property Lojing_JnsTempat As String
        Public Property Lojing_noResit As String
        Public Property Lojing_bilHari As Integer
        Public Property Lojing_ElaunHarian As Decimal
        Public Property Lojing_Jumlah As Decimal
        Public Property Lojing_Alamat As String
        Public Property totalTabSewaHotel As Decimal

    End Class

    Public Class UploadResitTblBPDN
        Public Property idItem As String
        Public Property mohonID As String
        Public Property ResitNo As String
        Public Property Tkh_Upload As String
        Public Property FlagResit As String
        Public Property JenisBelanjaP As String
        Public Property Jumlah As String
    End Class
    Public Class UploadResitTA_PDN
        Public Property idItem As String
        Public Property mohonID As String
        Public Property ResitNo As String
        Public Property Tkh_Upload As String
        Public Property FlagResit As String
        Public Property JenisKenderaan As String
        Public Property Jumlah As String
        Public Property jumlahSemua As String
        Public Property namafile As String
    End Class

    Public Class MaklKenyataan
        Public Property idbil As Integer
        Public Property mohonID As String
        Public Property flagMula As Integer
        Public Property tarikh As String
        Public Property MasaTolakJam As String
        Public Property MasaTolakMinit As String
        Public Property MasaSampaiJam As String
        Public Property MasaSampaiMinit As String
        Public Property flagTamat As Integer
        Public Property tujuan As String
        Public Property Jarak As String
        Public Property Kenderaan As String
        Public Property staKenderaan As String

    End Class

    Public Class tblSumbanganDN
        Public Property idbil As Integer
        Public Property mohonID As String
        Public Property KodTabung As String
        Public Property Jumlah As Decimal?
        Public Property JumSumbangan As Decimal?

    End Class
End Class