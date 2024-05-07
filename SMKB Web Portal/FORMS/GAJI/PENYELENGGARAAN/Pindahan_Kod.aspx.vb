Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Net.NetworkInformation
Public Class Pindahan_Kod
    Inherits System.Web.UI.Page
    Dim dbconn As New DBKewConn
    Dim dbconnSM As New DBSMConn
    Public dsKod As New DataSet
    Public dvKodKW As New DataView

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            fBindGvJenis()
            fBindDdlSMSM(ddlKatSMSM)
            fBindDdlSMKB(ddlKatSMKB)


        End If
    End Sub
    Private Sub fBindGvJenis()


        Try
            Dim dt As New DataTable
            dt = fCreateDtJenis()

            If dt.Rows.Count = 0 Then
                gvPindah.DataSource = New List(Of String)
            Else
                gvPindah.DataSource = dt
            End If
            gvPindah.DataBind()
            'lblJumRekod.InnerText = dt.Rows.Count


            'Required for jQuery DataTables to work.
            gvPindah.UseAccessibleHeader = True
            gvPindah.HeaderRow.TableSection = TableRowSection.TableHeader

        Catch ex As Exception

        End Try
    End Sub
    Private Function fCreateDtJenis() As DataTable

        Try

            Dim dt As New DataTable
            dt.Columns.Add("kod_smsm", GetType(String))
            dt.Columns.Add("kod_smkb", GetType(String))

            Dim kodsmsm As String
            Dim kodsmkb As String

            Dim strSql As String = "SELECT kod_smsm,kod_smkb from smkb_gaji_kod_convert order by kod_smsm"
            Dim dbconn As New DBKewConn
            dsKod = dbconn.fSelectCommand(strSql)
            dvKodKW = New DataView(dsKod.Tables(0))

            For i As Integer = 0 To dsKod.Tables(0).Rows.Count - 1

                kodsmsm = dsKod.Tables(0).Rows(i)(0).ToString
                kodsmkb = dsKod.Tables(0).Rows(i)(1).ToString

                dt.Rows.Add(kodsmsm, kodsmkb)
            Next

            Return dt

        Catch ex As Exception

        End Try

    End Function
    Private Sub gvPindah_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvPindah.RowCommand
        Try
            Dim strSql As String
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim selectedRow As GridViewRow = gvPindah.Rows(index)
            If e.CommandName = "EditRow" Then

                'Dim kod As String = ViewState("kod")



                ddlKatSMSM.Text = selectedRow.Cells(0).Text.ToString
                ddlKatSMKB.Text = selectedRow.Cells(1).Text.ToString
                'txtDaripada.Text = selectedRow.Cells(2).Text.ToString
                ViewState("SaveMode") = "2"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "ShowPopup('2');", True)

            ElseIf e.CommandName = "DeleteRow" Then
                ViewState("SaveMode") = "3"
                Dim jenis As String = selectedRow.Cells(0).Text.ToString

                If fCheckMaster(jenis) = False Then
                    strSql = "delete from SMKB_Gaji_Kod_Convert where kod_smsm = '" & jenis & "'"
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

                Else

                    lblModalMessaage.Text = "Rekod tidak dapat dipadam! Terdapat rekod potongan ini dalam master gaji!" 'message di modal
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
            Dim strKod As String = Trim(ddlKatSMSM.Text.TrimEnd)
            Dim strButir As String = Trim(ddlKatSMKB.Text.ToUpper.TrimEnd)
            'Dim strDaripada As String = Trim(txtDaripada.Text.ToUpper.TrimEnd)

            strSql = "select count(*) from SMKB_Gaji_Jenis_Trans where Jenis_Trans = '" & strKod & "'"
            If fCheckRec(strSql) = 0 Then

                strSql = "insert into SMKB_Gaji_Kod_Convert (Kod_SMSM , kod_SMKB) values (@Kod,@Butiran)"
                Dim paramSql() As SqlParameter = {
                    New SqlParameter("@Kod", strKod),
                    New SqlParameter("@Butiran", strButir)
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
                'lblModalMessaage.Text = "Ralat!Jenis trans telah wujud!" 'message di modal
                'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                strSql = "UPDATE SMKB_Gaji_Kod_Convert SET kod_SMKB=@Butir WHERE kod_SMSM=@Kod"

                Dim paramSql() As SqlParameter = {
                            New SqlParameter("@Butir", strButir),
                             New SqlParameter("@Kod", strKod)
                        }

                dbconn = New DBKewConn
                dbconn.sConnBeginTrans()
                If dbconn.fInsertCommand(strSql, paramSql) > 0 Then
                    dbconn.sConnCommitTrans()
                    'Alert("Rekod telah dikemaskini!")
                    fBindGvJenis()
                    lblModalMessaage.Text = "Rekod telah dikemaskini." 'message di modal
                    ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                Else
                    dbconn.sConnRollbackTrans()
                    'Alert("Rekod gagal dikemaskini!")
                    lblModalMessaage.Text = "Ralat!" 'message di modal
                End If
            End If


        Catch ex As Exception

        End Try
    End Sub

    Private Function fCheckMaster(ByVal strKod As String) As Boolean
        Dim strSql = "select count(*) from smkb_gaji_master  where jenis_trans = '" & strKod & "'"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt < 1 Then
            Return False
        Else
            Return True
        End If

    End Function
    Private Sub fBindDdlSMSM(ddl As DropDownList)
        Dim strSql As String = "Select KodElaun, Elaun,KodElaun + ' - ' + Elaun as butir from MS_Elaun order by KodElaun"
        Using dt = dbconnSM.fSelectCommandDt(strSql)
            ddl.DataSource = dt
            ddl.DataTextField = "butir"
            ddl.DataValueField = "KodElaun"
            ddl.DataBind()

            ddl.Items.Insert(0, New ListItem("- SILA PILIH - ", "-"))
            ddl.SelectedIndex = 0

        End Using
    End Sub
    Private Sub fBindDdlSMKB(ddl As DropDownList)
        Dim strSql As String = "Select Kod_Trans, Butiran,Kod_Trans + ' - ' + Butiran as butir from SMKB_Gaji_Kod_Trans order by Kod_Trans"
        Using dt = dbconn.fSelectCommandDt(strSql)
            ddl.DataSource = dt
            ddl.DataTextField = "butir"
            ddl.DataValueField = "Kod_Trans"
            ddl.DataBind()

            ddl.Items.Insert(0, New ListItem("- SILA PILIH - ", "-"))
            ddl.SelectedIndex = 0

        End Using
    End Sub
End Class