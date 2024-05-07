Imports System.ComponentModel
Imports System.Data.Entity.Core
Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Security.Cryptography
Imports System.Threading
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports Org.BouncyCastle.Ocsp

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Bil_WS
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

End Class

Module SharedModuleAR

    Public Sub logDOK(KodModule As String, No_Rujukan As String, Status_Dok As String, Ulasan As String)
        Dim userID As String = HttpContext.Current.Session("ssusrID")

        Try
            Using sqlConn As New SqlConnection(dbSMKB.strCon)
                sqlConn.Open()
                Dim sqlcmd As New SqlCommand
                sqlcmd.Connection = sqlConn
                sqlcmd.CommandText = "INSERT INTO SMKB_Status_Dok (Kod_Modul,Kod_Status_Dok,No_Rujukan,No_Staf,Tkh_Tindakan,Tkh_Transaksi,Status_Transaksi,Status,Ulasan)
                VALUES (@Kod_Modul,@Kod_Status_Dok,@No_Rujukan,@No_Staf,getdate(),getdate(),@Status_Transaksi,@Status,@Ulasan)  "
                sqlcmd.Parameters.Add(New SqlParameter("@Kod_Modul", KodModule))
                sqlcmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Status_Dok))
                sqlcmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
                sqlcmd.Parameters.Add(New SqlParameter("@No_Staf", userID))
                sqlcmd.Parameters.Add(New SqlParameter("@Status_Transaksi", "1"))
                sqlcmd.Parameters.Add(New SqlParameter("@Status", "1"))
                sqlcmd.Parameters.Add(New SqlParameter("@Ulasan", Ulasan))
                sqlcmd.ExecuteNonQuery()
            End Using
        Catch ex As Exception
            Dim msg As String = ex.Message

        End Try

    End Sub

    '@Param KodLejar eg: GL General Ledger, AR
    Public Async Function sendDataIntoLejar(userId As String, Ledger As String, Bil As Bil_Order, item As Bil_Order_Dtl, isCredit As Boolean, tarikh As String, Optional vot As String = "") As Tasks.Task(Of Response)
        Dim res As New Response
        res.Code = 200

        Try

            Dim ticket As New TokenResponseModel()
            Dim servicex As New ValuesService()
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")
            Dim parsedDate As Date = CDate(tarikh).ToString("yyyy-MM-dd")
            Dim vBulan As String = parsedDate.Month
            Dim vTahun As String = parsedDate.Year
            Dim dbcr As String = "DR"
            Dim kodvot As String = ""
            If Not String.IsNullOrEmpty(vot) Then
                kodvot = vot
            Else
                kodvot = item.Kod_Vot
            End If

            If isCredit Then
                dbcr = "CR"
            End If

            Dim values As String = ""
            If Ledger.Equals("AR") Then
                values = Await servicex.SendDataLejar(ticket.GetTicket("smkb", userId),
                                            "AR", Bil.Kod_Penghutang, item.Kod_Kump_Wang, item.Kod_PTJ,
                                            kodvot, item.Kod_Operasi, item.Kod_Projek, item.Jumlah, dbcr, vBulan, vTahun)
            ElseIf Ledger.Equals("GL") Then
                values = Await servicex.SendDataLejar(ticket.GetTicket("smkb", userId),
                                            "GL", "UTeM", item.Kod_Kump_Wang, item.Kod_PTJ,
                                            kodvot, item.Kod_Operasi, item.Kod_Projek, item.Jumlah, dbcr, vBulan, vTahun)

            End If


            If values.Contains("ok") Then
                res.Code = 200
            Else
                res.Code = 500
            End If
        Catch ex As Exception
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function

    Public Async Function sendDataIntoLejar_Bil_Adj(userId As String, Ledger As String, Bil As Bil_Adj, item As Bil_Adj_Dtl, isCredit As Boolean, tarikh As String, Optional vot As String = "") As Tasks.Task(Of Response)
        Dim res As New Response
        res.Code = 200

        Try

            Dim ticket As New TokenResponseModel()
            Dim servicex As New ValuesService()
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("ms-MY")
            Dim parsedDate As Date = CDate(tarikh).ToString("yyyy-MM-dd")
            Dim vBulan As String = parsedDate.Month
            Dim vTahun As String = parsedDate.Year
            Dim dbcr As String = "DR"
            Dim kodvot As String = ""
            If Not String.IsNullOrEmpty(vot) Then
                kodvot = vot
            Else
                kodvot = item.Kod_Vot
            End If

            If isCredit Then
                dbcr = "CR"
            End If

            Dim values As String = ""
            If Ledger.Equals("AR") Then
                values = Await servicex.SendDataLejar(ticket.GetTicket("smkb", userId),
                                            "AR", Bil.Kod_Penghutang, item.Kod_Kump_Wang, item.Kod_PTJ,
                                            kodvot, item.Kod_Operasi, item.Kod_Projek, item.Jumlah, dbcr, vBulan, vTahun)
            ElseIf Ledger.Equals("GL") Then
                values = Await servicex.SendDataLejar(ticket.GetTicket("smkb", userId),
                                            "GL", "UTeM", item.Kod_Kump_Wang, item.Kod_PTJ,
                                            kodvot, item.Kod_Operasi, item.Kod_Projek, item.Jumlah, dbcr, vBulan, vTahun)

            End If


            If values.Contains("ok") Then
                res.Code = 200
            Else
                res.Code = 500
            End If
        Catch ex As Exception
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSpecificPenghutang(ByVal Kod As String) As String
        Dim db = New DBKewConn

        'Dim statusList As String = String.Join(",", Kod.Select(Function(s) $"'{s}'"))
        Dim query As String = "SELECT *, STUFF(
                    (select '|'+ dtl.Kod_Detail + '--'+ dtl.Butiran from SMKB_Penghutang_Master p
                      JOIN SMKB_Lookup_Detail dtl 
                      ON (p.Kod_Negara = dtl.Kod_Detail AND dtl.Kod = '0001')
                      OR (p.Kod_Negeri = dtl.Kod_Detail AND dtl.Kod = '0002')
                      OR (p.Bandar = dtl.Kod_Detail AND dtl.Kod = '0003')  
                      WHERE p.Kod_Penghutang IN (" & Kod & ")
                      FOR XML PATH('')),1,1,''
                    ) As Butiran_Kod_Alamat FROM SMKB_Penghutang_Master 
                    WHERE Kod_Penghutang IN (" & Kod & ")"
        Dim param As New List(Of SqlParameter)

        Return JsonConvert.SerializeObject(db.Read(query, param))

    End Function

    Public Function GenerateID(Kod_Modul As String, Prefix As String, Butiran As String) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul =@Kod_Modul AND Prefix =@Prefix AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod_Modul", Kod_Modul))
        param.Add(New SqlParameter("@Prefix", Prefix))
        param.Add(New SqlParameter("@year", year))

        Dim dt As DataTable
        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir(Kod_Modul, Prefix, year, lastID)
        Else

            InsertNoAkhir(Kod_Modul, Prefix, year, lastID)
        End If
        newOrderID = Prefix + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newOrderID
    End Function

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

    Public Function PostLejarPenghutang(Akaun As String, orderid As Bil_Order_Dtl, kodPenghutang As String, TkhBil As String)
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim res As New Response
        res.Code = 200

        Dim nobil = orderid.No_Bil
        Dim kodkw = orderid.Kod_Kump_Wang
        Dim kodko = orderid.Kod_Operasi
        Dim kodkp = orderid.Kod_Projek
        Dim kodptj = orderid.Kod_PTJ
        Dim kodvot = orderid.Kod_Vot
        Dim Jumlah_Total = orderid.Jumlah
        Jumlah_Total = Jumlah_Total.ToString().Replace(",", "")
        Dim Jumlah = 0.00
        Dim bulan = Month(TkhBil)
        Dim tahun = Year(TkhBil)

        Dim Akaun_1 As String
        Dim Akaun_2 As String
        Dim Akaun_3 As String
        Dim Akaun_4 As String
        Dim Akaun_5 As String
        Dim Akaun_6 As String
        Dim Akaun_7 As String
        Dim Akaun_8 As String
        Dim Akaun_9 As String
        Dim Akaun_10 As String
        Dim Akaun_11 As String
        Dim Akaun_12 As String
        Dim Akaun_13 As String

        Dim param As New List(Of SqlParameter)

        Dim query As String = "SELECT Kod_Penghutang,Kod_Kump_Wang,Kod_Operasi,Kod_Projek,Kod_PTJ,Kod_Vot,
                                CASE WHEN @bulan = 1 THEN SUM(Cr_1) ELSE 0 END AS Cr_1 , 
                                CASE WHEN @bulan = 1 THEN SUM(Dr_1) ELSE 0 END AS Dr_1,
                                CASE WHEN @bulan = 2 THEN SUM(Cr_2) ELSE 0 END AS Cr_2 , 
                                CASE WHEN @bulan = 2 THEN SUM(Dr_2) ELSE 0 END AS Dr_2,
                                CASE WHEN @bulan = 3 THEN SUM(Cr_3) ELSE 0 END AS Cr_3 , 
                                CASE WHEN @bulan = 3 THEN SUM(Dr_3) ELSE 0 END AS Dr_3,
                                CASE WHEN @bulan = 4 THEN SUM(Cr_4) ELSE 0 END AS Cr_4 , 
                                CASE WHEN @bulan = 4 THEN SUM(Dr_4) ELSE 0 END AS Dr_4,
                                CASE WHEN @bulan = 5 THEN SUM(Cr_5) ELSE 0 END AS Cr_5 , 
                                CASE WHEN @bulan = 5 THEN SUM(Dr_5) ELSE 0 END AS Dr_5,
                                CASE WHEN @bulan = 6 THEN SUM(Cr_6) ELSE 0 END AS Cr_6 , 
                                CASE WHEN @bulan = 6 THEN SUM(Dr_6) ELSE 0 END AS Dr_6,
                                CASE WHEN @bulan = 7 THEN SUM(Cr_7) ELSE 0 END AS Cr_7 , 
                                CASE WHEN @bulan = 7 THEN SUM(Dr_7) ELSE 0 END AS Dr_7,
                                CASE WHEN @bulan = 8 THEN SUM(Cr_8) ELSE 0 END AS Cr_8 , 
                                CASE WHEN @bulan = 8 THEN SUM(Dr_8) ELSE 0 END AS Dr_8,
                                CASE WHEN @bulan = 9 THEN SUM(Cr_9) ELSE 0 END AS Cr_9 , 
                                CASE WHEN @bulan = 9 THEN SUM(Dr_9) ELSE 0 END AS Dr_9,
                                CASE WHEN @bulan = 10 THEN SUM(Cr_10) ELSE 0 END AS Cr_10 , 
                                CASE WHEN @bulan = 10 THEN SUM(Dr_10) ELSE 0 END AS Dr_10,
                                CASE WHEN @bulan = 11 THEN SUM(Cr_11) ELSE 0 END AS Cr_11 , 
                                CASE WHEN @bulan = 11 THEN SUM(Dr_11) ELSE 0 END AS Dr_11,
                                CASE WHEN @bulan = 12 THEN SUM(Cr_12) ELSE 0 END AS Cr_12 , 
                                CASE WHEN @bulan = 12 THEN SUM(Dr_12) ELSE 0 END AS Dr_12,
                                CASE WHEN @bulan = 13 THEN SUM(Cr_13) ELSE 0 END AS Cr_13 , 
                                CASE WHEN @bulan = 13 THEN SUM(Dr_13) ELSE 0 END AS Dr_13 , 
                                '1' as status
                                FROM SMKB_Lejar_Penghutang 
                                WHERE Kod_Penghutang=@kodpenghutang AND Kod_Kump_Wang=@kw AND Kod_Operasi=@kodko AND Kod_Projek=@kodkp AND Kod_PTJ=@kodptj AND Kod_Vot=@kodvot AND Tahun=@tahun
                                GROUP BY Kod_Penghutang,Kod_Vot,Kod_PTJ,Kod_Projek,Kod_Operasi,Kod_Kump_Wang"

        param.Add(New SqlParameter("@kodpenghutang", kodPenghutang))
        param.Add(New SqlParameter("@kw", kodkw))
        param.Add(New SqlParameter("@kodko", kodko))
        param.Add(New SqlParameter("@kodkp", kodkp))
        param.Add(New SqlParameter("@kodptj", "500000"))
        param.Add(New SqlParameter("@kodvot", "71901"))
        param.Add(New SqlParameter("@bulan", bulan))
        param.Add(New SqlParameter("@tahun", tahun))
        'param.Add(New SqlParameter("@Akaun", Akaun))

        dt = db.Read(query, param)
        If dt IsNot Nothing Then
            If dt.Rows.Count > 0 Then
                If Akaun = "Cr" Then
                    If (bulan = 1) Then
                        Jumlah = dt.Rows(0).Item("Cr_1")
                    ElseIf (bulan = 2) Then
                        Jumlah = dt.Rows(0).Item("Cr_2")
                    ElseIf (bulan = 3) Then
                        Jumlah = dt.Rows(0).Item("Cr_3")
                    ElseIf (bulan = 4) Then
                        Jumlah = dt.Rows(0).Item("Cr_4")
                    ElseIf (bulan = 5) Then
                        Jumlah = dt.Rows(0).Item("Cr_5")
                    ElseIf (bulan = 6) Then
                        Jumlah = dt.Rows(0).Item("Cr_6")
                    ElseIf (bulan = 7) Then
                        Jumlah = dt.Rows(0).Item("Cr_7")
                    ElseIf (bulan = 8) Then
                        Jumlah = dt.Rows(0).Item("Cr_8")
                    ElseIf (bulan = 9) Then
                        Jumlah = dt.Rows(0).Item("Cr_9")
                    ElseIf (bulan = 10) Then
                        Jumlah = dt.Rows(0).Item("Cr_10")
                    ElseIf (bulan = 11) Then
                        Jumlah = dt.Rows(0).Item("Cr_11")
                    ElseIf (bulan = 12) Then
                        Jumlah = dt.Rows(0).Item("Cr_12")
                    ElseIf (bulan = 13) Then
                        Jumlah = dt.Rows(0).Item("Cr_13")
                    End If
                ElseIf Akaun = "Dr" Then
                    If (bulan = 1) Then
                        Jumlah = dt.Rows(0).Item("Dr_1")
                    ElseIf (bulan = 2) Then
                        Jumlah = dt.Rows(0).Item("Dr_2")
                    ElseIf (bulan = 3) Then
                        Jumlah = dt.Rows(0).Item("Dr_3")
                    ElseIf (bulan = 4) Then
                        Jumlah = dt.Rows(0).Item("Dr_4")
                    ElseIf (bulan = 5) Then
                        Jumlah = dt.Rows(0).Item("Dr_5")
                    ElseIf (bulan = 6) Then
                        Jumlah = dt.Rows(0).Item("Dr_6")
                    ElseIf (bulan = 7) Then
                        Jumlah = dt.Rows(0).Item("Dr_7")
                    ElseIf (bulan = 8) Then
                        Jumlah = dt.Rows(0).Item("Dr_8")
                    ElseIf (bulan = 9) Then
                        Jumlah = dt.Rows(0).Item("Dr_9")
                    ElseIf (bulan = 10) Then
                        Jumlah = dt.Rows(0).Item("Dr_10")
                    ElseIf (bulan = 11) Then
                        Jumlah = dt.Rows(0).Item("Dr_11")
                    ElseIf (bulan = 12) Then
                        Jumlah = dt.Rows(0).Item("Dr_12")
                    ElseIf (bulan = 13) Then
                        Jumlah = dt.Rows(0).Item("Cr_13")
                    End If
                End If
                Dim Jumlah_Total_ = Jumlah + Jumlah_Total
                Jumlah_Total_ = Jumlah_Total_.ToString().Replace(",", "")
                If Akaun = "Dr" Then
                    Akaun_1 = "Dr_1"
                    Akaun_2 = "Dr_2"
                    Akaun_3 = "Dr_3"
                    Akaun_4 = "Dr_4"
                    Akaun_5 = "Dr_5"
                    Akaun_6 = "Dr_6"
                    Akaun_7 = "Dr_7"
                    Akaun_8 = "Dr_8"
                    Akaun_9 = "Dr_9"
                    Akaun_10 = "Dr_10"
                    Akaun_11 = "Dr_11"
                    Akaun_12 = "Dr_12"
                    Akaun_13 = "Dr_13"

                    Dim query_1 As String = "UPDATE LP
                    SET " & Akaun_1 & " =
                        CASE WHEN @bulan=1 THEN " & Jumlah_Total_ & " ELSE LP." & Akaun_1 & " END,
                        " & Akaun_2 & " = 
                        CASE WHEN @bulan=2 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_2 & " END,
                        " & Akaun_3 & " = 
                        CASE WHEN @bulan=3 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_3 & " END,
                        " & Akaun_4 & " = 
                        CASE WHEN @bulan=4 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_4 & " END,
                        " & Akaun_5 & " = 
                        CASE WHEN @bulan=5 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_5 & " END,
                        " & Akaun_6 & " = 
                        CASE WHEN @bulan=6 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_6 & " END,
                        " & Akaun_7 & " = 
                        CASE WHEN @bulan=7 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_7 & " END,
                        " & Akaun_8 & " = 
                        CASE WHEN @bulan=8 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_8 & " END,
                        " & Akaun_9 & " = 
                        CASE WHEN @bulan=9 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_9 & " END,
                        " & Akaun_10 & " = 
                        CASE WHEN @bulan=10 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_10 & " END,
                        " & Akaun_11 & " = 
                        CASE WHEN @bulan=11 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_11 & " END,
                        " & Akaun_12 & " = 
                        CASE WHEN @bulan=12 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_12 & " END,
                        " & Akaun_13 & " = 
                        CASE WHEN @bulan=13 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_13 & " END
                    FROM SMKB_Lejar_Penghutang LP
                    WHERE LP.Kod_Penghutang=@kodPenghutang AND LP.Kod_Kump_Wang=@kodkw AND LP.Kod_Operasi=@kodko AND LP.Kod_Projek=@kodkp AND LP.Kod_PTJ=@kodptj AND LP.Kod_Vot=@kodvot
                    AND LP.Tahun=@tahun"
                    Dim param_1 As New List(Of SqlParameter)
                    param_1.Add(New SqlParameter("@kodPenghutang", kodPenghutang))
                    param_1.Add(New SqlParameter("@bulan", bulan))
                    param_1.Add(New SqlParameter("@Jumlah_Total_", Jumlah_Total_))
                    param_1.Add(New SqlParameter("@kodkw", kodkw))
                    param_1.Add(New SqlParameter("@kodko", kodko))
                    param_1.Add(New SqlParameter("@kodkp", kodkp))
                    param_1.Add(New SqlParameter("@kodptj", "500000"))
                    param_1.Add(New SqlParameter("@kodvot", "71901"))
                    param_1.Add(New SqlParameter("@tahun", tahun))
                    Return db.Process(query_1, param_1)

                ElseIf Akaun = "Cr" Then
                    Akaun_1 = "Cr_1"
                    Akaun_2 = "Cr_2"
                    Akaun_3 = "Cr_3"
                    Akaun_4 = "Cr_4"
                    Akaun_5 = "Cr_5"
                    Akaun_6 = "Cr_6"
                    Akaun_7 = "Cr_7"
                    Akaun_8 = "Cr_8"
                    Akaun_9 = "Cr_9"
                    Akaun_10 = "Cr_10"
                    Akaun_11 = "Cr_11"
                    Akaun_12 = "Cr_12"
                    Akaun_13 = "Cr_13"

                    Dim query_1 As String = "UPDATE LP
                    SET " & Akaun_1 & " =
                        CASE WHEN @bulan=1 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_1 & " END,
                        " & Akaun_2 & " = 
                        CASE WHEN @bulan=2 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_2 & " END,
                        " & Akaun_3 & " = 
                        CASE WHEN @bulan=3 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_3 & " END,
                        " & Akaun_4 & " = 
                        CASE WHEN @bulan=4 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_4 & " END,
                        " & Akaun_5 & " = 
                        CASE WHEN @bulan=5 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_5 & " END,
                        " & Akaun_6 & " = 
                        CASE WHEN @bulan=6 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_6 & " END,
                        " & Akaun_7 & " = 
                        CASE WHEN @bulan=7 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_7 & " END,
                        " & Akaun_8 & " = 
                        CASE WHEN @bulan=8 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_8 & " END,
                        " & Akaun_9 & " = 
                        CASE WHEN @bulan=9 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_9 & " END,
                        " & Akaun_10 & " = 
                        CASE WHEN @bulan=10 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_10 & " END,
                        " & Akaun_11 & " = 
                        CASE WHEN @bulan=11 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_11 & " END,
                        " & Akaun_12 & " = 
                        CASE WHEN @bulan=12 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_12 & " END,
                        " & Akaun_13 & " = 
                        CASE WHEN @bulan=13 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_13 & " END
                    FROM SMKB_Lejar_Penghutang LP
                    WHERE LP.Kod_Penghutang=@kodpenghutang AND LP.Kod_Kump_Wang=@kodkw AND LP.Kod_Operasi=@kodko AND LP.Kod_Projek=@kodkp AND LP.Kod_PTJ=@kodptj AND LP.Kod_Vot=@kodvot
                    AND LP.Tahun=@tahun"
                    Dim param_1 As New List(Of SqlParameter)
                    param_1.Add(New SqlParameter("@kodpenghutang", kodPenghutang))
                    param_1.Add(New SqlParameter("@bulan", bulan))
                    param_1.Add(New SqlParameter("@kodkw", kodkw))
                    param_1.Add(New SqlParameter("@kodko", kodko))
                    param_1.Add(New SqlParameter("@kodkp", kodkp))
                    param_1.Add(New SqlParameter("@kodptj", "500000"))
                    param_1.Add(New SqlParameter("@kodvot", "71901"))
                    param_1.Add(New SqlParameter("@tahun", tahun))
                    Return db.Process(query_1, param_1)
                End If

            Else
                Dim query_2 As String
                Dim param_2 As New List(Of SqlParameter)
                If Akaun = "Cr" Then
                    query_2 = "INSERT INTO SMKB_Lejar_Penghutang 
                                SELECT @kodpenghutang , @tahun , @kodkw, @kodko,@kodkp,@kodptj,@kodvot,
                                '0.00' AS Debit_1 , 
                                CASE WHEN @bulan = 1 THEN " & Jumlah_Total & " ELSE 0.00 END AS Cr_1 ,
                                '0.00' AS  Debit_2 , 
                                CASE WHEN @bulan = 2 THEN" & Jumlah_Total & " ELSE 0 END AS Cr_2 ,
                                '0.00' AS  Debit_3 , 
                                CASE WHEN @bulan = 3 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_3 ,
                                '0.00' AS  Debit_4 , 
                                CASE WHEN @bulan = 4 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_4 ,
                                '0.00' AS  Debit_5 , 
                                CASE WHEN @bulan = 5 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_5 ,
                                '0.00' AS  Debit_6 , 
                                CASE WHEN @bulan = 6 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_6 ,
                                '0.00' AS  Debit_7 , 
                                CASE WHEN @bulan = 7 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_7 ,
                                '0.00' AS Debit_8 , 
                                CASE WHEN @bulan = 8 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_8 ,
                                '0.00' AS Debit_9 , 
                                CASE WHEN @bulan = 9 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_9 ,
                                '0.00' AS Debit_10 , 
                                CASE WHEN @bulan = 10 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_10 ,
                                '0.00' AS Debit_11 , 
                                CASE WHEN @bulan = 11 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_11 ,
                                '0.00' AS Debit_12 , 
                                CASE WHEN @bulan = 12 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_12 ,
                                '0.00' AS Debit_13 , 
                                CASE WHEN @bulan = 13 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_13,
                                '1' as status
                                FROM SMKB_Bil_Hdr
                                WHERE No_Bil=@nobil"
                    param_2.Add(New SqlParameter("@kodpenghutang", kodPenghutang))
                    param_2.Add(New SqlParameter("@tahun", tahun))
                    param_2.Add(New SqlParameter("@kodkw", kodkw))
                    param_2.Add(New SqlParameter("@kodko", kodko))
                    param_2.Add(New SqlParameter("@kodkp", kodkp))
                    param_2.Add(New SqlParameter("@kodptj", "500000"))
                    param_2.Add(New SqlParameter("@kodvot", "71901"))
                    param_2.Add(New SqlParameter("@bulan", bulan))
                    param_2.Add(New SqlParameter("@nobil", nobil))
                    Return db.Process(query_2, param_2)
                ElseIf Akaun = "Dr" Then
                    query_2 = "INSERT INTO SMKB_Lejar_Penghutang 
                        SELECT @kodpenghutang , @tahun , @kodkw, @kodko,@kodkp,@kodptj,@kodvot,
                        CASE WHEN @bulan = 1 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_1 ,
                        '0.00' AS Cr_1 ,
                        CASE WHEN @bulan = 2 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_2 ,
                        '0.00' AS Cr_2 , 
                        CASE WHEN @bulan = 3 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_3 ,
                        '0.00' AS Cr_3 , 
                        CASE WHEN @bulan = 4 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_4 ,
                        '0.00' AS Cr_4 ,
                        CASE WHEN @bulan = 5 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_5 ,
                        '0.00' AS Cr_5 ,
                        CASE WHEN @bulan = 6 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_6 ,
                        '0.00' AS Cr_6 ,
                        CASE WHEN @bulan = 7 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_7 ,
                        '0.00' AS Cr_7 ,
                        CASE WHEN @bulan = 8 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_8 ,
                        '0.00' AS Cr_8 ,
                        CASE WHEN @bulan = 9 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_9 ,
                        '0.00' AS Cr_9 ,
                        CASE WHEN @bulan = 10 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_10 ,
                        '0.00' AS Cr_10 ,
                        CASE WHEN @bulan = 11 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_11 ,
                        '0.00' AS Cr_11 ,
                        CASE WHEN @bulan = 12 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_12 ,
                        '0.00' AS Cr_12 ,
                        CASE WHEN @bulan = 13 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_13 ,
                        '0.00' AS Cr_13 ,
                        '1' as status
                        FROM SMKB_Bil_Hdr
                        WHERE No_Bil=@nobil"
                    param_2.Add(New SqlParameter("@kodpenghutang", kodPenghutang))
                    param_2.Add(New SqlParameter("@tahun", tahun))
                    param_2.Add(New SqlParameter("@kodkw", kodkw))
                    param_2.Add(New SqlParameter("@kodko", kodko))
                    param_2.Add(New SqlParameter("@kodkp", kodkp))
                    param_2.Add(New SqlParameter("@kodptj", "500000"))
                    param_2.Add(New SqlParameter("@kodvot", "71901"))
                    param_2.Add(New SqlParameter("@bulan", bulan))
                    param_2.Add(New SqlParameter("@nobil", nobil))
                    Return db.Process(query_2, param_2)
                End If
            End If
        End If
    End Function
    Public Function PostLejarAm(Akaun As String, orderid As Bil_Order_Dtl, TkhBil As String)
        Dim db As New DBKewConn
        Dim dt As DataTable
        Dim res As New Response
        res.Code = 200

        Dim nobil = orderid.No_Bil
        Dim kodkw = orderid.Kod_Kump_Wang
        Dim kodko = orderid.Kod_Operasi
        Dim kodkp = orderid.Kod_Projek
        Dim kodptj = orderid.Kod_PTJ
        Dim kodvot = orderid.Kod_Vot
        Dim Jumlah_Total = orderid.Jumlah
        Jumlah_Total = Jumlah_Total.ToString().Replace(",", "")
        Dim Jumlah = 0.00
        Dim bulan = Month(TkhBil)
        Dim tahun = Year(TkhBil)

        Dim Akaun_1 As String
        Dim Akaun_2 As String
        Dim Akaun_3 As String
        Dim Akaun_4 As String
        Dim Akaun_5 As String
        Dim Akaun_6 As String
        Dim Akaun_7 As String
        Dim Akaun_8 As String
        Dim Akaun_9 As String
        Dim Akaun_10 As String
        Dim Akaun_11 As String
        Dim Akaun_12 As String
        Dim Akaun_13 As String
        Dim kodSya As String
        kodSya = "UTeM"

        Dim param As New List(Of SqlParameter)

        Dim query As String = "SELECT Kod_Kump_Wang,Kod_Operasi,Kod_Projek,Kod_PTJ,Kod_Vot,
                                CASE WHEN @bulan = 1 THEN SUM(Cr_1) ELSE 0 END AS Cr_1 , 
                                CASE WHEN @bulan = 1 THEN SUM(Dr_1) ELSE 0 END AS Dr_1,
                                CASE WHEN @bulan = 2 THEN SUM(Cr_2) ELSE 0 END AS Cr_2 , 
                                CASE WHEN @bulan = 2 THEN SUM(Dr_2) ELSE 0 END AS Dr_2,
                                CASE WHEN @bulan = 3 THEN SUM(Cr_3) ELSE 0 END AS Cr_3 , 
                                CASE WHEN @bulan = 3 THEN SUM(Dr_3) ELSE 0 END AS Dr_3,
                                CASE WHEN @bulan = 4 THEN SUM(Cr_4) ELSE 0 END AS Cr_4 , 
                                CASE WHEN @bulan = 4 THEN SUM(Dr_4) ELSE 0 END AS Dr_4,
                                CASE WHEN @bulan = 5 THEN SUM(Cr_5) ELSE 0 END AS Cr_5 , 
                                CASE WHEN @bulan = 5 THEN SUM(Dr_5) ELSE 0 END AS Dr_5,
                                CASE WHEN @bulan = 6 THEN SUM(Cr_6) ELSE 0 END AS Cr_6 , 
                                CASE WHEN @bulan = 6 THEN SUM(Dr_6) ELSE 0 END AS Dr_6,
                                CASE WHEN @bulan = 7 THEN SUM(Cr_7) ELSE 0 END AS Cr_7 , 
                                CASE WHEN @bulan = 7 THEN SUM(Dr_7) ELSE 0 END AS Dr_7,
                                CASE WHEN @bulan = 8 THEN SUM(Cr_8) ELSE 0 END AS Cr_8 , 
                                CASE WHEN @bulan = 8 THEN SUM(Dr_8) ELSE 0 END AS Dr_8,
                                CASE WHEN @bulan = 9 THEN SUM(Cr_9) ELSE 0 END AS Cr_9 , 
                                CASE WHEN @bulan = 9 THEN SUM(Dr_9) ELSE 0 END AS Dr_9,
                                CASE WHEN @bulan = 10 THEN SUM(Cr_10) ELSE 0 END AS Cr_10 , 
                                CASE WHEN @bulan = 10 THEN SUM(Dr_10) ELSE 0 END AS Dr_10,
                                CASE WHEN @bulan = 11 THEN SUM(Cr_11) ELSE 0 END AS Cr_11 , 
                                CASE WHEN @bulan = 11 THEN SUM(Dr_11) ELSE 0 END AS Dr_11,
                                CASE WHEN @bulan = 12 THEN SUM(Cr_12) ELSE 0 END AS Cr_12 , 
                                CASE WHEN @bulan = 12 THEN SUM(Dr_12) ELSE 0 END AS Dr_12,
                                CASE WHEN @bulan = 13 THEN SUM(Cr_13) ELSE 0 END AS Cr_13 , 
                                CASE WHEN @bulan = 13 THEN SUM(Dr_13) ELSE 0 END AS Dr_13 , 
                                '1' as status
                                FROM SMKB_Lejar_Am
                                WHERE Kod_Kump_Wang=@kw AND Kod_Operasi=@kodko AND Kod_Projek=@kodkp AND Kod_PTJ=@kodptj AND Kod_Vot=@kodvot AND Tahun=@tahun AND Kod_Syarikat=@kodSya
                                GROUP BY Kod_Vot,Kod_PTJ,Kod_Projek,Kod_Operasi,Kod_Kump_Wang"

        param.Add(New SqlParameter("@kw", kodkw))
        param.Add(New SqlParameter("@kodko", kodko))
        param.Add(New SqlParameter("@kodkp", kodkp))
        param.Add(New SqlParameter("@kodptj", kodptj))
        param.Add(New SqlParameter("@kodvot", kodvot))
        param.Add(New SqlParameter("@bulan", bulan))
        param.Add(New SqlParameter("@tahun", tahun))
        param.Add(New SqlParameter("@kodSya", kodSya))

        dt = db.Read(query, param)
        If dt IsNot Nothing Then
            If dt.Rows.Count > 0 Then
                If Akaun = "Cr" Then
                    If (bulan = 1) Then
                        Jumlah = dt.Rows(0).Item("Cr_1")
                    ElseIf (bulan = 2) Then
                        Jumlah = dt.Rows(0).Item("Cr_2")
                    ElseIf (bulan = 3) Then
                        Jumlah = dt.Rows(0).Item("Cr_3")
                    ElseIf (bulan = 4) Then
                        Jumlah = dt.Rows(0).Item("Cr_4")
                    ElseIf (bulan = 5) Then
                        Jumlah = dt.Rows(0).Item("Cr_5")
                    ElseIf (bulan = 6) Then
                        Jumlah = dt.Rows(0).Item("Cr_6")
                    ElseIf (bulan = 7) Then
                        Jumlah = dt.Rows(0).Item("Cr_7")
                    ElseIf (bulan = 8) Then
                        Jumlah = dt.Rows(0).Item("Cr_8")
                    ElseIf (bulan = 9) Then
                        Jumlah = dt.Rows(0).Item("Cr_9")
                    ElseIf (bulan = 10) Then
                        Jumlah = dt.Rows(0).Item("Cr_10")
                    ElseIf (bulan = 11) Then
                        Jumlah = dt.Rows(0).Item("Cr_11")
                    ElseIf (bulan = 12) Then
                        Jumlah = dt.Rows(0).Item("Cr_12")
                    ElseIf (bulan = 13) Then
                        Jumlah = dt.Rows(0).Item("Cr_13")
                    End If
                ElseIf Akaun = "Dr" Then
                    If (bulan = 1) Then
                        Jumlah = dt.Rows(0).Item("Dr_1")
                    ElseIf (bulan = 2) Then
                        Jumlah = dt.Rows(0).Item("Dr_2")
                    ElseIf (bulan = 3) Then
                        Jumlah = dt.Rows(0).Item("Dr_3")
                    ElseIf (bulan = 4) Then
                        Jumlah = dt.Rows(0).Item("Dr_4")
                    ElseIf (bulan = 5) Then
                        Jumlah = dt.Rows(0).Item("Dr_5")
                    ElseIf (bulan = 6) Then
                        Jumlah = dt.Rows(0).Item("Dr_6")
                    ElseIf (bulan = 7) Then
                        Jumlah = dt.Rows(0).Item("Dr_7")
                    ElseIf (bulan = 8) Then
                        Jumlah = dt.Rows(0).Item("Dr_8")
                    ElseIf (bulan = 9) Then
                        Jumlah = dt.Rows(0).Item("Dr_9")
                    ElseIf (bulan = 10) Then
                        Jumlah = dt.Rows(0).Item("Dr_10")
                    ElseIf (bulan = 11) Then
                        Jumlah = dt.Rows(0).Item("Dr_11")
                    ElseIf (bulan = 12) Then
                        Jumlah = dt.Rows(0).Item("Dr_12")
                    ElseIf (bulan = 13) Then
                        Jumlah = dt.Rows(0).Item("Cr_13")
                    End If
                End If
                Dim Jumlah_Total_ = Jumlah + Jumlah_Total
                Jumlah_Total_ = Jumlah_Total_.ToString().Replace(",", "")
                If Akaun = "Dr" Then
                    Akaun_1 = "Dr_1"
                    Akaun_2 = "Dr_2"
                    Akaun_3 = "Dr_3"
                    Akaun_4 = "Dr_4"
                    Akaun_5 = "Dr_5"
                    Akaun_6 = "Dr_6"
                    Akaun_7 = "Dr_7"
                    Akaun_8 = "Dr_8"
                    Akaun_9 = "Dr_9"
                    Akaun_10 = "Dr_10"
                    Akaun_11 = "Dr_11"
                    Akaun_12 = "Dr_12"
                    Akaun_13 = "Dr_13"

                    Dim query_1 As String = "UPDATE LP
                    SET " & Akaun_1 & " =
                        CASE WHEN @bulan=1 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_1 & " END,
                        " & Akaun_2 & " = 
                        CASE WHEN @bulan=2 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_2 & " END,
                        " & Akaun_3 & " = 
                        CASE WHEN @bulan=3 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_3 & " END,
                        " & Akaun_4 & " = 
                        CASE WHEN @bulan=4 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_4 & " END,
                        " & Akaun_5 & " = 
                        CASE WHEN @bulan=5 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_5 & " END,
                        " & Akaun_6 & " = 
                        CASE WHEN @bulan=6 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_6 & " END,
                        " & Akaun_7 & " = 
                        CASE WHEN @bulan=7 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_7 & " END,
                        " & Akaun_8 & " = 
                        CASE WHEN @bulan=8 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_8 & " END,
                        " & Akaun_9 & " = 
                        CASE WHEN @bulan=9 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_9 & " END,
                        " & Akaun_10 & " = 
                        CASE WHEN @bulan=10 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_10 & " END,
                        " & Akaun_11 & " = 
                        CASE WHEN @bulan=11 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_11 & " END,
                        " & Akaun_12 & " = 
                        CASE WHEN @bulan=12 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_12 & " END,
                        " & Akaun_13 & " = 
                        CASE WHEN @bulan=13 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_13 & " END
                    FROM SMKB_Lejar_AM LP
                    WHERE LP.Kod_Kump_Wang=@kodkw AND LP.Kod_Operasi=@kodko AND LP.Kod_Projek=@kodkp AND LP.Kod_PTJ=@kodptj AND LP.Kod_Vot=@kodvot AND Kod_Syarikat=@kodSya
                    AND LP.Tahun=@tahun"
                    Dim param_1 As New List(Of SqlParameter)
                    param_1.Add(New SqlParameter("@bulan", bulan))
                    param_1.Add(New SqlParameter("@kodkw", kodkw))
                    param_1.Add(New SqlParameter("@kodko", kodko))
                    param_1.Add(New SqlParameter("@kodkp", kodkp))
                    param_1.Add(New SqlParameter("@kodptj", kodptj))
                    param_1.Add(New SqlParameter("@kodvot", kodvot))
                    param_1.Add(New SqlParameter("@tahun", tahun))
                    param_1.Add(New SqlParameter("@kodSya", kodSya))
                    Return db.Process(query_1, param_1)

                ElseIf Akaun = "Cr" Then
                    Akaun_1 = "Cr_1"
                    Akaun_2 = "Cr_2"
                    Akaun_3 = "Cr_3"
                    Akaun_4 = "Cr_4"
                    Akaun_5 = "Cr_5"
                    Akaun_6 = "Cr_6"
                    Akaun_7 = "Cr_7"
                    Akaun_8 = "Cr_8"
                    Akaun_9 = "Cr_9"
                    Akaun_10 = "Cr_10"
                    Akaun_11 = "Cr_11"
                    Akaun_12 = "Cr_12"
                    Akaun_13 = "Cr_13"

                    Dim query_1 As String = "UPDATE LP
                    SET " & Akaun_1 & " =
                        CASE WHEN @bulan=1 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_1 & " END,
                        " & Akaun_2 & " = 
                        CASE WHEN @bulan=2 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_2 & " END,
                        " & Akaun_3 & " = 
                        CASE WHEN @bulan=3 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_3 & " END,
                        " & Akaun_4 & " = 
                        CASE WHEN @bulan=4 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_4 & " END,
                        " & Akaun_5 & " = 
                        CASE WHEN @bulan=5 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_5 & " END,
                        " & Akaun_6 & " = 
                        CASE WHEN @bulan=6 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_6 & " END,
                        " & Akaun_7 & " = 
                        CASE WHEN @bulan=7 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_7 & " END,
                        " & Akaun_8 & " = 
                        CASE WHEN @bulan=8 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_8 & " END,
                        " & Akaun_9 & " = 
                        CASE WHEN @bulan=9 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_9 & " END,
                        " & Akaun_10 & " = 
                        CASE WHEN @bulan=10 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_10 & " END,
                        " & Akaun_11 & " = 
                        CASE WHEN @bulan=11 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_11 & " END,
                        " & Akaun_12 & " = 
                        CASE WHEN @bulan=12 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_12 & " END,
                        " & Akaun_13 & " = 
                        CASE WHEN @bulan=13 THEN  " & Jumlah_Total_ & " ELSE LP." & Akaun_13 & " END
                    FROM SMKB_Lejar_Am LP
                    WHERE LP.Kod_Kump_Wang=@kodkw AND LP.Kod_Operasi=@kodko AND LP.Kod_Projek=@kodkp AND LP.Kod_PTJ=@kodptj AND LP.Kod_Vot=@kodvot AND LP.Kod_Syarikat=@kodSya
                    AND LP.Tahun=@tahun"
                    Dim param_1 As New List(Of SqlParameter)
                    param_1.Add(New SqlParameter("@bulan", bulan))
                    param_1.Add(New SqlParameter("@kodkw", kodkw))
                    param_1.Add(New SqlParameter("@kodko", kodko))
                    param_1.Add(New SqlParameter("@kodkp", kodkp))
                    param_1.Add(New SqlParameter("@kodptj", kodptj))
                    param_1.Add(New SqlParameter("@kodvot", kodvot))
                    param_1.Add(New SqlParameter("@tahun", tahun))
                    param_1.Add(New SqlParameter("@kodSya", kodSya))
                    Return db.Process(query_1, param_1)
                End If

            Else
                Dim query_2 As String
                Dim param_2 As New List(Of SqlParameter)
                If Akaun = "Cr" Then
                    query_2 = "INSERT INTO SMKB_Lejar_Am
                                SELECT  @tahun , @kodkw, @kodko,@kodptj,@kodvot,@kodkp,@kodSya,
                                '0.00' AS Debit_1 , 
                                CASE WHEN @bulan = 1 THEN " & Jumlah_Total & " ELSE 0.00 END AS Cr_1 ,
                                '0.00' AS  Debit_2 , 
                                CASE WHEN @bulan = 2 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_2 ,
                                '0.00' AS  Debit_3 , 
                                CASE WHEN @bulan = 3 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_3 ,
                                '0.00' AS  Debit_4 , 
                                CASE WHEN @bulan = 4 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_4 ,
                                '0.00' AS  Debit_5 , 
                                CASE WHEN @bulan = 5 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_5 ,
                                '0.00' AS  Debit_6 , 
                                CASE WHEN @bulan = 6 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_6 ,
                                '0.00' AS  Debit_7 , 
                                CASE WHEN @bulan = 7 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_7 ,
                                '0.00' AS Debit_8 , 
                                CASE WHEN @bulan = 8 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_8 ,
                                '0.00' AS Debit_9 , 
                                CASE WHEN @bulan = 9 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_9 ,
                                '0.00' AS Debit_10 , 
                                CASE WHEN @bulan = 10 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_10 ,
                                '0.00' AS Debit_11 , 
                                CASE WHEN @bulan = 11 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_11 ,
                                '0.00' AS Debit_12 , 
                                CASE WHEN @bulan = 12 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_12 ,
                                '0.00' AS Debit_13 , 
                                CASE WHEN @bulan = 13 THEN " & Jumlah_Total & " ELSE 0 END AS Cr_13,
                                '1' as status
                                FROM SMKB_Bil_Hdr
                                WHERE No_Bil=@nobil"
                    param_2.Add(New SqlParameter("@tahun", tahun))
                    param_2.Add(New SqlParameter("@kodkw", kodkw))
                    param_2.Add(New SqlParameter("@kodko", kodko))
                    param_2.Add(New SqlParameter("@kodkp", kodkp))
                    param_2.Add(New SqlParameter("@kodptj", kodptj))
                    param_2.Add(New SqlParameter("@kodvot", kodvot))
                    param_2.Add(New SqlParameter("@bulan", bulan))
                    param_2.Add(New SqlParameter("@nobil", nobil))
                    param_2.Add(New SqlParameter("@kodSya", kodSya))
                    Return db.Process(query_2, param_2)
                ElseIf Akaun = "Dr" Then
                    query_2 = "INSERT INTO SMKB_Lejar_Am
                        SELECT @tahun , @kodkw, @kodko,@kodptj,@kodvot,@kodkp,@kodSya,
                        CASE WHEN @bulan = 1 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_1 ,
                        '0.00' AS Cr_1 ,
                        CASE WHEN @bulan = 2 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_2 ,
                        '0.00' AS Cr_2 , 
                        CASE WHEN @bulan = 3 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_3 ,
                        '0.00' AS Cr_3 , 
                        CASE WHEN @bulan = 4 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_4 ,
                        '0.00' AS Cr_4 ,
                        CASE WHEN @bulan = 5 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_5 ,
                        '0.00' AS Cr_5 ,
                        CASE WHEN @bulan = 6 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_6 ,
                        '0.00' AS Cr_6 ,
                        CASE WHEN @bulan = 7 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_7 ,
                        '0.00' AS Cr_7 ,
                        CASE WHEN @bulan = 8 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_8 ,
                        '0.00' AS Cr_8 ,
                        CASE WHEN @bulan = 9 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_9 ,
                        '0.00' AS Cr_9 ,
                        CASE WHEN @bulan = 10 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_10 ,
                        '0.00' AS Cr_10 ,
                        CASE WHEN @bulan = 11 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_11 ,
                        '0.00' AS Cr_11 ,
                        CASE WHEN @bulan = 12 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_12 ,
                        '0.00' AS Cr_12 ,
                        CASE WHEN @bulan = 13 THEN " & Jumlah_Total & " ELSE 0 END AS Dr_13 ,
                        '0.00' AS Cr_13 ,
                        '1' as status
                        FROM SMKB_Bil_Hdr
                        WHERE No_Bil=@nobil"
                    param_2.Add(New SqlParameter("@tahun", tahun))
                    param_2.Add(New SqlParameter("@kodkw", kodkw))
                    param_2.Add(New SqlParameter("@kodko", kodko))
                    param_2.Add(New SqlParameter("@kodkp", kodkp))
                    param_2.Add(New SqlParameter("@kodptj", kodptj))
                    param_2.Add(New SqlParameter("@kodvot", kodvot))
                    param_2.Add(New SqlParameter("@bulan", bulan))
                    param_2.Add(New SqlParameter("@nobil", nobil))
                    param_2.Add(New SqlParameter("@kodSya", kodSya))
                    Return db.Process(query_2, param_2)
                End If
            End If
        End If
    End Function
End Module

<Serializable>
Public Class LedgerItem_AR
    Public Property Kod_Penghutang As String
    Public Property Kod_Kump_Wang As String
    Public Property Kod_Operasi As String
    Public Property Kod_PTJ As String
    Public Property Kod_Projek As String
    Public Property Kod_Vot As String

    Overridable Function getSum() As Double
        Return 0
    End Function
End Class