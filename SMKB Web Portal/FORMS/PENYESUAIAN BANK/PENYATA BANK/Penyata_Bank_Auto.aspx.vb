Imports System.Web.Services
Imports Newtonsoft.Json

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration

Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports clsMail
Imports System.Reflection


Public Class Penyata_Bank_Auto
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


End Class


Public Class Order_Penyata_Auto

    Public Property IdPenyata As String
    Public Property Bank As String
    Public Property Tarikh As String
    Public Property Jumlah As String
    Public Property OrderDetails As List(Of OrderDetail_Penyata)

    Public Sub New()

    End Sub

    Public Sub New(IdPenyata_ As String, Bank_ As String, Tarikh_ As String, Jumlah_ As String, lOrderDetails_ As List(Of OrderDetail))

        IdPenyata = IdPenyata_
        Bank = Bank_
        Tarikh = Tarikh_
        Jumlah = Jumlah_

    End Sub
End Class

Public Class OrderDetail_Penyata_Auto
    Public Property ID As String
    Public Property Tarikh As String
    Public Property Rujukan As String
    Public Property Butiran As String
    Public Property Debit As String
    Public Property Kredit As String
    Public Property Baki As String


    Public Sub New()

    End Sub

    Public Sub New(Optional ID_ As String = "", Optional Tarikh_ As String = "", Optional Rujukan_ As String = "", Optional Butiran_ As String = "",
                   Optional Debit_ As String = "", Optional Kredit_ As String = "", Optional Baki_ As String = "")
        ID = ID_
        Tarikh = Tarikh_
        Rujukan = Rujukan_
        Butiran = Butiran_
        Debit = Debit_
        Kredit = Kredit_
        Baki = Baki_

    End Sub





End Class