Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data.SqlClient
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports SMKB_Web_Portal.Luar_Negara
Imports iTextSharp.text

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class LuarNegara1_WS
    Inherits System.Web.Services.WebService
    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fnCariStaf(ByVal q As String) As String


        Dim tmpDT As DataTable = GetListStaf(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetListStaf(kodPjbt As String) As DataTable
        Dim db = New DBSMConn
        kodPjbt = "41"
        Dim query As String = "SELECT  MS01_NoStaf as StafNo, MS01_Nama , MS08_Pejabat, JawGiliran, right(MS02_GredGajiS,2) as GredGaji
                    FROM VK_AdvClm "

        Dim param As New List(Of SqlParameter)

        If kodPjbt <> "" Then

            query &= "WHERE MS08_Pejabat = @kodPjbt  AND RIGHT(MS02_GredGajiS,2) >='41' "
            param.Add(New SqlParameter("@kodPjbt", kodPjbt))

        End If

        Return db.Read(query, param)

    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetUserInfo(nostaf As String)
        Dim db As New DBSMConn
        Dim query As String = $"Select a.MS01_NoStaf As StafNo, a.MS01_Nama As Param1, a.MS08_Pejabat As Param2, a.JawGiliran As Param3, a.Kumpulan As Param4, 
                                a.Singkatan as Param5, a.MS02_GredGajiS As Param6, Right(a.MS02_GredGajiS, 2) As GredGaji, 
                                a.MS02_JumlahGajiS, a.MS01_TelPejabat As Param7, a.MS02_Kumpulan, b.KodPBU as KodPejPemohon
                                From VK_AdvClm As a INNER Join MS_PejabatPBU As b On a.MS08_Pejabat = b.KodPejabat  
                                Where a.MS01_NoStaf = '{nostaf}' AND b.StatusPTJ=1"



        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecord_PermohonanPP(staffP As String) As String
        Dim resp As New ResponseRepository

        'If isClicked = False Then
        '    Return JsonConvert.SerializeObject(New DataTable)
        'End If

        dt = GetRecord_SenaraiSendiriPP(staffP)



        'dt = GetRecord_SenaraiSendiri(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_SenaraiSendiriPP(staffP As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT  No_Pendahuluan, No_Staf, Jenis_Pendahuluan,Tujuan, Jum_Lulus, isnull(No_Baucar,'-') as No_Baucar
                            FROM  SMKB_Pendahuluan_Hdr
                            WHERE (Jenis_Pendahuluan = 'PP') AND  No_Staf = @staffP "


        Dim param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@staffP", staffP))
        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisTugas(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisTugas(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisTugas(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  FROM   
                    SMKB_Lookup_Detail WHERE Kod='AC04' AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail='K' OR Kod_Detail='R' AND 
                        Butiran like 'Rasmi%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListPerjalanan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataKenyataan(id)

        For Each x As DataRow In dt.Rows
            If Not IsDBNull(x.Item("Nama_Fail_LampiranA")) Then
                Dim url As String = GetBaseUrl() + Trim(x.Item("Path_LampiranA")) + "/" + x.Item("Nama_Fail_LampiranA")
                x.Item("Path_LampiranA") = url
            End If
        Next
        Return JsonConvert.SerializeObject(dt)

        'dt = GetDataKenyataan(id)
        'resp.SuccessPayload(dt)

        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetDataKenyataan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.Bil, FORMAT(a.Tarikh, 'yyyy-MM-dd') AS Tarikh, a.Masa_Bertolak, 
                a.Negara,c.Negara, a.Bandar_LN, a.Jenis_Tugas_LN,b.Butiran,FORMAT(a.Tarikh_Tiba, 'yyyy-MM-dd') as Tarikh_Tiba, 
                SUBSTRING(CONVERT(varchar, a.Masa_Bertolak, 108), 1, 2) AS jamTolak,d.Path_LampiranA, d.Nama_Fail_LampiranA, Nama_Fail_LampiranA as url,
                SUBSTRING(CONVERT(varchar, a.Masa_Bertolak,108), 4, 2) AS minitTolak, a.Masa_Sampai, 
                SUBSTRING(CONVERT(varchar, a.Masa_Sampai, 108), 1, 2) AS jamSampai, 
                SUBSTRING(CONVERT(varchar, a.Masa_Sampai, 108), 4, 2) AS minitSampai, a.No_Tuntutan, FORMAT(d.Tarikh_Mohon, 'yyyy-MM-dd') as Tarikh_Mohon
                FROM  SMKB_Tuntutan_Dlm_Kenyataan AS a INNER JOIN 
                SMKB_Tuntutan_Hdr as d ON a.No_Tuntutan = d.No_Tuntutan INNER JOIN
                SMKB_Lookup_Detail as b ON a.Jenis_Tugas_LN = b.Kod_Detail INNER JOIN
                SMKB_CLM_Kump_Negara as c ON a.Negara = c.Negara
                WHERE  (a.No_Tuntutan = @No_Permohonan) AND b.Kod='AC04' AND b.status=1
                ORDER BY a.Bil"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Permohonan", id))
        dt = db.Read(query, param)
        Return dt

        'Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataKenderaan(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataKenderaanPjln(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataKenderaanPjln(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT No_Staf, No_Kenderaan as value,No_Kenderaan as text, Jenis_Kenderaan FROM SMKB_Tuntutan_Dftr_Kenderaan "
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " WHERE (No_Staf LIKE '%' + @kod + '%' ) "
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@kod", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordTuntutan(listClaim As MhnLuarNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If listClaim Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If listClaim.OrderID = "" Then 'untuk permohonan baru
            listClaim.OrderID = GenerateOrderID()

            If InsertNewOrder(listClaim) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
            End If
        Else 'untuk permohonan sedia ada

            If UpdateNewOrder(listClaim) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If
        End If


        'If UpdateStatusDokOrder_Mohon(listClaim, "Y") <> "OK" Then

        '    'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order YX
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        '    ' Exit Function

        'End If


        resp.Success("Rekod berjaya disimpan", "00", listClaim)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    'Private Function UpdateStatusDokOrder_Mohon(listClaim As MhnLuarNegara, statusLulus As String)
    '    Dim db As New DBKewConn

    '    Dim kodstatusLulus As String

    '    If statusLulus = "Y" Then
    '        kodstatusLulus = "02"
    '    End If

    '    Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
    '			VALUES
    '			(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@Kod_Modul", "04"))
    '    param.Add(New SqlParameter("@Kod_Status_Dok", "01"))
    '    param.Add(New SqlParameter("@No_Rujukan", listClaim.OrderID))
    '    param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
    '    param.Add(New SqlParameter("@Status_Transaksi", 1))
    '    param.Add(New SqlParameter("@Status", 1))
    '    param.Add(New SqlParameter("@Ulasan", "-"))

    '    Return db.Process(query, param)

    'End Function
    Private Function UpdateNewOrder(listClaim As MhnLuarNegara)

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET 
            Bulan_Tuntut = @Bulan_Tuntut, Tahun_Tuntut = @Tahun_Tuntut, No_Pendahuluan = @No_Pendahuluan, 
            Jum_Pendahuluan = @Jum_Pendahuluan, Kod_Kump_Wang = @Kod_Kump_Wang , Kod_Operasi = @Kod_Operasi, Kod_Projek = @Kod_Projek, 
            Kod_PTJ = @Kod_PTJ, Sebab_Lewat = @Sebab_Lewat,  Tkh_Bertolak = @Tkh_Bertolak, Bertolak_Dari = @Bertolak_Dari, 
            Masa_Bertolak = Masa_Bertolak, Tujuan_Tuntutan=@Tujuan_Tuntutan
            WHERE No_Tuntutan = @No_Tuntutan"

        If listClaim.jumlahBaucer = "" Then
            listClaim.jumlahBaucer = 0
        End If

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listClaim.OrderID))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Sebab_Lewat", listClaim.sebabLewat))
        param.Add(New SqlParameter("@Bulan_Tuntut", listClaim.Bulan))
        param.Add(New SqlParameter("@Tahun_Tuntut", listClaim.Tahun))
        param.Add(New SqlParameter("@Jenis_Tuntutan", "LN"))
        param.Add(New SqlParameter("@No_Pendahuluan", listClaim.noPendahuluan))
        param.Add(New SqlParameter("@Status_Dok", "02"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@Jum_Pendahuluan", listClaim.jumlahBaucer))
        param.Add(New SqlParameter("@Kod_Kump_Wang", listClaim.KumpWang))
        param.Add(New SqlParameter("@Kod_Operasi", listClaim.KodOperasi))
        param.Add(New SqlParameter("@Kod_Projek", listClaim.KodProjek))
        param.Add(New SqlParameter("@Kod_PTJ", listClaim.KodPtj))
        param.Add(New SqlParameter("@Id_Mohon", Session("ssusrID")))
        param.Add(New SqlParameter("@Pengesahan_Pemohon", listClaim.staPemohon))
        param.Add(New SqlParameter("@Tkh_Bertolak", listClaim.TkhTolak))
        param.Add(New SqlParameter("@Bertolak_Dari", listClaim.BertolakDari))
        param.Add(New SqlParameter("@Masa_Bertolak", listClaim.MasaBertolak))
        param.Add(New SqlParameter("@Tujuan_Tuntutan", listClaim.Tujuan))

        Return db.Process(query, param)
    End Function
    Private Function GenerateOrderID() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='09' AND Prefix ='CL' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("09", "CL", year, lastID)
        Else

            InsertNoAkhir("09", "CL", year, lastID)
        End If
        newOrderID = "CL" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newOrderID
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
        param.Add(New SqlParameter("@Butiran", "Tuntutan Luar Negara"))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))


        Return db.Process(query, param)
    End Function

    Private Function InsertNewOrder(listClaim As MhnLuarNegara)
        Dim db As New DBKewConn
        'Dim year = Date.Now.ToString("yyyy")
        'Dim month = Date.Now.Month
        'Dim blnTuntut = month + "/" + year

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Hdr (No_Tuntutan, No_Staf, PTj, Tarikh_Mohon, Bulan_Tuntut,Tahun_Tuntut, Jenis_Tuntutan, 
                    No_Pendahuluan, Status_Dok, Status,  Jum_Pendahuluan, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, Kod_PTJ,  
                    ID_Mohon, Pengesahan_Pemohon, Akuan_Pemohon, Sebab_Lewat,Tkh_Bertolak, Bertolak_Dari, Masa_Bertolak,Tujuan_Tuntutan)
                    VALUES (@No_Tuntutan, @No_Staf, @PTj, @Tarikh_Mohon,  @Bulan_Tuntut, @Tahun_Tuntut, 
                    @Jenis_Tuntutan, @No_Pendahuluan, @Status_Dok, @Status, @Jum_Pendahuluan, @Kod_Kump_Wang, @Kod_Operasi, @Kod_Projek,@Kod_PTJ,
                    @ID_Mohon, @Pengesahan_Pemohon, @Akuan_Pemohon,@Sebab_Lewat,@Tkh_Bertolak,@Bertolak_Dari, @Masa_Bertolak, @Tujuan_Tuntutan)"
        If listClaim.jumlahBaucer = 0.00 Then
            listClaim.jumlahBaucer = 0
        End If


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listClaim.OrderID))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@PTj", listClaim.hidPtjPemohon))
        param.Add(New SqlParameter("@Tarikh_Mohon", listClaim.TkhMohon))
        param.Add(New SqlParameter("@Sebab_Lewat", listClaim.sebabLewat))
        param.Add(New SqlParameter("@Bulan_Tuntut", listClaim.Bulan))
        param.Add(New SqlParameter("@Tahun_Tuntut", listClaim.Tahun))
        param.Add(New SqlParameter("@Jenis_Tuntutan", "LN"))
        param.Add(New SqlParameter("@No_Pendahuluan", listClaim.noPendahuluan))
        param.Add(New SqlParameter("@Status_Dok", "02"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@Jum_Pendahuluan", listClaim.jumlahBaucer))
        param.Add(New SqlParameter("@Kod_Kump_Wang", listClaim.KumpWang))
        param.Add(New SqlParameter("@Kod_Operasi", listClaim.KodOperasi))
        param.Add(New SqlParameter("@Kod_Projek", listClaim.KodProjek))
        param.Add(New SqlParameter("@Kod_PTJ", listClaim.KodPtj))
        param.Add(New SqlParameter("@Id_Mohon", Session("ssusrID")))
        param.Add(New SqlParameter("@Pengesahan_Pemohon", listClaim.staPemohon))
        param.Add(New SqlParameter("@Tkh_Bertolak", listClaim.TkhTolak))
        param.Add(New SqlParameter("@Bertolak_Dari", listClaim.BertolakDari))
        param.Add(New SqlParameter("@Masa_Bertolak", listClaim.MasaBertolak))
        param.Add(New SqlParameter("@Tujuan_Tuntutan", listClaim.Tujuan))
        param.Add(New SqlParameter("@Akuan_Pemohon", "1"))



        Return db.Process(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PermohonanSendiri(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime, staffP As String) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetRecord_SenaraiSendiri(category_filter, tkhMula, tkhTamat, staffP)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_SenaraiSendiri(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, staffP As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param = New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = "and a.No_Staf = @staffP and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -2, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = "and a.No_Staf = @staffP and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and a.No_Staf = @staffP  and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.No_Staf = @staffP and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.No_Staf = @staffP and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.No_Staf = @staffP  and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If


        Dim query As String = "SELECT a.No_Tuntutan, a.Tujuan_Tuntutan,  a.PTj, a.Bulan_Tuntut, a.Tahun_Tuntut, a.Status, a.No_Pendahuluan,
                FORMAT(a.Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon,  isnull(a.Jum_Pendahuluan,'0.00') as Jum_Pendahuluan,                      
                a.Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang as kw where a.Kod_Kump_Wang = kw.Kod_Kump_Wang) as colKW,
                a.Kod_Operasi, (select Butiran from SMKB_Operasi as ko where  ko.Kod_Operasi = a.Kod_Operasi) as colKO,
                a.Kod_Projek,  (select Butiran from SMKB_Projek as kp where kp.Kod_Projek = a.Kod_Projek) as colKp,
                a.Kod_PTJ, (SELECT b.Pejabat FROM vPEJABAT as b WHERE b.STATUS = 1 and b.kodpejabat = a.PTJ)as ButiranPTJ ,
                 a.Status_Dok,a.Tujuan_Tuntutan,FORMAT(a.Tkh_Bertolak, 'yyyy-MM-dd') AS Tkh_Bertolak, a.Bertolak_Dari, a.Masa_Bertolak,
                substring(CONVERT(varchar,a.Masa_Bertolak,108),1,2) as jamSampai, substring(CONVERT(varchar,a.Masa_Bertolak,108),4,2) as minitSampai,
                b.Butiran, a.No_Staf + ' - ' + c.ms01_nama   as NamaPemohon, a.No_Staf as Nopemohon
                FROM SMKB_Tuntutan_Hdr as a INNER JOIN 
                SMKB_Kod_Status_Dok AS b ON a.Status_Dok = b.Kod_Status_Dok INNER JOIN
                vPeribadi as c ON a.No_Staf = c.ms01_noStaf
                WHERE  (b.Kod_Modul = '09') AND (b.Kod_Status_Dok = '02') AND (a.Jenis_Tuntutan ='LN')  " & tarikhQuery & " order by a.Tarikh_Mohon desc"
        ' WHERE a.Status_Dok='01' AND a.Pengesahan_Pemohon='0' " & tarikhQuery & " order by a.Tarikh_Mohon desc"

        param.Add(New SqlParameter("@staffP", staffP))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisNegaraRegisteredToPerjalanan(ByVal q As String, ByVal nomohon As String) As String

        Dim tmpDT As DataTable = GetDataNegaraToPerjalanan(q, nomohon)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataNegaraToPerjalanan(kod As String, nomohon As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT No_Tuntutan, Negara as value, Negara as text 
            FROM  SMKB_Tuntutan_Dlm_Kenyataan WHERE No_Tuntutan= @No_Tuntutan "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", nomohon))
        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisNegara(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataNegara(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataNegara(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT   Negara as value, Negara as text FROM SMKB_CLM_Kump_Negara "
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "WHERE (Negara LIKE '%' + @kod + '%' OR  Negara LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetMataWangByNegara(ByVal q As String, ByVal negara As String) As String


        Dim tmpDT As DataTable = GetDataMatawangNegaraSelect(q, negara)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataMatawangNegaraSelect(kod As String, negara As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Negara, Matawang as text, Matawang as value FROM SMKB_CLM_Matawang WHERE Negara = @negara "
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@negara", negara))



        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetMataWang(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataMatawang(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataMatawang(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT  id +' - ' + Matawang AS text, Matawang AS value FROM  SMKB_CLM_Matawang "
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "WHERE (id LIKE '%' + @kod + '%' OR  Matawang LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJnsTugas(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisTugasEM(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisTugasEM(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  FROM   
                    SMKB_Lookup_Detail WHERE Kod='AC04' AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail='K' OR Kod_Detail='R' AND 
                        Butiran like 'Rasmi%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisTugasTblSewaHotel(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisTugasTblHotel(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisTugasTblHotel(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  FROM   
                    SMKB_Lookup_Detail WHERE Kod='AC04' AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail='K' OR Kod_Detail='R' AND 
                        Butiran like 'Rasmi%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTempatTblHotel(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataTempatTblHotel(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataTempatTblHotel(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  
        FROM   SMKB_Lookup_Detail WHERE (Kod = 'AC03') AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail ='H' OR Kod_Detail='L' AND 
                        Butiran like 'Hotel%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordKenyataan(kenyataan As MhnLuarNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim savePath As String = ""
        Dim folder As String = ""
        Dim postedFile As HttpPostedFile = Nothing
        Dim returnURL As String = ""
        Dim fileName As String = ""

        'Check if File is available.
        If HttpContext.Current.Request.Files.Count > 0 Then
            postedFile = HttpContext.Current.Request.Files(0)
        End If

        If postedFile IsNot Nothing Then
            fileName = postedFile.FileName

            If kenyataan.File_Name <> "" Then

                If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & kenyataan.OrderID) Then
                    System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & kenyataan.OrderID)
                End If

                ' Specify the file path where you want to save the uploaded file
                savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & kenyataan.OrderID & "/" & kenyataan.File_Name)
                folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & kenyataan.OrderID
                kenyataan.Folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & kenyataan.OrderID


                ' Save the file to the specified path
                postedFile.SaveAs(savePath)


                simpanLampiranA(kenyataan)
            End If
        End If





        For Each listKenyataan As tblKenyataanLN In kenyataan.GroupKenyataanLN

            If listKenyataan.JnsNegara = "" Then
                Continue For
            End If

            JumRekod += 1

            If listKenyataan.mohonID <> "" Then

                If semakdataKeperluan(listKenyataan.mohonID, listKenyataan.idbil) = "wujud" Then
                    'updateDataKeperluan--
                    If UpdateOrderDetail(listKenyataan) = "OK" Then
                        success += 1

                    End If
                Else
                    'insert Data Keperluan
                    listKenyataan.idbil = GenerateOrderDetailID(listKenyataan.mohonID)
                    listKenyataan.mohonID = kenyataan.OrderID
                    kenyataan.Folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/"
                    If InsertDataItem(listKenyataan) = "OK" Then
                        success += 1

                    End If
                End If
            Else

            End If
        Next




        resp.Success("Rekod berjaya disimpan", "00", kenyataan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function simpanLampiranA(kenyataan As MhnLuarNegara)
        Dim db As New DBKewConn

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & kenyataan.OrderID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & kenyataan.OrderID)
        End If

        kenyataan.Folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & kenyataan.OrderID

        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Nama_Fail_LampiranA = @Nama_Fail_LampiranA, Path_LampiranA = @Path_LampiranA                                
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", kenyataan.OrderID))
        param.Add(New SqlParameter("@Path_LampiranA", kenyataan.Folder))
        param.Add(New SqlParameter("@Nama_Fail_LampiranA", kenyataan.File_Name))


        Return db.Process(query, param)
    End Function


    Private Function InsertDataItem(listKenyataan As tblKenyataanLN)
        Dim db As New DBKewConn

        Dim masaMula As String
        Dim masaTamat As String

        masaMula = listKenyataan.MasaTolakJam + ":" + listKenyataan.MasaTolakMinit

        masaTamat = listKenyataan.MasaSampaiJam + ":" + listKenyataan.MasaSampaiMinit

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dlm_Kenyataan (No_Tuntutan, Bil, Tarikh, Masa_Bertolak, 
                            Masa_Sampai,Tarikh_Tiba, Negara,Bandar_LN, Jenis_Tugas_LN)
                            VALUES(@NoTuntutan, @bil,@tkhMula, @MasaMula, @MasaTamat, @Tarikh_Tiba, @Negara, @Bandar_LN, @Jenis_Tugas_LN)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@NoTuntutan", listKenyataan.mohonID))
        param.Add(New SqlParameter("@bil", listKenyataan.idbil))
        param.Add(New SqlParameter("@tkhMula", listKenyataan.tarikhTolak))
        param.Add(New SqlParameter("@MasaMula", masaMula))
        param.Add(New SqlParameter("@MasaTamat", masaTamat))
        param.Add(New SqlParameter("@Tarikh_Tiba", listKenyataan.tarikhTolak))
        param.Add(New SqlParameter("@Jenis_Tugas_LN", listKenyataan.JnsTugas))
        param.Add(New SqlParameter("@Negara", listKenyataan.JnsNegara))
        param.Add(New SqlParameter("@Bandar_LN", listKenyataan.Bandar))


        Return db.Process(query, param)
    End Function
    Private Function GenerateOrderDetailID(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 Bil as id
        from SMKB_Tuntutan_Dlm_Kenyataan 
        where No_Tuntutan = @itemId
        ORDER BY id DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function

    Private Function UpdateOrderDetail(listKenyataan As tblKenyataanLN)
        Dim db = New DBKewConn
        Dim masaMula As String
        Dim masaTamat As String

        masaMula = listKenyataan.MasaTolakJam + ":" + listKenyataan.MasaTolakMinit
        masaTamat = listKenyataan.MasaSampaiJam + ":" + listKenyataan.MasaSampaiMinit

        Dim query As String = "UPDATE SMKB_Tuntutan_Dlm_Kenyataan
        set  Tarikh = @tkhMula, Masa_Bertolak = @MasaMula, Tarikh_Tiba = @Tarikh_Tiba,
        Masa_Sampai = @MasaTamat, Negara = @Negara,Bandar_LN = @Bandar_LN, Jenis_Tugas_LN=@Jenis_Tugas_LN
        where No_Tuntutan = @NoTuntutan  AND Bil = @bil"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoTuntutan", listKenyataan.mohonID))
        param.Add(New SqlParameter("@bil", listKenyataan.idbil))
        param.Add(New SqlParameter("@tkhMula", listKenyataan.tarikhTolak))
        param.Add(New SqlParameter("@MasaMula", masaMula))
        param.Add(New SqlParameter("@MasaTamat", masaTamat))
        param.Add(New SqlParameter("@Tarikh_Tiba", listKenyataan.tarikhTolak))
        param.Add(New SqlParameter("@Jenis_Tugas_LN", listKenyataan.JnsNegara))
        param.Add(New SqlParameter("@Negara", listKenyataan.JnsNegara))
        param.Add(New SqlParameter("@Bandar_LN", listKenyataan.Bandar))
        param.Add(New SqlParameter("@NoTuntutan", listKenyataan.mohonID))
        param.Add(New SqlParameter("@Bil", listKenyataan.idbil))

        Return db.Process(query, param)
    End Function
    Private Function semakdataKeperluan(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT   No_Tuntutan, Bil FROM SMKB_Tuntutan_Dlm_Kenyataan WHERE No_Tuntutan=@mohonID AND Bil=@id"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@id", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataElaunMakan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordElaunMakan(id)

        resp.SuccessPayload(dt)

        If dt.Rows.Count = 0 Then
            resp.SuccessPayload(New DataTable())
        End If
        Return JsonConvert.SerializeObject(resp.GetResult())
        'Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function CallRecordElaunMakan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT ROW_NUMBER() OVER(ORDER BY a.No_Tuntutan) as listItem, a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,
                                b.Bil_Hari,b.Jenis_Tugas,
                                CASE WHEN b.Flag_Mkn_Pagi = 1 THEN 'Disediakan' else 'Tidak' END AS Flag_Mkn_Pagi, 
                                CASE WHEN b.Flag_Mkn_Tghari = 1 THEN 'Disediakan' else 'Tidak' END AS Flag_Mkn_Tghari,
                                CASE WHEN b.Flag_Mkn_Mlm = 1 THEN 'Disediakan' else 'Tidak' END AS Flag_Mkn_Mlm, 
                                b.Flag_Elaun_Harian,b.Kadar_Pertukaran,b.Matawang,
                                b.Kadar_Harga,  b.Jumlah_anggaran,
                                h.Butiran as JenisTugas, FORMAT(a.Tarikh_Mohon, 'yyyy-MM-dd') as Tarikh_Mohon
                                FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
                                SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN 
                                SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas
                                WHERE h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EM' AND a.No_Tuntutan = @No_Tuntutan
                                ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    Function GetDataFromVariable(ByVal val, Optional def = Nothing)
        If val = Nothing And def Is Nothing Then
            Return DBNull.Value
        End If

        If def IsNot Nothing Then
            Return def
        End If

        Return val
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordElaunMakan(itemElaunMakan As MhnLuarNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim folder As String = ""
        Dim postedFile As HttpPostedFile = Nothing
        Dim returnURL As String = ""
        Dim fileName As String = ""
        Dim savePath As String = ""

        'Check if File is available.
        If HttpContext.Current.Request.Files.Count > 0 Then
            postedFile = HttpContext.Current.Request.Files(0)
        End If


        For Each listElaunMakan As ElaunMakanLN In itemElaunMakan.GroupElaunMakan
            Dim tesdt = listElaunMakan.EM_hidID
            GetDataFromVariable(listElaunMakan.EM_hidID)



            If itemElaunMakan Is Nothing Then
                resp.Failed("Tiada simpan")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If



            If listElaunMakan.EM_hidID Is Nothing Then 'untuk permohonan baru
                listElaunMakan.EM_hidID = GenerateOrderIDElaunMakan(listElaunMakan.EM_mohonID)
                If listElaunMakan.EM_staTransit <> True Then
                    If InsertDataElaunMakan(listElaunMakan) <> "OK" Then
                        'If InsertNewOrder(AdvList) <> "OK" Then
                        resp.Failed("Gagal Menyimpan order 1266")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If
                Else
                    If InsertDataElaunMakanTransit(listElaunMakan) <> "OK" Then
                        resp.Failed("Gagal Menyimpan order 1266")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                    End If
                End If
                'If InsertDataElaunMakan(listElaunMakan) <> "OK" Then
                '    'If InsertNewOrder(AdvList) <> "OK" Then
                '    resp.Failed("Gagal Menyimpan order 1266")
                '    Return JsonConvert.SerializeObject(resp.GetResult())
                'End If
            Else 'untuk permohonan sedia ada
                If UpdateDataElaunMakan(listElaunMakan) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    ' Exit Function
                End If
            End If
        Next

        If UpdateTotalElaunMakan(itemElaunMakan) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If


        resp.Success("Rekod berjaya disimpan", "00", itemElaunMakan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GenerateOrderIDElaunMakan(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='EM'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function

    Private Function UpdateTotalElaunMakan(itemElaunMakan As MhnLuarNegara)
        Dim db = New DBKewConn
        Dim strJumlah As Decimal
        Dim query As String

        query = $"SELECT ISNULL(sum(Jumlah_anggaran),0) as harga
                        FROM SMKB_Tuntutan_Dtl 
                        WHERE Jns_Dtl_Tuntutan='EM' AND No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", itemElaunMakan.OrderID))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            strJumlah = dt.Rows(0).Item("harga")
        Else

            strJumlah = 0.00
        End If



        query = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Elaun_Mkn = @Jumlah_Elaun_Mkn                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim paramU As New List(Of SqlParameter)
        paramU.Add(New SqlParameter("@No_Tuntutan", itemElaunMakan.OrderID))
        paramU.Add(New SqlParameter("@Jumlah_Elaun_Mkn", strJumlah))

        Return db.Process(query, paramU)
    End Function
    Private Function InsertDataElaunMakan(listElaunMakan As ElaunMakanLN)
        Dim db As New DBKewConn
        Dim masaMula As String
        Dim masaTamat As String
        Dim fileName As String = ""
        Dim savePath As String = ""
        Dim folder As String = ""

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & listElaunMakan.EM_mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & listElaunMakan.EM_mohonID)
        End If

        ' Specify the file path where you want to save the uploaded file
        savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & listElaunMakan.EM_mohonID & "/" & listElaunMakan.EM_File_Name)
        folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & listElaunMakan.EM_mohonID
        listElaunMakan.EM_Folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & listElaunMakan.EM_mohonID

        masaMula = listElaunMakan.EM_JamMula + ":" + listElaunMakan.EM_MinitMula
        masaTamat = listElaunMakan.EM_JamSampai + ":" + listElaunMakan.EM_MinitSampai

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl(No_Tuntutan, Jns_Dtl_Tuntutan,No_Item, Jenis_Tugas, Negara, Matawang,Kadar_Pertukaran,
                        Tkh_Mula_LN, Tkh_Akhir_LN, Jam_Mula_LN, Jam_Akhir_LN,
                        Flag_Mkn_Pagi, Flag_Mkn_Tghari,Flag_Mkn_Mlm, Flag_Elaun_Harian, Bil_Hari, Kadar_Harga, Jumlah_anggaran,Nama_Fail,Path)
                        VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Tugas,@Negara, @Matawang,@Kadar_Pertukaran,
                        @Tkh_Mula_LN, @Tkh_Akhir_LN, @Jam_Mula_LN, @Jam_Akhir_LN,
                        @Flag_Mkn_Pagi, @Flag_Mkn_Tghari, @Flag_Mkn_Mlm, @Flag_Elaun_Harian,
                        @Bil_Hari, @Kadar_Harga, @Jumlah_anggaran,@Nama_Fail,@Path)"

        GetDataFromVariable(listElaunMakan.EM_StaElaunHarian, "0")
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listElaunMakan.EM_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EM"))
        param.Add(New SqlParameter("@No_Item", listElaunMakan.EM_hidID))
        param.Add(New SqlParameter("@Jenis_Tugas", listElaunMakan.EM_JnsTugas))
        param.Add(New SqlParameter("@Negara", listElaunMakan.EM_Negara))
        param.Add(New SqlParameter("@Matawang", listElaunMakan.EM_MataWang))
        param.Add(New SqlParameter("@Kadar_Pertukaran", listElaunMakan.EM_KadarMWang))
        param.Add(New SqlParameter("@Tkh_Mula_LN", listElaunMakan.EM_TkhMula))
        param.Add(New SqlParameter("@Tkh_Akhir_LN", listElaunMakan.EM_TkhAkhir))
        param.Add(New SqlParameter("@Jam_Mula_LN", masaMula))
        param.Add(New SqlParameter("@Jam_Akhir_LN", masaTamat))
        param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMakan.EM_MknPagi))
        param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMakan.EM_MknTghri))
        param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMakan.EM_MknMlm))
        param.Add(New SqlParameter("@Flag_Elaun_Harian", listElaunMakan.EM_StaElaunHarian))
        param.Add(New SqlParameter("@Bil_Hari", listElaunMakan.EM_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", listElaunMakan.EM_HargaElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMakan.EM_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", listElaunMakan.EM_File_Name))
        param.Add(New SqlParameter("@Path", listElaunMakan.EM_Folder))


        Return db.Process(query, param)
    End Function

    Private Function InsertDataElaunMakanTransit(listElaunMakan As ElaunMakanLN)
        Dim db As New DBKewConn
        Dim masaMula As String
        Dim masaTamat As String
        Dim masaTiba As String
        Dim masaBertolak As String

        masaMula = listElaunMakan.EM_JamMula + ":" + listElaunMakan.EM_MinitMula
        masaTamat = listElaunMakan.EM_JamSampai + ":" + listElaunMakan.EM_MinitSampai
        masaTiba = listElaunMakan.EM_JamTTiba + ":" + listElaunMakan.EM_MinitTTiba
        masaBertolak = listElaunMakan.EM_JamTTolak + ":" + listElaunMakan.EM_MinitTTolak

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl(No_Tuntutan, Jns_Dtl_Tuntutan,No_Item,  Jenis_Tugas, Negara, Matawang,Kadar_Pertukaran,
                        Tkh_Mula_LN,Tkh_Akhir_LN,Tkh_Bertolak_LN,Tkh_Tiba_LN,Jam_Mula_LN,Jam_Akhir_LN,Jam_Bertolak_LN,Jam_Tiba_LN,
                      Flag_Mkn_Pagi, Flag_Mkn_Tghari,Flag_Mkn_Mlm, Flag_Elaun_Harian, Bil_Hari, Kadar_Harga, Jumlah_anggaran)
                     VALUES(@No_Tuntutan, @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Tugas,@Negara, @Matawang,@Kadar_Pertukaran,
                    @Tkh_Mula_LN, @Tkh_Akhir_LN, @Tkh_Bertolak_LN, @Tkh_Tiba_LN, @Jam_Mula_LN, @Jam_Akhir_LN, @Jam_Bertolak_LN, @Jam_Tiba_LN,
                    @Flag_Mkn_Pagi, @Flag_Mkn_Tghari, @Flag_Mkn_Mlm, @Flag_Elaun_Harian,
                    @Bil_Hari,@Kadar_Harga, @Jumlah_anggaran)"

        GetDataFromVariable(listElaunMakan.EM_StaElaunHarian, "0")
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listElaunMakan.EM_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EM"))
        param.Add(New SqlParameter("@No_Item", listElaunMakan.EM_hidID))
        param.Add(New SqlParameter("@Jenis_Tugas", listElaunMakan.EM_JnsTugas))
        param.Add(New SqlParameter("@Negara", listElaunMakan.EM_Negara))
        param.Add(New SqlParameter("@Matawang", listElaunMakan.EM_MataWang))
        param.Add(New SqlParameter("@Kadar_Pertukaran", listElaunMakan.EM_KadarMWang))
        param.Add(New SqlParameter("@Tkh_Mula_LN", listElaunMakan.EM_TkhMula))
        param.Add(New SqlParameter("@Tkh_Akhir_LN", listElaunMakan.EM_TkhAkhir))
        param.Add(New SqlParameter("@Tkh_Tiba_LN", listElaunMakan.EM_TkhTransit))
        param.Add(New SqlParameter("@Tkh_Bertolak_LN", listElaunMakan.EM_TkhTransitTolak))
        param.Add(New SqlParameter("@Jam_Mula_LN", masaMula))
        param.Add(New SqlParameter("@Jam_Akhir_LN", masaTamat))
        param.Add(New SqlParameter("@Jam_Bertolak_LN", masaBertolak))
        param.Add(New SqlParameter("@Jam_Tiba_LN", masaBertolak))
        param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMakan.EM_MknPagi))
        param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMakan.EM_MknTghri))
        param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMakan.EM_MknMlm))
        param.Add(New SqlParameter("@Flag_Elaun_Harian", listElaunMakan.EM_StaElaunHarian))
        param.Add(New SqlParameter("@Bil_Hari", listElaunMakan.EM_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", listElaunMakan.EM_HargaElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMakan.EM_Jumlah))


        Return db.Process(query, param)
    End Function

    'Private Function UpdateDataElaunMakan(listElaunMakan As ElaunMakanLN)
    '    Dim db = New DBKewConn
    '    Dim masaMula As String
    '    Dim masaTamat As String

    '    masaMula = listElaunMakan.EM_JamMula + ":" + listElaunMakan.EM_MinitMula
    '    masaTamat = listElaunMakan.EM_JamSampai + ":" + listElaunMakan.EM_MinitSampai

    '    Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
    '    set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas,Flag_Mkn_Pagi = @Flag_Mkn_Pagi,
    '    Flag_Mkn_Tghari = @Flag_Mkn_Tghari, Flag_Mkn_Mlm = @Flag_Mkn_Mlm,Bil_Hari = @Bil_Hari,  Kadar_Harga = @Kadar_Harga, 
    '    Jumlah_anggaran = @Jumlah_anggaran
    '    where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EM'"

    '    Dim param As New List(Of SqlParameter)
    '    param.Add(New SqlParameter("@No_Tuntutan", listElaunMakan.EM_mohonID))
    '    param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EM"))
    '    param.Add(New SqlParameter("@No_Item", listElaunMakan.EM_hidID))
    '    param.Add(New SqlParameter("@Jenis_Tempat", listElaunMakan.EM_bilHari))
    '    param.Add(New SqlParameter("@Jenis_Tugas", listElaunMakan.EM_JnsTugas))
    '    param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMakan.EM_MknPagi))
    '    param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMakan.EM_MknTghri))
    '    param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMakan.EM_MknMlm))
    '    param.Add(New SqlParameter("@Flag_Elaun_Harian", listElaunMakan.EM_ElaunHarian))
    '    param.Add(New SqlParameter("@Bil_Hari", listElaunMakan.EM_bilHari))
    '    param.Add(New SqlParameter("@Kadar_Harga", listElaunMakan.EM_Jumlah))
    '    param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMakan.EM_Jumlah))

    '    Return db.Process(query, param)
    'End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisSumbangan(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisSumbangan(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisSumbangan(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT  Kod_Tabung as value, Kod_Tabung +' - ' + Butiran as text, Status
                        FROM SMKB_Ptj_Tabung WHERE Status=1 "
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Tabung ='K03001' OR Kod_Tabung='K03001' AND 
                        Butiran like 'Tabung%' and (Kod_Tabung LIKE '%' + @kod + '%') "
            param.Add(New SqlParameter("@kod", kod))

        End If

        Return db.Read(query, param)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataPelbagai(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataPelbagaiTab(id)

        'If dt IsNot Nothing Then
        '    For Each x As DataRow In dt.Rows
        '        If Not IsDBNull(x.Item("Nama_Fail")) Then
        '            Dim url As String = GetBaseUrl() + Trim(x.Item("Path")) + "/" + x.Item("Nama_Fail")
        '            x.Item("Path") = url
        '        End If
        '    Next
        'End If

        For Each x As DataRow In dt.Rows
            If Not IsDBNull(x.Item("Nama_Fail")) Then
                Dim url As String = GetBaseUrl() + Trim(x.Item("Path")) + "/" + x.Item("Nama_Fail")
                x.Item("Path") = url
            End If
        Next

        Return JsonConvert.SerializeObject(dt)

        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetDataPelbagaiTab(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Jenis_Belanja_Pelbagai, 
                b.Flag_Resit, b.No_Resit, b.Jumlah_anggaran, c.Butiran, b.Nama_Fail, b.Path, b.Negara, 
                b.Matawang 
                FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
                SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                SMKB_Lookup_Detail  as c ON b.Jenis_Belanja_Pelbagai = c.Kod_Detail INNER JOIN 
                SMKB_CLM_Matawang as d ON b.Negara = d.Negara AND b.Matawang = d.Matawang
                WHERE c.kod='AC10' AND a.No_Tuntutan = @No_Tuntutan AND  b.Jns_Dtl_Tuntutan='BP'
                ORDER BY b.No_Item ASC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        dt = db.Read(query, param)
        'If dt.Rows.Count > 0 Then
        '    Return dt
        'End If
        Return dt
        'Return db.Read(query, param)
    End Function

    Function GetBaseUrl() As String
        Dim curUrl As Uri = HttpContext.Current.Request.Url
        Dim scheme As String = curUrl.Scheme
        Dim host As String = curUrl.Host
        Dim port As Integer = curUrl.Port
        Dim segments As String() = curUrl.Segments

        If port <> 80 Then
            host = host + ":" + port.ToString()
        End If

        Return scheme + "://" + host + "/" + segments(1) + "/"
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordSumbangan(tabung As MhnLuarNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        For Each listSumbangan As tblSumbanganLN In tabung.GroupSumbangan

            If listSumbangan.mohonID = "" Then
                Continue For
            End If

            JumRekod += 1

            If listSumbangan.mohonID <> "" Then
                If semakdataSumbangan(listSumbangan.mohonID, listSumbangan.KodTabung) = "wujud" Then
                    'updateDataKeperluan--
                    If UpdateOrderDetail(listSumbangan) = "OK" Then
                        success += 1

                    End If
                Else
                    'insert Data Keperluan
                    listSumbangan.idbil = GenerateOrderDetailID(listSumbangan.mohonID)
                    listSumbangan.mohonID = tabung.OrderID
                    If InsertDataItem(listSumbangan) = "OK" Then
                        success += 1

                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalSumbangan(tabung) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", tabung)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateTotalSumbangan(tabung As MhnLuarNegara)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jum_Sumbangan = @Jum_Sumbangan                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", tabung.OrderID))
        param.Add(New SqlParameter("@Jum_Sumbangan", tabung.Jumlah))

        Return db.Process(query, param)
    End Function
    Private Function UpdateOrderDetail(listSumbangan As tblSumbanganLN)
        Dim db = New DBKewConn


        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set  Kod_Tabung = @Kod_Tabung, Jumlah_anggaran = @Jumlah_anggaran
        where No_Tuntutan = @NoTuntutan  AND No_Item = @No_Item AND Jns_Dtl_Tuntutan='ST'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoTuntutan", listSumbangan.mohonID))
        param.Add(New SqlParameter("@No_Item", listSumbangan.idbil))
        param.Add(New SqlParameter("@Kod_Tabung", listSumbangan.KodTabung))
        param.Add(New SqlParameter("@Jumlah_anggaran", listSumbangan.Jumlah))

        Return db.Process(query, param)
    End Function

    Private Function InsertDataItem(listSumbangan As tblSumbanganLN)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl (No_Tuntutan, No_Item, Jns_Dtl_Tuntutan, Kod_Tabung, 
                            Jumlah_anggaran)
                            VALUES(@NoTuntutan, @No_Item,@Jns_Dtl_Tuntutan, @Kod_Tabung, @Jumlah_anggaran)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoTuntutan", listSumbangan.mohonID))
        param.Add(New SqlParameter("@No_Item", listSumbangan.idbil))
        param.Add(New SqlParameter("@Kod_Tabung", listSumbangan.KodTabung))
        param.Add(New SqlParameter("@Jumlah_anggaran", listSumbangan.Jumlah))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "ST"))


        Return db.Process(query, param)
    End Function

    Private Function semakdataSumbangan(mohonID, tabung) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT No_Tuntutan, Kod_Tabung, Jumlah_anggaran FROM SMKB_Tuntutan_Dtl 
                                WHERE No_Tuntutan=@mohonID AND Kod_Tabung=@tabung AND Jns_Dtl_Tuntutan='ST'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@tabung", tabung))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDatSumbangan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallDataSumbangan(id)


        Return JsonConvert.SerializeObject(dt)


        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallDataSumbangan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Kod_Tabung, c.Butiran, b.Jumlah_anggaran, a.Jum_Sumbangan
                            From SMKB_Tuntutan_Hdr as a INNER JOIN
                            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                            SMKB_Ptj_Tabung as c ON b.Kod_Tabung = c.Kod_Tabung
                            WHERE a.No_Tuntutan = @No_Tuntutan ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    '<System.Web.Services.WebMethod(EnableSession:=True)>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function SaveRecordElaunMakan(itemElaunMakan As MhnLuarNegara) As String
    '    Dim resp As New ResponseRepository
    '    resp.Success("Data telah disimpan")
    '    Dim success As Integer = 0
    '    Dim JumRekod As Integer = 0
    '    Dim sumTotal As Decimal = 0.00


    '    For Each listElaunMkn As ElaunMakanLN In itemElaunMakan.GroupElaunMakan

    '        If listElaunMkn.EM_mohonID = "" Then
    '            Continue For
    '        End If

    '        JumRekod += 1

    '        'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model

    '        If listElaunMkn.EM_mohonID <> "" Then
    '            If semakdataElaunMakan(listElaunMkn.EM_mohonID, listElaunMkn.EM_hidID) = "wujud" Then
    '                'updateDataKeperluan--
    '                itemElaunMakan.OrderID = listElaunMkn.EM_mohonID
    '                If UpdateDataElaunMakan(listElaunMkn) = "OK" Then
    '                    success += 1
    '                    'listElaunMkn.EM_harga += listElaunMkn.EM_Jumlah
    '                End If
    '            Else
    '                'insert Data Keperluan
    '                listElaunMkn.EM_hidID = GenerateIDDataElaunMakan(listElaunMkn.EM_mohonID)
    '                itemElaunMakan.OrderID = listElaunMkn.EM_mohonID
    '                If InsertDataElaunMakan(listElaunMkn) = "OK" Then
    '                    success += 1
    '                    'listElaunMkn.EM_harga += listElaunMkn.EM_Jumlah
    '                End If
    '            End If
    '            'listElaunMkn.EM_hidID = listElaunMkn.EM_hidID + 1
    '        Else

    '        End If
    '        listElaunMkn.EM_hidID = listElaunMkn.EM_hidID + 1
    '    Next


    '    If UpdateTotalElaunMakan(itemElaunMakan) <> "OK" Then
    '        'If InsertNewOrder(OtherList) <> "OK" Then
    '        resp.Failed("Gagal Menyimpan order 1266")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '        ' Exit Function
    '        'End If
    '    End If

    '    resp.Success("Rekod berjaya disimpan", "00", itemElaunMakan)
    '    Return JsonConvert.SerializeObject(resp.GetResult())
    'End Function

    'Private Function UpdateTotalElaunMakan(itemElaunMakan As MhnLuarNegara)
    '    Dim db = New DBKewConn
    '    Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Elaun_Mkn = @Jumlah_Elaun_Mkn                                 
    '                            WHERE No_Tuntutan = @No_Tuntutan"

    '    Dim param As New List(Of SqlParameter)
    '    param.Add(New SqlParameter("@No_Tuntutan", itemElaunMakan.OrderID))
    '    param.Add(New SqlParameter("@Jumlah_Elaun_Mkn", itemElaunMakan.Jumlah))

    '    Return db.Process(query, param)
    'End Function
    'Private Function InsertDataElaunMakan(listElaunMakan As ElaunMakanLN)
    '    Dim db As New DBKewConn

    '    Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl(No_Tuntutan, Jns_Dtl_Tuntutan,No_Item, Jenis_Tempat, Jenis_Tugas, 
    '                  Flag_Mkn_Pagi, Flag_Mkn_Tghari,Flag_Mkn_Mlm, Flag_Elaun_Harian, Bil_Hari, Kadar_Harga, Jumlah_anggaran)
    '                 VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Tempat,@Jenis_Tugas, @Flag_Mkn_Pagi,@Flag_Mkn_Tghari,@Flag_Mkn_Mlm,@Flag_Elaun_Harian,
    '                @Bil_Hari,@Kadar_Harga, @Jumlah_anggaran)"
    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@No_Tuntutan", listElaunMakan.EM_mohonID))
    '    param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EM"))
    '    param.Add(New SqlParameter("@No_Item", listElaunMakan.EM_hidID))
    '    param.Add(New SqlParameter("@Jenis_Tugas", listElaunMakan.EM_JnsTugas))
    '    param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMakan.EM_MknPagi))
    '    param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMakan.EM_MknTghri))
    '    param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMakan.EM_MknMlm))
    '    param.Add(New SqlParameter("@Flag_Elaun_Harian", listElaunMakan.EM_ElaunHarian))
    '    param.Add(New SqlParameter("@Bil_Hari", listElaunMakan.EM_bilHari))
    '    param.Add(New SqlParameter("@Kadar_Harga", listElaunMakan.EM_ElaunHarian))
    '    param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMakan.EM_Jumlah))


    '    Return db.Process(query, param)
    'End Function
    Private Function GenerateIDDataElaunMakan(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='EM'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateDataElaunMakan(listElaunMakan As ElaunMakanLN)
        Dim db = New DBKewConn

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas,Flag_Mkn_Pagi = @Flag_Mkn_Pagi,
        Flag_Mkn_Tghari = @Flag_Mkn_Tghari, Flag_Mkn_Mlm = @Flag_Mkn_Mlm,Bil_Hari = @Bil_Hari,  Kadar_Harga = @Kadar_Harga, 
        Jumlah_anggaran = @Jumlah_anggaran
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EM'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listElaunMakan.EM_mohonID))
        param.Add(New SqlParameter("@No_Item", listElaunMakan.EM_hidID))
        param.Add(New SqlParameter("@Jenis_Tugas", listElaunMakan.EM_JnsTugas))
        param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMakan.EM_MknPagi))
        param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMakan.EM_MknTghri))
        param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMakan.EM_MknMlm))
        param.Add(New SqlParameter("@Bil_Hari", listElaunMakan.EM_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", listElaunMakan.EM_HargaElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMakan.EM_Jumlah))

        Return db.Process(query, param)
    End Function

    Private Function semakdataElaunMakan(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT  No_Tuntutan, No_Item FROM SMKB_Tuntutan_Dtl Where No_Tuntutan =@mohonID AND No_Item = @id AND Jns_Dtl_Tuntutan='EM'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@id", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataPengesahanLN(id As String)
        Dim db As New DBKewConn
        Dim query As String = $"SELECT No_Tuntutan, FORMAT(Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon, 
                                No_Pendahuluan, Jum_Pendahuluan, No_Baucar, 
                                Jumlah_Elaun_Mkn, Jumlah_Sewa_HotelLojing,Jum_Sumbangan, 
                                Jumlah_Belanja_Pelbagai,Jum_Gantirugi,Jum_Belanja_Sendiri,Jum_Tuntut,Jum_Baki_Tuntut
                                FROM            SMKB_Tuntutan_Hdr
                                WHERE (No_Tuntutan = '{id}')"



        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListPengesahan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataPengesahan(id)

        For Each x As DataRow In dt.Rows
            If Not IsDBNull(x.Item("Nama_Fail_Belanja")) Then
                Dim url As String = GetBaseUrl() + Trim(x.Item("Path_Belanja")) + "/" + x.Item("Nama_Fail_Belanja")
                x.Item("Path_Belanja") = url
            End If
        Next
        Return JsonConvert.SerializeObject(dt)

        'dt = GetDataKenyataan(id)
        'resp.SuccessPayload(dt)

        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetDataPengesahan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT No_Tuntutan, FORMAT(Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon, 
                                No_Pendahuluan, Jum_Pendahuluan, No_Baucar, 
                                Jumlah_Elaun_Mkn, Jumlah_Sewa_HotelLojing,Jum_Sumbangan, Path_Belanja, Nama_Fail_Belanja, Nama_Fail_Belanja as url,
                                Jumlah_Belanja_Pelbagai,Jum_Gantirugi,Jum_Belanja_Sendiri,Jum_Tuntut,Jum_Baki_Tuntut
                                FROM            SMKB_Tuntutan_Hdr
                                WHERE (No_Tuntutan = @No_Tuntutan)"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))
        dt = db.Read(query, param)
        Return dt

        'Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTotalElaunMakan(id As String)
        Dim db As New DBKewConn
        Dim query As String = $"SELECT ISNULL(sum(Jumlah_anggaran),0) as harga
                        FROM SMKB_Tuntutan_Dtl 
                        WHERE Jns_Dtl_Tuntutan='EM' AND No_Tuntutan ='{id}'"

        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFile() As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim idMohon As String = HttpContext.Current.Request.Form("idMohon")
        Dim jnsBelanja As String = HttpContext.Current.Request.Form("jnsBelanja")

        Dim savePath As String = ""
        Dim folder As String = ""

        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

            ' Specify the file path where you want to save the uploaded file
            If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & idMohon)) Then
                System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/"))
            End If


            ' Specify the file path where you want to save the uploaded file
            savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & idMohon)
            folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & idMohon

            ' Save the file to the specified path
            postedFile.SaveAs(savePath & "/" & fileName)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordPengesahan(PengesahanList As MhnLuarNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim folder As String = ""
        Dim postedFile As HttpPostedFile = Nothing
        Dim returnURL As String = ""
        Dim fileName As String = ""
        Dim savePath As String = ""

        'Check if File is available.
        If HttpContext.Current.Request.Files.Count > 0 Then
            postedFile = HttpContext.Current.Request.Files(0)
        End If



        If PengesahanList.File_Name <> "" Then

                If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & PengesahanList.OrderID) Then
                    System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & PengesahanList.OrderID)
                End If

                ' Specify the file path where you want to save the uploaded file
                savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & PengesahanList.OrderID & "/" & PengesahanList.File_Name)
                folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & PengesahanList.OrderID
                PengesahanList.Folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & PengesahanList.OrderID


            ' Save the file to the specified path
            'postedFile.SaveAs(savePath)
            'returnURL = GetBaseUrl() + folder + "/" + fileName
            ' Store the uploaded file name in session
            'Session("UploadedFileName") = fileName

            simpanBuktiBelanja(PengesahanList)
            End If



        If PengesahanList Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateDataPengesahan(PengesahanList) <> "OK" Then
            'If InsertNewOrder(AdvList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            '    ' Exit Function
            'End If
        End If


        If UpdateStatusDokOrder_Mohon(PengesahanList, "Y") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        Else
            'hantar email function

        End If

        resp.Success("Rekod berjaya disimpan", "00", PengesahanList)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function simpanBuktiBelanja(PengesahanList As MhnLuarNegara)
        Dim db As New DBKewConn

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & PengesahanList.OrderID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & PengesahanList.OrderID)
        End If

        PengesahanList.Folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & PengesahanList.OrderID

        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Nama_Fail_Belanja = @Nama_Fail_Belanja, Path_Belanja = @Path_Belanja                                
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", PengesahanList.OrderID))
        param.Add(New SqlParameter("@Nama_Fail_Belanja", PengesahanList.File_Name))
        param.Add(New SqlParameter("@Path_Belanja", PengesahanList.Folder))


        Return db.Process(query, param)
    End Function


    Private Function UpdateStatusDokOrder_Mohon(PengesahanList As MhnLuarNegara, statusLulus As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String = ""

        If statusLulus = "Y" Then
            kodstatusLulus = "02"
        End If

        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
    			VALUES
    			(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "04"))
        param.Add(New SqlParameter("@Kod_Status_Dok", kodstatusLulus))
        param.Add(New SqlParameter("@No_Rujukan", PengesahanList.OrderID))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", "-"))

        Return db.Process(query, param)

    End Function
    Private Function UpdateDataPengesahan(PengesahanList As MhnLuarNegara)


        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jum_Tuntut = @Jum_Tuntut, Jum_Baki_Tuntut = @Jum_Baki_Tuntut, Jum_Gantirugi= @Jum_Gantirugi,
                                Jum_Belanja_Sendiri = @Jum_Belanja_Sendiri,Status_Dok = @Status_Dok                               
                                WHERE No_Tuntutan = @No_Tuntutan "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Jum_Tuntut", PengesahanList.JumTuntut))
        param.Add(New SqlParameter("@Jum_Baki_Tuntut", PengesahanList.JumBakiTuntut))
        param.Add(New SqlParameter("@Jum_Gantirugi", PengesahanList.JumGantiRugi))
        param.Add(New SqlParameter("@Jum_Belanja_Sendiri", PengesahanList.JumBelanjaSendiri))
        param.Add(New SqlParameter("@Status_Dok", "02"))
        param.Add(New SqlParameter("@No_Tuntutan", PengesahanList.OrderID))


        Return db.Process(query, param)
    End Function
End Class