Imports System
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls
Imports System.Web
Imports System.Web.UI.WebControls

Public Class TableTransaksi
    Inherits System.Web.UI.UserControl

	Dim totalGajiPokok As Decimal = 0
	Dim totalBonus As Decimal = 0
	Dim totalElaun As Decimal = 0
	Dim totalOT As Decimal = 0
	Dim totalGajiKasar As Decimal = 0
	Dim totalPotongan As Decimal = 0
	Dim totalCuti As Decimal = 0
	Dim totalKWSP As Decimal = 0
	Dim totalKWSM As Decimal = 0
	Dim totalCukai As Decimal = 0
	Dim totalGajiBersih As Decimal = 0
	Dim totalSOCP As Decimal = 0
	Dim totalSOCM As Decimal = 0
	Dim totalPencen As Decimal = 0
	Dim totalASB As Decimal = 0
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
			'lblTajuk.InnerHtml = Tajuk
			'Dim selectedValues As List(Of String) = Session("SelectedValues")
			Dim selectedValues As String = Session("SelectedValues")
			Dim dataTable As New DataTable()
            dataTable.Columns.Add("bulan", GetType(String))
            dataTable.Columns.Add("tahun", GetType(String))
			dataTable.Columns.Add("ptj", GetType(String))
			dataTable.Columns.Add("kumpStaf", GetType(String))
			dataTable.Columns.Add("tarafPkhd", GetType(String))
			dataTable.Columns.Add("warga", GetType(String))
			dataTable.Rows.Add(Session("bulan"), Session("tahun"), Session("ptj"), Session("kumpStaf"), Session("tarafPkhd"), Session("warga"))

			rptone.DataSource = dataTable
			rptone.DataBind()
		End If
    End Sub
	Private Function LoadDataTable(bulan As String, tahun As String, ptj As String, kumpStaf As String, tarafPkhd As String, warga As String) As DataTable
		Dim query As String

		If ptj = "00" Then
			ptj = "%"
		ElseIf ptj = "-0000" Then
			ptj = "-"
		Else
			ptj = ptj
		End If

		query = "SELECT StaffNo,Nama,KP,MS02_GredGajiS AS GredGaji,
				COALESCE([G],0.00) AS Gaji_Pokok,
				COALESCE([B],0.00) AS Bonus,
				COALESCE([E],0.00) AS Elaun,
				COALESCE([O],0.00) AS OT, 
				(COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) AS Gaji_Kasar,
				COALESCE([P],0.00) AS Potongan,
				COALESCE([C],0.00) AS Cuti,
				No_KWSP,
				(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSM') AS KWSM,
				(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSP') AS KWSP,
				No_Cukai, Kategori_Cukai,
				COALESCE([T],0.00) AS Cukai,
				No_Perkeso,
				(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCM') AS SOCM,
				(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCP') AS SOCP,
				(
				(COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) -
				(COALESCE([P],0.00)+COALESCE([C],0.00)+(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCP')+(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSP')+COALESCE([T],0.00))
				) AS Gaji_Bersih,
				No_Pencen,
				COALESCE([N],0.00) AS Pencen,
				(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'ASB') AS ASB
				FROM(
				SELECT A.No_Staf AS StaffNo, C.MS01_Nama AS Nama, C.MS01_KpB AS KP, A.Jenis_Trans,A.Amaun,
				B.No_Cukai, B.Kategori_Cukai, C.MS01_NoPencen AS No_Pencen, C.MS01_NoKWSP AS No_KWSP, B.No_Perkeso, D.MS02_GredGajiS
				FROM SMKB_Gaji_Lejar A
				LEFT JOIN SMKB_Gaji_Staf B ON B.No_Staf = A.No_Staf
				LEFT JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
				LEFT JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS02_Perjawatan AS D ON D.MS01_NoStaf = A.No_Staf
				WHERE A.Bulan LIKE @bulan AND A.Tahun = @tahun AND A.Kod_PTJ LIKE @ptj AND C.MS01_Warganegara LIKE @warga AND D.MS02_KumpStaf LIKE @kumpStaf AND D.MS02_Taraf LIKE @tarafPkhd
				)AS SourceTable
				PIVOT(
				Sum(Amaun)
				FOR Jenis_Trans IN ([B],[C],[E],[G],[O],[P],[T],[N])
				) AS PivotTable;"

		'query = "SELECT No_Staf,Nama,KP,
		'			COALESCE([G],0.00) AS Gaji_Pokok,
		'			COALESCE([B],0.00) AS Bonus,
		'			COALESCE([E],0.00) AS Elaun,
		'			COALESCE([O],0.00) AS OT,
		'			(COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) AS Gaji_Kasar,
		'			COALESCE([P],0.00) AS Potongan,
		'			COALESCE([C],0.00) AS Cuti,No_KWSP,
		'			COALESCE([KWSP],0.00) AS KWSP,
		'			COALESCE([KWSM],0.00) AS KWSM,
		'			No_Cukai, Kategori_Cukai,
		'			COALESCE([T],0.00) AS Cukai,
		'			(
		'				(COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) -
		'				(COALESCE([P],0.00)+COALESCE([C],0.00)+COALESCE([KWSP],0.00)+COALESCE([SOCP],0.00)+COALESCE([T],0.00))
		'			) AS Gaji_Bersih,
		'			No_Perkeso,
		'			COALESCE([SOCP],0.00) AS SOCP,
		'			COALESCE([SOCM],0.00) AS SOCM,No_Pencen,
		'			COALESCE([N],0.00) AS Pencen
		'		FROM(
		'			SELECT A.No_Staf, C.MS01_Nama AS Nama, C.MS01_KpB AS KP, A.Jenis_Trans,A.Amaun,KWSM.KWSM,KWSP.KWSP,SOCM.SOCM,SOCP.SOCP, B.No_Cukai, B.Kategori_Cukai, C.MS01_NoPencen AS No_Pencen, C.MS01_NoKWSP AS No_KWSP, B.No_Perkeso
		'			FROM SMKB_Gaji_Lejar A
		'			LEFT JOIN SMKB_Gaji_Staf B ON B.No_Staf = A.No_Staf
		'			LEFT JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
		'			LEFT JOIN (SELECT No_Staf, Amaun AS KWSM FROM SMKB_Gaji_Lejar WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSM') AS KWSM ON KWSM.No_Staf = A.No_Staf
		'			LEFT JOIN (SELECT No_Staf, Amaun AS KWSP FROM SMKB_Gaji_Lejar WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSP') AS KWSP ON KWSP.No_Staf = A.No_Staf
		'			LEFT JOIN (SELECT No_Staf, Amaun AS SOCM FROM SMKB_Gaji_Lejar WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCM') AS SOCM ON SOCM.No_Staf = A.No_Staf
		'			LEFT JOIN (SELECT No_Staf, Amaun AS SOCP FROM SMKB_Gaji_Lejar WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCP') AS SOCP ON SOCP.No_Staf = A.No_Staf
		'			WHERE A.Bulan = @bulan AND A.Tahun = @tahun " + optWhere + "
		'		)AS SourceTable
		'		PIVOT(
		'		Sum(Amaun)
		'		FOR Jenis_Trans IN ([B],[C],[E],[G],[O],[P],[T],[N])
		'		) AS PivotTable;"

		Dim dataTable As New DataTable()
		Using connection As New SqlConnection(strCon)
			Using command As New SqlCommand(query, connection)
				command.Parameters.Add(New SqlParameter("@bulan", bulan))
				command.Parameters.Add(New SqlParameter("@tahun", tahun))
				command.Parameters.Add(New SqlParameter("@ptj", ptj))
				command.Parameters.Add(New SqlParameter("@kumpStaf", kumpStaf))
				command.Parameters.Add(New SqlParameter("@tarafPkhd", tarafPkhd))
				command.Parameters.Add(New SqlParameter("@warga", warga))

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
		Dim kumpStaf As String = rptItem.DataItem("kumpStaf")
		Dim tarafPkhd As String = rptItem.DataItem("tarafPkhd")
		Dim warga As String = rptItem.DataItem("warga")

		Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
		'rptTwo.DataSource = LoadDataTable(Session("bulan"), Session("tahun"), Session("ptj"))
		rptTwo.DataSource = LoadDataTable(bulan, tahun, ptj, kumpStaf, tarafPkhd, warga)
		rptTwo.DataBind()

		Dim jumlahGajiPokokControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahGajiPokok"), HtmlTableCell)
		Dim jumlahBonusControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahBonus"), HtmlTableCell)
		Dim jumlahElaunControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahElaun"), HtmlTableCell)
		Dim jumlahOTControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahOT"), HtmlTableCell)
		Dim jumlahGajiKasarControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahGajiKasar"), HtmlTableCell)
		Dim jumlahPotonganControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahPotongan"), HtmlTableCell)
		Dim jumlahCutiControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahCuti"), HtmlTableCell)
		Dim jumlahKWSPControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahKWSP"), HtmlTableCell)
		Dim jumlahKWSMControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahKWSM"), HtmlTableCell)
		Dim jumlahCukaiControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahCukai"), HtmlTableCell)
		Dim jumlahGajiBersihControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahGajiBersih"), HtmlTableCell)
		Dim jumlahSOCPControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahSOCP"), HtmlTableCell)
		Dim jumlahSOCMControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahSOCM"), HtmlTableCell)
		Dim jumlahPencenControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahPencen"), HtmlTableCell)
		Dim jumlahASBControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahASB"), HtmlTableCell)

		If jumlahGajiPokokControl IsNot Nothing Then
			jumlahGajiPokokControl.InnerText = totalGajiPokok.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahBonusControl IsNot Nothing Then
			jumlahBonusControl.InnerText = totalBonus.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahElaunControl IsNot Nothing Then
			jumlahElaunControl.InnerText = totalElaun.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahOTControl IsNot Nothing Then
			jumlahOTControl.InnerText = totalOT.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahGajiKasarControl IsNot Nothing Then
			jumlahGajiKasarControl.InnerText = totalGajiKasar.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahPotonganControl IsNot Nothing Then
			jumlahPotonganControl.InnerText = totalPotongan.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahCutiControl IsNot Nothing Then
			jumlahCutiControl.InnerText = totalCuti.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahKWSPControl IsNot Nothing Then
			jumlahKWSPControl.InnerText = totalKWSP.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahKWSMControl IsNot Nothing Then
			jumlahKWSMControl.InnerText = totalKWSM.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahCukaiControl IsNot Nothing Then
			jumlahCukaiControl.InnerText = totalCukai.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahGajiBersihControl IsNot Nothing Then
			jumlahGajiBersihControl.InnerText = totalGajiBersih.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahSOCPControl IsNot Nothing Then
			jumlahSOCPControl.InnerText = totalSOCP.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahSOCMControl IsNot Nothing Then
			jumlahSOCMControl.InnerText = totalSOCM.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahPencenControl IsNot Nothing Then
			jumlahPencenControl.InnerText = totalPencen.ToString("N2") ' Format as a decimal with two decimal places
		End If
		If jumlahASBControl IsNot Nothing Then
			jumlahASBControl.InnerText = totalASB.ToString("N2") ' Format as a decimal with two decimal places
		End If
	End Sub

	Protected Sub repeaterDetail_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
		If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
			' Retrieve the Amaun value from the data source
			Dim GajiPokok As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Gaji_Pokok"))
			Dim Bonus As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Bonus"))
			Dim Elaun As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Elaun"))
			Dim OT As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "OT"))
			Dim GajiKasar As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Gaji_Kasar"))
			Dim Potongan As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Potongan"))
			Dim Cuti As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Cuti"))
			Dim KWSP As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "KWSP"))
			Dim KWSM As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "KWSM"))
			Dim Cukai As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Cukai"))
			Dim GajiBersih As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Gaji_Bersih"))
			Dim SOCP As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "SOCP"))
			Dim SOCM As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "SOCM"))
			Dim Pencen As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Pencen"))
			Dim ASB As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "ASB"))

			totalGajiPokok += GajiPokok
			totalBonus += Bonus
			totalElaun += Elaun
			totalOT += OT
			totalGajiKasar += GajiKasar
			totalPotongan += Potongan
			totalCuti += Cuti
			totalKWSP += KWSP
			totalKWSM += KWSM
			totalCukai += Cukai
			totalGajiBersih += GajiBersih
			totalSOCP += SOCP
			totalSOCM += SOCM
			totalPencen += SOCM
			totalASB += ASB

		End If
	End Sub


End Class