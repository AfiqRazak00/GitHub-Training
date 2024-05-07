Imports System.ComponentModel
Imports System.Data.SqlClient
Imports System.Net.Http
'Imports Microsoft.Office.Interop.Excel
Imports System.Globalization
Imports Newtonsoft.Json
Imports System.Web.Script.Services


Public Class SMKB_API
    Private Shared Property domain As String = "http://devmis.utem.edu.my/SMKBNet/api/"
    Public Shared Function MakeHttpPostRequest(uidHeader As String, order As AR_Order) As Boolean
        Dim url As String = SMKB_API.domain + "/AR"

        Using httpClient As New HttpClient()
            Dim request As New HttpRequestMessage(HttpMethod.Post, url)

            ' Set headers using HttpRequestMessage
            request.Headers.TryAddWithoutValidation("UID", uidHeader)
            request.Content = New StringContent(Newtonsoft.Json.JsonConvert.SerializeObject(order), Text.Encoding.UTF8, "application/json")

            ' Send the request
            Dim response As HttpResponseMessage = httpClient.SendAsync(request).Result

            If response.IsSuccessStatusCode Then
                ' Print the response
                Console.WriteLine("Response: " & response.Content.ReadAsStringAsync().Result)
                Return True
            Else
                ' Print an error message to the console or log it
                Console.WriteLine("Error: " & CInt(response.StatusCode) & " - " & response.ReasonPhrase)
                Return False
            End If
        End Using
    End Function
    Public Shared Function MakeHttpPostRequestAP(uidHeader As String, order As AP_Order) As Boolean
        Dim url As String = SMKB_API.domain + "/AP"

        Using httpClient As New HttpClient()
            Dim request As New HttpRequestMessage(HttpMethod.Post, url)

            ' Set headers using HttpRequestMessage
            request.Headers.TryAddWithoutValidation("UID", uidHeader)
            request.Content = New StringContent(Newtonsoft.Json.JsonConvert.SerializeObject(order), Text.Encoding.UTF8, "application/json")

            ' Send the request
            Dim response As HttpResponseMessage = httpClient.SendAsync(request).Result

            If response.IsSuccessStatusCode Then
                ' Print the response
                Console.WriteLine("Response: " & response.Content.ReadAsStringAsync().Result)
                Return True
            Else
                ' Print an error message to the console or log it
                Console.WriteLine("Error: " & CInt(response.StatusCode) & " - " & response.ReasonPhrase)
                Return False
            End If
        End Using
    End Function
    Public Shared Function GetPemiutang(kod As String, Kat As String) As String
        Dim db As New DBKewConn
        Dim kodPemiutang As String = ""
        Dim dt As DataTable
        Dim sql As String = "SELECT Kod_Pemiutang FROM SMKB_Pemiutang_Master WHERE (No_Rujukan=@kod OR Kod_Pemiutang=@kod_1 ) AND Status=@Status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod_1", kod))
        param.Add(New SqlParameter("@Status", 1))


        dt = db.Read(sql, param)

        If dt.Rows.Count = 0 Then
            'kod pemiutang tidak wujud
            kodPemiutang = PemiutangWS.GeneratePemiutangID()
            Dim result = InsertPemiutang(kod, Kat, kodPemiutang)
            Return kodPemiutang
        Else
            'kod pemiutang wujud
            kodPemiutang = dt.Rows(0).Item("Kod_Pemiutang")
        End If
        Return kodPemiutang
    End Function
    Public Shared Function InsertPemiutang(kod As String, Kat As String, kodPemiutang As String) As String
        Dim db As New DBKewConn

        If Kat = "ST" Then
            Dim dbstaf As New DBSMConn
            Dim data_staf As String = "SELECT TOP 1 MS01_Nama,MS01_NoStaf FROM MS01_Peribadi WHERE MS01_NoStaf=@kod"
            Dim param1 As New List(Of SqlParameter)
            param1.Add(New SqlParameter("@kod", kod))

            Dim dt1 As DataTable
            dt1 = dbstaf.Read(data_staf, param1)

            If dt1.Rows.Count > 0 Then

                Dim sql As String = "INSERT INTO SMKB_Pemiutang_Master (Kod_Pemiutang,No_Rujukan,Nama_Pemiutang,Kategori_Pemiutang,Status) VALUES (@kod,@No_Rujukan,@Nama,@kategori,@Status) "
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPemiutang))
                param.Add(New SqlParameter("@No_Rujukan", dt1.Rows(0).Item("MS01_NoStaf")))
                param.Add(New SqlParameter("@Nama", dt1.Rows(0).Item("MS01_Nama")))
                param.Add(New SqlParameter("@kategori", dt1.Rows(0).Item("Kategori_Pemiutang")))
                param.Add(New SqlParameter("@Status", 1))

                Return db.Process(sql, param)

            End If
        ElseIf Kat = "PL" Then
            Dim dbPelajar As New DBSMPConn
            Dim data_pelajar As String = "SELECT '' AS Kod_Penghutang ,SMP01_Nama,'PL' AS SMP01_KATEGORI, SMP01_NoAkaun ,B.Fakulti AS SMP01_Alamat1,'JALAN HANG TUAH JAYA' AS SMP01_Alamat2,'76100' AS SMP01_Poskod,'04' AS SMP01_Negeri,
                                            'MY' AS SMP01_Negara ,SMP01_NoTel,SMP01_Nomatrik+'@student.utem.edu.my' AS SMP01_Emel, SMP01_Nomatrik, '02' AS KATEGORI_ID,'1' AS STATUS,'040305' AS BANDAR,SMP01_Bank,B.Kod_Fakulti
                                            FROM SMP01_Peribadi A
                                            JOIN SMP_Fakulti B ON A.SMP01_Fakulti=B.Kod_Fakulti 
                                            WHERE SMP01_Status='AKTIF' AND SMP01_Nomatrik = @kod
                                            ORDER BY SMP01_Nomatrik"
            Dim param2 As New List(Of SqlParameter)
            param2.Add(New SqlParameter("@kod", kod))

            Dim dt As DataTable
            dt = dbPelajar.Read(data_pelajar, param2)

            If dt.Rows.Count > 0 Then

                Dim kodPejabat = getPejabat(dt.Rows(0).Item("Kod_Fakulti"))

                Dim sql As String = "INSERT INTO SMKB_Pemiutang_Master(Kod_Pemiutang,No_Rujukan,Nama_Pemiutang,Kategori_Pemiutang,Alamat_1,Alamat_2,Poskod,Bandar,Kod_Negeri,Kod_Negara,Tel_Bimbit,Emel,Kod_Bank,No_Akaun,Status) 
                                    VALUES 
                                    (@kod,@No_Rujukan,@Nama,@Kategori_Pemiutang,@Alamat_1,@Alamat_2,@Poskod,@Bandar,@Kod_Negeri,@Kod_Negara,@Tel_Bimbit,@Emel,@Kod_Bank,@No_Akaun,@Status)"
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPemiutang))
                param.Add(New SqlParameter("@No_Rujukan", dt.Rows(0).Item("SMP01_Nomatrik")))
                param.Add(New SqlParameter("@Nama", dt.Rows(0).Item("SMP01_Nama")))
                param.Add(New SqlParameter("@Kategori_Pemiutang", dt.Rows(0).Item("SMP01_KATEGORI")))
                param.Add(New SqlParameter("@Alamat_1", dt.Rows(0).Item("SMP01_Alamat1")))
                param.Add(New SqlParameter("@Alamat_2", dt.Rows(0).Item("SMP01_Alamat2")))
                param.Add(New SqlParameter("@Poskod", dt.Rows(0).Item("SMP01_Poskod")))
                param.Add(New SqlParameter("@Bandar", dt.Rows(0).Item("BANDAR")))
                param.Add(New SqlParameter("@Kod_Negeri", dt.Rows(0).Item("SMP01_Negeri")))
                param.Add(New SqlParameter("@Kod_Negara", dt.Rows(0).Item("SMP01_Negara")))
                param.Add(New SqlParameter("@Tel_Bimbit", dt.Rows(0).Item("SMP01_NoTel")))
                param.Add(New SqlParameter("@Emel", dt.Rows(0).Item("SMP01_Emel")))
                param.Add(New SqlParameter("@Kod_Bank", dt.Rows(0).Item("SMP01_Bank")))
                param.Add(New SqlParameter("@No_Akaun", dt.Rows(0).Item("SMP01_NoAkaun")))
                param.Add(New SqlParameter("@Status", dt.Rows(0).Item("STATUS")))

                Return db.Process(sql, param)

            End If

        ElseIf Kat = "PG" Then
            Dim dbPelajar As New DBSMPConn
            Dim data_pelajar As String = "SELECT '' AS Kod_Penghutang ,SMG02_NAMA, 'PG' AS SMG01_KATEGORI,SMG02_NoAkaun,C.Fakulti AS ALAMAT,'JALAN HANG TUAH JAYA' AS SMG01_Alamat2,'76100' AS SMG01_Poskod,'04' AS SMP01_Negeri, 
                                        'MY' AS SMG01_Negara, SMG02_NOTEL, B.SMG01_NOMATRIK+'@student.utem.edu.my' AS SMP01_Emel,B.SMG01_NOMATRIK, '02' AS KATEGORI_ID,'1' AS STATUS, 'MELAKA' AS BANDAR,'' AS KODBANK, C.Kod_Fakulti
                                        FROM SMG01_PENGAJIAN A, SMG02_Peribadi B, SMG_FAKULTI C 
                                        WHERE SMG01_STATUS = 'AKTIF' AND A.SMG01_NOMATRIK=B.SMG01_NOMATRIK AND B.SMG01_NOMATRIK=@kod
                                        AND C.Status='1' AND A.SMG01_KODFAKULTI=C.Kod_Fakulti"
            Dim param2 As New List(Of SqlParameter)
            param2.Add(New SqlParameter("@kod", kod))

            Dim dt As DataTable
            dt = dbPelajar.Read(data_pelajar, param2)

            If dt.Rows.Count > 0 Then

                Dim kodPejabat = getPejabat(dt.Rows(0).Item("Kod_Fakulti"))

                Dim sql As String = "INSERT INTO SMKB_Pemiutang_Master(Kod_Pemiutang,No_Rujukan,Nama_Pemiutang,Kategori_Pemiutang,Alamat_1,Alamat_2,Poskod,Bandar,Kod_Negeri,Kod_Negara,Tel_Bimbit,Emel,Kod_Bank,No_Akaun,Status) 
                                    VALUES 
                                    (@kod,@No_Rujukan,@Nama,@Kategori_Pemiutang,@Alamat_1,@Alamat_2,@Poskod,@Bandar,@Kod_Negeri,@Kod_Negara,@Tel_Bimbit,@Emel,@Kod_Bank,@No_Akaun,@Status)"
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPemiutang))
                param.Add(New SqlParameter("@No_Rujukan", dt.Rows(0).Item("SMG01_NOMATRIK")))
                param.Add(New SqlParameter("@Nama", dt.Rows(0).Item("SMG02_NAMA")))
                param.Add(New SqlParameter("@Kategori_Penghutang", dt.Rows(0).Item("SMG01_KATEGORI")))
                param.Add(New SqlParameter("@Alamat_1", dt.Rows(0).Item("ALAMAT")))
                param.Add(New SqlParameter("@Alamat_2", dt.Rows(0).Item("SMG01_Alamat2")))
                param.Add(New SqlParameter("@Poskod", dt.Rows(0).Item("SMG01_Poskod")))
                param.Add(New SqlParameter("@Bandar", dt.Rows(0).Item("BANDAR")))
                param.Add(New SqlParameter("@Kod_Negeri", dt.Rows(0).Item("SMP01_Negeri")))
                param.Add(New SqlParameter("@Kod_Negara", dt.Rows(0).Item("SMG01_Negara")))
                param.Add(New SqlParameter("@Tel_Bimbit", dt.Rows(0).Item("SMG02_NOTEL")))
                param.Add(New SqlParameter("@Emel", dt.Rows(0).Item("SMP01_Emel")))
                param.Add(New SqlParameter("@Kod_Bank", "-"))
                param.Add(New SqlParameter("@No_Akaun", "-"))
                param.Add(New SqlParameter("@Status", dt.Rows(0).Item("STATUS")))
                param.Add(New SqlParameter("@Kod_Pejabat", kodPejabat))

                Return db.Process(sql, param)

            End If

        ElseIf Kat = "PH" Then
            Dim dbPelajarSH As New DBSMPSHConn
            Dim data_pelajar As String = "SELECT '' AS Kod_Penghutang ,SMP01_Nama,'PH' AS SMP01_KATEGORI, SMP01_NoAkaun ,B.Fakulti AS SMP01_Alamat1,'JALAN HANG TUAH JAYA' AS SMP01_Alamat2,'76100' AS SMP01_Poskod,'04' AS SMP01_Negeri, 
                                        'MY' AS SMP01_Negara ,SMP01_NoTel,SMP01_Nomatrik+'@student.utem.edu.my' AS SMP01_Emel, SMP01_Nomatrik, '02' AS KATEGORI_ID,'1' AS STATUS,'040305' AS BANDAR,SMP01_Bank,B.Kod_Fakulti 
                                        FROM SMP01_Peribadi A 
                                        JOIN SMP_Fakulti B ON A.SMP01_Fakulti=B.Kod_Fakulti WHERE SMP01_Status='AKTIF' AND SMP01_Nomatrik=@kod"
            Dim param2 As New List(Of SqlParameter)
            param2.Add(New SqlParameter("@kod", kod))

            Dim dt As DataTable
            dt = dbPelajarSH.Read(data_pelajar, param2)

            If dt.Rows.Count > 0 Then

                Dim kodPejabat = getPejabat(dt.Rows(0).Item("Kod_Fakulti"))

                Dim sql As String = "INSERT INTO SMKB_Pemiutang_Master(Kod_Pemiutang,No_Rujukan,Nama_Pemiutang,Kategori_Pemiutang,Alamat_1,Alamat_2,Poskod,Bandar,Kod_Negeri,Kod_Negara,Tel_Bimbit,Emel,Kod_Bank,No_Akaun,Status) 
                                    VALUES 
                                    (@kod,@No_Rujukan,@Nama,@Kategori_Pemiutang,@Alamat_1,@Alamat_2,@Poskod,@Bandar,@Kod_Negeri,@Kod_Negara,@Tel_Bimbit,@Emel,@Kod_Bank,@No_Akaun,@Status)"
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPemiutang))
                param.Add(New SqlParameter("@No_Rujukan", dt.Rows(0).Item("SMP01_Nomatrik")))
                param.Add(New SqlParameter("@Nama", dt.Rows(0).Item("SMP01_Nama")))
                param.Add(New SqlParameter("@Kategori_Pemiutang", dt.Rows(0).Item("SMP01_KATEGORI")))
                param.Add(New SqlParameter("@Alamat_1", dt.Rows(0).Item("SMP01_Alamat1")))
                param.Add(New SqlParameter("@Alamat_2", dt.Rows(0).Item("SMP01_Alamat2")))
                param.Add(New SqlParameter("@Poskod", dt.Rows(0).Item("SMP01_Poskod")))
                param.Add(New SqlParameter("@Bandar", dt.Rows(0).Item("BANDAR")))
                param.Add(New SqlParameter("@Kod_Negeri", dt.Rows(0).Item("SMP01_Negeri")))
                param.Add(New SqlParameter("@Kod_Negara", dt.Rows(0).Item("SMP01_Negara")))
                param.Add(New SqlParameter("@Tel_Bimbit", dt.Rows(0).Item("SMP01_NoTel")))
                param.Add(New SqlParameter("@Emel", dt.Rows(0).Item("SMP01_Emel")))
                param.Add(New SqlParameter("@Kod_Bank", "-"))
                param.Add(New SqlParameter("@No_Akaun", "-"))
                param.Add(New SqlParameter("@Status", dt.Rows(0).Item("STATUS")))

                Return db.Process(sql, param)

            End If
        End If

        Return kodPemiutang
    End Function

    Public Shared Function GetPenghutang(kod As String, Kat As String) As String
        Dim db As New DBKewConn
        Dim kodPenghutang As String = ""
        Dim dt As DataTable
        Dim sql As String = "SELECT Kod_Penghutang FROM SMKB_Penghutang_Master WHERE (No_Rujukan=@kod OR Kod_Penghutang=@kod_1 ) AND Status=@Status"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod_1", kod))
        param.Add(New SqlParameter("@Status", 1))


        dt = db.Read(sql, param)

        If dt.Rows.Count = 0 Then
            'kod pemiutang tidak wujud
            kodPenghutang = PenghutangWS.GeneratePenghutangID()
            Dim result = InsertPenghutang(kod, Kat, kodPenghutang)
            Return kodPenghutang
        Else
            'kod pemiutang wujud
            kodPenghutang = dt.Rows(0).Item("Kod_Penghutang")
        End If
        Return kodPenghutang
    End Function
    Public Shared Function InsertPenghutang(kod As String, Kat As String, kodPenghutang As String) As String
        Dim db As New DBKewConn

        If Kat = "ST" Then
            Dim dbstaf As New DBSMConn
            Dim data_staf As String = "SELECT TOP 1 MS01_Nama,MS01_NoStaf FROM MS01_Peribadi WHERE MS01_NoStaf=@kod"
            Dim param1 As New List(Of SqlParameter)
            param1.Add(New SqlParameter("@kod", kod))

            Dim dt1 As DataTable
            dt1 = dbstaf.Read(data_staf, param1)

            If dt1.Rows.Count > 0 Then

                Dim sql As String = "INSERT INTO SMKB_Penghutang_Master (Kod_Penghutang,No_Rujukan,Nama_Penghutang,Status) VALUES (@kod,@No_Rujukan,@Nama,@Status) "
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPenghutang))
                param.Add(New SqlParameter("@No_Rujukan", dt1.Rows(0).Item("MS01_NoStaf")))
                param.Add(New SqlParameter("@Nama", dt1.Rows(0).Item("MS01_Nama")))
                param.Add(New SqlParameter("@Status", 1))

                Return db.Process(sql, param)

            End If
        ElseIf Kat = "PL" Then
            Dim dbPelajar As New DBSMPConn
            Dim data_pelajar As String = "SELECT '' AS Kod_Penghutang ,SMP01_Nama,'PL' AS SMP01_KATEGORI, SMP01_NoAkaun ,B.Fakulti AS SMP01_Alamat1,'JALAN HANG TUAH JAYA' AS SMP01_Alamat2,'76100' AS SMP01_Poskod,'04' AS SMP01_Negeri,
                                            'MY' AS SMP01_Negara ,SMP01_NoTel,SMP01_Nomatrik+'@student.utem.edu.my' AS SMP01_Emel, SMP01_Nomatrik, '02' AS KATEGORI_ID,'1' AS STATUS,'040305' AS BANDAR,SMP01_Bank,B.Kod_Fakulti
                                            FROM SMP01_Peribadi A
                                            JOIN SMP_Fakulti B ON A.SMP01_Fakulti=B.Kod_Fakulti 
                                            WHERE SMP01_Status='AKTIF' AND SMP01_Nomatrik = @kod
                                            ORDER BY SMP01_Nomatrik"
            Dim param2 As New List(Of SqlParameter)
            param2.Add(New SqlParameter("@kod", kod))

            Dim dt As DataTable
            dt = dbPelajar.Read(data_pelajar, param2)

            If dt.Rows.Count > 0 Then

                Dim kodPejabat = getPejabat(dt.Rows(0).Item("Kod_Fakulti"))

                Dim sql As String = "INSERT INTO SMKB_Penghutang_Master (Kod_Penghutang,No_Rujukan,Nama_Penghutang,Kategori_Penghutang,Alamat_1,Alamat_2,Poskod,Bandar,Kod_Negeri,Kod_Negara,Tel_Bimbit,Emel,Kod_Bank,No_Akaun,Status,Kod_Pejabat) 
                                    VALUES 
                                    (@kod,@No_Rujukan,@Nama,@Kategori_Penghutang,@Alamat_1,@Alamat_2,@Poskod,@Bandar,@Kod_Negeri,@Kod_Negara,@Tel_Bimbit,@Emel,@Kod_Bank,@No_Akaun,@Status,@Kod_Pejabat) "
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPenghutang))
                param.Add(New SqlParameter("@No_Rujukan", dt.Rows(0).Item("SMP01_Nomatrik")))
                param.Add(New SqlParameter("@Nama", dt.Rows(0).Item("SMP01_Nama")))
                param.Add(New SqlParameter("@Kategori_Penghutang", dt.Rows(0).Item("SMP01_KATEGORI")))
                param.Add(New SqlParameter("@Alamat_1", dt.Rows(0).Item("SMP01_Alamat1")))
                param.Add(New SqlParameter("@Alamat_2", dt.Rows(0).Item("SMP01_Alamat2")))
                param.Add(New SqlParameter("@Poskod", dt.Rows(0).Item("SMP01_Poskod")))
                param.Add(New SqlParameter("@Bandar", dt.Rows(0).Item("BANDAR")))
                param.Add(New SqlParameter("@Kod_Negeri", dt.Rows(0).Item("SMP01_Negeri")))
                param.Add(New SqlParameter("@Kod_Negara", dt.Rows(0).Item("SMP01_Negara")))
                param.Add(New SqlParameter("@Tel_Bimbit", dt.Rows(0).Item("SMP01_NoTel")))
                param.Add(New SqlParameter("@Emel", dt.Rows(0).Item("SMP01_Emel")))
                param.Add(New SqlParameter("@Kod_Bank", dt.Rows(0).Item("SMP01_Bank")))
                param.Add(New SqlParameter("@No_Akaun", dt.Rows(0).Item("SMP01_NoAkaun")))
                param.Add(New SqlParameter("@Status", dt.Rows(0).Item("STATUS")))
                param.Add(New SqlParameter("@Kod_Pejabat", kodPejabat))

                Return db.Process(sql, param)

            End If

        ElseIf Kat = "PG" Then
            Dim dbPelajar As New DBSMPConn
            Dim data_pelajar As String = "SELECT '' AS Kod_Penghutang ,SMG02_NAMA, 'PG' AS SMG01_KATEGORI,SMG02_NoAkaun,C.Fakulti AS ALAMAT,'JALAN HANG TUAH JAYA' AS SMG01_Alamat2,'76100' AS SMG01_Poskod,'04' AS SMP01_Negeri, 
                                        'MY' AS SMG01_Negara, SMG02_NOTEL, B.SMG01_NOMATRIK+'@student.utem.edu.my' AS SMP01_Emel,B.SMG01_NOMATRIK, '02' AS KATEGORI_ID,'1' AS STATUS, 'MELAKA' AS BANDAR,'' AS KODBANK, C.Kod_Fakulti
                                        FROM SMG01_PENGAJIAN A, SMG02_Peribadi B, SMG_FAKULTI C 
                                        WHERE SMG01_STATUS = 'AKTIF' AND A.SMG01_NOMATRIK=B.SMG01_NOMATRIK AND B.SMG01_NOMATRIK=@kod
                                        AND C.Status='1' AND A.SMG01_KODFAKULTI=C.Kod_Fakulti"
            Dim param2 As New List(Of SqlParameter)
            param2.Add(New SqlParameter("@kod", kod))

            Dim dt As DataTable
            dt = dbPelajar.Read(data_pelajar, param2)

            If dt.Rows.Count > 0 Then

                Dim kodPejabat = getPejabat(dt.Rows(0).Item("Kod_Fakulti"))

                Dim sql As String = "INSERT INTO SMKB_Penghutang_Master (Kod_Penghutang,No_Rujukan,Nama_Penghutang,Kategori_Penghutang,Alamat_1,Alamat_2,Poskod,Bandar,Kod_Negeri,Kod_Negara,Tel_Bimbit,Emel,Kod_Bank,No_Akaun,Status,Kod_Pejabat) 
                                    VALUES 
                                    (@kod,@No_Rujukan,@Nama,@Kategori_Penghutang,@Alamat_1,@Alamat_2,@Poskod,@Bandar,@Kod_Negeri,@Kod_Negara,@Tel_Bimbit,@Emel,@Kod_Bank,@No_Akaun,@Status,@Kod_Pejabat) "
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPenghutang))
                param.Add(New SqlParameter("@No_Rujukan", dt.Rows(0).Item("SMG01_NOMATRIK")))
                param.Add(New SqlParameter("@Nama", dt.Rows(0).Item("SMG02_NAMA")))
                param.Add(New SqlParameter("@Kategori_Penghutang", dt.Rows(0).Item("SMG01_KATEGORI")))
                param.Add(New SqlParameter("@Alamat_1", dt.Rows(0).Item("ALAMAT")))
                param.Add(New SqlParameter("@Alamat_2", dt.Rows(0).Item("SMG01_Alamat2")))
                param.Add(New SqlParameter("@Poskod", dt.Rows(0).Item("SMG01_Poskod")))
                param.Add(New SqlParameter("@Bandar", dt.Rows(0).Item("BANDAR")))
                param.Add(New SqlParameter("@Kod_Negeri", dt.Rows(0).Item("SMP01_Negeri")))
                param.Add(New SqlParameter("@Kod_Negara", dt.Rows(0).Item("SMG01_Negara")))
                param.Add(New SqlParameter("@Tel_Bimbit", dt.Rows(0).Item("SMG02_NOTEL")))
                param.Add(New SqlParameter("@Emel", dt.Rows(0).Item("SMP01_Emel")))
                param.Add(New SqlParameter("@Kod_Bank", "-"))
                param.Add(New SqlParameter("@No_Akaun", "-"))
                param.Add(New SqlParameter("@Status", dt.Rows(0).Item("STATUS")))
                param.Add(New SqlParameter("@Kod_Pejabat", kodPejabat))

                Return db.Process(sql, param)

            End If

        ElseIf Kat = "PH" Then
            Dim dbPelajarSH As New DBSMPSHConn
            Dim data_pelajar As String = "SELECT '' AS Kod_Penghutang ,SMP01_Nama,'PH' AS SMP01_KATEGORI, SMP01_NoAkaun ,B.Fakulti AS SMP01_Alamat1,'JALAN HANG TUAH JAYA' AS SMP01_Alamat2,'76100' AS SMP01_Poskod,'04' AS SMP01_Negeri, 
                                        'MY' AS SMP01_Negara ,SMP01_NoTel,SMP01_Nomatrik+'@student.utem.edu.my' AS SMP01_Emel, SMP01_Nomatrik, '02' AS KATEGORI_ID,'1' AS STATUS,'040305' AS BANDAR,SMP01_Bank,B.Kod_Fakulti 
                                        FROM SMP01_Peribadi A 
                                        JOIN SMP_Fakulti B ON A.SMP01_Fakulti=B.Kod_Fakulti WHERE SMP01_Status='AKTIF' AND SMP01_Nomatrik=@kod"
            Dim param2 As New List(Of SqlParameter)
            param2.Add(New SqlParameter("@kod", kod))

            Dim dt As DataTable
            dt = dbPelajarSH.Read(data_pelajar, param2)

            If dt.Rows.Count > 0 Then

                Dim kodPejabat = getPejabat(dt.Rows(0).Item("Kod_Fakulti"))

                Dim sql As String = "INSERT INTO SMKB_Penghutang_Master (Kod_Penghutang,No_Rujukan,Nama_Penghutang,Kategori_Penghutang,Alamat_1,Alamat_2,Poskod,Bandar,Kod_Negeri,Kod_Negara,Tel_Bimbit,Emel,Kod_Bank,No_Akaun,Status,Kod_Pejabat) 
                                    VALUES 
                                    (@kod,@No_Rujukan,@Nama,@Kategori_Penghutang,@Alamat_1,@Alamat_2,@Poskod,@Bandar,@Kod_Negeri,@Kod_Negara,@Tel_Bimbit,@Emel,@Kod_Bank,@No_Akaun,@Status,@Kod_Pejabat) "
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPenghutang))
                param.Add(New SqlParameter("@No_Rujukan", dt.Rows(0).Item("SMP01_Nomatrik")))
                param.Add(New SqlParameter("@Nama", dt.Rows(0).Item("SMP01_Nama")))
                param.Add(New SqlParameter("@Kategori_Penghutang", dt.Rows(0).Item("SMP01_KATEGORI")))
                param.Add(New SqlParameter("@Alamat_1", dt.Rows(0).Item("SMP01_Alamat1")))
                param.Add(New SqlParameter("@Alamat_2", dt.Rows(0).Item("SMP01_Alamat2")))
                param.Add(New SqlParameter("@Poskod", dt.Rows(0).Item("SMP01_Poskod")))
                param.Add(New SqlParameter("@Bandar", dt.Rows(0).Item("BANDAR")))
                param.Add(New SqlParameter("@Kod_Negeri", dt.Rows(0).Item("SMP01_Negeri")))
                param.Add(New SqlParameter("@Kod_Negara", dt.Rows(0).Item("SMP01_Negara")))
                param.Add(New SqlParameter("@Tel_Bimbit", dt.Rows(0).Item("SMP01_NoTel")))
                param.Add(New SqlParameter("@Emel", dt.Rows(0).Item("SMP01_Emel")))
                param.Add(New SqlParameter("@Kod_Bank", "-"))
                param.Add(New SqlParameter("@No_Akaun", "-"))
                param.Add(New SqlParameter("@Status", dt.Rows(0).Item("STATUS")))
                param.Add(New SqlParameter("@Kod_Pejabat", kodPejabat))

                Return db.Process(sql, param)

            End If

        End If

        Return kodPenghutang
    End Function

    Public Shared Function getPejabat(kod As String) As String
        Dim db As New DBKewConn
        Dim sql_pjbt As String = "SELECT TOP 1 KodPejabat,Singkatan FROM VPejabat WHERE Singkatan LIKE '%' + @kod + '%' ORDER BY KodPejabat DESC"
        Dim param_pjbt As New List(Of SqlParameter)
        param_pjbt.Add(New SqlParameter("@kod", kod))
        Dim dt_pjbt As DataTable
        Dim kodPejabat As String
        dt_pjbt = db.Read(sql_pjbt, param_pjbt)
        If dt_pjbt.Rows.Count > 0 Then
            kodPejabat = dt_pjbt.Rows(0).Item("KodPejabat") + "0000"
        End If
        Return kodPejabat
    End Function

End Class
