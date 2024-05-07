Imports System.Web.Services
Imports Newtonsoft.Json
Imports SMKB_Web_Portal.Luar_Negara

Public Class Dalam_Negara
    Inherits System.Web.UI.Page
    Public dsKod As New DataSet
    Public dvKodKW As New DataView
    Dim dbconn As New DBKewConn

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Public Class MhnDlmNegara
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
        Public Property jumlahBaucer As Decimal
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


        Public Property GroupKenyataan As List(Of tblKenyataan)
        Public Property GroupItemTabElaunPjln As List(Of ElaunPjln_Item)

        Public Property GroupItemKendAwam As List(Of TambangAwam)
        Public Property GroupElaunMakan As List(Of ElaunMakan)
        Public Property GroupSewaHotel As List(Of SewaHotelTbl)
        Public Property GroupSewaLojing As List(Of SewaLojingTbl)
        Public Property ItemGroupPelbagai As List(Of BelanjaPelbagai)
        Public Property GroupSumbangan As List(Of tblSumbangan)


    End Class


    Public Class BelanjaPelbagai
        Public Property Pelbagai_hidID As Integer
        Public Property Pelbagai_mohonID As String
        Public Property strJnsPel As String
        Public Property strResitPel As String
        Public Property strTResitPel As String
        Public Property strNoResitPel As String
        Public Property strJumAmaunPel As Decimal
        Public Property strJumlahPel As Decimal

    End Class

    Public Class SewaLojingTbl
        Public Property SL_hidID As Integer
        Public Property SL_mohonID As String
        Public Property SL_JnsTugas As String
        Public Property SL_JnsTempat As String
        Public Property SL_noResit As String
        Public Property SL_ElaunHarian As Decimal
        Public Property SL_bilHari As Integer
        Public Property SL_AlamatLojing As String
        Public Property SL_Jumlah As Decimal
        Public Property SL_Total As Decimal

    End Class

    Public Class SewaHotelTbl
        Public Property SH_hidID As Integer
        Public Property SH_mohonID As String
        Public Property SH_JnsTugas As String
        Public Property SH_JnsTempat As String
        Public Property SH_noResit As String
        Public Property SH_ElaunHarian As Decimal
        Public Property SH_bilHari As Integer
        Public Property SH_Jumlah As Decimal
        Public Property SH_Total As Decimal

    End Class

    Public Class ElaunMakan
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
    Public Class TambangAwam
        Public Property Tambang_hidID As Integer
        Public Property Tambang_mohonID As String
        Public Property Tambang_jnsKend As String
        Public Property Tambang_dgnResit As String
        Public Property Tambang_tanpaResit As String
        Public Property Tambang_noResit As String
        Public Property Tambang_amaun As Decimal
        Public Property Tambang_Total As Decimal

    End Class
    Public Class ElaunPjln_Item

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


    Public Class tblKenyataan
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

    Public Class UploadResitTA
        Public Property idItem As String
        Public Property mohonID As String
        Public Property ResitNo As String
        Public Property Tkh_Upload As String
        Public Property FlagResit As String
        Public Property JenisKenderaan As String
        Public Property Jumlah As String
        Public Property jumlahSemua As String
    End Class

    Public Class UploadResitTblBP
        Public Property idItem As String
        Public Property mohonID As String
        Public Property ResitNo As String
        Public Property Tkh_Upload As String
        Public Property FlagResit As String
        Public Property JenisBelanjaP As String
        Public Property Jumlah As String
    End Class

    Public Class BatalListTA
        Public Property mohonID As String
        Public Property resit As String
        Public Property bilItem As Integer


    End Class

    Public Class UploadResitTblSewaHotel

        Public Property idItem As String
        Public Property mohonID As String
        Public Property Hotel_jnsTugas As String
        Public Property Hotel_JnsTempat As String
        Public Property Hotel_noResit As String
        Public Property Hotel_bilHari As Integer
        Public Property Hotel_ElaunHarian As Decimal
        Public Property Hotel_Jumlah As Decimal
    End Class

    Public Class UploadTblLojing
        Public Property idItem As String
        Public Property mohonID As String
        Public Property Lojing_jnsTugas As String
        Public Property Lojing_JnsTempat As String
        Public Property Lojing_noResit As String
        Public Property Lojing_bilHari As Integer
        Public Property Lojing_ElaunHarian As Decimal
        Public Property Lojing_Jumlah As Decimal
        Public Property Lojing_Alamat As String
    End Class

    Public Class tblSumbangan
        Public Property idbil As Integer
        Public Property mohonID As String
        Public Property KodTabung As String
        Public Property Jumlah As Decimal
        Public Property JumSumbangan As Decimal

    End Class

End Class