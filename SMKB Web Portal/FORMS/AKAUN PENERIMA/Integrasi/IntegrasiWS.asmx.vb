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
Imports System.Threading
Imports Microsoft.Ajax.Utilities
Imports AjaxControlToolkit
Imports System.Data.Entity.Core.Mapping
Imports System

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class IntegrasiWS
    Inherits System.Web.Services.WebService

    Dim dt As DataTable

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiLulusPendahuluan(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiPendahuluan(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiPendahuluan(category_filter As String, tkhMula As String, tkhTamat As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)


        If category_filter = "1" Then 'Harini
            tarikhQuery = " WHERE CAST(A.Tarikh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE)"
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " WHERE CAST(A.Tarikh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE)"
        ElseIf category_filter = "3" Then '7 day
            tarikhQuery = " WHERE A.Tarikh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP"
        ElseIf category_filter = "4" Then '30 day
            tarikhQuery = " WHERE A.Tarikh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP"
        ElseIf category_filter = "5" Then '60 day
            tarikhQuery = " WHERE A.Tarikh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP"
        ElseIf category_filter = "6" Then ' custom
            tarikhQuery = " WHERE CAST(A.Tarikh_Mohon AS DATE) >= @tkhMula AND CAST(A.Tarikh_Mohon AS DATE) <= @tkhTamat"
        End If
        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))
        Dim query As String = "SELECT No_Pendahuluan as No_Akaun, B.Kod_Penghutang, B.Nama_Penghutang, No_Rujukan, 
        (B.Alamat_1 + ',' + B.Alamat_2 + ',' + B.Poskod + ',' + B.Bandar + ',' + C.Butiran + ',' + D.Butiran) AS ALAMAT 
        From ADV_Order_Hdr A 
        INNER JOIN SMKB_Penghutang_Master B On A.No_Staf = B.No_Rujukan 
        INNER JOIN SMKB_Lookup_Detail C ON C.Kod='0002' AND B.Kod_Negeri=C.Kod_Detail 
        INNER JOIN SMKB_Lookup_Detail D ON D.Kod='0001' AND B.Kod_Negara=D.Kod_Detail" & tarikhQuery

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_MaklumatBilTerperinci(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, custcode As String, status As String) As String
        Dim resp As New ResponseRepository

        dt = Get_MaklumatBilTerperinci(category_filter, tkhMula, tkhTamat, custcode, status)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_MaklumatBilTerperinci(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, custcode As String, status As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)
        Dim query As String = ""

        If status = "03" Then
            query = "SELECT A.No_Pendahuluan as No_Akaun, C.Nama_Penghutang, FORMAT(A.Tarikh_Mohon, 'dd/MM/yyyy') As Tarikh_Mohon, A.Tujuan, A.Jum_Lulus As Jumlah 
                     FROM ADV_Order_Hdr A 
                     INNER JOIN ADV_Order_Dtl B ON B.No_Pendahuluan= A.No_Pendahuluan
                     INNER JOIN SMKB_Penghutang_Master C on C.No_Rujukan = A.No_Staf
                     WHERE A.No_Pendahuluan = @kodpenghutang"

            'query = "SELECT A.No_Pendahuluan as No_Akaun,C.Nama_Penghutang,FORMAT(A.Tarikh_Mohon, dd/MM/yyyy) as Tarikh_Mohon,'PENDAHULUAN' AS JNS_URUSNIAGA,A.Tujuan,Jum_Lulus,A.Status_Dok 
            '         FROM ADV_Order_Hdr A
            '         JOIN ADV_Order_Dtl B ON A.No_Pendahuluan=B.No_Pendahuluan
            '         JOIN SMKB_Penghutang_Master C ON A.No_Staf=C.No_Rujukan
            '         WHERE A.Status='1' --AND Status_Dok='20'
            '         AND A.No_Pendahuluan = @kodpenghutang
            '         ORDER BY A.No_Pendahuluan"

            param.Add(New SqlParameter("@kodpenghutang", custcode))

        Else
            query = "Select A.No_Dok As No_Invois,
                        B.Nama_Penghutang,
                        C.Butiran As UrusNiaga,
                        A.Tujuan,
                        FORMAT(A.Tkh_Daftar, 'dd/MM/yyyy') AS Tarikh_Mohon,
                        A.Jumlah_Bayar as Jumlah,
                        D.No_Pendahuluan as No_Akaun
                    FROM SMKB_Terima_Hdr A
                    INNER JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang = B.Kod_Penghutang
                    INNER JOIN SMKB_Kod_Urusniaga C ON A.Kod_Urusniaga = C.Kod_Urusniaga
					INNER JOIN ADV_Order_Hdr D ON D.No_Staf = B.No_Rujukan 
                    WHERE A.Status = '1' AND D.No_Pendahuluan = @kodpenghutang"
            param.Add(New SqlParameter("@kodpenghutang", custcode))
        End If


        Return db.Read(query, param)

        Try
            Return db.Read(query, param)
        Catch ex As SqlException
            ' Handle the exception, and log the error message.
            Console.WriteLine("SQL Exception Message: " & ex.Message)
        End Try

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrInvoisPendahuluan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrInvoisPendahuluan(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrInvoisPendahuluan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT A.No_Pendahuluan,C.Kod_Penghutang,C.Nama_Penghutang,FORMAT(A.Tarikh_Mohon, 'dd/MM/yyyy') as Tarikh_Mohon,'PENDAHULUAN' AS JNS_URUSNIAGA,A.Tujuan,Jum_Lulus,A.Status_Dok, 
                               (SELECT Kod_Urusniaga FROM SMKB_Kod_Urusniaga WHERE Status='1' AND Butiran = 'PENDAHULUAN') as KodUrusniaga
                               FROM ADV_Order_Hdr A
                               JOIN ADV_Order_Dtl B ON A.No_Pendahuluan=B.No_Pendahuluan
                               JOIN SMKB_Penghutang_Master C ON A.No_Staf=C.No_Rujukan
                               WHERE A.Status='1' --AND Status_Dok='20'
                               AND A.No_Pendahuluan = @noPendahuluan
                               ORDER BY A.No_Pendahuluan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noPendahuluan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordInvoisPendahuluan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordInvoisPendahuluan(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetRecordInvoisPendahuluan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT B.No_Pendahuluan+'|'+B.No_Item as dataid,
		A.Kod_Vot, (select Kod_Vot+' - '+ Butiran from SMKB_Vot as vot where A.Kod_Vot = vot.Kod_Vot) as ButiranVot,
		A.Kod_PTJ as colhidptj, (SELECT b.Pejabat FROM VPejabat as b WHERE b.kodpejabat = left(Kod_PTJ,2)) as ButiranPTJ,
		A.Kod_Kump_Wang as colhidkw, (select Butiran from SMKB_Kump_Wang as kw where A.Kod_Kump_Wang = kw.Kod_Kump_Wang) as colKW,
		A.Kod_Operasi  as colhidko, (select Butiran from SMKB_Operasi as ko where A.Kod_Operasi = ko.Kod_Operasi) as colKO,
		A.Kod_Projek as colhidkp, (select Butiran from SMKB_Projek as kp where A.Kod_Projek = kp.Kod_Projek) as colKp,
		B.Butiran as Perkara, B.Kuantiti, B.Kadar_Harga, B.Jumlah_anggaran, A.Jum_Lulus
		From ADV_Order_Hdr A
		INNER JOIN ADV_Order_Dtl B ON B.No_Pendahuluan = A.No_Pendahuluan
		WHERE A.No_Pendahuluan = @noPendahuluan
		AND A.Status = 1
		ORDER BY B.No_Item"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noPendahuluan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrInvoisTerimaan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrInvoisTerimaan(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrInvoisTerimaan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT A.No_Bil, G.No_Pendahuluan, A.Kod_Penghutang, B.Nama_Penghutang, B.Emel, B.Kategori_Penghutang, D.Butiran as Butiran_Kategori, A.Kod_Urusniaga, C.Butiran as JNS_URUSNIAGA, A.Kontrak, A.Tujuan, Kod_Status_Dok,
                                CASE WHEN Tkh_Mula <> '' THEN FORMAT(Tkh_Mula, 'yyyy-MM-dd') END AS Tarikh_Mohon,
                                CASE WHEN Tkh_Tamat <> '' THEN FORMAT(Tkh_Tamat, 'yyyy-MM-dd') END AS TkhTamat,Tkh_Mula,Tkh_Tamat,Tkh_Bil,A.No_Rujukan,Tempoh_Kontrak,Jenis_Tempoh,F.Butiran AS JenisTempoh
                                FROM SMKB_Bil_Hdr A
                                LEFT JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang=B.Kod_Penghutang
                                LEFT JOIN SMKB_Kod_Urusniaga C ON A.Kod_Urusniaga=C.Kod_Urusniaga
                                LEFT JOIN SMKB_Lookup_Detail D ON B.Kategori_Penghutang = D.Kod_Detail
                                LEFT JOIN SMKB_Lookup_Detail F ON A.Jenis_Tempoh=F.Kod_Detail AND F.Kod='AR09'
								INNER JOIN ADV_Order_Hdr G ON G.No_Pendahuluan = A.No_Rujukan
                                WHERE A.No_Rujukan = @noPendahuluan AND A.Status='1' AND D.Kod='0152'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noPendahuluan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordInvoisTerimaan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordInvoisTerimaan(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetRecordInvoisTerimaan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim jumlahBayar As Decimal = GetJumlaBayarByNoPendahuluanFromTerimaHdr(id)
        Dim query As String = "SELECT 
                A.No_Bil + '|' + B.No_Item AS dataid, C.No_Dok,
                B.Kod_Kump_Wang AS colhidkw,
                (SELECT Butiran FROM SMKB_Kump_Wang AS kw WHERE B.Kod_Kump_Wang = kw.Kod_Kump_Wang) AS colKW,
                B.Kod_Operasi AS colhidko,
                (SELECT Butiran FROM SMKB_Operasi AS ko WHERE B.Kod_Operasi = ko.Kod_Operasi) AS colKO,
                B.Kod_Projek AS colhidkp,
                (SELECT Butiran FROM SMKB_Projek AS kp WHERE B.Kod_Projek = kp.Kod_Projek) AS colKp,
                B.Kod_PTJ AS colhidptj,
                (SELECT F.Pejabat FROM VPejabat AS F
                    WHERE F.kodpejabat = LEFT(B.Kod_PTJ, 2)) AS ButiranPTJ,
                B.Kod_Vot,
                (SELECT Kod_Vot + ' - ' + Butiran FROM SMKB_Vot AS vot WHERE B.Kod_Vot = vot.Kod_Vot) AS ButiranVot,
                Perkara,
                Kuantiti,
                Kadar_Harga,
                B.Jumlah AS Jumlah_anggaran,
                D.Kredit AS Jumlah_Bayar,
				E.Jum_Lulus,
                Diskaun,
                Cukai
                FROM SMKB_Bil_Hdr A
                INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil
                INNER JOIN SMKB_Terima_Hdr C ON B.No_Bil=C.No_Rujukan
                INNER JOIN SMKB_Terima_Dtl D ON C.No_Dok=D.No_Dok AND B.No_Item=D.No_Item
				INNER JOIN ADV_Order_Hdr E ON E.No_Pendahuluan = A.No_Rujukan
                WHERE E.No_Pendahuluan= @noPendahuluan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@noPendahuluan", id))

        Return db.Read(query, param)
    End Function

    Public Function GetJumlaBayarByNoPendahuluanFromTerimaHdr(No_Pendahuluan As String) As Decimal
        Dim db = New DBKewConn

        Dim selectQuery As String = "Select Jumlah_Bayar as Jumlah 
								from SMKB_Terima_Hdr A
								Inner Join SMKB_Bil_Hdr B ON A.No_Rujukan = B.No_Bil
								INNER JOIN ADV_Order_Hdr C ON B.No_Rujukan = C.No_Pendahuluan
								WHERE C.No_Pendahuluan = @No_Pendahuluan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Pendahuluan", No_Pendahuluan))

        Dim result As DataTable = db.Read(selectQuery, param)

        Dim jumlah As New Decimal

        If Not IsDBNull(result.Rows(0)("Jumlah")) Then
            jumlah = result.Rows(0)("Jumlah")
        Else
            jumlah = 0.00
        End If

        Return jumlah
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePaymentPendahuluan(order As Order_TerimaPendahuluan) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        If order Is Nothing Then
            resp.Failed("Tidak Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.OrderID = "" Then
            order.OrderID = GenerateOrderID()
            order.OrderIDResit = GenerateOrderIDResit()
            If UpdateOrderNo(order.OrderID, order.OrderIDResit, order.NoBil) <> "OK" Then
                resp.Failed("Gagal Disimpan")
                Exit Function
            End If
            If InsertNewOrderbil(order.OrderID, order.PenghutangID, order.TkhMula, "0", order.JenisUrusniaga, order.Tujuan, order.Jumlah, "", "", order.NoBil, "03") <> "OK" Then
                resp.Failed("Gagal Disimpan")
                Exit Function
            End If
            If InsertNewOrderResit(order.OrderID, order.OrderIDResit, order.PenghutangID, order.TkhMula, "0", order.JenisUrusniaga, order.Tujuan, order.Jumlah, "", "", order.NoBil, order.ModTerima, order.KodBank, "06") <> "OK" Then
                resp.Failed("Gagal Disimpan")
                Exit Function
            End If
        End If

        For Each orderDetail As OrderDetail_inv In order.OrderDetails
            If orderDetail.ddlPTJ = "" Then
                Continue For
            End If

            If orderDetail.Cukai Is Nothing Then
                orderDetail.Cukai = 0.00
            End If

            If orderDetail.Diskaun Is Nothing Then
                orderDetail.Diskaun = 0.00
            End If

            JumRekod += 1

            orderDetail.amount = orderDetail.quantity * orderDetail.price 'This can be automated inside orderdetail model

            If orderDetail.id = "" Then
                orderDetail.id = GenerateOrderDetailID(order.OrderID)
                orderDetail.OrderID = order.OrderID
                If InsertOrderDetailBil(orderDetail) = "OK" Then
                    success += 1
                End If
                If InsertOrderDetailResit(orderDetail, order) = "OK" Then
                    success += 1
                End If
            End If
        Next

        If success = 0 Then
            resp.Failed("Rekod order detail gagal disimpan")
        End If

        If Not success = JumRekod Then
            resp.Success("Rekod order detail berjaya disimpan dengan beberapa rekod tidak disimpan", "00", order)
        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateOrderNo(OrderID As String, orderIDResit As String, NoBil As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE ADV_Order_Hdr SET Order_no = @orderID, No_Resit = @OrderIdResit WHERE No_pendahuluan = @noBil"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@orderID", OrderID))
        param.Add(New SqlParameter("@orderIdResit", orderIDResit))
        param.Add(New SqlParameter("@noBil", NoBil))

        Return db.Process(query, param)
    End Function

    Private Function InsertNewOrderbil(orderid As String, penghutangid As String, TkhMula As String, Kontrak As String, JenisUrusniaga As String, Tujuan As String, Jumlah As String, tempoh As String, tempohbyrn As String, norujukan As String, statusdok As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Bil_Hdr (No_Bil, Tahun, Tkh_Mohon, Jenis, No_Staf, Kod_Status_Dok, Status, Kod_Penghutang,Tkh_Mula,Tkh_Tamat,Kontrak,Kod_Urusniaga,Tujuan, Jumlah,No_Staf_Penyedia,Tkh_Bil, Tempoh_Kontrak, Jenis_Tempoh,No_Rujukan, Tkh_Lulus, No_Staf_Lulus, Flag_Lulus)
        VALUES (@No_Bil, YEAR(getdate()), CONVERT(smalldatetime, @tkhMohon, 103), @Jenis, @NoStaf, @statusdok ,'1', @Kod_Penghutang, CONVERT(smalldatetime, @Tkh_Mula, 103), getdate(),@Kontrak,@Kod_Urusniaga,@Tujuan,@Jumlah,@NoStafPenyedia,getdate(),@tempoh,@tempohbyrn, @norujukan, getdate(), @NoStaf, @flagLulus)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Bil", orderid))
        param.Add(New SqlParameter("@Jenis", "1"))
        param.Add(New SqlParameter("@statusdok", statusdok))
        param.Add(New SqlParameter("@Kod_Penghutang", penghutangid))
        param.Add(New SqlParameter("@tkhMohon", TkhMula))
        param.Add(New SqlParameter("@Tkh_Mula", TkhMula))
        param.Add(New SqlParameter("@Tkh_Tamat", "getdate()"))
        param.Add(New SqlParameter("@Kontrak", Kontrak))
        param.Add(New SqlParameter("@Kod_Urusniaga", JenisUrusniaga))
        param.Add(New SqlParameter("@Tujuan", Tujuan))
        param.Add(New SqlParameter("@Jumlah", Jumlah))
        param.Add(New SqlParameter("@NoStafPenyedia", Session("ssusrID")))
        param.Add(New SqlParameter("@NoStaf", Session("ssusrID")))
        param.Add(New SqlParameter("@tempoh", tempoh))
        param.Add(New SqlParameter("@tempohbyrn", tempohbyrn))
        param.Add(New SqlParameter("@norujukan", norujukan))
        param.Add(New SqlParameter("@flagLulus", "1"))


        Return db.Process(query, param)
    End Function

    Private Function InsertNewOrderResit(orderid As String, orderidresit As String, penghutangid As String, TkhMula As String, Kontrak As String, JenisUrusniaga As String, Tujuan As String, Jumlah As String, tempoh As String, tempohbyrn As String, norujukan As String, modterima As String, bankutem As String, statusdok As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Terima_Hdr
                              (No_Dok, Kod_Penghutang, No_Rujukan,Tujuan,Kod_Urusniaga,Mod_Terima,Tkh_Daftar,Staf_Terima,Jumlah_Sebenar,Jumlah_Bayar,
                               Staf_Closing, Flag_Closing, Flag_Lulus, Staf_Lulus, Tkh_Closing, Tkh_Lulus, Tkh_Dok, Kod_Bank,Kod_Terima,Kod_Status_Dok,Flag_Kaunter)
                               VALUES 
                              (@noresit,@Kod_Penghutang,@No_Bil,@Tujuan,@Kod_Urusniaga,@modterima,CONVERT(smalldatetime, @TkhMula, 103),@No_Staf,@Jumlah,@jumlahterima,
							   @No_Staf,@FlagClosing, @FlagLulus, @No_Staf,getdate(),getdate(), getdate(),@kodbank,'TK',@status,@flag)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@noresit", orderidresit))
        param.Add(New SqlParameter("@Kod_Penghutang", penghutangid))
        param.Add(New SqlParameter("@No_Bil", orderid))
        param.Add(New SqlParameter("@Tujuan", Tujuan))
        param.Add(New SqlParameter("@Kod_Urusniaga", JenisUrusniaga))
        param.Add(New SqlParameter("@modterima", modterima))
        param.Add(New SqlParameter("@TkhMula", TkhMula))
        param.Add(New SqlParameter("@tarikh", "getdate()"))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Jumlah", Jumlah))
        param.Add(New SqlParameter("@jumlahterima", Jumlah))
        param.Add(New SqlParameter("FlagClosing", "true"))
        param.Add(New SqlParameter("FlagLulus", "true"))
        param.Add(New SqlParameter("@kodbank", bankutem))
        param.Add(New SqlParameter("@status", statusdok))
        param.Add(New SqlParameter("@flag", "1"))

        Return db.Process(query, param)
    End Function

    Public Function InsertOrderDetailBil(orderDetail As OrderDetail_inv)
        Dim db = New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Bil_Dtl(No_Bil,No_Item,Kod_Kump_Wang,Kod_Operasi,Kod_PTJ,Kod_Projek,Kod_Vot,Perkara,Kuantiti,Kadar_Harga,Jumlah,Tahun,Status,Diskaun,Cukai, Status_Bayaran)
        VALUES                                        ( @no_bil , @no_item, @Kod_Kump_Wang, @Kod_Operasi , @Kod_PTJ , @Kod_Projek  , @Kod_Vot, @Perkara, @Kuantiti, @Kadar_Harga, @Jumlah, '2023', '1', @Diskaun, @Cukai, @statBayaran)    "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@no_bil", orderDetail.OrderID))
        param.Add(New SqlParameter("@no_item", orderDetail.id))
        param.Add(New SqlParameter("@Kod_Kump_Wang", orderDetail.ddlKw))
        param.Add(New SqlParameter("@Kod_Operasi", orderDetail.ddlKo))
        param.Add(New SqlParameter("@Kod_PTJ", orderDetail.ddlPTJ))
        param.Add(New SqlParameter("@Kod_Projek", orderDetail.ddlKp))
        param.Add(New SqlParameter("@Kod_Vot", orderDetail.ddlVot))
        param.Add(New SqlParameter("@Perkara", orderDetail.details))
        param.Add(New SqlParameter("@Kuantiti", orderDetail.quantity))
        param.Add(New SqlParameter("@Kadar_Harga", orderDetail.price))
        param.Add(New SqlParameter("@Jumlah", orderDetail.amount))
        param.Add(New SqlParameter("@Diskaun", orderDetail.Diskaun))
        param.Add(New SqlParameter("@Cukai", orderDetail.Cukai))
        param.Add(New SqlParameter("@StatBayaran", "BP"))

        Return db.Process(query, param)
    End Function

    Public Function InsertOrderDetailResit(orderDetail As OrderDetail_inv, order As Order_TerimaPendahuluan)
        Dim db = New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Terima_Dtl
                                VALUES( @noresit , @no_item, @Kod_Kump_Wang, @Kod_Operasi , @Kod_PTJ , @Kod_Projek  , @Kod_Vot, @Perkara,'','0.00', @Jumlah, @Cukai,@Diskaun,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@noresit", order.OrderIDResit))
        param.Add(New SqlParameter("@no_item", orderDetail.id))
        param.Add(New SqlParameter("@Kod_Kump_Wang", orderDetail.ddlKw))
        param.Add(New SqlParameter("@Kod_Operasi", orderDetail.ddlKo))
        param.Add(New SqlParameter("@Kod_PTJ", orderDetail.ddlPTJ))
        param.Add(New SqlParameter("@Kod_Projek", orderDetail.ddlKp))
        param.Add(New SqlParameter("@Kod_Vot", orderDetail.ddlVot))
        param.Add(New SqlParameter("@Perkara", orderDetail.details))
        param.Add(New SqlParameter("@Jumlah", orderDetail.amount))
        param.Add(New SqlParameter("@Cukai", orderDetail.Cukai))
        param.Add(New SqlParameter("@Diskaun", orderDetail.Diskaun))


        Return db.Process(query, param)
    End Function

    Public Function GenerateOrderDetailID(orderid As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "SELECT TOP 1 No_Item as id 
                                FROM SMKB_Bil_Dtl 
                                WHERE No_Bil= @orderid
                                ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@orderid", orderid))

        dt = db.Read(query, param)
        If dt IsNot Nothing Then
            If dt.Rows.Count > 0 Then
                'lastID = 1
                'Else
                lastID = CInt(dt.Rows(0).Item("id")) + 1
            End If
        End If

        'newOrderID = orderid + "SUBORD" + Right("0" + CStr(lastID), 2)
        newOrderID = lastID
        Return newOrderID
    End Function

    Private Function GenerateOrderID() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='12' AND Prefix ='AR' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("12", "AR", year, lastID)
        Else

            InsertNoAkhir("12", "AR", year, lastID)
        End If
        newOrderID = "AR" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newOrderID
    End Function

    Private Function GenerateOrderIDResit() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='12' AND Prefix ='RT' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("12", "RT", year, lastID)
        Else

            InsertNoAkhir("12", "RT", year, lastID)
        End If
        newOrderID = "RT" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

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
        param.Add(New SqlParameter("@Butiran", "Jurnal"))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))


        Return db.Process(query, param)
    End Function
End Class