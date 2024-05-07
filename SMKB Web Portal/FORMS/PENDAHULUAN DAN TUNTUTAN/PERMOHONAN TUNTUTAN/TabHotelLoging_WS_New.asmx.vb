Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data.SqlClient
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports SMKB_Web_Portal.Dalam_Negara

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class TabHotelLoging_WS_New
    Inherits System.Web.Services.WebService


    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim totalSewaLojing As Decimal = 0.00

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function


    <WebMethod()>
    Public Function TesttWorld() As String
        Return "Hello World XXXX"
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

    Private Function CallRecordElaunLojing(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan,b.Jenis_Tempat,b.Jenis_Tugas, 
            b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran , g.Butiran as Tempat,
            h.Butiran as JenisTugas, b.Path, b.Nama_Fail,b.Alamat_Lojing
            FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
            SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
            SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
            SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
            WHERE c.kod='AC01'  AND g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EL' AND a.No_Tuntutan =@No_Tuntutan
            ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

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

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan,b.Jenis_Tempat,b.Jenis_Tugas, 
            b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran , g.Butiran as Tempat,
            h.Butiran as JenisTugas, b.Path, b.Nama_Fail,b.Caj_Hotel, b.Flag_Kongsi_Bilik
            FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
            SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
            SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
            SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
            WHERE c.kod='AC01'  AND g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EH' AND a.No_Tuntutan =@No_Tuntutan
            ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataJumlahHotelLojing(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallDataTotalHotelLojing(id)


        Return JsonConvert.SerializeObject(dt)



    End Function

    Private Function CallDataTotalHotelLojing(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select z.No_Tuntutan, sum(z.Jumlah_anggaran_eh) as total_EH,sum(z.Caj_Hotel_eh) as CajHotel, sum(z.Jumlah_anggaran_eh)+sum(z.Caj_Hotel_eh) TotalK_EH,
sum(z.Jumlah_anggaran_el) as total_EL, sum(z.Caj_Hotel_el) as Cukai_EL,  (sum(z.Jumlah_anggaran_el)+sum(z.Caj_Hotel_el)) TotalK_EL
from (
SELECT No_Tuntutan,  SUM(Jumlah_anggaran) as Jumlah_anggaran_eh, SUM(Caj_Hotel) as Caj_Hotel_eh,	0 as Jumlah_anggaran_el, 0 as Caj_Hotel_el
	FROM SMKB_Tuntutan_Dtl
	WHERE Jns_Dtl_Tuntutan IN('EH') AND No_Tuntutan =@No_Tuntutan
	GROUP BY No_Tuntutan, Jns_Dtl_Tuntutan
	UNION 
	SELECT No_Tuntutan, 0 as Jumlah_anggaran_eh, 0 as Caj_Hotel_eh	, SUM(Jumlah_anggaran) as Jumlah_anggaran_el, SUM(isnull(Caj_Hotel,0)) as Caj_Hotel_el
	FROM SMKB_Tuntutan_Dtl
	WHERE Jns_Dtl_Tuntutan IN('EL') AND No_Tuntutan =@No_Tuntutan
	GROUP BY No_Tuntutan,Jns_Dtl_Tuntutan ) z group by z.No_Tuntutan"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function



    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadSewaHotel() As String
        Dim resp As New ResponseRepository
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        Dim checkList As New UploadResitTblSewaHotel


        checkList.idItem = HttpContext.Current.Request.Form("idItem")
        checkList.mohonID = HttpContext.Current.Request.Form("mohonID")
        checkList.Hotel_noResit = HttpContext.Current.Request.Form("Hotel_noResit")
        checkList.Hotel_bilHari = HttpContext.Current.Request.Form("Hotel_bilHari")
        checkList.Hotel_jnsTugas = HttpContext.Current.Request.Form("Hotel_jnsTugas")
        checkList.Hotel_JnsTempat = HttpContext.Current.Request.Form("Hotel_JnsTempat")
        checkList.Hotel_ElaunHarian = HttpContext.Current.Request.Form("Hotel_ElaunHarian")
        checkList.Hotel_Jumlah = HttpContext.Current.Request.Form("Hotel_Jumlah")
        checkList.totalCukai = HttpContext.Current.Request.Form("Total_Cukai")
        checkList.flagBilik = HttpContext.Current.Request.Form("flagBilik")
        totalSewaLojing += checkList.Hotel_Jumlah


        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)


        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)
            ' semak path dah wujud ke blom
            If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
                System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
            End If

            ' Specify the file path where you want to save the uploaded file
            Dim savePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID & "//" & fileName)
            Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            '---Save File kat table----
            Dim db As New DBKewConn

            Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl
                                    WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EH') AND (No_Resit = @No_Resit)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
            paramC.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateDataSewaHotel(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                checkList.idItem = GenerateIDDataSewaHotel(checkList.mohonID)
                If InsertDataSewaHotel(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            'ni tuk total keseluruhan masuk ke tblsmkb_tuntutan_Hdr
            If UpdateTotalSewaHotel(checkList) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If


            resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    Private Function UpdateTotalSewaHotel(checkList As UploadResitTblSewaHotel)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing = @Jumlah_Sewa_HotelLojing                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing", totalSewaLojing))

        Return db.Process(query, param)
    End Function

    Private Function InsertDataTblSewaHotel(checkList As UploadResitTblSewaHotel)
        Dim db As New DBKewConn


        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim mohonId As String = checkList.mohonID
        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName
        'Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/"

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID


        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                    Jenis_Tempat, Jenis_Tugas, Bil_Hari, Jenis_Penginapan, Kadar_Harga, Jumlah_anggaran, Nama_Fail,Path)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tempat, @Jenis_Tugas, @Bil_Hari,
                            @Jenis_Penginapan,@Kadar_Harga,@Jumlah_anggaran)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Hotel_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Hotel_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Hotel_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Hotel_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Hotel_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))


        Return db.Process(query, param)
    End Function
    Private Function UpdateDataTblSewaHotel(checkList As UploadResitTblSewaHotel)

        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas, Bil_Hari = @Bil_Hari, 
        No_Resit = @No_Resit, Kadar_Harga=@Kadar_Harga, Jumlah_anggaran = @Jumlah_anggaran, Nama_Fail = @Nama_Fail, Path = @Path
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EH' "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Hotel_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Hotel_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Hotel_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Hotel_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Hotel_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function GenerateIDTblSewaHotel(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='EH'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
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


    Private Function InsertDataSewaHotel(checkList As UploadResitTblSewaHotel)
        Dim db As New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                    Jenis_Tempat, Jenis_Tugas, Bil_Hari, Jenis_Penginapan, Kadar_Harga, Jumlah_anggaran, Nama_Fail, Path, Caj_Hotel)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tempat, @Jenis_Tugas, @Bil_Hari,
                            @Jenis_Penginapan,@Kadar_Harga,@Jumlah_anggaran,  @Nama_Fail, @Path, @Caj_Hotel)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Hotel_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Hotel_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Hotel_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Hotel_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Hotel_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))
        param.Add(New SqlParameter("@Caj_Hotel", checkList.totalCukai))


        Return db.Process(query, param)
    End Function

    Private Function GenerateIDDataSewaHotel(MohonID As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @No_Tuntutan AND Jns_Dtl_Tuntutan='EH'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@No_Tuntutan", MohonID))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateDataSewaHotel(checkList As UploadResitTblSewaHotel)
        Dim db = New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas, Bil_Hari = @Bil_Hari,Caj_Hotel = @Caj_Hotel, 
        No_Resit = @No_Resit, Kadar_Harga=@Kadar_Harga, Jumlah_anggaran = @Jumlah_anggaran, Nama_Fail = @Nama_Fail, Path = @Path
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EH' "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Hotel_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Hotel_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Hotel_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Hotel_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Hotel_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))
        param.Add(New SqlParameter("@Caj_Hotel", checkList.totalCukai))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadElaunLojing() As String
        Dim resp As New ResponseRepository
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        Dim checkList As New UploadTblLojing

        checkList.idItem = HttpContext.Current.Request.Form("idItem")
        checkList.mohonID = HttpContext.Current.Request.Form("mohonID")
        checkList.Lojing_noResit = HttpContext.Current.Request.Form("Lojing_noResit")
        checkList.Lojing_bilHari = HttpContext.Current.Request.Form("Lojing_bilHari")
        checkList.Lojing_jnsTugas = HttpContext.Current.Request.Form("Lojing_jnsTugas")
        checkList.Lojing_JnsTempat = HttpContext.Current.Request.Form("Lojing_JnsTempat")
        checkList.Lojing_ElaunHarian = HttpContext.Current.Request.Form("Lojing_ElaunHarian")
        checkList.Lojing_Jumlah = HttpContext.Current.Request.Form("Lojing_Jumlah")
        checkList.Lojing_Alamat = HttpContext.Current.Request.Form("Lojing_Alamat")
        totalSewaLojing += checkList.Lojing_Jumlah


        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)


        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)
            ' semak path dah wujud ke blom
            If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
                System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
            End If

            ' Specify the file path where you want to save the uploaded file
            Dim savePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID & "//" & fileName)
            Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            '---Save File kat table----
            Dim db As New DBKewConn

            Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl
                                    WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EL') AND (No_Resit = @No_Resit)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
            paramC.Add(New SqlParameter("@No_Resit", checkList.Lojing_noResit))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateDataElaunLojing(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                checkList.idItem = GenerateIDElaunLojing(checkList.mohonID)
                If InsertDataElaunLojing(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            'ni tuk total keseluruhan masuk ke tblsmkb_tuntutan_Hdr
            If UpdateTotalLojing(checkList) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If


            resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    Private Function UpdateTotalLojing(checkList As UploadTblLojing)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing = @Jumlah_Sewa_HotelLojing                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing", totalSewaLojing))

        Return db.Process(query, param)
    End Function
    Private Function InsertDataElaunLojing(checkList As UploadTblLojing)
        Dim db As New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                        Jenis_Tempat, Jenis_Tugas, Bil_Hari, Jenis_Penginapan, Kadar_Harga, Jumlah_anggaran, Nama_Fail, Path,Alamat_Lojing )
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tempat, @Jenis_Tugas, @Bil_Hari,
                      @Jenis_Penginapan,@Kadar_Harga,@Jumlah_anggaran,  @Nama_Fail, @Path, @Alamat_Lojing)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EL"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Lojing_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Lojing_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Lojing_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Lojing_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "L"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Lojing_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Lojing_Jumlah))
        param.Add(New SqlParameter("@Alamat_Lojing", checkList.Lojing_Alamat))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function UpdateDataElaunLojing(checkList As UploadTblLojing)
        Dim db = New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas, Bil_Hari = @Bil_Hari, 
        No_Resit = @No_Resit, Kadar_Harga=@Kadar_Harga, Jumlah_anggaran = @Jumlah_anggaran,
        Nama_Fail = @Nama_Fail, Path = @Path, Alamat_Lojing = @Alamat_Lojing
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EL' "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EL"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Lojing_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", checkList.Lojing_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Lojing_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Lojing_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "L"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Lojing_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Lojing_Jumlah))
        param.Add(New SqlParameter("@Alamat_Lojing", checkList.Lojing_Alamat))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function GenerateIDElaunLojing(MohonID As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @No_Tuntutan AND Jns_Dtl_Tuntutan='EL'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@No_Tuntutan", MohonID))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveJumlahHotelLojing(id As String, total As Decimal) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing = @Jumlah_Sewa_HotelLojing                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))
        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing", total))

        Return db.Process(query, param)

        resp.Success("Rekod berjaya disimpan", "00", "")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
End Class