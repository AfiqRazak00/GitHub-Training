﻿Imports System.Data.SqlClient
Imports System.Web.Services
Imports Newtonsoft.Json
Imports System.Web.Mvc

Public Class Senarai_Staf_Kontrak
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Fetch data from the database


            Dim corporate As DataTable = GetCorporate()
            ' Bind the data to the dropdown list
            syarikatFilter.DataSource = corporate
            syarikatFilter.DataBind()
        End If
    End Sub



    Private Function GetCorporate() As DataTable
        ' Create a connection to your database
        'Dim connectionString As String = "server=qa12.utem.edu.my;database=DbKewanganV4;uid=Smkb;pwd=smkb*pwd;"
        Dim connection As New SqlConnection(strCon)

        ' Create a SQL query to fetch the month data
        Dim query As String = "select Nama_Sing, Nama from SMKB_Korporat"

        ' Create a SqlCommand object to execute the query
        Dim command As New SqlCommand(query, connection)

        ' Create a DataTable to store the results
        Dim corporate As New DataTable()

        ' Open the database connection
        connection.Open()

        ' Execute the query and fill the DataTable with the results
        Using adapter As New SqlDataAdapter(command)
            adapter.Fill(corporate)
        End Using

        ' Close the database connection
        connection.Close()

        ' Return the DataTable with the month data
        Return corporate
    End Function


End Class