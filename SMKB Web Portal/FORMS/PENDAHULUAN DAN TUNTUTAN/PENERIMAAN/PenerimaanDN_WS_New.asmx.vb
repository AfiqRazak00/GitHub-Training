Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data.SqlClient
Imports System.IO
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports SMKB_Web_Portal.PenerimaanDN
Imports SMKB_Web_Portal.Dalam_Negara

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PenerimaanDN_WS_New
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
                FORMAT(a.Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon,  isnull(a.Jum_Pendahuluan,'0.00') as Jum_Pendahuluan,                      
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

        Dim query As String = "SELECT No_Tuntutan, Bil, FORMAT(Tarikh, 'yyyy-MM-dd') as Tarikh, case when CONVERT(int, Jarak_Lulus) is null  then CONVERT(int, Jarak) end as jumjarak,Jarak_Lulus, Masa_Bertolak,
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

        'Dim query As String = $"SELECT  TOP 1 No_Tuntutan, No_Kend, jumjarak, Jenis_Kenderaan, Butiran,KM, No_Staf,
        '        (SELECT TOP (1) Kadar
        '        FROM  SMKB_CLM_KdrKenderaan
        '        WHERE (KodKend = Jenis_Kenderaan) AND (jumjarak <= KM)
        '        ORDER BY KM) AS kadarHarga
        '        FROM (SELECT  a.No_Tuntutan, b.No_Kend, case when SUM(CONVERT(int, b.Jarak_Lulus)) IS NULL  then SUM(CONVERT(int, b.Jarak))end as jumjarak, 
        '        c.Jenis_Kenderaan, d.Butiran, h.KM, c.No_Staf
        '        FROM  SMKB_Tuntutan_Hdr AS a INNER JOIN
        '        SMKB_Tuntutan_Dlm_Kenyataan AS b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
        '        SMKB_Tuntutan_Dftr_Kenderaan AS c ON b.No_Kend = c.No_Kenderaan AND a.No_Staf = c.No_Staf INNER JOIN
        '        SMKB_Lookup_Detail AS d ON c.Jenis_Kenderaan = d.Kod_Detail INNER JOIN 
        '        SMKB_CLM_KdrKenderaan as h ON h.KodKend = c.Jenis_Kenderaan
        '        WHERE        (d.Kod = 'AC09') AND a.No_Tuntutan=@No_Permohonan
        '        GROUP BY a.No_Tuntutan, b.No_Kend, c.Jenis_Kenderaan, d.Butiran, h.KM,  c.No_Staf) AS e"

        Dim query As String = $"SELECT  TOP 1 No_Tuntutan, No_Kend, jumjarak, Jenis_Kenderaan, Butiran,KM, No_Staf,
                            (SELECT TOP (1) Kadar
                            FROM  SMKB_CLM_KdrKenderaan
                            WHERE (KodKend = Jenis_Kenderaan) AND (jumjarak <= KM)
                            ORDER BY KM) AS kadarHarga
                            FROM (SELECT        a.No_Tuntutan, b.No_Kend, 
                            case when SUM(CONVERT(int, b.Jarak_Lulus)) is null  then SUM(CONVERT(int, b.Jarak)) else SUM(CONVERT(int, b.Jarak_Lulus)) end as jumjarak,
                            ---case when SUM(CONVERT(int, b.Jarak_Lulus)) IS NULL  then SUM(CONVERT(int, b.Jarak))end as jumjarak, 
                            c.Jenis_Kenderaan, d.Butiran, h.KM, c.No_Staf
                            FROM  SMKB_Tuntutan_Hdr AS a INNER JOIN
                            SMKB_Tuntutan_Dlm_Kenyataan AS b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                            SMKB_Tuntutan_Dftr_Kenderaan AS c ON b.No_Kend = c.No_Kenderaan AND a.No_Staf = c.No_Staf INNER JOIN
                            SMKB_Lookup_Detail AS d ON c.Jenis_Kenderaan = d.Kod_Detail INNER JOIN 
                            SMKB_CLM_KdrKenderaan as h ON h.KodKend = c.Jenis_Kenderaan
                            WHERE        (d.Kod = 'AC09') AND a.No_Tuntutan=@No_Permohonan
                            GROUP BY a.No_Tuntutan, b.No_Kend, c.Jenis_Kenderaan, d.Butiran, h.KM,  c.No_Staf) AS e "


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
        ' If dt.Rows.Count > 0 Then
        Return dt
        ' End If

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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function kiraElaunMakan(ByVal jnsTugas As String, ByVal jnsTempat As String, ByVal hadGaji As String) As String
        Dim resp As New ResponseRepository

        dt = KiraElaunMakanTable(jnsTugas, jnsTempat, hadGaji)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function KiraElaunMakanTable(jnsTugas As String, jnsTempat As String, hadGaji As String) As DataTable
        Dim db = New DBKewConn
        Dim had As String
        had = Right(hadGaji, 2)

        Dim query As String = $"SELECT JenisTugas, Tempat, GredDari, GredKe, KadarMkn, KadarHotel,  KadarLojing
                                FROM            SMKB_CLM_KdrMknHtlLjg
                                WHERE (GredDari<=@had AND GredKe >=@had) AND JenisTugas=@JenisTugas AND Tempat=@Tempat"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@had", had))
        param.Add(New SqlParameter("@Tempat", jnsTempat))
        param.Add(New SqlParameter("@JenisTugas", jnsTugas))

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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function kiraElaunHotel(ByVal jnsTugas As String, ByVal jnsTempat As String, ByVal hadGaji As String) As String
        Dim resp As New ResponseRepository

        dt = KiraElaunHotelTable(jnsTugas, jnsTempat, hadGaji)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function KiraElaunHotelTable(jnsTugas As String, jnsTempat As String, hadGaji As String) As DataTable
        Dim db = New DBKewConn
        Dim had As String
        had = Right(hadGaji, 2)

        Dim query As String = $"SELECT JenisTugas, Tempat, GredDari, GredKe, KadarMkn, KadarHotel,  KadarLojing
                                FROM            SMKB_CLM_KdrMknHtlLjg
                                WHERE (GredDari<=@had AND GredKe >=@had) AND JenisTugas=@JenisTugas AND Tempat=@Tempat"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@had", had))
        param.Add(New SqlParameter("@Tempat", jnsTempat))
        param.Add(New SqlParameter("@JenisTugas", jnsTugas))

        Return db.Read(query, param)
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
        'If dt.Rows.Count > 0 Then
        Return dt
        'End If

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
    Public Function SaveRecordSokong(TerimaDN As TerimaDN) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)

        If TerimaDN Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If TerimaDN.mohonID = "" Then 'untuk permohonan baru
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            If UpdateSokongPTj(TerimaDN) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        If UpdateStatusDokSokongPTj(TerimaDN, TerimaDN.statusDok) <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        End If


        resp.Success("Rekod berjaya disimpan", "00", TerimaDN)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateSokongPTj(TerimaDN As TerimaDN)

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Status_Dok = @status                                
                                WHERE No_Tuntutan = @No_Tuntutan AND Status = 1"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@status", TerimaDN.statusDok))
        param.Add(New SqlParameter("@No_Tuntutan", TerimaDN.mohonID))


        Return db.Process(query, param)
    End Function

    Private Function UpdateStatusDokSokongPTj(TerimaDN As TerimaDN, statusLulus As String)
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
        param.Add(New SqlParameter("@Kod_Status_Dok", TerimaDN.statusDok))
        param.Add(New SqlParameter("@No_Rujukan", TerimaDN.mohonID))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", TerimaDN.catatan))

        Return db.Process(query, param)

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordTuntutan(listClaim As PenerimaDN) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If listClaim Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If UpdatePenerimaLULUS(listClaim) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        End If


        'If UpdateNewOrder(listClaim) <> "OK" Then
        '    'If InsertNewOrder(OtherList) <> "OK" Then
        '    resp.Failed("Gagal Menyimpan order 1266")
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        '    ' Exit Function
        '    'End If
        'End If

        resp.Success("Rekod berjaya disimpan", "00", listClaim)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdatePenerimaLULUS(listClaim As PenerimaDN)
        Dim db As New DBKewConn
        'Dim year = Date.Now.ToString("yyyy")
        'Dim month = Date.Now.Month
        'Dim blnTuntut = month + "/" + year

        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET 
                                Kod_Kump_Wang_Lulus = @Kod_Kump_Wang_Lulus, Kod_Operasi_Lulus = @Kod_Operasi_Lulus, 
                                Kod_Projek_Lulus = @Kod_Projek_Lulus, Kod_PTJ_Lulus = @Kod_PTJ_Lulus 
                                WHERE No_Tuntutan = @No_Tuntutan "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listClaim.OrderID))
        param.Add(New SqlParameter("@Kod_Kump_Wang_Lulus", listClaim.KumpWang))
        param.Add(New SqlParameter("@Kod_Operasi_Lulus", listClaim.KodOperasi))
        param.Add(New SqlParameter("@Kod_Projek_Lulus", listClaim.KodProjek))
        param.Add(New SqlParameter("@Kod_PTJ_Lulus", listClaim.KodPtj))

        Return db.Process(query, param)
    End Function


    Private Function UpdateNewOrder(listClaim As PenerimaDN)


        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Pendahuluan_Hdr SET 
                                Tarikh_Mula = @Tarikh_Mula, Tarikh_Tamat = @Tarikh_Tamat, Justifikasi_Prgm = @TunjukSebab, Peruntukan_Prgm = @Peruntukan_Prgm,  
                                Kod_Kump_Wang = @Kod_Kump_Wang , Kod_Operasi = @Kod_Operasi, Kod_Projek = @Kod_Projek, Kod_PTJ = @Kod_PTJ, Kod_Vot= @Kod_Vot,  
                                 Tkh_Adv_Perlu = @TkhAdvPerlu,  CaraBayar = @CaraBayar 
                                WHERE No_Pendahuluan = @No_Pendahuluan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Pendahuluan", listClaim.OrderID))
        param.Add(New SqlParameter("@PTj", listClaim.KodPtj))
        'param.Add(New SqlParameter("@Tujuan", listClaim.TujuanMohon))
        'param.Add(New SqlParameter("@TunjukSebab", listDetail.TunjukSebab))
        param.Add(New SqlParameter("@Peruntukan_Prgm", listClaim.KodPtj))
        param.Add(New SqlParameter("@Kod_Kump_Wang", listClaim.KumpWang))
        param.Add(New SqlParameter("@Kod_Operasi", listClaim.KodOperasi))
        param.Add(New SqlParameter("@Kod_Projek", listClaim.KodProjek))
        param.Add(New SqlParameter("@Kod_PTJ", listClaim.KodPtj))


        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisProjek(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetDataProjek(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataProjek(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Projek as value,B.Butiran as text FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Projek B ON A.Kod_Projek = B.Kod_Projek"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 and (A.Kod_Projek LIKE '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Operasi =@kod3 order by A.Kod_Projek"
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Operasi =@kod3 order by A.Kod_Projek"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodPtj(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodPtjList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodPtjList(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select distinct Kod_PTJ as value, 
        Kod_PTJ +' - '+(SELECT b.Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT as b
        WHERE b.STATUS = 1 and b.kodpejabat = left(Kod_PTJ,2)) as text
        from SMKB_COA_Master"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where Status = 1 and (Kod_PTJ LIKE '%' + @kod + '%' or 
        (left(Kod_PTJ,2) in (SELECT b.kodpejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT as b
        WHERE b.STATUS = 1 and b.kodpejabat = left(Kod_PTJ,2) and b.Pejabat like '%' + @kod2 + '%'))) order by Kod_PTJ"

            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If



        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisOperasi(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetDataOperasi(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataOperasi(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Operasi as value, B.Butiran As text
                                From SMKB_COA_Master A
                                INNER Join SMKB_Operasi B ON A.Kod_Operasi=B.Kod_Operasi"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 And (A.Kod_Operasi Like '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Kump_Wang =@kod3 order by A.Kod_Operasi"
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Kump_Wang =@kod3 order by A.Kod_Operasi"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisKumpWang(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetDataKumpWang(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataKumpWang(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Kump_Wang as value,B.Butiran as text
                                FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Kump_Wang B ON A.Kod_Kump_Wang=B.Kod_Kump_Wang"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 and (A.Kod_Kump_Wang LIKE '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordKenyataan(kenyataan As PenerimaDN) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        For Each listKenyataan As MaklKenyataan In kenyataan.GroupKenyataan

            If listKenyataan.tujuan = "" Then
                Continue For
            End If

            JumRekod += 1

            If listKenyataan.mohonID <> "" Then

                'updateDataKeperluan--
                If UpdateOrderDetail(listKenyataan) = "OK" Then
                    success += 1

                End If


            Else

            End If
        Next



        resp.Success("Rekod berjaya disimpan", "00", kenyataan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateOrderDetail(listKenyataan As MaklKenyataan)
        Dim db = New DBKewConn
        Dim masaMula As String
        Dim masaTamat As String

        masaMula = listKenyataan.MasaTolakJam + ":" + listKenyataan.MasaTolakMinit
        masaTamat = listKenyataan.MasaSampaiJam + ":" + listKenyataan.MasaSampaiMinit

        Dim query As String = "UPDATE SMKB_Tuntutan_Dlm_Kenyataan
        set Tujuan = @Tujuan, Tarikh = @tkhMula, Masa_Bertolak = @MasaMula, Jarak_Lulus = @Jarak_Lulus, 
        Masa_Sampai = @MasaTamat, Flag_Mula = @flagMula, Flag_Tamat = @flagTamat, No_Kend = @No_Kend, Flag_Kend_Sendiri = @FlagKendSend
        where No_Tuntutan = @NoTuntutan  AND Bil = @bil"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoTuntutan", listKenyataan.mohonID))
        param.Add(New SqlParameter("@bil", listKenyataan.idbil))
        param.Add(New SqlParameter("@tkhMula", listKenyataan.tarikh))
        param.Add(New SqlParameter("@MasaMula", masaMula))
        param.Add(New SqlParameter("@MasaTamat", masaTamat))
        param.Add(New SqlParameter("@Tujuan", listKenyataan.tujuan))
        param.Add(New SqlParameter("@flagMula", listKenyataan.flagMula))
        param.Add(New SqlParameter("@flagTamat", listKenyataan.flagTamat))
        param.Add(New SqlParameter("@No_Kend", listKenyataan.Kenderaan))
        param.Add(New SqlParameter("@FlagKendSend", listKenyataan.staKenderaan))
        param.Add(New SqlParameter("@Jarak_Lulus", listKenyataan.Jarak))
        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordElaunPjln(itemEP As PenerimaDN) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim sumTotal As Decimal = 0.00


        For Each listItemEP As ElaunPjln_ItemDN In itemEP.GroupItemTabElaunPjln

            If listItemEP.strJumJarak = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model
            itemEP.Jumlah = 0.00

            If listItemEP.mohonID <> "" Then
                If semakdataElaunPjln(listItemEP.mohonID, listItemEP.strhidKM) = "wujud" Then
                    itemEP.OrderID = listItemEP.mohonID
                    'updateDataKeperluan--
                    If UpdateDataElaunPjln(listItemEP) = "OK" Then
                        success += 1
                        'listItemEP.strTotalEP += listItemEP.strJumlahEP
                        itemEP.Jumlah += listItemEP.strJumlahEP
                    End If
                Else
                    'insert Data Keperluan
                    listItemEP.strhidKM = GenerateIDDataElaunPjln(listItemEP.mohonID)
                    itemEP.OrderID = listItemEP.mohonID
                    If InsertDataElaunPjln(listItemEP) = "OK" Then
                        success += 1
                        itemEP.Jumlah += listItemEP.strJumlahEP
                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalElaunPjln(itemEP) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", itemEP)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function UpdateTotalElaunPjln(itemEP As PenerimaDN) As String


        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Elaun_Kend_Lulus = @Jumlah_Elaun_Kend_Lulus                                 
                                WHERE No_Tuntutan = @No_Tuntutan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", itemEP.OrderID))
        param.Add(New SqlParameter("@Jumlah_Elaun_Kend_Lulus", itemEP.Jumlah))


        Return db.Process(query, param)
    End Function

    Private Function InsertDataElaunPjln(listItemEP As ElaunPjln_ItemDN)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl_Lulus(No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, Jenis_Kenderaan, No_Plat, KM, Flag_Kongsi_Kend, 
                         Kadar_Harga, Jumlah_anggaran)
                        VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Kenderaan , @No_Plat, @KM, @Flag_Kongsi_Kend,@Kadar_Harga,@Jumlah_anggaran)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listItemEP.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EK"))
        param.Add(New SqlParameter("@No_Item", listItemEP.strhidKM))
        param.Add(New SqlParameter("@Jenis_Kenderaan", listItemEP.strHidJnsK))
        param.Add(New SqlParameter("@No_Plat", listItemEP.strKenderaan))
        param.Add(New SqlParameter("@KM", listItemEP.strJumJarak))
        param.Add(New SqlParameter("@Kadar_Harga", listItemEP.strKadarKM))
        param.Add(New SqlParameter("@Jumlah_anggaran", listItemEP.strJumlahEP))
        param.Add(New SqlParameter("@Flag_Kongsi_Kend", listItemEP.strFlagKend))


        Return db.Process(query, param)
    End Function

    Private Function GenerateIDDataElaunPjln(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl_Lulus 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='EK'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function semakdataElaunPjln(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT   No_Tuntutan, No_Item FROM SMKB_Tuntutan_Dtl_Lulus WHERE No_Tuntutan=@mohonID AND Jns_Dtl_Tuntutan='EK' AND No_Item = @bil"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@bil", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function
    Private Function UpdateDataElaunPjln(listItemEP As ElaunPjln_ItemDN)
        Dim db = New DBKewConn

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl_Lulus
        set Jenis_Kenderaan = @Jenis_Kenderaan, No_Plat = @No_Plat, KM = @KM, Flag_Kongsi_Kend= @Flag_Kongsi_Kend,
        Kadar_Harga = @Kadar_Harga,Jumlah_anggaran = @Jumlah_anggaran 
        where No_Tuntutan = @No_Tuntutan AND No_Item= @No_Item"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listItemEP.mohonID))
        param.Add(New SqlParameter("@KM", listItemEP.strJumJarak))
        param.Add(New SqlParameter("@No_Item", listItemEP.strhidKM))
        param.Add(New SqlParameter("@Jenis_Kenderaan", listItemEP.strHidJnsK))
        param.Add(New SqlParameter("@No_Plat", listItemEP.strKenderaan))
        param.Add(New SqlParameter("@Flag_Kongsi_Kend", listItemEP.strFlagKend))
        param.Add(New SqlParameter("@Kadar_Harga", listItemEP.strKadarKM))
        param.Add(New SqlParameter("@Jumlah_anggaran", listItemEP.strJumlahEP))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadResitTA() As String
        Dim resp As New ResponseRepository
        Dim postedFile As HttpPostedFile = Nothing


        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = ""
        Dim fileSize As String = ""
        Dim checkList As New UploadResitTA_PDN
        Dim savePath As String = ""
        Dim folder As String = ""
        Dim returnURL As String = ""

        checkList.namafile = HttpContext.Current.Request.Form("namafile")
        checkList.idItem = HttpContext.Current.Request.Form("idItem")
        checkList.mohonID = HttpContext.Current.Request.Form("mohonID")
        checkList.ResitNo = HttpContext.Current.Request.Form("NoResit")
        checkList.FlagResit = HttpContext.Current.Request.Form("staResit")
        checkList.JenisKenderaan = HttpContext.Current.Request.Form("JnsKenderaan")
        checkList.Jumlah = HttpContext.Current.Request.Form("jumlah")
        checkList.jumlahSemua = HttpContext.Current.Request.Form("jumlahSemua")

        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        If HttpContext.Current.Request.Files.Count > 0 Then
            postedFile = HttpContext.Current.Request.Files(0)
        End If
        Session("UploadedFileName") = checkList.namafile
        fileName = checkList.namafile
        Try
            If postedFile IsNot Nothing Then
                fileName = postedFile.FileName
                fileSize = postedFile.ContentLength

                ' Convert the base64 string to byte array
                'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

                ' Specify the file path where you want to save the uploaded file
                savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID & "//" & fileName)
                folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

                ' Save the file to the specified path
                postedFile.SaveAs(savePath)
                returnURL = GetBaseUrl() + folder + "/" + fileUpload
                ' Store the uploaded file name in session
                Session("UploadedFileName") = checkList.namafile
            End If



            '---Save File kat table----
            Dim db As New DBKewConn
            Dim BilSemasa As Integer = 1
            ' checkList.idItem = checkList.idItem - BilSemasa

            Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl_Lulus
                                    WHERE  (No_Tuntutan =@No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'TA') AND (No_Item = @No_Item)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
            paramC.Add(New SqlParameter("@No_Item", checkList.idItem))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateResitTambangA(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                checkList.idItem = GenerateIDTblKenderaanAwam(checkList.mohonID)
                If InsertResitTambangA(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            If UpdateTotalTambang(checkList) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If


            resp.SuccessPayload(New With {.FileName = fileName, .Url = returnURL})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function


    Private Function UpdateTotalTambang(checkList As UploadResitTA_PDN) As String

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Tambang_Awam_Lulus = @Jumlah_Tambang_Awam_Lulus                                 
                                WHERE No_Tuntutan = @No_Tuntutan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jumlah_Tambang_Awam_Lulus", checkList.jumlahSemua))


        Return db.Process(query, param)
    End Function
    Private Function InsertResitTambangA(checkList As UploadResitTA_PDN)

        Dim db As New DBKewConn
        Dim fileName As String = Session("UploadedFileName")
        Dim folder As String = ""
        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        If Not String.IsNullOrEmpty(fileName) Then
            folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID
        End If


        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl_Lulus (No_Tuntutan, Jns_Dtl_Tuntutan,Jenis_Tambang,
                No_Item, No_Resit, Jumlah_anggaran, Flag_Resit, Nama_Fail, Path)
                 VALUES(@No_Tuntutan, @Jns_Dtl_Tuntutan, @Jenis_Tambang, @No_Item, @No_Resit, @Jumlah_anggaran,  @Flag_Resit,  @Nama_Fail, @Path)"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@Jenis_Tambang", checkList.JenisKenderaan))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "TA"))
        param.Add(New SqlParameter("@No_Resit", checkList.ResitNo))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Jumlah))
        param.Add(New SqlParameter("@Flag_Resit", checkList.FlagResit))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))
        Return db.Process(query, param)

    End Function

    Private Function GenerateIDTblKenderaanAwam(MohonID As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl_Lulus 
        where No_Tuntutan = @No_Tuntutan AND Jns_Dtl_Tuntutan='TA'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@No_Tuntutan", MohonID))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateResitTambangA(checkList As UploadResitTA_PDN)

        Dim db As New DBKewConn
        Dim fileName As String = Session("UploadedFileName")
        Dim folder As String = ""


        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        If Not String.IsNullOrEmpty(fileName) Then
            folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID
        End If

        Dim queryU As String = "UPDATE  SMKB_Tuntutan_Dtl_Lulus SET Jenis_Tambang = @Jenis_Tambang,
                No_Resit =@No_Resit, Jumlah_anggaran = Jumlah_anggaran, Flag_Resit = @Flag_Resit, Nama_Fail = @Nama_Fail, Path = @Path
                                WHERE  No_Tuntutan = @No_Tuntutan AND No_Item = @No_Item AND (Jns_Dtl_Tuntutan = 'TA')"

        Dim paramU As New List(Of SqlParameter)
        paramU.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        paramU.Add(New SqlParameter("@No_Item", checkList.idItem))
        paramU.Add(New SqlParameter("@Jenis_Tambang", checkList.JenisKenderaan))
        paramU.Add(New SqlParameter("@No_Resit", checkList.ResitNo))
        paramU.Add(New SqlParameter("@Jumlah_anggaran", checkList.Jumlah))
        paramU.Add(New SqlParameter("@Flag_Resit", checkList.FlagResit))
        paramU.Add(New SqlParameter("@Nama_Fail", fileName))
        paramU.Add(New SqlParameter("@Path", folder))

        Return db.Process(queryU, paramU)

    End Function


    'Delete Lampiran
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function BatalUploadResitTA(ByVal id As String, nomohon1 As String) As String
        Dim resp As New ResponseRepository

        'Dim namaFail As String = NamaFailPdf
        Dim noMohon As String = nomohon1

        'Baca data berdasarkan id mohon dan n0 item
        Dim db As New DBKewConn
        Dim clone As Integer = 1
        id = id - clone
        Dim namaFail As String

        Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl_Lulus
                                    WHERE  (No_Tuntutan =@No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'TA') AND (No_Item = @No_Item)"

        Dim paramC As New List(Of SqlParameter)
        paramC.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        paramC.Add(New SqlParameter("@No_Item", id))

        dt = db.Read(queryC, paramC)

        If dt.Rows.Count > 0 Then
            namaFail = dt.Rows(0).Item("Nama_Fail")
        Else
            namaFail = ""
        End If



        If Query_deleteLampiran(id, nomohon1) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim filePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & noMohon & "/" & namaFail
        If System.IO.File.Exists(filePath) Then
            System.IO.File.Delete(filePath)
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deleteLampiran(id As String, nomohon1 As String)
        Dim db As New DBKewConn


        Dim query As String = "DELETE  FROM SMKB_Tuntutan_Dtl_Lulus
                            WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'TA') AND (No_Item = @No_Item)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        param.Add(New SqlParameter("@No_Item", id))


        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordElaunMakan(itemElaunMakan As PenerimaDN) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim sumTotal As Decimal = 0.00


        For Each listElaunMkn As ElaunMakanDN In itemElaunMakan.GroupElaunMakan

            If listElaunMkn.EM_mohonID = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model
            listElaunMkn.EM_harga = 0.00
            If listElaunMkn.EM_mohonID <> "" Then
                If semakdataElaunMakan(listElaunMkn.EM_mohonID, listElaunMkn.EM_hidID) = "wujud" Then
                    'updateDataKeperluan--
                    itemElaunMakan.OrderID = listElaunMkn.EM_mohonID
                    If UpdateDataElaunMakan(listElaunMkn) = "OK" Then
                        success += 1
                        listElaunMkn.EM_harga += listElaunMkn.EM_Jumlah
                    End If
                Else
                    'insert Data Keperluan
                    listElaunMkn.EM_hidID = GenerateIDDataElaunMakan(listElaunMkn.EM_mohonID)
                    itemElaunMakan.OrderID = listElaunMkn.EM_mohonID
                    If InsertDataElaunMakan(listElaunMkn) = "OK" Then
                        success += 1
                        listElaunMkn.EM_harga += listElaunMkn.EM_Jumlah
                    End If
                End If
                'listElaunMkn.EM_hidID = listElaunMkn.EM_hidID + 1
            Else

            End If
            listElaunMkn.EM_hidID = listElaunMkn.EM_hidID + 1
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
    Private Function UpdateTotalElaunMakan(itemElaunMakan As PenerimaDN)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Elaun_Mkn_Lulus = @Jumlah_Elaun_Mkn_Lulus                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", itemElaunMakan.OrderID))
        param.Add(New SqlParameter("@Jumlah_Elaun_Mkn_Lulus", itemElaunMakan.Jumlah))

        Return db.Process(query, param)
    End Function

    Private Function InsertDataElaunMakan(listElaunMkn As ElaunMakanDN)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl_Lulus(No_Tuntutan, Jns_Dtl_Tuntutan,No_Item, Jenis_Tempat, Jenis_Tugas, 
                      Flag_Mkn_Pagi, Flag_Mkn_Tghari,Flag_Mkn_Mlm, Flag_Elaun_Harian, Bil_Hari, Kadar_Harga, Jumlah_anggaran)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Tempat,@Jenis_Tugas, @Flag_Mkn_Pagi,@Flag_Mkn_Tghari,@Flag_Mkn_Mlm,@Flag_Elaun_Harian,
                    @Bil_Hari,@Kadar_Harga, @Jumlah_anggaran)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listElaunMkn.EM_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EM"))
        param.Add(New SqlParameter("@No_Item", listElaunMkn.EM_hidID))
        param.Add(New SqlParameter("@Jenis_Tempat", listElaunMkn.EM_tempat))
        param.Add(New SqlParameter("@Jenis_Tugas", listElaunMkn.EM_JnsPerjalanan))
        param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMkn.EM_MknPagi))
        param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMkn.EM_MknTghri))
        param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMkn.EM_MknMlm))
        param.Add(New SqlParameter("@Flag_Elaun_Harian", listElaunMkn.EM_ElaunHarian))
        param.Add(New SqlParameter("@Bil_Hari", listElaunMkn.EM_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", listElaunMkn.EM_harga))
        param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMkn.EM_Jumlah))


        Return db.Process(query, param)
    End Function
    Private Function GenerateIDDataElaunMakan(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl_Lulus 
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

    Private Function UpdateDataElaunMakan(listElaunMkn As ElaunMakanDN)
        Dim db = New DBKewConn

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl_Lulus
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas,Flag_Mkn_Pagi = @Flag_Mkn_Pagi,
        Flag_Mkn_Tghari = @Flag_Mkn_Tghari, Flag_Mkn_Mlm = @Flag_Mkn_Mlm,Bil_Hari = @Bil_Hari,  Kadar_Harga = @Kadar_Harga, 
        Jumlah_anggaran = @Jumlah_anggaran
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EM'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listElaunMkn.EM_mohonID))
        param.Add(New SqlParameter("@No_Item", listElaunMkn.EM_hidID))
        param.Add(New SqlParameter("@Jenis_Tempat", listElaunMkn.EM_tempat))
        param.Add(New SqlParameter("@Jenis_Tugas", listElaunMkn.EM_JnsPerjalanan))
        param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMkn.EM_MknPagi))
        param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMkn.EM_MknTghri))
        param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMkn.EM_MknMlm))
        param.Add(New SqlParameter("@Bil_Hari", listElaunMkn.EM_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", listElaunMkn.EM_harga))
        param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMkn.EM_Jumlah))

        Return db.Process(query, param)
    End Function
    Private Function semakdataElaunMakan(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT  No_Tuntutan, No_Item FROM SMKB_Tuntutan_Dtl_Lulus Where No_Tuntutan =@mohonID AND No_Item = @id AND Jns_Dtl_Tuntutan='EM'"
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
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadSewaHotel() As String
        Dim resp As New ResponseRepository
        Dim postedFile As HttpPostedFile = Nothing
        ' Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileSurat")

        Dim checkList As New UploadResitTblSewaHotelDN


        checkList.idItem = HttpContext.Current.Request.Form("idItem")
        checkList.mohonID = HttpContext.Current.Request.Form("mohonID")
        checkList.Hotel_noResit = HttpContext.Current.Request.Form("Hotel_noResit")
        checkList.Hotel_bilHari = HttpContext.Current.Request.Form("Hotel_bilHari")
        checkList.Hotel_jnsTugas = HttpContext.Current.Request.Form("Hotel_jnsTugas")
        checkList.Hotel_JnsTempat = HttpContext.Current.Request.Form("Hotel_JnsTempat")
        checkList.Hotel_ElaunHarian = HttpContext.Current.Request.Form("Hotel_ElaunHarian")
        checkList.Hotel_Jumlah = HttpContext.Current.Request.Form("Hotel_Jumlah")
        checkList.totalTabSewaHotel = HttpContext.Current.Request.Form("totalTabSewaHotel")
        checkList.namafile = HttpContext.Current.Request.Form("fileSurat")
        'totalSewaLojing += checkList.Hotel_Jumlah


        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)


        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)
            ' semak path dah wujud ke blom
            'If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            '    System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
            'End If

            ' Specify the file path where you want to save the uploaded file
            'Dim savePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID & "//" & fileName)
            Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

            ' Save the file to the specified path
            'postedFile.SaveAs(savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = checkList.namafile

            '---Save File kat table----
            Dim db As New DBKewConn

            Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl_Lulus
                                    WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EH') AND (No_Resit = @No_Resit)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
            paramC.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateDataSewaHotel(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                checkList.idItem = GenerateIDDataSewaHotel(checkList.mohonID)
                If InsertDataSewaHotel(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            'ni tuk total keseluruhan masuk ke tblsmkb_tuntutan_Hdr
            If UpdateTotalSewaHotel(checkList) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If


            resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function


    Private Function UpdateTotalSewaHotel(checkList As UploadResitTblSewaHotelDN)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing_Lulus = @Jumlah_Sewa_HotelLojing_Lulus                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing_Lulus", checkList.totalTabSewaHotel))

        Return db.Process(query, param)
    End Function
    Private Function InsertDataSewaHotel(checkList As UploadResitTblSewaHotelDN)
        Dim db As New DBKewConn
        Dim fileName As String = checkList.namafile

        ' Store the uploaded file name in session


        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl_Lulus (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                    Jenis_Tempat, Jenis_Tugas, Bil_Hari, Jenis_Penginapan, Kadar_Harga, Jumlah_anggaran, Nama_Fail, Path)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tempat, @Jenis_Tugas, @Bil_Hari,
                            @Jenis_Penginapan,@Kadar_Harga,@Jumlah_anggaran,  @Nama_Fail, @Path)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Hotel_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Hotel_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Hotel_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Hotel_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Hotel_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))


        Return db.Process(query, param)
    End Function

    Private Function GenerateIDDataSewaHotel(MohonID As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl_Lulus 
        where No_Tuntutan = @No_Tuntutan AND Jns_Dtl_Tuntutan='EH'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@No_Tuntutan", MohonID))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateDataSewaHotel(checkList As UploadResitTblSewaHotelDN)
        Dim db = New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl_Lulus
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas, Bil_Hari = @Bil_Hari, 
        No_Resit = @No_Resit, Kadar_Harga=@Kadar_Harga, Jumlah_anggaran = @Jumlah_anggaran, Nama_Fail = @Nama_Fail, Path = @Path
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EH' "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Hotel_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Hotel_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Hotel_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Hotel_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Hotel_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function


    'Delete Data Sewa Hotel
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PadamDataSewaHotel(ByVal id As String, nomohon1 As String) As String
        Dim resp As New ResponseRepository

        'Dim namaFail As String = NamaFailPdf
        Dim noMohon As String = nomohon1

        'Baca data berdasarkan id mohon dan n0 item
        Dim db As New DBKewConn
        Dim clone As Integer = 1
        'id = id - clone
        Dim namaFail As String

        Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl_Lulus
                                    WHERE  (No_Tuntutan =@No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EH') AND (No_Item = @No_Item)"

        Dim paramC As New List(Of SqlParameter)
        paramC.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        paramC.Add(New SqlParameter("@No_Item", id))

        dt = db.Read(queryC, paramC)

        If dt.Rows.Count > 0 Then
            namaFail = dt.Rows(0).Item("Nama_Fail")
        Else
            namaFail = ""
        End If



        If Query_deleteDataSewaHotel(id, nomohon1) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim filePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & noMohon & "/" & namaFail
        If System.IO.File.Exists(filePath) Then
            System.IO.File.Delete(filePath)
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function Query_deleteDataSewaHotel(id As String, nomohon1 As String)
        Dim db As New DBKewConn


        Dim query As String = "DELETE  FROM SMKB_Tuntutan_Dtl_Lulus
                            WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EH') AND (No_Item = @No_Item)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        param.Add(New SqlParameter("@No_Item", id))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadElaunLojing() As String
        Dim resp As New ResponseRepository
        Dim postedFile As HttpPostedFile = Nothing
        'Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        Dim checkList As New UploadTblLojingDN

        checkList.idItem = HttpContext.Current.Request.Form("idItem")
        checkList.mohonID = HttpContext.Current.Request.Form("mohonID")
        checkList.Lojing_noResit = HttpContext.Current.Request.Form("Lojing_noResit")
        checkList.Lojing_bilHari = HttpContext.Current.Request.Form("Lojing_bilHari")
        checkList.Lojing_jnsTugas = HttpContext.Current.Request.Form("Lojing_jnsTugas")
        checkList.Lojing_JnsTempat = HttpContext.Current.Request.Form("Lojing_JnsTempat")
        checkList.Lojing_ElaunHarian = HttpContext.Current.Request.Form("Lojing_ElaunHarian")
        checkList.Lojing_Jumlah = HttpContext.Current.Request.Form("Lojing_Jumlah")
        checkList.Lojing_Alamat = HttpContext.Current.Request.Form("Lojing_Alamat")
        checkList.totalTabSewaHotel = HttpContext.Current.Request.Form("totalTabSewaHotel")

        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)


        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)
            ' semak path dah wujud ke blom
            'If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            '    System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
            'End If

            ' Specify the file path where you want to save the uploaded file
            ' Dim savePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID & "//" & fileName)
            Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

            ' Save the file to the specified path
            'postedFile.SaveAs(savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileUpload

            '---Save File kat table----
            Dim db As New DBKewConn

            Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl_Lulus
                                    WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EL') AND (No_Item = @No_Item)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
            paramC.Add(New SqlParameter("@No_Item", checkList.idItem))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateDataElaunLojing(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                checkList.idItem = GenerateIDElaunLojing(checkList.mohonID)
                If InsertDataElaunLojing(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            'ni tuk total keseluruhan masuk ke tblsmkb_tuntutan_Hdr
            If UpdateTotalLojing(checkList) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If


            resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    Private Function UpdateTotalLojing(checkList As UploadTblLojingDN)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing_Lulus = @Jumlah_Sewa_HotelLojing_Lulus                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing_Lulus", checkList.totalTabSewaHotel))

        Return db.Process(query, param)
    End Function
    Private Function InsertDataElaunLojing(checkList As UploadTblLojingDN)
        Dim db As New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl_Lulus (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                        Jenis_Tempat, Jenis_Tugas, Bil_Hari, Jenis_Penginapan, Kadar_Harga, Jumlah_anggaran, Nama_Fail, Path,Alamat_Lojing )
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tempat, @Jenis_Tugas, @Bil_Hari,
                      @Jenis_Penginapan,@Kadar_Harga,@Jumlah_anggaran,  @Nama_Fail, @Path, @Alamat_Lojing)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EL"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Lojing_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Lojing_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Lojing_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Lojing_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "L"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Lojing_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Lojing_Jumlah))
        param.Add(New SqlParameter("@Alamat_Lojing", checkList.Lojing_Alamat))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function UpdateDataElaunLojing(checkList As UploadTblLojingDN)
        Dim db = New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl_Lulus
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas, Bil_Hari = @Bil_Hari, 
        No_Resit = @No_Resit, Kadar_Harga=@Kadar_Harga, Jumlah_anggaran = @Jumlah_anggaran,
        Nama_Fail = @Nama_Fail, Path = @Path, Alamat_Lojing = @Alamat_Lojing
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EL' "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EL"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Lojing_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Lojing_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Lojing_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Lojing_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "L"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Lojing_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Lojing_Jumlah))
        param.Add(New SqlParameter("@Alamat_Lojing", checkList.Lojing_Alamat))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function GenerateIDElaunLojing(MohonID As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl_Lulus 
        where No_Tuntutan = @No_Tuntutan AND Jns_Dtl_Tuntutan='EL'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@No_Tuntutan", MohonID))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function

    'Delete Data PadamDataHotelLojing
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PadamDataHotelLojing(ByVal id As String, nomohon1 As String) As String
        Dim resp As New ResponseRepository

        'Dim namaFail As String = NamaFailPdf
        Dim noMohon As String = nomohon1

        'Baca data berdasarkan id mohon dan n0 item
        Dim db As New DBKewConn
        Dim clone As Integer = 1
        'id = id - clone
        Dim namaFail As String

        Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl_Lulus
                                    WHERE  (No_Tuntutan =@No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EL') AND (No_Item = @No_Item)"

        Dim paramC As New List(Of SqlParameter)
        paramC.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        paramC.Add(New SqlParameter("@No_Item", id))

        dt = db.Read(queryC, paramC)

        If dt.Rows.Count > 0 Then
            namaFail = dt.Rows(0).Item("Nama_Fail")
        Else
            namaFail = ""
        End If



        If Query_deleteDataHotelLojing(id, nomohon1) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim filePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & noMohon & "/" & namaFail
        If System.IO.File.Exists(filePath) Then
            System.IO.File.Delete(filePath)
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function Query_deleteDataHotelLojing(id As String, nomohon1 As String)
        Dim db As New DBKewConn


        Dim query As String = "DELETE  FROM SMKB_Tuntutan_Dtl_Lulus
                            WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EL') AND (No_Item = @No_Item)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        param.Add(New SqlParameter("@No_Item", id))


        Return db.Process(query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadTblBP() As String
        Dim resp As New ResponseRepository
        Dim fileName As String = ""

        Dim postedFile As HttpPostedFile = Nothing
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim returnURL As String = ""
        Dim list As New UploadResitTblBPDN
        Dim savePath As String = ""
        Dim folder As String = ""

        list.idItem = HttpContext.Current.Request.Form("idItem")
        list.mohonID = HttpContext.Current.Request.Form("mohonID")
        list.ResitNo = HttpContext.Current.Request.Form("NoResit")
        list.FlagResit = HttpContext.Current.Request.Form("staResit")
        list.JenisBelanjaP = HttpContext.Current.Request.Form("JnsBelanjeP")
        list.Jumlah = HttpContext.Current.Request.Form("jumlah")


        'Check if File is available.
        'If HttpContext.Current.Request.Files.Count > 0 Then
        '    postedFile = HttpContext.Current.Request.Files(0)
        'End If

        Session("UploadedFileName") = fileUpload

        Try

            If postedFile IsNot Nothing Then
                fileName = fileUpload


                ' Convert the base64 string to byte array
                'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

                ' Specify the file path where you want to save the uploaded file
                savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & list.mohonID & "/" & fileName)
                folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & list.mohonID

                ' Save the file to the specified path
                postedFile.SaveAs(savePath)
                returnURL = GetBaseUrl() + folder + "/" + fileName
                ' Store the uploaded file name in session
                Session("UploadedFileName") = fileName
            End If

            '---Save File kat table----
            Dim db As New DBKewConn

            Dim queryC As String = $"Select No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl_Lulus
                                    WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'BP') AND (No_Item = @No_Item)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", list.mohonID))
            paramC.Add(New SqlParameter("@No_Item", list.idItem))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateDataPelbagai(list) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                list.idItem = GenerateIDPelbagai(list.mohonID)
                If InsertDataPelbagai(list) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            If UpdateTotalPelbagai(list) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If

            If fileName <> "" Then

                resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Else
                resp.Failed("Data Telah Dikemaskini")
            End If

            'resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    Private Function UpdateTotalPelbagai(list As UploadResitTblBPDN) As String

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Belanja_Pelbagai_Lulus = @Jumlah_Belanja_Pelbagai_Lulus                                 
                                WHERE No_Tuntutan = @No_Tuntutan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", list.mohonID))
        param.Add(New SqlParameter("@Jumlah_Belanja_Pelbagai_Lulus", list.Jumlah))


        Return db.Process(query, param)
    End Function
    Private Function UpdateDataPelbagai(list As UploadResitTblBPDN)
        Dim db = New DBKewConn

        Dim fileName As String = HttpContext.Current.Request.Form("fileSurat")
        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName
        'Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/"


        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & list.mohonID

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl_Lulus
        set Jenis_Belanja_Pelbagai = @Jenis_Belanja_Pelbagai, Flag_Resit = @Flag_Resit, No_Resit = @No_Resit, 
        Jumlah_anggaran = @Jumlah_anggaran, Nama_Fail = @Nama_Fail, Path = @Path
        where No_Tuntutan= @No_Tuntutan AND  No_Item = @No_Item AND Jns_Dtl_Tuntutan= @Jns_Dtl_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", list.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "BP"))
        param.Add(New SqlParameter("@No_Item", list.idItem))
        param.Add(New SqlParameter("@Jenis_Belanja_Pelbagai", list.JenisBelanjaP))
        param.Add(New SqlParameter("@Flag_Resit", list.FlagResit))
        param.Add(New SqlParameter("@No_Resit", list.ResitNo))
        param.Add(New SqlParameter("@Jumlah_anggaran", list.Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function GenerateIDPelbagai(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl_Lulus 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='BP'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function

    Private Function InsertDataPelbagai(list As UploadResitTblBPDN)
        Dim db As New DBKewConn

        Dim fileName As String = HttpContext.Current.Request.Form("fileSurat")
        Dim mohonId As String = list.mohonID
        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName
        'Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/"

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & list.mohonID

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl_Lulus(No_Tuntutan, Jns_Dtl_Tuntutan, No_Item,   Jenis_Belanja_Pelbagai,  Flag_Resit, No_Resit,  
                         Jumlah_anggaran, Nama_Fail,Path)
                        VALUES(@No_Tuntutan, @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Belanja_Pelbagai , @Flag_Resit, @No_Resit, @Jumlah_anggaran, @Nama_Fail,@Path)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", list.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "BP"))
        param.Add(New SqlParameter("@No_Item", list.idItem))
        param.Add(New SqlParameter("@Jenis_Belanja_Pelbagai", list.JenisBelanjaP))
        param.Add(New SqlParameter("@Flag_Resit", list.FlagResit))
        param.Add(New SqlParameter("@No_Resit", list.ResitNo))
        param.Add(New SqlParameter("@Jumlah_anggaran", list.Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))


        Return db.Process(query, param)
    End Function


    'Delete Data PadamDataPelbagai
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PadamDataPelbagai(ByVal id As String, nomohon1 As String) As String
        Dim resp As New ResponseRepository

        'Dim namaFail As String = NamaFailPdf
        Dim noMohon As String = nomohon1

        'Baca data berdasarkan id mohon dan n0 item
        Dim db As New DBKewConn
        Dim clone As Integer = 1
        'id = id - clone
        Dim namaFail As String

        Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl_Lulus
                                    WHERE  (No_Tuntutan =@No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'BP') AND (No_Item = @No_Item)"

        Dim paramC As New List(Of SqlParameter)
        paramC.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        paramC.Add(New SqlParameter("@No_Item", id))

        dt = db.Read(queryC, paramC)

        If dt.Rows.Count > 0 Then
            namaFail = dt.Rows(0).Item("Nama_Fail")
        Else
            namaFail = ""
        End If



        If Query_deleteDataPelbagai(id, nomohon1) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim filePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & noMohon & "/" & namaFail
        If System.IO.File.Exists(filePath) Then
            System.IO.File.Delete(filePath)
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function Query_deleteDataPelbagai(id As String, nomohon1 As String)
        Dim db As New DBKewConn


        Dim query As String = "DELETE  FROM SMKB_Tuntutan_Dtl_Lulus
                            WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'BP') AND (No_Item = @No_Item)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        param.Add(New SqlParameter("@No_Item", id))


        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisSumbangan(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisSumbangan(q)
        Return JsonConvert.SerializeObject(tmpDT)
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

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveJumlahPelbagai(id As String, total As Decimal) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Belanja_Pelbagai = @Jumlah_Belanja_Pelbagai                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))
        param.Add(New SqlParameter("@Jumlah_Belanja_Pelbagai", total))

        Return db.Process(query, param)

        resp.Success("Rekod berjaya disimpan", "00", "")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallDataSumbangan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Kod_Tabung, c.Butiran, b.Jumlah_anggaran, a.Jum_Sumbangan
                            From SMKB_Tuntutan_Hdr as a INNER JOIN
                            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                            SMKB_Ptj_Tabung as c ON b.Kod_Tabung = c.Kod_Tabung
                            WHERE a.No_Tuntutan = @No_Tuntutan AND b.Jns_Dtl_Tuntutan='ST' ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
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

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordSumbanganDN(tabungDN As PenerimaDN) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        For Each listSumbangan As tblSumbanganDN In tabungDN.GroupSumbanganDN

            If listSumbangan.mohonID = "" Then
                Continue For
            End If

            JumRekod += 1

            If listSumbangan.mohonID <> "" Then
                If semakdataSumbangan(listSumbangan.mohonID, listSumbangan.KodTabung) = "wujud" Then
                    'updateDataKeperluan--
                    'If UpdateOrderDetail(listSumbangan) = "OK" Then
                    '    success += 1

                    'End If
                Else
                    'insert Data Keperluan
                    listSumbangan.idbil = GenerateOrderDetailIDSumbangan(listSumbangan.mohonID)
                    listSumbangan.mohonID = tabungDN.OrderID
                    If InsertDataItem(listSumbangan) = "OK" Then
                        success += 1

                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalSumbangan(tabungDN) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", tabungDN)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function UpdateTotalSumbangan(tabungDN As PenerimaDN)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jum_Sumbangan = @Jum_Sumbangan                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", tabungDN.OrderID))
        param.Add(New SqlParameter("@Jum_Sumbangan", tabungDN.Jumlah))

        Return db.Process(query, param)
    End Function

    Private Function GenerateOrderDetailIDSumbangan(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "SELECT TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId  AND Jns_Dtl_Tuntutan='ST'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
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

    Private Function InsertDataItem(listSumbangan As tblSumbanganDN)
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
End Class