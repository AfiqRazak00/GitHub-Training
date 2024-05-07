Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports System.Collections.Generic

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class StokTambahWS
    Inherits System.Web.Services.WebService

    Dim dtbl As DataTable
    Dim queryRB As New Query 'Query rollback

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchPtj() As String
        Using dtUserInfo = fGetPtj(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Private Function fGetPtj(strStaffID) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT CONCAT(MS08_Pejabat, '0000') AS KodPejabat, Pejabat
                                    FROM VPeribadi
                                    WHERE MS01_NoStaf = '{strStaffID}'
                                    AND MS01_Status = 1"

        Using dt = dbconn.fSelectCommandDt(strSql)
            If dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then
                Dim ptj As String = dt.Rows(0)("KodPejabat").ToString()
                Session("ptj") = ptj
            End If
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchDdlSyarikat() As String
        Using dtUserInfo = fGetDdlSyarikat()
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetDdlSyarikat() As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT ID_Sykt, Nama_Sykt FROM SMKB_Syarikat_Master"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSelectedDdlSyarikat(syarikat) As String
        Using dtUserInfo = fGetSelectedDdlSyarikat(syarikat)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetSelectedDdlSyarikat(syarikat) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT ID_Sykt, Nama_Sykt FROM SMKB_Syarikat_Master WHERE Nama_Sykt = '{syarikat}'"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchDdlKategori() As String
        Using dtUserInfo = fGetDdlKategori()
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetDdlKategori() As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT DISTINCT b.Butiran, a.Kod_Kategori FROM SMKB_SI_Barang_Master a
                                INNER JOIN SMKB_Lookup_Detail b ON a.Kod_Kategori = b.Kod_Detail
								INNER JOIN SMKB_SI_Barang_Stor c ON a.Kod_Brg = c.Kod_Brg
                                WHERE b.Kod = 'SI001' AND c.Kod_Ptj = '500000'"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchDdlKategoriUtama() As String
        Using dtUserInfo = fGetDdlKategoriUtama(Session("ptj"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetDdlKategoriUtama(strPtj) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT DISTINCT b.Butiran, a.Kod_Kategori FROM SMKB_SI_Barang_Master a
                                INNER JOIN SMKB_Lookup_Detail b ON a.Kod_Kategori = b.Kod_Detail
								INNER JOIN SMKB_SI_Barang_Stor c ON a.Kod_Brg = c.Kod_Brg
                                WHERE b.Kod = 'SI001' AND c.Kod_Ptj = '{strPtj}'"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchDdlBekalan(kodKategori) As String
        Using dtUserInfo = fGetDdlBekalan(kodKategori)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetDdlBekalan(kodKategori) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT DISTINCT a.Kod_Brg, a.Butiran FROM SMKB_SI_Barang_Master a
                                INNER JOIN SMKB_SI_Barang_Stor b ON a.Kod_Brg = b.Kod_Brg
                                WHERE a.Kod_Kategori = '{kodKategori}' AND b.Kod_Ptj = '500000'
                                AND b.Kat_Stor = 'SP'"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchDdlBekalanUtama(kodKategori) As String
        Using dtUserInfo = fGetDdlBekalanUtama(kodKategori, Session("ptj"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetDdlBekalanUtama(kodKategori, strPtj) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT DISTINCT a.Kod_Brg, a.Butiran FROM SMKB_SI_Barang_Master a
                                INNER JOIN SMKB_SI_Barang_Stor b ON a.Kod_Brg = b.Kod_Brg
                                WHERE a.Kod_Kategori = '{kodKategori}' AND b.Kod_Ptj = '{strPtj}'
                                AND b.Kat_Stor = 'SU'"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchBekalanDetails(kodBekalan) As String
        Using dtUserInfo = fGetBekalanDetails(kodBekalan)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetBekalanDetails(kodBekalan) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT DISTINCT a.Kod_Ukuran , c.Butiran,
                                    STUFF((
                                        SELECT DISTINCT ',' + b.Kod_Lokasi
                                        FROM SMKB_SI_Barang_Stor b
                                        WHERE a.Kod_Brg = b.Kod_Brg
                                        FOR XML PATH('')), 1, 1, '') AS Kod_Lokasi
                                FROM SMKB_SI_Barang_Master a
                                INNER JOIN SMKB_Lookup_Detail c ON a.Kod_Ukuran = c.Kod_Detail
                                WHERE c.Kod = 'SI003' AND a.Kod_Brg = '{kodBekalan}'"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanTambahStok(idBarang, tarikh, kuantiti, masa, harga_seunit, idSyarikat, jumlah, no_rujukan) As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn

        'Insert Data Ke SMKB_SI_Inventori
        If InsertTambahInventori($"{harga_seunit}", $"{idSyarikat}", $"{idBarang}", $"{kuantiti}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Insert Data Ke SMKB_SI_Transaksi
        If InsertTambahTransaksi($"{tarikh}", $"{masa}", $"{kuantiti}", $"{harga_seunit}", $"{jumlah}", $"{idBarang}", $"{no_rujukan}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        ' Add some sample data to the array
        Dim rsData As New With {
            .idSyarikat = idSyarikat
        }
        resp.Success("Rekod telah berjaya disimpan.", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertTambahInventori(harga_seunit, idSyarikat, idBarang, kuantiti) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_SI_Inventori 
                                (ID_Inv, Kod_Ptj, Harga_Unit, ID_Sykt, Kod_Brg, Baki_Unit, Kat_Stor, Status) 
                                VALUES (@ID_Inv, @Kod_Ptj, @Harga_Unit, @ID_Sykt, @Kod_Brg, @Baki_Unit, @Kat_Stor, @Status)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ID_Inv", Date.Now))
        param.Add(New SqlParameter("@Kod_Ptj", "500000"))
        param.Add(New SqlParameter("@Harga_Unit", harga_seunit))
        param.Add(New SqlParameter("@ID_Sykt", idSyarikat))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Baki_Unit", kuantiti))
        param.Add(New SqlParameter("@Kat_Stor", "SP"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("Kod_Brg", idBarang, query, param)
    End Function

    Private Function UpdateTambahInventori(harga_seunit, idSyarikat, idBarang, kuantiti) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_SI_Inventori
                                SET Baki_Unit = Baki_Unit + @kuantiti
                                WHERE Kod_Ptj = @Kod_Ptj AND Harga_Unit = @Harga_Unit AND ID_Sykt = @ID_Sykt AND Kod_Brg = @Kod_Brg"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kuantiti", kuantiti))
        param.Add(New SqlParameter("@Kod_Ptj", "500000"))
        param.Add(New SqlParameter("@Harga_Unit", harga_seunit))
        param.Add(New SqlParameter("@ID_Sykt", idSyarikat))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))

        Dim key As New Dictionary(Of String, String)
        key.Add("Kod_Ptj", "500000")
        key.Add("Harga_Unit", harga_seunit)
        key.Add("ID_Sykt", idSyarikat)
        key.Add("Kod_Brg", idBarang)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function InsertTambahTransaksi(tarikh, masa, kuantiti, harga_seunit, jumlah, idBarang, noRujukan) As String
        Dim db As New DBKewConn

        Dim bakiSemasa As String = GetBakiSemasa($"{idBarang}", "500000", $"{kuantiti}")
        'Dim datetime As String = ConvertToSmallDateTime($"{tarikh}", $"{masa}")
        Dim datetime As String = tarikh & " " & masa

        Dim query As String = "INSERT INTO SMKB_SI_Transaksi 
                                (ID_Transaksi, Tkh_Transaksi, Proses, Kuantiti, Harga_Unit, Jum_Harga, Created_By, Kod_Brg, Baki_Semasa, Kod_Ptj, Kat_Stor, Status, No_Rujukan) 
                                VALUES (@ID_Transaksi, @Tkh_Transaksi, @Proses, @Kuantiti, @Harga_Unit, @Jum_Harga, @Created_By, @Kod_Brg, @Baki_Semasa, @Kod_Ptj, @Kat_Stor, @Status, @No_Rujukan)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ID_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", datetime))
        param.Add(New SqlParameter("@Proses", "Masuk"))
        param.Add(New SqlParameter("@Kuantiti", kuantiti))
        param.Add(New SqlParameter("@Harga_Unit", harga_seunit))
        param.Add(New SqlParameter("@Jum_Harga", jumlah))
        param.Add(New SqlParameter("@Created_By", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Baki_Semasa", bakiSemasa))
        param.Add(New SqlParameter("@Kod_Ptj", "500000"))
        param.Add(New SqlParameter("@Kat_Stor", "SP"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@No_Rujukan", noRujukan))

        Return RbQueryCmd("Kod_Brg", idBarang, query, param)
    End Function

    Private Function GetBakiSemasa(idBarang, kodPtj, kuantiti)
        Dim db As New DBKewConn

        Dim Baki_Semasa As Integer
        Dim NewBakiSemasa As Integer

        Dim query As String = $"SELECT TOP 1 Baki_Semasa FROM SMKB_SI_Transaksi WHERE Kod_Brg = @Kod_Brg AND Kod_Ptj = @Kod_Ptj AND Status = @Status ORDER BY ID_Transaksi DESC"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Kod_Ptj", kodPtj))
        param.Add(New SqlParameter("@Status", "1"))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Baki_Semasa = CInt(dtbl.Rows(0).Item("Baki_Semasa"))
        Else
            Baki_Semasa = 0
        End If

        NewBakiSemasa = Baki_Semasa + kuantiti

        Return NewBakiSemasa
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanTambahStokUtama(idBarang, tarikh, kuantiti, masa, harga_seunit, idSyarikat, jumlah, no_rujukan) As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn

        'Insert Data Ke SMKB_SI_Inventori
        If InsertTambahInventoriUtama($"{harga_seunit}", $"{idSyarikat}", $"{idBarang}", $"{kuantiti}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Insert Data Ke SMKB_SI_Transaksi
        If InsertTambahTransaksiUtama($"{tarikh}", $"{masa}", $"{kuantiti}", $"{harga_seunit}", $"{jumlah}", $"{idBarang}", $"{no_rujukan}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        ' Add some sample data to the array
        Dim rsData As New With {
            .idSyarikat = idSyarikat
        }
        resp.Success("Rekod telah berjaya disimpan.", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertTambahInventoriUtama(harga_seunit, idSyarikat, idBarang, kuantiti) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_SI_Inventori 
                                (ID_Inv, Kod_Ptj, Harga_Unit, ID_Sykt, Kod_Brg, Baki_Unit, Kat_Stor, Status) 
                                VALUES (@ID_Inv, @Kod_Ptj, @Harga_Unit, @ID_Sykt, @Kod_Brg, @Baki_Unit, @Kat_Stor, @Status)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ID_Inv", Date.Now))
        param.Add(New SqlParameter("@Kod_Ptj", Session("ptj")))
        param.Add(New SqlParameter("@Harga_Unit", harga_seunit))
        param.Add(New SqlParameter("@ID_Sykt", idSyarikat))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Baki_Unit", kuantiti))
        param.Add(New SqlParameter("@Kat_Stor", "SU"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("Kod_Brg", idBarang, query, param)
    End Function

    Private Function InsertTambahTransaksiUtama(tarikh, masa, kuantiti, harga_seunit, jumlah, idBarang, noRujukan) As String
        Dim db As New DBKewConn

        Dim bakiSemasa As String = GetBakiSemasaUtama($"{idBarang}", Session("ptj"), $"{kuantiti}")
        Dim datetime As String = tarikh & " " & masa

        Dim query As String = "INSERT INTO SMKB_SI_Transaksi 
                                (ID_Transaksi, Tkh_Transaksi, Proses, Kuantiti, Harga_Unit, Jum_Harga, Created_By, Kod_Brg, Baki_Semasa, Kod_Ptj, Kat_Stor, Status, No_Rujukan) 
                                VALUES (@ID_Transaksi, @Tkh_Transaksi, @Proses, @Kuantiti, @Harga_Unit, @Jum_Harga, @Created_By, @Kod_Brg, @Baki_Semasa, @Kod_Ptj, @Kat_Stor, @Status, @No_Rujukan)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ID_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", datetime))
        param.Add(New SqlParameter("@Proses", "Masuk"))
        param.Add(New SqlParameter("@Kuantiti", kuantiti))
        param.Add(New SqlParameter("@Harga_Unit", harga_seunit))
        param.Add(New SqlParameter("@Jum_Harga", jumlah))
        param.Add(New SqlParameter("@Created_By", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Baki_Semasa", bakiSemasa))
        param.Add(New SqlParameter("@Kod_Ptj", Session("ptj")))
        param.Add(New SqlParameter("@Kat_Stor", "SU"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@No_Rujukan", noRujukan))

        Return RbQueryCmd("Kod_Brg", idBarang, query, param)
    End Function

    Private Function GetBakiSemasaUtama(idBarang, kodPtj, kuantiti)
        Dim db As New DBKewConn

        Dim Baki_Semasa As Integer
        Dim NewBakiSemasa As Integer

        Dim query As String = $"SELECT TOP 1 Baki_Semasa FROM SMKB_SI_Transaksi WHERE Kod_Brg = @Kod_Brg AND Kod_Ptj = @Kod_Ptj AND Status = @Status ORDER BY ID_Transaksi DESC"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Kod_Ptj", kodPtj))
        param.Add(New SqlParameter("@Status", "1"))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Baki_Semasa = CInt(dtbl.Rows(0).Item("Baki_Semasa"))
        Else
            Baki_Semasa = 0
        End If

        NewBakiSemasa = Baki_Semasa + kuantiti

        Return NewBakiSemasa
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchTransaksi(kodBekalan) As String
        Using dtUserInfo = fGetTransaksi(kodBekalan)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetTransaksi(kodBekalan) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT 
                                    a.Tkh_Transaksi, 
                                    FORMAT(a.Tkh_Transaksi, 'HH:mm:ss') AS Masa_Transaksi, 
                                    a.No_Rujukan, 
                                    c.Nama_Sykt, 
                                    a.Kuantiti, 
                                    a.Harga_Unit, 
                                    a.Jum_Harga,
                                    b.Id_Sykt
                                FROM 
                                    SMKB_SI_Transaksi a
                                INNER JOIN 
                                    (
                                        SELECT DISTINCT Kod_Brg, Kod_Ptj, ID_Sykt 
                                        FROM SMKB_SI_Inventori
                                    ) b ON a.Kod_Brg = b.Kod_Brg AND a.Kod_Ptj = b.Kod_Ptj
                                INNER JOIN 
                                    SMKB_Syarikat_Master c ON c.ID_Sykt = b.ID_Sykt
                                INNER JOIN SMKB_Perolehan_Pesanan_Hdr d ON d.Id_Syarikat = b.ID_Sykt AND d.No_Pesanan = a.No_Rujukan
                                WHERE 
                                    a.Kod_Brg = '{kodBekalan}' 
                                    AND a.Kod_Ptj = '500000' 
                                    AND a.Status = '1' 
                                    AND a.Proses = 'Masuk'
                                ORDER BY A.Tkh_Transaksi"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchTransaksiUtama(kodBekalan) As String
        Using dtUserInfo = fGetTransaksiUtama(kodBekalan, Session("ptj"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function

    <WebMethod()>
    Public Function fGetTransaksiUtama(kodBekalan, kodPtj) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT 
                                    a.Tkh_Transaksi, 
                                    FORMAT(a.Tkh_Transaksi, 'HH:mm:ss') AS Masa_Transaksi, 
                                    a.No_Rujukan, 
                                    c.Nama_Sykt, 
                                    a.Kuantiti, 
                                    a.Harga_Unit, 
                                    a.Jum_Harga,
                                    b.Id_Sykt
                                FROM 
                                    SMKB_SI_Transaksi a
                                INNER JOIN 
                                    (
                                        SELECT DISTINCT Kod_Brg, Kod_Ptj, ID_Sykt 
                                        FROM SMKB_SI_Inventori
                                    ) b ON a.Kod_Brg = b.Kod_Brg AND a.Kod_Ptj = b.Kod_Ptj
                                INNER JOIN 
                                    SMKB_Syarikat_Master c ON c.ID_Sykt = b.ID_Sykt
                                WHERE 
                                    a.Kod_Brg = '{kodBekalan}' 
                                    AND a.Kod_Ptj = '{kodPtj}' 
                                    AND a.Status = '1' 
                                    AND a.Proses = 'Masuk'
                                ORDER BY A.Tkh_Transaksi"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiStok(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String) As String
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        Using dtUserInfo = fGetSenaraiStok(category_filter, tkhMula, tkhTamat)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetSenaraiStok(category_filter As String, tkhMula As String, tkhTamat As String) As DataTable
        Dim dbconn As New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(a.ID_Inv AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(a.ID_Inv AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND a.ID_Inv >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND a.ID_Inv < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND a.ID_Inv >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND a.ID_Inv < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND a.ID_Inv >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND a.ID_Inv < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND CAST(a.ID_Inv AS DATE) >= @tkhMula AND CAST(a.ID_Inv AS DATE) <= @tkhTamat"
        End If

        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))

        Dim query As String = $"SELECT DISTINCT b.Nama_Sykt, CONVERT(varchar(10), a.ID_Inv, 103) AS ID_Inv, a.Harga_Unit, CONCAT(a.Kod_Brg, ' - ', c.Butiran) AS Butiran,
								(SELECT SUM(Baki_Unit)
									 FROM SMKB_SI_Inventori 
									 WHERE Kod_Brg = c.Kod_Brg AND Harga_Unit = a.Harga_Unit
									 AND Kod_Ptj = '500000') AS Baki_Unit, a.Status 
								FROM SMKB_SI_Inventori a
                                INNER JOIN SMKB_Syarikat_Master b ON a.ID_Sykt = b.ID_Sykt
                                INNER JOIN SMKB_SI_Barang_Master c ON a.Kod_Brg = c.Kod_Brg
                                WHERE a.Kod_Ptj = '500000' 
                                AND a.Status = '1' 
                                AND a.Kat_Stor = 'SP'" & tarikhQuery & "ORDER BY b.Nama_Sykt, Butiran, ID_Inv ASC"

        Return dbconn.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiStokUtama(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String) As String
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        Using dtUserInfo = fGetSenaraiStokUtama(category_filter, tkhMula, tkhTamat, Session("ptj"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetSenaraiStokUtama(category_filter As String, tkhMula As String, tkhTamat As String, kodPtj As String) As DataTable
        Dim dbconn As New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(a.ID_Inv AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(a.ID_Inv AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND a.ID_Inv >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND a.ID_Inv < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND a.ID_Inv >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND a.ID_Inv < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND a.ID_Inv >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND a.ID_Inv < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND CAST(a.ID_Inv AS DATE) >= @tkhMula AND CAST(a.ID_Inv AS DATE) <= @tkhTamat"
        End If

        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))

        Dim query As String = $"SELECT b.Nama_Sykt, 
                                    MAX(CONVERT(varchar(10), a.ID_Inv, 103)) AS ID_Inv, 
                                    a.Harga_Unit, 
                                    CONCAT(a.Kod_Brg, ' - ', c.Butiran) AS Butiran,
                                    (SELECT SUM(Baki_Unit)
                                     FROM SMKB_SI_Inventori 
                                     WHERE Kod_Brg = c.Kod_Brg AND Harga_Unit = a.Harga_Unit
                                     AND Kod_Ptj = '410000') AS Baki_Unit, 
                                    a.Status 
                                FROM 
                                    SMKB_SI_Inventori a
                                INNER JOIN 
                                    SMKB_Syarikat_Master b ON a.ID_Sykt = b.ID_Sykt
                                INNER JOIN 
                                    SMKB_SI_Barang_Master c ON a.Kod_Brg = c.Kod_Brg
                                WHERE 
                                    a.Kod_Ptj = '410000' 
                                    AND a.Status = '1' 
                                    AND a.Kat_Stor = 'SU'" & tarikhQuery & "GROUP BY 
                                    b.Nama_Sykt, a.Harga_Unit, CONCAT(a.Kod_Brg, ' - ', c.Butiran), a.Status, c.Kod_Brg, c.Butiran
                                ORDER BY 
                                    b.Nama_Sykt, Butiran, ID_Inv ASC"

        Return dbconn.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateTambahStok(idBarang, tarikh, kuantiti, masa, harga_seunit, idSyarikat) As String
        Dim resp As New ResponseRepository

        queryRB = New Query() 'New Query

        'Update Status Data di SMKB_SI_Transaksi
        If UpdateStatusTransaksi($"{tarikh}", $"{masa}", $"{idBarang}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Update Data Ke SMKB_SI_Inventori
        If UpdateKuantitiInventori($"{harga_seunit}", $"{idSyarikat}", $"{idBarang}", $"{kuantiti}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        ' Add some sample data to the array
        Dim rsData As New With {
            .idSyarikat = idSyarikat
        }
        resp.Success("Rekod telah berjaya dihapus.", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateStatusTransaksi(tarikh, masa, idBarang) As String
        Dim db As New DBKewConn

        'Dim datetime As String = ConvertToSmallDateTime($"{tarikh}", $"{masa}")
        Dim datetime As String = tarikh & " " & masa

        Dim query As String = "UPDATE SMKB_SI_Transaksi
                                SET Status = '0'
                                WHERE Tkh_Transaksi = @Tkh_Transaksi AND Proses = @Proses AND Kod_Brg = @Kod_Brg AND Kod_Ptj = @Kod_Ptj AND Kat_Stor = @Kat_Stor "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Tkh_Transaksi", datetime))
        param.Add(New SqlParameter("@Proses", "Masuk"))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Kod_Ptj", "500000"))
        param.Add(New SqlParameter("@Kat_Stor", "SP"))

        Return RbQueryCmd("Kod_Brg", idBarang, query, param)
    End Function

    Private Function UpdateKuantitiInventori(harga_seunit, idSyarikat, idBarang, kuantiti) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_SI_Inventori
                                SET Baki_Unit = Baki_Unit - @kuantiti
                                WHERE Kod_Ptj = @Kod_Ptj AND Harga_Unit = @Harga_Unit AND ID_Sykt = @ID_Sykt AND Kod_Brg = @Kod_Brg "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kuantiti", kuantiti))
        param.Add(New SqlParameter("@Kod_Ptj", "500000"))
        param.Add(New SqlParameter("@Harga_Unit", harga_seunit))
        param.Add(New SqlParameter("@ID_Sykt", idSyarikat))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))

        Dim key As New Dictionary(Of String, String)
        key.Add("Kod_Ptj", "500000")
        key.Add("Harga_Unit", harga_seunit)
        key.Add("ID_Sykt", idSyarikat)
        key.Add("Kod_Brg", idBarang)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateTambahStokUtama(idBarang, tarikh, kuantiti, masa, harga_seunit, idSyarikat) As String
        Dim resp As New ResponseRepository

        queryRB = New Query() 'New Query

        'Update Status Data di SMKB_SI_Transaksi
        If UpdateStatusTransaksiUtama($"{tarikh}", $"{masa}", $"{idBarang}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Update Data Ke SMKB_SI_Inventori
        If UpdateKuantitiInventoriUtama($"{harga_seunit}", $"{idSyarikat}", $"{idBarang}", $"{kuantiti}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        ' Add some sample data to the array
        Dim rsData As New With {
            .idSyarikat = idSyarikat
        }
        resp.Success("Rekod telah berjaya dihapus.", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateStatusTransaksiUtama(tarikh, masa, idBarang) As String
        Dim db As New DBKewConn

        Dim datetime As String = tarikh & " " & masa

        Dim query As String = "UPDATE SMKB_SI_Transaksi
                                SET Status = '0'
                                WHERE Tkh_Transaksi = @Tkh_Transaksi AND Proses = @Proses AND Kod_Brg = @Kod_Brg AND Kod_Ptj = @Kod_Ptj AND Kat_Stor = @Kat_Stor "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Tkh_Transaksi", datetime))
        param.Add(New SqlParameter("@Proses", "Masuk"))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Kod_Ptj", Session("ptj")))
        param.Add(New SqlParameter("@Kat_Stor", "SU"))

        Return RbQueryCmd("Kod_Brg", idBarang, query, param)
    End Function

    Private Function UpdateKuantitiInventoriUtama(harga_seunit, idSyarikat, idBarang, kuantiti) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_SI_Inventori
                                SET Baki_Unit = Baki_Unit - @kuantiti
                                WHERE Kod_Ptj = @Kod_Ptj AND Harga_Unit = @Harga_Unit AND ID_Sykt = @ID_Sykt AND Kod_Brg = @Kod_Brg "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kuantiti", kuantiti))
        param.Add(New SqlParameter("@Kod_Ptj", Session("ptj")))
        param.Add(New SqlParameter("@Harga_Unit", harga_seunit))
        param.Add(New SqlParameter("@ID_Sykt", idSyarikat))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))

        Dim key As New Dictionary(Of String, String)
        key.Add("Kod_Ptj", Session("ptj"))
        key.Add("Harga_Unit", harga_seunit)
        key.Add("ID_Sykt", idSyarikat)
        key.Add("Kod_Brg", idBarang)

        Return RbQueryCmdMulti(key, query, param)
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