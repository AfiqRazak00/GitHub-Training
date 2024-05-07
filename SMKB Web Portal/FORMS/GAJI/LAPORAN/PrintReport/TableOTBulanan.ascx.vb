Imports System.Data.SqlClient
Imports System.Web.Services

Public Class TableOTBulanan
    Inherits System.Web.UI.UserControl
    Dim totalAmaun As Decimal = 0
    Dim totalStaff As Decimal = 0
    Public Property totalAmaunAll As Decimal
    Public Property totalStaffAll As Decimal

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim bulan As String = Session("bulan")
            Dim tahun As String = Session("tahun")
            Dim ptj As String = Session("ptj")
            rptone.DataSource = GetPtj(bulan, tahun, ptj) 'Get group header
            rptone.DataBind()
        End If
    End Sub

    Private Function GetPtj(bulan As String, tahun As String, ptj As String) As DataTable
        Dim connection As New SqlConnection(strCon)

        If ptj = "00" Then
            ptj = "%"
        ElseIf ptj = "-0000" Then
            ptj = "-"
        Else
            ptj = Session("ptj") + "%"
        End If

        Dim query As String = $"SELECT DISTINCT A.OT_Ptj, C.Pejabat
                            FROM SMKB_EOT_Mohon_Hdr A
                            INNER JOIN SMKB_EOT_Mohon_Dtl B ON B.No_Mohon = A.No_Mohon
                            LEFT JOIN {DBStaf}MS_PEJABAT C ON C.KodPejPBU = A.OT_Ptj
                            WHERE B.Bulan = @bulan AND B.Tahun = @tahun AND A.OT_Ptj LIKE @ptj
                            ORDER BY A.OT_Ptj;"

        Dim command As New SqlCommand(query, connection)
        command.Parameters.Add(New SqlParameter("@tahun", tahun))
        command.Parameters.Add(New SqlParameter("@bulan", bulan))
        command.Parameters.Add(New SqlParameter("@ptj", ptj))

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

    Private Function LoadDataTable(ptj As String) As DataTable
        Dim query As String

        query = $"SELECT A.No_Mohon,C.MS01_Nama AS Nama, B.Tkh_Tuntut, FORMAT(B.Tkh_Tuntut, 'dd/MM/yyyy') AS formatted_date, A.Gaji, A.OT_Ptj, A.No_Staf,B.Jum_Jam_Tuntut,B.Kadar_Tuntut,B.Amaun_Tuntut,B.Jum_Jam_Sah,B.Kadar_Sah,B.Amaun_Sah,B.Jum_Jam_Lulus,B.Kadar_Lulus,B.Amaun_Lulus,
				B.Bulan,B.Tahun,B.Jum_Jam_Terima,B.Kadar_Terima,B.Amaun_Terima
				FROM SMKB_EOT_Mohon_Hdr A
				INNER JOIN SMKB_EOT_Mohon_Dtl B ON B.No_Mohon = A.No_Mohon
				LEFT JOIN {DBStaf}MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
				WHERE B.Bulan = @bulan AND B.Tahun = @tahun AND A.OT_Ptj LIKE  @ptj
				ORDER BY A.No_Staf,B.Tkh_Tuntut;"

        Dim dataTable As New DataTable()

        Using connection As New SqlConnection(strCon)
            Using command As New SqlCommand(query, connection)
                command.Parameters.Add(New SqlParameter("@tahun", Session("tahun")))
                command.Parameters.Add(New SqlParameter("@bulan", Session("bulan")))
                command.Parameters.Add(New SqlParameter("@ptj", ptj))

                connection.Open()
                dataTable.Load(command.ExecuteReader())
            End Using
        End Using
        Return dataTable
    End Function

    <WebMethod(EnableSession:=True)>
    Protected Sub rptone_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim rptItem As RepeaterItem = TryCast(e.Item, RepeaterItem)
        Dim ptj As String = rptItem.DataItem("OT_Ptj")

        Dim rptTwo As Repeater = TryCast(rptItem.FindControl("repeaterDetail"), Repeater)
        rptTwo.DataSource = LoadDataTable(ptj)
        totalAmaun = 0
        rptTwo.DataBind()

        Dim jumlahAmaunControl As HtmlTableCell = DirectCast(e.Item.FindControl("jumlahAmaun"), HtmlTableCell)

        If jumlahAmaunControl IsNot Nothing Then
            jumlahAmaunControl.InnerText = "Jumlah Amaun: " + totalAmaun.ToString("N2") ' Format as a decimal with two decimal places
        End If


        Session("jumlahBesarAmaun") = totalAmaunAll.ToString("N2")
    End Sub

    Protected Sub repeaterDetail_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            'Retrieve the Amaun value from the data source
            Dim amaun As Decimal = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Amaun_Lulus"))
            'Accumulate the total Amaun
            totalAmaun += amaun
            totalAmaunAll += amaun
        End If
    End Sub
End Class