﻿Imports System
Imports System.Data.SqlClient

Public Class reportPendapatanBukanPenggajian
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            LoadHeader()
        End If
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

            lblNamaKorporat.Text = ToTitleCase(dbread("Nama"))
            lblAlamatKorporat.Text = ToTitleCase(dbread("Almt1")) & ", " & ToTitleCase(dbread("Poskod")) & " " & ToTitleCase(dbread("Almt2")) & ", " & ToTitleCase(dbread("Negeri"))
            lblNoTelFaks.Text = "Tel : +" & dbread("No_Tel1") & "&nbsp; &nbsp; &nbsp; &nbsp; Faks : +" & dbread("No_Faks1")
            lblEmailKorporat.Text = "Email: " & dbread("Emel").ToLower()
        End If

        dbread.Close()
        connection.Close()
    End Sub

    Function ToTitleCase(input As String) As String
        Dim words As String() = input.Split(" "c)
        For i As Integer = 0 To words.Length - 1
            If words(i).Length > 0 Then
                words(i) = Char.ToUpper(words(i)(0)) + words(i).Substring(1).ToLower()
            End If
        Next
        Return String.Join(" ", words)
    End Function
End Class