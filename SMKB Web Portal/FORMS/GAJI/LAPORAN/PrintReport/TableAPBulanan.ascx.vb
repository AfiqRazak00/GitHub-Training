Imports System
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls
Imports System.Web
Imports System.Web.UI.WebControls

Public Class TableAPBulanan
    Inherits System.Web.UI.UserControl

    Dim totalDebit As Decimal = 0
    Dim totalKredit As Decimal = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim dataTable As New DataTable()

            dataTable.Columns.Add("bulan", GetType(String))
            dataTable.Columns.Add("tahun", GetType(String))
            dataTable.Rows.Add(Session("bulan"), Session("tahun"))

            rptone.DataSource = dataTable
            rptone.DataBind()
        End If
    End Sub

	Private Function LoadDataTable(bulan As String, tahun As String) As DataTable
		Dim query As String

		query = "SELECT Kod_Param,Kod_Kump_Wang,Kod_PTJ,Kod_Projek,Kod_Vot,'Posted' AS Status, Butiran, Debit, Kredit
				FROM SMKB_Gaji_AP WHERE Jenis_Proses = 'HD' AND RIGHT(Kod_Param, 2) = @bulan AND LEFT(Kod_Param,4) = @tahun"

		Dim dataTable As New DataTable()
		Using connection As New SqlConnection(strCon)
			Using command As New SqlCommand(query, connection)
				command.Parameters.Add(New SqlParameter("@bulan", bulan))
				command.Parameters.Add(New SqlParameter("@tahun", tahun))

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

		Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
		rptTwo.DataSource = LoadDataTable(bulan, tahun)
		rptTwo.DataBind()

		Dim jumlahDebitControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahDebit"), HtmlTableCell)
		Dim jumlahKreditControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahKredit"), HtmlTableCell)

		If jumlahDebitControl IsNot Nothing Then
			jumlahDebitControl.InnerText = totalDebit.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahKreditControl IsNot Nothing Then
			jumlahKreditControl.InnerText = totalKredit.ToString("N2") ' Format as a decimal with two decimal places
		End If


	End Sub

	Protected Sub repeaterDetail_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
		If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
			' Retrieve the Amaun value from the data source
			Dim Debit As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Debit"))
			Dim Kredit As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Kredit"))

			totalDebit += Debit
			totalKredit += Kredit

		End If
	End Sub

End Class