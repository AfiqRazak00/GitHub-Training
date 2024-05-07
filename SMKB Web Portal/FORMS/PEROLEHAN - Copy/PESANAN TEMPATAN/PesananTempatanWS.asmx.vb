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
Imports System.Data.Entity.Core.Mapping
Imports SMKB_Web_Portal.PEMFAKTORAN
Imports SMKB_Web_Portal.Maklumat_Pemfaktoran
Imports SMKB_Web_Portal.DaftarPtPtj
Imports SMKB_Web_Portal.DaftarPtUni
Imports SMKB_Web_Portal.SokonganPT
Imports System.Threading
Imports System.Globalization
Imports Newtonsoft.Json.Linq
Imports System.Data.Entity.Core
Imports System.Threading.Tasks
Imports AjaxControlToolkit



' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PesananTempatanWS
    Inherits System.Web.Services.WebService

    Dim dt As DataTable
    Dim queryRB As New Query()

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_DaftarPtPtj(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_DaftarPtPtj(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_DaftarPtPtj(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        Dim query = "select distinct a.No_Mohon, C.MS01_Nama,C.JawGiliran,C.MS01_VoIP,
                        A.No_Mohon,a.No_Perolehan, FORMAT(A.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon,A.Id_Pemohon,A.Tujuan,
                        FORMAT(A.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum,
                        CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                        c.Pejabat,
                        D.Nama + ' ' + D.Almt1 + ' ' + D.Almt2 AS Alamat,D.Bandar,D.Poskod,
                        negeri.Butiran AS NegeriButiran 
                        from SMKB_Perolehan_Permohonan_Hdr A
                        inner join SMKB_Perolehan_Permohonan_Dtl As B On A.No_Mohon = B.No_Mohon
                        INNER JOIN VPeribadi As C On C.MS01_NoStaf = A.Id_Pemohon
                        INNER JOIN SMKB_Lookup_Detail AS kategori ON A.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                        INNER JOIN SMKB_Korporat AS D ON 1 = 1
                        INNER JOIN SMKB_Lookup_Detail AS negeri ON D.Kod_Negeri = negeri.Kod_Detail And negeri.Kod = '0002'  
                        where a.Status_Dok='08' and a.No_Perolehan like ('PL%') and a.Status='1' " & tarikhQuery & " "

        Return db.Read(query, param)
    End Function

    'Daftar PT Universiti
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function DaftarPtUniversiti(DaftarPt1 As DaftarPTHdr, idMohonDtlArray As Butiran()) As Tasks.Task(Of String)

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim msg As String = ""

        If DaftarPt1 Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(DaftarPt1.txtNoMohon) Then
            msg = "Sila pastikan Bayar Atas Nama telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If DaftarPt1.NoPt = "" Then
            Dim noMohonID As String = GenerateNoPT()
            DaftarPt1.NoPt = noMohonID

            If InsertDaftarPtHdrUniversiti(DaftarPt1.txtNoMohon, DaftarPt1.idSyarikat, DaftarPt1.kodSyarikat, DaftarPt1.NoPt) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If


            If idMohonDtlArray IsNot Nothing AndAlso idMohonDtlArray.Length > 0 Then
                For Each butiranItem As Butiran In idMohonDtlArray
                    If butiranItem.Id_Mohon_Dtl IsNot Nothing Then
                        If InsertDaftarPtDtlUniversiti(DaftarPt1.NoPt, butiranItem.Id_Mohon_Dtl) <> "OK" Then
                            resp.Failed("Gagal Mendaftar Pesanan Tempatan.")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            'queryRB.rollback()
                        End If
                    End If
                Next
            End If

            If UpdateStatusDokPTUni(DaftarPt1.txtNoMohon) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            For Each item As Object In idMohonDtlArray
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


            For Each item As Object In idMohonDtlArray
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
                    Dim kodPemiutang As String = DaftarPt1.kodPemiutang
                    Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "AP", kodPemiutang, kodkw, kodptj,
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



        End If

        resp.Success("Maklumat berjaya disimpan", "00", DaftarPt1)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function UpdateStatusDokPTUni(txtNoMohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr set Status_Dok = '41'
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))

        Return db.Process(query, param)


    End Function
    Private Function InsertDaftarPtHdrUniversiti(txtNoMohon As String, idSyarikat As String, kodSyarikat As String, NoPt As String)
        Dim db As New DBKewConn

        Dim currentDate As Date = Date.Today

        Dim query As String = "INSERT INTO SMKB_Perolehan_Pesanan_Hdr (No_Mohon,Id_Syarikat,Kod_Syarikat,No_Pesanan,Tarikh_Pesanan,Disediakan_Oleh,Tarikh_Disediakan,Status)
        VALUES(@txtNoMohon, @idSyarikat, @kodSyarikat,@NoPt,@Tarikh_Pesanan,@Disediakan_Oleh,@Tarikh_Disediakan,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohon))
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))
        param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))
        param.Add(New SqlParameter("@NoPt", NoPt))
        param.Add(New SqlParameter("@Tarikh_Pesanan", currentDate))
        param.Add(New SqlParameter("@Disediakan_Oleh", Session("ssusrID")))
        param.Add(New SqlParameter("@Tarikh_Disediakan", currentDate))


        Return db.Process(query, param)

    End Function

    Private Function InsertDaftarPtDtlUniversiti(NoPt As String, Id_Mohon_Dtl As String)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Perolehan_Pesanan_Dtl (No_Pesanan, Id_Mohon_Dtl)
        VALUES(@No_Pesanan,@Id_Mohon_Dtl)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Pesanan", NoPt))
        param.Add(New SqlParameter("@Id_Mohon_Dtl", Id_Mohon_Dtl))



        Return db.Process(query, param)

    End Function

    'simpan daftar pesanan header
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function SimpanPesananTempatan(DaftarPt1 As DaftarPTHdr, idMohonDtlArray As Butiran()) As Tasks.Task(Of String)

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim msg As String = ""

        'queryRB = New Query()

        If DaftarPt1 Is Nothing Then
            resp.Failed("Gagal Mendaftar Pesanan Tempatan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(DaftarPt1.txtNoMohon) Then
            msg = "Sila pastikan no permohonan telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If DaftarPt1.NoPt = "" Then
            Dim noMohonID As String = GenerateNoPT()
            DaftarPt1.NoPt = noMohonID

            If InsertDaftarPtHdr(DaftarPt1.txtNoMohon, DaftarPt1.idSyarikat, DaftarPt1.kodSyarikat, DaftarPt1.NoPt) <> "OK" Then
                resp.Failed("Gagal Mendaftar Pesanan Tempatan.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'queryRB.rollback()
            End If

            If idMohonDtlArray IsNot Nothing AndAlso idMohonDtlArray.Length > 0 Then
                For Each butiranItem As Butiran In idMohonDtlArray
                    If butiranItem.Id_Mohon_Dtl IsNot Nothing Then
                        If InsertDaftarPtDtl(DaftarPt1.NoPt, butiranItem.Id_Mohon_Dtl) <> "OK" Then
                            resp.Failed("Gagal Mendaftar Pesanan Tempatan.")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            'queryRB.rollback()
                        End If
                    End If
                Next
            End If

            If InsertPembelianHdr(DaftarPt1.NoPt, DaftarPt1.txtNoMohon, DaftarPt1.kodSyarikat, DaftarPt1.idSyarikat) <> "OK" Then
                resp.Failed("Gagal Mendaftar Pesanan Tempatan.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'queryRB.rollback()
            End If

            If idMohonDtlArray IsNot Nothing AndAlso idMohonDtlArray.Length > 0 Then
                For Each butiranItem As Butiran In idMohonDtlArray
                    If butiranItem.Id_Mohon_Dtl IsNot Nothing Then
                        If InsertPembelianDtl(butiranItem.Id_Mohon_Dtl, butiranItem.Kuantiti, butiranItem.Kadar_Harga, butiranItem.Jumlah_Harga) <> "OK" Then
                            resp.Failed("Gagal Mendaftar Pesanan Tempatan.")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            'queryRB.rollback()
                        End If
                    End If
                Next
            End If

            If UpdateStatusDok(DaftarPt1.txtNoMohon, DaftarPt1.idSyarikat) <> "OK" Then
                resp.Failed("Gagal Mendaftar Pesanan Tempatan.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'queryRB.rollback()
            End If


            For Each item As Object In idMohonDtlArray
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


            For Each item As Object In idMohonDtlArray
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
                    Dim kodPemiutang As String = DaftarPt1.kodPemiutang
                    Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "AP", kodPemiutang, kodkw, kodptj,
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

        End If

        'queryRB.finish()
        resp.Success("Maklumat berjaya disimpan", "00", DaftarPt1)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertDaftarPtHdr(txtNoMohon As String, idSyarikat As String, kodSyarikat As String, NoPt As String)
        Dim db As New DBKewConn

        Dim currentDate As Date = Date.Today

        Dim query As String = "INSERT INTO SMKB_Perolehan_Pesanan_Hdr (No_Mohon,Id_Syarikat,Kod_Syarikat,No_Pesanan,Tarikh_Pesanan,Disediakan_Oleh,Tarikh_Disediakan,Status)
        VALUES(@txtNoMohon, @idSyarikat, @kodSyarikat,@NoPt,@Tarikh_Pesanan,@Disediakan_Oleh,@Tarikh_Disediakan,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohon))
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))
        param.Add(New SqlParameter("@kodSyarikat", kodSyarikat))
        param.Add(New SqlParameter("@NoPt", NoPt))
        param.Add(New SqlParameter("@Tarikh_Pesanan", currentDate))
        param.Add(New SqlParameter("@Disediakan_Oleh", Session("ssusrID")))
        param.Add(New SqlParameter("@Tarikh_Disediakan", currentDate))


        Return db.Process(query, param)

    End Function

    Private Function InsertDaftarPtDtl(NoPt As String, Id_Mohon_Dtl As String)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Perolehan_Pesanan_Dtl (No_Pesanan, Id_Mohon_Dtl)
        VALUES(@No_Pesanan,@Id_Mohon_Dtl)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Pesanan", NoPt))
        param.Add(New SqlParameter("@Id_Mohon_Dtl", Id_Mohon_Dtl))

        Return db.Process(query, param)

    End Function

    Private Function InsertPembelianHdr(NoPt As String, NoMohon As String, KodSyarikat As String, ID_Syarikat As String)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembelian_Hdr (Id_Pembelian, Id_Jualan,No_Mohon,Kod_Syarikat,ID_Syarikat,Keputusan_Lantik,Status)
        VALUES(@NoPt,'tiada',@No_Mohon,@Kod_Syarikat,@ID_Syarikat,'1','1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@NoPt", NoPt))
        param.Add(New SqlParameter("@No_Mohon", NoMohon))
        param.Add(New SqlParameter("@Kod_Syarikat", KodSyarikat))
        param.Add(New SqlParameter("@ID_Syarikat", ID_Syarikat))

        Return db.Process(query, param)

    End Function

    Private Function InsertPembelianDtl(Id_Mohon_Dtl As String, Kuantiti As String, Harga_Seunit As String, Jumlah_Harga As String)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Perolehan_Pembelian_Dtl (Id_Mohon_Dtl, Kuantiti,Harga_Seunit,Jumlah_Harga)
        VALUES(@Id_Mohon_Dtl,@Kuantiti,@Harga_Seunit,@Jumlah_Harga)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id_Mohon_Dtl", Id_Mohon_Dtl))
        param.Add(New SqlParameter("@Kuantiti", Kuantiti))
        param.Add(New SqlParameter("@Harga_Seunit", Harga_Seunit))
        param.Add(New SqlParameter("@Jumlah_Harga", Jumlah_Harga))

        Return db.Process(query, param)

    End Function
    Private Function UpdateStatusDok(txtNoMohon As String, idSyarikat As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr set Status_Dok = '41', Kod_Syarikat = @idSyarikat
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))

        Return db.Process(query, param)


    End Function
    Private Function GenerateNoPT()
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoPemfaktoran As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='PT' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
            UpdateNoAkhirPT("02", "PT", year, lastID)

        Else
            InsertNoAkhirPT("02", "PT", year, lastID)
        End If

        newNoPemfaktoran = "PT" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoPemfaktoran
    End Function

    Private Function InsertNoAkhirPT(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir (Kod_Modul,Prefix,No_Akhir,Tahun,Butiran,Kod_PTJ)
                               VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, '-')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Daftar Pesanan Tempatan"))


        Return db.Process(query, param)
    End Function

    Private Function UpdateNoAkhirPT(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir set No_Akhir = @No_Akhir
                              where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))

        Return db.Process(query, param)


    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_DaftarPtUni(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_DaftarPtUni(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_DaftarPtUni(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and c.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and c.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and c.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and c.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and c.Tarikh_Mohon >= @tkhMula and c.Tarikh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query = "    select  D.MS01_Nama,D.JawGiliran,D.MS01_VoIP,
                        C.No_Mohon,C.No_Perolehan,FORMAT(C.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon,C.Id_Pemohon,C.Tujuan,A.Kod_Syarikat,A.ID_Syarikat,
                        FORMAT(C.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum,
                        E.Nama_Sykt,
                        CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                        D.Pejabat,
                        F.Nama + ' ' + F.Almt1 + ' ' + F.Almt2 AS Alamat,F.Bandar,F.Poskod,
                        negeri.Butiran AS NegeriButiran,H.Kod_Pemiutang
                        from SMKB_Perolehan_Pembelian_Hdr As A
                        INNER JOIN SMKB_Perolehan_Permohonan_Hdr As C On c.No_Mohon = a.No_Mohon
						INNER JOIN SMKB_Pemiutang_Master AS H On H.No_Rujukan = A.ID_Syarikat
                        INNER JOIN VPeribadi As D On d.MS01_NoStaf = c.Id_Pemohon
                        INNER JOIN SMKB_Syarikat_Master As E ON E.ID_Sykt = A.ID_Syarikat						
                        INNER JOIN SMKB_Lookup_Detail AS kategori ON C.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                        INNER JOIN SMKB_Korporat AS F ON 1 = 1
                        INNER JOIN SMKB_Lookup_Detail AS negeri ON F.Kod_Negeri = negeri.Kod_Detail And negeri.Kod = '0002'                    
                        where (C.No_Perolehan LIKE 'DS%' OR C.No_Perolehan LIKE 'DT%') And C.Status_Dok = '40' and A.Keputusan_Lantik = '1' " & tarikhQuery & " "

        Return db.Read(query, param)
    End Function



    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_LulusPtOlehPtj(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_LulusPtOlehPtj(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_LulusPtOlehPtj(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        Dim query = "select  D.MS01_Nama,D.JawGiliran,D.MS01_VoIP,
		            C.No_Mohon,FORMAT(C.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon,C.Id_Pemohon,C.Tujuan,A.Kod_Syarikat,A.ID_Syarikat,
		            FORMAT(C.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum,
		            E.Nama_Sykt,
		            CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
		            D.Pejabat,
		            F.Nama + ' ' + F.Almt1 + ' ' + F.Almt2 AS Alamat,F.Bandar,F.Poskod,
		            negeri.Butiran AS NegeriButiran
		            from SMKB_Perolehan_Pembelian_Hdr As A
		            INNER JOIN SMKB_Perolehan_Permohonan_Hdr As C On c.No_Mohon = a.No_Mohon
		            INNER JOIN VPeribadi As D On d.MS01_NoStaf = c.Id_Pemohon
		            INNER JOIN SMKB_Syarikat_Master As E ON E.No_Sykt = C.Kod_Syarikat
		            INNER JOIN SMKB_Lookup_Detail AS kategori ON C.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
		            INNER JOIN SMKB_Korporat AS F ON 1 = 1
		            INNER JOIN SMKB_Lookup_Detail AS negeri ON F.Kod_Negeri = negeri.Kod_Detail And negeri.Kod = '0002'                    
                    where C.Status_Dok = '41' and A.Keputusan_Lantik = '1' " & tarikhQuery & " "

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_LulusPtUniversiti(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_LulusPtUniversiti(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_LulusPtUniversiti(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        Dim query = "select  D.MS01_Nama,D.JawGiliran,D.MS01_VoIP,
		            C.No_Mohon,FORMAT(C.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon,C.Id_Pemohon,C.Tujuan,A.Kod_Syarikat,A.ID_Syarikat,
		            FORMAT(C.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum,
		            E.Nama_Sykt,
		            CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
		            D.Pejabat,
		            F.Nama + ' ' + F.Almt1 + ' ' + F.Almt2 AS Alamat,F.Bandar,F.Poskod,
		            negeri.Butiran AS NegeriButiran,G.Kod_Pemiutang
		            from SMKB_Perolehan_Pembelian_Hdr As A
		            INNER JOIN SMKB_Perolehan_Permohonan_Hdr As C On c.No_Mohon = a.No_Mohon
		            INNER JOIN VPeribadi As D On d.MS01_NoStaf = c.Id_Pemohon
		            INNER JOIN SMKB_Syarikat_Master As E ON E.No_Sykt = C.Kod_Syarikat
		            INNER JOIN SMKB_Lookup_Detail AS kategori ON C.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
		            INNER JOIN SMKB_Korporat AS F ON 1 = 1
		            INNER JOIN SMKB_Lookup_Detail AS negeri ON F.Kod_Negeri = negeri.Kod_Detail And negeri.Kod = '0002' 
                    INNER JOIN SMKB_Pemiutang_Master As G On G.No_Rujukan = A.ID_Syarikat
                    where C.Status_Dok = '42' and A.Keputusan_Lantik = '1' " & tarikhQuery & " "

        Return db.Read(query, param)
    End Function
    'simpan daftar PT
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateLulusPtOlehPtj(LulusPt1 As LulusPTHdr) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If LulusPt1 Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateStatusDokLulusPtj(LulusPt1.txtNoMohon) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePelulusPtPtj(LulusPt1.txtNoMohon) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Maklumat berjaya disimpan", "00", LulusPt1)
        Return JsonConvert.SerializeObject(resp.GetResult())


    End Function

    Private Function UpdateStatusDokLulusPtj(txtNoMohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr set Status_Dok = '42'
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))

        Return db.Process(query, param)


    End Function

    Private Function UpdatePelulusPtPtj(txtNoMohon As String)
        Dim db As New DBKewConn

        Dim currentDate As Date = Date.Today

        Dim query As String = "UPDATE SMKB_Perolehan_Pesanan_Hdr set Id_Pelulus_Ptj = @Id_Pelulus_Ptj, Tarikh_Lulus_Ketua_Ptj = @Tarikh_Lulus_Ketua_Ptj
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))
        param.Add(New SqlParameter("@Id_Pelulus_Ptj", Session("ssusrID")))
        param.Add(New SqlParameter("@Tarikh_Lulus_Ketua_Ptj", currentDate))

        Return db.Process(query, param)

    End Function

    'simpan daftar PT
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function UpdateLulusPtOlehBendahari(txtNoMohon As String, NoPt As String, kPemiutang As String, rowDataArray As LulusPTHdr()) As Tasks.Task(Of String)

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If rowDataArray Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateStatusDokLulusBendahari(txtNoMohon) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePelulusPtBendahari(txtNoMohon) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
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
                Dim kodPemiutang As String = kPemiutang
                Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "AP", kPemiutang, kodkw, kodptj,
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

        resp.Success("Maklumat berjaya disimpan", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateStatusDokLulusBendahari(txtNoMohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr set Status_Dok = '43'
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))

        Return db.Process(query, param)


    End Function

    Private Function UpdatePelulusPtBendahari(txtNoMohon As String)
        Dim db As New DBKewConn

        Dim currentDate As Date = Date.Today

        Dim query As String = "UPDATE SMKB_Perolehan_Pesanan_Hdr set Id_Lulus_Bendahari = @Id_Lulus_Bendahari, Tarikh_Lulus_Bendahari = @Tarikh_Lulus_Bendahari
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))
        param.Add(New SqlParameter("@Id_Lulus_Bendahari", Session("ssusrID")))
        param.Add(New SqlParameter("@Tarikh_Lulus_Bendahari", currentDate))

        Return db.Process(query, param)

    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_BatalPtPermohonan(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_BatalPtPermohonan(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_BatalPtPermohonan(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and c.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and c.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and c.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and c.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and c.Tarikh_Mohon >= @tkhMula and c.Tarikh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query = "select  D.MS01_Nama,D.JawGiliran,D.MS01_VoIP,
                        C.No_Mohon,C.No_Perolehan,FORMAT(C.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon,C.Id_Pemohon,C.Tujuan,A.Kod_Syarikat,A.ID_Syarikat,
                        FORMAT(C.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum,
                        E.Nama_Sykt,
                        CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                        D.Pejabat,
                        F.Nama + ' ' + F.Almt1 + ' ' + F.Almt2 AS Alamat,F.Bandar,F.Poskod,
                        negeri.Butiran AS NegeriButiran,H.Kod_Pemiutang,C.Status_Dok,g.No_Pesanan
                        from SMKB_Perolehan_Pembelian_Hdr As A
                        INNER JOIN SMKB_Perolehan_Permohonan_Hdr As C On c.No_Mohon = a.No_Mohon
						INNER JOIN SMKB_Pemiutang_Master AS H On H.No_Rujukan = A.ID_Syarikat
                        INNER JOIN VPeribadi As D On d.MS01_NoStaf = c.Id_Pemohon
                        INNER JOIN SMKB_Syarikat_Master As E ON E.ID_Sykt = A.ID_Syarikat						
                        INNER JOIN SMKB_Lookup_Detail AS kategori ON C.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                        INNER JOIN SMKB_Korporat AS F ON 1 = 1
                        INNER JOIN SMKB_Lookup_Detail AS negeri ON F.Kod_Negeri = negeri.Kod_Detail And negeri.Kod = '0002'    
                        INNER JOIN SMKB_Perolehan_Pesanan_Hdr as G On C.No_Mohon = G.No_Mohon
                        where (C.No_Perolehan LIKE 'DS%' OR C.No_Perolehan LIKE 'DT%') And C.Status_Dok = '41' and A.Keputusan_Lantik = '1' " & tarikhQuery & " "

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function BatalPtSahaja(txtNoMohon As String, NoPt As String, kPemiutang As String, status_Dok As String, rowDataArray As LulusPTHdr()) As Tasks.Task(Of String)

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If rowDataArray Is Nothing Then
            resp.Failed("Tidak disimpan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateStatusDokBatalPtSahaja(txtNoMohon) <> "OK" Then
            resp.Failed("Gagal membatal pesanan tempatan1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePembatalPt(txtNoMohon) <> "OK" Then
            resp.Failed("Gagal membatal pesanan tempatan2.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If status_Dok = "41" Then

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
                    Dim kodPemiutang As String = kPemiutang
                    Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "AP", kPemiutang, kodkw, kodptj,
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

        End If
        resp.Success("Maklumat berjaya disimpan", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function BatalPesananTempatan(txtNoMohon As String, NoPt As String, kPemiutang As String, status_Dok As String, rowDataArray As LulusPTHdr()) As Tasks.Task(Of String)

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If rowDataArray Is Nothing Then
            resp.Failed("Tidak disimpan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateStatusDokBatal(txtNoMohon) <> "OK" Then
            resp.Failed("Gagal membatal pesanan tempatan1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePembatalPt(txtNoMohon) <> "OK" Then
            resp.Failed("Gagal membatal pesanan tempatan2.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If status_Dok = "41" Then

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
                    Dim kodPemiutang As String = kPemiutang
                    Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                                 "AP", kPemiutang, kodkw, kodptj,
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

        End If
        resp.Success("Maklumat berjaya disimpan", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function UpdateStatusDokBatal(txtNoMohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr set Status_Dok = '45' , Status = '0'
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))

        Return db.Process(query, param)


    End Function

    Private Function UpdateStatusDokBatalPtSahaja(txtNoMohon As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr set Status_Dok = '45'
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))

        Return db.Process(query, param)


    End Function

    Private Function UpdatePembatalPt(txtNoMohon As String)
        Dim db As New DBKewConn

        Dim currentDate As Date = Date.Today

        Dim query As String = "UPDATE SMKB_Perolehan_Pesanan_Hdr set Id_Batal = @Id_Batal, Tarikh_Batal = @Tarikh_Batal, Status = '0'
                              where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", txtNoMohon))
        param.Add(New SqlParameter("@Id_Batal", Session("ssusrID")))
        param.Add(New SqlParameter("@Tarikh_Batal", currentDate))

        Return db.Process(query, param)

    End Function


    'Load DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_PtPtj(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecord_PtPtj(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_PtPtj(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " Select distinct b.Id_Mohon_Dtl , B.Kod_Kump_Wang,B.Kod_Operasi,B.Kod_Ptj,B.Kod_Projek,B.Kod_Vot,B.Butiran,
                                B.Ukuran,B.Kuantiti,B.Kadar_Harga,B.Jumlah_Harga,C.Butiran,
                                (select Butiran from SMKB_Lookup_Detail where Kod = 'PO06 'And Kod_Detail = B.Ukuran ) As NewButiran
                                from SMKB_Perolehan_Permohonan_Hdr A
                                inner join SMKB_Perolehan_Permohonan_Dtl as B On A.no_mohon = B.no_mohon
                                Inner join SMKB_Lookup_Detail As C On B.Ukuran = C.Butiran
                                where A.No_Perolehan like ('%PL%') And A.Status='1' 
                                and A.Status_Dok='08' And A.No_Mohon = @nombor_mohon"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@nombor_mohon", id))

        Return db.Read(query, param)

    End Function

    'Load DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_PtUniversiti(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = Get_PtUniversiti(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_PtUniversiti(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " Select
                                D.Kod_Kump_Wang,D.Kod_Operasi,D.Kod_Ptj,D.Kod_Projek,D.Kod_Vot,D.Butiran,
                                A.Kuantiti,FORMAT(A.Harga_Seunit, 'N2') As Harga_Seunit, FORMAT(A.Harga_Seunit_Bercukai, 'N2') As Harga_Seunit_Bercukai,FORMAT(A.Jumlah_Harga, 'N2') As Jumlah_Harga,FORMAT(A.Jumlah_Harga_Bercukai, 'N2') As Jumlah_Harga_Bercukai,
                                (select Butiran from SMKB_Lookup_Detail where Kod = 'PO06 'And Kod_Detail = D.Ukuran ) As NewButiran,
                                A.Id_Mohon_Dtl,D.Ukuran
                                from SMKB_Perolehan_Pembelian_Dtl As A
                                Inner Join SMKB_Perolehan_Pembelian_Hdr As B On A.Id_Pembelian = B.Id_Pembelian
                                Inner Join  SMKB_Perolehan_Permohonan_Hdr As C On B.No_Mohon = C.No_Mohon
                                Inner Join SMKB_Perolehan_Permohonan_Dtl As D On A.Id_Mohon_Dtl = D.Id_Mohon_Dtl
                                Inner Join SMKB_Lookup_Detail As E On D.Ukuran = E.Kod_Detail
                                where B.Keputusan_Lantik = '1' And B.No_Mohon = @nombor_mohon And E.Kod ='PO06'"

        'Dim query As String = "SELECT Id_Mohon_Dtl, Kod_Kump_Wang, Kod_Operasi, Kod_Ptj, Kod_Projek, Kod_Vot, FORMAT(Baki_Peruntukan, '0.00') as Baki_Peruntukan, Butiran,
        '    Kuantiti, Ukuran, FORMAT(Kadar_Harga,'0.00') AS Kadar_Harga, FORMAT(Jumlah_Harga,'0.00') AS Jumlah_Harga FROM SMKB_Perolehan_Permohonan_Dtl WHERE No_Mohon = @nombor_mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@nombor_mohon", id))

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiKelulusanPtj(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_KelulusanPTj(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_KelulusanPTj(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        '   Dim query = "SELECT  a.No_Mohon, FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, FORMAT(a.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum,a.Tujuan,a.Skop,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,d.Pejabat As NamaPejabat,                   
        '               a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, CONCAT('RM ', a.Perolehan_Terdahulu) AS Perolehan_Terdahulu,a.Justifikasi, 
        '               kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
        '               StatusPO.Butiran As ButiranKodDok,
        'SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP,SMSM.JawGiliran,SMSM.MS01_VoIP,
        'E.Nama_Sykt, E.ID_Sykt,
        '               F.Nama + ' ' + F.Almt1 + ' ' + F.Almt2 AS Alamat,F.Bandar,F.Poskod,
        '               negeri.Butiran AS NegeriButiran
        '               FROM SMKB_Perolehan_Permohonan_Hdr AS a
        '               INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
        '               INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
        '               INNER JOIN VPeribadi AS SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
        '               INNER JOIN VPejabat AS D ON a.Bekal_Kepada = D.KodPejabat
        '               INNER JOIN SMKB_Syarikat_Master AS E ON a.Kod_Syarikat = E.ID_Sykt
        '               INNER JOIN SMKB_Korporat AS F ON 1 = 1
        '               INNER JOIN SMKB_Lookup_Detail AS negeri ON F.Kod_Negeri = negeri.Kod_Detail And negeri.Kod = '0002'                    
        '               where StatusPO.Kod_Modul='02' and Status_Dok = '39' " & tarikhQuery & "
        '               ORDER BY a.Tarikh_Mohon Desc"

        Dim query = "select Distinct D.MS01_Nama,D.JawGiliran,D.MS01_VoIP,
                    C.No_Mohon,FORMAT(C.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon,C.Id_Pemohon,
                    E.Nama_Sykt,E.No_sykt,
                    FORMAT(C.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum,
                    C.Tujuan,
                    CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    D.Pejabat,
					F.Nama + ' ' + F.Almt1 + ' ' + F.Almt2 AS Alamat,F.Bandar,F.Poskod,
                    negeri.Butiran AS NegeriButiran
                    from SMKB_Perolehan_Pembelian_Hdr As A
                    INNER JOIN SMKB_Perolehan_Pembelian_Dtl As B On b.Id_Pembelian = a.Id_Pembelian
                    INNER JOIN SMKB_Perolehan_Permohonan_Hdr As C On c.No_Mohon = a.No_Mohon
                    INNER JOIN VPeribadi As D On d.MS01_NoStaf = c.Id_Pemohon
                    INNER JOIN SMKB_Syarikat_Master As E ON E.No_Sykt = C.Kod_Syarikat
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON C.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                    INNER JOIN SMKB_Korporat AS F ON 1 = 1
                    INNER JOIN SMKB_Lookup_Detail AS negeri ON F.Kod_Negeri = negeri.Kod_Detail And negeri.Kod = '0002' 
                    where A.Keputusan_Lantik = '1' " & tarikhQuery & " "

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiPT(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_Load_SenaraiPT(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_Load_SenaraiPT(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        '   Dim query = "SELECT  a.No_Mohon, FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Skop,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,d.Pejabat As NamaPejabat,               
        '               a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, CONCAT('RM ', a.Perolehan_Terdahulu) AS Perolehan_Terdahulu,a.Justifikasi,FORMAT(a.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum, 
        '               kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
        '               StatusPO.Butiran As ButiranKodDok,
        'SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP,SMSM.JawGiliran,SMSM.MS01_VoIP
        '               FROM SMKB_Perolehan_Permohonan_Hdr AS a
        '               INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
        'INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
        'INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
        '               INNER JOIN VPejabat As D ON a.Bekal_Kepada = D.KodPejabat

        '               where id_pemohon= '02634' and StatusPO.Kod_Modul='02' and Status_Dok = '06' " & tarikhQuery & "
        '               ORDER BY a.Tarikh_Mohon Desc"

        Dim query = "select distinct D.MS01_Nama,D.JawGiliran,D.MS01_VoIP,
                    C.No_Mohon,C.Tarikh_Mohon,
                    E.Nama_Sykt,
                    C.Bekal_Sebelum,
                    C.Tujuan,
                    CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    D.Pejabat

                    from SMKB_Perolehan_Pembelian_Hdr As A
                    INNER JOIN SMKB_Perolehan_Pembelian_Dtl As B On b.Id_Pembelian = a.Id_Pembelian
                    INNER JOIN SMKB_Perolehan_Permohonan_Hdr As C On c.No_Mohon = a.No_Mohon
                    INNER JOIN VPeribadi As D On d.MS01_NoStaf = c.Id_Pemohon
                    INNER JOIN SMKB_Syarikat_Master As E ON E.No_Sykt = C.Kod_Syarikat
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON C.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'

                    where A.Keputusan_Lantik = '40' " & tarikhQuery & " "

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

        Dim query As String = " Select
                                D.Kod_Kump_Wang,D.Kod_Operasi,D.Kod_Ptj,D.Kod_Projek,D.Kod_Vot,D.Butiran,
                                A.Kuantiti,FORMAT(A.Harga_Seunit, 'N2') As Harga_Seunit, FORMAT(A.Harga_Seunit_Bercukai, 'N2') As Harga_Seunit_Bercukai,FORMAT(A.Jumlah_Harga, 'N2') As Jumlah_Harga,FORMAT(A.Jumlah_Harga_Bercukai, 'N2') As Jumlah_Harga_Bercukai,
                                (select Butiran from SMKB_Lookup_Detail where Kod = 'PO06 'And Kod_Detail = D.Ukuran ) As NewButiran
                                from SMKB_Perolehan_Pembelian_Dtl As A
                                Inner Join SMKB_Perolehan_Pembelian_Hdr As B On A.Id_Pembelian = B.Id_Pembelian
                                Inner Join  SMKB_Perolehan_Permohonan_Hdr As C On B.No_Mohon = C.No_Mohon
                                Inner Join SMKB_Perolehan_Permohonan_Dtl As D On A.Id_Mohon_Dtl = D.Id_Mohon_Dtl
                                Inner Join SMKB_Lookup_Detail As E On D.Ukuran = E.Kod_Detail
                                where B.Keputusan_Lantik = '1' And B.No_Mohon = @nombor_mohon And E.Kod ='PO06'"

        'Dim query As String = "SELECT Id_Mohon_Dtl, Kod_Kump_Wang, Kod_Operasi, Kod_Ptj, Kod_Projek, Kod_Vot, FORMAT(Baki_Peruntukan, '0.00') as Baki_Peruntukan, Butiran,
        '    Kuantiti, Ukuran, FORMAT(Kadar_Harga,'0.00') AS Kadar_Harga, FORMAT(Jumlah_Harga,'0.00') AS Jumlah_Harga FROM SMKB_Perolehan_Permohonan_Dtl WHERE No_Mohon = @nombor_mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@nombor_mohon", id))

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiUntukPembatalan(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SenaraiUtkBatal(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_SenaraiUtkBatal(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        Dim query = "SELECT  a.No_Mohon, FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Skop,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,d.Pejabat As NamaPejabat,               
                       a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, CONCAT('RM ', a.Perolehan_Terdahulu) AS Perolehan_Terdahulu,a.Justifikasi,FORMAT(a.Bekal_Sebelum,'dd/MM/yyyy') AS Bekal_Sebelum, 
                       kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                       StatusPO.Butiran As ButiranKodDok,
                       SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP,SMSM.JawGiliran,SMSM.MS01_VoIP
                       FROM SMKB_Perolehan_Permohonan_Hdr AS a
                       INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
                       INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
                       INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
                       INNER JOIN VPejabat As D ON a.Bekal_Kepada = D.KodPejabat
                       where id_pemohon= '02634' and StatusPO.Kod_Modul='02' and Status_Dok = '06' " & tarikhQuery & "
                       ORDER BY a.Tarikh_Mohon Desc"



        Return db.Read(query, param)
    End Function


    'Dropdown Kategori Perolehan
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPembekal(ByVal q As String) As String
        Dim tmpDT As DataTable = GetLoadPembekal(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetLoadPembekal(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "select id_sykt as value, Nama_Sykt as text from SMKB_Syarikat_Master"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " WHERE (id_sykt LIKE '%' + @kod + '%' OR Nama_Sykt LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Load DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FindKodSyarikat(ByVal idSyarikat As String) As String
        Dim resp As New ResponseRepository

        Dim noSyarikat As String = Get_FindKodSyarikat(idSyarikat)
        resp.SuccessPayload(noSyarikat)

        Return JsonConvert.SerializeObject(noSyarikat)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_FindKodSyarikat(idSyarikat As String) As String
        Dim db = New DBKewConn

        Dim query As String = "Select No_Sykt from SMKB_Syarikat_Master
                           where ID_Sykt = @ID_Sykt"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@ID_Sykt", idSyarikat))

        Dim dt As DataTable = db.Read(query, param)

        If dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("No_Sykt")) Then
            Return dt.Rows(0)("No_Sykt").ToString()
        Else
            Return String.Empty
        End If

    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FindKodPemiutang(ByVal idSyarikat As String) As String
        Dim resp As New ResponseRepository

        Dim kodSyarikat As String = Get_FindKodPemiutang(idSyarikat)
        resp.SuccessPayload(kodSyarikat)

        Return JsonConvert.SerializeObject(kodSyarikat)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_FindKodPemiutang(idSyarikat As String) As String
        Dim db = New DBKewConn

        Dim query As String = "Select Kod_Pemiutang from SMKB_Pemiutang_Master
                              where No_Rujukan =@idSyarikat"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))

        Dim dt As DataTable = db.Read(query, param)

        If dt.Rows.Count > 0 AndAlso Not IsDBNull(dt.Rows(0)("Kod_Pemiutang")) Then
            Return dt.Rows(0)("Kod_Pemiutang").ToString()
        Else
            Return String.Empty
        End If

    End Function


    'afiq START

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Syarikat_Master(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKod_Syarikat_Master(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetKod_Syarikat_Master(ID_Sykt As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
                    SELECT ID_Sykt as kodValue, No_Sykt as kodNo, CONCAT(ID_Sykt, ' - ', Nama_Sykt) as text
                    FROM SMKB_Syarikat_Master 
                    ORDER BY ID_Sykt 
                    "
        Dim param As New List(Of SqlParameter)

        If ID_Sykt <> "" Then
            query &= " AND (ID_Sykt LIKE '%' + @ID_Sykt + '%') "
            param.Add(New SqlParameter("@ID_Sykt", ID_Sykt))
        End If

        Return db.Read(query, param)
    End Function


    ' Perolehan_MesyPTeknikal START

    'Dropdown Kategori Pembekal START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPembekalPO(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodPembekalPO(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodPembekalPO(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Detail as kodValue, Kod_Detail + ' - ' + Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = 'PO03'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Dropdown Kategori Bekalan END


    'Dropdown Perolehan_Pesanan_Hdr START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPerolehanPesananHdr(ByVal q As String, category_filter As String, tkhMula As String, TkhTamat As String, IdSyarikat As String) As String

        Dim tmpDT As DataTable = GetKodPerolehanPesananHdr(q, category_filter, tkhMula, TkhTamat, IdSyarikat)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function
    Private Function GetKodPerolehanPesananHdr(kod As String, category_filter As String, tkhMula As String, TkhTamat As String, IdSyarikat As String) As DataTable
        Dim db = New DBKewConn
        Dim dataQuery As String = ""
        Dim param As New List(Of SqlParameter)

        If category_filter = "" Then 'kosong
            dataQuery = ""
        ElseIf category_filter = "1" Then 'PT No
            dataQuery = ""
        ElseIf category_filter = "4" Then 'Pembekal

            dataQuery = " WHERE Id_Syarikat = @IdSyarikat "
            param.Add(New SqlParameter("@IdSyarikat", IdSyarikat))
        ElseIf category_filter = "3" Then 'Tarikh
            dataQuery = " WHERE Tarikh_Pesanan >= @tkhMula and Tarikh_Pesanan <= @TkhTamat "
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", TkhTamat))

        End If

        Dim query As String = "SELECT No_Pesanan as kodValue, No_Pesanan as text FROM SMKB_Perolehan_Pesanan_Hdr " & dataQuery & ""





        If kod <> "" Then
            query &=
                " 
                    AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') 
                    

                "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Dropdown Perolehan_Pesanan_Hdr END

    ''Dropdown Kategori Bank START
    '<System.Web.Services.WebMethod()>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function GetBankPO(ByVal q As String) As String
    '    Dim tmpDT As DataTable = GetKodBankPO(q)
    '    Return JsonConvert.SerializeObject(tmpDT)
    'End Function
    'Private Function GetKodBankPO(kod As String) As DataTable
    '    Dim db = New DBKewConn
    '    Dim query As String = "SELECT Kod_Detail as kodValue, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod ='0150'"
    '    Dim param As New List(Of SqlParameter)
    '    If kod <> "" Then
    '        query &= " AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
    '        param.Add(New SqlParameter("@kod", kod))
    '        param.Add(New SqlParameter("@kod2", kod))
    '    End If

    '    Return db.Read(query, param)
    'End Function

    ''Dropdown Kategori Bank END


    'Dropdown Kategori Bank START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBankPO(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodBankPO(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodBankPO(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Id_No as kodValue, Bayar_Atas_Nama as text FROM SMKB_Perolehan_Pemfaktoran_Bank "
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Detail LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Dropdown Kategori Bank END


    'Dropdown Kategori syarikat START
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSyarikatPO(ByVal q As String, Jenis_Barang As String) As String
        Dim tmpDT As DataTable = GetKodSyarikatPO(q, Jenis_Barang)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodSyarikatPO(kod As String, Jenis_Barang As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
        SELECT B.ID_Sykt as value, B.Nama_Sykt as text, A.Jenis_Barang
        FROM SMKB_Perolehan_Permohonan_Hdr As A
        INNER JOIN SMKB_Syarikat_Master As B ON B.No_Sykt = A.Kod_Syarikat
        WHERE Jenis_Barang = @Jenis_Barang
    "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Jenis_Barang", Jenis_Barang))

        If kod <> "" Then
            query &= " AND (No_Sykt LIKE '%' + @kod + '%' OR Nama_Sykt LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    'Dropdown Kategori syarikat END

    'LoadPerolehan_Pesanan_Hdr START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pesanan_Hdr(IdPesanan As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Pesanan_Hdr(IdPesanan)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_Hdr(IdPesanan As String) As DataTable
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
            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0150' AND Kod_Detail = B.Kod_Bank)As Name_bank,
            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0003' AND Kod_Detail = Bandar_Semasa ) As Bandar_name,
            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0002' AND Kod_Detail = Kod_Negeri_Semasa ) As Negeri_name,
            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0001' AND Kod_Detail = Kod_Negara_Semasa ) As Negara_name,
            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0003' AND Kod_Detail = D.Bandar ) As Bandar_nameBank,
            (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0002' AND Kod_Detail = D.Negeri ) As Negeri_nameBank,
            D.Kod_Bank As Main_Kod_Bank,FORMAT(A.Tarikh_Pesanan,'yyyy-MM-dd') As Tarikh_PT1,C.ID_Sykt,
            *
            FROM SMKB_Perolehan_Pesanan_Hdr As A
            LEFT JOIN SMKB_Perolehan_Pemfaktoran As B On A.No_Pesanan=B.No_Pesanan
            INNER JOIN SMKB_Syarikat_Master As C On A.Id_Syarikat = C.ID_Sykt
            LEFT JOIN SMKB_Perolehan_Pemfaktoran_Bank As D On B.Id_Pemfaktoran_Bank = D.Id_No
            WHERE A.No_Pesanan = @IdPesanan
            "

            'query = "
            '     SELECT *
            '    FROM SMKB_Perolehan_Pesanan_Hdr As A
            '    INNER JOIN SMKB_Perolehan_Pemfaktoran As B On A.No_Pesanan=B.No_Pesanan
            '    where No_Pesanan = @IdPesanan
            '"
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdPesanan", IdPesanan))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'LoadPerolehan_Pesanan_Hdr END


    'LoadPemfaktoran_Bank START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPemfaktoran_Bank(IdPemfaktoranBank As String) As String
        Dim resp As New ResponseRepository




        dt = GetOrder_Pemfaktoran_Bank(IdPemfaktoranBank)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pemfaktoran_Bank(IdPemfaktoranBank As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                 SELECT (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0150' AND Kod_Detail = Kod_Bank)As Name_bank ,
                 (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0003' AND Kod_Detail = Bandar ) As Bandar_name,
                 (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0002' AND Kod_Detail = Negeri ) As Negeri_name,
                 (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0001' AND Kod_Detail = Negara ) As Negara_name,
                 * FROM SMKB_Perolehan_Pemfaktoran_Bank
                WHERE Id_No = @IdPemfaktoranBank
            "


            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdPemfaktoranBank", IdPemfaktoranBank))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'LoadPemfaktoran_Bank END

    'HantarPemfaktoran START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateHantarPemfaktoran(Pemfaktoran_dtl As Pemfaktoran_dtl1) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Pemfaktoran_dtl Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Pemfaktoran_dtl.txtIdFaktor = "" Then
            If Query_InsetPO_BajetSpesifikasi(Pemfaktoran_dtl) <> "OK" Then
                resp.Failed("Gagal mengemaskini rekod")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Else
            If Query_UpdatePO_BajetSpesifikasi(Pemfaktoran_dtl) <> "OK" Then
                resp.Failed("Gagal mengemaskini rekod")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If



        resp.Success("Rekod berjaya dikemaskini", "00", Pemfaktoran_dtl)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function Query_UpdatePO_BajetSpesifikasi(Pemfaktoran_dtl As Pemfaktoran_dtl1) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pemfaktoran
                              SET Id_Pemfaktoran_Bank = @IdPemfaktoranBank, Kod_Bank = @txtKodBank, Bayar_Atas_Nama = @txtBayar_Atas_Nama
                              WHERE Id_Faktor = @IdFaktor  AND No_Pesanan = @txtNo_PT
                            "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@IdFaktor", Pemfaktoran_dtl.txtIdFaktor))
        param.Add(New SqlParameter("@IdPemfaktoranBank", Pemfaktoran_dtl.txtId_Pemfaktoran_Bank))
        param.Add(New SqlParameter("@txtNo_PT", Pemfaktoran_dtl.txtNo_PT))
        param.Add(New SqlParameter("@txtBayar_Atas_Nama", Pemfaktoran_dtl.txtBayar_Atas_Nama))
        param.Add(New SqlParameter("@txtKodBank", Pemfaktoran_dtl.txtKodBank))

        Return db.Process(query, param)
    End Function

    Private Function Query_InsetPO_BajetSpesifikasi(Pemfaktoran_dtl As Pemfaktoran_dtl1) As String
        Dim db As New DBKewConn
        Dim query As String = "
                                INSERT INTO SMKB_Perolehan_Pemfaktoran ( Id_Pemfaktoran_Bank , Kod_Bank , Bayar_Atas_Nama, No_Pesanan, Status ) 
                                VALUES ( @IdPemfaktoranBank, @txtKodBank,@txtBayar_Atas_Nama, @txtNo_PT, '1') 
                            "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@IdPemfaktoranBank", Pemfaktoran_dtl.txtId_Pemfaktoran_Bank))
        param.Add(New SqlParameter("@txtNo_PT", Pemfaktoran_dtl.txtNo_PT))
        param.Add(New SqlParameter("@txtBayar_Atas_Nama", Pemfaktoran_dtl.txtBayar_Atas_Nama))
        param.Add(New SqlParameter("@txtKodBank", Pemfaktoran_dtl.txtKodBank))

        Return db.Process(query, param)
    End Function

    'HantarPemfaktoran END

    'LoadPerolehan_Pesanan_CT START


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pesanan_CT(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_Pesanan_CT(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetOrder_Pesanan_CT(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(A.Tarikh_Pesanan AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(A.Tarikh_Pesanan AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(A.Tarikh_Pesanan AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and A.Tarikh_Pesanan >= DATEADD(month, -1, getdate()) and A.Tarikh_Pesanan <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " andA.Tarikh_Pesanan >= DATEADD(month, -2, getdate()) and A.Tarikh_Pesanan <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and A.Tarikh_Pesanan >= @tkhMula and A.Tarikh_Pesanan <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query = " 
                SELECT FORMAT(SUM(E.Jumlah_Harga),'0.00') AS tot_Jumlah_Harga,
                A.No_Mohon, A.No_Pesanan, FORMAT(A.Tarikh_Pesanan,'dd/MM/yyyy') AS Tarikh_Pesanan, B.Tujuan, C.Nama_Sykt
                FROM SMKB_Perolehan_Pesanan_Hdr AS A
                INNER JOIN SMKB_Perolehan_Permohonan_Hdr AS B ON A.No_Mohon = B.No_Mohon
                INNER JOIN SMKB_Syarikat_Master AS C ON A.Id_Syarikat = C.ID_Sykt
                INNER JOIN SMKB_Perolehan_Permohonan_Dtl AS D ON B.No_Mohon = D.No_Mohon
                INNER JOIN SMKB_Perolehan_Pembelian_Dtl AS E On E.Id_Mohon_Dtl = D.Id_Mohon_Dtl
                where  B.Status_Dok = '41'  " & tarikhQuery & " 
                GROUP BY A.No_Mohon, A.No_Pesanan, A.Tarikh_Pesanan, B.Tujuan, C.Nama_Sykt  
                
                "

        Return db.Read(query, param)
    End Function

    ' LoadPerolehan_Pesanan_CT END

    ' LoadPerolehan_Pesanan_print START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pesanan_print(IdPesanan As String) As String
        Dim resp As New ResponseRepository

        dt = GetOrder_Pesanan_print(IdPesanan)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_print(IdPesanan As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
               SELECT (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= 'SI003' AND Kod_Detail = D.Ukuran ) As Unit_Ukuran,
             D.Kod_Kump_Wang, D.Kod_Ptj,D.Kod_Vot, D.Butiran,E.Kod_Negara_Pembuat,E.Harga_Seunit, E.Jumlah_Harga,E.Kuantiti
             FROM SMKB_Perolehan_Pesanan_Hdr AS A
             INNER JOIN SMKB_Perolehan_Permohonan_Hdr AS B ON A.No_Mohon = B.No_Mohon
             INNER JOIN SMKB_Syarikat_Master AS C ON A.Id_Syarikat = C.ID_Sykt
             INNER JOIN SMKB_Perolehan_Permohonan_Dtl AS D ON B.No_Mohon = D.No_Mohon
             INNER JOIN SMKB_Perolehan_Pembelian_Dtl AS E On E.Id_Mohon_Dtl = D.Id_Mohon_Dtl
                where A.No_Pesanan = @IdPesanan
                
            "
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdPesanan", IdPesanan))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' LoadPerolehan_Pesanan_print END


    ' LoadPerolehan_Pesanan_print START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pesanan_print_Dtl(IdPesanan As String) As String
        Dim resp As New ResponseRepository

        dt = GetOrder_Pesanan_print_Dtl(IdPesanan)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_print_Dtl(IdPesanan As String) As DataTable
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
                 FROM SMKB_Perolehan_Pesanan_Hdr As A
                 INNER JOIN SMKB_Perolehan_Permohonan_Hdr As B On A.No_Mohon = B.No_Mohon
                 INNER JOIN SMKB_Syarikat_Master As C On A.Id_Syarikat = C.ID_Sykt
                 INNER JOIN SMKB_Perolehan_Naskah_Jualan As D On A.No_Mohon = D.No_Mohon
                 INNER JOIN VPeribadi As E On E.MS01_NoStaf = B.Id_Pemohon
                 where A.No_Pesanan = @IdPesanan
                
            "
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdPesanan", IdPesanan))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' LoadPerolehan_Pesanan_print END


    ' LoadPerolehan_Pesanan_Pelarasan START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pesanan_Pelarasan(postData As String) As String
        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim req As Response = GetOrder_Pesanan_Pelarasan(postDt)
        Return JsonConvert.SerializeObject(req)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetOrder_Pesanan_Pelarasan(postDt) As Response
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)
        Dim db = New DBKewConn
        Dim dt As New DataTable
        Dim res As New Response
        Dim category_filter As String = postDt("category_filter")
        Dim tkhMula As String = postDt("tkhMula")
        Dim tkhTamat As String = postDt("tkhTamat")

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(Tarikh_Lulus_Ketua_Ptj AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(Tarikh_Lulus_Ketua_Ptj AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND Tarikh_Lulus_Ketua_Ptj >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND Tarikh_Lulus_Ketua_Ptj < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tarikh_Lulus_Ketua_Ptj >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND Tarikh_Lulus_Ketua_Ptj < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tarikh_Lulus_Ketua_Ptj >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND Tarikh_Lulus_Ketua_Ptj < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tarikh_Lulus_Ketua_Ptj >= @tkhMula AND Tarikh_Lulus_Ketua_Ptj <= @tkhTamat "
        End If

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@TkhTamat", tkhTamat))

        res.Code = 200
        Try
            Dim sqlText As String = $"SELECT *,
                                    ( Select TOP 1 No_Pelarasan From SMKB_Perolehan_Pelarasan_Hdr Where No_Pesanan = A.No_Pesanan Order By No_Pelarasan Desc) As No_Pelarasan,
                                    ( Select TOP 1 Tarikh_Pelarasan From SMKB_Perolehan_Pelarasan_Hdr Where No_Pesanan = A.No_Pesanan Order By No_Pelarasan Desc) As No_Pelarasan
                                    From SMKB_Perolehan_Pesanan_Hdr As A 
                                    INNER JOIN SMKB_Syarikat_Master AS C ON A.Id_Syarikat = C.ID_Sykt
                                    INNER JOIN SMKB_Perolehan_Permohonan_Hdr AS D ON A.No_Mohon = D.No_Mohon
                                    " & tarikhQuery & "Order By Tarikh_Lulus_Ketua_Ptj Desc"

            res.Payload = db.Read(sqlText, param)
        Catch ex As Exception
            Dim strex As String = ex.Message
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function


    ' LoadPerolehan_Pesanan_Pelarasan END


    ' LoadPerolehan_Pesanan_Pelarasan_Dtl START
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pesanan_Pelarasan_Dtl(postData As String) As String
        Dim resp As New ResponseRepository
        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        dt = GetOrder_Pesanan_Pelarasan_Dtl(postDt("TargetId"))

        If dt.Rows.Count > 0 Then
            resp.Success("Rekod ditemui", "00", dt)
        Else
            resp.Failed("Tiada rekod ditemui")
        End If

        'Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_Pelarasan_Dtl(IdPesanan As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            'query = "
            '    Select Top 1 E.No_Pelarasan As No_Pelarasan,
            '    E.Jumlah_Asal As Jumlah_Asal,
            '    Format(E.Tarikh_Pelarasan,'yyyy-MM-dd') As Tarikh_Pelarasan,
            '    E.Ulasan_Pelarasan,
            '    A.No_Mohon,A.No_Pesanan,C.ID_Sykt,
            '    Format(A.Tarikh_Pesanan,'yyyy-MM-dd') As Tarikh_Pesanan,
            '    B.No_Sebut_Harga,B.Tarikh_Daftar,C.Nama_Sykt,
            '    Format(F.Bekal_Sebelum,'yyyy-MM-dd') As Bekal_Sebelum,
            '    F.Id_Pemohon, F.Skop,
            '    (SELECT KodPejPBU + ' - ' + Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT WHERE KodPejabat = F.Bekal_Kepada) AS Bekal_Kepada,
            '    (SELECT Id_Pembelian From SMKB_Perolehan_Pembelian_Hdr Where ID_Syarikat = C.ID_Sykt And No_Mohon = A.No_Mohon) As IdPembelian,
            '    (SELECT MS01_NoTelBimbit FROM VPeribadi WHERE  MS01_NoStaf = F.Id_Pemohon ) As NoTelBimbit,
            '    (SELECT MS01_Nama FROM VPeribadi WHERE  MS01_NoStaf = F.Id_Pemohon ) As NamaPemohon,
            '    (SELECT Kod_Pemiutang FROM SMKB_Pemiutang_Master WHERE  No_Rujukan = D.ID_Syarikat ) As KodPemiutang
            '    from SMKB_Perolehan_Pesanan_Hdr As A
            '    Inner Join SMKB_Perolehan_Pembelian_Hdr AS D On A.No_Mohon = D.No_Mohon
            '    Inner Join SMKB_Perolehan_Naskah_Jualan As B On a.No_Mohon = b.No_Mohon
            '    Inner Join SMKB_Syarikat_Master As C On C.ID_Sykt = D.ID_Syarikat
            '    Inner Join SMKB_Perolehan_Permohonan_Hdr As F On F.No_Mohon = A.No_Mohon
            '    Left Join SMKB_Perolehan_Pelarasan_Hdr As E On E.No_Pesanan = A.No_Pesanan
            '    where A.No_Pesanan = @IdPesanan Order By No_Pelarasan Desc
            '"

            query = "Select Top 1 E.No_Pelarasan As No_Pelarasan,
                       E.Jumlah_Asal As Jumlah_Asal,
                       Format(E.Tarikh_Pelarasan,'yyyy-MM-dd') As Tarikh_Pelarasan,
                       E.Ulasan_Pelarasan,
                       A.No_Mohon,A.No_Pesanan,C.ID_Sykt,
                       Format(A.Tarikh_Pesanan,'yyyy-MM-dd') As Tarikh_Pesanan,
                       B.No_Sebut_Harga,B.Tarikh_Daftar,C.Nama_Sykt,
                       Format(F.Bekal_Sebelum,'yyyy-MM-dd') As Bekal_Sebelum,
                       F.Id_Pemohon, F.Skop,
                       (SELECT KodPejabat + ' - ' + Pejabat FROM VPejabat WHERE KodPejabat = left(F.Bekal_Kepada,2)) AS Bekal_Kepada,
                       (SELECT Id_Pembelian From SMKB_Perolehan_Pembelian_Hdr Where ID_Syarikat = C.ID_Sykt And No_Mohon = A.No_Mohon) As IdPembelian,
                       (SELECT MS01_NoTelBimbit FROM VPeribadi WHERE  MS01_NoStaf = F.Id_Pemohon ) As NoTelBimbit,
                       (SELECT MS01_Nama FROM VPeribadi WHERE  MS01_NoStaf = F.Id_Pemohon ) As NamaPemohon,
                       (SELECT Kod_Pemiutang FROM SMKB_Pemiutang_Master WHERE  No_Rujukan = D.ID_Syarikat ) As KodPemiutang
                       from SMKB_Perolehan_Pesanan_Hdr As A
                       Inner Join SMKB_Perolehan_Pembelian_Hdr AS D On A.No_Mohon = D.No_Mohon
                       Inner Join SMKB_Perolehan_Naskah_Jualan As B On a.No_Mohon = b.No_Mohon
                       Inner Join SMKB_Syarikat_Master As C On C.ID_Sykt = D.ID_Syarikat
                       Inner Join SMKB_Perolehan_Permohonan_Hdr As F On F.No_Mohon = A.No_Mohon
                       Left Join SMKB_Perolehan_Pelarasan_Hdr As E On E.No_Pesanan = A.No_Pesanan
                       where A.No_Pesanan = @IdPesanan Order By No_Pelarasan Desc"

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdPesanan", IdPesanan))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pesanan_Pelarasan_Dtl2(IdPesanan As String) As String
        Dim resp As New ResponseRepository

        dt = GetOrder_Pesanan_Pelarasan_Dtl2(IdPesanan)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_Pelarasan_Dtl2(IdPesanan As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            'query = "
            '    Select E.No_Pelarasan,
            '    Format(E.Tarikh_Pelarasan,'yyyy-MM-dd') As Tarikh_Pelarasan,
            '    E.Ulasan_Pelarasan,
            '    A.No_Mohon,A.No_Pesanan,C.ID_Sykt,
            '    Format(A.Tarikh_Pesanan,'yyyy-MM-dd') As Tarikh_Pesanan,
            '    B.No_Sebut_Harga,B.Tarikh_Daftar,C.Nama_Sykt,
            '    Format(F.Bekal_Sebelum,'yyyy-MM-dd') As Bekal_Sebelum,
            '    F.Id_Pemohon, F.Skop,
            '    (SELECT KodPejPBU + ' - ' + Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT WHERE KodPejabat = F.Bekal_Kepada) AS Bekal_Kepada,
            '    (SELECT Id_Pembelian From SMKB_Perolehan_Pembelian_Hdr Where ID_Syarikat = C.ID_Sykt And No_Mohon = A.No_Mohon) As IdPembelian,
            '    (SELECT MS01_NoTelBimbit FROM VPeribadi WHERE  MS01_NoStaf = F.Id_Pemohon ) As NoTelBimbit,
            '    (SELECT MS01_Nama FROM VPeribadi WHERE  MS01_NoStaf = F.Id_Pemohon ) As NamaPemohon,
            '    (SELECT Kod_Pemiutang FROM SMKB_Pemiutang_Master WHERE  No_Rujukan = D.ID_Syarikat ) As KodPemiutang
            '    from SMKB_Perolehan_Pesanan_Hdr As A
            '    Inner Join SMKB_Perolehan_Pembelian_Hdr AS D On A.No_Mohon = D.No_Mohon
            '    Inner Join SMKB_Perolehan_Naskah_Jualan As B On a.No_Mohon = b.No_Mohon
            '    Inner Join SMKB_Syarikat_Master As C On C.ID_Sykt = D.ID_Syarikat
            '    Inner Join SMKB_Perolehan_Permohonan_Hdr As F On F.No_Mohon = A.No_Mohon
            '    Left Join SMKB_Perolehan_Pelarasan_Hdr As E On E.No_Pesanan = A.No_Pesanan
            '    where A.No_Pesanan = @IdPesanan

            '"


            query = "Select E.No_Pelarasan,
                    Format(E.Tarikh_Pelarasan,'yyyy-MM-dd') As Tarikh_Pelarasan,
                    E.Ulasan_Pelarasan,
                    A.No_Mohon,A.No_Pesanan,C.ID_Sykt,
                    Format(A.Tarikh_Pesanan,'yyyy-MM-dd') As Tarikh_Pesanan,
                    B.No_Sebut_Harga,B.Tarikh_Daftar,C.Nama_Sykt,
                    Format(F.Bekal_Sebelum,'yyyy-MM-dd') As Bekal_Sebelum,
                    F.Id_Pemohon, F.Skop,
                    (SELECT KodPejabat + '0000' + ' - ' + Pejabat FROM VPejabat WHERE KodPejabat = F.Bekal_Kepada) AS Bekal_Kepada,
                    (SELECT Id_Pembelian From SMKB_Perolehan_Pembelian_Hdr Where ID_Syarikat = C.ID_Sykt And No_Mohon = A.No_Mohon) As IdPembelian,
                    (SELECT MS01_NoTelBimbit FROM VPeribadi WHERE  MS01_NoStaf = F.Id_Pemohon ) As NoTelBimbit,
                    (SELECT MS01_Nama FROM VPeribadi WHERE  MS01_NoStaf = F.Id_Pemohon ) As NamaPemohon,
                    (SELECT Kod_Pemiutang FROM SMKB_Pemiutang_Master WHERE  No_Rujukan = D.ID_Syarikat ) As KodPemiutang
                    from SMKB_Perolehan_Pesanan_Hdr As A
                    Inner Join SMKB_Perolehan_Pembelian_Hdr AS D On A.No_Mohon = D.No_Mohon
                    Inner Join SMKB_Perolehan_Naskah_Jualan As B On a.No_Mohon = b.No_Mohon
                    Inner Join SMKB_Syarikat_Master As C On C.ID_Sykt = D.ID_Syarikat
                    Inner Join SMKB_Perolehan_Permohonan_Hdr As F On F.No_Mohon = A.No_Mohon
                    Left Join SMKB_Perolehan_Pelarasan_Hdr As E On E.No_Pesanan = A.No_Pesanan
                    where A.No_Pesanan = @IdPesanan"


            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdPesanan", IdPesanan))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' LoadPerolehan_Pesanan_Pelarasan_Dtl END


    ' LoadPerolehan_Pesanan_Pelarasan_Tbl START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPerolehan_Pesanan_Pelarasan_Tbl(dllNo_mohon As String) As String
        Dim resp As New ResponseRepository

        dt = GetOrder_Pesanan_Pelarasan_Tbl(dllNo_mohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pesanan_Pelarasan_Tbl(dllNo_mohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                 Select
                 D.Kod_Kump_Wang,
                 D.Baki_Peruntukan,
                 (Select Butiran From SMKB_Kump_Wang Where Kod_Kump_Wang = D.Kod_Kump_Wang) As Txt_Kump_Wang,
                 D.Kod_Operasi,
                 (Select Butiran From SMKB_Operasi Where Kod_Operasi =  D.Kod_Operasi) As Txt_Operasi,
                 D.Kod_Ptj,
                 (SELECT Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT WHERE KodPejPBU = D.Kod_Ptj) AS Txt_Ptj,
                 D.Kod_Projek,
                 (Select Butiran From SMKB_Projek Where Kod_Projek =  D.Kod_Projek) As Txt_Projek,
                 D.Kod_Vot,
                 (Select Butiran From SMKB_Vot Where Kod_Vot =  D.Kod_Vot) As Txt_Vot,
                 D.Butiran, A.Id_Dtl, A.Id_Mohon_Dtl, D.Ukuran,
                 A.Kuantiti,
                 FORMAT(A.Harga_Seunit, 'N2') As Harga_Seunit, 
                 FORMAT(A.Harga_Seunit_Bercukai, 'N2') As Harga_Seunit_Bercukai,
                 FORMAT(A.Jumlah_Harga, 'N2') As Jumlah_Harga,
                 FORMAT(A.Jumlah_Harga, 'N2') As Jumlah_Harga_Asal,
                 FORMAT(A.Jumlah_Harga_Bercukai, 'N2') As Jumlah_Harga_Bercukai,
                 (select Butiran from SMKB_Lookup_Detail where Kod = 'PO06 'And Kod_Detail = D.Ukuran ) As Txt_Ukuran,
                 A.Id_Mohon_Dtl
                 from SMKB_Perolehan_Pembelian_Dtl As A
                 Inner Join SMKB_Perolehan_Pembelian_Hdr As B On A.Id_Pembelian = B.Id_Pembelian
                 Inner Join  SMKB_Perolehan_Permohonan_Hdr As C On B.No_Mohon = C.No_Mohon
                 Inner Join SMKB_Perolehan_Permohonan_Dtl As D On A.Id_Mohon_Dtl = D.Id_Mohon_Dtl
                 Inner Join SMKB_Lookup_Detail As E On D.Ukuran = E.Kod_Detail
                 where B.Keputusan_Lantik = '1' And B.No_Mohon = @nombor_mohon And E.Kod ='PO06'

            "
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@nombor_mohon", dllNo_mohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    ' LoadPerolehan_Pesanan_Pelarasan_Tbl END

    'Afiq END

    'Faiz START
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function SubmitPelarasan(postData As String) As Tasks.Task(Of String)
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        ' Deserialize JSON data into a JObject
        Dim postDt As JObject = JObject.Parse(postData)

        ' Initialize a dictionary to hold the deserialized data
        Dim objDt As New Dictionary(Of String, Dictionary(Of String, String))

        ' Simpan new item 
        Dim objDtNewItem As New Dictionary(Of String, Dictionary(Of String, String))

        ' Simpan delete item 
        Dim objDtDelItem As New Dictionary(Of String, Dictionary(Of String, String))

        ' Access the nested data directly from the "data" property
        Dim itemList As JObject = postDt("data")

        ' Iterate over each property in the JObject
        For Each prop As JProperty In itemList.Properties()
            ' Access data for each timestamp
            Dim dataForTimestamp As JObject = prop.Value

            ' Create a dictionary to hold the inner key-value pairs
            Dim innerDict As New Dictionary(Of String, String)

            ' Iterate over each key-value pair in the inner JObject
            For Each kvp As KeyValuePair(Of String, JToken) In dataForTimestamp
                innerDict.Add(kvp.Key, kvp.Value.ToString())
            Next

            ' Add the inner dictionary to the main dictionary using the timestamp as the key
            If prop.Name.Contains("newitem") Then
                objDtNewItem.Add(prop.Name, innerDict)
            ElseIf prop.Name.Contains("delitem") Then
                objDtDelItem.Add(prop.Name, innerDict)
            Else
                objDt.Add(ParseDtId(prop.Name, "yyyy-MM-ddTHH:mm:ss.fffffff"), innerDict)
            End If
        Next

        Dim noPesanan As String = postDt("noPesanan")
        Dim noMohon As String = postDt("noMohon")

        ' Get No Pelarasan 
        Dim noPelarasan As String = GenerateNoPelarasan()

        If noPelarasan = "" Then
            resp.Failed("1: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
        resultDt("NoPelarasan") = noPelarasan

        Dim lastBil As String = GetLastBilFromPermohonanDtl(postDt)
        If lastBil = "" Then
            resp.Failed("2: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        ' InsertPelarasanDtl
        If InsertPelarasanDtl(postDt, noPelarasan) <> "OK" Then
            'queryRB.rollback()
            resp.Failed("3: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query()

        'Insert Data Ke Pelarasan Hdr
        If InsertPelarasanHdr(postDt, noPelarasan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("4: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
        resultDt("TkhPelarasan") = Date.Now

        Dim dtJson = ReadPembelianDtl(postDt)
        If dtJson = "" Then
            resp.Failed("5: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePembelianDtl(postDt, objDt, dtJson) <> "OK" Then
            queryRB.rollback()
            resp.Failed("6: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Await AddNewItemProcess(objDtNewItem, postDt, lastBil) <> "OK" Then
            queryRB.rollback()
            resp.Failed("7: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Await DelItemPembelian(postDt, objDt, dtJson) <> "OK" Then
            queryRB.rollback()
            resp.Failed("8: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Await DelItemProcess(objDtDelItem, postDt) <> "OK" Then
            queryRB.rollback()
            resp.Failed("9: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        '' Iterate over each outer id_mohon_dtl
        For Each rowId As String In objDt.Keys
            ' Get the item data
            Dim itemDt As Dictionary(Of String, String) = objDt(rowId)
            Dim result = Await LejarAmProcess(itemDt)
            If result <> "OK" Then
                queryRB.rollback()
                resp.Failed("10: Sistem gagal memproses pelarasan ‼️")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Next

        '' Iterate over each outer id_mohon_dtl
        For Each rowId As String In objDt.Keys
            ' Get the item data
            Dim itemDt As Dictionary(Of String, String) = objDt(rowId)
            Dim result = Await LejarAmProcess2(itemDt, postDt)
            If result <> "OK" Then
                queryRB.rollback()
                resp.Failed("11: Sistem gagal memproses pelarasan ‼️")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Next

        queryRB.finish()

        resp.Success("Rekod telah berjaya disimpan", "00", resultDt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Public Function GetLastBilFromPermohonanDtl(postDt) As String
        Dim db As New DBKewConn

        ' Get Latest Bil
        Dim query As String = $"SELECT 
(SELECT COUNT(*) FROM SMKB_Perolehan_Permohonan_Dtl WHERE No_Mohon = '{postDt("noMohon")}') AS TotalRow,
(SELECT TOP 1 Bil FROM SMKB_Perolehan_Permohonan_Dtl WHERE No_Mohon = '{postDt("noMohon")}' ORDER BY Bil DESC) AS Bil"

        Dim param As New List(Of SqlParameter)

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            Dim totalRow = dt.Rows(0).Item("TotalRow")
            Dim result As String = If(dt.Rows(0).Item("Bil") Is DBNull.Value, totalRow, dt.Rows(0).Item("Bil"))
            Dim newBil As String = (CInt(result)).ToString()
            Return newBil
        Else
            Return ""
        End If
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function KemaskiniPelarasan(postData As String) As Tasks.Task(Of String)
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        ' Deserialize JSON data into a JObject
        Dim postDt As JObject = JObject.Parse(postData)

        ' Initialize a dictionary to hold the deserialized data
        Dim objDt As New Dictionary(Of String, Dictionary(Of String, String))

        ' Simpan new item 
        Dim objDtNewItem As New Dictionary(Of String, Dictionary(Of String, String))

        ' Simpan delete item 
        Dim objDtDelItem As New Dictionary(Of String, Dictionary(Of String, String))

        ' Access the nested data directly from the "data" property
        Dim itemList As JObject = postDt("data")

        ' Iterate over each property in the JObject
        For Each prop As JProperty In itemList.Properties()
            ' Access data for each timestamp
            Dim dataForTimestamp As JObject = prop.Value

            ' Create a dictionary to hold the inner key-value pairs
            Dim innerDict As New Dictionary(Of String, String)

            ' Iterate over each key-value pair in the inner JObject
            For Each kvp As KeyValuePair(Of String, JToken) In dataForTimestamp
                innerDict.Add(kvp.Key, kvp.Value.ToString())
            Next

            ' Add the inner dictionary to the main dictionary using the timestamp as the key
            If prop.Name.Contains("newitem") Then
                objDtNewItem.Add(prop.Name, innerDict)
            ElseIf prop.Name.Contains("delitem") Then
                objDtDelItem.Add(prop.Name, innerDict)
            Else
                ' Add the inner dictionary to the main dictionary using the timestamp as the key
                objDt.Add(ParseDtId(prop.Name, "yyyy-MM-ddTHH:mm:ss.fffffff"), innerDict)
            End If
        Next

        Dim noPesanan As String = postDt("noPesanan")
        Dim noMohon As String = postDt("noMohon")

        ' Get No Pelarasan 
        Dim noPelarasan As String = postDt("noPelarasan")

        If noPelarasan = "" Then
            resp.Failed("12: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim noPelarasanUpd As String = KemaskiniNoPelarasan(noPelarasan)

        If noPelarasanUpd = "" Then
            resp.Failed("13: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
        resultDt("NoPelarasan") = noPelarasanUpd

        Dim lastBil As String = GetLastBilFromPermohonanDtl(postDt)
        If lastBil = "" Then
            resp.Failed("14: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertPelarasanDtl(postDt, noPelarasanUpd) <> "OK" Then
            'queryRB.rollback()
            resp.Failed("15: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query()

        'Insert Data Ke Pelarasan Hdr
        If InsertPelarasanHdr(postDt, noPelarasanUpd) <> "OK" Then
            queryRB.rollback()
            resp.Failed("16: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
        resultDt("TkhPelarasan") = Date.Now

        Dim dtJson = ReadPembelianDtl(postDt)
        If dtJson = "" Then
            resp.Failed("17: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdatePembelianDtl(postDt, objDt, dtJson) <> "OK" Then
            queryRB.rollback()
            resp.Failed("18: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Await AddNewItemProcess(objDtNewItem, postDt, lastBil) <> "OK" Then
            queryRB.rollback()
            resp.Failed("19: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Await DelItemPembelian(postDt, objDt, dtJson) <> "OK" Then
            queryRB.rollback()
            resp.Failed("20: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Await DelItemProcess(objDtDelItem, postDt) <> "OK" Then
            queryRB.rollback()
            resp.Failed("21: Sistem gagal memproses pelarasan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        ' Iterate over each outer id_mohon_dtl
        For Each rowId As String In objDt.Keys
            ' Get the item data
            Dim itemDt As Dictionary(Of String, String) = objDt(rowId)
            Dim result = Await LejarAmProcess(itemDt)
            If result <> "OK" Then
                queryRB.rollback()
                resp.Failed("22: Sistem gagal memproses pelarasan ‼️")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Next

        ' Iterate over each outer id_mohon_dtl
        For Each rowId As String In objDt.Keys
            ' Get the item data
            Dim itemDt As Dictionary(Of String, String) = objDt(rowId)
            Dim result = Await LejarAmProcess2(itemDt, postDt)
            If result <> "OK" Then
                queryRB.rollback()
                resp.Failed("23: Sistem gagal memproses pelarasan ‼️")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Next

        queryRB.finish()

        resp.Success("Rekod telah berjaya dikemaskini", "00", resultDt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Public Async Function AddNewItemProcess(objDtNewItem, postDt, lastBil) As Task(Of String)
        'Jika ada penambahan item pada pelarasan lalu fungsi di bawah
        If objDtNewItem.Count > 0 Then

            Dim db As New DBKewConn

            ' Loop through each item in objDtNewItem
            For Each newItem As KeyValuePair(Of String, Dictionary(Of String, String)) In objDtNewItem
                ' Access the key (prop.Name) and the inner dictionary (innerDict) for the current item
                Dim newItemName As String = newItem.Key
                Dim itemDt As Dictionary(Of String, String) = newItem.Value

                Dim param As New List(Of SqlParameter)
                ' new id for permohonan permohonan detail
                Dim idMhnDtl As String = Date.Now.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
                lastBil = (Integer.Parse(lastBil) + 1).ToString()
                Dim query2 As String = $"INSERT INTO SMKB_Perolehan_Permohonan_Dtl 
                                    (Id_Mohon_Dtl, No_Mohon, Bil, Kod_Kump_Wang, Kod_Operasi, Kod_Ptj, Kod_Projek, Kod_Vot, Butiran, 
                                    Ukuran, Kuantiti, Kadar_Harga, Jumlah_Harga, Baki_Peruntukan, Status)
                                    VALUES ('{idMhnDtl}', '{postDt("noMohon")}', '{lastBil}', '{itemDt("Kod_Kump_Wang")}', '{itemDt("Kod_Operasi")}', 
                                    '{itemDt("Kod_Ptj")}', '{itemDt("Kod_Projek")}', '{itemDt("Kod_Vot")}', '{itemDt("Butiran")}', '{itemDt("Ukuran")}',
                                    '{itemDt("Kuantiti")}', '{itemDt("Harga_Seunit")}', '{itemDt("Jumlah_Harga")}', '{itemDt("Baki_Peruntukan")}', '1')"

                param.Clear()

                If RbQueryCmd("Id_Mohon_Dtl", idMhnDtl, query2, param) <> "OK" Then
                    Return "X"
                End If

                ' new id for permohonan pembelian detail
                Dim idDtl As String = Date.Now.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
                Dim query3 As String = $"INSERT INTO SMKB_Perolehan_Pembelian_Dtl 
                                        (Id_Dtl, Id_Mohon_Dtl, Id_Pembelian, Kuantiti, Harga_Seunit, Jumlah_Harga, Status) 
                                        VALUES ('{idDtl}', '{idMhnDtl}', '{postDt("idPembelian")}', '{itemDt("Kuantiti")}', '{itemDt("Harga_Seunit")}', 
                                        '{itemDt("Jumlah_Harga")}', '1')"

                param.Clear()

                If RbQueryCmd("Id_Dtl", idDtl, query3, param) <> "OK" Then
                    Return "X"
                End If

                Thread.Sleep(200)
            Next

            For Each newItem As KeyValuePair(Of String, Dictionary(Of String, String)) In objDtNewItem
                ' Access the key (prop.Name) and the inner dictionary (innerDict) for the current item
                Dim itemDt As Dictionary(Of String, String) = newItem.Value

                'Update Lejar
                Dim result = Await LejarAmProcess(itemDt)
                If result <> "OK" Then
                    Return "X"
                End If

                ''Update Lejar
                Dim result2 = Await LejarAmProcess2(itemDt, postDt)
                If result2 <> "OK" Then
                    Return "X"
                End If
            Next

            Return "OK"
        Else
            Return "OK"
        End If
    End Function

    Public Async Function DelItemProcess(objDtDelItem, postDt) As Task(Of String)
        If objDtDelItem.Count > 0 Then

            For Each delItem As KeyValuePair(Of String, Dictionary(Of String, String)) In objDtDelItem
                ' Access the key (prop.Name) and the inner dictionary (innerDict) for the current item
                Dim itemDt As Dictionary(Of String, String) = delItem.Value

                'Update Lejar
                Dim result = Await LejarAmProcess(itemDt)
                If result <> "OK" Then
                    Return "X"
                End If

                ''Update Lejar
                Dim result2 = Await LejarAmProcess2(itemDt, postDt)
                If result2 <> "OK" Then
                    Return "X"
                End If
            Next

            Return "OK"
        Else
            Return "OK"
        End If
    End Function

    Public Async Function LejarAmProcess(itemDt) As Tasks.Task(Of String)
        If itemDt.ContainsKey("Beza") Then 'Check jika itemDt ada field Beza, yg mana beza ni simpan value amount baru - amount lama
            Try
                Dim servicex As New ValuesService()
                Dim kodkw As String = itemDt("Kod_Kump_Wang")
                Dim kodko As String = itemDt("Kod_Operasi")
                Dim kodkp As String = itemDt("Kod_Projek")
                Dim kodptj As String = itemDt("Kod_Ptj")
                Dim KodVot As String = itemDt("Kod_Vot")
                Dim hasiltmbtlkHarga As String = itemDt("Beza")
                Dim dbcrTxt As String = ""

                ' Process dapatkan beza harga dan assign debit atau kredit
                Dim tempNum As Double
                If Double.TryParse(hasiltmbtlkHarga, tempNum) Then
                    ' Conversion successful
                    If tempNum > 0 Then
                        ' Value is greater than zero
                        dbcrTxt = "DR"
                        hasiltmbtlkHarga = tempNum.ToString()
                    Else
                        ' Value is not greater than zero
                        dbcrTxt = "CR"
                        hasiltmbtlkHarga = tempNum.ToString().Substring(1)
                    End If
                Else
                    Return "X"
                End If


                Dim myGetTicket As New TokenResponseModel()

                Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")
                Dim parsedDate As Date = CDate(Now()).ToString("yyyy-MM-dd")
                Dim vBulan As String = parsedDate.Month
                Dim vTahun As String = parsedDate.Year
                Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                             "GL", "UTeM", kodkw, kodptj,
                             KodVot, kodko, kodkp, hasiltmbtlkHarga, dbcrTxt, vBulan, vTahun)
                If values.Contains("ok") Then
                    Return "OK"
                    '    'lblModalMessaage.Text = "Rekod telah disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)

                Else
                    Return "X"
                    '    'lblModalMessaage.Text = "Rekod Gagal disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                End If
            Catch ex As Exception
                Return "X"
            End Try
        Else
            Return "OK"
        End If
    End Function

    Public Async Function LejarAmProcess2(itemDt, postDt) As Tasks.Task(Of String)
        If itemDt.ContainsKey("Beza") Then 'Check jika itemDt ada field Beza, yg mana beza ni simpan value amount baru - amount lama
            Try
                Dim servicex As New ValuesService()
                Dim kodkw As String = itemDt("Kod_Kump_Wang")
                Dim kodko As String = itemDt("Kod_Operasi")
                Dim kodkp As String = itemDt("Kod_Projek")
                Dim kodptj As String = itemDt("Kod_Ptj")
                Dim KodVot As String = itemDt("Kod_Vot")
                Dim hasiltmbtlkHarga As String = itemDt("Beza")
                Dim dbcrTxt As String = ""

                ' Process dapatkan beza harga dan assign debit atau kredit
                Dim tempNum As Double
                If Double.TryParse(hasiltmbtlkHarga, tempNum) Then
                    ' Conversion successful
                    If tempNum > 0 Then
                        ' Value is greater than zero
                        dbcrTxt = "DR"
                        hasiltmbtlkHarga = tempNum.ToString()
                    Else
                        ' Value is not greater than zero
                        dbcrTxt = "CR"
                        hasiltmbtlkHarga = tempNum.ToString().Substring(1)
                    End If
                Else
                    Return "X"
                End If


                Dim myGetTicket As New TokenResponseModel()

                Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")
                Dim parsedDate As Date = CDate(Now()).ToString("yyyy-MM-dd")
                Dim vBulan As String = parsedDate.Month
                Dim vTahun As String = parsedDate.Year
                Dim kodPemiutang As String = postDt("kodPemiutang")
                Dim values As String = Await servicex.SendDataLejar(myGetTicket.GetTicket("smkb", Session("ssusrID")),
                             "AP", kodPemiutang, kodkw, kodptj,
                             KodVot, kodko, kodkp, hasiltmbtlkHarga, dbcrTxt, vBulan, vTahun)
                If values.Contains("ok") Then
                    Return "OK"
                    '    'lblModalMessaage.Text = "Rekod telah disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)

                Else
                    Return "X"
                    '    'lblModalMessaage.Text = "Rekod Gagal disimpan" 'message di modal
                    '    'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
                End If

            Catch ex As Exception
                Return "X"
            End Try
        Else
            Return "OK"
        End If
    End Function

    'Public Function UpdatePelarasanHdr(postDt, noPelarasan, newId) As String
    '    Dim db As New DBKewConn
    '    Dim formattedDate As String = Date.Now.ToString("yyyy-MM-dd HH:mm:ss")
    '    Dim query As String = $"UPDATE SMKB_Perolehan_Pelarasan_Hdr set Ulasan_Pelarasan = '{postDt("ulasanPelarasan")}', 
    '                        No_Pelarasan = '{newId}',
    '                        Jumlah_Selepas_Pelarasan = '{postDt("jumlahSlpsPelarasan")}',
    '                        Tarikh_Pelarasan = @Tarikh_Pelarasan
    '                        Where No_Pelarasan = '{noPelarasan}'"
    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@Tarikh_Pelarasan", formattedDate))

    '    Return RbQueryCmd("No_Pelarasan", noPelarasan, query, param)
    'End Function

    Public Function KemaskiniNoPelarasan(noPelarasan As String) As String
        Dim num As String = noPelarasan

        ' Extract the static part and the number part
        Dim staticPart As String = num.Substring(0, 13) ' Assuming the static part length is always 12 characters
        Dim numberPart As Integer = Integer.Parse(num.Substring(14)) ' Extract the number part and convert it to an integer

        ' Increment the number part
        numberPart += 1

        ' Combine the static part and the incremented number part
        Dim id As String = staticPart & " " & numberPart.ToString()

        Return id
    End Function

    Public Function InsertPelarasanHdr(postDt, noPelarasan) As String
        Dim formattedDate As String = Date.Now.ToString("yyyy-MM-dd HH:mm:ss")
        Dim db As New DBKewConn
        Dim query As String = $"INSERT INTO SMKB_Perolehan_Pelarasan_Hdr 
                           (No_Pelarasan, No_Pesanan, Jumlah_Asal, Jumlah_Selepas_Pelarasan, Tarikh_Pelarasan, Ulasan_Pelarasan) 
                           VALUES ('{noPelarasan}', '{postDt("noPesanan")}', '{postDt("jumlahAsal")}', '{postDt("jumlahSlpsPelarasan")}', '{formattedDate}', '{postDt("ulasanPelarasan")}')"
        Dim param As New List(Of SqlParameter)

        Return RbQueryCmd("No_Pelarasan", noPelarasan, query, param)
    End Function

    Public Function InsertPelarasanDtl(postDt, noPelarasan) As String
        Dim db As New DBKewConn
        'Dim idTrim = noPelarasan.Substring(0, 13)

        Dim query As String = $"INSERT INTO SMKB_Perolehan_Pelarasan_Dtl 
                            ( No_Pelarasan, Id_Dtl, Id_Mohon_Dtl, Id_Pembelian, Kuantiti, Jenama, Model, Kod_Negara_Pembuat, 
                            Harga_Seunit, Harga_Seunit_Bercukai, Jumlah_Harga, Jumlah_Harga_Bercukai, Syor_Harga, Ulasan_Harga,
                            Rank_Harga, Status, Flag_SST, Kod_Kump_Wang, Kod_Operasi, Kod_Ptj, Kod_Projek, Kod_Vot, Butiran, Ukuran )
                            SELECT '{noPelarasan}', pbl.Id_Dtl, pmh.Id_Mohon_Dtl, pbl.Id_Pembelian, pbl.Kuantiti, pbl.Jenama, pbl.Model, 
                            pbl.Kod_Negara_Pembuat, pbl.Harga_Seunit, pbl.Harga_Seunit_Bercukai, pbl.Jumlah_Harga, pbl.Jumlah_Harga_Bercukai, pbl.Syor_Harga, 
                            pbl.Ulasan_Harga, pbl.Rank_Harga, pbl.Status, pbl.Flag_SST, pmh.Kod_Kump_Wang, pmh.Kod_Operasi, pmh.Kod_Ptj, pmh.Kod_Projek, pmh.Kod_Vot, pmh.Butiran, pmh.Ukuran 
                            FROM SMKB_Perolehan_Pembelian_Dtl pbl
                            JOIN SMKB_Perolehan_Permohonan_Dtl pmh ON pmh.Id_Mohon_Dtl = pbl.Id_Mohon_Dtl
                            WHERE pmh.No_Mohon = '{postDt("noMohon")}' And pbl.Id_Pembelian = '{postDt("idPembelian")}'"

        Dim param As New List(Of SqlParameter)

        Return db.Process(query, param)
    End Function

    Public Function ReadPembelianDtl(postDt) As String
        Dim db As New DBKewConn
        ' Convert Id Dari Date Time Ke String Tanpa -, :, .
        Dim query As String = $"SELECT 
                        pmh.Kod_Kump_Wang,
                        pmh.Kod_Operasi,
                        pmh.Kod_Ptj,
                        pmh.Kod_Vot,
                        pmh.Kod_Projek,
                        pbl.Jumlah_Harga,
                        REPLACE(REPLACE(REPLACE(FORMAT(pbl.Id_Mohon_Dtl,'yyyy-MM-ddHH:mm:ss.fffffff'), '-', ''), ':', ''), '.', '') AS Id_Mohon_Dtl,
                        REPLACE(REPLACE(REPLACE(FORMAT(pbl.Id_Dtl,'yyyy-MM-ddHH:mm:ss.fffffff'), '-', ''), ':', ''), '.', '') AS Id_Dtl
                        FROM 
                        SMKB_Perolehan_Pembelian_Dtl pbl
                        JOIN 
                        SMKB_Perolehan_Permohonan_Dtl pmh ON pmh.Id_Mohon_Dtl = pbl.Id_Mohon_Dtl
                        WHERE 
                        pmh.No_Mohon = '{postDt("noMohon")}' AND pbl.Id_Pembelian = '{postDt("idPembelian")}'"

        Dim param As New List(Of SqlParameter)

        dt = db.Read(query, param)
        Dim dtJson As String = JsonConvert.SerializeObject(dt)
        Return dtJson
    End Function

    Public Function UpdatePembelianDtl(postDt, objDt, dtJson) As String

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(dtJson) Then
            Dim jObjects = JArray.Parse(dtJson)

            For Each objRow As JObject In jObjects
                Dim id_mohon_dtl As String = ParseDtId2(objRow("Id_Mohon_Dtl").ToString()) ' id_mohon_dtl contains 202309182329326900000
                Dim id_dtl As String = ParseDtId2(objRow("Id_Dtl").ToString()) ' id_dtl contains 202309182329326900000

                ' Check Current Row Data Ada Dlm objDt tak, objDt key adalah id_mohon_dt
                Dim idExists As Boolean = objDt.ContainsKey(id_mohon_dtl)

                If idExists Then
                    ' Access specific values using keys
                    Dim itemDt As Dictionary(Of String, String) = objDt(id_mohon_dtl)

                    'Update Data Pembelian
                    Dim queryTxt As String = $"UPDATE SMKB_Perolehan_Pembelian_Dtl set Kuantiti = '{itemDt("Kuantiti")}', Harga_Seunit = '{itemDt("Harga_Seunit").Replace(",", "")}', Jumlah_Harga = '{itemDt("Jumlah_Harga").Replace(",", "")}' Where Id_Dtl = '{id_dtl}'"

                    If RbQueryCmd("Id_Dtl", id_dtl, queryTxt, param) <> "OK" Then
                        Return "X"
                    End If

                    'Update Data Permohonan
                    Dim queryTxt2 As String = $"UPDATE SMKB_Perolehan_Permohonan_Dtl set Kod_Kump_Wang = '{itemDt("Kod_Kump_Wang")}' , Kod_Operasi = '{itemDt("Kod_Operasi")}' ,  Kod_Ptj = '{itemDt("Kod_Ptj")}' , 
                                        Kod_Projek = '{itemDt("Kod_Projek")}' , Kod_Vot = '{itemDt("Kod_Vot")}' , Ukuran = '{itemDt("Ukuran")}' ,
                                        Butiran = '{itemDt("Butiran")}' Where Id_Mohon_Dtl = '{id_mohon_dtl}' And No_Mohon = '{postDt("noMohon")}'"

                    If RbQueryCmd("Id_Mohon_Dtl", id_mohon_dtl, queryTxt2, param) <> "OK" Then
                        Return "X"
                    End If
                End If
            Next

            Return "OK"
        Else
            Return "X"
        End If
    End Function

    Public Async Function DelItemPembelian(postDt, objDt, dtJson) As Tasks.Task(Of String)

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(dtJson) Then
            Dim jObjects = JArray.Parse(dtJson)

            For Each objRow As JObject In jObjects
                Dim id_mohon_dtl As String = ParseDtId2(objRow("Id_Mohon_Dtl").ToString()) ' id_mohon_dtl contains 202309182329326900000
                Dim id_dtl As String = ParseDtId2(objRow("Id_Dtl").ToString()) ' id_dtl contains 202309182329326900000

                ' Check Current Row Data Ada Dlm objDt tak, objDt key adalah id_mohon_dt
                Dim idExists As Boolean = objDt.ContainsKey(id_mohon_dtl)

                If Not idExists Then
                    'tambah field beza 
                    objRow.Add("Beza", $"-{objRow("Jumlah_Harga")}")

                    'Buang Data Pembelian
                    Dim queryTxt As String = $"DELETE SMKB_Perolehan_Pembelian_Dtl Where Id_Dtl = '{id_dtl}'"
                    Dim param1 As New List(Of SqlParameter)

                    'Buang Data Permohonan
                    Dim queryTxt2 As String = $"DELETE SMKB_Perolehan_Permohonan_Dtl Where Id_Mohon_Dtl = '{id_mohon_dtl}'"
                    Dim param2 As New List(Of SqlParameter)

                    If db.Process(queryTxt, param1) <> "OK" Then
                        Return "X"
                    End If

                    If db.Process(queryTxt2, param2) <> "OK" Then
                        Return "X"
                    End If

                    ''Update Lejar
                    Dim result = Await LejarAmProcess(objRow)
                    If result <> "OK" Then
                        Return "X"
                    End If

                    ''Update Lejar
                    Dim result2 = Await LejarAmProcess2(objRow, postDt)
                    If result2 <> "OK" Then
                        Return "X"
                    End If
                End If
            Next
            Return "OK"
        Else
            Return "X"
        End If
    End Function

    Function ParseDtId(stringValue As String, BaseFormat As String) As String
        Dim formattedDateTime As String = $"{stringValue.Substring(0, 19)}.{stringValue.Substring(20).PadRight(7, "0"c)}" 'Bagi ada 7 digit di akhir no id, termasuk trailing 0
        Dim parsedDate As DateTime = DateTime.ParseExact(formattedDateTime, BaseFormat, System.Globalization.CultureInfo.InvariantCulture)
        Return parsedDate.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
    End Function

    Function ParseDtId2(stringValue As String) As String
        ' Parse the string into a DateTime object
        Dim dateTimeValue As DateTime = DateTime.ParseExact(stringValue, "yyyyMMddHHmmssfffffff", CultureInfo.InvariantCulture)

        ' Format the DateTime object into the desired format
        Dim formattedDate As String = dateTimeValue.ToString("yyyy-MM-dd HH:mm:ss.fffffff")
        Return formattedDate
    End Function

    Private Function GenerateNoPelarasan()
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1

        Dim query As String = $"Select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='ADJ' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        queryRB = New Query()

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
            Dim resultId As String = UpdateNoAkhirPelarasan("02", "ADJ", year, lastID)
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        Else
            Dim resultId As String = InsertNoAkhirPelarasan("02", "ADJ", year, lastID)
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        End If

        queryRB.finish()
        Dim newId As String = "ADJ" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2) + " 1"

        Return newId
    End Function

    Private Function InsertNoAkhirPelarasan(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir (Kod_Modul,Prefix,No_Akhir,Tahun,Butiran,Kod_PTJ)
                           VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, '-')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Daftar Pelarasan"))


        Dim key As New Dictionary(Of String, String)
        key.Add("No_Akhir", ID)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("Tahun", year)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function UpdateNoAkhirPelarasan(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir set No_Akhir = @No_Akhir
                          where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))

        Dim key As New Dictionary(Of String, String)
        key.Add("No_Akhir", ID)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("Tahun", year)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FGetBakiSebenar(ByVal year As Integer, ByVal tarikh As String, ByVal kw As String, ByVal ko As String, ByVal ptj As String, ByVal kp As String, ByVal vot As String) As Decimal
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


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVot_COA(ByVal q As String) As String
        Dim tmpDT As DataTable = GetVot_KodCOAList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function



    Private Function GetVot_KodCOAList(kodCariVot As String) As DataTable

        kodCariVot = Replace(kodCariVot, " ", "%")

        Dim db = New DBKewConn
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
                     JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_PTJ,2) 
                     WHERE a.status = 1  "

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
    'Faiz END



End Class