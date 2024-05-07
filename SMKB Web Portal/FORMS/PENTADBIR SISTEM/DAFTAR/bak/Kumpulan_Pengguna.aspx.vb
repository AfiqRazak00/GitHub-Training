Imports System.Data.SqlClient
Imports System.Drawing

Public Class Kumpulan_Pengguna
    Inherits System.Web.UI.Page
    Dim dbconn As New DBKewConn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            fBindGvTahap()
            lbtnKemaskini.Visible = False
            lbtnUndo.Visible = False
        End If
    End Sub

    Private Sub fBindGvTahap()

        Dim strSql = "select KodTahap, JenTahap from MK_UTahap Order By KodTahap;"
        Using dt = fCreateDt(strSql)
            If dt.Rows.Count > 0 Then
                gvKumpPengguna.DataSource = dt
                gvKumpPengguna.DataBind()
                lblJumRekodS.Text = dt.Rows.Count
            Else
                fGlobalAlert("Tiada Rekod Dijumpai", Me.Page, Me.GetType())
            End If
        End Using
    End Sub

    Private Function fCreateDt(str As String) As DataTable
        Using dt = dbconn.fSelectCommandDt(str)
            Return dt
        End Using
    End Function

    Protected Sub lbtnReset_Click(sender As Object, e As EventArgs) Handles lbtnReset.Click
        txtJenisTahap.Text = ""
        txtKodTahap.Text = ""
    End Sub

    Protected Sub lbtnSimpan_Click(sender As Object, e As EventArgs) Handles lbtnSimpan.Click
        Try

            Dim kodTahap = txtKodTahap.Text

                Dim strSql = $"select count(*) from MK_UTahap where KodTahap = '{kodTahap}'"
            dbconn = New DBKewConn

            If dbconn.fSelectCount(strSql) > 0 Then
                    fGlobalAlert("Rekod sudah ada!. Tidak boleh buat penambahan rekod yang sama", Me.Page, Me.[GetType]())
                Else

                    strSql = "INSERT INTO MK_UTahap (KodTahap,JenTahap) VALUES (@KodTahapp, @JenisTahapp)"

                    Dim paramSql() As SqlParameter = {
                        New SqlParameter("@KodTahapp", kodTahap),
                        New SqlParameter("@JenisTahapp", txtJenisTahap.Text)
                    }

                    If dbconn.fInsertCommand(strSql, paramSql) > 0 Then
                        fGlobalAlert("Rekod baru telah disimpan!", Me.Page, Me.[GetType]())
                        lbtnReset_Click(sender, e)
                        fBindGvTahap()
                    Else
                        fGlobalAlert("Rekod tidak berjaya disimpan!", Me.Page, Me.[GetType]())
                    End If
                End If

        Catch ex As Exception
            'fErrorLog("Jenis_Permohonan.aspx(btnSave_Click)- " & ex.Message.ToString)
        End Try
    End Sub

    Protected Sub lbtnKemaskini_Click(sender As Object, e As EventArgs) Handles lbtnKemaskini.Click
        Try

            Dim kodTahap = txtKodTahap.Text

            dbconn = New DBKewConn


            Dim strSql = "Update MK_UTahap SET JenTahap=@JenTahapp WHERE KodTahap= @kodTahapp"

                Dim paramSql() As SqlParameter = {
                        New SqlParameter("@JenTahapp", txtJenisTahap.Text),
                        New SqlParameter("@kodTahapp", kodTahap)
                    }

                If dbconn.fInsertCommand(strSql, paramSql) > 0 Then
                    fGlobalAlert("Rekod baru telah dikemaskini!", Me.Page, Me.[GetType]())
                    lbtnReset_Click(sender, e)
                    fBindGvTahap()
                    lbtnUndo.Visible = False
                    lbtnKemaskini.Visible = False
                    lbtnSimpan.Visible = True
                    txtKodTahap.Enabled = False
                Else
                    fGlobalAlert("Rekod tidak berjaya dikemaskini!", Me.Page, Me.[GetType]())
                End If

        Catch ex As Exception
            'fErrorLog("Jenis_Permohonan.aspx(btnSave_Click)- " & ex.Message.ToString)
        End Try
    End Sub

    Protected Sub lbtnUndo_Click(sender As Object, e As EventArgs) Handles lbtnUndo.Click
        lbtnSimpan.Visible = True
        lbtnKemaskini.Visible = False
        lbtnUndo.Visible = False

        lbtnReset_Click(sender, e)
    End Sub

    Protected Sub gvKumpPengguna_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvKumpPengguna.SelectedIndexChanged
        Dim row = gvKumpPengguna.SelectedRow
        row.ForeColor = ColorTranslator.FromHtml("#0000FF")
                lbtnUndo.Visible = True
                lbtnKemaskini.Visible = True
                lbtnSimpan.Visible = False

                Dim KodTahap As String = Trim(row.Cells(1).Text)
                Dim jenTahap As String = Trim(row.Cells(2).Text)

                txtKodTahap.Text = KodTahap
                txtJenisTahap.Text = jenTahap
        txtKodTahap.Enabled = False
    End Sub

    Protected Sub gvKumpPengguna_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvKumpPengguna.RowDeleting
        Try
            Dim row As GridViewRow = DirectCast(gvKumpPengguna.Rows(e.RowIndex), GridViewRow)
            Dim KodTahap = Trim(row.Cells(1).Text)
            dbconn = New DBKewConn

            If KodTahap IsNot String.Empty Then
                Dim strSql = $"delete from MK_UTahap where KodTahap='{KodTahap}'"
                If dbconn.fUpdateCommand(strSql) > 0 Then
                    fGlobalAlert("Rekod Butiran telah dipadam!", Me.Page, Me.[GetType]())
                End If
            End If

            fBindGvTahap()

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub gvKumpPengguna_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvKumpPengguna.Sorting
        Dim strSql = "select KodTahap, JenTahap from MK_UTahap Order By KodTahap;"
        Dim sortedView As New DataView(fCreateDt(strSql))
        sortedView.Sort = e.SortExpression & " " & GetSortDirection(e.SortExpression)
        Session("SortedView2") = sortedView
        gvKumpPengguna.DataSource = sortedView
        gvKumpPengguna.DataBind()
    End Sub

    Protected Sub gvKumpPengguna_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvKumpPengguna.PageIndexChanging
        gvKumpPengguna.PageIndex = e.NewPageIndex

        If Session("SortedView2") IsNot Nothing Then
            gvKumpPengguna.DataSource = Session("SortedView2")
            gvKumpPengguna.DataBind()
        Else
            fBindGvTahap()
        End If
    End Sub

    Protected Sub ddlSaizRekod_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSaizRekod.SelectedIndexChanged
        gvKumpPengguna.PageSize = CInt(ddlSaizRekod.SelectedValue)
        fBindGvTahap()

    End Sub

    Private Function GetSortDirection(ByVal column As String) As String

        ' By default, set the sort direction to ascending.
        Dim sortDirection = "ASC"

        ' Retrieve the last column that was sorted.
        Dim sortExpression = TryCast(ViewState("SortExpression"), String)

        If sortExpression IsNot Nothing Then
            ' Check if the same column is being sorted.
            ' Otherwise, the default value can be returned.
            If sortExpression = column Then
                Dim lastDirection = TryCast(ViewState("SortDirection"), String)
                If lastDirection IsNot Nothing AndAlso lastDirection = "ASC" Then
                    sortDirection = "DESC"
                End If
            End If
        End If

        ' Save new values in ViewState.
        ViewState("SortDirection") = sortDirection
        ViewState("SortExpression") = column

        Return sortDirection

    End Function
End Class