Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols

Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Awal_Tahun_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim queryRB As New Query()

    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVotList(ByVal q As String, ByVal kodVot As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodVotList(q, kodVot)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVotPTJ(ByVal q As String) As String
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


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVotCOA(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodCOAList(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKWList(ByVal q As String, ByVal kodkw As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodKWList(q, kodkw)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKoList(ByVal q As String, ByVal kodko As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodKoList(q, kodko)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKpList(ByVal q As String, ByVal kodko As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodKPList(q, kodko)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListBahagian(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiBahagian(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiBahagian(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim existingRecord As Boolean = False

        Dim queryCheck As String = "SELECT 1 FROM SMKB_PTJ_PBU WHERE Kod_Ptj = @kodPtj"
        Dim paramCheck As New List(Of SqlParameter)
        paramCheck.Add(New SqlParameter("@kodPtj", Session("ssusrKodPTj")))

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck, paramCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If

        Dim queryMain As String
        If existingRecord Then
            queryMain = "select  distinct(KodPBU)  as value , NamaPBU as text from V_DSPejabat where KodPejabat = @ptj"

            If kod <> "" Then
                queryMain &= " and (KodPBU LIKE '%' + @kod + '%' or NamaPBU LIKE '%' + @kod + '%') order by KodPBU"
            End If

        Else
            queryMain = "select distinct(KodBahagian) AS value, NamaBahagian AS text from V_DSPejabat where Left(KodPejabat,2) = @ptj"

            If kod <> "" Then
                queryMain &= " and (KodBahagian LIKE '%' + @kod + '%' or NamaBahagian LIKE '%' + @kod + '%') order by KodBahagian"
            End If

        End If

        Dim paramMain As New List(Of SqlParameter)
        paramMain.Add(New SqlParameter("@status", "1"))
        paramMain.Add(New SqlParameter("@ptj", Left(Session("ssusrKodPTj"), 2)))
        paramMain.Add(New SqlParameter("@kod", kod))
        'paramMain.Add(New SqlParameter("@kod2", kod))

        Return db.Read(queryMain, paramMain)
    End Function


    'Private Function GetSenaraiBahagian(kod As String) As DataTable
    '    Dim db As New DBSMCocnn


    '    Dim query As String = "select distinct(KodBahagian) AS value, NamaBahagian AS text from V_DSPejabat where KodPejabat = @ptj "
    '    Dim param As New List(Of SqlParameter)

    '    If kod <> "" Then
    '        query &= " and (KodBahagian LIKE '%' + @kod + '%' or NamaBahagian LIKE '%' + @kod2 + '%') "
    '    End If

    '    param.Add(New SqlParameter("@status", "1"))
    '    param.Add(New SqlParameter("@ptj", Left(Session("ssusrKodPTj"), 2)))
    '    param.Add(New SqlParameter("@kod", kod))
    '    param.Add(New SqlParameter("@kod2", kod))


    '    Return db.Read(query, param)
    'End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListUnit(data As String, q As String) As String

        Dim tmpDT As DataTable = GetSenaraiUnit(data, q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiUnit(category As String, kod As String) As DataTable
        Dim db As New DBKewConn
        Dim existingRecord As Boolean = False

        Dim queryCheck As String = "SELECT 1 FROM SMKB_PTJ_PBU WHERE Kod_Ptj = @kodPtj"
        Dim paramCheck As New List(Of SqlParameter)
        paramCheck.Add(New SqlParameter("@kodPtj", Session("ssusrKodPTj")))

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck, paramCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If

        Dim queryMain As String
        If existingRecord Then
            queryMain = "select  distinct(KodBahagian)  as value , NamaBahagian as text from V_DSPejabat where KodPBU = @category"

            If kod <> "" Then
                queryMain &= " and (KodBahagian LIKE '%' + @kod + '%' or NamaBahagian LIKE '%' + @kod + '%') order by KodBahagian"
            End If

        Else
            queryMain = "select distinct(KodUnit) AS value, NamaUnit AS text from V_DSPejabat where KodBahagian = @category"

            If kod <> "" Then
                queryMain &= " and (KodUnit LIKE '%' + @kod + '%' or NamaUnit LIKE '%' + @kod + '%') order by KodUnit"
            End If

        End If



        Dim paramMain As New List(Of SqlParameter)
        paramMain.Add(New SqlParameter("@status", "1"))
        paramMain.Add(New SqlParameter("@category", category))
        paramMain.Add(New SqlParameter("@kod", kod))
        'paramMain.Add(New SqlParameter("@kod2", kod))

        Return db.Read(queryMain, paramMain)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListKW(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiKW(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiKW(kod As String) As DataTable
        Dim db As New DBKewConn
        'Dim query As String = "SELECT distinct a.Kod_Kump_Wang , b.Butiran as text FROM SMKB_COA_Master as a , SMKB_Kump_Wang as b
        '                        where a.Kod_Kump_Wang = b.Kod_Kump_Wang and  Kod_PTJ = @ptj and a.Status = @status AND a.Kod_Kump_Wang IN ('01','07')"
        Dim query As String = "select Kod_Kump_Wang as value, Butiran as text from SMKB_Kump_Wang where Status = 1 and Kod_Kump_Wang in ('01','07')"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (Kod_Kump_Wang LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') order by a.Kod_Kump_Wang"
        End If

        'param.Add(New SqlParameter("@status", "1"))
        'param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListPenyokong(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiPenyokong(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiPenyokong(kod As String) As DataTable
        Dim db As New DBSMConn
        Dim query As String = "select  a.MS01_NoStaf as value, c.MS01_Nama as text from 
                            MS02_Perjawatan as a ,
                            MS08_Penempatan as b,
                            MS01_Peribadi as c
                            where  a.MS01_NoStaf = b.MS01_NoStaf 
                            and a.MS01_NoStaf = c.MS01_NoStaf
                            and RIGHT(MS02_GredGajiS,2) >= '41'  AND A.MS01_NoStaf ='01861'                        
                            --and b.MS08_Pejabat = @ptj
                            and c.MS01_Status = @status and b.MS08_StaTerkini = @status"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (a.MS01_NoStaf LIKE '%' + @kod + '%' c.MS01_Nama LIKE '%' + @kod2 + '%') Order by  c.MS01_Nama"
        Else
            query &= " Order by  c.MS01_Nama"
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@ptj", Left(Session("ssusrKodPTj"), 2)))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListKO(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiKO(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiKO(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "select Kod_Operasi as value, Butiran as text from SMKB_Operasi where Status = @status"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (Kod_Operasi LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') order by Kod_Operasi"
        End If

        param.Add(New SqlParameter("@status", 1))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListKP(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiKP(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiKP(kod As String) As DataTable
        Dim db As New DBKewConn
        'Dim query As String = "SELECT distinct a.Kod_Projek as value, b.Butiran as text FROM SMKB_COA_Master as a , SMKB_Projek as b
        '                        where a.Kod_Projek = b.Kod_Projek  and  Kod_PTJ = @ptj and a.Status = @status "

        Dim query As String = "SELECT Kod_Projek  as value, Butiran as text FROM SMKB_Projek WHERE Status = 1"

        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (Kod_Projek LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') order by Kod_Projek"
        End If

        param.Add(New SqlParameter("@status", "1"))
        'param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListDasar(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiDasar(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiDasar(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Dasar as value, Butiran as text FROM SMKB_Dasar Where Status = @status  "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (Kod_Dasar LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisStatus(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetJenStatus(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteOrder(ByVal id As String) As String
        Dim resp As New ResponseRepository

        DeleteOrderDetails("", id)


        If DeleteOrderRecord(id) <> "OK" Then
            resp.Failed("Gagal")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("order_Bajet telah dihapuskan")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteRecord(ByVal id As String) As String
        Dim resp As New ResponseRepository
        If DeleteOrderDetails(id) = "OK" Then
            resp.Success("Berjaya")
        Else
            resp.Failed("Gagal")
        End If


        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord(ByVal id As String) As String
        Dim resp As New ResponseRepository

        If id = "" Then
            resp.Failed("ID diperlukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Dim record As order_Bajet = listOfOrder.Where(Function(x) x.OrderID = id).FirstOrDefault

        'If IsNothing(record) Then
        '    resp.Failed("Rekod tidak dijumpai")
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        'End If

        dt = GetOrder(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveOrders_Bajet(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Rekod berjaya disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0


        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.OrderID = "" Then 'untuk permohonan baru
            order.OrderID = GenerateOrderID()
            If InsertNewOrder(order.OrderID, order.Tarikh, order.PTJ, order.Bahagian, order.Unit, order.PTJPusatBajet, order.Dasar, order.KumpWang, order.KodKO, order.KodKP, order.Program, order.Justifikasi, order.Jumlah) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
            End If

        Else 'untuk permohonan sedia ada

            'start delete dlu detail sedia ada...
            DeleteOrderDtl(order.OrderID)
            'end delete

            If UpdateNewOrder(order.OrderID, order.Tarikh, order.PTJ, order.Bahagian, order.Unit, order.PTJPusatBajet, order.Dasar, order.KumpWang, order.KodKO, order.KodKP, order.Program, order.Justifikasi, order.Jumlah) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function

            End If
        End If


        For Each orderDetail_Bajet As orderDetail_Bajet In order.OrderDetails

            If orderDetail_Bajet.ddlObjAm = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail_Bajet.kredit = 0 'orderDetail_Bajet.quantity * orderDetail_Bajet.debit 'This can be automated insie orderDetail_Bajet model

            If orderDetail_Bajet.id = "" Then
                orderDetail_Bajet.id = GenerateOrderDetailID(order.OrderID)
                orderDetail_Bajet.OrderID = order.OrderID
                orderDetail_Bajet.Tarikh = order.Tarikh
                If InsertOrderDetail(orderDetail_Bajet) = "OK" Then
                    success += 1
                End If
            Else
                If InsertOrderDetail(orderDetail_Bajet) = "OK" Then
                    success += 1
                End If
            End If
        Next

        If InsertStatusDokOrder(order.OrderID, "Y", "01") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If

        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Not success = JumRekod Then
            resp.Success("Rekod order_Bajet detail berjaya disimpan dengan beberapa rekod tidak disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    '<System.Web.Services.WebMethod(EnableSession:=True)>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function SubmitOrders(order_Bajet As order_Bajet) As String
    '    Dim resp As New ResponseRepository
    '    resp.Success("Data telah di hantar.")
    '    Dim success As Integer = 0
    '    Dim JumRekod As Integer = 0
    '    If order_Bajet Is Nothing Then
    '        resp.Failed("Tiada simpan")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    End If


    '    If order_Bajet.OrderID = "" Then
    '        order_Bajet.OrderID = GenerateOrderID()
    '        If InsertNewOrder(order_Bajet.OrderID, order_Bajet.NoRujukan, order_Bajet.Perihal, order_Bajet.Tarikh, order_Bajet.JenisTransaksi, order_Bajet.JumlahDebit) <> "OK" Then
    '            resp.Failed("Gagal menghantar maklumat")
    '            Return JsonConvert.SerializeObject(resp.GetResult())
    '            ' Exit Function
    '        End If
    '    Else
    '        'start delete dlu detail sedia ada...
    '        DeleteOrderHdr(order_Bajet.OrderID, order_Bajet.NoRujukan, order_Bajet.Perihal, order_Bajet.Tarikh, order_Bajet.JenisTransaksi, order_Bajet.JumlahDebit)
    '        DeleteOrderDtl(order_Bajet.OrderID)
    '        'end delete

    '        If UpdateNewOrder(order_Bajet.OrderID, order_Bajet.NoRujukan, order_Bajet.Perihal, order_Bajet.Tarikh, order_Bajet.JenisTransaksi, order_Bajet.JumlahDebit) <> "OK" Then
    '            If InsertNewOrder(order_Bajet.OrderID, order_Bajet.NoRujukan, order_Bajet.Perihal, order_Bajet.Tarikh, order_Bajet.JenisTransaksi, order_Bajet.JumlahDebit) <> "OK" Then
    '                resp.Failed("Gagal Menyimpan Maklumat.")
    '                Return JsonConvert.SerializeObject(resp.GetResult())
    '                ' Exit Function
    '            End If
    '        End If

    '    End If

    '    For Each orderDetail_Bajet As orderDetail_Bajet In order_Bajet.OrderDetails

    '        If orderDetail_Bajet.ddlPTJ = "" Then
    '            Continue For
    '        End If

    '        JumRekod += 1

    '        'orderDetail_Bajet.kredit = 0 'orderDetail_Bajet.quantity * orderDetail_Bajet.debit 'This can be automated insie orderDetail_Bajet model

    '        If orderDetail_Bajet.id = "" Then
    '            orderDetail_Bajet.id = GenerateOrderDetailID(order_Bajet.OrderID)
    '            orderDetail_Bajet.OrderID = order_Bajet.OrderID
    '            If InsertOrderDetail(orderDetail_Bajet) = "OK" Then
    '                success += 1
    '            End If
    '        Else
    '            If UpdateOrderDetail(orderDetail_Bajet) = "OK" Then
    '                success += 1
    '            End If
    '        End If
    '    Next

    '    If UpdateStatusDokOrder_Submit(order_Bajet.OrderID, "Y") <> "OK" Then

    '        'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '        ' Exit Function

    '    End If


    '    If success = 0 Then
    '        resp.Failed("Rekod order_Bajet detail gagal dihantar")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    End If

    '    If Not success = JumRekod Then
    '        resp.Success("Rekod order_Bajet detail berjaya disimpan dengan beberapa rekod tidak disimpan", "00", order_Bajet)
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    Else
    '        'start call function submit
    '        UpdateStatusSubmit(order_Bajet.OrderID)
    '        'end call function submit

    '        resp.Success("Rekod berjaya dihantar", "00", order_Bajet)



    '        ''start emel
    '        'Dim message As String = String.Empty
    '        'Dim strNamaPenyokong As String
    '        'Dim strEmel As String

    '        'strNamaPenyokong = "Syafiqah"
    '        'strEmel = "syafiqah@utem.edu.my"



    '        'Dim Subject = "Pengesahan Transaksi Jurnal"
    '        'Dim body As String = "Assalamualaikum Wrh. Wbt. dan salam sejahtera,"
    '        'body += "<br /><br />Prof. / Prof. Madya/ Dr./ Tuan / Puan"
    '        'body += "<br /><br />Mohon log masuk sistem SMKB untuk mengesahkan transaksi jurnal."
    '        'body += "<br /><br />Terima kasih"
    '        'Dim sent = clsSharedMails.sendEmail(strEmel, Subject, body)
    '        ''close emel

    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    End If

    '    Return JsonConvert.SerializeObject(resp.GetResult())
    'End Function

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




    'Private Function UpdateOrderDetail(orderDetail_Bajet As orderDetail_Bajet)
    '    Dim db = New db
    '    Dim query As String = "UPDATE ORDERDETAILS
    '    set ddlVot = @ddlVot, details = @details, quantity = @quantity, 
    '    price = @price, amount = @amount
    '    where id = @id"
    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@ddlVot", orderDetail_Bajet.ddlVot))
    '    param.Add(New SqlParameter("@price", orderDetail_Bajet.debit))
    '    param.Add(New SqlParameter("@amount", orderDetail_Bajet.kredit))
    '    param.Add(New SqlParameter("@id", orderDetail_Bajet.id))

    '    Return db.Process(query, param)
    'End Function

    Private Function UpdateStatusSubmit(kod As String)
        Dim db As New DBKewConn

        Dim statusdok As String = "02" 'hantar
        Dim query As String = "Update SMKB_Jurnal_Hdr set Kod_Status_Dok =  @statusdok where No_Jurnal = @No_Jurnal and Status = 1"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Jurnal", kod))
        param.Add(New SqlParameter("@statusdok", statusdok))


        Return db.Process(query, param)
    End Function

    Private Function GenerateOrderDetailID(orderid As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 No_Item as id
        from SMKB_Agihan_Bajet_Dtl 
        where No_Mohon = @orderid
        order BY No_Item DESC"

        param.Add(New SqlParameter("@orderid", orderid))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function


    'Private Function InsertNewOrder(orderid As String, Tarikh As String, PTJ As String, Bahagian As String, Unit As String, PTJ_Pusat As String, Dasar As String, Kump_Wang As String, KodKo As String, KodKP As String, Program As String, Justifikasi As String, Jumlah As Decimal)
    '    Dim db As New DBKewConn

    '    Dim currentDateTime As DateTime = DateTime.Now.AddSeconds(-DateTime.Now.Second).AddMilliseconds(-DateTime.Now.Millisecond)
    '    Dim currentdatetime_ As String = currentDateTime.Year.ToString() + "." + currentDateTime.Month.ToString() + "." + currentDateTime.Day.ToString() +
    '           " " + currentDateTime.Hour.ToString() + ":" + currentDateTime.Minute.ToString() + ":" + "00"


    '    Dim query As String = "INSERT INTO SMKB_Agihan_Bajet_Hdr (Kod_Korporat , No_Mohon , Kod_Kump_Wang , Kod_Operasi , Kod_Projek , Kod_PTJ , Kod_Bahagian, Kod_Unit, PTJ_Pusat, Program, Justifikasi, Tahun_Bajet , Kod_Dasar, Jumlah_Mohon , Jumlah_KB , Jumlah_Kew , Jumlah_KetuaPTj ,Jumlah_Bendahari , Jumlah_NC, Jumlah_LPU, Tkh_Mohon , Created_Date , Created_By  ,Kod_Agih, Status_Dok)
    '    VALUES(@Kod_Korporat ,@No_Mohon, @KW, @KO, @KP, @Kod_PTj , @Kod_Bahagian, @Kod_Unit, @Kod_Pusat, @Program , @Justifikasi, @TahunBajet, @KodDasar, @JumlahMohon, @JumlahMohon, @JumlahMohon, @JumlahMohon, @JumlahMohon, @JumlahMohon, @JumlahMohon, @TkhMohon, @CreatedDate, @CreatedBy, @KodAgih , @Status_Dok)"
    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@Kod_Korporat", "UTeM"))
    '    param.Add(New SqlParameter("@No_Mohon", orderid))
    '    param.Add(New SqlParameter("@KW", Kump_Wang))
    '    param.Add(New SqlParameter("@KO", KodKo))
    '    param.Add(New SqlParameter("@KP", KodKP))
    '    param.Add(New SqlParameter("@Kod_PTj", PTJ))
    '    param.Add(New SqlParameter("@Kod_Bahagian", Bahagian))
    '    param.Add(New SqlParameter("@Kod_Unit", Unit))
    '    param.Add(New SqlParameter("@Kod_Pusat", PTJ_Pusat))
    '    param.Add(New SqlParameter("@Program", Program))
    '    param.Add(New SqlParameter("@Justifikasi", Justifikasi))
    '    param.Add(New SqlParameter("@TahunBajet", "2025"))
    '    param.Add(New SqlParameter("@KodDasar", Dasar))
    '    param.Add(New SqlParameter("@JumlahMohon", Replace(Jumlah, ",", "")))
    '    param.Add(New SqlParameter("@TkhMohon", currentdatetime_))
    '    param.Add(New SqlParameter("@CreatedDate", currentdatetime_))
    '    param.Add(New SqlParameter("@CreatedBy", Session("ssusrID")))
    '    param.Add(New SqlParameter("@KodAgih", "AL"))
    '    param.Add(New SqlParameter("@Status_Dok", "01"))

    '    Return db.Process(query, param)
    'End Function


    Private Function InsertNewOrder(orderid As String, Tarikh As String, PTJ As String, Bahagian As String, Unit As String, PTJ_Pusat As String, Dasar As String, Kump_Wang As String, KodKo As String, KodKP As String, Program As String, Justifikasi As String, Jumlah As Decimal)
        Dim db As New DBKewConn

        Dim queryCheck As String = $"SELECT 1 FROM SMKB_Agihan_Bajet_Hdr WHERE No_Mohon = '{orderid}'"
        Dim existingRecord As Boolean = False

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If

        Dim query As String = ""
        Dim currentDateTime As DateTime = DateTime.Now.AddSeconds(-DateTime.Now.Second).AddMilliseconds(-DateTime.Now.Millisecond)
        Dim currentdatetime_ As String = currentDateTime.Year.ToString() + "." + currentDateTime.Month.ToString() + "." + currentDateTime.Day.ToString() +
               " " + currentDateTime.Hour.ToString() + ":" + currentDateTime.Minute.ToString() + ":" + "00"

        Dim param As New List(Of SqlParameter)

        If existingRecord Then
            ' Update the existing record
            query = "UPDATE SMKB_Agihan_Bajet_Hdr
                        SET 
                        Kod_Korporat = @Kod_Korporat,
                        Kod_Kump_Wang = @KW,
                        Kod_Operasi = @KO,
                        Kod_Projek = @KP,
                        Kod_PTJ = @Kod_PTj,
                        Kod_Bahagian = @Kod_Bahagian,
                        Kod_Unit = @Kod_Unit,
                        PTJ_Pusat = @Kod_Pusat,
                        Program = @Program,
                        Justifikasi = @Justifikasi,
                        Tahun_Bajet = @TahunBajet,
                        Kod_Dasar = @KodDasar,
                        Jumlah_Mohon = @JumlahMohon,
                        Jumlah_KB = @JumlahMohon,
                        Jumlah_Kew = @JumlahMohon,
                        Jumlah_KetuaPTj = @JumlahMohon,
                        Jumlah_Bendahari = @JumlahMohon,
                        Jumlah_NC = @JumlahMohon,
                        Jumlah_LPU = @JumlahMohon,
                        Tkh_Mohon = @TkhMohon,
                        Created_Date = @CreatedDate,
                        Created_By = @CreatedBy,
                        Kod_Agih = @KodAgih,
                        Status_Dok = @Status_Dok
                        WHERE
                        No_Mohon = @No_Mohon"
        Else
            ' Insert a new record
            query = "INSERT INTO SMKB_Agihan_Bajet_Hdr (Kod_Korporat , No_Mohon , Kod_Kump_Wang , Kod_Operasi , Kod_Projek , Kod_PTJ , Kod_Bahagian, Kod_Unit, PTJ_Pusat, Program, Justifikasi, Tahun_Bajet , Kod_Dasar, Jumlah_Mohon , Jumlah_KB , Jumlah_Kew , Jumlah_KetuaPTj ,Jumlah_Bendahari , Jumlah_NC, Jumlah_LPU, Tkh_Mohon , Created_Date , Created_By  ,Kod_Agih, Status_Dok)
        VALUES(@Kod_Korporat ,@No_Mohon, @KW, @KO, @KP, @Kod_PTj , @Kod_Bahagian, @Kod_Unit, @Kod_Pusat, @Program , @Justifikasi, @TahunBajet, @KodDasar, @JumlahMohon, @JumlahMohon, @JumlahMohon, @JumlahMohon, @JumlahMohon, @JumlahMohon, @JumlahMohon, @TkhMohon, @CreatedDate, @CreatedBy, @KodAgih , @Status_Dok)"



        End If
        param.Add(New SqlParameter("@Kod_Korporat", "UTeM"))
        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@KW", Kump_Wang))
        param.Add(New SqlParameter("@KO", KodKo))
        param.Add(New SqlParameter("@KP", KodKP))
        param.Add(New SqlParameter("@Kod_PTj", PTJ))
        param.Add(New SqlParameter("@Kod_Bahagian", Bahagian))
        param.Add(New SqlParameter("@Kod_Unit", Unit))
        param.Add(New SqlParameter("@Kod_Pusat", PTJ_Pusat))
        param.Add(New SqlParameter("@Program", Program))
        param.Add(New SqlParameter("@Justifikasi", Justifikasi))
        param.Add(New SqlParameter("@TahunBajet", "2025"))
        param.Add(New SqlParameter("@KodDasar", Dasar))
        param.Add(New SqlParameter("@JumlahMohon", Replace(Jumlah, ",", "")))
        param.Add(New SqlParameter("@TkhMohon", currentdatetime_))
        param.Add(New SqlParameter("@CreatedDate", currentdatetime_))
        param.Add(New SqlParameter("@CreatedBy", Session("ssusrID")))
        param.Add(New SqlParameter("@KodAgih", "AL"))
        param.Add(New SqlParameter("@Status_Dok", "01"))

        'Return db.Process(query, param)
        Return RbQueryCmd("No_Mohon", orderid, query, param)

    End Function


    Private Function InsertOrderDetail(orderDetail_Bajet As orderDetail_Bajet)
        Dim db As New DBKewConn

        Dim currentDateTime As DateTime = DateTime.Now.AddSeconds(-DateTime.Now.Second).AddMilliseconds(-DateTime.Now.Millisecond)
        Dim currentdatetime_ As String = currentDateTime.Year.ToString() + "." + currentDateTime.Month.ToString() + "." + currentDateTime.Day.ToString() +
               " " + currentDateTime.Hour.ToString() + ":" + currentDateTime.Minute.ToString() + ":" + "00"

        Dim query As String = "INSERT INTO SMKB_Agihan_Bajet_Dtl (No_Item, No_Mohon, Kod_Vot_Am , Kod_Vot_Sbg, Butiran , Jumlah_Mohon, Jumlah_KB , Jumlah_Kew, Jumlah_KetuaPTJ , Jumlah_Bendahari , Jumlah_NC, Jumlah_LPU, Created_By, Created_Date , Kod_Agih)
        VALUES(@No_Item , @No_Mohon, @Kod_Vot_Am , @Kod_Vot_Sbg, @Butiran, @Jumlah_Mohon , @Jumlah_Mohon, @Jumlah_Mohon, @Jumlah_Mohon, @Jumlah_Mohon, @Jumlah_Mohon, @Jumlah_Mohon, @CreatedBy, @Created_Date , @Kod_Agih)"

        Dim param As New List(Of SqlParameter)

        Dim votAm As String = Left(orderDetail_Bajet.ddlObjAm, 1) + "0000"

        param.Add(New SqlParameter("@No_Item", orderDetail_Bajet.id))
        param.Add(New SqlParameter("@No_Mohon", orderDetail_Bajet.OrderID))
        param.Add(New SqlParameter("@Kod_Vot_Am", votAm))
        param.Add(New SqlParameter("@Kod_Vot_Sbg", orderDetail_Bajet.ddlObjAm))
        param.Add(New SqlParameter("@Butiran", orderDetail_Bajet.Butiran))
        param.Add(New SqlParameter("@Jumlah_Mohon", orderDetail_Bajet.Jumlah))
        param.Add(New SqlParameter("@Created_Date", currentdatetime_))
        param.Add(New SqlParameter("@CreatedBy", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Agih", "AL"))

        'Return db.Process(query, param)
        Return RbQueryCmd("No_Mohon", orderDetail_Bajet.OrderID, query, param)
    End Function

    Private Function UpadateOrderDetail(orderDetail_Bajet As orderDetail_Bajet)
        Dim db As New DBKewConn

        Dim currentDateTime As DateTime = DateTime.Now.AddSeconds(-DateTime.Now.Second).AddMilliseconds(-DateTime.Now.Millisecond)
        Dim currentdatetime_ As String = currentDateTime.Year.ToString() + "." + currentDateTime.Month.ToString() + "." + currentDateTime.Day.ToString() +
               " " + currentDateTime.Hour.ToString() + ":" + currentDateTime.Minute.ToString() + ":" + "00"

        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Dtl SET
                                Kod_Vot_Am = @Kod_Vot_Am, 
                                Kod_Vot_Sbg = @Kod_Vot_Sbg, 
                                Butiran = @Butiran, 
                                Jumlah_Kew  = @Jumlah_Mohon,
                                Jumlah_Bendahari = @Jumlah_Mohon, 
                                Jumlah_NC= @Jumlah_Mohon,  
                                Jumlah_LPU = @Jumlah_Mohon
                               WHERE No_Item = @No_Item and No_Mohon=@No_Mohon"

        Dim param As New List(Of SqlParameter)

        Dim votAm As String = Left(orderDetail_Bajet.ddlObjAm, 1) + "0000"

        param.Add(New SqlParameter("@No_Item", orderDetail_Bajet.id))
        param.Add(New SqlParameter("@No_Mohon", orderDetail_Bajet.OrderID))
        param.Add(New SqlParameter("@Kod_Vot_Am", votAm))
        param.Add(New SqlParameter("@Kod_Vot_Sbg", orderDetail_Bajet.ddlObjAm))
        param.Add(New SqlParameter("@Butiran", orderDetail_Bajet.Butiran))
        param.Add(New SqlParameter("@Jumlah_Mohon", orderDetail_Bajet.Jumlah))


        'Return db.Process(query, param)
        Return RbQueryCmd("No_Mohon", orderDetail_Bajet.OrderID, query, param)
    End Function

    Private Function DeleteOrderHdr(orderid As String)
        Dim db As New DBKewConn
        Dim query As String = "DELETE FROM SMKB_Agihan_Bajet_Hdr WHERE No_Mohon=@No_Mohon "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))

        Return db.Process(query, param)
    End Function

    Private Function DeleteOrderDtl(orderid As String)
        Dim db As New DBKewConn
        Dim query As String = "DELETE FROM SMKB_Agihan_Bajet_Dtl WHERE No_Mohon=@No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))

        Return db.Process(query, param)
    End Function


    Private Function UpdateNewOrder(OrderID As String, Tarikh As String, PTJ As String, Bahagian As String, Unit As String, PTJPusat As String, Dasar As String, KodKW As String, KodKO As String, KodKP As String, Program As String, Justifikasi As String, Jumlah As Decimal)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr SET Kod_Kump_Wang = @KW, Kod_Operasi = @KO, Kod_Projek =@KP, Kod_PTJ = @Kod_PTJ, Kod_Bahagian =@Kod_Bahagian, Kod_Unit =@Kod_Unit, PTJ_Pusat =@Kod_Pusat, Program =@Program, Justifikasi =@Justifikasi, Kod_Dasar = @KodDasar, Jumlah_Mohon =@Jumlah_Mohon , Jumlah_KB =@Jumlah_Mohon, Jumlah_Kew =@Jumlah_Mohon, Jumlah_KetuaPTj =@Jumlah_Mohon ,Jumlah_Bendahari =@Jumlah_Mohon , Jumlah_NC =@Jumlah_Mohon, Jumlah_LPU =@Jumlah_Mohon 
                               WHERE No_Mohon=@No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", OrderID))
        param.Add(New SqlParameter("@KW", KodKW))
        param.Add(New SqlParameter("@KO", KodKO))
        param.Add(New SqlParameter("@KP", KodKP))
        param.Add(New SqlParameter("@Kod_PTj", PTJ))
        param.Add(New SqlParameter("@Kod_Bahagian", Bahagian))
        param.Add(New SqlParameter("@Kod_Unit", Unit))
        param.Add(New SqlParameter("@Kod_Pusat", PTJPusat))
        param.Add(New SqlParameter("@Program", Program))
        param.Add(New SqlParameter("@Justifikasi", Justifikasi))
        param.Add(New SqlParameter("@KodDasar", Dasar))
        param.Add(New SqlParameter("@Jumlah_Mohon", Replace(Jumlah, ",", "")))

        'Return db.Process(query, param)
        Return RbQueryCmd("No_Mohon", OrderID, query, param)


    End Function

    Private Function UpdateLulusOrder(orderid As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String = "04"

        Dim query As String = "UPDATE SMKB_Jurnal_Hdr SET Kod_Status_Dok = @kodStatus
                               WHERE No_Jurnal=@No_Jurnal AND Status = 1"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Jurnal", orderid))
        param.Add(New SqlParameter("@kodStatus", kodstatusLulus))

        Return db.Process(query, param)

    End Function

    Private Function UpdateLulusOrderDetail(orderid As String)
        Dim db As New DBKewConn


        Dim query As String = "INSERT INTO SMKB_Lejar_Am
        select year(b.Tkh_Transaksi) as Tahun, Kod_Kump_Wang, Kod_Operasi, Kod_PTJ, Kod_Vot, Kod_Projek , 'UTeM', 
        CASE WHEN MONTH(b.Tkh_Transaksi) = 1 THEN SUM(Debit) ELSE 0 END AS Debit_1 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 1 THEN SUM(Kredit) ELSE 0 END AS Kredit_1 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 2 THEN SUM(Debit) ELSE 0 END AS Debit_2 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 2 THEN SUM(Kredit) ELSE 0 END AS Kredit_2 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 3 THEN SUM(Debit) ELSE 0 END AS Debit_3 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 3 THEN SUM(Kredit) ELSE 0 END AS Kredit_3 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 4 THEN SUM(Debit) ELSE 0 END AS Debit_4 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 4 THEN SUM(Kredit) ELSE 0 END AS Kredit_4 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 5 THEN SUM(Debit) ELSE 0 END AS Debit_5 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 5 THEN SUM(Kredit) ELSE 0 END AS Kredit_5 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 6 THEN SUM(Debit) ELSE 0 END AS Debit_6 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 6 THEN SUM(Kredit) ELSE 0 END AS Kredit_6 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 7 THEN SUM(Debit) ELSE 0 END AS Debit_7 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 7 THEN SUM(Kredit) ELSE 0 END AS Kredit_7 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 8 THEN SUM(Debit) ELSE 0 END AS Debit_8 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 8 THEN SUM(Kredit) ELSE 0 END AS Kredit_8 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 9 THEN SUM(Debit) ELSE 0 END AS Debit_9 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 9 THEN SUM(Kredit) ELSE 0 END AS Kredit_9 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 10 THEN SUM(Debit) ELSE 0 END AS Debit_10 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 10 THEN SUM(Kredit) ELSE 0 END AS Kredit_10 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 11 THEN SUM(Debit) ELSE 0 END AS Debit_11 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 11 THEN SUM(Kredit) ELSE 0 END AS Kredit_11 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 12 THEN SUM(Debit) ELSE 0 END AS Debit_12 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 12 THEN SUM(Kredit) ELSE 0 END AS Kredit_12 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 13 THEN SUM(Debit) ELSE 0 END AS Debit_13 ,
        CASE WHEN MONTH(b.Tkh_Transaksi) = 13 THEN SUM(Kredit) ELSE 0 END AS Kredit_13 ,
        b.Status
        from SMKB_Jurnal_Dtl a ,  SMKB_Jurnal_Hdr b 
        where a.No_Jurnal = b.No_Jurnal and
        a.No_Jurnal = @No_Jurnal
        and a.Status = 1
        and b.Status = 1
        group by year(b.Tkh_Transaksi) , Kod_Kump_Wang, Kod_Operasi, Kod_PTJ, Kod_Vot, Kod_Projek , MONTH(b.Tkh_Transaksi), b.Status"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Jurnal", orderid))


        Return db.Process(query, param)

    End Function

    Private Function UpdateLulusOrder_KB(orderid As String, kodDok As String)
        Dim db As New DBKewConn

        'Dim kodstatusLulus As String = "03"

        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr SET Status_Dok  = @kodStatus
                               WHERE No_Mohon =@No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@kodStatus", kodDok))

        'Return db.Process(query, param)

        Return RbQueryCmd("No_Mohon", orderid, query, param)
    End Function


    Private Function UpdateLulusOrder_bend_new(orderid As String, kod As String)
        Dim db As New DBKewConn

        'Dim kodstatusLulus As String = "03"

        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr SET Flag_Bendahari  = @kodStatus , Flag_NC = @kodStatus  , Flag_LPU = @kodStatus
                               WHERE No_Mohon =@No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@kodStatus", kod))

        'Return db.Process(query, param)

        Return RbQueryCmd("No_Mohon", orderid, query, param)
    End Function



    Private Function UpdateLulusOrder_Kew_Submit(orderid As String, kodDok As String)
        Dim db As New DBKewConn

        'Dim kodstatusLulus As String = "03"

        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr SET Status_Dok  = @kodStatus
                               WHERE Kod_PTJ =@Kod_PTJ "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_PTJ", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kodStatus", kodDok))
        'Return db.Process(query, param)

        Return RbQueryCmd("Kod_PTJ", Session("ssusrKodPTj"), query, param)
    End Function

    Private Function UpdateLulusOrder_bendahari_Submit(orderid As String, kodDok As String)
        Dim db As New DBKewConn

        'Dim kodstatusLulus As String = "03"

        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr SET Status_Dok  = @kodStatus
                               WHERE Status_Dok = '05' "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_PTJ", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kodStatus", kodDok))
        'Return db.Process(query, param)

        Return RbQueryCmd("Kod_PTJ", Session("ssusrKodPTj"), query, param)
    End Function
    Private Function UpdateLulusOrder_Kew(orderid As String, Tarikh As String, PTJ As String, Bahagian As String, Unit As String, PTJ_Pusat As String, Dasar As String, Kump_Wang As String, KodKo As String, KodKP As String, Program As String, Justifikasi As String, Jumlah As Decimal)
        Dim db As New DBKewConn

        Dim queryCheck As String = $"SELECT 1 FROM SMKB_Agihan_Bajet_Hdr WHERE No_Mohon = '{orderid}'"
        Dim existingRecord As Boolean = False

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If

        Dim query As String = ""
        Dim currentDateTime As DateTime = DateTime.Now.AddSeconds(-DateTime.Now.Second).AddMilliseconds(-DateTime.Now.Millisecond)
        Dim currentdatetime_ As String = currentDateTime.Year.ToString() + "." + currentDateTime.Month.ToString() + "." + currentDateTime.Day.ToString() +
               " " + currentDateTime.Hour.ToString() + ":" + currentDateTime.Minute.ToString() + ":" + "00"

        Dim param As New List(Of SqlParameter)

        If existingRecord Then
            ' Update the existing record
            query = "UPDATE SMKB_Agihan_Bajet_Hdr
                        SET 
                        Kod_Korporat = @Kod_Korporat,
                        Kod_Kump_Wang = @KW,
                        Kod_Operasi = @KO,
                        Kod_Projek = @KP,
                        Kod_PTJ = @Kod_PTj,
                        Kod_Bahagian = @Kod_Bahagian,
                        Kod_Unit = @Kod_Unit,
                        PTJ_Pusat = @Kod_Pusat,
                        Program = @Program,
                        Justifikasi = @Justifikasi,
                        Tahun_Bajet = @TahunBajet,
                        Kod_Dasar = @KodDasar,    
                        Jumlah_Kew = @JumlahMohon,
                        Jumlah_KetuaPTj = @JumlahMohon,
                        Jumlah_Bendahari = @JumlahMohon,
                        Jumlah_NC = @JumlahMohon,
                        Jumlah_LPU = @JumlahMohon  
                        WHERE
                        No_Mohon = @No_Mohon"



        End If
        param.Add(New SqlParameter("@Kod_Korporat", "UTeM"))
        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@KW", Kump_Wang))
        param.Add(New SqlParameter("@KO", KodKo))
        param.Add(New SqlParameter("@KP", KodKP))
        param.Add(New SqlParameter("@Kod_PTj", PTJ))
        param.Add(New SqlParameter("@Kod_Bahagian", Bahagian))
        param.Add(New SqlParameter("@Kod_Unit", Unit))
        param.Add(New SqlParameter("@Kod_Pusat", PTJ_Pusat))
        param.Add(New SqlParameter("@Program", Program))
        param.Add(New SqlParameter("@Justifikasi", Justifikasi))
        param.Add(New SqlParameter("@TahunBajet", "2025"))
        param.Add(New SqlParameter("@KodDasar", Dasar))
        param.Add(New SqlParameter("@JumlahMohon", Replace(Jumlah, ",", "")))



        'Return db.Process(query, param)
        Return RbQueryCmd("No_Mohon", orderid, query, param)

    End Function




    Private Function UpdateLulusOrder_Ketua(orderid As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String = "05"

        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr Set Status_Dok  = @kodStatus
                               WHERE No_Mohon =@No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@kodStatus", kodstatusLulus))

        Return db.Process(query, param)

    End Function

    Private Function UpdateLulusOrder_Bendahari(orderid As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String = "06"

        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr Set Status_Dok  = @kodStatus
                               WHERE No_Mohon =@No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@kodStatus", kodstatusLulus))

        Return db.Process(query, param)

    End Function

    Private Function UpdateLulusOrder_NC(orderid As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String = "07"

        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr Set Status_Dok  = @kodStatus
                               WHERE No_Mohon =@No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@kodStatus", kodstatusLulus))

        Return db.Process(query, param)

    End Function

    Private Function UpdateXLulusOrder(orderid As String)
        Dim db As New DBKewConn


        Dim kodstatusXLulus As String = "09" 'Gagal Kelulusan 1

        Dim query As String = "UPDATE SMKB_Jurnal_Hdr SET Kod_Status_Dok = @kodStatus
                               WHERE No_Jurnal=@No_Jurnal AND Status = 1"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Jurnal", orderid))
        param.Add(New SqlParameter("@kodStatus", kodstatusXLulus))

        Return db.Process(query, param)

    End Function

    Private Function UpdateStatusDokOrder(orderid As String, statusLulus As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String

        If statusLulus = "Y" Then

            kodstatusLulus = "04"

        ElseIf statusLulus = "N" Then

            kodstatusLulus = "09"

        End If


        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
							VALUES
							(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "01"))
        param.Add(New SqlParameter("@Kod_Status_Dok", kodstatusLulus))
        param.Add(New SqlParameter("@No_Rujukan", orderid))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        'param.Add(New SqlParameter("@Tkh_Tindakan", orderid))
        'param.Add(New SqlParameter("@Tkh_Transaksi", orderid))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", "-"))

        Return db.Process(query, param)

    End Function

    Private Function InsertStatusDokOrder(orderid As String, statusLulus As String, kodStatusDok As String)
        Dim db As New DBKewConn

        'Dim kodstatusLulus As String

        'If statusLulus = "Y" Then

        'kodstatusLulus = "01"

        'End If


        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
							VALUES
							(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "01"))
        param.Add(New SqlParameter("@Kod_Status_Dok", kodStatusDok))
        param.Add(New SqlParameter("@No_Rujukan", orderid))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        'param.Add(New SqlParameter("@Tkh_Tindakan", orderid))
        'param.Add(New SqlParameter("@Tkh_Transaksi", orderid))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", "-"))

        'Return db.Process(query, param)
        Return RbQueryCmd("No_Rujukan", orderid, query, param)
    End Function

    Private Function UpdateStatusDokOrder_Submit(orderid As String, statusLulus As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String

        If statusLulus = "Y" Then

            kodstatusLulus = "04"

        End If


        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
							VALUES
							(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "04"))
        param.Add(New SqlParameter("@Kod_Status_Dok", kodstatusLulus))
        param.Add(New SqlParameter("@No_Rujukan", orderid))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        'param.Add(New SqlParameter("@Tkh_Tindakan", orderid))
        'param.Add(New SqlParameter("@Tkh_Transaksi", orderid))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", "-"))

        Return db.Process(query, param)

    End Function


    Private Function GenerateOrderID() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='01' AND Prefix ='BG' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("01", "BG", year, lastID)
        Else

            InsertNoAkhir("01", "BG", year, lastID)
        End If
        newOrderID = "BG" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newOrderID
    End Function

    Private Function DeleteOrderRecord(orderid As String)
        Dim db = New db
        Dim query As String = "DELETE FROM orders WHERE order_id = @orderid "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@orderid", orderid))

        Return db.Process(query, param)
    End Function

    Private Function DeleteOrderDetails(Optional kod As String = "", Optional order_id As String = "")
        Dim db = New db
        Dim query As String = "DELETE FROM orderDetails WHERE "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " id = @id "
            param.Add(New SqlParameter("@id", kod))
        Else
            query &= " order_id = @order_id "

            param.Add(New SqlParameter("@order_id", order_id))
        End If

        Return db.Process(query, param)
    End Function

    Private Function GetKodVotList(kod As String, kodVot As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Vot as value,B.Butiran as text
                                FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Vot B ON A.Kod_Vot=B.Kod_Vot"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 and (A.Kod_Vot LIKE '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_PTJ =@kod3 order_Bajet by A.Kod_Vot"
        Else
            query &= " where A.Status = 1 and A.Kod_PTJ =@kod3 order_Bajet by A.Kod_Vot"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kodVot))

        Return db.Read(query, param)
    End Function

    Private Function GetKodKWList(kod As String, kodkw As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Kump_Wang as value,B.Butiran as text
                                FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Kump_Wang B ON A.Kod_Kump_Wang=B.Kod_Kump_Wang"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 and (A.Kod_Kump_Wang LIKE '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Vot =@kod3 order_Bajet by A.Kod_Kump_Wang"
        Else
            query &= " where A.Status = 1 and A.Kod_Vot =@kod3 order_Bajet by A.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kodkw))

        Return db.Read(query, param)
    End Function

    Private Function GetKodPtjList(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select distinct Kod_PTJ as value, 
        (SELECT b.Pejabat FROM VPejabat as b
        WHERE b.kodpejabat = left(Kod_PTJ,2)) as text
        from SMKB_COA_Master  "

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where Status = 1 and (Kod_PTJ LIKE '%' + @kod + '%' or 
        (left(Kod_PTJ,2) in (SELECT b.kodpejabat FROM VPejabat as b
        WHERE b.kodpejabat = left(Kod_PTJ,2) and b.Pejabat like '%' + @kod2 + '%'))) order_Bajet by Kod_PTJ"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodCOAList(kodCariVot As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT top 10 CONCAT(a.Kod_Vot, ' - ', vot.Butiran, ', ', a.Kod_Operasi, ' - ', ko.Butiran, ', ', kp.Butiran, ', ', a.Kod_Kump_Wang, ' - ', REPLACE(kw.Butiran, 'KUMPULAN WANG', 'KW'), ', ', mj.Pejabat) AS text,
                    a.Kod_Vot AS value ,
                    mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO ,  kp.Butiran as colKp , 
                    a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
                    FROM SMKB_COA_Master AS a 
                    JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                    JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                    JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
					JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
					JOIN VPejabat AS mj ON mj.kodpejabat = left(a.Kod_PTJ,2) 
                    WHERE a.status = 1 "

        Dim param As New List(Of SqlParameter)
        If kodCariVot <> "" Then
            query &= "AND (a.Kod_Vot LIKE '%' + @kod + '%' OR a.Kod_Operasi LIKE '%' + @kod2 + '%' OR a.Kod_Projek LIKE '%' + @kod3 + '%' OR a.Kod_Kump_Wang LIKE '%' + @kod4 + '%' OR a.Kod_PTJ LIKE '%' + @kod5 + '%' OR vot.Butiran LIKE '%' + @kodButir + '%' OR ko.Butiran LIKE '%' + @kodButir1 + '%'  OR kw.Butiran LIKE '%' + @kodButir2 + '%' OR mj.pejabat LIKE '%' + @kodButir3 + '%')"

            param.Add(New SqlParameter("@kod", kodCariVot))
            param.Add(New SqlParameter("@kod2", kodCariVot))
            param.Add(New SqlParameter("@kod3", kodCariVot))
            param.Add(New SqlParameter("@kod4", kodCariVot))
            param.Add(New SqlParameter("@kod5", kodCariVot))
            param.Add(New SqlParameter("@kodButir", kodCariVot))
            param.Add(New SqlParameter("@kodButir1", kodCariVot))
            param.Add(New SqlParameter("@kodButir2", kodCariVot))
            param.Add(New SqlParameter("@kodButir3", kodCariVot))
        End If

        Return db.Read(query, param)
    End Function

    Private Function GetKodKoList(kod As String, kodko As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Operasi as value, B.Butiran As text
                                From SMKB_COA_Master A
                                INNER Join SMKB_Operasi B ON A.Kod_Operasi=B.Kod_Operasi"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 And (A.Kod_Operasi Like '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Kump_Wang =@kod3 order_Bajet by A.Kod_Operasi"
        Else
            query &= " where A.Status = 1 and A.Kod_Kump_Wang =@kod3 order_Bajet by A.Kod_Operasi"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kodko))

        Return db.Read(query, param)
    End Function

    Private Function GetKodKPList(kod As String, kodkp As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Projek as value,B.Butiran as text FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Projek B ON A.Kod_Projek = B.Kod_Projek"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 and (A.Kod_Projek LIKE '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Operasi =@kod3 order_Bajet by A.Kod_Projek"
        Else
            query &= " where A.Status = 1 and A.Kod_Operasi =@kod3 order_Bajet by A.Kod_Projek"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kodkp))

        Return db.Read(query, param)
    End Function



    Private Function GetJenStatus(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "select Butiran  as text, Butiran as value , Kod_Status_Dok from SMKB_Kod_Status_Dok where Kod_Modul = '04' and Status = 1 
                                union 
                                select 'SEMUA' AS text , 'SEMUA' AS value , '00' AS Kod_Status_Dok 
                                order_Bajet by Kod_Status_Dok"

        'Dim param As New List(Of SqlParameter)
        'If kod <> "" Then
        '    query &= "where Kod_Modul = '04' and Status = 1 and (Kod_Status_Dok LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%')  "
        '    param.Add(New SqlParameter("@kod", kod))
        '    param.Add(New SqlParameter("@kod2", kod))
        'End If

        Return db.Read(query)
    End Function


    Private Function GetOrder(kod As String) As DataTable
        Dim db = New db

        Dim query As String = "SELECT A.order_id, B.id, b.order_id, b.ddlVot,  
        C.details as detailvot, b.details, b.quantity, b.price, b.amount 
        FROM orders A
        INNER JOIN orderDetails B
	        ON A.order_id = B.order_id 
        INNER JOIN vot C 
	        on B.ddlvot = C.ddlvot"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "  WHERE A.order_id = @ord "
            param.Add(New SqlParameter("@ord", kod))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiMohonBajet_KB(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiMohonTransaksiJurnal_KB(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiMohonTransaksiJurnal_KB(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -1, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -2, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tkh_Mohon >= @tkhMula and Tkh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "select No_Mohon, Program ,Justifikasi, Jumlah_KB as Jumlah, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi , 
                                 (select Butiran from SMKB_Kod_Status_Dok where Kod_Modul = '01' and Status = @status and Kod_Status_Dok = SMKB_Agihan_Bajet_Hdr.Status_Dok) as Kod_Status_Dok
                                from SMKB_Agihan_Bajet_Hdr 
                                where ID_Staf_KB = @userID  and Status_Dok = '02' " & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiMohonBajet_KewPtj(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiMohonTransaksiJurnal_KewPtj(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiMohonTransaksiJurnal_KewPtj(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -1, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -2, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tkh_Mohon >= @tkhMula and Tkh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "select No_Mohon, Program ,Justifikasi, Jumlah_KB as Jumlah, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi , 
                                 (select Butiran from SMKB_Kod_Status_Dok where Kod_Modul = '01' and Status = @status and Kod_Status_Dok = SMKB_Agihan_Bajet_Hdr.Status_Dok) as Kod_Status_Dok
                                from SMKB_Agihan_Bajet_Hdr 
                                where Status_Dok = '03' " & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiMohonBajet_KetuaPtj(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiMohonTransaksiJurnal_KetuaPtj(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiMohonTransaksiJurnal_KetuaPtj(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -1, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -2, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tkh_Mohon >= @tkhMula and Tkh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        'Dim query As String = "select No_Mohon, Program ,Justifikasi, Jumlah_KB as Jumlah, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi , 
        '                         (select Butiran from SMKB_Kod_Status_Dok where Kod_Modul = '01' and Status = @status and Kod_Status_Dok = SMKB_Agihan_Bajet_Hdr.Status_Dok) as Kod_Status_Dok
        '                        from SMKB_Agihan_Bajet_Hdr 
        '                        where ID_Staf_KB = @userID  and Status_Dok = '04' " & tarikhQuery

        Dim query As String = "select No_Mohon, Program ,Justifikasi, Jumlah_KB as Jumlah, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi , 
                                 (select Butiran from SMKB_Kod_Status_Dok where Kod_Modul = '01' and Status = @status and Kod_Status_Dok = SMKB_Agihan_Bajet_Hdr.Status_Dok) as Kod_Status_Dok
                                from SMKB_Agihan_Bajet_Hdr 
                                where Status_Dok = '04'  and Kod_PTJ =@Kod_PTJ" & tarikhQuery


        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@Kod_PTJ", Session("ssusrKodPTj")))

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiMohonBajet_Bendahari(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiMohonTransaksiJurnal_Bendahari(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiMohonBajet_NC(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiMohonTransaksiJurnal_NC(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiMohonTransaksiJurnal_NC(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -1, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -2, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tkh_Mohon >= @tkhMula and Tkh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "select No_Mohon, Program ,Justifikasi, Jumlah_KB as Jumlah, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi , 
                                 (select Butiran from SMKB_Kod_Status_Dok where Kod_Modul = '01' and Status = @status and Kod_Status_Dok = SMKB_Agihan_Bajet_Hdr.Status_Dok) as Kod_Status_Dok
                                from SMKB_Agihan_Bajet_Hdr 
                                where ID_Staf_KB = @userID  and Status_Dok = '06' " & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiMohonTransaksiJurnal_Bendahari(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -1, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -2, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tkh_Mohon >= @tkhMula and Tkh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "select No_Mohon, Program ,Justifikasi, Jumlah_KB as Jumlah, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi , 
                                 (select Butiran from SMKB_Kod_Status_Dok where Kod_Modul = '01' and Status = @status and Kod_Status_Dok = SMKB_Agihan_Bajet_Hdr.Status_Dok) as Kod_Status_Dok
                                from SMKB_Agihan_Bajet_Hdr 
                                where ID_Staf_KB = @userID  and Status_Dok = '05' " & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiTransaksiBajet(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String

        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiBajet(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiBajet(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""


        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(Tkh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -1, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND Tkh_Mohon >= DATEADD(month, -2, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND Tkh_Mohon >= @tkhMula and Tkh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "select No_Mohon, Program ,Justifikasi, Jumlah_Mohon, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi , Status_Dok,
                                 (select Butiran from SMKB_Kod_Status_Dok where Kod_Modul = '01' and Status = @status and Kod_Status_Dok = SMKB_Agihan_Bajet_Hdr.Status_Dok) as Kod_Status_Dok
                                from SMKB_Agihan_Bajet_Hdr 
                                where  Kod_Agih IN ('AL') AND Created_By = @userID " & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)
    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSummaryKewPTJ(tahun As String, category_KW As String) As String

        Dim resp As New ResponseRepository

        'If isClicked = False Then
        '    Return JsonConvert.SerializeObject(New DataTable)
        'End If


        dt = GetOrder_SenaraiSummaryKew(tahun, category_KW)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiSummaryKew(tahun As String, kw As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""


        Dim query As String = "SELECT ROW_NUMBER() OVER(ORDER BY S.Kod_Bahagian) AS Bil, S.Kod_Bahagian,  S.NamaBahagian, Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi , Kod_Projek , Kod_PTJ , 
                                isnull(sum(Operasi_10000),0) as Operasi_10000 , isnull(sum(Komited_10000),0) as Komited_10000, 
                                isnull(sum(Operasi_20000),0) as Operasi_20000 , isnull(sum(Komited_20000),0) as Komited_20000, 
                                isnull(sum(Operasi_30000),0) as Operasi_30000 , isnull(sum(Komited_30000),0) as Komited_30000, 
                                isnull(sum(Operasi_40000),0) as Operasi_40000 , isnull(sum(Komited_40000),0) as Komited_40000, 
                                isnull(sum(Operasi_50000),0) as Operasi_50000 , isnull(sum(Komited_50000),0) as Komited_50000, 
                                isnull(sum(Operasi_All),0) as Operasi_All,
                                isnull(sum(Komited_All),0) as Komited_All,
                                isnull(sum(Jumlah_Permohonan),0) as Jumlah_Permohonan
                                from
                                (
                                SELECT a.Kod_Bahagian ,
								(select  distinct(NamaPBU) as dept_name 
								from V_DSPejabat where Left(KodPejabat,2) = @Kod_PTJ_2 and KodPBU = A.Kod_Bahagian) as NamaBahagian,  
                                a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ , 
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '1%') THEN SUM(B.Jumlah_Kew) END AS Operasi_10000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '1%') THEN SUM(B.Jumlah_Kew) END AS Komited_10000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '2%') THEN SUM(B.Jumlah_Kew) END AS Operasi_20000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '2%') THEN SUM(B.Jumlah_Kew) END AS Komited_20000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '3%') THEN SUM(B.Jumlah_Kew) END AS Operasi_30000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '3%') THEN SUM(B.Jumlah_Kew) END AS Komited_30000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '4%') THEN SUM(B.Jumlah_Kew) END AS Operasi_40000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '4%') THEN SUM(B.Jumlah_Kew) END AS Komited_40000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '5%') THEN SUM(B.Jumlah_Kew) END AS Operasi_50000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '5%') THEN SUM(B.Jumlah_Kew) END AS Komited_50000 ,
                                CASE WHEN (A.Kod_Operasi = '01') THEN SUM(B.Jumlah_Kew) END AS Operasi_All,
                                CASE WHEN (A.Kod_Operasi = '02') THEN SUM(B.Jumlah_Kew) END AS Komited_All,
                                SUM(B.Jumlah_Kew)  AS Jumlah_Permohonan
                                FROM SMKB_Agihan_Bajet_Hdr as a , SMKB_Agihan_Bajet_Dtl as b --, SMKB_Status_Dok c
                                where a.No_Mohon = b.No_Mohon
                                and a.Kod_Kump_Wang = @Kod_Kump_Wang                               
                                and a.Flag_Kew = @status
                                and b.Flag_Kew = @status
                                and Kod_PTJ = @Kod_PTJ  and a.Status_Dok  in ('03','04','05','06','07')
                                --and a.No_Mohon = c.No_Rujukan and c.Kod_Status_Dok in ('03','04','05','06','07')
                                Group by a.Kod_Bahagian , Kod_Operasi , Kod_Vot_Am , a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ ,  b.Kod_Vot_Am
                                ) as S
                                Group by Kod_Bahagian , NamaBahagian, Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi, Kod_Projek , Kod_PTJ 
                                order by Kod_Bahagian"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_PTJ", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@Kod_PTJ_2", Left(Session("ssusrKodPTj"), 2)))

        Return db.Read(query, param)
    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSummaryBendahariPTJ(tahun As String, category_KW As String) As String

        Dim resp As New ResponseRepository

        'If isClicked = False Then
        '    Return JsonConvert.SerializeObject(New DataTable)
        'End If


        dt = GetOrder_SenaraiSummaryBendahari_Kew(tahun, category_KW)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiSummaryBendahari_Kew(tahun As String, kw As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""


        Dim query As String = "SELECT ROW_NUMBER() OVER(ORDER BY S.Kod_Bahagian) AS Bil, S.Kod_Bahagian,  S.NamaBahagian, Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi , Kod_Projek , 
                                --isnull(sum(Operasi_10000),0) as Operasi_10000 ,
								CASE 
									WHEN EXISTS (
										SELECT JumlahBendahari 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '01'
										AND KodVotAm = '10000'
									) 
									THEN (
										SELECT isnull(JumlahBendahari,0) 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '01'
										AND KodVotAm = '10000'
									)
									ELSE
									isnull(sum(Operasi_10000),0)
									END AS Operasi_10000,
								
								--isnull(sum(Komited_10000),0) as Komited_10000, 
								CASE 
									WHEN EXISTS (
										SELECT JumlahBendahari 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '02' 
										AND KodVotAm = '10000'
									) 
									THEN (
										SELECT isnull(JumlahBendahari,0) 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '02'
										AND KodVotAm = '10000'
									)
									ELSE
									isnull(sum(Komited_10000),0)
									END AS Komited_10000,
	--isnull(sum(Operasi_10000),0) as Operasi_10000 ,
								CASE 
									WHEN EXISTS (
										SELECT JumlahBendahari 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '01'
										AND KodVotAm = '20000'
									) 
									THEN (
										SELECT isnull(JumlahBendahari,0) 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '01'
										AND KodVotAm = '20000'
									)
									ELSE
									isnull(sum(Operasi_20000),0)
									END AS Operasi_20000,
								
								--isnull(sum(Komited_10000),0) as Komited_10000, 
								CASE 
									WHEN EXISTS (
										SELECT JumlahBendahari 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '02' 
										AND KodVotAm = '20000'
									) 
									THEN (
										SELECT isnull(JumlahBendahari,0) 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '02'
										AND KodVotAm = '20000'
									)
									ELSE
									isnull(sum(Komited_20000),0)
									END AS Komited_20000,

									CASE 
									WHEN EXISTS (
										SELECT JumlahBendahari 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '01'
										AND KodVotAm = '30000'
									) 
									THEN (
										SELECT isnull(JumlahBendahari,0) 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '01'
										AND KodVotAm = '30000'
									)
									ELSE
									isnull(sum(Operasi_30000),0)
									END AS Operasi_30000,
								
								--isnull(sum(Komited_10000),0) as Komited_10000, 
								CASE 
									WHEN EXISTS (
										SELECT JumlahBendahari 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '02' 
										AND KodVotAm = '30000'
									) 
									THEN (
										SELECT isnull(JumlahBendahari,0) 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '02'
										AND KodVotAm = '30000'
									)
									ELSE
									isnull(sum(Komited_30000),0)
									END AS Komited_30000,

												CASE 
									WHEN EXISTS (
										SELECT JumlahBendahari 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '01'
										AND KodVotAm = '40000'
									) 
									THEN (
										SELECT isnull(JumlahBendahari,0) 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '01'
										AND KodVotAm = '40000'
									)
									ELSE
									isnull(sum(Operasi_40000),0)
									END AS Operasi_40000,
								
								--isnull(sum(Komited_10000),0) as Komited_10000, 
								CASE 
									WHEN EXISTS (
										SELECT JumlahBendahari 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '02' 
										AND KodVotAm = '40000'
									) 
									THEN (
										SELECT isnull(JumlahBendahari,0) 
										FROM SMKB_BG_JumlahBajetAm 
										WHERE BG20_TahunBajet = '2025'
										AND KodPtj = S.Kod_Bahagian
										AND KodKW = Kod_Kump_Wang
										AND KodOperasi = '02'
										AND KodVotAm = '40000'
									)
									ELSE
									isnull(sum(Komited_40000),0)
									END AS Komited_40000,
                                isnull(sum(Operasi_All),0) as Operasi_All,
                                isnull(sum(Komited_All),0) as Komited_All,
                                isnull(sum(Jumlah_Permohonan),0) as Jumlah_Permohonan
                                from
                                (
                                SELECT a.Kod_PTJ AS Kod_Bahagian ,
								(select  distinct(Singkatan) as dept_name 
								from V_DSPejabat where Left(V_DSPejabat.KodPejabat,2) = lEFT(A.Kod_PTJ,2)) as NamaBahagian,  
                                a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , 
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '1%') THEN SUM(B.Jumlah_Kew) END AS Operasi_10000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '1%') THEN SUM(B.Jumlah_Kew) END AS Komited_10000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '2%') THEN SUM(B.Jumlah_Kew) END AS Operasi_20000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '2%') THEN SUM(B.Jumlah_Kew) END AS Komited_20000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '3%') THEN SUM(B.Jumlah_Kew) END AS Operasi_30000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '3%') THEN SUM(B.Jumlah_Kew) END AS Komited_30000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '4%') THEN SUM(B.Jumlah_Kew) END AS Operasi_40000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '4%') THEN SUM(B.Jumlah_Kew) END AS Komited_40000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '5%') THEN SUM(B.Jumlah_Kew) END AS Operasi_50000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '5%') THEN SUM(B.Jumlah_Kew) END AS Komited_50000 ,
                                CASE WHEN (A.Kod_Operasi = '01') THEN SUM(B.Jumlah_Kew) END AS Operasi_All,
                                CASE WHEN (A.Kod_Operasi = '02') THEN SUM(B.Jumlah_Kew) END AS Komited_All,
                                SUM(B.Jumlah_Kew)  AS Jumlah_Permohonan
                                FROM SMKB_Agihan_Bajet_Hdr as a , SMKB_Agihan_Bajet_Dtl as b --, SMKB_Status_Dok c
                                where a.No_Mohon = b.No_Mohon
                                and a.Kod_Kump_Wang = @Kod_Kump_Wang                              
                                and (a.Flag_Bendahari is null or a.Flag_Bendahari = 0)
                                and a.Status_Dok  in ('05','06','07')
								AND A.Tahun_Bajet ='2025'
                                --and a.No_Mohon = c.No_Rujukan and c.Kod_Status_Dok in ('03','04','05','06','07')
                                Group by a.Kod_PTJ , Kod_Operasi , Kod_Vot_Am , a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ ,  b.Kod_Vot_Am
                                ) as S
                                Group by  NamaBahagian, Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi, Kod_Projek , Kod_Bahagian 
          
          "

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_PTJ", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@Kod_PTJ_2", Left(Session("ssusrKodPTj"), 2)))

        Return db.Read(query, param)
    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSummaryKetuaPTJ(tahun As String, category_KW As String) As String

        Dim resp As New ResponseRepository

        'If isClicked = False Then
        '    Return JsonConvert.SerializeObject(New DataTable)
        'End If


        dt = GetOrder_SenaraiSummaryKetua(tahun, category_KW)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiSummaryKetua(tahun As String, kw As String) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""


        Dim query As String = "SELECT ROW_NUMBER() OVER(ORDER BY S.Kod_Bahagian) AS Bil, S.Kod_Bahagian,  S.NamaBahagian, Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi , Kod_Projek , Kod_PTJ , 
                                isnull(sum(Operasi_10000),0) as Operasi_10000 , isnull(sum(Komited_10000),0) as Komited_10000, 
                                isnull(sum(Operasi_20000),0) as Operasi_20000 , isnull(sum(Komited_20000),0) as Komited_20000, 
                                isnull(sum(Operasi_30000),0) as Operasi_30000 , isnull(sum(Komited_30000),0) as Komited_30000, 
                                isnull(sum(Operasi_40000),0) as Operasi_40000 , isnull(sum(Komited_40000),0) as Komited_40000, 
                                isnull(sum(Operasi_50000),0) as Operasi_50000 , isnull(sum(Komited_50000),0) as Komited_50000, 
                                isnull(sum(Operasi_All),0) as Operasi_All,
                                isnull(sum(Komited_All),0) as Komited_All,
                                isnull(sum(Jumlah_Permohonan),0) as Jumlah_Permohonan
                                from
                                (
                                SELECT a.Kod_Bahagian ,
								(select  distinct(NamaPBU) as dept_name 
								from V_DSPejabat where Left(KodPejabat,2) = @Kod_PTJ_2 and KodPBU = A.Kod_Bahagian) as NamaBahagian,  
                                a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ , 
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '1%') THEN SUM(B.Jumlah_Kew) END AS Operasi_10000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '1%') THEN SUM(B.Jumlah_Kew) END AS Komited_10000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '2%') THEN SUM(B.Jumlah_Kew) END AS Operasi_20000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '2%') THEN SUM(B.Jumlah_Kew) END AS Komited_20000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '3%') THEN SUM(B.Jumlah_Kew) END AS Operasi_30000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '3%') THEN SUM(B.Jumlah_Kew) END AS Komited_30000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '4%') THEN SUM(B.Jumlah_Kew) END AS Operasi_40000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '4%') THEN SUM(B.Jumlah_Kew) END AS Komited_40000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '5%') THEN SUM(B.Jumlah_Kew) END AS Operasi_50000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '5%') THEN SUM(B.Jumlah_Kew) END AS Komited_50000 ,
                                CASE WHEN (A.Kod_Operasi = '01') THEN SUM(B.Jumlah_Kew) END AS Operasi_All,
                                CASE WHEN (A.Kod_Operasi = '02') THEN SUM(B.Jumlah_Kew) END AS Komited_All,
                                SUM(B.Jumlah_Kew)  AS Jumlah_Permohonan
                                FROM SMKB_Agihan_Bajet_Hdr as a , SMKB_Agihan_Bajet_Dtl as b --, SMKB_Status_Dok c
                                where a.No_Mohon = b.No_Mohon
                                and a.Kod_Kump_Wang = @Kod_Kump_Wang                               
                                and a.Flag_Kew = @status
                                and b.Flag_Kew = @status
                                and Kod_PTJ = @Kod_PTJ  and a.Status_Dok  in ('04','05','06','07')
                                --and a.No_Mohon = c.No_Rujukan and c.Kod_Status_Dok in ('04','05','06','07')
                                Group by a.Kod_Bahagian , Kod_Operasi , Kod_Vot_Am , a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ ,  b.Kod_Vot_Am
                                ) as S
                                Group by Kod_Bahagian , NamaBahagian, Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi, Kod_Projek , Kod_PTJ 
                                order by Kod_Bahagian"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_PTJ", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@Kod_PTJ_2", Left(Session("ssusrKodPTj"), 2)))

        Return db.Read(query, param)
    End Function

    Public Function GetPenghutangList(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodPenghutangList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodPenghutangList(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Penghutang as value, Nama_Penghutang as text FROM SMKB_Penghutang_Master WHERE Status='1'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Penghutang LIKE '%' + @kod + '%' OR Nama_Penghutang LIKE '%' + @kod2 + '%' "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    Public Function GetUrusniagaList(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodUrusniagaList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodUrusniagaList(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Urusniaga AS value,Butiran AS text FROM SMKB_Kod_Urusniaga WHERE Status='1'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Urusniaga LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordBajet(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetTransaksiBajet(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetTransaksiBajet(kod As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select Kod_Vot_Sbg as ddlObjAm, Jumlah_Mohon as Jumlah, a.Butiran , b.Butiran as ButiranVot from SMKB_Agihan_Bajet_Dtl as a 
        inner join SMKB_Vot as b on a.Kod_Vot_Sbg = b.Kod_Vot and Status = 1
        where No_Mohon = @No_Mohon"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", kod))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordBajet_KB(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetTransaksiBajet_KB(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetTransaksiBajet_KB(kod As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select Kod_Vot_Sbg as ddlObjAm, Jumlah_KB as Jumlah, a.Butiran , b.Butiran as ButiranVot from SMKB_Agihan_Bajet_Dtl as a 
        inner join SMKB_Vot as b on a.Kod_Vot_Sbg = b.Kod_Vot and Status = 1
        where No_Mohon = @No_Mohon"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", kod))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordBajet_Kew(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetTransaksiBajet_Kew(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetTransaksiBajet_Kew(kod As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select No_Item, Kod_Vot_Sbg as ddlObjAm, Jumlah_Kew as Jumlah, a.Butiran , b.Butiran as ButiranVot from SMKB_Agihan_Bajet_Dtl as a 
        inner join SMKB_Vot as b on a.Kod_Vot_Sbg = b.Kod_Vot and Status = 1
        where No_Mohon = @No_Mohon
        order by No_Item"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrBajet(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrBajet(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrBajet(id As String) As DataTable
        Dim db = New DBKewConn
        Dim existingRecord As Boolean

        Dim queryCheck As String = "SELECT 1 FROM SMKB_PTJ_PBU WHERE Kod_Ptj = @kodPtj"
        Dim paramCheck As New List(Of SqlParameter)
        paramCheck.Add(New SqlParameter("@kodPtj", Session("ssusrKodPTj")))

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck, paramCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If

        Dim queryMain As String
        If existingRecord Then
            queryMain = "select No_Mohon, FORMAT(Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Transaksi, Kod_PTJ, 
        Kod_Bahagian, (select distinct(NamaPBU) from V_DSPejabat where KodPBU =  a.Kod_Bahagian ) as Butir_Kod_Bahagian, 
        Kod_Unit, (select distinct(NamaBahagian) from V_DSPejabat where KodBahagian = a.Kod_Unit ) as Butir_Kod_Unit, 
		PTJ_Pusat,
        CASE 
        WHEN  (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat ) IS NULL  THEN
        'TIADA'
        ELSE
        (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat )
        END AS Butir_PTJ_Pusat,    
        Kod_Dasar, (select Butiran from SMKB_Dasar where Kod_Dasar = a.Kod_Dasar ) as Butir_Kod_Dasar,   
        Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang where Kod_Kump_Wang = a.Kod_Kump_Wang ) as Butir_Kod_Kump_Wang,  
        Kod_Operasi, (select Butiran from SMKB_Operasi where Kod_Operasi = a.Kod_Operasi ) as Butir_Kod_Operasi,  
        Kod_Projek, (select Butiran from SMKB_Projek where Kod_Projek = a.Kod_Projek ) as Butir_Kod_Projek, 
        Program, Justifikasi, Jumlah_Mohon , Status_Dok
        from  SMKB_Agihan_Bajet_Hdr a
        where No_Mohon = @No_Mohon"


        Else
            queryMain = "select No_Mohon, FORMAT(Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Transaksi, Kod_PTJ, 
        Kod_Bahagian, (select distinct(NamaBahagian) from V_DSPejabat where KodBahagian =  a.Kod_Bahagian ) as Butir_Kod_Bahagian, 
        Kod_Unit, (select distinct(NamaUnit) from V_DSPejabat where KodUnit = a.Kod_Unit and KodBahagian = a.Kod_Bahagian ) as Butir_Kod_Unit, 
		PTJ_Pusat,
        CASE 
        WHEN  (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat ) IS NULL  THEN
        'TIADA'
        ELSE
        (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat )
        END AS Butir_PTJ_Pusat,    
        Kod_Dasar, (select Butiran from SMKB_Dasar where Kod_Dasar = a.Kod_Dasar ) as Butir_Kod_Dasar,   
        Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang where Kod_Kump_Wang = a.Kod_Kump_Wang ) as Butir_Kod_Kump_Wang,  
        Kod_Operasi, (select Butiran from SMKB_Operasi where Kod_Operasi = a.Kod_Operasi ) as Butir_Kod_Operasi,  
        Kod_Projek, (select Butiran from SMKB_Projek where Kod_Projek = a.Kod_Projek ) as Butir_Kod_Projek, 
        Program, Justifikasi, Jumlah_Mohon  , Status_Dok
        from  SMKB_Agihan_Bajet_Hdr a
        where No_Mohon = @No_Mohon"


        End If



        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", id))

        Return db.Read(queryMain, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrBajet_Kew(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrBajet_Kew(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrBajet_Kew(id As String) As DataTable
        Dim db = New DBKewConn
        Dim existingRecord As Boolean

        Dim queryCheck As String = "SELECT 1 FROM SMKB_PTJ_PBU WHERE Kod_Ptj = @kodPtj"
        Dim paramCheck As New List(Of SqlParameter)
        paramCheck.Add(New SqlParameter("@kodPtj", Session("ssusrKodPTj")))

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck, paramCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If

        Dim queryMain As String
        If existingRecord Then
            queryMain = "select No_Mohon, FORMAT(Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Transaksi, Kod_PTJ, 
        Kod_Bahagian, (select distinct(NamaPBU) from V_DSPejabat where KodPBU =  a.Kod_Bahagian ) as Butir_Kod_Bahagian, 
        Kod_Unit, (select distinct(NamaBahagian) from V_DSPejabat where KodBahagian = a.Kod_Unit ) as Butir_Kod_Unit, 
		PTJ_Pusat,
        CASE 
        WHEN  (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat ) IS NULL  THEN
        'TIADA'
        ELSE
        (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat )
        END AS Butir_PTJ_Pusat,    
        Kod_Dasar, (select Butiran from SMKB_Dasar where Kod_Dasar = a.Kod_Dasar ) as Butir_Kod_Dasar,   
        Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang where Kod_Kump_Wang = a.Kod_Kump_Wang ) as Butir_Kod_Kump_Wang,  
        Kod_Operasi, (select Butiran from SMKB_Operasi where Kod_Operasi = a.Kod_Operasi ) as Butir_Kod_Operasi,  
        Kod_Projek, (select Butiran from SMKB_Projek where Kod_Projek = a.Kod_Projek ) as Butir_Kod_Projek, 
        Program, Justifikasi, Jumlah_Kew as Jumlah_Mohon, Status_Dok
        from  SMKB_Agihan_Bajet_Hdr a
        where No_Mohon = @No_Mohon"


        Else
            queryMain = "select No_Mohon, FORMAT(Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Transaksi, Kod_PTJ, 
        Kod_Bahagian, (select distinct(NamaBahagian) from V_DSPejabat where KodBahagian =  a.Kod_Bahagian ) as Butir_Kod_Bahagian, 
        Kod_Unit, (select distinct(NamaUnit) from V_DSPejabat where KodUnit = a.Kod_Unit and KodBahagian = a.Kod_Bahagian ) as Butir_Kod_Unit, 
		PTJ_Pusat,
        CASE 
        WHEN  (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat ) IS NULL  THEN
        'TIADA'
        ELSE
        (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat )
        END AS Butir_PTJ_Pusat,    
        Kod_Dasar, (select Butiran from SMKB_Dasar where Kod_Dasar = a.Kod_Dasar ) as Butir_Kod_Dasar,   
        Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang where Kod_Kump_Wang = a.Kod_Kump_Wang ) as Butir_Kod_Kump_Wang,  
        Kod_Operasi, (select Butiran from SMKB_Operasi where Kod_Operasi = a.Kod_Operasi ) as Butir_Kod_Operasi,  
        Kod_Projek, (select Butiran from SMKB_Projek where Kod_Projek = a.Kod_Projek ) as Butir_Kod_Projek, 
        Program, Justifikasi, Jumlah_Kew as Jumlah_Mohon , Status_Dok
        from  SMKB_Agihan_Bajet_Hdr a
        where No_Mohon = @No_Mohon"


        End If



        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", id))

        Return db.Read(queryMain, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrBajet_KB(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrBajet_KB(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrBajet_KB(id As String) As DataTable
        Dim db = New DBKewConn
        Dim existingRecord As Boolean

        Dim queryCheck As String = "SELECT 1 FROM SMKB_PTJ_PBU WHERE Kod_Ptj = @kodPtj"
        Dim paramCheck As New List(Of SqlParameter)
        paramCheck.Add(New SqlParameter("@kodPtj", Session("ssusrKodPTj")))

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck, paramCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If

        Dim queryMain As String
        If existingRecord Then
            queryMain = "select No_Mohon, FORMAT(Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Transaksi, Kod_PTJ, 
        Kod_Bahagian, (select distinct(NamaPBU) from V_DSPejabat where KodPBU =  a.Kod_Bahagian ) as Butir_Kod_Bahagian, 
        Kod_Unit, (select distinct(NamaBahagian) from V_DSPejabat where KodBahagian = a.Kod_Unit ) as Butir_Kod_Unit, 
		PTJ_Pusat,
        CASE 
        WHEN  (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat ) IS NULL  THEN
        'TIADA'
        ELSE
        (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat )
        END AS Butir_PTJ_Pusat,    
        Kod_Dasar, (select Butiran from SMKB_Dasar where Kod_Dasar = a.Kod_Dasar ) as Butir_Kod_Dasar,   
        Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang where Kod_Kump_Wang = a.Kod_Kump_Wang ) as Butir_Kod_Kump_Wang,  
        Kod_Operasi, (select Butiran from SMKB_Operasi where Kod_Operasi = a.Kod_Operasi ) as Butir_Kod_Operasi,  
        Kod_Projek, (select Butiran from SMKB_Projek where Kod_Projek = a.Kod_Projek ) as Butir_Kod_Projek, 
        Program, Justifikasi, Jumlah_KB as Jumlah_Mohon , Status_Dok
        from  SMKB_Agihan_Bajet_Hdr a
        where No_Mohon = @No_Mohon"


        Else
            queryMain = "select No_Mohon, FORMAT(Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Transaksi, Kod_PTJ, 
        Kod_Bahagian, (select distinct(NamaBahagian) from V_DSPejabat where KodBahagian =  a.Kod_Bahagian ) as Butir_Kod_Bahagian, 
        Kod_Unit, (select distinct(NamaUnit) from V_DSPejabat where KodUnit = a.Kod_Unit and KodBahagian = a.Kod_Bahagian ) as Butir_Kod_Unit, 
		PTJ_Pusat,
        CASE 
        WHEN  (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat ) IS NULL  THEN
        'TIADA'
        ELSE
        (SELECT  bv.Pejabat  
        FROM SMKB_PTJ_Pusat av , VPejabat bv
        Where av.Kod_PTJ = concat(bv.KodPejabat,'0000')
        and av.Status_Pusat = 1 and av.Kod_PTJ = a.PTJ_Pusat )
        END AS Butir_PTJ_Pusat,    
        Kod_Dasar, (select Butiran from SMKB_Dasar where Kod_Dasar = a.Kod_Dasar ) as Butir_Kod_Dasar,   
        Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang where Kod_Kump_Wang = a.Kod_Kump_Wang ) as Butir_Kod_Kump_Wang,  
        Kod_Operasi, (select Butiran from SMKB_Operasi where Kod_Operasi = a.Kod_Operasi ) as Butir_Kod_Operasi,  
        Kod_Projek, (select Butiran from SMKB_Projek where Kod_Projek = a.Kod_Projek ) as Butir_Kod_Projek, 
        Program, Justifikasi, Jumlah_KB as Jumlah_Mohon  , Status_Dok
        from  SMKB_Agihan_Bajet_Hdr a
        where No_Mohon = @No_Mohon"


        End If



        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", id))

        Return db.Read(queryMain, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_KB(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah diluluskan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_KB(order.OrderID, "03") <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())           ' Exit Function
        Else
            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "03") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_KB_Return(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah dikembalikan kepada pemohon")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_KB(order.OrderID, "01") <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())           ' Exit Function
        Else
            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "01") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_Kew_Submit(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah dikembalikan kepada pemohon")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_Kew_Submit(order.OrderID, "04") <> "OK" Then

            resp.Failed("Berjaya hantar untuk kelulusan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())           ' Exit Function
        Else
            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "04") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Berjaya hantar untuk kelulusan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_Ketua_Submit(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah dikembalikan kepada pemohon")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_Kew_Submit(order.OrderID, "05") <> "OK" Then

            resp.Failed("Berjaya hantar untuk kelulusan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())           ' Exit Function
        Else
            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "05") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Berjaya hantar untuk kelulusan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_Bendahari_Submit(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah dikembalikan kepada pemohon")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_bendahari_Submit(order.OrderID, "06") <> "OK" Then

            resp.Failed("Berjaya hantar untuk kelulusan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())           ' Exit Function
        Else
            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "06") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Berjaya hantar untuk kelulusan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function save_objek_am(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Rekod telah disimpam")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If update_objek_am(order) <> "OK" Then

            resp.Failed("Rekod berjaya disimpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())           ' Exit Function
        Else
            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "05") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Berjaya hantar untuk kelulusan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function update_objek_am(order As order_Bajet)
        Dim db As New DBKewConn
        Dim query As String = ""
        Dim param As New List(Of SqlParameter)
        Dim existingRecord As Boolean


        Dim queryCheck As String = "SELECT 1 FROM [SMKB_BG_JumlahBajetAm] WHERE
        BG20_TahunBajet = '2025' and KodPtj = @KodPtj and KodKW = @KodKW and KodOperasi = @KodOperasi and KodVotAm = @KodVotAm "
        Dim paramCheck As New List(Of SqlParameter)
        paramCheck.Add(New SqlParameter("@KodPtj", order.PTJ))
        paramCheck.Add(New SqlParameter("@KodKW", Left(order.KumpWang, 2)))
        paramCheck.Add(New SqlParameter("@KodOperasi", Left(order.KodKO, 2)))
        paramCheck.Add(New SqlParameter("@KodVotAm", order.Dasar))

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck, paramCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If



        If existingRecord Then
            ' Record exists, perform update
            query = "UPDATE SMKB_BG_JumlahBajetAm SET   [JumlahBendahari] =  @JumlahBendahari ,[JumlahNC] = @JumlahNC, [JumlahLPU] = @JumlahLPU, [JumlahBendahari_Agihan] = @JumlahBendahari_Agihan, [JumlahNC_Agihan] = @JumlahNC_Agihan, [JumlahLPU_Agihan] = @JumlahLPU_Agihan 
            WHERE  BG20_TahunBajet = '2025' and KodPtj = @KodPtj and KodKW = @KodKW and KodOperasi = @KodOperasi and KodVotAm = @KodVotAm"
            ' Add parameters for update here
            param.Add(New SqlParameter("@BG20_TahunBajet", "2025"))
                param.Add(New SqlParameter("@KodPtj", order.PTJ))
            param.Add(New SqlParameter("@KodKW", Left(order.KumpWang, 2)))
            param.Add(New SqlParameter("@KodOperasi", Left(order.KodKO, 2)))
            param.Add(New SqlParameter("@KodVotAm", order.Dasar))
                param.Add(New SqlParameter("@JumlahBendahari", order.Jumlah))
                param.Add(New SqlParameter("@JumlahNC", order.Jumlah))
                param.Add(New SqlParameter("@JumlahLPU", order.Jumlah))
                param.Add(New SqlParameter("@JumlahBendahari_Agihan", order.Jumlah))
                param.Add(New SqlParameter("@JumlahNC_Agihan", order.Jumlah))
                param.Add(New SqlParameter("@JumlahLPU_Agihan", order.Jumlah))
                param.Add(New SqlParameter("@StatusBend", 1))
                param.Add(New SqlParameter("@StatusNC", 1))
                param.Add(New SqlParameter("@StatusLPU", 1))
                'param.Add(New SqlParameter("@Catatan_Bend", catatanBend))
                'param.Add(New SqlParameter("@Catatan_NC", catatanNC))
            Else
                ' Record does not exist, perform insert
                query = "INSERT INTO SMKB_BG_JumlahBajetAm 
([BG20_TahunBajet], [KodPtj], [KodKW], [KodOperasi], [KodVotAm], [JumlahBendahari], [JumlahNC], [JumlahLPU], [JumlahBendahari_Agihan], 
[JumlahNC_Agihan], [JumlahLPU_Agihan], [StatusBend], [StatusNC], [StatusLPU]) 
VALUES (@BG20_TahunBajet, @KodPtj, @KodKW, @KodOperasi, @KodVotAm, @JumlahBendahari, @JumlahNC, @JumlahLPU, @JumlahBendahari_Agihan,
@JumlahNC_Agihan, @JumlahLPU_Agihan, @StatusBend, @StatusNC, @StatusLPU)"
            ' Add parameters for insert here
            param.Add(New SqlParameter("@BG20_TahunBajet", "2025"))
            param.Add(New SqlParameter("@KodPtj", order.PTJ))
            param.Add(New SqlParameter("@KodKW", Left(order.KumpWang, 2)))
            param.Add(New SqlParameter("@KodOperasi", Left(order.KodKO, 2)))
            param.Add(New SqlParameter("@KodVotAm", order.Dasar))
            param.Add(New SqlParameter("@JumlahBendahari", order.Jumlah))
            param.Add(New SqlParameter("@JumlahNC", order.Jumlah))
            param.Add(New SqlParameter("@JumlahLPU", order.Jumlah))
            param.Add(New SqlParameter("@JumlahBendahari_Agihan", order.Jumlah))
            param.Add(New SqlParameter("@JumlahNC_Agihan", order.Jumlah))
            param.Add(New SqlParameter("@JumlahLPU_Agihan", order.Jumlah))
            param.Add(New SqlParameter("@StatusBend", 1))
            param.Add(New SqlParameter("@StatusNC", 1))
            param.Add(New SqlParameter("@StatusLPU", 1))
        End If

        ' Execute the query with parameters
        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function XLulusorder_KB(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Rekod tidak disokong")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_KB(order.OrderID, "99") <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        Else

            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "99") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function XLulusorder_Bajet(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Rekod tidak disokong")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_KB(order.OrderID, "99") <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        Else

            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "99") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function XLulusorder_Bajet_Bendahari(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Rekod tidak disokong")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_bend_new(order.OrderID, "1") <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        Else

            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "99") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If


        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    '<System.Web.Services.WebMethod(EnableSession:=True)>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function Lulusorder_Kew(order As order_Bajet) As String
    '    Dim resp As New ResponseRepository
    '    resp.Success("Rekod telah diluluskan")
    '    Dim success As Integer = 0
    '    Dim JumRekod As Integer = 0
    '    If order Is Nothing Then
    '        resp.Failed("Tiada simpan")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    End If


    '    If UpdateLulusOrder_Kew(order.OrderID, order.Tarikh, order.PTJ, order.Bahagian, order.Unit, order.PTJPusatBajet, order.Dasar, order.KumpWang, order.KodKO, order.KodKP, order.Program, order.Justifikasi, order.Jumlah) <> "OK" Then

    '        resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
    '            Return JsonConvert.SerializeObject(resp.GetResult())
    '            ' Exit Function

    '            success += 1

    '        End If


    '        If InsertStatusDokOrder(order.OrderID, "Y", "04") <> "OK" Then

    '        'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '        ' Exit Function

    '    End If

    '    If success = 0 Then
    '        resp.Failed("Rekod order_Bajet detail gagal disimpan")
    '        Return JsonConvert.SerializeObject(resp.GetResult())

    '    Else
    '        resp.Success("Rekod berjaya disimpan", "00", order)
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    End If




    '    Return JsonConvert.SerializeObject(resp.GetResult())
    'End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_Kew(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Rekod berjaya disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0


        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        If UpdateLulusOrder_Kew(order.OrderID, order.Tarikh, order.PTJ, order.Bahagian, order.Unit, order.PTJPusatBajet, order.Dasar, order.KumpWang, order.KodKO, order.KodKP, order.Program, order.Justifikasi, order.Jumlah) <> "OK" Then
            resp.Failed("Gagal Menyimpan Maklumat")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If



        For Each orderDetail_Bajet As orderDetail_Bajet In order.OrderDetails

            If orderDetail_Bajet.ddlObjAm = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail_Bajet.kredit = 0 'orderDetail_Bajet.quantity * orderDetail_Bajet.debit 'This can be automated insie orderDetail_Bajet model

            If orderDetail_Bajet.id = "" Then
                orderDetail_Bajet.id = GenerateOrderDetailID(order.OrderID)
                orderDetail_Bajet.OrderID = order.OrderID
                orderDetail_Bajet.Tarikh = order.Tarikh
                If InsertOrderDetail(orderDetail_Bajet) = "OK" Then
                    success += 1
                End If
            Else
                If UpadateOrderDetail(orderDetail_Bajet) = "OK" Then
                    success += 1
                End If
            End If
        Next

        If InsertStatusDokOrder(order.OrderID, "Y", "03") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If

        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If Not success = JumRekod Then
            resp.Success("Rekod order_Bajet detail berjaya disimpan dengan beberapa rekod tidak disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_Ketua(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah diluluskan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_Ketua(order.OrderID) <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "05") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If

        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_Bendahari(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah diluluskan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_Bendahari(order.OrderID) <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "06") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If

        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder_NC(order As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah diluluskan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder_NC(order.OrderID) <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

            success += 1

        End If

        If InsertStatusDokOrder(order.OrderID, "Y", "07") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function

        End If

        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Lulusorder(order_Bajet As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah diluluskan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order_Bajet Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateLulusOrder(order_Bajet.OrderID) <> "OK" Then

            resp.Failed("Berjaya simpan")  'Gagal Menyimpan order_Bajet XX 
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        Else

            If UpdateLulusOrderDetail(order_Bajet.OrderID) <> "OK" Then

                resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
            Else
                If UpdateStatusDokOrder(order_Bajet.OrderID, "Y") <> "OK" Then

                    resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    ' Exit Function

                End If
            End If

            success += 1

        End If



        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order_Bajet)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function XLulusorder(order_Bajet As order_Bajet) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah TIDAK diluluskan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order_Bajet Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateXLulusOrder(order_Bajet.OrderID) <> "OK" Then

            resp.Failed("Gagal Menyimpan order_Bajet")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        Else

            If UpdateStatusDokOrder(order_Bajet.OrderID, "N") <> "OK" Then

                resp.Failed("Gagal Menyimpan order_Bajet")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function

            End If

            success += 1

        End If



        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        Else
            resp.Success("Rekod berjaya disimpan", "00", order_Bajet)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If




        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function SendEmail() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='07' AND Prefix ='JK' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("07", "JK", year, lastID)
        Else

            InsertNoAkhir("07", "JK", year, lastID)
        End If
        newOrderID = "JK" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newOrderID
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDateNow()
        Dim db As New DBKewConn


        Dim query As String = $"select getdate() as curDateNow"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPTJ()
        Dim db As New DBSMConn


        Dim query As String = $"select concat(KodPejabat,'0000') as KodPejPBU, Pejabat from MS_Pejabat where KodPejabat =@kodPTJ and Status = @status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kodPTJ", Left(Session("ssusrKodPTj"), 2)))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function ReadPTJ(Kod_PTJ As String)
        Dim db As New DBSMConn


        Dim query As String = $"select KodPejPBU, Pejabat from MS_Pejabat where KodPejPBU =@kodPTJ and Status = @status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kodPTJ", Kod_PTJ))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function ViewPTJ(val As String)
        Dim db As New DBSMConn


        Dim query As String = $"select concat(KodPejabat,'0000') as KodPejPBU,  Pejabat from MS_Pejabat where KodPejabat =@kodPTJ and Status = @status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kodPTJ", Left(val, 2)))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetObjAm(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodObjAmList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodObjAmList(kodCariVot As String) As DataTable
        Dim db = New DBKewConn
        'Dim query As String = "SELECT DISTINCT A.Kod_Vot as value,concat(A.Kod_Vot,' - ',B.Butiran) as text
        '                        FROM SMKB_COA_Master A
        '                        INNER JOIN SMKB_Vot B ON A.Kod_Vot=B.Kod_Vot WHERE  B.Kod_Klasifikasi = 'H2' and Kod_PTJ = @kodPTJ AND A.Status = @status AND B.Status =@status "

        'Dim query As String = "SELECT DISTINCT B.Kod_Vot as value,concat(B.Kod_Vot,' - ',B.Butiran) as text
        '    FROM SMKB_COA_Master A
        '    INNER JOIN SMKB_Vot B ON CONCAT(LEFT(A.Kod_Vot,2),'000') = B.Kod_Vot WHERE  B.Kod_Klasifikasi = 'H2' and Kod_PTJ = @kodPTJ AND A.Status = @status AND B.Status = @status"

        Dim query As String = "select Kod_Vot as value, CONCAT(Kod_Vot ,' - ',Butiran ) as text from SMKB_Vot where Kod_Klasifikasi ='H2' AND lEFT(Kod_Vot,1) BETWEEN 1 AND 4 
        AND Status = @status  "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        'param.Add(New SqlParameter("@kodPTJ", Session("ssusrKodPTj")))

        If kodCariVot <> "" Then
            query &= "AND (Kod_Vot LIKE '%' + @kod + '%' OR Butiran LIKE '%' + @kodButir) ORDER BY Kod_Vot"

            param.Add(New SqlParameter("@kod", kodCariVot))
            param.Add(New SqlParameter("@kodButir", kodCariVot))

        Else
            query &= " ORDER BY Kod_Vot"

        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListPTJPusat(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiPTJ_Pusat(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiPTJ_Pusat(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT a.Kod_PTJ AS value ,b.Pejabat, b.Pejabat AS text 
                                FROM SMKB_PTJ_Pusat a , VPejabat b
                                Where a.Kod_PTJ = concat(b.KodPejabat,'0000')
                                and a.Status_Pusat = @status  
                                union 
                                Select '000000' as value, 'TIADA' as Pejabat, 'TIADA' as text"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " AND (a.Kod_PTJ LIKE '%' + @kod + '%' OR b.Pejabat LIKE '%' + @kod) ORDER BY A.Kod_PTJ"
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kod", kod))



        Return db.Read(query, param)
    End Function

    Public Class StaffROC
        Public Property NoMohon As String
        Public Property SenaraiPenyokong As String

    End Class

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HantarPermohonan(data As List(Of StaffROC))
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim counter As Integer = 0
        Dim sqlComm As New SqlCommand
        Dim cmd = New SqlCommand
        Dim dt As New DataTable
        Dim problem As String = ""
        Dim db = New DBKewConn
        Dim thngj As String = ""
        Dim blngj As String = ""

        While counter < data.Count

            If UpdateHantar(data(counter).NoMohon, data(counter).SenaraiPenyokong) = "OK" Then
                success += 1

                If InsertStatusDokOrder(data(counter).NoMohon, "Y", "02") <> "OK" Then

                    'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    ' Exit Function

                End If

            End If

            counter += 1
        End While

        If success = 1 Then
            resp.Success("Rekod berjaya dihantar untuk sokongan", "00", data)
        ElseIf success = 2 Then
            resp.Success("Rekod berjaya dihantar untuk sokongan" & problem)
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
        'Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function UpdateHantar(NoMohon As String, SenPenyokong As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr set Status_Dok = @Status_Dok , ID_Staf_KB = @ID_Staf_KB where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Status_Dok", "02"))
        param.Add(New SqlParameter("@ID_Staf_KB", SenPenyokong))
        param.Add(New SqlParameter("@No_Mohon", NoMohon))

        'Return db.Process(query, param)
        Return RbQueryCmd("No_Mohon", NoMohon, query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisKW(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetJenKW(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetJenKW(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Kump_Wang as value, Replace(Butiran,'KUMPULAN WANG ','') as text FROM SMKB_Kump_Wang WHERE Status = 1 AND Kod_Kump_Wang IN ('01','07')"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            'query &= " AND (Kod_Trans='A'or Kod_Trans='L') and Butiran like 'PELARASAN%'  and (Kod_Trans LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%')"
            query &= " AND (Kod_Kump_Wang LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%')"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrH1(ByVal tahun As String, ByVal kw As String, ByVal ko As String, ByVal kp As String, ByVal ptj As String, ByVal votam As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrH1(tahun, kw, ko, kp, ptj, votam)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrH1(tahun As String, kw As String, ko As String, kp As String, ptj As String, votam As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY B.Kod_Vot_Sbg) AS RowCountBil,
                                B.Kod_Vot_Sbg,
                                (select Butiran from SMKB_Vot where SMKB_Vot.Kod_Vot = b.Kod_Vot_Sbg) as ButiranSbg,
                                SUM(B.Jumlah_Kew) AS Jumlah
                                FROM SMKB_Agihan_Bajet_Hdr AS a
                                INNER JOIN SMKB_Agihan_Bajet_Dtl AS b ON a.No_Mohon = b.No_Mohon
                                WHERE Tahun_Bajet = @Tahun_Bajet
                                AND a.Kod_Kump_Wang = @Kod_Kump_Wang
                                AND a.Kod_Operasi = @Kod_Operasi
                                AND a.Kod_Projek = @Kod_Projek
                                AND Kod_Bahagian = @Kod_Bahagian
                                AND b.Kod_Vot_Am = @Kod_Vot_Am
                                AND a.Flag_Kew = 1
                                AND b.Flag_Kew = 1 
                                GROUP BY B.Kod_Vot_Sbg;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Tahun_Bajet", tahun))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_Operasi", ko))
        param.Add(New SqlParameter("@Kod_Projek", kp))
        param.Add(New SqlParameter("@Kod_Bahagian", ptj))
        param.Add(New SqlParameter("@Kod_Vot_Am", votam))

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrH1_Bendahari_new(ByVal tahun As String, ByVal kw As String, ByVal ko As String, ByVal kp As String, ByVal ptj As String, ByVal votam As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrH1_Bendahari_new(tahun, kw, ko, kp, ptj, votam)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrH1_Bendahari_new(tahun As String, kw As String, ko As String, kp As String, ptj As String, votam As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY B.Kod_Vot_Sbg) AS RowCountBil,
                                B.Kod_Vot_Sbg,
                                (select Butiran from SMKB_Vot where SMKB_Vot.Kod_Vot = b.Kod_Vot_Sbg) as ButiranSbg,
                                SUM(B.Jumlah_Kew) AS Jumlah
                                FROM SMKB_Agihan_Bajet_Hdr AS a
                                INNER JOIN SMKB_Agihan_Bajet_Dtl AS b ON a.No_Mohon = b.No_Mohon
                                WHERE Tahun_Bajet = @Tahun_Bajet
                                AND a.Kod_Kump_Wang = @Kod_Kump_Wang
                                AND a.Kod_Operasi = @Kod_Operasi
                                AND a.Kod_Projek = @Kod_Projek
                                AND Kod_PTJ = @Kod_Bahagian
                                AND b.Kod_Vot_Am = @Kod_Vot_Am
                                AND a.Flag_Kew = 1
                                AND b.Flag_Kew = 1 
                                GROUP BY B.Kod_Vot_Sbg;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Tahun_Bajet", tahun))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_Operasi", ko))
        param.Add(New SqlParameter("@Kod_Projek", kp))
        param.Add(New SqlParameter("@Kod_Bahagian", ptj))
        param.Add(New SqlParameter("@Kod_Vot_Am", votam))

        Return db.Read(query, param)
    End Function

    '<WebMethod()>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function Baca_ObjekAm(ByVal tahun As String, ByVal kw As String, ByVal ko As String, ByVal kp As String, ByVal ptj As String, ByVal votam As String) As String
    '    Dim resp As New ResponseRepository

    '    dt = Get_Baca_ObjekAm(tahun, kw, ko, kp, ptj, votam)
    '    resp.SuccessPayload(dt)

    '    Return JsonConvert.SerializeObject(resp.GetResult())
    'End Function

    'Private Function Get_Baca_ObjekAm(tahun As String, kw As String, ko As String, kp As String, ptj As String, votam As String) As DataTable
    '    Dim db = New DBKewConn

    '    Dim query As String = "SELECT 
    '                          ,[JumlahBendahari]

    '                      FROM [DbKewanganV4].[dbo].[SMKB_BG_JumlahBajetAm]
    '                      WHERE BG20_TahunBajet = '2025'
    '                        AND KodPtj = @Kod_Bahagian
    '                        AND KodKW = @Kod_Kump_Wang
    '                        AND KodOperasi = @Kod_Operasi
    '                        AND KodVotAm =@Kod_Vot_Am"

    '    Dim param As New List(Of SqlParameter)
    '    param.Add(New SqlParameter("@Tahun_Bajet", tahun))
    '    param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
    '    param.Add(New SqlParameter("@Kod_Operasi", ko))
    '    param.Add(New SqlParameter("@Kod_Projek", kp))
    '    param.Add(New SqlParameter("@Kod_Bahagian", ptj))
    '    param.Add(New SqlParameter("@Kod_Vot_Am", votam))

    '    Return db.Read(query, param)
    'End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Baca_ObjekAm(ByVal tahun As String, ByVal kw As String, ByVal ko As String, ByVal kp As String, ByVal ptj As String, ByVal votam As String)
        Dim db As New DBKewConn

        Dim query As String = "SELECT 
                              [JumlahBendahari]
                              
                          FROM [SMKB_BG_JumlahBajetAm]
                          WHERE BG20_TahunBajet = '2025'
                            AND KodPtj = @Kod_Bahagian
                            AND KodKW = @Kod_Kump_Wang
                            AND KodOperasi = @Kod_Operasi
                            AND KodVotAm =@Kod_Vot_Am"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Tahun_Bajet", tahun))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_Operasi", ko))
        param.Add(New SqlParameter("@Kod_Projek", kp))
        param.Add(New SqlParameter("@Kod_Bahagian", ptj))
        param.Add(New SqlParameter("@Kod_Vot_Am", votam))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrH1_Bendahari(ByVal tahun As String, ByVal kw As String, ByVal ko As String, ByVal kp As String, ByVal ptj As String, ByVal votam As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrH1_Bendahari(tahun, kw, ko, kp, ptj, votam)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrH1_Bendahari(tahun As String, kw As String, ko As String, kp As String, ptj As String, votam As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY B.Kod_Vot_Sbg) AS RowCountBil,
                                B.Kod_Vot_Sbg,
                                (select Butiran from SMKB_Vot where SMKB_Vot.Kod_Vot = b.Kod_Vot_Sbg) as ButiranSbg,
                                SUM(B.Jumlah_KetuaPTJ) AS Jumlah
                                FROM SMKB_Agihan_Bajet_Hdr AS a
                                INNER JOIN SMKB_Agihan_Bajet_Dtl AS b ON a.No_Mohon = b.No_Mohon
                                WHERE Tahun_Bajet = @Tahun_Bajet
                                AND a.Kod_Kump_Wang = @Kod_Kump_Wang
                                AND a.Kod_Operasi = @Kod_Operasi
                                AND a.Kod_Projek = @Kod_Projek
                                AND Kod_PTJ = @Kod_PTJ
                                AND b.Kod_Vot_Am = @Kod_Vot_Am
                                AND a.Status_Dok = '03'
                                AND a.Flag_KetuaPTJ = 1
                                AND b.Flag_KetuaPTJ = 1 
                                GROUP BY B.Kod_Vot_Sbg;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Tahun_Bajet", tahun))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_Operasi", ko))
        param.Add(New SqlParameter("@Kod_Projek", kp))
        param.Add(New SqlParameter("@Kod_PTJ", ptj))
        param.Add(New SqlParameter("@Kod_Vot_Am", votam))

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrH2(ByVal tahun As String, ByVal kw As String, ByVal ko As String, ByVal kp As String, ByVal ptj As String, ByVal votam As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrH2(tahun, kw, ko, kp, ptj, votam)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrH2(tahun As String, kw As String, ko As String, kp As String, ptj As String, votam As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY B.Kod_Vot_Sbg) AS RowCountBil,
                                B.Kod_Vot_Sbg, a.No_Mohon,
                                a.Program , b.Butiran ,SUM(B.Jumlah_Kew) as Jumlah
                                FROM SMKB_Agihan_Bajet_Hdr AS a
                                INNER JOIN SMKB_Agihan_Bajet_Dtl AS b ON a.No_Mohon = b.No_Mohon
                                WHERE Tahun_Bajet = @Tahun_Bajet
                                AND a.Kod_Kump_Wang = @Kod_Kump_Wang
                                AND a.Kod_Operasi = @Kod_Operasi
                                AND a.Kod_Projek = @Kod_Projek
                                AND Kod_Bahagian = @Kod_Bahagian
                                AND b.Kod_Vot_Sbg = @Kod_Vot_Am
                                AND a.Flag_KB = @Status
                                AND b.Flag_KB = @Status 
                                 GROUP BY B.Kod_Vot_Sbg , a.No_Mohon, Program , Butiran ,  b.Jumlah_Kew"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@Tahun_Bajet", tahun))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_Operasi", ko))
        param.Add(New SqlParameter("@Kod_Projek", kp))
        param.Add(New SqlParameter("@Kod_Bahagian", ptj))
        param.Add(New SqlParameter("@Kod_Vot_Am", votam))

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrH2_Bend_New(ByVal tahun As String, ByVal kw As String, ByVal ko As String, ByVal kp As String, ByVal ptj As String, ByVal votam As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrH2_bend_new(tahun, kw, ko, kp, ptj, votam)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrH2_bend_new(tahun As String, kw As String, ko As String, kp As String, ptj As String, votam As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY B.Kod_Vot_Sbg) AS RowCountBil,
                                B.Kod_Vot_Sbg, a.No_Mohon,
                                a.Program , b.Butiran ,SUM(B.Jumlah_Kew) as Jumlah
                                FROM SMKB_Agihan_Bajet_Hdr AS a
                                INNER JOIN SMKB_Agihan_Bajet_Dtl AS b ON a.No_Mohon = b.No_Mohon
                                WHERE Tahun_Bajet = @Tahun_Bajet
                                AND a.Kod_Kump_Wang = @Kod_Kump_Wang
                                AND a.Kod_Operasi = @Kod_Operasi
                                AND a.Kod_Projek = @Kod_Projek
                                AND Kod_PTJ = @Kod_Bahagian
                                AND b.Kod_Vot_Sbg = @Kod_Vot_Am
                                AND a.Flag_KB = @Status
                                AND b.Flag_KB = @Status 
                                 GROUP BY B.Kod_Vot_Sbg , a.No_Mohon, Program , Butiran ,  b.Jumlah_Kew"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@Tahun_Bajet", tahun))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_Operasi", ko))
        param.Add(New SqlParameter("@Kod_Projek", kp))
        param.Add(New SqlParameter("@Kod_Bahagian", ptj))
        param.Add(New SqlParameter("@Kod_Vot_Am", votam))

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrH2_Bendahari(ByVal tahun As String, ByVal kw As String, ByVal ko As String, ByVal kp As String, ByVal ptj As String, ByVal votam As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrH2_Bendahari(tahun, kw, ko, kp, ptj, votam)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrH2_Bendahari(tahun As String, kw As String, ko As String, kp As String, ptj As String, votam As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = " SELECT 
                                ROW_NUMBER() OVER (ORDER BY B.Kod_Vot_Sbg) AS RowCountBil,
                                B.Kod_Vot_Sbg, a.No_Mohon,
                                a.Program , b.Butiran , b.Jumlah_KetuaPTJ as Jumlah
                                FROM SMKB_Agihan_Bajet_Hdr AS a
                                INNER JOIN SMKB_Agihan_Bajet_Dtl AS b ON a.No_Mohon = b.No_Mohon
                                WHERE Tahun_Bajet = @Tahun_Bajet
                                AND a.Kod_Kump_Wang = @Kod_Kump_Wang
                                AND a.Kod_Operasi = @Kod_Operasi
                                AND a.Kod_Projek = @Kod_Projek
                                AND A.Kod_PTJ = @Kod_Bahagian
                                AND b.Kod_Vot_Sbg = @Kod_Vot_Am
                                AND a.Status_Dok = '03'
                                AND a.Flag_KetuaPTJ = @Status
                                AND b.Flag_KetuaPTJ = @Status 
                               GROUP BY B.Kod_Vot_Sbg , a.No_Mohon, Program , Butiran , b.Jumlah_KetuaPTJ;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@Tahun_Bajet", tahun))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_Operasi", ko))
        param.Add(New SqlParameter("@Kod_Projek", kp))
        param.Add(New SqlParameter("@Kod_Bahagian", ptj))
        param.Add(New SqlParameter("@Kod_Vot_Am", votam))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadKW(KodKW As String)
        Dim db As New DBKewConn

        Dim query As String = "select concat(Kod_Kump_Wang,' - ', Butiran) as Butiran , Kod_Kump_Wang as KodKW , Butiran as NamaKW from SMKB_Kump_Wang where Kod_Kump_Wang = @KodKw and Status = @Status"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@KodKw", KodKW))
        param.Add(New SqlParameter("@Status", "1"))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSbg(kodSbg As String)
        Dim db As New DBKewConn

        Dim query As String = "select Butiran from smkb_vot where Kod_Klasifikasi ='H2' and Status = @Status and Kod_Vot = @Kod_Vot "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Vot", kodSbg))
        param.Add(New SqlParameter("@Status", "1"))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function



    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBahagian(Kod_Bahagian As String) As String
        Dim resp As New ResponseRepository

        dt = GetBahagian(Kod_Bahagian)
        resp.SuccessPayload(dt)

        'Return JsonConvert.SerializeObject(resp.GetResult())
        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetBahagian(Kod_Bahagian As String) As DataTable
        Dim db = New DBEQConn

        Dim query As String = "select UPPER(dept_name) as Nama from live_dept where status = @status and dept_kod = @dept"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@dept", Kod_Bahagian))
        param.Add(New SqlParameter("@Status", "1"))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadKO(KodKO As String)
        Dim db As New DBKewConn

        ' Use parameterized query to avoid SQL injection
        Dim query As String = "SELECT CONCAT(Kod_Operasi, ' - ', Butiran) AS Butiran , Kod_Operasi as KodKo , Butiran as NamaKo FROM SMKB_Operasi WHERE Kod_Operasi = @KodKO AND Status = @Status"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@KodKO", KodKO))
        param.Add(New SqlParameter("@Status", "1"))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadKP(KodKP As String)
        Dim db As New DBKewConn

        ' Use parameterized query to avoid SQL injection
        Dim query As String = "SELECT CONCAT(Kod_Projek, ' - ', Butiran) AS Butiran , Kod_Projek as KodKp , Butiran as NamaKp FROM SMKB_Projek WHERE Kod_Projek = @KodKP AND Status = @Status"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@KodKP", KodKP))
        param.Add(New SqlParameter("@Status", "1"))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDasar(KodDasar As String)
        Dim db As New DBKewConn

        ' Use parameterized query to avoid SQL injection
        Dim query As String = "SELECT CONCAT(Kod_Dasar, ' - ', Butiran) AS Butiran , Kod_Dasar as KodDasar , Butiran as NamaDasar FROM SMKB_Dasar WHERE Kod_Dasar = @Kod_Dasar AND Status = @Status"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Dasar", KodDasar))
        param.Add(New SqlParameter("@Status", "1"))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPTJ_Pusat(Kod As String)
        Dim db As New DBKewConn

        ' Use parameterized query to avoid SQL injection
        Dim query As String = "SELECT a.Kod_PTJ AS value ,b.Pejabat, b.Pejabat AS text 
                                FROM SMKB_PTJ_Pusat a , VPejabat b
                                Where a.Kod_PTJ = concat(b.KodPejabat,'0000')
                                and a.Status_Pusat = @status  and a.Kod_PTJ = @kod
                                union 
                                Select '000000' as value, 'TIADA' as Pejabat, 'TIADA' as text "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", Kod))
        param.Add(New SqlParameter("@status", "1"))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)

    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmd(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        Return If(queryRB.execute(idValue, idKey, cmd) < 0, "X", "OK")
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmdMulti(idKey As Dictionary(Of String, String), strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        Dim key As New Dictionary(Of String, String)

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        Return If(queryRB.execute(idKey, cmd) < 0, "X", "OK")
    End Function


End Class