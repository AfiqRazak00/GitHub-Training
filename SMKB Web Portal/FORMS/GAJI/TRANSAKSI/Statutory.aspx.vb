Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Net.NetworkInformation

Public Class Statutory
    Inherits System.Web.UI.Page
    Dim dbconn As New DBKewConn
    Dim dbconnSM As New DBSMConn
    Public dsKod As New DataSet
    Public dvKodKW As New DataView

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            'fBindGvJenis()

        End If
    End Sub

End Class