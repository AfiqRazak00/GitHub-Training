Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports SMKB_Web_Portal.PengesahanPD

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PengesahanDN_WS
    Inherits System.Web.Services.WebService
    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
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
                FORMAT(a.Tarikh_Mohon, 'dd-MM-yyyy') AS Tarikh_Mohon,  isnull(a.Jum_Pendahuluan,'0.00') as Jum_Pendahuluan,                      
                a.Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang as kw where a.Kod_Kump_Wang = kw.Kod_Kump_Wang) as colKW,
                a.Kod_Operasi, (select Butiran from SMKB_Operasi as ko where  ko.Kod_Operasi = a.Kod_Operasi) as colKO,
                a.Kod_Projek,  (select Butiran from SMKB_Projek as kp where kp.Kod_Projek = a.Kod_Projek) as colKp,
                a.Kod_PTJ,  (SELECT b.Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT as b WHERE b.STATUS = 1 and b.kodpejabat = left(a.Kod_PTJ,2)) as ButiranPTJ,
                 a.Status_Dok,
                b.Butiran, a.No_Staf + ' - ' + c.ms01_nama   as NamaPemohon, a.No_Staf as Nopemohon
                FROM SMKB_Tuntutan_Hdr as a INNER JOIN 
                SMKB_Kod_Status_Dok AS b ON a.Status_Dok = b.Kod_Status_Dok INNER JOIN
                [qa11].dbStaf.dbo.MS01_Peribadi as c ON a.No_Staf = c.ms01_noStaf
                WHERE  (b.Kod_Modul = '09') AND (b.Kod_Status_Dok = '02') AND (a.Jenis_Tuntutan ='DN')  " & tarikhQuery & " order by a.Tarikh_Mohon desc"
        ' WHERE a.Status_Dok='01' AND a.Pengesahan_Pemohon='0' " & tarikhQuery & " order by a.Tarikh_Mohon desc"

        param.Add(New SqlParameter("@staffP", staffP))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetUserInfo(nostaf As String)
        Dim db As New DBSMConn
        Dim query As String = $"SELECT  MS01_NoStaf as StafNo, MS01_Nama as Param1, MS08_Pejabat as Param2, JawGiliran as Param3, Kumpulan as Param4, 
                                Singkatan as Param5, MS02_GredGajiS as Param6, 
                                MS02_JumlahGajiS,  MS01_TelPejabat as Param7,  MS02_Kumpulan
                                FROM VK_AdvClm WHERE MS01_NoStaf = '{nostaf}'"
        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListKenyataan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataKenyataan(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function GetDataKenyataan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT No_Tuntutan, Bil, FORMAT(Tarikh, 'yyyy-MM-dd') as Tarikh,Jarak, Masa_Bertolak,
                substring(CONVERT(varchar,Masa_Bertolak,108),1,2) as jamTolak, substring(CONVERT(varchar,Masa_Bertolak,108),4,2) as minitTolak, 
                Masa_Sampai,substring(CONVERT(varchar,Masa_Sampai,108),1,2) as jamSampai, substring(CONVERT(varchar,Masa_Sampai,108),4,2) as minitSampai,
                Tujuan, Flag_Mula, Flag_Tamat, No_Kend, Flag_Kend_Sendiri, Flag_Sokong_Kend_Sendiri
                FROM  SMKB_Tuntutan_Dlm_Kenyataan WHERE No_Tuntutan = @No_Permohonan ORDER BY Bil ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Permohonan", id))

        Return db.Read(query, param)
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataFromKenyataan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataForElaunPerjln(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetDataForElaunPerjln(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"SELECT  TOP 1 No_Tuntutan, No_Kend, jumjarak, Jenis_Kenderaan, Butiran,KM, No_Staf,
                (SELECT TOP (1) Kadar
                FROM  SMKB_CLM_KdrKenderaan
                WHERE (KodKend = Jenis_Kenderaan) AND (jumjarak <= KM)
                ORDER BY KM) AS kadarHarga
                FROM (SELECT        a.No_Tuntutan, b.No_Kend, SUM(CONVERT(int, b.Jarak)) AS jumjarak, c.Jenis_Kenderaan, d.Butiran, h.KM, c.No_Staf
                FROM  SMKB_Tuntutan_Hdr AS a INNER JOIN
                SMKB_Tuntutan_Dlm_Kenyataan AS b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                SMKB_Tuntutan_Dftr_Kenderaan AS c ON b.No_Kend = c.No_Kenderaan AND a.No_Staf = c.No_Staf INNER JOIN
                SMKB_Lookup_Detail AS d ON c.Jenis_Kenderaan = d.Kod_Detail INNER JOIN 
                SMKB_CLM_KdrKenderaan as h ON h.KodKend = c.Jenis_Kenderaan
                WHERE        (d.Kod = 'AC09') AND a.No_Tuntutan=@No_Permohonan
                GROUP BY a.No_Tuntutan, b.No_Kend, c.Jenis_Kenderaan, d.Butiran, h.KM,  c.No_Staf) AS e"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Permohonan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataKendAwam(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataKenderaanAwamTab(id)

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

    Private Function GetDataKenderaanAwamTab(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Jenis_Tambang, b.Flag_Resit, 
                        b.No_Resit, b.Jumlah_anggaran, c.Butiran, b.Nama_Fail, b.Path  
                        FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
                        SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                        SMKB_Lookup_Detail  as c ON b.Jenis_Tambang = c.Kod_Detail 
                        WHERE c.kod='AC11' AND a.No_Tuntutan =@No_Tuntutan AND  b.Jns_Dtl_Tuntutan='TA'
                        ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Return dt
        End If

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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKendAwam(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataKenderaanAwam(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataKenderaanAwam(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text, Keutamaan, Status
                                FROM  SMKB_Lookup_Detail
                                WHERE        (Kod = 'AC11')"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Status = 1 and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataElaunMakan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordElaunMakan(id)

        'For Each x As DataRow In dt.Rows
        '    If Not IsDBNull(x.Item("Nama_Fail")) Then
        '        Dim url As String = GetBaseUrl() + Trim(x.Item("Path")) + "/" + x.Item("Nama_Fail")
        '        x.Item("Path") = url
        '    End If
        'Next
        'Return JsonConvert.SerializeObject(dt)


        resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallRecordElaunMakan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Tempat,b.Jenis_Tugas,
                        b.Flag_Mkn_Pagi, b.Flag_Mkn_Tghari,b.Flag_Mkn_Mlm, b.Flag_Elaun_Harian,
                        b.Kadar_Harga,  b.Jumlah_anggaran, g.Butiran as Tempat,
                        h.Butiran as JenisTugas
                        FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
                        SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN           
                        SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
                        SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
                        WHERE  g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EM' AND a.No_Tuntutan =@No_Tuntutan
                        ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataStoreProceHari(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordHariMakan(id)


        resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallRecordHariMakan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "Declare @Tarikh smalldatetime
                               DEclare @MasaMula time(7)
                                Declare @MasaTamat time(7)
                                Declare @JumHari tinyint
                                Declare @BilJam float,
                                @FlagMula bit, @FlagTamat bit

                                IF OBJECT_ID(N'tempdb..#TempData') IS NOT NULL 
                                    begin
                                        DROP TABLE #TempData 
                                    end

                        IF OBJECT_ID(N'tempdb..#TempData2') IS NOT NULL  
                                    begin
                                        DROP TABLE #TempData2 
                                    end

                                Create table #TempData (
            	                    Tarikh smalldatetime,
                                    MasaMula time(7),
            	                    MasaTamat time(7)
                                )

                                CREATE TABLE #TempData2 (
            	                    Bil_Hari int,
                                    BilJam  float
                                )

                                declare cur cursor for
                                SELECT Tarikh, Masa_Bertolak, Masa_Sampai, Flag_Mula, FLag_Tamat 
            	                    FROM SMKB_Tuntutan_Dlm_Kenyataan
            	                    WHERE No_Tuntutan = @No_Tuntutan
            	                    ORDER BY Tarikh ASC, Masa_Bertolak ASC
                                open cur
                                FETCH next from cur into @Tarikh, @MasaMula, @MasaTamat, @FlagMula, @FlagTamat
                                While @@FETCH_STATUS = 0
                                Begin
                                      If @FlagMula = 1 
            		                    Begin 
            			                    DELETE FROM #TempData
            		                    End

            	                    INSERT INTO #TempData
            	                    VALUES (@Tarikh, @MasaMula, @MasaTamat)

            	                    if @FlagTamat = 1 
            		                    Begin

            			                    SELECT @JumHari = DATEDIFF(Day, MIN(Tarikh), MAX(Tarikh)) , 
            			                    @BilJam = SUM(datediff(minute, MasaMula, MasaTamat) / 60.0) 
            			                    FROM #TempData

            			                    INSERT INTO #TempData2
            			                    VALUES(@JumHari, @BilJam)
            		                    End

                                      FETCH next from cur into @Tarikh, @MasaMula, @MasaTamat, @FlagMula, @FlagTamat
                                End
                                Close cur
                                deallocate cur

                        SELECT * FROM #TempData2 "


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataElaunLojing(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordElaunLojing(id)

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

    Private Function CallRecordElaunLojing(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan,b.Jenis_Tempat,b.Jenis_Tugas, 
            b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran , g.Butiran as Tempat,
            h.Butiran as JenisTugas, b.Path, b.Nama_Fail,b.Alamat_Lojing
            FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
            SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
            SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
            SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
            WHERE c.kod='AC01'  AND g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EL' AND a.No_Tuntutan =@No_Tuntutan
            ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

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

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataSewaHotel(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordSewaHotel(id)

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

    Private Function CallRecordSewaHotel(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan,b.Jenis_Tempat,b.Jenis_Tugas, 
            b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran , g.Butiran as Tempat,
            h.Butiran as JenisTugas, b.Path, b.Nama_Fail
            FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
            SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
            SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
            SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
            WHERE c.kod='AC01'  AND g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EH' AND a.No_Tuntutan =@No_Tuntutan
            ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataPelbagai(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataPelbagaiTab(id)

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

        Dim query As String = $"SELECT a.No_Tuntutan, FORMAT(a.Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon,  b.Jns_Dtl_Tuntutan,b.No_Item,b.Jenis_Belanja_Pelbagai, 
                b.Flag_Resit, b.No_Resit, b.Jumlah_anggaran, c.Butiran, b.Nama_Fail, b.Path  
                FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
                SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                SMKB_Lookup_Detail  as c ON b.Jenis_Belanja_Pelbagai = c.Kod_Detail 
                WHERE c.kod='AC10' AND a.No_Tuntutan =@No_Tuntutan AND  b.Jns_Dtl_Tuntutan='BP'
                ORDER BY b.No_Item ASC"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Return dt
        End If

        'Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisPelbagai(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisBelanjaPelbagai(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisBelanjaPelbagai(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  
        FROM   SMKB_Lookup_Detail WHERE (Kod = 'AC10') AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail ='01' OR Kod_Detail='02' AND 
                        Butiran like 'Tempat%' and (Kod_Detail LIKE '%' + @kod + '%') "
            param.Add(New SqlParameter("@kod", kod))

        End If

        Return db.Read(query, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataPengesahan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordPengesahan(id)

        'For Each x As DataRow In dt.Rows
        '    If Not IsDBNull(x.Item("Nama_Fail")) Then
        '        Dim url As String = GetBaseUrl() + Trim(x.Item("Path")) + "/" + x.Item("Nama_Fail")
        '        x.Item("Path") = url
        '    End If
        'Next
        'Return JsonConvert.SerializeObject(dt)


        resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallRecordPengesahan(id As String) As DataTable
        Dim db = New DBKewConn


        Dim query As String = "SELECT No_Tuntutan, FORMAT(Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon, No_Pendahuluan, Jum_Pendahuluan, No_Baucar, 
                                Jumlah_Tambang_Awam, Jumlah_Elaun_Kend, Jumlah_Elaun_Mkn, Jumlah_Sewa_HotelLojing,Jum_Sumbangan, 
                                Jumlah_Belanja_Pelbagai
                                FROM            SMKB_Tuntutan_Hdr
                                WHERE (No_Tuntutan = @No_Tuntutan)"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataPelulus(mohonID As String)
        Dim db As New DBKewConn
        Dim query As String = $"SELECT   DISTINCT     a.No_Tuntutan,  a.PTj, a.Jenis_Tuntutan, c.Ketua +' - '+ d.ms01_nama as NamaPelulus, f.JawGiliran as Jawatan
                FROM            SMKB_Tuntutan_Hdr AS a INNER JOIN                
                [qa11].dbStaf.[dbo].[MS_KetuaPejPBU] as c ON a.PTj = c.KodPejabat INNER JOIN
                [qa11].dbStaf.dbo.MS01_Peribadi as d ON c.Ketua = d.ms01_nostaf  INNER JOIN
                [qa11].dbStaf.dbo.MS02_Perjawatan as e ON c.Ketua = e.MS01_NoStaf  INNER JOIN
                [qa11].dbStaf.dbo.MS_Jawatan as f ON e.MS02_JawSandang = f.KodJawatan
                where  a.Status_Dok ='01' AND a.No_Tuntutan='{mohonID}' "
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordSokong(SokongPD As SokongPD) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)

        If SokongPD Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If SokongPD.mohonID = "" Then 'untuk permohonan baru
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            If UpdateSokongPTj(SokongPD) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        If UpdateStatusDokSokongPTj(SokongPD, SokongPD.statusDok) <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        End If


        resp.Success("Rekod berjaya disimpan", "00", SokongPD)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateSokongPTj(SokongPD As SokongPD)

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Status_Dok = @status                                
                                WHERE No_Tuntutan = @No_Tuntutan AND Status = 1"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@status", SokongPD.statusDok))
        param.Add(New SqlParameter("@No_Tuntutan", SokongPD.mohonID))


        Return db.Process(query, param)
    End Function

    Private Function UpdateStatusDokSokongPTj(SokongPD As SokongPD, statusLulus As String)
        Dim db As New DBKewConn

        'Dim kodstatusLulus As String

        'If statusLulus = "Y" Then

        '    kodstatusLulus = "06"

        'End If


        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
    			VALUES
    			(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "09"))
        param.Add(New SqlParameter("@Kod_Status_Dok", SokongPD.statusDok))
        param.Add(New SqlParameter("@No_Rujukan", SokongPD.mohonID))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", SokongPD.catatan))

        Return db.Process(query, param)

    End Function
End Class