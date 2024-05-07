Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Globalization
Imports System.IO

Public Class Naskah_Jualan
    Inherits System.Web.UI.Page

    Private dbconn As New DBKewConn
    Public KodStatus As Int16 = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ViewState("kodsubmenu") = Request.QueryString("KodSubMenu")
            ViewState("Jenis") = Request.QueryString("Jenis")
            Dim idNJ = Request.QueryString("NoNJ")
            Dim noPO = Request.QueryString("NoPO")

            txtIdNJ.Text = idNJ

            fBindBindAll()


            If txtIdNJ.Text.Equals(String.Empty) Then
                DaftarJualan(noPO, ViewState("Jenis"))
            Else
                EditJualan(idNJ, noPO)
            End If

        End If
        'fGetJenisDok(lblNoPO1.Text)

    End Sub

    Private Sub fBindBindAll()

        Dim sqlVend = "SELECT ROC01_IDSya, ROC01_NamaSya, (ROC01_NamaSya + ' - ' + ROC01_IDSya) as Butiran2 FROM  ROC01_Syarikat
WHERE ROC01_KodAktif = '01' AND ROC01_KodLulus = '1' AND LEFT(ROC01_IDSya, 2) = 'RC' ORDER BY ROC01_NamaSya;"
        Dim sqlLesenDaftar As String = $"Select KodDaftar, (KodDaftar + ' - ' + Butiran) As Butiran2 from ROC_Daftar;"
        Dim sqlBidang As String = $"SELECT PO02_KodBidang, b.Butiran, PO02_Condition FROM PO02_NaskahJualanBidang a, ROC_Bidang b WHERE PO02_KodBidang = KodBidang AND PO02_JualanID='{txtIdNJ.Text}';"
        Dim sqlLesenGv As String = $"SELECT PO02_kodLesen, b.Butiran, PO02_Detail FROM PO02_NaskahJualanLesen a, ROC_Daftar b WHERE PO02_kodLesen = KodDaftar AND PO02_JualanID='{txtIdNJ.Text}';"
        Dim sqlLesenCIDB As String = $"SELECT PO02_KodKategori, PO02_KodKhusus, b.Butiran, PO02_Condition FROM PO02_NaskahJualanCIDB a, ROC_PengkhususanCIDB b WHERE PO02_KodKhusus = b.KodKhusus AND PO02_JualanID='{txtIdNJ.Text}';"
        Dim sqlKategoriCIDB As String = $"Select KodKategori, Butiran from ROC_KategoriCIDB;"


        Using ds = dbconn.fSelectCommand(sqlVend + sqlLesenDaftar + sqlBidang + sqlLesenGv + sqlLesenCIDB + sqlKategoriCIDB)
            Using dtVen = ds.Tables(0)
                ddlVendor.DataSource = dtVen
                ddlVendor.DataTextField = "Butiran2"
                ddlVendor.DataValueField = "ROC01_IDSya"
                ddlVendor.DataBind()

                ddlVendor.Items.Insert(0, New ListItem("SILA PILIH", String.Empty))
                ddlVendor.SelectedIndex = 0
            End Using

            Using dt = ds.Tables(1)
                ddlLesenDaftar.DataSource = dt
                ddlLesenDaftar.DataTextField = "Butiran2"
                ddlLesenDaftar.DataValueField = "KodDaftar"
                ddlLesenDaftar.DataBind()
                ddlLesenDaftar.Items.Insert(0, New ListItem("-Sila Pilih-", ""))
                ddlLesenDaftar.SelectedIndex = 0
            End Using

            Using dt = ds.Tables(2)
                dt.Columns.Add("Condition", GetType(String))
                For Each row As DataRow In dt.Rows
                    If Not IsDBNull(row("PO02_Condition")) Then
                        If row("PO02_Condition") = 0 Then
                            row("Condition") = "Terakhir"
                        ElseIf row("PO02_Condition") = 1 Then
                            row("Condition") = "Dan"
                        ElseIf row("PO02_Condition") = 2 Then
                            row("Condition") = "Atau"
                        End If
                    End If
                Next

                gvSyarikatBidang.DataSource = dt
                gvSyarikatBidang.DataBind()

                gvSyarikatBidang2.DataSource = dt
                gvSyarikatBidang2.DataBind()
            End Using

            Using dt = ds.Tables(3)
                gvLesen.DataSource = dt
                gvLesen.DataBind()

                gvLesen2.DataSource = dt
                gvLesen2.DataBind()
            End Using

            Using dt = ds.Tables(4)
                dt.Columns.Add("Condition", GetType(String))
                For Each row As DataRow In dt.Rows
                    If Not IsDBNull(row("PO02_Condition")) Then
                        If row("PO02_Condition") = 0 Then
                            row("Condition") = "Terakhir"
                        ElseIf row("PO02_Condition") = 1 Then
                            row("Condition") = "Dan"
                        ElseIf row("PO02_Condition") = 2 Then
                            row("Condition") = "Atau"
                        End If
                    End If
                Next

                GVSyarikatCIDB.DataSource = dt
                GVSyarikatCIDB.DataBind()

                gvSyarikatCIDB2.DataSource = dt
                gvSyarikatCIDB2.DataBind()

                ddlGred.Items.Insert(0, New ListItem("-Sila Pilih-", ""))
                ddlGred.SelectedIndex = 0
            End Using

            Using dt = ds.Tables(5)
                ddlKategori.DataSource = dt
                ddlKategori.DataTextField = "Butiran"
                ddlKategori.DataValueField = "KodKategori"
                ddlKategori.DataBind()

                ddlKategori.Items.Insert(0, New ListItem("-Sila Pilih-", ""))
                ddlKategori.SelectedIndex = 0
            End Using

            gvKhususCIDB.DataSource = New List(Of String)
            gvKhususCIDB.DataBind()

            gvBidang.DataSource = New List(Of String)
            gvBidang.DataBind()
        End Using
    End Sub

    Private Sub sPopulateRingkasan(KaedahPO As String)
        lblIdJualan.Text = txtIdNJ.Text
        lblNoPO.Text = lblNoPO1.Text
        lblTarikh.Text = lblTarikhNJ.Text
        lblStatus.Text = lblStatus1.Text
        lblTujuan.Text = lblTujuan1.Text
        lblKategoriPO.Text = lblKategoriPO1.Text
        lblHargaNskh.Text = txtHrgNskh.Text
        lblPTJ1.Text = lblPTjMohon.Text
        lblTrkMulaIklan.Text = txtTrkMulaIklan.Text
        lblTrkMulaPO.Text = txtTrkMulaPO.Text
        lblTrkTmtPO.Text = txtTrkTamatPO.Text
        txtRingArahan.Text = txtSyarat.Text
        txtMasaMulaIklan2.Text = txtMasaMulaIklan.Text
        txtMasaMulaPO2.Text = txtMasaMulaPO.Text
        txtMasaTmtPO2.Text = txtMasaTamatPO.Text
        lblGred1.Text = ddlGred.SelectedValue

        If rbLawTpk.SelectedValue = 1 Then
            trLawatanTapak2.Visible = True
            lblTrkLawatan.Text = txtTrkLawTpk.Text
            txtMasaLawatan2.Text = txtMasaLawTpk.Text
            lblTmptTpt.Text = txtTmptTapak.Text
        Else
            trLawatanTapak2.Visible = False
        End If

        lblNoSHTD.Text = txtNoSHTD.Text

        If KaedahPO.Equals("P01") Then
            'trTeknikalTitle.Visible = False
            trTeknikalScope.Visible = False
            'trNoSHTD2.Visible = False
            lblKaedah.Text = "PEMBELIAN TERUS"
        Else
            trTeknikalScope.Visible = True
            lblScope.Text = lblScope1.Text

            If KaedahPO.Equals("P03") Then
                lblKaedah.Text = "SEBUT HARGA"
                trVendor.Visible = True
            ElseIf KaedahPO.Equals("P02") Then
                lblKaedah.Text = "TENDER"
                trVendor.Visible = True
            ElseIf KaedahPO.Equals("P04") Then
                lblKaedah.Text = "SEBUT HARGA PTJ"
            End If
        End If



    End Sub

    Private Sub fBindDdlLesenDaftar()

        Dim strSql As String = $"Select KodDaftar, (KodDaftar + ' - ' + Butiran) As Butiran2 from ROC_Daftar"

            Dim ds As New DataSet
            ds = dbconn.fselectCommand(strSql)

            ddlLesenDaftar.DataSource = ds
            ddlLesenDaftar.DataTextField = "Butiran2"
            ddlLesenDaftar.DataValueField = "KodDaftar"
        ddlLesenDaftar.DataBind()
    End Sub

    Private Sub fBindDdlBidangUtama()
        Try
            Dim strSql As String = "Select Kod, (Kod + ' - ' + Butiran) As Butiran2 from ROC_BidangUtama"

            Dim ds As New DataSet
            ds = dbconn.fselectCommand(strSql)

            ddlBidangUtama.DataSource = ds
            ddlBidangUtama.DataTextField = "Butiran2"
            ddlBidangUtama.DataValueField = "Kod"
            ddlBidangUtama.DataBind()

            ddlBidangUtama.Items.Insert(0, New ListItem("-Sila Pilih-", ""))
            ddlBidangUtama.SelectedIndex = 0
            'ddlLesenDaftar.Items.Insert(0, New ListItem("-KESELURUHAN-", ""))
            'ddlLesenDaftar.SelectedIndex = 5
        Catch ex As Exception
            'fErrorLog("Peruntukan_KW.aspx(fBindDdlKW)- " & ex.Message.ToString)
        End Try
    End Sub


    Private Sub fBindGVSyarikatBidang()
        Dim strSql As String = $"SELECT PO02_KodBidang, b.Butiran, PO02_Condition FROM PO02_NaskahJualanBidang a, ROC_Bidang b WHERE PO02_KodBidang = KodBidang AND PO02_JualanID='{txtIdNJ.Text}'"

        Dim ds As New DataSet
        ds = dbconn.fselectCommand(strSql)
        ds.Tables(0).Columns.Add("Condition", GetType(String))
        For Each row As DataRow In ds.Tables(0).Rows
            If Not IsDBNull(row("PO02_Condition")) Then
                If row("PO02_Condition") = 0 Then
                    row("Condition") = "Terakhir"
                ElseIf row("PO02_Condition") = 1 Then
                    row("Condition") = "Dan"
                ElseIf row("PO02_Condition") = 2 Then
                    row("Condition") = "Atau"
                End If
            End If

        Next

        gvSyarikatBidang.DataSource = ds
        gvSyarikatBidang.DataBind()

        gvSyarikatBidang2.DataSource = ds
        gvSyarikatBidang2.DataBind()

    End Sub



    Private Sub fBindGVSyarikatCIDB()
        Dim strSql As String = $"SELECT PO02_KodKategori, PO02_KodKhusus, b.Butiran, PO02_Condition FROM PO02_NaskahJualanCIDB a, ROC_PengkhususanCIDB b WHERE PO02_KodKhusus = b.KodKhusus AND PO02_JualanID='{txtIdNJ.Text}'"

        Dim ds As New DataSet
        ds = dbconn.fselectCommand(strSql)
        ds.Tables(0).Columns.Add("Condition", GetType(String))
        For Each row As DataRow In ds.Tables(0).Rows
            If Not IsDBNull(row("PO02_Condition")) Then
                If row("PO02_Condition") = 0 Then
                    row("Condition") = "Terakhir"
                ElseIf row("PO02_Condition") = 1 Then
                    row("Condition") = "Dan"
                ElseIf row("PO02_Condition") = 2 Then
                    row("Condition") = "Atau"
                End If
            End If
        Next

        GVSyarikatCIDB.DataSource = ds
        GVSyarikatCIDB.DataBind()

        gvSyarikatCIDB2.DataSource = ds
        gvSyarikatCIDB2.DataBind()
    End Sub

    Private Sub fBindGVLesen()
        Dim strSql As String = $"SELECT PO02_kodLesen, b.Butiran, PO02_Detail FROM PO02_NaskahJualanLesen a, ROC_Daftar b WHERE PO02_kodLesen = KodDaftar AND PO02_JualanID='{txtIdNJ.Text}'"

        Dim ds As New DataSet
        ds = dbconn.fselectCommand(strSql)

        gvLesen.DataSource = ds
        gvLesen.DataBind()

        gvLesen2.DataSource = ds
        gvLesen2.DataBind()
    End Sub


    Private Sub fbindDdlGred()
        Try
            Dim strSql As String = "Select KodGred from ROC_GredCIDB"

            Dim ds As New DataSet
            ds = dbconn.fselectCommand(strSql)

            ddlGred.DataSource = ds
            ddlGred.DataTextField = "KodGred"
            ddlGred.DataValueField = "KodGred"
            ddlGred.DataBind()

            ddlGred.Items.Insert(0, New ListItem("-Sila Pilih-", ""))
            ddlGred.SelectedIndex = 5
        Catch ex As Exception
            'fErrorLog("Peruntukan_KW.aspx(fBindDdlKW)- " & ex.Message.ToString)
        End Try
    End Sub


    Private Sub DaftarJualan(NoPO As String, jenis As String)
        lblTarikhNJ.Text = Date.Today.ToString("dd/MM/yyyy").ToString

        txtNamaPemohon.Text = Session("ssusrName")
        txtJawPemohon.Text = Session("ssusrPost")
        lblStatus1.Text = "Daftar Jualan Naskah"

        Dim strSqlPP = $"SELECT PO01_NoMohonSem, PO01_NoMohon, PO01_Tujuan,PO01_Scope, PO01_JenisDok, 
