Imports System
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls
Imports System.Web
Imports System.Web.UI.WebControls

Public Class TablePCBTerperinci
	Inherits System.Web.UI.UserControl

	Dim totalGAJI As Decimal = 0
	Dim totalKWSP As Decimal = 0
	Dim totalPEN As Decimal = 0
	Dim totalPCB As Decimal = 0
	Dim totalZAKAT As Decimal = 0
	Dim totalPOTPCB As Decimal = 0

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

		query = $"SELECT No_Staf,Nama,
					COALESCE([GAJI],0.00) AS Gaji,
					COALESCE([KWSP],0.00) AS KWSP,
					(COALESCE([GAJI],0.00) - COALESCE([KWSP],0.00)) AS Jum_Pen_PCB,Kategori_Cukai,
					(SELECT COUNT(*)
					FROM {DBStaf}MS05_Anak
					WHERE MS01_NoStaf = No_Staf AND (YEAR(GETDATE()) - YEAR(MS05_TkhLahir)) <= 18) AS anakbelow18,
					COALESCE([TAX],0.00) AS PCB,
					COALESCE([TAV],0.00) AS PCB2,
					COALESCE([ZK01],0.00) AS Zakat,
					CASE
						WHEN (COALESCE([TAX], 0.00) - COALESCE([ZK01], 0.00)) < 0 THEN 0.00
						ELSE (COALESCE([TAX], 0.00) - COALESCE([ZK01], 0.00))
					END AS Pot_PCB
					FROM(
					SELECT A.No_Staf, C.MS01_Nama AS Nama,A.Kod_Trans,A.Amaun,B.Kategori_Cukai
					FROM SMKB_Gaji_Lejar A
					INNER JOIN SMKB_Gaji_Staf B ON B.No_Staf = A.No_Staf
					LEFT JOIN {DBStaf}MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
					WHERE A.Bulan = @bulan AND A.Tahun = @tahun AND Kod_PTJ LIKE @ptj
					)AS SourceTable
					PIVOT(
					Sum(Amaun)
					FOR Kod_Trans IN ([TAX],[TAV],[ZK01],[GAJI],[KWSP])
					) AS PivotTable
					ORDER BY No_Staf;"

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

		Dim jum As HtmlTableCell = DirectCast(e.Item.FindControl("jum"), HtmlTableCell)

		If jum IsNot Nothing Then
			jum.InnerText = totalGAJI.ToString("N2") ' Format as a decimal with two decimal places
		End If

		Dim potKWSP As HtmlTableCell = DirectCast(e.Item.FindControl("potKWSP"), HtmlTableCell)

		If potKWSP IsNot Nothing Then
			potKWSP.InnerText = totalKWSP.ToString("N2") ' Format as a decimal with two decimal places
		End If

		Dim jumPen As HtmlTableCell = DirectCast(e.Item.FindControl("jumPen"), HtmlTableCell)

		If jumPen IsNot Nothing Then
			jumPen.InnerText = totalPEN.ToString("N2") ' Format as a decimal with two decimal places
		End If

		Dim jumPCB As HtmlTableCell = DirectCast(e.Item.FindControl("PCB"), HtmlTableCell)

		If jumPCB IsNot Nothing Then
			jumPCB.InnerText = totalPCB.ToString("N2") ' Format as a decimal with two decimal places
		End If

		Dim jumZakat As HtmlTableCell = DirectCast(e.Item.FindControl("potZakat"), HtmlTableCell)

		If jumZakat IsNot Nothing Then
			jumZakat.InnerText = totalZAKAT.ToString("N2") ' Format as a decimal with two decimal places
		End If

		Dim jumPotPCB As HtmlTableCell = DirectCast(e.Item.FindControl("potPCB"), HtmlTableCell)

		If jumPotPCB IsNot Nothing Then
			jumPotPCB.InnerText = totalPOTPCB.ToString("N2") ' Format as a decimal with two decimal places
		End If
	End Sub

	Protected Sub repeaterDetail_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
		If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
			' Retrieve the Amaun value from the data source
			Dim gaji As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Gaji"))
			totalGAJI += gaji

			Dim KWSP As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "KWSP"))
			totalKWSP += KWSP

			Dim jumpen As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Jum_Pen_PCB"))
			totalPEN += jumpen

			Dim jumpcb As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "PCB"))
			totalPCB += jumpcb

			Dim jumzakat As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Zakat"))
			totalZAKAT += jumzakat

			Dim jumpotpcb As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Pot_PCB"))
			totalPOTPCB += jumpotpcb
		End If
	End Sub
End Class