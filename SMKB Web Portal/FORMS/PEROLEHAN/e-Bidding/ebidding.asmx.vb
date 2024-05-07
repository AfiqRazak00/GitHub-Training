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
Imports System.Data.OleDb
Imports System.Net.Http
Imports System.Threading

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class ebidding
    Inherits System.Web.Services.WebService

    Dim dt As DataTable

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiBidaan1() As String
        Dim resp As New ResponseRepository

        dt = GetRecord_SenaraiBidaan1()
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_SenaraiBidaan1() As DataTable
        Dim db = New DBKewConn


        Dim query As String = "select A.Id_Bidaan,A.Id_Jualan,A.no_mohon,A.No_Sebut_Harga,A.Tarikh_Mula,A.Tarikh_Tamat, 
                                      Concat ( A.No_Sebut_Harga, ' - ' ,Tujuan) As Details2,A.Harga_Mula_Bidaan,A.KenaikanBidaanMin,
                                      B.No_Perolehan,B.Tujuan
                                      from SMKB_Perolehan_Bidaan_Hdr As A
                                      INNER JOIN SMKB_Perolehan_Permohonan_Hdr As B On B.No_Mohon = A.No_Mohon"

        Return db.Read(query)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiBidaan2() As String
        Dim resp As New ResponseRepository

        dt = GetRecord_SenaraiBidaan2()
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_SenaraiBidaan2() As DataTable
        Dim db = New DBKewConn


        Dim query As String = "select A.Id_Bidaan,A.Id_Jualan,A.no_mohon,A.No_Sebut_Harga,A.Tarikh_Mula,A.Tarikh_Tamat,B.No_Perolehan,B.Tujuan,concat (A.No_Sebut_Harga, ' - ' , Tujuan) As Detail
                               from SMKB_Perolehan_Bidaan_Hdr As A
                               INNER JOIN SMKB_Perolehan_Permohonan_Hdr As B On B.No_Mohon = A.No_Mohon"

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

        If String.IsNullOrEmpty(SaveBidaan.txtMasaMula) Then
            msg += "Sila pastikan masa mula telah diisi."
        End If

        If String.IsNullOrEmpty(SaveBidaan.txtMasaTamat) Then
            msg += "Sila pastikan masa tamat telah diisi."
        End If

        If String.IsNullOrEmpty(SaveBidaan.noSebutHarga5) Then
            msg += "Sila pastikan sebut harga telah dipilih."
        End If

        If String.IsNullOrEmpty(SaveBidaan.txtHargaMula) Then
            msg += "Sila pastikan harga mula bidaan telah diisi."
        End If

        If String.IsNullOrEmpty(SaveBidaan.kenaikanBidaanMinima) Then
            msg += "Sila pastikan kenaikan bidaan minima telah diisi."
        End If


        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        If SaveBidaan.txtIdBidaan = "" Then
            Dim noMohonID As String = GenerateBidaan()
            SaveBidaan.txtIdBidaan = noMohonID

            If InsertNewOrder(SaveBidaan.txtIdBidaan, SaveBidaan.txtTarikhMula, SaveBidaan.txtMasaMula, SaveBidaan.txtTarikhTamat, SaveBidaan.txtMasaTamat, SaveBidaan.noSebutHarga5, SaveBidaan.Id_Jualan, SaveBidaan.No_Mohon, SaveBidaan.txtHargaMula, SaveBidaan.kenaikanBidaanMinima) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            If UpdateFlagEbidding(SaveBidaan.No_Mohon) <> "OK" Then
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

    Private Function InsertNewOrder(txtIdBidaan As String, txtTarikhMula As String, txtMasaMula As String, txtTarikhTamat As String, txtMasaTamat As String, noSebutHarga5 As String, Id_Jualan As String, No_Mohon As String, txtHargaMula As String, kenaikanBidaanMinima As String)
        Dim db As New DBKewConn
        InitializeCulture()
        Dim combinedDateTime As DateTime = (txtTarikhMula & " " & txtMasaMula)
        Dim combinedDateTime2 As DateTime = (txtTarikhTamat & " " & txtMasaTamat)

        'Dim combinedDateTime As DateTime = DateTime.ParseExact(txtTarikhMula & " " & txtMasaMula, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture)
        'Dim combinedDateTime2 As DateTime = DateTime.ParseExact(txtTarikhTamat & " " & txtMasaTamat, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture)

        Dim query As String = "INSERT INTO SMKB_Perolehan_Bidaan_Hdr (Id_Bidaan, Tarikh_Mula, Tarikh_Tamat,Status,No_Mohon,No_Sebut_Harga,Id_Jualan,Harga_Mula_Bidaan,KenaikanBidaanMin)
        VALUES(@txtIdBidaan, @combinedDateTime, @combinedDateTime2,1,@No_Mohon,@No_Sebut_Harga,@Id_Jualan,@Harga_Mula_Bidaan,@KenaikanBidaanMin)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIdBidaan", txtIdBidaan))
        param.Add(New SqlParameter("@combinedDateTime", combinedDateTime))
        param.Add(New SqlParameter("@combinedDateTime2", combinedDateTime2))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@No_Sebut_Harga", noSebutHarga5))
        param.Add(New SqlParameter("@Id_Jualan", Id_Jualan))
        param.Add(New SqlParameter("@Harga_Mula_Bidaan", txtHargaMula))
        param.Add(New SqlParameter("@KenaikanBidaanMin", kenaikanBidaanMinima))


        Return db.Process(query, param)
    End Function

    Private Function UpdateFlagEbidding(No_Mohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Flag_Ebidding = '2'
        WHERE No_Mohon = @txtNoMohon "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", No_Mohon))

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


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiSebutHarga(ByVal q As String) As String

        Dim tmpDT As DataTable = Get_SenaraiSebutHarga(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function Get_SenaraiSebutHarga(noSebutHarga As String) As DataTable
        Dim db = New DBKewConn


        Dim query As String = "Select A.No_Sebut_Harga as kodValue, concat(A.No_Sebut_Harga, ' - ', B.Tujuan) as text
                               from SMKB_Perolehan_Naskah_Jualan As A
                               Inner Join SMKB_Perolehan_Permohonan_Hdr As B On B.No_Mohon = A.No_Mohon
                               where B.Flag_Ebidding = '1' "

        Dim param As New List(Of SqlParameter)

        If noSebutHarga <> "" Then
            query &= " AND (No_Sebut_Harga LIKE '%' + @No_Sebut_Harga + '%') "
            param.Add(New SqlParameter("@No_Sebut_Harga", noSebutHarga))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function showMaklumat(ByVal noSebutHarga As String) As String
        Dim db = New DBKewConn
        Dim param As New List(Of SqlParameter)()

        Dim query As String = "Select Id_Jualan,No_Mohon from SMKB_Perolehan_Naskah_Jualan
                              where No_Sebut_Harga = @noSebutHarga"

        param.Add(New SqlParameter("@noSebutHarga", noSebutHarga))

        Return JsonConvert.SerializeObject(db.Read(query, param))
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiBidaan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_SenaraiBidaan(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_SenaraiBidaan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT subquery.rank,subquery.no_sebut_harga,subquery.kod_pembuka,subquery.peratus_teknikal,subquery.harga
                                FROM
                                    (SELECT
                                        ROW_NUMBER() OVER (ORDER BY SUM(D.jumlah_harga_bercukai)) AS rank,
                                        A.no_sebut_harga,
                                        C.kod_pembuka,
                                        C.peratus_teknikal,
                                        SUM(D.jumlah_harga_bercukai) AS harga
                                    FROM
                                        SMKB_Perolehan_Naskah_Jualan AS A
                                        INNER JOIN SMKB_Perolehan_Permohonan_Hdr AS B ON B.no_mohon = A.no_mohon
                                        INNER JOIN SMKB_Perolehan_Pembelian_Hdr AS C ON C.no_mohon = A.no_mohon
                                        INNER JOIN SMKB_Perolehan_Pembelian_Dtl AS D ON D.id_pembelian = C.id_pembelian
                                    WHERE B.flag_ebidding = '1' AND (B.status_dok = '44' or B.status_dok = '54') AND C.keputusan_syor = '1' AND A.no_sebut_harga = @id
                                    GROUP BY A.no_sebut_harga,C.kod_pembuka, C.peratus_teknikal
                                    ) AS subquery
                                ORDER BY
                                    subquery.harga"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@id", id))

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_LiveBidaan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_LiveBidaan(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_LiveBidaan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "
                                SELECT subquery.rank,subquery.no_sebut_harga,subquery.kod_pembuka,subquery.peratus_teknikal,subquery.harga
                                FROM
                                    (SELECT
                                        ROW_NUMBER() OVER (ORDER BY E.Harga_Bidaan) AS rank,
                                        A.no_sebut_harga,
                                        C.kod_pembuka,
                                        C.peratus_teknikal,
                                        E.Harga_Bidaan AS harga
                                    FROM
                                        SMKB_Perolehan_Naskah_Jualan AS A
                                        INNER JOIN SMKB_Perolehan_Permohonan_Hdr AS B ON B.no_mohon = A.no_mohon
                                        INNER JOIN SMKB_Perolehan_Pembelian_Hdr AS C ON C.no_mohon = A.no_mohon
                                        INNER JOIN SMKB_Perolehan_Pembelian_Dtl AS D ON D.id_pembelian = C.id_pembelian
			                            INNER JOIN SMKB_Perolehan_Bidaan_Dtl As E ON C.ID_Syarikat = E.Id_Syarikat
                                    WHERE B.flag_ebidding = '2' AND C.keputusan_syor = '1' AND A.no_sebut_harga = @id
                                    GROUP BY A.no_sebut_harga,C.kod_pembuka, C.peratus_teknikal,E.Harga_Bidaan
                                    ) AS subquery
                                ORDER BY
                                    subquery.harga
        "


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@id", id))

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateDaftarBidaan(UpdateBidaan As UpdateBidaan) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim msg As String = ""

        If UpdateBidaan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(UpdateBidaan.txtTarikhMula) Then
            msg = "Sila pastikan tarikh mula telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(UpdateBidaan.txtTarikhTamat) Then
            msg += "Sila pastikan tarikh tamat telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBidaan.txtMasaMula) Then
            msg += "Sila pastikan masa mula telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBidaan.txtMasaTamat) Then
            msg += "Sila pastikan masa tamat telah diisi."
        End If

        'If String.IsNullOrEmpty(SaveBidaan.noSebutHarga5) Then
        '    msg += "Sila pastikan sebut harga telah dipilih."
        'End If

        If String.IsNullOrEmpty(UpdateBidaan.txtHargaMula) Then
            msg += "Sila pastikan harga mula bidaan telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBidaan.kenaikanBidaanMinima) Then
            msg += "Sila pastikan kenaikan bidaan minima telah diisi."
        End If


        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If UpdateBidaan.txtIdBidaan <> "" Then
            If UpdateBidaanInfo(UpdateBidaan.txtIdBidaan, UpdateBidaan.txtTarikhMula, UpdateBidaan.txtMasaMula, UpdateBidaan.txtTarikhTamat, UpdateBidaan.txtMasaTamat, UpdateBidaan.txtHargaMula, UpdateBidaan.kenaikanBidaanMinima) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", UpdateBidaan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateBidaanInfo(txtIdBidaan As String, txtTarikhMula As String, txtMasaMula As String, txtTarikhTamat As String, txtMasaTamat As String, txtHargaMula As String, kenaikanBidaanMinima As String)
        Dim db As New DBKewConn
        InitializeCulture()
        Dim combinedDateTime As DateTime = (txtTarikhMula & " " & txtMasaMula)
        Dim combinedDateTime2 As DateTime = (txtTarikhTamat & " " & txtMasaTamat)

        Dim query As String = "UPDATE SMKB_Perolehan_Bidaan_Hdr SET Tarikh_Mula=@Tarikh_Mula,Tarikh_Tamat=@Tarikh_Tamat,
                               Harga_Mula_Bidaan=@Harga_Mula_Bidaan,KenaikanBidaanMin=@KenaikanBidaanMin
                               where Id_Bidaan=@txtIdBidaan"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Tarikh_Mula", combinedDateTime))
        param.Add(New SqlParameter("@Tarikh_Tamat", combinedDateTime2))
        param.Add(New SqlParameter("@Harga_Mula_Bidaan", txtHargaMula))
        param.Add(New SqlParameter("@KenaikanBidaanMin", kenaikanBidaanMinima))
        param.Add(New SqlParameter("@txtIdBidaan", txtIdBidaan))

        Return db.Process(query, param)


    End Function


    'dev/afiq START

    'LoadPerolehan_Pembelian_Hdr Start

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pembelian_Hdr(Id_Jualan As String) As String
        Dim resp As New ResponseRepository

        dt = GetOrder_Pembelian_Hdr(Id_Jualan)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pembelian_Hdr(Id_Jualan As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "

                SELECT A.Id_Jualan, A.No_Sebut_Harga, 
                B.Id_Pembelian, B.No_Mohon, B.ID_Syarikat, 
                C.Nama_Sykt, C.Emel_Semasa
                from SMKB_Perolehan_Naskah_Jualan As A
                INNER JOIN SMKB_Perolehan_Pembelian_Hdr As B ON A.Id_Jualan = B.Id_Jualan
                INNER JOIN SMKB_Syarikat_Master As C ON C.ID_Sykt = B.ID_Syarikat
                WHERE A.No_Sebut_Harga= @IdJualan
                
            "
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdJualan", Id_Jualan))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function


    'LoadPerolehan_Pembelian_Hdr END

    ' Email service START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function EmelStaf_Vendo(Pembelian_Hdr As Pembelian_Hdr) As Tasks.Task(Of String)
        Dim clsCrypto As New clsCrypto
        Dim db As New DBKewConn

        Dim resp As New ResponseRepository
        Dim response = New Response

        Dim fullName_Penerima As String = Pembelian_Hdr.dllNamaSykt
        Dim email_Penerima As String = Pembelian_Hdr.ddlEmelSemasa
        Dim NoStaff_Penerima = Pembelian_Hdr.ddLIDSyarikat
        Dim TarikhLuput = "null" 'kenalpasti tarikh active


        Dim NameSubMenu As String = Pembelian_Hdr.dllNameSubMenu
        Dim KodSubMenu = Pembelian_Hdr.dllKodSubMenu 'identify kod sub menu skrin sokong/lulus ikut modul msing2
        Dim NoRujukan = "Null"

        Dim combineData = NoStaff_Penerima + Now() + NoRujukan
        Dim id = Replace(Replace(Replace(clsCrypto.fEncrypt(combineData), "/", "@"), "+", "@"), "%", "@")

        'mula insert
        Dim paramSqlBtrn() As SqlParameter = Nothing
        Dim strSqlButiran = "INSERT INTO SMKB_Emel_Auth (ID_Token, No_Staf_Penerima, Emel_Penerima,  Kod_Sub_Menu, No_Rujukan)
                                            VALUES (@ID_Token, @No_Staf_Penerima, @Emel_Penerima,  @Kod_Sub_Menu, @No_Rujukan)"
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
                         vbCrLf & "Terima kasih atas kerjasama Tuan / Puan." &
                         "<br>" &
                         "<br><br>" &
                         vbCrLf & "Email dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " &
                         "<br><br>" &
                         vbCrLf & "Email ini tidak perlu dibalas."

            'vbCrLf & "ID Mesyuarat : " & IDMsy &
            '"<br><br>" &

            myEmel_Vendo(email_Penerima, subject, body)


            resp.Success("Notifikasi berjaya dihantar.", "00")
            response = resp.GetResult()



        Else
            db.sConnRollbackTrans()
        End If

        Return Tasks.Task.FromResult(JsonConvert.SerializeObject(response))
    End Function

    Public strConEmail_Mesyuarat_JK As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    Private Function myEmel_Vendo(alamat, subject, body)
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

    'dev/afiq End


End Class






