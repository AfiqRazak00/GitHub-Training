Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Net.NetworkInformation
Public Class KWSP
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
                gvKwsp.DataSource = New List(Of String)
            Else
                gvKwsp.DataSource = dt
            End If
            gvKwsp.DataBind()
            'lblJumRekod.InnerText = dt.Rows.Count


            'Required for jQuery DataTables to work.
            gvKwsp.UseAccessibleHeader = True
            gvKwsp.HeaderRow.TableSection = TableRowSection.TableHeader

        Catch ex As Exception

        End Try
    End Sub
    Private Function fCreateDtJenis() As DataTable

        Try

            Dim dt As New DataTable
            dt.Columns.Add("Kod", GetType(String))
            dt.Columns.Add("Butiran", GetType(String))
            dt.Columns.Add("kwsp_maj", GetType(String))
            dt.Columns.Add("Kwsp_Pek", GetType(String))



            Dim kod As String
            Dim butir As String
            Dim kwsp_pek As String
            Dim kwsp_maj As String



            Dim strSql As String = "SELECT kod,butiran,kwsp_maj,kwsp_pek from smkb_gaji_kwsp order by kod"
            Dim dbconn As New DBKewConn
            dsKod = dbconn.fSelectCommand(strSql)
            dvKodKW = New DataView(dsKod.Tables(0))

            For i As Integer = 0 To dsKod.Tables(0).Rows.Count - 1

                kod = dsKod.Tables(0).Rows(i)(0).ToString
                butir = dsKod.Tables(0).Rows(i)(1).ToString
                kwsp_maj = dsKod.Tables(0).Rows(i)(2).ToString
                kwsp_pek = dsKod.Tables(0).Rows(i)(3).ToString

                dt.Rows.Add(kod, butir, kwsp_maj, kwsp_pek)
            Next

            Return dt

        Catch ex As Exception

        End Try

    End Function
    Private Sub gvKwsp_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvKwsp.RowCommand
        Try
            Dim strSql As String
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim selectedRow As GridViewRow = gvKwsp.Rows(index)


            If e.CommandName = "EditRow" Then

                'Dim kod As String = ViewState("kod")


                txtJenis.Text = selectedRow.Cells(0).Text.ToString
                txtButir.Text = selectedRow.Cells(1).Text.ToString
                txtMaj.Text = selectedRow.Cells(2).Text.ToString
                txtPek.Text = selectedRow.Cells(3).Text.ToString
                ViewState("SaveMode") = "2"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "ShowPopup('2');", True)

            ElseIf e.CommandName = "DeleteRow" Then
                ViewState("SaveMode") = "3"
                Dim jenis As String = selectedRow.Cells(0).Text.ToString

                'If fCheckMaster(jenis) = False Then
                strSql = "delete from SMKB_Gaji_Kwsp where kod = '" & jenis & "'"
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

                'Else

                'lblModalMessaage.Text = "Rekod tidak dapat dipadam! Terdapat rekod potongan ini dalam master gaji!" 'message di modal
                'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                'End If

            End If
        Catch ex As Exception

        End Try
    End Sub
    Private Sub lbtnSave_Click(sender As Object, e As EventArgs) Handles lbtnSave.ServerClick
        Dim strSql As String
        Dim dbconn As New DBKewConn
        Try
            Dim strKod As String = Trim(txtJenis.Text.TrimEnd)
            Dim strButir As String = Trim(txtButir.Text.ToUpper.TrimEnd)
            Dim strMaj As String = Trim(txtMaj.Text.ToUpper.TrimEnd)
            Dim strPek As String = Trim(txtPek.Text.ToUpper.TrimEnd)
            Dim message As String = ""
            Dim isave As String = hdnSave.Text

            If strKod = "" Then
                message = "Sila masukkan Kod!"
                ClientScript.RegisterStartupScript([GetType](), "alert", "notification('" + message + "');", True)
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "ShowPopup('1');", True)
                Exit Sub
            End If

            If isave = "1" Then
                strSql = "select count(*) from SMKB_Gaji_Kwsp where Kod = '" & strKod & "'"
                If fCheckRec(strSql) > 0 Then

                    message = "Rekod tidak disimpan. Kod kwsp ini telah wujud."
                    ClientScript.RegisterStartupScript([GetType](), "alert", "notification('" + message + "');", True)
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "ShowPopup('1');", True)
                    Exit Sub
                Else

                    strSql = "insert into SMKB_Gaji_Kwsp (Kod , Butiran, Kwsp_Maj, Kwsp_Pek) values (@Kod,@Butiran,@Maj,@Pek)"
                    Dim paramSql() As SqlParameter = {
                        New SqlParameter("@Kod", strKod),
                        New SqlParameter("@Butiran", strButir),
                        New SqlParameter("@Maj", strMaj),
                        New SqlParameter("@Pek", strPek)
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
                End If

            Else

                'lblModalMessaage.Text = "Ralat!Jenis trans telah wujud!" 'message di modal
                'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                strSql = "UPDATE SMKB_Gaji_Kwsp SET Butiran=@Butir, Kwsp_Maj=@Maj,Kwsp_Pek=@Pek WHERE Kod=@Kod"

                Dim paramSql() As SqlParameter = {
                                New SqlParameter("@Butir", strButir),
                                New SqlParameter("@Maj", strMaj),
                                New SqlParameter("@Pek", strPek),
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
End Class