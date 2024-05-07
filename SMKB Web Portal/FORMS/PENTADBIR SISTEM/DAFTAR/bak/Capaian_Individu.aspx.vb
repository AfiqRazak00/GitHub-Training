Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Globalization

Public Class Capaian_Individu
    Inherits System.Web.UI.Page


    Dim dbconn As New DBKewConn

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                fBindDdlKodModul()
                ddlKodModul.Items.Insert(0, "-SILA PILIH-")
                ddlKodModul.SelectedIndex = 0

                fbindDdlFungsi()
                fBindDDLJenisCapaian()

                fBindGvTahap(0)

                lbtnKemaskini.Visible = False
                lbtnUndo.Visible = False
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub fbindDdlFungsi()
        ddlFungsi.Items.Insert(0, New ListItem("-SILA PILIH-", ""))
        ddlFungsi.Items.Insert(1, New ListItem("R - BACA SAHAJA", "R"))
        ddlFungsi.Items.Insert(2, New ListItem("W - BACA & TULIS", "W"))
        ddlFungsi.SelectedIndex = 0
    End Sub

    Private Sub fBindDdlKodModul()
        Dim strSql As String = "Select KodModul, DisModul, (KodModul + ' - ' + DisModul) as Butiran From MK_UModul ORDER BY KODMODUL"
        Using dt = dbconn.fSelectCommandDt(strSql)
            ddlKodModul.DataSource = dt
            ddlKodModul.DataTextField = "Butiran"
            ddlKodModul.DataValueField = "KodModul"
            ddlKodModul.DataBind()

            ddlKodModul.Items.Insert(0, New ListItem("- SILA PILIH - ", ""))
            ddlKodModul.SelectedIndex = 0
        End Using
    End Sub
    Private Sub fBindDdlKodSubModul(ByVal strKodModul As String)
        Dim strSql As String = "select KodSub, DisSub, (KodSub + ' - ' + DisSub) as Butiran From MK_USubModul WHERE kodModul = '" & strKodModul & "' and status = 'true' ORDER BY Urutan"
        Using dt = dbconn.fSelectCommandDt(strSql)

            ddlKodSubModul.DataSource = dt
            ddlKodSubModul.DataTextField = "Butiran"
            ddlKodSubModul.DataValueField = "KodSub"
            ddlKodSubModul.DataBind()
        End Using
    End Sub

    Protected Sub ddlKodModul_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlKodModul.SelectedIndexChanged
        fBindDdlKodSubModul(ddlKodModul.SelectedValue)
        ddlKodSubModul.Items.Insert(0, New ListItem("-SILA PILIH-", String.Empty))
        ddlKodSubModul.SelectedIndex = 0
    End Sub

    Protected Sub ddlKodSubModul_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlKodSubModul.SelectedIndexChanged
        fBindDdlKodSubMenu(ddlKodSubModul.SelectedValue)
        ddlKodSubMenu.Items.Insert(0, New ListItem("-SILA PILIH-", String.Empty))
        ddlKodSubMenu.SelectedIndex = 0
    End Sub

    Private Sub fBindDdlKodSubMenu(strKodSubModul As String)


        Dim strSql As String = $"select KodSubMenu, (KodSubMenu + ' - ' + NamaSubMenu) AS Butiran from MK_USubMenu WHERE KodSub='{strKodSubModul}' AND Status ='True' ORDER BY KodSubMenu"

        Using dt = dbconn.fSelectCommandDt(strSql)

            ddlKodSubMenu.DataSource = dt
            ddlKodSubMenu.DataTextField = "Butiran"
            ddlKodSubMenu.DataValueField = "KodSubMenu"
            ddlKodSubMenu.DataBind()
        End Using


    End Sub

    Private Sub fBindDDLJenisCapaian()
        ddlJenisCapaian.Items.Insert(0, New ListItem("-SILA PILIH-", ""))
        ddlJenisCapaian.Items.Insert(1, New ListItem("L - TERHAD", "L"))
        ddlJenisCapaian.Items.Insert(2, New ListItem("U - TIADA HAD", "U"))
        ddlJenisCapaian.SelectedIndex = 0
    End Sub


    Private Sub fBindGvTahap(strint As Integer)

        Dim strSql = ""
        If strint = 0 Then
            strSql = $"SELECT a.KodSubMenu, a.TkhMula, a.TkhTamat, a.JenCapai, a.Fungsi, a.nostaf, b.NamaSubMenu 
