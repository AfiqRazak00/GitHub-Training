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
Imports System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder
Imports System.Web.Http.Results
Imports System.Web.Http
Imports Org.BouncyCastle.Math.EC
Imports System.Web.Script.Serialization

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Perolehan
    Inherits System.Web.Services.WebService

    Dim queryRB As New Query()

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_TawaranIklanUni() As String
        Dim resp As New ResponseRepository
        Dim FoundResult = False
        Dim dt As DataTable
        Dim dtFiltered As New DataTable

        dt = GetList_TawaranIklanUni()

        dtFiltered = dt.Clone()

        If dt.Rows.Count > 0 Then
            For Each RowDT As DataRow In dt.Rows

                FoundResult = CheckVendor(RowDT("IdJualan"), RowDT("No_Mohon"))

                If Not FoundResult Then
                    Return Nothing
                Else
                    dtFiltered.ImportRow(RowDT)
                End If
            Next
        End If

        If dtFiltered.Rows.Count > 0 Then
            Return JsonConvert.SerializeObject(dtFiltered)
        Else
            Return Nothing
        End If

    End Function

    Private Function GetList_TawaranIklanUni() As DataTable
        Dim db = New DBKewConn
        'Dim query As String = "SELECT A.No_Mohon, C.Id_Jualan as IdNaskah,B.Id_Jualan as IdJualan ,A.Tujuan,D.Pejabat, FORMAT(C.Tarikh_Masa_Mula_Iklan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhMula,A.Jenis_Barang,
        '                        FORMAT(C.Tarikh_Masa_Mula_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhBuka, FORMAT(C.Tarikh_Masa_Tamat_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhTutup,
        'C.Lawatan_Tapak,FORMAT(C.Tarikh_Masa_Lawatan_Tapak, 'dddd, dd MMMM yyyy, hh:mm tt') as TkhLawatan,C.Harga As HargaNaskah
        '                        FROM SMKB_Perolehan_Permohonan_Hdr A,SMKB_Perolehan_Pembelian_Hdr B,SMKB_Perolehan_Naskah_Jualan C, VPejabat D
        '                        WHERE A.No_Mohon=B.No_Mohon AND B.No_Mohon=C.No_Mohon AND LEFT(A.Kod_Ptj_Mohon,2)=D.KodPejabat
        '                        AND GetDate() between C.Tarikh_Masa_Mula_Iklan and C.Tarikh_Masa_Tamat_Perolehan AND No_Perolehan LIKE 'DS%'"

        Dim Query1 As String = "SELECT A.No_Mohon, C.Id_Jualan as IdNaskah,C.Id_Jualan as IdJualan ,A.Tujuan,D.Pejabat, FORMAT(C.Tarikh_Masa_Mula_Iklan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhMula,A.Jenis_Barang,
                                FORMAT(C.Tarikh_Masa_Mula_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhBuka, FORMAT(C.Tarikh_Masa_Tamat_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhTutup,
						        C.Lawatan_Tapak,FORMAT(C.Tarikh_Masa_Lawatan_Tapak, 'dddd, dd MMMM yyyy, hh:mm tt') as TkhLawatan,C.Harga As HargaNaskah
                                FROM SMKB_Perolehan_Permohonan_Hdr A,SMKB_Perolehan_Naskah_Jualan C, VPejabat D
                                WHERE A.No_Mohon=C.No_Mohon AND LEFT(A.Kod_Ptj_Mohon,2)=D.KodPejabat
                                AND GetDate() between C.Tarikh_Masa_Mula_Iklan and C.Tarikh_Masa_Tamat_Perolehan AND A.No_Perolehan LIKE 'DS%'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", ""))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(Query1, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_TawaranIklanPTJ() As String
        Dim resp As New ResponseRepository
        Dim FoundResult = False
        Dim dt As DataTable
        Dim dtFiltered As New DataTable

        dt = GetList_TawaranIklanPTJ()
        dtFiltered = dt.Clone()

        If dt.Rows.Count > 0 Then
            For Each RowDT As DataRow In dt.Rows

                FoundResult = CheckVendor(RowDT("IdNaskah"), RowDT("No_Mohon"))

                If FoundResult Then
                    dtFiltered.ImportRow(RowDT)
                End If

            Next
        End If

        If dtFiltered.Rows.Count > 0 Then
            Return JsonConvert.SerializeObject(dtFiltered)
        Else
            Return Nothing
        End If

    End Function

    Private Function GetList_TawaranIklanPTJ() As DataTable
        Dim db = New DBKewConn
        Dim Query1 As String = "SELECT A.No_Mohon, C.Id_Jualan as IdNaskah,C.Id_Jualan as IdJualan ,A.Tujuan,D.Pejabat, FORMAT(C.Tarikh_Masa_Mula_Iklan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhMula,A.Jenis_Barang,
                                FORMAT(C.Tarikh_Masa_Mula_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhBuka, FORMAT(C.Tarikh_Masa_Tamat_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhTutup,
						        C.Lawatan_Tapak,FORMAT(C.Tarikh_Masa_Lawatan_Tapak, 'dddd, dd MMMM yyyy, hh:mm tt') as TkhLawatan,C.Harga As HargaNaskah
                                FROM SMKB_Perolehan_Permohonan_Hdr A,SMKB_Perolehan_Naskah_Jualan C, VPejabat D
                                WHERE A.No_Mohon=C.No_Mohon AND LEFT(A.Kod_Ptj_Mohon,2)=D.KodPejabat
                                AND GetDate() between C.Tarikh_Masa_Mula_Iklan and C.Tarikh_Masa_Tamat_Perolehan AND A.No_Perolehan LIKE 'PS%'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", ""))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(Query1, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_TawaranIklanTender() As String
        Dim resp As New ResponseRepository
        Dim FoundResult = False
        Dim dt As DataTable
        Dim dtFiltered As New DataTable

        dt = GetList_TawaranIklanTender()

        dtFiltered = dt.Clone()

        If dt.Rows.Count > 0 Then
            For Each RowDT As DataRow In dt.Rows

                FoundResult = CheckVendor(RowDT("IdJualan"), RowDT("No_Mohon"))

                If Not FoundResult Then
                    Return Nothing
                Else
                    dtFiltered.ImportRow(RowDT)
                End If
            Next
        End If

        If dtFiltered.Rows.Count > 0 Then
            Return JsonConvert.SerializeObject(dtFiltered)
        Else
            resp.Failed("Tiada Maklumat")
            Return JsonConvert.SerializeObject(resp)
        End If

    End Function

    Private Function GetList_TawaranIklanTender() As DataTable
        Dim db = New DBKewConn
        Dim Query1 As String = "SELECT A.No_Mohon, C.Id_Jualan as IdNaskah,C.Id_Jualan as IdJualan ,A.Tujuan,D.Pejabat, FORMAT(C.Tarikh_Masa_Mula_Iklan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhMula,A.Jenis_Barang,
                        FORMAT(C.Tarikh_Masa_Mula_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhBuka, FORMAT(C.Tarikh_Masa_Tamat_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhTutup,
						C.Lawatan_Tapak,FORMAT(C.Tarikh_Masa_Lawatan_Tapak, 'dddd, dd MMMM yyyy, hh:mm tt') as TkhLawatan,C.Harga As HargaNaskah
                        FROM SMKB_Perolehan_Permohonan_Hdr A,SMKB_Perolehan_Naskah_Jualan C, VPejabat D
                        WHERE A.No_Mohon=C.No_Mohon AND LEFT(A.Kod_Ptj_Mohon,2)=D.KodPejabat
                        AND GetDate() between C.Tarikh_Masa_Mula_Iklan and C.Tarikh_Masa_Tamat_Perolehan AND A.No_Perolehan LIKE 'DT%'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", ""))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(Query1, param)
    End Function

    Private Function CheckVendor(IdJualan As String, NoMohon As String)

        Dim FoundLesenKerja = False
        Dim FoundGred = False
        Dim FoundKhusus = False
        Dim FoundBidang = False
        Dim FoundResult = False

        If KatSyarikatKerja(Session("ssusrID")) = True Then

            Dim StatusLesenKerja As LesenTamatTempah = LesenTamatTempohCIDB(Session("ssusrID"), IdJualan)
            If StatusLesenKerja.Status <> "00" Then
                FoundLesenKerja = False
            Else
                FoundLesenKerja = True
            End If

            'Check Gred condition <> OK
            If IsGredMatch(IdJualan, Session("ssusrID")) = True Then
                FoundGred = False
            Else
                FoundGred = True
            End If

            'Condition -> Khusus
            Dim DTKhususPO As New DataTable
            Dim DTKhususSya As New DataTable

            DTKhususPO = GetDataKhususPO(NoMohon)
            DTKhususSya = GetDataKhususSya(Session("ssusrID"))

            If DTKhususPO.Rows.Count > 1 Then
                If DTKhususSya.Rows.Count > 1 Then

                    'Dim Syarat As New List(Of String)
                    Dim foundOr = False, FoundDan = False, FoundDanOne = False
                    Dim ind = 0, indFoundDanOne = 0
                    For Each rowPO As DataRow In DTKhususPO.Rows
                        'For Each rowSya As DataRow In DTBidangSya.Rows
                        If rowPO("Syarat") = "0" Then
                            If DTKhususSya.Select($"Kod_Khusus = '{ rowPO("Kod_Khusus")}'").Any() Then
                                If FoundDanOne Then
                                    If (indFoundDanOne = ind - 1) Then
                                        FoundDan = True
                                    End If
                                Else
                                    foundOr = True
                                End If
                            End If
                        ElseIf rowPO("Syarat") = "1" Then
                            If DTKhususSya.Select($"Kod_Khusus = '{ rowPO("Kod_Khusus")}'").Any() Then
                                FoundDanOne = True
                                indFoundDanOne = ind
                            End If
                        ElseIf rowPO("Syarat") = "2" Then
                            If DTKhususSya.Select($"Kod_Khusus = '{ rowPO("Kod_Khusus")}'").Any() Then
                                If FoundDanOne Then
                                    If (indFoundDanOne = ind - 1) Then
                                        FoundDan = True
                                        FoundDanOne = False
                                    End If
                                Else
                                    foundOr = True
                                End If
                            End If
                        End If
                        ind += 1
                        'Next
                    Next

                    FoundBidang = foundOr Or FoundDan

                End If
            Else
                For Each rowPO As DataRow In DTKhususPO.Rows
                    For Each RowSya As DataRow In DTKhususSya.Rows
                        If rowPO("Kod_Khusus") = RowSya("Khusus") Then
                            FoundKhusus = True
                        End If
                    Next
                Next
            End If

            If Not FoundLesenKerja OrElse Not FoundGred OrElse Not FoundKhusus Then
                FoundResult = False
            Else
                FoundResult = True
            End If
        Else

            ''Perkhidmatan & Bekalan
            ''check Tamat Tempoh Lesen
            Dim StatusLesenLain As LesenTamatTempah = LesenTamatTempohCIDB(Session("ssusrID"), IdJualan)
            If StatusLesenLain.Status <> "00" Then
                FoundLesenKerja = False
            Else
                FoundLesenKerja = True
            End If

            'check lesen is exist?
            'Filter Condition
            'Filter Bidang

            'Condition -> Khusus
            Dim DTBidangPO As New DataTable
            Dim DTBidangSya As New DataTable

            DTBidangPO = GetDataBidangPO(NoMohon)
            DTBidangSya = GetDataBidangSya(Session("ssusrID"))

            If DTBidangPO.Rows.Count > 1 Then
                If DTBidangSya.Rows.Count > 1 Then

                    'Dim Syarat As New List(Of String)
                    Dim foundOr = False, FoundDan = False, FoundDanOne = False
                    Dim ind = 0, indFoundDanOne = 0
                    For Each rowPO As DataRow In DTBidangPO.Rows
                        'For Each rowSya As DataRow In DTBidangSya.Rows
                        If rowPO("Syarat") = "0" Then
                            If DTBidangSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                If FoundDanOne Then
                                    If (indFoundDanOne = ind - 1) Then
                                        FoundDan = True
                                    End If
                                Else
                                    foundOr = True
                                End If
                            End If
                        ElseIf rowPO("Syarat") = "1" Then
                            If DTBidangSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                FoundDanOne = True
                                indFoundDanOne = ind
                            End If
                        ElseIf rowPO("Syarat") = "2" Then
                            If DTBidangSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                If FoundDanOne Then
                                    If (indFoundDanOne = ind - 1) Then
                                        FoundDan = True
                                        FoundDanOne = False
                                    End If
                                Else
                                    foundOr = True
                                End If
                            End If
                        End If
                        ind += 1
                        'Next
                    Next

                    FoundBidang = foundOr Or FoundDan

                End If
            Else
                For Each rowPO As DataRow In DTBidangPO.Rows
                    For Each RowSya As DataRow In DTBidangSya.Rows
                        If rowPO("Kod_Bidang") = RowSya("Kod_Bidang") Then
                            FoundBidang = True
                        End If
                    Next
                Next
            End If

            If Not FoundLesenKerja AndAlso Not FoundBidang Then
                FoundResult = False
            Else
                FoundResult = True
            End If
        End If

        If Not FoundResult Then
            Return False
        Else
            Return True
        End If
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataNaskah(Id_Jualan As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_Naskah(Id_Jualan)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_Naskah(Id_Jualan As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "Select DISTINCT
								A.No_Mohon,
								A.Tujuan, 
								A.Skop,
								A.Jenis_Dokumen,
								(SELECT Kategori_Perolehan FROM SMKB_Perolehan_Kaedah PK WHERE A.Jenis_Dokumen = PK.Kod_KategoriKaedah) As KaedahPO,
								A.Jenis_Barang,
								(SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE Kod = 'PO03' AND A.Jenis_Barang = lp.Kod_Detail) as KatPO,
								--B.Tarikh_Beli As TkhBeli,
                                C.Id_Jualan As IdNaskah,
								C.No_Sebut_Harga, 
								C.Harga,
								C.Tempat_Hantar,
								C.Tarikh_Masa_Mula_Perolehan As TkhMula,
								C.Tarikh_Masa_Mula_Iklan As TkhJual,
								C.Tarikh_Masa_Tamat_Perolehan As TkhTutup,
								C.Tempat_Lawatan_Tapak,
								C.Tarikh_Masa_Lawatan_Tapak as TkhLawat,
								C.Syarat_Perolehan,
								D.Pejabat As PTJ
								--E.Kod_Lesen,
								--F.Kod_Bidang,
                                --(SELECT (F.Kod_Bidang + ' - ' + B.Butiran ) As Bidang FROM SMKB_Syarikat_Bidang B Where F.Kod_Bidang = B.KodBidang) As ButiranBidang
								FROM SMKB_Perolehan_Permohonan_Hdr A, SMKB_Perolehan_Naskah_Jualan C, VPejabat D
								WHERE A.No_Mohon = C.No_Mohon AND LEFT(A.Kod_Ptj_Mohon,2)=D.KodPejabat
								AND C.Id_Jualan = @IdNaskah"

        'Dim query As String = "Select DISTINCT
        'A.No_Mohon,
        'A.Tujuan, 
        'A.Skop,
        'A.Jenis_Dokumen,
        '(SELECT Kategori_Perolehan FROM SMKB_Perolehan_Kaedah PK WHERE A.Jenis_Dokumen = PK.Kod_KategoriKaedah) As KaedahPO,
        'A.Jenis_Barang,
        '(SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE Kod = @Kod AND A.Jenis_Barang = lp.Kod_Detail) as KatPO,
        'B.Tarikh_Beli As TkhBeli,
        '                        C.Id_Jualan As IdNaskah,
        'C.No_Sebut_Harga, 
        'C.Harga,
        'C.Tempat_Hantar,
        'C.Tarikh_Masa_Mula_Perolehan As TkhMula,
        'C.Tarikh_Masa_Mula_Iklan As TkhJual,
        'C.Tarikh_Masa_Tamat_Perolehan As TkhTutup,
        'C.Tempat_Lawatan_Tapak,
        'C.Tarikh_Masa_Lawatan_Tapak as TkhLawat,
        'C.Syarat_Perolehan,
        'D.Pejabat As PTJ,
        'E.Kod_Lesen,
        'F.Kod_Bidang,
        '                        (SELECT (F.Kod_Bidang + ' - ' + B.Butiran ) As Bidang FROM SMKB_Syarikat_Bidang B Where F.Kod_Bidang = B.KodBidang) As ButiranBidang
        'FROM SMKB_Perolehan_Permohonan_Hdr A, SMKB_Perolehan_Pembelian_Hdr B, SMKB_Perolehan_Naskah_Jualan C, VPejabat D, SMKB_Perolehan_Lesen E, SMKB_Perolehan_Bidang F
        'WHERE A.No_Mohon = B.No_Mohon AND B.No_Mohon = C.No_Mohon AND LEFT(A.Kod_Ptj_Mohon,2)=D.KodPejabat AND C.Id_Jualan = E.Id_Jualan AND A.No_Mohon = F.No_Mohon
        'AND C.Id_Jualan = @IdNaskah"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod", "PO03"))
        param.Add(New SqlParameter("@IdNaskah", Id_Jualan))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_Lesen(Id) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_Lesen(Id)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_Lesen(Id As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Id_Jualan, Kod_Lesen, Maklumat_Lanjut,
								(SELECT Butiran From SMKB_Lookup_Detail lp WHERE Kod = @KodDtl AND Kod_Lesen = lp.Kod_Detail) as ButiranLesen
								FROM SMKB_Perolehan_Lesen 
								WHERE Id_Jualan = @Id"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Id", Id))
        param.Add(New SqlParameter("@KodDtl", "VDR03"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function CheckTempahNaskah(MklmtIklan As TawaranIklan) As String
        Dim resp As New ResponseRepository

        Dim StatusAktif As String
        Dim StatusLulus As String

        Dim Success As Integer = 0

        If MklmtIklan Is Nothing Then
            resp.Failed("Tiada Maklumat Naskah")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        StatusAktif = StatusAktifSyarikat(Session("ssusrID"))
        If StatusAktif <> "01" Then

            Select Case StatusAktif
                Case "X"
                    resp.Failed("Syarikat Anda Tidak Aktif, Sila Lengkapkan Pendaftaran Syarikat Anda.")
                Case "00"
                    resp.Failed("Syarikat Anda Tidak Aktif, Sila Lengkapkan Pendaftaran Syarikat Anda.")
                Case "02"
                    resp.Failed("Syarikat tuan telah disenarai hitam oleh pihak UTeM. Sila hubungi pihak UTeM.")
                Case "03"
                    resp.Failed("Syarikat tuan telah digantung oleh pihak UTeM. Sila hubungi pihak UTeM.")
            End Select

            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        StatusLulus = StatusLulusSyarikat(Session("ssusrID"))

        If StatusLulus <> "1" Then
            Select Case StatusLulus
                Case "X"
                    resp.Failed("Syarikat tuan sedang dalam semakan kelulusan pendaftaran. Sila hubungi pihak UTeM.")
                Case "2"
                    resp.Failed("Syarikat tuan Tidak Mendapat Kelulusan Untuk Pendaftaran. Sila hubungi pihak UTeM.")
                Case "3"
                    resp.Failed("Syarikat tuan sedang dalam semakan kelulusan pendaftaran. Sila hubungi pihak UTeM.")
                Case "4"
                    resp.Failed("Syarikat tuan sedang dalam semakan kelulusan kemaskini. Sila hubungi pihak UTeM.")
                Case "5"
                    resp.Failed("Syarikat tuan sedang dalam semakan kelulusan Kemaskini. Sila hubungi pihak UTeM.")
            End Select

            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If BeliIklan(Session("ssusrID"), MklmtIklan.OrderNaskahID) = "OK" Then
            resp.Failed("Syarikat Anda Telah Membeli Naskah Ini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'condition status katSya <> true
        If KatSyarikatKerja(Session("ssusrID")) = True Then

            Dim StatusLesenKerja As LesenTamatTempah = LesenTamatTempohCIDB(Session("ssusrID"), MklmtIklan.OrderNaskahID)
            If StatusLesenKerja.Status <> "00" Then
                Select Case StatusLesenKerja.Status
                    Case "01"
                        resp.Failed($"Sijil syarikat tuan: {StatusLesenKerja.KodDaftar} telah tamat pada {StatusLesenKerja.tamatDate.ToString("dddd, dd MMMM yyyy, hh:mm tt", New CultureInfo("en-MY"))}. Oleh itu, syarikat tuan tidak boleh membuat tempahan naskah jualan ini sehingga kemaskini dilakukan. Sila kemaskini sijil di menu Pendaftaran!")
                    Case "02"
                        resp.Failed($"Sijil syarikat tuan: {StatusLesenKerja.KodDaftar} telah tamat pada {StatusLesenKerja.tamatDate.ToString("dddd, dd MMMM yyyy, hh:mm tt", New CultureInfo("en-MY"))}. Oleh itu, syarikat tuan tidak boleh membuat tempahan naskah jualan ini sehingga kemaskini dilakukan. Sila kemaskini sijil di menu Pendaftaran!")
                    Case "03"
                        resp.Failed($"Sijil syarikat tuan: {StatusLesenKerja.KodDaftar} telah/tamat pada bulan ini. Oleh itu, syarikat tuan tidak boleh membuat tempahan naskah jualan ini sehingga kemaskini dilakukan. Sila kemaskini sijil di menu Pendaftaran!")
                End Select

                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            'Check Gred condition <> OK
            If IsGredMatch(MklmtIklan.OrderNaskahID, Session("ssusrID")) <> True Then
                resp.Failed("Gred CIDB syarikat tuan tidak layak untuk membolehkan beli naskah jualan ini. Sila kemaskini sijil di menu Pendaftaran")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            Dim DTKhususPO As New DataTable
            Dim DTKhususSya As New DataTable

            DTKhususPO = GetDataKhususPO(MklmtIklan.NoMohon)
            DTKhususSya = GetDataKhususSya(Session("ssusrID"))

            Dim FoundResult = False
            If DTKhususPO.Rows.Count > 1 Then
                If DTKhususSya.Rows.Count > 1 Then

                    'Dim Syarat As New List(Of String)
                    Dim foundOr = False, FoundDan = False, FoundDanOne = False
                    Dim ind = 0, indFoundDanOne = 0
                    For Each rowPO As DataRow In DTKhususPO.Rows
                        'For Each rowSya As DataRow In DTBidangSya.Rows
                        If rowPO("Syarat") = "0" Then
                            If DTKhususSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                If FoundDanOne Then
                                    If (indFoundDanOne = ind - 1) Then
                                        FoundDan = True
                                    End If
                                Else
                                    foundOr = True
                                End If
                            End If
                        ElseIf rowPO("Syarat") = "1" Then
                            If DTKhususSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                FoundDanOne = True
                                indFoundDanOne = ind
                            End If
                        ElseIf rowPO("Syarat") = "2" Then
                            If DTKhususSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                If FoundDanOne Then
                                    If (indFoundDanOne = ind - 1) Then
                                        FoundDan = True
                                        FoundDanOne = False
                                    End If
                                Else
                                    foundOr = True
                                End If
                            End If
                        End If
                        ind += 1
                        'Next
                    Next

                    FoundResult = foundOr Or FoundDan
                End If
            End If

            If Not FoundResult Then
                resp.Failed("Kod Khusus dan Kod Kategori CIDB syarikat tuan tidak layak untuk membolehkan beli naskah jualan ini. Sila kemaskini Kod Khusus di menu Pendaftaran!")
                Return JsonConvert.SerializeObject(resp.GetResult())
            Else
                Success += 1
            End If

        Else

            ''Perkhidmatan & Bekalan
            ''check Tamat Tempoh Lesen
            Dim StatusLesenLain As LesenTamatTempah = LesenTamatTempohCIDB(Session("ssusrID"), MklmtIklan.OrderNaskahID)
            If StatusLesenLain.Status <> "00" Then
                Select Case StatusLesenLain.Status
                    Case "01"
                        resp.Failed($"Sijil syarikat tuan: {StatusLesenLain.KodDaftar} telah tamat pada {StatusLesenLain.tamatDate.ToString("dddd, dd MMMM yyyy, hh:mm tt", New CultureInfo("en-MY"))}. Oleh itu, syarikat tuan tidak boleh membuat tempahan naskah jualan ini sehingga kemaskini dilakukan. Sila kemaskini sijil di menu Pendaftaran!")
                    Case "02"
                        resp.Failed($"Sijil syarikat tuan: {StatusLesenLain.KodDaftar} telah tamat pada {StatusLesenLain.tamatDate.ToString("dddd, dd MMMM yyyy, hh:mm tt", New CultureInfo("en-MY"))}. Oleh itu, syarikat tuan tidak boleh membuat tempahan naskah jualan ini sehingga kemaskini dilakukan. Sila kemaskini sijil di menu Pendaftaran!")
                    Case "03"
                        resp.Failed($"Sijil syarikat tuan: {StatusLesenLain.KodDaftar} telah/tamat pada bulan ini. Oleh itu, syarikat tuan tidak boleh membuat tempahan naskah jualan ini sehingga kemaskini dilakukan. Sila kemaskini sijil di menu Pendaftaran!")
                End Select

                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            'check lesen is exist?
            'Filter Condition
            'Filter Bidang

            'Condition -> Khusus
            Dim DTBidangPO As New DataTable
            Dim DTBidangSya As New DataTable

            DTBidangPO = GetDataBidangPO(MklmtIklan.NoMohon)
            DTBidangSya = GetDataBidangSya(Session("ssusrID"))

            Dim FoundBidang = False
            If DTBidangPO.Rows.Count > 0 Then
                If DTBidangSya.Rows.Count > 0 Then

                    'Dim Syarat As New List(Of String)
                    Dim foundOr = False, FoundDan = False, FoundDanOne = False
                    Dim ind = 0, indFoundDanOne = 0
                    For Each rowPO As DataRow In DTBidangPO.Rows
                        'For Each rowSya As DataRow In DTBidangSya.Rows
                        If rowPO("Syarat") = "0" Then
                            If DTBidangSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                If FoundDanOne Then
                                    If (indFoundDanOne = ind - 1) Then
                                        FoundDan = True
                                    End If
                                Else
                                    foundOr = True
                                End If
                            End If
                        ElseIf rowPO("Syarat") = "1" Then
                            If DTBidangSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                FoundDanOne = True
                                indFoundDanOne = ind
                            End If
                        ElseIf rowPO("Syarat") = "2" Then
                            If DTBidangSya.Select($"Kod_Bidang = '{ rowPO("Kod_Bidang")}'").Any() Then
                                If FoundDanOne Then
                                    If (indFoundDanOne = ind - 1) Then
                                        FoundDan = True
                                        FoundDanOne = False
                                    End If
                                Else
                                    foundOr = True
                                End If
                            End If
                        End If
                        ind += 1
                        'Next
                    Next

                    FoundBidang = foundOr Or FoundDan

                End If
            Else
                ' Handle the case where one of the DataTables doesn't have enough rows
                For Each rowPO As DataRow In DTBidangPO.Rows
                    For Each RowSya As DataRow In DTBidangSya.Rows
                        If rowPO("Kod_bidang") = RowSya("Kod_bidang") Then
                            FoundBidang = True
                        End If
                    Next
                Next
            End If

            If Not FoundBidang Then
                Return False
            Else
                Success += 1
            End If

        End If

        If Success <= 0 Then
            resp.Failed("Maaf, Tempahan Naskah Anda Tidak Berjaya")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Tahniah!, Syarikat Anda Layak Menempah Naskah ini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    'Check Bidang

    Private Function GetDataBidangPO(NoMohon As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT No_Mohon, Kod_Bidang, Syarat, urutan
                              FROM SMKB_Perolehan_Bidang 
                              WHERE No_Mohon = @NoMohon AND Status = @Status
                              ORDER BY CAST(urutan AS int) ASC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoMohon", NoMohon))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    Private Function GetDataBidangSya(IdSya As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select A.ID_Sykt, B.No_Daftar, B.Kod_Bidang 
                              From SMKB_Syarikat_Daftar A
                              INNER JOIN SMKB_Syarikat_Daftar_Bidang B ON B.No_Daftar = A.No_Daftar
                              WHERE A.Status = @Status1 AND B.Status = @Status2 AND A.ID_Sykt = @IdSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@Status1", "1"))
        param.Add(New SqlParameter("@Status2", "1"))

        Return db.Read(query, param)
    End Function

    Private Function GetDataKhususPO(NoMohon As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT A.Kod_Khusus, A.No_Mohon, A.Kod_kategori, A.Syarat, A.Urutan 
                               FROM SMKB_Perolehan_CIDB A
                               WHERE No_Mohon = @NoMohon
                               ORDER BY Urutan Asc"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoMohon", NoMohon))

        Return db.Read(query, param)
    End Function

    Private Function GetDataKhususSya(IdSya As String)
        Dim db As New DBKewConn
        Dim query As String = "SELECT A.ID_Sykt, C.ID_Sykt, A.No_Daftar, B.Kod_Kategori, B.Kod_Khusus
                               FROM SMKB_Syarikat_Daftar A
                               INNER JOIN SMKB_Syarikat_Daftar_CIDB B ON B.ID_Daftar = A.No_Daftar
                               INNER JOIN SMKB_Syarikat_Master C ON C.No_Sykt = A.ID_Sykt
                               WHERE C.No_Sykt = @IdSya AND A.Status = @Status1 AND B.Status = @Status2 "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@Status1", "1"))
        param.Add(New SqlParameter("@Status2", "1"))

        Return db.Read(query, param)
    End Function

    Private Function StatusAktifSyarikat(IdSya As String) As String
        Dim db As New DBKewConn
        Dim dt As New DataTable
        Dim Status As String = ""
        Dim query As String = "SELECT Status_Aktif FROM SMKB_Syarikat_Master WHERE No_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            ' Assuming only one row is returned, so we access the first row
            Status = dt.Rows(0)("Status_Aktif").ToString()
        End If

        ' Check if Status is null or an empty string
        If String.IsNullOrEmpty(Status) Then
            ' Handle if Status is null or empty
            Status = "X"
        End If

        Return Status
    End Function

    Private Function StatusLulusSyarikat(IdSya As String) As String
        Dim db As New DBKewConn
        Dim dt As New DataTable
        Dim Status As String = ""
        Dim query As String = "SELECT Status_Lulus FROM SMKB_Syarikat_Master WHERE No_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            ' Assuming only one row is returned, so we access the first row
            Status = dt.Rows(0)("Status_Lulus").ToString()
        End If

        ' Check if Status is null or an empty string
        If String.IsNullOrEmpty(Status) Then
            ' Handle if Status is null or empty
            Status = "X"
        End If

        Return Status
    End Function

    Private Function BeliIklan(IdSya As String, IdNaskah As String) As String
        Dim db As New DBKewConn
        Dim dt As New DataTable
        Dim Result As String
        Dim query As String = "SELECT Id_Jualan, Tarikh_Beli, ID_Syarikat 
                               FROM SMKB_Perolehan_Pembelian_Hdr A
                               INNER JOIN SMKB_Syarikat_Master B ON B.ID_Sykt = A.ID_Syarikat
                               WHERE Id_Jualan = @IdNaskah AND B.No_Sykt = @IdSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@IdNaskah", IdNaskah))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Result = "OK"
        Else
            Result = "X"
        End If

        Return Result
    End Function

    Private Function KatSyarikatKerja(IdSya As String) As String
        Dim db As New DBKewConn
        Dim dt As New DataTable
        Dim Status As Boolean

        Dim query As String = "SELECT * FROM SMKB_Syarikat_Master WHERE No_Sykt = @IdSya And Kerja = @kerja"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@kerja", True))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = True
        Else
            Status = False
        End If

        Return Status

    End Function

    Private Function LesenTamatTempohCIDB(IdSya As String, IdNaskah As String) As LesenTamatTempah
        Dim db As New DBKewConn
        Dim dt As New DataTable
        Dim data As New LesenTamatTempah()

        'Dim KodDaftar As String
        'Dim tamatDate As DateTime
        'Dim Status As String
        Dim query As String = "SELECT DISTINCT A.Id_Jualan, B.Kod_Lesen , C.Kod_Daftar, C.Tkh_Tamat
								FROM SMKB_Perolehan_Naskah_Jualan A
								INNER JOIN SMKB_Perolehan_Lesen B ON B.Id_Jualan = A.Id_Jualan
								INNER JOIN SMKB_Syarikat_Daftar C ON C.Kod_Daftar = B.Kod_Lesen
								INNER JOIN SMKB_Syarikat_Master D ON D.No_Sykt = c.ID_Sykt
								WHERE A.Id_Jualan = @IdNaskah AND B.Status = '1' and c.Status= '1' AND No_Sykt = @IdSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdNaskah", IdNaskah))
        param.Add(New SqlParameter("@IdSya", IdSya))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            For Each dr As DataRow In dt.Rows
                ' data.KodDaftar = dt.Rows(0)("Kod_Daftar").ToString()
                ' data.tamatDate = Convert.ToDateTime(dt.Rows(0)("Tkh_Tamat"))

                data.KodDaftar = dr.Item("Kod_Daftar").ToString()
                data.tamatDate = Convert.ToDateTime(dr.Item("Tkh_Tamat"))
                ' Get current year and month
                Dim currentYear As Integer = DateTime.Now.Year
                Dim currentMonth As Integer = DateTime.Now.Month

                If data.tamatDate.Year < currentYear Then
                    ' Expiration year is in the past
                    data.Status = "01"
                ElseIf data.tamatDate.Year = currentYear Then
                    If data.tamatDate.Month < currentMonth Then
                        ' Expiration month is in the past within the current year
                        data.Status = "02"
                    ElseIf data.tamatDate.Month = currentMonth Then
                        ' Expiration month is the current month within the current year
                        data.Status = "03"
                    Else
                        ' Expiration month is in the future within the current year
                        data.Status = "00"
                    End If
                Else
                    ' Expiration year is in the future
                    data.Status = "00"
                End If
            Next
        Else
            data.Status = "X"
        End If

        Return data
    End Function

    Private Function IsGredMatch(IdJualan As String, IdSya As String) As String
        Dim db As New DBKewConn
        Dim dt As New DataTable
        Dim Status As String

        Dim query As String = "SELECT DISTINCT A.ID_Sykt, B.Kod_Gred, C.Id_Jualan, C.Gred_CIDB 
							   FROM SMKB_Syarikat_Daftar A
							   INNER JOIN SMKB_Syarikat_Daftar_CIDB B ON B.ID_Daftar = A.No_Daftar
							   iNNER JOIN SMKB_Perolehan_Naskah_Jualan C ON C.Gred_CIDB = B.Kod_Gred
							   WHERE A.Status = @status1 and B.Status = @status2 AND C.Id_Jualan = @IdJualan 
                               AND A.ID_Sykt = @IdSya "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status1", "1"))
        param.Add(New SqlParameter("@status2", "1"))
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@IdJualan", IdJualan))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Status = True
        Else
            Status = False
        End If

        Return Status

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_OrderNaskah(IdNaskah As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetData_OrderNaskah(IdNaskah)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_OrderNaskah(IdNaskah As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT 
                               A.No_Perolehan, A.Tujuan, 
                               B.ID_Sykt, B.Nama_Sykt, B.Emel_Semasa, B.Tel_Pej_Semasa, 
                               C.Id_Jualan, C.No_Mohon ,C.Harga
							   FROM SMKB_Perolehan_Permohonan_Hdr A, SMKB_Syarikat_Master B, SMKB_Perolehan_Naskah_Jualan C
							   WHERE No_Sykt = @idSya AND A.No_Mohon = C.No_Mohon AND C.Id_Jualan = @IdNaskah"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", Session("ssusrID")))
        param.Add(New SqlParameter("@IdNaskah", IdNaskah))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function OrderNaskah(DataOrder As OrderIklan) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        Dim IdMohonDtls As List(Of String)
        Dim IdMohonDtl As String
        queryRB = New Query

        Try
            If DataOrder Is Nothing Then
                resp.Failed("Tiada ID")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If DataOrder.IdPembelian = "" Then
                DataOrder.IdPembelian = GenerateOrderNaskahID()
                If InsertPembelianHdr(DataOrder) <> "OK" Then
                    Throw New Exception("Gagal Membeli Naskah")
                End If

                If IsHargaNaskah(DataOrder.IdJualan) = "OK" Then
                    If UpdateStatBayar(DataOrder.IdPembelian) <> "OK" Then
                        Throw New Exception("Maaf Sistem Ralat")
                    End If
                End If

                IdMohonDtls = GetIdMohonDtl(DataOrder.NoMohon)
                For Each IdMohonDtl In IdMohonDtls
                    If InsertPembelianDtl(IdMohonDtl) <> "OK" Then
                        Throw New Exception("Gagal Membeli Naskah")
                    End If
                Next

                For Each IdMohonDtl In IdMohonDtls
                    If UpdateIdPembelian(IdMohonDtl, DataOrder.IdPembelian) <> "OK" Then
                        Throw New Exception("Gagal Membeli Naskah Jualan")
                    End If
                Next

                If InsertDataBuku(DataOrder.IdPembelian) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat maklumat Buku 1 dan Buku 2")
                End If

            Else

                Throw New Exception("Data Telah Wujud")

            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            Success -= 1
            queryRB.rollback()
        End Try

        If Success > 0 Then
            resp.SuccessPayload(DataOrder.IdPembelian)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed($"Naskah {DataOrder.IdJualan} Tidak Berjaya Di Tempah")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

    End Function

    Private Function InsertPembelianHdr(DataOrder As OrderIklan) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembelian_Hdr 
                               (Id_Pembelian, Id_jualan, No_Mohon, Kod_Syarikat, Tarikh_Beli, ID_Syarikat, Status) 
                               VALUES (@IdPembelian, @IdJualan, @NoMohon, @KodSya, @TkhBeli, @IdSyarikat, @Status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", DataOrder.IdPembelian))
        param.Add(New SqlParameter("@IdJualan", DataOrder.IdJualan))
        param.Add(New SqlParameter("@NoMohon", DataOrder.NoMohon))
        param.Add(New SqlParameter("@KodSya", "-"))
        param.Add(New SqlParameter("@TkhBeli", DateTime.Now))
        param.Add(New SqlParameter("@IdSyarikat", DataOrder.IdSyarikat))
        param.Add(New SqlParameter("@Status", "1"))

        Dim Key As New Dictionary(Of String, String)
        Key.Add("Id_Pembelian", DataOrder.IdPembelian)
        Key.Add("Id_Jualan", DataOrder.IdJualan)
        'Return db.Process(query, param)
        'Return RbQueryCmd("Id_Pembelian", DataOrder.IdPembelian, query, param)
        Return RbQueryCmdMulti(Key, query, param)
        'Return db.Process(query, param)
    End Function

    Private Function InsertPembelianDtl(IdMohonDtl As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembelian_Dtl (Id_Mohon_Dtl)
                               VALUES (@IdMohonDtl)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdMohonDtl", IdMohonDtl))

        Return RbQueryCmd("Id_Mohon_Dtl", IdMohonDtl, query, param)
    End Function

    Private Function GetIdMohonDtl(NoMohon As String) As List(Of String)
        Dim db As New DBKewConn
        Dim dt As New DataTable
        Dim IdMohonDtls As New List(Of String)
        Dim query As String = "SELECT Id_Mohon_Dtl
                            FROM SMKB_Perolehan_Permohonan_Dtl 
                            WHERE No_Mohon = @NoMohon"

        'Dim query1 As String = "SELECT Id_Mohon_Dtl, Kuantiti
        '                    FROM SMKB_Perolehan_Permohonan_Dtl 
        '                    WHERE No_Mohon = @NoMohon"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoMohon", NoMohon))

        dt = db.Read(query, param)
        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then
            For Each row As DataRow In dt.Rows
                If Not IsDBNull(row("Id_Mohon_Dtl")) Then
                    Dim IdMohonDtl As DateTime = DirectCast(row("Id_Mohon_Dtl"), DateTime)
                    ' Convert the DateTime object to the desired format
                    Dim formattedDate As String = IdMohonDtl.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
                    IdMohonDtls.Add(formattedDate)
                End If

                'If Not IsDBNull(row("Kuantiti")) Then
                '    Dim Kuantiti As Integer = row("Kuantiti")
                '    IdMohonDtls.Add(Kuantiti)
                'End If
            Next
        End If

        Return IdMohonDtls
    End Function

    Private Function UpdateIdPembelian(IdMohonDtl As String, IdPembelian As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dtl 
                               SET Id_Pembelian = @IdPembelian 
                               WHERE Id_Mohon_Dtl = @IdMohonDtl"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdMohonDtl", IdMohonDtl))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))

        Return RbQueryCmd("Id_mohon_Dtl", IdMohonDtl, query, param)
        'Return False
    End Function

    Private Function InsertDataBuku(IdPembelian As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembelian_Dokumen(Id_Pembelian, Kod_Dokumen, Kod_Buku, Status_Simpan, Status_Hantar, Status)
                                SELECT @IdPembelian, Kod_Dokumen, Kod_Buku, @StatSimpan, @StatHantar, Status
                                FROM SMKB_Perolehan_Dokumen
                                WHERE Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@StatSimpan", "0"))
        param.Add(New SqlParameter("@StatHantar", "0"))

        Dim Key As New Dictionary(Of String, String)
        Key.Add("Id_Pembelian", IdPembelian)
        Key.Add("Status", "1")

        Return db.Process(query, param)

        'Return RbQueryCmd("Id_Pembelian", DataOrder.IdPembelian, query, param)
        Return RbQueryCmdMulti(Key, query, param)
        'Return RbQueryCmd("Id_Pembelian", IdPembelian, query, param)
    End Function

    Private Function IsHargaNaskah(IdJualan As String) As String
        Dim dt As DataTable
        Dim result As String = "X" ' Default to "X" if the price is not null

        dt = GetHargaNaskah(IdJualan)

        If dt.Rows.Count > 0 AndAlso dt.Rows(0).Item("Harga") IsNot DBNull.Value Then
            ' If the DataTable contains rows and the "Harga" value is not null, change result to "OK"
            result = "OK"
        End If

        Return result
    End Function

    Private Function GetHargaNaskah(IdJualan As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Harga From SMKB_Perolehan_Naskah_Jualan WHERE Id_Jualan = @IdJualan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdJualan", IdJualan))

        Return db.Read(query, param)
    End Function

    Private Function UpdateStatBayar(IdPembelian As String) As String
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr SET Status_Bayar = @Status WHERE Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("Id_Pembelian", IdPembelian, query, param)
    End Function

    '////////////////////////////////////////////////    JAWAB IKLAN /////////////////////////////////////////////////////

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveMklmtPO(mklmtPO As MklmtPO) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        queryRB = New Query

        If mklmtPO Is Nothing Then
            resp.Failed("Sila Isi Maklumat Yang Diperlukan")
        End If

        Try
            If InsertMklmtPO(mklmtPO.IdPembelian, mklmtPO.BilTempoh, mklmtPO.JenTempoh) <> "OK" Then
                Throw New Exception("Gagal Menyimpan Maklumat Perolehan")
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            Success = 0
            queryRB.rollback()
            'resp.Failed(ex.Message)
            'Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        If Success <= 0 Then
            resp.Failed("Gagal Menyimpan Maklumat Perolehan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Berjaya Menyimpan Maklumat Perolehan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    Private Function InsertMklmtPO(IdPembelian As String, BilTempoh As Integer, JenTempoh As String)
        Dim db As DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr 
                               SET Tempoh = @BilTempoh, Jenis_Tempoh = @JenTempoh 
                               WHERE Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@BilTempoh", BilTempoh))
        param.Add(New SqlParameter("@JenTempoh", JenTempoh))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))

        Return RbQueryCmd("Id_Pembelian", IdPembelian, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_JawabPembelian() As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_JawabPembelian()

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_JawabPembelian() As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT DISTINCT
                                A.Tujuan AS Tajuk,
                                A.Skop As Skop ,
                                A.Kod_Ptj_Mohon As PTJ,
                                B.Harga AS HargaMeja, 
                                FORMAT(B.Tarikh_Masa_Mula_Iklan, 'dd/MM/yyyy') AS TkhPamer, 
                                FORMAT(B.Tarikh_Masa_Tamat_Perolehan, 'dddd, dd MMMM yyyy, hh:mm tt') As TkhTutup, 
                                C.Id_Pembelian As OrderID, 
                                FORMAT(C.Tarikh_Beli, 'dd/MM/yyyy') As TkhDiJual,
                                F.Status_Hantar As StatHantar,
                                C.Status_Cetak As StatCetak,
                                E.Pejabat
                                FROM SMKB_Perolehan_Permohonan_Hdr A
                                INNER JOIN SMKB_Perolehan_Naskah_Jualan B ON A.No_Mohon = B.No_Mohon
                                INNER JOIN SMKB_Perolehan_Pembelian_Hdr C ON A.No_Mohon = C.No_Mohon
								INNER JOIN SMKB_Syarikat_Master D ON D.ID_Sykt = C.ID_Syarikat
                                LEFT JOIN VPejabat E ON LEFT(A.Kod_Ptj_Mohon, 2) = E.KodPejabat
								INNER JOIN SMKB_Perolehan_Pembelian_Dokumen F ON F.Id_Pembelian = C.Id_Pembelian
                                WHERE C.Status = @status AND D.No_Sykt = @idSya"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", Session("ssusrID")))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataPerolehan(IdPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable
        dt = GetData_Perolehan(IdPembelian)
        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetData_Perolehan(IdPembelian As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT 
								A.Id_Jualan, A.Id_Pembelian, A.Tempoh, A.Jenis_Tempoh,
								D.No_Sykt, B.No_Perolehan, 
								B.Jenis_Barang, B.Tujuan, B.Skop, A.Tempoh, 
								(SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE lp.Kod_Detail = A.Jenis_Tempoh AND Kod = @kodTempoh AND lp.Status = @StatusTempoh) As ButiranTempoh,
								(SELECT BUTIRAN FROM SMKB_Lookup_Detail LP WHERE LP.Kod_Detail = B.Jenis_barang AND Kod = @kod AND Status = @Status) as ButiranKatSya
								FROM SMKB_Perolehan_Pembelian_Hdr A
								INNER JOIN SMKB_Perolehan_Permohonan_Hdr B ON B.No_Mohon = A.No_Mohon
								INNER JOIN SMKB_Perolehan_Naskah_Jualan C ON C.No_Mohon = B.No_Mohon
								INNER JOIN SMKB_Syarikat_Master D ON D.ID_Sykt = A.ID_Syarikat
								WHERE D.No_Sykt = @IdSya AND A.Id_Pembelian = @idPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdSya", Session("ssusrID")))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@kod", "PO03"))
        param.Add(New SqlParameter("@kodTempoh", "AR09"))
        param.Add(New SqlParameter("@StatusTempoh", "1"))
        param.Add(New SqlParameter("@idPembelian", IdPembelian))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodBuku1(KodDokumen As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetKod_Buku1(KodDokumen)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetKod_Buku1(KodDokumen As String) As DataTable
        Dim db As New DBKewConn
        ' Dim query As String = " SELECT Kod_Dokumen FROM SMKB_Perolehan_Dokumen WHERE Kod_Buku = @KodBuku AND Status = @Status"
        Dim query1 As String = "SELECT A.Kod_Dokumen, B.Butiran, B.Keutamaan
                                 FROM SMKB_Perolehan_Dokumen A
                                 INNER JOIN SMKB_Lookup_Detail B ON B.Kod_Detail = A.Kod_Dokumen 
                                 WHERE A.Kod_Buku = @KodBuku AND B.Kod= @Kod
                                 AND A.Status = @Status AND A.Kod_Dokumen = @KodDokumen"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBuku", "BK1"))
        param.Add(New SqlParameter("@Kod", "VDR10"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@KodDokumen", KodDokumen))

        Return db.Read(query1, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodBuku2(KodDokumen As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetKod_Buku2(KodDokumen)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetKod_Buku2(KodDokumen As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT A.Kod_Dokumen, B.Butiran, B.Keutamaan
                                 FROM SMKB_Perolehan_Dokumen A
                                 INNER JOIN SMKB_Lookup_Detail B ON B.Kod_Detail = A.Kod_Dokumen 
                                 WHERE A.Kod_Buku = @KodBuku AND B.Kod= @Kod
                                 AND A.Status = @Status AND A.Kod_Dokumen = @KodDokumen"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodBuku", "BK2"))
        param.Add(New SqlParameter("@Kod", "VDR10"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@KodDokumen", KodDokumen))

        Return db.Read(query, param)
    End Function

    'load Buku1
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListBuku1(IdPembelian) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_Buku1(IdPembelian)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_Buku1(IdPembelian As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT A.Id_Pembelian, A.Kod_Dokumen, B.Butiran As ButiranDokumen, A.Status_Simpan, A.Status_Hantar
                                 FROM SMKB_Perolehan_Pembelian_Dokumen A
                                 INNER Join SMKB_Lookup_Detail B ON B.Kod_Detail =A.Kod_Dokumen 
                                 WHERE B.Kod = @kod AND A.Status = @Status AND A.Kod_Buku = @KodBuku AND A.Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@kod", "VDR10"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@KodBuku", "BK1"))

        Return db.Read(query, param)
    End Function

    'load Buku2
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListBuku2(IdPembelian) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_Buku2(IdPembelian)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_Buku2(IdPembelian As String)
        Dim db As New DBKewConn
        Dim query As String = "SELECT A.Id_Pembelian, A.Kod_Dokumen, B.Butiran As ButiranDokumen, A.Status_Simpan, A.Status_Hantar
                                 FROM SMKB_Perolehan_Pembelian_Dokumen A
                                 INNER Join SMKB_Lookup_Detail B ON B.Kod_Detail =A.Kod_Dokumen 
                                 WHERE B.Kod = @kod AND A.Status = @Status AND A.Kod_Buku = @KodBuku AND A.Id_Pembelian = @IdPembelian"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@kod", "VDR10"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@KodBuku", "BK2"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveJawapan(IdPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        Dim dtBuku1 As DataTable
        Dim dtBuku2 As DataTable

        If IdPembelian Is Nothing Then
            resp.Failed("Id Tidak Sah")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        dtBuku1 = GetStatSimpanBuku1(IdPembelian)
        dtBuku2 = GetStatSimpanBuku2(IdPembelian)

        If dtBuku1.Rows.Count > 0 Then
            resp.Failed("Sila Lengkapkan Dan Simpan Maklumat Di Buku 1")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If dtBuku2.Rows.Count > 0 Then
            resp.Failed("Sila Lengkapkan Dan Simpan Maklumat Di Buku 2")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try
            If UpdateStatHantarDok(IdPembelian) <> "OK" Then
                Throw New Exception("Hantar Jawapan Tidak Berjaya")
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            Success = 0
            queryRB.rollback()
        End Try

        If Success > 0 Then
            resp.Success("Jawapan Berjaya Di Hantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Jawapan Gagal Di Hantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    Private Function GetStatSimpanBuku1(IdPembelian As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Status_Simpan FROM SMKB_Perolehan_Pembelian_Dokumen
                               WHERE Status_Simpan = @StatSimpan AND Id_Pembelian = @IdPembelian AND Kod_Buku = @KodBuku1 
                               AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@StatSimpan", "0"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@KodBuku1", "BK1"))

        Return db.Read(query, param)
    End Function

    Private Function GetStatSimpanBuku2(IdPembelian As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Status_Simpan FROM SMKB_Perolehan_Pembelian_Dokumen
                               WHERE Status_Simpan = @StatSimpan AND Id_Pembelian = @IdPembelian
                               AND Kod_Buku = @KodBuku2 AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@StatSimpan", "0"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@KodBuku2", "BK2"))

        Return db.Read(query, param)
    End Function

    Private Function UpdateStatHantarDok(IdPembelian As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen SET Status_Hantar = @StatHantar
                               WHERE Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@StatHantar", "1"))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))

        Return RbQueryCmd("Id_PemBelian", IdPembelian, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSahDok(KodDok As String, IdPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetListSah(KodDok, IdPembelian)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetListSah(KodDok As String, IdPembelian As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Status_Simpan, Status_Hantar 
                               FROM SMKB_Perolehan_Pembelian_Dokumen WHERE Kod_Dokumen = @KodDokumen
                               AND Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodDokumen", KodDok))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetProfilSyarikat(IdSya) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_ProfilSyarikat(IdSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_ProfilSyarikat(IdSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Nama_Dok, Jenis_Dok, Bil, Path 
                               FROM SMKB_Syarikat_Lampiran 
                               WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenisDok AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@jenisDok", "PS"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePengesahan(MklmtSah As MklmtPengesahan) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0

        If MklmtSah Is Nothing Then
            resp.Failed("Sila Isi Maklumat Yang Diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try
            Dim errorMessages As New Dictionary(Of String, String) From {
        {"01", "Gagal Menyimpan Pengesahan Profil"},
        {"02", "Gagal Menyimpan Pengesahan Syarat Am"},
        {"03", "Gagal Menyimpan Pengesahan Jadual Harga"},
        {"04", "Gagal Menyimpan Pengesahan Jaminan Pembekal"},
        {"05", "Gagal Menyimpan Pengesahan Suakt Akaun Pembida"},
        {"06", "Gagal Menyimpan Pengesahan Pengesahan Pengalaman"},
        {"07", "Gagal Menyimpan Pengesahan Surat MTO"},
        {"08", "Gagal Menyimpan Pengesahan Salian Sijil Terkini"},
        {"09", "Gagal Menyimpan Pengesahan Jadual Perancangan Kerja"},
        {"10", "Gagal Menyimpan Pengesahan Authorization Letter Pembekal"},
        {"11", "Gagal Menyimpan Pengesahan Katalog"},
        {"12", "Gagal Menyimpan Pengesahan Sample"},
        {"13", "Gagal Menyimpan Pengesahan Borang Penentuan Teknikal"}
    }

            If errorMessages.ContainsKey(MklmtSah.KodDokumen) Then
                If UpdateSah(MklmtSah) <> "OK" Then
                    Throw New Exception(errorMessages(MklmtSah.KodDokumen))
                End If
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            Success -= 1
            queryRB.rollback()
        End Try


        If Success > 0 Then
            resp.Success("Pengesahan Berjaya")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Pengesahan Tidak Berjaya")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    Private Function UpdateSah(MklmtSah As MklmtPengesahan) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen 
                               SET Status_Simpan = @StatSimpan
                               WHERE Id_Pembelian = @IdPembelian 
                               AND Kod_Dokumen = @KodDokumen"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@StatSimpan", MklmtSah.ValueSah))
        param.Add(New SqlParameter("@IdPembelian", MklmtSah.IdPembelian))
        param.Add(New SqlParameter("@KodDokumen", MklmtSah.KodDokumen))

        Dim Key As New Dictionary(Of String, String)
        Key.Add("Id_Pembelian", MklmtSah.IdPembelian)
        Key.Add("Kod_Dokumen", MklmtSah.KodDokumen)

        Return RbQueryCmdMulti(Key, query, param)
    End Function

    Private Function UpdateSahKatalog(IdPembelian As String, KodDokumen As String, ValueSah As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dokumen 
                               SET Status_Simpan = @StatSimpan
                               WHERE Id_Pembelian = @IdPembelian 
                               AND Kod_Dokumen = @KodDokumen"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@StatSimpan", ValueSah))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@KodDokumen", KodDokumen))

        Dim Key As New Dictionary(Of String, String)
        Key.Add("Id_Pembelian", IdPembelian)
        Key.Add("Kod_Dokumen", KodDokumen)

        Return RbQueryCmdMulti(Key, query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetNegara(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodNegara(q)
        Return JsonConvert.SerializeObject(tmpDT)
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

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataJadual(IdPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dt As New DataTable

        dt = GetData_Jadual(IdPembelian)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetData_Jadual(IdPembelian As String) As DataTable
        Dim db As New DBKewConn
        'Dim query As String = "SELECT DISTINCT A.No_Mohon, A.Id_Mohon_Dtl, Butiran, Ukuran,
        '(SELECT Butiran FROM SMKB_Lookup_Detail LP WHERE A.Ukuran = LP.Kod_Detail AND Kod = @KodLookUp) AS ButiranUkuran,
        'C.Kod_Negara_Pembuat,
        '(SELECT Butiran FROM SMKB_Lookup_Detail LP WHERE C.Kod_Negara_Pembuat = LP.Kod_Detail AND Kod = @LookupNegara) As ButiranNegara,
        'A.Kuantiti, C.Harga_Seunit, C.Harga_Seunit_Bercukai, C.Jumlah_Harga, C.Jumlah_Harga_Bercukai
        'FROM SMKB_Perolehan_Permohonan_Dtl A
        'INNER JOIN SMKB_Perolehan_Pembelian_Hdr B ON A.No_Mohon = B.No_Mohon
        'INNER JOIN SMKB_Perolehan_Pembelian_Dtl C ON C.Id_Pembelian = B.Id_Pembelian
        'WHERE B.Id_Pembelian = @IdPembelian"

        Dim query As String = "SELECT 
								A.Id_Dtl,
								A.Id_Pembelian,
								A.Id_Mohon_Dtl,
								B.Butiran,
								A.Jenama,
								A.Model,
								B.Ukuran,
								(SELECT Butiran FROM SMKB_Lookup_Detail LP WHERE B.Ukuran = LP.Kod_Detail AND Kod = @KodLookUp) AS ButiranUkuran,
								A.Kod_Negara_Pembuat,
								(SELECT Butiran FROM SMKB_Lookup_Detail LP WHERE A.Kod_Negara_Pembuat = LP.Kod_Detail AND Kod = @LookupNegara) As ButiranNegara,
								B.Kuantiti,
								A.Harga_Seunit,
								A.Harga_Seunit_Bercukai,
								A.Jumlah_Harga,
								A.Jumlah_Harga_Bercukai
								FROM SMKB_Perolehan_Pembelian_Dtl A
								INNER JOIN SMKB_Perolehan_Permohonan_Dtl B ON B.Id_Mohon_Dtl = A.Id_Mohon_Dtl
								WHERE Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@KodLookUp", "PO06"))
        param.Add(New SqlParameter("@LookupNegara", "0001"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveDataJadual(Jadual As MklmtJadual) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        queryRB = New Query

        If Jadual Is Nothing Then
            resp.Failed("Sila Lengkapkan Maklumat Yang Diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try
            For Each DataRow As JadualDetails In Jadual.JadualDetail
                If UpdateDataJadual(DataRow.IdDtl, DataRow.Jenama, DataRow.Model, DataRow.Negara, DataRow.Kuantiti, DataRow.HargaUnit,
                                    DataRow.HargaUnitCukai, DataRow.JumHarga, DataRow.JumHargaCukai) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat Jadual Harga")
                End If
            Next

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            Success = 0
            queryRB.rollback()
        End Try

        If Success > 0 Then
            resp.Success("Berjaya Menyimpan Maklumat Jadual")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Gagal Menyimpan Maklumat Jadual")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

    End Function

    Private Function UpdateDataJadual(IdDtl As String, Jenama As String, Model As String, Negara As String,
                                      Kuantiti As String, HargaUnit As String, HargaUnitCukai As String,
                                      JumHarga As String, JumHargaCukai As String) As String
        Dim db As New DBKewConn
        'queryRB = New Query

        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dtl 
                               SET Kuantiti = @Kuantiti, Jenama = @Jenama, Model = @Model, Kod_Negara_Pembuat = @Negara, 
                               Harga_Seunit = @HargaUnit, Harga_Seunit_Bercukai = @HargaUnitCukai, Jumlah_Harga = @JumHarga,
                               Jumlah_Harga_Bercukai = @JumHargaCukai WHERE Id_Mohon_Dtl = @IdMohonDtl"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdMohonDtl", IdDtl))
        param.Add(New SqlParameter("@Jenama", Jenama))
        param.Add(New SqlParameter("@Model", Model))
        param.Add(New SqlParameter("@Negara", Negara))
        param.Add(New SqlParameter("@Kuantiti", Kuantiti))
        param.Add(New SqlParameter("@HargaUnit", HargaUnit))
        param.Add(New SqlParameter("@HargaUnitCukai", HargaUnitCukai))
        param.Add(New SqlParameter("@JumHarga", JumHarga))
        param.Add(New SqlParameter("@JumHargaCukai", JumHargaCukai))

        'Dim Key As New Dictionary(Of String, String)
        'Key.Add("Id_Mohon_Dtl", IdDtl)

        'Return RbQueryCmdMulti(Key, query, param)

        Return RbQueryCmd("Id_Mohon_Dtl", IdDtl, query, param)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadList_SenaraiPengalaman(idSemSya As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_SenaraiPengalaman(idSemSya)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetList_SenaraiPengalaman(idSemSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Bil as IdPengalaman, ID_Sykt as IdSemSya , Tajuk_Projek as TajukProjek, Jabatan as NamaSyarikat, FORMAT(Tkh_Mula, 'dd/MM/yyyy') as TarikhMula, FORMAT(Tkh_Tamat, 'dd/MM/yyyy') As TarikhTamat, Nilai_Jualan as NilaiJualan FROM SMKB_Syarikat_Pengalaman WHERE ID_Sykt = @idSemSya AND Status = @status"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idSemSya", idSemSya))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSijilBank(IdSya) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable
        Dim BankTerkini As Boolean = False

        If IdSya <> "" Then
            BankTerkini = CheckBankTerkini(IdSya)
        End If

        If BankTerkini = False Then
            dt = GetList_SijilBank(IdSya)
        Else

            dt = GetList_SijilBankTerkini(IdSya)
        End If

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function CheckBankTerkini(IdSya As String) As Boolean
        Dim db As New DBKewConn
        Dim dt As New DataTable

        Dim query As String = "SELECT Jenis_Dok 
                               FROM SMKB_Perolehan_Jawapan_Lampiran 
                               WHERE No_Rujukan = @IdSya AND Jenis_Dok = @JenDok AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@JenDok", "Bank"))
        param.Add(New SqlParameter("@Status", "1"))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Function GetList_SijilBank(IdSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Nama_Dok, Jenis_Dok, Bil, Path 
                               FROM SMKB_Syarikat_Lampiran 
                               WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenisDok AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@jenisDok", "BANK"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    Private Function GetList_SijilBankTerkini(IdSya As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Nama_Dok, Jenis_Dok, Bil, Path 
                               FROM SMKB_Perolehan_Jawapan_Lampiran 
                               WHERE No_Rujukan = @idSya AND Jenis_Dok = @jenisDok AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@jenisDok", "BANK"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveSijilBank(Bank As SijilBank) As String
        Dim resp As New ResponseRepository
        Dim success As Integer = 0
        queryRB = New Query

        If Bank Is Nothing Then
            resp.Failed("Sila Upload Jadual Kerja")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try

            For Each dataFile As MklmtFile In Bank.ListFile
                dataFile.Bil = GenerateBilFile(Bank.IdPembelian)
                If InsertLampiranJawapan(Bank.IdPembelian, dataFile.IdSya, dataFile.JenDok, dataFile.FileName, dataFile.Bil, dataFile.filePath, dataFile.JenFile) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat lampiran")
                End If
            Next

            success += 1
            queryRB.finish()

        Catch ex As Exception
            success = 0
            queryRB.rollback()
        End Try

        If success > 0 Then
            resp.Success("Fail Berjaya Di Simpan")
        Else
            resp.Failed("Fail Gagal Di Simpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetHdrSpekAm(IdPembelian As String) As String
        Dim dt As New DataTable

        Dim NoMohon As String = GetNoMohon(IdPembelian)

        dt = GetHdr_SpekAm(NoMohon)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetHdr_SpekAm(NoMohon As String) As DataTable
        Dim db As New DBKewConn

        Dim query As String = "SELECT DISTINCT A.No_Mohon, A.Kod_Spesifikasi, B.Butiran
							   FROM SMKB_Perolehan_Spesifikasi_Am A
							   INNER JOIN SMKB_Perolehan_Spesifikasi B ON B.Kod = A.Kod_Spesifikasi
							   WHERE No_Mohon = @NoMohon"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoMohon", NoMohon))

        Return db.Read(query, param)
    End Function

    Private Function GetNoMohon(IdPembelian As String) As String
        Dim db As New DBKewConn
        Dim dt As New DataTable
        Dim NoMohon As String

        Dim query As String = "SELECT No_Mohon FROM SMKB_Perolehan_Pembelian_Hdr WHERE Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))

        dt = db.Read(query, param)

        If dt.Rows.Count() > 0 Then
            NoMohon = dt.Rows(0).Item("No_Mohon")
            Return NoMohon
        Else
            Return ""
        End If
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_ListDetailAm(kod As String, no_mohon As String) As String
        Dim resp As New ResponseRepository
        Dim dt As New DataTable

        If kod = "" Or String.IsNullOrEmpty(no_mohon) Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetSpek_DetailList(kod, no_mohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpek_DetailList(Kod As String, NoMohon As String) As DataTable
        Dim db As New DBKewConn
        Dim dt As New DataTable

        Dim query As String = "SELECT A.id_am, no_mohon,kod_spesifikasi,butiran,wajaran, B.Jawapan 
                                FROM SMKB_Perolehan_Spesifikasi_Am A
					            LEFT JOIN SMKB_Perolehan_Jawapan_Am B ON B.Id_Am = A.Id_Am
                                WHERE kod_spesifikasi = @Kod and no_mohon = @NoMohon
                                ORDER by A.id_am"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoMohon", NoMohon))
        param.Add(New SqlParameter("@Kod", Kod))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveJawapanAm(DataJawapanAm As JawapanAm) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        Dim db As New DBKewConn
        queryRB = New Query

        If DataJawapanAm Is Nothing Then
            resp.Success("Berjaya Menyimpan Maklumat Jadual")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try
            'For Each DataRow As JawapanAmDetails In DataJawapanAm.JawapanAmDetail

            '    Dim formattedIdTeknikal As String = ""
            '    formattedIdTeknikal = DataRow.IdAm.ToString("yyyy-MM-dd HH:mm:ss.fffffff")

            '    If InsertJawapanAm(DataJawapanAm.IdPembelian, formattedIdTeknikal, DataRow.JawapanAm) <> "OK" Then
            '        Throw New Exception("Gagal Menyimpan Maklumat Jadual Harga")
            '    End If
            'Next

            Dim formattedIdTeknikal As String = ""
            formattedIdTeknikal = DataJawapanAm.IdAm.ToString("yyyy-MM-dd HH:mm:ss.fffffff")

            If InsertJawapanAm(DataJawapanAm.IdPembelian, formattedIdTeknikal, DataJawapanAm.JawapanAm) <> "OK" Then
                Throw New Exception("Gagal Menyimpan Maklumat Jadual Harga")
            End If

            Success += 1
            'queryRB.finish()

        Catch ex As Exception
            Success = 0
            'queryRB.rollback()
        End Try

        If Success > 0 Then
            resp.Success("Jawapan Anda Berjaya Di Simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Jawapan Anda Gagal Di Simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

    End Function

    Private Function InsertJawapanAm(IdPembelian As String, IdAm As String, JawapanAm As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Jawapan_Am 
                               (Id_Pembelian, Id_Am, Jawapan, Skor, Status) VALUES (@IdPembelian, @IdAm, @JawapanAm, @Skor, @Status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@IdAm", IdAm))
        param.Add(New SqlParameter("@JawapanAm", JawapanAm))
        param.Add(New SqlParameter("@Skor", "0"))
        param.Add(New SqlParameter("@Status", "1"))

        Dim Key As New Dictionary(Of String, String)
        Key.Add("Id_Pembelian", IdPembelian)
        Key.Add("Id_Am", IdAm)

        Return db.Process(query, param)

        'Return RbQueryCmdMulti(Key, query, param)
    End Function

    '//////////////////////////////////////////// Speksifikasi Teknikal /////////////////////////////////

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetHdrSpekTeknikal(IdPembelian As String) As String
        Dim dt As New DataTable

        Dim NoMohon As String = GetNoMohon(IdPembelian)

        dt = GetHdr_SpekTeknikal(NoMohon)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetHdr_SpekTeknikal(NoMohon As String) As DataTable
        Dim db As New DBKewConn

        'Dim query As String = "SELECT DISTINCT A.No_Mohon, A.Kod_Spesifikasi, B.Butiran
        '  FROM SMKB_Perolehan_Spesifikasi_Am A
        '  INNER JOIN SMKB_Perolehan_Spesifikasi B ON B.Kod = A.Kod_Spesifikasi
        '  WHERE No_Mohon = @NoMohon"
        'Dim query1 As String = "SELECT A.Id_Mohon_Dtl, A.No_Mohon, A.Butiran, A.Jumlah_Harga, B.Jenama, B.Model, B.Kod_Negara_Pembuat,
        '                        (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE B.Kod_Negara_Pembuat = lp.Kod_Detail AND Kod = '0001') AS ButiranNegara
        '                        FROM SMKB_Perolehan_Permohonan_Dtl A
        '                        INNER JOIN SMKB_Perolehan_Pembelian_Dtl B ON B.Id_Mohon_Dtl = A.Id_Mohon_Dtl
        '                        WHERE No_Mohon = @NoMohon"
        Dim query2 As String = "SELECT DISTINCT A.Id_Mohon_Dtl, A.No_Mohon, A.Butiran, A.Jumlah_Harga, B.Jenama, B.Model, B.Kod_Negara_Pembuat,
                                (SELECT Butiran FROM SMKB_Lookup_Detail lp WHERE B.Kod_Negara_Pembuat = lp.Kod_Detail AND Kod = '0001') AS ButiranNegara
                                FROM SMKB_Perolehan_Permohonan_Dtl A
                                INNER JOIN SMKB_Perolehan_Pembelian_Dtl B ON B.Id_Mohon_Dtl = A.Id_Mohon_Dtl
                                INNER JOIN SMKB_Perolehan_Spesifikasi_Teknikal C ON C.Id_Mohon_Dtl = B.Id_Mohon_Dtl 
                                WHERE C.No_Mohon = @NoMohon"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoMohon", NoMohon))

        Return db.Read(query2, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadData_ListDetailTeknikal(kod As String, no_mohon As String) As String
        Dim resp As New ResponseRepository
        Dim dt As New DataTable

        If kod = "" Or String.IsNullOrEmpty(no_mohon) Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetSpek_DetailListTeknikal(kod, no_mohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpek_DetailListTeknikal(Kod As String, NoMohon As String) As DataTable
        Dim db As New DBKewConn
        Dim dt As New DataTable

        'Dim query As String = "SELECT A.id_am, no_mohon,kod_spesifikasi,butiran,wajaran, B.Jawapan 
        '                        FROM SMKB_Perolehan_Spesifikasi_Am A
        '         LEFT JOIN SMKB_Perolehan_Jawapan_Am B ON B.Id_Am = A.Id_Am
        '                        WHERE kod_spesifikasi = @Kod and no_mohon = @NoMohon
        '                        ORDER by A.id_am"

        Dim query1 As String = "SELECT Distinct A.Id_Teknikal, A.Id_Mohon_Dtl, A.Butiran, B.Id_Pembelian, B.Jawapan, B.Sampel, B.Katalog 
                                FROM SMKB_Perolehan_Spesifikasi_Teknikal A
                                LEFT JOIN SMKB_Perolehan_Jawapan_Teknikal B ON B.Id_Teknikal = A.Id_Teknikal
                                WHERE A.No_Mohon = @NoMohon AND A.Id_Mohon_Dtl = @Kod"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoMohon", NoMohon))
        param.Add(New SqlParameter("@Kod", Kod))

        Return db.Read(query1, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveJawapanTeknikal(DataJawapanTeknikal As JawapanTeknikal) As String
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        queryRB = New Query

        If DataJawapanTeknikal Is Nothing Then
            resp.Failed("Sila Lengkapkan Jawapan Di Ruang yang Disediakan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try
            For Each DataRow As JawapanTeknikalDetails In DataJawapanTeknikal.JawapanTeknikalDetail

                Dim formattedIdTeknikal As String = ""
                formattedIdTeknikal = DataRow.IdTeknikal.ToString("yyyy-MM-dd HH:mm:ss.fffffff")

                If InsertJawapanTeknikal(DataJawapanTeknikal.IdPembelian, formattedIdTeknikal, DataRow.JawapanTeknikal, DataRow.Sampel, DataRow.Katalog) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat Jadual Harga")
                End If
            Next

            Success += 1
            'queryRB.finish()

        Catch ex As Exception
            Success = 0
            queryRB.rollback()
        End Try

        If Success > 0 Then
            resp.Success("Jawapan Anda Berjaya Di Simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Jawapan Anda Gagal Di Simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

    End Function

    Private Function InsertJawapanTeknikal(IdPembelian As String, IdTeknikal As String, JawapanTeknikal As String, Sampel As String, Katalog As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Jawapan_Teknikal (Id_Pembelian, Id_Teknikal, Jawapan, Skor, Sampel, Katalog, Status)
                               VALUES (@IdPembelian, @IdTeknikal, @JawapanTeknikal, @Skor, @Sampel, @Katalog, @Status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@IdTeknikal", IdTeknikal))
        param.Add(New SqlParameter("@JawapanTeknikal", JawapanTeknikal))
        param.Add(New SqlParameter("@Skor", "0"))
        param.Add(New SqlParameter("@Sampel", Sampel))
        param.Add(New SqlParameter("@Katalog", Katalog))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Process(query, param)
        'Return RbQueryCmd("Id_Teknikal", IdTeknikal, query, param)
    End Function

    '/////////////////////////////////////////////  Jadual Kerja   ///////////////////////////////////////////////

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJadualKerja(IdSya As String, IdPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_JadualKerja(IdSya, IdPembelian)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_JadualKerja(IdSya As String, IdPembelian As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Nama_Dok, Jenis_Dok, Bil, Path 
                               FROM SMKB_Perolehan_Jawapan_Lampiran 
                               WHERE No_Rujukan = @idSya AND Jenis_Dok = @jenisDok AND Id_Pembelian = @IdPembelian AND Status = @status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@jenisDok", "JK"))
        param.Add(New SqlParameter("@status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveJadualKerja(JK As JadualKerja) As String
        Dim resp As New ResponseRepository
        Dim success As Integer = 0
        queryRB = New Query

        If JK Is Nothing Then
            resp.Failed("Sila Upload Jadual Kerja")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try

            For Each dataFile As MklmtFile In JK.ListFile
                dataFile.Bil = GenerateBilFile(JK.IdPembelian)
                If InsertLampiranJawapan(dataFile.NoRujukan, dataFile.IdSya, dataFile.JenDok, dataFile.FileName, dataFile.Bil, dataFile.filePath, dataFile.JenFile) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat lampiran")
                End If
            Next

            success += 1
            queryRB.finish()

        Catch ex As Exception
            success = 0
            queryRB.rollback()
        End Try

        If success > 0 Then
            resp.Success("Fail Berjaya Di Simpan")
        Else
            resp.Failed("Fail Gagal Di Simpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertLampiran(idSya As String, noRujukan As String, jenDok As String, fileName As String, bil As String, filePath As String, jenFile As String)
        Dim db = New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Syarikat_Lampiran (ID_Sykt, No_Rujukan, Jenis_Dok, Nama_Dok, Bil, Path, Content_Type, Status) 
                               VALUES (@idSya, @noRujukan, @jenDok, @namadok, @bil, @filePath, @jenFile, @status)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idSya", idSya))
        param.Add(New SqlParameter("@JenDok", jenDok))
        param.Add(New SqlParameter("@namaDok", fileName))
        param.Add(New SqlParameter("@bil", bil))
        param.Add(New SqlParameter("@filePath", filePath))
        param.Add(New SqlParameter("@jenFile", jenFile))

        'If String.IsNullOrEmpty(idDok) Then
        '    param.Add(New SqlParameter("@idDok", DBNull.Value))
        'Else
        '    param.Add(New SqlParameter("@idDok", idDok))
        'End If

        If String.IsNullOrEmpty(noRujukan) Then
            param.Add(New SqlParameter("@noRujukan", DBNull.Value))
        Else
            param.Add(New SqlParameter("@noRujukan", noRujukan))
        End If

        param.Add(New SqlParameter("@status", 1))

        Dim Key As New Dictionary(Of String, String)
        Key.Add("ID_Sykt", idSya)
        Key.Add("Bil", bil)

        Return RbQueryCmdMulti(Key, query, param)
    End Function

    Private Function InsertLampiranJawapan(IdPembelian As String, NoRujukan As String, Jenis_Dok As String, NamaDok As String, Bil As Integer, Path As String, ContentType As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Jawapan_Lampiran 
                               (Id_Pembelian, No_Rujukan, Jenis_Dok, Nama_Dok, Bil, Path, Content_Type, Status) 
                               VALUES (@IdPembelian, @noRujukan, @jenDok, @namadok, @bil, @filePath, @jenFile, @status)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@JenDok", Jenis_Dok))
        param.Add(New SqlParameter("@namaDok", NamaDok))
        param.Add(New SqlParameter("@bil", Bil))
        param.Add(New SqlParameter("@filePath", Path))
        param.Add(New SqlParameter("@jenFile", ContentType))

        If String.IsNullOrEmpty(NoRujukan) Then
            param.Add(New SqlParameter("@noRujukan", DBNull.Value))
        Else
            param.Add(New SqlParameter("@noRujukan", NoRujukan))
        End If

        param.Add(New SqlParameter("@status", 1))

        Dim Key As New Dictionary(Of String, String)
        Key.Add("Id_Pembelian", IdPembelian)
        Key.Add("Bil", Bil)

        Return RbQueryCmdMulti(Key, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAL(IdSya, IdPembelian) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_AL(IdSya, IdPembelian)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_AL(IdSya As String, IdPembelian As String) As DataTable
        Dim db = New DBKewConn
        'Dim query As String = "SELECT Nama_Dok, Jenis_Dok, Bil, Path 
        '                       FROM SMKB_Syarikat_Lampiran 
        '                       WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenisDok AND Status = @status"

        Dim query1 As String = "SELECT Nama_Dok, Jenis_Dok, Bil, path
                                FROM SMKB_Perolehan_Jawapan_Lampiran
                                WHERE No_Rujukan = @IdSya AND Id_Pembelian = @IdPembelian AND Jenis_Dok = @JenDok AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdSya", IdSya))
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))
        param.Add(New SqlParameter("@JenDok", "AL"))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query1, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTajukProjek(ByVal q As String) As String
        Dim tmpDT As DataTable = GetList_TajukProjek(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetList_TajukProjek(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Bil As value, Tajuk_Projek As text
                               FROM SMKB_Syarikat_Pengalaman
                               WHERE ID_Sykt = @IdSya AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "AND Butiran LIKE '%' + @kod + '%'"
            param.Add(New SqlParameter("@kod", kod))
        End If

        param.Add(New SqlParameter("@IdSya", Session("ssusrID")))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveAL(AL As AuthorLetter) As String
        Dim resp As New ResponseRepository
        Dim success As Integer = 0
        queryRB = New Query

        If AL Is Nothing Then
            resp.Failed("Sila Upload Authorization Letter Pembekal")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try

            For Each dataFile As MklmtFile In AL.ListFile
                dataFile.Bil = GenerateBilFile(AL.IdPembelian)
                If InsertLampiranJawapan(dataFile.NoRujukan, dataFile.IdSya, dataFile.JenDok, dataFile.FileName, dataFile.Bil, dataFile.filePath, dataFile.JenFile) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat lampiran")
                End If
            Next

            success += 1
            queryRB.finish()

        Catch ex As Exception
            success = 0
            queryRB.rollback()
        End Try

        If success > 0 Then
            resp.Success("Fail Berjaya Di Simpan")
        Else
            resp.Failed("Fail Gagal Di Simpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKatalog(IdSya As String, IdPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_Katalog(IdSya, IdPembelian)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_Katalog(IdSya As String, IdPembelian As String) As DataTable
        Dim db = New DBKewConn
        'Dim query As String = "SELECT Nama_Dok, Jenis_Dok, Bil, Path 
        '                       FROM SMKB_Syarikat_Lampiran 
        '                       WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenisDok AND Status = @status"

        Dim query1 As String = "SELECT A.Id_Jawapan_Teknikal, A.Id_Teknikal, B.Butiran, A.Jawapan, A.Sampel, A.Katalog, A.Nama_Dok, Path
                                FROM SMKB_Perolehan_Jawapan_Teknikal A
                                INNER JOIN SMKB_Perolehan_Spesifikasi_Teknikal B ON B.Id_Teknikal = A.Id_Teknikal
                                WHERE A.Id_Pembelian = @IdPembelian AND A.Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        'param.Add(New SqlParameter("@jenisDok", "KATALOG"))
        param.Add(New SqlParameter("@status", "1"))

        param.Add(New SqlParameter("@IdPembelian", IdPembelian))

        Return db.Read(query1, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePengesahanKatalog(MklmtSahKatalog As MklmtPengesahanKatalog) As String
        Dim resp As New ResponseRepository
        Dim success As Integer = 0

        If MklmtSahKatalog Is Nothing Then
            resp.Failed("Sila Lengkapkan Maklumat Yang Diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Try
            If UpdateSahKatalog(MklmtSahKatalog.IdPembelian, MklmtSahKatalog.KodDokumen, MklmtSahKatalog.ValueSah) <> "OK" Then
                Throw New Exception("Gagal Menyimpan Pengesahan Katalog")
            End If

            For Each dataFile As MklmtFile In MklmtSahKatalog.ListFile
                dataFile.Bil = GenerateBilFile(MklmtSahKatalog.IdPembelian)
                If InsertLampiranJawapan(dataFile.NoRujukan, dataFile.IdSya, dataFile.JenDok, dataFile.FileName, dataFile.Bil, dataFile.filePath, dataFile.JenFile) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat lampiran")
                End If
            Next

            success += 1
            queryRB.finish()

        Catch ex As Exception
            success = 0
            queryRB.rollback()
        End Try

        If success > 0 Then
            resp.Success("Fail Berjaya Di Simpan")
        Else
            resp.Failed("Fail Gagal Di Simpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PadamFileKatalog(dataFile As DelKatalog) As String
        Dim resp As New ResponseRepository
        Dim success As Integer = 0
        Dim resultDt As New Dictionary(Of String, Object)

        Dim dt As New DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        queryRB = New Query

        Dim dateTime As DateTime
        If DateTime.TryParseExact(dataFile.IdTeknikal, "yyyy-MM-ddTHH:mm:ss.ff", CultureInfo.InvariantCulture, DateTimeStyles.None, dateTime) Then
            ' Format the DateTime as desired
            dataFile.IdTeknikal = dateTime.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
        End If

        dt = GetDataKatalog(dataFile.IdTeknikal)

        If dt.Rows.Count > 0 Then
            Try
                If DelStatusKatalog(dataFile.IdTeknikal, dataFile.IdPembelian) <> "OK" Then
                    Throw New Exception("Gagal Menyimpan Maklumat lampiran")
                End If

                success += 1
                queryRB.finish()

            Catch ex As Exception
                success = 0
                queryRB.rollback()
            End Try
        Else
            success = 0
        End If

        If success > 0 Then
            resp.Success("Katalog Berjaya Dipadam")
        Else
            resp.Failed("Katalog Gagal Diapdam")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetDataKatalog(IdTeknikal As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT * FROM SMKB_Perolehan_Jawapan_Teknikal WHERE Id_Jawapan_Teknikal = @IdTeknikal"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdTeknikal", IdTeknikal))

        Return db.Read(query, param)
    End Function

    Private Function DelStatusKatalog(IdTeknikal As String, idPembelian As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Jawapan_Teknikal SET Status = @StatusDel 
                               WHERE Id_Jawapan_Teknikal = @IdTeknikal AND Id_Pembelian = @IdPembelian AND Status = @Status"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdTeknikal", IdTeknikal))
        param.Add(New SqlParameter("@IdPembelian", idPembelian))
        param.Add(New SqlParameter("@StatusDel", "0"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("Id_Teknikal", IdTeknikal, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSampel(IdSya As String, IdPembelian As String) As String
        Dim resp As New ResponseRepository
        Dim dt As DataTable

        dt = GetList_Sampel(IdSya, IdPembelian)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetList_Sampel(IdSya As String, IdPembelian As String) As DataTable
        Dim db = New DBKewConn
        'Dim query As String = "SELECT Nama_Dok, Jenis_Dok, Bil, Path 
        '                       FROM SMKB_Syarikat_Lampiran 
        '                       WHERE ID_Sykt = @idSya AND Jenis_Dok = @jenisDok AND Status = @status"

        Dim query1 As String = "SELECT A.Id_Jawapan_Teknikal, A.Id_Teknikal, B.Butiran, A.Jawapan, A.Sampel, A.Katalog 
                                FROM SMKB_Perolehan_Jawapan_Teknikal A
                                INNER JOIN SMKB_Perolehan_Spesifikasi_Teknikal B ON B.Id_Teknikal = A.Id_Teknikal
                                WHERE A.Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSya", IdSya))
        'param.Add(New SqlParameter("@jenisDok", "KATALOG"))
        'param.Add(New SqlParameter("@status", "1"))

        param.Add(New SqlParameter("@IdPembelian", IdPembelian))

        Return db.Read(query1, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileJK() As String
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/JK/")
        Return result
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileBank() As String
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/BANK/")
        Return result
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileAL() As String
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/AL/")
        Return result
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileKatalog() As String
        Dim result = UploadFile("~/UPLOAD/DOCUMENT/E-VENDOR/KATALOG/")
        Return result
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFile(ByVal uploadFolder As String) As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim kodDaftar As String = HttpContext.Current.Request.Form("kodDaftar")
        Dim resp As New ResponseRepository
        Dim IdSya As String
        Dim Bil As String

        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

            ' Specify the file path where you want to save the uploaded file
            'Dim savePath As String = Server.MapPath($"{uploadFolder}\{IdDok}\{fileName}")
            'IdDok = SelectIdDokLampiran(kodDaftar, Session("ssusrID"))
            IdSya = Session("ssusrID")
            Bil = SelectBilLampiran(kodDaftar, IdSya)
            Dim specificFolder As String = Path.Combine(uploadFolder, IdSya)
            Dim directoryPath As String = Path.Combine(specificFolder, Bil)
            'Dim savePath As String = Path.Combine(specificFolder, fileName)
            Dim savePath As String = Server.MapPath($"{directoryPath}\{fileName}")
            'Dim savePath As String = Path.Combine(directoryPath, fileName)

            If Not Directory.Exists(directoryPath) Then
                Directory.CreateDirectory(Server.MapPath(directoryPath))
            End If


            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            Debug.WriteLine("Path : " & savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            Return "OK"
            'Catch ex As HttpException
            '    Return $"Error uploading file: {ex.Message}"
        Catch ex As Exception
            Return $"Unexpected error uploading file: {ex.Message}"
        End Try

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveKatalog() As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim fileSize As Long = postedFile.ContentLength
        Dim fileExtension As String = Path.GetExtension(fileName).ToLower()

        Dim KodDaftar As String = HttpContext.Current.Request.Form("kodDaftar")
        Dim IdPembelian As String = HttpContext.Current.Request.Form("IdPembelian")
        Dim IdTeknikal As String = HttpContext.Current.Request.Form("IdJawapanTeknikal")
        Dim filePath As String = "~/UPLOAD/DOCUMENT/E-VENDOR/KATALOG/"
        Dim resp As New ResponseRepository
        Dim Success As Integer = 0
        queryRB = New Query

        Dim db As New DBKewConn
        Dim param As New Dictionary(Of String, Object)
        Dim json As New JavaScriptSerializer()

        Dim IdSya = Session("ssusrID")

        ' Convert the string to DateTime
        Dim dateTime As DateTime
        If DateTime.TryParseExact(IdTeknikal, "yyyy-MM-ddTHH:mm:ss.ff", CultureInfo.InvariantCulture, DateTimeStyles.None, dateTime) Then
            ' Format the DateTime as desired
            IdTeknikal = dateTime.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
        End If
        'Dim Bil = SelectBilLampiran(KodDaftar, IdSya)

        Try

            'Dim Bil = GenerateBilFile(IdPembelian)
            ' If InsertLampiranJawapan(IdPembelian, IdJwpnTeknikal, KodDaftar, fileName, Bil, filePath, fileExtension) <> "OK" Then
            If UpdateLampiranKatalog(IdTeknikal, IdPembelian, fileName, filePath, fileExtension) <> "OK" Then
                Throw New Exception("Gagal Menyimpan Maklumat lampiran Katalog")
            End If

            Success += 1
            queryRB.finish()

        Catch ex As Exception
            Success = 0
            queryRB.rollback()
        End Try

        If Success > 0 Then
            'Dim newBil = SelectBilLampiran(KodDaftar, IdSya)
            Dim specificFolder As String = Path.Combine(filePath, IdSya)
            Dim idTeknikalTrimmed As String = IdTeknikal.Replace(":", ",").Trim().Replace(" ", "")
            Dim directoryPath As String = Path.Combine(specificFolder, idTeknikalTrimmed)
            'Dim savePath As String = Path.Combine(specificFolder, fileName)
            Dim savePath As String = Server.MapPath($"{directoryPath}\{fileName}")
            'Dim savePath As String = Path.Combine(directoryPath, fileName)

            If Not Directory.Exists(directoryPath) Then
                Directory.CreateDirectory(Server.MapPath(directoryPath))
            End If

            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            Debug.WriteLine("Path : " & savePath)
        Else
            resp.Failed("Gagal Memuat Naik Fail Katalog.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Berjaya Memuat Naik Fail Katalog")
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateLampiranKatalog(Id_Jawapan_Teknikal As String, IdPembelia As String, NamaDok As String, filePath As String, JenDok As String) As String
        Dim db As New DBKewConn
        'Dim query As String = "INSERT INTO SMKB_Perolehan_Jawapan_Teknikal (Nama_Dok, Path, Content_Type, Status) 
        '                       VALUES (@NamaDok, @FilePath, @JenisDok, @Status)"

        Dim query As String = "UPDATE SMKB_Perolehan_Jawapan_Teknikal 
                               SET Nama_Dok = @NamaDok, Path = @FilePath, Content_Type = @JenisDok, Status = @Status 
                               WHERE Id_Teknikal = @IdTeknikal"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdTeknikal", Id_Jawapan_Teknikal))
        param.Add(New SqlParameter("@IdPembelian", IdPembelia))
        param.Add(New SqlParameter("@NamaDok", NamaDok))
        param.Add(New SqlParameter("@FilePath", filePath))
        param.Add(New SqlParameter("@JenisDok", JenDok))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("Id_Jawapan_Teknikal", Id_Jawapan_Teknikal, query, param)
    End Function

    Private Function SelectBilLampiran(kodDaftar As String, Idsya As String)
        Dim db = New DBKewConn
        Dim dt As DataTable
        Dim Bil As Integer

        Dim query As String = "Select Bil FROM SMKB_Perolehan_Jawapan_Lampiran WHERE Jenis_Dok = @kodDaftar AND No_Rujukan = @idSya AND status = @status ORDER BY Bil DESC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kodDaftar", kodDaftar))
        param.Add(New SqlParameter("@idSya", Idsya))
        param.Add(New SqlParameter("@status", 1))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("Bil")) Then
            Bil = Convert.ToInt32(dt.Rows(0)("Bil"))
        End If

        Return Bil
    End Function

    Private Function GenerateBilFile(IdPembelian As String)
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim Bil As Integer = 1

        Dim query As String = "SELECT MAX(CONVERT(INT, Bil)) + 1  AS LatestBil FROM SMKB_Perolehan_Jawapan_Lampiran WHERE Id_Pembelian = @IdPembelian"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@IdPembelian", IdPembelian))

        dt = db.Read(query, param)

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("LatestBil")) Then
            Bil = Convert.ToInt32(dt.Rows(0)("LatestBil"))
        End If

        Return Bil
    End Function

    Private Function GenerateOrderNaskahID() As String
        Dim db As New DBKewConn
        Dim dt As New DataTable

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderNaskahID As String = ""

        Dim query As String = "SELECT TOP 1 No_Akhir as id FROM SMKB_No_Akhir WHERE Kod_Modul ='20' AND Prefix ='VNJ' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("20", "VNJ", year, lastID)
        Else

            InsertNoAkhir("20", "VNJ", year, lastID)
        End If
        newOrderNaskahID = "VNJ" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)
        'newSyarikatID = "RC" + Format(lastID, "000000").ToString

        Return newOrderNaskahID
    End Function

    Private Function UpdateNoAkhir(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))

        Return db.Process(query, param)
    End Function

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Vendor Naskah Jualan"))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmd(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        If queryRB.execute(idValue, idKey, cmd) < 0 Then
            Return "X"
        Else
            Return "OK"
        End If
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmdMulti(idKey As Dictionary(Of String, String), strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        Dim key As New Dictionary(Of String, String)

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        Return If(queryRB.execute(idKey, cmd) < 0, "X", "OK")
    End Function
End Class