Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.EnterpriseServices
Imports System.IO
Imports iTextSharp.text.log
Imports System.Data.Entity.Core.Mapping
Imports SMKB_Web_Portal.Daftar_Bidaan
Imports System.Globalization

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class ebidding_vendor
    Inherits System.Web.Services.WebService

    Dim dt As DataTable

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiBidaan() As String
        Dim resp As New ResponseRepository

        dt = GetRecord_SenaraiBidaan()
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_SenaraiBidaan() As DataTable
        Dim db = New DBKewConn


        Dim query As String = "select Id_Bidaan,Id_Jualan,no_mohon,No_Sebut_Harga,Tarikh_Mula,Tarikh_Tamat
                               from SMKB_Perolehan_Bidaan_Hdr"

        Return db.Read(query)
    End Function

    Protected Sub InitializeCulture()
        System.Threading.Thread.CurrentThread.CurrentCulture = New CultureInfo("en-MY")
        System.Threading.Thread.CurrentThread.CurrentUICulture = New CultureInfo("MY")
    End Sub



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanDaftarBidaan(SaveBidaan As BidaanHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim msg As String = ""

        If SaveBidaan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(SaveBidaan.txtTarikhMula) Then
            msg = "Sila pastikan tarikh mula telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBidaan.txtTarikhTamat) Then
            msg += "Sila pastikan tarikh tamat telah diisi."
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If SaveBidaan.txtIdBidaan = "" Then
            Dim noMohonID As String = GenerateBidaan()
            SaveBidaan.txtIdBidaan = noMohonID

            If InsertNewOrder(SaveBidaan.txtIdBidaan, SaveBidaan.txtTarikhMula, SaveBidaan.txtMasaMula, SaveBidaan.txtTarikhTamat, SaveBidaan.txtMasaTamat) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        Else

            'Dim rekodPermohonan = GetLoadBidaan(SaveBidaan.txtIdBidaan)
            'If rekodPermohonan.Rows.Count = 0 Then
            '    resp.Failed("Rekod Permohonan tidak dijumpai.")
            '    Return JsonConvert.SerializeObject(resp.GetResult())
            '    Exit Function
            'End If

            'If UpdateNewOrder(SaveBidaan.txtTarikhMula, SaveBidaan.txtMasaMula, SaveBidaan.txtTarikhTamat, SaveBidaan.txtMasaTamat) <> "OK" Then
            '    resp.Failed("Gagal mengemaskini order")
            '    Return JsonConvert.SerializeObject(resp.GetResult())
            'End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", SaveBidaan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertNewOrder(txtIdBidaan As String, txtTarikhMula As String, txtMasaMula As String, txtTarikhTamat As String, txtMasaTamat As String)
        Dim db As New DBKewConn
        InitializeCulture()
        Dim combinedDateTime As DateTime = (txtTarikhMula & " " & txtMasaMula)
        Dim combinedDateTime2 As DateTime = (txtTarikhTamat & " " & txtMasaTamat)

        'Dim combinedDateTime As DateTime = DateTime.ParseExact(txtTarikhMula & " " & txtMasaMula, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture)
        'Dim combinedDateTime2 As DateTime = DateTime.ParseExact(txtTarikhTamat & " " & txtMasaTamat, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture)

        Dim query As String = "INSERT INTO SMKB_Perolehan_Bidaan_Hdr (Id_Bidaan, Tarikh_Mula, Tarikh_Tamat,Status)
        VALUES(@txtIdBidaan, @combinedDateTime, @combinedDateTime2,1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIdBidaan", txtIdBidaan))
        param.Add(New SqlParameter("@combinedDateTime", combinedDateTime))
        param.Add(New SqlParameter("@combinedDateTime2", combinedDateTime2))


        Return db.Process(query, param)
    End Function

    Private Function UpdateNewOrder(txtTarikhMula As String, txtMasaMula As String, txtTarikhTamat As String, txtMasaTamat As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Tahun_Perolehan =  @ddlTahun, Tujuan = @txtTujuan, Skop = @txtSkop, 
        Jenis_Barang = @ddlkategoriPO, Tarikh_Perlu = @txtTkh, Perolehan_Terdahulu =  @txtAmaun, Justifikasi = @txtJustifikasi
        WHERE No_Mohon = @txtNoMohon "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtTarikhMula))
        param.Add(New SqlParameter("@ddlTahun", txtMasaMula))
        param.Add(New SqlParameter("@txtTujuan", txtTarikhTamat))
        param.Add(New SqlParameter("@txtSkop", txtMasaTamat))

        Return db.Process(query, param)
    End Function


    'Generate Nombor Bidaan
    Private Function GenerateBidaan()
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoPO As String = ""
        Dim ptj = "410000"

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='BN' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
            UpdateNoAkhir("02", "BN", year, lastID, ptj)

        Else
            InsertNoAkhir("02", "BN", year, lastID, ptj)
        End If

        newNoPO = "BN" + ptj.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoPO
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetLoadBidaan(id_bidaan As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select Id_Bidaan 
                               from SMKB_Perolehan_Bidaan_Hdr
                               where Id_Bidaan = @id_bidaan
                               ORDER BY Id_Bidaan DESC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@id_bidaan", id_bidaan))

        Dim dt As DataTable = db.Read(query, param)

        Return dt
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

        If UpdateStatusZon(txtNoMohonR, flagPT) <> "OK" Then
            resp.Failed("Gagal menghantar kelulusan permohonan perolehan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Permohonan perolehan berjaya diluluskan.", "00", txtNoMohonR)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateStatusZon(txtNoMohonR As String, flagPT As Boolean)
        Dim db As New DBKewConn
        Dim flagPTValue As String = If(flagPT, "1", "0")

        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '06', Flag_PT = @flagPT WHERE No_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))
        param.Add(New SqlParameter("@flagPT", flagPTValue))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Simpan_Bida(nobida As String, nilaibida As String) As String
        Dim response As New Response
        response.Code = 200
        response.Message = "Berjaya Di Simpan"

        Dim userID As String = HttpContext.Current.Session("ssusrID")
        Dim query As New Query

        'update SMKB_Pinjaman_Hdr
        If query.execute(nobida, "Id_Bidaan", saveChecklistDtl(nobida, nilaibida, userID)) < 0 Then
            response.Code = 500
            response.Message = "Maaf! Maklumat gagal di simpan"
            query.rollback()
        Else
            query.finish()
        End If

        'insert SMKB_Pinjaman_Dtl_UlasanSokongan
        'For Each item As Object In checklistData
        'Try
        '        Dim id As String = item.ID
        '        Dim isChecked As Integer = If(item.isChecked, 1, 0)
        '        If query.execute(pinjamanHdr.No_Pinj, "No_Pinj", saveChecklistDtl(pinjamanHdr.No_Pinj, id, isChecked)) < 0 Then
        '            Throw New Exception("Maklumat ulasan checklist gagal di simpan")
        '        End If
        '    Catch ex As Exception
        '        response.Code = 500
        '        response.Message = ex.Message
        '        query.rollback()
        '    End Try
        'Next

        'insert SMKB_Status_Dok
        'If query.execute(pinjamanHdr.No_Pinj, "No_Rujukan", logInvoisDok(pinjamanHdr.No_Pinj, ulasan, userID, pinjamanHdr.New_Status_Dok)) > 0 Then
        '    query.finish()
        'Else
        '    response.Code = 500
        '    response.Message = "Maklumat status dok gagal di simpan"
        '    query.rollback()
        'End If
        Return JsonConvert.SerializeObject(response)
    End Function

    Private Function saveChecklistDtl(nobida As String, nilaibida As String, userID As String) As SqlCommand
        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Perolehan_Bidaan_Dtl (Id_Bidaan,Id_Syarikat,Harga_Bidaan,Status)
                VALUES (@nobida,@userID,@nilaibida,@Status)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@nobida", nobida))
        cmd.Parameters.Add(New SqlParameter("@userID", userID))
        cmd.Parameters.Add(New SqlParameter("@nilaibida", nilaibida))
        cmd.Parameters.Add(New SqlParameter("@Status", "1"))

        Return cmd
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiBidaan2() As String
        Dim resp As New ResponseRepository
        Dim userID As String = HttpContext.Current.Session("ssusrID")
        dt = GetRecord_SenaraiBidaan2(userID)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_SenaraiBidaan2(id_syarikat As String) As DataTable
        Dim db = New DBKewConn
        Dim cmd As New SqlCommand
        'Dim nosyarikat As String = "02634"

        'Dim query As String = "SELECT A.Id_Bidaan,A.Id_Jualan,A.no_mohon,A.No_Sebut_Harga,A.Tarikh_Mula,A.Tarikh_Tamat,B.No_Perolehan,B.Tujuan,concat (A.No_Sebut_Harga, ' - ' , Tujuan) AS Detail
        '                        FROM SMKB_Perolehan_Bidaan_Hdr AS A
        '                        INNER JOIN SMKB_Perolehan_Permohonan_Hdr AS B ON B.No_Mohon = A.No_Mohon
        '                        INNER JOIN SMKB_Perolehan_Pembelian_Hdr AS C ON A.Id_Jualan=C.Id_Jualan
        '                        WHERE C.ID_Syarikat=@id_syarikat"


        Dim query As String = "Select A.Id_Bidaan,A.Id_Jualan,A.no_mohon,A.No_Sebut_Harga,A.Tarikh_Mula,A.Tarikh_Tamat,B.No_Perolehan,
                                B.Tujuan, concat(A.No_Sebut_Harga, ' - ' , Tujuan) AS Detail
                                From SMKB_Perolehan_Bidaan_Hdr As A
                                INNER Join SMKB_Perolehan_Permohonan_Hdr AS B ON B.No_Mohon = A.No_Mohon
                                INNER Join SMKB_Perolehan_Pembelian_Hdr AS C ON A.Id_Jualan=C.Id_Jualan
                                INNER Join SMKB_Syarikat_Master As D On C.ID_Syarikat = D.ID_Sykt
                                WHERE D.No_Sykt ='02634'"

        'cmd.CommandText = query
        'cmd.Parameters.Add(New SqlParameter("@id_syarikat", id_syarikat))


        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@nosyarikat", nosyarikat))

        Return db.Read(query)
    End Function


End Class