FROM MK_UProsesInd a INNER JOIN
MK_USubMenu b ON a.KodSubMenu = b.KodSubMenu 
ORDER BY a.KodSubMenu"
        Else
            strSql = $"SELECT a.KodSubMenu, a.TkhMula, a.TkhTamat, a.JenCapai, a.Fungsi, a.nostaf, b.NamaSubMenu 
FROM MK_UProsesInd a INNER JOIN
MK_USubMenu b ON a.KodSubMenu = b.KodSubMenu WHERE NoStaf = '{txtNoStaf.Text.Trim}'
ORDER BY a.KodSubMenu"
        End If

        Using dt = fCreateDt(strSql)
            If dt.Rows.Count = 0 Then
                fGlobalAlert("Tiada Rekod Dijumpai", Me.Page, Me.GetType())
            End If

            gvTahapPengguna.DataSource = dt
            gvTahapPengguna.DataBind()
        End Using
    End Sub

    Private Function fCreateDt(str As String) As DataTable
        Using dt = dbconn.fSelectCommandDt(str)
            lblJumRekodS.Text = dt.Rows.Count
            Return dt
        End Using
    End Function


    Protected Sub gvTahapPengguna_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvTahapPengguna.RowDeleting
        Try
            Dim strSql As String
            dbconn = New DBKewConn
            Dim strKodSubMenu As String
            Dim nostaf As String = txtNoStaf.Text.Trim

            Dim row As GridViewRow = DirectCast(gvTahapPengguna.Rows(e.RowIndex), GridViewRow)
            strKodSubMenu = row.Cells(1).Text.ToString

            gvTahapPengguna.EditIndex = -1

            strSql = $"delete from MK_UProsesInd WHERE nostaf='{ nostaf }' AND KodSubMenu ='{strKodSubMenu}'"
            If dbconn.fUpdateCommand(strSql) > 0 Then
                fGlobalAlert("Rekod telah dipadam!", Me.Page, Me.[GetType]())
                fBindGvTahap(1)
            End If

            lbtnReset_Click(sender, e)
        Catch ex As Exception
            'fErrorLog("Jenis_Permohonan.aspx(gvJenPermohonan_RowDeleting)- " & ex.Message.ToString)
        End Try
    End Sub



    Protected Sub gvTahapPengguna_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvTahapPengguna.SelectedIndexChanged
        Try

        Catch ex As Exception

        End Try
        Dim row = gvTahapPengguna.SelectedRow
        lbtnUndo.Visible = True
        lbtnKemaskini.Visible = True
        lbtnSimpan.Visible = False
        Dim nostaf As String = row.Cells(3).Text
        Dim KodSubMenu As String = row.Cells(1).Text
        Dim TarikhMula As String = row.Cells(5).Text
        Dim TarikhHingga As String = row.Cells(6).Text
        Dim JenCapai As String = CType(row.Cells(4).FindControl("lblJnsCapaian"), Label).Text 'row.Cells(4).ToString.Substring(0, 1)
        Dim ButiranFungsi As String = CType(row.Cells(7).FindControl("lblFungsi"), Label).Text '.Cells(7).ToString.Substring(0, 1)
        Dim kodFungsi = ButiranFungsi.Substring(0, ButiranFungsi.IndexOf(" ")).Trim
        Dim KodJnsCapai = Left(JenCapai, 1)

        If KodJnsCapai.Equals("L") Then
            txtStartDate.Text = TarikhMula
            txtEndDate.Text = TarikhHingga
            trTarikh.Visible = True
            rfvTarikhMula.Enabled = True
            rfvTarikhAkhir.Enabled = True

        Else
            txtStartDate.Text = ""
            txtEndDate.Text = ""
            trTarikh.Visible = False
            rfvTarikhMula.Enabled = False
            rfvTarikhAkhir.Enabled = False
        End If

        Dim KodSubModul = KodSubMenu.Substring(0, 4)
        Dim KodModul = KodSubMenu.Substring(0, 2)

        ddlJenisCapaian.SelectedValue = KodJnsCapai
        ddlFungsi.SelectedValue = kodFungsi

        ddlKodModul.SelectedValue = KodModul

        fBindDdlKodSubModul(KodModul)
        If ddlKodSubModul.Items.FindByValue(KodSubModul) IsNot Nothing Then
            ddlKodSubModul.SelectedValue = KodSubModul
        Else
            fGlobalAlert("Tiada data untuk kodsubmodul: " + KodSubModul, Me.Page, Me.[GetType]())
        End If

        fBindDdlKodSubMenu(KodSubModul)
        If ddlKodSubMenu.Items.FindByValue(KodSubMenu) IsNot Nothing Then
            ddlKodSubMenu.SelectedValue = KodSubMenu
        Else
            fGlobalAlert("Tiada data untuk KodSubMenu: " + KodSubMenu, Me.Page, Me.[GetType]())
        End If


    End Sub

    Protected Sub lbtnSimpan_Click(sender As Object, e As EventArgs) Handles lbtnSimpan.Click
        Try
            Page.Validate()
            If Page.IsValid Then

                Dim noStaf As String = txtNoStaf.Text.Trim
                Dim kodSubMenu = ddlKodSubMenu.SelectedValue

                Dim strSql = $"select select * from MK_UProsesInd WHERE NoStaf='{ noStaf }' AND KodSubMenu ='{kodSubMenu}'"
                dbconn = New DBKewConn
                If dbconn.fSelectCount(strSql) > 0 Then
                    fGlobalAlert("Rekod sudah ada!. Tidak boleh buat penambahan rekod yang sama", Me.Page, Me.[GetType]())
                Else
                    Dim strJenisCapaian = ddlJenisCapaian.SelectedValue
                    Dim strFungsi = ddlFungsi.SelectedValue
                    Dim startDate As DateTime, endDate As DateTime
                    Dim paramSql() As SqlParameter
                    strSql = $"INSERT INTO MK_UProsesInd VALUES (@Kodsubmenuu,@NoStaff,@StartDatee,@EndDatee,@JenisCapaiann,@Fungsii)"

                    If strJenisCapaian.Equals("L") Then
                        startDate = DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", New CultureInfo("en-US"))
                        endDate = DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", New CultureInfo("en-US"))

                        '"select [KodSubMenu],[TkhMula],[TkhTamat],[KodTahap],[JenCapai],[Fungsi] From [DbKewanganV2].[dbo].[MK_UProsesKump]

                        paramSql = {
                            New SqlParameter("@Kodsubmenuu", ddlKodSubMenu.SelectedValue),
                            New SqlParameter("@NoStaff", noStaf),
                            New SqlParameter("@JenisCapaiann", strJenisCapaian),
                            New SqlParameter("@Fungsii", strFungsi),
                            New SqlParameter("@StartDatee", startDate),
                            New SqlParameter("@EndDatee", endDate)
                        }
                    Else

                        paramSql = {
                            New SqlParameter("@Kodsubmenuu", ddlKodSubMenu.SelectedValue),
                            New SqlParameter("@NoStaff", noStaf),
                            New SqlParameter("@JenisCapaiann", strJenisCapaian),
                            New SqlParameter("@Fungsii", strFungsi),
                            New SqlParameter("@StartDatee", DBNull.Value),
                            New SqlParameter("@EndDatee", DBNull.Value)
                        }
                    End If


                    If dbconn.fInsertCommand(strSql, paramSql) > 0 Then
                        fGlobalAlert("Rekod baru telah ditambah!", Me.Page, Me.[GetType]())
                        fBindGvTahap(1)
                        lbtnReset_Click(sender, e)
                    Else
                        fGlobalAlert("Maklumat tidak berjaya disimpan!", Me.Page, Me.[GetType]())
                    End If
                End If

            End If
        Catch ex As Exception
            'fErrorLog("Jenis_Permohonan.aspx(btnSave_Click)- " & ex.Message.ToString)
        End Try
    End Sub

    Protected Sub lbtnKemaskini_Click(sender As Object, e As EventArgs) Handles lbtnKemaskini.Click
        Try
            Page.Validate()
            If Page.IsValid Then
                Dim kodSubmenu = ddlKodSubMenu.SelectedValue
                Dim strJenisCapaian = ddlJenisCapaian.SelectedValue
                Dim strSql = ""

                Dim strFungsi = ddlFungsi.SelectedValue
                Dim noStaf As String = txtNoStaf.Text.Trim
                Dim paramSql() As SqlParameter
                If strJenisCapaian.Equals("U") Then
                    strSql = $"Update MK_UProsesInd SET TkhMula=@TrkMulaa, TkhTamat=@TkhTamatt, JenCapai=@JnsCapaii, Fungsi=@Fungsii WHERE KodSubMenu= @KodSubMenus AND NoStaf=@NoStaff"
                    paramSql = {
                         New SqlParameter("@KodSubMenus", kodSubmenu),
                         New SqlParameter("@NoStaff", noStaf),
                       New SqlParameter("@JnsCapaii", strJenisCapaian),
                       New SqlParameter("@TrkMulaa", DBNull.Value),
                        New SqlParameter("@TkhTamatt", DBNull.Value),
                        New SqlParameter("@Fungsii", strFungsi)
                    }
                Else
                    Dim startDate As DateTime = DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", New CultureInfo("en-US"))
                    Dim endDate As DateTime = DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", New CultureInfo("en-US"))
                    strSql = "Update MK_UProsesInd SET TkhMula=@TrkMulaa, TkhTamat=@TkhTamatt, JenCapai=@JnsCapaii, Fungsi=@Fungsii WHERE KodSubMenu= @KodSubMenus AND NoStaf=@NoStaff"
                    paramSql = {
                        New SqlParameter("@KodSubMenus", kodSubmenu),
                        New SqlParameter("@TrkMulaa", startDate),
                        New SqlParameter("@TkhTamatt", endDate),
                        New SqlParameter("@NoStaff", noStaf),
                       New SqlParameter("@JnsCapaii", strJenisCapaian),
                        New SqlParameter("@Fungsii", strFungsi)
                    }
                End If

                Dim dbconn As New DBKewConn


                If dbconn.fInsertCommand(strSql, paramSql) > 0 Then
                    fGlobalAlert("Rekod baru telah dikemaskini!", Me.Page, Me.[GetType]())
                    fBindGvTahap(1)

                    lbtnReset_Click(sender, e)

                    lbtnUndo.Visible = False
                    lbtnKemaskini.Visible = False
                    lbtnSimpan.Visible = True

                    lbtnReset_Click(sender, e)
                Else
                    fGlobalAlert("Rekod tidak berjaya dikemaskini!", Me.Page, Me.[GetType]())
                End If
            End If
        Catch ex As Exception
            'fErrorLog("Jenis_Permohonan.aspx(btnSave_Click)- " & ex.Message.ToString)
        End Try
    End Sub

    Protected Sub lbtnUndo_Click(sender As Object, e As EventArgs) Handles lbtnUndo.Click
        lbtnSimpan.Visible = True
        lbtnKemaskini.Visible = False
        lbtnUndo.Visible = False
    End Sub

    Protected Sub lbtnReset_Click(sender As Object, e As EventArgs) Handles lbtnReset.Click
        txtStartDate.Text = Date.Now.ToString("dd/MM/yyyy")
        txtEndDate.Text = Date.Now.AddDays(1).ToString("dd/MM/yyyy")

        ddlKodSubModul.Items.Clear()
        ddlKodSubMenu.Items.Clear()
        ddlJenisCapaian.SelectedIndex = 0
        ddlFungsi.SelectedIndex = 0
        ddlKodModul.SelectedIndex = 0
    End Sub

    Protected Sub ddlJenisCapaian_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlJenisCapaian.SelectedIndexChanged
        If ddlJenisCapaian.SelectedValue = "U" Then
            trTarikh.Visible = False
            rfvTarikhMula.Enabled = False
            rfvTarikhAkhir.Enabled = False
            txtStartDate.Text = ""
            txtEndDate.Text = ""
        Else
            trTarikh.Visible = True
            rfvTarikhMula.Enabled = True
            rfvTarikhAkhir.Enabled = True
        End If
    End Sub

    Protected Sub ddlSaizRekod_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSaizRekod.SelectedIndexChanged
        gvTahapPengguna.PageSize = CInt(ddlSaizRekod.SelectedValue)
        If txtNoStaf.Text = "" Then
            fBindGvTahap(0)
        Else
            fBindGvTahap(1)
        End If

    End Sub

    Protected Sub gvTahapPengguna_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvTahapPengguna.PageIndexChanging
        gvTahapPengguna.PageIndex = e.NewPageIndex

        If Session("SortedView") IsNot Nothing Then
            gvTahapPengguna.DataSource = Session("SortedView")
            gvTahapPengguna.DataBind()
        Else
            If txtNoStaf.Text = "" Then
                fBindGvTahap(0)
            Else
                fBindGvTahap(1)
            End If
        End If
    End Sub

    Protected Sub gvTahapPengguna_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvTahapPengguna.Sorting
        Dim strsql = ""
        If txtNoStaf.Text = "" Then
            strsql = $"SELECT a.KodSubMenu, a.TkhMula, a.TkhTamat, a.JenCapai, a.Fungsi, a.nostaf, b.NamaSubMenu 
