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

Imports System.EnterpriseServices
Imports System.IO
Imports iTextSharp.text.log




' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PenyataBank_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    'Private strConn As String = "Data Source=devmis12.utem.edu.my;Initial Catalog=dbKewanganV4;Persist Security Info=True;User ID=smkb;Password=Smkb@Dev2012"


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBank(ByVal q As String) As String
        Dim tmpDT As DataTable = GetSenaraiBank(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetSenaraiBank(kod As String) As DataTable
        Dim db As New DBKewConn

        kod = Replace(kod, " ", "%")

        Dim query As String = "select Kod_Bank as value, concat(Kod_Bank, ' - ',Nama_Bank , ' ( No. Akaun: ' , No_Akaun, ' ) ') as text from SMKB_Bank_Master where Kod_Jen_Bank = 1 "
        Dim param As New List(Of SqlParameter)
        Dim paramName As String = ""

        If kod <> "" Then

            Dim arrString As String() = kod.Split("%")
            Dim counter As Integer = 0

            For Each str As String In arrString
                paramName = "@str" & counter
                query &= " and concat(Kod_Bank, ' - ',Nama_Bank , ' ( No. Akaun: ' , No_Akaun, ' ) ') like '%'  + " & paramName & "+ '%' "
                counter += 1
                param.Add(New SqlParameter(paramName, str))
            Next

        End If

        query &= " order by Kod_Bank"

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiTransaksi(strKodBank As String) As String

        Dim resp As New ResponseRepository

        dt = GetOrder_SenaraiTransaksi(strKodBank)
        Return JsonConvert.SerializeObject(dt)
    End Function


    Private Function GetOrder_SenaraiTransaksi(strKodBank As String) As DataTable
        Dim db = New DBKewConn





        Dim query As String = "select A.Kod_bank, A.Pyt_Id, FORMAT (A.Tkh_Pyt, 'dd-MM-yyyy') as Tkh_Pyt  , A.Baki_Pyt, 
                                B.Nama_Bank, B.No_Akaun, B.Nama_Sing 
                                from SMKB_Penyesuaian_Bank_Hdr A inner join SMKB_Bank_Master B 
                                on A.Kod_bank = B.Kod_bank 
                                where A.Cara_Masuk = 'M' and B.Kod_Jen_Bank = 1 
                                and A.Kod_bank = @kodBank
                                ORDER BY A.Tkh_Pyt Desc"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kodBank", strKodBank))

        Return db.Read(query, param)


    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveOrders(order As Order_Penyata) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.IdPenyata = "" Then 'untuk permohonan baru

            If InsertNewOrder(order.Bank, order.Tarikh, order.Jumlah) <> "OK" Then
                resp.Failed("Gagal Menyimpan Maklumat.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            Else
                success = 1

            End If

        End If

        If success = 0 Then
            resp.Failed("Rekod order_Penyata detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertNewOrder(Bank As String, Tarikh As String, Jumlah As Decimal)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Penyesuaian_Bank_Hdr (Kod_bank, Pyt_Id, Tkh_Pyt, Baki_Pyt, Status_Tutup, Cara_Masuk, No_Staf, Tkh)
        VALUES(@Bank , @Id ,@Tarikh, @Jumlah, @Status_Tutup, @Cara_Masuk, @No_Staf, getdate())"
        Dim param As New List(Of SqlParameter)

        Dim Id As String = Bank & Year(Tarikh) & Month(Tarikh).ToString("D2")

        param.Add(New SqlParameter("@Bank", Bank))
        param.Add(New SqlParameter("@Id", Id))
        param.Add(New SqlParameter("@Tarikh", Tarikh))
        param.Add(New SqlParameter("@Jumlah", Jumlah))
        param.Add(New SqlParameter("@Status_Tutup", "N"))
        param.Add(New SqlParameter("@Cara_Masuk", "M"))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))

        Return db.Process(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrPenyata(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrPenyata(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrPenyata(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.Pyt_Id,
               concat(A.Kod_bank ,' - ', (select b.Nama_Bank from SMKB_Bank_Master as b where b.Kod_Jen_Bank = 1  and b.Kod_bank = a.Kod_bank)) as Nama_Bank 
                , (select b.No_Akaun from SMKB_Bank_Master as b where b.Kod_Jen_Bank = 1  and b.Kod_bank = a.Kod_bank) as No_Akaun,
                FORMAT(a.Tkh_Pyt, 'yyyy-MM-dd')  as Tkh_Pyt, a.Baki_Pyt
                FROM SMKB_Penyesuaian_Bank_Hdr AS  A WHERE a.Pyt_Id = @Pyt_Id"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Pyt_Id", id))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveOrders_Dtl(order As Order_Penyata) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If order.IdPenyata <> "" Then 'untuk permohonan baru

            For Each orderDetail As OrderDetail_Penyata In order.OrderDetails

                If orderDetail.Tarikh = "" Then
                    Continue For
                End If

                JumRekod += 1

                'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model


                orderDetail.ID = GenerateOrderDetailID(order.IdPenyata)

                If InsertOrderDetail(order.IdPenyata, orderDetail) = "OK" Then
                    success += 1
                End If

            Next


        End If

        If success = 0 Then
            resp.Failed("Rekod order_Penyata detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Rekod berjaya disimpan", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GenerateOrderDetailID(orderid As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 Id as id
        from SMKB_Penyesuaian_Bank_Dtl 
        where Pyt_Id = @orderid
        ORDER BY Id DESC"

        param.Add(New SqlParameter("@orderid", orderid))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function

    Private Function InsertOrderDetail(IdPenyata As String, orderDetail As OrderDetail_Penyata)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Penyesuaian_Bank_Dtl ( Id, Pyt_Id, Tkh, Rujukan, Butiran, Debit, Kredit, Baki, Status_Penyesuaian)
        VALUES( @Id, @Pyt_Id, @Tkh, @Rujukan, @Butiran, @Debit, @Kredit, @Baki, @Status_Penyesuaian)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Id", orderDetail.ID))
        param.Add(New SqlParameter("@Pyt_Id", IdPenyata))
        param.Add(New SqlParameter("@Tkh", orderDetail.Tarikh))
        param.Add(New SqlParameter("@Rujukan", orderDetail.Rujukan))
        param.Add(New SqlParameter("@Butiran", orderDetail.Butiran))
        param.Add(New SqlParameter("@Debit", orderDetail.Debit))
        param.Add(New SqlParameter("@Kredit", orderDetail.Kredit))
        param.Add(New SqlParameter("@Baki", orderDetail.Baki))
        param.Add(New SqlParameter("@Status_Penyesuaian", "U"))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveAndUploadFile() As String

        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim fileSize As Long = postedFile.ContentLength
        Dim fileExtension As String = Path.GetExtension(fileName).ToLower()
        Dim nomohon As String = HttpContext.Current.Request.Form("nomohon")
        'namaFail = HttpContext.Current.Request.Form("namaFail")
        'dokumenType = HttpContext.Current.Request.Form("dokumenType")

        'delete data 

        Try
            Dim query As String

            Dim db As New DBKewConn
            Dim i As Integer = 1
            Dim cells As String()

            ' Specify the file path where you want to save the uploaded file
            Dim folderPath As String = Server.MapPath("~/UPLOAD/DOCUMENT/PENYESUAIAN BANK/PENYATA BANK/")
            Dim savePath As String = Path.Combine(folderPath, postedFile.FileName)

            'start Process delete if ada id yg sama
            Dim query_Delete As String = "DELETE FROM SMKB_Penyesuaian_Bank_Dtl WHERE Pyt_Id = @Pyt_Id"
            Dim param_Delete As New List(Of SqlParameter)

            param_Delete.Add(New SqlParameter("@Pyt_Id", nomohon))

            db.Process(query_Delete, param_Delete)

            If System.IO.File.Exists(savePath) Then
                System.IO.File.Delete(savePath)
            End If

            'end process

            ' Check file extension on the server side
            If Not IsFileExtensionValid(fileExtension) Then
                ' Delete the file if the extension is not valid
                File.Delete(savePath)
                Return "Invalid file format. Only CSV files are allowed."
            End If

            'Save the file to the specified path
            postedFile.SaveAs(savePath)
            'Read the contents of CSV file.
            Dim csvData As String = File.ReadAllText(savePath)


            'Execute a loop over the rows.
            For Each row As String In csvData.Split(ControlChars.Lf)
                If Not String.IsNullOrEmpty(row) Then
                    ' Clear the parameter list for each iteration
                    Dim param As New List(Of SqlParameter)

                    cells = row.Split(","c)
                    'Execute a loop over the columns.
                    'For Each cell As String In row.Split(","c)

                    query = "INSERT INTO SMKB_Penyesuaian_Bank_Dtl (Pyt_Id, Id, Tkh, Rujukan, Butiran, Debit, Kredit, Baki, Status_Penyesuaian)
                       VALUES( @Pyt_Id, @Id , @Tkh, @Rujukan, @Butiran, @Debit, @Kredit, @Baki, @Status_Penyesuaian)"

                    param.Add(New SqlParameter("@Pyt_Id", nomohon))
                    param.Add(New SqlParameter("@Id", i))
                    param.Add(New SqlParameter("@Tkh", cells(2)))
                    param.Add(New SqlParameter("@Rujukan", cells(4)))
                    param.Add(New SqlParameter("@Butiran", cells(3)))

                    If cells(6) = "" Then
                        param.Add(New SqlParameter("@Debit", 0.00))
                    Else
                        param.Add(New SqlParameter("@Debit", Double.Parse(cells(6))))
                    End If

                    If cells(5) = "" Then
                        param.Add(New SqlParameter("@Kredit", 0.00))
                    Else
                        param.Add(New SqlParameter("@Kredit", Double.Parse(cells(5))))
                    End If

                    param.Add(New SqlParameter("@Baki", Double.Parse(cells(7).Replace("+", ""))))
                    param.Add(New SqlParameter("@Status_Penyesuaian", "U"))

                    Try
                        db.Process(query, param)
                        ' Print or log a success message if needed
                    Catch ex As Exception
                        ' Handle exceptions or log errors
                        Console.WriteLine("Error: " & ex.Message)
                    End Try


                    i += 1
                    'Next
                End If
            Next

        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try

        Dim resp As New ResponseRepository
        resp.Success("Rekod berjaya disimpan", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function

    Private Function IsFileExtensionValid(extension As String) As Boolean
        ' Check if the file extension is valid (e.g., only allow PDF files)
        Return extension = ".csv"
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordDtl(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetInfoDtl(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetInfoDtl(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select Id, FORMAT(Tkh, 'yyyy-MM-dd') as Tkh_Transaksi, Rujukan , 
        Butiran, Debit , Kredit, Baki from  SMKB_Penyesuaian_Bank_dtl a 
        where Pyt_Id = @Pyt_Id"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Pyt_Id", id))

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Proses_BR(order As OrderDetail_Penyesuaian) As String
        Dim resp As New ResponseRepository
        Dim db = New DBKewConn
        Dim sqlComm As New SqlCommand
        Dim X As Integer = 0

        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If order Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Dim Tarikh As String = order.Tarikh.ToString("MM/dd/yyyy")

        If order.IdPenyata <> "" Then 'untuk permohonan baru

            sqlcon = New SqlConnection(strConn)

            Using (sqlcon)

                sqlComm.Connection = sqlcon

                sqlComm.CommandText = "USP_BR_Auto"
                sqlComm.CommandType = CommandType.StoredProcedure

                sqlComm.Parameters.AddWithValue("KODBANK", Left((order.IdPenyata), 5))
                sqlComm.Parameters.AddWithValue("NoStaf", Session("ssusrID"))
                sqlComm.Parameters.AddWithValue("TKH", order.Tarikh)
                sqlComm.Parameters.AddWithValue("PenyId", order.IdPenyata)

                sqlcon.Open()
                sqlComm.ExecuteNonQuery()
                sqlcon.Close()

            End Using

            success = 1
        End If

        If success = 0 Then
            resp.Failed("Rekod order_Penyesuaian detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Success("Penyesuaian Berjaya", "00", order)
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


End Class