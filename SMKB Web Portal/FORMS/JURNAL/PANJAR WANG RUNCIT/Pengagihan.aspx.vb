Public Class Pengagihan
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class OrderM_Agih

    Public Property OrderMId As String
    Public Property Tarikh As String
    Public Property NoPtj As String
    Public Property Kumpulan As String
    Public Property Jumlah As String
    Public Property BakiSemasa As String
    Public Property JumlahTolak As String
    Public Property JumlahTambah As String
    Public Property OrderMDetails_Agih As List(Of OrderMDetail_Agih)

    Public Sub New()

    End Sub

    Public Sub New(OrderMId_ As String, Tarikh_ As String, NoPtj_ As String, Kumpulan_ As String, Jumlah_ As String, BakiSemasa_ As String, lOrderMDetails_ As List(Of OrderMDetail_Agih))
        OrderMId = OrderMId_
        Tarikh = Tarikh_
        NoPtj = NoPtj_
        Kumpulan = Kumpulan_
        Jumlah = Jumlah_
        OrderMDetails_Agih = lOrderMDetails_
        BakiSemasa = BakiSemasa_
    End Sub

End Class

Public Class OrderMDetail_Agih
    Public Property id As String
    Public Property checkBox As String
    Public Property OrderMId As String
    Public Property butiran As String
    Public Property tarikh_resit As String
    Public Property resit As String
    Public Property ddlcoa As String
    Public Property kw As String
    Public Property ko As String
    Public Property kp As String
    Public Property ptj As String
    Public Property jumlah As Decimal
    Public Property baki As Decimal
    Public Property ulasan_semak As String
    Public Property Bil As String
    Public Sub New()

    End Sub

    Public Sub New(Optional Bil_ As String = "", Optional checkBox_ As String = "", Optional tarikh_resit_ As String = "", Optional id_ As String = "", Optional OrderMid_ As String = "", Optional butiran_ As String = "", Optional resit_ As String = "",
                   Optional ptj_ As String = "", Optional kw_ As String = "", Optional ko_ As String = "", Optional kp_ As String = "",
                   Optional ddlcoa_ As String = "", Optional jumlah_ As Decimal = 0.00, Optional baki_ As Decimal = 0.00, Optional ulasan_semak_ As String = "")
        id = id_
        Bil = Bil_
        checkBox = checkBox_
        OrderMId = OrderMid_
        butiran = butiran_
        resit = resit_
        ptj = ptj_
        kw = kw_
        ko = ko_
        kp = kp_
        ddlcoa = ddlcoa_
        jumlah = jumlah_
        baki = baki_
        tarikh_resit = tarikh_resit_
        ulasan_semak = ulasan_semak_

    End Sub
End Class