FROM MK_UProsesInd a INNER JOIN
MK_USubMenu b ON a.KodSubMenu = b.KodSubMenu 
ORDER BY a.KodSubMenu;"
        Else
            strsql = $"SELECT a.KodSubMenu, a.TkhMula, a.TkhTamat, a.JenCapai, a.Fungsi, a.nostaf, b.NamaSubMenu 
FROM MK_UProsesInd a INNER JOIN
MK_USubMenu b ON a.KodSubMenu = b.KodSubMenu WHERE NoStaf = '{txtNoStaf.Text.Trim}'
ORDER BY a.KodSubMenu;"
        End If
        Dim sortedView As New DataView(fCreateDt(strsql))
        sortedView.Sort = e.SortExpression & " " & GetSortDirection(e.SortExpression)
        Session("SortedView") = sortedView
        gvTahapPengguna.DataSource = sortedView
        gvTahapPengguna.DataBind()
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

    Protected Sub lbtnSearch_Click(sender As Object, e As EventArgs) Handles lbtnSearch.Click
        BindGridViewStaf()
        MPEStaf.Show()
    End Sub

    Protected Sub gvstaf_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvstaf.SelectedIndexChanged
        Dim row = gvstaf.SelectedRow
        Dim nostaf As String = row.Cells(1).Text.Trim
        txtNoStaf.Text = nostaf
        txtNamaStaf.Text = row.Cells(2).Text.Trim
        txtJawatan.Text = row.Cells(4).Text.Trim

        Dim strSql = $"SELECT a.KodSubMenu, a.TkhMula, a.TkhTamat, a.JenCapai, a.Fungsi, a.nostaf, b.NamaSubMenu 
