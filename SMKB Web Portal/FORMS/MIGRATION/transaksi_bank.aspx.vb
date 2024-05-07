Imports System.Globalization
Imports System.Threading
Imports System.Web.Services
Imports System.Data.SqlClient
Imports System.Web.Services.Protocols

Public Class transaksi_bank
    Inherits System.Web.UI.Page
    'Dim dbconn As New DBKewConn

    Public dsTrans As New DataSet
    Dim dbconn As New DBKewConn

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' txtTokenID.Value = Session("tokenID")

            'txtTkhTrans.Value = DateTime.Today.ToString("yyyy-MM-dd")
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")


            Dim currentYear As Integer = DateTime.Now.Year
            Dim startYear As Integer = currentYear - 10 ' Change the value as per your requirement
            Dim endYear As Integer = currentYear ' Change the value as per your requirement

            For year As Integer = startYear To endYear
                ddlTahun.Items.Add(New ListItem(year.ToString(), year.ToString()))
            Next

            ddlTahun.Items.FindByValue(DateTime.Now.Year).Selected = True

            fBindKodBank("76106")
            fBindBulan(DateTime.Now.Month)
        End If
    End Sub

    <WebMethod(EnableSession:=True)>
    Public Shared Async Function TransferData(ByVal kodbank As String, ByVal bulan As String, ByVal tahun As String) As Tasks.Task(Of String)
        Try
            Dim myGetTicket As New TokenResponseModel()
            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateTransBank(myGetTicket.GetTicket("smkb", HttpContext.Current.Session("ssusrID")), kodbank, bulan, tahun)
            Return "Transfer Berjaya. <br>" & values
            'lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception
            Return "Ralat."
            'lblModalMessaage.Text = "Ralat."
            'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Function



    '<WebMethod(EnableSession:=True)>
    'Public Shared Async Function GetTotalTransfer(ByVal kodbank As String, ByVal bulan As String, ByVal tahun As String) As Tasks.Task(Of String)
    '    Try
    '        Dim myGetTicket As New TokenResponseModel()

    '        Dim servicex As New ValuesService()
    '        Dim values As String = Await servicex.getTotalTransfer(myGetTicket.GetTicket("smkb", HttpContext.Current.Session("ssusrID")), kodbank, bulan, tahun)

    '        Dim result = values.Split("|")

    '        Dim percent As Decimal = (CDbl(result(0)) / CDbl(result(1))) * 100

    '        Return percent
    '        'lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
    '        'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
    '    Catch ex As Exception
    '        Return "Ralat."
    '        'lblModalMessaage.Text = "Ralat."
    '        'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
    '    End Try
    'End Function

    Private Sub fBindKodBank(kodKlasifikasi As String)
        Try
            Dim strsql As String

            strsql = $"select kod_bank, (kod_bank + ' - ' + Nama_Bank) as Nama_Bank from SMKB_Bank_Master"

            Dim ds As New DataSet
            Dim dt As New DataTable
            ds = dbconn.fSelectCommand(strsql)

            ddlKodBank.DataSource = ds
            ddlKodBank.DataTextField = "Nama_Bank"
            ddlKodBank.DataValueField = "kod_bank"
            ddlKodBank.DataBind()


            ddlKodBank.Items.Insert(0, New ListItem("- SILA PILIH -", 0))

            If kodKlasifikasi = "" Then
                ddlKodBank.SelectedIndex = 0
            Else
                ddlKodBank.Items.FindByValue(kodKlasifikasi).Selected = True
            End If

        Catch ex As Exception
            Response.Write("An error occurred: " & ex.Message)
        End Try
    End Sub

    Private Sub fBindBulan(kodKlasifikasi As String)
        Try
            Dim strsql As String

            strsql = $"SELECT Kod_Detail, Butiran
                    FROM SMKB_Lookup_Detail
                    WHERE kod = '0147'
                    ORDER BY CONVERT(INT, Kod_Detail)"

            Dim ds As New DataSet
            Dim dt As New DataTable
            ds = dbconn.fSelectCommand(strsql)

            ddlBulan.DataSource = ds
            ddlBulan.DataTextField = "Butiran"
            ddlBulan.DataValueField = "Kod_Detail"
            ddlBulan.DataBind()


            ddlBulan.Items.Insert(0, New ListItem("- SILA PILIH -", 0))

            If kodKlasifikasi = "" Then
                ddlBulan.SelectedIndex = 0
            Else
                ddlBulan.Items.FindByValue(kodKlasifikasi).Selected = True
            End If

        Catch ex As Exception
            Response.Write("An error occurred: " & ex.Message)
        End Try
    End Sub
End Class