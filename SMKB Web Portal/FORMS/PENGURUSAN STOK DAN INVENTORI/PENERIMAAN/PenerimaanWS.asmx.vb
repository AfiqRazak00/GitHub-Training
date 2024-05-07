Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PenerimaanWS
    Inherits System.Web.Services.WebService

    Dim dtbl As DataTable
    Dim queryRB As New Query 'Query rollback

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiPenerimaan(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String) As String
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        Using dtUserInfo = fGetSenaraiPenerimaan(category_filter, tkhMula, tkhTamat)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetSenaraiPenerimaan(category_filter As String, tkhMula As String, tkhTamat As String) As DataTable
        Dim dbconn As New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(a.Tkh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(a.Tkh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND a.Tkh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND a.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND a.Tkh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND a.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND a.Tkh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND a.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND CAST(a.Tkh_Mohon AS DATE) >= @tkhMula AND CAST(a.Tkh_Mohon AS DATE) <= @tkhTamat"
        End If

        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))

        Dim query As String = $"SELECT 
                                    a.No_Mohon, 
                                    MAX(a.Tkh_Mohon) AS Tkh_Mohon, 
									(SELECT SUM(b.Kuantiti_Mohon)
									 FROM SMKB_SI_Order_Dtl b
									 WHERE a.No_Mohon = b.No_Mohon) AS Kuantiti_Mohon,
                                    (SELECT SUM(b.Kuantiti_Lulus)
									 FROM SMKB_SI_Order_Dtl b
									 WHERE a.No_Mohon = b.No_Mohon) AS Kuantiti_Lulus,
                                   CONCAT(MAX(a.Kod_Ptj), '-', (SELECT Pejabat FROM VPejabat b WHERE KodPejPBU = a.Kod_Ptj)) AS Kod_Ptj
                                FROM 
                                    SMKB_SI_Order_Hdr a 
                                INNER JOIN 
                                    SMKB_SI_Order_Dtl b ON a.No_Mohon = b.No_Mohon
                                WHERE 
                                    a.Kat_Mohon = 'S' AND a.Status_Dok = '06'" & tarikhQuery & "GROUP BY a.No_Mohon,a.Kod_Ptj;"

        Return dbconn.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchPenerimaanDetails(noMohon As String) As String

        Using dtUserInfo = fGetPenerimaanDetails(noMohon)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetPenerimaanDetails(noMohon As String) As DataTable
        Dim dbconn As New DBKewConn

        Dim query As String = $"SELECT DISTINCT
                                    a.Kod_Brg,
	                                a.No_Mohon,
                                    a.Kuantiti_Mohon, 
                                    a.Tujuan, 
                                    a.Kuantiti_Lulus,
                                    b.Tkh_Mohon,
                                    b.No_Staf,
                                    (SELECT SUM(c.Baki_Unit)
									 FROM SMKB_SI_Inventori c
									 WHERE c.Kod_Brg = a.Kod_Brg
									   AND c.Kod_Ptj = '500000') AS Total_Baki_Unit,
                                    d.Butiran AS NamaBarang, 
                                     STUFF((
		                                SELECT DISTINCT ',' + e.Kod_Lokasi
		                                FROM SMKB_SI_Barang_Stor e
		                                WHERE a.Kod_Brg = e.Kod_Brg AND e.Kod_Ptj = '500000'
		                                FOR XML PATH('')), 1, 1, '') AS Kod_Lokasi,
	                                f.Butiran,
	                                CONCAT(g.KodPejabat, '0000') AS KodPejabat,
	                                g.Pejabat
                                FROM 
                                    SMKB_SI_Order_Dtl a
                                INNER JOIN 
                                    SMKB_SI_Order_Hdr b ON a.No_Mohon = b.No_Mohon AND b.Kat_Mohon = 'S' AND b.Status_Dok = '06'
                                INNER JOIN 
                                    SMKB_SI_Inventori c ON a.Kod_Brg = c.Kod_Brg
                                INNER JOIN 
                                    SMKB_SI_Barang_Master d ON a.Kod_Brg = d.Kod_Brg
                                INNER JOIN 
                                    SMKB_SI_Barang_Stor e ON a.Kod_Brg = e.Kod_Brg
                                INNER JOIN 
	                                SMKB_Lookup_Detail f ON d.Kod_Ukuran = f.Kod_Detail
                                INNER JOIN 
	                                VPejabat g ON LEFT(b.Kod_Ptj, 2) = g.KodPejabat
                                WHERE a.No_Mohon = @No_Mohon
                                AND c.Kod_Ptj = '500000'
                                AND f.Kod ='SI003'"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", noMohon))

        Return dbconn.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchPemohonDetails(NoStaf As String) As String
        Using dtUserInfo = fGetPemohonDetails(NoStaf)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function
    <WebMethod()>
    Public Function fGetPemohonDetails(NoStaf) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT MS01_Nama As Nama, JawGiliran As NamaJawatan, MS01_NoTelBimbit As NoTel FROM VPeribadi WHERE MS01_NoStaf = '{NoStaf}'"

        Using dt = dbconn.fselectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchPengesah(noMohon As String) As String
        Using dtUserInfo = fGetPengesah(noMohon)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function
    <WebMethod()>
    Public Function fGetPengesah(noMohon) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT No_Staf, Tkh_Tindakan FROM SMKB_Status_Dok WHERE Kod_Modul = '28' AND Kod_Status_Dok = '03' AND No_Rujukan = '{noMohon}';"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchPelulus(noMohon As String) As String
        Using dtUserInfo = fGetPelulus(noMohon)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return "Error"
            End If
        End Using
    End Function
    <WebMethod()>
    Public Function fGetPelulus(noMohon) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT No_Staf, Tkh_Tindakan FROM SMKB_Status_Dok WHERE Kod_Modul = '28' AND Kod_Status_Dok = '04' AND No_Rujukan = '{noMohon}';"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanPenerimaan(formDataArray As List(Of OrderDtl), NoMohon As String, kodPtj As String) As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn
        Dim Query As String

        queryRB = New Query() 'New Query

        'Update Status_Dok ke SMKB_SI_Order_Hdr
        If UpdateStatusOrder($"{NoMohon}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Insert Data Ke SMKB_Pinjaman_Status_Dok
        If InsertStatusDok(Session("ssusrID"), $"{NoMohon}") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod 2 ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Update Data Ke SMKB_SI_Transaksi
        For Each formData In formDataArray
            While formData.KuantitiLulus > 0
                Dim Baki_Unit As Integer = 1
                Dim KuantitiTransaksi As Integer = 1
                Dim Harga As Decimal
                Dim idSykt As String

                Dim bakiSemasa As Integer = GetBakiSemasa(formData.IdBarang, "500000")
                Dim bakiSemasaPtj As Integer = GetBakiSemasaPtj(formData.IdBarang, kodPtj)

                Query = $"SELECT TOP 1 Baki_Unit, Harga_Unit, ID_Sykt, ID_Inv
                            FROM SMKB_SI_Inventori
                            WHERE Kod_Ptj = @Kod_Ptj AND Kod_Brg = @Kod_Brg AND Baki_Unit > 0
                            ORDER BY ID_Inv"
                Dim param As New List(Of SqlParameter)
                param.Clear() ' Clearing parameters before reusing the list

                param.Add(New SqlParameter("@Kod_Ptj", "500000"))
                param.Add(New SqlParameter("@Kod_Brg", formData.IdBarang))

                dtbl = db.Read(Query, param)

                If dtbl.Rows.Count > 0 Then
                    Baki_Unit = CInt(dtbl.Rows(0).Item("Baki_Unit"))
                    Harga = CDec(dtbl.Rows(0).Item("Harga_Unit"))
                    idSykt = dtbl.Rows(0).Item("ID_Sykt").ToString()
                    Dim ID_Inv As DateTime = dtbl.Rows(0).Field(Of DateTime)("ID_Inv")


                    If Baki_Unit >= formData.KuantitiLulus Then
                        KuantitiTransaksi = formData.KuantitiLulus
                        Baki_Unit = Baki_Unit - formData.KuantitiLulus
                        bakiSemasa = bakiSemasa - formData.KuantitiLulus
                        bakiSemasaPtj = bakiSemasaPtj + formData.KuantitiLulus
                        formData.KuantitiLulus = 0
                    Else
                        KuantitiTransaksi = Baki_Unit
                        formData.KuantitiLulus = formData.KuantitiLulus - Baki_Unit
                        bakiSemasa = bakiSemasa - Baki_Unit
                        bakiSemasaPtj = bakiSemasaPtj + Baki_Unit
                        Baki_Unit = 0

                        'Update Data Ke SMKB_SI_Inventori
                        If UpdateStatusInventori(Harga, formData.IdBarang, idSykt, ID_Inv) <> "OK" Then
                            queryRB.rollback()
                            resp.Failed("Gagal menyimpan rekod ‼️")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                        End If
                    End If

                    'Update Data Ke SMKB_SI_Inventori
                    If UpdateInventori(Harga, formData.IdBarang, idSykt, Baki_Unit, ID_Inv) <> "OK" Then
                        queryRB.rollback()
                        resp.Failed("Gagal menyimpan rekod ‼️")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If

                    'Insert Data Keluar Ke SMKB_SI_Transaksi
                    If InsertTransaksi(formData.IdBarang, KuantitiTransaksi, bakiSemasa, Harga, NoMohon) <> "OK" Then
                        queryRB.rollback()
                        resp.Failed("Gagal menyimpan rekod ‼️")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If

                    'Insert Data Masuk Ke SMKB_SI_Transaksi
                    If InsertTambahTransaksi(formData.IdBarang, KuantitiTransaksi, bakiSemasaPtj, Harga, NoMohon, kodPtj) <> "OK" Then
                        queryRB.rollback()
                        resp.Failed("Gagal menyimpan rekod ‼️")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If

                    'Insert Data Ke SMKB_SI_Inventori
                    If InsertTambahInventori(Harga, idSykt, formData.IdBarang, KuantitiTransaksi, kodPtj) <> "OK" Then
                        queryRB.rollback()
                        resp.Failed("Gagal menyimpan rekod ‼️")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If
                Else
                    resp.Failed("Gagal membaca rekod ‼️")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End While
        Next

        Dim result As New List(Of Object)()
        'queryRB.finish()

        ' Add some sample data to the array
        Dim rsData As New With {
            .NoMohon = NoMohon
        }
        resp.Success("Rekod telah berjaya disimpan.", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertTambahInventori(harga_seunit, idSyarikat, idBarang, kuantiti, kodPtj) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_SI_Inventori 
                                (ID_Inv, Kod_Ptj, Harga_Unit, ID_Sykt, Kod_Brg, Baki_Unit, Kat_Stor, Status) 
                                VALUES (@ID_Inv, @Kod_Ptj, @Harga_Unit, @ID_Sykt, @Kod_Brg, @Baki_Unit, @Kat_Stor, @Status)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ID_Inv", Date.Now))
        param.Add(New SqlParameter("@Kod_Ptj", kodPtj))
        param.Add(New SqlParameter("@Harga_Unit", harga_seunit))
        param.Add(New SqlParameter("@ID_Sykt", idSyarikat))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Baki_Unit", kuantiti))
        param.Add(New SqlParameter("@Kat_Stor", "SU"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("Kod_Brg", idBarang, query, param)
    End Function

    Private Function InsertTambahTransaksi(IdBarang, KuantitiTransaksi, bakiSemasa, Harga, NoMohon, kodPtj) As String
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_SI_Transaksi 
                                (ID_Transaksi, Tkh_Transaksi, Proses, Kuantiti, Harga_Unit, Jum_Harga, Created_By, Kod_Brg, Baki_Semasa, Kod_Ptj, Kat_Stor, Status, No_Rujukan) 
                                VALUES (@ID_Transaksi, @Tkh_Transaksi, @Proses, @Kuantiti, @Harga_Unit, @Jum_Harga, @Created_By, @Kod_Brg, @Baki_Semasa, @Kod_Ptj, @Kat_Stor, @Status, @No_Rujukan)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ID_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Proses", "Masuk"))
        param.Add(New SqlParameter("@Kuantiti", KuantitiTransaksi))
        param.Add(New SqlParameter("@Harga_Unit", Harga))
        param.Add(New SqlParameter("@Jum_Harga", KuantitiTransaksi * Harga))
        param.Add(New SqlParameter("@Created_By", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Brg", IdBarang))
        param.Add(New SqlParameter("@Baki_Semasa", bakiSemasa))
        param.Add(New SqlParameter("@Kod_Ptj", kodPtj))
        param.Add(New SqlParameter("@Kat_Stor", "SU"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@No_Rujukan", NoMohon))

        Return RbQueryCmd("Kod_Brg", IdBarang, query, param)
    End Function

    Private Function UpdateStatusInventori(Harga, idBarang, idSykt, ID_Inv) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_SI_Inventori
                                SET Status = '0'
                                WHERE Kod_Ptj = @Kod_Ptj AND Harga_Unit = @Harga_Unit AND ID_Sykt = @ID_Sykt AND Kod_Brg = @Kod_Brg AND ID_Inv = @ID_Inv"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Ptj", "500000"))
        param.Add(New SqlParameter("@Harga_Unit", Harga))
        param.Add(New SqlParameter("@ID_Sykt", idSykt))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@ID_Inv", ID_Inv))

        Dim key As New Dictionary(Of String, String)
        key.Add("Kod_Ptj", "500000")
        key.Add("Harga_Unit", Harga)
        key.Add("ID_Sykt", idSykt)
        key.Add("Kod_Brg", idBarang)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function InsertTransaksi(IdBarang, KuantitiTransaksi, bakiSemasa, Harga, NoMohon) As String
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_SI_Transaksi 
                                (ID_Transaksi, Tkh_Transaksi, Proses, Kuantiti, Harga_Unit, Jum_Harga, Created_By, Kod_Brg, Baki_Semasa, Kod_Ptj, Kat_Stor, Status, No_Rujukan) 
                                VALUES (@ID_Transaksi, @Tkh_Transaksi, @Proses, @Kuantiti, @Harga_Unit, @Jum_Harga, @Created_By, @Kod_Brg, @Baki_Semasa, @Kod_Ptj, @Kat_Stor, @Status, @No_Rujukan)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ID_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Proses", "Keluar"))
        param.Add(New SqlParameter("@Kuantiti", KuantitiTransaksi))
        param.Add(New SqlParameter("@Harga_Unit", Harga))
        param.Add(New SqlParameter("@Jum_Harga", KuantitiTransaksi * Harga))
        param.Add(New SqlParameter("@Created_By", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Brg", IdBarang))
        param.Add(New SqlParameter("@Baki_Semasa", bakiSemasa))
        param.Add(New SqlParameter("@Kod_Ptj", "500000"))
        param.Add(New SqlParameter("@Kat_Stor", "SP"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@No_Rujukan", NoMohon))

        Return RbQueryCmd("Kod_Brg", IdBarang, query, param)
    End Function

    Private Function UpdateInventori(Harga, idBarang, idSykt, Baki_Unit, ID_Inv) As String
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_SI_Inventori
                                SET Baki_Unit = @kuantiti
                                WHERE Kod_Ptj = @Kod_Ptj AND Harga_Unit = @Harga_Unit AND ID_Sykt = @ID_Sykt AND Kod_Brg = @Kod_Brg AND ID_Inv = @ID_Inv"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kuantiti", Baki_Unit))
        param.Add(New SqlParameter("@Kod_Ptj", "500000"))
        param.Add(New SqlParameter("@Harga_Unit", Harga))
        param.Add(New SqlParameter("@ID_Sykt", idSykt))
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@ID_Inv", ID_Inv))

        Dim key As New Dictionary(Of String, String)
        key.Add("Kod_Ptj", "500000")
        key.Add("Harga_Unit", Harga)
        key.Add("ID_Sykt", idSykt)
        key.Add("Kod_Brg", idBarang)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function GetBakiSemasaPtj(idBarang, kodPtj)
        Dim db As New DBKewConn

        Dim Baki_Semasa As Integer

        Dim query As String = $"SELECT TOP 1 Baki_Semasa
                            FROM SMKB_SI_Transaksi
                            WHERE Kod_Ptj = @Kod_Ptj AND Kod_Brg = @Kod_Brg
                            ORDER BY ID_Transaksi DESC"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Kod_Ptj", kodPtj))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Baki_Semasa = CInt(dtbl.Rows(0).Item("Baki_Semasa"))
        Else
            Baki_Semasa = 0
        End If

        Return Baki_Semasa
    End Function

    Private Function GetBakiSemasa(idBarang, kodPtj)
        Dim db As New DBKewConn

        Dim Baki_Semasa As Integer

        Dim query As String = $"SELECT TOP 1 Baki_Semasa
                            FROM SMKB_SI_Transaksi
                            WHERE Kod_Ptj = @Kod_Ptj AND Kod_Brg = @Kod_Brg
                            ORDER BY ID_Transaksi DESC"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod_Brg", idBarang))
        param.Add(New SqlParameter("@Kod_Ptj", kodPtj))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Baki_Semasa = CInt(dtbl.Rows(0).Item("Baki_Semasa"))
        Else
            Baki_Semasa = 0
        End If

        Return Baki_Semasa
    End Function

    Private Function UpdateStatusOrder(NoMohon) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_SI_Order_Hdr
                                SET Status_Dok = @Status_Dok
                                WHERE No_Mohon = @No_Mohon AND Kat_Mohon = @Kat_Mohon AND Status = @Status"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Status_Dok", "07"))
        param.Add(New SqlParameter("@No_Mohon", NoMohon))
        param.Add(New SqlParameter("@Kat_Mohon", "S"))
        param.Add(New SqlParameter("@Status", "1"))

        Dim key As New Dictionary(Of String, String)
        key.Add("No_Mohon", NoMohon)
        key.Add("Kat_Mohon", "S")
        key.Add("Status", "1")

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function InsertStatusDok(staffId, noPermohonan) As String
        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status) 
                                VALUES (@Kod_Modul, @Kod_Status_Dok, @No_Rujukan, @No_Staf, @Tkh_Tindakan, @Tkh_Transaksi, @Status_Transaksi, @Status)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "28"))
        param.Add(New SqlParameter("@Kod_Status_Dok", "07"))
        param.Add(New SqlParameter("@No_Rujukan", noPermohonan))
        param.Add(New SqlParameter("@No_Staf", staffId))
        param.Add(New SqlParameter("@Tkh_Tindakan", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Status_Transaksi", "1"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("No_Rujukan", noPermohonan, query, param)
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

    Public Class OrderDtl
        Public Property IdBarang As String
        Public Property KuantitiLulus As String
    End Class
End Class