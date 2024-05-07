Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json


Public Class PM
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub





End Class


Public Class Perolehan_Mesyuarat_Header

    Public Property ddlTarikh As String
    Public Property ddlMasa As String
    Public Property ddlTempat As String
    Public Property ddlJawatankuasa_kod As String
    Public Property ddlKodPTj As String
    Public Property txtIDMesy As String
    Public Property txtTarikh As String


End Class


Public Class Perolehan_Mesyuarat_Detail

    Public Property ddlNo_Mohon As String
    Public Property ddlTurutan As String
    Public Property txtIDMesy As String


End Class

Public Class Perolehan_Mesyuarat_JKD

    Public Property ddlNo_Staf As String
    Public Property ddlName As String
    Public Property txtIDMesy As String
    Public Property ddlEmel As String
    Public Property ddlNo_Tel As String
    Public Property dllJawatan As String
    Public Property dllKodSubMenu As String
    Public Property dllNameSubMenu As String
    Public Property ddlTarikh As String
    Public Property ddlMasa As String
    Public Property ddlTempat As String
End Class