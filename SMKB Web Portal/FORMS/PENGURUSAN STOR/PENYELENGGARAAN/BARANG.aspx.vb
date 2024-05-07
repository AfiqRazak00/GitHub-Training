Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class BARANG
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class barangInsertDetail
    Public Property kodBarang As String
    Public Property ukuranBarang As String
    Public Property butiranBarang As String
    Public Property kategoriBarang As String
    Public Property statusBarang As String

    Public Sub New()
    End Sub
    Public Sub New(kodBarang_ As String, ukuranBarang_ As String, butiranBarang_ As String, kategoriBarang_ As String, statusBarang_ As String)
        kodBarang = kodBarang_
        ukuranBarang = ukuranBarang_
        butiranBarang = butiranBarang_
        kategoriBarang = kategoriBarang_
        statusBarang = statusBarang_
    End Sub
End Class