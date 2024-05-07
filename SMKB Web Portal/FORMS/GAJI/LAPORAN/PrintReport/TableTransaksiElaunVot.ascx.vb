Imports System
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls
Imports System.Web
Imports System.Web.UI.WebControls

Public Class TableTransaksiElaunVot
    Inherits System.Web.UI.UserControl
    ' Define the maximum number of columns per page
    Dim ColumnsPerPage As Integer = 20
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'lblTajuk.InnerHtml = Tajuk
            Dim dataTable As New DataTable()
            dataTable.Columns.Add("bulan", GetType(String))
            dataTable.Columns.Add("tahun", GetType(String))
            dataTable.Columns.Add("ptj", GetType(String))
            dataTable.Rows.Add(Session("bulan"), Session("tahun"), Session("ptj"))

            rptone.DataSource = dataTable
            rptone.DataBind()
        End If
    End Sub

    Private Function LoadDataTable(bulan As String, tahun As String, ptj As String) As DataTable
        Dim query As String

        If ptj = "00" Then
            ptj = "%"
        ElseIf ptj = "-0000" Then
            ptj = "-"
        Else
            ptj = ptj + "%"
        End If

        query = "-- Create a dynamic SQL statement to generate the pivot query
					DECLARE @sql AS NVARCHAR(MAX);
					DECLARE @vot_tetap_columns AS NVARCHAR(MAX);

					-- Get the distinct values in the Vot_Tetap column from SMKB_Gaji_Kod_Trans
					SET @vot_tetap_columns = STUFF(
						(SELECT DISTINCT ', [' + K.Vot_Tetap + ']' FROM SMKB_Gaji_Kod_Trans K WHERE K.Kod_Trans IN (SELECT DISTINCT L.Kod_Trans
												FROM SMKB_Gaji_Lejar L
												WHERE L.Bulan LIKE @bulan AND L.Tahun = @tahun AND L.Jenis_Trans = 'E' AND L.Kod_PTJ LIKE @ptj)
						FOR XML PATH('')), 1, 2, '');

					-- Build the dynamic SQL query
					SET @sql = N'
					SELECT No_Staf AS No, Nama, ' + @vot_tetap_columns + '
					FROM (
						SELECT L.No_Staf,B.MS01_Nama AS Nama,K.Vot_Tetap,L.Amaun
						FROM SMKB_Gaji_Lejar L
						INNER JOIN SMKB_Gaji_Kod_Trans K ON L.Kod_Trans = K.Kod_Trans
						LEFT JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_Peribadi AS B ON B.MS01_NoStaf = L.No_Staf
						WHERE L.Bulan LIKE @bulan AND L.Tahun = @tahun AND L.Jenis_Trans = ''E''  AND L.Kod_PTJ LIKE @ptj
					) AS SourceTable
					PIVOT (
						SUM(Amaun) FOR Vot_Tetap IN (' + @vot_tetap_columns + ')
					) AS PivotTable
					ORDER BY No_Staf;';

					-- Execute the dynamic SQL
					EXEC sp_executesql @sql,N'@bulan NVARCHAR(10), @tahun INT, @ptj NVARCHAR(50)', @bulan, @tahun, @ptj;
					"

        Dim dataTable As New DataTable()
        Using connection As New SqlConnection(strCon)
            Using command As New SqlCommand(query, connection)
                command.Parameters.Add(New SqlParameter("@bulan", bulan))
                command.Parameters.Add(New SqlParameter("@tahun", tahun))
                command.Parameters.Add(New SqlParameter("@ptj", ptj))
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

            Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
            Dim tableHeader As HtmlTableRow = TryCast(rptItem.FindControl("tableHeader"), HtmlTableRow)

            'Load data based on your criteria
            Dim dataTable As DataTable = LoadDataTable(bulan, tahun, ptj)

            'Create Dynamic table headers based on the DataTable columns
            If dataTable.Rows.Count > 0 Then
                tableHeader.Cells.Clear()

                For Each column As DataColumn In dataTable.Columns
                    Dim headerCell As New HtmlTableCell()
                    headerCell.InnerText = column.ColumnName
                    headerCell.Attributes("style") = "text-align: center; border: 1px solid black;padding: 8px;" ' Set border style
                    tableHeader.Cells.Add(headerCell)
                Next
            End If

            'Dynamically create rows And cells for the repeaterDetail
            rptTwo.Controls.Clear()
            Dim detailTable As New HtmlTable()

            For Each row As DataRow In dataTable.Rows
                'Dim itemTemplate As New RepeaterItem(ListItemType.Item)
                Dim itemTemplate As New RepeaterItem(0, ListItemType.Item) ' Specify the itemIndex and itemType
                Dim newRow As New HtmlTableRow()


                For Each column As DataColumn In dataTable.Columns
                    Dim newCell As New HtmlTableCell()
                    Dim cellValue As Object = row(column)

                    If column.ColumnName = "Nama" Then
                        newCell.Attributes("style") = "border: 1px solid black;padding: 8px;" ' Set border style
                        newCell.InnerText = cellValue.ToString()
                    ElseIf column.ColumnName = "No" Then
                        newCell.Attributes("style") = "text-align: center; border: 1px solid black;padding: 8px;" ' Set border style
                        newCell.InnerText = cellValue.ToString()
                    Else
                        newCell.Attributes("style") = "text-align: right;border: 1px solid black;padding: 8px;" ' Set border style
                        If Not Convert.IsDBNull(cellValue) AndAlso cellValue IsNot Nothing Then
                            Dim amount As Double
                            If Double.TryParse(cellValue.ToString(), amount) Then
                                newCell.InnerText = amount.ToString("N2")
                            End If
                        Else
                            newCell.InnerText = "0.00"
                        End If
                    End If
                    newRow.Cells.Add(newCell)
                Next

                itemTemplate.Controls.Add(newRow)
                rptTwo.Controls.Add(itemTemplate)

            Next

        End If
    End Sub

    'Protected Sub rptone_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
    '    If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
    '        Dim rptItem As RepeaterItem = TryCast(e.Item, RepeaterItem)
    '        Dim bulan As String = rptItem.DataItem("bulan")
    '        Dim tahun As String = rptItem.DataItem("tahun")
    '        Dim ptj As String = rptItem.DataItem("ptj")


    '        Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
    '        Dim tableHeader As HtmlTableRow = TryCast(rptItem.FindControl("tableHeader"), HtmlTableRow)

    '        'Load data based on your criteria
    '        Dim dataTable As DataTable = LoadDataTable(bulan, tahun, ptj)

    '        'Create Dynamic table headers based on the DataTable columns
    '        If dataTable.Rows.Count > 0 Then
    '            tableHeader.Cells.Clear()

    '            For Each column As DataColumn In dataTable.Columns
    '                Dim headerCell As New HtmlTableCell()
    '                headerCell.InnerText = column.ColumnName
    '                headerCell.Attributes("style") = "text-align: center; border: 1px solid black;padding: 8px;" ' Set border style
    '                'headerCell.Attributes("style") = "text-align: center; width: 5%;border: 1px solid #000;padding: 8px;"
    '                tableHeader.Cells.Add(headerCell)
    '            Next
    '        End If

    '        'Dynamically create rows And cells for the repeaterDetail
    '        rptTwo.Controls.Clear()
    '        Dim detailTable As New HtmlTable()

    '        For Each row As DataRow In dataTable.Rows
    '            'Dim itemTemplate As New RepeaterItem(ListItemType.Item)
    '            Dim itemTemplate As New RepeaterItem(0, ListItemType.Item) ' Specify the itemIndex and itemType
    '            Dim newRow As New HtmlTableRow()


    '            For Each column As DataColumn In dataTable.Columns
    '                Dim newCell As New HtmlTableCell()
    '                Dim cellValue As Object = row(column)

    '                If column.ColumnName = "Nama" Then
    '                    newCell.Attributes("style") = "border: 1px solid black;padding: 8px;" ' Set border style
    '                    newCell.InnerText = cellValue.ToString()
    '                ElseIf column.ColumnName = "No" Then
    '                    newCell.Attributes("style") = "text-align: center; border: 1px solid black;padding: 8px;" ' Set border style
    '                    newCell.InnerText = cellValue.ToString()
    '                Else
    '                    newCell.Attributes("style") = "text-align: right;border: 1px solid black;padding: 8px;" ' Set border style
    '                    If Not Convert.IsDBNull(cellValue) AndAlso cellValue IsNot Nothing Then
    '                        Dim amount As Double
    '                        If Double.TryParse(cellValue.ToString(), amount) Then
    '                            newCell.InnerText = amount.ToString("N2")
    '                        End If
    '                    Else
    '                        newCell.InnerText = "0.00"
    '                    End If
    '                End If
    '                newRow.Cells.Add(newCell)
    '            Next

    '            itemTemplate.Controls.Add(newRow)
    '            rptTwo.Controls.Add(itemTemplate)

    '        Next

    '        ' Add a last row to calculate the totals
    '        Dim totalRow As New HtmlTableRow()

    '        For Each column As DataColumn In dataTable.Columns
    '            Dim totalCell As New HtmlTableCell()
    '            totalCell.Attributes("style") = "text-align: right; font-weight: bold; border: 1px solid black; padding: 8px;"

    '            If column.ColumnName = "No" Then
    '                ' For "No" column, create a merged cell and add text "Jumlah(RM)"
    '                Dim mergedCell As New HtmlTableCell()
    '                mergedCell.Attributes("style") = "text-align: center; font-weight: bold; border: 1px solid black; padding: 8px;"
    '                mergedCell.InnerText = "Jumlah(RM)"
    '                mergedCell.ColSpan = 2 ' Merge two columns for "No" and "Nama"
    '                totalRow.Cells.Add(mergedCell)
    '            ElseIf column.ColumnName = "Nama" Then
    '                ' Skip adding a cell for "Nama" column in the total row
    '            Else
    '                ' For other columns, calculate the total and add a cell
    '                Dim columnTotal As Double = dataTable.AsEnumerable().Sum(Function(r) If(IsNumeric(r(column)), Convert.ToDouble(r(column)), 0))
    '                totalCell.InnerText = columnTotal.ToString("N2")

    '                totalRow.Cells.Add(totalCell)
    '            End If

    '        Next

    '        ' Add the total row to the detailTable
    '        detailTable.Rows.Add(totalRow)
    '        ' Add the detailTable to the repeaterDetail
    '        rptTwo.Controls.Add(detailTable)

    '    End If
    'End Sub
End Class