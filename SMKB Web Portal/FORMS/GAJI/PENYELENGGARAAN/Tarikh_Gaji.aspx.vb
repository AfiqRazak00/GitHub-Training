Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Net.NetworkInformation
Public Class Tarikh_Gaji
    Inherits System.Web.UI.Page
    Dim dbconn As New DBKewConn
    Dim dbconnSM As New DBSMConn
    Public dsKod As New DataSet
    Public dvKodKW As New DataView
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            fBindGvJenis()

        End If
    End Sub
    Private Sub fBindGvJenis()


        Try
            Dim dt As New DataTable
            dt = fCreateDtJenis()

            If dt.Rows.Count = 0 Then
                gvJenis.DataSource = New List(Of String)
            Else
                gvJenis.DataSource = dt
            End If
            gvJenis.DataBind()
            'lblJumRekod.InnerText = dt.Rows.Count


            'Required for jQuery DataTables to work.
            gvJenis.UseAccessibleHeader = True
            gvJenis.HeaderRow.TableSection = TableRowSection.TableHeader

        Catch ex As Exception

        End Try
    End Sub
    Private Function fCreateDtJenis() As DataTable

        Try

            Dim dt As New DataTable
            dt.Columns.Add("bulan", GetType(String))
            dt.Columns.Add("tahun", GetType(String))
            dt.Columns.Add("Tarikh_Byr_Gaji", GetType(String))
            dt.Columns.Add("status", GetType(String))


            Dim bulan As String
            Dim tahun As String
            Dim tkhgaji As String
            Dim stagaji As String
            Dim strSql As String = "SELECT bulan,tahun,CONVERT(VARCHAR,ISNULL(Tarikh_Byr_Gaji,GETDATE()),103) Tarikh_Byr_Gaji,status from smkb_gaji_Tarikh_Gaji order by  tahun,bulan desc"
            Dim dbconn As New DBKewConn
            dsKod = dbconn.fSelectCommand(strSql)
            dvKodKW = New DataView(dsKod.Tables(0))

            For i As Integer = 0 To dsKod.Tables(0).Rows.Count - 1

                bulan = dsKod.Tables(0).Rows(i)(0).ToString
                tahun = dsKod.Tables(0).Rows(i)(1).ToString
                tkhgaji = dsKod.Tables(0).Rows(i)(2).ToString
                stagaji = dsKod.Tables(0).Rows(i)(3).ToString

                dt.Rows.Add(bulan, tahun, tkhgaji, stagaji)
            Next

            Return dt

        Catch ex As Exception

        End Try

    End Function
    Private Sub gvJenis_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvJenis.RowCommand
        Try
            Dim strSql As String
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim selectedRow As GridViewRow = gvJenis.Rows(index)
            If e.CommandName = "EditRow" Then

                ddlMonths.Value = selectedRow.Cells(0).Text.ToString
                ddlyear.Value = selectedRow.Cells(1).Text.ToString
                tkhGaji.Text = selectedRow.Cells(2).Text.ToString

                If selectedRow.Cells(3).Text = True Then
                    ddlStatus.Text = "AKTIF"
                Else
                    ddlStatus.Text = "TIDAK AKTIF"
                End If

                ViewState("SaveMode") = "2"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "ShowPopup('2');", True)

            ElseIf e.CommandName = "DeleteRow" Then
                ViewState("SaveMode") = "3"
                Dim sbln As String = selectedRow.Cells(0).Text.ToString
                Dim sthn As String = selectedRow.Cells(1).Text.ToString

                strSql = "delete from SMKB_Gaji_Tarikh_Gaji where bulan = '" & sbln & "' and tahun = '" & sthn & "'"
                dbconn.sConnBeginTrans()
                If dbconn.fUpdateCommand(strSql) > 0 Then
                    dbconn.sConnCommitTrans()

                    lblModalMessaage.Text = "Rekod telah dipadam!" 'message di modal
                    ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                    fBindGvJenis()
                Else
                    dbconn.sConnRollbackTrans()
                    lblModalMessaage.Text = "Rekod gagal dipadam!" 'message di modal
                    ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                End If


            End If
        Catch ex As Exception

        End Try
    End Sub
    Private Sub lbtnSave_Click(sender As Object, e As EventArgs) Handles lbtnSave.ServerClick
        Dim strSql As String
        Dim dbconn As New DBKewConn
        Try
            Dim strBulan As String = ddlMonths.Value
            Dim strTahun As String = ddlyear.Value
            Dim strTkhGaji As String = tkhGaji.Text
            Dim strStatus As Byte
            Dim isave As String = hdnSave.Text
            Dim message As String = "Rekod tidak disimpan. Sila masukkan jensi transaksi."

            If ddlStatus.SelectedValue = "AKTIF" Then
                strStatus = 1
            Else
                strStatus = 0
            End If

            If isave = "1" Then

                If strBulan = "" Then
                    message = "Sila masukkan Bulan!"
                    ClientScript.RegisterStartupScript([GetType](), "alert", "notification('" + message + "');", True)
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "ShowPopup('1');", True)
                    Exit Sub
                End If

                strSql = "select count(*) from SMKB_Gaji_Tarikh_Gaji where Bulan = '" & strBulan & "' and Tahun = '" & strTahun & "'"
                If fCheckRec(strSql) = 0 Then
                    strSql = "insert into SMKB_Gaji_Tarikh_Gaji (Bulan, Tahun , Tarikh_Byr_Gaji, Status) values (@a,@b,@c,@d)"
                    Dim paramSql() As SqlParameter = {
                        New SqlParameter("@a", strBulan),
                        New SqlParameter("@b", strTahun),
                        New SqlParameter("@c", strTkhGaji),
                        New SqlParameter("@d", strStatus)
                    }

                    dbconn.sConnBeginTrans()
                    If dbconn.fInsertCommand(strSql, paramSql) > 0 Then
                        dbconn.sConnCommitTrans()
                        'fGlobalAlert("Rekod baru telah disimpan!", Me.Page, Me.[GetType]())
                        fBindGvJenis()
                        'fReset()
                        lblModalMessaage.Text = "Rekod baru telah disimpan." 'message di modal
                        ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                    Else
                        dbconn.sConnRollbackTrans()
                        'fGlobalAlert("Ralat!", Me.Page, Me.[GetType]())
                        lblModalMessaage.Text = "Ralat!" 'message di modal
                        ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                    End If
                Else
                    lblModalMessaage.Text = "Rekod tidak disimpan. Tarikh bagi bulan dan tahun ini telah wujud." 'message di modal
                    ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                    Exit Sub
                End If
            Else
                strSql = "UPDATE SMKB_Gaji_Tarikh_Gaji SET Tarikh_Byr_Gaji=@a, Status=@b WHERE Bulan=@c and Tahun = @d"

                Dim paramSql() As SqlParameter = {
                                New SqlParameter("@a", strTkhGaji),
                                New SqlParameter("@b", strStatus),
                                New SqlParameter("@c", strBulan),
                                New SqlParameter("@d", strTahun)
                        }

                dbconn = New DBKewConn
                dbconn.sConnBeginTrans()
                If dbconn.fInsertCommand(strSql, paramSql) > 0 Then
                    dbconn.sConnCommitTrans()

                    fBindGvJenis()
                    lblModalMessaage.Text = "Rekod telah dikemaskini." 'message di modal
                    ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                Else
                    dbconn.sConnRollbackTrans()

                    lblModalMessaage.Text = "Ralat!" 'message di modal
                End If
            End If

        Catch ex As Exception

        End Try
    End Sub
End Class