FROM MK_UProsesInd a INNER JOIN
MK_USubMenu b ON a.KodSubMenu = b.KodSubMenu WHERE NoStaf = '{nostaf}'
ORDER BY a.KodSubMenu"


        Using dt = fCreateDt(strSql)
            If dt.Rows.Count = 0 Then
                fGlobalAlert("Tiada Rekod Dijumpai", Me.Page, Me.GetType())
            End If
            gvTahapPengguna.DataSource = dt
            gvTahapPengguna.DataBind()
        End Using

        MPEStaf.Hide()
    End Sub

    Protected Sub gvstaf_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvstaf.Sorting
        Dim sortedView As New DataView(fCreateDtStaf())
        sortedView.Sort = e.SortExpression & " " & GetSortDirection(e.SortExpression)
        Session("SortedView2") = sortedView
        gvstaf.DataSource = sortedView
        gvstaf.DataBind()
    End Sub

    Protected Sub gvstaf_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvstaf.PageIndexChanging
        gvstaf.PageIndex = e.NewPageIndex

        If Session("SortedView2") IsNot Nothing Then
            gvstaf.DataSource = Session("SortedView2")
            gvstaf.DataBind()
        Else
            BindGridViewStaf()
        End If
    End Sub

    Protected Sub lbtnCariStaf_Click(sender As Object, e As EventArgs) Handles lbtnCariStaf.Click
        Dim strSql = ""

        If ddlCariStaf.SelectedValue = 1 Then
            'Nama
            strSql = $"select a.MS01_NoStaf, a.MS01_Nama, c.JawGiliran , e.Pejabat, e.KodPejabat, d.MS08_Unit 
