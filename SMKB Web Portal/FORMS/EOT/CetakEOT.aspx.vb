Imports System.Globalization
Imports System.IO
Imports System.Collections
Imports System.Web.HttpFileCollection
Imports Microsoft.Office.Interop.Excel
Imports System.Drawing



Public Class CetakEOT
    Inherits System.Web.UI.Page
    Dim dbconn As New DBKewConn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       ' Dim nostaf As String = Request.QueryString("txtNoStaf")
        Dim nomohon As String = Request.QueryString("bilid")

        If nomohon IsNot Nothing Then
            fBindTransaksi(nomohon)
            fBindTransaksi_Details(nomohon)
            fBindTransaksi_Butir(nomohon)
        End If
    End Sub
     Private Sub fBindTransaksi(nomohon As String)
        If nomohon <> "" Then
            Dim strSql As String
            Dim strSql1 As String
            Dim strBulan As String
            Dim BulanP As String
            Dim strTahun As String


            '      strSql = $"select distinct  A.MS01_NOSTAF, A.MS01_NAMA,D.Singkatan,D.PEJABAT, E.No_Mohon,month(f.Tkh_Tuntut) as bulan,year(f.tkh_tuntut) as Tahun, g.jawgiliran,
            '      A.MS01_NoTelBimbit FROM VPeribadi A INNER JOIN [qa11].dbstaf.dbo.MS02_Perjawatan B ON A.MS01_NoStaf = B.MS01_NoStaf INNER JOIN
            '      [qa11].dbstaf.dbo.MS08_Penempatan C ON B.MS01_NoStaf = C.MS01_NoStaf and c.MS08_StaTerkini = 1 INNER JOIN [qa11].dbstaf.dbo.MS_Pejabat D 
            '       ON C.MS08_Pejabat = D.KodPejabat  AND A.MS01_Status =1 INNER JOIN  SMKB_EOT_Mohon_Hdr E   ON  A.MS01_NOSTAF = E.No_Staf  INNER JOIN SMKB_EOT_Mohon_Dtl f on e.No_Mohon = f.No_Mohon
            'INNER JOIN [qa11].dbstaf.dbo.MS_Jawatan G ON G.kodjawatan = B.MS02_JawSandang
            'WHERE E.No_Mohon = '{nomohon}'"

            strSql = $"select distinct  A.NoStaf, A.Nama,A.Singkat,A.NPejabat, E.No_Mohon,month(f.Tkh_Tuntut) as bulan,year(f.tkh_tuntut) as Tahun, a.JGiliran,
            A.NoTelBimbit FROM VPeribadi12 A INNER JOIN  SMKB_EOT_Mohon_Hdr E   ON  a.NoStaf = E.No_Staf  INNER JOIN SMKB_EOT_Mohon_Dtl f on e.No_Mohon = f.No_Mohon
            WHERE E.No_Mohon = '{nomohon}'"

            Dim ds = dbconn.fSelectCommand(strSql)
            Using dt = ds.Tables(0)
                If dt.Rows.Count > 0 Then
                    lblPejabat.InnerText = dt.Rows(0)("NPejabat").ToString
                    strBulan = dt.Rows(0)("bulan").ToString
                    strTahun = dt.Rows(0)("Tahun").ToString
                    If strBulan = "1" Then
                        lblBulTahun.InnerText = "JANUARI" & " " & strTahun
                    ElseIf strBulan = "2" Then

                        lblBulTahun.InnerText = "FEBUARI" & " " & strTahun
                    ElseIf strBulan = "3" Then

                        lblBulTahun.InnerText = "MAC" & " " & strTahun
                    ElseIf strBulan = "4" Then

                        lblBulTahun.InnerText = "APRIL" & " " & strTahun
                    ElseIf strBulan = "5" Then

                        lblBulTahun.InnerText = "MEI" & " " & strTahun
                    ElseIf strBulan = "6" Then

                        lblBulTahun.InnerText = "JUN" & " " & strTahun
                    ElseIf strBulan = "7" Then

                        lblBulTahun.InnerText = "JULAI" & " " & strTahun
                    ElseIf strBulan = "8" Then

                        lblBulTahun.InnerText = "OGOS" & " " & strTahun
                    ElseIf strBulan = "9" Then

                        lblBulTahun.InnerText = "SEPTEMBER" & " " & strTahun
                    ElseIf strBulan = "10" Then

                        lblBulTahun.InnerText = "OKTOBER" & " " & strTahun
                    ElseIf strBulan = "11" Then

                        lblBulTahun.InnerText = "NOVEMBER" & " " & strTahun
                    ElseIf strBulan = "12" Then
                        lblBulTahun.InnerText = "DISEMBER" & " " & strTahun

                    End If


                    lblNostaf.InnerText = dt.Rows(0)("NoStaf").ToString
                    lblNama.InnerText = dt.Rows(0)("Nama").ToString
                    lblJawatan.InnerText = dt.Rows(0)("JGiliran").ToString
                    lblNoTel.InnerText = dt.Rows(0)("NoTelBimbit").ToString
                    lblNoMohon.InnerText = nomohon


                End If
            End Using

            strSql1 =$" select RIGHT('00' + CAST(SUM(a.Jam) / 60 AS VARCHAR(2)), 2) +
             Right('00' + CAST(SUM(a.Jam) % 60 AS VARCHAR(2)), 2) AS JamTuntut from
             (SELECT    sum(convert(int,substring(Jum_Jam_Tuntut,1,2)) * 60 + convert(int,substring(Jum_Jam_Tuntut,3,2))) as Jam
             FROM SMKB_EOT_Mohon_Dtl WHERE        (No_Mohon = '{nomohon}')) a"
             Dim ds1 = dbconn.fSelectCommand(strSql1)
            Using dt = ds1.Tables(0)
                lblJumJam.InnerText =  dt.Rows(0)("JamTuntut").ToString
                lblJumJam1.InnerText =  dt.Rows(0)("JamTuntut").ToString
                lblJumJam2.InnerText =  dt.Rows(0)("JamTuntut").ToString
            End Using
            'dapatkan jum jam tuntut

        End If
    End Sub

    Private Sub fBindTransaksi_Details(nomohon As String)
        If nomohon <> "" Then
            Dim strSql As String

            strSql = $"SELECT  ROW_NUMBER() OVER (ORDER BY No_Mohon) AS Bil, No_Mohon, No_Turutan, Tkh_Tuntut, Jam_Mula, Jam_Tamat, Jum_Jam_Tuntut,
        case when  Kadar_Tuntut = '1.125' then '1' when  Kadar_Tuntut = '1.125' THEN '2' when Kadar_Tuntut = '1.250' then 3
        when Kadar_Tuntut = '1.500' then 4 when  Kadar_Tuntut = '2.000' then 4 end as StatusHari
        FROM            SMKB_EOT_Mohon_Dtl  WHERE        (No_Mohon = '{nomohon}') order by Tkh_Tuntut,No_Turutan "
            Dim ds = dbconn.fSelectCommand(strSql)
            If ds IsNot Nothing Then
                Dim dt = ds.Tables(0)

                EOTransaksi.DataSource = dt
                EOTransaksi.DataBind()

            End If
        End If
    End Sub
      Private Sub fBindTransaksi_Butir(nomohon As String)
        If nomohon <> "" Then
            Dim strSql As String

            strSql = $"Select distinct  DENSE_RANK() OVER (ORDER BY No_Mohon) AS Bil, Tkh_Tuntut,Tujuan ,Catatan from  SMKB_EOT_Mohon_Dtl 
            WHERE (No_Mohon = '{nomohon}') order by Tkh_Tuntut,Tujuan ,Catatan"
            Dim ds = dbconn.fSelectCommand(strSql)
            If ds IsNot Nothing Then
                Dim dt = ds.Tables(0)

                EOTButir.DataSource = dt
                EOTButir.DataBind()

            End If
        End If
    End Sub
End Class