PO01_StatusPP, PO01_JenisBrg, PO01_KodPtjMohon, Butiran FROM PO01_PPembelian a, MK_PTJ b 
WHERE (PO01_StatusPP='006' OR PO01_StatusPP='010') AND b.KodPTJ = a.PO01_KodPtjMohon AND PO01_NoMohon='{NoPO}';"
        Dim ds = dbconn.fSelectCommand(strSqlPP)
        Dim dtPP = ds.Tables(0)
        If dtPP.Rows.Count > 0 Then
            fSetDataPP(dtPP, ViewState("Jenis"))

        End If

        KodStatus = 1
    End Sub

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="NoJN">No Jualan Naskah</param>
    ''' <param name="NoPO">No Perolehan</param>
    Private Sub EditJualan(NoJN As String, NoPO As String)
        Try
            Dim strSqlPP = $"Select PO01_NoMohonSem, PO01_NoMohon, PO01_Tujuan,PO01_Scope, PO01_JenisDok, 
PO01_StatusPP, PO01_JenisBrg, PO01_KodPtjMohon, Butiran 
FROM PO01_PPembelian a, MK_PTJ b 
WHERE PO01_NoMohon='{NoPO}' AND b.KodPTJ = a.PO01_KodPtjMohon;"

            Dim strSqlNJ = $"Select PO02_JualanID, PO01_NoMohon, PO02_Gred, PO01_NoMohonSem, [PO02_TarikhDaftar],[PO02_HargaNaskah],[PO02_NoDaftar],
[PO02_StatusLawTapak],[PO02_TmptLawTapak],[PO02_TrkMasaLawTapak],[PO02_TrkMasaMulaIklan],[PO02_TrkMasaMulaPO],
[PO02_TrkMasaTamatPO],PO02_IdPemohon, PO02_JwtnPemohon, PO02_TmptHantar, PO02_Syarat, PO02_JenisTender, ROC01_IDSya
FROM [PO02_NaskahJualan] 
WHERE PO02_JualanID='{NoJN}' AND PO01_NoMohon='{NoPO}';"

            Dim ds = dbconn.fselectCommand(strSqlPP + strSqlNJ)
            Dim dtPP = ds.Tables(0)
            If dtPP.Rows.Count > 0 Then
                fSetDataPP(dtPP, ViewState("Jenis"))
            End If

            Dim dtNJ = ds.Tables(1)
            If dtNJ.Rows.Count > 0 Then
                txtIdNJ.Text = NoJN
                lblNoPO1.Text = dtNJ.Rows(0)("PO01_NoMohon")

                Dim culture = New CultureInfo("ms-My")

                Dim trkDaftarNJ As DateTime = dtNJ.Rows(0)("PO02_TarikhDaftar")
                Dim hargaNskh = dtNJ.Rows(0)("PO02_HargaNaskah")
                Dim noDaftarSHTD = dtNJ.Rows(0)("PO02_NoDaftar").ToString
                'If trLawatanTapak.Visible Then
                Dim StatusLawTpk = dtNJ.Rows(0)("PO02_StatusLawTapak").ToString
                Dim tmptLawTpk = dtNJ.Rows(0)("PO02_TmptLawTapak").ToString

                If StatusLawTpk = "1" Then
                    Dim TrkMasaLawTpk As DateTime = dtNJ.Rows(0)("PO02_TrkMasaLawTapak")
                    'Dim MasaLawTpk As TimeSpan = dtNJ.Rows(0)("PO02_MasaLawTapak")

                    txtTrkLawTpk.Text = TrkMasaLawTpk.ToString("dd/MM/yyyy") '.ToShortTimeString
                    txtMasaLawTpk.Text = TrkMasaLawTpk.ToString("HH:mm")  '.ToShortDateString
                    txtTmptTapak.Text = tmptLawTpk
                End If

                rbLawTpk.SelectedValue = StatusLawTpk
                'End If


                Dim TrkMasaMulaIklan As DateTime = dtNJ.Rows(0)("PO02_TrkMasaMulaIklan")
                Dim TrkMasaMulaPO As DateTime = dtNJ.Rows(0)("PO02_TrkMasaMulaPO")
                Dim TrkMasaTamatPO As DateTime = dtNJ.Rows(0)("PO02_TrkMasaTamatPO")

                lblTarikhNJ.Text = trkDaftarNJ.ToShortDateString
                txtHrgNskh.Text = hargaNskh.ToString
                txtNoSHTD.Text = noDaftarSHTD

                txtTrkMulaIklan.Text = TrkMasaMulaIklan.ToString("dd/MM/yyyy") 'ToShortDateString
                txtTrkMulaPO.Text = TrkMasaMulaPO.ToString("dd/MM/yyyy") '("d", culture) '.ToShortDateString
                txtTrkTamatPO.Text = TrkMasaTamatPO.ToString("dd/MM/yyyy") '.ToShortDateString

                txtMasaMulaIklan.Text = TrkMasaMulaIklan.ToString("HH:mm") '.ToShortTimeString
                txtMasaMulaPO.Text = TrkMasaMulaPO.ToString("HH:mm") '.ToShortTimeString
                txtMasaTamatPO.Text = TrkMasaTamatPO.ToString("HH:mm") ' .ToShortTimeString

                txtTmptHantar.Text = dtNJ.Rows(0)("PO02_TmptHantar").ToString
                txtSyarat.Text = dtNJ.Rows(0)("PO02_Syarat").ToString
                txtNamaPemohon.Text = dtNJ.Rows(0)("PO02_IdPemohon").ToString
                txtJawPemohon.Text = dtNJ.Rows(0)("PO02_JwtnPemohon").ToString

                fLoadGVLampiran(NoJN)

                sPopulateRingkasan(ViewState("KodJenisDok"))


                If Not IsDBNull(dtNJ.Rows(0)("PO02_JenisTender")) Then
                    If dtNJ.Rows(0)("PO02_JenisTender") = "RT" Then
                        chxRundinganTerus.Checked = True
                    Else
                        chxRundinganTerus.Checked = False
                    End If
                Else
                    chxRundinganTerus.Checked = False
                End If

                ddlVendor.SelectedValue = IIf(IsDBNull(dtNJ.Rows(0)("ROC01_IDSya")), String.Empty, dtNJ.Rows(0)("ROC01_IDSya"))
                ddlGred.SelectedValue = IIf(IsDBNull(dtNJ.Rows(0)("PO02_Gred")), String.Empty, dtNJ.Rows(0)("PO02_Gred"))
            End If

            If ViewState("kodsubmenu") = "020301" Or ViewState("kodsubmenu") = "020302" Then
                If ViewState("KodStatus").Equals("031") Or ViewState("KodStatus").Equals("006") Then
                    '31 - DAFTAR JUALAN NASKAH
                    '06 - LULUS PERMOHONAN PEMBELIAN
                    btnHantar.Visible = True
                    mvNaskahJualan.SetActiveView(View1)
                    lbtnPrev4.Visible = True
                    KodStatus = 1
                Else
                    mvNaskahJualan.SetActiveView(View4)
                    lbtnPrev4.Visible = False
                    btnHantar.Visible = False
                    KodStatus = 4
                    If ViewState("KodStatus").Equals("032") Then
                        'Proses Jualan Naskah
                        BtnBatal.Visible = True
                    End If
                End If
            Else
                KodStatus = 4
                mvNaskahJualan.SetActiveView(View4)
                btnHantar.Visible = False
                lbtnPrev4.Visible = False
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub fSetDataPP(dtPP As DataTable, jenis As String)
        hfNoMohonSem.Value = dtPP.Rows(0)("PO01_NoMohonSem").ToString
        Dim NoPO = dtPP.Rows(0)("PO01_NoMohon").ToString
        Dim Tujuan = dtPP.Rows(0)("PO01_Tujuan").ToString
        Dim StatusPP = dtPP.Rows(0)("PO01_StatusPP").ToString
        Dim KodJenisPO = dtPP.Rows(0)("PO01_JenisBrg").ToString
        Dim KodJenisDok = dtPP.Rows(0)("PO01_JenisDok").ToString
        Dim StatusDok = fGetStatusDokPO(dtPP.Rows(0)("PO01_StatusPP").ToString)
        Dim KodStatus = StatusDok.FirstOrDefault.Key
        ViewState("KodPTj") = dtPP.Rows(0)("PO01_KodPtjMohon").ToString.Substring(0, 2)
        lblPTjMohon.Text = dtPP.Rows(0)("Butiran").ToString

        If ViewState("Jenis") = "Ptj" Then
            txtTmptHantar.ReadOnly = True
            txtTmptHantar.Text = dtPP.Rows(0)("Butiran").ToString
        End If

        txtTrkMulaIklan.Text = Date.Now.ToString("dd/MM/yyyy")
        txtMasaMulaIklan.Text = Today.ToString("HH:mm")
        txtMasaMulaPO.Text = Today.ToString("HH:mm")
        txtMasaTamatPO.Text = Today.ToString("HH:mm")

        lblScope1.Text = dtPP.Rows(0)("PO01_Scope").ToString
        lblNoPO1.Text = NoPO
        lblTujuan1.Text = Tujuan
        lblStatus1.Text = StatusDok.FirstOrDefault.Value

        fBindDdlLesenDaftar()

        If KodJenisPO = "K" Then
            lblKategoriPO1.Text = "KERJA"
            trCIDB.Visible = True
            trView3CIDB.Visible = True
            fbindDdlGred()
            'trLawatanTapak.Visible = True
            trGred.Visible = True
            trGred1.Visible = True
        Else
            trMOF.Visible = True
            trView3Bidang.Visible = True
            fBindDdlBidangUtama()
            If KodJenisPO = "B" Then
                lblKategoriPO1.Text = "BEKALAN"
            ElseIf KodJenisPO = "P" Then
                lblKategoriPO1.Text = "PERKHIDMATAN"
            End If
        End If

        ViewState("KodJenisDok") = KodJenisDok

        If KodJenisDok.Equals("P02") Then
            lblKaedahPO.Text = "TENDER"
        ElseIf KodJenisDok.Equals("P03") Then
            lblKaedahPO.Text = "SEBUT HARGA"
        ElseIf KodJenisDok.Equals("P04") Then
            lblKaedahPO.Text = "SEBUT HARGA PTJ"
            txtHrgNskh.Text = "0.00"
            txtHrgNskh.Enabled = False
        End If


        ViewState("KodStatus") = KodStatus
    End Sub

    ''' <summary>
    ''' Jana Naskah Jualan
    ''' </summary>
    Private Function fJanaNoIdNkhJualan() As String
        Dim year = Date.Now.ToString("yy")
        Dim month = Date.Now.Month

        Dim indx = NoIndexNJ()
        Dim strNo = Format(indx, "000000").ToString
        Dim NoId = "NJ" + ViewState("KodPTj") + strNo + month.ToString("00") + year.ToString

        ViewState("indx") = indx
        Return NoId
    End Function

    Private Function NoIndexNJ()
        Dim index As Integer = 0
        Try
            Dim year = Date.Now.Year
            Dim KodPtj = ViewState("KodPTj")

            Dim strSql = $"SELECT NoAkhir From MK_NoAkhir WHERE KodModul = 'PO' AND Prefix = 'NJ' AND Tahun = {year} and kodptj = {KodPtj}"

            Dim ds = dbconn.fselectCommand(strSql)
            Dim dt = ds.Tables(0)
            If dt.Rows.Count = 1 Then
                index = dt.Rows(0)("NoAkhir") + 1
            Else
                index = 1
            End If
        Catch ex As Exception

        End Try

        Return index
    End Function

    Private Sub UpdateNoAkhir(no As Integer)
        Dim year = Date.Now.Year
        Dim KodPtj = ViewState("KodPTj")

        Dim strSql = "SELECT KodModul, Prefix, NoAkhir, Tahun, Butiran, kodPTJ, ID From MK_NoAkhir WHERE KodModul = @KodModull AND Prefix = @Prefixx AND Tahun = @years and kodptj = @KodPtjj"
        Dim paramSql() As SqlParameter = {
            New SqlParameter("@KodModull", "PO"),
            New SqlParameter("@Prefixx", "NJ"),
            New SqlParameter("@years", year),
            New SqlParameter("@KodPtjj", KodPtj)
            }

        Dim ds = dbconn.fSelectCommand(strSql, "MKNoAkhir", paramSql)

        If ds.Tables(0).Rows.Count > 0 Then
            ds.Tables(0).Rows(0)("NoAkhir") = no
        Else
            Dim dr As DataRow
            dr = ds.Tables(0).NewRow
            dr("KodModul") = "PO"
            dr("Prefix") = "NJ"
            dr("noakhir") = 1
            dr("Tahun") = year
            dr("Butiran") = "Naskah Jualan"
            dr("kodPTJ") = KodPtj
            ds.Tables(0).Rows.Add(dr)
        End If

        dbconn.sUpdateCommand(ds, strSql)

    End Sub

    Private Sub fGetJenisDok(noMohon As String)
        'KodJenisDok 
        'P01 -PERMOHONAN PEMBELIAN BIASA
        'P02 -PERMOHONAN PEMBELIAN TENDER
        'P03 -PERMOHONAN PEMBELIAN SEBUTHARGA UNIVERSITI
        'P04 -PERMOHONAN PEMBELIAN SEBUTHARGA PTJ

        Dim str = $"Select PO01_JenisDok FROM PO01_PPembelian WHERE PO01_NoMohon='{noMohon}'"
        Dim jenisdok As String = ""
        dbconn.sSelectCommand(str, jenisdok)
        ViewState("KaedahPO") = jenisdok
    End Sub

    Private Sub fSimpanStatusBerjaya(daftar As Boolean)
        Dim tarikh = DateTime.Now
        Dim strSql = $"UPDATE PO01_PPembelian SET PO01_StatusPP=@StatusPP WHERE PO01_NoMohon=@NoMohon;"
        Dim strSql2 = $"INSERT INTO PO10_StatusDok VALUES (@NoJualanID,@NoMohon,'-',@StatusPP,@noStaff,@tarikh,@ulasan);"
        Dim Status = "031" 'DAFTAR JUALAN NASKAH
        Dim ulasan = ""
        Dim paramSql() As SqlParameter

        If daftar Then
            'Daftar
            ulasan = "daftar"
            paramSql = {
                New SqlParameter("@NoJualanID", txtIdNJ.Text),
                New SqlParameter("@NoMohon", lblNoPO1.Text),
                New SqlParameter("@StatusPP", Status),
                New SqlParameter("@noStaff", Session("ssusrID")),
                New SqlParameter("@tarikh", tarikh),
                New SqlParameter("@ulasan", ulasan)
            }

            dbconn.sUpdateCommand(strSql + strSql2, paramSql)
        Else
            'Kemaskini
            ulasan = "Kemaskini"
            paramSql = {
                New SqlParameter("@NoJualanID", txtIdNJ.Text),
                New SqlParameter("@NoMohon", lblNoPO1.Text),
                New SqlParameter("@StatusPP", Status),
                New SqlParameter("@noStaff", Session("ssusrID")),
                New SqlParameter("@tarikh", tarikh),
                New SqlParameter("@ulasan", ulasan)
            }
            dbconn.sUpdateCommand(strSql2, paramSql)
        End If


    End Sub

    Protected Sub btnSimpan_Click(sender As Object, e As EventArgs) Handles btnSimpan.Click
        Try
            If txtTrkMulaIklan.Text = "" Or txtTrkMulaPO.Text = "" Or txtTrkTamatPO.Text = "" Then
                fGlobalAlert($"Sila isi tarikh Mula Iklan, Mula Perolehan dan Tamat Perolehan!", Me.Page, Me.[GetType]())
                Exit Sub
            End If



            Dim tarikhMasaMulaIklan As DateTime = DateTime.ParseExact(txtTrkMulaIklan.Text, "dd/MM/yyyy", New CultureInfo("en-US")).Add(TimeSpan.Parse(txtMasaMulaIklan.Text))
            Dim tarikhMasaMulaPO As DateTime = DateTime.ParseExact(txtTrkMulaPO.Text, "dd/MM/yyyy", New CultureInfo("en-US")).Add(TimeSpan.Parse(txtMasaMulaPO.Text))
            Dim tarikhMasaTamatPO As DateTime = DateTime.ParseExact(txtTrkTamatPO.Text, "dd/MM/yyyy", New CultureInfo("en-US")).Add(TimeSpan.Parse(txtMasaTamatPO.Text))
            'Daim tambah date_conversion utk elak salah date conversion
            'Dim tarikhNJ = CDate(date_conversion(lblTarikhNJ.Text)).ToString("yyyy-MM-dd") 'DateTime.ParseExact(lblTarikhNJ.Text, "dd/MM/yyyy", New CultureInfo("en-US"))
            Dim tarikhNJN As Date = DateTime.ParseExact(Trim(lblTarikhNJ.Text.TrimEnd), "dd/MM/yyyy", CultureInfo.CurrentCulture)
            Dim tarikhNJ As String = tarikhNJN.ToString("yyyy-MM-dd")

            If tarikhMasaMulaPO <= tarikhMasaMulaIklan Then
                fGlobalAlert($"Pastikan tarikh dan masa mula Perolehan melebihi tarikh mula iklan!", Me.Page, Me.[GetType]())
                Exit Sub
            End If

            If tarikhMasaTamatPO <= tarikhMasaMulaPO Then
                fGlobalAlert($"Pastikan tarikh dan masa tamat Perolehan melebihi tarikh mula Perolehan!", Me.Page, Me.[GetType]())
                Exit Sub
            End If

            Dim tarikhMasaLwtTpk As DateTime? = Nothing
            ' Dim masalawTpk As TimeSpan? = Nothing

            If rbLawTpk.SelectedValue = "1" Then
                'If txtTmptTapak.Text = String.Empty Or txtTrkLawTpk.Text = String.Empty Or txtMasaLawTpk.Text = String.Empty Then
                '    fGlobalAlert($"Sila isi Tempat, tarikh dan masa Lawatan Tapak!", Me.Page, Me.[GetType]())
                '    Exit Sub
                'End If
                tarikhMasaLwtTpk = DateTime.ParseExact(txtTrkLawTpk.Text, "dd/MM/yyyy", New CultureInfo("en-US")).Add(TimeSpan.Parse(txtMasaLawTpk.Text))
            End If

            Dim isResultUpdate As Boolean = False
            Dim isResultCommit As Boolean = False

            Dim dr As DataRow = Nothing

            If txtIdNJ.Text.Equals(String.Empty) Then
                Dim noIdNJ = fJanaNoIdNkhJualan()

                Dim strSql = $"Select PO02_JualanID, PO01_NoMohon, PO01_NoMohonSem, PO02_TarikhDaftar, PO02_HargaNaskah, 
