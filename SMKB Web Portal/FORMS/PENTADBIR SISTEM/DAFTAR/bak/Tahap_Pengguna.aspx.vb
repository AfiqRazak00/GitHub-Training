Imports System.Drawing
Imports System.Data.SqlClient
Public Class Tahap_Pengguna
    Inherits System.Web.UI.Page

    'Public Shared dsStaf As New DataSet
    'Public Shared dvStaf As New DataView
    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    If Not IsPostBack Then
    '        fBindDdlJabatan()
    '        fBindDdlTahap()
    '        gvStaf.DataSource = New List(Of String)
    '        gvStaf.DataBind()

    '    End If
    'End Sub
    'Private Sub fBindDdlTahap()

    '    Try

    '        Dim strSql As String = "select KodTahap, (KodTahap + ' - ' + JenTahap) As Butiran from MK_UTahap ORDER BY KodTahap"
    '        Dim ds As New DataSet
    '        Dim dbconn As New DBKewConn
    '        Dim dt As New DataTable
    '        ds = dbconn.fselectCommand(strSql)

    '        ddlTahapBaru.DataSource = ds
    '        ddlTahapBaru.DataTextField = "Butiran"
    '        ddlTahapBaru.DataValueField = "KodTahap"
    '        ddlTahapBaru.DataBind()

    '        ddlTahapBaru.Items.Insert(0, New ListItem(String.Empty, String.Empty))
    '        ddlTahapBaru.SelectedIndex = 0

    '    Catch ex As Exception
    '        'fErrorLog("Pendaftaran_Menu.aspx(fBindDdlKodModul)- " & ex.Message.ToString)
    '    End Try
    'End Sub
    'Private Sub fBindDdlJabatan()

    '    Try

    '        Dim strSql As String = "select KodPTJ, (KodPTJ + ' - ' + Singkatan) As Butiran from MK_PTJ WHERE Status='1' ORDER BY KodPTJ "
    '        Dim ds As New DataSet
    '        Dim dbconn As New DBKewConn
    '        Dim dt As New DataTable
    '        ds = dbconn.fselectCommand(strSql)

    '        ddlJabatan.DataSource = ds
    '        ddlJabatan.DataTextField = "Butiran"
    '        ddlJabatan.DataValueField = "KodPTJ"
    '        ddlJabatan.DataBind()

    '        ddlJabatan.Items.Insert(0, New ListItem(String.Empty, String.Empty))
    '        ddlJabatan.SelectedIndex = 0

    '    Catch ex As Exception
    '        'fErrorLog("Pendaftaran_Menu.aspx(fBindDdlKodModul)- " & ex.Message.ToString)
    '    End Try
    'End Sub

    'Private Sub gvStaf_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvStaf.RowDataBound

    '    Try
    '        If e.Row.RowType = DataControlRowType.DataRow Then
    '            e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(gvStaf, "Select$" & e.Row.RowIndex)
    '            e.Row.ToolTip = "Klik untuk pilih rekod ini."
    '            e.Row.ForeColor = ColorTranslator.FromHtml("#000000")
    '        End If
    '    Catch ex As Exception

    '    End Try

    'End Sub

    'Protected Sub ddlJabatan_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlJabatan.SelectedIndexChanged
    '    Try
    '        Dim strKodPejabat As String
    '        strKodPejabat = ddlJabatan.SelectedValue.ToString
    '        fBindGvStaf(strKodPejabat)
    '    Catch ex As Exception
    '        'fErrorLog("Pendaftaran_Menu.aspx(ddlKodModul_SelectedIndexChanged)- " & ex.Message.ToString)
    '    End Try
    'End Sub

    'Private Function fBindGvStaf(strKodPejabat)

    '    Try

    '        gvStaf.DataSource = BindGvStaf(strKodPejabat)
    '        gvStaf.DataBind()

    '    Catch ex As Exception
    '        'fErrorLog(ex.ToString)
    '    End Try

    'End Function



    'Private Function BindGvStaf(ByVal strKodPejabat As String) As DataTable
    '    Dim dsStaf As New DataSet
    '    Dim dvStaf As New DataView

    '    Dim dsTahap As New DataSet
    '    Dim dvTahap As New DataView

    '    Dim intBil As Integer
    '    Dim strNoStaf As String
    '    Dim strNamaStaf As String
    '    Dim strJawatan As String
    '    Dim strTahapPengguna As String
    '    Dim strStatus As String

    '    Try
    '        strKodPejabat = strKodPejabat.Substring(0, 2)
    '        Dim strSql As String = "Select NoStaf, Nama, JawGiliran, StatusStaf from VNilaiPrestasi01 WHERE KodPejabat='" & Trim(Left(strKodPejabat, Len(strKodPejabat))) & "' AND KodKategori in ('01','07','11','03','08','09','10','11','20','23') ORDER BY NoStaf"
    '        Dim dbconn As New DBSMConn
    '        Dim dt As New DataTable
    '        dsStaf = dbconn.fselectCommand(strSql)
    '        dvStaf = New DataView(dsStaf.Tables(0))

    '        Dim strStaffId As String
    '        Dim strStaff As String
    '        For i As Integer = 0 To dsStaf.Tables(0).Rows.Count - 1
    '            strStaffId = dsStaf.Tables(0).Rows(i)("NoStaf").ToString
    '            strStaff = strStaff & ",'" & strStaffId & "'"
    '        Next
    '        strStaff = strStaff.Remove(0, 1)

    '        Dim strSql2 As String = "SELECT MK_UTahapDT.KodTahap, MK_UTahap.JenTahap, MK_UTahapDT.NoStaf FROM MK_UTahap INNER JOIN MK_UTahapDT ON MK_UTahap.KodTahap = MK_UTahapDT.KodTahap WHERE NoStaf in (" & strStaff & ")"
    '        Dim dbconn2 As New DBKewConn
    '        Dim dt2 As New DataTable
    '        dsTahap = dbconn2.fselectCommand(strSql2)
    '        dvTahap = New DataView(dsTahap.Tables(0))

    '        Dim ds As New DataSet
    '        Dim dt3 As New DataTable
    '        Dim dcBil = New DataColumn("Bil", GetType(Int32))
    '        Dim dcNoStaf = New DataColumn("NoStaf", GetType(String))
    '        Dim dcNamaStaf = New DataColumn("NamaStaf", GetType(String))
    '        Dim dcJawatan = New DataColumn("Jawatan", GetType(String))
    '        Dim dcTahapPengguna = New DataColumn("TahapPengguna", GetType(String))
    '        Dim dcStatus = New DataColumn("Status", GetType(String))

    '        dt3.Columns.Add(dcBil)
    '        dt3.Columns.Add(dcNoStaf)
    '        dt3.Columns.Add(dcNamaStaf)
    '        dt3.Columns.Add(dcJawatan)
    '        dt3.Columns.Add(dcTahapPengguna)
    '        dt3.Columns.Add(dcStatus)

    '        For i As Integer = 0 To dsStaf.Tables(0).Rows.Count - 1
    '            intBil = intBil + 1
    '            strNoStaf = dsStaf.Tables(0).Rows(i)("NoStaf").ToString
    '            With dvTahap
    '                .RowFilter = "NoStaf = '" & strNoStaf & "'"
    '            End With

    '            If (dvTahap.Count() > 0) Then
    '                strTahapPengguna = dvTahap.Item(0)("JenTahap").ToString
    '            Else
    '                strTahapPengguna = String.Empty
    '            End If


    '            strNamaStaf = dsStaf.Tables(0).Rows(i)("Nama").ToString
    '                strJawatan = dsStaf.Tables(0).Rows(i)("JawGiliran").ToString

    '            strStatus = dsStaf.Tables(0).Rows(i)("StatusStaf").ToString
    '                If strStatus = "True" Then
    '                    strStatus = "Aktif"
    '                Else
    '                    strStatus = "Tidak Aktif"
    '                End If
    '                dt3.Rows.Add(intBil, strNoStaf, strNamaStaf, strJawatan, strTahapPengguna, strStatus)

    '        Next

    '        ViewState("dtLst") = dt3
    '        Return dt3
    '    Catch ex As Exception

    '    End Try
    'End Function

    'Protected Sub gvStaf_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvStaf.Sorting
    '    Try

    '        Dim sortingDirection As String = String.Empty
    '        If direction = SortDirection.Ascending Then
    '            direction = SortDirection.Descending
    '            sortingDirection = "Desc"
    '        Else
    '            direction = SortDirection.Ascending
    '            sortingDirection = "Asc"
    '        End If
    '        Dim strKodPejabat As String
    '        strKodPejabat = Trim(ddlJabatan.SelectedValue.ToString.TrimEnd)
    '        Dim sortedView As New DataView(BindGvStaf(strKodPejabat))
    '        sortedView.Sort = Convert.ToString(e.SortExpression + " ") & sortingDirection
    '        Session("SortedView") = sortedView
    '        gvStaf.DataSource = sortedView
    '        gvStaf.DataBind()

    '    Catch ex As Exception
    '        'fErrorLog(ex.Message.ToString)
    '    End Try
    'End Sub

    'Public Property direction() As SortDirection
    '    Get
    '        If ViewState("directionState") Is Nothing Then
    '            ViewState("directionState") = SortDirection.Ascending
    '        End If
    '        Return DirectCast(ViewState("directionState"), SortDirection)
    '    End Get
    '    Set
    '        ViewState("directionState") = Value
    '    End Set
    'End Property

    'Protected Sub gvStaf_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvStaf.PageIndexChanging
    '    Try

    '        gvStaf.PageIndex = e.NewPageIndex
    '        If Session("SortedView") IsNot Nothing Then
    '            gvStaf.DataSource = Session("SortedView")
    '            gvStaf.DataBind()
    '        Else
    '            Dim dt As New DataTable
    '            Dim strKodPejabat As String
    '            strKodPejabat = Trim(ddlJabatan.SelectedValue.ToString.TrimEnd)
    '            dt = BindGvStaf(strKodPejabat)
    '            gvStaf.DataSource = dt
    '            gvStaf.DataBind()
    '        End If

    '    Catch ex As Exception
    '        'fErrorLog(ex.Message.ToString)
    '    End Try
    'End Sub

    'Protected Sub gvStaf_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvStaf.SelectedIndexChanged
    '    For Each row As GridViewRow In gvStaf.Rows
    '        If row.RowIndex = gvStaf.SelectedIndex Then

    '            row.ForeColor = ColorTranslator.FromHtml("#0000FF")
    '            row.ToolTip = String.Empty
    '        Else
    '            row.ForeColor = ColorTranslator.FromHtml("#000000")
    '            row.ToolTip = "Klik untuk pilih rekod ini."
    '        End If

    '        Dim strNamaStaf As String = gvStaf.Rows(row.RowIndex).Cells(2).Text
    '        Dim strNoStaf As String = gvStaf.Rows(row.RowIndex).Cells(1).Text
    '        Dim strTahapPengguna As String = gvStaf.Rows(row.RowIndex).Cells(4).Text.ToString
    '        If strTahapPengguna = "&nbsp;" Then
    '            strTahapPengguna = ""
    '        End If
    '        txtNamaStaf.Text = strNamaStaf
    '        txtNoStaf.Text = strNoStaf
    '        txtTahapLama.Text = strTahapPengguna

    '    Next
    'End Sub

    'Public Sub OnConfirm(sender As Object, e As EventArgs)
    '    Dim strSaveStatus As String
    '    Try
    '        strSaveStatus = fUpdateRec()
    '        If strSaveStatus = "1" Then
    '            Dim strmsg As String = "alert('Rekod ini telah dikemas kini!')"
    '            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CloseWindow", strmsg, True)
    '            fBindGvStaf(ddlJabatan.SelectedValue.ToString)
    '            txtNamaStaf.Text = ""
    '            txtNoStaf.Text = ""
    '            txtTahapLama.Text = ""
    '            ddlTahapBaru.SelectedValue = ""
    '        Else
    '            Dim strmsg As String = "alert('Rekod ini gagal dikemas kini!')"
    '            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CloseWindow", strmsg, True)
    '        End If
    '    Catch ex As Exception

    '    End Try



    'End Sub

    'Private Function fUpdateRec() As String
    '    Try
    '        Dim strSql As String
    '        Dim strNoStaf As String = Trim(txtNoStaf.Text)
    '        Dim strTahapLama As String = Trim(txtTahapLama.Text)
    '        Dim strTahapbaru As String = Trim(ddlTahapBaru.SelectedValue)
    '        Dim strConnString As String = dbKewConnStr()
    '        If strTahapLama = "" Then
    '            strSql = "Insert into MK_UTahapDT (NoStaf, KodTahap ) values (@NoStaf,@strKodTahap) "
    '            Using connection As New SqlConnection(strConnString)
    '                Dim command As New SqlCommand(strSql, connection)
    '                command.Parameters.AddWithValue("@NoStaf", strNoStaf)
    '                command.Parameters.AddWithValue("@strKodTahap", strTahapbaru)

    '                Try
    '                    connection.Open()
    '                    Dim rowsAffected As Integer = command.ExecuteNonQuery()

    '                    If rowsAffected > 0 Then
    '                        Return "1"
    '                    End If

    '                Catch ex As Exception
    '                    Console.WriteLine(ex.Message)
    '                    Return "0"
    '                End Try
    '            End Using
    '        Else
    '            strSql = "Update MK_UTahapDT set KodTahap = @strKodTahap where NoStaf = @NoStaf"
    '            Using connection As New SqlConnection(strConnString)
    '                Dim command As New SqlCommand(strSql, connection)
    '                command.Parameters.Add("@NoStaf", SqlDbType.VarChar)
    '                command.Parameters("@NoStaf").Value = strNoStaf
    '                command.Parameters.AddWithValue("@strKodTahap", strTahapbaru)

    '                Try
    '                    connection.Open()
    '                    Dim rowsAffected As Integer = command.ExecuteNonQuery()

    '                    If rowsAffected > 0 Then
    '                        Return "1"
    '                    End If

    '                Catch ex As Exception
    '                    Console.WriteLine(ex.Message)
    '                    Return "0"
    '                End Try
    '            End Using
    '        End If



    '    Catch ex As Exception
    '        Return "0"
    '    End Try
    'End Function

    'Protected Sub gvStaf_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvStaf.RowDeleting
    '    Try
    '        Dim strSql As String
    '        Dim dbconn As New DBKewConn
    '        Dim strNoStaf As String
    '        Dim row As GridViewRow = DirectCast(gvStaf.Rows(e.RowIndex), GridViewRow)
    '        strNoStaf = Trim(row.Cells(1).Text.ToString.TrimEnd)

    '        gvStaf.EditIndex = -1

    '        strSql = "delete from MK_UTahapDT where NoStaf = '" & strNoStaf & "'"
    '        If dbconn.fUpdateCommand(strSql) > 0 Then
    '            Alert("Rekod telah dipadam!")
    '            Dim strKodPejabat As String = ddlJabatan.SelectedValue.ToString
    '            fBindGvStaf(strKodPejabat)
    '        End If

    '    Catch ex As Exception
    '        'fErrorLog("Jenis_Permohonan.aspx(gvJenPermohonan_RowDeleting)- " & ex.Message.ToString)
    '    End Try
    'End Sub

    'Private Sub Alert(msg As String)
    '    Dim sb As New StringBuilder()
    '    sb.Append("alert('")
    '    sb.Append(msg.Replace(vbLf, "\n").Replace(vbCr, "").Replace("'", "\'"))
    '    sb.Append("');")
    '    ScriptManager.RegisterStartupScript(Me.Page, Me.[GetType](), "showalert", sb.ToString(), True)
    'End Sub

    'Private Sub ddlTapisan_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlTapisan.SelectedIndexChanged
    '    If ddlTapisan.SelectedValue = 0 Then
    '        txtCarian.Enabled = False
    '        txtCarian.Text = ""
    '    Else
    '        txtCarian.Enabled = True
    '    End If
    'End Sub

    'Private Sub lbtnCari_Click(sender As Object, e As EventArgs) Handles lbtnCari.Click
    '    'Dim strKodPejabat = ddlJabatan.SelectedValue.ToString
    '    'fBindGvStaf(strKodPejabat)

    '    Try
    '        Dim dtLst As New DataTable
    '        dtLst = CType(ViewState("dtLst"), DataTable)
    '        Dim dvLst As New DataView(dtLst)

    '        If ddlTapisan.SelectedValue = 1 Then
    '            dvLst.RowFilter = "NamaStaf like '%" & txtCarian.Text & "%'"

    '        ElseIf ddlTapisan.SelectedValue = 2 Then
    '            dvLst.RowFilter = "NoStaf = '" & txtCarian.Text & "'"

    '        End If

    '        gvStaf.DataSource = dvLst
    '        gvStaf.DataBind()

    '    Catch ex As Exception

    '    End Try






    'End Sub
End Class