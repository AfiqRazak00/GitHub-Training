Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class LOKASI
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class LokasiInsertDetail
    Public Property kodLokasiPengesahan As String
    Public Property KodLokasiDetailPengesahan As String
    Public Property pejabatLokasiPengesahan As String
    Public Property butiranLokasiPengesahan As String
    Public Property kategoriStorPengesahan As String
    Public Property statusLokasiPengesahan As String

    Public Sub New()
    End Sub
    Public Sub New(kodLokasiPengesahan_ As String, KodLokasiDetailPengesahan_ As String, ukuranLokasiPengesahan_ As String, butiranLokasiPengesahan_ As String, kategoriStorPengesahan_ As String, statusLokasiPengesahan_ As String)
        kodLokasiPengesahan = kodLokasiPengesahan_
        KodLokasiDetailPengesahan = KodLokasiDetailPengesahan_
        pejabatLokasiPengesahan = ukuranLokasiPengesahan_
        butiranLokasiPengesahan = butiranLokasiPengesahan_
        kategoriStorPengesahan = kategoriStorPengesahan_
        statusLokasiPengesahan = statusLokasiPengesahan_
    End Sub
End Class
