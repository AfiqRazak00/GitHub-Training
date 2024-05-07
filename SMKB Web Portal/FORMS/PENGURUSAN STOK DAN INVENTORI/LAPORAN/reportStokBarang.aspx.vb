Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls
Imports System.Web.Services
Imports System.Web.Script.Services

Public Class reportStokBarang
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            'kategori.Text= Session("kategori")
            ' Check if Session("kategori") is "Stor Utama"
            If Session("kategori") IsNot Nothing AndAlso Session("kategori").ToString() = "STOR UTAMA" Then
                kategori.Visible = True ' Show the kategori control
                kategori.Text = Session("kategori")

                ptj.Text = GetDescriptionPTJByCode(Session("ptj"))
                ptjPanel.Visible = True ' Show the ptjPanel control

            Else
                kategori.Visible = True ' Show the kategori control
                kategori.Text = Session("kategori")
                ptj.Visible = False
                ptjPanel.Visible = False
            End If
            LoadLogoUtem()
        End If
    End Sub

    Protected Function GetDescriptionPTJByCode(ByVal code As String) As String
        Dim connection As New SqlConnection(strCon)
        connection.Open()
        Dim description As String = ""
        Dim trimmedCode As String = ""
        If code.Length >= 4 Then
            trimmedCode = code.Substring(0, code.Length - 4)

            Dim query As String = "SELECT Pejabat from {DBStaf}MS_PEJABAT WHERE KodPejabat = @ptj"

            Using command As New SqlCommand(query, connection)
                command.Parameters.AddWithValue("@ptj", trimmedCode)
                description = DirectCast(command.ExecuteScalar(), String)
            End Using
        Else
            description = "KESELURUHAN"
        End If
        Return description
    End Function



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