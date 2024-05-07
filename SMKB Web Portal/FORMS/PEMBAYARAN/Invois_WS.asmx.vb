Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Net.Http.Headers
Imports Microsoft.Ajax.Utilities
Imports System.Globalization
'Imports System.Globalization
Imports System.Threading
Imports System.Runtime.InteropServices
' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Invois_WS
    Inherits System.Web.Services.WebService



    'test api
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=True)>
    Public Function ping() As String
        '  logInvoisDok("test", "testlog")
        'test
        Return JsonConvert.SerializeObject(Session("ssusrID"))
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=True, ResponseFormat:=ResponseFormat.Json)>
    Public Function getInvoisHeader(ID_Rujukan As String) As String
        Dim response As New Response
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)

                sqlconn.Open()

                Dim cmd As New SqlCommand
                cmd.Connection = sqlconn
                cmd.CommandText = "SELECT * FROM SMKB_Pembayaran_Invois_Hdr 
                                WHERE ID_Rujukan=@ID_Rujukan"
                cmd.Parameters.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))
                Dim dt As New DataTable
                dt.Load(cmd.ExecuteReader())

                response.Payload = dt
                response.Code = 200

            End Using
        Catch ex As Exception
            response.Status = 500
            response.Message = ex.Message

        End Try

        Return JsonConvert.SerializeObject(response)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=True, ResponseFormat:=ResponseFormat.Json)>
    Public Function getIntegrationHeader(ID_Rujukan As String) As String
        Dim response As New Response
        Dim data
        data = Split(ID_Rujukan, "|")
        Dim idrujukan = data(0)
        Dim jnsinv = data(1)
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)

                sqlconn.Open()

                Dim cmd As New SqlCommand
                cmd.Connection = sqlconn

                cmd.CommandText = "SELECT 'BP' AS Jenis_Bayar,@jnsinv AS Jenis_Invois, No_Order AS No_Rujukan,Jumlah_Keseluruhan AS Jumlah_Sebenar,* FROM AP_Order_Hdr 
                                    WHERE No_Order=@ID_Rujukan"
                cmd.Parameters.Add(New SqlParameter("@ID_Rujukan", idrujukan))
                cmd.Parameters.Add(New SqlParameter("@jnsinv", jnsinv))
                Dim dt As New DataTable
                dt.Load(cmd.ExecuteReader())

                response.Payload = dt
                response.Code = 200

            End Using
        Catch ex As Exception
            response.Status = 500
            response.Message = ex.Message

        End Try

        Return JsonConvert.SerializeObject(response)
    End Function
    'insert invois
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function insertInvois(invois As InvoisHdr) As String
        'dok daftar
        If invois.Kategori_Invois.Equals("PP") Then
            invois.Status_Dok = "03"
        ElseIf invois.Kategori_Invois.Equals("INV") Then
            invois.Status_Dok = "01"
        End If
        Dim response As New Response
        response.Code = 200
        response.Message = "Berjaya disimpan"
        invois.ID_Rujukan = generateIDRujukan(Session("ssusrKodPTj"))

        Dim query As New Query()
        Try
            If query.execute(invois.ID_Rujukan, "ID_Rujukan", invois.InsertCommand()) > 0 Then

                If invois.details IsNot Nothing Then
                    Dim dtlRes As Response = insertInvoisDetail(invois.ID_Rujukan, invois.details, query)
                    If dtlRes.Code <> "200" Then
                        Throw New Exception("Maklumat transaksi gagal disimpan")
                    End If
                Else
                    logInvoisDok(invois.ID_Rujukan, invois.Status_Dok)
                End If

                response.Code = "200"
                response.Message = "berjaya disimpan"
                query.finish()
            Else
                Throw New Exception("Gagal memasukkan data invois")
            End If
        Catch ex As Exception
            query.rollback()
            Query.logError_RunningNo(invois.ID_Rujukan, "03", ex.Message)
            response.Message = ex.Message
            response.Code = 500
        End Try
        Return JsonConvert.SerializeObject(response)
    End Function


    'invois listing new
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getInvoisDraf(ByVal DateStart As String, ByVal DateEnd As String) As String
        Dim dok As New List(Of String) From {"01"}
        Dim req As Response = fetchInvoisSum(dok, DateStart, DateEnd)
        Return JsonConvert.SerializeObject(req)
    End Function
    'invois listing new
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getPPDraf(ByVal DateStart As String, ByVal DateEnd As String) As String
        Dim dok As New List(Of String) From {"03"}
        Dim req As Response = fetchInvoisSum(dok, DateStart, DateEnd)
        Return JsonConvert.SerializeObject(req)
    End Function

    'invois di hantar untuk penerimaan
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getInvoisHantar(ByVal DateStart As String, ByVal DateEnd As String) As String
        Dim dok As New List(Of String) From {"02"}
        Dim req As Response = fetchInvoisSum(dok, DateStart, DateEnd)
        Return JsonConvert.SerializeObject(req)
    End Function


    'pp di hantar untuk sokongan
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getPPHantar(ByVal DateStart As String, ByVal DateEnd As String) As String
        Dim dok As New List(Of String) From {"04"}
        Dim req As Response = fetchInvoisSum(dok, DateStart, DateEnd)
        Return JsonConvert.SerializeObject(req)
    End Function


    'pp di hantar untuk terimaan (dah di sokong)
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getPPSokong(ByVal DateStart As String, ByVal DateEnd As String) As String
        Dim dok As New List(Of String) From {"06"}
        Dim req As Response = fetchInvoisSum(dok, DateStart, DateEnd)
        Return JsonConvert.SerializeObject(req)
    End Function





    'full invois data
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getFullInvoisData(ByVal ID_Rujukan As String) As String
        Dim hdr As Response = fetchInvoisHdrFull(ID_Rujukan)
        Dim dtl As Response = fetchInvoisDtlFull(ID_Rujukan)
        If hdr.Code <> "200" Then
            Return JsonConvert.SerializeObject(hdr)
        End If
        If dtl.Code <> "200" Then
            Return JsonConvert.SerializeObject(dtl)
        End If
        Dim data As New Dictionary(Of String, Object)()
        data.Add("hdr", hdr.Payload)
        data.Add("dtl", dtl.Payload)
        Dim response As New Response
        response.Code = "200"
        response.Payload = data

        Return JsonConvert.SerializeObject(response)

    End Function


    'delete invois detail
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function delInvoisDetail(invoisDtl As InvoisDtl) As String
        Return JsonConvert.SerializeObject(deleteInvoisDtl(invoisDtl))
    End Function

    'update invois hdr to 06
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function sokongPermohonanPembayaran(invois As InvoisHdr, ulasan As String) As String
        Dim res As New Response
        invois.Status_Dok = "06"
        Dim query As New Query()
        res = doUpdateInvoisHdr(invois, query)
        If res.Code.Equals("200") Then
            query.finish()
            logInvoisDok(invois.ID_Rujukan, invois.Status_Dok, ulasan)
        Else
            query.rollback()
        End If
        Return JsonConvert.SerializeObject(res)
    End Function


    'update invois hdr
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function updateInvoisHdr(invois As InvoisHdr) As String
        Dim res As New Response
        Dim query As New Query
        res = doUpdateInvoisHdr(invois, query)
        If res.Code.Equals("200") Then
            query.finish()
        Else
            query.rollback()
        End If
        Return JsonConvert.SerializeObject(res)
    End Function




    'update invois hdr
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function batalInvois(invois As InvoisHdr) As String
        invois.Status_Dok = 20
        Dim query As New Query()
        Dim res As Response = doUpdateInvoisHdr(invois, query)
        If res.Code.Equals("200") Then
            query.finish()
            logInvoisDok(invois.ID_Rujukan, invois.Status_Dok)
        Else
            query.rollback()
        End If
        Return JsonConvert.SerializeObject(res)
    End Function


    'update invois =
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function updateInvoisData(invois As InvoisHdr) As String
        If invois.Kategori_Invois.Equals("PP") Then
            invois.Status_Dok = "03"
        ElseIf invois.Kategori_Invois.Equals("INV") Then
            invois.Status_Dok = "01"
        End If
        Dim res As Response = updateFullInvoisData(invois)
        If res.Code.Equals("200") Then
            logInvoisDok(invois.ID_Rujukan, invois.Status_Dok)
        End If
        Return JsonConvert.SerializeObject(res)
    End Function

    'hantar invois =
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function submitInvoisData(invois As InvoisHdr) As String
        If invois.Kategori_Invois.Equals("PP") Then
            invois.Status_Dok = "04"
        ElseIf invois.Kategori_Invois.Equals("INV") Then
            invois.Status_Dok = "02"
        End If
        Dim res As Response = updateFullInvoisData(invois)
        If res.Code.Equals("200") Then
            logInvoisDok(invois.ID_Rujukan, invois.Status_Dok)
        End If
        Return JsonConvert.SerializeObject(res)
    End Function

    Private Function updateFullInvoisData(invois As InvoisHdr) As Response
        Dim query As New Query
        Dim res As Response = doUpdateInvoisHdr(invois, query)
        Dim resdtl As Response = saveInvoisDtl(invois.details, query)
        If res.Code <> "200" Or resdtl.Code <> "200" Then
            res.Code = 500
            res.Message = "Gagal Kemaskini invois"
            query.rollback()
            Return res
        Else
            query.finish()
            Return res
        End If
    End Function


    'get specific vot 
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVotCOASpecific(ByVal Kod As List(Of String)) As String
        Dim db = New DBKewConn

        Dim statusList As String = String.Join(",", Kod.Select(Function(s) $"'{s}'"))
        Dim query As String = "
                SELECT  DISTINCT
                    a.Kod_Vot as KodVOT,  a.Kod_PTJ as KodPTJ , a.Kod_Kump_Wang as KodKW , a.Kod_Operasi as KodKO , a.Kod_Projek as KodKP,
                    vot.Butiran as VOT,   mj.Pejabat as PTJ , kw.Butiran as KW , ko.Butiran as KO ,  kp.Butiran as KP 
                FROM SMKB_COA_Master AS a 
                    JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                    JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                    JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
					JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
					JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_PTJ,2) 
                WHERE a.status = 1 AND a.Kod_Vot IN(" & statusList & ") "
        Dim param As New List(Of SqlParameter)

        Return JsonConvert.SerializeObject(db.Read(query, param))
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSpecificPemiutang(ByVal Kod As List(Of String)) As String
        Dim db = New DBKewConn

        Dim statusList As String = String.Join(",", Kod.Select(Function(s) $"'{s}'"))
        Dim query As String = "
             SELECT *, STUFF(
	            (select '|'+ dtl.Kod_Detail + '--'+ dtl.Butiran from SMKB_Pemiutang_Master p
	              JOIN SMKB_Lookup_Detail dtl 
	              ON (p.Kod_Negara = dtl.Kod_Detail AND dtl.Kod = '0001')
	              OR (p.Kod_Negeri = dtl.Kod_Detail AND dtl.Kod = '0002')
	              OR (p.Bandar = dtl.Kod_Detail AND dtl.Kod = '0003')  
	              WHERE p.Kod_Pemiutang IN (" & statusList & ")
	              FOR XML PATH('')),1,1,''
            ) As Butiran_Kod_Alamat FROM SMKB_Pemiutang_Master 
            WHERE Kod_Pemiutang IN (" & statusList & ") "
        Dim param As New List(Of SqlParameter)

        Return JsonConvert.SerializeObject(db.Read(query, param))

    End Function


    'kod vot untuk pilihan kelulusan invois
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getKodVotBelanja(ByVal tarikh As String) As String
        Dim db = New DBKewConn
        ' Kod_Vot IN ( '81101', '81401', '81402') perlu? kalau mmg untuk invois shaja no need since yg lain null auto false
        Dim query As String = "
            SELECT * FROM SMKB_Vot
              WHERE 
              (MONTH(AP_Invois_TkhMula) <= MONTH(@date) AND MONTH(AP_Invois_TkhTamat) >= MONTH(@date)) 
              AND
              (DAY(AP_Invois_TkhMula) <= DAY(@date) AND DAY(AP_Invois_TkhTamat) >= DAY(@date))
        "
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@date", tarikh))
        Return JsonConvert.SerializeObject(db.Read(query, param))
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getJenInv(ByVal q As String, ByVal kategori As String) As String
        Dim pp As Boolean = False
        Dim invois As Boolean = False
        Dim tmpDT As New DataTable
        If kategori.Equals("PP") Then
            pp = True
        End If
        If kategori.Equals("INV") Then
            invois = True
        End If
        Return JsonConvert.SerializeObject(GetKodJenInvList(q, pp, invois))
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function lulusInvois(invois As InvoisHdr, ulasan As String) As Tasks.Task(Of String)
        Dim res As New Response
        Dim query As New Query

        If String.IsNullOrEmpty(invois.Kod_Vot) Then
            res.Code = 400
            res.Message = "Invalid Vot"
            Return JsonConvert.SerializeObject(res)
        End If

        If invois.Kategori_Invois = "PP" Then
            invois.Status_Dok = "07"
        ElseIf invois.Kategori_Invois = "INV" Then
            invois.Status_Dok = "42"
        Else
            res.Code = 400
            res.Message = "Kategori tidak sah"

            Return JsonConvert.SerializeObject(res)
        End If

        res = doUpdateInvoisHdr(invois, query)
        If Not res.Code.Equals("200") Then
            res.Message = "Maklumat invois gagal di simpan"
            query.rollback()
            Return JsonConvert.SerializeObject(res)
        End If

        logInvoisDok(invois.ID_Rujukan, invois.Status_Dok, ulasan)

        Dim userId As String = Session("ssusrID")

        For Each dtl As InvoisDtl In invois.details
            Try
                If dtl.Kod_Pemiutang IsNot Nothing And Not dtl.Kod_Pemiutang.Equals("") Then
                    res = Await debitIntoGeneralLedger(userId, dtl, invois.Tarikh_Invois)
                    If res.Code.Equals("200") Then
                        res = Await creditIntoAccPemiutang(userId, dtl, invois.Tarikh_Invois, invois.Kod_Vot)
                        If Not res.Code.Equals("200") Then
                            Throw New Exception("Gagal memasukkan data kedalam lejar")
                        End If
                    Else
                        Throw New Exception("Gagal memasukkan data kedalam lejar")
                    End If
                End If
            Catch ex As Exception
                query.rollback()
                res.Message = ex.Message
            End Try
        Next
        query.finish()
        res.Message = "Maklumat berjaya disimpan"
        Return JsonConvert.SerializeObject(res)
    End Function
    Private Async Function creditIntoAccPemiutang(userId As String, invDtl As InvoisDtl, tarikh As String, vot As String) As Tasks.Task(Of Response)
        Return Await SharedModulePembayaran.sendDataIntoLejar(userId, "AP", invDtl, True, tarikh, vot)
    End Function
    Private Async Function debitIntoAccPemiutang(userId As String, invDtl As InvoisDtl, tarikh As String, vot As String) As Tasks.Task(Of Response)
        Return Await SharedModulePembayaran.sendDataIntoLejar(userId, "AP", invDtl, False, tarikh, vot) 'betul ke ap 
    End Function
    Private Async Function creditIntoGeneralLedger(userId As String, invDtl As InvoisDtl, tarikh As String) As Tasks.Task(Of Response)
        Return Await SharedModulePembayaran.sendDataIntoLejar(userId, "GL", invDtl, True, tarikh)
    End Function
    Private Async Function debitIntoGeneralLedger(userId As String, invDtl As InvoisDtl, tarikh As String) As Tasks.Task(Of Response)
        Return Await SharedModulePembayaran.sendDataIntoLejar(userId, "GL", invDtl, False, tarikh)
    End Function

    '@param kategori should be either PP or INV
    Private Function GetKodJenInvList(kod As String, PermohonanPembayaran As Boolean, Invois As Boolean) As DataTable

        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod as value, Kod + ' - ' + Butiran as text FROM SMKB_Pembayaran_Jenis_Invois WHERE Status='1' 
                        AND  Kategori_Inv = @Kategori_Inv AND Kategori_PP = @Kategori_PP "
        Dim param As New List(Of SqlParameter)

        Dim pp As String = "0"
        Dim inv As String = "0"
        If PermohonanPembayaran Then
            pp = "1"
        End If
        If Invois Then
            inv = "1"
        End If
        If kod <> "" Then
            query &= " AND (Kod LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If


        param.Add(New SqlParameter("@Kategori_Inv", inv))
        param.Add(New SqlParameter("@Kategori_PP", pp))

        Return db.Read(query, param)
    End Function



    'insert invois details

    Private Function insertInvoisDetail(details As InvoisDtl, ByRef query As Query) As Response
        Dim lst As New List(Of InvoisDtl) From {details}
        Return insertInvoisDetail(details.ID_Rujukan, lst, query)
    End Function

    Private Function insertInvoisDetail(ID_Rujukan As String, details As List(Of InvoisDtl), ByRef query As Query) As Response
        Dim response As New Response
        response.Code = "200"
        response.Message = "Berjaya di simpan"
        Try
            For Each dtl As InvoisDtl In details
                dtl.No_Item = InvoisDtl.getNo_Item(ID_Rujukan)
                dtl.ID_Rujukan = ID_Rujukan

                Dim id As New Dictionary(Of String, String)
                id.Add("ID_Rujukan", dtl.ID_Rujukan)
                id.Add("No_Item", dtl.No_Item)
                If query.execute(id, dtl.InsertCommand()) < 1 Then
                    Throw New Exception("Gagal Menyimpan Maklumat transaksi")
                End If
            Next
        Catch ex As Exception
            response.Code = 500
            response.Message = ex.Message
        End Try

        Return response
    End Function



    Private Function fetchInvoisSum(Status_Dok As String, DateStart As String, DateEnd As String) As Response
        Dim tmp As New List(Of String)
        tmp.Add(Status_Dok)
        Return fetchInvoisSum(tmp, DateStart, DateEnd)
    End Function

    'query invois hdr with sum
    Private Function fetchInvoisSum(Status_Dok As List(Of String), DateStart As String, DateEnd As String) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim statusList As String = String.Join(",", Status_Dok.Select(Function(s) $"'{s}'"))
                Dim sqlText As String = "Select hdr.ID_Rujukan,hdr.No_Invois, hdr.Tarikh_Daftar, hdr.Tarikh_Invois, hdr.Tarikh_Terima_Invois, hdr.Tujuan,
                jb.Kod + ' - ' + jb.Butiran as Jenis_Bayar,
                ji.Kod + ' - ' + ji.Butiran as Jenis_Invois,
                dtl.Jumlah,
				(SELECT SUBSTRING((
				SELECT distinct ' , ' + Nama_Pemiutang 
				FROM SMKB_Pembayaran_Invois_Hdr A,
				SMKB_Pembayaran_Invois_Dtl B,
				SMKB_Pemiutang_Master C  
				WHERE A.ID_Rujukan=B.ID_Rujukan AND B.Kod_Pemiutang=C.Kod_Pemiutang
				AND A.ID_Rujukan=hdr.ID_Rujukan  FOR XML PATH('')
				), 3, 1000) AS Combined_Names) AS Nama_Pemiutang,kdsts.Butiran AS Status
                From SMKB_Pembayaran_Invois_Hdr hdr
                JOIN 
                SMKB_Pembayaran_Jenis_Bayar jb ON hdr.Jenis_Bayar = jb.Kod
                JOIN
                SMKB_Pembayaran_Jenis_Invois ji ON hdr.Jenis_Invois = ji.Kod
                LEFT JOIN
                (SELECT
                    ID_Rujukan,
                    SUM(
                        COALESCE(Kadar_Harga, 0) * COALESCE(Kuantiti_Sebenar, 0)
                        + COALESCE(Amaun_Dicukai,0) * COALESCE(Kuantiti_Sebenar, 0) 
						-(COALESCE(Kadar_Harga, 0) *  COALESCE(Kuantiti_Sebenar, 0) * COALESCE(Diskaun, 0) / 100) 
                        +(COALESCE(Amaun_Dicukai,Kadar_Harga, 0) *  COALESCE(Kuantiti_Sebenar, 0) * COALESCE(Cukai, 0) / 100)
						 
                    ) AS Jumlah
                FROM
                    SMKB_Pembayaran_Invois_Dtl
                GROUP BY
                    ID_Rujukan
                ) dtl ON hdr.ID_Rujukan = dtl.ID_Rujukan
				LEFT JOIN SMKB_Kod_Status_Dok kdsts ON Status_Dok=kdsts.Kod_Status_Dok AND Kod_Modul='03'
                WHERE Status_Dok IN (" & statusList & ") "



                If DateStart IsNot Nothing And DateStart <> "" Then
                    sqlText += " AND hdr.Tarikh_Daftar >= @DateStart "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateStart", DateStart))
                End If

                If DateEnd IsNot Nothing And DateEnd <> "" Then
                    sqlText += " AND hdr.Tarikh_Daftar <= @DateEnd "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateEnd", DateEnd))
                End If

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

    'query full invois header
    Private Function fetchInvoisHdrFull(ID_Rujukan As String) As Response
        Dim res As New Response
        res.Code = 200
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn
                sqlcmd.CommandText = "SELECT * FROM SMKB_Pembayaran_Invois_Hdr WHERE ID_Rujukan=@ID_Rujukan"
                sqlcmd.Parameters.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))
                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using

        Catch ex As Exception
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function
    Private Function fetchInvoisDtlFull(ID_Rujukan As String) As Response
        Dim res As New Response
        res.Code = 200
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn
                sqlcmd.CommandText = "SELECT * FROM SMKB_Pembayaran_Invois_Dtl WHERE ID_Rujukan=@ID_Rujukan"
                sqlcmd.Parameters.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))
                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using

        Catch ex As Exception
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res

    End Function
    'query full invois dtl


    Private Function saveInvoisDtl(dtl As List(Of InvoisDtl), ByRef query As Query) As Response
        Dim res As New Response
        For Each item As InvoisDtl In dtl
            res = saveInvoisDtl(item, query)
            If res.Code <> "200" Then
                Return res
            End If
        Next
        Return res
    End Function

    Private Function saveInvoisDtl(dtl As InvoisDtl, ByRef query As Query) As Response
        Dim response As New Response
        response.Code = 200
        response.Message = "Berjaya Di Simpan"

        If dtl.ID_Rujukan IsNot Nothing And dtl.No_Item Is Nothing Then
            Return insertInvoisDetail(dtl, query)
        End If

        If dtl.No_Item Is Nothing Then
            response.Code = 400
            response.Message = "No_Item tidak sah"
        ElseIf dtl.ID_Rujukan Is Nothing Then
            response.Code = 400
            response.Message = "id rujukan tidak sah"
        Else
            Try
                Dim id As New Dictionary(Of String, String)
                id.Add("ID_Rujukan", dtl.ID_Rujukan)
                id.Add("No_Item", dtl.No_Item)
                query.execute(id, dtl.UpdateCommand())
            Catch ex As Exception
                response.Code = 500
                response.Message = ex.Message
            End Try
        End If
        Return response
    End Function

    'method that execute the update process
    Private Function doUpdateInvoisHdr(invois As InvoisHdr, ByRef query As Query) As Response
        Dim response As New Response
        response.Code = 200
        response.Message = "Berjaya Di Simpan"
        If invois.ID_Rujukan Is Nothing Then
            response.Code = 400
            response.Message = "id rujukan tidak sah"
        Else
            Try
                query.execute(invois.ID_Rujukan, "ID_Rujukan", invois.updateCommand())
            Catch ex As Exception
                response.Code = 500
                response.Message = ex.Message
            End Try
        End If
        Return response
    End Function

    Private Function deleteInvoisDtl(dtl As InvoisDtl) As Response
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlConn As New SqlConnection(dbSMKB.strCon)
                sqlConn.Open()
                Dim sqlCmd As SqlCommand
                sqlCmd = dtl.deleteCommand()
                sqlCmd.Connection = sqlConn
                sqlCmd.ExecuteNonQuery()

            End Using
        Catch ex As Exception
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function

    Private Function generateIDRujukan(Kod_PTJ As String) As String
        Return SharedModulePembayaran.generateRunningNumber("03", "INV", Kod_PTJ, "Invois")
    End Function

    Private Sub logInvoisDok(No_Rujukan As String, Status_Dok As String)
        SharedModulePembayaran.logDOK("03", No_Rujukan, Status_Dok, "-")
    End Sub

    Private Sub logInvoisDok(No_Rujukan As String, Status_Dok As String, Ulasan As String)
        SharedModulePembayaran.logDOK("03", No_Rujukan, Status_Dok, Ulasan)
    End Sub
