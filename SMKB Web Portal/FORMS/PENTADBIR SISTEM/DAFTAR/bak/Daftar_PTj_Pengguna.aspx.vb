Public Class Daftar_PTj_Pengguna
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            sLoadDdlStaf()
            fClearGvPTj()
            fClearGvPTjSel()
        End If
    End Sub

    Private Sub lbtnCari_Click(sender As Object, e As EventArgs) Handles lbtnCari.Click

        fLoadGvPTjSel() 'Load PTj yang telah didaftarkan dahulu
        fLoadGvPTj() 'Kemudian load semua PTj
    End Sub

    Private Sub sLoadDdlStaf()
        Try
            Dim strSql As String = "select MS01_NoStaf, (MS01_NoStaf + ' - ' + MS01_Nama) as Nama from MS01_Peribadi A
where  A.MS01_Status = 1
order by A.MS01_Nama"


            Dim ds As New DataSet
            Dim dbconn As New DBSMConn
            Dim dt As New DataTable
            ds = dbconn.fselectCommand(strSql)

            ddlStaf.DataSource = ds
            ddlStaf.DataTextField = "Nama"
            ddlStaf.DataValueField = "MS01_NoStaf"
            ddlStaf.DataBind()

            ddlStaf.Items.Insert(0, New ListItem("- SILA PILIH - ", "0"))
            ddlStaf.SelectedValue = 0


        Catch ex As Exception

        End Try
    End Sub

    Private Sub fClearGvPTj()
        Try
            gvPTj.DataSource = New List(Of String)
            gvPTj.DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub fClearGvPTjSel()
        Try
            gvPTjSel.DataSource = New List(Of String)
            gvPTjSel.DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub fLoadGvPTj()
        Dim intRec As Integer = 0
        Dim strSql As String
        fClearGvPTj()

        Try

            strSql = "select KodPTJ, Butiran as ButPTj from MK_PTJ where KodKategoriPTJ = 'P' and Status = 1"

            Dim ds As New DataSet
            Dim dbconn As New DBKewConn
            ds = dbconn.fSelectCommand(strSql)

            If Not ds Is Nothing Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Dim dtPTj As DataTable = ds.Tables(0)
                    gvPTj.DataSource = dtPTj
                    gvPTj.DataBind()
                    ViewState("dtPTj") = dtPTj
                End If
            End If

            'Semak PTj yang sudah dipilih dalam senarai
            If gvPTjSel.Rows.Count > 0 Then
                For Each gvRow As GridViewRow In gvPTj.Rows
                    Dim strKodPTjSel As String = TryCast(gvRow.FindControl("lblKodPTj"), Label).Text
                    Dim chkSel As CheckBox = DirectCast(gvRow.FindControl("cbSelect"), CheckBox)

                    For Each gvRow2 As GridViewRow In gvPTjSel.Rows
                        Dim strKodPTj As String = TryCast(gvRow2.FindControl("lblKodPTj"), Label).Text

                        If strKodPTj = strKodPTjSel Then
                            chkSel.Enabled = False
                            chkSel.Checked = True
                            gvRow.ForeColor = Drawing.Color.Blue
                        End If
                    Next
                Next
            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub fLoadGvPTjSel()
        Dim intRec As Integer = 0
        Dim strSql As String
        fClearGvPTjSel()
        Try

            strSql = "select PTJ as KodPTJ, (Select Butiran from MK_PTJ B where B.KodPTJ = PTJ) as ButPTj from MK_PowerPTJ where NoStaf = '" & Trim(ddlStaf.SelectedValue.TrimEnd) & "'"

            Dim ds As New DataSet
            Dim dbconn As New DBKewConn
            ds = dbconn.fSelectCommand(strSql)

            If Not ds Is Nothing Then
                ' If ds.Tables(0).Rows.Count > 0 Then
                Dim dtPTjSel As DataTable = ds.Tables(0)

                    gvPTjSel.DataSource = dtPTjSel
                    gvPTjSel.DataBind()

                    ViewState("dtPTjSel") = dtPTjSel
                    'End If
                End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub lbtnTambah_Click(sender As Object, e As EventArgs) Handles lbtnTambah.Click
        Try
            Dim dtPTjSel As New DataTable
            dtPTjSel = TryCast(ViewState("dtPTjSel"), DataTable)

            For Each gvRow As GridViewRow In gvPTj.Rows
                Dim chkSel As CheckBox = DirectCast(gvRow.FindControl("cbSelect"), CheckBox)
                If chkSel.Checked = True Then
                    Dim strKodPTj As String = TryCast(gvRow.FindControl("lblKodPTj"), Label).Text
                    Dim strButiran As String = Server.HtmlDecode(TryCast(gvRow.FindControl("lblPTj"), Label).Text)

                    Dim foundRows As DataRow()
                    foundRows = dtPTjSel.Select("KodPTJ='" & strKodPTj & "'")

                    If foundRows.Count = 0 Then
                        Dim row As DataRow = dtPTjSel.NewRow
                        row.Item("KodPTJ") = strKodPTj
                        row.Item("ButPTj") = strButiran

                        dtPTjSel.Rows.Add(row)

                        chkSel.Enabled = False
                        gvRow.ForeColor = Drawing.Color.Blue
                    End If
                End If
            Next

            Dim dataView As New DataView(dtPTjSel)
            dataView.Sort = " KodPTJ ASC"
            dtPTjSel = dataView.ToTable()

            gvPTjSel.DataSource = dtPTjSel
            gvPTjSel.DataBind()

            ViewState("dtPTjSel") = dtPTjSel

        Catch ex As Exception

        End Try
    End Sub

    Private Sub gvPTjSel_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvPTjSel.RowDeleting


        Try
            Dim index As Integer = Convert.ToInt32(e.RowIndex)
            Dim selectedRow As GridViewRow = gvPTjSel.Rows(index)

            Dim strKodPTjSel As String = Trim(CType(selectedRow.FindControl("lblKodPTj"), Label).Text.TrimEnd)

            Dim dtPTjSel As New DataTable
            If Not ViewState("dtPTjSel") Is Nothing Then
                dtPTjSel = TryCast(ViewState("dtPTjSel"), DataTable)
            Else
                Exit Sub
            End If

            Dim foundRows As DataRow()
            foundRows = dtPTjSel.Select("KodPTJ='" & strKodPTjSel & "'")
            If foundRows.Count > 0 Then
                foundRows(0).Delete()

                For Each gvRow As GridViewRow In gvPTj.Rows
                    Dim chkSel As CheckBox = DirectCast(gvRow.FindControl("cbSelect"), CheckBox)
                    If chkSel.Checked = True Then
                        Dim strKodPTj As String = TryCast(gvRow.FindControl("lblKodPTj"), Label).Text

                        If strKodPTj = strKodPTjSel Then
                            chkSel.Enabled = True
                            chkSel.Checked = False
                            gvRow.ForeColor = Drawing.Color.Black
                        End If
                    End If
                Next

                gvPTjSel.DataSource = dtPTjSel
                gvPTjSel.DataBind()
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub lbtnSimpan_Click(sender As Object, e As EventArgs) Handles lbtnSimpan.Click
        Dim blnSuccess As Boolean = True
        Dim strSql As String
        Dim dbconn As New DBKewConn
        Dim strMsg As String
        Dim intTrackNo As Integer
        Try
            Dim strNoStaf As String = Trim(ddlStaf.SelectedValue.TrimEnd)

            Dim dtPTjSel As New DataTable
            If Not ViewState("dtPTjSel") Is Nothing Then
                dtPTjSel = TryCast(ViewState("dtPTjSel"), DataTable)
            Else
                Exit Sub
            End If

            dbconn.sConnBeginTrans()

            strSql = "select count(*) from MK_PowerPTJ where NoStaf = '" & strNoStaf & "'"
            If dbconn.fSelectCount(strSql) > 0 Then
                strSql = "delete from MK_PowerPTJ where NoStaf = '" & strNoStaf & "'"

                intTrackNo = 1
                If Not dbconn.fUpdateCommand(strSql) > 0 Then
                    blnSuccess = False
                    Exit Try
                End If
            End If

            intTrackNo = 2
            For Each row As DataRow In dtPTjSel.Rows
                intTrackNo = 3
                Dim strKodPTj As String = row.Item("KodPTj").ToString

                strSql = "insert into MK_PowerPTJ values ('" & strNoStaf & "','" & strKodPTj & "')"

                intTrackNo = 4
                If Not dbconn.fInsertCommand(strSql) > 0 Then
                    blnSuccess = False
                    Exit Try
                End If
            Next

        Catch ex As Exception
            blnSuccess = False
            strMsg = ex.Message.ToString
        End Try

        If blnSuccess = True Then
            dbconn.sConnCommitTrans()
            fClearGvPTj()
            fClearGvPTjSel()
            ddlStaf.SelectedIndex = 0
            fGlobalAlert("Maklumat telah disimpan!", Me.Page, Me.[GetType]())

        ElseIf blnSuccess = False Then
            dbconn.sConnRollbackTrans()
            fGlobalAlert("Ralat! Err - " & strMsg & ", TrackNo - " & intTrackNo, Me.Page, Me.[GetType]())
        End If

    End Sub
End Class