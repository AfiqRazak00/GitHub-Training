Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports SMKB_Web_Portal.Luar_Negara


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class TabPelbagaiLN_WS
    Inherits System.Web.Services.WebService
    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable


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
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function LuarNegara_SaveUploadTblBP() As String
        Dim resp As New ResponseRepository
        Dim fileName As String = ""
        Dim fileSize As String = ""
        Dim postedFile As HttpPostedFile = Nothing
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim returnURL As String = ""
        Dim list As New UploadResitTblBP
        Dim savePath As String = ""
        Dim folder As String = ""

        list.idItem = HttpContext.Current.Request.Form("idItem")
        list.mohonID = HttpContext.Current.Request.Form("mohonID")
        list.ResitNo = HttpContext.Current.Request.Form("NoResit")
        list.FlagResit = HttpContext.Current.Request.Form("staResit")
        list.JenisBelanjaP = HttpContext.Current.Request.Form("JnsBelanjeP")
        list.JnsNegara = HttpContext.Current.Request.Form("JnsNegara")
        list.JnsMataWang = HttpContext.Current.Request.Form("JnsMataWang")
        list.Jumlah = HttpContext.Current.Request.Form("jumlah")
        list.JumlahAll = HttpContext.Current.Request.Form("jumlahAll")


        'Check if File is available.
        If HttpContext.Current.Request.Files.Count > 0 Then
            postedFile = HttpContext.Current.Request.Files(0)
        End If

        Session("UploadedFileName") = ""

        Try

            If postedFile IsNot Nothing Then
                fileName = postedFile.FileName
                fileSize = postedFile.ContentLength

                ' Convert the base64 string to byte array
                'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

                If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID) Then
                    System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID)
                End If

                ' Specify the file path where you want to save the uploaded file
                savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & list.mohonID & "//" & fileName)
                folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & list.mohonID

                ' Save the file to the specified path
                postedFile.SaveAs(savePath)
                returnURL = GetBaseUrl() + folder + "/" + fileName
                ' Store the uploaded file name in session
                Session("UploadedFileName") = fileName
            End If

            '---Save File kat table----
            Dim db As New DBKewConn

            Dim queryC As String = $"Select No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl
                                    WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'BP') AND (No_Item = @No_Item)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", list.mohonID))
            paramC.Add(New SqlParameter("@No_Item", list.idItem))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateDataPelbagai(list) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                list.idItem = GenerateIDPelbagai(list.mohonID)
                If InsertDataPelbagai(list) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            If UpdateTotalPelbagai(list) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If

            If fileName <> "" Then

                resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Else
                resp.Failed("Data Tidak Berjaya Disimpan")
            End If

            'resp.SuccessPayload(New With {.FileName = fileName, .Url = GetBaseUrl() + folder + "/" + fileName})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    Private Function UpdateTotalPelbagai(list As UploadResitTblBP) As String

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Belanja_Pelbagai = @Jumlah_Belanja_Pelbagai                                 
                                WHERE No_Tuntutan = @No_Tuntutan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", list.mohonID))
        param.Add(New SqlParameter("@Jumlah_Belanja_Pelbagai", list.Jumlah))


        Return db.Process(query, param)
    End Function
    Private Function UpdateDataPelbagai(list As UploadResitTblBP)
        Dim db = New DBKewConn

        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName
        'Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/"


        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & list.mohonID

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Belanja_Pelbagai = @Jenis_Belanja_Pelbagai, Flag_Resit = @Flag_Resit, No_Resit = @No_Resit, 
        Jumlah_anggaran = @Jumlah_anggaran, Nama_Fail = @Nama_Fail, Path = @Path, Negara =@Negara , Matawang = Matawang
        where No_Tuntutan= @No_Tuntutan AND  No_Item = @No_Item AND Jns_Dtl_Tuntutan= @Jns_Dtl_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", list.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "BP"))
        param.Add(New SqlParameter("@No_Item", list.idItem))
        param.Add(New SqlParameter("@Jenis_Belanja_Pelbagai", list.JenisBelanjaP))
        param.Add(New SqlParameter("@Flag_Resit", list.FlagResit))
        param.Add(New SqlParameter("@No_Resit", list.ResitNo))
        param.Add(New SqlParameter("@Negara", list.JnsNegara))
        param.Add(New SqlParameter("@Matawang", list.JnsMataWang))
        param.Add(New SqlParameter("@Jumlah_anggaran", list.Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))

        Return db.Process(query, param)
    End Function

    Private Function GenerateIDPelbagai(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='BP'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function

    Private Function InsertDataPelbagai(list As UploadResitTblBP)
        Dim db As New DBKewConn

        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim mohonId As String = list.mohonID
        ' Store the uploaded file name in session
        Session("UploadedFileName") = fileName
        'Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/"

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & list.mohonID)
        End If

        Dim folder As String = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & list.mohonID

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl(No_Tuntutan, Jns_Dtl_Tuntutan, No_Item,  Jenis_Belanja_Pelbagai,  Flag_Resit, No_Resit,  
                         Negara, Matawang, Jumlah_anggaran, Nama_Fail,Path)
                        VALUES(@No_Tuntutan, @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Belanja_Pelbagai , @Flag_Resit, @No_Resit,
                        @Negara, @Matawang,  @Jumlah_anggaran, @Nama_Fail,@Path)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", list.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "BP"))
        param.Add(New SqlParameter("@No_Item", list.idItem))
        param.Add(New SqlParameter("@Jenis_Belanja_Pelbagai", list.JenisBelanjaP))
        param.Add(New SqlParameter("@Flag_Resit", list.FlagResit))
        param.Add(New SqlParameter("@No_Resit", list.ResitNo))
        param.Add(New SqlParameter("@Negara", list.JnsNegara))
        param.Add(New SqlParameter("@Matawang", list.JnsMataWang))
        param.Add(New SqlParameter("@Jumlah_anggaran", list.Jumlah))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))


        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveJumlahPelbagai(id As String, total As Decimal) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Belanja_Pelbagai = @Jumlah_Belanja_Pelbagai                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))
        param.Add(New SqlParameter("@Jumlah_Belanja_Pelbagai", total))

        Return db.Process(query, param)

        resp.Success("Rekod berjaya disimpan", "00", "")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

End Class