PO02_NoDaftar,PO02_StatusLawTapak, PO02_TmptLawTapak, PO02_TrkMasaLawTapak, PO02_TmptHantar, PO02_Syarat, PO02_Gred,
PO02_TrkMasaMulaIklan, PO02_TrkMasaMulaPO, PO02_TrkMasaTamatPO, PO02_IdPemohon, PO02_JwtnPemohon, PO02_JenisTender, ROC01_IDSya
FROM [PO02_NaskahJualan] WHERE PO02_JualanID='{noIdNJ}'"
                Dim dsNJ = dbconn.fSelectCommand(strSql, "NJDs")
                If dsNJ.Tables(0).Rows.Count = 0 Then
                    'insert new item
                    dr = dsNJ.Tables(0).NewRow
                    dr("PO02_JualanID") = noIdNJ
                    dr("PO01_NoMohon") = lblNoPO1.Text
                    dr("PO01_NoMohonSem") = hfNoMohonSem.Value
                    dr("PO02_TarikhDaftar") = tarikhNJ
                    dr("PO02_HargaNaskah") = CDec(txtHrgNskh.Text)
                    dr("PO02_NoDaftar") = txtNoSHTD.Text.Trim
                    dr("PO02_StatusLawTapak") = rbLawTpk.SelectedValue
                    dr("PO02_TmptLawTapak") = txtTmptTapak.Text.Trim
                    If tarikhMasaLwtTpk IsNot Nothing Then
                        dr("PO02_TrkMasaLawTapak") = tarikhMasaLwtTpk
                    Else
                        dr("PO02_TrkMasaLawTapak") = DBNull.Value
                    End If

                    dr("PO02_TrkMasaMulaIklan") = tarikhMasaMulaIklan
                    dr("PO02_TrkMasaMulaPO") = tarikhMasaMulaPO
                    dr("PO02_TrkMasaTamatPO") = tarikhMasaTamatPO
                    dr("PO02_IdPemohon") = Session("ssusrID")
                    dr("PO02_JwtnPemohon") = txtJawPemohon.Text.Trim
                    dr("PO02_Syarat") = txtSyarat.Text
                    dr("PO02_TmptHantar") = txtTmptHantar.Text.Trim
                    dr("PO02_Gred") = ddlGred.SelectedValue
                    If trVendor.Visible Then
                        dr("PO02_JenisTender") = IIf(chxRundinganTerus.Checked, "RT", DBNull.Value)
                        dr("ROC01_IDSya") = ddlVendor.SelectedValue
                    End If

                    dsNJ.Tables(0).Rows.Add(dr)
                    dbconn.sUpdateCommand(dsNJ, strSql, isResultUpdate, True, isResultCommit)
                End If

                If isResultCommit Then
                    txtIdNJ.Text = noIdNJ
                    UpdateNoAkhir(ViewState("indx"))
                    sPopulateRingkasan(ViewState("KodJenisDok"))
                    If Not String.IsNullOrEmpty(txtIdNJ.Text) Then
                        fSimpanStatusBerjaya(True)
                    End If
                    fGlobalAlert($"Rekod telah didaftarkan!", Me.Page, Me.[GetType]())
                Else
                    fGlobalAlert($"Rekod tidak berjaya disimpan! Sila hubungi admin.", Me.Page, Me.[GetType]())
                End If

            Else
                Dim noIdNJ = txtIdNJ.Text
                Dim strSql = $"Select PO02_JualanID, PO01_NoMohon, PO02_TarikhDaftar, PO02_HargaNaskah, 
