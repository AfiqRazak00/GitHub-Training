Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class PengesahanPenjamin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("DariEmel") = "Ya" Then
            ClientScript.RegisterStartupScript(Me.GetType(), "CallMyFunction", "showModalAndReadSessionData();", True)

        End If
    End Sub

End Class

Public Class pengesahanInsertDetail
    Public Property setujuPengesahan As String
    Public Property tarikhPengesahan As String
    Public Property emailPengesahan As String
    Public Property namaPengesahan As String
    Public Property bilPengesahan As String
    Public Property nopinjPengesahan As String
    Public Property namapinjPengesahan As String
    Public Property hargaPengesahan As String
    Public Property butiranPengesahan As String
    Public Property kategoriPengesahan As String
    Public Property jenisPengesahan As String
    Public Property NoStafPeminjam As String

    Public Sub New()
    End Sub
    Public Sub New(setujuPengesahan_ As String, tarikhPengesahan_ As String, emailPengesahan_ As String, namaPengesahan_ As String, bilPengesahan_ As String, nopinjPengesahan_ As String, namapinjPengesahan_ As String, hargaPengesahan_ As String, kategoriPengesahan_ As String, jenisPengesahan_ As String, butiranPengesahan_ As String, NoStafPeminjam_ As String)
        setujuPengesahan = setujuPengesahan_
        tarikhPengesahan = tarikhPengesahan_
        emailPengesahan = emailPengesahan_
        namaPengesahan = namaPengesahan_
        bilPengesahan = bilPengesahan_
        nopinjPengesahan = nopinjPengesahan_
        namapinjPengesahan = namapinjPengesahan_
        hargaPengesahan = hargaPengesahan_
        kategoriPengesahan = kategoriPengesahan_
        jenisPengesahan = jenisPengesahan_
        butiranPengesahan = butiranPengesahan_
        NoStafPeminjam = NoStafPeminjam_
    End Sub
End Class


'silap
Public Class pengesahanInsertDetail2
    Public Property tidaksetujuPengesahan As String
    Public Property tarikhPengesahan As String
    Public Property emailPengesahan As String
    Public Property namaPengesahan As String
    Public Property hargaPengesahan As String
    Public Property butiranPengesahan As String
    Public Property kategoriPengesahan As String
    Public Property jenisPengesahan As String



    Public Sub New()
    End Sub
    Public Sub New(setujuPengesahan_ As String, tarikhPengesahan_ As String, hargaPengesahan_ As String, butiranPengesahan_ As String, kategoriPengesahan_ As String, jenisPengesahan_ As String)
        tidaksetujuPengesahan = setujuPengesahan_
        tarikhPengesahan = tarikhPengesahan_
        emailPengesahan = tarikhPengesahan_
        namaPengesahan = tarikhPengesahan_
        hargaPengesahan = hargaPengesahan_
        butiranPengesahan = butiranPengesahan_
        kategoriPengesahan = kategoriPengesahan_
        jenisPengesahan = jenisPengesahan_

    End Sub
End Class