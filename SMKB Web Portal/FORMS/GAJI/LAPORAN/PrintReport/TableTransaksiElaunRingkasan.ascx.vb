Imports System
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls
Imports System.Web
Imports System.Web.UI.WebControls

Public Class TableTransaksiElaunRingkasan
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'lblTajuk.InnerHtml = Tajuk
            Dim dataTable As New DataTable()
            dataTable.Columns.Add("bulan", GetType(String))
            dataTable.Columns.Add("tahun", GetType(String))
            dataTable.Columns.Add("ptj", GetType(String))
            dataTable.Columns.Add("kodelaun", GetType(String))
            dataTable.Rows.Add(Session("bulan"), Session("tahun"), Session("ptj"), Session("kodelaun"))

            rptone.DataSource = dataTable
            rptone.DataBind()
        End If
    End Sub

    Private Function LoadDataTable(bulan As String, tahun As String, ptj As String, kodelaun As String) As DataTable
        Dim query As String

        If ptj = "00" Then
            ptj = "%"
        ElseIf ptj = "-0000" Then
            ptj = "-"
        Else
            ptj = ptj + "%"
        End If

        If kodelaun = "00" Then
            kodelaun = "%"
        Else
            kodelaun = kodelaun + "%"
        End If

        query = "DECLARE @DynamicSQL NVARCHAR(MAX);
					DECLARE @ColumnList NVARCHAR(MAX);

					-- Create a comma-separated list of distinct Category values to be used as columns
					SELECT @ColumnList = COALESCE(@ColumnList + ', ', '') + QUOTENAME(Kod_Trans)
					FROM (SELECT DISTINCT Kod_Trans FROM SMKB_Gaji_Lejar WHERE Jenis_Trans = 'E' AND Bulan = @bulan AND Tahun = @tahun AND Kod_PTJ LIKE @ptj AND Kod_Trans LIKE @kodelaun) AS Categories;

					-- Build the dynamic SQL query to pivot the table
					SET @DynamicSQL = N'
						SELECT *
						FROM (
							SELECT A.No_Staf AS No, B.MS01_Nama AS Nama, A.Kod_Trans, Amaun
							FROM SMKB_Gaji_Lejar A
							LEFT JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
							WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_PTJ LIKE @ptj AND Kod_Trans LIKE @kodelaun
						) AS SourceTable
						PIVOT (
							SUM(Amaun)
							FOR Kod_Trans IN (' + @ColumnList + ')
						) AS PivotTable;';

					-- Execute the dynamic SQL query with the new parameter
					EXEC sp_executesql @DynamicSQL, N'@bulan INT, @tahun INT, @ptj NVARCHAR(50), @kodelaun NVARCHAR(50)', @bulan, @tahun, @ptj, @kodelaun;"

        Dim dataTable As New DataTable()
        Using connection As New SqlConnection(strCon)
            Using command As New SqlCommand(query, connection)
                command.Parameters.Add(New SqlParameter("@bulan", bulan))
                command.Parameters.Add(New SqlParameter("@tahun", tahun))
                command.Parameters.Add(New SqlParameter("@ptj", ptj))
                command.Parameters.Add(New SqlParameter("@kodelaun", kodelaun))
                connection.Open()
                dataTable.Load(command.ExecuteReader())
            End Using
        End Using
        Return dataTable
    End Function

    Protected Sub rptone_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim rptItem As RepeaterItem = TryCast(e.Item, RepeaterItem)
            Dim bulan As String = rptItem.DataItem("bulan")
            Dim tahun As String = rptItem.DataItem("tahun")
            Dim ptj As String = rptItem.DataItem("ptj")
            Dim kodelaun As String = rptItem.DataItem("kodelaun")

            Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
            Dim tableHeader As HtmlTableRow = TryCast(rptItem.FindControl("tableHeader"), HtmlTableRow)

            ' Load data based on your criteria
            Dim dataTable As DataTable = LoadDataTable(bulan, tahun, ptj, kodelaun)

            ' Create dynamic table headers based on the DataTable columns
            If dataTable.Rows.Count > 0 Then
                tableHeader.Cells.Clear()

                For Each column As DataColumn In dataTable.Columns
                    Dim headerCell As New HtmlTableCell()
                    headerCell.InnerText = column.ColumnName
                    tableHeader.Cells.Add(headerCell)
                Next
            End If

            ' Dynamically create rows and cells for the repeaterDetail
            rptTwo.Controls.Clear()

            For Each row As DataRow In dataTable.Rows
                'Dim itemTemplate As New RepeaterItem(ListItemType.Item)
                Dim itemTemplate As New RepeaterItem(0, ListItemType.Item) ' Specify the itemIndex and itemType
                Dim newRow As New HtmlTableRow()

                For Each column As DataColumn In dataTable.Columns
                    Dim newCell As New HtmlTableCell()
                    newCell.InnerText = row(column).ToString()
                    newRow.Cells.Add(newCell)
                Next

                itemTemplate.Controls.Add(newRow)
                rptTwo.Controls.Add(itemTemplate)
            Next
        End If
    End Sub
End Class