PO02_NoDaftar,PO02_StatusLawTapak, PO02_TmptLawTapak, PO02_TrkMasaLawTapak, PO02_TmptHantar, PO02_Syarat, PO02_Gred,
PO02_TrkMasaMulaIklan, PO02_TrkMasaMulaPO, PO02_TrkMasaTamatPO ,PO02_IdPemohon,PO02_JwtnPemohon, PO02_JenisTender, ROC01_IDSya
FROM [PO02_NaskahJualan] WHERE PO02_JualanID='{noIdNJ}'"
                Dim dsNJ = dbconn.fSelectCommand(strSql, "NJDs")
                If dsNJ.Tables(0).Rows.Count > 0 Then
                    'insert new itemtxtTmptHantar
                    dr = dsNJ.Tables(0).Rows(0)

                    dr("PO02_HargaNaskah") = CDec(txtHrgNskh.Text)

                    'If trNoSHTD.Visible Then
                    dr("PO02_NoDaftar") = txtNoSHTD.Text
                    'End If

                    'If trLawatanTapak.Visible Then
                    dr("PO02_StatusLawTapak") = rbLawTpk.SelectedValue
                    dr("PO02_TmptLawTapak") = txtTmptTapak.Text
                    If tarikhMasaLwtTpk IsNot Nothing Then
                        dr("PO02_TrkMasaLawTapak") = tarikhMasaLwtTpk
                    Else
                        dr("PO02_TrkMasaLawTapak") = DBNull.Value
                    End If
                    'End If

                    dr("PO02_TrkMasaMulaIklan") = tarikhMasaMulaIklan
                    dr("PO02_TrkMasaMulaPO") = tarikhMasaMulaPO
                    dr("PO02_TrkMasaTamatPO") = tarikhMasaTamatPO
                    dr("PO02_IdPemohon") = Session("ssusrID")

                    dr("PO02_JwtnPemohon") = txtJawPemohon.Text.Trim
                    dr("PO02_Syarat") = txtSyarat.Text
                    dr("PO02_TmptHantar") = txtTmptHantar.Text.Trim
                    dr("PO02_Gred") = ddlGred.SelectedValue

                    If trVendor.Visible Then
                        dr("PO02_JenisTender") = IIf(chxRundinganTerus.Checked, "RT", DBNull.Value)
                        dr("ROC01_IDSya") = ddlVendor.SelectedValue
                    End If

                    dbconn.sUpdateCommand(dsNJ, strSql, isResultUpdate, True, isResultCommit)
                    If isResultCommit Then
                        fSimpanStatusBerjaya(False)
                        fGlobalAlert($"Rekod telah dikemaskini!", Me.Page, Me.[GetType]())
                        sPopulateRingkasan(ViewState("KodJenisDok"))
                    Else
                        fGlobalAlert($"Rekod tidak berjaya disimpan! Sila hubungi admin.", Me.Page, Me.[GetType]())
                    End If

                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub rbLawTpk_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rbLawTpk.SelectedIndexChanged
        If rbLawTpk.SelectedIndex = 0 Then
            divUlasan.Visible = False
            revtxtTrkLawTpk.Enabled = False
            rfvtxtMasaLawTpk.Enabled = False
            rfvtxtTmptTapak.Enabled = False
        ElseIf rbLawTpk.SelectedIndex = 1 Then
            divUlasan.Visible = True
            revtxtTrkLawTpk.Enabled = True
            rfvtxtMasaLawTpk.Enabled = True
            rfvtxtTmptTapak.Enabled = True
        End If
    End Sub

    Protected Sub ddlBidangUtama_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlBidangUtama.SelectedIndexChanged
        Try
            Dim strSql As String = $"Select Kod, (Kod + ' - ' +Butiran) As Butiran2 from ROC_SubBidang where KodBdgUtama='{ddlBidangUtama.SelectedValue}'"

            Dim ds As New DataSet
            ds = dbconn.fselectCommand(strSql)

            ddlSubBidang.DataSource = ds
            ddlSubBidang.DataTextField = "Butiran2"
            ddlSubBidang.DataValueField = "Kod"
            ddlSubBidang.DataBind()

            ddlSubBidang.Items.Insert(0, New ListItem("-Sila Pilih-", ""))
            ddlSubBidang.SelectedIndex = 0
        Catch ex As Exception
            'fErrorLog("Peruntukan_KW.aspx(fBindDdlKW)- " & ex.Message.ToString)
        End Try
    End Sub

    Protected Sub ddlSubBidang_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSubBidang.SelectedIndexChanged
        Try
            Dim strSql As String = $"Select KodBidang, Butiran from ROC_Bidang where KodSubBidang='{ddlSubBidang.SelectedValue}'"

            Dim ds As New DataSet
            ds = dbconn.fselectCommand(strSql)

            gvBidang.DataSource = ds
            gvBidang.DataBind()

        Catch ex As Exception
            'fErrorLog("Peruntukan_KW.aspx(fBindDdlKW)- " & ex.Message.ToString)
        End Try
    End Sub

    Private Sub fBindDdlKategori()
        Try
            Dim strSql As String = $"Select KodKategori, Butiran from ROC_KategoriCIDB"

            Dim ds As New DataSet
            ds = dbconn.fselectCommand(strSql)

            ddlKategori.DataSource = ds
            ddlKategori.DataTextField = "Butiran"
            ddlKategori.DataValueField = "KodKategori"
            ddlKategori.DataBind()

            ddlKategori.Items.Insert(0, New ListItem("-Sila Pilih-", ""))
            ddlKategori.SelectedIndex = 0
        Catch ex As Exception
            'fErrorLog("Peruntukan_KW.aspx(fBindDdlKW)- " & ex.Message.ToString)
        End Try
    End Sub

    Protected Sub ddlKategori_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlKategori.SelectedIndexChanged
        Try
            Dim strSql As String = $"Select KodKhusus, Butiran from ROC_PengkhususanCIDB where KodKategori='{ddlKategori.SelectedValue}'"

            Dim ds As New DataSet
            ds = dbconn.fselectCommand(strSql)

            gvKhususCIDB.DataSource = ds
            gvKhususCIDB.DataBind()

        Catch ex As Exception
            'fErrorLog("Peruntukan_KW.aspx(fBindDdlKW)- " & ex.Message.ToString)
        End Try
    End Sub

    Protected Sub lbtnNextView1_Click(sender As Object, e As EventArgs) Handles lbtnNextView1.Click
        If txtIdNJ.Text.Equals(String.Empty) Then
            fGlobalAlert("Sila klik button SIMPAN sebelum pergi ke laman seterusnya.", Page, Me.GetType())
        Else
            'fBindDdlLesenDaftar()
            mvNaskahJualan.SetActiveView(View2)
            KodStatus = 2
        End If

    End Sub

    Protected Sub lbtnNextView2_Click(sender As Object, e As EventArgs) Handles lbtnNextView2.Click
        mvNaskahJualan.SetActiveView(View3)
        KodStatus = 3
    End Sub

    Protected Sub lbtnPrevView2_Click(sender As Object, e As EventArgs) Handles lbtnPrevView2.Click
        mvNaskahJualan.SetActiveView(View1)
        KodStatus = 1
    End Sub

    Protected Sub lbtnPrev3_Click(sender As Object, e As EventArgs) Handles lbtnPrevView3.Click
        mvNaskahJualan.SetActiveView(View2)
        KodStatus = 2
    End Sub

    Protected Sub btnHantar_Click(sender As Object, e As EventArgs) Handles btnHantar.Click
        Try
            Dim StatusHantar = ""
            Dim paramSql() As SqlParameter = {}
            Dim tarikh = DateTime.Now
            If ViewState("kodsubmenu") = "020301" Or ViewState("kodsubmenu") = "020302" Then

                StatusHantar = "032" 'PROSES JUALAN NASKAH

                Dim strSql = $"UPDATE PO01_PPembelian Set PO01_StatusPP = @StatusPP WHERE PO01_NoMohon=@NoMohon;"
                Dim strSql2 = $"INSERT INTO PO10_StatusDok VALUES (@NoIDNJ,@NoMohon,'-',@StatusPP,@noStaff,@tarikh,@ulasan);"
                paramSql = {
                    New SqlParameter("@NoIDNJ", txtIdNJ.Text),
                    New SqlParameter("@NoMohon", lblNoPO1.Text),
                    New SqlParameter("@StatusPP", StatusHantar),
                    New SqlParameter("@noStaff", Session("ssusrID")),
                    New SqlParameter("@tarikh", tarikh),
                    New SqlParameter("@ulasan", "PROSES JUALAN NASKAH")
                    }
                dbconn.sUpdateCommand(strSql + strSql2, paramSql)

                If ViewState("kodsubmenu") = "020301" Then
                    fGlobalAlert($"Rekod telah dihantar!", Me.Page, Me.[GetType](), "../../Perolehan/Jualan Naskah/Jualan_PTJ.aspx?KodSub=0203&KodSubMenu=020301")
                Else
                    fGlobalAlert($"Rekod telah dihantar!", Me.Page, Me.[GetType](), "../../Perolehan/Jualan Naskah/Jualan_Universiti.aspx?KodSub=0203&KodSubMenu=020302")
                End If

            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub lbtnKembali_Click(sender As Object, e As EventArgs) Handles lbtnKembali.Click

        If ViewState("kodsubmenu") = "020102" Then
            ' 020105 - Kelulusan Ketua PTj
            Response.Redirect($"~/FORMS/Perolehan/Permohonan Perolehan/Kelulusan_Ketua_PTJ.aspx?KodSub=0201&KodSubMenu=020105")

        ElseIf ViewState("kodsubmenu") = "020101" Then
            ' 020101 - Permohonan Pembelian
            Response.Redirect($"~/FORMS/Perolehan/Permohonan Perolehan/Permohonan_Perolehan.aspx?KodSub=0201&KodSubMenu=020101")
        ElseIf ViewState("kodsubmenu") = "020301" Then
            ' 020301 - Jualan PTJ
            Response.Redirect($"~/FORMS/Perolehan/Jualan Naskah/Jualan_PTJ.aspx?KodSub=0203&KodSubMenu=020301")
        ElseIf ViewState("kodsubmenu") = "020302" Then
            ' 020302 - Jualan Universiti
            Response.Redirect($"~/FORMS/Perolehan/Jualan Naskah/Jualan_Universiti.aspx?KodSub=0203&KodSubMenu=020302")
        End If
    End Sub

    Protected Sub lbtnTambahLesen_Click(sender As Object, e As EventArgs) Handles lbtnTambahLesen.Click

        Try
            Dim kodLesen = ddlLesenDaftar.SelectedValue

            Dim strSql = "SELECT PO02_JualanID, PO02_kodLesen, PO02_Detail FROM PO02_NaskahJualanLesen WHERE PO02_JualanID = @NoNJj AND PO02_kodLesen=@KodLesenn"
            Dim paramSql() As SqlParameter = {
                New SqlParameter("@NoNJj", txtIdNJ.Text),
                New SqlParameter("@KodLesenn", kodLesen)
                }

            Dim ds = dbconn.fSelectCommand(strSql, "Lesen", paramSql)
            Dim dtLesen = ds.Tables(0)

            Dim detail = txtDetail.Text
            If dtLesen.Rows.Count > 0 Then
                If Not detail.Equals(String.Empty) Then
                    dtLesen.Rows(0)("PO02_Detail") = detail
                End If

            Else
                Dim dr As DataRow
                dr = dtLesen.NewRow
                dr("PO02_JualanID") = txtIdNJ.Text
                dr("PO02_kodLesen") = kodLesen
                If Not detail.Equals(String.Empty) Then
                    dr("PO02_Detail") = detail
                End If
                dtLesen.Rows.Add(dr)
            End If

            dbconn.sUpdateCommand(ds, strSql)

            fBindGVLesen()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub gvLesen_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvLesen.RowDeleting
        Try
            Dim index = e.RowIndex
            'Dim selectedRow As GridViewRow = gvLesen.

            Dim KodLesen As String = gvLesen.DataKeys(index).Value 'selectedRow.Cells(1).Text
            Dim namaLesen = gvLesen.Rows(index).Cells(2).Text

            Dim strSql = $"delete from PO02_NaskahJualanLesen where PO02_kodLesen = '{KodLesen}' AND PO02_JualanID='{txtIdNJ.Text}'"
            If dbconn.fUpdateCommand(strSql) > 0 Then
                fGlobalAlert($"Rekod '{namaLesen}' telah dipadam!", Me.Page, Me.GetType())
                fBindGVLesen()
            End If

        Catch ex As Exception

        End Try
    End Sub



    Protected Sub gvSyarikatBidang_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvSyarikatBidang.RowDeleting
        Try
            Dim index = e.RowIndex
            'Dim selectedRow As GridViewRow = gvLesen.

            Dim KodBidang As String = gvSyarikatBidang.DataKeys(index).Value 'selectedRow.Cells(1).Text
            Dim namaBidang = gvSyarikatBidang.Rows(index).Cells(2).Text

            Dim strSql = $"delete from PO02_NaskahJualanBidang where PO02_KodBidang = '{KodBidang}' AND PO02_JualanID='{txtIdNJ.Text}'"
            If dbconn.fUpdateCommand(strSql) > 0 Then
                fGlobalAlert($"Rekod '{namaBidang}' telah dipadam!", Me.Page, Me.GetType())
                fBindGVSyarikatBidang()
            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub lbtnTambahMOF_Click(sender As Object, e As EventArgs) Handles lbtnTambahMOF.Click
        Try
            If ddlSubBidang.SelectedIndex = 0 Then
                fGlobalAlert($"Sila pilih sub bidang sebelum klik button Simpan!", Me.Page, Me.GetType())
                Exit Sub
            End If

            'Dim chkAll As CheckBox = DirectCast(gvBidang.HeaderRow.Cells(0).FindControl("checkAll"), CheckBox)
            Dim KodBidang As String = ""
            Dim dsBidang As New DataSet

            Dim strSql = $"SELECT PO02_KodBidang, PO02_JualanID, PO02_Condition FROM PO02_NaskahJualanBidang WHERE PO02_JualanID = '{txtIdNJ.Text}'"
            dsBidang = dbconn.fSelectCommand(strSql, "NJDttDs")
            Dim dtBidang = dsBidang.Tables(0)
            Dim foundRow As DataRow
            Dim rows = gvBidang.Rows
            For i As Integer = 0 To rows.Count - 1
                KodBidang = gvBidang.DataKeys(i).Value 'rows(i).Cells(2).Text.ToString()
                foundRow = dtBidang.Select($"PO02_KodBidang= '{KodBidang}' AND PO02_JualanID= '{txtIdNJ.Text}' ").FirstOrDefault()
                Dim rbSelect As RadioButton = CType(rows(i).Cells(0).FindControl("rbPilih"), RadioButton)
                If rbSelect.Checked Then
                    If foundRow Is Nothing Then
                        dtBidang.NewRow()
                        dtBidang.Rows.Add(KodBidang, txtIdNJ.Text, ddlSituasiBidang.SelectedValue)
                    End If
                End If

                'If chkAll.Checked Then
                'Add all rows
                'If foundRow Is Nothing Then
                'dtBidang.NewRow()
                'dtBidang.Rows.Add(KodBidang, txtIdNJ.Text)
                'End If
                'Else
                'Dim chk As CheckBox = DirectCast(rows(i).Cells(0).FindControl("CheckBox1"), CheckBox)
                'If chk.Checked Then
                '    If foundRow Is Nothing Then
                '        dtBidang.NewRow()
                '        dtBidang.Rows.Add(KodBidang, txtIdNJ.Text)
                '    End If
                'End If
                'End If

            Next
            dbconn.sUpdateCommand(dsBidang, strSql)

            fBindGVSyarikatBidang()

            ddlSubBidang.SelectedIndex = 0
            ddlSubBidang_SelectedIndexChanged(sender, e)

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub lbtnTambahCIDB_Click(sender As Object, e As EventArgs) Handles lbtnTambahCIDB.Click
        Try
            If ddlKategori.SelectedIndex = 0 Then
                fGlobalAlert($"Sila pilih sub bidang sebelum klik button Simpan!", Me.Page, Me.GetType())
                Exit Sub
            End If
            'Dim chkAll As CheckBox = DirectCast(gvKhususCIDB.HeaderRow.Cells(0).FindControl("checkAll"), CheckBox)
            Dim KodKhusus As String = ""
            Dim dsKhusus As New DataSet

            Dim KodGred = ddlGred.SelectedValue
            Dim KodKategori = ddlKategori.SelectedValue

            Dim strSql = $"SELECT PO02_KodKhusus, PO02_JualanID, PO02_KodKategori, PO02_Condition FROM PO02_NaskahJualanCIDB WHERE PO02_JualanID = '{txtIdNJ.Text}'"
            dsKhusus = dbconn.fSelectCommand(strSql, "NJDttDs")
            Dim dtBidang = dsKhusus.Tables(0)
            Dim foundRow As DataRow
            Dim rows = gvKhususCIDB.Rows

            For i As Integer = 0 To rows.Count - 1
                KodKhusus = gvKhususCIDB.DataKeys(i).Value 'rows(i).Cells(2).Text.ToString()
                foundRow = dtBidang.Select($"PO02_KodKhusus= '{KodKhusus}' AND PO02_JualanID= '{txtIdNJ.Text}' AND PO02_KodKategori= '{KodKategori}'").FirstOrDefault()
                Dim rbSelect As RadioButton = CType(rows(i).Cells(0).FindControl("rbPilih"), RadioButton)
                If rbSelect.Checked Then
                    If foundRow Is Nothing Then
                        dtBidang.NewRow()
                        dtBidang.Rows.Add(KodKhusus, txtIdNJ.Text, KodKategori, ddlSituasiCIDB.SelectedValue)
                    End If
                End If

                'If chkAll.Checked Then
                '    'Add all rows
                '    If foundRow Is Nothing Then
                '        dtBidang.NewRow()
                '        dtBidang.Rows.Add(KodKhusus, txtIdNJ.Text, KodKategori)
                '    End If
                'Else
                '    Dim chk As CheckBox = DirectCast(rows(i).Cells(0).FindControl("CheckBox1"), CheckBox)
                '    If chk.Checked Then
                '        If foundRow Is Nothing Then
                '            dtBidang.NewRow()
                '            dtBidang.Rows.Add(KodKhusus, txtIdNJ.Text, KodKategori)
                '        End If
                '    End If
                'End If

            Next
            dbconn.sUpdateCommand(dsKhusus, strSql)

            fBindGVSyarikatCIDB()

            ddlKategori.SelectedIndex = 0
            ddlKategori_SelectedIndexChanged(sender, e)

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GVSyarikatCIDB_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles GVSyarikatCIDB.RowDeleting
        Try

            Dim index = e.RowIndex

            Dim KodKhusus As String = GVSyarikatCIDB.DataKeys(index).Value 'SelectedDataKey.Value.ToString 'selectedRow.Cells(1).Text
            Dim namaKhusus = GVSyarikatCIDB.Rows(index).Cells(4).Text

            Dim strSql = $"DELETE from PO02_NaskahJualanCIDB where PO02_KodKhusus = '{KodKhusus}' AND PO02_JualanID='{txtIdNJ.Text}'"
            If dbconn.fUpdateCommand(strSql) > 0 Then
                fGlobalAlert($"Rekod '{namaKhusus}' telah dipadam!", Me.Page, Me.GetType())
                fBindGVSyarikatCIDB()
            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub lbtnCari_Click(sender As Object, e As EventArgs) Handles lbtnCari.Click
        Dim noMohon As String = lblNoPO1.Text
        Dim length = noMohon.Length
        'Dim NoMohonSem = noMohon.Remove(0, 2).Insert(0, "BS")

        Response.Redirect($"~/FORMS/Perolehan/Permohonan Perolehan/MaklumatPermohonanPO.aspx?KodSub={ViewState("kodsubmenu").Substring(0, 3)}&KodSubMenu={ViewState("kodsubmenu")}&no={hfNoMohonSem.Value}&nolls={noMohon}&noNJ={txtIdNJ.Text}")
    End Sub

    Private Sub lbtnUploadLamp_Click(sender As Object, e As EventArgs) Handles lbtnUploadLamp.Click
        If rbDokumenType.SelectedItem Is Nothing Then
            LabelMessage1.ForeColor = Color.Red
            LabelMessage1.Text = "Pilih salah satu jenis dokumen"
            Exit Sub
        End If

        If FileUpload1.FileName IsNot String.Empty Then
            If FileUpload1.PostedFile.ContentType = "application/pdf" Or FileUpload1.PostedFile.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document" Then
                If FileUpload1.PostedFile.ContentLength < 51200000 Then  '500KB
                    Dim FileName = Path.GetFileName(FileUpload1.FileName)
                    If FileName.Length < 50 Then
                        Dim folderPath As String = Server.MapPath($"~/Upload/Document/PO/JualanNaskah/{txtIdNJ.Text}/")
                        Dim ContentType = FileUpload1.PostedFile.ContentType

                        'Check whether Directory (Folder) exists.
                        If Not Directory.Exists(folderPath) Then
                            'If Directory (Folder) does not exists. Create it.
                            Directory.CreateDirectory(folderPath)
                        End If

                        Try
                            'Dim NoMohon = txtIdNJ.Text + "_"
                            Dim SaveFileName = FileName 'String.Concat(NoMohon, FileName)

                            'Create the path And file name to check for duplicates.
                            Dim pathToCheck = folderPath + SaveFileName

                            'Check to see if a file already exists with the same name as the file to upload.
                            If File.Exists(pathToCheck) Then
                                LabelMessage1.ForeColor = Color.Red
                                LabelMessage1.Text = "The target file already exists, please rename it."
                            Else
                                'Save the File to the Directory (Folder).
                                FileUpload1.SaveAs(folderPath & SaveFileName)

                                simpanPath(folderPath, SaveFileName, ContentType, rbDokumenType.SelectedValue)
                                rbDokumenType.ClearSelection()
                                fLoadGVLampiran(txtIdNJ.Text)

                                LabelMessage1.ForeColor = Color.Green
                                'Display the success message.
                                LabelMessage1.Text = FileName + " has been uploaded."
                            End If

                        Catch ex As Exception
                            'Display the success message.
                            LabelMessage1.ForeColor = Color.Red
                            LabelMessage1.Text = FileName + " could Not be uploaded."
                        End Try
                    Else
                        LabelMessage1.ForeColor = Color.Red
                        LabelMessage1.Text = "The filename length cannot exceed 50 characters, please rename it."
                    End If

                Else
                    LabelMessage1.ForeColor = Color.Red
                    LabelMessage1.Text = "Please upload file With size Not more than 500KB"
                End If
            Else
                LabelMessage1.ForeColor = Color.Red
                LabelMessage1.Text = "Please upload file With type Of 'docx' or 'pdf'."
            End If
        Else
            LabelMessage1.ForeColor = Color.Red
            LabelMessage1.Text = "Upload failed! : No file selected."
        End If
    End Sub

    Private Sub simpanPath(Path As String, FileName As String, ContentType As String, JenisLamp As String)
        Dim ds As New DataSet
        Try
            Dim noMohon = txtIdNJ.Text
            'PO13_JenisDok
            Dim str = "select PO13_ID, PO13_NoMohon, PO13_NamaDok, PO13_Bil, PO13_Path, PO13_ContentType, PO13_JenisDok, PO13_StatusDelete from PO13_Lampiran"
            ds = dbconn.fSelectCommand(str, "dsStr")
            Dim dsRows = ds.Tables(0).AsEnumerable().Where(Function(r) r.Item("PO13_NoMohon") = noMohon)
            Dim record = dsRows.Count

            Dim Bil = record + 1

            Dim dr As DataRow
            dr = ds.Tables(0).NewRow
            dr("PO13_NoMohon") = noMohon
            dr("PO13_NamaDok") = FileName
            dr("PO13_Bil") = Bil
            dr("PO13_Path") = Path
            dr("PO13_ContentType") = ContentType
            dr("PO13_JenisDok") = JenisLamp
            dr("PO13_StatusDelete") = 0
            ds.Tables(0).Rows.Add(dr)
            dbconn.sUpdateCommand(ds, str)
        Catch ex As Exception
        End Try

    End Sub

    Private Sub fLoadGVLampiran(ByVal noMohon As String)
        Try
            'PO13_JenisDok = L, Jenis Lampiran
            'PO13_JenisDok = T, Jenis Teknikal
            Dim str = $"select PO13_ID, PO13_NoMohon, PO13_NamaDok, PO13_JenisDok from PO13_Lampiran where PO13_NoMohon = '{noMohon}' AND PO13_StatusDelete=0"

            Dim ds = dbconn.fselectCommand(str)
            If ds IsNot Nothing Then


                ds.Tables(0).Columns.Add("JenisDok", GetType(String))
                Dim jenisdok = ""
                If ds.Tables(0).Rows.Count > 0 Then
                    For Each dr As DataRow In ds.Tables(0).Rows
                        jenisdok = dr.Item("PO13_JenisDok")
                        If jenisdok.Equals("A") Then
                            dr.Item("JenisDok") = "Syarat-syarat am"
                        ElseIf jenisdok.Equals("B") Then
                            dr.Item("JenisDok") = "Akaun Pembida"
                        ElseIf jenisdok.Equals("C") Then
                            dr.Item("JenisDok") = "Jaminan Pembekal"
                        ElseIf jenisdok.Equals("D") Then
                            dr.Item("JenisDok") = "MTO"
                        ElseIf jenisdok.Equals("E") Then
                            dr.Item("JenisDok") = "Jadual Penentuan Teknikal"
                        End If
                    Next

                    gvLampiran.DataSource = ds
                    gvLampiran.DataBind()

                    gvLampiran2.DataSource = ds
                    gvLampiran2.DataBind()
                Else
                    gvLampiran.DataSource = New List(Of ListItem)
                    gvLampiran.DataBind()

                    gvLampiran2.DataSource = New List(Of ListItem)
                    gvLampiran2.DataBind()
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub gvLampiran_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvLampiran.RowDeleting
        Try
            Dim index As Integer = e.RowIndex
            Dim filename = gvLampiran.Rows(index).Cells(1).Text
            Dim folderPath As String = Server.MapPath($"~/Upload/Document/PO/JualanNaskah/{txtIdNJ.Text}/")
            Dim tarikhDelete As String = Date.Now.Date.ToString("ddMMyyyyHHmmss")

            If String.IsNullOrEmpty(filename) Then
                fGlobalAlert("Tiada Dokumen untuk dihapuskan", Me.Page, Me.GetType())
                Exit Sub
            End If

            Dim filepathfile = folderPath + filename
            Dim renameFile = filename + "_" + tarikhDelete + "_forDelete"
            'Dim filepath = Request.Url.Authority + Request.ApplicationPath + filepathfile
            Dim destfilepathfile = folderPath + renameFile
            Dim fileInfo As New FileInfo(filepathfile)
            If fileInfo.Exists Then
                Dim strSql = $"UPDATE PO13_Lampiran SET PO13_StatusDelete=@StatusDlt, PO13_NamaDok=@NamaDok WHERE PO13_ID=@Id;"
                'Dim str = "DELETE FROM PO13_Lampiran where PO13_ID=@Id"
                Dim paramSql = {
                            New SqlParameter("@Id", gvLampiran.DataKeys(index).Value),
                            New SqlParameter("@StatusDlt", 1),
                            New SqlParameter("@NamaDok", renameFile)
                            }

                If dbconn.fUpdateCommand(strSql, paramSql) > 0 Then
                    fileInfo.MoveTo(destfilepathfile)
                    LabelMessage1.ForeColor = Color.Green
                    LabelMessage1.Text = "Dokumen telah dipadam!."
                    fLoadGVLampiran(txtIdNJ.Text)
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub lbtnNextView3_Click(sender As Object, e As EventArgs) Handles lbtnNextView3.Click
        mvNaskahJualan.SetActiveView(View4)
        KodStatus = 4
    End Sub

    Protected Sub lbtnPrev4_Click(sender As Object, e As EventArgs) Handles lbtnPrev4.Click
        mvNaskahJualan.SetActiveView(View3)
        KodStatus = 3
    End Sub

    Protected Sub chxRundinganTerus_CheckedChanged(sender As Object, e As EventArgs) Handles chxRundinganTerus.CheckedChanged
        If chxRundinganTerus.Checked Then
            ddlVendor.Enabled = True
            rfvddlVendor.Enabled = True
        Else
            ddlVendor.Enabled = False
            rfvddlVendor.Enabled = False
        End If
    End Sub


    Protected Sub lbtnSearch_Click(sender As Object, e As EventArgs) Handles lbtnSearch.Click
        If ddlVendor.SelectedValue = "" Then
            fGlobalAlert("Sila pilih Vendor!", Me.Page, Me.GetType())
            Exit Sub
        End If

        Dim sqlVend = $"SELECT ROC01_NoSya, ROC01_IDSem FROM  ROC01_Syarikat
