Imports System.Data.SqlClient

Public Class reportStafKontrak
    Inherits System.Web.UI.Page

    Dim listBulan As String() = {"Januari", "Februari", "Mac", "April", "Mei", "Jun", "Julai", "Ogos", "September", "Oktober", "November", "Disember"}

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Request.QueryString("selectedname") IsNot Nothing Then
                ' Retrieve the selectedvalue from the query string
                Dim selectedname As String = Request.QueryString("selectedname")

                ' Display the selectedvalue in the Label
                selectedWarga.Text = selectedname
            End If
            'selectedWarga.Text = GetDescriptionPTJByCode(Session("selectedWarga"))
            tahun.Text = Session("tahun")
            'bulan.Text = listBulan(Session("bulan") - 1)
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