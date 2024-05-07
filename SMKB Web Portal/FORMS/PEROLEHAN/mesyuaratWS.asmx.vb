Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.EnterpriseServices
Imports System.IO
Imports iTextSharp.text.log
Imports SMKB_Web_Portal.KPT
Imports SMKB_Web_Portal.JU
Imports System.Data.Entity.Core.Mapping
Imports System.Collections.Generic
Imports System.Data.OleDb
Imports System.Net.Http
Imports System.Threading

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class mesyuaratWS
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    '<WebMethod()> _
    'Public Function HelloWorld() As String
    '    Return "Hello World"
    'End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_Sebut_Harga(IdMohon As String) As String
        Dim resp As New ResponseRepository


        dt = GetOrder_Senarai_Sebut_Harga(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Senarai_Sebut_Harga(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            'query = "

            '            select C.No_Mohon, C.Tujuan, C.Kod_Ptj_Mohon, C.No_Perolehan, D.No_Sebut_Harga from 
            '            SMKB_Perolehan_Pembelian_Hdr As A
            '            inner join SMKB_Perolehan_Pembelian_Dokumen As B On A.Id_Pembelian = B.Id_Pembelian
            '            inner join SMKB_Perolehan_Permohonan_Hdr As C On A.No_Mohon = C.No_Mohon
            '            inner join SMKB_Perolehan_Naskah_Jualan as D on C.No_Mohon = D.No_Mohon
            '            where B.Status_Hantar ='1'
            '            AND (No_Perolehan LIKE ('DS%') OR No_Perolehan LIKE ('DT%'))
            '            group by C.No_Mohon, C.Tujuan, C.Kod_Ptj_Mohon, C.No_Perolehan, D.No_Sebut_Harga

            '        "

            'query = "
            '            SELECT * 
            '            FROM SMKB_Perolehan_Permohonan_Hdr 
            '            WHERE ( (Status_Dok = '07' AND Flag_PenentuanTeknikal = '1') 
            '            OR (Status_Dok = '35' AND Flag_PenentuanTeknikal = '1') )
            '            --AND No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where Status_Dok = '33')
            '            AND (No_Perolehan LIKE ('DS%') OR No_Perolehan LIKE ('DT%'))
            '            ORDER BY No_Mohon
            '        "

            query = "
                         SELECT * 
                         FROM SMKB_Perolehan_Permohonan_Hdr a
	                        INNER JOIN SMKB_Perolehan_Naskah_Jualan b ON b.No_Mohon = a.No_Mohon
                         WHERE Status_Dok = '35' AND Flag_PenentuanTeknikal = '1'
                         AND a.No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where Status_Dok = '47')
                         AND (No_Perolehan LIKE ('DS%') OR No_Perolehan LIKE ('DT%'))
                         ORDER BY a.No_Mohon
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Dtl(Perolehan_Mesyuarat_Detail As Perolehan_Mesyuarat_Detail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Detail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Perolehan_Mesyuarat_Detail.txtIDMesy = Session("sessionIDMesy")
        If InsertPerolehan_Mesyuarat_Dtl(Perolehan_Mesyuarat_Detail.txtIDMesy, Perolehan_Mesyuarat_Detail.ddlNo_Mohon, Perolehan_Mesyuarat_Detail.ddlTurutan) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        ' Update query
        Dim updateResult As String = UpdatePerolehan_Permohonan_Hdr(Perolehan_Mesyuarat_Detail.ddlNo_Mohon)
        If updateResult <> "OK" Then
            resp.Failed("Gagal mengemaskini Status Dokumen")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod= berjaya disimpan", "00", Perolehan_Mesyuarat_Detail)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdatePerolehan_Permohonan_Hdr(ddlNo_Mohon As String) As String
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Perolehan_Permohonan_Hdr SET Status_Dok = '47' WHERE No_Mohon = @ddlNo_Mohon"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@ddlNo_Mohon", ddlNo_Mohon))
        Return db.Process(query, param)
    End Function

    Private Function InsertPerolehan_Mesyuarat_Dtl(txtIDMesy As String, ddlNo_Mohon As String, ddlTurutan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Dtl (ID_Mesy, No_Mohon, Turutan, Status_Dok, Status_Lulus)
        VALUES(@txtIDMesy, @ddlNo_Mohon, @ddlTurutan, '47' ,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlNo_Mohon", ddlNo_Mohon))
        param.Add(New SqlParameter("@ddlTurutan", ddlTurutan))


        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_JK(Perolehan_Mesyuarat_JKD As Perolehan_Mesyuarat_JKD) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_JKD Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Perolehan_Mesyuarat_JKD.txtIDMesy = Session("sessionIDMesy")
        If InsertPerolehan_Mesyuarat_JK(Perolehan_Mesyuarat_JKD.txtIDMesy, Perolehan_Mesyuarat_JKD.ddlNo_Staf, Perolehan_Mesyuarat_JKD.ddlName, Perolehan_Mesyuarat_JKD.ddlEmel, Perolehan_Mesyuarat_JKD.ddlNo_Tel, Perolehan_Mesyuarat_JKD.dllJawatan) <> "OK" Then
            resp.Failed("Gagal Menyimpan Daftar Mesyuarat")
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
        End If
        Dim emailSend_Mesyuarat_JK = EmelStaf_Mesyuarat_JK(Perolehan_Mesyuarat_JKD)

        resp.Success("Rekod berjaya disimpan, ID Mesyuarat : ", Perolehan_Mesyuarat_JKD.txtIDMesy)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function InsertPerolehan_Mesyuarat_JK(txtIDMesy As String, ddlNo_Staf As String, ddlName As String, ddlEmel As String, ddlNo_Tel As String, dllJawatan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_JK (ID_Mesy, No_Staf, Nama, Emel, No_Tel,Jawatan,Kehadiran )
        VALUES(@txtIDMesy, @ddlNo_Staf, @ddlName, @ddlEmel, @ddlNo_Tel, @dllJawatan ,1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlNo_Staf", ddlNo_Staf))
        param.Add(New SqlParameter("@ddlName", ddlName))
        param.Add(New SqlParameter("@ddlEmel", ddlEmel))
        param.Add(New SqlParameter("@ddlNo_Tel", ddlNo_Tel))
        param.Add(New SqlParameter("@dllJawatan", dllJawatan))


        Return db.Process(query, param)
    End Function

    ' Email service START
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function EmelStaf_Mesyuarat_JK(Perolehan_Mesyuarat_JKD As Perolehan_Mesyuarat_JKD) As Tasks.Task(Of String)
        Dim clsCrypto As New clsCrypto
        Dim db As New DBKewConn

        Dim resp As New ResponseRepository
        Dim response = New Response

        Dim fullName_Penerima As String = Perolehan_Mesyuarat_JKD.ddlName
        Dim email_Penerima As String = Perolehan_Mesyuarat_JKD.ddlEmel
        Dim NoStaff_Penerima = Perolehan_Mesyuarat_JKD.ddlNo_Staf
        Dim TarikhLuput = "2024-04-29" 'kenalpasti tarikh active

        Dim IDMsy As String = Perolehan_Mesyuarat_JKD.txtIDMesy
        Dim TarikhMsy As String = Perolehan_Mesyuarat_JKD.ddlTarikh
        Dim MasaMsy As String = Perolehan_Mesyuarat_JKD.ddlMasa
        Dim MasaMsyAPI As String = MasaMsy.Replace(":", ".")
        Dim TempatMsy As String = Perolehan_Mesyuarat_JKD.ddlTempat

        Dim NameSubMenu As String = Perolehan_Mesyuarat_JKD.dllNameSubMenu
        Dim KodSubMenu = Perolehan_Mesyuarat_JKD.dllKodSubMenu 'identify kod sub menu skrin sokong/lulus ikut modul msing2
        Dim NoRujukan = "Null"

        Dim combineData = NoStaff_Penerima + Now() + NoRujukan
        Dim id = Replace(Replace(Replace(clsCrypto.fEncrypt(combineData), "/", "@"), "+", "@"), "%", "@")

        'mula insert
        Dim paramSqlBtrn() As SqlParameter = Nothing
        Dim strSqlButiran = "INSERT INTO SMKB_Emel_Auth (ID_Token, No_Staf_Penerima, Emel_Penerima, Tarikh_Luput_URL, Kod_Sub_Menu, No_Rujukan)
                                            VALUES (@ID_Token, @No_Staf_Penerima, @Emel_Penerima, @Tarikh_Luput_URL, @Kod_Sub_Menu, @No_Rujukan)"
        paramSqlBtrn = {New SqlParameter("@ID_Token", id),
                                New SqlParameter("@No_Staf_Penerima", NoStaff_Penerima),
                                New SqlParameter("@Emel_Penerima", email_Penerima),
                                New SqlParameter("@Tarikh_Luput_URL", TarikhLuput),
                                New SqlParameter("@Kod_Sub_Menu", KodSubMenu),
                                New SqlParameter("@No_Rujukan", NoRujukan)
                            }

        If db.fInsertCommand(strSqlButiran, paramSqlBtrn) > 0 Then

            Dim url As String = "http://localhost:1559/SMKBNet/loginsmkb.aspx?id=" & id 'ResolveUrl("~/loginsmkb.aspx?id=" & id) 

            'Send the New password to the user's email
            Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
            Dim body As String = "PEMBERITAHUAN" &
                         "<br><br>" &
                         vbCrLf & "Assalamualaikum Dan Salam Sejahtera " & fullName_Penerima & "," &
                         "<br><br>" &
                         vbCrLf & "Dengan segala hormatnya, kami menjemput Tuan / Puan untuk menghadiri Mesyuarat " & NameSubMenu & " yang akan diadakan seperti berikut:" &
                         "<br><br>" &
                         vbCrLf & "Tarikh : " & TarikhMsy &
                         "<br><br>" &
                          vbCrLf & "Masa : " & MasaMsy &
                         "<br><br>" &
                          vbCrLf & "Tempat : " & TempatMsy &
                         "<br><br>" &
                         vbCrLf & "Terima kasih atas kerjasama Tuan / Puan." &
                         "<br>" &
                         "<br><br>" &
                         vbCrLf & "Email dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " &
                         "<br><br>" &
                         vbCrLf & "Email ini tidak perlu dibalas."

            'vbCrLf & "ID Mesyuarat : " & IDMsy &
            '"<br><br>" &

            myEmel_Mesyuarat_JK(email_Penerima, subject, body)


            ''Notification API


            ' API endpoint URL
            Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Dengan segala hormatnya, kami menjemput Tuan atau Puan untuk menghadiri Mesyuarat " + NameSubMenu + " pada Tarikh " + TarikhMsy + ", Masa " + MasaMsyAPI + " dan Tempat " + TempatMsy + "/" + NoStaff_Penerima

            Try

                Using client As New HttpClient()
                    Dim content = New FormUrlEncodedContent(New Dictionary(Of String, String)())
                    Dim response1 As HttpResponseMessage = Await client.PostAsync(apiUrl, content)

                    If response1.IsSuccessStatusCode Then
                        'resp.Success("Permohonan perolehan berjaya dihantar.", "00", txtNoMohonR)
                        'response = resp.GetResult()
                    Else
                        resp.Failed("gagal.")
                    End If
                End Using

            Catch ex As Exception
                Dim msg As String = ex.Message
            End Try

            resp.Success("Notifikasi berjaya dihantar.", "00")
            response = resp.GetResult()



        Else
            db.sConnRollbackTrans()
        End If

        Return JsonConvert.SerializeObject(response)
    End Function

    Public strConEmail_Mesyuarat_JK As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    Private Function myEmel_Mesyuarat_JK(alamat, subject, body)
        Dim cnExec As OleDb.OleDbConnection
        Dim cmdExec As OleDb.OleDbCommand

        Try
            cnExec = New OleDb.OleDbConnection(strConEmail_Mesyuarat_JK)
            cnExec.Open()

            cmdExec = New OleDbCommand("EXEC msdb.dbo.sp_send_dbmail @profile_name= 'EmailSmkb', @recipients= '" & alamat & "', @subject = '" & subject & "', " &
                  "@body= '" & Replace(body, "'", "''") & "', @body_format='HTML';", cnExec)
            cmdExec.ExecuteNonQuery()
            cmdExec.Dispose()
            cmdExec = Nothing
            cnExec.Dispose()
            cnExec.Close()
            cnExec = Nothing

            Return 1    'Proses Berjaya
        Catch ex As Exception
            ' Show the exception's message.
            MsgBox(ex.Message)
            Return 0    'Proses Gagal
        End Try

    End Function
    ' Email service END

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Hdr(Perolehan_Mesyuarat_Header As Perolehan_Mesyuarat_Header) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Header Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If Perolehan_Mesyuarat_Header.txtIDMesy = "" Then
            Dim IDMesy As String = GenerateNoMesyuarat(Perolehan_Mesyuarat_Header.ddlKodPTj)
            Session("sessionIDMesy") = IDMesy
            Perolehan_Mesyuarat_Header.txtIDMesy = IDMesy
            Dim tarikhMasa As String = Perolehan_Mesyuarat_Header.ddlTarikh + " " + Perolehan_Mesyuarat_Header.ddlMasa
            Perolehan_Mesyuarat_Header.txtTarikh = tarikhMasa

            If InsertPerolehan_Mesyuarat_Hdr(Perolehan_Mesyuarat_Header.txtIDMesy, Perolehan_Mesyuarat_Header.ddlMasa, Perolehan_Mesyuarat_Header.ddlTarikh, Perolehan_Mesyuarat_Header.ddlTempat, Perolehan_Mesyuarat_Header.ddlJawatankuasa_kod) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Header)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GenerateNoMesyuarat(ddlKodPTj As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newIDMesy As String = ""
        Dim ptj = ddlKodPTj

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='02' AND Prefix ='TM' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir2("02", "TM", year, lastID)
        Else

            InsertNoAkhir2("02", "TM", year, lastID)
        End If
        newIDMesy = "TM" + ptj.ToString + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newIDMesy
    End Function

    Private Function UpdateNoAkhir2(kodModul As String, prefix As String, year As String, ID As String)
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

    Private Function InsertNoAkhir2(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Mohon Pembelian"))
        param.Add(New SqlParameter("@Kod_PTJ", "-")) 'letak session ssusrKodPTj


        Return db.Process(query, param)
    End Function



    Private Function InsertPerolehan_Mesyuarat_Hdr(txtIDMesy As String, ddlMasa As String, ddlTarikh As String, ddlTempat As String, ddlJawatankuasa_kod As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Hdr (IDMesy, Tempat, TarikhMasa, TarikhDaftar,  Kod_JK, Status)
        VALUES(@txtIDMesy, @ddlTempat, @ddlMasa, @ddlTarikh, @ddlJawatankuasa_kod, 1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlMasa", ddlMasa))
        param.Add(New SqlParameter("@ddlTarikh", ddlTarikh))
        param.Add(New SqlParameter("@ddlTempat", ddlTempat))
        param.Add(New SqlParameter("@ddlJawatankuasa_kod", ddlJawatankuasa_kod))


        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Hdr_harga(Perolehan_Mesyuarat_Header As Perolehan_Mesyuarat_Header) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Header Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If Perolehan_Mesyuarat_Header.txtIDMesy = "" Then
            Dim IDMesy As String = GenerateNoMesyuarat(Perolehan_Mesyuarat_Header.ddlKodPTj)
            Session("sessionIDMesy") = IDMesy
            Perolehan_Mesyuarat_Header.txtIDMesy = IDMesy
            Dim tarikhMasa As String = Perolehan_Mesyuarat_Header.ddlTarikh + " " + Perolehan_Mesyuarat_Header.ddlMasa
            Perolehan_Mesyuarat_Header.txtTarikh = tarikhMasa

            If InsertPerolehan_Mesyuarat_Hdr_Harga(Perolehan_Mesyuarat_Header.txtIDMesy, Perolehan_Mesyuarat_Header.ddlMasa, Perolehan_Mesyuarat_Header.ddlTarikh, Perolehan_Mesyuarat_Header.ddlTempat, Perolehan_Mesyuarat_Header.ddlJawatankuasa_kod) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Header)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Dtl_Harga(Perolehan_Mesyuarat_Detail As Perolehan_Mesyuarat_Detail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Detail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Perolehan_Mesyuarat_Detail.txtIDMesy = Session("sessionIDMesy")
        If InsertPerolehan_Mesyuarat_Dtl_Harga(Perolehan_Mesyuarat_Detail.txtIDMesy, Perolehan_Mesyuarat_Detail.ddlNo_Mohon, Perolehan_Mesyuarat_Detail.ddlTurutan) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Detail)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function InsertPerolehan_Mesyuarat_Dtl_Harga(txtIDMesy As String, ddlNo_Mohon As String, ddlTurutan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Dtl (ID_Mesy, No_Mohon, Turutan, Status_Dok, Status_Lulus)
        VALUES(@txtIDMesy, @ddlNo_Mohon, @ddlTurutan, '49' ,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlNo_Mohon", ddlNo_Mohon))
        param.Add(New SqlParameter("@ddlTurutan", ddlTurutan))


        Return db.Process(query, param)
    End Function

    Private Function InsertPerolehan_Mesyuarat_Hdr_Harga(txtIDMesy As String, ddlMasa As String, ddlTarikh As String, ddlTempat As String, ddlJawatankuasa_kod As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Hdr (IDMesy, Tempat, TarikhMasa, TarikhDaftar,  Kod_JK, Status)
        VALUES(@txtIDMesy, @ddlTempat, @ddlMasa, @ddlTarikh, @ddlJawatankuasa_kod, 1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlMasa", ddlMasa))
        param.Add(New SqlParameter("@ddlTarikh", ddlTarikh))
        param.Add(New SqlParameter("@ddlTempat", ddlTempat))
        param.Add(New SqlParameter("@ddlJawatankuasa_kod", ddlJawatankuasa_kod))


        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Hdr_Teknikal(Perolehan_Mesyuarat_Header As Perolehan_Mesyuarat_Header) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Header Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If Perolehan_Mesyuarat_Header.txtIDMesy = "" Then
            Dim IDMesy As String = GenerateNoMesyuarat(Perolehan_Mesyuarat_Header.ddlKodPTj)
            Session("sessionIDMesy") = IDMesy
            Perolehan_Mesyuarat_Header.txtIDMesy = IDMesy
            Dim tarikhMasa As String = Perolehan_Mesyuarat_Header.ddlTarikh + " " + Perolehan_Mesyuarat_Header.ddlMasa
            Perolehan_Mesyuarat_Header.txtTarikh = tarikhMasa

            If InsertPerolehan_Mesyuarat_Hdr_Teknikal(Perolehan_Mesyuarat_Header.txtIDMesy, Perolehan_Mesyuarat_Header.ddlMasa, Perolehan_Mesyuarat_Header.ddlTarikh, Perolehan_Mesyuarat_Header.ddlTempat, Perolehan_Mesyuarat_Header.ddlJawatankuasa_kod) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Header)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPerolehan_Mesyuarat_Hdr_Teknikal(txtIDMesy As String, ddlMasa As String, ddlTarikh As String, ddlTempat As String, ddlJawatankuasa_kod As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Hdr (IDMesy, Tempat, TarikhMasa, TarikhDaftar,  Kod_JK, Status)
        VALUES(@txtIDMesy, @ddlTempat, @ddlMasa, @ddlTarikh, @ddlJawatankuasa_kod, 1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlMasa", ddlMasa))
        param.Add(New SqlParameter("@ddlTarikh", ddlTarikh))
        param.Add(New SqlParameter("@ddlTempat", ddlTempat))
        param.Add(New SqlParameter("@ddlJawatankuasa_kod", ddlJawatankuasa_kod))


        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Dtl_Teknikal(Perolehan_Mesyuarat_Detail As Perolehan_Mesyuarat_Detail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Detail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Perolehan_Mesyuarat_Detail.txtIDMesy = Session("sessionIDMesy")
        If InsertPerolehan_Mesyuarat_Dtl_Teknikal(Perolehan_Mesyuarat_Detail.txtIDMesy, Perolehan_Mesyuarat_Detail.ddlNo_Mohon, Perolehan_Mesyuarat_Detail.ddlTurutan) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Detail)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function InsertPerolehan_Mesyuarat_Dtl_Teknikal(txtIDMesy As String, ddlNo_Mohon As String, ddlTurutan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Dtl (ID_Mesy, No_Mohon, Turutan, Status_Dok, Status_Lulus)
        VALUES(@txtIDMesy, @ddlNo_Mohon, @ddlTurutan, '51' ,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlNo_Mohon", ddlNo_Mohon))
        param.Add(New SqlParameter("@ddlTurutan", ddlTurutan))


        Return db.Process(query, param)
    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Hdr_Pengesyoran(Perolehan_Mesyuarat_Header As Perolehan_Mesyuarat_Header) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Header Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If Perolehan_Mesyuarat_Header.txtIDMesy = "" Then
            Dim IDMesy As String = GenerateNoMesyuarat(Perolehan_Mesyuarat_Header.ddlKodPTj)
            Session("sessionIDMesy") = IDMesy
            Perolehan_Mesyuarat_Header.txtIDMesy = IDMesy
            Dim tarikhMasa As String = Perolehan_Mesyuarat_Header.ddlTarikh + " " + Perolehan_Mesyuarat_Header.ddlMasa
            Perolehan_Mesyuarat_Header.txtTarikh = tarikhMasa

            If InsertPerolehan_Mesyuarat_Hdr_Teknikal(Perolehan_Mesyuarat_Header.txtIDMesy, Perolehan_Mesyuarat_Header.ddlMasa, Perolehan_Mesyuarat_Header.ddlTarikh, Perolehan_Mesyuarat_Header.ddlTempat, Perolehan_Mesyuarat_Header.ddlJawatankuasa_kod) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Header)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPerolehan_Mesyuarat_Hdr_Pengesyoran(txtIDMesy As String, ddlMasa As String, ddlTarikh As String, ddlTempat As String, ddlJawatankuasa_kod As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Hdr (IDMesy, Tempat, TarikhMasa, TarikhDaftar,  Kod_JK, Status)
        VALUES(@txtIDMesy, @ddlTempat, @ddlMasa, @ddlTarikh, @ddlJawatankuasa_kod, 1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlMasa", ddlMasa))
        param.Add(New SqlParameter("@ddlTarikh", ddlTarikh))
        param.Add(New SqlParameter("@ddlTempat", ddlTempat))
        param.Add(New SqlParameter("@ddlJawatankuasa_kod", ddlJawatankuasa_kod))


        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Dtl_Pengesyoran(Perolehan_Mesyuarat_Detail As Perolehan_Mesyuarat_Detail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Detail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Perolehan_Mesyuarat_Detail.txtIDMesy = Session("sessionIDMesy")
        If InsertPerolehan_Mesyuarat_Dtl_Pengesyoran(Perolehan_Mesyuarat_Detail.txtIDMesy, Perolehan_Mesyuarat_Detail.ddlNo_Mohon, Perolehan_Mesyuarat_Detail.ddlTurutan) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Detail)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function InsertPerolehan_Mesyuarat_Dtl_Pengesyoran(txtIDMesy As String, ddlNo_Mohon As String, ddlTurutan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Dtl (ID_Mesy, No_Mohon, Turutan, Status_Dok, Status_Lulus)
        VALUES(@txtIDMesy, @ddlNo_Mohon, @ddlTurutan, '53' ,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlNo_Mohon", ddlNo_Mohon))
        param.Add(New SqlParameter("@ddlTurutan", ddlTurutan))


        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Hdr_Lantik(Perolehan_Mesyuarat_Header As Perolehan_Mesyuarat_Header) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Header Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If Perolehan_Mesyuarat_Header.txtIDMesy = "" Then
            Dim IDMesy As String = GenerateNoMesyuarat(Perolehan_Mesyuarat_Header.ddlKodPTj)
            Session("sessionIDMesy") = IDMesy
            Perolehan_Mesyuarat_Header.txtIDMesy = IDMesy
            Dim tarikhMasa As String = Perolehan_Mesyuarat_Header.ddlTarikh + " " + Perolehan_Mesyuarat_Header.ddlMasa
            Perolehan_Mesyuarat_Header.txtTarikh = tarikhMasa

            If InsertPerolehan_Mesyuarat_Hdr_Lantik(Perolehan_Mesyuarat_Header.txtIDMesy, Perolehan_Mesyuarat_Header.ddlMasa, Perolehan_Mesyuarat_Header.ddlTarikh, Perolehan_Mesyuarat_Header.ddlTempat, Perolehan_Mesyuarat_Header.ddlJawatankuasa_kod) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Return JsonConvert.SerializeObject(resp.GetResult())
                'Exit Function
            End If

        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Header)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPerolehan_Mesyuarat_Hdr_Lantik(txtIDMesy As String, ddlMasa As String, ddlTarikh As String, ddlTempat As String, ddlJawatankuasa_kod As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Hdr (IDMesy, Tempat, TarikhMasa, TarikhDaftar,  Kod_JK, Status)
        VALUES(@txtIDMesy, @ddlTempat, @ddlMasa, @ddlTarikh, @ddlJawatankuasa_kod, 1)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlMasa", ddlMasa))
        param.Add(New SqlParameter("@ddlTarikh", ddlTarikh))
        param.Add(New SqlParameter("@ddlTempat", ddlTempat))
        param.Add(New SqlParameter("@ddlJawatankuasa_kod", ddlJawatankuasa_kod))


        Return db.Process(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SavePerolehan_Mesyuarat_Dtl_Lantik(Perolehan_Mesyuarat_Detail As Perolehan_Mesyuarat_Detail) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If Perolehan_Mesyuarat_Detail Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Perolehan_Mesyuarat_Detail.txtIDMesy = Session("sessionIDMesy")
        If InsertPerolehan_Mesyuarat_Dtl_Lantik(Perolehan_Mesyuarat_Detail.txtIDMesy, Perolehan_Mesyuarat_Detail.ddlNo_Mohon, Perolehan_Mesyuarat_Detail.ddlTurutan) <> "OK" Then
            resp.Failed("Gagal Menyimpan order")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", Perolehan_Mesyuarat_Detail)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPerolehan_Mesyuarat_Dtl_Lantik(txtIDMesy As String, ddlNo_Mohon As String, ddlTurutan As String) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Perolehan_Mesyuarat_Dtl (ID_Mesy, No_Mohon, Turutan, Status_Dok, Status_Lulus)
        VALUES(@txtIDMesy, @ddlNo_Mohon, @ddlTurutan, '55' ,'1')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@txtIDMesy", txtIDMesy))
        param.Add(New SqlParameter("@ddlNo_Mohon", ddlNo_Mohon))
        param.Add(New SqlParameter("@ddlTurutan", ddlTurutan))


        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_Sebut_Harga_PenHarga(IdMohon As String) As String
        Dim resp As New ResponseRepository


        dt = GetOrder_Senarai_Sebut_Harga_PenHarga(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Senarai_Sebut_Harga_PenHarga(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                       
                        SELECT * 
                        FROM SMKB_Perolehan_Permohonan_Hdr a
						INNER JOIN SMKB_Perolehan_Naskah_Jualan b ON b.No_Mohon = a.No_Mohon
                        WHERE  (Status_Dok = '48' AND Flag_PenentuanTeknikal = '1')
                        AND a.No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where (Status_Dok = '49' or Status_Dok = '50') )
                        AND (No_Perolehan LIKE ('DS%') OR No_Perolehan LIKE ('DT%'))
                        ORDER BY a.No_Mohon

                    "
            'AND No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where Status_Dok = '48')
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_Sebut_Harga_PenTeknikal(IdMohon As String) As String
        Dim resp As New ResponseRepository


        dt = GetOrder_Senarai_Sebut_Harga_PenTeknikal(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Senarai_Sebut_Harga_PenTeknikal(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                       
                        SELECT * 
                        FROM SMKB_Perolehan_Permohonan_Hdr a
						INNER JOIN SMKB_Perolehan_Naskah_Jualan b ON b.No_Mohon = a.No_Mohon
                        WHERE  (Status_Dok = '48' AND Flag_PenentuanTeknikal = '1')
                        AND a.No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where (Status_Dok = '51' or Status_Dok = '52') )
                        AND (No_Perolehan LIKE ('DS%') OR No_Perolehan LIKE ('DT%'))
                        ORDER BY a.No_Mohon

                    "
            'AND No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where Status_Dok = '48')
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_Sebut_Harga_Pengesyoran(IdMohon As String) As String
        Dim resp As New ResponseRepository


        dt = GetOrder_Senarai_Sebut_Harga_Pengesyoran(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Senarai_Sebut_Harga_Pengesyoran(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""


            query = "
                       
                        SELECT * 
                        FROM SMKB_Perolehan_Permohonan_Hdr a
                        INNER JOIN SMKB_Perolehan_Naskah_Jualan b ON b.No_Mohon = a.No_Mohon
                        WHERE (a.Status_Dok = '52' AND a.Flag_PHarga = '1' AND a.Flag_PTeknikal = '1') 
                        AND a.No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where (Status_Dok = '53' or Status_Dok = '54') )
                        AND (No_Perolehan LIKE ('DS%') OR No_Perolehan LIKE ('DT%'))
                        ORDER BY a.No_Mohon

                    "
            'AND No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where Status_Dok = '48')
            'WHERE (a.Status_Dok = '48' AND a.Flag_PHarga = '1' AND a.Flag_PTeknikal = '1') 
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai_Sebut_Harga_Lantik(IdMohon As String) As String
        Dim resp As New ResponseRepository


        dt = GetOrder_Senarai_Sebut_Harga_Lantik(IdMohon)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Senarai_Sebut_Harga_Lantik(IdMohon As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            Dim CURRENT_DATE As DateTime = DateTime.Now

            query = "
                       
                         SELECT  a.No_Perolehan,a.No_Mohon,b.No_Sebut_Harga,a.Tujuan
                         FROM SMKB_Perolehan_Permohonan_Hdr a
                             INNER JOIN SMKB_Perolehan_Naskah_Jualan b ON b.No_Mohon = a.No_Mohon
                             INNER JOIN SMKB_Perolehan_Pembelian_hdr c ON b.No_Mohon = a.No_Mohon
                             INNER JOIN SMKB_Perolehan_Bidaan_Hdr d ON b.No_Sebut_Harga = d.No_Sebut_Harga
                         WHERE  
                             (
                             (a.Status_Dok = '54' AND a.Flag_Ebidding = '0' AND c.Keputusan_Syor = '1') 
                             OR  
                             (a.Status_Dok = '54' AND a.Flag_Ebidding = '2' AND c.Keputusan_Syor = '1'  AND (d.Tarikh_Tamat < @CURRENT_DATE))
                             )
                         AND a.No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where (Status_Dok = '55' or Status_Dok = '56') )
                         AND (a.No_Perolehan LIKE 'DS%' OR a.No_Perolehan LIKE 'DT%')
                         Group by a.No_Perolehan,a.No_Mohon,b.No_Sebut_Harga,a.Tujuan
                         ORDER BY a.No_Mohon

                    "
            'AND No_Mohon not in (select No_Mohon from SMKB_Perolehan_Mesyuarat_Dtl where Status_Dok = '48')
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@IdMohon", IdMohon))
            cmd.Parameters.Add(New SqlParameter("@CURRENT_DATE", CURRENT_DATE))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    '-----------------------JAWATANKUASA PENILAIAN MESYUARAT----------------------------

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Jawatan_Kuasa_Pembuka(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKod_Jawatan_kuasaPembuka(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetKod_Jawatan_kuasaPembuka(Kod_Jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
                    SELECT Kod_Jawatankuasa as kodValue, CONCAT(Kod_Jawatankuasa, ' - ', Butiran) as text
                    FROM SMKB_Perolehan_Jawatankuasa 
					WHERE Kod_Jawatankuasa like '%JPP%' or  Kod_Jawatankuasa like '%JPU%'
                    ORDER BY Kod_Jawatankuasa 

                    "
        Dim param As New List(Of SqlParameter)

        If Kod_Jawatankuasa <> "" Then
            query &= " AND (Kod_Jawatankuasa LIKE '%' + @Kod_Jawatankuasa + '%') "
            param.Add(New SqlParameter("@Kod_Jawatankuasa", Kod_Jawatankuasa))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Jawatan_Kuasa_Harga(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKod_Jawatan_kuasaHarga(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetKod_Jawatan_kuasaHarga(Kod_Jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
                    SELECT Kod_Jawatankuasa as kodValue, CONCAT(Kod_Jawatankuasa, ' - ', Butiran) as text
                    FROM SMKB_Perolehan_Jawatankuasa 
					WHERE Kod_Jawatankuasa like '%JHP%' or  Kod_Jawatankuasa like '%JHU%'
                    ORDER BY Kod_Jawatankuasa 

                    "
        Dim param As New List(Of SqlParameter)

        If Kod_Jawatankuasa <> "" Then
            query &= " AND (Kod_Jawatankuasa LIKE '%' + @Kod_Jawatankuasa + '%') "
            param.Add(New SqlParameter("@Kod_Jawatankuasa", Kod_Jawatankuasa))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Jawatan_Kuasa_Pengesyoran(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKod_Jawatan_kuasaPengesyoran(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetKod_Jawatan_kuasaPengesyoran(Kod_Jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
                    SELECT Kod_Jawatankuasa as kodValue, CONCAT(Kod_Jawatankuasa, ' - ', Butiran) as text
                    FROM SMKB_Perolehan_Jawatankuasa 
					WHERE Kod_Jawatankuasa like '%JSP%' or  Kod_Jawatankuasa like '%JSU%' 
                    ORDER BY Kod_Jawatankuasa

                    "
        Dim param As New List(Of SqlParameter)

        If Kod_Jawatankuasa <> "" Then
            query &= " AND (Kod_Jawatankuasa LIKE '%' + @Kod_Jawatankuasa + '%') "
            param.Add(New SqlParameter("@Kod_Jawatankuasa", Kod_Jawatankuasa))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Jawatan_Kuasa_Lantik(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKod_Jawatan_kuasaLantik(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetKod_Jawatan_kuasaLantik(Kod_Jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
                    SELECT Kod_Jawatankuasa as kodValue, CONCAT(Kod_Jawatankuasa, ' - ', Butiran) as text
                    FROM SMKB_Perolehan_Jawatankuasa 
					WHERE Kod_Jawatankuasa like '%JLP%' or  Kod_Jawatankuasa like '%JLU%'
                    ORDER BY Kod_Jawatankuasa

                    "
        Dim param As New List(Of SqlParameter)

        If Kod_Jawatankuasa <> "" Then
            query &= " AND (Kod_Jawatankuasa LIKE '%' + @Kod_Jawatankuasa + '%') "
            param.Add(New SqlParameter("@Kod_Jawatankuasa", Kod_Jawatankuasa))
        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_Jawatan_Kuasa_Teknikal(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKod_Jawatan_kuasaTeknikal(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetKod_Jawatan_kuasaTeknikal(Kod_Jawatankuasa As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "
                    SELECT Kod_Jawatankuasa as kodValue, CONCAT(Kod_Jawatankuasa, ' - ', Butiran) as text
                    FROM SMKB_Perolehan_Jawatankuasa 
					WHERE Kod_Jawatankuasa like '%JTP%' or  Kod_Jawatankuasa like '%JTU%' or  Kod_Jawatankuasa like '%JTI%'
                    ORDER BY Kod_Jawatankuasa

                    "
        Dim param As New List(Of SqlParameter)

        If Kod_Jawatankuasa <> "" Then
            query &= " AND (Kod_Jawatankuasa LIKE '%' + @Kod_Jawatankuasa + '%') "
            param.Add(New SqlParameter("@Kod_Jawatankuasa", Kod_Jawatankuasa))
        End If

        Return db.Read(query, param)
    End Function

End Class