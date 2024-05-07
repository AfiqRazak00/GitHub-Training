Imports System.ComponentModel
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.SqlTypes
Imports System.Drawing.Imaging
Imports System.Globalization
Imports System.IO
Imports System.Security.Policy
Imports System.Threading.Tasks
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Xml
Imports EnvDTE
Imports iTextSharp.text
Imports Microsoft.Ajax.Utilities
Imports Newtonsoft.Json
Imports Org.BouncyCastle.Asn1
Imports Org.BouncyCastle.Bcpg
Imports WebGrease.Css.Extensions
Imports System.Collections.Generic

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class EVendorPenyelengaraan_WS
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodBdgUtama(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodBU(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodBU(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod as value, (Kod + ' - ' + Butiran ) as text FROM SMKB_Syarikat_Bidang_Utama WHERE Status = @status"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%'"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        query &= " ORDER BY Kod"

        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodSubBidang(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = ListItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodSB(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodSB(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod as value, (Kod + ' - ' + Butiran ) as text FROM SMKB_Syarikat_Sub_Bidang WHERE Status = @status"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%'"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        query &= " ORDER BY Kod"

        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_BidangUtama() As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_BidangUtama()

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_BidangUtama() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod, Butiran From SMKB_Syarikat_Bidang_Utama WHERE Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_SubBidang(IsClicked As String, categoryFilterBU As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        'If IsClicked = False Then
        '    dt = GetList_SubBidang1()
        '    'Return JsonConvert.SerializeObject(New DataTable)
        '    Return JsonConvert.SerializeObject(dt)
        'End If

        If IsClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        'dt = GetList_SubBidang(IsClicked, categoryFilterBU)
        dt = GetList_SubBidang(categoryFilterBU)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_SubBidang(categoryFilterBU As String) As DataTable
        Dim db As New DBKewConn
        Dim BdgUtamaQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)

        If categoryFilterBU <> "" Then
            BdgUtamaQuery = " AND Kod_Bdg_Utama = @BdgUtama"
        End If

        Dim query As String = "SELECT Kod, Butiran, Kod_Bdg_Utama As KodBU From SMKB_Syarikat_Sub_Bidang WHERE Status = @status" & BdgUtamaQuery & ""

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@BdgUtama", categoryFilterBU))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_Bidang(IsClickedBdg As String, categoryFilterBdg As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        If IsClickedBdg = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetList_Bidang(categoryFilterBdg)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_Bidang(categoryFilterBdg As String) As DataTable
        Dim db As New DBKewConn
        Dim BdgQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)

        If categoryFilterBdg <> "" Then
            BdgQuery = " AND KodSubBidang = @subBdg"
        End If
        Dim query As String = "SELECT KodBidang, Butiran, KodSubBidang As KodSB FROM SMKB_Syarikat_Bidang WHERE Status = @status" & BdgQuery & ""

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@subBdg", categoryFilterBdg))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveBidangUtama(bdgUtama As BidangUtama) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Dihantar")
        Dim success As Integer = 0

        If bdgUtama Is Nothing Then
            resp.Failed("Sila Isi Maklumat Yang Diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If IsBUExist(bdgUtama.KodBU) = "OK" Then
            If UpdateBU(bdgUtama.KodBU, bdgUtama.ButiranBU) <> "OK" Then
                resp.Failed("Gagal Mengemaskini Bidang Utama")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1

        Else

            If bdgUtama.KodBU <> "" Then
                If InsertBU(bdgUtama.KodBU, bdgUtama.ButiranBU) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Bidang Utama")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If

                success += 1

            End If

        End If

        If success = 0 Then
            resp.Failed("Maklumat Bidang Utama Gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Bidang Utama Berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveSubBidang(SubBdg As SubBidang) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Dihantar")
        Dim success As Integer = 0

        If SubBdg Is Nothing Then
            resp.Failed("Sila Isi Maklumat Sub Bidang Yang Diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If IsSBExist(SubBdg.KodSB) = "OK" Then
            If UpdateSB(SubBdg.KodBU, SubBdg.KodSB, SubBdg.ButiranSB) <> "OK" Then
                resp.Failed("Gagal Mengemaskini Sub Bidang")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1

        Else

            If SubBdg.KodSB <> "" Then
                If InsertSB(SubBdg.KodBU, SubBdg.KodSB, SubBdg.ButiranSB) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Sub Bidang")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If

                success += 1

            End If

        End If

        If success = 0 Then
            resp.Failed("Maklumat Sub Bidang Gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Sub Bidang Berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveBidang(bidang As Bidang) As String
        Dim resp As New ResponseRepository
        resp.Success("Maklumat Berjaya Dihantar")
        Dim success As Integer = 0

        If bidang Is Nothing Then
            resp.Failed("Sila Isi Maklumat Sub Bidang Yang Diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If IsBdgExist(bidang.KodBdg) = "OK" Then
            If UpdateBdg(bidang.KodBdg, bidang.KodSB, bidang.ButiranBdg) <> "OK" Then
                resp.Failed("Gagal Mengemaskini Sub Bidang")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            success += 1

        Else

            If bidang.KodBdg <> "" Then
                If InsertBdg(bidang.KodBdg, bidang.KodSB, bidang.ButiranBdg) <> "OK" Then
                    resp.Failed("Gagal Menyimpan Sub Bidang")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If

                success += 1

            End If

        End If

        If success = 0 Then
            resp.Failed("Maklumat Sub Bidang Gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Maklumat Sub Bidang Berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function IsBUExist(KodBU As String) As String
        Dim db = New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query As String = "SELECT Kod, Butiran From SMKB_Syarikat_Bidang_Utama WHERE Kod = @KodBU AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBU", KodBU))
        param.Add(New SqlParameter("@status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status

    End Function

    Private Function IsSBExist(KodSB As String) As String
        Dim db = New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query As String = "SELECT Kod, Butiran, Kod_Bdg_Utama From SMKB_Syarikat_Sub_Bidang WHERE Kod = @KodSB AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodSB", KodSB))
        param.Add(New SqlParameter("@status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status

    End Function

    Private Function IsBdgExist(KodBdg As String) As String
        Dim db = New DBKewConn
        Dim dt As DataTable
        Dim Status As String

        Dim query As String = "SELECT KodBidang, Butiran, KodSubBidang From SMKB_Syarikat_Bidang WHERE KodBidang = @KodBdg AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBdg", KodBdg))
        param.Add(New SqlParameter("@status", "1"))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = "OK"
        Else
            Status = "X"
        End If

        Return Status

    End Function

    Private Function InsertBU(KodBU As String, ButiranBU As String) As String
        Dim db = New DBKewConn
        Dim ResultInsert As String
        Dim Status As String = ""
        Dim StatusDok As String = ""
        Dim query As String = "INSERT INTO SMKB_Syarikat_Bidang_Utama (Kod, Butiran) VALUES (@KodBU, @ButiranBU)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBU", KodBU))
        param.Add(New SqlParameter("@ButiranBU", ButiranBU))

        'Return db.Process(query, param)
        ResultInsert = db.Process(query, param)
        'If ResultInsert <> "OK" Then
        '    Status = "X"
        '    Return Status
        'Else
        '    Status = "OK"
        'End If

        'If Status = "OK" Then
        '    Dim IdRujukan As String = Session("ssusrID")
        '    Dim Process As String = "INSERT"
        '    Dim Table As String = "SMKB_Syarikat_Bidang_Utama"
        '    Dim fieldNames As String = "Kod|Butiran"
        '    Dim fieldValues As String = $"{KodBU}|{ButiranBU}"

        '    If InsertStatusDok(IdRujukan, Process, Table, fieldNames, fieldValues) <> "OK" Then
        '        StatusDok = "X"
        '    Else
        '        StatusDok = "OK"
        '    End If
        'End If

        'Return StatusDok
        Return ResultInsert
    End Function

    Private Function InsertSB(KodBU As String, KodSB As String, ButiranSB As String) As String
        Dim db = New DBKewConn
        Dim ResultInsert As String
        Dim Status As String = ""
        Dim StatusDok As String = ""

        Dim query As String = "INSERT INTO SMKB_Syarikat_Sub_Bidang (Kod, Butiran, Kod_Bdg_Utama) VALUES (@KodSB, @ButiranBU, @KodBU)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBU", KodBU))
        param.Add(New SqlParameter("@KodSB", KodSB))
        param.Add(New SqlParameter("@ButiranBU", ButiranSB))

        ResultInsert = db.Process(query, param)
        'If ResultInsert <> "OK" Then
        '    Status = "X"
        '    Return Status
        'Else
        '    Status = "OK"
        'End If

        'If Status = "OK" Then
        '    Dim IdRujukan As String = Session("ssusrID")
        '    Dim Process As String = "INSERT"
        '    Dim Table As String = "SMKB_Syarikat_Sub_Bidang"
        '    Dim fieldNames As String = "Kod|Butiran|Kod_Bdg_Utama"
        '    Dim fieldValues As String = $"{KodSB}|{ButiranSB}|{KodBU}"

        '    If InsertStatusDok(IdRujukan, Process, Table, fieldNames, fieldValues) <> "OK" Then
        '        StatusDok = "X"
        '    Else
        '        StatusDok = "OK"
        '    End If
        'End If

        'Return StatusDok
        Return ResultInsert
    End Function

    Private Function InsertBdg(KodBdg As String, KodSB As String, ButiranBdg As String) As String
        Dim db = New DBKewConn
        Dim ResultInsert As String
        Dim Status As String = ""
        Dim StatusDok As String = ""

        Dim query As String = "INSERT INTO SMKB_Syarikat_Bidang (KodBidang, Butiran, KodSubBidang) VALUES (@KodBdg, @ButiranBdg, @KodSB)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBdg", KodBdg))
        param.Add(New SqlParameter("@KodSB", KodSB))
        param.Add(New SqlParameter("@ButiranBdg", ButiranBdg))

        ResultInsert = db.Process(query, param)
        'If ResultInsert <> "OK" Then
        '    Status = "X"
        '    Return Status
        'Else
        '    Status = "OK"
        'End If

        'If Status = "OK" Then
        '    Dim IdRujukan As String = Session("ssusrID")
        '    Dim Process As String = "INSERT"
        '    Dim Table As String = "SMKB_Syarikat_Bidang"
        '    Dim fieldNames As String = "KodBidang|Butiran|KodSubBidang"
        '    Dim fieldValues As String = $"{KodBdg}|{ButiranBdg}|{KodSB}"

        '    If InsertStatusDok(IdRujukan, Process, Table, fieldNames, fieldValues) <> "OK" Then
        '        StatusDok = "X"
        '    Else
        '        StatusDok = "OK"
        '    End If
        'End If

        'Return StatusDok

        Return ResultInsert
    End Function

    Private Function UpdateBU(KodBU As String, ButiranBU As String) As String
        Dim db As New DBKewConn
        Dim ResultInsert As String
        Dim Status As String = ""
        Dim StatusDok As String = ""
        Dim query As String = "UPDATE SMKB_Syarikat_Bidang_Utama SET Butiran = @ButiranBu WHERE Kod = @kodBU"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBU", KodBU))
        param.Add(New SqlParameter("@ButiranBU", ButiranBU))

        'Return db.Process(query, param)

        ResultInsert = db.Process(query, param)
        'If ResultInsert <> "OK" Then
        '    Status = "X"
        '    Return Status
        'Else
        '    Status = "OK"
        'End If

        'If Status = "OK" Then
        '    Dim IdRujukan As String = Session("ssusrID")
        '    Dim Process As String = "UPDATE"
        '    Dim Table As String = "SMKB_Syarikat_Bidang_Utama"
        '    Dim fieldNames As String = "Kod|Butiran"
        '    Dim fieldValues As String = $"{KodBU}|{ButiranBU}|{KodBU}"

        '    If InsertStatusDok(IdRujukan, Process, Table, fieldNames, fieldValues) <> "OK" Then
        '        StatusDok = "X"
        '    Else
        '        StatusDok = "OK"
        '    End If
        'End If

        'Return StatusDok

        Return ResultInsert
    End Function

    Private Function UpdateSB(KodBU As String, KodSB As String, ButiranSB As String) As String
        Dim db As New DBKewConn
        Dim ResultInsert As String
        Dim Status As String = ""
        Dim StatusDok As String = ""
        Dim query As String = "UPDATE SMKB_Syarikat_Sub_Bidang SET Butiran = @ButiranSB, Kod_Bdg_Utama = @KodBU WHERE Kod = @KodSB"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBU", KodBU))
        param.Add(New SqlParameter("@KodSB", KodSB))
        param.Add(New SqlParameter("@ButiranSB", ButiranSB))

        'Return db.Process(query, param)

        ResultInsert = db.Process(query, param)
        'If ResultInsert <> "OK" Then
        '    Status = "X"
        '    Return Status
        'Else
        '    Status = "OK"
        'End If

        'If Status = "OK" Then
        '    Dim IdRujukan As String = Session("ssusrID")
        '    Dim Process As String = "UPDATE"
        '    Dim Table As String = "SMKB_Syarikat_Sub_Bidang"
        '    Dim fieldNames As String = "Kod|Butiran|Kod_Bdg_Utama"
        '    Dim fieldValues As String = $"{KodSB}|{ButiranSB}|{KodBU}"

        '    If InsertStatusDok(IdRujukan, Process, Table, fieldNames, fieldValues) <> "OK" Then
        '        StatusDok = "X"
        '    Else
        '        StatusDok = "OK"
        '    End If
        'End If

        'Return StatusDok

        Return ResultInsert
    End Function
    Private Function UpdateBdg(KodBidang As String, KodSB As String, ButiranBdg As String) As String
        Dim db As New DBKewConn
        Dim ResultInsert As String
        Dim Status As String = ""
        Dim StatusDok As String = ""
        Dim query As String = "UPDATE SMKB_Syarikat_Bidang SET Butiran = @ButiranBdg, KodSubBidang = @KodSB WHERE KodBidang = @KodBdg"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBdg", KodBidang))
        param.Add(New SqlParameter("@KodSB", KodSB))
        param.Add(New SqlParameter("@ButiranBdg", ButiranBdg))

        'Return db.Process(query, param)

        ResultInsert = db.Process(query, param)
        'If ResultInsert <> "OK" Then
        '    Status = "X"
        '    Return Status
        'Else
        '    Status = "OK"
        'End If

        'If Status = "OK" Then
        '    Dim IdRujukan As String = Session("ssusrID")
        '    Dim Process As String = "UPDATE"
        '    Dim Table As String = "SMKB_Syarikat_Sub_Bidang"
        '    Dim fieldNames As String = "KodBidang|Butiran|KodSubBidang"
        '    Dim fieldValues As String = $"{KodBidang}|{ButiranBdg}|{KodSB}"

        '    If InsertStatusDok(IdRujukan, Process, Table, fieldNames, fieldValues) <> "OK" Then
        '        StatusDok = "X"
        '    Else
        '        StatusDok = "OK"
        '    End If
        'End If

        'Return StatusDok

        Return ResultInsert
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataBU(KodBU As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_BU(KodBU)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_BU(KodBU As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod, Butiran From SMKB_Syarikat_Bidang_Utama WHERE Kod = @KodBU"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBU", KodBU))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataSB(KodSB As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_SB(KodSB)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_SB(KodSB As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT A.Kod, A.Butiran, A.Kod_Bdg_Utama, B.Butiran As ButiranBU 
                               From SMKB_Syarikat_Sub_Bidang A, SMKB_Syarikat_Bidang_Utama B
                               WHERE A.Kod_bdg_Utama = B.Kod AND A.Kod = @KodSB"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodSB", KodSB))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataBdg(KodBdg As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_Bdg(KodBdg)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_Bdg(KodBdg As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT A.KodBidang, A.Butiran, A.KodSubBidang, B.Butiran As ButiranSB
                               From SMKB_Syarikat_Bidang A, SMKB_Syarikat_Sub_Bidang B
                               WHERE A.KodSubBidang = B.Kod AND A.KodBidang = @KodBdg"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBdg", KodBdg))

        Return db.Read(query, param)
    End Function

    'Private Function InsertStatusDok(IdRujukan As String, Process As String, Table As String, fieldNames As String, fieldValues As String) As String
    '    Dim db As New DBKewConn
    '    Dim query As String = "INSERT INTO SMKB_Syarikat_Status_Dok (ID_Rujukan, Proses, Nama_Table, Medan, Value, Tkh_Tindakan, Ulasan, Status) 
    '                           VALUES (@IdRujukan,@Process,@Table,@Medan,@Value,@TkhTindakan,@Ulasan,@Status)"

    '    Dim param As New List(Of SqlParameter)
    '    param.Add(New SqlParameter("@IdRujukan", IdRujukan))
    '    param.Add(New SqlParameter("@Process", Process))
    '    param.Add(New SqlParameter("@Table", Table))
    '    param.Add(New SqlParameter("@Medan", fieldNames))
    '    param.Add(New SqlParameter("@Value", fieldValues))
    '    param.Add(New SqlParameter("@TkhTindakan", DateTime.Now))
    '    param.Add(New SqlParameter("@Ulasan", "NULL"))
    '    param.Add(New SqlParameter("@Status", "1"))

    '    Return db.Process(query, param)
    'End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteBU(KodBU As String) As String
        Dim resp As New ResponseRepository
        If DelBU(KodBU) = "OK" Then
            resp.Success("Berjaya")
        Else
            resp.Failed("Gagal")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DelBU(KodBU As String) As String
        Dim db As New DBKewConn
        Dim query As String = "Update SMKB_Syarikat_Bidang_Utama SET Status = @statusBaru WHERE Kod = @kodBU AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBU", KodBU))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@statusBaru", "0"))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteSB(KodSB As String) As String
        Dim resp As New ResponseRepository
        If DelSB(KodSB) = "OK" Then
            resp.Success("Berjaya")
        Else
            resp.Failed("Gagal")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DelSB(KodSB As String) As String
        Dim db As New DBKewConn
        Dim query As String = "Update SMKB_Syarikat_Sub_Bidang SET Status = @statusBaru WHERE Kod = @KodSB AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodSB", KodSB))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@statusBaru", "0"))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteBdg(KodBdg As String) As String
        Dim resp As New ResponseRepository
        If DelBdg(KodBdg) = "OK" Then
            resp.Success("Berjaya")
        Else
            resp.Failed("Gagal")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function DelBdg(KodBdg As String) As String
        Dim db As New DBKewConn
        Dim query As String = "Update SMKB_Syarikat_Bidang SET Status = @statusBaru WHERE KodBidang = @KodBdg AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBdg", KodBdg))
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@statusBaru", "0"))

        Return db.Process(query, param)
    End Function

End Class