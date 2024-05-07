Imports Microsoft.AspNet.Identity
Imports System.Globalization
Imports System.Threading
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Collections.Specialized
Imports System.Reflection
Imports System
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Net.NetworkInformation
Imports System.Diagnostics.Eventing
Imports System.Diagnostics.Eventing.Reader
Imports System.Linq
Imports System.Data.Entity.Infrastructure
Imports System.IO

Public Class transferLajerPenghutang
    Inherits System.Web.UI.Page
    'Dim dbconn As New DBKewConn

    Public dsTrans As New DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' txtTokenID.Value = Session("tokenID")

            'txtTkhTrans.Value = DateTime.Today.ToString("yyyy-MM-dd")
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")


            Dim currentYear As Integer = DateTime.Now.Year
            Dim startYear As Integer = currentYear - 5 ' Change the value as per your requirement
            Dim endYear As Integer = currentYear  ' Change the value as per your requirement

            For year As Integer = endYear To startYear Step -1
                ddlTahun.Items.Add(New ListItem(year.ToString(), year.ToString()))
            Next


        End If
    End Sub

    Protected Async Sub GetDataApi_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.get_KodPenghutang(myGetTicket.GetTicket("smkb", Session("ssusrID")), "01662")
            'Dim myList = values.ToList()
            errorMessage.InnerText = ("Data0 " & values)
        Catch
            errorMessage.InnerText = "TIADA DATA"
        End Try
    End Sub

    Protected Async Sub InsertData_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateLajerPenghutangResit(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. " & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat."
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try

    End Sub

    Protected Async Sub btnBil_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateLajerPenghutangBil(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. " & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat."
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub

    Protected Async Sub blnTerimaanDtl_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateTerimaDtl(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat."
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub

    Protected Async Sub btnInvoisDtl_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateInvoisDtl(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat." + ex.Message.ToString()
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub
    Protected Async Sub btnBaucarDtl_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateBaucarDtl(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat." + ex.Message.ToString()
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub

    Protected Async Sub btnBaucarHdr_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateBaucarHdr(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat." + ex.Message.ToString()
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub

    Protected Async Sub btnUpdateIRRujukanBaucar_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.updateIDRujukanBaucarHdr(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat." + ex.Message.ToString()
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub


    Protected Async Sub btnUpdateEmail_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.updateEmailStaf(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat." + ex.Message.ToString()
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub

    Protected Async Sub blnTerimaanHdr_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateTerimaHdr(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat." + ex.Message.ToString()
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub
    Protected Async Sub blnTerimaanTrans_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateTerimaTrans(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat."
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub


    Protected Async Sub btnBilHdr_Click(sender As Object, e As EventArgs)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim values As String = Await servicex.migrateBilHdr(myGetTicket.GetTicket("smkb", Session("ssusrID")))

            lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception

            lblModalMessaage.Text = "Ralat."
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Sub

End Class