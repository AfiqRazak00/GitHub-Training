Imports Microsoft.AspNet.Identity
Imports System.Globalization
Imports System.Threading
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Collections.Specialized
Imports System.Reflection
Imports System
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Net.NetworkInformation



Public Class SI_Jenis

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Dim kategoriData As DataTable = GetKategoriList()
        '' Bind the data to the dropdown list
        'ddlKategori.DataSource = kategoriData
        'ddlKategori.DataBind()

    End Sub

    'Private Function GetKategoriList() As DataTable
    '    Create a connection to your database
    '    Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb_Pt;pwd=@Abcd@1234;"
    '    Dim connection As New SqlConnection(connectionString)

    '    Create a SQL query to fetch the month data
    '    Dim query As String = "SELECT DISTINCT B.Butiran As ButiranKat
    '                      FROM SMKB_SI_Jenis A, SMKB_Lookup_Detail B
    '                      WHERE A.Kod_Kategori = B.Kod_Detail
    '                      AND B.kod= 'SI001'"

    '    Create a SqlCommand object to execute the query
    '    Dim command As New SqlCommand(query, connection)

    '    Create a DataTable to store the results
    '    Dim kategoriData As New DataTable()
    '    kategoriData.Columns.Add("Kategori")
    '    kategoriData.Rows.Add("------------------SILA PILIH------------------")
    '    Open the database connection
    '    connection.Open()

    '    Execute the query and fill the DataTable with the results
    '    Using adapter As New SqlDataAdapter(command)
    '        adapter.Fill(kategoriData)
    '    End Using

    '    Close the database connection
    '    connection.Close()

    '    Return the DataTable with the month data
    '    Return kategoriData
    'End Function
End Class


Public Class JenisStok
        Public Property Jenis As String
        Public Property Kategori As String
        Public Property Butiran As String
        Public Property Status As String

    End Class