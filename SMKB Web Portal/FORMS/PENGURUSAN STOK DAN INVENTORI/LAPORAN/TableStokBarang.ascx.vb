
Imports System
Imports System.Data.SqlClient
	Imports System.Diagnostics.Eventing.Reader
	Imports System.Web.UI.HtmlControls
	Imports System.Web
	Imports System.Web.UI.WebControls
Public Class TableStokBarang
	Inherits System.Web.UI.UserControl

	Dim total As Decimal = 0
		Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
			If Not IsPostBack Then
				Dim dataTable As New DataTable()
			dataTable.Columns.Add("kategori", GetType(String))

			dataTable.Columns.Add("ptj", GetType(String))
			dataTable.Rows.Add(Session("kategori"), Session("ptj"))
			rptone.DataSource = dataTable
				rptone.DataBind()
			End If
		End Sub

	Private Function LoadDataTable(ptj As String, kategori As String) As DataTable
		Dim query As String
		If kategori = "STOR UTAMA" Then
			If ptj = "00" Then
				ptj = "%"
			ElseIf ptj = "-0000" Then
				ptj = "-"
			Else
				ptj = ptj + "%"
			End If

			query = $"SELECt ROW_NUMBER() OVER (ORDER BY A.Kod_Brg) AS No, A.Kod_Brg,A.Butiran,C.Butiran AS Ukuran, B.takat_Min, b.takat_max, b.Takat_menokok, '50' as Baki
                                FROM SMKB_SI_Barang_Hdr A
                                INNER JOIN smkb_si_barang_dtl B ON B.Kod_brg = A.Kod_Brg
                                INNER JOIN SMKB_Lookup_Detail C ON C.Kod_Detail = A.Kod_Ukuran AND C.KOD IN ('SI003') 
                                INNER JOIN SMKB_Lookup_Detail D ON D.Kod_Detail = B.kat_stor AND D.KOD IN ('SI002') 
                                INNER JOIN {DBStaf}MS_PEJABAT E ON E.KodPejPBU = B.Kod_Ptj
                                WHERE D.Butiran = '{kategori}' and Kod_Ptj LIKE '{ptj}'"

		Else

			query = $"SELECT ROW_NUMBER() OVER (ORDER BY A.Kod_Brg) AS No,A.Kod_Brg,A.Butiran,C.Butiran AS Ukuran, B.takat_Min, b.takat_max, b.Takat_menokok, '50' as Baki
                                FROM SMKB_SI_Barang_Hdr A
                                INNER JOIN smkb_si_barang_dtl B ON B.Kod_brg = A.Kod_Brg
                                INNER JOIN SMKB_Lookup_Detail C ON C.Kod_Detail = A.Kod_Ukuran AND C.KOD IN ('SI003') 
                                INNER JOIN SMKB_Lookup_Detail D ON D.Kod_Detail = B.kat_stor AND D.KOD IN ('SI002') 
                                INNER JOIN {DBStaf}MS_PEJABAT E ON E.KodPejPBU = B.Kod_Ptj
                                WHERE D.Butiran = '{kategori}'"
		End If

		Dim dataTable As New DataTable()
		Using connection As New SqlConnection(strCon)
			Using command As New SqlCommand(query, connection)
				command.Parameters.Add(New SqlParameter("@ptj", ptj))
				command.Parameters.Add(New SqlParameter("@kategori", kategori))

				connection.Open()
				dataTable.Load(command.ExecuteReader())
			End Using
		End Using
		Return dataTable
	End Function
	Protected Sub rptone_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
		Dim rptItem As RepeaterItem = TryCast(e.Item, RepeaterItem)
		Dim kategori As String = rptItem.DataItem("kategori")

		Dim ptj As String = rptItem.DataItem("ptj")
		Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
		rptTwo.DataSource = LoadDataTable(ptj, kategori)
		rptTwo.DataBind()

	End Sub



	Protected Function GetBakiStyle(baki As Object, takatMin As Object, takatMenokok As Object) As String
		If Not IsDBNull(baki) AndAlso Not IsDBNull(takatMin) AndAlso Not IsDBNull(takatMenokok) Then
			Dim bakiValue As Decimal = Convert.ToDecimal(baki)
			Dim takatMinValue As Decimal = Convert.ToDecimal(takatMin)
			Dim takatMenokokValue As Decimal = Convert.ToDecimal(takatMenokok)

			If bakiValue < takatMinValue AndAlso bakiValue < takatMenokokValue Then
				Return "color: red;"
			ElseIf bakiValue < takatMinValue OrElse bakiValue < takatMenokokValue Then
				Return "color: green;"
			End If
		End If
		Return ""
	End Function

	Protected Sub repeaterDetail_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
			If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then

		End If
		End Sub
	End Class