End Class

<Serializable>
Public Class Request
    Public Property body As Object
End Class
<Serializable>
Public Class InvoisHdr

    Public Property ID_Rujukan As String
    Public Property No_Invois As String
    Public Property No_PTempatan As String
    Public Property Tarikh_Invois As String
    Public Property Tarikh_Terima_Invois As String
    Public Property No_DO As String
    Public Property Tarikh_DO As String
    Public Property Tarikh_Terima_DO As String
    Public Property Jenis_Bayar As String
    Public Property Kategori_Invois As String
    Public Property Jenis_Invois As String
    Public Property Padan As String
    Public Property Tujuan As String
    Public Property Tarikh_Daftar As String
    Public Property Status_Dok As String
    Public Property Status As String
    Public Property Dibuat_Oleh As String
    Public Property Tarikh_Dibuat As String

    '22/8/2023
    Public Property Kod_Vot As String
    Public Property Jumlah_Bayar As Double?
    Public Property Jumlah_Sebenar As Double?

    Public Property details As List(Of InvoisDtl)
    Public Function InsertCommand() As SqlCommand
        If ID_Rujukan Is Nothing Then
            Throw New Exception("ID rujukan tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String
        sql = "INSERT INTO SMKB_Pembayaran_Invois_Hdr (ID_Rujukan,Tarikh_Daftar,Tarikh_Dibuat,Status"
        values = "(@ID_Rujukan,getdate(),getdate(),'1'"
        cmd.Parameters.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))


        If No_Invois IsNot Nothing Then
            sql += ", No_Invois"
            values += ", @No_Invois"
            cmd.Parameters.Add(New SqlParameter("@No_Invois", No_Invois))
        End If

        If No_PTempatan IsNot Nothing Then
            sql += ", No_PTempatan"
            values += ", @No_PTempatan"
            cmd.Parameters.Add(New SqlParameter("@No_PTempatan", No_PTempatan))
        End If
        If Status_Dok IsNot Nothing Then
            sql += ", Status_Dok"
            values += ", @Status_Dok"
            cmd.Parameters.Add(New SqlParameter("@Status_Dok", Status_Dok))
        End If
        If Tarikh_Invois IsNot Nothing Then
            sql += ", Tarikh_Invois"
            values += ", @Tarikh_Invois"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_Invois", Tarikh_Invois))
        End If

        If Tarikh_Terima_Invois IsNot Nothing Then
            sql += ", Tarikh_Terima_Invois"
            values += ", @Tarikh_Terima_Invois"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_Terima_Invois", Tarikh_Terima_Invois))
        End If

        If No_DO IsNot Nothing Then
            sql += ", No_DO"
            values += ", @No_DO"
            cmd.Parameters.Add(New SqlParameter("@No_DO", No_DO))
        End If

        If Tarikh_DO IsNot Nothing Then
            sql += ", Tarikh_DO"
            values += ", @Tarikh_DO"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_DO", Tarikh_DO))
        End If

        If Tarikh_Terima_DO IsNot Nothing Then
            sql += ", Tarikh_Terima_DO"
            values += ", @Tarikh_Terima_DO"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_Terima_DO", Tarikh_Terima_DO))
        End If

        If Jenis_Bayar IsNot Nothing Then
            sql += ", Jenis_Bayar"
            values += ", @Jenis_Bayar"
            cmd.Parameters.Add(New SqlParameter("@Jenis_Bayar", Jenis_Bayar))
        End If

        If Kategori_Invois IsNot Nothing Then
            sql += ", Kategori_Invois"
            values += ", @Kategori_Invois"
            cmd.Parameters.Add(New SqlParameter("@Kategori_Invois", Kategori_Invois))
        End If

        If Jenis_Invois IsNot Nothing Then
            sql += ", Jenis_Invois"
            values += ", @Jenis_Invois"
            cmd.Parameters.Add(New SqlParameter("@Jenis_Invois", Jenis_Invois))
        End If

        If Padan IsNot Nothing Then
            sql += ", Padan"
            values += ", @Padan"
            cmd.Parameters.Add(New SqlParameter("@Padan", Padan))
        End If

        If Tujuan IsNot Nothing Then
            sql += ", Tujuan"
            values += ", @Tujuan"
            cmd.Parameters.Add(New SqlParameter("@Tujuan", Tujuan))
        End If



        If Dibuat_Oleh IsNot Nothing Then
            sql += ", Dibuat_Oleh"
            values += ", @Dibuat_Oleh"
            cmd.Parameters.Add(New SqlParameter("@Dibuat_Oleh", Dibuat_Oleh))
        End If

        If Jumlah_Bayar.HasValue Then
            sql += ", Jumlah_Bayar"
            values += ", @Jumlah_Bayar"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Bayar", Jumlah_Bayar))
        End If
        If Jumlah_Sebenar.HasValue Then
            sql += ", Jumlah_Sebenar"
            values += ", @Jumlah_Sebenar"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Sebenar", Jumlah_Sebenar))

        End If


        ' Construct the final SQL command
        cmd.CommandText = sql + ") VALUES " + values + ")"

        Return cmd
    End Function

    Public Function updateCommand() As SqlCommand
        If ID_Rujukan Is Nothing Then
            Throw New Exception("Id rujukan tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "UPDATE SMKB_Pembayaran_Invois_Hdr SET "

        If Not String.IsNullOrEmpty(No_Invois) Then
            values += "No_Invois = @No_Invois,"
            cmd.Parameters.Add(New SqlParameter("@No_Invois", No_Invois))
        End If

        If Not String.IsNullOrEmpty(No_PTempatan) Then
            values += "No_PTempatan = @No_PTempatan,"
            cmd.Parameters.Add(New SqlParameter("@No_PTempatan", No_PTempatan))
        End If

        If Not String.IsNullOrEmpty(Tarikh_Invois) Then
            values += "Tarikh_Invois = @Tarikh_Invois,"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_Invois", Tarikh_Invois))
        End If

        If Not String.IsNullOrEmpty(Tarikh_Terima_Invois) Then
            values += "Tarikh_Terima_Invois = @Tarikh_Terima_Invois,"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_Terima_Invois", Tarikh_Terima_Invois))
        End If

        If Not String.IsNullOrEmpty(No_DO) Then
            values += "No_DO = @No_DO,"
            cmd.Parameters.Add(New SqlParameter("@No_DO", No_DO))
        End If

        If Not String.IsNullOrEmpty(Tarikh_DO) Then
            values += "Tarikh_DO = @Tarikh_DO,"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_DO", Tarikh_DO))
        End If

        If Not String.IsNullOrEmpty(Tarikh_Terima_DO) Then
            values += "Tarikh_Terima_DO = @Tarikh_Terima_DO,"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_Terima_DO", Tarikh_Terima_DO))
        End If

        If Not String.IsNullOrEmpty(Kod_Vot) Then
            values += "Kod_Vot = @Kod_Vot,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Vot", Kod_Vot))
        End If

        If Not String.IsNullOrEmpty(Jenis_Bayar) Then
            values += "Jenis_Bayar = @Jenis_Bayar,"
            cmd.Parameters.Add(New SqlParameter("@Jenis_Bayar", Jenis_Bayar))
        End If

        If Not String.IsNullOrEmpty(Kategori_Invois) Then
            values += "Kategori_Invois = @Kategori_Invois,"
            cmd.Parameters.Add(New SqlParameter("@Kategori_Invois", Kategori_Invois))
        End If

        If Not String.IsNullOrEmpty(Jenis_Invois) Then
            values += "Jenis_Invois = @Jenis_Invois,"
            cmd.Parameters.Add(New SqlParameter("@Jenis_Invois", Jenis_Invois))
        End If

        If Not String.IsNullOrEmpty(Padan) Then
            values += "Padan = @Padan,"
            cmd.Parameters.Add(New SqlParameter("@Paddan", Padan))
        End If

        If Not String.IsNullOrEmpty(Tujuan) Then
            values += "Tujuan = @Tujuan,"
            cmd.Parameters.Add(New SqlParameter("@Tujuan", Tujuan))
        End If

        If Not String.IsNullOrEmpty(Tarikh_Daftar) Then
            values += "Tarikh_Daftar = @Tarikh_Daftar,"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_Daftar", Tarikh_Daftar))
        End If

        If Not String.IsNullOrEmpty(Status_Dok) Then
            values += "Status_Dok = @Status_Dok,"
            cmd.Parameters.Add(New SqlParameter("@Status_Dok", Status_Dok))
        End If

        If Not String.IsNullOrEmpty(Status) Then
            values += "Status = @Status,"
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If

        If Not String.IsNullOrEmpty(Dibuat_Oleh) Then
            values += "Dibuat_Oleh = @Dibuat_Oleh,"
            cmd.Parameters.Add(New SqlParameter("@Dibuat_Oleh", Dibuat_Oleh))
        End If

        If Not String.IsNullOrEmpty(Tarikh_Dibuat) Then
            values += "Tarikh_Dibuat = @Tarikh_Dibuat,"
            cmd.Parameters.Add(New SqlParameter("@Tarikh_Dibuat", Tarikh_Dibuat))
        End If

        If Jumlah_Bayar.HasValue Then
            values += "Jumlah_Bayar = @Jumlah_Bayar,"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Bayar", Jumlah_Bayar))

        End If
        If Jumlah_Sebenar.HasValue Then
            values += "Jumlah_Sebenar = @Jumlah_Sebenar,"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Sebenar", Jumlah_Sebenar))

        End If

        If Not String.IsNullOrEmpty(values) Then
            values = values.Substring(0, values.Length - 1) 'remove extra ,

        End If
        cmd.CommandText = sql + values + " WHERE ID_Rujukan = @ID_Rujukan"
        cmd.Parameters.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))

        Return cmd
    End Function


