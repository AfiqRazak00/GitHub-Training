Imports System.Data.SqlClient
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class SENARAI_PERBELANJAAN_BIL
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Not IsPostBack Then




            Dim kewangan As DataTable = GetKW()
            kodkw.DataSource = kewangan
            kodkw.DataBind()

        End If

    End Sub




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

