Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.IO
Imports System.Collections.Generic
Imports System.Drawing
Imports System.Globalization
Imports System.Web.Configuration

Imports System.Net
Imports System.Net.Mail
Imports SMKB_Web_Portal.ROC_WS
Imports System.Net.Http
Imports System.Threading


<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Mohon_WS
    Inherits System.Web.Services.WebService
    Public strConEmail As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim dtbl As DataTable



    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetUserInfo(nostaf As String)
        Dim db As New DBSMConn
        Dim query As String = $"SELECT  MS01_NoStaf as StafNo, MS01_Nama as Param1, MS08_Pejabat as Param2, JawGiliran as Param3, Kumpulan as Param4, 
                                Singkatan as Param5, MS02_GredGajiS as Param6,right(MS02_GredGajiS,2) as GredGaji, 
                                MS02_JumlahGajiS,  MS01_TelPejabat as Param7,  MS02_Kumpulan
                                FROM VK_AdvClm WHERE MS01_NoStaf = '{nostaf}'"
        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListMaster(ByVal nostaf As String) As String
        Dim resp As New ResponseRepository


        dt = GetListMaster(nostaf)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function GetListMaster(nostaf As String) As DataTable
        Dim db = New DBKewConn

        Dim dt As New DataTable
        Dim query As String = $"select ROW_NUMBER() OVER (ORDER BY id_mohon) row_num, id_mohon,no_staf,SMKB_Gaji_Permohonan.kod_trans,butiran,amaun,case when status_dok='01' then 'MOHON' when status_dok='02' then 'LULUS' when status_dok='03' then 'TIDAK LULUS' else '-' end as status_dok,ulasan,CONVERT(VARCHAR,ISNULL(Tkh_Mula,GETDATE()),103) Tkh_Mula,CONVERT(VARCHAR,ISNULL(Tkh_Tamat,GETDATE()),103) Tkh_Tamat 
                                from SMKB_Gaji_Permohonan,smkb_gaji_kod_trans where SMKB_Gaji_Permohonan.kod_trans = smkb_gaji_kod_trans.kod_trans and no_staf = '{nostaf}' Order by id_mohon"
        Return db.Read(query)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodTrans() As String
        Dim tmpDT As DataTable = GetDataKodTrans()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataKodTrans() As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"select Kod_Trans, Butiran from SMKB_Gaji_Kod_Trans where jenis_trans= 'P' and status_mohon = 1 order by Kod_Trans"

        Return db.Read(query)
    End Function
    Public Function myEmel(alamat, subject, body)
        Dim cnExec As OleDb.OleDbConnection
        Dim cmdExec As OleDb.OleDbCommand

        Try
            cnExec = New OleDb.OleDbConnection(strConEmail)
            cnExec.Open()

            cmdExec = New OleDb.OleDbCommand("EXEC msdb.dbo.sp_send_dbmail @profile_name= 'EmailSmkb', @recipients= '" & alamat & "', @subject = '" & subject & "', " &
                  "@body= '" & Replace(body, "'", "''") & "', @body_format='HTML';", cnExec)
            cmdExec.ExecuteNonQuery()
            cmdExec.Dispose()
            cmdExec = Nothing
            cnExec.Dispose()
            cnExec.Close()
            cnExec = Nothing

            Return 1    'Proses Berjaya
        Catch ex As Exception
            ' Show the exception's message.
            MsgBox(ex.Message)
            Return 0    'Proses Gagal
        End Try

    End Function
    Public Function fGetMohonInfo(nomohon) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"select a.MS01_Nama,b.No_Staf,b.ID_Mohon,b.Kod_Trans,b.amaun,c.Butiran,CONVERT(VARCHAR,ISNULL(Tkh_Mula,GETDATE()),103) Tkh_Mula,CONVERT(VARCHAR,ISNULL(Tkh_Tamat,GETDATE()),103) Tkh_Tamat
                                    FROM {DBStaf}MS01_Peribadi a, SMKB_Gaji_Permohonan b,SMKB_Gaji_Kod_Trans c
                                    WHERE b.ID_Mohon = '{nomohon}'
                                    AND b.No_Staf = a.MS01_NoStaf
                                    AND b.Kod_Trans = c.Kod_Trans;"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function
    Public Function SendEmail(nostaf As String, nomohon As String) As String

        Dim email As String
        Dim nama As String
        Dim jenispot As String
        Dim jumpot As String
        Dim nostafmohon As String
        Dim namamohon As String

        Using dtUserInfo = fGetUserInfo(nostaf)
            If dtUserInfo.Rows.Count > 0 Then
                nama = dtUserInfo.Rows.Item(0).Item("MS01_Nama")
                email = dtUserInfo.Rows.Item(0).Item("MS01_Email")
            End If
        End Using


        Using dtMohonInfo = fGetMohonInfo(nomohon)
            If dtMohonInfo.Rows.Count > 0 Then
                nostafmohon = dtMohonInfo.Rows.Item(0).Item("No_Staf")
                namamohon = dtMohonInfo.Rows.Item(0).Item("MS01_Nama")
                jenispot = dtMohonInfo.Rows.Item(0).Item("Butiran")
                jumpot = dtMohonInfo.Rows.Item(0).Item("amaun")
            End If
        End Using

        email = "nuraini@utem.edu.my"

        ' Send the new password to the user's email
        Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
        Dim body As String = "Permohonan Potongan Staf " _
        & "<br><br>" _
        & vbCrLf & "Assalamualaikum Dan Salam Sejahtera " & nama & "," _
        & "<br><br>" _
        & vbCrLf & "Dimaklumkan terdapat permohonan potongan staf yang perlu disahkan." _
        & "<br><br>" _
        & vbCrLf & "Berikut merupakan butiran permohonan :" _
        & "<br><br>" _
        & vbCrLf & "No. Permohonan : " & nomohon & "," _
        & "<br>" _
        & vbCrLf & "No. Staf : " & nostafmohon & "," _
        & "<br>" _
        & vbCrLf & "Nama : " & namamohon & "," _
        & "<br>" _
        & vbCrLf & "Jenis Potongan : " & jenispot & "," _
        & "<br>" _
        & vbCrLf & "Amaun Potongan (RM) : " & jumpot & "," _
        & "<br><br>" _
        & vbCrLf & "Sila log masuk ke dalam UTeM - Sistem Maklumat Kewangan Bersepadu. " _
        & "<br><br>" _
        & vbCrLf & "Sila layari <a href='https://portal.utem.edu.my/iutem'>https://portal.utem.edu.my/iutem</a>" _
        & "<br><br>" _
        & vbCrLf & "Email ini dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " _
        & "<br><br>"

        myEmel(email, subject, body)

    End Function

    'Private Function SendEmailHantar(Noarahan As String, Nostaf As String, NoStafSah As String) As String
    '    Dim nama As String
    '    Dim email As String
    '    Dim KodSubMenu As String
    '    Dim clsCrypto As New clsCrypto
    '    Dim db As New DBKewConn

    '    Using dtUserInfo = fGetUserInfo(Nostaf)
    '        If dtUserInfo.Rows.Count > 0 Then
    '            nama = dtUserInfo.Rows.Item(0).Item("MS01_Nama")
    '        End If
    '    End Using

    '    Using dtUserInfo = fGetUserInfo(NoStafSah)
    '        If dtUserInfo.Rows.Count > 0 Then
    '            email = dtUserInfo.Rows.Item(0).Item("MS01_Email")
    '        End If
    '    End Using

    '    'set id pka
    '    Nostaf = "00664"
    '    email = "nuraini@utem.edu.my"
    '    KodSubMenu = "080206" 'sokong mohon pot

    '    'create token
    '    Dim combineData = Nostaf + Now() + Noarahan
    '    Dim id = clsCrypto.fEncrypt(combineData)

    '    Dim currentUrl As Uri = HttpContext.Current.Request.Url

    '    ' Construct the URL using the current request URL
    '    Dim url As String = currentUrl.Scheme & "://" & currentUrl.Authority & "/SMKBNet/loginsmkb?id=" & id


    '    'mula insert SMKB_Emel_Auth
    '    Dim paramSqlBtrn() As SqlParameter = Nothing
    '    Dim strSqlButiran = "INSERT INTO SMKB_Emel_Auth (ID_Token, No_Staf_Penerima, Emel_Penerima, Tarikh_Luput_URL, Kod_Sub_Menu, No_Rujukan)
    '                                        VALUES (@ID_Token, @No_Staf_Penerima, @Emel_Penerima, @Tarikh_Luput_URL, @Kod_Sub_Menu, @No_Rujukan)"
    '    paramSqlBtrn = {New SqlParameter("@ID_Token", id),
    '                            New SqlParameter("@No_Staf_Penerima", Nostaf),
    '                            New SqlParameter("@Emel_Penerima", email),
    '                            New SqlParameter("@Tarikh_Luput_URL", "2024-04-29"),
    '                            New SqlParameter("@Kod_Sub_Menu", KodSubMenu),
    '                            New SqlParameter("@No_Rujukan", Noarahan)
    '                        }


    '    If db.fInsertCommand(strSqlButiran, paramSqlBtrn) > 0 Then


    '        ' Send the new password to the user's email
    '        Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
    '        Dim body As String = "Permohonan Potongan Gaji Staf " _
    '        & "<br><br>" _
    '        & vbCrLf & "Assalamualaikum Dan Salam Sejahtera " _
    '        & "<br><br>" _
    '        & vbCrLf & "Dimaklumkan bahawa, staf " & nama & " telah membuat permohonan potongan gaji  melalui portal e-ot." _
    '        & vbCrLf & "Sehubungan dengan itu, dipohon kerjasama tuan/puan untuk menyokong atau meluluskan permohonan" _
    '        & vbCrLf & "tersebut sekiranya tuan/puan berpuas hati dengan permohonan yang dibuat oleh staf tersebut." _
    '        & "<br><br>" _
    '        & vbCrLf & "Sila klik di link ini untuk menyemak permohonan untuk sokongan melalui <a href=" + url + ">" + url + "</a>" _
    '        & "<br><br>" _
    '        & vbCrLf & "Email ini dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " _
    '        & "<br><br>"

    '        myEmel(email, subject, body)
    '    Else
    '        db.sConnRollbackTrans()
    '    End If

    'End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanMaster(DataMohonPot As DataMohonPot) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn
        Dim NoStafSah As String

        NoStafSah = "02479"
        If DataMohonPot Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        Dim strSql = "select count(*) from smkb_gaji_master  where no_staf= '" & DataMohonPot.No_Staf & "' and Kod_trans = '" & DataMohonPot.Kod_Trans & "'"
        Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        If intCnt > 0 Then
            resp.Failed("Kod transaksi yang dimasukkan telah wujud bagi staf ini! Sila masukkan Kod Transaksi lain.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If


        'If fInsertMaster(DataMaster.No_Staf, DataMaster.Kod_Sumber, DataMaster.Jenis_Trans, DataMaster.Kod_Trans, DataMaster.Tkh_Mula_Trans, DataMaster.Tkh_Tamat_Trans, DataMaster.AmaunTrans, DataMaster.No_Trans, DataMaster.Catatan, DataMaster.Sta_Trans) <> "OK" Then
        If fInsertMaster(DataMohonPot) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If

        If success = 1 Then
            ' SendEmail(DataMohonPot.No_Staf, DataMohonPot.No_Mohon)
            SendEmailHantar(DataMohonPot.No_Mohon, DataMohonPot.No_Staf, NoStafSah)

            Session("NoStaf") = DataMohonPot.No_Staf
        resp.Success("Rekod berjaya disimpan", "00", DataMohonPot)
        Return JsonConvert.SerializeObject(resp.GetResult())
        Else
        resp.Failed("Rekod tidak berjaya disimpan")
        Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function
    Private Function fInsertMaster(DataMohonPot As DataMohonPot)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal
        Dim staMaster As String = ""
        Dim idmohon As String = ""

        If DataMohonPot.Sta_Trans = "AKTIF" Then
            staMaster = "A"
        ElseIf DataMohonPot.Sta_Trans = "BATAL" Then
            staMaster = "B"
        End If

        idmohon = GenOrderID("08", "GP", "ID MOHON BAGI PERMOHONAN POTONGAN STAF")
        DataMohonPot.No_Mohon = idmohon

        Dim query As String = "insert into SMKB_Gaji_Permohonan (ID_Mohon,No_Staf, Kod_Trans, Amaun, Status_Dok,Tkh_Mohon,Tkh_Mula,Tkh_Tamat) values (@idmohon,@nostaf,@kod,@amaun,@statrans,@tkh,@tkhmula,@tkhtmt)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idmohon", idmohon))
        param.Add(New SqlParameter("@nostaf", DataMohonPot.No_Staf))
        param.Add(New SqlParameter("@kod", DataMohonPot.Kod_Trans))
        param.Add(New SqlParameter("@amaun", Double.Parse(DataMohonPot.AmaunTrans).ToString("N2")))
        param.Add(New SqlParameter("@statrans", "01"))
        param.Add(New SqlParameter("@tkh", Date.Now))
        param.Add(New SqlParameter("@tkhmula", CDate(DataMohonPot.Tkh_Mula)))
        param.Add(New SqlParameter("@tkhtmt", CDate(DataMohonPot.Tkh_Tamat)))


        Return db.Process(query, param)
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateMaster(DataMohonPot As DataMohonPot) As String
        'Public Function SimpanAK(No_Arahan As String, No_Surat As String, No_Staf_Peg_AK As String, Kod_PTJ As String, KW As String, Kod_Vot As String, Tkh_Mula As String Tkh_Tamat As String, Lokasi As String, PeneranganK As String,  Jen_Dok as string, File_Name as string) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim dbconn As New DBKewConn

        If DataMohonPot Is Nothing Then
            resp.Failed("Tiada data!Rekod tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Dim strSql = "select count(*) from smkb_gaji_master  where no_staf= '" & DataMaster.No_Staf & "' and Kod_trans = '" & DataMaster.Kod_Trans & "' and jenis_trans =  '" & DataMaster.Jenis_Trans & "'"
        'Dim intCnt As Integer = dbconn.fSelectCount(strSql)
        'If intCnt > 0 Then
        '    resp.Failed("Kod transaksi yang dimasukkan telah wujud bagi staf ini! Sila masukkan Kod Transaksi lain.")
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        '    Exit Function
        'End If

        'If fInsertMaster(DataMaster.No_Staf, DataMaster.Kod_Sumber, DataMaster.Jenis_Trans, DataMaster.Kod_Trans, DataMaster.Tkh_Mula_Trans, DataMaster.Tkh_Tamat_Trans, DataMaster.AmaunTrans, DataMaster.No_Trans, DataMaster.Catatan, DataMaster.Sta_Trans) <> "OK" Then
        If fUpdateMaster(DataMohonPot) <> "OK" Then
            resp.Failed("Gagal Menyimpan Rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        Else

            success = 1

        End If


        If success = 1 Then
            Session("NoStaf") = DataMohonPot.No_Staf
            resp.Success("Rekod berjaya disimpan", "00", DataMohonPot)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function
    Private Function fUpdateMaster(DataMohonPot As DataMohonPot)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal = 0
        Dim staMaster As String = ""


        Dim query As String = "UPDATE SMKB_Gaji_Permohonan SET Tkh_Mula = @tkhmula, Tkh_Tamat = @tkhtmt, Amaun = @amaun WHERE ID_Mohon = @nomohon"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@tkhmula", CDate(DataMohonPot.Tkh_Mula)))
        param.Add(New SqlParameter("@tkhtmt", CDate(DataMohonPot.Tkh_Tamat)))
        param.Add(New SqlParameter("@amaun", Decimal.Parse(DataMohonPot.AmaunTrans).ToString("N2")))
        param.Add(New SqlParameter("@nomohon", DataMohonPot.No_Mohon))

        Return db.Process(query, param)
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function KemaskiniPermohonanPot(postData As String) As String
        Dim db As New DBKewConn
        Dim resp As New ResponseRepository
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        ' Access data using keys
        'Dim value1 As String = postDt("NoPendaftaran")

        ' Get No Pinjamam
        Dim NoPinjaman As String = postDt("NoPinjaman")

        Dim query As String = $"Update SMKB_Gaji_Permohonan Set
                            Kod_Trans= '{postDt("KodTrans")}', Amaun= '{postDt("Amaun")}'
                            Where No_Mohon = '{NoPinjaman}'"

        Dim UpdHdr As String = db.Process(query, param)
        ' Dim UpdDtl As String = db.Process(query2, param)

        If UpdHdr <> "OK" Then
            resp.Failed("Gagal menyimpan rekod permohonan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod telah berjaya dikemaskini", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListMohon(ByVal DateStart As String, ByVal DateEnd As String) As String
        Dim resp As New ResponseRepository


        'dt = GetListMohon(DateStart, DateEnd)

        Dim req As Response = GetListMohon(DateStart, DateEnd)
        Return JsonConvert.SerializeObject(req)
        'resp.SuccessPayload(dt)

        'Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetListMohon(DateStart As String, DateEnd As String) As Response
        Dim db = New DBKewConn
        Dim thngj As String = ""
        Dim blngj As String = ""
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200

        'dt = db.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        'If dt.Rows.Count > 0 Then
        '    blngj = dt.Rows(0).Item("bulan").ToString()
        '    thngj = dt.Rows(0).Item("tahun").ToString()
        'End If

        'Dim query As String = $"select ROW_NUMBER() OVER(ORDER BY Tkh_Mohon ASC) AS Bil,b.ID_Mohon,b.No_Staf,a.MS01_Nama,b.No_Staf +'|'+ a.MS01_Nama as nama,b.Kod_Trans,b.amaun,c.Butiran,b.Tkh_Mohon,isnull(b.Ulasan,'') Ulasan
        '                            FROM {DBStaf}MS01_Peribadi a, SMKB_Gaji_Permohonan b,SMKB_Gaji_Kod_Trans c
        '                            WHERE b.Status_Dok = '01'
        '                            AND b.No_Staf = a.MS01_NoStaf
        '                            AND b.Kod_Trans = c.Kod_Trans;"

        'Return db.Read(query)

        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"select ROW_NUMBER() OVER(ORDER BY Tkh_Mohon ASC) AS Bil,b.ID_Mohon ID_Mohon,b.No_Staf No_Staf,a.MS01_Nama MS01_Nama,
                                    b.No_Staf +'|'+ a.MS01_Nama as nama,b.Kod_Trans Kod_Trans,b.amaun amaun,c.Butiran Butiran,
                                    FORMAT(CONVERT(datetime, b.Tkh_Mohon), 'dd/MM/yyyy') AS FormattedDate,isnull(b.Ulasan,'') Ulasan,
                                    CONVERT(VARCHAR,ISNULL(Tkh_Mula,GETDATE()),103) Tkh_Mula,CONVERT(VARCHAR,ISNULL(Tkh_Tamat,GETDATE()),103) Tkh_Tamat
                                    FROM {DBStaf}MS01_Peribadi a, SMKB_Gaji_Permohonan b,SMKB_Gaji_Kod_Trans c
                                    WHERE b.Status_Dok = '01'
                                    AND b.No_Staf = a.MS01_NoStaf
                                    AND b.Kod_Trans = c.Kod_Trans
                                    "

                If DateStart IsNot Nothing And DateStart <> "" Then
                    sqlText += " AND b.Tkh_Mohon >= @DateStart "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateStart", DateStart))
                End If

                If DateEnd IsNot Nothing And DateEnd <> "" Then
                    sqlText += " AND b.Tkh_Mohon <= @DateEnd "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateEnd", DateEnd))
                End If

                sqlText += " ORDER BY b.Tkh_Mohon DESC;"
                sqlcmd.CommandText = sqlText

                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using
        Catch ex As Exception
            Dim strex As String = ex.Message
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBlnThnGaji()
        Dim db As New DBKewConn


        Dim query As String = $"select bulan,tahun,cast(bulan as varchar(2)) + '/' + cast(tahun as varchar(5)) as butir from SMKB_Gaji_bulan;"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListIncome(ByVal nostaf As String, ByVal tahun As Integer, ByVal bulan As Integer) As String
        Dim resp As New ResponseRepository


        dt = GetListIncome(nostaf, tahun, bulan)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetListIncome(nostaf As String, thn As Integer, bln As Integer) As DataTable
        Dim db = New DBKewConn

        'Dim query As String = $"Select SMKB_Gaji_Lejar.No_Staf,SMKB_Gaji_Lejar.Kod_Trans,SMKB_Gaji_Kod_Trans.Butiran,sum(SMKB_Gaji_Lejar.Amaun) As Amaun 
        'From SMKB_Gaji_Lejar, SMKB_Gaji_Kod_Trans
        'Where SMKB_Gaji_Lejar.Kod_Trans = SMKB_Gaji_Kod_Trans.Kod_Trans And SMKB_Gaji_Lejar.Jenis_Trans In ('H','B','G','E','O') 
        'And SMKB_Gaji_Lejar.Bulan={bln} And SMKB_Gaji_Lejar.Tahun={thn} And SMKB_Gaji_Lejar.No_Staf='{nostaf}' GROUP BY SMKB_Gaji_Lejar.No_Staf,   
        'SMKB_Gaji_Lejar.Kod_Trans, SMKB_Gaji_Kod_Trans.Butiran, SMKB_Gaji_Lejar.Jenis_Trans
        'order by(CASE WHEN SMKB_Gaji_Lejar.Jenis_Trans = 'G' THEN 0 WHEN SMKB_Gaji_Lejar.Jenis_Trans = 'E' THEN 1 ELSE 2 END)"

        Dim query As String = $"Select Kod_Sumber, Jenis_Trans, Kod_Trans,CONVERT(VARCHAR,ISNULL(Tkh_Mula,GETDATE()),103) Tkh_Mula,
        Convert(VARCHAR, ISNULL(Tkh_Tamat, GETDATE()), 103) Tkh_Tamat , Amaun, isnull(No_Trans,'') as no_trans,isnull(catatan,'') as catatan, 
        Case when status='A' then 'AKTIF' when status='B' then 'BATAL' else '-' end as status,no_staf from SMKB_Gaji_Master where no_staf = '{nostaf}' and status='A'
		And ((select Tarikh_Byr_Gaji from SMKB_Gaji_Tarikh_Gaji where bulan='{bln}' And tahun='{thn}') between Tkh_Mula And  Tkh_Tamat)
        and Jenis_Trans In ('H','B','G','E','O') 
		Order by(CASE WHEN Jenis_Trans = 'G' THEN 0 WHEN Jenis_Trans = 'E' THEN 1 ELSE 2 END),Kod_Trans"


        Return db.Read(query)
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListPotonganSlip(ByVal nostaf As String, ByVal tahun As Integer, ByVal bulan As Integer) As String
        Dim resp As New ResponseRepository


        dt = GetListPotonganSlip(nostaf, tahun, bulan)

        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function GetListPotonganSlip(nostaf As String, thn As Integer, bln As Integer) As DataTable
        Dim db = New DBKewConn

        '      Dim query As String = $"select SMKB_Gaji_Permohonan.No_Staf,   
        '      SMKB_Gaji_Permohonan.Kod_Trans,
        '      e.Butiran,   
        '      sum(SMKB_Gaji_Permohonan.Amaun) as Amaun,'1' as stadata from SMKB_Gaji_Permohonan, SMKB_Gaji_Kod_Trans e where 
        '      SMKB_Gaji_Permohonan.Kod_Trans = e.Kod_Trans and 
        '      SMKB_Gaji_Permohonan.No_Staf='{nostaf}' and SMKB_Gaji_Permohonan.Status_Dok='01'
        '      GROUP BY SMKB_Gaji_Permohonan.No_Staf,   
        '      SMKB_Gaji_Permohonan.Kod_Trans,e.Butiran
        'union all
        '      SELECT SMKB_Gaji_Lejar.No_Staf,   
        '      SMKB_Gaji_Lejar.Kod_Trans,
        '      SMKB_Gaji_Kod_Trans.Butiran,   
        '      sum(SMKB_Gaji_Lejar.Amaun) as Amaun,'2' as stadata
        '      FROM   SMKB_Gaji_Lejar, SMKB_Gaji_Kod_Trans
        '      WHERE  SMKB_Gaji_Lejar.Kod_Trans = SMKB_Gaji_Kod_Trans.Kod_Trans AND SMKB_Gaji_Lejar.Jenis_Trans in ('P','C','K','N','T','S') and SMKB_Gaji_Lejar.Bayar_Drpd='P'
        '      AND SMKB_Gaji_Lejar.Bulan={bln} AND SMKB_Gaji_Lejar.Tahun={thn} and SMKB_Gaji_Lejar.No_Staf='{nostaf}'
        '      GROUP BY SMKB_Gaji_Lejar.No_Staf,   
        '      SMKB_Gaji_Lejar.Kod_Trans,SMKB_Gaji_Kod_Trans.Butiran,SMKB_Gaji_Lejar.Jenis_Trans"


        Dim query As String = $"Select distinct 'GAJI' as Kod_Sumber,'P' as Jenis_Trans,SMKB_Gaji_Permohonan.Kod_Trans,   
        Convert(VARCHAR, ISNULL(SMKB_Gaji_Permohonan.Tkh_Mula, GETDATE()), 103) Tkh_Mula,
        Convert(VARCHAR, ISNULL(SMKB_Gaji_Permohonan.Tkh_Tamat, GETDATE()), 103) Tkh_Tamat,
        SMKB_Gaji_Permohonan.Amaun as Amaun,'-' as no_trans,
        '' as catatan,'BARU' as status,
        SMKB_Gaji_Permohonan.No_Staf, e.Butiran 
        From SMKB_Gaji_Permohonan, SMKB_Gaji_Kod_Trans e Where
        SMKB_Gaji_Permohonan.Kod_Trans = e.Kod_Trans And
        SMKB_Gaji_Permohonan.No_Staf ='{nostaf}' and SMKB_Gaji_Permohonan.Status_Dok='01'
        union all
        Select Kod_Sumber, Jenis_Trans, Kod_Trans,CONVERT(VARCHAR,ISNULL(Tkh_Mula,GETDATE()),103) Tkh_Mula,
        Convert(VARCHAR, ISNULL(Tkh_Tamat, GETDATE()), 103) Tkh_Tamat , Amaun, isnull(No_Trans,'') as no_trans,isnull(catatan,'') as catatan, 
        Case when status='A' then 'AKTIF' when status='B' then 'BATAL' else '-' end as status,no_staf,(select f.Butiran from SMKB_Gaji_Kod_Trans f where f.Kod_Trans=SMKB_Gaji_Master.Kod_Trans) as Butiran from SMKB_Gaji_Master where no_staf = '{nostaf}' and status='A'
        And ((select Tarikh_Byr_Gaji from SMKB_Gaji_Tarikh_Gaji where bulan={bln} And tahun={thn}) between Tkh_Mula And  Tkh_Tamat)
        And Jenis_Trans in ('P','C','K','N','T','S') and Bayar_Drpd='P'"
        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRekodStaf(No_Mohon As String)
        Dim db As New DBKewConn

        'Dim query As String = $"Select a.MS01_NoStaf,a.MS01_Nama,a.MS01_KpB,b.JawatanS,b.gredgajis,b.PejabatS,b.jumlahgajis,
        '                        case when a.ms01_status =1 then 'AKTIF' else 'TIDAK AKTIF' end status_staf,b.tarafkhidmat From MS01_Peribadi_1 a, VPerjawatan1 b, ms_skim
        '                        WHERE a.MS01_NoStaf = b.nostaf and ms01_nostaf = '{nostaf}' and ms08_staterkini=1;"

        Dim query As String = $"Select a.MS01_NoStaf,a.MS01_Nama,a.MS01_KpB,c.JawGiliran JawatanS,b.MS02_GredGajiS gredgajis,b.MS02_JumlahGajiS jumlahgajis,
        (Select skim from  {DBStaf}MS_Skim where kodskim = b.MS02_Skim ) As skim,
        (select Pejabat from {DBStaf}MS_Pejabat where KodPejabat=d.MS08_Pejabat) as PejabatS,
        Case when a.ms01_status =1 then 'AKTIF' else 'TIDAK AKTIF' end status_staf,
        (select TarafKhidmat from {DBStaf}MS_TarafKhidmat where KodTarafKhidmat=b.MS02_Taraf) tarafkhidmat,e.ID_Mohon 
        From {DBStaf}MS01_Peribadi a, {DBStaf}MS02_Perjawatan b, {DBStaf}MS_Jawatan c, {DBStaf}MS08_Penempatan d, SMKB_Gaji_Permohonan e
        WHERE a.MS01_NoStaf = b.MS01_NoStaf And a.MS01_NoStaf = d.MS01_NoStaf and a.ms01_nostaf = e.No_Staf And e.ID_Mohon = '{No_Mohon}' and d.MS08_StaTerkini = 1 and b.MS02_JawSandang = c.KodJawatan;"

        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Public Class StaffMohon
        Public Property NoMohon As String

    End Class

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanROC(data As List(Of StaffMohon))
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

        While counter < data.Count

            'data(counter).NoMohon


            counter += 1
        End While

        If success = 1 Then
            resp.Success("Rekod berjaya disimpan")
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
        'Return JsonConvert.SerializeObject(dt)
    End Function

    'get modal pinjaman data
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getFullSokonganData(ByVal No_Mohon As String) As String
        Dim hdr As Response = fetchSokonganHdrFull(No_Mohon)
        If hdr.Code <> "200" Then
            Return JsonConvert.SerializeObject(hdr)
        End If

        Dim data As New Dictionary(Of String, Object)()
        data.Add("hdr", hdr.Payload)

        Dim response As New Response
        response.Code = "200"
        response.Payload = data

        Return JsonConvert.SerializeObject(response)

    End Function

    'query modal pinjaman
    Private Function fetchSokonganHdrFull(No_Mohon As String) As Response
        Dim res As New Response
        res.Code = 200
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn
                sqlcmd.CommandText = $"Select distinct e.ID_Mohon ,a.MS01_NoStaf,a.MS01_Nama,a.MS01_KpB,c.JawGiliran JawatanS,b.MS02_GredGajiS gredgajis,b.MS02_JumlahGajiS jumlahgajis,
                                        (Select skim from  {DBStaf}MS_Skim where kodskim = b.MS02_Skim ) As skim,
                                        (select Pejabat from {DBStaf}MS_Pejabat where KodPejabat=d.MS08_Pejabat) as PejabatS,
                                        Case when a.ms01_status =1 then 'AKTIF' else 'TIDAK AKTIF' end status_staf,
                                        (select TarafKhidmat from {DBStaf}MS_TarafKhidmat where KodTarafKhidmat=b.MS02_Taraf) tarafkhidmat
                                        From {DBStaf}MS01_Peribadi a, {DBStaf}MS02_Perjawatan b, {DBStaf}MS_Jawatan c, {DBStaf}MS08_Penempatan d, SMKB_Gaji_Permohonan e
                                        WHERE a.MS01_NoStaf = b.MS01_NoStaf And a.MS01_NoStaf = d.MS01_NoStaf and a.ms01_nostaf = e.No_Staf And e.ID_Mohon = @No_Pinj
                                        and d.MS08_StaTerkini = 1 and b.MS02_JawSandang = c.KodJawatan;"
                sqlcmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Mohon))
                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using

        Catch ex As Exception
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function


    ''Update kemaskini dari Kelulusan PTJ
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function KemaskiniPTJ(txtNoMohonR As String, Ulasan As String) As String
        Dim resp As New ResponseRepository

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan di tab 1.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim rekodPermohonan = GetLoadPermohonan(txtNoMohonR)

        If rekodPermohonan.Rows.Count = 0 Then
            resp.Failed("Rekod Permohonan tidak dijumpai.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf UpdateKemaskiniPTJ(txtNoMohonR, Ulasan) <> "OK" Then
            resp.Failed("Gagal menghantar ulasan.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        ElseIf InsertUlasanPTJ(txtNoMohonR, Ulasan) <> "OK" Then
            resp.Failed("Gagal menghantar ulasan.")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        resp.Success("Ulasan berjaya disimpan di pangkalan data.", "00", txtNoMohonR)

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetLoadPermohonan(id_mohon As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = $"select a.MS01_Nama,b.No_Staf,b.ID_Mohon,b.Kod_Trans,b.amaun,c.Butiran,CONVERT(VARCHAR,ISNULL(Tkh_Mula,GETDATE()),103) Tkh_Mula,CONVERT(VARCHAR,ISNULL(Tkh_Tamat,GETDATE()),103) Tkh_Tamat
                                    FROM {DBStaf}MS01_Peribadi a, SMKB_Gaji_Permohonan b,SMKB_Gaji_Kod_Trans c
                                    WHERE b.ID_Mohon = @id_mohon
                                    AND b.No_Staf = a.MS01_NoStaf
                                    AND b.Kod_Trans = c.Kod_Trans;"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@id_mohon", id_mohon))

        Dim dt As DataTable = db.Read(query, param)

        Return dt
    End Function
    Private Function UpdateKemaskiniPTJ(txtNoMohonR As String, vulasan As String)
        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_Gaji_Permohonan SET Status_Dok = '03',ulasan = @ulasan  WHERE ID_Mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@ulasan", vulasan))
        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))

        Return db.Process(query, param)
    End Function

    Private Function InsertUlasanPTJ(txtNoMohonR As String, Ulasan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Gaji_Permohonan SET Status_Dok = '03',Ulasan = @Ulasan WHERE ID_Mohon = @NoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Ulasan", Ulasan))
        param.Add(New SqlParameter("@NoMohon", txtNoMohonR))


        Return db.Process(query, param)
    End Function


    'Update Status dari kelulusan PTJ hahaha
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PtjLulusPermohonan(txtNoMohonR As String) As String
        Dim resp As New ResponseRepository
        Dim dbconn As New DBKewConn
        Dim dt As New DataTable
        Dim vnostaf As String
        Dim vtkhmula As String
        Dim vtkhtmt As String
        Dim vamaun As String
        Dim vkodtrans As String
        Dim success As Integer = 0

        If String.IsNullOrEmpty(txtNoMohonR) Then
            resp.Failed("Sila pilih no permohonan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        dt = dbconn.Read("SELECT no_staf,kod_trans,tkh_mula,tkh_tamat,amaun FROM smkb_gaji_permohonan where id_mohon = '" & txtNoMohonR & "' ")
        If dt.Rows.Count > 0 Then
            vnostaf = dt.Rows(0).Item("no_staf").ToString()
            vtkhmula = dt.Rows(0).Item("tkh_mula").ToString()
            vtkhtmt = dt.Rows(0).Item("tkh_tamat").ToString()
            vamaun = dt.Rows(0).Item("amaun").ToString()
            vkodtrans = dt.Rows(0).Item("kod_trans").ToString()
        End If

        If UpdateStatusPTJ(txtNoMohonR) <> "OK" Then
            resp.Failed("Gagal menghantar sokongan permohonan.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else

            Dim strSql = "select count(*) from smkb_gaji_master  where no_staf= '" & vnostaf & "' and Kod_trans = '" & vkodtrans & "' and jenis_trans = 'P'"
            Dim intCnt As Integer = DBConn.fSelectCount(strSql)
            If intCnt > 0 Then
                If fUpdateMaster(vnostaf, vtkhmula, vtkhtmt, vkodtrans, vamaun) <> "OK" Then
                    success = 2
                Else
                    success = 1
                End If


            Else
                If fInsertMaster(vnostaf, vtkhmula, vtkhtmt, vkodtrans, vamaun) <> "OK" Then
                    success = 2
                Else
                    success = 1
                End If
            End If
        End If


        If success = 1 Then
            resp.Success("Permohonan berjaya disokong.")
        Else
            resp.Failed("Rekod tidak berjaya disokong.")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function
    Private Function UpdateStatusPTJ(txtNoMohonR As String)

        Dim db As New DBKewConn
        Dim checkExist As Integer

        Dim query As String = "UPDATE SMKB_Gaji_Permohonan SET Status_Dok = '02' WHERE ID_mohon = @txtNoMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtNoMohon", txtNoMohonR))

        Return db.Process(query, param)


    End Function
    Private Function fInsertMaster(vnostaf As String, vtkhmula As String, vtkhtmt As String, vkodtrans As String, vamaun As String)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal
        Dim staMaster As String = ""
        Dim no_id As String = ""

        no_id = GenOrderID("08", "M", "ID BAGI TRANSAKSI MASTER")

        Dim query As String = "insert into SMKB_Gaji_Master (No_Staf, Kod_Sumber, Jenis_Trans, Kod_Trans,Tkh_Mula, Tkh_Tamat, Amaun, No_Trans, Catatan, Status, Bayar_Drpd  ) values (@nostaf,@sumber,@jenis,@kod, @tkhmula, @tkhtmt, @amaun, @noruj, @catatan, @statrans, @byr)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@nostaf", vnostaf))
        param.Add(New SqlParameter("@sumber", "GAJI"))
        param.Add(New SqlParameter("@jenis", "P"))
        param.Add(New SqlParameter("@kod", vkodtrans))
        param.Add(New SqlParameter("@tkhmula", CDate(vtkhmula)))
        param.Add(New SqlParameter("@tkhtmt", CDate(vtkhtmt)))
        param.Add(New SqlParameter("@amaun", Decimal.Parse(vamaun).ToString("N2")))
        param.Add(New SqlParameter("@noruj", "-"))
        param.Add(New SqlParameter("@catatan", "-"))
        param.Add(New SqlParameter("@statrans", "A"))
        param.Add(New SqlParameter("@byr", "P"))

        Return db.Process(query, param)
    End Function
    Private Function fUpdateMaster(vnostaf As String, vtkhmula As String, vtkhtmt As String, vkodtrans As String, vamaun As String)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim jumlah As Decimal = 0
        Dim staMaster As String = ""

        Dim query As String = "UPDATE SMKB_Gaji_Master SET Tkh_Mula = @tkhmula, Tkh_Tamat = @tkhtmt, Amaun = @amaun, Status = @statrans WHERE no_staf = @nostaf and Kod_Trans = @kod"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@tkhmula", CDate(vtkhmula)))
        param.Add(New SqlParameter("@tkhtmt", CDate(vtkhtmt)))
        param.Add(New SqlParameter("@amaun", Decimal.Parse(vamaun).ToString("N2")))
        param.Add(New SqlParameter("@statrans", "A"))
        param.Add(New SqlParameter("@nostaf", vnostaf))
        param.Add(New SqlParameter("@kod", vkodtrans))

        Return db.Process(query, param)
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

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String, Butiran As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))


        Return db.Process(query, param)
    End Function
    Private Function GenOrderID(kodModul, prefix, butiran) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newNoID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='{kodModul}' AND Prefix ='{prefix}' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            lastID = CInt(dtbl.Rows(0).Item("id")) + 1

            UpdateNoAkhir($"{kodModul}", $"{prefix}", year, lastID)
        Else

            InsertNoAkhir($"{kodModul}", $"{prefix}", year, lastID, butiran)
        End If
        newNoID = $"{prefix}" + Format(lastID, "00000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newNoID
    End Function
    Public Function SendEmailHantar(Noarahan As String, Nostaf As String, NoStafSah As String) As String
        Dim nama As String
        Dim email As String
        Dim KodSubMenu As String
        Dim clsCrypto As New clsCrypto
        Dim db As New DBKewConn

        Using dtUserInfo = fGetUserInfo(Nostaf)
            If dtUserInfo.Rows.Count > 0 Then
                nama = dtUserInfo.Rows.Item(0).Item("MS01_Nama")
            End If
        End Using

        Using dtUserInfo = fGetUserInfo(NoStafSah)
            If dtUserInfo.Rows.Count > 0 Then
                email = dtUserInfo.Rows.Item(0).Item("MS01_Email")
            End If
        End Using

        'set id pka
        ' Nostaf = "02634"
        'Nostaf = "02684"
        ' email = "syafiqah@utem.edu.my"
        'email = "muhammadfarid@utem.edu.my"
        KodSubMenu = "080206" 'pengesahan OT
        NoStafSah = "02479"
        'create token
        Dim combineData = NoStafSah + Now() + Noarahan
        ' Dim id = clsCrypto.fEncrypt(combineData)

        Dim id = Replace(Replace(Replace(clsCrypto.fEncrypt(combineData), "/", "@"), "+", "@"), "%", "@")

        Dim currentUrl As Uri = HttpContext.Current.Request.Url

        ' Construct the URL using the current request URL
        Dim url As String = currentUrl.Scheme & "://" & currentUrl.Authority & "/SMKBNet/loginsmkb?id=" & id


        'mula insert SMKB_Emel_Auth
        Dim paramSqlBtrn() As SqlParameter = Nothing
        Dim strSqlButiran = "INSERT INTO SMKB_Emel_Auth (ID_Token, No_Staf_Penerima, Emel_Penerima, Tarikh_Luput_URL, Kod_Sub_Menu, No_Rujukan)
                                            VALUES (@ID_Token, @No_Staf_Penerima, @Emel_Penerima, @Tarikh_Luput_URL, @Kod_Sub_Menu, @No_Rujukan)"
        paramSqlBtrn = {New SqlParameter("@ID_Token", id),
                                New SqlParameter("@No_Staf_Penerima", NoStafSah),
                                New SqlParameter("@Emel_Penerima", email),
                                New SqlParameter("@Tarikh_Luput_URL", "2024-05-30"),
                                New SqlParameter("@Kod_Sub_Menu", KodSubMenu),
                                New SqlParameter("@No_Rujukan", Noarahan)
                            }


        If db.fInsertCommand(strSqlButiran, paramSqlBtrn) > 0 Then


            ' Send the new password to the user's email
            Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
            Dim body As String = "Permohonan Potongan Gaji Staf " _
            & "<br><br>" _
            & vbCrLf & "Assalamualaikum Dan Salam Sejahtera " _
            & "<br><br>" _
            & vbCrLf & "Dimaklumkan bahawa, staf " & nama & " telah memohon potongan gaji melalui portal." _
            & vbCrLf & "Sehubungan dengan itu, dipohon kerjasama tuan/puan untuk menyokong atau meluluskan permohonan" _
            & vbCrLf & "tersebut sekiranya tuan/puan berpuas hati dengan permohonan yang dibuat oleh tersebut." _
            & "<br><br>" _
            & vbCrLf & "Sila klik di link ini untuk menyemak permohonan tersebut untuk kelulusan melalui <a href=" + url + ">" + url + "</a>" _
            & "<br><br>" _
            & vbCrLf & "Email ini dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " _
            & "<br><br>"

            myEmel(email, subject, body)
            fMobileNotis(id, NoStafSah)
        Else
            db.sConnRollbackTrans()
        End If

    End Function


    Public Async Function fMobileNotis(id As String, NoStaff_Penerima As String) As Tasks.Task(Of String)
        Dim resp As New ResponseRepository
        Dim response = New Response
        Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Permohonan Potongan Gaji Staf.Memerlukan kelulusan anda untuk Permohonan Potongan Gaji Staf./" + id + "/" + NoStaff_Penerima
        Using client As New HttpClient()
            Dim content = New FormUrlEncodedContent(New Dictionary(Of String, String)())
            Dim response1 As HttpResponseMessage = Await client.PostAsync(apiUrl, content)

            If response1.IsSuccessStatusCode Then
                'resp.Success("Permohonan perolehan berjaya dihantar.", "00", txtNoMohonR)
                'response = resp.GetResult()
            Else
                resp.Failed("gagal.")
            End If
        End Using
    End Function
End Class