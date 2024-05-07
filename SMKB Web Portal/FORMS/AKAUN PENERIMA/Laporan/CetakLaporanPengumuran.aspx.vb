Imports System
Imports System.Data.SqlClient

Public Class CetakLaporanPengumuran
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim vot As String = Request.QueryString("kodvot")
        LoadHeader()
        fCariButiranVot(vot)
    End Sub
    Private Sub LoadHeader()

        Dim strSql As String = "select a.Nama_Sing, a.Nama, a.Almt1, a.Almt2, a.Bandar, a.Poskod, b.Butiran as Negara, c.Butiran as Negeri, a.Kod_Negara, a.No_Tel1, a.No_Tel2, 
                            a.No_Faks1, a.No_Faks2, a.Laman_Web, a.Logo, a.Emel, a.Kategori, a.No_GST
                            from SMKB_Korporat a 
                            INNER JOIN SMKB_Lookup_Detail b ON b.Kod='0001' AND a.Kod_Negara=b.Kod_Detail
                            INNER JOIN SMKB_Lookup_Detail c ON c.Kod='0002' AND a.Kod_Negeri=c.Kod_Detail"

        Dim connection As New SqlConnection(strCon)
        connection.Open()

        Dim command As New SqlCommand(strSql, connection)
        Dim dbread As SqlDataReader = command.ExecuteReader()

        If dbread.Read() Then
            Dim imageData As Byte() = DirectCast(dbread("Logo"), Byte())
            Dim base64String As String = Convert.ToBase64String(imageData)
            imgMyImage.ImageUrl = String.Format("data:image/jpg;base64,{0}", base64String)

        End If

        dbread.Close()
        connection.Close()
    End Sub
    Private Sub fCariButiranVot(vot As String)
        Try
            Dim strsql As String


            strsql = $"SELECT DISTINCT B.Butiran FROM SMKB_Lejar_Penghutang A
                        INNER JOIN SMKB_Vot B ON A.Kod_Vot=B.Kod_Vot
                        WHERE B.Kod_Vot = '" & vot & "'"

            Dim connection As New SqlConnection(strCon)
            connection.Open()

            Dim command As New SqlCommand(strsql, connection)
            Dim dbread As SqlDataReader = command.ExecuteReader()

            If dbread.Read() Then
                votButiranDisplay.Text = "Vot :" & vot & " - " & dbread("Butiran")
            End If
        Catch ex As Exception

        End Try
    End Sub
End Class