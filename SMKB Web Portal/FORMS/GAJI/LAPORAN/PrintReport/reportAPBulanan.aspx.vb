Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls

Public Class reportAPBulanan
    Inherits System.Web.UI.Page
    Dim listBulan As String() = {"Januari", "Februari", "Mac", "April", "Mei", "Jun", "Julai", "Ogos", "September", "Oktober", "November", "Disember"}

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            tahun.Text = DateTime.Now.Year.ToString()
            bulan.Text = listBulan(DateTime.Now.Month - 1)
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

    Protected Sub Button1_Click(sender As Object, e As EventArgs)

    End Sub

End Class