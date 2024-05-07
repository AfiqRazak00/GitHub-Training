Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports SMKB_Web_Portal.Dalam_Negara
Imports SMKB_Web_Portal.Luar_Negara
Imports SMKB_Web_Portal.BatalBorang

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class TabSewaHotelLojingLN
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim totalSewaHotelLN As Decimal = 0.00

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
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

        Dim query As String = "Select a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan, b.Jenis_Tugas, 
            b.Kadar_Harga, b.No_Resit, b.Jumlah_anggaran, c.Butiran,b.Kadar_Pertukaran, b.Negara,b.Matawang,
            h.Butiran As JenisTugas, b.Path, b.Nama_Fail
            From SMKB_Tuntutan_Hdr As a INNER Join
            SMKB_Tuntutan_Dtl As b On a.No_Tuntutan = b.No_Tuntutan INNER Join
            SMKB_Lookup_Detail As c On b.Jenis_Penginapan = c.Kod_Detail  INNER Join
            SMKB_Lookup_Detail As h On h.Kod_Detail = b.Jenis_Tugas 
            Where c.kod ='AC01'   AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EH' AND a.No_Tuntutan = @No_Tuntutan
            Order BY b.No_Item ASC "


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function kiraElaunHotel(ByVal jnsTugas As String, ByVal jnsNegara As String) As String
        Dim resp As New ResponseRepository

        dt = KiraElaunHotelTable(jnsTugas, jnsNegara)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function KiraElaunHotelTable(jnsTugas As String, jnsNegara As String) As DataTable
        Dim db = New DBKewConn


        Dim query As String = $"Select        a.Kategori, a.JenisTugas, a.SewaHotel, a.ElnLojing, b.Negara
                        FROM            SMKB_CLM_KdrLuarNegara AS a INNER JOIN						
                        SMKB_CLM_Kump_Negara as b ON a.Kategori = b.Kategori  INNER JOIN
						SMKB_Tuntutan_Dlm_Kenyataan AS c ON c.Negara = b.Negara 
                        WHERE b.Negara = @jnsNegara AND a.JenisTugas= @jnsTugas"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@jnsNegara", jnsNegara))
        param.Add(New SqlParameter("@jnsTugas", jnsTugas))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadSewaHotel() As String
        Dim resp As New ResponseRepository
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        Dim checkList As New UploadResitHotelLN


        checkList.idItem = HttpContext.Current.Request.Form("idItem")
        checkList.mohonID = HttpContext.Current.Request.Form("mohonID")
        checkList.Hotel_jnsTugas = HttpContext.Current.Request.Form("Hotel_jnsTugas")
        checkList.Hotel_MataWang = HttpContext.Current.Request.Form("Hotel_MataWang")
        checkList.Hotel_Negara = HttpContext.Current.Request.Form("Hotel_Negara")
        checkList.Hotel_KdrPertukaran = HttpContext.Current.Request.Form("Hotel_KdrPertukaran")
        checkList.Hotel_noResit = HttpContext.Current.Request.Form("Hotel_noResit")
        checkList.Hotel_bilHari = HttpContext.Current.Request.Form("Hotel_bilHari")
        checkList.Hotel_ElaunHarian = HttpContext.Current.Request.Form("Hotel_ElaunHarian")
        checkList.Hotel_Jumlah = HttpContext.Current.Request.Form("Hotel_Jumlah")
        checkList.TotalAllTab = HttpContext.Current.Request.Form("TotalAllHotel")
        totalSewaHotelLN += checkList.Hotel_Jumlah


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
                                    WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EH') AND (No_Item = @No_Item)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
            paramC.Add(New SqlParameter("@No_Item", checkList.idItem))

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

    Private Function UpdateTotalSewaHotel(checkList As UploadResitHotelLN)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing = @Jumlah_Sewa_HotelLojing                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing", checkList.TotalAllTab))

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

    Private Function UpdateDataSewaHotel(checkList As UploadResitHotelLN)
        Dim db = New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Matawang = @Matawang, Negara = @Negara, Kadar_Pertukaran = @Kadar_Pertukaran, Jenis_Tugas = @Jenis_Tugas, Bil_Hari = @Bil_Hari, 
        No_Resit = @No_Resit, Kadar_Harga=@Kadar_Harga, Jumlah_anggaran = @Jumlah_anggaran, Nama_Fail = @Nama_Fail, Path = @Path
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EH' "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))
        param.Add(New SqlParameter("@Matawang", checkList.Hotel_MataWang))
        param.Add(New SqlParameter("@Negara", checkList.Hotel_Negara))
        param.Add(New SqlParameter("@Kadar_Pertukaran", checkList.Hotel_KdrPertukaran))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Hotel_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Hotel_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Hotel_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Hotel_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function InsertDataSewaHotel(checkList As UploadResitHotelLN)
        Dim db As New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                    Jenis_Tugas, Matawang, Negara, Kadar_Pertukaran, Bil_Hari, Jenis_Penginapan, Kadar_Harga, Jumlah_anggaran, Nama_Fail, Path)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tugas, @Matawang, @Negara, @Kadar_Pertukaran, @Bil_Hari,
                            @Jenis_Penginapan, @Kadar_Harga, @Jumlah_anggaran,  @Nama_Fail, @Path)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Hotel_noResit))
        param.Add(New SqlParameter("@Matawang", checkList.Hotel_MataWang))
        param.Add(New SqlParameter("@Negara", checkList.Hotel_Negara))
        param.Add(New SqlParameter("@Kadar_Pertukaran", checkList.Hotel_KdrPertukaran))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Hotel_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Hotel_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Hotel_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Hotel_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))


        Return db.Process(query, param)
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

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan, b.Jenis_Tugas, 
                            b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran,b.Kadar_Pertukaran, b.Negara,b.Matawang, 
                            h.Butiran as JenisTugas, b.Path, b.Nama_Fail
                            FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
                            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                            SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
                            SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
                            WHERE c.kod='AC01'   AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EL' AND a.No_Tuntutan = @No_Tuntutan
                            ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadDataLojing() As String
        Dim resp As New ResponseRepository
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        Dim checkList As New UploadResitLojingLN


        checkList.idItem = HttpContext.Current.Request.Form("idItem")
        checkList.mohonID = HttpContext.Current.Request.Form("mohonID")
        checkList.Lojing_jnsTugas = HttpContext.Current.Request.Form("Lojing_jnsTugas")
        checkList.Lojing_MataWang = HttpContext.Current.Request.Form("Lojing_MataWang")
        checkList.Lojing_Negara = HttpContext.Current.Request.Form("Lojing_Negara")
        checkList.Lojing_KdrPertukaran = HttpContext.Current.Request.Form("Lojing_KdrPertukaran")
        checkList.Lojing_noResit = HttpContext.Current.Request.Form("Lojing_noResit")
        checkList.Lojing_bilHari = HttpContext.Current.Request.Form("Lojing_bilHari")
        checkList.Lojing_ElaunHarian = HttpContext.Current.Request.Form("Lojing_ElaunHarian")
        checkList.Lojing_Jumlah = HttpContext.Current.Request.Form("Lojing_Jumlah")
        checkList.TotalAllTab = HttpContext.Current.Request.Form("TotalAllHotel")
        totalSewaHotelLN += checkList.Lojing_Jumlah


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
                                    WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'EL') AND (No_Item = @No_Item)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
            paramC.Add(New SqlParameter("@No_Item", checkList.idItem))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateDataLojing(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                checkList.idItem = GenerateIDDataLojing(checkList.mohonID)
                If InsertDataLojing(checkList) <> "OK" Then
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

    Private Function UpdateDataLojing(checkList As UploadResitLojingLN)
        Dim db = New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Matawang = @Matawang, Negara = @Negara, Kadar_Pertukaran = @Kadar_Pertukaran, Jenis_Tugas = @Jenis_Tugas, Bil_Hari = @Bil_Hari, 
        No_Resit = @No_Resit, Kadar_Harga=@Kadar_Harga, Jumlah_anggaran = @Jumlah_anggaran, Nama_Fail = @Nama_Fail, Path = @Path
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EL' "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Lojing_noResit))
        param.Add(New SqlParameter("@Matawang", checkList.Lojing_MataWang))
        param.Add(New SqlParameter("@Negara", checkList.Lojing_Negara))
        param.Add(New SqlParameter("@Kadar_Pertukaran", checkList.Lojing_KdrPertukaran))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Lojing_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Lojing_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Lojing_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Lojing_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function InsertDataLojing(checkList As UploadResitLojingLN)
        Dim db As New DBKewConn
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                    Jenis_Tugas, Matawang, Negara, Kadar_Pertukaran, Bil_Hari, Jenis_Penginapan, Kadar_Harga, Jumlah_anggaran, Nama_Fail, Path)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tugas, @Matawang, @Negara, @Kadar_Pertukaran, @Bil_Hari,
                            @Jenis_Penginapan, @Kadar_Harga, @Jumlah_anggaran,  @Nama_Fail, @Path)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EL"))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@No_Resit", checkList.Lojing_noResit))
        param.Add(New SqlParameter("@Matawang", checkList.Lojing_MataWang))
        param.Add(New SqlParameter("@Negara", checkList.Lojing_Negara))
        param.Add(New SqlParameter("@Kadar_Pertukaran", checkList.Lojing_KdrPertukaran))
        param.Add(New SqlParameter("@Jenis_Tugas", checkList.Lojing_jnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", checkList.Lojing_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "L"))
        param.Add(New SqlParameter("@Kadar_Harga", checkList.Lojing_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Lojing_Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))


        Return db.Process(query, param)
    End Function

    Private Function UpdateTotalLojing(checkList As UploadResitLojingLN)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing = @Jumlah_Sewa_HotelLojing                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing", checkList.TotalAllTab))

        Return db.Process(query, param)
    End Function

    Private Function GenerateIDDataLojing(MohonID As String) As String
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
    Public Function DeleteHotelRecord(PadamDataHotel As BatalHotel) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)

        If PadamDataHotel Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If PadamDataHotel.mohonID = "" Then 'untuk permohonan baru
            resp.Failed("Tiada Data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            If UpdateBatal(PadamDataHotel) <> "OK" Then  '
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

        End If




        resp.Success("Rekod berjaya disimpan", "00", PadamDataHotel)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateBatal(PadamDataHotel As BatalHotel)

        Dim db As New DBKewConn
        Dim query As String = "DELETE SMKB_Tuntutan_Dtl                                 
                                WHERE No_Tuntutan = @No_Tuntutan AND No_Item = @No_Item AND Jns_Dtl_Tuntutan= 'EH' "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", PadamDataHotel.mohonID))
        param.Add(New SqlParameter("@No_Item", PadamDataHotel.idItem))



        Return db.Process(query, param)
    End Function

    Private Function UpdateStatusDokBatal(PadamDataHotel As BatalHotel)
        Dim db As New DBKewConn



        Dim query As String = "UPDATE  SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing =@Jumlah_Sewa_HotelLojing
                               WHERE No_Tuntutan =@No_Tuntutan "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing", PadamDataHotel.jumlahTabHotel))
        param.Add(New SqlParameter("@No_Tuntutan", PadamDataHotel.mohonID))


        Return db.Process(query, param)

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