Imports System.Web.Services
Imports Newtonsoft.Json

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration

Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports clsMail
Imports System.Reflection

Public Class Penetapan_Tarikh
    Inherits System.Web.UI.Page

    Public dsKod As New DataSet
    Public dvKodKW As New DataView

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


End Class

Public Class Order_Pertengahan
    Public Property TahunBajet As String
    Public Property TkhPertengahan As String
    Public Property TkhAkhir As String

    Public Sub New()

    End Sub

    Public Sub New(TahunBajet_ As String, TkhPertengahan_ As String, TkhAkhir_ As String)

        TahunBajet = TahunBajet_
        TkhPertengahan = TkhPertengahan_
        TkhAkhir = TkhAkhir_

    End Sub
End Class


