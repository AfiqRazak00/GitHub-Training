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
Imports System.Runtime.InteropServices.ComTypes

Public Class TetapanTahap
    Inherits System.Web.UI.Page

    Public dsTahapDT As New DataSet
    Public dvTahapDT As New DataView
    Dim dbconn As New DBKewConn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            fCariTahap()

            fBindTahap("")
            fBindGv()

        End If
    End Sub

    Private Function fBindGv()

        Try

            Dim dt As New DataTable
            dt = fCreateDtKW()

            If dt.Rows.Count = 0 Then
                gvTahapDT.DataSource = New List(Of String)
            Else
                gvTahapDT.DataSource = dt
            End If
            gvTahapDT.DataBind()
            'lblJumRekod.InnerText = dt.Rows.Count


            'Required for jQuery DataTables to work.
            gvTahapDT.UseAccessibleHeader = True
            gvTahapDT.HeaderRow.TableSection = TableRowSection.TableHeader

        Catch ex As Exception

        End Try
    End Function

    Private Function fCreateDtKW() As DataTable

        Try

            Dim dt As New DataTable
            dt.Columns.Add("Bil", GetType(String))
            dt.Columns.Add("No_Staf", GetType(String))
            dt.Columns.Add("ms01_nama", GetType(String))
            dt.Columns.Add("pejabat", GetType(String))
            dt.Columns.Add("status", GetType(String))

            Dim intBil As Integer
            Dim strNoStaf As String
            Dim strNama As String
            Dim strPejabat As String
            Dim strStatus As String

            Dim dataCarian = ddlTahap.SelectedValue

            Dim strSql As String = $"SELECT a.No_Staf, b.ms01_nama,  d.pejabat, a.Status
                        FROM SMKB_UTahapDT as a, [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_Peribadi as b, [DEVMIS\SQL_INS01].dbStaf.dbo.MS08_Penempatan as c, [DEVMIS\SQL_INS01].dbStaf.dbo.MS_Pejabat d
                        WHERE a.No_Staf = b.ms01_nostaf
                        AND a.No_Staf  = c.ms01_nostaf
                        AND c.ms08_staterkini = 1
                        AND c.ms08_pejabat = d.kodpejabat
                        AND a.Kod_Tahap = '{dataCarian}'
                        ORDER BY b.ms01_nama"

            dsTahapDT = dbconn.fSelectCommand(strSql)
            dvTahapDT = New DataView(dsTahapDT.Tables(0))
            intBil = 1
            For i As Integer = 0 To dsTahapDT.Tables(0).Rows.Count - 1

                intBil = i
                strNoStaf = dsTahapDT.Tables(0).Rows(i)(0).ToString
                strNama = dsTahapDT.Tables(0).Rows(i)(1).ToString
                strPejabat = dsTahapDT.Tables(0).Rows(i)(2).ToString

                Dim status = dsTahapDT.Tables(0).Rows(i)(3).ToString
                If status = 1 Then
                    strStatus = "Aktif"
                Else
                    strStatus = "Tidak Aktif"
                End If

                dt.Rows.Add(intBil, strNoStaf, strNama, strPejabat, strStatus)
            Next

            Return dt

        Catch ex As Exception

        End Try

    End Function

    'Private Sub lbtnSimpan_Click(sender As Object, e As EventArgs) Handles lbtnSimpan.ServerClick
    '    Dim strSql As String
    '    Dim dbconn As New DBKewConn
    '    Try
    '        Dim strCode As String = Trim(txtCode.Value.TrimEnd)
    '        Dim strDescription As String = Trim(txtDescription.Value.ToUpper.TrimEnd)
    '        Dim strMasterLookup As String = ddlTahap.SelectedValue
    '        Dim strStartDate As String = Trim(txtStartDate1.Value)
    '        Dim strEndDate As String = Trim(txtEndDate1.Value)
    '        Dim strPriority As String = Trim(rblpriority_indicator.DataValueField)
    '        Dim intStatus As Integer = Trim(rblStatus.DataValueField)
    '        Dim strhfc_cd As String = "PKUTEM"




    '        'If ViewState("SaveMode") = 1 Then
    '        'INSERT

    '        strSql = "select count(*) from SMKB_lookup_detail where Master_Reference_code = '" & strMasterLookup & "' and Detail_Reference_code ='" & strCode & "'"
    '        If fCheckRec(strSql) = 0 Then

    '            strSql = "insert into SMKB_lookup_detail (Master_Reference_code, Detail_Reference_code, Description, priority_indicator, start_date, end_date , status, hfc_cd ) 
    '                values (@Master_Reference_code, @Detail_Reference_code,@Description, @priority_indicator, @start_date, @end_date, @Status, @hfc_cd)"
    '            Dim paramSql() As SqlParameter = {
    '                New SqlParameter("@Detail_Reference_code", strCode),
    '                New SqlParameter("@Master_Reference_code", strMasterLookup),
    '                New SqlParameter("@Description", strDescription),
    '                New SqlParameter("@priority_indicator", strPriority),
    '                New SqlParameter("@start_date", strStartDate),
    '                New SqlParameter("@end_date", strEndDate),
    '                New SqlParameter("@Status", intStatus),
    '                New SqlParameter("@hfc_cd", strhfc_cd)
    '            }

    '            dbconn.sConnBeginTrans()
    '            If dbconn.fInsertCommand(strSql, paramSql) > 0 Then
    '                dbconn.sConnCommitTrans()
    '                'fGlobalAlert("Rekod baru telah disimpan!", Me.Page, Me.[GetType]())
    '                lblModalMessaage.Text = "Rekod baru telah disimpan" 'message di modal
    '                ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
    '                fBindGv()
    '                'fReset()
    '            Else
    '                dbconn.sConnRollbackTrans()
    '                'fGlobalAlert("Ralat!", Me.Page, Me.[GetType]())
    '                lblModalMessaage.Text = "Ralat!" 'message di modal
    '                ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
    '            End If

    '            'Else


    '            'End If

    '            'ElseIf ViewState("SaveMode") = 2 Then
    '        Else
    '            'UPDATE
    '            strSql = "update SMKB_lookup_detail set Description = @Description, priority_indicator = @priority_indicator, start_date = @start_date, end_date = @end_date, status = @status
    '            where Master_Reference_code = '" & strMasterLookup & "' AND Detail_Reference_code = '" & strCode & "'"
    '            Dim paramSql() As SqlParameter = {
    '                    New SqlParameter("@Code", strCode),
    '                    New SqlParameter("@Description", strDescription),
    '                    New SqlParameter("@priority_indicator", strPriority),
    '                    New SqlParameter("@start_date", strStartDate),
    '                    New SqlParameter("@end_date", strEndDate),
    '                    New SqlParameter("@Status", intStatus)
    '                        }
    '            dbconn.sConnBeginTrans()
    '            If dbconn.fUpdateCommand(strSql, paramSql) > 0 Then
    '                dbconn.sConnCommitTrans()
    '                'fGlobalAlert("Rekod telah dikemaskini!", Me.Page, Me.[GetType]())
    '                lblModalMessaage.Text = "Rekod telah dikemaskini." 'message di modal
    '                ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
    '                fBindGv()
    '                'fReset()
    '            Else
    '                dbconn.sConnRollbackTrans()
    '                'fGlobalAlert("Ralat!", Me.Page, Me.[GetType]())
    '                lblModalMessaage.Text = "Ralat!" 'message di modal
    '                ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
    '            End If
    '        End If

    '    Catch ex As Exception

    '    End Try
    'End Sub


    'Private Sub gvTahapDT_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvTahapDT.RowCommand
    '    Try
    '        If e.CommandName = "Select" Then


    '            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
    '            Dim selectedRow As GridViewRow = gvTahapDT.Rows(index)

    '            Dim strKod As String = selectedRow.Cells(0).Text.ToString
    '            txtDescription.Value = selectedRow.Cells(1).Text.ToString


    '            'Call sql
    '            Dim strSql As String = $"select Master_Reference_code, Detail_Reference_code, Description, priority_indicator, start_date, end_date, status from SMKB_lookup_detail
    '                            where hfc_cd = 'PKUTEM'
    '                            and Detail_Reference_code = '{strKod}' and Master_Reference_code ='" & ddlCariTahap.SelectedValue & "'"

    '            Dim dt As New DataTable
    '            dt = dbconn.fSelectCommandDt(strSql)
    '            If dt.Rows.Count > 0 Then

    '                Dim Master_Reference_code As String = dt.Rows(0)("Master_Reference_code")
    '                fBindTahap(Master_Reference_code)
    '                fBindTahap(Master_Reference_code)

    '                txtCode.Value = dt.Rows(0)("Detail_Reference_code")
    '                txtDescription.Value = dt.Rows(0)("Description")


    '                Dim startDate As DateTime = CDate(dt.Rows(0)("start_date"))

    '                'txtStartDate1.Value = 
    '                txtStartDate1.Value = Format(startDate, "yyyy-MM-dd")

    '                Dim endDate As DateTime = CDate(dt.Rows(0)("end_date"))

    '                'txtEndDate1.Value = 
    '                'txtEndDate1.Value = endDate.ToShortDateString()

    '                txtEndDate1.Value = Format(endDate, "yyyy-MM-dd")

    '                Dim priority_indicator = dt.Rows(0)("priority_indicator")
    '                rblpriority_indicator.SelectedValue = priority_indicator

    '                Dim status = dt.Rows(0)("status")
    '                rblStatus.SelectedValue = status

    '                'ClientScript.RegisterStartupScript([GetType](), "alert1", "updStartDate('" & Format(startDate, "yyyy-MM-dd") & "');", True)
    '                ' ClientScript.RegisterStartupScript([GetType](), "alert2", "updEndDate('" & Format(endDate, "yyyy-MM-dd") & "');", True)
    '            End If


    '            ClientScript.RegisterStartupScript([GetType](), "alert3", "ShowPopup('1');", True)


    '        End If
    '    Catch ex As Exception

    '    End Try
    'End Sub

    Private Sub gvTahapDT_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvTahapDT.PageIndexChanging
        gvTahapDT.PageIndex = e.NewPageIndex
        fBindGv()
    End Sub


    Private Sub fBindTahap(kodKlasifikasi As String)
        Try
            Dim strsql As String
            Dim dataCarian = ddlCariTahap.SelectedValue

            strsql = $"select SELECT Kod_Tahap, Jen_Tahap, Butiran, Status FROM SMKB_UTahap WHERE status = 1 ORDER BY Jen_Tahap"

            Dim ds As New DataSet
            Dim dt As New DataTable
            ds = dbconn.fSelectCommand(strsql)
            ' Dim strKod = Trim(ds.Tables(0).Rows(0)("Kod").ToString)

            ddlTahap.DataSource = ds
            ddlTahap.DataTextField = "Jen_Tahap"
            ddlTahap.DataValueField = "Kod_Tahap"
            ddlTahap.DataBind()


            ddlTahap.Items.Insert(0, New ListItem("- SILA PILIH -", 0))

            'If kodKlasifikasi = "" Then
            'ddlTahap.SelectedIndex = 0
            'Else
            ddlTahap.Items.FindByValue(ddlCariTahap.SelectedValue).Selected = True
            'End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub fCariTahap()
        Try
            Dim strsql As String


            strsql = $"SELECT Kod_Tahap, Jen_Tahap, Butiran, Status FROM SMKB_UTahap WHERE status = 1 ORDER BY Jen_Tahap"

            Dim ds As New DataSet
            Dim dt As New DataTable
            ds = dbconn.fSelectCommand(strsql)
            'Dim strKod = Trim(ds.Tables(0).Rows(0)("Kod").ToString)

            ddlCariTahap.DataSource = ds
            ddlCariTahap.DataTextField = "Jen_Tahap"
            ddlCariTahap.DataValueField = "Kod_Tahap"
            ddlCariTahap.DataBind()

            ddlCariTahap.Items.Insert(0, New ListItem("- SILA PILIH -", 0))
            ddlCariTahap.SelectedIndex = 0


        Catch ex As Exception

        End Try
    End Sub

    Private Sub lbtnCari_Click(sender As Object, e As EventArgs) Handles lbtnCari.ServerClick
        fBindGv()
    End Sub


End Class