FROM MS01_Peribadi a, ms02_perjawatan b, MS_Jawatan c, MS08_Penempatan d, MS_Pejabat e
WHERE b.MS01_NoStaf = a.MS01_NoStaf AND b.ms02_jawsandang = c.KodJawatan  
AND e.KodPejabat = d.MS08_Pejabat AND d.MS01_NoStaf = a.MS01_NoStaf AND d.MS08_StaTerkini = 1 AND 
a.MS01_Nama LIKE '%{txtCariStaf.Text}%' 
ORDER BY MS01_NoStaf;"

        ElseIf ddlCariStaf.SelectedValue = 2 Then
            'No Staf
            strSql = $"select a.MS01_NoStaf, a.MS01_Nama, c.JawGiliran , e.Pejabat, e.KodPejabat, d.MS08_Unit 
FROM MS01_Peribadi a, ms02_perjawatan b, MS_Jawatan c, MS08_Penempatan d, MS_Pejabat e
WHERE b.MS01_NoStaf = a.MS01_NoStaf AND b.ms02_jawsandang = c.KodJawatan  
AND e.KodPejabat = d.MS08_Pejabat AND d.MS01_NoStaf = a.MS01_NoStaf AND d.MS08_StaTerkini = 1 AND 
a.MS01_NoStaf LIKE '{txtCariStaf.Text}%' 
ORDER BY MS01_NoStaf;"
        ElseIf ddlCariStaf.SelectedValue = 3 Then
            'Nama PTJ
            strSql = $"select a.MS01_NoStaf, a.MS01_Nama, c.JawGiliran , e.Pejabat, e.KodPejabat, d.MS08_Unit 
