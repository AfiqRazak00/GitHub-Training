Imports System.ComponentModel
Imports System.Data.SqlClient
Imports System.Net.Http
'Imports Microsoft.Office.Interop.Excel
Imports System.Globalization
Imports Newtonsoft.Json
Imports System.Web.Script.Services


Public Class SMKB_API
    Private Shared Property domain As String = "http://localhost:1557/SMKBNet/api"
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

                Dim sql As String = "INSERT INTO SMKB_Pemiutang_Master (Kod_Pemiutang,No_Rujukan,Nama_Pemiutang,Status) VALUES (@kod,@No_Rujukan,@Nama,@Status) "
                Dim param As New List(Of SqlParameter)
                param.Add(New SqlParameter("@kod", kodPemiutang))
                param.Add(New SqlParameter("@No_Rujukan", dt1.Rows(0).Item("MS01_NoStaf")))
                param.Add(New SqlParameter("@Nama", dt1.Rows(0).Item("MS01_Nama")))
                param.Add(New SqlParameter("@Status", 1))

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


        End If

        Return kodPenghutang
    End Function

End Class
