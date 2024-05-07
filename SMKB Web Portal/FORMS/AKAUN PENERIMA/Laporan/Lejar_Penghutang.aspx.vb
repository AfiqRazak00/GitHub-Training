Imports System.Data.SqlClient
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class Lejar_Penghutang
    Inherits System.Web.UI.Page
    Dim dbconn As New DBKewConn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Fetch data from the database
            Dim ptjData As DataTable = GetPtjList()
            ' Bind the data to the dropdown list
            ptj.DataSource = ptjData
            ptj.DataBind()

            Dim corporate As DataTable = GetCorporate()
            ' Bind the data to the dropdown list
            syarikat.DataSource = corporate
            syarikat.DataBind()

            Dim tahun_ As DataTable = GetTahun()
            ' Bind the data to the dropdown list
            tahun.DataSource = tahun_
            tahun.DataBind()
            ' Add default value after binding
            tahun.Items.Insert(0, New ListItem("-- SILA PILIH --", "0"))
        End If
    End Sub

    Private Function GetPtjList() As DataTable
        Dim strSql As String
        strSql = $"select '00' AS KodPejabat, 'KESELURUHAN' AS Pejabat UNION ALL
        select concat(KodPejabat,'0000') as KodPejabat , Pejabat from VPejabat"
        Dim ds = dbconn.fSelectCommandDt(strSql)

        Return ds
    End Function

    Private Function GetCorporate() As DataTable
        Dim strSql As String
        strSql = $"select Nama_Sing, Nama from SMKB_Korporat"
        Dim ds = dbconn.fSelectCommandDt(strSql)

        Return ds
    End Function
    Private Function GetTahun() As DataTable
        Dim strSql As String
        strSql = $"SELECT DISTINCT YEAR(GETDATE()) AS VALUE, YEAR(GETDATE()) AS Year
                                UNION
                                SELECT DISTINCT YEAR(GETDATE()) AS VALUE,YEAR(DATEADD(YEAR, -1, GETDATE())) AS Year
                                UNION
                                SELECT DISTINCT YEAR(GETDATE()) AS VALUE,YEAR(DATEADD(YEAR, -2, GETDATE())) AS Year
                                UNION
                                SELECT DISTINCT YEAR(GETDATE()) AS VALUE,YEAR(DATEADD(YEAR, -3, GETDATE())) AS Year
                                UNION
                                SELECT DISTINCT YEAR(GETDATE()) AS VALUE,YEAR(DATEADD(YEAR, -4, GETDATE())) AS Year
                                ORDER BY Year DESC;"
        Dim ds = dbconn.fSelectCommandDt(strSql)

        Return ds

    End Function

End Class