FROM MS01_Peribadi a, ms02_perjawatan b, MS_Jawatan c, MS08_Penempatan d, MS_Pejabat e
WHERE b.MS01_NoStaf = a.MS01_NoStaf AND b.ms02_jawsandang = c.KodJawatan  
AND e.KodPejabat = d.MS08_Pejabat AND d.MS01_NoStaf = a.MS01_NoStaf AND d.MS08_StaTerkini = 1 AND 
e.Pejabat LIKE '%{txtCariStaf.Text}%' 
ORDER BY MS01_NoStaf;"
        End If


        Dim dbSMconn As New DBSMConn
        Using dt = dbSMconn.fselectCommandDt(strSql)
            gvstaf.DataSource = dt
            gvstaf.DataBind()
            lblJumRekodPend.InnerText = dt.Rows.Count
        End Using
    End Sub


    Protected Sub ddlSaizRekodStaf_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSaizRekodStaf.SelectedIndexChanged
        gvstaf.PageSize = CInt(ddlSaizRekodStaf.SelectedValue)
        BindGridViewStaf()
    End Sub

    Private Function fCreateDtStaf() As DataTable
        Dim strSql2 = $"select a.MS01_NoStaf, a.MS01_Nama, c.JawGiliran , e.Pejabat, e.KodPejabat, d.MS08_Unit 
FROM MS01_Peribadi a, ms02_perjawatan b, MS_Jawatan c, MS08_Penempatan d, MS_Pejabat e
WHERE b.MS01_NoStaf = a.MS01_NoStaf AND b.ms02_jawsandang = c.KodJawatan  
AND e.KodPejabat = d.MS08_Pejabat AND d.MS01_NoStaf = a.MS01_NoStaf AND d.MS08_StaTerkini = 1 
ORDER BY MS01_NoStaf"
        Dim dbSMconn As New DBSMConn
        Using dt = dbSMconn.fselectCommandDt(strSql2)

            Return dt
        End Using


    End Function

    Private Sub BindGridViewStaf()

        gvstaf.DataSource = fCreateDtStaf()
        gvstaf.DataBind()
    End Sub
End Class