Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data.SqlClient
Imports System.IO
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports SMKB_Web_Portal.PengesahanLN

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PengesahanLN_WS
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
                a.Kod_PTJ,  (SELECT b.Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT as b WHERE b.STATUS = 1 and b.kodpejabat = left(a.Kod_PTJ,2)) as ButiranPTJ  ,
                 a.Status_Dok,a.Tujuan_Tuntutan,FORMAT(a.Tkh_Bertolak, 'yyyy-MM-dd') AS Tkh_Bertolak, a.Bertolak_Dari, a.Masa_Bertolak,
                substring(CONVERT(varchar,a.Masa_Bertolak,108),1,2) as jamSampai, substring(CONVERT(varchar,a.Masa_Bertolak,108),4,2) as minitSampai,
                b.Butiran, a.No_Staf + ' - ' + c.ms01_nama   as NamaPemohon, a.No_Staf as Nopemohon
                FROM SMKB_Tuntutan_Hdr as a INNER JOIN 
                SMKB_Kod_Status_Dok AS b ON a.Status_Dok = b.Kod_Status_Dok INNER JOIN
                [qa11].dbStaf.dbo.MS01_Peribadi as c ON a.No_Staf = c.ms01_noStaf
                WHERE  (b.Kod_Modul = '09') AND (b.Kod_Status_Dok = '02') AND (a.Jenis_Tuntutan ='LN')  " & tarikhQuery & " order by a.Tarikh_Mohon desc"
        ' WHERE a.Status_Dok='01' AND a.Pengesahan_Pemohon='0' " & tarikhQuery & " order by a.Tarikh_Mohon desc"

        param.Add(New SqlParameter("@staffP", staffP))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetUserInfo(nostaf As String)
        Dim db As New DBSMConn
        Dim query As String = $"SELECT  MS01_NoStaf as StafNo, MS01_Nama as Param1, 
                                MS08_Pejabat as Param2, JawGiliran as Param3, Kumpulan as Param4, 
                                Singkatan as Param5, MS02_GredGajiS as Param6, 
                                MS02_JumlahGajiS,  MS01_TelPejabat as Param7,  MS02_Kumpulan
                                FROM VK_AdvClm WHERE MS01_NoStaf = '{nostaf}'"
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

        Return JsonConvert.SerializeObject(resp.GetResult())
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


        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@No_Permohonan", id))

        'Return db.Read(query, param)
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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataPengesahanLN(id As String)
        Dim db As New DBKewConn
        Dim query As String = $"SELECT No_Tuntutan, FORMAT(Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon, 
                                No_Pendahuluan, Jum_Pendahuluan, No_Baucar, 
                                Jumlah_Elaun_Mkn, Jumlah_Sewa_HotelLojing,Jum_Sumbangan, 
                                Jumlah_Belanja_Pelbagai
                                FROM            SMKB_Tuntutan_Hdr
                                WHERE (No_Tuntutan = '{id}')"



        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

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


    Private Function CallRecordElaunLojing(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT  a.No_Tuntutan, b.Jns_Dtl_Tuntutan, b.No_Item, b.Bil_Hari, b.Jenis_Penginapan, 
                    b.Jenis_Tugas,h.Butiran AS JenisTugas, 
                    b.Kadar_Harga, b.No_Resit, b.Jumlah_anggaran, c.Butiran,  b.Path, b.Nama_Fail, b.Negara, b.Matawang, 
                    b.Kadar_Pertukaran
                    FROM            SMKB_Tuntutan_Hdr AS a INNER JOIN
                    SMKB_Tuntutan_Dtl AS b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                    SMKB_Lookup_Detail AS c ON b.Jenis_Penginapan = c.Kod_Detail INNER JOIN
                    SMKB_Lookup_Detail AS h ON h.Kod_Detail = b.Jenis_Tugas
                    WHERE        (c.Kod = 'AC01') AND (h.Kod = 'AC04') AND (b.Jns_Dtl_Tuntutan = 'EL') AND (a.No_Tuntutan = @No_Tuntutan)
                    ORDER BY b.No_Item"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function



    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function kiraElaunHotel(ByVal jnsTugas As String, ByVal jnsNegara As String) As String
        Dim resp As New ResponseRepository

        dt = KiraElaunHotelTable(jnsTugas, jnsNegara)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function KiraElaunHotelTable(jnsTugas As String, jnsNegara As String) As DataTable
        Dim db = New DBKewConn


        Dim query As String = $"SELECT        a.Kategori, a.JenisTugas, a.SewaHotel, a.ElnLojing, b.Negara
                        FROM            SMKB_CLM_KdrLuarNegara AS a INNER JOIN						
                        SMKB_CLM_Kump_Negara as b ON a.Kategori = b.Kategori  INNER JOIN
						SMKB_Tuntutan_Dlm_Kenyataan AS c ON c.Negara = b.Negara 
                        WHERE b.Negara = @jnsNegara AND a.JenisTugas= @jnsTugas"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@jnsNegara", jnsNegara))
        param.Add(New SqlParameter("@jnsTugas", jnsTugas))

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

        Dim query As String = "SELECT  a.No_Tuntutan, b.Jns_Dtl_Tuntutan, b.No_Item, b.Bil_Hari, b.Jenis_Penginapan, 
                    b.Jenis_Tugas,h.Butiran AS JenisTugas, 
                    b.Kadar_Harga, b.No_Resit, b.Jumlah_anggaran, c.Butiran,  b.Path, b.Nama_Fail, b.Negara, b.Matawang, 
                    b.Kadar_Pertukaran
                    FROM            SMKB_Tuntutan_Hdr AS a INNER JOIN
                    SMKB_Tuntutan_Dtl AS b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                    SMKB_Lookup_Detail AS c ON b.Jenis_Penginapan = c.Kod_Detail INNER JOIN
                    SMKB_Lookup_Detail AS h ON h.Kod_Detail = b.Jenis_Tugas
                    WHERE        (c.Kod = 'AC01') AND (h.Kod = 'AC04') AND (b.Jns_Dtl_Tuntutan = 'EH') AND (a.No_Tuntutan = @No_Tuntutan)
                    ORDER BY b.No_Item"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
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

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordSokong(SokongLN As SokongLN) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)

        If SokongLN Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If SokongLN.mohonID = "" Then 'untuk permohonan baru
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            If UpdateSokongPTj(SokongLN) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If

        If UpdateStatusDokSokongPTj(SokongLN, SokongLN.statusDok) <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        End If


        resp.Success("Rekod berjaya disimpan", "00", SokongLN)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateSokongPTj(SokongLN As SokongLN)

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Status_Dok = @status                                
                                WHERE No_Tuntutan = @No_Tuntutan AND Status = 1"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@status", SokongLN.statusDok))
        param.Add(New SqlParameter("@No_Tuntutan", SokongLN.mohonID))


        Return db.Process(query, param)
    End Function

    Private Function UpdateStatusDokSokongPTj(SokongLN As SokongLN, statusLulus As String)
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
        param.Add(New SqlParameter("@Kod_Status_Dok", SokongLN.statusDok))
        param.Add(New SqlParameter("@No_Rujukan", SokongLN.mohonID))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", SokongLN.catatan))

        Return db.Process(query, param)

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
                where  a.Status_Dok ='02' AND a.No_Tuntutan='{mohonID}' "

        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
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
End Class