WHERE ROC01_KodAktif = '01' AND ROC01_KodLulus = '1' AND LEFT(ROC01_IDSya, 2) = 'RC' AND ROC01_IDSya='{ddlVendor.SelectedValue}'"

        Using ds = dbconn.fselectCommand(sqlVend)
            Dim KodSub = Request.QueryString("KodSub")
            Response.Redirect($"~/FORMS/PENDAFTARAN SYARIKAT/SYARIKAT BERDAFTAR/Maklumat_Vendor.aspx?KodSub={KodSub}&KodSubMenu={ViewState("kodsubmenu")}&noSya={ds.Tables(0).Rows(0)(0).ToString}&noSem={ds.Tables(0).Rows(0)(1).ToString}")
        End Using


    End Sub


    Protected Sub BtnBatal_Click(sender As Object, e As EventArgs) Handles BtnBatal.Click
        Try
            Dim StatusBatal = "034"
            Dim paramSql() As SqlParameter = {}
            Dim tarikh = DateTime.Now
            Dim rCommit = False

            'Batal Naskah Jualan dan Permohonan Pembelian
            Dim strSql = $"UPDATE PO01_PPembelian Set PO01_StatusPP = @StatusPP WHERE PO01_NoMohon=@NoMohon;"
                Dim strSql2 = $"INSERT INTO PO10_StatusDok VALUES (@NoIDNJ,@NoMohon,'-',@StatusPP,@noStaff,@tarikh,@ulasan);"
                paramSql = {
                    New SqlParameter("@NoIDNJ", txtIdNJ.Text),
                    New SqlParameter("@NoMohon", lblNoPO1.Text),
                    New SqlParameter("@StatusPP", StatusBatal),
                    New SqlParameter("@noStaff", Session("ssusrID")),
                    New SqlParameter("@tarikh", tarikh),
                    New SqlParameter("@ulasan", "Batal Naskah Jualan dan Permohonan Pembelian")
                    }
                dbconn.sUpdateCommand(strSql + strSql2, paramSql, rCommit)

            If rCommit Then
                If ViewState("kodsubmenu") = "020301" Then
                    fGlobalAlert($"Rekod telah dibatalkan!", Me.Page, Me.[GetType](), "../../Perolehan/Jualan Naskah/Jualan_PTJ.aspx?KodSub=0203&KodSubMenu=020301")
                Else
                    fGlobalAlert($"Rekod telah dibatalkan!", Me.Page, Me.[GetType](), "../../Perolehan/Jualan Naskah/Jualan_Universiti.aspx?KodSub=0203&KodSubMenu=020302")
                End If
            Else
                fGlobalAlert($"Rekod tidak boleh disimpan! Sila hubungi Administrator.", Me.Page, Me.[GetType]())
            End If

        Catch ex As Exception

        End Try
    End Sub


End Class