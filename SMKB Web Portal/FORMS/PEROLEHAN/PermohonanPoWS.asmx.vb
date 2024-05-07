Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.EnterpriseServices
Imports System.IO
Imports iTextSharp.text.log
Imports SMKB_Web_Portal.KPT
Imports SMKB_Web_Portal.JU
Imports System.Data.Entity.Core.Mapping

Imports System.Threading
Imports System.Globalization
Imports System.Collections.Generic
Imports System.Net.Http
Imports Microsoft.ReportingServices.Interfaces
Imports System
Imports System.Data.OleDb
Imports System.Data.Entity.Core
Imports System.Web.Http


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PermohonanPoWS
    Inherits System.Web.Services.WebService
    'Inherits MainClass

    Dim dt As DataTable

    Public Property MessageBox As Object

    '===============================================================================================================================================================================
    'webservice Function for tab 1 (Maklumat Perolehan)
    '===============================================================================================================================================================================

    'Display Status
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function displayStatusPO() As String
        Dim tmpDT As DataTable = displayKodStatusPO()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function displayKodStatusPO() As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = 03"

        Return db.Read(query)
    End Function

    'Dropdown Kategori Perolehan
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKategoriPO(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodKategoriPO(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodKategoriPO(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail + ' - ' + Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = 'PO03'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Dropdown Kategori Perolehan
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SenaraiPejabat(ByVal q As String) As String
        Dim tmpDT As DataTable = GetSenaraiPejabat(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetSenaraiPejabat(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT KodPejabat as value, KodPejabat + ' - ' + Pejabat as text FROM VPejabat"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " WHERE (KodPejabat LIKE '%' + @kod + '%' OR Pejabat LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function
    'Display PTj
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPTjPO(ByVal ssusrKodPTj As String) As String
        Dim tmpDT As DataTable = GetKodPTjPO(ssusrKodPTj)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodPTjPO(ByVal ssusrKodPTj As String) As DataTable
        Dim db = New DBKewConn

        Dim ssusrKodPTj2 = Left(ssusrKodPTj, 2)
        Dim query As String = "SELECT KodPejabat + '0000' as value, KodPejabat + '0000' + ' - ' + Pejabat as text FROM VPejabat WHERE KodPejabat = @ssusrKodPTj2"

        'Dim query As String = "SELECT KodPejPBU as value, KodPejPBU + ' - ' + Pejabat as text FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT WHERE KodPejPBU ='" & ssusrKodPTj & "'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ssusrKodPTj2", ssusrKodPTj2))

        Return db.Read(query, param)
    End Function

    'Save data insert into (Maklumat Perolehan)
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePermohonanPo(mohonPoHeader As PermohonanPoHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPoHeader Is Nothing Then 'hahahahah
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Dim msg As String = ""

        If String.IsNullOrEmpty(mohonPoHeader.txtTujuan) Then
            msg += "Sila pastikan tajuk / tujuan telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoHeader.txtSkop) Then
            msg += "Sila pastikan skop telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoHeader.ddlkategoriPO) Then
            msg += "Sila pastikan kategori perolehan telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoHeader.ddlListPtj) Then
            msg += "Sila pastikan bekal kepada telah dipilih.<br/>"
        End If

        If String.IsNullOrEmpty(mohonPoHeader.txtTarikh_Mula_Perolehan) Then
            msg += "Sila pastikan tarikh mula perolehan kepada telah dipilih.<br/>"
        End If

        If String.IsNullOrEmpty(mohonPoHeader.txtTempoh) Or mohonPoHeader.txtTempoh = 0 Then
            msg += "Sila pastikan tempoh telah diisi.<br/>"
        End If

        If String.IsNullOrEmpty(mohonPoHeader.txtJenis_tempoh) Then
            msg += "Sila pastikan jenis tempoh telah dipilih.<br/>"
        End If

        If String.IsNullOrEmpty(mohonPoHeader.txtAmaun) Then
            msg += "Sila pastikan rekod perolehan terdahulu telah diisi.<br/>"
        End If

        If String.IsNullOrEmpty(mohonPoHeader.txtJustifikasi) Then
            msg += "Sila pastikan justifikasi perolehan telah diisi.<br/>"
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If mohonPoHeader.txtNoMohon = "" AndAlso mohonPoHeader.txtNoPO = "" Then
            Dim noMohonID As String = GenerateNoMohon(mohonPoHeader.ddlListPtj)
            mohonPoHeader.txtNoMohon = noMohonID
            mohonPoHeader.txtNoPO = noMohonID

            'Session("SessionNoMohon") = noMohonID

            mohonPoHeader.lblStatus1 = getKod_Status_Dok()

            If InsertNewOrder(mohonPoHeader.txtNoMohon, mohonPoHeader.lblTarikhPO, mohonPoHeader.lblStatus1, mohonPoHeader.ddlTahun, mohonPoHeader.txtTujuan, mohonPoHeader.txtSkop, mohonPoHeader.ddlkategoriPO, mohonPoHeader.ddlPTJPemohon, mohonPoHeader.txtTkh, mohonPoHeader.txtAmaun, mohonPoHeader.txtJustifikasi, mohonPoHeader.ddlListPtj, mohonPoHeader.txtTarikh_Mula_Perolehan, mohonPoHeader.txtTempoh, mohonPoHeader.txtJenis_tempoh, mohonPoHeader.txtTarikh_Tamat_Perolehan, mohonPoHeader.tahapPerolehan) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If
        Else
            Dim rekodPermohonan = GetLoadPermohonanPerolehan(Session("ssusrID"), mohonPoHeader.txtNoMohon)
            If rekodPermohonan.Rows.Count = 0 Then
                resp.Failed("Rekod Permohonan tidak dijumpai.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            End If

            If UpdateNewOrder(mohonPoHeader.txtNoMohon, mohonPoHeader.ddlTahun, mohonPoHeader.txtTujuan, mohonPoHeader.txtSkop, mohonPoHeader.ddlkategoriPO, mohonPoHeader.ddlPTJPemohon, mohonPoHeader.txtAmaun, mohonPoHeader.txtJustifikasi, mohonPoHeader.ddlListPtj, mohonPoHeader.txtTarikh_Mula_Perolehan, mohonPoHeader.txtTempoh, mohonPoHeader.txtJenis_tempoh, mohonPoHeader.txtTarikh_Tamat_Perolehan) <> "OK" Then
                resp.Failed("Gagal mengemaskini order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If
            'Koding untuk update
        End If

        resp.Success("Rekod berjaya disimpan", "00", mohonPoHeader)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertNewOrder(txtNoMohon As String, lblTarikhPO As String, lblStatus1 As String, ddlTahun As String, txtTujuan As String, txtSkop As String, ddlkategoriPO As String, ddlPTJPemohon As String, txtTkh As String, txtAmaun As String, txtJustifikasi As String, ddlListPtj As String, txtTarikh_Mula_Perolehan As String, txtTempoh As String, txtJenis_tempoh As String, txtTarikh_Tamat_Perolehan As String, tahapPerolehan As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Permohonan_Hdr (No_Mohon, Tarikh_Mohon, Status_Dok, Tahun_Perolehan, Tujuan, Skop, Jenis_Barang, Kod_Ptj_Mohon, Id_Pemohon, Perolehan_Terdahulu, Justifikasi, Bekal_Kepada,Tarikh_Mula,Tempoh,Jenis_Tempoh,Bekal_Sebelum,TahapPerolehan)
        VALUES(@txtNoMohon, @lblTarikhPO, @lblStatus1, @ddlTahun, @txtTujuan, @txtSkop, @ddlkategoriPO, @ddlPTJPemohon, @txtPemohon, @txtAmaun, @txtJustifikasi, @Bekal_Kepada,@Tarikh_Mula,@Tempoh,@Jenis_Tempoh,@Bekal_Sebelum,@TahapPerolehan)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohon))
        'param.Add(New SqlParameter("@txtNoPO", txtNoPO))
        param.Add(New SqlParameter("@lblTarikhPO", lblTarikhPO))
        param.Add(New SqlParameter("@lblStatus1", lblStatus1))
        param.Add(New SqlParameter("@ddlTahun", ddlTahun))
        param.Add(New SqlParameter("@txtTujuan", txtTujuan))
        param.Add(New SqlParameter("@txtSkop", txtSkop))
        param.Add(New SqlParameter("@ddlkategoriPO", ddlkategoriPO))
        param.Add(New SqlParameter("@ddlPTJPemohon", ddlPTJPemohon))
        param.Add(New SqlParameter("@txtPemohon", Session("ssusrID")))
        param.Add(New SqlParameter("@txtAmaun", txtAmaun))
        param.Add(New SqlParameter("@txtJustifikasi", txtJustifikasi))
        param.Add(New SqlParameter("@Bekal_Kepada", ddlListPtj))

        param.Add(New SqlParameter("@Tarikh_Mula", txtTarikh_Mula_Perolehan))
        param.Add(New SqlParameter("@Tempoh", txtTempoh))
        param.Add(New SqlParameter("@Jenis_Tempoh", txtJenis_tempoh))
        param.Add(New SqlParameter("@Bekal_Sebelum", txtTarikh_Tamat_Perolehan))
        param.Add(New SqlParameter("@TahapPerolehan", tahapPerolehan))


        Return db.Process(query, param)
    End Function

    Private Function UpdateNewOrder(txtNoMohon As String, ddlTahun As String, txtTujuan As String, txtSkop As String, ddlkategoriPO As String, ddlPTJPemohon As String, txtAmaun As String, txtJustifikasi As String, ddlListPtj As String, txtTarikh_Mula_Perolehan As String, txtTempoh As String, txtJenis_tempoh As String, txtTarikh_Tamat_Perolehan As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Tahun_Perolehan =  @ddlTahun, Tujuan = @txtTujuan, Skop = @txtSkop, 
        Jenis_Barang = @ddlkategoriPO, Perolehan_Terdahulu =  @txtAmaun, Justifikasi = @txtJustifikasi, Bekal_Kepada = @Bekal_Kepada,
        Tarikh_Mula = @Tarikh_Mula,Tempoh = @Tempoh ,Jenis_Tempoh = @Jenis_Tempoh ,Bekal_Sebelum = @Bekal_Sebelum
        WHERE No_Mohon = @txtNoMohon "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohon))
        param.Add(New SqlParameter("@ddlTahun", ddlTahun))
        param.Add(New SqlParameter("@txtTujuan", txtTujuan))
        param.Add(New SqlParameter("@txtSkop", txtSkop))
        param.Add(New SqlParameter("@ddlkategoriPO", ddlkategoriPO))
        param.Add(New SqlParameter("@txtAmaun", txtAmaun))
        param.Add(New SqlParameter("@txtJustifikasi", txtJustifikasi))
        param.Add(New SqlParameter("@Bekal_Kepada", ddlListPtj))

        param.Add(New SqlParameter("@Tarikh_Mula", txtTarikh_Mula_Perolehan))
        param.Add(New SqlParameter("@Tempoh", txtTempoh))
        param.Add(New SqlParameter("@Jenis_Tempoh", txtJenis_tempoh))
        param.Add(New SqlParameter("@Bekal_Sebelum", txtTarikh_Tamat_Perolehan))


        Return db.Process(query, param)
    End Function

    Private Function GenerateNoMohon(ddlPTJList As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoMohon As String = ""
        'Dim ptj = ddlPTJList
        Dim ptjBekal As String = ddlPTJList.PadRight(6, "0"c)

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='BS' AND Tahun =@year AND Kod_PTJ =@ddlPTJList"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))
        param.Add(New SqlParameter("@ddlPTJList", ptjBekal))


        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("02", "BS", year, lastID, ptjBekal)
        Else

            InsertNoAkhir("02", "BS", year, lastID, ptjBekal)
        End If
        newNoMohon = "BS" + ptjBekal.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoMohon
    End Function

    Private Function UpdateNoAkhir(kodModul As String, prefix As String, year As String, ID As String, ptjBekal As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun and Kod_PTJ= @ptjBekal"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@ptjBekal", ptjBekal))


        Return db.Process(query, param)
    End Function

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String, ptjBekal As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @ptjBekal)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Mohon Pembelian"))
        param.Add(New SqlParameter("@ptjBekal", ptjBekal))


        Return db.Process(query, param)
    End Function
    Private Function UpdateNoAkhirBendahari(kodModul As String, prefix As String, year As String, ID As String, ddlPTJPemohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun and Kod_PTJ=@Kod_PTJ"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Kod_PTJ", ddlPTJPemohon))


        Return db.Process(query, param)
    End Function

    Private Function InsertNoAkhirBendahari(kodModul As String, prefix As String, year As String, ID As String, ddlPTJPemohon As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Lulus Bendahari"))
        param.Add(New SqlParameter("@Kod_PTJ", ddlPTJPemohon))

        Return db.Process(query, param)
    End Function

    Private Function getKod_Status_Dok() As String
        Dim db As New DBKewConn

        Dim Kod_Status_Dok As String = ""

        Dim query As String = "SELECT Kod_Status_Dok FROM SMKB_Kod_Status_Dok WHERE Butiran = 'DAFTAR PERMOHONAN PEMBELIAN'"
        Dim param As New List(Of SqlParameter)

        Dim dt As DataTable = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Kod_Status_Dok = dt.Rows(0)("Kod_Status_Dok").ToString()
        End If

        Return Kod_Status_Dok
    End Function

    'Dropdown VOT/COA
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVot_COA(ByVal q As String) As String
        Dim tmpDT As DataTable = GetVot_KodCOAList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    'Private Function GetVot_KodCOAList(kodCariVot As String) As DataTable
    '    Dim db = New DBKewConn
    '    Dim query As String = "SELECT top 10 CONCAT(a.Kod_Vot, ' - ', vot.Butiran, ', ', a.Kod_Operasi, ' - ', ko.Butiran, ' , ', a.Kod_Projek, ' - ', kp.Butiran, ', ', a.Kod_Kump_Wang, ' - ', 
    '	REPLACE(kw.Butiran, 'KUMPULAN WANG', 'KW'), ', ', LEFT(a.Kod_PTJ,2), ' - ', mj.Pejabat) AS text,
    '                a.Kod_Vot AS value ,
    '                mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO , kp.Butiran as colKp , 
    '                a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
    '                FROM SMKB_COA_Master AS a 
    '                JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
    '                JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
    '                JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
    '	JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
    '	JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_PTJ,2) 
    '                WHERE a.status = 1"

    '    Dim param As New List(Of SqlParameter)
    '    If kodCariVot <> "" Then
    '        query &= "AND (a.Kod_Vot LIKE '%' + @kod + '%' OR a.Kod_Operasi LIKE '%' + @kod2 + '%' OR a.Kod_Projek LIKE '%' + @kod3 + '%' OR a.Kod_Kump_Wang LIKE '%' + @kod4 + '%' OR a.Kod_PTJ LIKE '%' + @kod5 + '%' OR vot.Butiran LIKE '%' + @kodButir + '%' OR ko.Butiran LIKE '%' + @kodButir1 + '%'  OR kw.Butiran LIKE '%' + @kodButir2 + '%' OR mj.pejabat LIKE '%' + @kodButir3 + '%')"

    '        param.Add(New SqlParameter("@kod", kodCariVot))
    '        param.Add(New SqlParameter("@kod2", kodCariVot))
    '        param.Add(New SqlParameter("@kod3", kodCariVot))
    '        param.Add(New SqlParameter("@kod4", kodCariVot))
    '        param.Add(New SqlParameter("@kod5", kodCariVot))
    '        param.Add(New SqlParameter("@kodButir", kodCariVot))
    '        param.Add(New SqlParameter("@kodButir1", kodCariVot))
    '        param.Add(New SqlParameter("@kodButir2", kodCariVot))
    '        param.Add(New SqlParameter("@kodButir3", kodCariVot))
    '    End If

    '    Return db.Read(query, param)
    'End Function

    Private Function GetVot_KodCOAList(kodCariVot As String) As DataTable

        kodCariVot = Replace(kodCariVot, " ", "%")

        Dim db = New DBKewConn
        'Dim query As String = "SELECT TOP 10 UPPER(a.COA_Index) AS text,
        '                    a.Kod_Vot AS value ,
        '                    vot.Butiran AS colhidvot ,
        '                    mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO ,  kp.Butiran as colKp , 
        '                    a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
        '                    FROM SMKB_COA_Master AS a 
        '                    JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
        '                    JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
        '                    JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
        '                    JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
        '                    JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_PTJ,2) 
        '                    WHERE a.status = 1  "

        Dim query As String = "SELECT TOP 10 UPPER(a.COA_Index) AS text,
                            a.Kod_Vot AS value ,
                            vot.Butiran AS colhidvot ,
                            mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO ,  kp.Butiran as colKp , 
                            a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
                            FROM SMKB_COA_Master AS a 
                            JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                            JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                            JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                            JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
                            JOIN VPejabat AS mj ON mj.kodpejabat = left(a.Kod_PTJ,2) 
                            WHERE a.status = 1"

        Dim param As New List(Of SqlParameter)
        Dim paramName As String = ""
        If kodCariVot <> "" Then

            Dim arrString As String() = kodCariVot.Split("%")
            Dim counter As Integer = 0

            For Each str As String In arrString
                paramName = "@str" & counter
                query &= " and COA_Index like '%' + " & paramName & "+ '%'  "
                counter += 1
                param.Add(New SqlParameter(paramName, str))
            Next

        End If

        Return db.Read(query, param)
    End Function
    'Dropdown Ukuran
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetUkuran(ByVal q As String) As String
        Dim tmpDT As DataTable = GetUkuranList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetUkuranList(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = 'PO06'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Butiran LIKE '%' + @kod + '%') "
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Load DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PerolehanDtl(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_PerolehanDtl(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_PerolehanDtl(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT Id_Mohon_Dtl, Kod_Kump_Wang, Kod_Operasi, Kod_Ptj, Kod_Projek, Kod_Vot, FORMAT(Baki_Peruntukan, '0.00') as Baki_Peruntukan, Butiran,
            Kuantiti, Ukuran, FORMAT(Kadar_Harga,'0.00') AS Kadar_Harga, FORMAT(Jumlah_Harga,'0.00') AS Jumlah_Harga FROM SMKB_Perolehan_Permohonan_Dtl WHERE No_Mohon = @nombor_mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@nombor_mohon", id))

        Return db.Read(query, param)
    End Function

    'Load DataTable tblSpekTeknikal
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SpekTeknikal(ByVal id As String, ByVal hidden As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_SpekTeknikal(id, hidden)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_SpekTeknikal(id As String, hidden As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT Id_Mohon_Dtl, Id_Teknikal, Butiran, Wajaran FROM SMKB_Perolehan_Spesifikasi_Teknikal 
            WHERE No_Mohon = @nombor_mohon AND Id_Mohon_Dtl = @id_mohon_dtl_hidden"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@nombor_mohon", id))
        param.Add(New SqlParameter("@id_mohon_dtl_hidden", hidden))

        Return db.Read(query, param)
    End Function

    'Save data insert into (Maklumat Bajet dan Spesifikasi)
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePO_BajetSpesifikasi(mohonPoDetail As PermohonanPoDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPoDetail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(mohonPoDetail.No_MohonDTL) Then
            resp.Failed("Sila Pilih No Permohonam atau lengkap di tab1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim msg As String = ""

        If String.IsNullOrEmpty(mohonPoDetail.coa_vot) Then
            msg += "Sila pilih dari pilihan COA. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoDetail.ddlPTj) Then
            msg += "Sila pilih dari pilihan COA. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoDetail.ddlKW) Then
            msg += "Sila pilih dari pilihan COA. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoDetail.ddlKodOperasi) Then
            msg += "Sila pilih dari pilihan COA. <br/>"
        End If


        If String.IsNullOrEmpty(mohonPoDetail.txtPerkara) Then
            msg += "Sila barang / perkara telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoDetail.txtKuantiti) Then
            msg += "Sila pastikan kuantiti telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoDetail.ddlUkuran) Then
            msg += "Sila pastikan ukuran telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(mohonPoDetail.txtAngHrgSeunit) Then
            msg += "Sila pastikan anggaran harga seunit telah diisi.<br/>"
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If mohonPoDetail.txtBakiPeruntukan < mohonPoDetail.txtJumAngHrg Then
            resp.Failed("Baki peruntukan tidak mencukupi.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertPO_BajetSpesifikasi(mohonPoDetail) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", mohonPoDetail)
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function InsertPO_BajetSpesifikasi(mohonPoDetail As PermohonanPoDetail) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Permohonan_Dtl (No_Mohon, Kod_Vot, Kod_Ptj, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, Baki_Peruntukan, Butiran, Kuantiti, Ukuran, Kadar_Harga, Jumlah_Harga)
    VALUES(@nombor_mohon, @coa_vot, @ddlPTj, @ddlKW, @ddlKodOperasi, @ddlKodProjek, @txtBakiPeruntukan, @txtPerkara, @txtKuantiti, @ddlUkuran, @txtAngHrgSeunit, @txtJumAngHrg)"
        Dim param As New List(Of SqlParameter)

        'param.Add(New SqlParameter("@bilangan", mohonPoDetail.bilangan))
        param.Add(New SqlParameter("@nombor_mohon", mohonPoDetail.No_MohonDTL))
        param.Add(New SqlParameter("@coa_vot", mohonPoDetail.coa_vot))
        param.Add(New SqlParameter("@ddlPTj", mohonPoDetail.ddlPTj))
        param.Add(New SqlParameter("@ddlKW", mohonPoDetail.ddlKW))
        param.Add(New SqlParameter("@ddlKodOperasi", mohonPoDetail.ddlKodOperasi))
        param.Add(New SqlParameter("@ddlKodProjek", mohonPoDetail.ddlKodProjek))
        param.Add(New SqlParameter("@txtBakiPeruntukan", mohonPoDetail.txtBakiPeruntukan))
        param.Add(New SqlParameter("@txtPerkara", mohonPoDetail.txtPerkara))
        param.Add(New SqlParameter("@txtKuantiti", mohonPoDetail.txtKuantiti))
        param.Add(New SqlParameter("@ddlUkuran", mohonPoDetail.ddlUkuran))
        param.Add(New SqlParameter("@txtAngHrgSeunit", mohonPoDetail.txtAngHrgSeunit))
        param.Add(New SqlParameter("@txtJumAngHrg", mohonPoDetail.txtJumAngHrg))

        Return db.Process(query, param)
    End Function

    'Save data insert into (Maklumat Spesifikasi Teknikal)
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePO_SpekTeknikal(mohonPoSpekTeknikal As PermohonanPoSpekTeknikal) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPoSpekTeknikal Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim msg As String = ""

        If String.IsNullOrEmpty(mohonPoSpekTeknikal.butiran) Then
            msg += "Sila pastikan butiran telah diisi. <br/>"
        End If


        If (mohonPoSpekTeknikal.katPerolehan <> "K") Then
            If String.IsNullOrEmpty(mohonPoSpekTeknikal.wajaran) Then
                msg += "Sila pastikan wajaran telah diisi. <br/>"
            End If
        End If

        'If String.IsNullOrEmpty(mohonPoSpekTeknikal.wajaran) Then
        '    msg += "Sila pastikan wajaran telah diisi. <br/>"
        'End If


        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertPO_SpekTeknikal(mohonPoSpekTeknikal) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya disimpan", "00", mohonPoSpekTeknikal)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPO_SpekTeknikal(mohonPoSpekTeknikal As PermohonanPoSpekTeknikal) As String
        Dim db As New DBKewConn

        If (mohonPoSpekTeknikal.katPerolehan = "K") Then

            Dim query As String = "INSERT INTO SMKB_Perolehan_Spesifikasi_Teknikal (No_Mohon, Id_Mohon_Dtl, Butiran,Bil, Status)
            VALUES(@no_mohon, @idMohonDtl, @butiran,'1', '1')"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@no_mohon", mohonPoSpekTeknikal.no_MohonSpekTeknikal))
            param.Add(New SqlParameter("@idMohonDtl", mohonPoSpekTeknikal.id_mohon_dtl))
            param.Add(New SqlParameter("@butiran", mohonPoSpekTeknikal.butiran))

            Return db.Process(query, param)

        Else

            Dim query As String = "INSERT INTO SMKB_Perolehan_Spesifikasi_Teknikal (No_Mohon, Id_Mohon_Dtl, Butiran, Wajaran, Bil, Status)
            VALUES(@no_mohon, @idMohonDtl, @butiran, @wajaran, '1', '1')"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@no_mohon", mohonPoSpekTeknikal.no_MohonSpekTeknikal))
            param.Add(New SqlParameter("@idMohonDtl", mohonPoSpekTeknikal.id_mohon_dtl))
            param.Add(New SqlParameter("@butiran", mohonPoSpekTeknikal.butiran))
            param.Add(New SqlParameter("@wajaran", mohonPoSpekTeknikal.wajaran))

            Return db.Process(query, param)
        End If

    End Function

    'Delete Row DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeletePoDtl(ByVal id As String) As String
        Dim resp As New ResponseRepository

        If Query_deletePoDtl(id) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deletePoDtl(id As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM SMKB_Perolehan_Permohonan_Dtl WHERE Id_Mohon_Dtl = @Id_Mohon_Dtl"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Mohon_Dtl", id))

        Return db.Process(query, param)
    End Function

    'Delete Row DataTable tblSpekTeknikal
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeletePoSpekTeknikal(ByVal id As String) As String
        Dim resp As New ResponseRepository

        If Query_deletePoSpekTeknikal(id) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deletePoSpekTeknikal(id As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM SMKB_Perolehan_Spesifikasi_Teknikal WHERE Id_Teknikal = @id_teknikal"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id_teknikal", id))

        Return db.Process(query, param)
    End Function

    'Load data for Update Row DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPoDtlRowData(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = Query_loadPoDtlRowData(id)
        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function Query_loadPoDtlRowData(id As String) As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "SELECT	a.Kod_Vot, vot.Butiran as Butiran_vot, 
        '                          a.Kod_Ptj, mj.Pejabat as Butiran_ptj, 
        '                          a.Kod_Kump_Wang, kw.Butiran As Butiran_kw,
        '                          a.Kod_Operasi, ko.Butiran As Butiran_ko,
        '                          a.Kod_Projek, kp.Butiran as Butiran_kp, 
        '                          a.Ukuran, ukur.Butiran as Butiran_ukuran,
        '                          a.Butiran, a.Kuantiti, 
        '                                FORMAT(a.Kadar_Harga,'0.00') AS  Kadar_Harga,
        '                                FORMAT(a.Jumlah_Harga,'0.00') AS Jumlah_Harga, 
        '                                FORMAT(a.Baki_Peruntukan,'0.00') AS Baki_Peruntukan
        '                    FROM SMKB_Perolehan_Permohonan_Dtl AS a
        '                    INNER JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
        '                    INNER JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_Ptj,2) 
        '                    INNER JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
        '                    INNER JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
        '                    INNER JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
        '                    INNER JOIN SMKB_Lookup_Detail as ukur on ukur.Kod='PO06' AND ukur.Kod_Detail = a.Ukuran
        '                    WHERE a.Id_Mohon_Dtl = @id_mohon_dtl"
        Dim query As String = "SELECT	a.Kod_Vot, vot.Butiran as Butiran_vot, 
		                                a.Kod_Ptj, mj.Pejabat as Butiran_ptj, 
		                                a.Kod_Kump_Wang, kw.Butiran As Butiran_kw,
		                                a.Kod_Operasi, ko.Butiran As Butiran_ko,
		                                a.Kod_Projek, kp.Butiran as Butiran_kp, 
		                                a.Ukuran, ukur.Butiran as Butiran_ukuran,
		                                a.Butiran, a.Kuantiti, 
                                        FORMAT(a.Kadar_Harga,'0.00') AS  Kadar_Harga,
                                        FORMAT(a.Jumlah_Harga,'0.00') AS Jumlah_Harga, 
                                        FORMAT(a.Baki_Peruntukan,'0.00') AS Baki_Peruntukan
                            FROM SMKB_Perolehan_Permohonan_Dtl AS a
                            INNER JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                            INNER JOIN VPejabat AS mj ON mj.kodpejabat = left(a.Kod_Ptj,2) 
                            INNER JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                            INNER JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                            INNER JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
                            INNER JOIN SMKB_Lookup_Detail as ukur on ukur.Kod='PO06' AND ukur.Kod_Detail = a.Ukuran
                            WHERE a.Id_Mohon_Dtl = @id_mohon_dtl"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id_mohon_dtl", id))

        Return db.Read(query, param)
    End Function


    'Update data (Maklumat Bajet dan Spesifikasi)
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdatePO_BajetSpesifikasi(mohonPoDetail As PermohonanPoDetail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPoDetail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Query_UpdatePO_BajetSpesifikasi(mohonPoDetail) <> "OK" Then
            resp.Failed("Gagal mengemaskini rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dikemaskini", "00", mohonPoDetail)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function Query_UpdatePO_BajetSpesifikasi(mohonPoDetail As PermohonanPoDetail) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Dtl
                              SET No_Mohon = @nombor_mohon, Kod_Vot = @coa_vot, Kod_Ptj = @ddlPTj, Kod_Kump_Wang = @ddlKW, 
                              Kod_Operasi = @ddlKodOperasi, Kod_Projek = @ddlKodProjek, Baki_Peruntukan = @txtBakiPeruntukan, 
                              Butiran = @txtPerkara, Kuantiti = @txtKuantiti, Ukuran = @ddlUkuran, Kadar_Harga = @txtAngHrgSeunit, 
                              Jumlah_Harga = @txtJumAngHrg WHERE Id_Mohon_Dtl = @idMohonDtl"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idMohonDtl", mohonPoDetail.id_mohonDtl))
        param.Add(New SqlParameter("@nombor_mohon", mohonPoDetail.No_MohonDTL))
        param.Add(New SqlParameter("@coa_vot", mohonPoDetail.coa_vot))
        param.Add(New SqlParameter("@ddlPTj", mohonPoDetail.ddlPTj))
        param.Add(New SqlParameter("@ddlKW", mohonPoDetail.ddlKW))
        param.Add(New SqlParameter("@ddlKodOperasi", mohonPoDetail.ddlKodOperasi))
        param.Add(New SqlParameter("@ddlKodProjek", mohonPoDetail.ddlKodProjek))
        param.Add(New SqlParameter("@txtBakiPeruntukan", mohonPoDetail.txtBakiPeruntukan))
        param.Add(New SqlParameter("@txtPerkara", mohonPoDetail.txtPerkara))
        param.Add(New SqlParameter("@txtKuantiti", mohonPoDetail.txtKuantiti))
        param.Add(New SqlParameter("@ddlUkuran", mohonPoDetail.ddlUkuran))
        param.Add(New SqlParameter("@txtAngHrgSeunit", mohonPoDetail.txtAngHrgSeunit))
        param.Add(New SqlParameter("@txtJumAngHrg", mohonPoDetail.txtJumAngHrg))

        Return db.Process(query, param)
    End Function


    'Load data for Update Row DataTable tblSpekTeknikal
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSpekTekRowData(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = Query_LoadSpekTekRowData(id)
        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function Query_LoadSpekTekRowData(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT Butiran, Wajaran FROM SMKB_Perolehan_Spesifikasi_Teknikal WHERE Id_Teknikal = @id_teknikal"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id_teknikal", id))

        Return db.Read(query, param)
    End Function

    'Update data (Maklumat Bajet dan Spesifikasi)
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdatePO_SpekTeknikal(mohonPoSpekTeknikal As PermohonanPoSpekTeknikal) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPoSpekTeknikal Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Query_UpdatePO_SpekTeknikal(mohonPoSpekTeknikal) <> "OK" Then
            resp.Failed("Gagal mengemaskini rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dikemaskini", "00", mohonPoSpekTeknikal)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_UpdatePO_SpekTeknikal(mohonPoSpekTeknikal As PermohonanPoSpekTeknikal) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Spesifikasi_Teknikal
                              SET Butiran = @butiran, Wajaran = @wajaran
                              WHERE Id_Teknikal = @id_spek_teknikal"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id_spek_teknikal", mohonPoSpekTeknikal.idTeknikal))
        param.Add(New SqlParameter("@butiran", mohonPoSpekTeknikal.butiran))
        param.Add(New SqlParameter("@wajaran", mohonPoSpekTeknikal.wajaran))

        Return db.Process(query, param)
    End Function

    'Load DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadKelulusanPo() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadKelulusanPo()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadKelulusanPo() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT  a.No_Mohon,
		                        FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, 
		                        a.Tujuan,
		                        a.Skop,
		                        a.Jenis_Barang, kategori.Butiran AS kategori_butiran, 
		                        a.Kod_Ptj_Mohon,
		                        FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, 
		                        FORMAT(a.Perolehan_Terdahulu,'0.00') AS Perolehan_Terdahulu,
		                        a.Justifikasi,
		                        FORMAT(SUM(b.Jumlah_Harga),'0.00') AS Total_Harga
                        FROM SMKB_Perolehan_Permohonan_Hdr AS a
                        INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                        INNER JOIN SMKB_Perolehan_Permohonan_Dtl AS b ON a.No_Mohon = b.No_Mohon
                        WHERE a.Status_Lulus IS NULL
                        GROUP BY a.No_Mohon, a.Tujuan, a.Justifikasi, a.Skop, a.Kod_Ptj_Mohon, a.Jenis_Barang, kategori.Butiran, 
                        FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy'), FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy'),FORMAT(a.Perolehan_Terdahulu,'0.00')
                        ORDER BY No_Mohon DESC"

        Return db.Read(query)
    End Function

    'Lulus Permohonan Perolehan
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LulusPerolehan(mohonPo As PermohonanPo) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPo Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Query_LulusPerolehan(mohonPo) <> "OK" Then
            resp.Failed("Gagal mengemaskini rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Permohonan Berjaya Diluluskan", "00", mohonPo)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_LulusPerolehan(mohonPo As PermohonanPo) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr
                              SET Status_Lulus = '1'
                              WHERE No_Mohon = @no_mohon_po"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@no_mohon_po", mohonPo.nombor_mohon))

        Return db.Process(query, param)
    End Function

    'Tak Lulus Permohonan Perolehan
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function TakLulusPerolehan(mohonPo As PermohonanPo) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonPo Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Query_TakLulusPerolehan(mohonPo) <> "OK" Then
            resp.Failed("Gagal mengemaskini rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Permohonan Ditolak", "00", mohonPo)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_TakLulusPerolehan(mohonPo As PermohonanPo) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr
                              SET Status_Lulus = '0'
                              WHERE No_Mohon = @no_mohon_po"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@no_mohon_po", mohonPo.nombor_mohon))

        Return db.Process(query, param)
    End Function

    '===============================================================================================================================================================================
    'webservice Function for Dashboard Page
    '===============================================================================================================================================================================

    'Get data for total mohon perolehan
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTotalMohon() As String
        Dim resp As New ResponseRepository

        dt = Query_GetTotalMohon()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Query_GetTotalMohon() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT COUNT(*) AS tot_mohon FROM SMKB_Perolehan_Permohonan_Hdr;"

        Return db.Read(query)
    End Function

    'Get info for kelulusan perolehan
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKelulusanInfo() As String
        Dim resp As New ResponseRepository

        dt = Query_GetKelulusanInfo()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Query_GetKelulusanInfo() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT 
                                    COUNT(CASE WHEN Status_Lulus = '1' THEN 1 END) AS kelulusan_lulus,
                                    COUNT(CASE WHEN Status_Lulus = '0' THEN 1 END) AS kelulusan_tak_lulus,
                                    COUNT(CASE WHEN Status_Lulus IS NULL THEN 1 END) AS kelulusan_pending
                                FROM SMKB_Perolehan_Permohonan_Hdr;"

        Return db.Read(query)
    End Function

    'Get info for Anggaran Perbelanjaan
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAnggaran() As String
        Dim resp As New ResponseRepository

        dt = Query_GetAnggaran()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Query_GetAnggaran() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT FORMAT(SUM(Jumlah_Harga),'0.00') AS tot_Jumlah_Harga
                                FROM SMKB_Perolehan_Permohonan_Dtl"

        Return db.Read(query)
    End Function

    'Load Graph Kategori Perolehan
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadGraphKategoriPo() As String
        Dim resp As New ResponseRepository

        dt = Query_LoadGraphKategoriPo()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Query_LoadGraphKategoriPo() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT
                                SUM(CASE WHEN kategori.Butiran = 'KERJA' THEN 1 ELSE 0 END) AS kerja_count,
                                SUM(CASE WHEN kategori.Butiran = 'BEKALAN' THEN 1 ELSE 0 END) AS bekalan_count,
                                SUM(CASE WHEN kategori.Butiran = 'BEKALAN ICT' THEN 1 ELSE 0 END) AS ict_count,
                                SUM(CASE WHEN kategori.Butiran = 'PERKHIDMATAN' THEN 1 ELSE 0 END) AS perkhidmatan_count
                            FROM SMKB_Perolehan_Permohonan_Hdr AS a
                            INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03';"

        Return db.Read(query)
    End Function

    'Load Graph Pemohon based on month
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPemohonMonth() As String
        Dim resp As New ResponseRepository

        dt = Query_GetPemohonMonth()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Query_GetPemohonMonth() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT 
                                    MONTH(Tarikh_Mohon) AS month,
                                    COUNT(*) AS row_count
                                FROM SMKB_Perolehan_Permohonan_Hdr
                                GROUP BY MONTH(Tarikh_Mohon)
                                ORDER BY month;"

        Return db.Read(query)
    End Function

    '===============================================================================================================================================================================
    'webservice Function for Laporan Page
    '===============================================================================================================================================================================

    'Load DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadLaporanPo(category_filter As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadLaporanPo(category_filter)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadLaporanPo(category_filter As String) As DataTable
        Dim db = New DBKewConn

        Dim tarikhQuery As String = ""

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        End If

        Dim query As String = "
            SELECT  a.No_Mohon,FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, 
		    a.Tujuan,a.Jenis_Barang, a.status, kategori.Butiran AS kategori_butiran, 
            (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = '02' AND Kod_Status_Dok = Status_Dok ) As Status_Lulus
            FROM SMKB_Perolehan_Permohonan_Hdr AS a
            INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
            WHERE a.status ='1' " & tarikhQuery & " 
            ORDER BY No_Mohon DESC
        "

        Return db.Read(query)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Syarikat_Bidang_Utama(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodSyarikatBidangUtama(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodSyarikatBidangUtama(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "Select Kod As value, CONCAT(Kod, ' - ', Butiran) AS text From SMKB_Syarikat_Bidang_Utama order by Kod"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod LIKE '%' + @kod + '%') "
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Sub_Bidang_Utama(ByVal q As String, ByVal kodmof As String) As String

        Dim tmpDT As DataTable = GetKodSubBidangUtama(q, kodmof)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodSubBidangUtama(kod As String, kodmof As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "select kod as value, CONCAT(Kod, ' - ', Butiran) as text,Kod_Bdg_Utama 
                               from SMKB_Syarikat_Sub_Bidang WHERE 1 = 1  "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " AND (Kod LIKE '%' + @kod + '%') "
            param.Add(New SqlParameter("@kod", kod))
        End If

        If Not String.IsNullOrEmpty(kodmof) Then
            query &= " AND Kod_Bdg_Utama = @kodmof "
            param.Add(New SqlParameter("@kodmof", kodmof))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Show_Table_Bidang_Utama(ByVal kod_sub_bidang As String) As String
        Dim resp As New ResponseRepository
        If (kod_sub_bidang = "") Then
            Return ""
        End If
        dt = GetTableBU(kod_sub_bidang)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetTableBU(kod_sub_bidang As String) As DataTable
        Dim db = New DBKewConn
        Dim param As New List(Of SqlParameter)
        Dim query As String = "select kodbidang, butiran , KodSubBidang 
                               from SMKB_Syarikat_Bidang WHERE KodSubBidang = @kod_sub_bidang"
        param.Add(New SqlParameter("@kod_sub_bidang", kod_sub_bidang))
        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodCidb(ByVal q As String) As String

        Dim tmpDT As DataTable = GetCidb(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetCidb(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "Select Kod_Detail As value,Butiran As text from SMKB_Lookup_Detail
                               where kod ='vdr05'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @Kod_Detail + '%') "
            param.Add(New SqlParameter("@Kod_Detail", kod))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Show_Table_Cidb(ByVal kod_kategori As String) As String
        Dim resp As New ResponseRepository
        If (kod_kategori = "") Then
            Return ""
        End If
        dt = GetTableCidb(kod_kategori)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetTableCidb(kod_kategori As String) As DataTable
        Dim db = New DBKewConn
        Dim param As New List(Of SqlParameter)
        Dim query As String = "select kodkhusus, butiran , kodkategori,kodButiran
                               from SMKB_Syarikat_CIDB_Pengkhususan
                               where KodKategori= @kod_kategori"
        param.Add(New SqlParameter("@kod_kategori", kod_kategori))
        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasi(nomohon As String) As String

        Dim resp As New ResponseRepository

        dt = GetSpeksifikasi_Perolehan(nomohon)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasi_Perolehan(nomohon As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""

        Dim query As String = "SELECT kod, butiran, Jumlah, ISNULL(JumWajaran, 0) as JumWajaran 
        FROM SMKB_Perolehan_Spesifikasi A
        OUTER APPLY (
	        SELECT COUNT(no_mohon) as Jumlah , SUM(wajaran) as JumWajaran 
	        FROM SMKB_Perolehan_Spesifikasi_Am subA
	        WHERE no_mohon = @nomohon AND A.kod = subA.Kod_Spesifikasi
        ) B"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@nomohon", nomohon))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSpeksifikasiDetail(kod As String) As String

        Dim resp As New ResponseRepository
        dt = GetSpeksifikasi_Detail(kod)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpeksifikasi_Detail(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""

        Dim query As String = "SELECT IDDt, Kod, Butiran FROM SMKB_Perolehan_SpesifikasiDt WHERE Kod = @kod"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", kod))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanSpekDetail(nomohon As String, spekList As List(Of SpekDetail)) As String

        Dim resp As New ResponseRepository
        Dim rekodPermohonan = GetLoadPermohonanPerolehan(Session("ssusrID"), nomohon)

        If rekodPermohonan.Rows.Count = 0 Or String.IsNullOrEmpty(nomohon) Then
            resp.Failed("Sila isi maklumat pada tab 1 atau pilih senarai permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        For Each spek As SpekDetail In spekList
            'If String.IsNullOrEmpty(spek.butiran) Or String.IsNullOrEmpty(spek.wajaran) Then
            If String.IsNullOrEmpty(spek.butiran) Then
                Continue For
            End If
            insertNewSpekDetail(nomohon, spek.kodspek, spek.butiran, spek.wajaran, spek.kategoriPo)
        Next

        resp.Success("Data berjaya dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function insertNewSpekDetail(nomohon, kodspek, butiran, wajaran, kategoriPo)
        Dim db As New DBKewConn

        If (kategoriPo = "K") Then
            Dim query As String = "INSERT INTO SMKB_Perolehan_Spesifikasi_Am (No_Mohon, Kod_Spesifikasi, Butiran, Status)
            VALUES (@nomohon, @kodspek, @butiran, 1)"

            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@nomohon", nomohon))
            param.Add(New SqlParameter("@kodspek", kodspek))
            param.Add(New SqlParameter("@butiran", butiran))

            Return db.Process(query, param)

        Else
            Dim query As String = "INSERT INTO SMKB_Perolehan_Spesifikasi_Am (No_Mohon, Kod_Spesifikasi, Butiran, Wajaran, Status)
            VALUES (@nomohon, @kodspek, @butiran, @wajaran, 1)"

            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@nomohon", nomohon))
            param.Add(New SqlParameter("@kodspek", kodspek))
            param.Add(New SqlParameter("@butiran", butiran))
            param.Add(New SqlParameter("@wajaran", wajaran))

            Return db.Process(query, param)

        End If

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanSpekManual(nomohon As String, kodspek As String, butiran As String, wajaran As String, id As String, kategoriPo As String) As String
        Dim resp As New ResponseRepository
        Dim rekodPermohonan = GetLoadPermohonanPerolehan(Session("ssusrID"), nomohon)

        If rekodPermohonan.Rows.Count = 0 Or String.IsNullOrEmpty(nomohon) Then
            resp.Failed("Rekod Permohonan Tidak Dijumpai.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(id) Then
            insertNewSpekDetailManual(nomohon, kodspek, butiran, wajaran, kategoriPo)
            resp.Success("Data berjaya disimpan.")
        Else
            UpdateSpekDetail(nomohon, butiran, wajaran, id, kategoriPo)
            resp.Success("Data berjaya dikemaskini.")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Sub insertNewSpekDetailManual(nomohon As String, kodspek As String, butiran As String, wajaran As String, kategoriPo As String)
        Dim db As New DBKewConn
        If (kategoriPo = "K") Then
            Dim query As String = "INSERT INTO SMKB_Perolehan_Spesifikasi_Am (No_Mohon, Kod_Spesifikasi, Butiran, Status) VALUES (@nomohon, @kodspek, @butiran, 1)"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@nomohon", nomohon))
            param.Add(New SqlParameter("@kodspek", kodspek))
            param.Add(New SqlParameter("@butiran", butiran))

            db.Process(query, param)

        Else

            Dim query As String = "INSERT INTO SMKB_Perolehan_Spesifikasi_Am (No_Mohon, Kod_Spesifikasi, Butiran, Wajaran, Status) VALUES (@nomohon, @kodspek, @butiran, @wajaran, 1)"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@nomohon", nomohon))
            param.Add(New SqlParameter("@kodspek", kodspek))
            param.Add(New SqlParameter("@butiran", butiran))
            param.Add(New SqlParameter("@wajaran", wajaran))

            db.Process(query, param)

        End If

    End Sub
    Private Function UpdateSpekDetail(nomohon As String, butiran As String, wajaran As String, id As String, kategoriPo As String)
        Dim db As New DBKewConn

        If (kategoriPo = "K") Then
            Dim query As String = "UPDATE SMKB_Perolehan_Spesifikasi_Am SET Butiran = @butiran
                                   WHERE No_Mohon = @nomohon And Id_Am = @id_am"

            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@butiran", butiran))
            param.Add(New SqlParameter("@nomohon", nomohon))
            param.Add(New SqlParameter("@id_am", id))

            Return db.Process(query, param)
        Else
            Dim query As String = "UPDATE SMKB_Perolehan_Spesifikasi_Am SET Butiran = @butiran, Wajaran = @wajaran
                               WHERE No_Mohon = @nomohon And Id_Am = @id_am"

            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@butiran", butiran))
            param.Add(New SqlParameter("@wajaran", wajaran))
            param.Add(New SqlParameter("@nomohon", nomohon))
            param.Add(New SqlParameter("@id_am", id))

            Return db.Process(query, param)

        End If


    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPermohonanPerolehan(id_pemohon As String) As String
        Dim resp As New ResponseRepository
        If String.IsNullOrEmpty(id_pemohon) Then
            Return JsonConvert.SerializeObject(New DataTable())
        End If

        Dim dt As DataTable = GetLoadPermohonanPerolehan(id_pemohon, "")

        Return JsonConvert.SerializeObject(dt)

    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetLoadPermohonanPerolehan(id_pemohon As String, id_mohon As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT  a.No_Mohon,
		                        FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, 
		                        a.Tujuan,
		                        --a.Jenis_Barang, 
								kategori.Butiran AS kategori_butiran
                                --a.Status_Lulus
                        FROM SMKB_Perolehan_Permohonan_Hdr AS a
                        INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
                         where id_pemohon= @id_pemohon
                        ORDER BY No_Mohon DESC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@id_pemohon", id_pemohon))

        Dim dt As DataTable = db.Read(query, param)

        Return dt
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiPerolehan(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SenaraiPerolehan(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SenaraiPerolehan(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)
        param = New List(Of SqlParameter)

        param.Add(New SqlParameter("@idpengguna", Session("ssusrID")))

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        'Dim query = "SELECT  a.No_Mohon, FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,                    
        '            kategori.Butiran AS kategori_butiran
        '            FROM SMKB_Perolehan_Permohonan_Hdr AS a
        '            INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
        '            where id_pemohon= '02634' " & tarikhQuery & "
        '            ORDER BY a.Tarikh_Mohon Desc"

        Dim query = "SELECT * FROM (
	        SELECT ROW_NUMBER() OVER(ORDER BY a.Tarikh_Mohon ASC) Bil, a.No_Mohon, FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Status_Dok,                   
	        kategori.Butiran AS kategori_butiran,c.Butiran, a.Tahun_Perolehan
	        FROM SMKB_Perolehan_Permohonan_Hdr AS a
	        INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
            INNER JOIN SMKB_Kod_Status_Dok As C ON a.Status_Dok = c.Kod_Status_Dok
	        where (a.Status_Dok='03' or a.Status_Dok='04' or (a.Status_Dok='29' and a.Flag_PenentuanTeknikal='1') or (a.Status_Dok='30' and a.Flag_PenentuanTeknikal='0')) and c.Kod_Modul='02' and TahapPerolehan='uni' and id_pemohon= @idpengguna " & tarikhQuery & " 
        ) mainTbl"

        Return db.Read(query, param)
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiPerolehanPtj(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SenaraiPerolehanPtj(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SenaraiPerolehanPtj(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)
        param = New List(Of SqlParameter)

        param.Add(New SqlParameter("@idpengguna", Session("ssusrID")))

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        'Dim query = "SELECT  a.No_Mohon, FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,                    
        '            kategori.Butiran AS kategori_butiran
        '            FROM SMKB_Perolehan_Permohonan_Hdr AS a
        '            INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
        '            where id_pemohon= '02634' " & tarikhQuery & "
        '            ORDER BY a.Tarikh_Mohon Desc"

        Dim query = "SELECT * FROM (
	        SELECT ROW_NUMBER() OVER(ORDER BY a.Tarikh_Mohon ASC) Bil, a.No_Mohon, FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Status_Dok,                   
	        kategori.Butiran AS kategori_butiran,c.Butiran, a.Tahun_Perolehan
	        FROM SMKB_Perolehan_Permohonan_Hdr AS a
	        INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
            INNER JOIN SMKB_Kod_Status_Dok As C ON a.Status_Dok = c.Kod_Status_Dok
	        where (a.Status_Dok='03' or a.Status_Dok='04' or (a.Status_Dok='29' and a.Flag_PenentuanTeknikal='1') or (a.Status_Dok='30' and a.Flag_PenentuanTeknikal='0')) and c.Kod_Modul='02' and TahapPerolehan='ptj' and id_pemohon= @idpengguna " & tarikhQuery & " 
        ) mainTbl"

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function ClearSessionNoMohon()
        Session("nomohon") = ""
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrPerolehan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrPerolehan(id)
        resp.SuccessPayload(dt)

        If String.IsNullOrEmpty(id) Then
            Session("nomohon") = ""
        Else
            dt = GetHdrPerolehan(id)
            resp.SuccessPayload(dt)

            If (dt.Rows.Count > 0) Then
                Session("nomohon") = id
            End If
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrPerolehan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT No_Mohon,FORMAT(Tarikh_Mohon, 'dd/MM/yyyy') AS Tarikh_Mohon,Tujuan,Skop,Jenis_Barang,Justifikasi,Kod_Ptj_Mohon,Perolehan_Terdahulu,Bekal_Kepada,
        FORMAT(Tarikh_Perlu, 'dd/MM/yyyy') AS Tarikh_Perlu, Format(A.Tarikh_Mula, 'yyyy-MM-dd') Tarikh_Mula,Tempoh,Jenis_Tempoh, Format(Bekal_Sebelum, 'yyyy-MM-dd')  Bekal_Sebelum,
        (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = A.status_dok) AS status_dok,
        (SELECT CONCAT(Kod_Detail, ' - ', Butiran) AS Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PO03' AND SMKB_Lookup_Detail.Kod_Detail = A.Jenis_Barang) AS Butiran,
        (SELECT CONCAT(KodPejabat, ' - ', Pejabat) AS Butiran FROM VPejabat WHERE VPejabat.KodPejabat = A.Bekal_Kepada) AS ButiranPtj,
        B.Butiran as B_JenisTempoh ,a.Tahun_Perolehan
        FROM SMKB_Perolehan_Permohonan_Hdr a
        INNER JOIN SMKB_Lookup_Detail B
	    ON A.Jenis_Tempoh = B.Kod_Detail AND kod = 'PO05'
        WHERE No_Mohon = @No_Mohon"

        'Dim query As String = "Select Case No_Mohon ,Tarikh_Mohon, Status_Dok,Tahun_Perolehan
        '                        Tujuan, Skop, Kod_Ptj_Mohon, Id_Pemohon, Tarikh_Perlu, Perolehan_Terdahulu, Justifikasi,
        '                        (SELECT  concat(Kod_Detail,' - ' ,Butiran) as Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PO03' and SMKB_Lookup_Detail.Kod_Detail = SMKB_Perolehan_Permohonan_Hdr.Jenis_Barang) AS Butiran					
        '                        From SMKB_Perolehan_Permohonan_Hdr Where No_Mohon = @No_Mohon"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", id))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PNLDetail(kod As String, no_mohon As String) As String
        Dim resp As New ResponseRepository
        If kod = "" Or String.IsNullOrEmpty(no_mohon) Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetSpek_DetailList(kod, no_mohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetSpek_DetailList(kod As String, no_mohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        'Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=smkb;pwd=Smkb@Dev2012;"


        Using sqlconn As New SqlConnection(strCon)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String

            query = "select id_am, no_mohon,kod_spesifikasi,butiran,wajaran 
                    from SMKB_Perolehan_Spesifikasi_Am
                    where kod_spesifikasi = @kod and no_mohon = @no_mohon
                    order by id_am"

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@kod", kod))
            cmd.Parameters.Add(New SqlParameter("@no_mohon", no_mohon))


            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'Delete ChildTable Speksifikasi Am
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteSpeksifikasiAm(ByVal id As String) As String
        Dim resp As New ResponseRepository

        If Query_DeleteSpeksifikasiAm(id) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_DeleteSpeksifikasiAm(id As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM SMKB_Perolehan_Spesifikasi_Am WHERE id_am = @id_am"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id_am", id))

        Return db.Process(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_BidangMof(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_BidangMof(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_BidangMof(id As String) As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "SELECT a.Id_Jualan,a.Kod_Bidang,b.Butiran,a.No_Mohon,
        '                    CASE
        '                    WHEN a.Syarat = 0 THEN 'terakhir'
        '                    WHEN a.Syarat = 1 THEN 'dan'
        '                    WHEN a.Syarat = 2 THEN 'atau'
        '                    END AS Syarat,
        '                    a.Urutan,a.Status
        '                    FROM SMKB_Perolehan_Bidang a
        '                    JOIN SMKB_Syarikat_Bidang b ON a.Kod_Bidang = b.KodBidang
        '                    WHERE a.No_Mohon = @nombor_mohon"

        Dim query As String = "SELECT a.Id_Jualan,a.Kod_Bidang,b.Butiran,a.No_Mohon,
                                CASE
                                    WHEN a.Syarat = 0 THEN 'terakhir'
                                    WHEN a.Syarat = 1 THEN 'dan'
                                    WHEN a.Syarat = 2 THEN 'atau'
                                END AS Syarat,
                                a.Urutan,
                                a.Status
                            FROM SMKB_Perolehan_Bidang a
                            JOIN SMKB_Syarikat_Bidang b ON a.Kod_Bidang = b.KodBidang
                            WHERE a.No_Mohon = @nombor_mohon
                            ORDER BY 
                                CASE 
                                    WHEN a.Syarat = 0 THEN 2  
                                    WHEN a.Syarat = 1 THEN 1  
                                    WHEN a.Syarat = 2 THEN 1  
                                    ELSE 0                    
                                END"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@nombor_mohon", id))

        Return db.Read(query, param)
    End Function

    'Delete Row DataTable Table Bidang Mof
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteBidangMof2(ByVal id As String) As String
        Dim resp As New ResponseRepository

        If Query_deleteBidangMof2(id) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deleteBidangMof2(id As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM SMKB_Perolehan_Bidang WHERE Id_Jualan = @Id_Jualan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Jualan", id))

        Return db.Process(query, param)
    End Function

    'Save data insert into (Maklumat Bajet dan Spesifikasi)
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveBidangMof(bidangMofHeader As SimpanBidangMof) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If bidangMofHeader Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertBidangMof(bidangMofHeader) <> "OK" Then
            resp.Failed("Gagal Menyimpan data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya disimpan", "00", bidangMofHeader)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertBidangMof(bidangMofHeader As SimpanBidangMof) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Bidang(Kod_Bidang, No_Mohon, Syarat, Urutan, Status)
        VALUES(@kodbidang, @txtNoMohon, @keperluan_mof, ISNULL((SELECT TOP 1 Urutan + 1 FROM [SMKB_Perolehan_Bidang] WHERE No_mohon = @txtNoMohon ORDER BY Urutan DESC), 1), '1')"
        Dim param As New List(Of SqlParameter)

        'param.Add(New SqlParameter("@idjualan", bidangMofHeader.idJualan))
        param.Add(New SqlParameter("@kodbidang", bidangMofHeader.kodBidang))
        param.Add(New SqlParameter("@txtNoMohon", bidangMofHeader.noMohon))
        param.Add(New SqlParameter("@keperluan_mof", bidangMofHeader.syarat))
        'param.Add(New SqlParameter("@urutan", "1"))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PaparStatusBidang(ByVal noMohon As String) As String
        Dim db = New DBKewConn
        Dim ayat As String = ""
        Dim counter As Integer = 0
        Dim query As String = "SELECT Kod_Bidang, Syarat, Urutan FROM SMKB_Perolehan_Bidang WHERE No_mohon = @noMohon ORDER BY CASE WHEN Syarat <> '0' THEN 1 ELSE 0 END desc,
        CAST(URUTAN as integer)  ASC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohon", noMohon))

        Dim prevKod As String = ""
        Dim prevSyarat As String = ""
        Dim flag As Integer = 0
        Dim dt As DataTable = db.Read(query, param)
        Dim response As New Response

        '1 - dan
        '2 - atau
        '0 - terakhir
        '(010101 ATAU 010303) DAN 010699 DAN (010102 ATAU 020199 ATAU 020103 ATAU 060101) DAN 020299


        Dim curSyaratText As String = ""
        For Each dr As DataRow In dt.Rows
            curSyaratText = ""
            counter += 1
            Dim curSyarat As String = dr.Item("Syarat")
            Dim curCode As String = dr.Item("Kod_Bidang")

            If curSyarat = "2" And prevSyarat <> "2" Then
                ayat &= " ( "
            End If

            If curSyarat = "1" Then
                curSyaratText = " DAN "
            ElseIf curSyarat = "2" Then
                curSyaratText = " ATAU "
            End If

            ayat &= curCode

            If curSyarat = "1" And prevSyarat = "2" Then
                ayat &= " ) " & curSyaratText
            Else
                ayat &= curSyaratText
            End If
            '(prevSyarat = "2" And (curSyarat = "1" Or curSyarat = "0")) Or
            If (counter = dt.Rows.Count And curSyarat = "2") Or (prevSyarat = "2" And curSyarat = "0") Then
                ayat &= " ) "
            End If

            'If prevSyarat <> "2" Then
            '    ayat &= curSyaratText
            'End If

            prevKod = curCode
            prevSyarat = curSyarat
        Next


        'For Each dr As DataRow In dt.Rows
        '    If prevKod = "" Then
        '        prevKod = dr.Item("Kod_Bidang")
        '        prevSyarat = dr.Item("Syarat")
        '        If ayat = "" And dr.Item("Syarat") = "2" Then
        '            ayat = " ( "
        '            flag = 4
        '        End If
        '        Continue For
        '    End If

        '    If prevSyarat = "2" Then
        '        If flag = 4 Then
        '            ayat &= " " & prevKod
        '        End If
        '        ayat &= " ATAU " & dr.Item("Kod_Bidang")

        '        If dr.Item("Syarat") = "1" Then
        '            ayat &= " ) "
        '        End If

        '        prevKod = dr.Item("Kod_Bidang")
        '        prevSyarat = dr.Item("Syarat")

        '        If dr.Item("Syarat") = "0" Then
        '            ayat &= " ) "
        '        End If

        '        flag = 1

        '    ElseIf prevSyarat = "1" Then
        '        If flag = 0 Then
        '            ayat &= " " & prevKod
        '        End If

        '        If prevSyarat = "2" Then
        '            ayat &= " ) "
        '        End If
        '        ayat &= " DAN "
        '        prevKod = dr.Item("Kod_Bidang")
        '        prevSyarat = dr.Item("Syarat")
        '        flag = 0

        '        If dr.Item("Syarat") = "2" Then
        '            ayat &= " ( "
        '            flag = 4
        '        ElseIf dr.Item("Syarat") = "0" Then
        '            ayat &= dr.Item("Kod_Bidang")
        '        End If
        '    End If


        '    counter += 1
        'Next
        response.Payload = ayat
        response.Status = True
        response.Code = "00"


        Return JsonConvert.SerializeObject(response)
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PaparStatusBidangDescription(ByVal noMohon2 As String) As String

        Dim db = New DBKewConn
        Dim ayat As String = ""
        Dim counter As Integer = 0
        Dim query As String = "SELECT B.Butiran As Kod_Bidang, A.Syarat, A.Urutan 
                                FROM SMKB_Perolehan_Bidang A
                                JOIN SMKB_Syarikat_Bidang B ON A.Kod_Bidang = B.KodBidang
                                WHERE A.No_mohon = @noMohon2
                                ORDER BY 
                                CASE WHEN A.Syarat <> '0' THEN 1 ELSE 0 END desc,
                                CAST(A.URUTAN as integer)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohon2", noMohon2))

        Dim prevKod As String = ""
        Dim prevSyarat As String = ""
        Dim flag As Integer = 0
        Dim dt As DataTable = db.Read(query, param)
        Dim response As New Response

        '1 - dan
        '2 - atau
        '0 - terakhir
        '(010101 ATAU 010303) DAN 010699 DAN (010102 ATAU 020199 ATAU 020103 ATAU 060101) DAN 020299


        Dim curSyaratText As String = ""
        For Each dr As DataRow In dt.Rows
            curSyaratText = ""
            counter += 1
            Dim curSyarat As String = dr.Item("Syarat")
            Dim curCode As String = dr.Item("Kod_Bidang")

            If curSyarat = "2" And prevSyarat <> "2" Then
                ayat &= " ( "
            End If

            If curSyarat = "1" Then
                curSyaratText = " DAN "
            ElseIf curSyarat = "2" Then
                curSyaratText = " ATAU "
            End If

            ayat &= curCode

            If curSyarat = "1" And prevSyarat = "2" Then
                ayat &= " ) " & curSyaratText
            Else
                ayat &= curSyaratText
            End If
            '(prevSyarat = "2" And (curSyarat = "1" Or curSyarat = "0")) Or
            If (counter = dt.Rows.Count And curSyarat = "2") Or (prevSyarat = "2" And curSyarat = "0") Then
                ayat &= " ) "
            End If

            'If prevSyarat <> "2" Then
            '    ayat &= curSyaratText
            'End If

            prevKod = curCode
            prevSyarat = curSyarat
        Next


        response.Payload = ayat
        response.Status = True
        response.Code = "00"


        Return JsonConvert.SerializeObject(response)
        'Dim db = New DBKewConn
        'Dim ayat As String = ""
        'Dim counter As Integer = 0

        'Dim query As String = "SELECT B.Butiran As Kod_Bidang, A.Syarat, A.Urutan 
        '                        FROM SMKB_Perolehan_Bidang A
        '                        JOIN SMKB_Syarikat_Bidang B ON A.Kod_Bidang = B.KodBidang
        '                        WHERE A.No_mohon = @noMohon2
        '                        ORDER BY 
        '                        CASE WHEN A.Syarat <> '0' THEN 1 ELSE 0 END desc,
        '                        CAST(A.URUTAN as integer)"

        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@noMohon2", noMohon2))

        'Dim prevKod As String = ""
        'Dim prevSyarat As String = ""
        'Dim flag As Integer = 0
        'Dim dt As DataTable = db.Read(query, param)
        'Dim response As New Response

        ''1 - dan
        ''2 - atau
        ''0 - terakhir
        ''(010101 ATAU 010303) DAN 010699 DAN (010102 ATAU 020199 ATAU 020103 ATAU 060101) DAN 020299
        'For Each dr As DataRow In dt.Rows
        '    If prevKod = "" Then
        '        prevKod = dr.Item("Kod_Bidang")
        '        prevSyarat = dr.Item("Syarat")
        '        If ayat = "" And dr.Item("Syarat") = "2" Then
        '            ayat = " ( "
        '            flag = 4
        '        End If
        '        Continue For
        '    End If

        '    If prevSyarat = "2" Then
        '        If flag = 4 Then
        '            ayat &= " " & prevKod
        '        End If
        '        ayat &= " ATAU " & dr.Item("Kod_Bidang")

        '        If dr.Item("Syarat") = "1" Then
        '            ayat &= " ) "
        '        End If

        '        prevKod = dr.Item("Kod_Bidang")
        '        prevSyarat = dr.Item("Syarat")

        '        If dr.Item("Syarat") = "0" Then
        '            ayat &= " ) "
        '        End If

        '        flag = 1

        '    ElseIf prevSyarat = "1" Then
        '        If flag = 0 Then
        '            ayat &= " " & prevKod
        '        End If

        '        If prevSyarat = "2" Then
        '            ayat &= " ) "
        '        End If
        '        ayat &= " DAN "
        '        prevKod = dr.Item("Kod_Bidang")
        '        prevSyarat = dr.Item("Syarat")
        '        flag = 0

        '        If dr.Item("Syarat") = "2" Then
        '            ayat &= " ( "
        '            flag = 4
        '        ElseIf dr.Item("Syarat") = "0" Then
        '            ayat &= dr.Item("Kod_Bidang")
        '        End If
        '    End If

        '    counter += 1
        'Next
        'response.Payload = ayat
        'response.Status = True
        'response.Code = "00"

        'Return JsonConvert.SerializeObject(response)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_Cidb(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_Cidb(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_Cidb(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.Id_Jualan, a.Kod_Kategori, a.Kod_Khusus, a.No_Mohon,
                               CASE
                                    WHEN a.Syarat = 0 THEN 'terakhir'
                                    WHEN a.Syarat = 1 THEN 'dan'
                                    WHEN a.Syarat = 2 THEN 'atau'
                                END AS Syarat,
                                a.Urutan, a.Status,
                                b.Butiran -- Select all columns from SMKB_Syarikat_CIDB_Pengkhususan
                                FROM SMKB_Perolehan_CIDB a
                                JOIN SMKB_Syarikat_CIDB_Pengkhususan b ON a.Kod_Khusus = b.KodKhusus
                                WHERE a.No_Mohon = @nombor_mohon"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@nombor_mohon", id))

        Return db.Read(query, param)
    End Function

    'Save data insert into (Maklumat Bajet dan Spesifikasi)
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveBidangCidb(bidangCidbHeader As SimpanBidangCidb) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If bidangCidbHeader Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertBidangCidb(bidangCidbHeader) <> "OK" Then
            resp.Failed("Gagal Menyimpan data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Data berjaya disimpan", "00", bidangCidbHeader)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertBidangCidb(bidangCidbHeader As SimpanBidangCidb) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_CIDB(Kod_Khusus, No_Mohon, Kod_Kategori,Syarat, Urutan, Status)
        VALUES(@kodkhusus, @noMohon, @kodkategori, @syarat, ISNULL((SELECT TOP 1 Urutan + 1 FROM [SMKB_Perolehan_CIDB] WHERE No_Mohon = @noMohon ORDER BY Urutan DESC), 1), '1')"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kodkhusus", bidangCidbHeader.kodkhusus))
        param.Add(New SqlParameter("@noMohon", bidangCidbHeader.noMohon))
        param.Add(New SqlParameter("@kodkategori", bidangCidbHeader.kodkategori))
        param.Add(New SqlParameter("@syarat", bidangCidbHeader.syarat))


        Return db.Process(query, param)
    End Function


    'Delete Row DataTable Table Bidang Mof
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteCidb(ByVal id As String) As String
        Dim resp As New ResponseRepository

        If Query_deleteCidb(id) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deleteCidb(id As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM SMKB_Perolehan_CIDB WHERE Id_Jualan = @Id_Jualan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Jualan", id))

        Return db.Process(query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PaparStatusCidb(ByVal noMohon As String) As String
        Dim db = New DBKewConn
        Dim ayat As String = ""
        Dim counter As Integer = 0
        Dim query As String = "SELECT Kod_Khusus As Kod_Bidang, Syarat, Urutan FROM SMKB_Perolehan_CIDB WHERE No_mohon = @nomohon ORDER BY CASE WHEN Syarat <> '0' THEN 1 ELSE 0 END desc,
        CAST(URUTAN as integer)  ASC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohon", noMohon))

        Dim prevKod As String = ""
        Dim prevSyarat As String = ""
        Dim flag As Integer = 0
        Dim dt As DataTable = db.Read(query, param)
        Dim response As New Response
        '1 - dan
        '2 - atau
        '0 - terakhir
        '(010101 ATAU 010303) DAN 010699 DAN (010102 ATAU 020199 ATAU 020103 ATAU 060101) DAN 020299

        For Each dr As DataRow In dt.Rows
            If prevKod = "" Then
                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")
                If ayat = "" And dr.Item("Syarat") = "2" Then
                    ayat = " ( "
                    flag = 4
                End If
                Continue For
            End If

            If prevSyarat = "2" Then
                If flag = 4 Then
                    ayat &= " " & prevKod
                End If
                ayat &= " ATAU " & dr.Item("Kod_Bidang")

                If dr.Item("Syarat") = "1" Then
                    ayat &= " ) "
                End If

                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")

                If dr.Item("Syarat") = "0" Then
                    ayat &= " ) "
                End If

                flag = 1

            ElseIf prevSyarat = "1" Then
                If flag = 0 Then
                    ayat &= " " & prevKod
                End If

                If prevSyarat = "2" Then
                    ayat &= " ) "
                End If
                ayat &= " DAN "
                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")
                flag = 0

                If dr.Item("Syarat") = "2" Then
                    ayat &= " ( "
                    flag = 4
                ElseIf dr.Item("Syarat") = "0" Then
                    ayat &= dr.Item("Kod_Bidang")
                End If
            End If


            counter += 1
        Next
        response.Payload = ayat
        response.Status = True
        response.Code = "00"

        Return JsonConvert.SerializeObject(response)
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PaparStatusCidbDescription(ByVal noMohon As String) As String
        Dim db = New DBKewConn
        Dim ayat As String = ""
        Dim counter As Integer = 0

        Dim query As String = "SELECT B.Butiran As Kod_Bidang, A.Syarat, A.Urutan 
                                FROM SMKB_Perolehan_CIDB A
                                JOIN SMKB_Syarikat_CIDB_Pengkhususan B ON A.Kod_Khusus = B.KodKhusus
                                WHERE A.No_mohon = @nomohon
                                ORDER BY 
                                CASE WHEN A.Syarat <> '0' THEN 1 ELSE 0 END desc,
                                CAST(A.URUTAN as integer)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noMohon", noMohon))
        Dim prevKod As String = ""
        Dim prevSyarat As String = ""
        Dim flag As Integer = 0
        Dim dt As DataTable = db.Read(query, param)
        Dim response As New Response
        '1 - dan
        '2 - atau
        '0 - terakhir
        '(010101 ATAU 010303) DAN 010699 DAN (010102 ATAU 020199 ATAU 020103 ATAU 060101) DAN 020299

        For Each dr As DataRow In dt.Rows
            If prevKod = "" Then
                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")
                If ayat = "" And dr.Item("Syarat") = "2" Then
                    ayat = " ( "
                    flag = 4
                End If
                Continue For
            End If

            If prevSyarat = "2" Then
                If flag = 4 Then
                    ayat &= " " & prevKod
                End If
                ayat &= " ATAU " & dr.Item("Kod_Bidang")

                If dr.Item("Syarat") = "1" Then
                    ayat &= " ) "
                End If

                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")

                If dr.Item("Syarat") = "0" Then
                    ayat &= " ) "
                End If

                flag = 1

            ElseIf prevSyarat = "1" Then
                If flag = 0 Then
                    ayat &= " " & prevKod
                End If

                If prevSyarat = "2" Then
                    ayat &= " ) "
                End If
                ayat &= " DAN "
                prevKod = dr.Item("Kod_Bidang")
                prevSyarat = dr.Item("Syarat")
                flag = 0

                If dr.Item("Syarat") = "2" Then
                    ayat &= " ( "
                    flag = 4
                ElseIf dr.Item("Syarat") = "0" Then
                    ayat &= dr.Item("Kod_Bidang")
                End If
            End If

            counter += 1
        Next
        response.Payload = ayat
        response.Status = True
        response.Code = "00"

        Return JsonConvert.SerializeObject(response)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFile() As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        Try
            ' Specify the file path where you want to save the uploaded file
            Dim savePath As String = Server.MapPath("~/UPLOAD/DOCUMENT/PEROLEHAN/PERMOHONAN/" & fileName)

            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveAndUploadFile() As String
        Dim dokumenType As String, namaFail As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim fileSize As Long = postedFile.ContentLength
        Dim fileExtension As String = Path.GetExtension(fileName).ToLower()
        Dim nomohon As String = HttpContext.Current.Request.Form("nomohon")
        namaFail = HttpContext.Current.Request.Form("namaFail")
        dokumenType = HttpContext.Current.Request.Form("dokumenType")
        Try

            ' Specify the file path where you want to save the uploaded file
            Dim folderPath As String = Server.MapPath("~/UPLOAD/DOCUMENT/PEROLEHAN/PERMOHONAN/" & nomohon)
            Dim savePath As String = Path.Combine(folderPath, postedFile.FileName)

            ' Check if the folder for No_Mohon exists, create it if not
            If Not Directory.Exists(folderPath) Then
                Directory.CreateDirectory(folderPath)
            End If

            ' Check file extension on the server side
            If Not IsFileExtensionValid(fileExtension) Then
                ' Delete the file if the extension is not valid
                File.Delete(savePath)
                Return "Invalid file format. Only PDF files are allowed."
            End If

            Dim query As String = "INSERT INTO SMKB_Perolehan_Lampiran(No_Mohon, Lampiran, Nama_Fail, Jenis_Dokumen, Status) VALUES (@No_Mohon, @Lampiran, @Nama_Fail, @Jenis_Dokumen, 1)"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@No_Mohon", nomohon))
            param.Add(New SqlParameter("@Lampiran", namaFail & fileExtension))
            param.Add(New SqlParameter("@Nama_Fail", postedFile.FileName))
            param.Add(New SqlParameter("@Jenis_Dokumen", dokumenType))

            Dim db As New DBKewConn
            Dim result As String = db.Process(query, param)

            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            Return "File uploaded successfully. " & result
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function


    Private Function IsFileExtensionValid(extension As String) As Boolean
        ' Check if the file extension is valid (e.g., only allow PDF files)
        Return extension = ".pdf"
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_Lampiran(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_Lampiran(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_Lampiran(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT Id_Lampiran,Nama_Fail,Lampiran
                               from SMKB_Perolehan_Lampiran
                               WHERE No_Mohon = @nombor_mohon
                               order by Id_Lampiran asc"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@nombor_mohon", id))

        Return db.Read(query, param)
    End Function

    'Delete Lampiran
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteLampiran(ByVal id As String, nomohon1 As String, NamaFailPdf As String) As String
        Dim resp As New ResponseRepository

        Dim namaFail As String = NamaFailPdf
        Dim noMohon As String = nomohon1

        If Query_deleteLampiran(id, nomohon1, NamaFailPdf) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim filePath As String = Server.MapPath("~/Upload/Document/PEROLEHAN/PERMOHONAN/") & noMohon & "/" & namaFail
        If System.IO.File.Exists(filePath) Then
            System.IO.File.Delete(filePath)
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deleteLampiran(id As String, nomohon1 As String, NamaFailPdf As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM SMKB_Perolehan_Lampiran WHERE Id_Lampiran = @Id_Lampiran"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Lampiran", id))

        Return db.Process(query, param)
    End Function

    'Semakan Bendahari ZON
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiSemakanZon(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_SenaraiSemakanZon(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_SenaraiSemakanZon(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query = "SELECT  a.No_Mohon, a.No_Perolehan,FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan, a.Skop, a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,                    
                    a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, CONCAT('RM ', a.Perolehan_Terdahulu) AS Perolehan_Terdahulu,a.Justifikasi, 
                    kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    StatusPO.Butiran As ButiranKodDok,FORMAT(a.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum ,
					SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP
                    FROM SMKB_Perolehan_Permohonan_Hdr AS a
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
					INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
					INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
                    where StatusPO.Kod_Modul='02' and Status_Dok = '28' " & tarikhQuery & "
                    ORDER BY a.Tarikh_Mohon Desc"

        Return db.Read(query, param)
    End Function
    'Semakan Kelulusan PTJ
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiKelulusanPtj(ObjKelulusanPTj As ObjKelulusanPTj) As String
        'Public Function Load_SenaraiKelulusanPtj(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime, Optional no_mohon As String = "") As String
        Dim resp As New ResponseRepository

        If ObjKelulusanPTj.isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_KelulusanPTj(ObjKelulusanPTj.categori_Filter, ObjKelulusanPTj.tkhMula, ObjKelulusanPTj.tkhTamat, ObjKelulusanPTj.ssusrKodPTj, ObjKelulusanPTj.no_mohon)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Public Class ObjKelulusanPTj
        Public Property categori_Filter As String
        Public Property isClicked5 As Boolean
        Public Property tkhMula As DateTime
        Public Property tkhTamat As DateTime
        Public Property no_mohon As String = ""
        Public Property category_filter As String
        Public Property ssusrKodPTj As String

    End Class

    Private Function Get_Load_KelulusanPTj(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, ssusrKodPTj As String, Optional no_mohon As String = "") As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)
        param = New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "

            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        If Not String.IsNullOrEmpty(no_mohon) Then
            tarikhQuery = " AND a.No_Mohon = @no_mohon "
            param.Add(New SqlParameter("@no_mohon", no_mohon))
        End If

        Dim query = "SELECT  a.No_Mohon, a.No_Perolehan,FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Skop,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,                    
                    a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, CONCAT('RM ', a.Perolehan_Terdahulu) AS Perolehan_Terdahulu,a.Justifikasi, 
                    kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    StatusPO.Butiran As ButiranKodDok,FORMAT(a.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum ,
					SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP,
                    CONCAT((a.Bekal_Kepada +'0000'), ' - ', c.Pejabat) As BekalPTJ,a.Bekal_Kepada
                    FROM SMKB_Perolehan_Permohonan_Hdr AS a
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
					INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
					INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
                    INNER JOIN VPejabat As C On a.Bekal_Kepada = C.KodPejabat
                    where Bekal_Kepada = @bekalkepada and StatusPO.Kod_Modul='02' and Status_Dok = '28' " & tarikhQuery & "
                    ORDER BY a.Tarikh_Mohon Desc"
        param.Add(New SqlParameter("@bekalkepada", ssusrKodPTj))
        Return db.Read(query, param)
    End Function

    'Semakan Kelulusan Bendahari
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiKelulusanBendahari(ObjKelulusanPTj As ObjKelulusanPTj) As String

        'Public Function Load_SenaraiKelulusanBendahari(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If ObjKelulusanPTj.isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_KelulusanBendahari(ObjKelulusanPTj.category_filter, ObjKelulusanPTj.tkhMula, ObjKelulusanPTj.tkhTamat, ObjKelulusanPTj.no_mohon)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_KelulusanBendahari(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, Optional no_mohon As String = "") As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)
        param = New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "

            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        If Not String.IsNullOrEmpty(no_mohon) Then
            tarikhQuery = " AND a.No_Mohon = @no_mohon "
            param.Add(New SqlParameter("@no_mohon", no_mohon))
        End If

        Dim query = "SELECT  a.No_Mohon, a.No_Perolehan,FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Skop,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,                    
                    a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, CONCAT('RM ', a.Perolehan_Terdahulu) AS Perolehan_Terdahulu,a.Justifikasi, 
                    kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    StatusPO.Butiran As ButiranKodDok,FORMAT(a.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum ,
					SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP,
                    CONCAT((a.Bekal_Kepada +'0000'), ' - ', c.Pejabat) As BekalPTJ,a.Bekal_Kepada
                    FROM SMKB_Perolehan_Permohonan_Hdr AS a
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
					INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
					INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
                    INNER JOIN VPejabat As C On a.Bekal_Kepada = C.KodPejabat
                    where StatusPO.Kod_Modul='02' and Status_Dok = '08' " & tarikhQuery & "
                    ORDER BY a.Tarikh_Mohon Desc"

        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKaedahPerolehan(ByVal noMohon As String) As String
        Dim db = New DBKewConn
        Dim param As New List(Of SqlParameter)()

        Dim totalValue As Double = GetTotalValueFromDatabase(noMohon)

        If String.IsNullOrEmpty(noMohon) Then
            Return JsonConvert.SerializeObject(New List(Of Object)({New With {.Kod_Kaedah = "", .Kategori_Perolehan = ""}}))
        End If

        Dim query As String = "SELECT Kod_Kaedah,Kategori_Perolehan FROM SMKB_Perolehan_Kaedah WHERE @totalValue BETWEEN Min_Harga AND Max_Harga"
        param.Add(New SqlParameter("@totalValue", totalValue))

        Return JsonConvert.SerializeObject(db.Read(query, param))
    End Function

    Private Function GetTotalValueFromDatabase(ByVal noMohon As String) As Double
        Dim db = New DBKewConn
        Dim totalValue As Double = 0.00
        Dim param As New List(Of SqlParameter)()

        Dim query As String = "SELECT SUM(Jumlah_Harga) AS TotalValue FROM smkb_perolehan_permohonan_dtl WHERE no_mohon = @no_mohon"
        param.Add(New SqlParameter("@no_mohon", noMohon))

        ' Execute the query and retrieve the DataTable
        Dim resultTable As DataTable = db.Read(query, param)

        If resultTable.Rows.Count > 0 Then
            'totalValue = resultTable.Rows(0)("TotalValue")
            If IsDBNull(resultTable.Rows(0)("TotalValue")) = False Then
                totalValue = resultTable.Rows(0)("TotalValue")

            End If
        End If

        Return totalValue
    End Function

    'Update Status dari permohonan ke semakan zon bendahari
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HantarPermohonan(txtNoMohonR As String)

        Dim resp As New ResponseRepository
        Dim response = New Response

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim rekodPermohonan = GetLoadPermohonanPerolehan(Session("ssusrID"), txtNoMohonR)

        If rekodPermohonan.Rows.Count = 0 Then
            resp.Failed("Rekod Permohonan tidak dijumpai.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf UpdateStatusKod(txtNoMohonR) <> "OK" Then
            resp.Failed("Gagal menghantar permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Dim emailSend = EmelStaf(txtNoMohonR)


        'EMEL STAF'

        ''Notification API
        'Dim statNoti = Session("ssusrID")
        'Dim statNoti = "02684"

        '' API endpoint URL
        'Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Sila buat pengesahan bagi permohonan perolehan/x0PjUEkVR819BkYavs8EDYTUbxlqGHHEuwyVrnYDqwGnq0ZeeCn6ZpjqvDAeIqX/" + statNoti

        'Using client As New HttpClient()
        '    Dim content = New FormUrlEncodedContent(New Dictionary(Of String, String)())
        '    Dim response1 As HttpResponseMessage = Await client.PostAsync(apiUrl, content)

        '    If response1.IsSuccessStatusCode Then
        '        'resp.Success("Permohonan perolehan berjaya dihantar.", "00", txtNoMohonR)
        '        'response = resp.GetResult()
        '    Else
        '        resp.Failed("gagal.")
        '    End If
        'End Using


        resp.Success("Permohonan perolehan berjaya dihantar.", "00")
        response = resp.GetResult()

        Return JsonConvert.SerializeObject(response)

    End Function
    ' Email service START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function EmelStaf(orderID As String) As Tasks.Task(Of String)
        Dim clsCrypto As New clsCrypto
        Dim db As New DBKewConn

        Dim resp As New ResponseRepository
        Dim response = New Response

        Dim fullName_Penerima As String = "Muhammad Afiq bin Abd Razak"
        Dim email_Penerima As String = "muhammadfarid@utem.edu.my"
        Dim NoStaff_Penerima = "02684"
        Dim TarikhLuput = "2024-04-29" 'kenalpasti tarikh active

        Dim KodSubMenu = "020102" 'identify kod sub menu skrin sokong/lulus ikut modul msing2
        Dim NoRujukan = orderID

        Dim combineData = NoStaff_Penerima + Now() + NoRujukan
        Dim id = Replace(Replace(Replace(clsCrypto.fEncrypt(combineData), "/", "@"), "+", "@"), "%", "@")

        'mula insert
        Dim paramSqlBtrn() As SqlParameter = Nothing
        Dim strSqlButiran = "INSERT INTO SMKB_Emel_Auth (ID_Token, No_Staf_Penerima, Emel_Penerima, Tarikh_Luput_URL, Kod_Sub_Menu, No_Rujukan)
                                            VALUES (@ID_Token, @No_Staf_Penerima, @Emel_Penerima, @Tarikh_Luput_URL, @Kod_Sub_Menu, @No_Rujukan)"
        paramSqlBtrn = {New SqlParameter("@ID_Token", id),
                                New SqlParameter("@No_Staf_Penerima", NoStaff_Penerima),
                                New SqlParameter("@Emel_Penerima", email_Penerima),
                                New SqlParameter("@Tarikh_Luput_URL", TarikhLuput),
                                New SqlParameter("@Kod_Sub_Menu", KodSubMenu),
                                New SqlParameter("@No_Rujukan", NoRujukan)
                            }

        If db.fInsertCommand(strSqlButiran, paramSqlBtrn) > 0 Then


            Dim url As String = "http://localhost:1559/SMKBNet/loginsmkb.aspx?id=" & id 'ResolveUrl("~/loginsmkb.aspx?id=" & id) 

            'Send the New password to the user's email
            Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
            Dim body As String = "Kelulusan Ketua PTJ " &
                         "<br><br>" &
                         vbCrLf & "Assalamualaikum Dan Salam Sejahtera " & fullName_Penerima & "," &
                         "<br><br>" &
                         vbCrLf & "Memerlukan kelulusan anda untuk permohonan perolehan. " &
                         "<br><br>" &
                         vbCrLf & "Sila klik di link ini untuk menyemak permohonan perolehan untuk kelulusan ketua PTJ melalui <a href=" + url + ">" + url + "</a>" &
                         "<br>" &
                         "<br><br>" &
                         vbCrLf & "Email dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " &
                         "<br><br>" &
                         vbCrLf & "Email ini tidak perlu dibalas."

            myEmel(email_Penerima, subject, body)

            ''Notification API


            ' API endpoint URL
            Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Kelulusan Permohonanan Perolehan .Memerlukan kelulusan anda untuk permohonan perolehan./" + id + "/" + NoStaff_Penerima

            Try

                Using client As New HttpClient()
                    Dim content = New FormUrlEncodedContent(New Dictionary(Of String, String)())
                    Dim response1 As HttpResponseMessage = Await client.PostAsync(apiUrl, content)

                    If response1.IsSuccessStatusCode Then
                        'resp.Success("Permohonan perolehan berjaya dihantar.", "00", txtNoMohonR)
                        'response = resp.GetResult()
                    Else
                        resp.Failed("gagal.")
                    End If
                End Using

            Catch ex As Exception
                Dim msg As String = ex.Message
            End Try

            resp.Success("Notifikasi berjaya dihantar.", "00")
            response = resp.GetResult()



        Else
            db.sConnRollbackTrans()
        End If

        Return JsonConvert.SerializeObject(response)
    End Function

    Public strConEmail As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    Private Function myEmel(alamat, subject, body)
        Dim cnExec As OleDb.OleDbConnection
        Dim cmdExec As OleDb.OleDbCommand

        Try
            cnExec = New OleDb.OleDbConnection(strConEmail)
            cnExec.Open()

            cmdExec = New OleDbCommand("EXEC msdb.dbo.sp_send_dbmail @profile_name= 'EmailSmkb', @recipients= '" & alamat & "', @subject = '" & subject & "', " &
                  "@body= '" & Replace(body, "'", "''") & "', @body_format='HTML';", cnExec)
            cmdExec.ExecuteNonQuery()
            cmdExec.Dispose()
            cmdExec = Nothing
            cnExec.Dispose()
            cnExec.Close()
            cnExec = Nothing

            Return 1    'Proses Berjaya
        Catch ex As Exception
            ' Show the exception's message.
            MsgBox(ex.Message)
            Return 0    'Proses Gagal
        End Try

    End Function
    ' Email service END

    Private Function UpdateStatusKod(txtNoMohonR As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr Set Status_Dok = 28 WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))

        Return db.Process(query, param)
    End Function


    'Update Status dari kelulusan PTJ   
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function ZonLulusPermohonan(txtNoMohonR As String, flagPT As Boolean, txtKodPejabat As String) As String
        Dim resp As New ResponseRepository

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim rekodPermohonan = GetLoadPermohonanPerolehan(Session("ssusrID"), txtNoMohonR)

        If rekodPermohonan.Rows.Count = 0 Then
            resp.Failed("Rekod Permohonan tidak dijumpai.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf UpdateStatusZon(txtNoMohonR, flagPT) <> "OK" Then
            resp.Failed("Gagal menghantar kelulusan permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Permohonan perolehan berjaya diluluskan.", "00", txtNoMohonR)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateStatusZon(txtNoMohonR As String, flagPT As Boolean)
        Dim db As New DBKewConn
        Dim flagPTValue As String = If(flagPT, "1", "0")

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr Set Status_Dok = '06', Flag_PT = @flagPT WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))
        param.Add(New SqlParameter("@flagPT", flagPTValue))

        Return db.Process(query, param)
    End Function

    'Update kemaskini dari Semakan Zon Bendahari
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function ZonKemaskiniPermohonan(txtNoMohonR As String, Ulasan As String, NoStaff As String) As String
        Dim resp As New ResponseRepository

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim rekodPermohonan = GetLoadPermohonanPerolehan(Session("ssusrID"), txtNoMohonR)

        If rekodPermohonan.Rows.Count = 0 Then
            resp.Failed("Rekod Permohonan tidak dijumpai.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf UpdateKemaskiniZon(txtNoMohonR) <> "OK" Then
            resp.Failed("Gagal menghantar ulasan.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf InsertUlasan(txtNoMohonR, Ulasan, NoStaff) <> "OK" Then
            resp.Failed("Gagal menghantar ulasan.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        resp.Success("Ulasan berjaya disimpan pangkalan data.", "00", txtNoMohonR)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateKemaskiniZon(txtNoMohonR As String)
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '04' WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))

        Return db.Process(query, param)
    End Function

    Private Function InsertUlasan(txtNoMohonR As String, Ulasan As String, NoStaff As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Status_Transaksi, Status,Ulasan)
                              VALUES('02','04',@NoMohon,@No_Staf,'1','1',@Ulasan)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@NoMohon", txtNoMohonR))
        param.Add(New SqlParameter("@No_Staf", NoStaff))
        param.Add(New SqlParameter("@Ulasan", Ulasan))

        Return db.Process(query, param)
    End Function

    'Update Status dari kelulusan PTJ hahaha
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PtjLulusPermohonan(txtNoMohonR As String, flagPT As Boolean, txtKodPejabat As String) As String
        Dim resp As New ResponseRepository
        Dim db = New DBKewConn

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim newNoPO As String = GenerateNoPoPL(txtNoMohonR, txtKodPejabat)

        If UpdateStatusPTJ(txtNoMohonR, newNoPO, flagPT) <> "OK" Then
            resp.Failed("Gagal menghantar kelulusan permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        'Dim emailSend = EmelBendahari(txtNoMohonR)

        Dim param As New List(Of SqlParameter)()

        Dim query As String = "SELECT SUM(A.Jumlah_Harga) AS TotalValue, COUNT(B.No_Perolehan) AS TotalCount 
                              FROM smkb_perolehan_permohonan_dtl A 
                              INNER JOIN SMKB_Perolehan_Permohonan_Hdr B ON A.No_Mohon = B.No_Mohon 
                              WHERE A.no_mohon = @no_mohon"

        param.Add(New SqlParameter("@no_mohon", txtNoMohonR))

        Dim resultTable As DataTable = db.Read(query, param)

        If resultTable.Rows.Count > 0 Then
            If Not IsDBNull(resultTable.Rows(0)("TotalValue")) Then
                Dim totalValue As Double = Convert.ToDouble(resultTable.Rows(0)("TotalValue"))

                If totalValue > 49999 Then
                    Dim emailSend = EmelBendahari(txtNoMohonR)
                End If

            End If
        End If



        resp.Success("Permohonan perolehan berjaya diluluskan.", "00", txtNoMohonR)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    ' Email service START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function EmelBendahari(orderID As String) As Tasks.Task(Of String)
        Dim clsCrypto As New clsCrypto
        Dim db As New DBKewConn

        Dim resp As New ResponseRepository
        Dim response = New Response

        Dim fullName_Penerima As String = "Muhammad Afiq bin Abd Razak"
        Dim email_Penerima As String = "muhammadfarid@utem.edu.my"
        Dim NoStaff_Penerima = "02684"
        Dim TarikhLuput = "2024-04-29" 'kenalpasti tarikh active

        Dim KodSubMenu = "020104" 'identify kod sub menu skrin sokong/lulus ikut modul msing2
        Dim NoRujukan = orderID

        Dim combineData = NoStaff_Penerima + Now() + NoRujukan
        Dim id = Replace(Replace(Replace(clsCrypto.fEncrypt(combineData), "/", "@"), "+", "@"), "%", "@")

        'mula insert
        Dim paramSqlBtrn() As SqlParameter = Nothing
        Dim strSqlButiran = "INSERT INTO SMKB_Emel_Auth (ID_Token, No_Staf_Penerima, Emel_Penerima, Tarikh_Luput_URL, Kod_Sub_Menu, No_Rujukan)
                                          VALUES (@ID_Token, @No_Staf_Penerima, @Emel_Penerima, @Tarikh_Luput_URL, @Kod_Sub_Menu, @No_Rujukan)"
        paramSqlBtrn = {New SqlParameter("@ID_Token", id),
                              New SqlParameter("@No_Staf_Penerima", NoStaff_Penerima),
                              New SqlParameter("@Emel_Penerima", email_Penerima),
                              New SqlParameter("@Tarikh_Luput_URL", TarikhLuput),
                              New SqlParameter("@Kod_Sub_Menu", KodSubMenu),
                              New SqlParameter("@No_Rujukan", NoRujukan)
                          }

        If db.fInsertCommand(strSqlButiran, paramSqlBtrn) > 0 Then


            Dim url As String = "http://localhost:1559/SMKBNet/loginsmkb.aspx?id=" & id 'ResolveUrl("~/loginsmkb.aspx?id=" & id) 

            'Send the New password to the user's email
            Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
            Dim body As String = "Kelulusan Bendahari (Modul Perolehan) " &
                       "<br><br>" &
                       vbCrLf & "Assalamualaikum Dan Salam Sejahtera " & fullName_Penerima & "," &
                       "<br><br>" &
                       vbCrLf & "Memerlukan kelulusan anda untuk permohonan perolehan. " &
                       "<br><br>" &
                       vbCrLf & "Sila klik di link ini untuk menyemak permohonan perolehan untuk kelulusan Bendahari melalui <a href=" + url + ">" + url + "</a>" &
                       "<br>" &
                       "<br><br>" &
                       vbCrLf & "Email dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " &
                       "<br><br>" &
                       vbCrLf & "Email ini tidak perlu dibalas."

            myEmel(email_Penerima, subject, body)

            ''Notification API


            ' API endpoint URL
            Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Kelulusan Permohonan Perolehan. Memerlukan kelulusan anda untuk permohonan perolehan./" + id + "/" + NoStaff_Penerima
            Try

                Using client As New HttpClient()
                    Dim content = New FormUrlEncodedContent(New Dictionary(Of String, String)())
                    Dim response1 As HttpResponseMessage = Await client.PostAsync(apiUrl, content)

                    If response1.IsSuccessStatusCode Then
                        'resp.Success("Permohonan perolehan berjaya dihantar.", "00", txtNoMohonR)
                        'response = resp.GetResult()
                    Else
                        resp.Failed("gagal.")
                    End If
                End Using

            Catch ex As Exception
                Dim msg As String = ex.Message
            End Try

            resp.Success("Notifikasi berjaya dihantar.", "00")
            response = resp.GetResult()



        Else
            db.sConnRollbackTrans()
        End If

        Return JsonConvert.SerializeObject(response)
    End Function

    Private Function UpdateStatusPTJ(txtNoMohonR As String, ByVal newNoPO As String, flagPT As Boolean)

        Dim db As New DBKewConn

        Dim fullDate As String = Date.Now.ToString("yyyy-MM-dd")
        Dim flagPTValue As String = If(flagPT, "1", "0")

        Dim checkExist As Integer

        Dim query1 As String = "Select count(no_perolehan) As CheckExist from SMKB_PEROLEHAN_PERMOHONAN_HDR where no_mohon= @nomohon"
        Dim param1 As New List(Of SqlParameter)

        param1.Add(New SqlParameter("@nomohon", txtNoMohonR))
        Dim resultTable As DataTable = db.Read(query1, param1)


        If resultTable.Rows.Count > 0 Then
            If Not IsDBNull(resultTable.Rows(0)("CheckExist")) Then
                checkExist = Convert.ToInt32(resultTable.Rows(0)("CheckExist"))
            End If
        End If

        If checkExist = 0 Then

            Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '08' , No_Perolehan = ISNULL(@noperolehan, No_Perolehan) , Flag_PT = @flagPT , Id_Pelulus=@Id_Pelulus,Tarikh_Lulus=@Tarikh_Lulus WHERE No_Mohon = @txtNoMohon"
            Dim param As New List(Of SqlParameter)

            If String.IsNullOrEmpty(newNoPO) Then
                param.Add(New SqlParameter("@noperolehan", DBNull.Value))
            Else
                param.Add(New SqlParameter("@noperolehan", newNoPO))
            End If

            param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))
            param.Add(New SqlParameter("@flagPT", flagPTValue))
            param.Add(New SqlParameter("@Id_Pelulus", Session("ssusrID")))
            param.Add(New SqlParameter("@Tarikh_Lulus", fullDate))

            Return db.Process(query, param)

        Else

            Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '08', No_Perolehan = ISNULL(@noperolehan, No_Perolehan) , Flag_PT = @flagPT WHERE No_Mohon = @txtNoMohon"
            Dim param As New List(Of SqlParameter)

            If String.IsNullOrEmpty(newNoPO) Then
                param.Add(New SqlParameter("@noperolehan", DBNull.Value))
            Else
                param.Add(New SqlParameter("@noperolehan", newNoPO))
            End If

            param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))
            param.Add(New SqlParameter("@flagPT", flagPTValue))

            Return db.Process(query, param)


        End If

    End Function

    'Generate Nombor Perolehan Berdasarkan Jumlah
    Private Function GenerateNoPoPL(txtNoMohonR As String, txtKodPejabat As String)
        Dim db = New DBKewConn

        Dim ptjBekal As String = txtKodPejabat.PadRight(6, "0"c)

        Dim totalValue As Double = 0.00
        Dim totalCount As Integer
        Dim param As New List(Of SqlParameter)()
        Dim query As String = "SELECT SUM(A.Jumlah_Harga) AS TotalValue,COUNT(B.No_Perolehan) AS TotalCount
                               FROM smkb_perolehan_permohonan_dtl A
                               INNER JOIN SMKB_Perolehan_Permohonan_Hdr B ON A.No_Mohon = B.No_Mohon
                               WHERE A.no_mohon = @no_mohon"

        param.Add(New SqlParameter("@no_mohon", txtNoMohonR))

        Dim resultTable As DataTable = db.Read(query, param)

        If resultTable.Rows.Count > 0 Then
            If Not IsDBNull(resultTable.Rows(0)("TotalValue")) Then
                totalValue = Convert.ToDouble(resultTable.Rows(0)("TotalValue"))
            End If
            If Not IsDBNull(resultTable.Rows(0)("TotalCount")) Then
                totalCount = Convert.ToInt32(resultTable.Rows(0)("TotalCount"))
            End If
        End If
        Dim newNoPO As String = ""

        If totalValue <= 49999 And totalCount = 0 Then

            Dim year = Date.Now.ToString("yyyy")
            Dim month = Date.Now.Month

            Dim lastID As Integer = 1

            Dim ptj = txtKodPejabat

            Dim prefix As String = ""
            If totalValue < 1000 Then
                prefix = "PB"
            ElseIf totalValue >= 1000 AndAlso totalValue <= 49999 Then
                prefix = "PL"
            End If

            Dim param2 As New List(Of SqlParameter)()
            Dim query2 As String = $"SELECT TOP 1 No_Akhir AS id FROM SMKB_No_Akhir WHERE Kod_Modul ='02' AND Prefix = @prefix AND Tahun = @year AND Kod_PTJ=@Kod_PTJ"
            param2.Add(New SqlParameter("@year", year))
            param2.Add(New SqlParameter("@prefix", prefix))
            param2.Add(New SqlParameter("@Kod_PTJ", ptjBekal))


            Dim noAkhirTable As DataTable = db.Read(query2, param2)

            If noAkhirTable.Rows.Count > 0 Then
                lastID = CInt(noAkhirTable.Rows(0).Item("id")) + 1
                UpdateNoAkhirBendahari("02", prefix, year, lastID, ptjBekal)
            Else
                InsertNoAkhirBendahari("02", prefix, year, lastID, ptjBekal)
            End If

            newNoPO = prefix + ptjBekal.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)
            Return newNoPO

        Else
            Return Nothing

        End If

    End Function

    'Update kemaskini dari Kelulusan PTJ
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function KemaskiniPTJ(txtNoMohonR As String, Ulasan As String, NoStaff As String) As String
        Dim resp As New ResponseRepository

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim rekodPermohonan = GetLoadPermohonanPerolehan(Session("ssusrID"), txtNoMohonR)

        If rekodPermohonan.Rows.Count = 0 Then
            resp.Failed("Rekod Permohonan tidak dijumpai.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf UpdateKemaskiniPTJ(txtNoMohonR) <> "OK" Then
            resp.Failed("Gagal menghantar ulasan.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf InsertUlasanPTJ(txtNoMohonR, Ulasan, NoStaff) <> "OK" Then
            resp.Failed("Gagal menghantar ulasan.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        resp.Success("Ulasan berjaya disimpan di pangkalan data.", "00", txtNoMohonR)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateKemaskiniPTJ(txtNoMohonR As String)
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '04' WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))

        Return db.Process(query, param)
    End Function

    Private Function InsertUlasanPTJ(txtNoMohonR As String, Ulasan As String, NoStaff As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Status_Transaksi, Status,Ulasan)
                              VALUES('02','04',@NoMohon,@No_Staf,'1','1',@Ulasan)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@NoMohon", txtNoMohonR))
        param.Add(New SqlParameter("@No_Staf", NoStaff))
        param.Add(New SqlParameter("@Ulasan", Ulasan))

        Return db.Process(query, param)
    End Function

    'Update Status dari kelulusan  bendahari  hahaha
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function BendahariLulusPermohonan(txtNoMohonR As String, txtKodPejabat As String) As String
        Dim resp As New ResponseRepository

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim newNoPO As String = GenerateNoPoZon(txtNoMohonR, txtKodPejabat)

        If newNoPO Is Nothing Then
            Return Nothing
        End If

        If UpdateStatusBendahari(txtNoMohonR, newNoPO) <> "OK" Then
            resp.Failed("Gagal mengemaskini status permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Permohonan perolehan berjaya diluluskan.", "00", txtNoMohonR)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function UpdateStatusBendahari(txtNoMohonR As String, newNoPO As String)
        Dim db As New DBKewConn
        Dim fullDate As String = Date.Now.ToString("yyyy-MM-dd")
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '07' , No_Perolehan = @noperolehan , Flag_PenentuanTeknikal=1, Id_Penyemak=@Id_Penyemak,Tarikh_Semak=@Tarikh_Semak WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))
        param.Add(New SqlParameter("@noperolehan", newNoPO))
        param.Add(New SqlParameter("@Id_Penyemak", Session("ssusrID")))
        param.Add(New SqlParameter("@Tarikh_Semak", fullDate))

        Return db.Process(query, param)
    End Function

    'Generate Nombor Perolehan Berdasarkan Jumlah
    Private Function GenerateNoPoZon(txtNoMohonR As String, txtKodPejabat As String)
        Dim db = New DBKewConn
        Dim ptjBekal As String = txtKodPejabat.PadRight(6, "0"c)

        Dim totalValue As Double = 0.00
        Dim param As New List(Of SqlParameter)()
        Dim query As String = "SELECT SUM(Jumlah_Harga) AS TotalValue FROM smkb_perolehan_permohonan_dtl WHERE no_mohon = @no_mohon"
        param.Add(New SqlParameter("@no_mohon", txtNoMohonR))

        Dim resultTable As DataTable = db.Read(query, param)

        If resultTable.Rows.Count > 0 Then
            If Not IsDBNull(resultTable.Rows(0)("TotalValue")) Then
                totalValue = Convert.ToDouble(resultTable.Rows(0)("TotalValue"))
            End If
        End If

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoPO As String = ""
        Dim ptj = txtKodPejabat

        Dim prefix As String = ""

        If totalValue < 19999 Then
            'prefix = "PL"
            Return Nothing
        ElseIf totalValue >= 20000 AndAlso totalValue < 49999 Then
            'prefix = "PS"
            Return Nothing
        ElseIf totalValue >= 50000 AndAlso totalValue < 499999 Then
            prefix = "DS"
        ElseIf totalValue >= 500000 Then
            prefix = "DT"

        End If

        Dim param2 As New List(Of SqlParameter)()
        Dim query2 As String = $"SELECT TOP 1 No_Akhir AS id FROM SMKB_No_Akhir WHERE Kod_Modul ='02' AND Prefix = @prefix AND Tahun = @year And Kod_PTJ=@Kod_PTJ"
        param2.Add(New SqlParameter("@year", year))
        param2.Add(New SqlParameter("@prefix", prefix))
        param2.Add(New SqlParameter("@Kod_PTJ", ptjBekal))

        Dim noAkhirTable As DataTable = db.Read(query2, param2)

        If noAkhirTable.Rows.Count > 0 Then
            lastID = CInt(noAkhirTable.Rows(0).Item("id")) + 1
            UpdateNoAkhirBendahari("02", prefix, year, lastID, ptjBekal)
        Else
            InsertNoAkhirBendahari("02", prefix, year, lastID, ptjBekal)
        End If

        newNoPO = prefix + ptjBekal.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoPO
    End Function

    'Generate Nombor Perolehan Berdasarkan Jumlah
    Private Function GenerateNoPoZon1(txtNoMohonR As String, txtKodPejabat As String)
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoPO As String = ""
        Dim ptj = txtKodPejabat

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='PB' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
            UpdateNoAkhir("02", "PB", year, lastID, txtKodPejabat)

        Else
            InsertNoAkhir("02", "PB", year, lastID, txtKodPejabat)
        End If

        newNoPO = "PB" + ptj.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoPO
    End Function

    'Update kemaskini dari Semakan Bendahari
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function BendahariKemaskiniPermohonan(txtNoMohonR As String, Ulasan As String, NoStaff As String) As String
        Dim resp As New ResponseRepository

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim rekodPermohonan = GetLoadPermohonanPerolehan(Session("ssusrID"), txtNoMohonR)

        If rekodPermohonan.Rows.Count = 0 Then
            resp.Failed("Rekod Permohonan tidak dijumpai.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf UpdateKemaskiniBendahari(txtNoMohonR) <> "OK" Then
            resp.Failed("Gagal menghantar ulasan.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf InsertUlasanBendahari(txtNoMohonR, Ulasan, NoStaff) <> "OK" Then
            resp.Failed("Gagal menghantar ulasan.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        resp.Success("Ulasan berjaya disimpan pangkalan data.", "00", txtNoMohonR)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateKemaskiniBendahari(txtNoMohonR As String)
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '04' WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))

        Return db.Process(query, param)
    End Function

    Private Function InsertUlasanBendahari(txtNoMohonR As String, Ulasan As String, NoStaff As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Status_Transaksi, Status,Ulasan)
                              VALUES('02','04',@NoMohon,@No_Staf,'1','1',@Ulasan)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@NoMohon", txtNoMohonR))
        param.Add(New SqlParameter("@No_Staf", NoStaff))
        param.Add(New SqlParameter("@Ulasan", Ulasan))

        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSpekAmReport(id As String) As String

        Dim db As New DBKewConn

        'Dim query As String = "Select * from SMKB_Perolehan_Spesifikasi_Am
        '                       where no_mohon = @no_mohon"

        Dim query As String = "
            With cte as (
	            SELECT CONVERT(varchar, Row_Number() OVER(Order by Kod ASC))  as Bil, 
	            1 as Level, Kod, Butiran
	            FROM SMKB_Perolehan_Spesifikasi mainA
	            WHERE Kod IN (
		            SELECT Kod_spesifikasi 
		            FROM SMKB_Perolehan_Spesifikasi_Am 
		            WHERE no_mohon = @no_mohon
	            )
            ) 
            SELECT CASE WHEN Level = 1 THEN '1.' + Bil ELSE BIL END as Bil,
            Kod, Butiran, Level
            FROM (
	            SELECT * 
	            FROM cte
	            UNION ALL
	            Select CONCAT(CONCAT(CONCAT('1.', cte.Bil), '.'), (ROW_NUMBER() OVER(PARTITION BY Kod_Spesifikasi ORDER BY Kod_Spesifikasi))), 
	            2 as Level, Kod_Spesifikasi, mainB.Butiran
	            from SMKB_Perolehan_Spesifikasi_Am mainB
	            INNER JOIN cte 
		            ON mainB.Kod_Spesifikasi = cte.Kod
	            WHERE no_mohon = @no_mohon
            ) mainTbl
            ORDER BY Kod, Level"


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@no_mohon", id))
        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSpekAmLVL(id As String) As String

        Dim db As New DBKewConn
        Dim test As String = Session("ssusrID")
        'Dim query As String = "Select * from SMKB_Perolehan_Spesifikasi_Am
        '                       where no_mohon = @no_mohon"

        Dim query As String = "
            With cte as (
	            SELECT CONVERT(varchar, Row_Number() OVER(Order by Kod ASC))  as Bil, 
	            1 as Level, Kod, Butiran
	            FROM SMKB_Perolehan_Spesifikasi mainA
	            WHERE Kod IN (
		            SELECT Kod_spesifikasi 
		            FROM SMKB_Perolehan_Spesifikasi_Am 
		            WHERE no_mohon = @no_mohon
	            )
            ) 
            SELECT CASE WHEN Level = 1 THEN '1.' + Bil ELSE BIL END as Bil,
            Kod, Butiran, Level
            FROM (
	            SELECT * 
	            FROM cte
	            UNION ALL
	            Select CONCAT(CONCAT(CONCAT('1.', cte.Bil), '.'), (ROW_NUMBER() OVER(PARTITION BY Kod_Spesifikasi ORDER BY Kod_Spesifikasi))), 
	            2 as Level, Kod_Spesifikasi, mainB.Butiran
	            from SMKB_Perolehan_Spesifikasi_Am mainB
	            INNER JOIN cte 
		            ON mainB.Kod_Spesifikasi = cte.Kod
	            WHERE no_mohon = @no_mohon
            ) mainTbl
            ORDER BY Kod, Level"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@no_mohon", id))
        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSpekTeknikalReport(id As String) As String

        Dim db As New DBKewConn


        Dim query As String = "
                With cte as (
	            SELECT CONVERT(varchar, Row_Number() OVER(Order by Id_Mohon_Dtl ASC))  as Bil, 
	            1 as Level, mainA.Id_Mohon_Dtl, mainA.Butiran
	            FROM SMKB_Perolehan_Permohonan_Dtl mainA
	            WHERE mainA.Id_Mohon_Dtl IN (
		            SELECT Id_Mohon_Dtl
		            FROM SMKB_Perolehan_Spesifikasi_Teknikal 
		            WHERE no_mohon = @no_mohon
	                       )
                ) 
                SELECT CASE WHEN Level = 1 THEN '2.' + Bil ELSE BIL END as Bil,
                Id_Mohon_Dtl, Butiran, Level
                FROM (
	                SELECT * 
	                FROM cte
	                UNION ALL
	                Select CONCAT(CONCAT(CONCAT('2.', cte.Bil), '.'), (ROW_NUMBER() OVER(PARTITION BY mainB.Id_Mohon_Dtl ORDER BY mainB.Id_Mohon_Dtl))), 
	                2 as Level, mainb.Id_Mohon_Dtl, mainB.Butiran
	                from SMKB_Perolehan_Spesifikasi_Teknikal mainB
	                INNER JOIN cte 
		                ON mainB.Id_Mohon_Dtl = cte.Id_Mohon_Dtl
	                WHERE no_mohon = @no_mohon
                ) mainTbl
                ORDER BY Id_Mohon_Dtl, Level"


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@no_mohon", id))
        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSpekTeknikalLVL(id As String) As String

        Dim db As New DBKewConn


        Dim query As String = "
                With cte as (
	            SELECT CONVERT(varchar, Row_Number() OVER(Order by Id_Mohon_Dtl ASC))  as Bil, 
	            1 as Level, mainA.Id_Mohon_Dtl, mainA.Butiran
	            FROM SMKB_Perolehan_Permohonan_Dtl mainA
	            WHERE mainA.Id_Mohon_Dtl IN (
		            SELECT Id_Mohon_Dtl
		            FROM SMKB_Perolehan_Spesifikasi_Teknikal 
		            WHERE no_mohon = @no_mohon
	                       )
                ) 
                SELECT CASE WHEN Level = 1 THEN '2.' + Bil ELSE BIL END as Bil,
                Id_Mohon_Dtl, Butiran, Level
                FROM (
	                SELECT * 
	                FROM cte
	                UNION ALL
	                Select CONCAT(CONCAT(CONCAT('2.', cte.Bil), '.'), (ROW_NUMBER() OVER(PARTITION BY mainB.Id_Mohon_Dtl ORDER BY mainB.Id_Mohon_Dtl))), 
	                2 as Level, mainb.Id_Mohon_Dtl, mainB.Butiran
	                from SMKB_Perolehan_Spesifikasi_Teknikal mainB
	                INNER JOIN cte 
		                ON mainB.Id_Mohon_Dtl = cte.Id_Mohon_Dtl
	                WHERE no_mohon = @no_mohon
                ) mainTbl
                where level = '2'
                ORDER BY Id_Mohon_Dtl, Level"


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@no_mohon", id))
        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SetNoMohon(IdMohon As String)
        Session("no_mohon_spek") = IdMohon
        Return True
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fGetBakiSebenar(ByVal year As Integer, ByVal tarikh As String, ByVal kw As String, ByVal ko As String, ByVal ptj As String, ByVal kp As String, ByVal vot As String) As Decimal
        Dim dbconn As New DBKewConn
        Dim bakiSebenar As Decimal = 0.00
        Try
            Dim param1 As SqlParameter = New SqlParameter("@arg_tahun", SqlDbType.Int)
            param1.Value = year
            param1.Direction = ParameterDirection.Input
            param1.IsNullable = False

            Dim param2 As SqlParameter = New SqlParameter("@arg_tarikh", SqlDbType.VarChar)
            param2.Value = tarikh
            param2.Direction = ParameterDirection.Input
            param2.IsNullable = False

            Dim param3 As SqlParameter = New SqlParameter("@arg_kw", SqlDbType.VarChar)
            param3.Value = kw
            param3.Direction = ParameterDirection.Input
            param3.IsNullable = False

            Dim param4 As SqlParameter = New SqlParameter("@arg_Operasi", SqlDbType.VarChar)
            param4.Value = ko
            param4.Direction = ParameterDirection.Input
            param4.IsNullable = False

            Dim param5 As SqlParameter = New SqlParameter("@arg_projek", SqlDbType.VarChar)
            param5.Value = kp
            param5.Direction = ParameterDirection.Input
            param5.IsNullable = False

            Dim param6 As SqlParameter = New SqlParameter("@arg_jbt", SqlDbType.VarChar)
            param6.Value = ptj
            param6.Direction = ParameterDirection.Input
            param6.IsNullable = True

            Dim param7 As SqlParameter = New SqlParameter("@arg_vot", SqlDbType.VarChar)
            param7.Value = Left(vot, 2) + "000"
            param7.Direction = ParameterDirection.Input
            param7.IsNullable = False

            Dim param8 As SqlParameter = New SqlParameter("@l_bakisbnr", SqlDbType.Decimal)
            param8.Value = bakiSebenar
            param8.Direction = ParameterDirection.Output
            param8.IsNullable = False

            Dim paramSql() As SqlParameter = {param1, param2, param3, param4, param5, param6, param7, param8}

            Dim l_bakisbnr = dbconn.fExecuteSP("USP_BAKISBNR_BAJET", paramSql, param8, bakiSebenar)

            Return JsonConvert.SerializeObject(bakiSebenar)
        Catch ex As Exception

        End Try
    End Function



    'afiq start

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Jawatan_Kuasa(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKod_Jawatan_kuasa(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetKod_Jawatan_kuasa(Kod_Jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
                    SELECT Kod_Jawatankuasa as kodValue, CONCAT(Kod_Jawatankuasa, ' - ', Butiran) as text
                    FROM SMKB_Perolehan_Jawatankuasa 
					WHERE Kod_Jawatankuasa like '%JI%' or  Kod_Jawatankuasa like '%JT%'
                    ORDER BY Kod_Jawatankuasa 


                    "
        Dim param As New List(Of SqlParameter)

        If Kod_Jawatankuasa <> "" Then
            query &= " AND (Kod_Jawatankuasa LIKE '%' + @Kod_Jawatankuasa + '%') "
            param.Add(New SqlParameter("@Kod_Jawatankuasa", Kod_Jawatankuasa))
        End If

        Return db.Read(query, param)
    End Function


    ' Perolehan_MesyPTeknikal START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_MesyPTeknikal(tahunSemasa As String) As String
        Dim resp As New ResponseRepository


        dt = GetOrder_Perolehan_MesyPTeknikal(tahunSemasa)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Perolehan_MesyPTeknikal(tahunSemasa As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "

                    SELECT A.IDMesy, A.Tempat, A.TarikhDaftar  
                    FROM SMKB_Perolehan_Mesyuarat_HDR A
                    INNER JOIN SMKB_Perolehan_Mesyuarat_Dtl B ON A.IDMesy = B.ID_Mesy
                    WHERE YEAR(a.TarikhDaftar)  = @tahunSemasa  AND B.Status_Dok = '33'
                    GROUP BY A.IDMesy, A.Tempat, A.TarikhDaftar
                    ORDER BY A.IDMesy DESC
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@tahunSemasa", tahunSemasa))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'Perolehan_MesyPTeknikal END


    ' SMKB_Perolehan_JawatankuasaDT START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_JawatankuasaDT(KodJawatanKuas As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Perolehan_JawatankuasaDT(KodJawatanKuas)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Perolehan_JawatankuasaDT(KodJawatanKuas As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                    SELECT * 
                    FROM SMKB_Perolehan_JawatankuasaDT a
                    INNER JOIN VPeribadi b ON a.No_Staf = b.MS01_NoStaf
                    where a.Kod_JawatanKuasa  = @KodJawatanKuas
                    ORDER BY 
                    CASE
                       WHEN a.jawatan = 'PENGERUSI' THEN 1
                       WHEN a.jawatan = 'SETIAUSAHA' THEN 2
                       WHEN a.jawatan = 'AHLI' THEN 3
                    END
            "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@KodJawatanKuas", KodJawatanKuas))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'SMKB_Perolehan_JawatankuasaDT END




    ' SMKB_Perolehan_MesyuaratDt START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_MesyuaratDt(IDMesy As String) As String
        Dim resp As New ResponseRepository

        If IDMesy = "" Then
            IDMesy = Session("IDMesy")
        Else
            Session("IDMesy") = IDMesy
        End If

        If IDMesy = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_Perolehan_MesyuaratDt(IDMesy)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Perolehan_MesyuaratDt(IDMesy As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "

                    SELECT * 
                    FROM SMKB_Perolehan_Mesyuarat_Dtl a
                    INNER JOIN SMKB_Perolehan_Mesyuarat_Hdr b ON a.ID_Mesy = b.IDMesy
                    INNER JOIN SMKB_Perolehan_Permohonan_Hdr c ON a.No_Mohon = c.No_Mohon
                    where a.ID_Mesy  = @IDMesy
                    and a.Status_Dok = '33'
                    order by a.turutan asc


                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IDMesy", IDMesy))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'SMKB_Perolehan_MesyuaratDt END


    ' Maklumat_Permohonan_Perolehan START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMaklumat_Permohonan_Perolehan(IdAm As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Maklumat_Permohonan_Perolehan(IdAm)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Maklumat_Permohonan_Perolehan(IdAm As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                    SELECT a.No_Perolehan,a.No_Mohon, FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,                    
                    a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu,  a.Perolehan_Terdahulu,a.Justifikasi, 
                    kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    StatusPO.Butiran As ButiranKodDok,
					SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP,a.Skop
                    FROM SMKB_Perolehan_Permohonan_Hdr AS a
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                    INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
                    INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
                    WHERE a.No_Mohon = @IdAm
                    AND StatusPO.Kod_Modul='02' 
                    ORDER BY a.No_Mohon

                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdAm", IdAm))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'Maklumat_Permohonan_Perolehan END


    ' SMKB_Perolehan_Permohonan_Dtl START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Permohonan_Dtl(NoMohon As String) As String
        Dim resp As New ResponseRepository

        If NoMohon = "" Then
            NoMohon = Session("NoMohon")
        Else
            Session("NoMohon") = NoMohon
        End If

        If NoMohon = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If


        dt = GetOrder_Perolehan_Permohonan_Dtl(NoMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Perolehan_Permohonan_Dtl(NoMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            query = "

            SELECT Id_Mohon_Dtl, Kod_Kump_Wang, Kod_Operasi, Kod_Ptj, Kod_Projek, Kod_Vot, FORMAT(Baki_Peruntukan, '0.00') as Baki_Peruntukan, Butiran,
            Kuantiti, Ukuran, FORMAT(Kadar_Harga,'0.00') AS Kadar_Harga, FORMAT(Jumlah_Harga,'0.00') AS Jumlah_Harga 
            FROM SMKB_Perolehan_Permohonan_Dtl 
            WHERE No_Mohon = @NoMohon

                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@NoMohon", NoMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'SMKB_Perolehan_Permohonan_Dtl END


    ' Senarai_Sebut_Harga START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_Sebut_Harga(IdMohon As String) As String
        Dim resp As New ResponseRepository


        dt = GetOrder_Senarai_Sebut_Harga(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Senarai_Sebut_Harga(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                       
                        SELECT * 
                        FROM SMKB_Perolehan_Permohonan_Hdr 
                        WHERE ( (Status_Dok = '07' AND Flag_PenentuanTeknikal = '1') 
                        OR (Status_Dok = '08' AND Flag_PenentuanTeknikal = '1') )
                        AND No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where Status_Dok = '33')
                        AND (No_Perolehan LIKE ('DS%') OR No_Perolehan LIKE ('DT%'))
                        ORDER BY No_Mohon

                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'Senarai_Sebut_Harga END


    ' SMKB_Perolehan_Naskah_Jualan SART

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadNaskah_Jualan(category_filter As String, isClick As Boolean) As String
        Dim resp As New ResponseRepository

        If (isClick = False) Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        If (category_filter = "") Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_Naskah_Jualan(category_filter)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Naskah_Jualan(category_filter As String) As DataTable
        Dim db = New DBKewConn
        Dim kod_status As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'KESELURUHAN
            kod_status = " "
        ElseIf category_filter = "2" Then ' LULUS PERMOHONAN PEMBELIAN
            kod_status = " AND  B.status_dok = '08' "
        ElseIf category_filter = "3" Then ' DFTAR JUALAN NASKAH
            kod_status = " AND  B.status_dok = '34' "
        ElseIf category_filter = "4" Then 'PROSES JUALN NASKAH
            kod_status = " AND  B.status_dok = '35' "
        ElseIf category_filter = "5" Then 'TERIMAAN DOKUMENN
            kod_status = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'BATAL JUALAN NASKAH
            kod_status = " AND  B.status_dok = '36' "

            param = New List(Of SqlParameter)
        End If

        'Dim query = "
        '             SELECT FORMAT(SUM(A.Jumlah_Harga),'0.00') AS tot_Jumlah_Harga, CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB, 
        '            (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = B.status_dok) AS status_dok_butiran,
        '            B.No_Mohon, B.Tujuan, B.Jenis_Barang, B.Status_Dok, B.Flag_PenentuanTeknikal, B.No_Perolehan,
        '            C.Id_Jualan, C.Tarikh_Masa_Mula_Iklan,C.Tarikh_Masa_Tamat_Perolehan,C.Status_Lanjut
        '            FROM SMKB_Perolehan_Permohonan_Hdr as B
        '            LEFT JOIN  SMKB_Perolehan_Permohonan_Dtl as A ON A.No_Mohon = B.No_Mohon
        '            INNER JOIN SMKB_Lookup_Detail AS kategori ON B.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
        '            LEFT JOIN  SMKB_Perolehan_Naskah_Jualan AS C ON B.No_Mohon = C.No_Mohon
        '            where ( (B.Status_Dok IN ('07') AND B.Flag_PenentuanTeknikal IN ('0')) OR (B.Status_Dok IN ('08') AND B.Flag_PenentuanTeknikal IN ('0')) or (B.Status_Dok IN ('31') AND B.Flag_PenentuanTeknikal IN ('1'))
        '            or (B.Status_Dok IN ('34') AND B.Flag_PenentuanTeknikal IN ('1')) or (B.Status_Dok IN ('35') AND B.Flag_PenentuanTeknikal IN ('1')) ) 
        '            AND ( B.No_Perolehan LIKE ('DS%') OR B.No_Perolehan LIKE ('DT%') )
        '            AND C.Id_Jualan not in (select Id_Jualan from SMKB_Perolehan_Pembelian_Hdr where Status_Dok = '35')
        '            " & kod_status & "
        '            group by B.No_Mohon, B.Tujuan, B.Jenis_Barang, B.Status_Dok,B.Flag_PenentuanTeknikal,B.No_Perolehan, kategori.Kod_Detail, kategori.Butiran, 
        '            C.Id_Jualan, C.Tarikh_Masa_Mula_Iklan,C.Tarikh_Masa_Tamat_Perolehan,C.Status_Lanjut

        ' "

        Dim query = "
                     SELECT FORMAT(SUM(A.Jumlah_Harga),'0.00') AS tot_Jumlah_Harga, CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB, 
                    (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = B.status_dok) AS status_dok_butiran,
                    B.No_Mohon, B.Tujuan, B.Jenis_Barang, B.Status_Dok, B.Flag_PenentuanTeknikal, B.No_Perolehan,
                    C.Id_Jualan, C.Tarikh_Masa_Mula_Iklan,C.Tarikh_Masa_Tamat_Perolehan,C.Status_Lanjut
                    FROM SMKB_Perolehan_Permohonan_Hdr as B
                    LEFT JOIN  SMKB_Perolehan_Permohonan_Dtl as A ON A.No_Mohon = B.No_Mohon
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON B.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                    LEFT JOIN  SMKB_Perolehan_Naskah_Jualan AS C ON B.No_Mohon = C.No_Mohon
                    where ( (B.Status_Dok IN ('07') AND B.Flag_PenentuanTeknikal IN ('0')) OR (B.Status_Dok IN ('08') AND B.Flag_PenentuanTeknikal IN ('0')) or (B.Status_Dok IN ('31') AND B.Flag_PenentuanTeknikal IN ('1'))
                    or (B.Status_Dok IN ('34') AND B.Flag_PenentuanTeknikal IN ('1')) or (B.Status_Dok IN ('35') AND B.Flag_PenentuanTeknikal IN ('1')) ) 
                    AND ( B.No_Perolehan LIKE ('DS%') OR B.No_Perolehan LIKE ('DT%') )
                    " & kod_status & "
                    group by B.No_Mohon, B.Tujuan, B.Jenis_Barang, B.Status_Dok,B.Flag_PenentuanTeknikal,B.No_Perolehan, kategori.Kod_Detail, kategori.Butiran, 
                    C.Id_Jualan, C.Tarikh_Masa_Mula_Iklan,C.Tarikh_Masa_Tamat_Perolehan,C.Status_Lanjut
         "

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadNaskah_JualanDS(category_filter As String, isClick As Boolean) As String
        Dim resp As New ResponseRepository

        If (isClick = False) Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        If (category_filter = "") Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_Naskah_JualanDS(category_filter)



        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Naskah_JualanDS(category_filter As String) As DataTable
        Dim db = New DBKewConn
        Dim kod_status As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'KESELURUHAN
            kod_status = " "
        ElseIf category_filter = "2" Then ' LULUS PERMOHONAN PEMBELIAN
            kod_status = " AND  B.status_dok = '08' "
        ElseIf category_filter = "3" Then ' DFTAR JUALAN NASKAH
            kod_status = " AND  B.status_dok = '34' "
        ElseIf category_filter = "4" Then 'PROSES JUALN NASKAH
            kod_status = " AND  B.status_dok = '35' "
        ElseIf category_filter = "5" Then 'TERIMAAN DOKUMENN
            kod_status = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'BATAL JUALAN NASKAH
            kod_status = " AND  B.status_dok = '36' "

            param = New List(Of SqlParameter)
        End If

        Dim query = "
                    SELECT FORMAT(SUM(A.Jumlah_Harga),'0.00') AS tot_Jumlah_Harga, CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB, 
                    (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = B.status_dok) AS status_dok_butiran,
                    B.No_Mohon, B.Tujuan, B.Jenis_Barang, B.Status_Dok, B.Flag_PenentuanTeknikal, B.No_Perolehan,
                    C.Id_Jualan, C.Tarikh_Masa_Mula_Iklan,C.Tarikh_Masa_Tamat_Perolehan,C.Status_Lanjut
                    FROM SMKB_Perolehan_Permohonan_Hdr as B
                    LEFT JOIN  SMKB_Perolehan_Permohonan_Dtl as A ON A.No_Mohon = B.No_Mohon
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON B.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                    LEFT JOIN  SMKB_Perolehan_Naskah_Jualan AS C ON B.No_Mohon = C.No_Mohon
                    where ( (B.Status_Dok IN ('07') AND B.Flag_PenentuanTeknikal IN ('1')) OR (B.Status_Dok IN ('08') AND B.Flag_PenentuanTeknikal IN ('0')) or (B.Status_Dok IN ('31') AND B.Flag_PenentuanTeknikal IN ('1'))
                    or (B.Status_Dok IN ('34') AND B.Flag_PenentuanTeknikal IN ('1')) or (B.Status_Dok IN ('35') AND B.Flag_PenentuanTeknikal IN ('1')) ) 
                    AND B.No_Perolehan LIKE 'PS%'
                    " & kod_status & "
                    group by B.No_Mohon, B.Tujuan, B.Jenis_Barang, B.Status_Dok,B.Flag_PenentuanTeknikal,B.No_Perolehan, kategori.Kod_Detail, kategori.Butiran, 
                    C.Id_Jualan, C.Tarikh_Masa_Mula_Iklan,C.Tarikh_Masa_Tamat_Perolehan,C.Status_Lanjut
        
         "

        Return db.Read(query, param)
    End Function

    ' SMKB_Perolehan_Naskah_Jualan END

    ' SMKB_Perolehan_Lampiran SART

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Lampiran(Id_Mohon As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Perolehan_Lampiran(Id_Mohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Perolehan_Lampiran(Id_Mohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                        SELECT *
                        from SMKB_Perolehan_Lampiran
                        WHERE No_Mohon = @Id_Mohon
                        order by Id_Lampiran asc

                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@Id_Mohon", Id_Mohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' SMKB_Perolehan_Lampiran END


    'Save data insert into (Maklumat Pendaftaran Mesyuarat PT) START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Hdr(Perolehan_Mesyuarat_Header As Perolehan_Mesyuarat_Header) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Header Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If Perolehan_Mesyuarat_Header.txtIDMesy = "" Then
            Dim IDMesy As String = GenerateNoMesyuarat(Perolehan_Mesyuarat_Header.ddlKodPTj)
            Session("sessionIDMesy") = IDMesy
            Perolehan_Mesyuarat_Header.txtIDMesy = IDMesy
            Dim tarikhMasa As String = Perolehan_Mesyuarat_Header.ddlTarikh + " " + Perolehan_Mesyuarat_Header.ddlMasa
            Perolehan_Mesyuarat_Header.txtTarikh = tarikhMasa

            If InsertPerolehan_Mesyuarat_Hdr(Perolehan_Mesyuarat_Header.txtIDMesy, Perolehan_Mesyuarat_Header.ddlMasa, Perolehan_Mesyuarat_Header.ddlTarikh, Perolehan_Mesyuarat_Header.ddlTempat, Perolehan_Mesyuarat_Header.ddlJawatankuasa_kod) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Header)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function InsertPerolehan_Mesyuarat_Hdr(txtIDMesy As String, ddlMasa As String, ddlTarikh As String, ddlTempat As String, ddlJawatankuasa_kod As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Hdr (IDMesy, Tempat, TarikhMasa, TarikhDaftar,  Kod_JK, Status)
        VALUES(@txtIDMesy, @ddlTempat, @ddlMasa, @ddlTarikh, @ddlJawatankuasa_kod, 1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlMasa", ddlMasa))
        param.Add(New SqlParameter("@ddlTarikh", ddlTarikh))
        param.Add(New SqlParameter("@ddlTempat", ddlTempat))
        param.Add(New SqlParameter("@ddlJawatankuasa_kod", ddlJawatankuasa_kod))


        Return db.Process(query, param)
    End Function


    'Save data insert into (Maklumat Pendaftaran Mesyuarat PT) END

    'Save data insert into (Maklumat Pendaftaran Mesyuarat DTL) START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Dtl(Perolehan_Mesyuarat_Detail As Perolehan_Mesyuarat_Detail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Detail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Perolehan_Mesyuarat_Detail.txtIDMesy = Session("sessionIDMesy")
        If InsertPerolehan_Mesyuarat_Dtl(Perolehan_Mesyuarat_Detail.txtIDMesy, Perolehan_Mesyuarat_Detail.ddlNo_Mohon, Perolehan_Mesyuarat_Detail.ddlTurutan) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If

        If UpdateStatusDaftarMY(Perolehan_Mesyuarat_Detail.ddlNo_Mohon) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If


        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Detail)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function InsertPerolehan_Mesyuarat_Dtl(txtIDMesy As String, ddlNo_Mohon As String, ddlTurutan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Dtl (ID_Mesy, No_Mohon, Turutan, Status_Dok, Status_Lulus)
        VALUES(@txtIDMesy, @ddlNo_Mohon, @ddlTurutan, '33' ,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlNo_Mohon", ddlNo_Mohon))
        param.Add(New SqlParameter("@ddlTurutan", ddlTurutan))


        Return db.Process(query, param)
    End Function

    Private Function UpdateStatusDaftarMY(txtNoMohonR As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '33' WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))

        Return db.Process(query, param)
    End Function
    'Save data insert into (Maklumat Pendaftaran Mesyuarat DTL) END

    'Save data insert into (Maklumat Pendaftaran Mesyuarat JK) START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_JK(Perolehan_Mesyuarat_JKD As Perolehan_Mesyuarat_JKD) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Perolehan_Mesyuarat_JKD.txtIDMesy = Session("sessionIDMesy")
        If InsertPerolehan_Mesyuarat_JK(Perolehan_Mesyuarat_JKD.txtIDMesy, Perolehan_Mesyuarat_JKD.ddlNo_Staf, Perolehan_Mesyuarat_JKD.ddlName, Perolehan_Mesyuarat_JKD.ddlEmel, Perolehan_Mesyuarat_JKD.ddlNo_Tel, Perolehan_Mesyuarat_JKD.dllJawatan) <> "OK" Then
            resp.Failed("Gagal Menyimpan Daftar Mesyuarat")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If

        Dim emailSend_Mesyuarat_JK = EmelStaf_Mesyuarat_JK(Perolehan_Mesyuarat_JKD)

        resp.Success("Rekod berjaya disimpan, ID Mesyuarat : ", Perolehan_Mesyuarat_JKD.txtIDMesy)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function InsertPerolehan_Mesyuarat_JK(txtIDMesy As String, ddlNo_Staf As String, ddlName As String, ddlEmel As String, ddlNo_Tel As String, dllJawatan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_JK (ID_Mesy, No_Staf, Nama, Emel, No_Tel,Jawatan,Kehadiran )
        VALUES(@txtIDMesy, @ddlNo_Staf, @ddlName, @ddlEmel, @ddlNo_Tel, @dllJawatan ,1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlNo_Staf", ddlNo_Staf))
        param.Add(New SqlParameter("@ddlName", ddlName))
        param.Add(New SqlParameter("@ddlEmel", ddlEmel))
        param.Add(New SqlParameter("@ddlNo_Tel", ddlNo_Tel))
        param.Add(New SqlParameter("@dllJawatan", dllJawatan))


        Return db.Process(query, param)
    End Function

    ' Email service START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function EmelStaf_Mesyuarat_JK(Perolehan_Mesyuarat_JKD As Perolehan_Mesyuarat_JKD) As Tasks.Task(Of String)
        Dim clsCrypto As New clsCrypto
        Dim db As New DBKewConn

        Dim resp As New ResponseRepository
        Dim response = New Response

        Dim fullName_Penerima As String = Perolehan_Mesyuarat_JKD.ddlName
        Dim email_Penerima As String = Perolehan_Mesyuarat_JKD.ddlEmel
        Dim NoStaff_Penerima = Perolehan_Mesyuarat_JKD.ddlNo_Staf
        Dim TarikhLuput = "2024-04-29" 'kenalpasti tarikh active

        Dim IDMsy As String = Perolehan_Mesyuarat_JKD.txtIDMesy
        Dim TarikhMsy As String = Perolehan_Mesyuarat_JKD.ddlTarikh
        Dim MasaMsy As String = Perolehan_Mesyuarat_JKD.ddlMasa
        Dim MasaMsyAPI As String = MasaMsy.Replace(":", ".")
        Dim TempatMsy As String = Perolehan_Mesyuarat_JKD.ddlTempat

        Dim NameSubMenu As String = Perolehan_Mesyuarat_JKD.dllNameSubMenu
        Dim KodSubMenu = Perolehan_Mesyuarat_JKD.dllKodSubMenu 'identify kod sub menu skrin sokong/lulus ikut modul msing2
        Dim NoRujukan = "Null"

        Dim combineData = NoStaff_Penerima + Now() + NoRujukan
        Dim id = Replace(Replace(Replace(clsCrypto.fEncrypt(combineData), "/", "@"), "+", "@"), "%", "@")

        'mula insert
        Dim paramSqlBtrn() As SqlParameter = Nothing
        Dim strSqlButiran = "INSERT INTO SMKB_Emel_Auth (ID_Token, No_Staf_Penerima, Emel_Penerima, Tarikh_Luput_URL, Kod_Sub_Menu, No_Rujukan)
                                            VALUES (@ID_Token, @No_Staf_Penerima, @Emel_Penerima, @Tarikh_Luput_URL, @Kod_Sub_Menu, @No_Rujukan)"
        paramSqlBtrn = {New SqlParameter("@ID_Token", id),
                                New SqlParameter("@No_Staf_Penerima", NoStaff_Penerima),
                                New SqlParameter("@Emel_Penerima", email_Penerima),
                                New SqlParameter("@Tarikh_Luput_URL", TarikhLuput),
                                New SqlParameter("@Kod_Sub_Menu", KodSubMenu),
                                New SqlParameter("@No_Rujukan", NoRujukan)
                            }

        If db.fInsertCommand(strSqlButiran, paramSqlBtrn) > 0 Then

            Dim url As String = "http://localhost:1559/SMKBNet/loginsmkb.aspx?id=" & id 'ResolveUrl("~/loginsmkb.aspx?id=" & id) 

            'Send the New password to the user's email
            Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
            Dim body As String = "PEMBERITAHUAN" &
                         "<br><br>" &
                         vbCrLf & "Assalamualaikum Dan Salam Sejahtera " & fullName_Penerima & "," &
                         "<br><br>" &
                         vbCrLf & "Dengan segala hormatnya, kami menjemput Tuan / Puan untuk menghadiri Mesyuarat " & NameSubMenu & " yang akan diadakan seperti berikut:" &
                         "<br><br>" &
                         vbCrLf & "Tarikh : " & TarikhMsy &
                         "<br><br>" &
                          vbCrLf & "Masa : " & MasaMsy &
                         "<br><br>" &
                          vbCrLf & "Tempat : " & TempatMsy &
                         "<br><br>" &
                         vbCrLf & "Terima kasih atas kerjasama Tuan / Puan." &
                         "<br>" &
                         "<br><br>" &
                         vbCrLf & "Email dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " &
                         "<br><br>" &
                         vbCrLf & "Email ini tidak perlu dibalas."

            'vbCrLf & "ID Mesyuarat : " & IDMsy &
            '"<br><br>" &

            myEmel_Mesyuarat_JK(email_Penerima, subject, body)


            ''Notification API


            ' API endpoint URL
            Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Dengan segala hormatnya, kami menjemput Tuan atau Puan untuk menghadiri Mesyuarat " + NameSubMenu + " pada Tarikh " + TarikhMsy + ", Masa " + MasaMsyAPI + " dan Tempat " + TempatMsy + "/" + NoStaff_Penerima

            Try

                Using client As New HttpClient()
                    Dim content = New FormUrlEncodedContent(New Dictionary(Of String, String)())
                    Dim response1 As HttpResponseMessage = Await client.PostAsync(apiUrl, content)

                    If response1.IsSuccessStatusCode Then
                        'resp.Success("Permohonan perolehan berjaya dihantar.", "00", txtNoMohonR)
                        'response = resp.GetResult()
                    Else
                        resp.Failed("gagal.")
                    End If
                End Using

            Catch ex As Exception
                Dim msg As String = ex.Message
            End Try

            resp.Success("Notifikasi berjaya dihantar.", "00")
            response = resp.GetResult()



        Else
            db.sConnRollbackTrans()
        End If

        Return JsonConvert.SerializeObject(response)
    End Function

    Public strConEmail_Mesyuarat_JK As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    Private Function myEmel_Mesyuarat_JK(alamat, subject, body)
        Dim cnExec As OleDb.OleDbConnection
        Dim cmdExec As OleDb.OleDbCommand

        Try
            cnExec = New OleDb.OleDbConnection(strConEmail_Mesyuarat_JK)
            cnExec.Open()

            cmdExec = New OleDbCommand("EXEC msdb.dbo.sp_send_dbmail @profile_name= 'EmailSmkb', @recipients= '" & alamat & "', @subject = '" & subject & "', " &
                  "@body= '" & Replace(body, "'", "''") & "', @body_format='HTML';", cnExec)
            cmdExec.ExecuteNonQuery()
            cmdExec.Dispose()
            cmdExec = Nothing
            cnExec.Dispose()
            cnExec.Close()
            cnExec = Nothing

            Return 1    'Proses Berjaya
        Catch ex As Exception
            ' Show the exception's message.
            MsgBox(ex.Message)
            Return 0    'Proses Gagal
        End Try

    End Function
    ' Email service END

    'Save data insert into (Maklumat Pendaftaran Mesyuarat JK) END

    Private Function GenerateNoMesyuarat(ddlKodPTj As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newIDMesy As String = ""
        Dim ptj = ddlKodPTj

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='TM' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir2("02", "TM", year, lastID)
        Else

            InsertNoAkhir2("02", "TM", year, lastID)
        End If
        newIDMesy = "TM" + ptj.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newIDMesy
    End Function

    Private Function UpdateNoAkhir2(kodModul As String, prefix As String, year As String, ID As String)
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

    Private Function InsertNoAkhir2(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Mohon Pembelian"))
        param.Add(New SqlParameter("@Kod_PTJ", "-")) 'letak session ssusrKodPTj


        Return db.Process(query, param)
    End Function

    'Save data insert into (Maklumat Pendaftaran Mesyuarat PT)  END


    'update (Maklumat Pendaftaran Mesyuarat DTL) START

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HantarPerolehan_Mesyuarat_Data(HantarPerolehan_Mesyuarat_Dtl As HantarPerolehan_Mesyuarat_Detail) As String
        Dim resp As New ResponseRepository

        If HantarPerolehan_Mesyuarat_Dtl Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Dim rekodPermohonan = GetOrder_Perolehan_MesyuaratDt(HantarPerolehan_Mesyuarat_Dtl.txtIDMesyH)

        If rekodPermohonan.Rows.Count = 0 Then
            resp.Failed("Rekod Permohonan tidak dijumpai.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf UpdatePerolehan_Mesyuarat_Dtl(HantarPerolehan_Mesyuarat_Dtl.txtNoMohonH, HantarPerolehan_Mesyuarat_Dtl.txtIDMesyH, HantarPerolehan_Mesyuarat_Dtl.txtUlasanH, HantarPerolehan_Mesyuarat_Dtl.txtStatusDokH) <> "OK" Then
            resp.Failed("Gagal menghantar permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Permohonan perolehan berjaya dihantar.")

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdatePerolehan_Mesyuarat_Dtl(txtNoMohonH As String, txtIDMesyH As String, txtUlasanH As String, txtStatusDokH As String)
        Dim db As New DBKewConn
        Dim query As String = "
        UPDATE SMKB_Perolehan_Mesyuarat_Dtl
        set Ulasan = @txtUlasanH, Status_Dok = @txtStatusDokH
        where No_Mohon = @txtNoMohon AND ID_Mesy = @txtIDMesyH
        "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonH))
        param.Add(New SqlParameter("@txtIDMesyH", txtIDMesyH))
        param.Add(New SqlParameter("@txtUlasanH", txtUlasanH))
        param.Add(New SqlParameter("@txtStatusDokH", txtStatusDokH))


        Return db.Process(query, param)
    End Function

    'update (Maklumat Pendaftaran Mesyuarat DTL) END


    ' LoadSenaraiHT START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiHT(IDMesy As String) As String
        Dim resp As New ResponseRepository

        If IDMesy = "" Then
            IDMesy = Session("IDMesy")
        Else
            Session("IDMesy") = IDMesy
        End If

        If IDMesy = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiHT(IDMesy)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiHT(IDMesy As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "

                    SELECT * 
                    FROM SMKB_Perolehan_Mesyuarat_Dtl a
                    INNER JOIN SMKB_Perolehan_Mesyuarat_Hdr b ON a.ID_Mesy = b.IDMesy
                    INNER JOIN SMKB_Perolehan_Permohonan_Hdr c ON a.No_Mohon = c.No_Mohon
                    and a.Status_Dok = '30'
                    and c.Flag_PenentuanTeknikal ='1'
                    order by a.No_Mohon asc

                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IDMesy", IDMesy))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'LoadSenaraiHT END

    ' Maklumat_Permohonan_Perolehan START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMaklumat_Permohonan_PerolehanST(IdAm As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Maklumat_Permohonan_PerolehanST(IdAm)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Maklumat_Permohonan_PerolehanST(IdAm As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                    SELECT a.No_Perolehan, a.No_Mohon,a.Tarikh_Mohon, a.Tujuan,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,                    
                    a.Kod_Ptj_Mohon,a.Tarikh_Perlu, a.Perolehan_Terdahulu,a.Justifikasi, 
                    kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    StatusPO.Butiran As ButiranKodDok,
                    SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP,a.Skop,
                    Ulasan
                    FROM SMKB_Perolehan_Permohonan_Hdr AS a
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                    INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
                    INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
                    INNER JOIN SMKB_Perolehan_Mesyuarat_Dtl AS Mesyuarat_Dtl ON a.No_Mohon = Mesyuarat_Dtl.No_Mohon 
                    WHERE a.No_Mohon = @IdAm
                    AND StatusPO.Kod_Modul='02' 
                    ORDER BY a.No_Mohon

                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdAm", IdAm))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'Maklumat_Permohonan_Perolehan END


    'Updata Status_Dok SMKB_Perolehan_Permohonan_Hdr START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HantarStatus_Dok_Permohonan_Hdr(HantarPerolehan_Mesyuarat_Dtl As HantarPerolehan_Mesyuarat_Detail) As String

        Dim resp As New ResponseRepository

        If HantarPerolehan_Mesyuarat_Dtl.txtNoMohonH Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If UpdateStatus_Dok_Permohonan_Hdr(HantarPerolehan_Mesyuarat_Dtl.txtNoMohonH, HantarPerolehan_Mesyuarat_Dtl.txtStatusDokH, HantarPerolehan_Mesyuarat_Dtl.txtFlag_PenentuanTeknikal) <> "OK" Then
            resp.Failed("Gagal menghantar permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Permohonan perolehan berjaya dihantar.", "00", HantarPerolehan_Mesyuarat_Dtl.txtNoMohonH)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateStatus_Dok_Permohonan_Hdr(txtNoMohonH As String, txtStatusDokH As String, txtFlag_PenentuanTeknikal As String)
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = @Status_Dok , Flag_PenentuanTeknikal= @Flag_PenentuanTeknikal  WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonH))
        param.Add(New SqlParameter("@Status_Dok", txtStatusDokH))
        param.Add(New SqlParameter("@Flag_PenentuanTeknikal", txtFlag_PenentuanTeknikal))


        Return db.Process(query, param)
    End Function

    'Updata Status_Dok SMKB_Perolehan_Permohonan_Hdr END

    'INSERT  Senarai_Jualan_Naskah START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateSenarai_Jualan_Naskah(HantarPerolehan_Mesyuarat_Dtl As HantarPerolehan_Mesyuarat_Detail) As String

        Dim resp As New ResponseRepository

        If HantarPerolehan_Mesyuarat_Dtl.txtNoMohonH Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If InsertSenarai_Jualan_Naskah(HantarPerolehan_Mesyuarat_Dtl.txtNoMohonH) <> "OK" Then
            resp.Failed("Gagal menghantar permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Permohonan perolehan berjaya dihantar.", "00", HantarPerolehan_Mesyuarat_Dtl.txtNoMohonH)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function InsertSenarai_Jualan_Naskah(txtNoMohonH As String)
        Dim db As New DBKewConn

        'Dim query As String = "INSERT INTO SMKB_Perolehan_Naskah_Jualan (No_Mohon, Id_Jualan, Tarikh_Daftar, No_Sebut_Harga, Harga, Gred_CIDB, Lawatan_Tapak, Tempat_Lawatan_Tapak, Tarikh_Masa_Lawatan_Tapak, Tarikh_Masa_Mula_Iklan, Tarikh_Masa_Mula_Perolehan, Tarikh_Masa_Tamat_Perolehan, Tempat_Hantar, No_Staf, Syarat_Perolehan, Status_Lanjut, Status) 
        'VALUES (@txtNoMohon, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)"


        Dim query As String = "INSERT INTO SMKB_Perolehan_Naskah_Jualan (No_Mohon, Id_Jualan, Tarikh_Daftar, No_Sebut_Harga, Harga, Gred_CIDB, Lawatan_Tapak, Tempat_Lawatan_Tapak, Tarikh_Masa_Lawatan_Tapak, Tarikh_Masa_Mula_Iklan, Tarikh_Masa_Mula_Perolehan, Tarikh_Masa_Tamat_Perolehan, Tempat_Hantar, No_Staf, Syarat_Perolehan, Status_Lanjut, Status) 
        VALUES (@txtNoMohon, @IdJualan, @Tarikh_Daftar, @No_Sebut_Harga, @Harga, @Gred_CIDB, @Lawatan_Tapak, @Tempat_Lawatan_Tapak, @Tarikh_Masa_Lawatan_Tapak, @Tarikh_Masa_Mula_Iklan, @Tarikh_Masa_Mula_Perolehan, @Tarikh_Masa_Tamat_Perolehan, @Tempat_Hantar, @No_Staf, @Syarat_Perolehan, @Status_Lanjut, @Status)"


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonH))
        param.Add(New SqlParameter("@IdJualan", DBNull.Value))
        param.Add(New SqlParameter("@Tarikh_Daftar", DBNull.Value))
        param.Add(New SqlParameter("@No_Sebut_Harga", DBNull.Value))
        param.Add(New SqlParameter("@Harga", DBNull.Value))
        param.Add(New SqlParameter("@Gred_CIDB", DBNull.Value))
        param.Add(New SqlParameter("@Lawatan_Tapak", DBNull.Value))
        param.Add(New SqlParameter("@Tempat_Lawatan_Tapak", DBNull.Value))
        param.Add(New SqlParameter("@Tarikh_Masa_Lawatan_Tapak", DBNull.Value))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Iklan", DBNull.Value))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Perolehan", DBNull.Value))
        param.Add(New SqlParameter("@Tarikh_Masa_Tamat_Perolehan", DBNull.Value))
        param.Add(New SqlParameter("@Tempat_Hantar", DBNull.Value))
        param.Add(New SqlParameter("@No_Staf", DBNull.Value))
        param.Add(New SqlParameter("@Syarat_Perolehan", DBNull.Value))
        param.Add(New SqlParameter("@Status_Lanjut", DBNull.Value))
        param.Add(New SqlParameter("@Status", DBNull.Value))

        Return db.Process(query, param)
    End Function


    'INSERT Senarai_Jualan_Naskah END

    'Dropdown SMKB_Lookup_Detail START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Kod_Pendaftaran(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodPendaftaran(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetKodPendaftaran(Kod_Detail As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
                    SELECT Kod_Detail as kodValue, CONCAT(Kod_Detail, ' - ', Butiran) as text
                    FROM SMKB_Lookup_Detail
                    where Kod = 'vdr03'

                    "
        Dim param As New List(Of SqlParameter)

        If Kod_Detail <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @Kod_Detail + '%' or Butiran like '%'+ @kod2 + '%')"
            param.Add(New SqlParameter("@Kod_Detail", Kod_Detail))
            param.Add(New SqlParameter("@kod2", Kod_Detail))
        End If

        Return db.Read(query, param)
    End Function
    'Dropdown SMKB_Lookup_Detail END

    ' LoadMaklumat_Naskah_Jualan SART

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMaklumat_Naskah_Jualan(IdMohon As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Maklumat_Naskah_Jualan(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Maklumat_Naskah_Jualan(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                     SELECT CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB, SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP,
                     (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = B.status_dok) AS status_dok_butiran,
                     (SELECT Butiran as text FROM SMKB_Syarikat_CIDB_Gred WHERE Kod_Gred = C.Gred_CIDB) AS Kod_Gred_butiran,
                     (SELECT CONCAT(ID_Sykt, ' - ', Nama_Sykt) as text FROM SMKB_Syarikat_Master WHERE ID_Sykt = C.Kod_Vendo) AS Nama_Sykt_butiran,
                    Format(C.Tarikh_Masa_Lawatan_Tapak,'yyyy-MM-dd') as Tarikh_Lawatan_Tapak, Format(B.Tarikh_Mohon,'yyyy-MM-dd') As Tarikh_Mohon, 
                    Format(C.Tarikh_Masa_Mula_Iklan,'yyyy-MM-dd') As Tarikh_Masa_Mula_Iklan, Format(C.Tarikh_Masa_Mula_Perolehan,'yyyy-MM-dd') As Tarikh_Masa_Mula_Perolehan, 
                    Format(C.Tarikh_Masa_Tamat_Perolehan,'yyyy-MM-dd') As Tarikh_Tamat_Perolehan,  Format(C.Tarikh_Masa_Tamat_Perolehan,'hh:mm ') As Masa_Tamat_Perolehan, 
                    Format(C.Tarikh_Masa_Lawatan_Tapak,'hh:mm ') As Masa_Lawatan_Tapak,
                    B.*,C.*              
                     FROM SMKB_Perolehan_Permohonan_Hdr as B
                     INNER JOIN SMKB_Lookup_Detail AS kategori ON B.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                     LEFT JOIN  SMKB_Perolehan_Naskah_Jualan AS C ON B.No_Mohon = C.No_Mohon
                     LEFT JOIN VPeribadi As SMSM ON B.Id_Pemohon = SMSM.MS01_NoStaf
                     where B.No_Mohon = @IdMohon
                     order by B.No_Mohon
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' LoadMaklumat_Naskah_Jualan END

    'updateMaklumat_Naskah_Jualan START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadeUpdateMaklumat_Naskah_Jualan(HantarNaskah_Jualan_Dtl As HantarNaskah_Jualan) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        If HantarNaskah_Jualan_Dtl Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If HantarNaskah_Jualan_Dtl.txtIdJualan = "" Then
            Dim noIdJualan As String = GenerateNoJualan(HantarNaskah_Jualan_Dtl.ddlKodPTj, 0)

            If HantarNaskah_Jualan_Dtl.ddlNo_Perolehan = "DS" Then
                Dim noIdNoSebutHarga As String = GenerateNoSebutHarga(HantarNaskah_Jualan_Dtl.ddlKodPTj)
                HantarNaskah_Jualan_Dtl.txtNo_Sebut_Harga = noIdNoSebutHarga
            End If

            If HantarNaskah_Jualan_Dtl.ddlNo_Perolehan = "DT" Then
                Dim noIdNoSebutHarga As String = GenerateNoSebutTander(HantarNaskah_Jualan_Dtl.ddlKodPTj)
                HantarNaskah_Jualan_Dtl.txtNo_Sebut_Harga = noIdNoSebutHarga
            End If

            If HantarNaskah_Jualan_Dtl.ddlNo_Perolehan = "PS" Then
                Dim noIdNoSebutHarga As String = GenerateNoPTJ(HantarNaskah_Jualan_Dtl.ddlKodPTj)
                HantarNaskah_Jualan_Dtl.txtNo_Sebut_Harga = noIdNoSebutHarga
            End If

            HantarNaskah_Jualan_Dtl.txtIdJualan = noIdJualan



            If HantarNaskah_Jualan_Dtl.txtLawatan_Tapak = "Tidak" Then
                If InsertNewOrder_Maklumat_Naskah_Jualan(HantarNaskah_Jualan_Dtl) <> "OK" Then
                    resp.Failed("Gagal Menyimpan daftar maklumat naskah jualan.")
                    GenerateNoJualan(HantarNaskah_Jualan_Dtl.ddlKodPTj, 1)
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    'Exit Function
                End If
            Else
                If InsertNewOrder_Maklumat_Naskah_Jualan_Lawatan_Tapak(HantarNaskah_Jualan_Dtl) <> "OK" Then
                    resp.Failed("Gagal Menyimpan daftar maklumat naskah jualan.")
                    GenerateNoJualan(HantarNaskah_Jualan_Dtl.ddlKodPTj, 1)
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    'Exit Function
                End If
            End If

            If UpdateStatus_Dok_Permohonan_Hdr_Naskah(HantarNaskah_Jualan_Dtl.txtNoMohon, HantarNaskah_Jualan_Dtl.txtStatusDokH, HantarNaskah_Jualan_Dtl.txtFlag_PenentuanTeknikal) <> "OK" Then
                resp.Failed("Gagal mengemaskini Status Permohonan.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        Else



            If HantarNaskah_Jualan_Dtl.txtLawatan_Tapak = "Tidak" Then
                If UpdateNewOrder_Maklumat_Naskah_Jualan(HantarNaskah_Jualan_Dtl.txtNoMohon, HantarNaskah_Jualan_Dtl.txtIdJualan, HantarNaskah_Jualan_Dtl.txtHarga, HantarNaskah_Jualan_Dtl.txtGred_CIDB, HantarNaskah_Jualan_Dtl.txtLawatan_Tapak, HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Mula_Iklan, HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Mula_Perolehan, HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Tamat_Perolehan, HantarNaskah_Jualan_Dtl.txtTempat_Hantar, HantarNaskah_Jualan_Dtl.txtNo_Staf, HantarNaskah_Jualan_Dtl.txtSyarat_Perolehan, HantarNaskah_Jualan_Dtl.txtStatus_Lanjut, HantarNaskah_Jualan_Dtl.ddlVendo, HantarNaskah_Jualan_Dtl.txtStatus) <> "OK" Then
                    resp.Failed("Gagal mengemaskini maklumat naskah jualan.")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    'Exit Function
                End If
            Else
                If UpdateNewOrder_Maklumat_Naskah_Jualan_Lawatan_Tapak(HantarNaskah_Jualan_Dtl.txtNoMohon, HantarNaskah_Jualan_Dtl.txtIdJualan, HantarNaskah_Jualan_Dtl.txtHarga, HantarNaskah_Jualan_Dtl.txtGred_CIDB, HantarNaskah_Jualan_Dtl.txtLawatan_Tapak, HantarNaskah_Jualan_Dtl.txtTempat_Lawatan_Tapak, HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Lawatan_Tapak, HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Mula_Iklan, HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Mula_Perolehan, HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Tamat_Perolehan, HantarNaskah_Jualan_Dtl.txtTempat_Hantar, HantarNaskah_Jualan_Dtl.txtNo_Staf, HantarNaskah_Jualan_Dtl.txtSyarat_Perolehan, HantarNaskah_Jualan_Dtl.txtStatus_Lanjut, HantarNaskah_Jualan_Dtl.ddlVendo, HantarNaskah_Jualan_Dtl.txtStatus) <> "OK" Then
                    resp.Failed("Gagal mengemaskini maklumat naskah jualan.")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    'Exit Function
                End If
            End If
            'Koding untuk update
        End If

        resp.Success("Rekod berjaya disimpan.", "00", HantarNaskah_Jualan_Dtl)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function InsertNewOrder_Maklumat_Naskah_Jualan(HantarNaskah_Jualan_Dtl)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Naskah_Jualan (No_Mohon, Id_Jualan, Tarikh_Daftar, No_Sebut_Harga, Harga, Gred_CIDB, Lawatan_Tapak, Tarikh_Masa_Mula_Iklan, Tarikh_Masa_Mula_Perolehan, Tarikh_Masa_Tamat_Perolehan, Tempat_Hantar, No_Staf, Syarat_Perolehan, Status_Lanjut, Status, Kod_Vendo) 
        VALUES (@txtNoMohon, @IdJualan, @Tarikh_Daftar, @No_Sebut_Harga, @Harga, @Gred_CIDB, @Lawatan_Tapak,  @Tarikh_Masa_Mula_Iklan, @Tarikh_Masa_Mula_Perolehan, @Tarikh_Masa_Tamat_Perolehan, @Tempat_Hantar, @No_Staf, @Syarat_Perolehan, @Status_Lanjut, @Status, @ddlVendo )"


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", HantarNaskah_Jualan_Dtl.txtNoMohon))
        param.Add(New SqlParameter("@IdJualan", HantarNaskah_Jualan_Dtl.txtIdJualan))
        param.Add(New SqlParameter("@Tarikh_Daftar", HantarNaskah_Jualan_Dtl.txtTarikh_Daftar))
        param.Add(New SqlParameter("@No_Sebut_Harga", HantarNaskah_Jualan_Dtl.txtNo_Sebut_Harga))
        param.Add(New SqlParameter("@Harga", HantarNaskah_Jualan_Dtl.txtHarga))
        param.Add(New SqlParameter("@Gred_CIDB", HantarNaskah_Jualan_Dtl.txtGred_CIDB))
        param.Add(New SqlParameter("@Lawatan_Tapak", HantarNaskah_Jualan_Dtl.txtLawatan_Tapak))
        param.Add(New SqlParameter("@Tempat_Lawatan_Tapak", HantarNaskah_Jualan_Dtl.txtTempat_Lawatan_Tapak))
        param.Add(New SqlParameter("@Tarikh_Masa_Lawatan_Tapak", HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Lawatan_Tapak))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Iklan", HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Mula_Iklan))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Perolehan", HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Mula_Perolehan))
        param.Add(New SqlParameter("@Tarikh_Masa_Tamat_Perolehan", HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Tamat_Perolehan))
        param.Add(New SqlParameter("@Tempat_Hantar", HantarNaskah_Jualan_Dtl.txtTempat_Hantar))
        param.Add(New SqlParameter("@No_Staf", HantarNaskah_Jualan_Dtl.txtNo_Staf))
        param.Add(New SqlParameter("@Syarat_Perolehan", HantarNaskah_Jualan_Dtl.txtSyarat_Perolehan))
        param.Add(New SqlParameter("@Status_Lanjut", HantarNaskah_Jualan_Dtl.txtStatus_Lanjut))
        param.Add(New SqlParameter("@Status", HantarNaskah_Jualan_Dtl.txtStatus))
        param.Add(New SqlParameter("@ddlVendo", HantarNaskah_Jualan_Dtl.ddlVendo))



        Return db.Process(query, param)
    End Function

    Private Function InsertNewOrder_Maklumat_Naskah_Jualan_Lawatan_Tapak(HantarNaskah_Jualan_Dtl)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Naskah_Jualan (No_Mohon, Id_Jualan, Tarikh_Daftar, No_Sebut_Harga, Harga, Gred_CIDB, Lawatan_Tapak, Tempat_Lawatan_Tapak, Tarikh_Masa_Lawatan_Tapak, Tarikh_Masa_Mula_Iklan, Tarikh_Masa_Mula_Perolehan, Tarikh_Masa_Tamat_Perolehan, Tempat_Hantar, No_Staf, Syarat_Perolehan, Status_Lanjut, Status, Kod_Vendo) 
        VALUES (@txtNoMohon, @IdJualan, @Tarikh_Daftar, @No_Sebut_Harga, @Harga, @Gred_CIDB, @Lawatan_Tapak, @Tempat_Lawatan_Tapak, @Tarikh_Masa_Lawatan_Tapak, @Tarikh_Masa_Mula_Iklan, @Tarikh_Masa_Mula_Perolehan, @Tarikh_Masa_Tamat_Perolehan, @Tempat_Hantar, @No_Staf, @Syarat_Perolehan, @Status_Lanjut, @Status, @ddlVendo )"


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", HantarNaskah_Jualan_Dtl.txtNoMohon))
        param.Add(New SqlParameter("@IdJualan", HantarNaskah_Jualan_Dtl.txtIdJualan))
        param.Add(New SqlParameter("@Tarikh_Daftar", HantarNaskah_Jualan_Dtl.txtTarikh_Daftar))
        param.Add(New SqlParameter("@No_Sebut_Harga", HantarNaskah_Jualan_Dtl.txtNo_Sebut_Harga))
        param.Add(New SqlParameter("@Harga", HantarNaskah_Jualan_Dtl.txtHarga))
        param.Add(New SqlParameter("@Gred_CIDB", HantarNaskah_Jualan_Dtl.txtGred_CIDB))
        param.Add(New SqlParameter("@Lawatan_Tapak", HantarNaskah_Jualan_Dtl.txtLawatan_Tapak))
        param.Add(New SqlParameter("@Tempat_Lawatan_Tapak", HantarNaskah_Jualan_Dtl.txtTempat_Lawatan_Tapak))
        param.Add(New SqlParameter("@Tarikh_Masa_Lawatan_Tapak", HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Lawatan_Tapak))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Iklan", HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Mula_Iklan))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Perolehan", HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Mula_Perolehan))
        param.Add(New SqlParameter("@Tarikh_Masa_Tamat_Perolehan", HantarNaskah_Jualan_Dtl.txtTarikh_Masa_Tamat_Perolehan))
        param.Add(New SqlParameter("@Tempat_Hantar", HantarNaskah_Jualan_Dtl.txtTempat_Hantar))
        param.Add(New SqlParameter("@No_Staf", HantarNaskah_Jualan_Dtl.txtNo_Staf))
        param.Add(New SqlParameter("@Syarat_Perolehan", HantarNaskah_Jualan_Dtl.txtSyarat_Perolehan))
        param.Add(New SqlParameter("@Status_Lanjut", HantarNaskah_Jualan_Dtl.txtStatus_Lanjut))
        param.Add(New SqlParameter("@Status", HantarNaskah_Jualan_Dtl.txtStatus))
        param.Add(New SqlParameter("@ddlVendo", HantarNaskah_Jualan_Dtl.ddlVendo))



        Return db.Process(query, param)
    End Function

    Private Function UpdateNewOrder_Maklumat_Naskah_Jualan(txtNoMohon As String, txtIdJualan As String, txtHarga As String, txtGred_CIDB As String, txtLawatan_Tapak As String, txtTarikh_Masa_Mula_Iklan As String, txtTarikh_Masa_Mula_Perolehan As String, txtTarikh_Masa_Tamat_Perolehan As String, txtTempat_Hantar As String, txtNo_Staf As String, txtSyarat_Perolehan As String, txtStatus_Lanjut As String, ddlVendo As String, txtStatus As String)
        Dim db As New DBKewConn
        Dim query As String = "
        UPDATE SMKB_Perolehan_Naskah_Jualan SET Harga=@Harga, Gred_CIDB=@Gred_CIDB,
        Lawatan_Tapak=@Lawatan_Tapak, Tarikh_Masa_Mula_Iklan=@Tarikh_Masa_Mula_Iklan, 
        Tarikh_Masa_Mula_Perolehan=@Tarikh_Masa_Mula_Perolehan, Tarikh_Masa_Tamat_Perolehan=@Tarikh_Masa_Tamat_Perolehan,
        Tempat_Hantar=@Tempat_Hantar, No_Staf=@No_Staf, Syarat_Perolehan=@Syarat_Perolehan, Status_Lanjut=@Status_Lanjut, Status=@Status, Kod_Vendo=@ddlVendo
        WHERE No_Mohon = @txtNoMohon AND  Id_Jualan = @IdJualan
        "


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohon))
        param.Add(New SqlParameter("@IdJualan", txtIdJualan))
        param.Add(New SqlParameter("@Harga", txtHarga))
        param.Add(New SqlParameter("@Gred_CIDB", txtGred_CIDB))
        param.Add(New SqlParameter("@Lawatan_Tapak", txtLawatan_Tapak))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Iklan", txtTarikh_Masa_Mula_Iklan))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Perolehan", txtTarikh_Masa_Mula_Perolehan))
        param.Add(New SqlParameter("@Tarikh_Masa_Tamat_Perolehan", txtTarikh_Masa_Tamat_Perolehan))
        param.Add(New SqlParameter("@Tempat_Hantar", txtTempat_Hantar))
        param.Add(New SqlParameter("@No_Staf", txtNo_Staf))
        param.Add(New SqlParameter("@Syarat_Perolehan", txtSyarat_Perolehan))
        param.Add(New SqlParameter("@Status_Lanjut", txtStatus_Lanjut))
        param.Add(New SqlParameter("@Status", txtStatus))
        param.Add(New SqlParameter("@ddlVendo", ddlVendo))

        Return db.Process(query, param)
    End Function

    Private Function UpdateNewOrder_Maklumat_Naskah_Jualan_Lawatan_Tapak(txtNoMohon As String, txtIdJualan As String, txtHarga As String, txtGred_CIDB As String, txtLawatan_Tapak As String, txtTempat_Lawatan_Tapak As String, txtTarikh_Masa_Lawatan_Tapak As String, txtTarikh_Masa_Mula_Iklan As String, txtTarikh_Masa_Mula_Perolehan As String, txtTarikh_Masa_Tamat_Perolehan As String, txtTempat_Hantar As String, txtNo_Staf As String, txtSyarat_Perolehan As String, txtStatus_Lanjut As String, ddlVendo As String, txtStatus As String)
        Dim db As New DBKewConn
        Dim query As String = "
        UPDATE SMKB_Perolehan_Naskah_Jualan SET Harga=@Harga, Gred_CIDB=@Gred_CIDB,
        Lawatan_Tapak=@Lawatan_Tapak, Tempat_Lawatan_Tapak=@Tempat_Lawatan_Tapak, Tarikh_Masa_Lawatan_Tapak=@Tarikh_Masa_Lawatan_Tapak, 
        Tarikh_Masa_Mula_Iklan=@Tarikh_Masa_Mula_Iklan, Tarikh_Masa_Mula_Perolehan=@Tarikh_Masa_Mula_Perolehan, Tarikh_Masa_Tamat_Perolehan=@Tarikh_Masa_Tamat_Perolehan,
        Tempat_Hantar=@Tempat_Hantar, No_Staf=@No_Staf, Syarat_Perolehan=@Syarat_Perolehan, Status_Lanjut=@Status_Lanjut, Status=@Status, Kod_Vendo=@ddlVendo
        WHERE No_Mohon = @txtNoMohon AND  Id_Jualan = @IdJualan
        "


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohon))
        param.Add(New SqlParameter("@IdJualan", txtIdJualan))
        param.Add(New SqlParameter("@Harga", txtHarga))
        param.Add(New SqlParameter("@Gred_CIDB", txtGred_CIDB))
        param.Add(New SqlParameter("@Lawatan_Tapak", txtLawatan_Tapak))
        param.Add(New SqlParameter("@Tempat_Lawatan_Tapak", txtTempat_Lawatan_Tapak))
        param.Add(New SqlParameter("@Tarikh_Masa_Lawatan_Tapak", txtTarikh_Masa_Lawatan_Tapak))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Iklan", txtTarikh_Masa_Mula_Iklan))
        param.Add(New SqlParameter("@Tarikh_Masa_Mula_Perolehan", txtTarikh_Masa_Mula_Perolehan))
        param.Add(New SqlParameter("@Tarikh_Masa_Tamat_Perolehan", txtTarikh_Masa_Tamat_Perolehan))
        param.Add(New SqlParameter("@Tempat_Hantar", txtTempat_Hantar))
        param.Add(New SqlParameter("@No_Staf", txtNo_Staf))
        param.Add(New SqlParameter("@Syarat_Perolehan", txtSyarat_Perolehan))
        param.Add(New SqlParameter("@Status_Lanjut", txtStatus_Lanjut))
        param.Add(New SqlParameter("@Status", txtStatus))
        param.Add(New SqlParameter("@ddlVendo", ddlVendo))

        Return db.Process(query, param)
    End Function


    Private Function GenerateNoJualan(ddlPTJPemohon As String, no_check As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoMohon As String = ""
        Dim ptj = ddlPTJPemohon

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='NJ' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If (no_check = "1") Then
            lastID = CInt(dt.Rows(0).Item("id")) - 1

            UpdateNoAkhirNJ("02", "NJ", year, lastID, ddlPTJPemohon)
        Else
            If dt.Rows.Count > 0 Then
                lastID = CInt(dt.Rows(0).Item("id")) + 1

                UpdateNoAkhirNJ("02", "NJ", year, lastID, ddlPTJPemohon)
            Else

                InsertNoAkhirNJ("02", "NJ", year, lastID, ddlPTJPemohon)
            End If
        End If



        newNoMohon = "NJ" + ptj.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoMohon
    End Function

    Private Function GenerateNoSebutHarga(ddlPTJPemohon As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoMohon As String = ""
        Dim ptj = ddlPTJPemohon

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='SH' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhirSHT("02", "SH", year, lastID, ddlPTJPemohon)
        Else

            InsertNoAkhirSHT("02", "SH", year, lastID, ddlPTJPemohon)
        End If
        newNoMohon = "UTeM" + "/" + "SH" + "/" + Format(lastID, "000").ToString + "/" + Right(year.ToString(), 4)

        Return newNoMohon
    End Function

    Private Function GenerateNoSebutTander(ddlPTJPemohon As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoMohon As String = ""
        Dim ptj = ddlPTJPemohon

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='DT' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhirSHT("02", "DT", year, lastID, ddlPTJPemohon)
        Else

            InsertNoAkhirSHT("02", "DT", year, lastID, ddlPTJPemohon)
        End If
        newNoMohon = "UTeM" + "/" + "DT" + "/" + Format(lastID, "000").ToString + "/" + Right(year.ToString(), 4)

        Return newNoMohon
    End Function

    Private Function GenerateNoPTJ(ddlPTJPemohon As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoMohon As String = ""
        Dim ptj = ddlPTJPemohon

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='SH' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhirSHT("02", "SH", year, lastID, ptj)
        Else

            InsertNoAkhirSHT("02", "SH", year, lastID, ptj)
        End If
        newNoMohon = "UTeM" + "/" + "SH" + "/" + ptj.ToString + "/" + Format(lastID, "000").ToString + "/" + Right(year.ToString(), 4)

        Return newNoMohon
    End Function


    Private Function UpdateStatus_Dok_Permohonan_Hdr_Naskah(txtNoMohonH As String, txtStatusDokH As String, txtFlag_PenentuanTeknikal As String)
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = @Status_Dok , Flag_PenentuanTeknikal= @Flag_PenentuanTeknikal  WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonH))
        param.Add(New SqlParameter("@Status_Dok", txtStatusDokH))
        param.Add(New SqlParameter("@Flag_PenentuanTeknikal", txtFlag_PenentuanTeknikal))


        Return db.Process(query, param)
    End Function

    Private Function UpdateNoAkhirNJ(kodModul As String, prefix As String, year As String, ID As String, ddlPTJPemohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir, Kod_PTJ = @Kod_PTJ
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Kod_PTJ", ddlPTJPemohon))


        Return db.Process(query, param)
    End Function

    Private Function InsertNoAkhirNJ(kodModul As String, prefix As String, year As String, ID As String, ddlPTJPemohon As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Naskah Jualan"))
        param.Add(New SqlParameter("@Kod_PTJ", ddlPTJPemohon)) 'letak session ssusrKodPTj


        Return db.Process(query, param)
    End Function


    Private Function UpdateNoAkhirSHT(kodModul As String, prefix As String, year As String, ID As String, ddlPTJPemohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir, Kod_PTJ = @Kod_PTJ
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Kod_PTJ", ddlPTJPemohon))


        Return db.Process(query, param)
    End Function

    Private Function InsertNoAkhirSHT(kodModul As String, prefix As String, year As String, ID As String, ddlPTJPemohon As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Sebut Harga / Tendar"))
        param.Add(New SqlParameter("@Kod_PTJ", ddlPTJPemohon)) 'letak session ssusrKodPTj


        Return db.Process(query, param)
    End Function



    'updateMaklumat_Naskah_Jualan END


    'INSERT SMKB_Perolehan_Lesen START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdatePerolehan_Lesen(HantarHantarLesen_Dtl As HantarLesen) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        If HantarHantarLesen_Dtl Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If InsertPerolehan_Lesen(HantarHantarLesen_Dtl.txtIdJualan, HantarHantarLesen_Dtl.txtNoMohon, HantarHantarLesen_Dtl.txtKod_Lesen, HantarHantarLesen_Dtl.txtStatus, HantarHantarLesen_Dtl.txtMaklumat_lanjut) <> "OK" Then
            resp.Failed("Gagal menghantar permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Maklumat Lesen Pendaftaran berjaya diSimpan.")

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function InsertPerolehan_Lesen(txtIdJualan As String, txtNoMohon As String, txtKod_Lesen As String, txtStatus As String, txtMaklumat_lanjut As String)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Perolehan_Lesen (Id_Jualan, No_Mohon, Kod_Lesen,  Status, Maklumat_Lanjut) 
        VALUES (@IdJualan, @txtNoMohon, @txtKod_Lesen, @Status, @txtMaklumat_lanjut)"


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohon))
        param.Add(New SqlParameter("@IdJualan", txtIdJualan))
        param.Add(New SqlParameter("@txtKod_Lesen", txtKod_Lesen))
        param.Add(New SqlParameter("@Status", txtStatus))
        param.Add(New SqlParameter("@txtMaklumat_lanjut", txtMaklumat_lanjut))


        Return db.Process(query, param)
    End Function


    'INSERT SMKB_Perolehan_Lesen END

    'LoadPerolehan_Lesen START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Lesen(IdMohon As String, IdJualan As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Perolehan_Lesen(IdMohon, IdJualan)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Perolehan_Lesen(IdMohon As String, IdJualan As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
               SELECT A.Id_Lesen
                     ,A.Id_Jualan
                     ,A.No_Mohon
                     ,A.Kod_Lesen
                     ,A.Status
	                 ,A.Maklumat_Lanjut
	                 ,B.Butiran
                 FROM SMKB_Perolehan_Lesen AS A
                 inner join SMKB_Lookup_Detail AS B On A.Kod_Lesen = B.Kod_Detail
                 where B.Kod = 'vdr03' AND A.Id_Jualan = @IdJualan AND A.No_Mohon = @IdMohon
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            cmd.Parameters.Add(New SqlParameter("@IdJualan", IdJualan))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'LoadPerolehan_Lesen END


    'Delete Perolehan_Lesen START
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeletePerolehan_Lesen(ByVal Id_Lesen_Dtl As String) As String
        Dim resp As New ResponseRepository

        If Query_deletePerolehan_Lesen(Id_Lesen_Dtl) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dipadam.")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deletePerolehan_Lesen(Id_Lesen_Dtl As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM SMKB_Perolehan_Lesen WHERE Id_Lesen = @Id_Lesen_Dtl"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Lesen_Dtl", Id_Lesen_Dtl))

        Return db.Process(query, param)
    End Function
    'Delete Perolehan_Lesen END


    'HantarProcessJN

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadeUpdateMaklumat_JN_SD(HantarNaskah_Jualan_Dtl As HantarNaskah_Jualan) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        If HantarNaskah_Jualan_Dtl Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateStatus_Dok_Permohonan_Hdr_NJ(HantarNaskah_Jualan_Dtl.txtNoMohon, HantarNaskah_Jualan_Dtl.txtStatusDokH, HantarNaskah_Jualan_Dtl.txtFlag_PenentuanTeknikal) <> "OK" Then
            resp.Failed("Gagal menghantar maklumat jualan naskah.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Maklumat jualan naskah berjaya diHantar")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function UpdateStatus_Dok_Permohonan_Hdr_NJ(txtNoMohonH As String, txtStatusDokH As String, txtFlag_PenentuanTeknikal As String)
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = @Status_Dok , Flag_PenentuanTeknikal= @Flag_PenentuanTeknikal  WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonH))
        param.Add(New SqlParameter("@Status_Dok", txtStatusDokH))
        param.Add(New SqlParameter("@Flag_PenentuanTeknikal", txtFlag_PenentuanTeknikal))


        Return db.Process(query, param)
    End Function

    'HantarProcessJN

    'Dropdown Kategori CIDB_Gred START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCIDB_Gred(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodCIDB_Gred(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodCIDB_Gred(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Gred as value, Butiran as text FROM SMKB_Syarikat_CIDB_Gred"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function
    'Dropdown Kategori CIDB_Gred END


    ' LoadPesanan_Pembelian SART

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPesanan_Pembelian(category_filter As String, isClick As Boolean) As String
        Dim resp As New ResponseRepository

        If (isClick = False) Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        If (category_filter = "") Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_Pesanan_Pembelian(category_filter)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_Pembelian(category_filter As String) As DataTable
        Dim db = New DBKewConn
        Dim kod_status As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'KESELURUHAN
            kod_status = " "
        ElseIf category_filter = "2" Then ' DAFTAR PESANAN BELIAN
            kod_status = " AND  B.status_dok = '46' "
        ElseIf category_filter = "3" Then ' DFTAR JUALAN NASKAH
            kod_status = " AND  B.status_dok = '34' "
        ElseIf category_filter = "4" Then 'PROSES JUALN NASKAH
            kod_status = " AND  B.status_dok = '35' "
        ElseIf category_filter = "5" Then 'TERIMAAN DOKUMENN
            kod_status = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'BATAL JUALAN NASKAH
            kod_status = " AND  B.status_dok = '36' "

            param = New List(Of SqlParameter)
        End If


        Dim query = "Select 
                         (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PO03' AND Kod_Detail = Jenis_Barang ) As Kategori,
                         (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = '02' AND Kod_Status_Dok = A.Status_Dok ) As Status_Dtl,
                        * from 
                        SMKB_Perolehan_Permohonan_Hdr A
                        Inner Join SMKB_Perolehan_Permohonan_Dtl As B on B.No_Mohon =A.No_Mohon
                        where a.Status_Dok ='08' and a.Flag_PenentuanTeknikal IS NULL and a.No_Perolehan like 'PB%' and a.Status ='1'
                        order by a.No_Perolehan"

        'Dim query = "


        '            SELECT 
        '            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PO03' AND Kod_Detail = Jenis_Barang ) As Kategori,
        '            (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = '02' AND Kod_Status_Dok = PH.Status_Hantar ) As Status_Dtl,
        '            * 
        '            FROM SMKB_Perolehan_Permohonan_Hdr As A
        '            LEFT JOIN SMKB_Perolehan_Pembelian_Hdr As PH On  A.No_Mohon = PH.No_Mohon
        '            WHERE A.Status_Dok = '08' 
        '            And (PH.Status_Hantar = '46' or PH.Status_Hantar IS NULL)
        '            AND Flag_PenentuanTeknikal = '1' 
        '            AND No_Perolehan LIKE ('PB%') 

        '            " & kod_status & "
        '            ORDER BY A.No_Mohon

        ' "

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPesanan_PembelianDS(category_filter As String, isClick As Boolean) As String
        Dim resp As New ResponseRepository

        If (isClick = False) Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        If (category_filter = "") Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_Pesanan_PembelianDS(category_filter)



        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_PembelianDS(category_filter As String) As DataTable
        Dim db = New DBKewConn
        Dim kod_status As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'KESELURUHAN
            kod_status = " "
        ElseIf category_filter = "2" Then ' LULUS PERMOHONAN PEMBELIAN
            kod_status = " AND  B.status_dok = '08' "
        ElseIf category_filter = "3" Then ' DFTAR JUALAN NASKAH
            kod_status = " AND  B.status_dok = '34' "
        ElseIf category_filter = "4" Then 'PROSES JUALN NASKAH
            kod_status = " AND  B.status_dok = '35' "
        ElseIf category_filter = "5" Then 'TERIMAAN DOKUMENN
            kod_status = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'BATAL JUALAN NASKAH
            kod_status = " AND  B.status_dok = '36' "

            param = New List(Of SqlParameter)
        End If

        Dim query = "
                    SELECT FORMAT(SUM(A.Jumlah_Harga),'0.00') AS tot_Jumlah_Harga, CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB, 
                    (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = B.status_dok) AS status_dok_butiran,
                    B.No_Mohon, B.Tujuan, B.Jenis_Barang, B.Status_Dok, B.Flag_PenentuanTeknikal, B.No_Perolehan,
                    C.Id_Jualan, C.Tarikh_Masa_Mula_Iklan,C.Tarikh_Masa_Tamat_Perolehan,C.Status_Lanjut
                    FROM SMKB_Perolehan_Permohonan_Hdr as B
                    LEFT JOIN  SMKB_Perolehan_Permohonan_Dtl as A ON A.No_Mohon = B.No_Mohon
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON B.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                    LEFT JOIN  SMKB_Perolehan_Naskah_Jualan AS C ON B.No_Mohon = C.No_Mohon
                    where ( (B.Status_Dok IN ('07') AND B.Flag_PenentuanTeknikal IN ('0')) OR (B.Status_Dok IN ('08') AND B.Flag_PenentuanTeknikal IN ('0')) or (B.Status_Dok IN ('31') AND B.Flag_PenentuanTeknikal IN ('1'))
                    or (B.Status_Dok IN ('34') AND B.Flag_PenentuanTeknikal IN ('1')) or (B.Status_Dok IN ('35') AND B.Flag_PenentuanTeknikal IN ('1')) ) 
                    AND B.No_Perolehan LIKE 'PS%'
                    " & kod_status & "
                    group by B.No_Mohon, B.Tujuan, B.Jenis_Barang, B.Status_Dok,B.Flag_PenentuanTeknikal,B.No_Perolehan, kategori.Kod_Detail, kategori.Butiran, 
                    C.Id_Jualan, C.Tarikh_Masa_Mula_Iklan,C.Tarikh_Masa_Tamat_Perolehan,C.Status_Lanjut
        
         "

        Return db.Read(query, param)
    End Function

    ' LoadPesanan_Pembelian END


    ' LoadMaklumat_Pesanan_Pembelian SART

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMaklumat_Pesanan_Pembelian(IdMohon As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Maklumat_Pesanan_Pembelian(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Maklumat_Pesanan_Pembelian(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                    SELECT 
                    PH.Id_Pembelian,PH.No_Mohon,PH.Kod_Syarikat, PH.Tarikh_Beli,PH.Tempoh,PH.Jenis_Tempoh,PH.Status_Hantar,Format(PH.Tarikh_Mula,'yyyy-MM-dd') Tarikh_Mula,
                    Format(PH.Tarikh_Tamat,'yyyy-MM-dd')Tarikh_Tamat,PH.ID_Syarikat,PH.Pelulus_PO,
                    PM.Kod_Pemiutang, b.No_Mohon As NoMohonUN,
                    (SELECT Nama as text FROM VKetuaPTJ  WHERE Nostaf = PH.Pelulus_PO) AS Nama_Pelulus,
                    (SELECT Jawatan FROM VKetuaPTJ  WHERE Nostaf = PH.Pelulus_PO) AS JawatanPelulus,
                    CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB, SMSM.MS01_Nama As Nama, 
                    CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP, 
                    (SELECT CONCAT(ID_Sykt, ' - ', Nama_Sykt) as text FROM SMKB_Syarikat_Master  WHERE ID_Sykt = PH.ID_Syarikat) AS Nama_Sykt_butiran,
                    (SELECT  Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = 'PO05' AND Kod_Detail = PH.Jenis_Tempoh) AS Nama_Jenis_Tempoh,
                    SMSM.JawGiliran,
                    (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = 02 AND Kod_Status_Dok = PH.Status_Hantar) AS status_dok_butiran,
                    PH.Kod_Syarikat as KodSykt, 
                    B.* 
                    FROM SMKB_Perolehan_Permohonan_Hdr as B
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON B.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                    LEFT JOIN VPeribadi As SMSM ON B.Id_Pemohon = SMSM.MS01_NoStaf
                    LEFT JOIN SMKB_Perolehan_Pembelian_Hdr As PH On  B.No_Mohon = PH.No_Mohon
                    LEFT JOIN SMKB_Pemiutang_Master AS PM ON PH.ID_Syarikat = PM.No_Rujukan
                     where B.No_Mohon = @IdMohon
                     order by B.No_Mohon
            "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' LoadMaklumat_Pesanan_Pembelian END

    'Load DataTable tblMaklumat_PerolehanDtl START
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_Maklumat_PerolehanDtl(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_Maklumat_PerolehanDtl(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_Maklumat_PerolehanDtl(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "
            SELECT A.Id_Mohon_Dtl, A.Kod_Kump_Wang, A.Kod_Operasi, A.Kod_Ptj, A.Kod_Projek, A.Kod_Vot, FORMAT(A.Baki_Peruntukan, '0.00') as Baki_Peruntukan, A.Butiran,
            FORMAT(A.Jumlah_Harga,'0.00') AS Jumlah_Harga_A, 
            FORMAT(B.Jumlah_Harga,'0.00') AS Jumlah_Harga_B,
            FORMAT(b.Harga_Seunit,'0.00') AS  Harga_Seunit_B,
            FORMAT(b.Jumlah_Harga_Bercukai,'0.00') AS  Jumlah_Harga_Bercukai_B,
            A.Kuantiti, A.Ukuran, FORMAT(A.Kadar_Harga,'0.00') AS Kadar_Harga, FORMAT(A.Jumlah_Harga,'0.00') AS Jumlah_Harga, B.* 
			FROM SMKB_Perolehan_Permohonan_Dtl As A
			LEFT JOIN SMKB_Perolehan_Pembelian_Dtl As B On A.Id_Mohon_Dtl = B.Id_Mohon_Dtl
            WHERE No_Mohon = @nombor_mohon
        "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@nombor_mohon", id))

        Return db.Read(query, param)
    End Function
    'Load DataTable tblMaklumat_PerolehanDtl END

    'Dropdown Kategori Negara START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetNegara(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodNegara(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodNegara(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Detail as kodValue, Kod_Detail + ' - ' + Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = '0001'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Dropdown Kategori Negara END

    'Dropdown  Jenis Tempoh START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenis_Tempoh(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodJenis_Tempoh(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodJenis_Tempoh(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Detail as kodValue,  Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = 'PO05'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Dropdown  Jenis Tempoh END

    'Load data for Update Row DataTable tblDataPerolehanDtl START
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPoDtlMaklumat_PerolehanDtl(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = Query_loadPoDtlMaklumat_PerolehanDtl(id)
        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function Query_loadPoDtlMaklumat_PerolehanDtl(id As String) As DataTable
        Dim db = New DBKewConn

        'Dim query As String = "
        '                    SELECT a.Kod_Vot, vot.Butiran as Butiran_vot, 
        '                    a.Kod_Ptj, mj.Pejabat as Butiran_ptj, 
        '                    a.Kod_Kump_Wang, kw.Butiran As Butiran_kw,
        '                    a.Kod_Operasi, ko.Butiran As Butiran_ko,
        '                    a.Kod_Projek, kp.Butiran as Butiran_kp, 
        '                    a.Ukuran, ukur.Butiran as Butiran_ukuran,
        '                    a.Butiran, a.Kuantiti, 
        '                    FORMAT(a.Kadar_Harga,'0.00') AS  Kadar_Harga_A,
        '                    FORMAT(a.Jumlah_Harga,'0.00') AS Jumlah_Harga_A, 
        '                    FORMAT(PB.Harga_Seunit,'0.00') AS  Harga_Seunit_PB,
        '                    FORMAT(PB.Jumlah_Harga,'0.00') AS Jumlah_Harga_PB,
        '                    FORMAT(a.Baki_Peruntukan,'0.00') AS Baki_Peruntukan,
        '                    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0001' AND Kod_Detail = PB.Kod_Negara_Pembuat ) As Negara_Pembuat,
        '                    PB.Id_Mohon_Dtl as Id_Mohon_Dtl_PB,
        '                    PB.*,
        '                    PH.*
        '                    FROM SMKB_Perolehan_Permohonan_Dtl AS a
        '                    INNER JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
        '                    INNER JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_Ptj,2) 
        '                    INNER JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
        '                    INNER JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
        '                    INNER JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
        '                    INNER JOIN SMKB_Lookup_Detail as ukur on ukur.Kod='PO06' AND ukur.Kod_Detail = a.Ukuran
        '                    LEFT JOIN SMKB_Perolehan_Pembelian_Dtl As PB On A.Id_Mohon_Dtl = PB.Id_Mohon_Dtl
        '                    INNER JOIN SMKB_Perolehan_Permohonan_Hdr As ah On ah.No_Mohon  =  a.No_Mohon 
        '                    LEFT JOIN SMKB_Perolehan_Pembelian_Hdr As PH On ah.No_Mohon = PH.No_Mohon
        '                    WHERE a.Id_Mohon_Dtl = @id_mohon_dtl;
        '"


        Dim query As String = "SELECT a.Kod_Vot, vot.Butiran as Butiran_vot, 
                                a.Kod_Ptj, mj.Pejabat as Butiran_ptj, 
                                a.Kod_Kump_Wang, kw.Butiran As Butiran_kw,
                                a.Kod_Operasi, ko.Butiran As Butiran_ko,
                                a.Kod_Projek, kp.Butiran as Butiran_kp, 
                                a.Ukuran, ukur.Butiran as Butiran_ukuran,
                                a.Butiran, a.Kuantiti, 
                                FORMAT(a.Kadar_Harga,'0.00') AS  Kadar_Harga_A,
                                FORMAT(a.Jumlah_Harga,'0.00') AS Jumlah_Harga_A, 
                                FORMAT(PB.Harga_Seunit,'0.00') AS  Harga_Seunit_PB,
                                FORMAT(PB.Jumlah_Harga,'0.00') AS Jumlah_Harga_PB,
                                FORMAT(a.Baki_Peruntukan,'0.00') AS Baki_Peruntukan,
                                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0001' AND Kod_Detail = PB.Kod_Negara_Pembuat ) As Negara_Pembuat,
                                PB.Id_Mohon_Dtl as Id_Mohon_Dtl_PB,
                                PB.*,
                                PH.*
                                FROM SMKB_Perolehan_Permohonan_Dtl AS a
                                INNER JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                                INNER JOIN VPejabat AS mj On mj.kodpejabat = left(a.Kod_Ptj,2) 
                                INNER JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                                INNER JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                                INNER JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
                                INNER JOIN SMKB_Lookup_Detail as ukur on ukur.Kod='PO06' AND ukur.Kod_Detail = a.Ukuran
                                LEFT JOIN SMKB_Perolehan_Pembelian_Dtl As PB On A.Id_Mohon_Dtl = PB.Id_Mohon_Dtl
                                INNER JOIN SMKB_Perolehan_Permohonan_Hdr As ah On ah.No_Mohon  =  a.No_Mohon 
                                LEFT JOIN SMKB_Perolehan_Pembelian_Hdr As PH On ah.No_Mohon = PH.No_Mohon
                                WHERE a.Id_Mohon_Dtl = @id_mohon_dtl "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id_mohon_dtl", id))

        Return db.Read(query, param)
    End Function
    'Load data for Update Row DataTable tblDataPerolehanDtl END

    'Update data (Maklumat Pesanan_belian) START
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdatePO_Pesanan_belian(pembelianPoDetail As PembelianPoDtl) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If pembelianPoDetail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If pembelianPoDetail.id_MohonDTL_PB = "" Then

            If Query_InsertPO_belian_Dtl(pembelianPoDetail) <> "OK" Then
                resp.Failed("Gagal menghantar permohonan perolehan.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        Else

            If Query_UpdatePO_belian_Dtl(pembelianPoDetail) <> "OK" Then
                resp.Failed("Gagal mengemaskini order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If
            'Koding untuk update
        End If

        resp.Success("Rekod berjaya dikemaskini", "00", pembelianPoDetail)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function Query_InsertPO_belian_Dtl(pembelianPoDetail As PembelianPoDtl) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembelian_Dtl (Id_Mohon_Dtl, Kuantiti, Harga_Seunit, Jenama, Model, Kod_Negara_Pembuat, Flag_SST, Id_Pembelian, Jumlah_Harga, Jumlah_Harga_Bercukai, Harga_Seunit_Bercukai)
            VALUES(@idMohonDtl, @txtKuantiti, @txtAngHrgSeunit, @txtJenama_update, @txtModal_update, @ddlNegara_Pembuat_update, @txtFlag_sst, @ddlId_Pembelian, @txtJumAngHrg, @txtJumAngHrgSST, @txtAngHrgSeunitSST )
                                "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idMohonDtl", pembelianPoDetail.id_mohonDtl))
        param.Add(New SqlParameter("@coa_vot", pembelianPoDetail.coa_vot))
        param.Add(New SqlParameter("@ddlPTj", pembelianPoDetail.ddlPTj))
        param.Add(New SqlParameter("@ddlKW", pembelianPoDetail.ddlKW))
        param.Add(New SqlParameter("@ddlKodOperasi", pembelianPoDetail.ddlKodOperasi))
        param.Add(New SqlParameter("@ddlKodProjek", pembelianPoDetail.ddlKodProjek))
        param.Add(New SqlParameter("@txtPerkara", pembelianPoDetail.txtPerkara))
        param.Add(New SqlParameter("@txtKuantiti", pembelianPoDetail.txtKuantiti))
        param.Add(New SqlParameter("@ddlUkuran", pembelianPoDetail.ddlUkuran))
        param.Add(New SqlParameter("@txtAngHrgSeunit", pembelianPoDetail.txtAngHrgSeunit))
        param.Add(New SqlParameter("@txtJumAngHrg", pembelianPoDetail.txtJumAngHrg))
        param.Add(New SqlParameter("@txtModal_update", pembelianPoDetail.txtModal_update))
        param.Add(New SqlParameter("@txtJenama_update", pembelianPoDetail.txtJenama_update))
        param.Add(New SqlParameter("@ddlNegara_Pembuat_update", pembelianPoDetail.ddlNegara_Pembuat_update))
        param.Add(New SqlParameter("@txtFlag_sst", pembelianPoDetail.txtFlag_sst))
        param.Add(New SqlParameter("@ddlId_Pembelian", pembelianPoDetail.ddlId_Pembelian))
        param.Add(New SqlParameter("@txtAngHrgSeunitSST", pembelianPoDetail.txtAngHrgSeunitSST))
        param.Add(New SqlParameter("@txtJumAngHrgSST", pembelianPoDetail.txtJumAngHrgSST))

        Return db.Process(query, param)
    End Function

    Private Function Query_UpdatePO_belian_Dtl(pembelianPoDetail As PembelianPoDtl) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Dtl
                              SET Kuantiti=@txtKuantiti, Harga_Seunit=@txtAngHrgSeunit, Jenama=@txtJenama_update, Model=@txtModal_update, Kod_Negara_Pembuat=@ddlNegara_Pembuat_update , Flag_SST=@txtFlag_sst, Id_Pembelian=@ddlId_Pembelian, Jumlah_Harga=@txtJumAngHrg, Jumlah_Harga_Bercukai=@txtJumAngHrgSST, Harga_Seunit_Bercukai=@txtAngHrgSeunitSST
                              WHERE Id_Mohon_Dtl = @idMohonDtl"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idMohonDtl", pembelianPoDetail.id_mohonDtl))
        param.Add(New SqlParameter("@coa_vot", pembelianPoDetail.coa_vot))
        param.Add(New SqlParameter("@ddlPTj", pembelianPoDetail.ddlPTj))
        param.Add(New SqlParameter("@ddlKW", pembelianPoDetail.ddlKW))
        param.Add(New SqlParameter("@ddlKodOperasi", pembelianPoDetail.ddlKodOperasi))
        param.Add(New SqlParameter("@ddlKodProjek", pembelianPoDetail.ddlKodProjek))
        param.Add(New SqlParameter("@txtPerkara", pembelianPoDetail.txtPerkara))
        param.Add(New SqlParameter("@txtKuantiti", pembelianPoDetail.txtKuantiti))
        param.Add(New SqlParameter("@ddlUkuran", pembelianPoDetail.ddlUkuran))
        param.Add(New SqlParameter("@txtAngHrgSeunit", pembelianPoDetail.txtAngHrgSeunit))
        param.Add(New SqlParameter("@txtJumAngHrg", pembelianPoDetail.txtJumAngHrg))
        param.Add(New SqlParameter("@txtModal_update", pembelianPoDetail.txtModal_update))
        param.Add(New SqlParameter("@txtJenama_update", pembelianPoDetail.txtJenama_update))
        param.Add(New SqlParameter("@ddlNegara_Pembuat_update", pembelianPoDetail.ddlNegara_Pembuat_update))
        param.Add(New SqlParameter("@txtFlag_sst", pembelianPoDetail.txtFlag_sst))
        param.Add(New SqlParameter("@ddlId_Pembelian", pembelianPoDetail.ddlId_Pembelian))
        param.Add(New SqlParameter("@txtAngHrgSeunitSST", pembelianPoDetail.txtAngHrgSeunitSST))
        param.Add(New SqlParameter("@txtJumAngHrgSST", pembelianPoDetail.txtJumAngHrgSST))

        Return db.Process(query, param)
    End Function
    'Update data (Maklumat Pesanan_belian) END

    'updata SMKB_Perolehan_Pembelian_Hdr START
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function UpdatePO_Pesanan_belian_Hdr(pembelianPoHeder As PembelianPoHdr, rowDataArray As LulusPBHdr()) As Tasks.Task(Of String)
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If pembelianPoHeder Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If pembelianPoHeder.ddlId_Pembelian = "" Then
            Dim noIdPembelian As String = GenerateNoPembelian(pembelianPoHeder.txtPTJ_Mohon, 0)
            pembelianPoHeder.ddlId_Pembelian = noIdPembelian

            If Query_InsertPO_belian_Hdr(pembelianPoHeder) <> "OK" Then
                resp.Failed("Gagal menghantar permohonan perolehan.")
                GenerateNoPembelian(pembelianPoHeder.txtPTJ_Mohon, 1)
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        Else

            If Query_UpdatePO_belian_Hdr(pembelianPoHeder) <> "OK" Then
                resp.Failed("Gagal mengemaskini order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If
            'Koding untuk update
        End If

        resp.Success("Rekod berjaya dikemaskini", "00", pembelianPoHeder)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function Query_InsertPO_belian_Hdr(pembelianPoHeder As PembelianPoHdr) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembelian_Hdr (Id_Pembelian, No_Mohon, Kod_Syarikat, Tempoh, Jenis_Tempoh, Tarikh_Mula, Tarikh_Tamat, ID_Syarikat ,  Id_Jualan , Status,  Tarikh_Beli)
            VALUES(@Id_Pembelian, @No_Mohon, @Kod_Syarikat, @Tempoh, @Jenis_Tempoh, @Tarikh_Terima, @Tarikh_Hantar, @ID_Syarikat,'-',1,@Tarikh_Beli)
                                "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Pembelian", pembelianPoHeder.ddlId_Pembelian))
        param.Add(New SqlParameter("@No_Mohon", pembelianPoHeder.ddlNo_Mohon))
        param.Add(New SqlParameter("@Kod_Syarikat", pembelianPoHeder.ddlKod_Syarikat))
        param.Add(New SqlParameter("@Tempoh", pembelianPoHeder.ddlTempoh))
        param.Add(New SqlParameter("@Jenis_Tempoh", pembelianPoHeder.ddlJenis_Tempoh))
        param.Add(New SqlParameter("@Tarikh_Terima", pembelianPoHeder.ddlTarikh_Terima))
        param.Add(New SqlParameter("@Tarikh_Hantar", pembelianPoHeder.ddlTarikh_Hantar))
        param.Add(New SqlParameter("@ID_Syarikat", pembelianPoHeder.ddlID_Syarikat))
        param.Add(New SqlParameter("@Tarikh_Beli", pembelianPoHeder.ddlTarikh_Beli))



        Return db.Process(query, param)
    End Function

    Private Function Query_UpdatePO_belian_Hdr(pembelianPoHeder As PembelianPoHdr) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr
                              SET  Kod_Syarikat= @Kod_Syarikat, Tempoh= @Tempoh, 
                                  Jenis_Tempoh= @Jenis_Tempoh, Tarikh_Mula= @Tarikh_Terima, 
                                  Tarikh_Tamat= @Tarikh_Hantar, ID_Syarikat= @ID_Syarikat
                              WHERE Id_Pembelian = @Id_Pembelian"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Pembelian", pembelianPoHeder.ddlId_Pembelian))
        param.Add(New SqlParameter("@No_Mohon", pembelianPoHeder.ddlNo_Mohon))
        param.Add(New SqlParameter("@Kod_Syarikat", pembelianPoHeder.ddlKod_Syarikat))
        param.Add(New SqlParameter("@Tempoh", pembelianPoHeder.ddlTempoh))
        param.Add(New SqlParameter("@Jenis_Tempoh", pembelianPoHeder.ddlJenis_Tempoh))
        param.Add(New SqlParameter("@Tarikh_Terima", pembelianPoHeder.ddlTarikh_Terima))
        param.Add(New SqlParameter("@Tarikh_Hantar", pembelianPoHeder.ddlTarikh_Hantar))
        param.Add(New SqlParameter("@ID_Syarikat", pembelianPoHeder.ddlID_Syarikat))


        Return db.Process(query, param)
    End Function


    Private Function GenerateNoPembelian(ddlPTJPemohon As String, no_check As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoMohon As String = ""
        Dim ptj = ddlPTJPemohon

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='MS' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If (no_check = "1") Then
            lastID = CInt(dt.Rows(0).Item("id")) - 1

            UpdateNoAkhirVNJ("02", "MS", year, lastID, ptj)
        Else
            If dt.Rows.Count > 0 Then
                lastID = CInt(dt.Rows(0).Item("id")) + 1

                UpdateNoAkhirVNJ("02", "MS", year, lastID, ptj)
            Else

                InsertNoAkhirVNJ("02", "MS", year, lastID, ptj)
            End If
        End If



        newNoMohon = "MS" + ptj.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoMohon
    End Function

    Private Function UpdateNoAkhirVNJ(kodModul As String, prefix As String, year As String, ID As String, Kod_PTJ As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir, Kod_PTJ = @Kod_PTJ
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Kod_PTJ", Kod_PTJ))


        Return db.Process(query, param)
    End Function

    Private Function InsertNoAkhirVNJ(kodModul As String, prefix As String, year As String, ID As String, Kod_PTJ As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Pesanan Belian"))
        param.Add(New SqlParameter("@Kod_PTJ", Kod_PTJ))


        Return db.Process(query, param)
    End Function

    'updata SMKB_Perolehan_Pembelian_Hdr END


    'Dropdown Pelulus START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPelulus(ByVal q As String, Kod_Perjabat As String) As String
        Dim tmpDT As DataTable = GetKodPelulus(q, Kod_Perjabat)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodPelulus(kod As String, Kod_Perjabat As String) As DataTable
        Dim db = New DBKewConn
        Dim kod_ptj = "'" + Kod_Perjabat + "'"
        Dim query As String = " SELECT Nostaf as kodValue, Nama as text, Jawatan FROM VKetuaPTJ WHERE Pejabat = @Kod_Perjabat"

        Dim param As New List(Of SqlParameter)

        If Kod_Perjabat <> "" Then
            query &= " AND (Nostaf LIKE '%' + @kod + '%' OR Nama LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
            param.Add(New SqlParameter("@Kod_Perjabat", Kod_Perjabat))
        End If

        Return db.Read(query, param)
    End Function

    'Dropdown  Pelulus END


    ' START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiPembelian_CT(category_filter As String, isClicked7 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked7 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SenaraiPembelian_CT(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SenaraiPembelian_CT(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Beli AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Beli AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Beli AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Beli >= DATEADD(month, -1, getdate()) and a.Tarikh_Beli <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Beli >= DATEADD(month, -2, getdate()) and a.Tarikh_Beli <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Beli >= @tkhMula and a.Tarikh_Beli <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If


        Dim query As String = "

                                SELECT FORMAT(SUM(D.Jumlah_Harga),'0.00') AS tot_Jumlah_Harga,
                                A.No_Mohon, A.Id_Pembelian, A.Tarikh_Beli, B.Tujuan, C.Nama_Sykt
                                FROM SMKB_Perolehan_Pembelian_Hdr AS A
                                INNER JOIN SMKB_Perolehan_Permohonan_Hdr AS B ON A.No_Mohon = B.No_Mohon
                                INNER JOIN SMKB_Syarikat_Master AS C ON A.Id_Syarikat = C.ID_Sykt
                                INNER JOIN SMKB_Perolehan_Permohonan_Dtl AS D ON B.No_Mohon = D.No_Mohon
                                where  a.Status_Hantar = '46'  " & tarikhQuery & "
                                GROUP BY A.No_Mohon, A.Id_Pembelian, A.Tarikh_Beli, B.Tujuan, C.Nama_Sykt
                               
                                "

        Return db.Read(query, param)
    End Function
    ' END

    ' LoadPerolehan_Pembelian_print START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pembelian_print_Dtl(IdPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = GetOrder_Pembelian_print_Dtl(IdPembelian)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pembelian_print_Dtl(IdPembelian As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                 SELECT 
                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0003' AND Kod_Detail = Bandar_Semasa ) As Bandar_name,
                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0002' AND Kod_Detail = Kod_Negeri_Semasa ) As Negeri_name,
                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0001' AND Kod_Detail = Kod_Negara_Semasa ) As Negara_name,
                *
                FROM SMKB_Perolehan_Pembelian_Hdr As A
                INNER JOIN SMKB_Perolehan_Permohonan_Hdr As B On A.No_Mohon = B.No_Mohon
                INNER JOIN SMKB_Syarikat_Master As C On A.Id_Syarikat = C.ID_Sykt
                INNER JOIN VPeribadi As E On E.MS01_NoStaf = B.Id_Pemohon
                where A.Id_Pembelian = @IdPembelian
                
            "
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdPembelian", IdPembelian))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' LoadPerolehan_Pembelian_print END

    ' LoadPerolehan_Pembelian_print START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pembelian_print(IdPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = GetOrder_Pembelian_print(IdPembelian)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pembelian_print(IdPembelian As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "

                SELECT (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= 'SI003' AND Kod_Detail = D.Ukuran ) As Unit_Ukuran, *
                FROM SMKB_Perolehan_Pembelian_Hdr AS A
                INNER JOIN SMKB_Perolehan_Permohonan_Hdr AS B ON A.No_Mohon = B.No_Mohon
                INNER JOIN SMKB_Syarikat_Master AS C ON A.ID_Syarikat = C.ID_Sykt
                INNER JOIN SMKB_Perolehan_Permohonan_Dtl AS D ON B.No_Mohon = D.No_Mohon
                INNER JOIN SMKB_Perolehan_Pembelian_Dtl AS E ON D.Id_Mohon_Dtl = E.Id_Mohon_Dtl
                where A.Id_Pembelian =  @IdPembelian
                
            "
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdPembelian", IdPembelian))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' LoadPerolehan_Pesanan_print END

    'updata UpdateHantar_Pesanan_belian_Hdr START
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function UpdateHantar_Pesanan_belian_Hdr(pembelianPoHeder As PembelianPoHdr, rowDataArray As LulusPBHdr()) As Tasks.Task(Of String)
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If pembelianPoHeder Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If UpdatePO_belian_Hdr(pembelianPoHeder) <> "OK" Then
            resp.Failed("Gagal mengemaskini order")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If

        If UpdateStatus_Permohonan_Hdr_PB(pembelianPoHeder) <> "OK" Then
            resp.Failed("Gagal mengemaskini order")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If

        For Each item As Object In rowDataArray
            Try
                Dim servicex As New ValuesService()
                Dim kodkw As String = item.Kod_Kump_Wang
                Dim kodko As String = item.Kod_Operasi
                Dim kodkp As String = item.Kod_Projek
                Dim kodptj As String = item.Kod_Ptj
                Dim KodVot As String = item.Kod_Vot
                Dim Jumlah_Harga As String = item.Jumlah_Harga

                Dim myGetTicket As New TokenResponseModel()

                Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")
                Dim parsedDate As Date = CDate(Now()).ToString("yyyy-MM-dd")
                Dim vBulan As String = parsedDate.Month
                Dim vTahun As String = parsedDate.Year
                Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "GL", "UTeM", kodkw, kodptj,
                                 KodVot, kodko, kodkp, Jumlah_Harga, "DR", vBulan, vTahun)
                If values.Contains("ok") Then

                    '    'lblModalMessaage.Text = "Rekod telah disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)

                Else
                    '    'lblModalMessaage.Text = "Rekod Gagal disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                End If

            Catch ex As Exception
                resp.Failed("Maklumat gagal disimpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End Try
        Next


        For Each item As Object In rowDataArray
            Try
                Dim servicex As New ValuesService()
                Dim kodkw As String = item.Kod_Kump_Wang
                Dim kodko As String = item.Kod_Operasi
                Dim kodkp As String = item.Kod_Projek
                Dim kodptj As String = item.Kod_Ptj
                Dim KodVot As String = item.Kod_Vot
                Dim Jumlah_Harga As String = item.Jumlah_Harga


                Dim myGetTicket As New TokenResponseModel()

                Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")
                Dim parsedDate As Date = CDate(Now()).ToString("yyyy-MM-dd")
                Dim vBulan As String = parsedDate.Month
                Dim vTahun As String = parsedDate.Year
                Dim kodPemiutang As String = pembelianPoHeder.ddlKod_Pemiutang
                Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "AP", pembelianPoHeder.ddlKod_Pemiutang, kodkw, kodptj,
                                 KodVot, kodko, kodkp, Jumlah_Harga, "DR", vBulan, vTahun)
                If values.Contains("ok") Then

                    '    'lblModalMessaage.Text = "Rekod telah disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)

                Else
                    '    'lblModalMessaage.Text = "Rekod Gagal disimpan" 'message di modal
                    '    ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)

                End If

            Catch ex As Exception
                resp.Failed("Maklumat gagal disimpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End Try
        Next

        resp.Success("Rekod berjaya dikemaskini", "00", pembelianPoHeder)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateStatus_Permohonan_Hdr_PB(pembelianPoHeder As PembelianPoHdr)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '46' WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", pembelianPoHeder.ddlNo_Mohon))

        Return db.Process(query, param)
    End Function

    Private Function UpdatePO_belian_Hdr(pembelianPoHeder As PembelianPoHdr) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr
                              SET  Pelulus_PO= @Pelulus_PO, Status_Hantar= '46'
                              WHERE Id_Pembelian = @Id_Pembelian"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Pelulus_PO", pembelianPoHeder.ddlPelulus_PO))
        param.Add(New SqlParameter("@Id_Pembelian", pembelianPoHeder.ddlId_Pembelian))

        Return db.Process(query, param)
    End Function

    'updata UpdateHantar_Pesanan_belian_Hdr END

    ' LoadPesanan_Pembelian_batal START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPesanan_Pembelian_batal(category_filter As String, isClick As Boolean) As String
        Dim resp As New ResponseRepository

        If (isClick = False) Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        If (category_filter = "") Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_Pesanan_Pembelian_batal(category_filter)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_Pembelian_batal(category_filter As String) As DataTable
        Dim db = New DBKewConn
        Dim kod_status As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'KESELURUHAN
            kod_status = " "
        ElseIf category_filter = "2" Then ' DAFTAR PESANAN BELIAN
            kod_status = " AND  PH.status_dok = '46' "
        ElseIf category_filter = "3" Then ' DFTAR JUALAN NASKAH
            kod_status = " AND  PH.status_dok = '34' "
        ElseIf category_filter = "4" Then 'PROSES JUALN NASKAH
            kod_status = " AND  PH.status_dok = '35' "
        ElseIf category_filter = "5" Then 'TERIMAAN DOKUMENN
            kod_status = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'BATAL JUALAN NASKAH
            kod_status = " AND  PH.status_dok = '36' "

            param = New List(Of SqlParameter)
        End If

        Dim query = "
                     SELECT 
                     (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PO03' AND Kod_Detail = Jenis_Barang ) As Kategori,
                     (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = '02' AND Kod_Status_Dok = PH.Status_Hantar ) As Status_Dtl,
                     * 
                     FROM SMKB_Perolehan_Permohonan_Hdr As A
                     LEFT JOIN SMKB_Perolehan_Pembelian_Hdr As PH On  A.No_Mohon = PH.No_Mohon
                     WHERE Status_Dok = '08' 
                     AND Flag_PenentuanTeknikal = '1' 
                     AND A.No_Perolehan LIKE ('PB%') 
                     AND PH.Status_Hantar = '46' 
                    " & kod_status & "
                    ORDER BY A.No_Mohon
         "

        'Dim query = " SELECT 
        '             (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PO03' AND Kod_Detail = Jenis_Barang ) As Kategori,
        '             (SELECT Butiran FROM SMKB_Kod_Status_Dok WHERE Kod_Modul = '02' AND Kod_Status_Dok = PH.Status_Hantar ) As Status_Dtl,* 
        '             FROM SMKB_Perolehan_Permohonan_Hdr As A
        '             LEFT JOIN SMKB_Perolehan_Pembelian_Hdr As PH On  A.No_Mohon = PH.No_Mohon
        '             WHERE Status_Dok = '08' 
        '             AND A.Flag_PenentuanTeknikal = '1' 
        '             AND A.No_Perolehan LIKE ('PB%') 
        '             " & kod_status & "
        '             ORDER BY A.No_Mohon "

        Return db.Read(query, param)
    End Function
    ' LoadPesanan_Pembelian_batal END

    'updata UpdateHantar_Pesanan_belian_Hdr_batal START
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function UpdateHantar_Pesanan_belian_Hdr_batal(pembelianPoHeder As PembelianPoHdr, rowDataArray As LulusPBHdr()) As Tasks.Task(Of String)
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If pembelianPoHeder Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If UpdatePO_belian_Hdr_batal(pembelianPoHeder) <> "OK" Then
            resp.Failed("Gagal mengemaskini order")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If

        For Each item As Object In rowDataArray
            Try
                Dim servicex As New ValuesService()
                Dim kodkw As String = item.Kod_Kump_Wang
                Dim kodko As String = item.Kod_Operasi
                Dim kodkp As String = item.Kod_Projek
                Dim kodptj As String = item.Kod_Ptj
                Dim KodVot As String = item.Kod_Vot
                Dim Jumlah_Harga As String = item.Jumlah_Harga

                Dim myGetTicket As New TokenResponseModel()

                Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")
                Dim parsedDate As Date = CDate(Now()).ToString("yyyy-MM-dd")
                Dim vBulan As String = parsedDate.Month
                Dim vTahun As String = parsedDate.Year
                Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "GL", "UTeM", kodkw, kodptj,
                                 KodVot, kodko, kodkp, Jumlah_Harga, "CR", vBulan, vTahun)
                If values.Contains("ok") Then

                    '    'lblModalMessaage.Text = "Rekod telah disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)

                Else
                    '    'lblModalMessaage.Text = "Rekod Gagal disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                End If

            Catch ex As Exception
                resp.Failed("Maklumat gagal disimpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End Try
        Next


        For Each item As Object In rowDataArray
            Try
                Dim servicex As New ValuesService()
                Dim kodkw As String = item.Kod_Kump_Wang
                Dim kodko As String = item.Kod_Operasi
                Dim kodkp As String = item.Kod_Projek
                Dim kodptj As String = item.Kod_Ptj
                Dim KodVot As String = item.Kod_Vot
                Dim Jumlah_Harga As String = item.Jumlah_Harga


                Dim myGetTicket As New TokenResponseModel()

                Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")
                Dim parsedDate As Date = CDate(Now()).ToString("yyyy-MM-dd")
                Dim vBulan As String = parsedDate.Month
                Dim vTahun As String = parsedDate.Year
                Dim kodPemiutang As String = pembelianPoHeder.ddlKod_Pemiutang
                Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "AP", pembelianPoHeder.ddlKod_Pemiutang, kodkw, kodptj,
                                 KodVot, kodko, kodkp, Jumlah_Harga, "CR", vBulan, vTahun)
                If values.Contains("ok") Then

                    '    'lblModalMessaage.Text = "Rekod telah disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)

                Else
                    '    'lblModalMessaage.Text = "Rekod Gagal disimpan" 'message di modal
                    '    ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)

                End If

            Catch ex As Exception
                resp.Failed("Maklumat gagal disimpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End Try
        Next

        resp.Success("Rekod berjaya dikemaskini", "00", pembelianPoHeder)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdatePO_belian_Hdr_batal(pembelianPoHeder As PembelianPoHdr) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pembelian_Hdr
                              SET  Pelulus_PO= @Pelulus_PO, Status_Hantar= '57'
                              WHERE Id_Pembelian = @Id_Pembelian"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Pelulus_PO", pembelianPoHeder.ddlPelulus_PO))
        param.Add(New SqlParameter("@Id_Pembelian", pembelianPoHeder.ddlId_Pembelian))

        Return db.Process(query, param)
    End Function

    'updata UpdateHantar_Pesanan_belian_Hdr_batal END

    'dev/afiq End


End Class


Public Class SpekDetail
    Public Property kodspek As String
    Public Property butiran As String
    Public Property wajaran As String
    Public Property kategoriPo As String

End Class

Public Class ManualSpekDetail
    Public Property kodspek As String
    Public Property butiran As String
    Public Property wajaran As String

    Public Property kategoriPo As String
End Class

Public Class ZonPtj
    Public Property flagPt As String

End Class