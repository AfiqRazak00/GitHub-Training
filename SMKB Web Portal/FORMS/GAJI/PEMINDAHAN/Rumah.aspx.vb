Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO
Imports System.Data.OleDb
Imports System.Runtime.Remoting.Messaging
Imports Newtonsoft.Json
Imports System
Imports System.Security.Policy
Imports System.Runtime.Remoting.Contexts

Public Class Rumah
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
        Where Bulan = '" & month & "' And tahun = '" & year & "' And a.Kod_Trans in ('PPK','PPK2','PPK4')", DBCon)
        dr2 = cmd2.ExecuteReader
        While dr2.Read()

            sjumrekod = dr2(1)


            Me.jumrekod.Text = sjumrekod.ToString()


            stotalpcb = dr2(0).ToString()
            Me.jumpcb.Text = stotalpcb.ToString()

        End While
        dr2.Close()
        ClientScript.RegisterStartupScript([GetType](), "alert", "testJv();", True)


    End Sub
    Function GetMonth(bln)
        If bln < 10 Then
            GetMonth = "0" & bln
        Else
            GetMonth = bln
        End If
    End Function
    Private Sub eksport()
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
            Dim blnpot As String
            Dim nokerajaan As String

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

            blnpot = year + month

            Dim strSql = "select count(*) as bil from smkb_gaji_lejar  where Kod_Trans in ('PPK','PPK2','PPK4') and Bulan='" & month & "' and Tahun='" & year & "'"
            Dim intCnt As Integer = dbconn.fSelectCount(strSql)
            If intCnt = 0 Then
                lblModalMessaage.Text = "Tiada rekod untuk diproses!"
                ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                Exit Sub
            End If


            nokerajaan = "4003"

            If Len(nokerajaan) >= 10 Then
                nokerajaan = Left(nokerajaan, 10)
            Else
                nokerajaan = nokerajaan + space(10 - Len(nokerajaan))
            End If

            filePath = System.Web.HttpContext.Current.Server.MapPath("~\Upload\Document\PENDAHULUAN DAN TUNTUTAN\PD\Rumah.txt")
            'Dim strPath As String = "C:\Cukai.txt"
            If System.IO.File.Exists(filePath) Then
                System.IO.File.Delete(filePath)
            End If

            w = File.AppendText(filePath)


            DBCon.Open()
            cmd = New SqlCommand("select distinct a.no_staf, isnull(b.ms01_nama,'') ms01_nama,isnull(c.No_Trans,'') No_Trans,b.ms01_kpb,b.ms01_nopasport,a.amaun amaun
                from smkb_gaji_lejar a inner Join [qa11].dbstaf.dbo.ms01_peribadi b on a.no_staf=b.ms01_nostaf inner join
		        SMKB_Gaji_Master c on a.No_Staf = c.No_Staf and a.Kod_Trans = c.Kod_Trans where bulan='" & month & "' and tahun ='" & year & "' and a.Kod_Trans in ('PPK','PPK2','PPK4')", DBCon)

            dr = cmd.ExecuteReader

            While dr.Read()
                nama = dr(1)

                If Len(nama) >= 50 Then
                    nama = Left(nama, 50)
                Else
                    nama = nama + Space(50 - Len(nama))
                End If


                'no akaun tabung haji
                noakaun = dr(2)

                If Len(noakaun) >= 10 Then
                    noakaun = Right(noakaun, 10)
                Else
                    noakaun = Space(10 - Len(noakaun)) + noakaun
                End If


                kpbaru = ""
                kpbaru = dr(3).ToString.Trim()

                If kpbaru <> "" Then
                    ls_firstKPL = ""
                    ls_firstKPL = Left(kpbaru, 1)
                    If IsNumeric(ls_firstKPL) = True Then
                        If Len(kpbaru) >= 12 Then
                            kpbaru = Right(kpbaru, 12)
                        Else
                            kpbaru = kpbaru + Space(12 - Len(kpbaru))
                        End If
                    Else
                        If Len(kpbaru) > 1 Then
                            kpbaru = Mid(kpbaru, 2)
                            If Len(kpbaru) >= 12 Then
                                kpbaru = ls_firstKPL + Right(kpbaru, 12)
                            Else
                                kpbaru = ls_firstKPL + Space(12 - Len(kpbaru)) + kpbaru
                            End If
                        Else
                            kpbaru = ls_firstKPL + Space(12)
                        End If
                    End If
                Else
                    kpbaru = " " + Space(12)
                End If

                nostaf = dr(0)
                If Len(nostaf) >= 10 Then
                    nostaf = Left(nostaf, 10)
                Else
                    nostaf = nostaf + Space(10 - Len(nostaf))
                End If

                jumpcb = dr(5).ToString()

                jumpcb = jumpcb.ToString.Replace("."c, "")

                If Len(jumpcb) >= 7 Then
                    jumpcb = Right(jumpcb, 7)
                Else
                    jumpcb = jumpcb.PadRight(7, "0"c)
                End If

                strWrite = nokerajaan + kpbaru + noakaun + nama + jumpcb
                w.WriteLine(strWrite)

                success = 1
            End While
            dr.Close()

            w.Close()


            Dim response As System.Web.HttpResponse = System.Web.HttpContext.Current.Response
            response.Write("<script>alert('OK')</script>")

            response.ClearContent()
            response.Clear()
            response.ContentType = "text/plain"
            response.AddHeader("Content-Disposition", "attachment; filename=Rumah.txt;")
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