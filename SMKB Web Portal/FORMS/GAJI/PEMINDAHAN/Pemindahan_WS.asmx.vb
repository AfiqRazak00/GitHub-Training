Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic


Imports System.Drawing
Imports System.Globalization

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration
Imports AjaxControlToolkit
Imports System.Reflection
Imports System
Imports Microsoft.Office.Interop.Excel
Imports System.IO

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Pemindahan_WS
    Inherits System.Web.Services.WebService
    Dim w As StreamWriter

    Public Function HelloWorld() As String
        Return "Hello World"
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRumusCukai(month As Integer, year As Integer)
        Dim db As New DBKewConn

        Dim query As String = $"select sum(z.pcb) as pcb,sum(z.cp38) as cp,sum(z.bilpcb) as bilpcb,sum(z.bilcp) as bilcp,(select no_cukai from SMKB_Gaji_No_Majikan) as nocukai from (
        select sum(a.amaun) pcb,
        isnull((select sum(c.amaun) from smkb_gaji_lejar c where c.No_Staf=a.No_Staf and c.Jenis_Trans='T' and c.Kod_Trans='CP38' and c.Bulan='{month}' and c.Tahun='{year}'),0) as cp38,
        count(a.no_staf) as bilpcb, isnull((select count(c.no_staf) from smkb_gaji_lejar c where c.No_Staf=a.No_Staf and c.Jenis_Trans='T' and c.Kod_Trans='CP38' and c.Bulan='{month}' and c.Tahun='{year}'),0) as bilcp
        from smkb_gaji_lejar a inner Join [qa11].dbstaf.dbo.ms01_peribadi_1 b on a.no_staf=b.ms01_nostaf 
        where bulan='{month}' and tahun ='{year}' and Jenis_Trans='T' group by a.no_staf)z;"

        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)

    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PindahCukai(sblnthn As String)

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim dr, dr1, dr2 As SqlDataReader
        Dim nama, nocukai, kodisteri, act_cukai, nostaf, negara, kplama, kpbaru, nopasport, jumpcb As String
        Dim stotalpcb As String
        Dim success As Integer
        'Dim sblnthn As String
        Dim sjumrekod As String
        Dim sjumpcb As String
        Dim strWrite As String
        Dim dbconn As New DBKewConn
        Dim cmd = New SqlCommand
        'Open the connection.

        Dim db = New DBKewConn
        Dim thngj As String = ""
        Dim blngj As String = ""
        Dim blnsblm As Integer = 0
        Dim thnnsblm As Integer = 0
        Dim filePath As String = ""
        Dim DBCon As New SqlConnection(strCon)
        success = 0
        'sblnthn = Me.txtTarikh.Value
        If sblnthn = "" Then
            resp.Failed("Sila masukkan pilihan bulan dan tahun!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim blnthn As DateTime = Convert.ToDateTime(sblnthn.Trim())
        Dim month As String = blnthn.ToString("MM")
        Dim year As String = blnthn.ToString("yyyy")

        'Dim yrmth As String = Me.txtTarikh.Value



        If Len(year) >= 4 Then
            year = Right(year, 4)
        Else
            year = year.PadLeft(4, "0"c)
        End If

        Dim strSql = "select count(*) as bil from smkb_gaji_lejar  where (Jenis_Trans='T' or Kod_Trans='CP38') and Bulan='" & month & "' and Tahun='" & year & "'"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt = 0 Then

            resp.Failed("Tiada rekod untuk diproses!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If




        filePath = System.Web.HttpContext.Current.Server.MapPath("~\Upload\Document\PENDAHULUAN DAN TUNTUTAN\PD\Cukai.txt")

        If System.IO.File.Exists(filePath) Then
            System.IO.File.Delete(filePath)
        End If

        w = File.AppendText(filePath)
        DBCon.Open()
        cmd = New SqlCommand("select sum(z.pcb) as pcb,sum(z.cp38) as cp,sum(z.bilpcb) as bilpcb,sum(z.bilcp) as bilcp,(select no_cukai from SMKB_Gaji_No_Majikan) as nocukai from (
        select sum(a.amaun) pcb,
        isnull((select sum(c.amaun) from smkb_gaji_lejar c where c.No_Staf=a.No_Staf and c.Jenis_Trans='T' and c.Kod_Trans='CP38' and c.Bulan='" & month & "' and c.Tahun='" & year & "'),0) as cp38,
        count(a.no_staf) as bilpcb, isnull((select count(c.no_staf) from smkb_gaji_lejar c where c.No_Staf=a.No_Staf and c.Jenis_Trans='T' and c.Kod_Trans='CP38' and c.Bulan='" & month & "' and c.Tahun='" & year & "'),0) as bilcp
        from smkb_gaji_lejar a inner Join [qa11].dbstaf.dbo.ms01_peribadi b on a.no_staf=b.ms01_nostaf 
        where bulan='" & month & "' and tahun ='" & year & "' and Jenis_Trans='T' group by a.no_staf)z", DBCon)
        dr1 = cmd.ExecuteReader
        While dr1.Read()
            nocukai = dr1(4)
            sjumrekod = dr1(2)
            If Len(nocukai) > 0 Then
                For j = 1 To Len(nocukai)
                    If IsNumeric(Mid(nocukai, j, 1)) = True Then
                        nocukai = nocukai + Mid(nocukai, j, 1)
                    End If
                Next
            End If



            If Len(nocukai) >= 10 Then
                nocukai = Right(nocukai, 10)
            Else
                nocukai = nocukai.PadLeft(10, "0"c)
            End If
            's_header = "H" + s_act_kerajaan + s_act_kerajaan + s_year + GetMonth(s_mth) + CStr(s_sum_pcb) + CStr(s_count_pcb) + CStr(s_sum_cp38) + CStr(s_count_cp38)

            stotalpcb = dr1(0).ToString()

            stotalpcb = stotalpcb.ToString.Replace("."c, "")

            If Len(stotalpcb) >= 11 Then
                stotalpcb = Right(stotalpcb, 11)
            Else
                stotalpcb = stotalpcb.PadLeft(11, "0"c)
            End If
            strWrite = "H" + nocukai + year + stotalpcb
            ' nocukai = Trim(rs("nocukai"))
            w.WriteLine(strWrite)
        End While
        dr1.Close()



        cmd = New SqlCommand("select a.no_staf, b.ms01_nama,isnull(b.ms01_nocukai,'') as ms01_nocukai,b.ms01_kpb,b.ms01_kpl,b.ms01_nopasport,sum(a.amaun) pcb,
        isnull((select sum(c.amaun) from smkb_gaji_lejar c where c.No_Staf=a.No_Staf and c.Jenis_Trans='T' and c.Kod_Trans='CP38' and c.Bulan='" & month & "' and c.Tahun='" & year & "'),0) as cp38
        from smkb_gaji_lejar a inner Join [qa11].dbstaf.dbo.ms01_peribadi b on a.no_staf=b.ms01_nostaf 
        where bulan='" & month & "' and tahun ='" & year & "' and Jenis_Trans='T' group by a.no_staf, b.ms01_nama,b.ms01_nocukai,b.ms01_kpb,b.ms01_kpl,b.ms01_nopasport", DBCon)

        dr = cmd.ExecuteReader

        While dr.Read()
            nama = dr(1)
            'If IsNull(nama) = True Or nama = "" Then
            '    s_nama_staf = ""
            'End If
            If Len(nama) >= 60 Then
                nama = Left(nama, 60)
            Else
                nama = nama + Space(60 - Len(nama))
            End If

            kplama = dr(5)
            If Len(kplama) >= 12 Then
                kplama = Left(kplama, 12)
            Else
                kplama = kplama + Space(12 - Len(kplama))
            End If


            kpbaru = dr(4)
            If Len(kpbaru) >= 12 Then
                kpbaru = Left(kpbaru, 12)
            Else
                kpbaru = kpbaru + Space(12 - Len(kpbaru))
            End If

            nopasport = dr(5)
            If Len(nopasport) >= 12 Then
                nopasport = Left(nopasport, 12)
            Else
                nopasport = nopasport + Space(12 - Len(nopasport))
            End If

            nostaf = dr(0)
            If Len(nostaf) >= 10 Then
                nostaf = Left(nostaf, 10)
            Else
                nostaf = nostaf + Space(10 - Len(nostaf))
            End If

            negara = Space(2)

            nocukai = dr(2)
            If nocukai = "" Or nocukai = "-" Then
                nocukai = ""
            End If

            kodisteri = ""
            act_cukai = ""

            If Len(nocukai) > 0 Then
                For j = 1 To Len(nocukai)
                    If IsNumeric(Mid(nocukai, j, 1)) = True Then
                        act_cukai = act_cukai + Mid(nocukai, j, 1)
                    ElseIf InStr(Mid(nocukai, j, 1), "(") <> 0 Then
                        kodisteri = Mid(nocukai, j + 1, 1)
                        Exit For
                    End If
                Next
            End If

            If Len(act_cukai) >= 10 Then
                act_cukai = Right(act_cukai, 10)
            Else
                act_cukai = act_cukai.PadLeft(10, "0"c)
            End If

            kodisteri = "0"

            jumpcb = dr(6).ToString()

            sjumpcb = jumpcb.ToString.Replace("."c, "")

            'If Len(sjumpcb) >= 9 Then
            '    sjumpcb = Right(sjumpcb, 9)
            'Else
            '    sjumpcb = 9 - Len(sjumpcb), "0") & CStr(sjumpcb)
            'End If

            strWrite = "D" + act_cukai + kodisteri + nama + kplama + kpbaru + nopasport + negara + sjumpcb + nostaf
            ' nocukai = Trim(rs("nocukai"))
            w.WriteLine(strWrite)

            success = 1
        End While
        dr.Close()
        'If success = 1 Then
        '    lblModalMessaage.Text = "Data selesai dieksport."
        '    ClientScript.RegisterStartupScript([GetType](), "alert", "testJv();", True)
        'End If

        'ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "MyJSFunction", "testJv();", True)

        w.Close()


        'jumrekod.Text = "10101"
        Dim response As System.Web.HttpResponse = System.Web.HttpContext.Current.Response
        response.Write("<script>alert('OK')</script>")

        response.ClearContent()
        response.Clear()
        response.ContentType = "text/plain"
        response.AddHeader("Content-Disposition", "attachment; filename=Cukai.txt;")
        response.TransmitFile(filePath)
        response.Flush()
        Context.ApplicationInstance.CompleteRequest()
        'response.[End]()

        DBCon.Close()
        DBCon.Dispose()
    End Function
End Class