Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols

Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System
Imports SMKB_Web_Portal.Perkeso

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Utiliti_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListSocsoHdr() As String
        Dim resp As New ResponseRepository


        dt = getListSocsoHdr()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    Public Function getListSocsoHdr() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "Select kod, butiran from smkb_gaji_perkeso_hdr order by kod"

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListDetSocso(ByVal kodhdr As String) As String
        Dim resp As New ResponseRepository


        dt = GetListDetSocso(kodhdr)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function GetListDetSocso(kodhdr As String) As DataTable
        Dim db = New DBKewConn

        Dim dt As New DataTable

        Dim query As String = $"select kod, amaun, perkeso_pek, perkeso_maj from smkb_gaji_perkeso_dtl where kod = '{kodhdr}'"
        Return db.Read(query)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateHdrSocso(DataSocsoHdr As DataSocsoHdr) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataSocsoHdr Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If fUpdateHdr(DataSocsoHdr) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If

        If success = 1 Then
            Session("Kod") = DataSocsoHdr.Kod
            resp.Success("Rekod berjaya disimpan", "00", DataSocsoHdr)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function
    Private Function fUpdateHdr(DataSocsoHdr As DataSocsoHdr)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal = 0
        Dim staMaster As String = ""


        Dim query As String = "UPDATE SMKB_Gaji_Perkeso_Hdr SET Butiran = @jenis where Kod = @kod"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@jenis", DataSocsoHdr.Butiran))
        param.Add(New SqlParameter("@kod", DataSocsoHdr.Kod))

        Return db.Process(query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanSocsoHdr(DataSocsoHdr As DataSocsoHdr) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataSocsoHdr Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Dim strSql = "select count(*) from SMKB_Gaji_Perkeso_Hdr  where kod= '" & DataSocsoHdr.Kod & "'"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt > 0 Then
            resp.Failed("Kod yang dimasukkan telah wujud! Sila masukkan Kod lain.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If


        If fInsertSocsoHdr(DataSocsoHdr) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If


        If success = 1 Then
            Session("Kod") = DataSocsoHdr.Kod
            resp.Success("Rekod berjaya disimpan", "00", DataSocsoHdr)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function

    Private Function fInsertSocsoHdr(DataSocsoHdr As DataSocsoHdr)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal
        Dim staMaster As String = ""


        Dim query As String = "insert into SMKB_Gaji_Perkeso_Hdr (kod, butiran) values (@kod,@butir)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", DataSocsoHdr.Kod))
        param.Add(New SqlParameter("@butir", DataSocsoHdr.Butiran))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HapusSocsoHdr(DataSocsoHdr As DataSocsoHdr) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah dipadam")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataSocsoHdr Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If fDeleteSocsoHdr(DataSocsoHdr) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If


        If success = 1 Then
            Session("Kod") = DataSocsoHdr.Kod
            resp.Success("Rekod berjaya dipadam", "00", DataSocsoHdr)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya dipadam")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function

    Private Function fDeleteSocsoHdr(DataSocsoHdr As DataSocsoHdr)
        Dim db As New DBKewConn

        Dim query As String = "DELETE SMKB_Gaji_Perkeso_Hdr WHERE kod = @kod"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", DataSocsoHdr.Kod))

        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListCukaiHdr() As String
        Dim resp As New ResponseRepository


        dt = getListCukaiHdr()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    Public Function getListCukaiHdr() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "Select kod, butiran from smkb_gaji_cukai_hdr order by kod"

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListDetCukai(ByVal kodhdr As String) As String
        Dim resp As New ResponseRepository


        dt = GetListDetCukai(kodhdr)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function GetListDetCukai(kodhdr As String) As DataTable
        Dim db = New DBKewConn

        Dim dt As New DataTable

        Dim query As String = $"select kod, amaun, cukai_pek, cukai_maj from smkb_gaji_cukai_dtl where kod = '{kodhdr}'"
        Return db.Read(query)
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanCukaiHdr(DataCukaiHeader As DataCukaiHeader) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataCukaiHeader Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Dim strSql = "select count(*) from SMKB_Gaji_Cukai_Hdr  where kod= '" & DataCukaiHeader.Kod & "'"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt > 0 Then
            resp.Failed("Kod yang dimasukkan telah wujud! Sila masukkan Kod lain.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If


        If fInsertCukaiHdr(DataCukaiHeader) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If


        If success = 1 Then
            Session("Kod") = DataCukaiHeader.Kod
            resp.Success("Rekod berjaya disimpan", "00", DataCukaiHeader)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function

    Private Function fInsertCukaiHdr(DataCukaiHeader As DataCukaiHeader)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal
        Dim staMaster As String = ""


        Dim query As String = "insert into SMKB_Gaji_Cukai_Hdr (kod, butiran) values (@kod,@butir)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", DataCukaiHeader.Kod))
        param.Add(New SqlParameter("@butir", DataCukaiHeader.Butiran))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanSocsoDet(DataSocsoDet As DataSocsoDet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataSocsoDet Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Dim strSql = "select count(*) from SMKB_Gaji_Perkeso_Dtl  where kod= '" & DataSocsoDet.KodDet & "'"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt > 0 Then
            resp.Failed("Kod yang dimasukkan telah wujud! Sila masukkan Kod lain.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If


        If fInsertSocsoDet(DataSocsoDet) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If


        If success = 1 Then
            Session("Kod") = DataSocsoDet.KodDet
            resp.Success("Rekod berjaya disimpan", "00", DataSocsoDet)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function

    Private Function fInsertSocsoDet(DataSocsoDet As DataSocsoDet)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal
        Dim staMaster As String = ""


        Dim query As String = "insert into SMKB_Gaji_Perkeso_Dtl (kod, amaun, perkeso_pek,perkeso_maj) values (@kod,@butir)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", DataSocsoDet.KodDet))
        param.Add(New SqlParameter("@amaun", DataSocsoDet.AmaunDet))
        param.Add(New SqlParameter("@pek", DataSocsoDet.AmaunPek))
        param.Add(New SqlParameter("@maj", DataSocsoDet.AmaunMaj))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateDetSocso(DataSocsoDet As DataSocsoDet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataSocsoDet Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If fUpdateDetSocso(DataSocsoDet) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If

        If success = 1 Then
            resp.Success("Rekod berjaya disimpan", "00", DataSocsoDet)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function
    Private Function fUpdateDetSocso(DataSocsoDet As DataSocsoDet)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal = 0
        Dim staMaster As String = ""


        Dim query As String = "UPDATE SMKB_Gaji_Perkeso_Dtl SET perkeso_pek = @b,perkeso_maj = @c where Kod = @kod and amaun = @amaun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@b", DataSocsoDet.AmaunPek))
        param.Add(New SqlParameter("@c", DataSocsoDet.AmaunMaj))
        param.Add(New SqlParameter("@kod", DataSocsoDet.KodDet))
        param.Add(New SqlParameter("@amaun", DataSocsoDet.AmaunDet))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateHdrCukai(DataCukaiHeader As DataCukaiHeader) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataCukaiHeader Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If fUpdateHdrCukai(DataCukaiHeader) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If

        If success = 1 Then
            Session("Kod") = DataCukaiHeader.Kod
            resp.Success("Rekod berjaya disimpan", "00", DataCukaiHeader)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function
    Private Function fUpdateHdrCukai(DataCukaiHeader As DataCukaiHeader)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal = 0
        Dim staMaster As String = ""


        Dim query As String = "UPDATE SMKB_Gaji_Cukai_Hdr SET Butiran = @jenis where Kod = @kod"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@jenis", DataCukaiHeader.Butiran))
        param.Add(New SqlParameter("@kod", DataCukaiHeader.Kod))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanCukaiDet(DataCukaiDet As DataCukaiDet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataCukaiDet Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Dim strSql = "select count(*) from SMKB_Gaji_Cukai_Dtl  where kod= '" & DataCukaiDet.KodDet & "'"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt > 0 Then
            resp.Failed("Kod yang dimasukkan telah wujud! Sila masukkan Kod lain.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If


        If fInsertCukaiDet(DataCukaiDet) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If


        If success = 1 Then
            Session("Kod") = DataCukaiDet.KodDet
            resp.Success("Rekod berjaya disimpan", "00", DataCukaiDet)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function

    Private Function fInsertCukaiDet(DataCukaiDet As DataCukaiDet)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal
        Dim staMaster As String = ""


        Dim query As String = "insert into SMKB_Cukai_Cukai_Dtl (kod, amaun, cukai_pek,cukai_maj) values (@kod,@amaun,@pek,@maj)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", DataCukaiDet.KodDet))
        param.Add(New SqlParameter("@amaun", DataCukaiDet.AmaunDet))
        param.Add(New SqlParameter("@pek", DataCukaiDet.AmaunPek))
        param.Add(New SqlParameter("@maj", DataCukaiDet.AmaunMaj))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateDetCukai(DataCukaiDet As DataCukaiDet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataCukaiDet Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If fUpdateDetCukai(DataCukaiDet) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If

        If success = 1 Then
            resp.Success("Rekod berjaya disimpan", "00", DataCukaiDet)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function
    Private Function fUpdateDetCukai(DataCukaiDet As DataCukaiDet)
        Dim db As New DBKewConn


        Dim query As String = "UPDATE SMKB_Gaji_Cukai_Dtl SET cukai_pek = @b,cukai_maj = @c where Kod = @d and amaun = @e"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@b", DataCukaiDet.AmaunPek))
        param.Add(New SqlParameter("@c", DataCukaiDet.AmaunMaj))
        param.Add(New SqlParameter("@d", DataCukaiDet.KodDet))
        param.Add(New SqlParameter("@e", DataCukaiDet.AmaunDet))


        Return db.Process(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetNegeri(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodNegeri(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetNegara(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodNegara(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBandar(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodBandar(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPoskod(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodPoskod(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodBandar(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE kod = '0003'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodBank(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT kod_Detail as value, (kod_Detail + ' - ' + Butiran ) as text FROM SMKB_Lookup_Detail WHERE kod = '0097'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND ( kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%')"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodNegeri(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE kod='0002'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodNegara(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE kod = '0001'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodPoskod(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail as text FROM SMKB_Lookup_Detail WHERE Kod='0079'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Kod_Detail LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If
        query &= " ORDER BY Kod_Detail ASC"
        Return db.Read(query, param)
    End Function
End Class