Imports System
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls
Imports System.Web
Imports System.Web.UI.WebControls

Public Class TableAmanahGaji
	Inherits System.Web.UI.UserControl

	Dim total As Decimal = 0

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Not IsPostBack Then
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
			ptj = ptj
		End If

		query = $"SELECT A.No_Staf,B.MS01_Nama AS Nama,SUM(A.Amaun) AS Gaji_Bersih
					FROM SMKB_Gaji_Lejar A
					LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
					WHERE A.Kod_PTJ LIKE @ptj AND A.Bulan = @bulan AND A.Tahun = @tahun AND A.Kod_Trans = 'GAJI'
					AND (SELECT Tahan_Gaji FROM SMKB_Gaji_Staf WHERE No_Staf = A.No_Staf) = 1
					GROUP BY A.Amaun,A.No_Staf,B.MS01_Nama
					ORDER BY A.No_Staf;"

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
		Dim rptItem As RepeaterItem = TryCast(e.Item, RepeaterItem)
		Dim bulan As String = rptItem.DataItem("bulan")
		Dim tahun As String = rptItem.DataItem("tahun")
		Dim ptj As String = rptItem.DataItem("ptj")

		Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
		rptTwo.DataSource = LoadDataTable(bulan, tahun, ptj)
		rptTwo.DataBind()

		Dim jumlahControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlah"), HtmlTableCell)

		If jumlahControl IsNot Nothing Then
			jumlahControl.InnerText = total.ToString("N2") ' Format as a decimal with two decimal places
		End If

	End Sub

	Protected Sub repeaterDetail_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
		If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
			' Retrieve the Amaun value from the data source
			Dim gajiBersih As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Gaji_Bersih"))
			total += gajiBersih
		End If
	End Sub
End Class