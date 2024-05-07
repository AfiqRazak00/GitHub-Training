﻿Public Class Mohon_EOT
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None
    End Sub
End Class
Public Class MohonEOT
    Public Property ID As Long
    Public Property Jum_Jam As String
    Public Property No_Arahan As String
    Public Property No_Mohon As String
    Public Property Folder As String
    Public Property No_Staf As String
    Public Property No_Surat As String
    Public Property Tahun As Integer
    Public Property Bulan As Integer
    Public Property Tujuan As String
    Public Property Catatan As String
    Public Property No_Staf_Sah As String
    Public Property OT_Ptj As String
    Public Property No_Staf_Lulus As String
    Public Property Tkh_Mula As Date
    Public Property Tkh_Tamat As Date
    Public Property Amaun As Decimal
    Public Property Kadar As Decimal
    Public Property Tkh_Tuntut As Date
    Public Property Jam_Mula As String
    Public Property Jam_Tamat As String
    Public Property Ulasan As String
    Public Property File_Name As String
End Class
