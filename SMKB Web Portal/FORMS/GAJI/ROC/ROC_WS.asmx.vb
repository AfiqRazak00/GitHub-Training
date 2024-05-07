Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols

Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class ROC_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim BulanGaji As String
    Dim TahunGaji As String
    'Private strConnx As String = "Data Source=devmis12.utem.edu.my;Initial Catalog=dbKewanganV4;Persist Security Info=True;User ID=smkb;Password=Smkb@Dev2012"



    Public Function HelloWorld() As String
        Return "Hello World"
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBlnGaji()
        Dim db As New DBKewConn
        Dim dbconn As New DBKewConn


        dt = DBConn.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            BulanGaji = dt.Rows(0).Item("bulan").ToString()
            TahunGaji = dt.Rows(0).Item("tahun").ToString()
        End If
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListROC() As String
        Dim resp As New ResponseRepository


        dt = GetListROC()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListUbahROC() As String
        Dim resp As New ResponseRepository


        dt = GetListUbahROC()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRumusROC()
        Dim db As New DBKewConn

        Dim thngj As String = ""
        Dim blngj As String = ""
        Dim dt2 As New DataTable

        dt2 = db.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt2.Rows.Count > 0 Then
            blngj = dt2.Rows(0).Item("bulan").ToString()
            thngj = dt2.Rows(0).Item("tahun").ToString()
        End If


        Dim query As String = $"Select  distinct sum(z.jumroc) totroc,sum(z.jumbelum) totbelum,sum(z.jumterima) totterima from (
        Select  count(distinct a.MS15_NoRoc) As jumroc,0 jumbelum,0 As jumterima From {DBStaf}MS15_ROC a ,{DBStaf}ROC01_Butir b 
        where a.MS15_NoRoc = b.MS15_NoRoc And
        Year(MS15_TkhDisahkan) = '{thngj}' And Month(MS15_TkhDisahkan) = '{blngj}' And b.ROC01_KumpButiran in ('1','2')
        And MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC) 
        union all
        Select  0 As jumroc,count(distinct a.MS15_NoRoc) jumbelum,0 As jumterima From {DBStaf}MS15_ROC a ,{DBStaf}ROC01_Butir b 
        where a.MS15_NoRoc = b.MS15_NoRoc And a.MS15_StaBendahari Is NULL And
        Year(MS15_TkhDisahkan) = '{thngj}' And Month(MS15_TkhDisahkan) = '{blngj}' And b.ROC01_KumpButiran in ('1','2')
        And MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC) 
        union all 
        Select 0 As jumroc,0 jumbelum,count(distinct a.MS15_NoRoc) As jumterima From {DBStaf}MS15_ROC a,{DBStaf}ROC01_Butir b  where 
        a.MS15_NoRoc = b.MS15_NoRoc And Year(MS15_TkhDisahkan) = '{thngj}' And Month(MS15_TkhDisahkan) = '{blngj}' And a.MS15_StaBendahari Is Not NULL
        And b.ROC01_KumpButiran in ('1','2') And MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC)  ) z;"

        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRumusSahROC()
        Dim db As New DBKewConn
        Dim thngj As String = ""
        Dim blngj As String = ""
        Dim dt2 As New DataTable

        dt2 = db.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt2.Rows.Count > 0 Then
            blngj = dt2.Rows(0).Item("bulan").ToString()
            thngj = dt2.Rows(0).Item("tahun").ToString()
        End If

        Dim query As String = $"Select  distinct sum(z.jumroc) totroc,sum(z.jumbelum) totbelum,sum(z.jumterima) totterima from (
        Select  count(distinct a.MS15_NoRoc) As jumroc,0 jumbelum,0 As jumterima From {DBStaf}MS15_ROC a ,{DBStaf}ROC01_Butir b 
        where a.MS15_NoRoc = b.MS15_NoRoc And
        Year(MS15_TkhDisahkan) = '{thngj}' And Month(MS15_TkhDisahkan) = '{blngj}' And b.ROC01_KumpButiran in ('1','2')
        And MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC) 
        union all
        Select  0 As jumroc,count(distinct a.MS15_NoRoc) jumbelum,0 As jumterima From {DBStaf}MS15_ROC a ,{DBStaf}ROC01_Butir b 
        where a.MS15_NoRoc = b.MS15_NoRoc And a.MS15_StaBendahari Is NULL And
        Year(MS15_TkhDisahkan) = '{thngj}' And Month(MS15_TkhDisahkan) = '{blngj}' And b.ROC01_KumpButiran in ('1','2')
        And MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC) 
        union all 
        Select 0 As jumroc,0 jumbelum,count(distinct a.MS15_NoRoc) As jumterima From {DBStaf}MS15_ROC a,{DBStaf}ROC01_Butir b  where 
        a.MS15_NoRoc = b.MS15_NoRoc And Year(MS15_TkhDisahkan) = '{thngj}' And Month(MS15_TkhDisahkan) = '{blngj}' And a.MS15_StaBendahari Is Not NULL
        And b.ROC01_KumpButiran in ('1','2') And MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC)  ) z;"

        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBulanGaji()
        Dim db As New DBSMConn

        Dim query As String = $"select bulan,tahun from SMKB_Gaji_bulan;"
        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRekodROC(noroc As String)
        Dim db As New DBSMConn

        Dim query As String = $"Select ms15_NOROC R1NoROC,MS15_NORUJSURAT R1NoRujSurat,MS15_KETERANGAN R1Keterangan,Convert(VARCHAR, ISNULL(MS15_TkhRoc, GETDATE()), 103) R1TkhRoc,NamaROC From MS15_rOC,MS_KodROC WHERE ms15_kodroc = kodroc and ms15_NOROC = '{noroc}';"
        'Dim query As String = $"Select * From VMS15_ROC WHERE R1NOROC = '{noroc}';"
        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDtROC(noroc As String)
        Dim db As New DBSMConn


        Dim query As String = $"Select distinct ROC01_Butiran,Convert(VARCHAR, ISNULL(ROC01_TkhMulaB, GETDATE()), 103) ROC01_TkhMulaB, Convert(VARCHAR, ISNULL(ROC01_TkhTamatB, GETDATE()), 103) ROC01_TkhTamatB,roc01_amaunakandibayar From ROC01_BUTIR Where MS15_NoROC = '{noroc}' and ROC01_KumpButiran in ('1','2') order by roc01_amaunakandibayar;"
        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBlnThnGaji()
        Dim db As New DBKewConn


        Dim query As String = $"select bulan,tahun,cast(bulan as varchar(2)) + '/' + cast(tahun as varchar(5)) as butir from SMKB_Gaji_bulan;"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Public Class StaffROC
        Public Property NoStaf As String
        Public Property NoROC As String
    End Class

    Private Function GetListROC() As DataTable
        Dim db = New DBKewConn
        Dim thngj As String = ""
        Dim blngj As String = ""

        dt = db.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            blngj = dt.Rows(0).Item("bulan").ToString()
            thngj = dt.Rows(0).Item("tahun").ToString()
        End If

        'Dim query As String = $"select ms01_nostaf, CONVERT(VARCHAR,ISNULL(MS15_TkhDisahkan,GETDATE()),103) MS15_TkhDisahkan, MS15_NoRujSurat, MS15_NoRoc, MS15_Keterangan  from {DBStaf}MS15_ROC 
        'Where MS15_StaBendahari Is NULL
        '                    And YEAR(MS15_TkhDisahkan) = '{thngj}' AND MONTH(MS15_TkhDisahkan) = '{blngj}'
        '                    And MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC) ORDER BY ms01_nostaf"
        'Dim query As String = $"select a.MS15_NoRoc MS15_NoRoc,a.ms01_nostaf ms01_nostaf,a.ms01_nostaf + '|' + b.ms01_nama as ms01_nama, CONVERT(VARCHAR,ISNULL(a.MS15_TkhDisahkan,GETDATE()),103) MS15_TkhDisahkan, a.MS15_NoRujSurat MS15_NoRujSurat, a.MS15_Keterangan  MS15_Keterangan from {DBStaf}MS15_ROC_1 a , {DBStaf}MS01_Peribadi_1 b
        '                    Where a.ms01_nostaf = b.ms01_nostaf and a.MS15_StaBendahari Is NULL
        '                    And YEAR(a.MS15_TkhDisahkan) = '{thngj}' AND MONTH(a.MS15_TkhDisahkan) = '{blngj}'
        '                    And a.MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC) ORDER BY a.ms01_nostaf"

        Dim query As String = $"select distinct a.MS15_NoRoc MS15_NoRoc,a.ms01_nostaf + ' | ' + b.ms01_nama nama, CONVERT(VARCHAR,ISNULL(a.MS15_TkhDisahkan,GETDATE()),103) MS15_TkhDisahkan, a.MS15_NoRujSurat MS15_NoRujSurat, a.MS15_Keterangan  MS15_Keterangan 
                            from {DBStaf}MS15_ROC a , {DBStaf}MS01_Peribadi b,{DBStaf}ROC01_Butir c 
                            Where a.ms01_nostaf = b.ms01_nostaf and a.MS15_NoRoc = c.MS15_NoRoc  and a.MS15_StaBendahari Is NULL
                            and c.ROC01_KumpButiran in ('1','2') And YEAR(a.MS15_TkhDisahkan) = '{thngj}' AND MONTH(a.MS15_TkhDisahkan) = '{blngj}'
                            And a.MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC) ORDER BY a.MS15_NoRoc"

        Return db.Read(query)
    End Function
    Private Function GetListUbahROC() As DataTable
        Dim db = New DBKewConn
        Dim thngj As String = ""
        Dim blngj As String = ""
        Dim blnsblm As Integer = 0
        Dim thnnsblm As Integer = 0

        dt = db.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            blngj = dt.Rows(0).Item("bulan").ToString()
            thngj = dt.Rows(0).Item("tahun").ToString()
        End If

        'blnsblm = blngj - 1
        If blngj > 1 Then
            blnsblm = blngj - 1
            thnnsblm = thngj


        Else
            blnsblm = 12
            thnnsblm = thngj - 1
        End If
        ' thnnsblm = thngj - 1

        Dim query As String = $"select * from (Select distinct a.no_staf no_staf,e.ms01_nama ms01_nama,kod_trans + ' | ' + (select c.Butiran from SMKB_Gaji_Kod_Trans c where c.Kod_Trans=a.Kod_Trans) as kod_trans,
            (select amaun from smkb_gaji_lejar b where a.kod_trans = b.Kod_Trans And b.bulan='{blnsblm}' And b.tahun='{thnnsblm}' And b.No_Staf=a.No_Staf) as jumlama ,amaun as jumbaru,d.MS15_Keterangan MS15_Keterangan,d.MS15_NoRoc MS15_NoRoc
            From smkb_gaji_master a inner Join {DBStaf}MS15_ROC d on  a.no_roc = d.MS15_NoRoc 
            inner Join {DBStaf}ms01_peribadi e on d.ms01_nostaf=e.ms01_nostaf
            Where MS15_StaBendahari Is Not NULL
            And YEAR(MS15_TkhDisahkan) = '{thngj}' 
            And MONTH(MS15_TkhDisahkan) = '{blngj}' And MS15_KodROC Not In (Select KOD_ROC FROM SMKB_Gaji_ROC))tblMain"

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanROC(data As List(Of StaffROC))
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim counter As Integer = 0
        Dim bil As Integer = 0
        Dim sqlComm As New SqlCommand
        Dim cmd = New SqlCommand
        Dim dt As New DataTable
        Dim dt2 As New DataTable
        Dim dt3 As New DataTable
        Dim problem As String = ""
        Dim db = New DBKewConn
        Dim thngj As String = ""
        Dim blngj As String = ""
        Dim kodparam As String

        dt = db.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan")
        If dt.Rows.Count > 0 Then
            blngj = dt.Rows(0).Item("bulan").ToString()
            thngj = dt.Rows(0).Item("tahun").ToString()
        End If

        If blngj < 10 Then
            kodparam = thngj + "0" + blngj
        Else
            kodparam = thngj + blngj
        End If


        dt = db.Read("SELECT status_dok FROM SMKB_Gaji_STatus_Dok where kod_param='" & kodparam & "' and status_dok='01'")
        If dt.Rows.Count > 0 Then
            resp.Failed("Pegawai telah membuat pengesahan ROC. Rekod ROC tidak diproses.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        'dt = db.Read("SELECT status FROM SMKB_Gaji_Param where kod_param='" & kodparam & "' and status='01'")
        'If dt.Rows.Count > 0 Then
        '    resp.Failed("Pegawai telah membuat pengesahan ROC. Rekod ROC tidak diproses.")
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        '    Exit Function
        'End If


        dt2 = db.Read($"Select * from (
        Select distinct substring(ROC01_Butiran, 1, 5) As kodroc
        From {DBStaf}ROC01_BUTIR a , {DBStaf}ms15_roc b 
        Where a.MS15_NoRoc = b.MS15_NoRoc And Year(b.MS15_TkhDisahkan) = '" & thngj & "' AND MONTH(b.MS15_TkhDisahkan) = '" & blngj & "'  and ROC01_KumpButiran=2 and MS15_StaBendahari IS NULL
        And b.MS15_KodROC Not In (Select KOD_ROC From SMKB_Gaji_ROC) ) z Where z.kodroc Not In (Select Kod_SMSM from SMKB_Gaji_Kod_Convert)")
        If dt2.Rows.Count > 0 Then
            resp.Failed("Terdapat kod roc baru yang tidak wujud dalam kod smkb. Sila semak semula.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        While bil < data.Count
            dt3 = db.Read($"Select * from (
            Select distinct a.roc01_tkhtamatb
            From {DBStaf}ROC01_BUTIR a , {DBStaf}ms15_roc b 
            Where a.MS15_NoRoc = b.MS15_NoRoc And Year(b.MS15_TkhDisahkan) = '" & thngj & "' AND MONTH(b.MS15_TkhDisahkan) = '" & blngj & "'  and ROC01_KumpButiran ') and MS15_StaBendahari IS NULL
            and a.MS15_NoRoc = '" & data(bil).NoROC & "' And b.MS15_KodROC Not In (Select KOD_ROC From SMKB_Gaji_ROC) and a.roc01_tkhtamatb is null) z ")
            If dt3.Rows.Count > 0 Then
                resp.Failed("Terdapat butiran roc yang tidak mempunyai tarikh tamat. Sila semak semula.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            End If
            bil += 1
        End While

        While counter < data.Count
            Using sqlcon = New SqlConnection(strCon)
                sqlComm.Connection = sqlcon
                sqlComm.CommandTimeout = 600
                sqlComm.CommandText = "USP_TERIMA_ROC"
                sqlComm.CommandType = CommandType.StoredProcedure
                sqlComm.Parameters.Clear()

                sqlComm.Parameters.AddWithValue("@iBlnTrans", blngj)
                sqlComm.Parameters.AddWithValue("@iThnTrans", thngj)
                sqlComm.Parameters.AddWithValue("@NoStaf", data(counter).NoStaf)
                sqlComm.Parameters.AddWithValue("@NoROC", data(counter).NoROC)
                sqlComm.Parameters.AddWithValue("@UserID", "00664")

                sqlcon.Open()

                'sqlComm.ExecuteNonQuery()
                'Dim rowsAffected As Integer = sqlComm.ExecuteNonQuery()
                Dim X = sqlComm.ExecuteNonQuery()
                If X > 0 Then
                    success = 1
                ElseIf (problem <> "" Or success = 1) And X <= 0 Then
                    problem &= data(counter).NoROC & " | "
                    success = 2
                Else
                    problem &= data(counter).NoROC & " | "
                    success = 0
                End If
            End Using

            counter += 1
        End While

        If success = 1 Then
            resp.Success("Rekod berjaya disimpan")
        ElseIf success = 2 Then
            resp.Success("Rekod berjaya disimpan tetapi terdapat rekod tidak dapat diproses. No ROC " & problem)
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
        'Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRekodStaf(nostaf As String)
        Dim db As New DBSMConn

        'Dim query As String = $"Select a.MS01_NoStaf,a.MS01_Nama,a.MS01_KpB,b.JawatanS,b.gredgajis,b.PejabatS,b.jumlahgajis,
        '                        case when a.ms01_status =1 then 'AKTIF' else 'TIDAK AKTIF' end status_staf,b.tarafkhidmat From MS01_Peribadi_1 a, VPerjawatan1 b, ms_skim
        '                        WHERE a.MS01_NoStaf = b.nostaf and ms01_nostaf = '{nostaf}' and ms08_staterkini=1;"

        Dim query As String = $"Select a.MS01_NoStaf,a.MS01_Nama,a.MS01_KpB,c.JawGiliran JawatanS,b.MS02_GredGajiS gredgajis,b.MS02_JumlahGajiS jumlahgajis,(Select skim from  MS_Skim where kodskim = b.MS02_Skim ) As skim,
        (select Pejabat from MS_Pejabat where KodPejabat=d.MS08_Pejabat) as PejabatS,
        Case when a.ms01_status =1 then 'AKTIF' else 'TIDAK AKTIF' end status_staf,(select TarafKhidmat from MS_TarafKhidmat where KodTarafKhidmat=b.MS02_Taraf) tarafkhidmat From MS01_Peribadi a, MS02_Perjawatan b, MS_Jawatan c, MS08_Penempatan d
        WHERE a.MS01_NoStaf = b.MS01_NoStaf And a.MS01_NoStaf = d.MS01_NoStaf And a.ms01_nostaf = '{nostaf}' and d.MS08_StaTerkini = 1 and b.MS02_JawSandang = c.KodJawatan;"

        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SahROC(kodparam As String) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn


        fDeleteParam(kodparam)

        If fInsertParam(kodparam) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If

        If success = 1 Then

            resp.Success("Rekod berjaya disimpan", "00", kodparam)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function

    Private Function fDeleteParam(kodparam As String)
        Dim db As New DBKewConn
        Dim db2 As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        'Dim strSql = "select count(*) from smkb_gaji_param  where kod_param =  '" & kodparam & "' and status= '01'"
        'Dim intCnt As Integer = db.fSelectCount(strSql)
        'If intCnt > 0 Then
        '    Dim query2 As String = "DELETE SMKB_Gaji_Param where kod_param= @kod and status=@staparam"
        '    Dim param2 As New List(Of SqlParameter)
        '    param2.Add(New SqlParameter("@kod", kodparam))
        '    param2.Add(New SqlParameter("@staparam", "01"))
        '    Return db2.Process(query2, param2)
        'End If

        Dim strSql = "select count(*) from smkb_gaji_Status_Dok  where kod_param =  '" & kodparam & "' and status= '01'"
        Dim intCnt As Integer = db.fSelectCount(strSql)
        If intCnt > 0 Then
            Dim query2 As String = "DELETE smkb_gaji_Status_Dok where kod_param= @kod and status=@staparam"
            Dim param2 As New List(Of SqlParameter)
            param2.Add(New SqlParameter("@kod", kodparam))
            param2.Add(New SqlParameter("@staparam", "01"))
            Return db2.Process(query2, param2)
        End If

    End Function
    Private Function fInsertParam(kodparam As String)
        Dim db As New DBKewConn
        Dim db2 As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        'Dim query As String = "insert into SMKB_Gaji_Param (kod_param, status, Tarikh ) values (@kod,@staparam,@tarikh)"
        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@kod", kodparam))
        'param.Add(New SqlParameter("@staparam", "01"))
        'param.Add(New SqlParameter("@tarikh", dtTkhToday))

        Dim querys As String = "insert into SMKB_Gaji_Status_Dok (kod_param, status_dok,no_staf, Tarikh ) values (@kod,@staparam,@id,@tarikh)"
        Dim params As New List(Of SqlParameter)
        params.Add(New SqlParameter("@kod", kodparam))
        params.Add(New SqlParameter("@staparam", "01"))
        params.Add(New SqlParameter("@id", Session("ssusrID")))
        params.Add(New SqlParameter("@tarikh", dtTkhToday))


        'Return db.Process(query, param)
        Return db2.Process(querys, params)
    End Function


    Public Class ChecklistItem
        Public Property ID As String
        Public Property isChecked As Boolean
    End Class
    <Serializable>
    Public Class TerimaROC
        Public Property No_Pinj As String
        Public Property No_Staf As String
        Public Property Status_Dok As String
        Public Property Status As String
        Public Property New_Status_Dok As String
        'Public Property details As List(Of SokonganPinjamanHdr)

        Public Function updateCommand() As SqlCommand
            If No_Pinj Is Nothing Then
                Throw New Exception("No Pinjaman tidak sah")
            End If

            Dim cmd As New SqlCommand
            Dim sql As String
            Dim values As String = ""
            sql = "UPDATE SMKB_Pinjaman_Hdr SET Status_Dok = @Status_Dok "

            cmd.CommandText = sql + " WHERE No_Pinj = @No_Pinj"
            cmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
            cmd.Parameters.Add(New SqlParameter("@Status_Dok", New_Status_Dok))

            Return cmd
        End Function
    End Class
End Class