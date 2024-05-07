Imports System
Imports System.Data.SqlClient
Imports System.Diagnostics.Eventing.Reader
Imports System.Web.UI.HtmlControls
Imports System.Web
Imports System.Web.UI.WebControls

Public Class TableRingkasanGaji
    Inherits System.Web.UI.UserControl

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

        If Session("ptj") = "00" Then
			query = $"SELECT No_Staf,Nama,
	                           COALESCE([G],0.00) AS G,
	                           COALESCE([B],0.00) AS B,
	                           COALESCE([E],0.00) AS E,
	                           COALESCE([O],0.00) AS O,
	                           (COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) AS Gaji_Kasar,
	                           COALESCE([P],0.00) AS P,
	                           COALESCE([C],0.00) AS C,
	                           COALESCE([K],0.00) AS K,
	                           COALESCE([S],0.00) AS S,
	                           COALESCE([T],0.00) AS T,
	                           ((COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) -
	                           (COALESCE([P],0.00)+COALESCE([C],0.00)+COALESCE([K],0.00)+COALESCE([T],0.00))) AS Gaji_Bersih,
	                           '0.00' AS KWSM, '0.00' AS SOCM
                        FROM (
	                        SELECT A.No_Staf,B.MS01_Nama AS Nama,A.Jenis_Trans,A.Amaun,A.Bulan,A.Tahun
	                        FROM SMKB_Gaji_Lejar A
	                        LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
	                        WHERE A.No_Staf LIKE '%' AND A.Bulan = @bulan AND A.Tahun = @tahun
                        ) AS SourceTable
                        PIVOT(
	                        SUM(Amaun)
	                        --FOR Jenis_Trans IN([B],[C],[E],[G],[O],[P],[T])
	                        FOR Jenis_Trans IN([B],[C],[E],[G],[K],[O],[P],[S],[T])
                        ) AS PivotTable;"
		ElseIf Session("ptj") = "-0000" Then
			query = $"SELECT No_Staf,Nama,
	                           COALESCE([G],0.00) AS G,
	                           COALESCE([B],0.00) AS B,
	                           COALESCE([E],0.00) AS E,
	                           COALESCE([O],0.00) AS O,
	                           (COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) AS Gaji_Kasar,
	                           COALESCE([P],0.00) AS P,
	                           COALESCE([C],0.00) AS C,
	                           COALESCE([K],0.00) AS K,
	                           COALESCE([S],0.00) AS S,
	                           COALESCE([T],0.00) AS T,
	                           ((COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) -
	                           (COALESCE([P],0.00)+COALESCE([C],0.00)+COALESCE([K],0.00)+COALESCE([T],0.00))) AS Gaji_Bersih,
	                           '0.00' AS KWSM, '0.00' AS SOCM
                        FROM (
	                        SELECT A.No_Staf,B.MS01_Nama AS Nama,A.Jenis_Trans,A.Amaun,A.Bulan,A.Tahun
	                        FROM SMKB_Gaji_Lejar A
	                        LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
	                        WHERE A.No_Staf LIKE '%' AND A.Bulan = @bulan AND A.Tahun = @tahun AND A.Kod_PTJ= '-'
                        ) AS SourceTable
                        PIVOT(
	                        SUM(Amaun)
	                        --FOR Jenis_Trans IN([B],[C],[E],[G],[O],[P],[T])
	                        FOR Jenis_Trans IN([B],[C],[E],[G],[K],[O],[P],[S],[T])
                        ) AS PivotTable;"
		Else
			query = $"SELECT No_Staf,Nama,
	                           COALESCE([G],0.00) AS G,
	                           COALESCE([B],0.00) AS B,
	                           COALESCE([E],0.00) AS E,
	                           COALESCE([O],0.00) AS O,
	                           (COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) AS Gaji_Kasar,
	                           COALESCE([P],0.00) AS P,
	                           COALESCE([C],0.00) AS C,
	                           COALESCE([K],0.00) AS K,
	                           COALESCE([S],0.00) AS S,
	                           COALESCE([T],0.00) AS T,
	                           ((COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) -
	                           (COALESCE([P],0.00)+COALESCE([C],0.00)+COALESCE([K],0.00)+COALESCE([T],0.00))) AS Gaji_Bersih,
	                           '0.00' AS KWSM, '0.00' AS SOCM
                        FROM (
	                        SELECT A.No_Staf,B.MS01_Nama AS Nama,A.Jenis_Trans,A.Amaun,A.Bulan,A.Tahun
	                        FROM SMKB_Gaji_Lejar A
	                        LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
	                        WHERE A.No_Staf LIKE '%' AND A.Bulan = @bulan AND A.Tahun = @tahun AND A.Kod_PTJ= @ptj
                        ) AS SourceTable
                        PIVOT(
	                        SUM(Amaun)
	                        --FOR Jenis_Trans IN([B],[C],[E],[G],[O],[P],[T])
	                        FOR Jenis_Trans IN([B],[C],[E],[G],[K],[O],[P],[S],[T])
                        ) AS PivotTable;"
		End If

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
        'rptTwo.DataSource = LoadDataTable(Session("bulan"), Session("tahun"), Session("ptj"))
        rptTwo.DataSource = LoadDataTable(bulan, tahun, ptj)
        rptTwo.DataBind()

    End Sub
End Class