Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Globalization
'Imports System.Globalization
Imports System.Threading
Imports System.Threading.Tasks

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.

<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PelarasanWS
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_Record_Senarai_Bil(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Record_Senarai_Bil(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_Record_Senarai_Bil(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(Tkh_Lulus AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(Tkh_Lulus AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND Tkh_Lulus >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND Tkh_Lulus < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tkh_Lulus >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND Tkh_Lulus < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tkh_Lulus >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND Tkh_Lulus < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tkh_Lulus >= @tkhMula AND Tkh_Lulus <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "SELECT A.No_Bil as No_Bil,B.Nama_Penghutang,C.Butiran as UrusNiaga,A.Tujuan,
                                CASE WHEN Tkh_Mula <> '' THEN FORMAT(Tkh_Mula, 'dd/MM/yyyy') END AS Tkh_Mula,
                                CASE WHEN Tkh_Tamat <> '' THEN FORMAT(Tkh_Tamat, 'dd/MM/yyyy') END AS Tkh_Tamat,
                                CASE WHEN Tkh_Mohon <> '' THEN FORMAT(Tkh_Mohon, 'dd/MM/yyyy') END AS Tkh_Mohon,
                                CASE WHEN Tkh_Lulus <> '' THEN FORMAT(Tkh_Lulus, 'dd/MM/yyyy') END AS Tkh_Lulus,
                                A.Jumlah,D.Butiran AS STATUS_BIL,
                                CASE 
                                WHEN A.No_Staf_Penyedia  <> '' THEN E.MS01_Nama 
                                END
                                AS Penyedia,A.No_Staf_Penyedia, (SELECT COUNT(No_Item) FROM SMKB_Bil_Dtl WHERE SMKB_Bil_Dtl.No_Bil = A.No_Bil ) AS NO_ITEM
                                FROM SMKB_Bil_Hdr A
                                inner JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang=B.Kod_Penghutang
                                inner JOIN SMKB_Kod_Urusniaga C ON A.Kod_Urusniaga=C.Kod_Urusniaga
                                INNER JOIN SMKB_Kod_Status_Dok D ON A.Kod_Status_Dok=D.Kod_Status_Dok AND Kod_Modul='12'
                                Left join VPeribadi as E on E.MS01_NoStaf = A.No_Staf_Penyedia 
                                WHERE  A.Status='1' AND A.Kod_Status_Dok='03' " & tarikhQuery & "
                                ORDER BY Tkh_Mohon , No_Bil"

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrInvois(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrInvois(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrInvois(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT A.No_Bil,A.Kod_Penghutang,B.Nama_Penghutang,A.No_Rujukan,A.Kod_Urusniaga,C.Butiran, A.Kontrak,A.Tujuan, 
                                CASE WHEN A.Tempoh_Kontrak IS NULL THEN '-' ELSE A.Tempoh_Kontrak END AS Tempoh_Kontrak, D.Butiran as Kategori, E.Butiran as Jenis_Tempoh,
                                CASE WHEN Tkh_Mula <> '' THEN FORMAT(Tkh_Mula, 'dd/MM/yyyy') END AS Tkh_Mula,
                                CASE WHEN Tkh_Tamat <> '' THEN FORMAT(Tkh_Tamat, 'dd/MM/yyyy') END AS Tkh_Tamat,Jumlah
                                FROM SMKB_Bil_Hdr A
                                INNER JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang=B.Kod_Penghutang
                                INNER JOIN SMKB_Kod_Urusniaga C ON A.Kod_Urusniaga=C.Kod_Urusniaga
								INNER JOIN SMKB_Lookup_Detail D ON D.Kod = '0152' AND B.Kategori_Penghutang = D.Kod_Detail
								INNER JOIN SMKB_Lookup_Detail E ON E.Kod ='AR09' AND A.Jenis_Tempoh = E.Kod_Detail
                                WHERE No_Bil = @No_Invois AND A.Status='1'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Invois", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordInvois(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetTransaksiInvois(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetTransaksiInvois(kod As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select a.No_Bil+'|'+a.No_Item as dataid,Kod_Kump_Wang as colhidkw ,(select Butiran from SMKB_Kump_Wang as kw where a.Kod_Kump_Wang = kw.Kod_Kump_Wang) as colKW,
        Kod_Operasi  as colhidko, (select Butiran from SMKB_Operasi as ko where a.Kod_Operasi = ko.Kod_Operasi) as colKO,
        Kod_Projek as colhidkp,  (select Butiran from SMKB_Projek as kp where a.Kod_Projek = kp.Kod_Projek) as colKp,
        Kod_PTJ as colhidptj , (SELECT b.Pejabat FROM VPejabat as b
        WHERE b.kodpejabat = left(Kod_PTJ,2)) as ButiranPTJ ,
        Kod_Vot , (select Kod_Vot+' - '+ Butiran from SMKB_Vot as vot where a.Kod_Vot = vot.Kod_Vot) as ButiranVot,
        Perkara ,Kuantiti, Kadar_Harga, Jumlah, Diskaun, Cukai
        from SMKB_Bil_Dtl as a
        where No_Bil = @No_Invois
        and status = 1
        order by No_Item"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Invois", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCarianVotList(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetCarianKodVotList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetCarianKodVotList(kodCariVot As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT TOP 10 CONCAT(a.Kod_Vot, ' - ', vot.Butiran, ', ', a.Kod_Operasi, ' - ', ko.Butiran, ', ', a.Kod_Projek, ', ', a.Kod_Kump_Wang, ' - ', REPLACE(kw.Butiran, 'KUMPULAN WANG', 'KW'), ', ', a.Kod_PTJ) AS text,
                            a.Kod_Kump_Wang + a.Kod_Operasi + a.Kod_PTJ + a.Kod_Projek + a.Kod_Vot AS value 
                            FROM SMKB_COA_Master AS a
                            JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                            JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                            JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                            WHERE a.status = 1 "

        Dim param As New List(Of SqlParameter)
        If kodCariVot <> "" Then
            query &= "AND (a.Kod_Vot LIKE '%' + @kod + '%' OR a.Kod_Operasi LIKE '%' + @kod2 + '%' OR a.Kod_Projek LIKE '%' + @kod3 + '%' OR a.Kod_Kump_Wang LIKE '%' + @kod4 + '%' OR a.Kod_PTJ LIKE '%' + @kod5 + '%' OR vot.Butiran LIKE '%' + @kodButir + '%' OR ko.Butiran LIKE '%' + @kodButir1 + '%'  OR kw.Butiran LIKE '%' + @kodButir2 + '%')"

            param.Add(New SqlParameter("@kod", kodCariVot))
            param.Add(New SqlParameter("@kod", kodCariVot))
            param.Add(New SqlParameter("@kod2", kodCariVot))
            param.Add(New SqlParameter("@kod3", kodCariVot))
            param.Add(New SqlParameter("@kod4", kodCariVot))
            param.Add(New SqlParameter("@kod5", kodCariVot))
            param.Add(New SqlParameter("@kodButir", kodCariVot))
            param.Add(New SqlParameter("@kodButir1", kodCariVot))
            param.Add(New SqlParameter("@kodButir2", kodCariVot))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiLulusInvois(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiInvois(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiInvois(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(A.Tkh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(A.Tkh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND A.Tkh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND A.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND A.Tkh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND A.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND A.Tkh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND A.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND A.Tkh_Mohon >= @tkhMula AND A.Tkh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "SELECT 
                                    A.No_Bil AS No_Invois,
                                    B.Nama_Penghutang,
                                    C.Butiran AS UrusNiaga,
                                    A.Tujuan,
                                    FORMAT(A.Tkh_Mohon, 'dd/MM/yyyy') AS TKHMOHON,
                                    CASE WHEN A.Tkh_Mula <> '' THEN FORMAT(A.Tkh_Mula, 'dd/MM/yyyy') END AS Tkh_Mula,
                                    CASE WHEN A.Tkh_Tamat <> '' THEN FORMAT(A.Tkh_Tamat, 'dd/MM/yyyy') END AS Tkh_Tamat,
                                    A.Jumlah
                                FROM 
                                    SMKB_Bil_Hdr A
                                INNER JOIN 
                                    SMKB_Penghutang_Master B ON A.Kod_Penghutang = B.Kod_Penghutang
                                INNER JOIN 
                                    SMKB_Kod_Urusniaga C ON A.Kod_Urusniaga = C.Kod_Urusniaga
                                LEFT JOIN 
                                    SMKB_Bil_Adj_Hdr D ON A.No_Bil = D.No_Bil AND D.Kod_Status_Dok = '01'
                                WHERE  
                                    A.Status = '1' 
                                    AND A.Kod_Status_Dok = '03' 
                                    AND D.No_Bil IS NULL
                                " & tarikhQuery

        Return db.Read(query)
    End Function

    Private Function generateNoPelarasan(Jenis As String) As String
        Return SharedModuleAR.GenerateID("12", Jenis, "Pelarasan" + Jenis)
    End Function

    Private Sub logInvoisDok(No_Rujukan As String, Status_Dok As String, Ulasan As String)
        SharedModulePembayaran.logDOK("12", No_Rujukan, Status_Dok, Ulasan)
    End Sub
    Private Async Function creditIntoAccPenghutang(userId As String, Bil As Bil_Adj, BilDtl As Bil_Adj_Dtl, tarikh As String, vot As String) As Tasks.Task(Of Response)
        Return Await SharedModuleAR.sendDataIntoLejar_Bil_Adj(userId, "AR", Bil, BilDtl, True, tarikh, "71901")
    End Function
    Private Async Function debitIntoAccPenghutang(userId As String, Bil As Bil_Adj, BilDtl As Bil_Adj_Dtl, tarikh As String, vot As String) As Tasks.Task(Of Response)
        Return Await SharedModuleAR.sendDataIntoLejar_Bil_Adj(userId, "AR", Bil, BilDtl, False, tarikh, "71901")
    End Function
    Private Async Function creditIntoGeneralLedger(userId As String, Bil As Bil_Adj, BilDtl As Bil_Adj_Dtl, tarikh As String) As Tasks.Task(Of Response)
        Return Await SharedModuleAR.sendDataIntoLejar_Bil_Adj(userId, "GL", Bil, BilDtl, True, tarikh)
    End Function
    Private Async Function debitIntoGeneralLedger(userId As String, Bil As Bil_Adj, BilDtl As Bil_Adj_Dtl, tarikh As String) As Tasks.Task(Of Response)
        Return Await SharedModuleAR.sendDataIntoLejar_Bil_Adj(userId, "GL", Bil, BilDtl, False, tarikh)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecord_SenaraiLulusPelarasan(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiPelarasan(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiPelarasan(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(A.Tkh_Pelarasan AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(A.Tkh_Pelarasan AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND A.Tkh_Pelarasan >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND A.Tkh_Pelarasan < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND A.Tkh_Pelarasan >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND A.Tkh_Pelarasan < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND A.Tkh_Pelarasan >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND A.Tkh_Pelarasan < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND A.Tkh_Pelarasan >= @tkhMula AND A.Tkh_Pelarasan <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "SELECT A.No_Pelarasan ,A.No_Bil as No_Invois,C.Nama_Penghutang,D.Butiran as UrusNiaga,A.Tujuan,FORMAT(A.Tkh_Pelarasan, 'dd/MM/yyyy') AS TKHMOHON,
                                CASE WHEN Tkh_Mula <> '' THEN FORMAT(Tkh_Mula, 'dd/MM/yyyy') END AS Tkh_Mula,
                                CASE WHEN Tkh_Tamat <> '' THEN FORMAT(Tkh_Tamat, 'dd/MM/yyyy') END AS Tkh_Tamat,Jumlah_Besar FROM
                                SMKB_Bil_Adj_Hdr AS A, SMKB_Bil_Hdr AS B, SMKB_Penghutang_Master AS C, SMKB_Kod_Urusniaga AS D
                                WHERE A.No_Bil=B.No_Bil AND B.Kod_Penghutang=C.Kod_Penghutang AND B.Kod_Urusniaga=D.Kod_Urusniaga AND A.Status='1' AND A.Kod_Status_Dok='01' " & tarikhQuery

        Return db.Read(query)
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

    'query full pelarasan invois header
    Private Function fetchInvoisHdrFull(ID_Rujukan As String) As Response
        Dim res As New Response
        res.Code = 200
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn
                sqlcmd.CommandText = "SELECT A.No_Pelarasan,A.Tkh_Pelarasan,B.*,C.*,D.*,E.Butiran AS JNSTEMPOH 
                                        FROM SMKB_Bil_Adj_Hdr A, SMKB_Bil_Hdr B, SMKB_Penghutang_Master C,SMKB_Kod_Urusniaga D,SMKB_Lookup_Detail E
                                        WHERE A.No_Bil=B.No_Bil AND B.Kod_Penghutang=C.Kod_Penghutang AND B.Kod_Urusniaga=D.Kod_Urusniaga AND B.Jenis_Tempoh=E.Kod_Detail AND E.Kod='AR09'
                                        AND A.No_Pelarasan=@ID_Rujukan"
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
                sqlcmd.CommandText = "SELECT * FROM SMKB_Bil_Adj_Dtl WHERE No_Pelarasan=@ID_Rujukan ORDER BY No_Item "
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
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function SaveLulus(order As Bil_Adj) As Tasks.Task(Of String)
        Dim res As New Response
        Dim query As New Query
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If order Is Nothing Then
            res.Code = 400
            res.Message = "Data tidak wujud"
            Return JsonConvert.SerializeObject(res)
        End If
        order.Kod_Status_Dok = "02"
        res = UpdateLulusOrder(order, query)
        If Not res.Code.Equals("200") Then
            res.Message = "Maklumat bil gagal di simpan"
            query.rollback()
            Return JsonConvert.SerializeObject(res)
        End If

        logInvoisDok(order.No_Pelarasan, order.Kod_Status_Dok, "ulasan")
        Dim userId As String = Session("ssusrID")

        For Each orderDetail As Bil_Adj_Dtl In order.details
            Try
                If order.No_Pelarasan IsNot Nothing And Not order.No_Pelarasan.Equals("") Then
                    If orderDetail.Petunjuk = "-" Then
                        res = Await debitIntoGeneralLedger(userId, order, orderDetail, order.Tkh_Pelarasan)
                        If res.Code.Equals("200") Then
                            res = Await creditIntoAccPenghutang(userId, order, orderDetail, order.Tkh_Pelarasan, orderDetail.Kod_Vot)
                            If Not res.Code.Equals("200") Then
                                Throw New Exception("Gagal memasukkan data kedalam lejar")
                            End If
                        Else
                            Throw New Exception("Gagal memasukkan data kedalam lejar")
                        End If
                    ElseIf orderDetail.Petunjuk = "+" Then
                        res = Await creditIntoGeneralLedger(userId, order, orderDetail, order.Tkh_Pelarasan)
                        If res.Code.Equals("200") Then
                            res = Await debitIntoAccPenghutang(userId, order, orderDetail, order.Tkh_Pelarasan, orderDetail.Kod_Vot)
                            If Not res.Code.Equals("200") Then
                                Throw New Exception("Gagal memasukkan data kedalam lejar")
                            End If
                        Else
                            Throw New Exception("Gagal memasukkan data kedalam lejar")
                        End If
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
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveMohon(order As Bil_Adj) As String
        Dim res As New Response
        Dim query As New Query
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If order Is Nothing Then
            res.Code = 400
            res.Message = "Data tidak wujud"
            Return JsonConvert.SerializeObject(res)
        End If
        order.Kod_Status_Dok = "01"
        res = InsertOrderOrder(order, query)
        If Not res.Code.Equals("200") Then
            res.Message = "Maklumat bil gagal di simpan"
            query.rollback()
            Return JsonConvert.SerializeObject(res)
        End If

        logInvoisDok(order.No_Pelarasan, order.Kod_Status_Dok, "ulasan")
        Dim userId As String = Session("ssusrID")

        For Each orderDetail As Bil_Adj_Dtl In order.details
            Try
                If order.No_Pelarasan IsNot Nothing And Not order.No_Pelarasan.Equals("") Then
                    orderDetail.No_Pelarasan = order.No_Pelarasan
                    If Not query.execute(orderDetail.No_Pelarasan, "No_Pelarasan", orderDetail.InsertCommand()) > 0 Then
                        Throw New Exception("Gagal memasukkan data Bil Details")
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

    Private Function UpdateLulusOrder(orderid As Bil_Adj, ByRef query As Query) As Response
        Dim response As New Response
        Dim db As New DBKewConn
        response.Code = 200
        response.Message = "Berjaya Di Simpan"

        If orderid.No_Pelarasan Is Nothing Then
            response.Code = 400
            response.Message = "No Bil tidak sah"
        Else
            Try
                query.execute(orderid.No_Pelarasan, "No_Pelarasan", orderid.updateCommand())
            Catch ex As Exception
                response.Code = 500
                response.Message = ex.Message
            End Try
        End If
        Return response
    End Function

    Private Function InsertOrderOrder(orderid As Bil_Adj, ByRef query As Query) As Response
        Dim response As New Response
        Dim db As New DBKewConn
        response.Code = 200
        response.Message = "Berjaya Di Simpan"

        orderid.No_Pelarasan = GenerateID("12", orderid.Petunjuk, "Pelarasan Nota Debit Nota Kredit")
        If orderid.No_Pelarasan Is Nothing Then
            response.Code = 400
            response.Message = "No Bil tidak sah"
        Else
            Try
                query.execute(orderid.No_Pelarasan, "No_Pelarasan", orderid.InsertCommand())
            Catch ex As Exception
                response.Code = 500
                response.Message = ex.Message
            End Try
        End If
        Return response
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RejectLulus(order As Bil_Adj) As String
        Dim res As New Response
        Dim query As New Query
        If order Is Nothing Then
            res.Code = 400
            res.Message = "Data tidak wujud"
            Return JsonConvert.SerializeObject(res)
        End If
        order.Kod_Status_Dok = "03"
        'order.Tkh_Lulus = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")
        'order.No_Staf_Lulus = Session("ssusrID")
        res = UpdateLulusOrder(order, query)
        If Not res.Code.Equals("200") Then
            res.Message = "Maklumat bil gagal di simpan"
            query.rollback()
            Return JsonConvert.SerializeObject(res)
        End If

        logInvoisDok(order.No_Bil, "03", "Kelulusan Bil")

        query.finish()
        res.Message = "Maklumat berjaya disimpan"
        Return JsonConvert.SerializeObject(res)
    End Function
End Class