Imports System.Data.SqlClient
Imports System.Web.Services

Public Class TableStafKontrak
    Inherits System.Web.UI.UserControl
    Dim totalAmaun As Decimal = 0
    Dim totalStaff As Decimal = 0
    Public Property totalAmaunAll As Decimal
    Public Property totalStaffAll As Decimal

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim tahun As String = Session("tahun")
            Dim selectedWarga As String = Session("selectedWarga")
            rptone.DataSource = GetPtj(tahun, selectedWarga) 'Get group header
            rptone.DataBind()
        End If
    End Sub

    Private Function GetPtj(tahun As String, selectedWarga As String) As DataTable
        Dim connection As New SqlConnection(strCon)
        Dim query As String =
                        $"SELECT DISTINCT B.MS01_Warganegara,
                        CASE 
	                        WHEN B.MS01_Warganegara = 'M01' THEN 'WARGANEGARA' ELSE 'BUKAN WARGANEGARA' 
                        END AS Warganegara
                        FROM {DBStaf}dbo.MS09_Kontrak A
                        INNER JOIN {DBStaf}MS01_Peribadi B ON B.MS01_NoStaf = A.MS01_NoStaf
                        WHERE '2020' BETWEEN YEAR(A.MS09_TkhMula) AND YEAR(CONVERT(DATETIME, A.MS09_TkhTamat, 103))"

        If (selectedWarga = "0") Then
            query = query & " AND B.MS01_Warganegara <> 'M01';"
        Else
            query = query & " AND B.MS01_Warganegara LIKE @selectedWarga;"
        End If

        Dim command As New SqlCommand(query, connection)
        command.Parameters.Add(New SqlParameter("@tahun", tahun))
        command.Parameters.Add(New SqlParameter("@selectedWarga", selectedWarga))

        Dim potongan As New DataTable()
        connection.Open()

        ' Execute the query and fill the DataTable with the results
        Using adapter As New SqlDataAdapter(command)
            adapter.Fill(potongan)
        End Using

        ' Close the database connection
        connection.Close()

        ' Return the DataTable with the month data
        Return potongan
    End Function

    Private Function LoadDataTable(selectedWarga As String) As DataTable
        Dim query As String

        query = $"SELECT A.MS01_NoStaf, B.MS01_Nama, (SELECT MS02_GredGajiS FROM {DBStaf}MS02_Perjawatan WHERE MS01_NoStaf = A.MS01_NoStaf) AS Gred,
				YEAR(CONVERT(DATETIME, B.MS01_TkhLahir, 103)) AS TahunLahir,
				(YEAR(GETDATE()) - YEAR(CONVERT(DATETIME, B.MS01_TkhLahir, 103))) AS Umur,
				B.MS01_Warganegara, (SELECT NamaNegara FROM {DBStaf}MS_Negara WHERE KodNegara = B.MS01_Warganegara) AS Warganegara,
                CASE 
	                WHEN B.MS01_Warganegara = 'M01' THEN 'WARGANEGARA' ELSE 'BUKAN WARGANEGARA' 
                END AS WarganegaraInd,
				A.MS09_TkhMula,CONVERT(VARCHAR(10), A.MS09_TkhMula, 103) AS TkhMulaFormatted, A.MS09_TkhTamat,
				(SELECT MS02_JumlahGajiS FROM {DBStaf}MS02_Perjawatan WHERE MS01_NoStaf = A.MS01_NoStaf) AS gaji_pokok,
				CASE
					WHEN year(GETDATE()) - substring(B.MS01_TkhLahir,7,4) > 60 THEN '5.5'
					WHEN year(GETDATE()) - substring(B.MS01_TkhLahir,7,4) <= 60 THEN '11'
				END AS kwsp, 
				DATEDIFF(MONTH, CONVERT(DATETIME, A.MS09_TkhMula, 103), CONVERT(DATETIME, A.MS09_TkhTamat, 103)) AS TempohBulan
				FROM {DBStaf}MS09_Kontrak A
				INNER JOIN {DBStaf}MS01_Peribadi B ON B.MS01_NoStaf = A.MS01_NoStaf
				WHERE @tahun BETWEEN YEAR(A.MS09_TkhMula) AND YEAR(CONVERT(DATETIME, A.MS09_TkhTamat, 103)) AND B.MS01_Warganegara = @selectedWarga ORDER BY B.MS01_Nama;"


        Dim dataTable As New DataTable()
        Using connection As New SqlConnection(strCon)
            Using command As New SqlCommand(query, connection)
                command.Parameters.Add(New SqlParameter("@tahun", Session("tahun")))
                command.Parameters.Add(New SqlParameter("@selectedWarga", selectedWarga))
                connection.Open()
                dataTable.Load(command.ExecuteReader())
            End Using
        End Using
        Return dataTable
    End Function

    <WebMethod(EnableSession:=True)>
    Protected Sub rptone_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim rptItem As RepeaterItem = TryCast(e.Item, RepeaterItem)
        Dim ptj As String = rptItem.DataItem("MS01_Warganegara")

        Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
        rptTwo.DataSource = LoadDataTable(ptj)
        totalAmaun = 0
        rptTwo.DataBind()

        Dim jumlahAmaunControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahAmaun"), HtmlTableCell)

        If jumlahAmaunControl IsNot Nothing Then
            jumlahAmaunControl.InnerText = "Jumlah (RM): " + totalAmaun.ToString("N2") ' Format as a decimal with two decimal places
        End If


        'Session("jumlahBesarAmaun") = totalAmaunAll.ToString("N2")
    End Sub

    Protected Sub repeaterDetail_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            'Retrieve the Amaun value from the data source
            Dim amaun As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "gaji_pokok"))
            'Accumulate the total Amaun
            totalAmaun += amaun
        End If
    End Sub


End Class