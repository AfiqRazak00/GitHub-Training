Imports System.Globalization

Public Class Pembelian_Terus
    Inherits System.Web.UI.Page

    Private dbconn As New DBKewConn

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                fBindDdlStatus()
                fBindGVJualanPTj("")
                txtTahun.Text = Date.Now.Year.ToString

            End If
        Catch ex As Exception

        End Try
    End Sub

    ''' <summary>
    ''' Bind data BG_StatusDokBaru and load to dropdownlist
    ''' </summary>
    Private Sub fBindDdlStatus()
        Try
            Dim strSql As String = "Select Kod, Butiran from PO_StatusPP Where SubModul='JN' OR Kod='006' ORDER BY Kod"

            Dim ds As New DataSet

            ds = dbconn.fselectCommand(strSql)

            ddlStatus.DataSource = ds
            ddlStatus.DataTextField = "Butiran"
            ddlStatus.DataValueField = "Kod"
            ddlStatus.DataBind()

            ddlStatus.Items.Insert(0, New ListItem("-KESELURUHAN-", ""))
            ddlStatus.SelectedIndex = 0
        Catch ex As Exception
            'fErrorLog("Peruntukan_KW.aspx(fBindDdlKW)- " & ex.Message.ToString)
        End Try
    End Sub

    Private Sub fBindGVJualanPTj(KodStatus As String)
        Try
            Dim strSql As String = ""
            If KodStatus = String.Empty Then
                strSql = $"SELECT a.PO01_NoMohon, PO01_Tujuan, PO01_JenisBrg,PO02_JualanID, PO02_TrkMasaMulaIklan,PO02_TrkMasaTamatPO,PO01_StatusPP, c.Butiran AS ButiranStatus, d.Butiran AS ButiranBrg 
FROM PO01_PPembelian a
LEFT JOIN PO02_NaskahJualan b ON a.PO01_NoMohon = b.PO01_NoMohon
LEFT JOIN PO_StatusPP c ON a.PO01_StatusPP = c.Kod
LEFT JOIN PO_JenisItem d ON a.PO01_JenisBrg = d.Kod
WHERE PO01_Status='A' AND PO01_Tahun={Date.Now.Year} AND (a.PO01_FlagVendor = 0) AND 
(PO01_StatusPP='006' OR PO01_StatusPP='031' OR PO01_StatusPP='032') 
AND PO01_KodPtjMohon='{Session("ssusrKodPTj")}'
AND (PO01_JenisDok='P04') ORDER BY PO01_StatusPP"
            Else
                strSql = $"SELECT a.PO01_NoMohon, PO01_Tujuan, PO01_JenisBrg,PO02_JualanID, PO02_TrkMasaMulaIklan,PO02_TrkMasaTamatPO,PO01_StatusPP, c.Butiran AS ButiranStatus, d.Butiran AS ButiranBrg 
FROM PO01_PPembelian a
LEFT JOIN PO02_NaskahJualan b ON a.PO01_NoMohon = b.PO01_NoMohon
LEFT JOIN PO_StatusPP c ON a.PO01_StatusPP = c.Kod
LEFT JOIN PO_JenisItem d ON a.PO01_JenisBrg = d.Kod
WHERE PO01_Status='A' AND PO01_Tahun={Date.Now.Year} AND (a.PO01_FlagVendor = 0) AND PO01_StatusPP='{KodStatus}' 
AND PO01_KodPtjMohon='{Session("ssusrKodPTj")}'
AND (PO01_JenisDok='P04') ORDER BY PO01_StatusPP"
            End If
            'Dim ds = dbconn.fselectCommand(strSql)
            Dim dt = fCreateDt(strSql) 'ds.Tables(0) 'fCreateDt(strSql)

            gvPO.DataSource = dt
            gvPO.DataBind()

        Catch ex As Exception

        End Try
    End Sub

    Private Function fCreateDt(strSql As String) As DataTable

        Using dt = dbconn.fSelectCommandDt(strSql)
            Dim strDate As DateTime = Nothing
            dt.Columns.Add("TarikhMasaMulaIklan", GetType(String))
            dt.Columns.Add("TarikhMasaTamatPO", GetType(String))
            For Each row As DataRow In dt.Rows
                If IsDBNull(row("PO02_TrkMasaMulaIklan")) Then
                    row("TarikhMasaMulaIklan") = ""
                Else
                    strDate = row("PO02_TrkMasaMulaIklan")
                    row("TarikhMasaMulaIklan") = strDate.ToString("dddd, dd MMMM yyyy, hh:mm tt", CultureInfo.CreateSpecificCulture("ms-MY")) '("dd/MM/yyyy HH:mm") 
                End If

                If IsDBNull(row("PO02_TrkMasaTamatPO")) Then
                    row("TarikhMasaTamatPO") = ""
                Else
                    strDate = row("PO02_TrkMasaTamatPO")
                    row("TarikhMasaTamatPO") = strDate.ToString("dddd, dd MMMM yyyy, hh:mm tt", CultureInfo.CreateSpecificCulture("ms-MY")) '("dd/MM/yyyy HH:mm") 
                End If
            Next
            Return dt
        End Using
    End Function

    Protected Sub ddlStatus_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlStatus.SelectedIndexChanged
        fBindGVJualanPTj(ddlStatus.SelectedValue)
    End Sub

    Protected Sub gvPO_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvPO.SelectedIndexChanged
        Dim selectedRow As GridViewRow = gvPO.SelectedRow
        Dim NoPO As String = selectedRow.Cells(1).Text
        Dim NoNJ As String = selectedRow.Cells(4).Text

        ' Convert the row index stored in the CommandArgument
        ' property to an Integer.
        Dim KodSubMenu = Request.QueryString("KodSubMenu")
        Dim KodSub = Request.QueryString("KodSub")

        'Open other page.
        Response.Redirect($"~/FORMS/Perolehan/Jualan Naskah/Naskah_Jualan.aspx?KodSub={KodSub}&KodSubMenu={KodSubMenu}&NoPO={NoPO}&NoNJ={NoNJ}&Jenis=Ptj")
    End Sub
End Class