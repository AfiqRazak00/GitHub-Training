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
    Public Property kodLokasi As String
    Public Property pejabatLokasi As String
    Public Property butiranLokasi As String
    Public Property kategoriLokasi As String
    Public Property statusLokasi As String

    Public Sub New()
    End Sub
    Public Sub New(kodLokasi_ As String, ukuranLokasi_ As String, butiranLokasi_ As String, kategoriLokasi_ As String, statusLokasi_ As String)
        kodLokasi = kodLokasi_
        pejabatLokasi = ukuranLokasi_
        butiranLokasi = butiranLokasi_
        kategoriLokasi = kategoriLokasi_
        statusLokasi = statusLokasi_
    End Sub
End Class
