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


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class TambahKurangWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable


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
        Dim db As New DBEQConn
        Dim query As String = "select dept_kod as value, UPPER(dept_name) as text from live_dept where status = @status and mkod = @ptj"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (dept_kod LIKE '%' + @kod + '%' or dept_name LIKE '%' + @kod2 + '%') "
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@ptj", Left(Session("ssusrKodPTj"), 2)))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListUnit(category As String, kod As String) As String

        Dim tmpDT As DataTable = GetSenaraiUnit(category, kod)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiUnit(category As String, kod As String) As DataTable
        Dim db As New DBEQConn
        Dim query As String = "select unit_kod as value, unit_name as text from live_unit where status = @status"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (unit_kod LIKE '%' + @kod + '%' or unit_name LIKE '%' + @kod2 + '%') "
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))

        If category <> "" Then
            query &= " AND dept_kod = @category"
            param.Add(New SqlParameter("@category", category))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListKW(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiKW(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiKW(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT distinct a.Kod_Kump_Wang as value, b.Butiran as text FROM SMKB_COA_Master as a , SMKB_Kump_Wang as b
                                where a.Kod_Kump_Wang = b.Kod_Kump_Wang and  Kod_PTJ = @ptj and a.Status = @status "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (a.Kod_Kump_Wang LIKE '%' + @kod + '%' or b.Butiran LIKE '%' + @kod2 + '%') order by a.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
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
                            and RIGHT(MS02_GredGajiS,2) >= @ptj                           
                            and b.MS08_Pejabat = @ptj
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
        Dim query As String = "SELECT distinct a.Kod_Operasi as value, b.Butiran as text FROM SMKB_COA_Master as a , SMKB_Operasi as b
                                where a.Kod_Operasi = b.Kod_Operasi  and  Kod_PTJ = @ptj and a.Status = @status "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (a.Kod_Operasi LIKE '%' + @kod + '%' or b.Butiran LIKE '%' + @kod2 + '%') order by a.Kod_Operasi"
        End If

        param.Add(New SqlParameter("@status", "1"))
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
        Dim query As String = "SELECT distinct a.Kod_Projek as value, b.Butiran as text FROM SMKB_COA_Master as a , SMKB_Projek as b
                                where a.Kod_Projek = b.Kod_Projek  and  Kod_PTJ = @ptj and a.Status = @status "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (a.Kod_Projek LIKE '%' + @kod + '%' or b.Butiran LIKE '%' + @kod2 + '%') order by a.Kod_Projek"
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
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

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListPeruntukan(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiPeruntukan(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiPeruntukan(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Peruntukan as value, Butiran as text FROM SMKB_Kategori_Peruntukan Where Status = @status  "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (Kod_Peruntukan LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
        End If

        param.Add(New SqlParameter("@status", "1"))
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
    Public Function SaveOrders_TK(order As order_TK) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.OrderID = "" Then 'untuk permohonan baru
            order.OrderID = GenerateOrderID()
            If InsertNewOrder(order.OrderID, order.Tahun, order.Butiran, order.Amaun, order.Dasar, order.KW, order.KO, order.KP, order.Ptj, order.Vot, order.KategoriAgih) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function

            End If
            If InsertNewOrderDtl(order.OrderID, order.Butiran, order.Amaun, order.Vot, order.KategoriAgih) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If


            success = 1
        Else
            If Update_Order(order.OrderID, order.Tahun, order.Butiran, order.Amaun, order.Dasar, order.KW, order.KO, order.KP, order.Ptj, order.Vot, order.KategoriAgih) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function

            End If
            If Update_OrderDtl(order.OrderID, order.Butiran, order.Amaun, order.Vot, order.KategoriAgih) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
            success = 1
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


    Private Function InsertNewOrder(orderid As string, Tahun  As string, Butiran  As string, Amaun  As string, Dasar  As string, KW  As string, KO  As string, KP  As string, Ptj  As string, Vot  As string, KategoriAgih As String) 
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Agihan_Bajet_Hdr (Kod_Korporat, No_Mohon, Kod_Kump_Wang, Kod_Operasi , Justifikasi, Kod_Projek, Kod_PTJ, Tahun_Bajet, Kod_Dasar, 
                            Jumlah_Mohon , Tkh_Mohon , 
                            Jumlah_Pengesah, Flag_Pengesah ,
                            Jumlah_Bendahari , Flag_Bendahari ,
                            Created_Date , Created_By , Kod_Agih, Status_Dok)
                            VALUES(@Kod_Korporat, @No_Mohon, @Kod_Kump_Wang, @Kod_Operasi , @Justifikasi, @Kod_Projek, @Kod_PTJ, @Tahun_Bajet, @Kod_Dasar, 
                            @Jumlah_Mohon , GETDATE() , 
                            @Jumlah_Pengesah, @Flag_Pengesah ,
                            @Jumlah_Bendahari , @Flag_Bendahari ,
                            GETDATE() , @Created_By , @Kod_Agih, @Status_Dok)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Korporat", "UTeM"))
        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@Kod_Kump_Wang", Left(KW, 2)))
        param.Add(New SqlParameter("@Kod_Operasi", Left(KO, 2)))
        param.Add(New SqlParameter("@Justifikasi", Butiran))
        param.Add(New SqlParameter("@Kod_Projek", Left(KP, 7)))
        param.Add(New SqlParameter("@Kod_PTJ", Left(Ptj, 6)))
        param.Add(New SqlParameter("@Tahun_Bajet", Tahun))
        param.Add(New SqlParameter("@Kod_Dasar", Left(Dasar, 3)))
        param.Add(New SqlParameter("@Jumlah_Mohon", Amaun))
        param.Add(New SqlParameter("@Jumlah_Pengesah", Amaun))
        param.Add(New SqlParameter("@Flag_Pengesah", 1))
        param.Add(New SqlParameter("@Jumlah_Bendahari", Amaun))
        param.Add(New SqlParameter("@Flag_Bendahari", 1))
        param.Add(New SqlParameter("@Created_By", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Agih", KategoriAgih))
        param.Add(New SqlParameter("@Status_Dok", "01"))

        Return db.Process(query, param)
    End Function

    Private Function InsertNewOrderDtl(orderid As String, Butiran As String, Amaun As String, Vot As String, KategoriAgih As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Agihan_Bajet_Dtl (No_Mohon, Kod_Vot_Am, Kod_Vot_Sbg, Butiran , Jumlah_Mohon ,  Created_Date, Created_By , Kod_Agih,
                                Jumlah_Pengesah, Flag_Pengesah, 
                                Jumlah_Bendahari , Flag_Bendahari)
                                VALUES(@No_Mohon, @Kod_Vot_Am, @Kod_Vot_Sbg, @Butiran , @Jumlah_Mohon ,  GETDATE(), @Created_By , @Kod_Agih,
                                @Jumlah_Pengesah, @Flag_Pengesah, 
                                @Jumlah_Bendahari , @Flag_Bendahari)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@Kod_Vot_Am", Left(Vot, 1) + "0000"))
        param.Add(New SqlParameter("@Kod_Vot_Sbg", Left(Vot, 5)))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@Jumlah_Mohon", Amaun))
        param.Add(New SqlParameter("@Created_By", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Agih", KategoriAgih))
        param.Add(New SqlParameter("@Jumlah_Pengesah", Amaun))
        param.Add(New SqlParameter("@Flag_Pengesah", 1))
        param.Add(New SqlParameter("@Jumlah_Bendahari", Amaun))
        param.Add(New SqlParameter("@Flag_Bendahari", 1))
        Return db.Process(query, param)
    End Function

    Private Function Update_Order(orderid As String, Tahun As String, Butiran As String, Amaun As String, Dasar As String, KW As String, KO As String, KP As String, Ptj As String, Vot As String, KategoriAgih As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr 
                                SET Kod_Korporat = @Kod_Korporat, 
                                    Kod_Kump_Wang = @Kod_Kump_Wang, 
                                    Kod_Operasi = @Kod_Operasi, 
                                    Justifikasi = @Justifikasi, 
                                    Kod_Projek = @Kod_Projek, 
                                    Kod_PTJ = @Kod_PTJ, 
                                    Tahun_Bajet = @Tahun_Bajet, 
                                    Kod_Dasar = @Kod_Dasar, 
                                    Jumlah_Mohon = @Jumlah_Mohon, 
                                    Tkh_Mohon = GETDATE(), 
                                    Jumlah_Pengesah = @Jumlah_Pengesah, 
                                    Flag_Pengesah = @Flag_Pengesah, 
                                    Jumlah_Bendahari = @Jumlah_Bendahari, 
                                    Flag_Bendahari = @Flag_Bendahari, 
                                    Created_Date = GETDATE(), 
                                    Created_By = @Created_By, 
                                    Kod_Agih = @Kod_Agih, 
                                    Status_Dok = @Status_Dok 
                                WHERE No_Mohon = @No_Mohon;
"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Korporat", "UTeM"))
        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@Kod_Kump_Wang", Left(KW, 2)))
        param.Add(New SqlParameter("@Kod_Operasi", Left(KO, 2)))
        param.Add(New SqlParameter("@Justifikasi", Butiran))
        param.Add(New SqlParameter("@Kod_Projek", Left(KP, 7)))
        param.Add(New SqlParameter("@Kod_PTJ", Left(Ptj, 6)))
        param.Add(New SqlParameter("@Tahun_Bajet", Tahun))
        param.Add(New SqlParameter("@Kod_Dasar", Left(Dasar, 3)))
        param.Add(New SqlParameter("@Jumlah_Mohon", Amaun))
        param.Add(New SqlParameter("@Jumlah_Pengesah", Amaun))
        param.Add(New SqlParameter("@Flag_Pengesah", 1))
        param.Add(New SqlParameter("@Jumlah_Bendahari", Amaun))
        param.Add(New SqlParameter("@Flag_Bendahari", 1))
        param.Add(New SqlParameter("@Created_By", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Agih", KategoriAgih))
        param.Add(New SqlParameter("@Status_Dok", "01"))

        Return db.Process(query, param)
    End Function

    Private Function Update_OrderDtl(orderid As String, Butiran As String, Amaun As String, Vot As String, KategoriAgih As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Dtl 
                                SET Kod_Vot_Am = @Kod_Vot_Am, 
                                    Kod_Vot_Sbg = @Kod_Vot_Sbg, 
                                    Butiran = @Butiran, 
                                    Jumlah_Mohon = @Jumlah_Mohon, 
                                    Created_Date = GETDATE(), 
                                    Created_By = @Created_By, 
                                    Jumlah_Pengesah = @Jumlah_Pengesah, 
                                    Flag_Pengesah = @Flag_Pengesah, 
                                    Jumlah_Bendahari = @Jumlah_Bendahari, 
                                    Flag_Bendahari = @Flag_Bendahari 
                                WHERE No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", orderid))
        param.Add(New SqlParameter("@Kod_Vot_Am", Left(Vot, 1) + "0000"))
        param.Add(New SqlParameter("@Kod_Vot_Sbg", Left(Vot, 5)))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@Jumlah_Mohon", Amaun))
        param.Add(New SqlParameter("@Created_By", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Agih", KategoriAgih))
        param.Add(New SqlParameter("@Jumlah_Pengesah", Amaun))
        param.Add(New SqlParameter("@Flag_Pengesah", 1))
        param.Add(New SqlParameter("@Jumlah_Bendahari", Amaun))
        param.Add(New SqlParameter("@Flag_Bendahari", 1))
        Return db.Process(query, param)
    End Function



    Private Function InsertNewOrderDtl_K(orderid As String, Kod_Kump_Wang As String, Kod_Operasi As String, Kod_Projek As String, Kod_PTJ As String, Kod_Vot As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_BG_ViremenDtl (No_Viremen , Kod_Kump_Wang , Kod_Operasi , Kod_Projek, Kod_PTJ , Kod_Vot , Kod_Vir)
                              VALUES(@No_Viremen , @Kod_Kump_Wang , @Kod_Operasi , @Kod_Projek, @Kod_PTJ , @Kod_Vot , @Kod_Vir)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Viremen", orderid))
        param.Add(New SqlParameter("@Kod_Kump_Wang", Left(Kod_Kump_Wang, 2)))
        param.Add(New SqlParameter("@Kod_Operasi", Left(Kod_Operasi, 2)))
        param.Add(New SqlParameter("@Kod_Projek", Left(Kod_Projek, 7)))
        param.Add(New SqlParameter("@Kod_PTJ", Left(Kod_PTJ, 6)))
        param.Add(New SqlParameter("@Kod_Vot", Left(Kod_Vot, 5)))
        param.Add(New SqlParameter("@Kod_Vir", "K"))

        Return db.Process(query, param)
    End Function

    Private Function InsertNewOrderDtl_M(orderid As String, Kod_Kump_Wang As String, Kod_Operasi As String, Kod_Projek As String, Kod_PTJ As String, Kod_Vot As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_BG_ViremenDtl (No_Viremen , Kod_Kump_Wang , Kod_Operasi , Kod_Projek, Kod_PTJ , Kod_Vot , Kod_Vir)
                              VALUES(@No_Viremen , @Kod_Kump_Wang , @Kod_Operasi , @Kod_Projek, @Kod_PTJ , @Kod_Vot , @Kod_Vir)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Viremen", orderid))
        param.Add(New SqlParameter("@Kod_Kump_Wang", Left(Kod_Kump_Wang, 2)))
        param.Add(New SqlParameter("@Kod_Operasi", Left(Kod_Operasi, 2)))
        param.Add(New SqlParameter("@Kod_Projek", Left(Kod_Projek, 7)))
        param.Add(New SqlParameter("@Kod_PTJ", Left(Kod_PTJ, 6)))
        param.Add(New SqlParameter("@Kod_Vot", Left(Kod_Vot, 5)))
        param.Add(New SqlParameter("@Kod_Vir", "M"))

        Return db.Process(query, param)
    End Function


    Private Function InsertOrderDetail(orderDetail_Bajet As orderDetail_Bajet)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Agihan_Bajet_Dtl (No_Item, No_Mohon, Kod_Vot_Am , Kod_Vot_Sbg, Butiran , Jumlah_Mohon, Jumlah_KB , Jumlah_Kew, Jumlah_KetuaPTJ , Jumlah_Bendahari , Jumlah_NC, Created_By, Created_Date , Kod_Agih)
        VALUES(@No_Item , @No_Mohon, @Kod_Vot_Am , @Kod_Vot_Sbg, @Butiran, @Jumlah_Mohon , @Jumlah_Mohon, @Jumlah_Mohon, @Jumlah_Mohon, @Jumlah_Mohon, @Jumlah_Mohon, @CreatedBy, @Created_Date , @Kod_Agih)"
        Dim param As New List(Of SqlParameter)

        Dim votAm As String = Left(orderDetail_Bajet.ddlObjAm, 1) + "0000"

        param.Add(New SqlParameter("@No_Item", orderDetail_Bajet.id))
        param.Add(New SqlParameter("@No_Mohon", orderDetail_Bajet.OrderID))
        param.Add(New SqlParameter("@Kod_Vot_Am", votAm))
        param.Add(New SqlParameter("@Kod_Vot_Sbg", orderDetail_Bajet.ddlObjAm))
        param.Add(New SqlParameter("@Butiran", orderDetail_Bajet.Butiran))
        param.Add(New SqlParameter("@Jumlah_Mohon", orderDetail_Bajet.Jumlah))
        param.Add(New SqlParameter("@Created_Date", orderDetail_Bajet.Tarikh))
        param.Add(New SqlParameter("@CreatedBy", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_Agih", "AL"))

        Return db.Process(query, param)
    End Function

    Private Function DeleteOrderHdr(orderid As String, norujukan As String, perihal As String, tarikh As String, jenistransaksi As String, jumlahBesar As Decimal)
        Dim db As New DBKewConn
        Dim query As String = "DELETE FROM SMKB_Jurnal_Hdr WHERE No_Jurnal=@No_Jurnal "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Jurnal", orderid))

        Return db.Process(query, param)
    End Function

    Private Function DeleteOrderDtl(orderid As String)
        Dim db As New DBKewConn
        Dim query As String = "DELETE FROM SMKB_Jurnal_Dtl WHERE No_Jurnal=@No_Jurnal AND Status = 1"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Jurnal", orderid))

        Return db.Process(query, param)
    End Function


    'Private Function UpdateNewOrder(orderid As String, Tarikh As String, PTJ As String, Bahagian As String, Unit As String, PTJ_Pusat As String, Dasar As String, Kump_Wang As String, KodKo As String, KodKP As String, Program As String, Justifikasi As String)
    '    Dim db As New DBKewConn
    '    Dim query As String = "UPDATE SMKB_Jurnal_Hdr SET Jenis_Trans = @JenisTrans , No_Rujukan =@No_Rujukan , Butiran =@Butiran , Jumlah =@Jumlah
    '                           WHERE No_Jurnal=@No_Jurnal AND Status = 1"
    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@No_Jurnal", orderid))
    '    param.Add(New SqlParameter("@No_Rujukan", norujukan))
    '    param.Add(New SqlParameter("@Butiran", perihal))
    '    param.Add(New SqlParameter("@Jumlah", jumlahBesar))
    '    param.Add(New SqlParameter("@JenisTrans", jenistransaksi))

    '    Return db.Process(query, param)
    'End Function

    Private Function UpdateLulusOrder(orderid As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String = "04" 'Kelulusan 1

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

    Private Function UpdateStatusDokOrder_Mohon(orderid As String, statusLulus As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String

        If statusLulus = "Y" Then

            kodstatusLulus = "02"

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

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='01' AND Prefix ='TK' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("01", "TK", year, lastID)
        Else

            InsertNoAkhir("01", "TK", year, lastID)
        End If
        newOrderID = "TK" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

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
        Dim query As String = "SELECT TOP 10 UPPER(a.COA_Index) AS text,
                        a.Kod_Vot AS value ,
                        vot.Butiran AS colhidvot ,
                        mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO , kp.Butiran as colKp , 
                        a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
                        FROM SMKB_COA_Master AS a 
                        JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                        JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                        JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                        JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
                        JOIN VPEJABAT AS mj ON mj.kodpejabat = left(a.Kod_PTJ,2) 
                        WHERE a.status = 1  "

        Dim param As New List(Of SqlParameter)

        ' Check if kodCariVot array has values
        If kodCariVot IsNot Nothing AndAlso kodCariVot.Length > 0 Then

            Dim counter As Integer = 0

            For Each str As String In kodCariVot
                Dim paramName As String = "@str" & counter
                query &= " AND COA_Index LIKE '%' + " & paramName & "+ '%'  "
                counter += 1
                param.Add(New SqlParameter(paramName, str))
            Next

        End If

        Return db.Read(query, param)


    End Function

    'Private Function GetKodCOAList(kodCariVot As String) As DataTable

    '    kodCariVot = Replace(kodCariVot, " ", "%")

    '    Dim db = New DBKewConn
    '    Dim query As String = "SELECT TOP 10 UPPER(a.COA_Index) AS text,
    '                        a.Kod_Vot AS value ,
    '                        vot.Butiran AS colhidvot ,
    '                        mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO ,  kp.Butiran as colKp , 
    '                        a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
    '                        FROM SMKB_COA_Master AS a 
    '                        JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
    '                        JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
    '                        JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
    '                        JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
    '                        JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_PTJ,2) 
    '                        WHERE a.status = 1  and A.Kod_Vot like '%000'"

    '    Dim param As New List(Of SqlParameter)
    '    Dim paramName As String = ""
    '    If kodCariVot <> "" Then

    '        Dim arrString As String() = kodCariVot.Split("%")
    '        Dim counter As Integer = 0

    '        For Each str As String In arrString
    '            paramName = "@str" & counter
    '            query &= " and COA_Index like '%' + " & paramName & "+ '%'  "
    '            counter += 1
    '            param.Add(New SqlParameter(paramName, str))
    '        Next

    '    End If

    '    Return db.Read(query, param)
    'End Function

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
                                where ID_Staf_KB = @userID  and Status_Dok = '03' " & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiTransaksiTK(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String

        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiTK(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiTK(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""


        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND a.Created_Date >= DATEADD(month, -1, getdate()) and a.Created_Date <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND a.Created_Date >= DATEADD(month, -2, getdate()) and a.Created_Date <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND a.Created_Date >= @tkhMula and a.Created_Date <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "select a.No_Mohon, FORMAT (a.Created_Date, 'dd-MM-yyyy') as Tkh_Transaksi ,Justifikasi as Butiran, A.Kod_Kump_Wang AS kw, a.Kod_Operasi as ko, a.Kod_Projek as kp, a.Kod_PTJ as ptj , a.Jumlah_Mohon as Amaun,
        b.Kod_Vot_Sbg as vot, a.Kod_Agih, (select Butiran from SMKB_Kategori_Peruntukan where SMKB_Kategori_Peruntukan.Kod_Peruntukan = a.Kod_Agih and SMKB_Kategori_Peruntukan.Status = 1) AS Butiran_KodAgih
        from SMKB_Agihan_Bajet_Hdr as a , 
        SMKB_Agihan_Bajet_Dtl as B
        where a.No_Mohon = B.No_Mohon  and a.Kod_Agih in ('TB','KG') and  Status_Dok ='01'" & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiTransaksiTK_Bend(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String

        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiTK_Bend(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiTransaksiTK_Sah(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String

        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiTK_Sah(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiTK_Bend(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""


        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND a.Created_Date >= DATEADD(month, -1, getdate()) and a.Created_Date <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND a.Created_Date >= DATEADD(month, -2, getdate()) and a.Created_Date <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND a.Created_Date >= @tkhMula and a.Created_Date <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "select a.No_Mohon, FORMAT (a.Created_Date, 'dd-MM-yyyy') as Tkh_Transaksi ,Justifikasi as Butiran, A.Kod_Kump_Wang AS kw, a.Kod_Operasi as ko, a.Kod_Projek as kp, a.Kod_PTJ as ptj , a.Jumlah_Mohon as Amaun,
        b.Kod_Vot_Sbg as vot, a.Kod_Agih, (select Butiran from SMKB_Kategori_Peruntukan where SMKB_Kategori_Peruntukan.Kod_Peruntukan = a.Kod_Agih and SMKB_Kategori_Peruntukan.Status = 1) AS Butiran_KodAgih
        from SMKB_Agihan_Bajet_Hdr as a , 
        SMKB_Agihan_Bajet_Dtl as B
        where a.No_Mohon = B.No_Mohon  and a.Kod_Agih in ('TB','KG') and  Status_Dok ='03'" & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiTK_Sah(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim param As List(Of SqlParameter)
        Dim tarikhQuery As String = ""


        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " AND CAST(a.Created_Date AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND a.Created_Date >= DATEADD(month, -1, getdate()) and a.Created_Date <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND a.Created_Date >= DATEADD(month, -2, getdate()) and a.Created_Date <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND a.Created_Date >= @tkhMula and a.Created_Date <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "select a.No_Mohon, FORMAT (a.Created_Date, 'dd-MM-yyyy') as Tkh_Transaksi ,Justifikasi as Butiran, A.Kod_Kump_Wang AS kw, a.Kod_Operasi as ko, a.Kod_Projek as kp, a.Kod_PTJ as ptj , a.Jumlah_Mohon as Amaun,
        b.Kod_Vot_Sbg as vot, a.Kod_Agih, (select Butiran from SMKB_Kategori_Peruntukan where SMKB_Kategori_Peruntukan.Kod_Peruntukan = a.Kod_Agih and SMKB_Kategori_Peruntukan.Status = 1) AS Butiran_KodAgih
        from SMKB_Agihan_Bajet_Hdr as a , 
        SMKB_Agihan_Bajet_Dtl as B
        where a.No_Mohon = B.No_Mohon  and a.Kod_Agih in ('TB','KG') and  Status_Dok ='02'" & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiTransaksiViremen_KB(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String

        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiViremen_KB(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiViremen_KB(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        Dim query As String = "select a.No_Viremen, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi ,Tujuan, Amaun, No_Staf, Kod_Status_Dok, Ruj_Surat , 
                               virKeluar.kod_kump_wang as kw_K, virKeluar.kod_operasi as ko_K, virKeluar.kod_projek as kp_K, virKeluar.kod_ptj as ptj_K, virKeluar.kod_vot as vot_K ,
                                virMasuk.kod_kump_wang as kw_M, virMasuk.kod_operasi as ko_M, virMasuk.kod_projek as kp_M, virMasuk.kod_ptj as ptj_M, virMasuk.kod_vot as vot_M
                                from smkb_bg_viremen as a , 
                                smkb_bg_viremendtl as virKeluar,
                                smkb_bg_viremendtl as virMasuk
                                where a.No_viremen = virMasuk.No_Viremen and  a.No_viremen = virKeluar.No_Viremen
                                AND virKeluar.kod_vir ='K'
                                AND virMasuk.kod_vir ='M' and Kod_Status_Dok ='02'
                                AND No_Staf = @userID " & tarikhQuery

        param = New List(Of SqlParameter)
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


        Dim query As String = "SELECT ROW_NUMBER() OVER(ORDER BY S.Kod_Bahagian) AS Bil, S.Kod_Bahagian,  Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi , Kod_Projek , Kod_PTJ , Kod_Vot_Am, 
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
                                SELECT a.Kod_Bahagian , a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ , b.Kod_Vot_Am ,
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
                                FROM SMKB_Agihan_Bajet_Hdr as a , SMKB_Agihan_Bajet_Dtl as b
                                where a.No_Mohon = b.No_Mohon
                                and a.Kod_Kump_Wang = @Kod_Kump_Wang
                                and a.Status_Dok = '03'
                                and a.Flag_Kew = @status
                                and b.Flag_Kew = @status
                                and Kod_PTJ = @Kod_PTJ
                                Group by a.Kod_Bahagian , Kod_Operasi , Kod_Vot_Am , a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ 
                                ) as S
                                Group by Kod_Bahagian , Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi, Kod_Projek , Kod_PTJ , Kod_Vot_Am
                                order by Kod_Bahagian"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))
        param.Add(New SqlParameter("@Kod_PTJ", Session("ssusrKodPTj")))

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


        Dim query As String = "SELECT ROW_NUMBER() OVER(ORDER BY S.Kod_PTJ) AS Bil, Kod_PTJ, Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi , Kod_Projek , Kod_Vot_Am, 
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
                                SELECT a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ , b.Kod_Vot_Am ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '1%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Operasi_10000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '1%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Komited_10000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '2%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Operasi_20000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '2%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Komited_20000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '3%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Operasi_30000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '3%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Komited_30000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '4%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Operasi_40000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '4%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Komited_40000 ,
                                CASE WHEN (A.Kod_Operasi = '01' AND B.Kod_Vot_Am LIKE '5%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Operasi_50000 ,
                                CASE WHEN (A.Kod_Operasi = '02' AND B.Kod_Vot_Am LIKE '5%') THEN SUM(B.Jumlah_KetuaPTJ) END AS Komited_50000 ,
                                CASE WHEN (A.Kod_Operasi = '01') THEN SUM(B.Jumlah_KetuaPTJ) END AS Operasi_All,
                                CASE WHEN (A.Kod_Operasi = '02') THEN SUM(B.Jumlah_KetuaPTJ) END AS Komited_All,
                                SUM(B.Jumlah_KetuaPTJ)  AS Jumlah_Permohonan
                                FROM SMKB_Agihan_Bajet_Hdr as a , SMKB_Agihan_Bajet_Dtl as b
                                where a.No_Mohon = b.No_Mohon
                                and a.Kod_Kump_Wang = @Kod_Kump_Wang
                                and a.Status_Dok = '03'
                                and a.Flag_KetuaPTJ = @status
                                and b.Flag_KetuaPTJ = @status
                                Group by Kod_Operasi , Kod_Vot_Am , a.Tahun_Bajet ,a.Kod_Kump_Wang , a.Kod_Operasi, a.Kod_Projek , a.Kod_PTJ 
                                ) as S
                                Group by Tahun_Bajet , Kod_Kump_Wang , Kod_Operasi, Kod_Projek , Kod_PTJ , Kod_Vot_Am
                                order by Kod_PTJ"

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@Kod_Kump_Wang", kw))

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
    Public Function LoadHdrBajet(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrBajet(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrBajet(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select No_Mohon, FORMAT(Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Transaksi, Kod_PTJ, Kod_Bahagian , Kod_Unit, PTJ_Pusat, Kod_Dasar, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, 
        Program, Justifikasi, Jumlah_Mohon  
        from  SMKB_Agihan_Bajet_Hdr a
        where No_Mohon = @No_Mohon"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrBajet_KB(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrBajet_KB(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrBajet_KB(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select No_Mohon, FORMAT(Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Transaksi, Kod_PTJ, Kod_Bahagian , Kod_Unit, PTJ_Pusat, Kod_Dasar, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, 
        Program, Justifikasi, Jumlah_KB as Jumlah  
        from  SMKB_Agihan_Bajet_Hdr a
        where No_Mohon = @No_Mohon"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", id))

        Return db.Read(query, param)
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


        Dim query As String = $"select YEAR(getdate()) as curDateNow"
        Dim dt As DataTable = db.fSelectCommandDt(query)

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


        Dim query As String = $"select KodPejPBU, Pejabat from MS_Pejabat where KodPejPBU =@kodPTJ and Status = @status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kodPTJ", val))

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
        Dim query As String = "SELECT DISTINCT A.Kod_Vot as value,concat(A.Kod_Vot,' - ',B.Butiran) as text
                                FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Vot B ON A.Kod_Vot=B.Kod_Vot WHERE  B.Kod_Klasifikasi = 'H2' and Kod_PTJ = @kodPTJ AND A.Status = @status AND B.Status =@status "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kodPTJ", Session("ssusrKodPTj")))

        If kodCariVot <> "" Then
            query &= "AND (a.Kod_Vot LIKE '%' + @kod + '%' OR B.Butiran LIKE '%' + @kodButir) ORDER BY A.Kod_Vot"

            param.Add(New SqlParameter("@kod", kodCariVot))
            param.Add(New SqlParameter("@kodButir", kodCariVot))

        Else
            query &= " ORDER BY A.Kod_Vot"

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
        Dim query As String = "SELECT Kod_PTJ AS Value , Kod_PTJ AS text FROM SMKB_PTJ_Pusat Where Status_Pusat = @status "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (kod_PTJ LIKE '%' + @kod + '%') order by Kod_PTJ"
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kod", kod))



        Return db.Read(query, param)
    End Function

    Public Class StaffROC
        Public Property NoMohon As String
        Public Property SenaraiPenyokong As String

    End Class

    <System.Web.Services.WebMethod()>
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
            End If

            counter += 1
        End While

        If success = 1 Then
            resp.Success("Rekod berjaya disimpan")
        ElseIf success = 2 Then
            resp.Success("Rekod berjaya disimpan. " & problem)
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

        param.Add(New SqlParameter("@Status_Dok", "03"))
        param.Add(New SqlParameter("@ID_Staf_KB", SenPenyokong))
        param.Add(New SqlParameter("@No_Mohon", NoMohon))

        Return db.Process(query, param)
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
                                AND a.Status_Dok = '03'
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
                                a.Program , b.Butiran , b.Jumlah_KB as Jumlah
                                FROM SMKB_Agihan_Bajet_Hdr AS a
                                INNER JOIN SMKB_Agihan_Bajet_Dtl AS b ON a.No_Mohon = b.No_Mohon
                                WHERE Tahun_Bajet = @Tahun_Bajet
                                AND a.Kod_Kump_Wang = @Kod_Kump_Wang
                                AND a.Kod_Operasi = @Kod_Operasi
                                AND a.Kod_Projek = @Kod_Projek
                                AND Kod_Bahagian = @Kod_Bahagian
                                AND b.Kod_Vot_Sbg = @Kod_Vot_Am
                                AND a.Status_Dok = '03'
                                AND a.Flag_KB = @Status
                                AND b.Flag_KB = @Status 
                                 GROUP BY B.Kod_Vot_Sbg , a.No_Mohon, Program , Butiran , b.Jumlah_KB;"

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

        Dim query As String = "select concat(Kod_Kump_Wang,' - ', Butiran) as Butiran from SMKB_Kump_Wang where Kod_Kump_Wang = @KodKw and Status = @Status"

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
        Dim query As String = "SELECT CONCAT(Kod_Operasi, ' - ', Butiran) AS Butiran FROM SMKB_Operasi WHERE Kod_Operasi = @KodKO AND Status = @Status"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@KodKO", KodKO))
        param.Add(New SqlParameter("@Status", "1"))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrTK(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrTK(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrTK(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select a.No_Mohon, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi ,Tahun_Bajet, Justifikasi, a.Jumlah_Mohon , 
                                concat(a.Kod_Kump_Wang,' - ',kw.Butiran) as kw, 
                                concat(a.kod_operasi,' - ',ko.Butiran) as ko, 
                                concat(a.Kod_Projek,' - ',kp.Butiran) as kp, 
                                concat(a.kod_ptj,' - ', mj.Pejabat) as ptj, 
                                concat(b.Kod_Vot_Sbg,' - ',vot.Butiran) as vot  ,
                                a.Kod_Dasar as dasar , dasar.Butiran AS dasar_Butir,
                                a.Kod_Agih , Agih.Butiran as Butir_Agih
                                from SMKB_Agihan_Bajet_Hdr as a 
                                JOIN SMKB_Agihan_Bajet_Dtl as b ON A.No_Mohon = b.No_Mohon
                                JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                                JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                                JOIN SMKB_Projek as kp on a.Kod_Projek = kp.Kod_Projek
                                JOIN SMKB_Vot AS vot ON b.Kod_Vot_Sbg = vot.Kod_Vot
                                JOIN SMKB_Dasar AS dasar ON a.Kod_Dasar = dasar.Kod_Dasar
                                JOIN SMKB_Kategori_Peruntukan AS Agih ON a.Kod_Agih = Agih.Kod_Peruntukan
                                JOIN VPejabat AS mj ON  mj.kodpejabat =  Left(a.kod_ptj,2)
                                WHERE a.No_Mohon =@No_Mohon"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", id))

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPTJ()
        Dim db As New DBSMConn


        Dim query As String = $"select KodPejPBU, Pejabat from MS_Pejabat where KodPejPBU =@kodPTJ and Status = @status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@kodPTJ", Session("ssusrKodPTj")))

        Dim dt As DataTable = db.Read(query, param)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HantarPermohonan_MohonTK(order As order_TK) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.OrderID = "" Then 'untuk permohonan baru
            order.OrderID = GenerateOrderID()
            If InsertNewOrder(order.OrderID, order.Tahun, order.Butiran, order.Amaun, order.Dasar, order.KW, order.KO, order.KP, order.Ptj, order.Vot, order.KategoriAgih) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function

            Else


                success = 1

            End If

        Else

            If UpdateHantar_MohonTK(order.OrderID) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
            success = 1
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

    Private Function UpdateHantar_MohonTK(No_Mohon As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr set Status_Dok = @Status_Dok where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Status_Dok", "02"))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))

        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HantarPermohonan_MohonTK_Bend(order As order_TK) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.OrderID = "" Then 'untuk permohonan baru
            order.OrderID = GenerateOrderID()
            If InsertNewOrder(order.OrderID, order.Tahun, order.Butiran, order.Amaun, order.Dasar, order.KW, order.KO, order.KP, order.Ptj, order.Vot, order.KategoriAgih) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function

            Else
                'If InsertNewOrderDtl_K(order.OrderID, order.KW_Drpd, order.KO_Drpd, order.KP_Drpd, order.PTJ_Drpd, order.Vot_Drpd) <> "OK" Then
                '    resp.Failed("Gagal Menyimpan Maklumat.")
                '    Return JsonConvert.SerializeObject(resp.GetResult())
                'End If

                'If InsertNewOrderDtl_M(order.OrderID, order.KW_Kpd, order.KO_Kpd, order.KP_Kpd, order.PTJ_Kpd, order.Vot_Kpd) <> "OK" Then
                '    resp.Failed("Gagal Menyimpan Maklumat.")
                '    Return JsonConvert.SerializeObject(resp.GetResult())
                'End If

                success = 1

            End If

        Else

            If UpdateHantar_MohonTK_Bend(order.OrderID) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
            success = 1
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
    Public Function HantarPermohonan_MohonTK_Sah(order As order_TK) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.OrderID = "" Then 'untuk permohonan baru
            order.OrderID = GenerateOrderID()
            If InsertNewOrder(order.OrderID, order.Tahun, order.Butiran, order.Amaun, order.Dasar, order.KW, order.KO, order.KP, order.Ptj, order.Vot, order.KategoriAgih) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function

            Else
                'If InsertNewOrderDtl_K(order.OrderID, order.KW_Drpd, order.KO_Drpd, order.KP_Drpd, order.PTJ_Drpd, order.Vot_Drpd) <> "OK" Then
                '    resp.Failed("Gagal Menyimpan Maklumat.")
                '    Return JsonConvert.SerializeObject(resp.GetResult())
                'End If

                'If InsertNewOrderDtl_M(order.OrderID, order.KW_Kpd, order.KO_Kpd, order.KP_Kpd, order.PTJ_Kpd, order.Vot_Kpd) <> "OK" Then
                '    resp.Failed("Gagal Menyimpan Maklumat.")
                '    Return JsonConvert.SerializeObject(resp.GetResult())
                'End If

                success = 1

            End If

        Else

            If UpdateHantar_MohonTK_Sah(order.OrderID) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
            success = 1
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


    Private Function UpdateHantar_MohonTK_Bend(No_Mohon As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr set Status_Dok = @Status_Dok , Tkh_Bendahari = GetDate() where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Status_Dok", "05"))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))

        Return db.Process(query, param)
    End Function

    Private Function UpdateHantar_MohonTK_Sah(No_Mohon As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Agihan_Bajet_Hdr set Status_Dok = @Status_Dok , Tkh_Bendahari = GetDate() where No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Status_Dok", "03"))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))

        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HantarPermohonan_MohonViremen_KB(order As order_TK) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.OrderID = "" Then 'untuk permohonan baru
            order.OrderID = GenerateOrderID()
            If InsertNewOrder(order.OrderID, order.Tahun, order.Butiran, order.Amaun, order.Dasar, order.KW, order.KO, order.KP, order.Ptj, order.Vot, order.KategoriAgih) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function


            Else
                'If InsertNewOrderDtl_K(order.OrderID, order.KW_Drpd, order.KO_Drpd, order.KP_Drpd, order.PTJ_Drpd, order.Vot_Drpd) <> "OK" Then
                '    resp.Failed("Gagal Menyimpan Maklumat.")
                '    Return JsonConvert.SerializeObject(resp.GetResult())
                'End If

                'If InsertNewOrderDtl_M(order.OrderID, order.KW_Kpd, order.KO_Kpd, order.KP_Kpd, order.PTJ_Kpd, order.Vot_Kpd) <> "OK" Then
                '    resp.Failed("Gagal Menyimpan Maklumat.")
                '    Return JsonConvert.SerializeObject(resp.GetResult())
                'End If

                success = 1

            End If

        Else

            If UpdateHantar_MohonViremen_KB(order.OrderID) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
            success = 1
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

    Private Function UpdateHantar_MohonViremen_KB(No_Viremen As String)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE smkb_bg_viremen set Kod_Status_Dok = @Status_Dok where No_Viremen = @No_Viremen"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Status_Dok", "03"))
        param.Add(New SqlParameter("@No_Viremen", No_Viremen))

        Return db.Process(query, param)
    End Function

    '<System.Web.Services.WebMethod(EnableSession:=True)>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function HantarPermohonan_MohonViremen_Bend(order As order_Viremen) As String
    '    Dim resp As New ResponseRepository
    '    resp.Success("Data telah disimpan")
    '    Dim success As Integer = 0
    '    Dim JumRekod As Integer = 0
    '    If order Is Nothing Then
    '        resp.Failed("Tiada simpan")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    End If

    '    If order.OrderID = "" Then 'untuk permohonan baru
    '        order.OrderID = GenerateOrderID()
    '        If InsertNewOrder(order.OrderID, order.Tujuan, order.Rujukan, order.Jumlah) <> "OK" Then
    '            resp.Failed("Gagal Menyimpan Maklumat.")
    '            Return JsonConvert.SerializeObject(resp.GetResult())
    '            ' Exit Function

    '        Else
    '            If InsertNewOrderDtl_K(order.OrderID, order.KW_Drpd, order.KO_Drpd, order.KP_Drpd, order.Ptj_Drpd, order.Vot_Drpd) <> "OK" Then
    '                resp.Failed("Gagal Menyimpan Maklumat.")
    '                Return JsonConvert.SerializeObject(resp.GetResult())
    '            End If

    '            If InsertNewOrderDtl_M(order.OrderID, order.KW_Kpd, order.KO_Kpd, order.KP_Kpd, order.Ptj_Kpd, order.Vot_Kpd) <> "OK" Then
    '                resp.Failed("Gagal Menyimpan Maklumat.")
    '                Return JsonConvert.SerializeObject(resp.GetResult())
    '            End If

    '            success = 1

    '        End If

    '    Else

    '        If UpdateHantar_MohonViremen_Bend(order.OrderID) <> "OK" Then
    '            resp.Failed("Gagal Menyimpan Maklumat.")
    '            Return JsonConvert.SerializeObject(resp.GetResult())
    '        End If
    '        success = 1
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

    'Private Function UpdateHantar_MohonViremen_Bend(No_Viremen As String)
    '    Dim db = New DBKewConn
    '    Dim query As String = "UPDATE smkb_bg_viremen set Kod_Status_Dok = @Status_Dok where No_Viremen = @No_Viremen"
    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@Status_Dok", "04"))
    '    param.Add(New SqlParameter("@No_Viremen", No_Viremen))

    '    Return db.Process(query, param)
    'End Function

    '<System.Web.Services.WebMethod(EnableSession:=True)>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function HantarPermohonan_MohonViremen_NC(order As order_Viremen) As String
    '    Dim resp As New ResponseRepository
    '    resp.Success("Data telah disimpan")
    '    Dim success As Integer = 0
    '    Dim JumRekod As Integer = 0
    '    If order Is Nothing Then
    '        resp.Failed("Tiada simpan")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    End If

    '    If order.OrderID = "" Then 'untuk permohonan baru
    '        order.OrderID = GenerateOrderID()
    '        If InsertNewOrder(order.OrderID, order.Tujuan, order.Rujukan, order.Jumlah) <> "OK" Then
    '            resp.Failed("Gagal Menyimpan Maklumat.")
    '            Return JsonConvert.SerializeObject(resp.GetResult())
    '            ' Exit Function

    '        Else
    '            If InsertNewOrderDtl_K(order.OrderID, order.KW_Drpd, order.KO_Drpd, order.KP_Drpd, order.Ptj_Drpd, order.Vot_Drpd) <> "OK" Then
    '                resp.Failed("Gagal Menyimpan Maklumat.")
    '                Return JsonConvert.SerializeObject(resp.GetResult())
    '            End If

    '            If InsertNewOrderDtl_M(order.OrderID, order.KW_Kpd, order.KO_Kpd, order.KP_Kpd, order.Ptj_Kpd, order.Vot_Kpd) <> "OK" Then
    '                resp.Failed("Gagal Menyimpan Maklumat.")
    '                Return JsonConvert.SerializeObject(resp.GetResult())
    '            End If

    '            success = 1

    '        End If

    '    Else

    '        If UpdateHantar_MohonViremen_NC(order.OrderID) <> "OK" Then
    '            resp.Failed("Gagal Menyimpan Maklumat.")
    '            Return JsonConvert.SerializeObject(resp.GetResult())
    '        End If
    '        success = 1
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

    'Private Function UpdateHantar_MohonViremen_NC(No_Viremen As String)
    '    Dim db = New DBKewConn
    '    Dim query As String = "UPDATE smkb_bg_viremen set Kod_Status_Dok = @Status_Dok where No_Viremen = @No_Viremen"
    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@Status_Dok", "05"))
    '    param.Add(New SqlParameter("@No_Viremen", No_Viremen))

    '    Return db.Process(query, param)
    'End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiTransaksiViremen_Bend(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String

        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiViremen_Bend(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiViremen_Bend(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        Dim query As String = "select a.No_Viremen, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi ,Tujuan, Amaun, No_Staf, Kod_Status_Dok, Ruj_Surat , 
                               virKeluar.kod_kump_wang as kw_K, virKeluar.kod_operasi as ko_K, virKeluar.kod_projek as kp_K, virKeluar.kod_ptj as ptj_K, virKeluar.kod_vot as vot_K ,
                                virMasuk.kod_kump_wang as kw_M, virMasuk.kod_operasi as ko_M, virMasuk.kod_projek as kp_M, virMasuk.kod_ptj as ptj_M, virMasuk.kod_vot as vot_M
                                from smkb_bg_viremen as a , 
                                smkb_bg_viremendtl as virKeluar,
                                smkb_bg_viremendtl as virMasuk
                                where a.No_viremen = virMasuk.No_Viremen and  a.No_viremen = virKeluar.No_Viremen
                                AND virKeluar.kod_vir ='K'
                                AND virMasuk.kod_vir ='M' and Kod_Status_Dok ='03'
                                AND No_Staf = @userID " & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiTransaksiViremen_NC(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String

        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiViremen_NC(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiViremen_NC(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
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

        Dim query As String = "select a.No_Viremen, FORMAT (Tkh_Mohon, 'dd-MM-yyyy') as Tkh_Transaksi ,Tujuan, Amaun, No_Staf, Kod_Status_Dok, Ruj_Surat , 
                               virKeluar.kod_kump_wang as kw_K, virKeluar.kod_operasi as ko_K, virKeluar.kod_projek as kp_K, virKeluar.kod_ptj as ptj_K, virKeluar.kod_vot as vot_K ,
                                virMasuk.kod_kump_wang as kw_M, virMasuk.kod_operasi as ko_M, virMasuk.kod_projek as kp_M, virMasuk.kod_ptj as ptj_M, virMasuk.kod_vot as vot_M
                                from smkb_bg_viremen as a , 
                                smkb_bg_viremendtl as virKeluar,
                                smkb_bg_viremendtl as virMasuk
                                where a.No_viremen = virMasuk.No_Viremen and  a.No_viremen = virKeluar.No_Viremen
                                AND virKeluar.kod_vir ='K'
                                AND virMasuk.kod_vir ='M' and Kod_Status_Dok ='04'
                                AND No_Staf = @userID " & tarikhQuery

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@userID", Session("ssusrID")))

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVotCOA_Kpd(ByVal q As String, ByVal kwDrpd As String) As String


        Dim tmpDT As DataTable = GetKodCOAList_Kpd(q, kwDrpd)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodCOAList_Kpd(kodCariVot As String, kwDrpd As String) As DataTable

        kodCariVot = Replace(kodCariVot, " ", "%")

        Dim db = New DBKewConn
        Dim query As String = "SELECT TOP 10 UPPER(a.COA_Index) AS text,
                            a.Kod_Vot AS value ,
                            vot.Butiran AS colhidvot ,
                            mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO ,  kp.Butiran as colKp , 
                            a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
                            FROM SMKB_COA_Master AS a 
                            JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                            JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                            JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                            JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
                            JOIN VPejabat AS mj ON mj.kodpejabat = left(a.Kod_PTJ,2) 
                            WHERE a.status = 1  and a.Kod_Kump_Wang = @Kod_Kump_Wang "

        Dim param As New List(Of SqlParameter)
        Dim paramName As String = ""
        param.Add(New SqlParameter("@Kod_Kump_Wang", Left(kwDrpd, 2)))

        If kodCariVot <> "" Then

            Dim arrString As String() = kodCariVot.Split("%")
            Dim counter As Integer = 0

            For Each str As String In arrString
                paramName = "@str" & counter
                query &= " and COA_Index like '%' + " & paramName & "+ '%'  "
                counter += 1
                param.Add(New SqlParameter(paramName, str))
            Next

        End If

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKategoriValue(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKategoriValueFromKod(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKategoriValueFromKod(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Dasar as value, Butiran as text FROM SMKB_Dasar WHERE Status= @Status"
        Dim param As New List(Of SqlParameter)
        If (kod <> "") Then
            query = query & " AND Kod_Dasar=@kod"
            param.Add(New SqlParameter("@Status", 1))
            param.Add(New SqlParameter("@kod", kod))
        End If
        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fGetBakiSebenar(ByVal year As Integer, ByVal tarikh As String, ByVal kw As String, ByVal ko As String, ByVal ptj As String, ByVal kp As String, ByVal vot As String) As Decimal
        Dim dbconn As New DBKewConn
        Dim bakiSebenar As Decimal = 0.00
        Try
            Dim param1 As SqlParameter = New SqlParameter("@arg_tahun", SqlDbType.Int)
            param1.Value = year
            param1.Direction = ParameterDirection.Input
            param1.IsNullable = False

            Dim param2 As SqlParameter = New SqlParameter("@arg_tarikh", SqlDbType.VarChar)
            param2.Value = tarikh
            param2.Direction = ParameterDirection.Input
            param2.IsNullable = False

            Dim param3 As SqlParameter = New SqlParameter("@arg_kw", SqlDbType.VarChar)
            param3.Value = kw
            param3.Direction = ParameterDirection.Input
            param3.IsNullable = False

            Dim param4 As SqlParameter = New SqlParameter("@arg_Operasi", SqlDbType.VarChar)
            param4.Value = ko
            param4.Direction = ParameterDirection.Input
            param4.IsNullable = False

            Dim param5 As SqlParameter = New SqlParameter("@arg_projek", SqlDbType.VarChar)
            param5.Value = kp
            param5.Direction = ParameterDirection.Input
            param5.IsNullable = False

            Dim param6 As SqlParameter = New SqlParameter("@arg_jbt", SqlDbType.VarChar)
            param6.Value = ptj
            param6.Direction = ParameterDirection.Input
            param6.IsNullable = True

            Dim param7 As SqlParameter = New SqlParameter("@arg_vot", SqlDbType.VarChar)
            param7.Value = vot
            param7.Direction = ParameterDirection.Input
            param7.IsNullable = False

            Dim param8 As SqlParameter = New SqlParameter("@l_bakisbnr", SqlDbType.Decimal)
            param8.Value = bakiSebenar
            param8.Direction = ParameterDirection.Output
            param8.IsNullable = False

            Dim paramSql() As SqlParameter = {param1, param2, param3, param4, param5, param6, param7, param8}

            Dim l_bakisbnr = dbconn.fExecuteSP("USP_BAKISBNR_BAJET", paramSql, param8, bakiSebenar)

            Return JsonConvert.SerializeObject(bakiSebenar)
        Catch ex As Exception

        End Try
    End Function


End Class