End Class

<Serializable>
Public Class InvoisDtl
    Inherits LedgerItem
    Public Property ID_Rujukan As String
    Public Property No_Item As String
    Public Property Butiran As String
    Public Property Kadar_Harga As Double?
    Public Property Status As String
    Public Property Kuantiti_Sebenar As Double?
    Public Property Diskaun As Double?
    Public Property Cukai As Double?

    'used for penerimaan
    Public Property debit As Boolean?
    Public Property credit As Boolean?
    Public Property Jumlah_Perlu_Bayar As Double?

    Public Property Amaun_Sebenar As Double?

    Public Property Amaun_Dicukai As Double?


    Public Overrides Function getSum() As Double
        Return Jumlah_Perlu_Bayar
    End Function
    Public Function UpdateCommand() As SqlCommand
        If String.IsNullOrEmpty(ID_Rujukan) Then
            Throw New Exception("ID rujukan tidak sah")
        End If

        If String.IsNullOrEmpty(No_Item) Then
            Throw New Exception("No Item tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "UPDATE SMKB_Pembayaran_Invois_Dtl SET "

        If Not String.IsNullOrEmpty(Kod_Pemiutang) Then
            values += "Kod_Pemiutang = @Kod_Pemiutang,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Pemiutang", Kod_Pemiutang))
        End If

        If Not String.IsNullOrEmpty(Kod_Kump_Wang) Then
            values += "Kod_Kump_Wang = @Kod_Kump_Wang,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Kump_Wang", Kod_Kump_Wang))
        End If

        If Not String.IsNullOrEmpty(Kod_Operasi) Then
            values += "Kod_Operasi = @Kod_Operasi,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Operasi", Kod_Operasi))
        End If

        If Not String.IsNullOrEmpty(Kod_PTJ) Then
            values += "Kod_PTJ = @Kod_PTJ,"
            cmd.Parameters.Add(New SqlParameter("@Kod_PTJ", Kod_PTJ))
        End If

        If Not String.IsNullOrEmpty(Kod_Projek) Then
            values += "Kod_Projek = @Kod_Projek,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Projek", Kod_Projek))
        End If

        If Not String.IsNullOrEmpty(Kod_Vot) Then
            values += "Kod_Vot = @Kod_Vot,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Vot", Kod_Vot))
        End If

        If Not String.IsNullOrEmpty(Butiran) Then
            values += "Butiran = @Butiran,"
            cmd.Parameters.Add(New SqlParameter("@Butiran", Butiran))
        End If

        If Kadar_Harga.HasValue Then
            values += "Kadar_Harga = @Kadar_Harga,"
            cmd.Parameters.Add(New SqlParameter("@Kadar_Harga", Kadar_Harga))
        End If

        If Not String.IsNullOrEmpty(Status) Then
            values += "Status = @Status,"
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If

        If Kuantiti_Sebenar.HasValue Then
            values += "Kuantiti_Sebenar = @Kuantiti_Sebenar,"
            cmd.Parameters.Add(New SqlParameter("@Kuantiti_Sebenar", Kuantiti_Sebenar))
        End If

        If Diskaun.HasValue Then
            values += "Diskaun = @Diskaun,"
            cmd.Parameters.Add(New SqlParameter("@Diskaun", Diskaun))
        End If

        If Cukai.HasValue Then
            values += "Cukai = @Cukai,"
            cmd.Parameters.Add(New SqlParameter("@Cukai", Cukai))
        End If

        If Amaun_Sebenar.HasValue Then
            values += "Amaun_Sebenar = @Amaun_Sebenar,"
            cmd.Parameters.Add(New SqlParameter("@Amaun_Sebenar", Amaun_Sebenar))
        End If


        If Amaun_Dicukai.HasValue Then
            values += "Amaun_Dicukai = @Amaun_Dicukai,"
            cmd.Parameters.Add(New SqlParameter("@Amaun_Dicukai", Amaun_Dicukai))
        End If

        If Not String.IsNullOrEmpty(values) Then
            values = values.Substring(0, values.Length - 1) 'remove extra ,
        End If

        cmd.CommandText = sql + values + " WHERE ID_Rujukan = @ID_Rujukan AND No_Item = @No_Item"
        cmd.Parameters.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))
        cmd.Parameters.Add(New SqlParameter("@No_Item", No_Item))

        Return cmd
    End Function

    Public Function InsertCommand() As SqlCommand
        If String.IsNullOrEmpty(ID_Rujukan) Then
            Throw New Exception("ID rujukan tidak sah")
        End If

        If String.IsNullOrEmpty(No_Item) Then
            Throw New Exception("No Item tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim columns As New List(Of String)
        Dim values As New List(Of String)
        sql = "INSERT INTO SMKB_Pembayaran_Invois_Dtl ("

        'wajib
        columns.Add("ID_Rujukan")
        values.Add("@ID_Rujukan")
        cmd.Parameters.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))

        columns.Add("No_Item")
        values.Add("@No_Item")
        cmd.Parameters.Add(New SqlParameter("@No_Item", No_Item))

        If Not String.IsNullOrEmpty(Kod_Pemiutang) Then
            columns.Add("Kod_Pemiutang")
            values.Add("@Kod_Pemiutang")
            cmd.Parameters.Add(New SqlParameter("@Kod_Pemiutang", Kod_Pemiutang))
        End If

        If Not String.IsNullOrEmpty(Kod_Kump_Wang) Then
            columns.Add("Kod_Kump_Wang")
            values.Add("@Kod_Kump_Wang")
            cmd.Parameters.Add(New SqlParameter("@Kod_Kump_Wang", Kod_Kump_Wang))
        End If

        If Not String.IsNullOrEmpty(Kod_Operasi) Then
            columns.Add("Kod_Operasi")
            values.Add("@Kod_Operasi")
            cmd.Parameters.Add(New SqlParameter("@Kod_Operasi", Kod_Operasi))
        End If

        If Not String.IsNullOrEmpty(Kod_PTJ) Then
            columns.Add("Kod_PTJ")
            values.Add("@Kod_PTJ")
            cmd.Parameters.Add(New SqlParameter("@Kod_PTJ", Kod_PTJ))
        End If

        If Not String.IsNullOrEmpty(Kod_Projek) Then
            columns.Add("Kod_Projek")
            values.Add("@Kod_Projek")
            cmd.Parameters.Add(New SqlParameter("@Kod_Projek", Kod_Projek))
        End If

        If Not String.IsNullOrEmpty(Kod_Vot) Then
            columns.Add("Kod_Vot")
            values.Add("@Kod_Vot")
            cmd.Parameters.Add(New SqlParameter("@Kod_Vot", Kod_Vot))
        End If

        If Not String.IsNullOrEmpty(Butiran) Then
            columns.Add("Butiran")
            values.Add("@Butiran")
            cmd.Parameters.Add(New SqlParameter("@Butiran", Butiran))
        End If

        If Kadar_Harga.HasValue Then
            columns.Add("Kadar_Harga")
            values.Add("@Kadar_Harga")
            cmd.Parameters.Add(New SqlParameter("@Kadar_Harga", Kadar_Harga))
        End If

        If Not String.IsNullOrEmpty(Status) Then
            columns.Add("Status")
            values.Add("@Status")
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If

        If Kuantiti_Sebenar.HasValue Then
            columns.Add("Kuantiti_Sebenar")
            values.Add("@Kuantiti_Sebenar")
            cmd.Parameters.Add(New SqlParameter("@Kuantiti_Sebenar", Kuantiti_Sebenar))
        End If

        If Diskaun.HasValue Then
            columns.Add("Diskaun")
            values.Add("@Diskaun")
            cmd.Parameters.Add(New SqlParameter("@Diskaun", Diskaun))
        End If

        If Cukai.HasValue Then
            columns.Add("Cukai")
            values.Add("@Cukai")
            cmd.Parameters.Add(New SqlParameter("@Cukai", Cukai))
        End If

        If Amaun_Sebenar.HasValue Then
            columns.Add("Amaun_Sebenar")
            values.Add("@Amaun_Sebenar")
            cmd.Parameters.Add(New SqlParameter("@Amaun_Sebenar", Amaun_Sebenar))
        End If

        If Amaun_Dicukai.HasValue Then
            columns.Add("Amaun_Dicukai")
            values.Add("@Amaun_Dicukai")
            cmd.Parameters.Add(New SqlParameter("@Amaun_Dicukai", Amaun_Dicukai))
        End If
        ' Combine columns and values lists into SQL format
        sql += String.Join(",", columns) + ") VALUES (" + String.Join(",", values) + ")"
        cmd.CommandText = sql

        Return cmd
    End Function

    Public Function deleteCommand() As SqlCommand
        If String.IsNullOrEmpty(ID_Rujukan) Or String.IsNullOrEmpty(No_Item) Then
            Throw New Exception("ID rujukan atau no item tidak sah")
        End If
        Dim cmd As New SqlCommand
        cmd.CommandText = "DELETE FROM SMKB_Pembayaran_Invois_Dtl WHERE ID_Rujukan=@ID_Rujukan AND No_Item=@No_Item"
        cmd.Parameters.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))
        cmd.Parameters.Add(New SqlParameter("@No_Item", No_Item))

        Return cmd
    End Function

    Public Shared Function getNo_Item(ID_Rujukan As String) As String
        Dim db As New DBKewConn
        Dim NoItem As Integer


        Dim sql As String = "SELECT MAX(No_Item) AS No_Item from SMKB_Pembayaran_Invois_Dtl where ID_Rujukan = @ID_Rujukan"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@ID_Rujukan", ID_Rujukan))

        Dim dt As DataTable
        dt = db.Read(sql, param)

        If dt.Rows.Count = 0 Then
            NoItem = 1
        Else
            Dim value As Object = dt.Rows(0)("No_Item") ' Retrieve value from the first row

            If DBNull.Value.Equals(value) Then
                NoItem = 1
            Else
                NoItem = Convert.ToInt32(dt.Rows(0).Item("No_Item")) + 1

            End If
        End If
        Return CStr(NoItem)
    End Function


End Class
