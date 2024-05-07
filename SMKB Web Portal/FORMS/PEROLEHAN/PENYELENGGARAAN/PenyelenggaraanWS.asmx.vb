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
Imports System.Globalization
Imports SMKB_Web_Portal.Maklumat_Pemfaktoran
Imports System.Reflection
Imports SMKB_Web_Portal.Daftar_Bidaan
Imports SMKB_Web_Portal.Daftar_Jawatankuasa
Imports SMKB_Web_Portal.Pelulus_PT


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PenyelenggaraanWS
    Inherits System.Web.Services.WebService

    Dim dt As DataTable


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPoskod(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodPoskod(q)
        Return JsonConvert.SerializeObject(tmpDT)
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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetNegeri(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodNegeri(q)
        Return JsonConvert.SerializeObject(tmpDT)
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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBandar(ByVal q As String) As String


        Dim tmpDT As DataTable = GetKodBandar(q)
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


        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY A.id_no) AS Bil,
                                A.id_no,A.bayar_atas_nama,A.Kod_Bank,A.noakaun,A.Email,A.Alamat1,A.Alamat2,A.Bandar,A.Negeri,A.Poskod,A.Negara,
                                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod_Detail = A.Bandar AND Kod = '0003') AS NamaBandar,
                                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod_Detail = A.Negeri AND Kod = '0002') AS NamaNegeri
                                FROM SMKB_Perolehan_Pemfaktoran_Bank A"

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanPemfaktoranBank(SaveBankPemfaktoran As PemfaktoranHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")


        Dim msg As String = ""

        If SaveBankPemfaktoran Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.txtBayar) Then
            msg = "Sila pastikan Bayar Atas Nama telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.txtNoAkaun) Then
            msg += "Sila pastikan No Akaun telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.txtNamaBank) Then
            msg += "Sila pastikan Nama Bank telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.txtEmail) Then
            msg += "Sila pastikan Email telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.txtAlamat1) Then
            msg += "Sila pastikan Alamat 1 telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.txtAlamat2) Then
            msg += "Sila pastikan Alamat 2 telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.ddlPoskod) Then
            msg += "Sila pastikan Poskod telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.ddlBandar) Then
            msg += "Sila pastikan Bandar telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveBankPemfaktoran.ddlNegeri) Then
            msg += "Sila pastikan Negeri telah diisi.<br/>"
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If SaveBankPemfaktoran.txtNoId = "" Then
            Dim noMohonID As String = GenerateNoId()
            SaveBankPemfaktoran.txtNoId = noMohonID

            If InsertNewOrder(SaveBankPemfaktoran.txtNoId, SaveBankPemfaktoran.txtBayar, SaveBankPemfaktoran.txtNoAkaun, SaveBankPemfaktoran.txtNamaBank, SaveBankPemfaktoran.txtEmail, SaveBankPemfaktoran.txtAlamat1, SaveBankPemfaktoran.txtAlamat2, SaveBankPemfaktoran.ddlPoskod, SaveBankPemfaktoran.ddlBandar, SaveBankPemfaktoran.ddlNegeri) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        resp.Success("Maklumat berjaya disimpan", "00", SaveBankPemfaktoran)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function GenerateNoId()
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoPemfaktoran As String = ""
        Dim ptj = "410000"

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='PN' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
            UpdateNoAkhir("02", "PN", year, lastID, ptj)

        Else
            InsertNoAkhir("02", "PN", year, lastID, ptj)
        End If

        newNoPemfaktoran = "PN" + Format(lastID, "000000").ToString

        Return newNoPemfaktoran
    End Function

    Private Function InsertNewOrder(txtNoId As String, txtBayar As String, txtNoAkaun As String, txtNamaBank As String, txtEmail As String, txtAlamat1 As String, txtAlamat2 As String, ddlPoskod As String, ddlBandar As String, ddlNegeri As String)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Perolehan_Pemfaktoran_Bank (Id_No, Bayar_Atas_Nama, Kod_Bank,NoAkaun,Email,Alamat1,Alamat2,Poskod,Bandar,Negeri,Status)
        VALUES(@txtNoId, @txtBayar, @txtNamaBank,@txtNoAkaun,@txtEmail,@txtAlamat1,@txtAlamat2,@ddlPoskod,@ddlBandar,@ddlNegeri,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoId", txtNoId))
        param.Add(New SqlParameter("@txtBayar", txtBayar))
        param.Add(New SqlParameter("@txtNoAkaun", txtNoAkaun))
        param.Add(New SqlParameter("@txtNamaBank", txtNamaBank))
        param.Add(New SqlParameter("@txtEmail", txtEmail))
        param.Add(New SqlParameter("@txtAlamat1", txtAlamat1))
        param.Add(New SqlParameter("@txtAlamat2", txtAlamat2))
        param.Add(New SqlParameter("@ddlPoskod", ddlPoskod))
        param.Add(New SqlParameter("@ddlBandar", ddlBandar))
        param.Add(New SqlParameter("@ddlNegeri", ddlNegeri))

        Return db.Process(query, param)
    End Function


    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String, ddlPTJPemohon As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Pemfaktoran Bank"))
        param.Add(New SqlParameter("@Kod_PTJ", ddlPTJPemohon)) 'letak session ssusrKodPTj


        Return db.Process(query, param)
    End Function

    Private Function UpdateNoAkhir(kodModul As String, prefix As String, year As String, ID As String, ddlPTJPemohon As String)
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


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdatePemfaktoranBank(UpdateBankPemfaktoran As PemfaktoranHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim msg As String = ""

        If UpdateBankPemfaktoran Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.txtBayar) Then
            msg = "Sila pastikan Bayar Atas Nama telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.txtNoAkaun) Then
            msg += "Sila pastikan No Akaun telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.txtNamaBank) Then
            msg += "Sila pastikan Nama Bank telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.txtEmail) Then
            msg += "Sila pastikan Email telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.txtAlamat1) Then
            msg += "Sila pastikan Alamat 1 telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.txtAlamat2) Then
            msg += "Sila pastikan Alamat 2 telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.ddlPoskod) Then
            msg += "Sila pastikan Poskod telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.ddlBandar) Then
            msg += "Sila pastikan Bandar telah diisi."
        End If

        If String.IsNullOrEmpty(UpdateBankPemfaktoran.ddlNegeri) Then
            msg += "Sila pastikan Negeri telah diisi."
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateBankPemfaktoran.txtNoId <> "" Then

            If UpdatePemfaktoranBank(UpdateBankPemfaktoran.txtNoId, UpdateBankPemfaktoran.txtBayar, UpdateBankPemfaktoran.txtNoAkaun, UpdateBankPemfaktoran.txtNamaBank, UpdateBankPemfaktoran.txtEmail, UpdateBankPemfaktoran.txtAlamat1, UpdateBankPemfaktoran.txtAlamat2, UpdateBankPemfaktoran.ddlPoskod, UpdateBankPemfaktoran.ddlBandar, UpdateBankPemfaktoran.ddlNegeri) <> "OK" Then
                resp.Failed("Gagal Mengemaskini Maklumat")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        resp.Success("Rekod berjaya dikemaskini", "00", UpdateBankPemfaktoran)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function UpdatePemfaktoranBank(txtNoId As String, txtBayar As String, txtNoAkaun As String, txtNamaBank As String, txtEmail As String, txtAlamat1 As String, txtAlamat2 As String, ddlPoskod As String, ddlBandar As String, ddlNegeri As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pemfaktoran_Bank SET Bayar_Atas_Nama =  @Bayar_Atas_Nama, Kod_Bank = @Kod_Bank, NoAkaun = @NoAkaun, 
        Email = @Email, Alamat1 = @Alamat1, Alamat2 =  @Alamat2, Poskod = @ddlPoskod, Bandar = @ddlBandar,Negeri = @ddlNegeri
        WHERE Id_No = @txtNoId "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoId", txtNoId))
        param.Add(New SqlParameter("@Bayar_Atas_Nama", txtBayar))
        param.Add(New SqlParameter("@Kod_Bank", txtNamaBank))
        param.Add(New SqlParameter("@NoAkaun", txtNoAkaun))
        param.Add(New SqlParameter("@Email", txtEmail))
        param.Add(New SqlParameter("@Alamat1", txtAlamat1))
        param.Add(New SqlParameter("@Alamat2", txtAlamat2))
        param.Add(New SqlParameter("@ddlPoskod", ddlPoskod))
        param.Add(New SqlParameter("@ddlBandar", ddlBandar))
        param.Add(New SqlParameter("@ddlNegeri", ddlNegeri))

        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Mod_Jawatankuasa(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodModJawatankuasa(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodModJawatankuasa(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "Select Kod_Detail As value, Butiran AS text From SMKB_Lookup_Detail where Kod ='0153'"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod LIKE '%' + @kod + '%') "
            param.Add(New SqlParameter("@kod", kod))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Kod_Jawatankuasa(ByVal q As String, ByVal kod_jawatankuasa As String) As String

        Dim tmpDT As DataTable = GetKodJawatankuasa(q, kod_jawatankuasa)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodJawatankuasa(carian As String, kod_jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim where As String = ""
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(carian) Then
            where &= " AND text LIKE '%' + @carian + '%'"
            param.Add(New SqlParameter("@carian", carian))
        End If

        Dim query As String = "SELECT DISTINCT * FROM (
                                    SELECT
                                        CASE 
                                            WHEN kategori = 'P' THEN 'Pembuka'
                                            WHEN kategori = 'T' THEN 'Penilaian Teknikal'
                                            WHEN kategori = 'L' THEN 'Perlantikan'
		                                    WHEN kategori = 'H' THEN 'Penilaian Harga'
                                            WHEN kategori = 'S' THEN 'Pengesyoran'
                                            WHEN kategori = 'TI' THEN 'Teknikal ICT'
											WHEN kategori = 'TU' THEN 'Teknikal Universiti'
                                        END AS text,
	                                    kategori as value
                                     FROM
                                        smkb_perolehan_jawatankuasa
                                    WHERE
                                        Mod_Jawatankuasa = @kod 
                                ) mainTable
                                WHERE 1 = 1 " & where & "
                                order by text"


        param.Add(New SqlParameter("@kod", kod_jawatankuasa))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Simpan_Jawatankuasa(SaveJawatan As JawatankuasaHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        Dim msg As String = ""

        If SaveJawatan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(SaveJawatan.ddlMod) Then
            msg = "Sila pastikan Mod Jawatankuasa telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(SaveJawatan.ddlKategori) Then
            msg += "Sila pastikan Kategori Jawatankuasa telah dipilih."
        End If

        If String.IsNullOrEmpty(SaveJawatan.txtNamaJawatankuasa) Then
            msg += "Sila pastikan Nama Jawatankuasa telah diisi."
        End If

        If String.IsNullOrEmpty(SaveJawatan.DokumenType) Then
            msg += "Sila pastikan status telah dipilih."
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If SaveJawatan.txtKodJawatankuasa = "" Then
            Dim noMohonID As String = GenerateKodJawatankuasa(SaveJawatan.ddlMod, SaveJawatan.ddlKategori)
            SaveJawatan.txtKodJawatankuasa = noMohonID

            If InsertNewOrder(SaveJawatan.ddlMod, SaveJawatan.ddlKategori, SaveJawatan.txtKodJawatankuasa, SaveJawatan.txtNamaJawatankuasa, SaveJawatan.DokumenType) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", SaveJawatan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertNewOrder(ddlMod As String, ddlKategori As String, txtKodJawatankuasa As String, txtNamaJawatankuasa As String, DokumenType As String)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Perolehan_Jawatankuasa (Mod_Jawatankuasa, Kategori, Kod_Jawatankuasa,Butiran,Status)
        VALUES(@Mod_Jawatankuasa,@Kategori,@Kod_Jawatankuasa,@Butiran,@Status)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Mod_Jawatankuasa", ddlMod))
        param.Add(New SqlParameter("@Kategori", ddlKategori))
        param.Add(New SqlParameter("@Kod_Jawatankuasa", txtKodJawatankuasa))
        param.Add(New SqlParameter("@Butiran", txtNamaJawatankuasa))
        param.Add(New SqlParameter("@Status", DokumenType))

        Return db.Process(query, param)
    End Function


    'Generate Nombor Bidaan
    Private Function GenerateKodJawatankuasa(ddlMod As String, ddlKategori As String)
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim lastID As Integer = 1
        Dim newNoPO As String = ""
        Dim Prefix = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix = 'J' + @ddlKategori + LEFT(@ddlMod, 1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ddlMod", ddlMod))
        param.Add(New SqlParameter("@ddlKategori", ddlKategori))

        Prefix = "J" + ddlKategori + Left(ddlMod, 1)

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
            UpdateNoAkhir2("02", Prefix, lastID, year)

        Else
            InsertNoAkhir2("02", Prefix, lastID, year)
        End If

        Dim formattedLastID As String = If(lastID < 10, "0" & lastID.ToString(), lastID.ToString())
        newNoPO = Prefix & formattedLastID

        Return newNoPO
    End Function


    Private Function InsertNoAkhir2(kodModul As String, prefix As String, ID As String, year As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir (Kod_Modul,Prefix,No_Akhir,Butiran,Tahun)
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Butiran,@Tahun)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Butiran", "Kod Jawatankuasa"))
        param.Add(New SqlParameter("@Tahun", year))



        Return db.Process(query, param)
    End Function

    Private Function UpdateNoAkhir2(kodModul As String, prefix As String, ID As String, year As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
                               set No_Akhir = @No_Akhir
                              where Kod_Modul=@Kod_Modul and Prefix=@Prefix"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))

        Return db.Process(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadAhliJawatankuasa() As String
        Dim resp As New ResponseRepository

        dt = GetRecord_AhliJawatankuasa()
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_AhliJawatankuasa() As DataTable
        Dim db = New DBKewConn


        Dim query As String = " Select  A.ID,A.No_Lantikan,A.Kod_JawatanKuasa,A.KodPTj,Format(A.TarikhKuatkuasa,'yyyy-MM-dd')TarikhKuatkuasa,Format(A.TarikhTamat,'yyyy-MM-dd')TarikhTamat,A.No_Staf,A.Jawatan,A.Status,A.kodJawatanAsal,
                                B.MS01_Nama,B.JawGiliran,B.Pejabat,C.Butiran,(C.Kod_Jawatankuasa + ' - ' + Butiran) As newbutiran
                                from SMKB_Perolehan_JawatankuasaDT A
                                INNER JOIN VPeribadi As B On B.MS01_NoStaf = A.No_Staf
                                INNER JOIN SMKB_Perolehan_Jawatankuasa As C On C.Kod_Jawatankuasa = A.Kod_JawatanKuasa
                                order by A.Kod_JawatanKuasa"

        Return db.Read(query)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJawatankuasa() As String
        Dim resp As New ResponseRepository

        dt = GetRecord_Jawatankuasa()
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_Jawatankuasa() As DataTable
        Dim db = New DBKewConn


        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY A.Butiran) AS Bil,
                                Kod_Jawatankuasa,
                                Butiran,
                                CASE 
                                    WHEN Status = 'true' THEN 'aktif'
                                    WHEN Status = 'false' THEN 'tidak aktif'
                                END AS Status,
                                CASE 
                                            WHEN kategori = 'P' THEN 'Pembuka'
                                            WHEN kategori = 'T' THEN 'Penilaian Teknikal'
                                            WHEN kategori = 'L' THEN 'Perlantikan'
		                                    WHEN kategori = 'H' THEN 'Penilaian Harga'
                                            WHEN kategori = 'S' THEN 'Pengesyoran'
                                            WHEN kategori = 'TI' THEN 'Teknikal ICT'
											WHEN kategori = 'TU' THEN 'Teknikal Universiti'
                                END AS KategoriD,A.kategori,A.Mod_Jawatankuasa,                               
                                (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod_Detail = A.Mod_Jawatankuasa AND Kod = '0153') AS Mod_JawatankuasaD
                                FROM 
                                SMKB_Perolehan_Jawatankuasa A"

        Return db.Read(query)
    End Function
    'Update Status dari kelulusan PTJ   
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Update_Jawatankuasa(UpdateJawatan As JawatankuasaHeader)
        Dim resp As New ResponseRepository

        Dim msg As String = ""

        If UpdateJawatan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(UpdateJawatan.ddlMod) Then
            msg = "Sila pastikan Mod Jawatankuasa telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(UpdateJawatan.ddlKategori) Then
            msg += "Sila pastikan Kategori Jawatankuasa telah dipilih.<br/>"
        End If

        If String.IsNullOrEmpty(UpdateJawatan.txtKodJawatankuasa) Then
            msg += "Sila pilih dari senarai jawatankuasa.<br/>"
        End If

        If String.IsNullOrEmpty(UpdateJawatan.txtNamaJawatankuasa) Then
            msg += "Sila pastikan Nama Jawatankuasa diisi.<br/>"
        End If

        If String.IsNullOrEmpty(UpdateJawatan.DokumenType) Then
            msg += "Sila pastikan status telah dipilih.<br/>"
        End If


        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Not String.IsNullOrEmpty(UpdateJawatan.txtKodJawatankuasa) Then

            If Update_Jawatankuasa(UpdateJawatan.txtNamaJawatankuasa, UpdateJawatan.DokumenType, UpdateJawatan.txtKodJawatankuasa) <> "OK" Then
                resp.Failed("Gagal menghantar kelulusan permohonan perolehan.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        resp.Success("Maklumat berjaya dikemaskini.", "00", UpdateJawatan.txtKodJawatankuasa)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function Update_Jawatankuasa(txtNamaJawatankuasa As String, DokumenType As String, txtKodJawatankuasa As String)

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Jawatankuasa SET 
        Butiran = @txtNamaJawatankuasa, Status = @DokumenType
        WHERE Kod_Jawatankuasa = @txtKodJawatankuasa "


        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNamaJawatankuasa", txtNamaJawatankuasa))
        param.Add(New SqlParameter("@DokumenType", DokumenType))
        param.Add(New SqlParameter("@txtKodJawatankuasa", txtKodJawatankuasa))

        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Ptj(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodPtj(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodPtj(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "Select KodPejabat As value, KodPejabat + '0000' + ' - ' + Pejabat AS text From VPejabat"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " WHERE (KodPejabat LIKE '%' + @kod + '%' OR Pejabat LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetStaf(ByVal q As String, ByVal kod_jawatankuasa As String) As String

        Dim tmpDT As DataTable = GetKodStaf(q, kod_jawatankuasa)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodStaf(carian As String, kod_jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim where As String = ""
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(carian) Then
            where &= " AND text LIKE '%' + @carian + '%'"
            param.Add(New SqlParameter("@carian", carian))
        End If

        Dim query = "SELECT * FROM (
                        SELECT MS01_NoStaf as value, MS01_NoStaf + ' - ' + MS01_Nama as text
                        FROM vperibadi
                        WHERE MS08_Pejabat = @kod 
                     ) mainTable
                      WHERE 1 = 1 " & where & "
                      order by text"


        param.Add(New SqlParameter("@kod", kod_jawatankuasa))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Simpan_AhliJawatankuasa(SaveAhliJawatan As JawatankuasaHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        Dim msg As String = ""

        If SaveAhliJawatan Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(SaveAhliJawatan.ddlMod) Then
            msg = "Sila pastikan Mod Jawatankuasa telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(SaveAhliJawatan.ddlKodJawatankuasa) Then
            msg += "Sila pastikan Kategori Jawatankuasa telah dipilih."
        End If

        If String.IsNullOrEmpty(SaveAhliJawatan.txtTarikhMula) Then
            msg += "Sila pastikan tarikh mula telah diisi."
        End If

        If String.IsNullOrEmpty(SaveAhliJawatan.txtTarikhTamat) Then
            msg += "Sila pastikan  tarikh tamat telah diisi."
        End If

        If String.IsNullOrEmpty(SaveAhliJawatan.ddlPtj) Then
            msg += "Sila pastikan Pusat Tanggungjawab telah dipilih."
        End If

        If String.IsNullOrEmpty(SaveAhliJawatan.ddlStaf) Then
            msg += "Sila pastikan nama staf telah dipilih."
        End If

        If String.IsNullOrEmpty(SaveAhliJawatan.ddlJawatan) Then
            msg += "Sila pastikan jawatan jawantankuasa telah dipilih."
        End If


        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If SaveAhliJawatan.no_lantikan = "" Then
            Dim noLantikan As String = GenerateNoLantikan(SaveAhliJawatan.ddlKodJawatankuasa, SaveAhliJawatan.ddlPtj, SaveAhliJawatan.txtTarikhMula)
            SaveAhliJawatan.no_lantikan = noLantikan

            If InsertAhliJawatan(SaveAhliJawatan.ddlKodJawatankuasa, SaveAhliJawatan.no_lantikan, SaveAhliJawatan.txtTarikhMula, SaveAhliJawatan.txtTarikhTamat, SaveAhliJawatan.ddlPtj, SaveAhliJawatan.ddlStaf, SaveAhliJawatan.ddlJawatan) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", SaveAhliJawatan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertAhliJawatan(ddlKodJawatankuasa As String, no_lantikan As String, txtTarikhMula As String, txtTarikhTamat As String, ddlPtj As String, ddlStaf As String, ddlJawatan As String)
        Dim db As New DBKewConn
        Dim kodPtj As String = ddlPtj + "0000"


        Dim query As String = "INSERT INTO SMKB_Perolehan_JawatankuasaDT(Kod_JawatanKuasa,No_Lantikan,TarikhKuatkuasa,TarikhTamat,KodPTj,No_Staf,Jawatan,Status)
        VALUES(@ddlKodJawatankuasa,@no_lantikan,@txtTarikhMula,@txtTarikhTamat,@ddlPtj,@ddlStaf,@ddlJawatan,1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ddlKodJawatankuasa", ddlKodJawatankuasa))
        param.Add(New SqlParameter("@no_lantikan", no_lantikan))
        param.Add(New SqlParameter("@txtTarikhMula", txtTarikhMula))
        param.Add(New SqlParameter("@txtTarikhTamat", txtTarikhTamat))
        param.Add(New SqlParameter("@ddlPtj", kodPtj))
        param.Add(New SqlParameter("@ddlStaf", ddlStaf))
        param.Add(New SqlParameter("@ddlJawatan", ddlJawatan))

        Return db.Process(query, param)
    End Function

    'Generate Nombor Bidaan
    Private Function GenerateNoLantikan(ddlKodJawatankuasa As String, ddlPtj As String, txtTarikhMula As String)
        Dim db As New DBKewConn


        Dim tarikhMula As DateTime = DateTime.Parse(txtTarikhMula)


        Dim year As Integer = Integer.Parse(tarikhMula.ToString("yy"))
        Dim month As Integer = tarikhMula.Month
        Dim day As Integer = tarikhMula.Day



        Dim newNoPO As String = ddlKodJawatankuasa & ddlPtj & "0000" & month.ToString() & day.ToString() & year.ToString()

        Return newNoPO
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodJawatanK(ByVal q As String, ByVal kod_jawatankuasa As String) As String

        Dim tmpDT As DataTable = GetKodJK(q, kod_jawatankuasa)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodJK(carian As String, kod_jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim where As String = ""
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(carian) Then
            where &= " AND text LIKE '%' + @carian + '%'"
            param.Add(New SqlParameter("@carian", carian))
        End If

        Dim query As String = "SELECT * FROM (
                                    SELECT Kod_Jawatankuasa + ' - ' + butiran AS text,
	                                 Kod_Jawatankuasa as value
                                     FROM
                                        smkb_perolehan_jawatankuasa
                                    WHERE
                                        Mod_Jawatankuasa = @kod 
                                ) mainTable
                                WHERE 1 = 1 " & where & "
                                order by text"


        param.Add(New SqlParameter("@kod", kod_jawatankuasa))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Senarai_Pelulus() As String
        Dim resp As New ResponseRepository

        dt = GetRecord_Pelulus()
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_Pelulus() As DataTable
        Dim db = New DBKewConn


        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY A.KodPTJ) AS Bil, 
                                A.Id_No,A.KodPTJ,A.KodPTJ + '0000' AS KodPTJ2,A.NoStaf,
                                CASE WHEN A.Status = 'true' THEN 'Aktif' ELSE 'Tidak Aktif' END AS Status,
                                (SELECT kodpejabat + '0000' + ' - ' + pejabat FROM VPejabat WHERE KodPejabat = A.KodPTJ) AS NamaPejabat,
                                (SELECT MS01_Nama FROM VPeribadi WHERE MS01_NoStaf = A.NoStaf) AS NamaStaf,  CONVERT(smallint, A.Status) as KodStatus
                            FROM SMKB_Perolehan_Pelulus_PTJ A
                            ORDER BY Bil"

        Return db.Read(query)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanPelulus(SavePelulus As PelulusHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        Dim msg As String = ""

        If SavePelulus Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(SavePelulus.ddlPtj) Then
            msg = "Sila pastikan Mod Jawatankuasa telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(SavePelulus.ddlStaf) Then
            msg += "Sila pastikan Kategori Jawatankuasa telah dipilih."
        End If

        If String.IsNullOrEmpty(SavePelulus.ddlStatus) Then
            msg += "Sila pastikan Nama Jawatankuasa telah diisi."
        End If

        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If InsertPelulus(SavePelulus.ddlPtj, SavePelulus.ddlStaf, SavePelulus.ddlStatus) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", SavePelulus)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPelulus(ddlPtj As String, ddlStaf As String, ddlStatus As String)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Perolehan_Pelulus_PTJ (KodPTJ, NoStaf, Status)
        VALUES(@ddlPtj,@ddlStaf,@ddlStatus)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ddlPtj", ddlPtj))
        param.Add(New SqlParameter("@ddlStaf", ddlStaf))
        param.Add(New SqlParameter("@ddlStatus", ddlStatus))


        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateAhliJawatan(UpdateAhli As PelulusHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim msg As String = ""

        If UpdateAhli Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(UpdateAhli.ddlPtj) Then
            msg = "Sila pastikan maklumat PTJ telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(UpdateAhli.ddlStaf) Then
            msg += "Sila pastikan maklumat Staf telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(UpdateAhli.ddlStatus) Then
            msg += "Sila pastikan maklumat Status telah dipilih. <br/>"
        End If


        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If UpdateAhliJawatanKuasa(UpdateAhli.ddlPtj, UpdateAhli.ddlStaf, UpdateAhli.ddlStatus, UpdateAhli.txtIdNo) <> "OK" Then
            resp.Failed("Gagal Mengemaskini Maklumat")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        resp.Success("Rekod berjaya dikemaskini", "00", UpdateAhli)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function UpdateAhliJawatanKuasa(ddlPtj As String, ddlStaf As String, ddlStatus As String, txtIdNo As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Pelulus_PTJ SET KodPTJ = @ddlPtj, NoStaf = @ddlStaf, Status = @ddlStatus 
        WHERE Id_No = @txtNoId "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@ddlPtj", ddlPtj))
        param.Add(New SqlParameter("@ddlStaf", ddlStaf))
        param.Add(New SqlParameter("@ddlStatus", ddlStatus))
        param.Add(New SqlParameter("@txtNoId", txtIdNo))

        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateAJKDetail(SaveUpdateAhli As UpdateAhJKHeader) As String

        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim msg As String = ""

        If SaveUpdateAhli Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If String.IsNullOrEmpty(SaveUpdateAhli.txtTarikhMulaR) Then
            msg = "Sila pastikan tarikh mula telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveUpdateAhli.txtTarikhTamatR) Then
            msg += "Sila pastikan tarikh tamat telah diisi. <br/>"
        End If

        If String.IsNullOrEmpty(SaveUpdateAhli.ddlPtjR) Then
            msg += "Sila pastikan maklumat PTJ telah dipilih. <br/>"
        End If

        If String.IsNullOrEmpty(SaveUpdateAhli.ddlStafR) Then
            msg += "Sila pastikan maklumat staf telah dipilih. <br/>"
        End If


        If String.IsNullOrEmpty(SaveUpdateAhli.ddlJawatanR) Then
            msg += "Sila pastikan maklumat jawatan telah dipilih. <br/>"
        End If


        If String.IsNullOrEmpty(msg) = False Then
            resp.Failed(msg)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If QueryUpdateAJKDetail(SaveUpdateAhli.txtTarikhMulaR, SaveUpdateAhli.txtTarikhTamatR, SaveUpdateAhli.ddlPtjR, SaveUpdateAhli.ddlStafR, SaveUpdateAhli.ddlJawatanR, SaveUpdateAhli.noLantikanR, SaveUpdateAhli.id) <> "OK" Then
            resp.Failed("Gagal Mengemaskini Maklumat")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        resp.Success("Rekod berjaya dikemaskini", "00", SaveUpdateAhli)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function QueryUpdateAJKDetail(txtTarikhMulaR As String, txtTarikhTamatR As String, ddlPtjR As String, ddlStafR As String, ddlJawatanR As String, noLantikanR As String, id As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_JawatankuasaDT SET TarikhKuatkuasa = @txtTarikhMulaR, TarikhTamat = @txtTarikhTamatR, Jawatan= @ddlJawatanR
        WHERE ID = @id "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtTarikhMulaR", txtTarikhMulaR))
        param.Add(New SqlParameter("@txtTarikhTamatR", txtTarikhTamatR))
        param.Add(New SqlParameter("@ddlJawatanR", ddlJawatanR))
        param.Add(New SqlParameter("@id", id))


        Return db.Process(query, param)
    End Function
End Class