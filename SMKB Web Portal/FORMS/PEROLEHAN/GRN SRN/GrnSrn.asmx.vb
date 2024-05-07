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
Imports System.Collections.Generic

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class GrnSrn
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    '===============================================================================================================================================================================
    'webservice (GRN SRN)
    '===============================================================================================================================================================================

    '<WebMethod()> _
    'Public Function HelloWorld() As String
    '    Return "Hello World"
    'End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPT_Syarikat(IdPesanan As String) As String
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


            'query = "
            '    SELECT 
            '    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0150' AND Kod_Detail = B.Kod_Bank)As Name_bank,
            '    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0003' AND Kod_Detail = Bandar_Semasa ) As Bandar_name,
            '    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0002' AND Kod_Detail = Kod_Negeri_Semasa ) As Negeri_name,
            '    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0001' AND Kod_Detail = Kod_Negara_Semasa ) As Negara_name,
            '    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0003' AND Kod_Detail = D.Bandar ) As Bandar_nameBank,
            '    (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod= '0002' AND Kod_Detail = D.Negeri ) As Negeri_nameBank,
            '    D.Kod_Bank As Main_Kod_Bank,
            '    *
            '    FROM SMKB_Perolehan_Pesanan_Hdr As A
            '    LEFT JOIN SMKB_Perolehan_Pemfaktoran As B On A.No_Pesanan=B.No_Pesanan
            '    INNER JOIN SMKB_Syarikat_Master As C On A.Id_Syarikat = C.ID_Sykt
            '    INNER JOIN SMKB_Perolehan_Pemfaktoran_Bank As D On B.Id_Pemfaktoran_Bank = D.Id_No
            '    WHERE A.No_Pesanan = @IdPesanan
            '"

            query = "
                select a.No_Perolehan, c.Nama_Sykt, a.Tujuan, d.No_Pesanan from SMKB_Perolehan_Permohonan_Hdr a
                inner join SMKB_Perolehan_Pembelian_Hdr b on b.No_Mohon = a.No_Mohon
                inner join SMKB_Syarikat_Master c on c.ID_Sykt = b.ID_Syarikat
                inner join SMKB_Perolehan_Pesanan_Hdr d on d.Id_Syarikat = c.ID_Sykt
                where d.No_Pesanan = @IdPesanan
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SenaraiGRN(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_SenaraiGRN(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_SenaraiGRN(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Pesanan AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Pesanan AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(c.Tarikh_Pesanan AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and c.Tarikh_Pesanan >= DATEADD(month, -1, getdate()) and c.Tarikh_Pesanan <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and c.Tarikh_Pesanan >= DATEADD(month, -2, getdate()) and c.Tarikh_Pesanan <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and c.Tarikh_Pesanan >= @tkhMula and c.Tarikh_Pesanan <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query = "
                        select a.No_Mohon, a.No_Perolehan, a.Tujuan, a.Bekal_Sebelum, a.Bekal_Kepada, c.No_Pesanan, c.Tarikh_Pesanan, e.Butiran, g.Nama, i.Emel_Semasa, i.ID_Sykt, i.Tel_Bimbit_Semasa, i.No_Sykt, i.Nama_Sykt,k.No_GRN,
					    b.Tempoh, b.Id_Pembelian, KodPejabat as value, KodPejabat + ' - ' + Pejabat as text, kategori.Butiran AS kategori_butiran, MIN(f.Kategori_Perolehan) AS Kaedah
					    from SMKB_Perolehan_Permohonan_Hdr a
					    inner join SMKB_Perolehan_Pembelian_Hdr b on b.No_Mohon = a.No_Mohon
					    inner join SMKB_Perolehan_Pesanan_Hdr c on c.No_Mohon = a.No_Mohon
					    inner join VPejabat as ptj on ptj.KodPejabat = a.Bekal_Kepada
					    INNER JOIN SMKB_Lookup_Detail e ON e.Kod_Detail = b.Jenis_Tempoh
					    join SMKB_Perolehan_Permohonan_Dtl h on a.No_Mohon = h.No_Mohon
					    INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                        LEFT JOIN SMKB_Perolehan_Kaedah f ON h.Jumlah_Harga BETWEEN f.Min_Harga AND f.Max_Harga
					     inner join SMKB_Syarikat_Master i on i.ID_Sykt = b.ID_Syarikat
					     left join SMKB_Syarikat_Rujukan g on g.ID_Sykt = i.ID_Sykt
					     LEFT JOIN SMKB_Perolehan_GRN_Hdr k ON k.No_Pesanan = c.No_Pesanan
					    where e.Kod = 'PO05'
                        AND (k.No_GRN = (SELECT MAX(No_GRN) FROM SMKB_Perolehan_GRN_Hdr WHERE No_Pesanan = c.No_Pesanan) OR k.No_GRN IS NULL)
                        " & tarikhQuery & "
					    group by a.No_Mohon, a.No_Perolehan, a.Tujuan, a.Bekal_Sebelum, a.Bekal_Kepada, c.No_Pesanan, c.Tarikh_Pesanan, e.Butiran, g.Nama,
					    b.Tempoh, b.Id_Pembelian, KodPejabat, KodPejabat, Pejabat, kategori.Butiran,  i.Emel_Semasa, i.ID_Sykt, i.Tel_Bimbit_Semasa, i.No_Sykt, i.Nama_Sykt, k.No_GRN;
                    "

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRecord_ItemGrn(ByVal idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = LoadRecord_ItemGrn(idPembelian)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function LoadRecord_ItemGrn(idPembelian As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " 
                            SELECT b.Id_Mohon_Dtl, a.Butiran, b.Kuantiti, b.Harga_Seunit,
                            b.Jumlah_Harga, f.Butiran AS text, a.No_Mohon, g.No_Pesanan, grn.No_GRN, grndtl.Kuantiti, 
                            grndtl.Kuantiti_Terima, grndtl.Kuantiti_Selisih, grndtl.Amaun, grn.Status as grnStatus
                            FROM SMKB_Perolehan_Permohonan_Dtl a
                            INNER JOIN SMKB_Perolehan_Pembelian_Dtl b ON a.Id_Mohon_Dtl = b.Id_Mohon_Dtl
                            INNER JOIN SMKB_Perolehan_Pembelian_Hdr c ON c.No_Mohon = a.No_Mohon
                            INNER JOIN SMKB_Perolehan_Pesanan_Hdr g ON g.No_Mohon = a.No_Mohon
                            LEFT JOIN SMKB_Perolehan_GRN_Hdr grn ON grn.No_Pesanan = g.No_Pesanan
                            LEFT JOIN SMKB_Perolehan_GRN_Dtl grndtl ON grndtl.No_GRN = grn.No_GRN AND grndtl.Id_Mohon_Dtl = a.Id_Mohon_Dtl
                            INNER JOIN SMKB_Syarikat_Master e ON e.ID_Sykt = c.ID_Syarikat
                            JOIN SMKB_Lookup_Detail f ON a.Ukuran = f.Kod_Detail
                            WHERE f.Kod = 'PO06' AND b.Id_Pembelian = @idPembelian
                            AND (grn.No_GRN = (SELECT MAX(No_GRN) FROM SMKB_Perolehan_GRN_Hdr WHERE No_Pesanan = g.No_Pesanan) OR grn.No_GRN IS NULL)
        "
        'INNER JOIN (SELECT Id_Mohon_Dtl, MAX(No_GRN) AS Max_No_GRN FROM SMKB_Perolehan_GRN_Dtl GROUP BY Id_Mohon_Dtl) grndtl_max ON grndtl.Id_Mohon_Dtl = grndtl_max.Id_Mohon_Dtl AND grndtl.No_GRN = grndtl_max.Max_No_GRN

        Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@txtNoPT", txtNoPT))
        param.Add(New SqlParameter("@idPembelian", idPembelian))
        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetLoad_ItemGrnTerima(ByVal idPembelian As String, idSyarikat As String) As String
        Dim resp As New ResponseRepository

        dt = LoadData_ItemGrn(idPembelian, idSyarikat)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function LoadData_ItemGrn(idPembelian As String, idSyarikat As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " select a.Id_Pembelian, grn.No_GRN, g.No_Pesanan, kategori.Butiran AS kategori_butiran, c.Tujuan, b.Nama_Sykt, grn.Status as grnStatus, b.ID_Sykt, grn.Content_Type from SMKB_Perolehan_Pembelian_Hdr a
                                INNER JOIN SMKB_Syarikat_Master b ON b.ID_Sykt = a.ID_Syarikat
                                INNER JOIN SMKB_Perolehan_Pesanan_Hdr g ON g.No_Mohon = a.No_Mohon
                                LEFT JOIN SMKB_Perolehan_GRN_Hdr grn ON grn.No_Pesanan = g.No_Pesanan
                                left join SMKB_Perolehan_Permohonan_Hdr c on c.No_Mohon = a.No_Mohon
                                INNER JOIN SMKB_Lookup_Detail AS kategori ON c.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03'
                                where a.Id_Pembelian = @idPembelian and b.ID_Sykt = @idSyarikat and (grn.Status = '1' or grn.Status = '2')
                              "
        'and b.ID_Sykt = 'RC000008'
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", idPembelian))
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))
        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRecord_ItemGrnChild(ByVal idPembelian As String, idSyarikat As String, txtNoGrn As String) As String
        Dim resp As New ResponseRepository

        dt = LoadRecord_ItemGrnChild(idPembelian, idSyarikat, txtNoGrn)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function LoadRecord_ItemGrnChild(idPembelian As String, idSyarikat As String, txtNoGrn As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " SELECT b.Id_Mohon_Dtl, a.Butiran, b.Kuantiti, b.Harga_Seunit, b.Jumlah_Harga, f.Butiran AS text, a.No_Mohon, g.No_Pesanan, grn.No_GRN, grndtl.Kuantiti, grndtl.Kuantiti_Terima, 
                                grndtl.Kuantiti_Selisih, grndtl.Amaun, grn.Status as grnStatus
                                FROM SMKB_Perolehan_Permohonan_Dtl a
                                INNER JOIN SMKB_Perolehan_Pembelian_Dtl b ON a.Id_Mohon_Dtl = b.Id_Mohon_Dtl
                                INNER JOIN SMKB_Perolehan_Pembelian_Hdr c ON c.No_Mohon = a.No_Mohon
                                INNER JOIN SMKB_Perolehan_Pesanan_Hdr g ON g.No_Mohon = a.No_Mohon
                                LEFT JOIN SMKB_Perolehan_GRN_Hdr grn ON grn.No_Pesanan = g.No_Pesanan
                                LEFT JOIN SMKB_Perolehan_GRN_Dtl grndtl ON grndtl.No_GRN = grn.No_GRN AND grndtl.Id_Mohon_Dtl = a.Id_Mohon_Dtl
                                INNER JOIN SMKB_Syarikat_Master e ON e.ID_Sykt = c.ID_Syarikat
                                JOIN SMKB_Lookup_Detail f ON a.Ukuran = f.Kod_Detail
                                WHERE f.Kod = 'PO06' AND b.Id_Pembelian = @idPembelian and c.ID_Syarikat = @idSyarikat and GRN.No_GRN = @txtNoGrn
                               "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", idPembelian))
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))
        param.Add(New SqlParameter("@txtNoGrn", txtNoGrn))
        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRecord_TotalHarga(ByVal idPembelian As String) As String
        Dim resp As New ResponseRepository

        dt = LoadRecord_TotalHargaSyarikat(idPembelian)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function LoadRecord_TotalHargaSyarikat(idPembelian As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " select FORMAT(SUM(Jumlah_Harga), '0.00') as Total_Jumlah_Harga 
                                from SMKB_Perolehan_Pembelian_Dtl dtl 
				                inner join SMKB_Perolehan_Pembelian_Hdr hdr on dtl.Id_Pembelian = hdr.Id_Pembelian 
                                where dtl.Id_Pembelian = @idPembelian
                               "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPembelian", idPembelian))
        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveDaftarGrn_Hdr(DaftarGRN As GRN) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        'Dim msg As String = ""

        Dim noGrnID As String = DaftarGRN.txtNoGrn ' Initialize noGrnID with txtNoGrn value

        ' Check if txtNoGrn is empty or not
        If DaftarGRN.txtNoGrn = "" Then

            noGrnID = GenerateNoGRN(DaftarGRN.txtKodBekalKepada)
            DaftarGRN.txtNoGrn = noGrnID
            Session("sessiontxtNoGrn") = noGrnID
            If InsertDaftarPtHdr(DaftarGRN.txtNoGrn, DaftarGRN.txtNoPT, DaftarGRN.txtTkhDO, DaftarGRN.txtNoDO, DaftarGRN.txtTkhTerimaDO, DaftarGRN.txtUlasanDO, DaftarGRN.idSyarikat) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If


        End If

        resp.Success("Maklumat berjaya disimpan", "00", DaftarGRN)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveDaftarGrn_Dtl(DaftarGRNDtl As GrnItem()) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        ' Assuming txtNoGrn is a common value for all items in the array
        Dim txtNoGrn As String = Session("sessiontxtNoGrn")

        For Each item As GrnItem In DaftarGRNDtl
            item.txtNoGrn = txtNoGrn

            If InsertDaftarPtDtl(item.txtNoGrn, item.idMohonDtl, item.itemKuantiti, item.itemTerima, item.itemBakiTinggal, item.amaunGRNTerima, item.beza, item.beza2) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Next

        resp.Success("Maklumat berjaya disimpan", "00", DaftarGRNDtl)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    '<System.Web.Services.WebMethod(EnableSession:=True)>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function SaveDaftarGrn_Dtl(DaftarGRNDtl As GrnItem) As String

    '    Dim resp As New ResponseRepository
    '    resp.Success("Data telah disimpan")
    '    'Dim msg As String = ""


    '    DaftarGRNDtl.txtNoGrn = Session("sessiontxtNoGrn")

    '    If InsertDaftarPtDtl(DaftarGRNDtl.txtNoGrn, DaftarGRNDtl.idMohonDtl, DaftarGRNDtl.itemKuantiti, DaftarGRNDtl.itemTerima, DaftarGRNDtl.itemBakiTinggal, DaftarGRNDtl.amaunGRNTerima, DaftarGRNDtl.beza, DaftarGRNDtl.beza2) <> "OK" Then
    '        resp.Failed("Gagal Menyimpan order")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '        'Exit Function
    '    End If

    '    resp.Success("Maklumat berjaya disimpan", "00", DaftarGRNDtl)
    '    Return JsonConvert.SerializeObject(resp.GetResult())
    'End Function

    Private Function GenerateNoGRN(txtKodBekalKepada As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoGRN As String = ""
        Dim ptj = txtKodBekalKepada

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='GRN' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhirGRN("02", "GRN", year, lastID, txtKodBekalKepada)
        Else

            InsertNoAkhirGRN("02", "GRN", year, lastID, txtKodBekalKepada)
        End If
        newNoGRN = "GRN" + ptj.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoGRN
    End Function

    Private Function InsertNoAkhirGRN(kodModul As String, prefix As String, year As String, ID As String, txtKodBekalKepada As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir (Kod_Modul,Prefix,No_Akhir,Tahun,Butiran,Kod_PTJ)
                               VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @txtKodBekalKepada)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "GRN SRN"))
        param.Add(New SqlParameter("@txtKodBekalKepada", txtKodBekalKepada))

        Return db.Process(query, param)
    End Function

    Private Function UpdateNoAkhirGRN(kodModul As String, prefix As String, year As String, ID As String, txtKodBekalKepada As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir set No_Akhir = @No_Akhir
                              where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@txtKodBekalKepada", txtKodBekalKepada))

        Return db.Process(query, param)

    End Function

    Private Function InsertDaftarPtHdr(txtNoGrn As String, txtNoPT As String, txtTkhDO As String, txtNoDO As String, txtTkhTerimaDO As String, txtUlasanDO As String, idSyarikat As String)
        Dim db As New DBKewConn

        'Dim currentDate As Date = Date.Today

        Dim query As String = "INSERT INTO SMKB_Perolehan_GRN_Hdr (No_GRN,Tarikh_GRN,No_Pesanan,No_DO,Tarikh_DO, Ulasan, ID_Sykt, Status)
        VALUES(@txtNoGrn,@txtTkhTerimaDO,@txtNoPT,@txtNoDO,@txtTkhDO, @txtUlasanDO, @idSyarikat, '1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoGrn", txtNoGrn))
        param.Add(New SqlParameter("@txtNoPT", txtNoPT))
        param.Add(New SqlParameter("@txtTkhDO", txtTkhDO))
        param.Add(New SqlParameter("@txtNoDO", txtNoDO))
        param.Add(New SqlParameter("@txtTkhTerimaDO", txtTkhTerimaDO))
        param.Add(New SqlParameter("@txtUlasanDO", txtUlasanDO))
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))


        Return db.Process(query, param)

    End Function

    'Private Function InsertDaftarPtDtl(No_GRN As String, Id_Mohon_Dtl As String, itemKuantiti As String, itemTerima As String, itemBakiTinggal As String, amaunGRNTerima As String)
    '    Dim db As New DBKewConn

    '    Dim query As String = "INSERT INTO SMKB_Perolehan_GRN_Dtl (No_GRN, Id_Mohon_Dtl, Kuantiti, Kuantiti_Terima, Kuantiti_Selisih, Amaun)
    '    VALUES(@No_GRN, @Id_Mohon_Dtl, @itemKuantiti, @itemTerima, @itemBakiTinggal, @amaunGRNTerima)"

    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@No_GRN", No_GRN))
    '    param.Add(New SqlParameter("@Id_Mohon_Dtl", Id_Mohon_Dtl))
    '    param.Add(New SqlParameter("@itemKuantiti", itemKuantiti))
    '    param.Add(New SqlParameter("@itemTerima", itemTerima))
    '    param.Add(New SqlParameter("@itemBakiTinggal", itemBakiTinggal))
    '    param.Add(New SqlParameter("@amaunGRNTerima", amaunGRNTerima))

    '    Return db.Process(query, param)

    'End Function

    Private Function InsertDaftarPtDtl(No_GRN As String, Id_Mohon_Dtl As String, itemKuantiti As String, itemTerima As String, itemBakiTinggal As String, amaunGRNTerima As String, beza As String, beza2 As String) As String
        Dim db As New DBKewConn

        ' Check if the Id_Mohon_Dtl already exists
        If CheckExistingId(Id_Mohon_Dtl) Then
            ' If the Id_Mohon_Dtl exists, insert a new record with different column names
            Dim query As String = "INSERT INTO SMKB_Perolehan_GRN_Dtl (No_GRN, Id_Mohon_Dtl, Kuantiti, Kuantiti_Terima, Kuantiti_Selisih, KuantitiSemasa, Amaun) VALUES (@No_GRN, @Id_Mohon_Dtl, @itemKuantiti, @itemTerima, @beza, @beza2, @amaunGRNTerima)"

            Dim param As New List(Of SqlParameter)
            param.Add(New SqlParameter("@No_GRN", No_GRN))
            param.Add(New SqlParameter("@Id_Mohon_Dtl", Id_Mohon_Dtl))
            param.Add(New SqlParameter("@itemKuantiti", itemKuantiti))
            param.Add(New SqlParameter("@itemTerima", itemTerima))
            param.Add(New SqlParameter("@beza", beza))
            param.Add(New SqlParameter("@beza2", beza2))
            param.Add(New SqlParameter("@amaunGRNTerima", amaunGRNTerima))

            Return db.Process(query, param)
        Else
            ' If the Id_Mohon_Dtl does not exist, insert a new record with the original column names
            Dim query As String = "INSERT INTO SMKB_Perolehan_GRN_Dtl (No_GRN, Id_Mohon_Dtl, Kuantiti, Kuantiti_Terima, Kuantiti_Selisih, Amaun) VALUES (@No_GRN, @Id_Mohon_Dtl, @itemKuantiti, @itemTerima, @itemBakiTinggal, @amaunGRNTerima)"

            Dim param As New List(Of SqlParameter)
            param.Add(New SqlParameter("@No_GRN", No_GRN))
            param.Add(New SqlParameter("@Id_Mohon_Dtl", Id_Mohon_Dtl))
            param.Add(New SqlParameter("@itemKuantiti", itemKuantiti))
            param.Add(New SqlParameter("@itemTerima", itemTerima))
            param.Add(New SqlParameter("@itemBakiTinggal", itemBakiTinggal))
            param.Add(New SqlParameter("@amaunGRNTerima", amaunGRNTerima))

            Return db.Process(query, param)
        End If
    End Function

    Private Function CheckExistingId(ByVal Id_Mohon_Dtl As String) As Boolean
        Dim db As New DBKewConn
        Dim query As String = "SELECT COUNT(*) FROM SMKB_Perolehan_GRN_Dtl WHERE Id_Mohon_Dtl = @Id_Mohon_Dtl"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Id_Mohon_Dtl", Id_Mohon_Dtl))
        Dim count As Integer = 0

        Try
            Using connection As New SqlConnection(db.ConnectionString)
                connection.Open()
                Using command As New SqlCommand(query, connection)
                    command.Parameters.AddRange(param.ToArray())
                    count = Convert.ToInt32(command.ExecuteScalar())
                End Using
            End Using
        Catch ex As Exception
            ' Handle any exceptions here
            ' You might want to log the exception for debugging purposes
            ' For simplicity, we'll just return False in case of any error
            Return False

        End Try

        ' If count is greater than 0, return True indicating existence
        Return count > 0
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveAndUploadFile() As String
        Dim namaFail As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim fileSize As Long = postedFile.ContentLength
        Dim fileExtension As String = Path.GetExtension(fileName).ToLower()
        Dim txtNoGrn As String = HttpContext.Current.Request.Form("txtNoGrn")
        Dim sessiontxtNoGrn As String = CType(HttpContext.Current.Session("sessiontxtNoGrn"), String)
        'Dim txtNoGrn As String = HttpContext.Current.Session("sessiontxtNoGrn")
        'Dim txtNoGrn As String = HttpContext.Current.Request.Form("txtNoGrn")
        namaFail = HttpContext.Current.Request.Form("namaFail")
        Try

            ' Specify the file path where you want to save the uploaded file
            Dim folderPath As String = Server.MapPath("~/UPLOAD/DOCUMENT/PEROLEHAN/GRNSRN/" & sessiontxtNoGrn)
            Dim savePath As String = Path.Combine(folderPath, postedFile.FileName)
            Dim pathSimpan As String = ("~/UPLOAD/DOCUMENT/PEROLEHAN/GRNSRN/" & sessiontxtNoGrn)

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

            Dim query As String = "UPDATE SMKB_Perolehan_GRN_Hdr SET File_DO = @File_DO, Path = @Path, Content_Type = @Content_Type WHERE No_GRN = @No_GRN"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@No_GRN", sessiontxtNoGrn))
            param.Add(New SqlParameter("@Path", pathSimpan))
            'param.Add(New SqlParameter("@Content_Type", namaFail & fileExtension))
            param.Add(New SqlParameter("@Content_Type", postedFile.FileName))
            'param.Add(New SqlParameter("@File_DO", postedFile.FileName))
            param.Add(New SqlParameter("@File_DO", namaFail))

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
        Return extension = ".pdf" OrElse extension = ".png" OrElse extension = ".jpg" OrElse extension = ".jpeg"
        'Return extension = ".pdf"
    End Function

End Class