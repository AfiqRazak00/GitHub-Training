﻿Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO
Imports System.Data.OleDb
Imports System.Runtime.Remoting.Messaging
Imports Newtonsoft.Json
Imports System
Imports System.Security.Policy
Imports System.Security.Cryptography

Public Class Tabung_Haji
    Inherits System.Web.UI.Page
    Dim dbconn As New DBKewConn
    Dim dbconnSM As New DBSMConn
    Public dsKod As New DataSet
    Public dvKodKW As New DataView
    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim w As StreamWriter

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'fBindGvJenis()
            Me.txtTarikh.Value = CStr(Year(Now)) + "-" + CStr(Month(Now))

        End If
    End Sub
    Protected Sub btnExport_Click(sender As Object, e As EventArgs)
        'Dim strConnx As String = "Data Source=devmis12.utem.edu.my;Initial Catalog=dbKewanganV4;Persist Security Info=True;User ID=smkb;Password=Smkb@Dev2012"
        Dim DBCon As New SqlConnection(strCon)
        Dim cmd2 = New SqlCommand
        Dim dr2 As SqlDataReader
        Dim stotalpcb As String
        Dim success As Integer
        Dim sblnthn As String
        Dim sjumrekod As String
        Dim sjumpcb As String
        Dim blnthn As DateTime = Convert.ToDateTime(Me.txtTarikh.Value.Trim())
        Dim month As String = blnthn.ToString("MM")
        Dim year As String = blnthn.ToString("yyyy")


        DBCon.Open()

        cmd2 = New SqlCommand("Select sum(a.amaun) jum,count(a.no_staf) As bilstaf
        From smkb_gaji_lejar a inner Join [qa11].dbstaf.dbo.ms01_peribadi b on a.no_staf=b.ms01_nostaf 
        Where Bulan = '" & month & "' And tahun = '" & year & "' And a.Kod_Trans ='TH01'", DBCon)
        dr2 = cmd2.ExecuteReader
            While dr2.Read()

            sjumrekod = dr2(1)


            Me.jumrekod.Text = sjumrekod.ToString()


            stotalpcb = dr2(0).ToString()
            Me.jumpcb.Text = stotalpcb.ToString()

        End While
        dr2.Close()
        ClientScript.RegisterStartupScript([GetType](), "alert", "testJv();", True)
        'eksport()

    End Sub
    Function GetMonth(bln)
        If bln < 10 Then
            GetMonth = "0" & bln
        Else
            GetMonth = bln
        End If
    End Function

    Private Sub eksport()
        'Dim strConnx As String = "Data Source=devmis12.utem.edu.my;Initial Catalog=dbKewanganV4;Persist Security Info=True;User ID=smkb;Password=Smkb@Dev2012"
        Dim DBCon As New SqlConnection(strCon)
        Dim cmd = New SqlCommand
        Dim cmd1 = New SqlCommand
        Try


            Dim dr, dr1, dr2 As SqlDataReader
            Dim nama, nostaf, kpbaru, nopasport, jumpcb As String
            Dim stotalpcb As String
            Dim success As Integer
            Dim sblnthn As String
            Dim sjumrekod As String
            Dim sjumall As String
            Dim strWrite As String
            Dim ls_firstKPL As String
            Dim noakaun As String
            'Open the connection.

            Dim db = New DBKewConn
            Dim thngj As String = ""
            Dim blngj As String = ""
            Dim blnsblm As Integer = 0
            Dim thnnsblm As Integer = 0
            Dim filePath As String = ""
            Dim iHash As Long
            Dim jumHash As Long
            Dim S_hash As String

            success = 0
            sblnthn = Me.txtTarikh.Value
            If sblnthn = "" Then
                lblModalMessaage.Text = "Sila masukkan pilihan bulan dan tahun!"
                ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                Exit Sub
            End If

            Dim blnthn As DateTime = Convert.ToDateTime(Me.txtTarikh.Value.Trim())
            Dim month As String = blnthn.ToString("MM")
            Dim year As String = blnthn.ToString("yyyy")

            Dim yrmth As String = Me.txtTarikh.Value



            If Len(year) >= 4 Then
                year = Right(year, 4)
            Else
                year = year.PadLeft(4, "0"c)
            End If

            Dim strSql = "select count(*) as bil from smkb_gaji_lejar  where Kod_Trans='TH01' and Bulan='" & month & "' and Tahun='" & year & "'"
            Dim intCnt As Integer = dbconn.fSelectCount(strSql)
            If intCnt = 0 Then
                lblModalMessaage.Text = "Tiada rekod untuk diproses!"
                ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                Exit Sub
            End If


            filePath = System.Web.HttpContext.Current.Server.MapPath("~\Upload\Document\PENDAHULUAN DAN TUNTUTAN\PD\Tabung_Haji.txt")
            'Dim strPath As String = "C:\Cukai.txt"
            If System.IO.File.Exists(filePath) Then
                System.IO.File.Delete(filePath)
            End If

            w = File.AppendText(filePath)

            strWrite = "H1UTEM010801SW0030" + month + year
            w.WriteLine(strWrite)

            DBCon.Open()
            cmd = New SqlCommand("select distinct a.no_staf, isnull(b.ms01_nama,'') ms01_nama,isnull(c.No_Trans,'') No_Trans,b.ms01_kpb,b.ms01_nopasport,a.amaun amaun
                from smkb_gaji_lejar a inner Join [qa11].dbstaf.dbo.ms01_peribadi b on a.no_staf=b.ms01_nostaf inner join
		        SMKB_Gaji_Master c on a.No_Staf = c.No_Staf and a.Kod_Trans = c.Kod_Trans where bulan='" & month & "' and tahun ='" & year & "' and a.Kod_Trans='TH01'", DBCon)

            dr = cmd.ExecuteReader

            While dr.Read()
                nama = dr(1)

                If Len(nama) >= 40 Then
                    nama = Left(nama, 40)
                Else
                    nama = nama + Space(40 - Len(nama))
                End If


                'no akaun tabung haji
                noakaun = dr(2)
                If noakaun = "" Or noakaun = "-" Then
                    noakaun = ""
                    iHash = 0
                Else

                    noakaun = noakaun
                    iHash = CLng(Right(noakaun, 4))

                End If


                If Len(noakaun) >= 15 Then
                    noakaun = Right(noakaun, 15)
                Else
                    noakaun = Space(15 - Len(noakaun)) + noakaun
                End If

                jumHash = jumHash + iHash

                kpbaru = ""
                kpbaru = dr(3)

                If kpbaru <> "" Then
                    ls_firstKPL = ""
                    ls_firstKPL = Left(kpbaru, 1)
                    If IsNumeric(ls_firstKPL) = True Then
                        If Len(kpbaru) >= 14 Then
                            kpbaru = Right(kpbaru, 14)
                        Else
                            kpbaru = kpbaru + Space(14 - Len(kpbaru))
                        End If
                    Else
                        If Len(kpbaru) > 1 Then
                            kpbaru = Mid(kpbaru, 2)
                            If Len(kpbaru) >= 14 Then
                                kpbaru = ls_firstKPL + Right(kpbaru, 14)
                            Else
                                kpbaru = ls_firstKPL + Space(14 - Len(kpbaru)) + kpbaru
                            End If
                        Else
                            kpbaru = ls_firstKPL + Space(14)
                        End If
                    End If
                Else
                    kpbaru = Space(12)
                End If


                kpbaru = dr(3).ToString.Trim()

                If Len(kpbaru) >= 12 Then
                    kpbaru = Left(kpbaru, 12)
                Else
                    kpbaru = kpbaru + Space(12 - Len(kpbaru))
                End If


                If kpbaru <> "" Then
                    ls_firstKPL = ""
                    ls_firstKPL = Left(kpbaru, 1)
                    If IsNumeric(ls_firstKPL) = True Then
                        If Len(kpbaru) >= 14 Then
                            kpbaru = Right(kpbaru, 14)
                        Else
                            kpbaru = kpbaru + Space(14 - Len(kpbaru))
                        End If
                    Else
                        If Len(kpbaru) > 1 Then
                            kpbaru = Mid(kpbaru, 2)
                            If Len(kpbaru) >= 14 Then
                                kpbaru = ls_firstKPL + Right(kpbaru, 14)
                            Else
                                kpbaru = ls_firstKPL + Space(14 - Len(kpbaru)) + kpbaru
                            End If
                        Else
                            kpbaru = ls_firstKPL + Space(14)
                        End If
                    End If
                Else
                    kpbaru = " " + Space(12)
                End If

                nopasport = dr(4)
                If Len(nopasport) >= 12 Then
                    nopasport = Left(nopasport, 12)
                Else
                    nopasport = nopasport + Space(12 - Len(nopasport))
                End If

                nostaf = dr(0)
                If Len(nostaf) >= 20 Then
                    nostaf = Left(nostaf, 20)
                Else
                    nostaf = nostaf + Space(20 - Len(nostaf))
                End If

                jumpcb = dr(5).ToString()

                jumpcb = jumpcb.ToString.Replace("."c, "")

                If Len(jumpcb) >= 11 Then
                    jumpcb = Right(jumpcb, 11)
                Else
                    jumpcb = jumpcb.PadRight(11, "0"c)
                End If

                strWrite = "0" + noakaun + kpbaru + nama + jumpcb + nostaf
                w.WriteLine(strWrite)

                success = 1
            End While
            dr.Close()

            cmd1 = New SqlCommand("select sum(a.amaun) jum,count(a.no_staf) as bilstaf
		    from smkb_gaji_lejar a inner Join [qa11].dbstaf.dbo.ms01_peribadi b on a.no_staf=b.ms01_nostaf 
            where bulan='" & month & "' and tahun ='" & year & "' and a.Kod_Trans='TH01'", DBCon)
            dr1 = cmd1.ExecuteReader
            While dr1.Read()

                sjumrekod = dr1(1)

                sjumall = dr1(0).ToString()

                If Len(sjumrekod) >= 6 Then
                    sjumrekod = Left(sjumrekod, 6)
                Else
                    sjumrekod = sjumrekod.PadLeft(6, "0"c)
                End If

                sjumall = sjumall.ToString.Replace("."c, "")

                If Len(sjumall) >= 13 Then
                    sjumall = Right(sjumall, 13)

                Else
                    sjumall = sjumall.PadLeft(13, "0"c)

                End If

                S_hash = jumHash.ToString()
                If Len(S_hash) >= 20 Then
                    S_hash = Left(S_hash, 20)
                Else
                    S_hash = S_hash.PadLeft(12, "0"c)
                End If

                strWrite = "FF" + sjumrekod + sjumall + S_hash
                ' nocukai = Trim(rs("nocukai"))
                w.WriteLine(strWrite)
            End While
            dr1.Close()



            w.Close()


            'jumrekod.Text = "10101"
            Dim response As System.Web.HttpResponse = System.Web.HttpContext.Current.Response
            response.Write("<script>alert('OK')</script>")

            response.ClearContent()
            response.Clear()
            response.ContentType = "text/plain"
            response.AddHeader("Content-Disposition", "attachment; filename=Tabung_Haji.txt;")
            response.TransmitFile(filePath)
            response.Flush()
            Context.ApplicationInstance.CompleteRequest()
            'response.[End]()

            DBCon.Close()
            DBCon.Dispose()

        Catch ex As Exception
            lblModalMessaage.Text = "Gagal." 'message di modal
            ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try

    End Sub
    Protected Sub HiddenButton_Click(sender As Object, e As EventArgs)
        eksport()

        'lblModalMessaage.Text = "Rekod baru telah disimpan." 'message di modal
        'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
    End Sub
End Class