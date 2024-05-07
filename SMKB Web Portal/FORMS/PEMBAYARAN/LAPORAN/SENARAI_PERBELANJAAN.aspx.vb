
Imports System.Data.SqlClient
Imports System.Web.Services
Imports Newtonsoft.Json


Public Class SENARAI_PERBELANJAAN
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then




            Dim kewangan As DataTable = GetKW()
            kodkw.DataSource = kewangan
            kodkw.DataBind()

        End If

    End Sub

    Private Function GetPtjList() As DataTable
        ' Create a connection to your database
        Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb;pwd=Smkb@Dev2012;"
        Dim connection As New SqlConnection(connectionString)

        ' Create a SQL query to fetch the month data
        Dim query As String = " select '00' AS KodPejabat, 'KESELURUHAN' AS Pejabat UNION ALL
        select concat(KodPejabat,'0000') as KodPejabat , Pejabat from [devmis\SQL_INS01].dbStaf.dbo.MS_PEJABAT where Status = 1"

        ' Create a SqlCommand object to execute the query
        Dim command As New SqlCommand(query, connection)

        ' Create a DataTable to store the results
        Dim ptjData As New DataTable()

        ' Open the database connection
        connection.Open()

        ' Execute the query and fill the DataTable with the results
        Using adapter As New SqlDataAdapter(command)
            adapter.Fill(ptjData)
        End Using

        ' Close the database connection
        connection.Close()

        ' Return the DataTable with the month data
        Return ptjData
    End Function

    Private Function GetCorporate() As DataTable
        ' Create a connection to your database
        Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb;pwd=Smkb@Dev2012;"
        Dim connection As New SqlConnection(connectionString)

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

        Return corporate
    End Function


    Private Function GetKW() As DataTable

        Dim connection As New SqlConnection(strCon)
        Dim query As String = "SELECT '00' AS Kod_Kump_Wang, 'KESELURUHAN' AS Butiran UNION ALL
                            SELECT Kod_Kump_Wang, CONCAT(Kod_Kump_Wang, ' - ', Butiran) AS Butiran
                            FROM SMKB_Kump_Wang
                            ORDER BY Kod_Kump_Wang"

        Dim command As New SqlCommand(query, connection)
        Dim kewangan As New DataTable()
        connection.Open()

        ' Execute the query and fill the DataTable with the results
        Using adapter As New SqlDataAdapter(command)
            adapter.Fill(kewangan)
        End Using

        ' Close the database connection
        connection.Close()

        ' Return the DataTable with the month data
        Return kewangan
    End Function



End Class