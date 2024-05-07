Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic


Imports System.Drawing
Imports System.Globalization

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration
Imports AjaxControlToolkit
Imports System.Reflection
Imports System

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.

<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Proses_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim BulanGaji As String
    Dim TahunGaji As String


    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBankMaster() As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetDataBank()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetDataBank() As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"select Kod_Bank, Nama_Sing from SMKB_Bank_Master where Kod_bank='76106' order by Kod_Bank"

        Return db.Read(query)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBlnThnGaji()
        Dim db As New DBKewConn


        Dim query As String = $"select bulan,tahun,cast(bulan as varchar(2)) + '/' + cast(tahun as varchar(5)) as butir from SMKB_Gaji_bulan;"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fProsesGaji(kodparam As String)
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim counter As Integer = 0
        Dim sqlComm As New SqlCommand
        Dim cmd = New SqlCommand
        Dim dt As New DataTable
        Dim problem As String = ""
        Dim dbconn As New DBKewConn

        dt = dbconn.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            BulanGaji = dt.Rows(0).Item("bulan").ToString()
            TahunGaji = dt.Rows(0).Item("tahun").ToString()
        End If

        Dim strSql = "select count(*) from smkb_gaji_status_dok  where kod_param =  '" & kodparam & "' and Status_Dok in ('10')"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt <= 0 Then
            resp.Success("Pengesahan Statutory tidak lengkap! Sila buat Pengesahan Statutory.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql1 = "select count(*) from SMKB_Gaji_Tarikh_Gaji  where bulan =  '" & BulanGaji & "' and tahun =  '" & TahunGaji & "'"
        Dim intCnt1 As Integer = dbconn.fSelectCount(strSql1)
        If intCnt1 <= 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Tarikh Gaji tidak lengkap!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql2 = "select count(*) from SMKB_Gaji_AP  where kod_param =  '" & kodparam & "' and status = '12'"
        Dim intCnt2 As Integer = dbconn.fSelectCount(strSql2)
        If intCnt2 > 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Baucar sudah dikeluarkan!")

            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql3 = "select count(*) from SMKB_Gaji_AP  where kod_param =  '" & kodparam & "' and status = '11'"
        Dim intCnt3 As Integer = dbconn.fSelectCount(strSql3)
        If intCnt3 > 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Draf Baucar sudah dikeluarkan!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Using sqlcon = New SqlConnection(strCon)
            sqlComm.Connection = sqlcon
            sqlComm.CommandTimeout = 2000
            sqlComm.CommandText = "USP_PROSES_GAJI"
            sqlComm.CommandType = CommandType.StoredProcedure

            sqlComm.Parameters.Clear()

            sqlComm.Parameters.AddWithValue("@iBulan", BulanGaji)
            sqlComm.Parameters.AddWithValue("@iTahun", TahunGaji)
            sqlComm.Parameters.AddWithValue("@idProses", Session("ssusrID"))
            sqlcon.Open()

            'sqlComm.ExecuteNonQuery()
            'Dim rowsAffected As Integer = sqlComm.ExecuteNonQuery()
            Dim X = sqlComm.ExecuteNonQuery()
            If X > 0 Then
                success = 1
            Else

                success = 0
            End If
        End Using


        If success = 1 Then
            resp.Success("Proses gaji telah berjaya diproses.")
        Else
            resp.Failed("Rekod gaji tidak berjaya diproses.")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fProsesGajiPtj(ptjDr As String, ptjHg As String, kodparam As String)
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim counter As Integer = 0
        Dim sqlComm As New SqlCommand
        Dim cmd = New SqlCommand
        Dim dt As New DataTable
        Dim problem As String = ""
        Dim dbconn As New DBKewConn

        dt = dbconn.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            BulanGaji = dt.Rows(0).Item("bulan").ToString()
            TahunGaji = dt.Rows(0).Item("tahun").ToString()
        End If

        Dim strSql = "select count(*) from smkb_gaji_status_dok  where kod_param =  '" & kodparam & "' and Status_Dok in ('10')"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt <= 0 Then
            resp.Success("Pengesahan Statutory tidak lengkap! Sila buat Pengesahan Statutory.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql1 = "select count(*) from SMKB_Gaji_Tarikh_Gaji  where bulan =  '" & BulanGaji & "' and tahun =  '" & TahunGaji & "'"
        Dim intCnt1 As Integer = dbconn.fSelectCount(strSql1)
        If intCnt1 <= 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Tarikh Gaji tidak lengkap!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql2 = "select count(*) from SMKB_Gaji_AP  where kod_param =  '" & kodparam & "' and status = '12'"
        Dim intCnt2 As Integer = dbconn.fSelectCount(strSql2)
        If intCnt2 > 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Baucar sudah dikeluarkan!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql3 = "select count(*) from SMKB_Gaji_AP  where kod_param =  '" & kodparam & "' and status = '11'"
        Dim intCnt3 As Integer = dbconn.fSelectCount(strSql3)
        If intCnt3 > 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Draf Baucar sudah dikeluarkan!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Using sqlcon = New SqlConnection(strCon)
            sqlComm.Connection = sqlcon
            sqlComm.CommandTimeout = 2000
            sqlComm.CommandText = "USP_PROSES_GAJI_PTJ"
            sqlComm.CommandType = CommandType.StoredProcedure

            sqlComm.Parameters.Clear()

            sqlComm.Parameters.AddWithValue("@iBulan", BulanGaji)
            sqlComm.Parameters.AddWithValue("@iTahun", TahunGaji)
            sqlComm.Parameters.AddWithValue("@strPtjDr", ptjDr)
            sqlComm.Parameters.AddWithValue("@strPtjHg", ptjHg)
            sqlComm.Parameters.AddWithValue("@idProses", Session("ssusrID"))

            sqlcon.Open()

            'sqlComm.ExecuteNonQuery()
            'Dim rowsAffected As Integer = sqlComm.ExecuteNonQuery()
            Dim X = sqlComm.ExecuteNonQuery()
            If X > 0 Then
                success = 1
            Else

                success = 0
            End If
        End Using


        If success = 1 Then
            resp.Success("Proses gaji telah berjaya diproses.")
        Else
            resp.Failed("Rekod gaji tidak berjaya diproses.")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fProsesGajiStaf(nostafDr As String, nostafHg As String, kodparam As String)
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim counter As Integer = 0
        Dim sqlComm As New SqlCommand
        Dim cmd = New SqlCommand
        Dim dt As New DataTable
        Dim problem As String = ""
        Dim dbconn As New DBKewConn

        dt = dbconn.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            BulanGaji = dt.Rows(0).Item("bulan").ToString()
            TahunGaji = dt.Rows(0).Item("tahun").ToString()
        End If

        Dim strSql = "select count(*) from smkb_gaji_Status_Dok  where kod_param =  '" & kodparam & "' and Status_Dok in ('10')"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt <= 0 Then
            resp.Success("Pengesahan Statutory tidak lengkap! Sila buat Pengesahan Statutory.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql1 = "select count(*) from SMKB_Gaji_Tarikh_Gaji  where bulan =  '" & BulanGaji & "' and tahun =  '" & TahunGaji & "'"
        Dim intCnt1 As Integer = dbconn.fSelectCount(strSql1)
        If intCnt1 <= 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Tarikh Gaji tidak lengkap!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql2 = "select count(*) from SMKB_Gaji_AP  where kod_param =  '" & kodparam & "' and status = '12'"
        Dim intCnt2 As Integer = dbconn.fSelectCount(strSql2)
        If intCnt2 > 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Baucar sudah dikeluarkan!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Dim strSql3 = "select count(*) from SMKB_Gaji_AP  where kod_param =  '" & kodparam & "' and status = '11'"
        Dim intCnt3 As Integer = dbconn.fSelectCount(strSql3)
        If intCnt3 > 0 Then
            resp.Success("Proses gaji tidak boleh dilakukan lagi kerana Draf Baucar sudah dikeluarkan!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        Using sqlcon = New SqlConnection(strCon)
            sqlComm.Connection = sqlcon
            sqlComm.CommandTimeout = 2000
            sqlComm.CommandText = "USP_PROSES_GAJI_STAF"
            sqlComm.CommandType = CommandType.StoredProcedure

            sqlComm.Parameters.Clear()

            sqlComm.Parameters.AddWithValue("@iBulan", BulanGaji)
            sqlComm.Parameters.AddWithValue("@iTahun", TahunGaji)
            sqlComm.Parameters.AddWithValue("@strStafDr", nostafDr)
            sqlComm.Parameters.AddWithValue("@strStafHg", nostafHg)
            sqlComm.Parameters.AddWithValue("@idProses", Session("ssusrID"))

            sqlcon.Open()

            'sqlComm.ExecuteNonQuery()
            'Dim rowsAffected As Integer = sqlComm.ExecuteNonQuery()
            Dim X = sqlComm.ExecuteNonQuery()
            If X > 0 Then
                success = 1
            Else

                success = 0
            End If
        End Using

        If success = 1 Then
            resp.Success("Proses gaji telah berjaya diproses.")
        Else
            resp.Failed("Rekod gaji tidak berjaya diproses.")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fProsesAP(ibank As String)
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim counter As Integer = 0
        Dim sqlComm As New SqlCommand
        Dim cmd = New SqlCommand
        Dim dt As New DataTable
        Dim problem As String = ""
        Dim dbconn As New DBKewConn

        dt = dbconn.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            BulanGaji = dt.Rows(0).Item("bulan").ToString()
            TahunGaji = dt.Rows(0).Item("tahun").ToString()
        End If

        Using sqlcon = New SqlConnection(strCon)
            sqlComm.Connection = sqlcon
            sqlComm.CommandTimeout = 1000
            sqlComm.CommandText = "USP_APSource"
            sqlComm.CommandType = CommandType.StoredProcedure

            sqlComm.Parameters.Clear()

            sqlComm.Parameters.AddWithValue("@arg_bulan", BulanGaji)
            sqlComm.Parameters.AddWithValue("@arg_tahun", TahunGaji)
            sqlComm.Parameters.AddWithValue("@BankVot", ibank)
            sqlComm.Parameters.AddWithValue("@idProses", Session("ssusrID"))


            sqlcon.Open()

            'sqlComm.ExecuteNonQuery()
            'Dim rowsAffected As Integer = sqlComm.ExecuteNonQuery()
            Dim X = sqlComm.ExecuteNonQuery()
            If X > 0 Then
                success = 1
            Else

                success = 0
            End If
        End Using

        If success = 1 Then
            resp.Success("Rekod berjaya disimpan")
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTotalLejar() As String
        Dim db = New DBKewConn
        'TOP 20 COUNT(A.MS01_NOSTAF)
        Dim query As String = $"SELECT count(A.MS01_NOSTAF) as Total
        From {DBStaf}MS01_PERIBADI A INNER JOIN {DBStaf}MS08_PENEMPATAN B ON (A.MS01_NOSTAF = B.MS01_NOSTAF )
        WHERE B.MS08_StaTerkini = '1'  and A.MS01_STATUS=1"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTotalLejarPtj(ptjDr As String, ptjHg As String)
        Dim db = New DBKewConn
        'TOP 20 COUNT(A.MS01_NOSTAF)
        Dim query As String = $"SELECT count(A.MS01_NOSTAF) as Total
        From {DBStaf}MS01_PERIBADI A INNER JOIN {DBStaf}MS08_PENEMPATAN B ON (A.MS01_NOSTAF = B.MS01_NOSTAF )
        WHERE B.MS08_StaTerkini = '1'  and A.MS01_STATUS=1 And B.ms08_pejabat >= '" & ptjDr & "' And B.ms08_pejabat <= '" & ptjHg & "'"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTotalLejarStaf(nostafDr As String, nostafHg As String)
        Dim db = New DBKewConn
        'TOP 20 COUNT(A.MS01_NOSTAF)
        Dim query As String = $"SELECT count(A.MS01_NOSTAF) as Total
        From {DBStaf}MS01_PERIBADI A INNER JOIN {DBStaf}MS08_PENEMPATAN B ON (A.MS01_NOSTAF = B.MS01_NOSTAF )
        WHERE B.MS08_StaTerkini = '1'  and A.MS01_STATUS=1 And A.MS01_NOSTAF >= '" & nostafDr & "' And A.MS01_NOSTAF <= '" & nostafHg & "'"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetProgressLejar() As String
        Dim db = New DBKewConn

        Dim dt2 As New DataTable
        Dim problem As String = ""

        dt2 = db.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt2.Rows.Count > 0 Then
            BulanGaji = dt2.Rows(0).Item("bulan").ToString()
            TahunGaji = dt2.Rows(0).Item("tahun").ToString()
        End If

        Dim query As String = $"SELECT  COUNT(DISTINCT No_Staf)  as JumlahSelesai
        FROM SMKB_GAJI_Lejar WHERE Bulan ={BulanGaji} and Tahun = {TahunGaji} and No_Staf IN (
	        SELECT A.MS01_NOSTAF
	        From {DBStaf}MS01_PERIBADI A INNER JOIN {DBStaf}MS08_PENEMPATAN B ON (A.MS01_NOSTAF = B.MS01_NOSTAF )
	        WHERE B.MS08_StaTerkini = '1'  and A.MS01_STATUS=1 
        )"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetStatusProcessing(param As String) As String
        Dim db = New DBKewConn

        Dim query As String = $"SELECT Status_Dok FROM SMKB_Gaji_Status_Dok WHERE Status_Dok = '03' AND Kod_Param = '{param}'"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTotalAP() As String
        Dim db = New DBKewConn

        Dim query As String = $"SELECT count(A.MS01_NOSTAF) as Total
        From {DBStaf}MS01_PERIBADI A INNER JOIN {DBStaf}MS08_PENEMPATAN B ON (A.MS01_NOSTAF = B.MS01_NOSTAF )
        WHERE B.MS08_StaTerkini = '1'  and A.MS01_STATUS=1"

        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetProgressAP() As String
        Dim db = New DBKewConn

        Dim query As String = $"SELECT  COUNT(vot)  as JumlahSelesai
        FROM SMKB_Gaji_Temp_ApSource"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetStatusAP(param As String) As String
        Dim db = New DBKewConn

        Dim query As String = $"SELECT Status_Dok FROM SMKB_Gaji_Status_Dok WHERE Status_Dok = '04' AND Kod_Param = '{param}'"
        Dim dt As DataTable = db.Read(query)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBayarGaji(ByVal Tahun As String, ByVal Bulan As String) As String
        Dim resp As New ResponseRepository

        dt = GetBayarGaji(Tahun, Bulan)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetBayarGaji(Tahun As String, Bulan As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        'Dim query As String = "select isnull(sum(amaun),0) as jumlah_gaji from SMKB_Gaji_Lejar where Kod_Trans='gaji' and bulan=@Bulan and tahun=@Tahun"

        Dim query As String = "Select isnull(sum(a.amaun), 0) As jumlah_gaji,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.Jenis_Trans In ('K') and b.bulan=a.Bulan and b.Tahun=a.Tahun) as GAJI,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.Jenis_Trans In ('B','H') and b.bulan=a.Bulan and b.Tahun=a.Tahun) as BONUS,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.Jenis_Trans In ('O') and b.bulan=a.Bulan and b.Tahun=a.Tahun) as OT
        From SMKB_Gaji_Lejar a
        Where a.Kod_Trans ='gaji' and a.bulan=@Bulan and a.tahun=@Tahun
        Group by a.Bulan,a.Tahun"

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@Bulan", Bulan))


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBayarElaun(ByVal Tahun As String, ByVal Bulan As String) As String
        Dim resp As New ResponseRepository

        dt = GetBayarElaun(Tahun, Bulan)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetBayarElaun(Tahun As String, Bulan As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select isnull(sum(a.amaun), 0) As jumlah_elaun,(Select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.kod_Trans In ('E001') and b.bulan=a.Bulan and b.Tahun=a.Tahun ) as ITKA,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.kod_Trans In ('E002') and b.bulan=a.Bulan and b.Tahun=a.Tahun ) as ITP,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.kod_Trans In ('E003') and b.bulan=a.Bulan and b.Tahun=a.Tahun ) as ITK, 
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.kod_Trans In ('E026') and b.bulan=a.Bulan and b.Tahun=a.Tahun ) as SARA
        From SMKB_Gaji_Lejar a Where jenis_Trans ='E' and bulan=@Bulan and tahun=@Tahun
        Group by a.Bulan,a.Tahun"
        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@Bulan", Bulan))


        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBayarPot(ByVal Tahun As String, ByVal Bulan As String) As String
        Dim resp As New ResponseRepository

        dt = GetBayarPot(Tahun, Bulan)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetBayarPot(Tahun As String, Bulan As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        'Dim query As String = "select isnull(sum(amaun),0) as jumlah_pot from SMKB_Gaji_Lejar where jenis_Trans='P' and bulan=@Bulan and tahun=@Tahun"

        Dim query As String = "Select isnull(sum(a.amaun), 0) As jumlah_pot,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.Jenis_Trans In ('K') and b.Bayar_Drpd='P' and b.bulan=a.Bulan and b.Tahun=a.Tahun) as KWSP,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.Jenis_Trans In ('N') and b.Bayar_Drpd='M' and b.bulan=a.Bulan and b.Tahun=a.Tahun) as PENCEN,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.Jenis_Trans In ('S') and b.Bayar_Drpd='P' and b.bulan=a.Bulan and b.Tahun=a.Tahun) as PERKESO,
        (select isnull(sum(b.amaun),0) from SMKB_Gaji_Lejar b 
        where b.Jenis_Trans In ('T') and b.Bayar_Drpd='P' and b.bulan=a.Bulan and b.Tahun=a.Tahun) as CUKAI
        From SMKB_Gaji_Lejar a
        Where a.jenis_Trans ='P' and a.bulan=@Bulan and a.tahun=@Tahun
        Group by a.Bulan,a.Tahun"

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@Bulan", Bulan))


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBayarkatPot(ByVal Tahun As String, ByVal Bulan As String) As String
        Dim resp As New ResponseRepository

        dt = GetBayarKarPot(Tahun, Bulan)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetBayarKarPot(Tahun As String, Bulan As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "select isnull(sum(amaun),0) as jumlah_pot from SMKB_Gaji_Lejar where jenis_Trans='P' and bulan=@Bulan and tahun=@Tahun"

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@Bulan", Bulan))


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBayarOT(ByVal Tahun As String, ByVal Bulan As String) As String
        Dim resp As New ResponseRepository

        dt = GetBayarOT(Tahun, Bulan)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetBayarOT(Tahun As String, Bulan As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "select isnull(sum(amaun),0) as jumlah_ot,kod_ptj from SMKB_Gaji_Lejar where jenis_Trans='O' and bulan=@Bulan and tahun=@Tahun group by kod_ptj"

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@Bulan", Bulan))


        Return db.Read(query, param)
    End Function
    Public Function LoadPiePot(ByVal Tahun As String, ByVal Bulan As String) As String
        Dim resp As New ResponseRepository

        dt = GetPiePot(Tahun, Bulan)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetPiePot(Tahun As String, Bulan As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "SELECT * FROM (
            SELECT Kod_Trans, sum(Amaun) as amaun 
            FROM SMKB_Gaji_Lejar where jenis_Trans in ('K','S','N') and bulan=@Bulan and tahun=@Tahun group by Kod_Trans
            ) AS SourceTable
            PIVOT (
                MAX(Amaun) FOR Kod_Trans IN ([KWSP], [SOCP],[PENC])
            ) AS PivotTable;"

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@Bulan", Bulan))


        Return db.Read(query, param)
    End Function
End Class