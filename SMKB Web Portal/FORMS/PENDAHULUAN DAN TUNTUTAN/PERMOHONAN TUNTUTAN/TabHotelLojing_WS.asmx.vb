Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System
Imports SMKB_Web_Portal.Dalam_Negara

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class TabHotelLojing_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
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
        checkList.Hotel_jnsTugas = HttpContext.Current.Request.Form("Hotel_jnsTugas")
        checkList.Hotel_JnsTempat = HttpContext.Current.Request.Form("Hotel_JnsTempat")
        checkList.Hotel_noResit = HttpContext.Current.Request.Form("Hotel_noResit")
        checkList.Hotel_bilHari = HttpContext.Current.Request.Form("Hotel_bilHari")
        checkList.Hotel_ElaunHarian = HttpContext.Current.Request.Form("Hotel_ElaunHarian")
        checkList.Hotel_Jumlah = HttpContext.Current.Request.Form("Hotel_Jumlah")


        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)


        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

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
                If UpdateDataTblSewaHotel(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                checkList.idItem = GenerateIDTblSewaHotel(checkList.mohonID)
                If InsertDataTblSewaHotel(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataSewaHotel(ByVal id As String) As String
        'Dim resp As New ResponseRepository

        'dt = CallRecordSewaHotel(id)
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan,b.Jenis_Tempat,b.Jenis_Tugas, 
            b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran , g.Butiran as Tempat,
            h.Butiran as JenisTugas, b.Nama_Fail, b.Path
            FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
            SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
            SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
            SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
            WHERE c.kod='AC01'  AND g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EH' AND a.No_Tuntutan =@No_Tuntutan
            ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        dt = db.Read(query, param)

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

    'Private Function CallRecordSewaHotel(id As String) As DataTable
    '    Dim db = New DBKewConn

    '    Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan,b.Jenis_Tempat,b.Jenis_Tugas, 
    '        b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran , g.Butiran as Tempat,
    '        h.Butiran as JenisTugas
    '        FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
    '        SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
    '        SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
    '        SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
    '        SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
    '        WHERE c.kod='AC01'  AND g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EH' AND a.No_Tuntutan =@No_Tuntutan
    '        ORDER BY b.No_Item ASC"


    '    Dim param As New List(Of SqlParameter)
    '    param.Add(New SqlParameter("@No_Tuntutan", id))

    '    Return db.Read(query, param)
    'End Function


End Class