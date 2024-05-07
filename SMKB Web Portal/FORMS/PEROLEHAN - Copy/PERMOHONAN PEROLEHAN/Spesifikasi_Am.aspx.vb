
Imports System
Imports System.Web
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls

Public Class Spesifikasi_Am
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim test As String = HttpContext.Current.Request.form("no_mohon")
        Dim test2 As String = test

        If Not IsPostBack Then
            LoadLogoUtem()
        End If

    End Sub


    Private Sub LoadLogoUtem()
        Dim strSql As String = "Select Logo from SMKB_Korporat"

        Dim connection As New SqlConnection(strCon)
        connection.Open()

        Dim command As New SqlCommand(strSql, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()

        If reader.Read() Then
            Dim imageData As Byte() = DirectCast(reader("Logo"), Byte())
            Dim base64String As String = Convert.ToBase64String(imageData)
            imgMyImage.ImageUrl = String.Format("data:image/jpg;base64,{0}", base64String)
        End If

        reader.Close()
        connection.Close()
    End Sub
End Class