Public Class Sokong_EOT
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None

    End Sub


    'Public Class MohonEOT
    '    Public Property No_Arahan As String
    '    Public Property No_Mohon As String
    '    Public Property No_Staf As String
    '    Public Property Tahun As String
    '    Public Property Bulan As String
    '    Public Property Tujuan As String
    '    Public Property Catatan As String
    '    Public Property No_Staf_Sah As String
    '    Public Property OT_Ptj As String
    '    Public Property No_Staf_Lulus As String
    '    Public Property Tkh_Mula As Date
    '    Public Property Tkh_Tamat As Date
    '    Public Property Amaun As Decimal
    '    Public Property Kadar As Decimal
    '    Public Property Tkh_Tuntut As Date
    '    Public Property Jam_Mula As String
    '    Public Property Jam_Tamat As String
    '    Public Property ID As Long
    '    Public Property Ulasan As String

    'End Class
End Class

Public Class OrderEot
    Public Property Jammulalulus As String
    Public Property Jamtamatlulus As String
    Public Property Jumjamlulus As String
    Public Property Amaunlulus As String
    Public Property Turutan As String
    Public Property ID As Long
    Public Property StatusMohon As String
    Public Property UlasanLulus As String


    'Public Property OrderDetails As List(Of OrderEot)


    'Public Sub New(Jammulalulus_ As String, Jamtamatlulus_ As String, Jumjamlulus_ As String, Amaunlulus_ As String, Turutan_ As String, lOrderDetails_ As List(Of OrderEot))
    '    Jammulalulus = Jammulalulus_
    '    Jamtamatlulus = Jamtamatlulus_
    '    Jumjamlulus = Jumjamlulus_
    '    Amaunlulus = Amaunlulus_
    '    Turutan = Turutan_
    '    OrderDetails = lOrderDetails_

    'End Sub
End Class