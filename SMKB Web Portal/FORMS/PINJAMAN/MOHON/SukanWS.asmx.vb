﻿Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports Org.BouncyCastle.Ocsp
Imports SMKB_Web_Portal.ModMain
Imports Org.BouncyCastle.Utilities
Imports Microsoft.Build.Framework.XamlTypes
Imports System.IO
Imports Newtonsoft
Imports Microsoft.Reporting.Chart.WebForms
Imports Microsoft.Reporting.WebForms
Imports Newtonsoft.Json.Linq
Imports System.Collections.Generic
Imports System
Imports System.Web.UI.WebControls.Expressions

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class SukanWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim glbJenPinj As String = "J00010"
    Dim glbKatPinj As String = "K00003"
    Dim queryRB As New Query 'Query rollback
    Public strConEmail As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJumlahMohon(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataJumlahMohon(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJumlahMohon(ByVal q As String) As DataTable
        Dim result As Integer
        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))
        resultTable.Columns.Add("sort", GetType(Integer))

        Dim divisor As Integer = 100

        Dim db As New DBKewConn
        Dim query As String = $"Select top 1 * from SMKB_Pinjaman_Kelayakan WHERE Jenis_Pinj = '{glbJenPinj}' And Status = '1'"
        Dim param As New List(Of SqlParameter)

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            result = CInt(dtbl.Rows(0).Item("Max_Amaun")) / divisor
            For i As Integer = 1 To result
                Dim numericValue As Integer = i * divisor
                'Min value 200
                If (numericValue >= 200) Then
                    resultTable.Rows.Add(numericValue.ToString("N0"), numericValue.ToString(), numericValue)
                End If
            Next
        Else
            resultTable.Rows.Add("-", "0", 0)
        End If

        Dim filteredTable As DataTable = resultTable.Clone()
        Dim filteredRows As DataRow()

        filteredRows = resultTable.Select("value LIKE '%" & q & "%'")

        If filteredRows.Length > 0 Then
            filteredTable = filteredRows.CopyToDataTable()
            filteredTable.DefaultView.Sort = "sort ASC"
            filteredTable = filteredTable.DefaultView.ToTable()
        End If

        Return filteredTable

    End Function

    Private Function GenerateOrderID(kodModul, prefix, butiran) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='{kodModul}' AND Prefix ='{prefix}' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dtbl = db.Read(query, param)

        queryRB = New Query()

        If dtbl.Rows.Count > 0 Then
            lastID = CInt(dtbl.Rows(0).Item("id")) + 1
            Dim resultId As String = UpdateNoAkhir($"{kodModul}", $"{prefix}", year, lastID)
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        Else
            Dim resultId As String = InsertNoAkhir($"{kodModul}", $"{prefix}", year, lastID, butiran)
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        End If
        queryRB.finish()
        newOrderID = $"{prefix}" + Format(lastID, "0000").ToString + month.ToString("00") + Right(year.ToString(), 2)

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

        Dim key As New Dictionary(Of String, String)
        key.Add("No_Akhir", ID)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("Tahun", year)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String, Butiran As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))

        Dim key As New Dictionary(Of String, String)
        key.Add("No_Akhir", ID)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("Tahun", year)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function GetIdPenghutang(staffId) As String
        Dim db As New DBKewConn
        Dim dbsm As New DBSMConn
        Dim resultId As String

        Dim query As String = "Select Kod_Penghutang From SMKB_Penghutang_Master
                              Where No_Rujukan = @staffId"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@staffId", staffId))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            resultId = dtbl.Rows(0).Item("Kod_Penghutang")
            Return resultId
        Else
            resultId = GenerateOrderID("12", "PH", "PENGHUTANG")
            param.Clear()
            'GetMaklumatStaff
            Dim query2 As String = "Select * From MS01_Peribadi
                                    Where MS01_NoStaf = @noStaff"

            param.Add(New SqlParameter("@noStaff", staffId))

            dtbl = dbsm.Read(query2, param)

            queryRB = New Query()
            If (InsertPenghutang(resultId, dtbl.Rows(0)) <> "OK") Then
                queryRB.rollback()
                Return ""
            Else
                queryRB.finish()
                Return resultId
            End If
        End If
    End Function

    Private Function InsertPenghutang(kodBaru, data) As String
        Dim query As String = "INSERT INTO SMKB_Penghutang_Master 
                                (Kod_Penghutang, No_Rujukan, Nama_Penghutang, Kategori_Penghutang, Alamat_1, Alamat_2, Poskod, Bandar, 
                                Kod_Negeri, Kod_Negara, Tel_Bimbit, Emel, Kod_Bank, No_Akaun, Status, Kod_Pejabat) 
                                VALUES (@a, @b, @c, @d, @e, @f, @g, @h, @i, @j, @k, @l, @m, @n, @o, @p)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@a", kodBaru))
        param.Add(New SqlParameter("@b", data.Item("MS01_NoStaf")))
        param.Add(New SqlParameter("@c", data.Item("MS01_Nama")))
        param.Add(New SqlParameter("@d", "ST"))
        param.Add(New SqlParameter("@e", data.Item("MS01_AlamatT1")))
        param.Add(New SqlParameter("@f", data.Item("MS01_AlamatT2")))
        param.Add(New SqlParameter("@g", data.Item("MS01_PoskodTetap")))
        param.Add(New SqlParameter("@h", data.Item("MS01_BandarTetap")))
        param.Add(New SqlParameter("@i", data.Item("MS01_NegeriTetap")))
        param.Add(New SqlParameter("@j", data.Item("MS01_NegaraTetap")))
        param.Add(New SqlParameter("@k", data.Item("MS01_NoTelBimbit")))
        param.Add(New SqlParameter("@l", data.Item("MS01_Email")))
        param.Add(New SqlParameter("@m", data.Item("MS01_KodBank")))
        param.Add(New SqlParameter("@n", data.Item("MS01_NoAkaun")))
        param.Add(New SqlParameter("@o", "1"))
        param.Add(New SqlParameter("@p", "staff"))

        Return RbQueryCmd("Kod_Penghutang", kodBaru, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SubmitPermohonanSukan(postData As String) As String
        Dim resp As New ResponseRepository

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        ' Generate New Prefix
        Dim NoPinjaman As String = GenerateOrderID("13", "PS", "Pinjaman Sukan")

        If NoPinjaman = "" Then
            resp.Failed("Permohonan tidak berjaya\nSistem gagal memproses pembiayaan ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Check Id Data SMKB_Penghutang Master
        Dim kodPenghutang As String = GetIdPenghutang(Session("ssusrID"))

        If kodPenghutang = "" Then
            resp.Failed("Permohonan tidak berjaya\nSistem gagal mendapatkan rekod penghutang ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Check Id Data SMKB_Penghutang Master
        Dim kodPemiutang As String = GetIdPemiutang(postDt("IdSyarikat"))

        If kodPemiutang = "" Then
            resp.Failed("Permohonan tidak berjaya\nSistem gagal mendapatkan rekod pemiutang ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Semak Segala Kelayakan
        Dim getData = GetTempohKelayakan(postDt)
        Dim statusLayak As String = getData("StatusLayak")

        queryRB = New Query() 'New Query

        'Insert Data Ke SMKB_Pinjaman_Hdr
        If InsertPermohonanSukan(postDt, NoPinjaman, Session("ssusrID"), kodPemiutang, kodPenghutang, statusLayak) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Insert Data Ke SMKB_Pinjaman_Dtl_Sukan
        If InsertMaklumatSukan(postDt, NoPinjaman) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Insert Data Ke SMKB_Pinjaman_Status_Dok
        If InsertPinjStatusDok(Session("ssusrID"), NoPinjaman) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        ' Add some sample data to the array
        Dim rsData As New With {
            .nopinjaman = NoPinjaman
        }
        resp.Success("Rekod telah berjaya disimpan ✅", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertPermohonanSukan(data, noPinjaman, staffId, kodPemiutang, kodPenghutang, statusLayak) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_Pinjaman_Hdr 
                                (No_Pinj, No_Staf, Kategori_Pinj, Jenis_Pinj, Tempoh_Pinj, Amaun_Mohon, Status_Dok, Kod_Pemiutang, Tkh_Mohon, Status, Kod_Penghutang, Status_Layak) 
                                VALUES (@a, @b, @c, @d, @e, @f, @g, @h, @i, @j, @k, @l)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@a", noPinjaman))
        param.Add(New SqlParameter("@b", staffId))
        param.Add(New SqlParameter("@c", glbKatPinj))
        param.Add(New SqlParameter("@d", glbJenPinj))
        param.Add(New SqlParameter("@e", data("TempohByrBalik")))
        param.Add(New SqlParameter("@f", data("AmaunMohon")))
        param.Add(New SqlParameter("@g", "28"))
        param.Add(New SqlParameter("@h", kodPemiutang))
        param.Add(New SqlParameter("@i", Date.Now))
        param.Add(New SqlParameter("@j", "A"))
        param.Add(New SqlParameter("@k", kodPenghutang))
        param.Add(New SqlParameter("@l", statusLayak)) 'Ikut kelayakan staff L atau T

        Return RbQueryCmd("No_Pinj", noPinjaman, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiPermohonan() As String
        'Dim dok As New List(Of String) From {"03"}
        Dim req As Response = getSenaraiPermohonan(Session("ssusrID"))
        Return JsonConvert.SerializeObject(req)
    End Function

    'PROSES DPT KAN DATA
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function FetchSelectedPermohonan(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        'GetData
        Dim db As New DBKewConn
        Dim dbsm As New DBSMConn
        Dim param As New List(Of SqlParameter)

        'Check Jika Data Ada
        Dim query As String = $"Select 
                            a.No_Pinj, 
                            a.Status_Dok,
                            Kategori_Pinj, 
                            Tempoh_Pinj, 
                            Amaun_Mohon,
                            b.Nama_Pemiutang As NamaSykt,
                            c.ID_Sykt As IdSykt,
                            c.No_Sykt As NoSykt,
                            d.Harga,
                            d.Jenis_Sukan As KodJenisPeralatanSukan, 
                            (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM13' And Kod_Detail = d.Jenis_Sukan) As TxtJenisPeralatanSukan
                            From SMKB_Pinjaman_Hdr a, SMKB_Pemiutang_Master b, SMKB_Syarikat_Master c, SMKB_Pinjaman_Dtl_Sukan d
                            Where a.Kod_Pemiutang = b.Kod_Pemiutang And 
                            a.No_Pinj = d.No_Pinj And
                            b.No_Rujukan = c.ID_Sykt And
                            a.No_Pinj = '{postDt("noPinjaman")}'"
        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            resultDt("DataTab1") = JsonConvert.SerializeObject(dtbl)
        End If

        param.Clear()
        Dim query2 As String = $"
                                Select a.Bil, a.No_Staf, (b.MS01_Nama) as NamaPenjamin, a.Setuju
                                From SMKB_Pinjaman_Penjamin a
                                INNER JOIN
                                VPeribadi b ON a.No_Staf = b.MS01_NoStaf
                                Where No_Pinj = '{postDt("noPinjaman")}' And Status = '1'
                                Order By Bil Asc
                                "

        dtbl = db.Read(query2, param)

        If dtbl.Rows.Count > 0 Then
            resultDt("DataTab2") = JsonConvert.SerializeObject(dtbl)
        End If

        param.Clear()
        Dim query3 As String = $"Select * From SMKB_Pinjaman_Dtl_CheckList
                                Where No_Pinj = '{postDt("noPinjaman")}' And Status = '1'"

        dtbl = db.Read(query3, param)

        If dtbl.Rows.Count > 0 Then
            resultDt("DataTab3") = JsonConvert.SerializeObject(dtbl)
        End If

        resp.Success("Rekod Ditemui", "00", resultDt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSenaraiPermohonan(staffId) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"SELECT ROW_NUMBER() OVER (ORDER BY No_Pinj) AS row_num, 
                                        FORMAT(Tkh_Mohon, 'dd/MM/yyyy') AS Tkh_Mohon, 
                                        No_Pinj, 
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' And Kod_Detail = Jenis_Pinj) As Jenis_Pinj,  
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM24' And Kod_Detail = Status_Dok) As StatusDok, 
                                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM25' And Kod_Detail = Status_Layak) As StatusLyk
                                        From SMKB_Pinjaman_Hdr
                                        WHERE Status = 'A'
                                        And Jenis_Pinj = '{glbJenPinj}'
                                        And No_Staf = '{staffId}' Order By Tkh_Mohon Asc"

                sqlcmd.CommandText = sqlText

                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using
        Catch ex As Exception
            Dim strex As String = ex.Message
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function GetSenaraiSemak(postData As String) As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        'Check Row, Ada: Update, Xde: Insert
        Dim query As String = $"Select ID_CheckList, (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM29' AND Kod_Detail = ID_Butiran) AS Butiran
                                From SMKB_Pinjaman_CheckList
                                Where Kategori_Pinj = '{glbKatPinj}' And Jenis_Pinj = '{glbJenPinj}' And Taraf_Khidmat = '{postDt("KodTarafK")}' And Status = '1'"

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            resp.Success("Rekod Ditemui", "00", dtbl)
        Else
            resp.Failed("Tiada Rekod Ditemui")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertMaklumatSukan(data, noPinjaman) As String
        Dim param As New List(Of SqlParameter)
        Dim query As String = $"INSERT INTO SMKB_Pinjaman_Dtl_Sukan
                            (No_Pinj, Jenis_Sukan, Harga, Status) 
                            VALUES ('{noPinjaman}', '{data("JenisPinjSukan")}', '{data("HargaPeralatan")}', '1')"

        Return RbQueryCmd("No_Pinj", noPinjaman, query, param)
    End Function

    Private Function InsertPinjStatusDok(staffId, noPinjaman) As String
        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status) 
                                VALUES (@Kod_Modul, @Kod_Status_Dok, @No_Rujukan, @No_Staf, @Tkh_Tindakan, @Tkh_Transaksi, @Status_Transaksi, @Status)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "13"))
        param.Add(New SqlParameter("@Kod_Status_Dok", "28"))
        param.Add(New SqlParameter("@No_Rujukan", noPinjaman))
        param.Add(New SqlParameter("@No_Staf", staffId))
        param.Add(New SqlParameter("@Tkh_Tindakan", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Status_Transaksi", "1"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("No_Rujukan", noPinjaman, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetTempohKelayakan(postDt) As Dictionary(Of String, Object)
        Dim param As New List(Of SqlParameter)
        Dim db As New DBKewConn
        Dim dbsm As New DBSMConn
        Dim resultDt As New Dictionary(Of String, Object)

        Dim query As String = $"Select Status_Dok, No_Pinj, No_Staf, tkh_mohon, DATEADD(Year, 3, tkh_mohon) AS tigatahuntempoh From SMKB_Pinjaman_Hdr
                              Where No_Staf = '{Session("ssusrID")}' AND Kategori_Pinj = '{glbKatPinj}' And Jenis_Pinj = '{glbJenPinj}'
                              And tkh_mohon = (Select Max (tkh_mohon) From SMKB_Pinjaman_Hdr Where No_Staf = '{Session("ssusrID")}' And Kategori_Pinj = '{glbKatPinj}' And Jenis_Pinj = '{glbJenPinj}' AND Status_Dok <> '28')"

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Dim statusDok As String = dtbl.Rows(0).Item("Status_Dok")
            ' Boleh mohon semula setelah bayaran terdahulu selesai
            If statusDok = "25" Then
                'Permohonan Melepasi Tapisan iaitu Status Dok 25
                resultDt = GetStatusKelayakan(postDt)
            Else
                resultDt("StatusLayak") = "T"
            End If
        Else
            'Permohonan Kali Pertama
            resultDt = GetStatusKelayakan(postDt)
        End If

        Return resultDt
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetStatusKelayakan(postDt) As Dictionary(Of String, Object)
        Dim param As New List(Of SqlParameter)
        Dim db As New DBKewConn
        Dim dbsm As New DBSMConn
        Dim resultDt As New Dictionary(Of String, Object)

        Dim query2 As String = $"WITH 
                            Elaun AS (
                                SELECT SUM(Amaun) AS Total
                                FROM SMKB_Gaji_Master 
                                WHERE No_Staf = @staffId AND Jenis_Trans = 'E' AND Tkh_Tamat > CURRENT_TIMESTAMP AND Status = 'A'
                            ),
                            Potongan AS (
                                SELECT SUM(Amaun) AS Total
                                FROM SMKB_Gaji_Master 
                                WHERE No_Staf = @staffId AND Jenis_Trans = 'P' AND Tkh_Tamat > CURRENT_TIMESTAMP AND Status = 'A'
                            ),
                            Ansuran AS (
                                SELECT Ansuran
                                FROM SMKB_Pinjaman_Jadual 
                                WHERE Kategori_Pinj = @kategoripinj And Tempoh = @tempoh And Amaun = @amaun
                            )
                            SELECT 
                                Amaun AS GajiPkok, 
                                CAST((Amaun / 3.0) AS DECIMAL(10, 2)) AS Gaji1Per3,
                                (SELECT Total FROM Elaun) AS Elaun,
                                (SELECT Total FROM Potongan) AS Potongan,
                                (SELECT Ansuran FROM Ansuran) AS Ansuran,
                                (Amaun + (SELECT Total FROM Elaun)) AS GajiKasar,
                                CAST(((0.6 * (Amaun + (SELECT Total FROM Elaun)))) AS DECIMAL(10, 2)) AS EnamPuluhPercent
                            FROM SMKB_Gaji_Master 
                            WHERE Kod_Trans = 'GAJI' AND No_Staf = @staffId AND Status = 'A'"

        param.Add(New SqlParameter("@staffId", Session("ssusrID")))
        param.Add(New SqlParameter("@kategoripinj", glbKatPinj))
        param.Add(New SqlParameter("@tempoh", postDt("TempohByrBalik")))
        param.Add(New SqlParameter("@amaun", postDt("AmaunMohon")))

        dtbl = db.Read(query2, param)

        resultDt("Ansuran") = dtbl.Rows(0).Item("Ansuran")

        'Staf tidak berada dalam tempoh hutang dan hutang telah selesai
        'Check Gaji Staf
        Dim gajiStaf As Double = CDbl(dtbl.Rows(0).Item("GajiPkok"))

        Dim elaun As Double = CDbl(dtbl.Rows(0).Item("Elaun"))
        Dim ansuran As Double = CDbl(dtbl.Rows(0).Item("Ansuran"))
        Dim gaji1per3 As Double = CDbl(dtbl.Rows(0).Item("Gaji1Per3"))
        Dim potongan As Double = CDbl(dtbl.Rows(0).Item("Potongan"))
        Dim enampercent As Double = CDbl(dtbl.Rows(0).Item("EnamPuluhPercent"))
        Dim jenisPinj As String = glbJenPinj
        Dim premise1 As Boolean = (ansuran < gaji1per3)
        Dim premise2 As Boolean = (ansuran + potongan) < enampercent

        'Min 1620.00 Gaji Staff Untuk Lulus Permohonan
        If (premise1 And premise2) Then
            resultDt("StatusLayak") = "L"
        Else
            resultDt("StatusLayak") = "T"
        End If

        Return resultDt
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTempohBayarBalik(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataTempohBayarBalik(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataTempohBayarBalik(ByVal q As String) As DataTable
        Dim result As Integer
        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(Integer))

        Dim divisor As Integer = 6

        Dim db As New DBKewConn
        Dim query As String = $"Select top 1 * from SMKB_Pinjaman_Kelayakan WHERE Jenis_Pinj = '{glbJenPinj}' And Status = '1'"
        Dim param As New List(Of SqlParameter)

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            result = CInt(dtbl.Rows(0).Item("Max_Tempoh")) / divisor
            For i As Integer = 1 To result
                Dim numericValue As Integer = i * divisor
                resultTable.Rows.Add(numericValue, numericValue)
            Next
        Else
            resultTable.Rows.Add("-", 0)
        End If

        Dim filteredTable As DataTable = resultTable.Clone()
        Dim filteredRows As DataRow()

        filteredRows = resultTable.Select("text LIKE '%" & q & "%'")

        If filteredRows.Length > 0 Then
            filteredTable = filteredRows.CopyToDataTable()
            filteredTable.DefaultView.Sort = "value ASC"
            filteredTable = filteredTable.DefaultView.ToTable()
        End If

        Return filteredTable

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function SubmitPenjamin(postData As String) As String
        Dim resp As New ResponseRepository

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        ' Convert the JSON string to a VB.NET array of strings
        Dim stringArray As String() = JsonConvert.DeserializeObject(Of String())(postDt("DataPenjamin"))

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        'Check Jika Data Ada
        Dim query As String = $"Select * From SMKB_Pinjaman_Penjamin
                                Where No_Pinj = '{postDt("NoPinjaman")}'"
        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            'Update Status To 0
            param.Clear()
            queryRB = New Query()
            Dim query2 As String = $"Update SMKB_Pinjaman_Penjamin Set
                                        Status='0' Where No_Pinj = '{postDt("NoPinjaman")}'"
            If RbQueryCmd("No_Pinj", postDt("NoPinjaman"), query2, param) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal mengemaskini rekod Penjamin")
                Return JsonConvert.SerializeObject(resp.GetResult())
            Else
                queryRB.finish()
            End If
        End If

        ' Display the elements in the array
        Dim bilgn As Integer = 0

        ' Define New Query
        queryRB = New Query()
        For Each noStaff As String In stringArray
            ' Tambah Ke Db Penjamin
            bilgn += 1
            If SetPenjamin(noStaff, postDt, bilgn) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal menyimpan rekod penjamin")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit For
            End If
        Next
        queryRB.finish()

        resp.Success("Rekod telah berjaya disimpan ✅", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function ClearPenjamin(postData As String) As String
        Dim resp As New ResponseRepository

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        queryRB = New Query()

        'Check Jika Data Ada
        Dim query As String = $"Select * From SMKB_Pinjaman_Penjamin
                                Where No_Pinj = '{postDt("NoPinjaman")}'"
        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            'Update Status To 0
            param.Clear()
            Dim query2 As String = $"Update SMKB_Pinjaman_Penjamin Set
                                        Status='0' Where No_Pinj = '{postDt("NoPinjaman")}'"
            If RbQueryCmd("No_Pinj", postDt("NoPinjaman"), query2, param) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal mengemaskini rekod penjamin")
                Return JsonConvert.SerializeObject(resp.GetResult())
            Else
                queryRB.finish()
                resp.Success("Rekod telah berjaya dikemaskini ✅", "00")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Else
            resp.Failed("Rekod tidak ditemui")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    Private Function SetPenjamin(noStaff, data, bilgn) As String
        Dim db As New DBKewConn
        Dim dbsm As New DBSMConn
        Dim noPinjaman As String = data("NoPinjaman")
        Dim param As New List(Of SqlParameter)

        'Check Row, Ada: Update, Xde: Insert
        'Dim query As String = $"Select * From SMKB_Pinjaman_Penjamin
        '                        Where No_Pinj = '{noPinjaman}' And Bil = '{bilgn}'"
        'dtbl = db.Read(query, param)

        'If dtbl.Rows.Count > 0 Then
        '    'UPDATE
        '    param.Clear()
        '    Dim query2 As String = $"Update SMKB_Pinjaman_Penjamin Set
        '                            No_Staf='{noStaff}',Status='1'
        '                            Where No_Pinj = '{noPinjaman}'
        '                            And Bil = '{bilgn}'"

        '    Return RbQueryCmd("No_Pinj", noPinjaman, query2, param)
        'Else

        'End If

        param.Clear()
        'Get Kod PTj
        Dim query3 As String = $"Select MS08_Pejabat As KodPtj From MS08_Penempatan
                                    Where MS01_NoStaf = '{noStaff}' And MS08_StaTerkini = '1'"
        dtbl = dbsm.Read(query3, param)

        Dim kodptj As String = dtbl.Rows(0).Item("KodPtj")

        'INSERT
        Dim query4 As String = $"INSERT INTO SMKB_Pinjaman_Penjamin 
                                    (No_Pinj, Bil, No_Staf, Kod_PTj, Butir_Hutang, Status, Kategori_Pinj)
                                    VALUES ('{noPinjaman}', '{bilgn}', '{noStaff}', '{kodptj}', '-', '1', '{glbKatPinj}')"
        Return RbQueryCmd("No_Pinj", noPinjaman, query4, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function KemaskiniPermohonanSukan(postData As String) As String
        Dim db As New DBKewConn
        Dim resp As New ResponseRepository
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        ' Access data using keys
        'Dim value1 As String = postDt("NoPendaftaran")

        ' Get No Pinjamam
        Dim NoPinjaman As String = postDt("NoPinjaman")
        Dim kodPemiutang As String = GetIdPemiutang(postDt("IdSyarikat"))

        If kodPemiutang = "" Then
            resp.Failed("Permohonan tidak berjaya\nSistem gagal mendapatkan rekod pemiutang ‼️")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB = New Query()

        Dim query As String = $"Update SMKB_Pinjaman_Hdr Set
                            Jenis_Pinj= '{glbJenPinj}', Tempoh_Pinj= '{postDt("TempohByrBalik")}', Amaun_Mohon= '{postDt("AmaunMohon")}', Kod_Pemiutang= '{kodPemiutang}'
                            Where No_Pinj = '{NoPinjaman}'"

        Dim query2 As String = $"Update SMKB_Pinjaman_Dtl_Sukan Set
                                Jenis_Sukan = '{postDt("JenisPinjSukan")}', Harga = '{postDt("HargaPeralatan")}'
                                Where No_Pinj = '{NoPinjaman}'"

        Dim UpdHdr As String = RbQueryCmd("No_Pinj", NoPinjaman, query, param)
        Dim UpdDtl As String = RbQueryCmd("No_Pinj", NoPinjaman, query2, param)

        If UpdHdr <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod pinjaman hdr")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdDtl <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod pinjaman dlt sukan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB.finish()
        resp.Success("Rekod telah berjaya dikemaskini ✅", "00")
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetIdPemiutang(idSyarikat) As String
        Dim db As New DBKewConn
        Dim resultId As String

        Dim query As String = "Select Kod_Pemiutang From SMKB_Pemiutang_Master 
                                Where No_Rujukan = @idSyarikat"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idSyarikat", idSyarikat))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            resultId = dtbl.Rows(0).Item("Kod_Pemiutang")
            Return resultId
        Else
            resultId = GenerateOrderID("03", "PM", "PEMIUTANG")
            param.Clear()
            'GetMaklumatSyarikat
            Dim query2 As String = "Select * From SMKB_Syarikat_Master
                                    Where ID_Sykt = @ID_Sykt"

            param.Add(New SqlParameter("@ID_Sykt", idSyarikat))

            dtbl = db.Read(query2, param)

            queryRB = New Query()

            If InsertPemiutang(resultId, dtbl.Rows(0)) <> "OK" Then
                queryRB.rollback()
                Return ""
            Else
                queryRB.finish()
                Return resultId
            End If
        End If
    End Function

    Private Function InsertPemiutang(kodBaru, data) As String
        Dim query As String = "INSERT INTO SMKB_Pemiutang_Master 
                                (Kod_Pemiutang, No_Rujukan, Nama_Pemiutang, Kategori_Pemiutang, Alamat_1, Alamat_2, Bandar, Poskod, Kod_Negeri, Kod_Negara, 
                                Tel_Bimbit, Emel, No_Akaun,Kod_Bank, Status) 
                                VALUES (@a, @b, @c, @d, @e, @f, @g, @h, @i, @j, @k, @l, @m, @n, @o)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@a", kodBaru))
        param.Add(New SqlParameter("@b", data.Item("ID_Sykt")))
        param.Add(New SqlParameter("@c", data.Item("Nama_Sykt")))
        param.Add(New SqlParameter("@d", "SY"))
        param.Add(New SqlParameter("@e", data.Item("Almt_Semasa_1")))
        param.Add(New SqlParameter("@f", data.Item("Almt_Semasa_2")))
        param.Add(New SqlParameter("@g", data.Item("Bandar_Semasa")))
        param.Add(New SqlParameter("@h", data.Item("Poskod_Semasa")))
        param.Add(New SqlParameter("@i", data.Item("Kod_Negeri_Semasa")))
        param.Add(New SqlParameter("@j", data.Item("Kod_Negara_Semasa")))
        param.Add(New SqlParameter("@k", data.Item("Tel_Bimbit_Semasa")))
        param.Add(New SqlParameter("@l", data.Item("Emel_Semasa")))
        param.Add(New SqlParameter("@m", data.Item("No_Akaun")))
        param.Add(New SqlParameter("@n", data.Item("Kod_Bank")))
        param.Add(New SqlParameter("@o", "1"))

        Return RbQueryCmd("Kod_Pemiutang", kodBaru, query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisPinjSukan(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataJenisPinjSukan(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisPinjSukan(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM13"))

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        dtbl2 = db.Read(query, param)

        If dtbl2.Rows.Count > 0 Then
            For Each row As DataRow In dtbl2.Rows
                resultTable.Rows.Add(row.Item("text"), row.Item("value"))
            Next
        Else
            resultTable.Rows.Add("-", "-")
        End If

        Dim filteredTable As DataTable = resultTable.Clone()
        Dim filteredRows As DataRow()

        filteredRows = resultTable.Select("text LIKE '%" & q & "%'")

        If filteredRows.Length > 0 Then
            filteredTable = filteredRows.CopyToDataTable()
            filteredTable.DefaultView.Sort = "text ASC"
            filteredTable = filteredTable.DefaultView.ToTable()
        End If

        Return filteredTable
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function PadamSenaraiSemak(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        queryRB = New Query()

        'Check Row, Ada: Update, Xde: Insert
        Dim query As String = $"Select Nama_Fail From SMKB_Pinjaman_Dtl_CheckList
                              Where No_Pinj='{postDt("NoPinjaman")}' And ID_CheckList = '{postDt("CheckListId")}'"

        dtbl = db.Read(query)

        If dtbl.Rows.Count > 0 Then
            Dim query2 As String = $"UPDATE SMKB_Pinjaman_Dtl_CheckList
                            Set Status = '0'
                            where No_Pinj=@No_Pinj And ID_CheckList = @ID_CheckList"

            param.Add(New SqlParameter("@No_Pinj", postDt("NoPinjaman")))
            param.Add(New SqlParameter("@ID_CheckList", postDt("CheckListId")))
            Dim result As String = RbQueryCmd("No_Pinj", postDt("NoPinjaman"), query2, param)

            If result <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal membuang rekod fail")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            queryRB.finish()
            'DeleteFile($"~/Upload/Document/PINJAMAN/MOHON/{dtbl.Rows(0).Item("Nama_Fail")}")
            DeleteFile(Server.MapPath($"~/Upload/Document/PINJAMAN/MOHON/{dtbl.Rows(0).Item("Nama_Fail")}"))
            resp.Success("Fail telah berjaya dipadam", "00")
        Else
            resp.Failed("Tiada rekod ditemui")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Public Sub DeleteFile(filePath As String)
        If File.Exists(filePath) Then
            Try
                File.Delete(filePath)
                Console.WriteLine("File deleted.")
            Catch ex As Exception
                Console.WriteLine("An error occurred: " & ex.Message)
            End Try
        Else
            Console.WriteLine("File does not exist.")
        End If
    End Sub

    <WebMethod(EnableSession:=True)>
    Function SubmitCheckList() As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("File")
        Dim fileName As String = HttpContext.Current.Request.Form("NamaFile")
        Dim fileSize As Long = postedFile.ContentLength
        Dim fileExtension As String = Path.GetExtension(fileName).ToLower()

        Dim noPinjaman As String = HttpContext.Current.Request.Form("NoPinjaman")
        Dim checkListId As String = HttpContext.Current.Request.Form("CheckListId")
        Dim resp As New ResponseRepository


        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim resultDt As New Dictionary(Of String, Object)
        Dim json As New JavaScriptSerializer()

        Try
            ' Specify the file path where you want to save the uploaded file
            Dim folderPath As String = Server.MapPath("~/UPLOAD/DOCUMENT/PINJAMAN/MOHON/")
            Dim savePath As String = Path.Combine(folderPath, $"{noPinjaman}{Session("ssusrID")}{checkListId}{fileExtension}")

            ' Check if the folder for No_Mohon exists, create it if not
            If Not Directory.Exists(folderPath) Then
                Directory.CreateDirectory(folderPath)
            End If

            ' Check file extension on the server side
            If Not IsFileExtensionValid(fileExtension) Then
                '' Delete the file if the extension is not valid
                File.Delete(savePath)
                resultDt("success") = False
                resultDt("message") = "Format fail tidak sah. Hanya fail PDF sahaja yang dibenarkan"
                Return json.Serialize(resultDt)
            End If

            ' Check Data Exist In DB
            Dim query As String = $"Select * From SMKB_Pinjaman_Dtl_CheckList
                                  Where No_Pinj = '{noPinjaman}' And ID_CheckList = '{checkListId}'"

            dtbl = db.Read(query, param)

            If dtbl.Rows.Count > 0 Then
                queryRB = New Query()
                resultDt("success") = True
                resultDt("message") = "Fail berjaya di kemaskini"
                param.Clear()
                Dim query2 As String = $"UPDATE SMKB_Pinjaman_Dtl_CheckList
                            Set Status = '1'
                            where No_Pinj=@No_Pinj And ID_CheckList = @ID_CheckList"

                param.Add(New SqlParameter("@No_Pinj", noPinjaman))
                param.Add(New SqlParameter("@ID_CheckList", checkListId))
                Dim result As String = RbQueryCmd("No_Pinj", noPinjaman, query2, param)

                If result <> "OK" Then
                    queryRB.rollback()
                    resultDt("success") = False
                    resultDt("message") = "Gagal menyimpan rekod fail"
                    Return json.Serialize(resultDt)
                Else
                    queryRB.finish()
                End If

                ' Save the file to the specified path
                postedFile.SaveAs(savePath)
                Return json.Serialize(resultDt)
            Else
                queryRB = New Query()
                Dim query3 As String = $"INSERT INTO SMKB_Pinjaman_Dtl_CheckList
                                    (No_Pinj, ID_CheckList, Hantar, Nama_Fail, Tkh_Fail, Status) 
                                    VALUES (@a, @b, @c, @d, @e, @f)"
                param.Clear()
                param.Add(New SqlParameter("@a", noPinjaman))
                param.Add(New SqlParameter("@b", checkListId))
                param.Add(New SqlParameter("@c", "1"))
                param.Add(New SqlParameter("@d", $"{noPinjaman}{Session("ssusrID")}{checkListId}{fileExtension}"))
                param.Add(New SqlParameter("@e", Date.Now))
                param.Add(New SqlParameter("@f", "1"))

                'Dim db As New DBKewConn
                Dim result As String = RbQueryCmd("No_Pinj", noPinjaman, query3, param)

                If result <> "OK" Then
                    queryRB.rollback()
                    resultDt("success") = False
                    resultDt("message") = "Gagal menyimpan rekod fail"
                    Return json.Serialize(resultDt)
                Else
                    queryRB.finish()
                End If

                ' Save the file to the specified path
                postedFile.SaveAs(savePath)

                resultDt("success") = True
                resultDt("message") = "Fail berjaya dimuat naik"
                Return json.Serialize(resultDt)
            End If
        Catch ex As Exception
            resultDt("success") = False
            resultDt("message") = "Ralat memuat naik fail: " & ex.Message
            Return json.Serialize(resultDt)
        End Try
    End Function

    Private Function IsFileExtensionValid(extension As String) As Boolean
        ' Check if the file extension is valid (e.g., only allow PDF files)
        Return extension = ".pdf"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function PermohonanLengkap(postData As String) As String
        Dim resp As New ResponseRepository
        Dim sendDt As New Dictionary(Of String, Object)

        Dim db As New DBKewConn
        Dim dtbl2 As DataTable
        Dim dtbl3 As DataTable
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        'Check Jika Data Ada
        Dim query0 As String = $"Select * From SMKB_Pinjaman_Hdr Where No_Staf = '{Session("ssusrID")}' And Kategori_Pinj = '{glbKatPinj}' And Status_Dok = '01'"
        dtbl3 = db.Read(query0, param)

        If dtbl3.Rows.Count > 0 Then
            resp.Failed("Terdapat Permohonan Pembiayaan Yang Sedang Diproses. Permohonan ini tidak dapat dihantar.")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            queryRB = New Query()

            'Check Jika Data Ada
            Dim query As String = $"Select Top 1 * From SMKB_Pinjaman_Hdr Where No_Pinj = '{postDt("NoPinjaman")}'"
            dtbl = db.Read(query, param)

            If dtbl.Rows.Count > 0 Then
                'Update Status To 0
                param.Clear()
                Dim stdok = "01" 'Status Berjaya
                Dim query2 As String = $"Update SMKB_Pinjaman_Hdr Set
                                   Status_Dok='{stdok}' Where No_Pinj = '{postDt("NoPinjaman")}'"
                Dim Status As String = RbQueryCmd("No_Pinj", postDt("NoPinjaman"), query2, param)

                Dim query3 As String = $"INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status) 
                                VALUES ('13', '{stdok}', '{postDt("NoPinjaman")}', '{Session("ssusrID")}', @Tkh_Tindakan, @Tkh_Transaksi, '1', '1')"

                param.Add(New SqlParameter("@Tkh_Tindakan", Date.Now))
                param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))
                Dim StatusDok As String = RbQueryCmd("No_Rujukan", postDt("NoPinjaman"), query3, param)

                If Status <> "OK" Then
                    queryRB.rollback()
                    resp.Failed("Kemaskini Pinjaman Hdr Tidak Berjaya")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If

                If StatusDok <> "OK" Then
                    queryRB.rollback()
                    resp.Failed("Kemaskini Status Dok Tidak Berjaya")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If

                queryRB.finish()

                ' Get NoStaf Penjamin
                Dim query4 As String = $"Select No_Staf As NoStaf From SMKB_Pinjaman_Penjamin Where No_Pinj = '{postDt("NoPinjaman")}' And Status = '1'"
                param.Clear()
                ' Execute the read query
                dtbl2 = db.Read(query4, param)

                ' Hantar Emel Ke Setiap Penjamin
                If dtbl2.Rows.Count > 0 Then
                    For Each row As DataRow In dtbl2.Rows
                        sendDt("NoStaffPenjamin") = row.Item("NoStaf")
                        ProsesEmelKePenjamin(sendDt)
                    Next
                Else
                    'resp.Success("Tiada Rekod Ditemui", "00") ' Permohonan Tanpa Penjamin
                    'Return JsonConvert.SerializeObject(resp.GetResult())
                End If

                resp.Success("Permohonan Berjaya Dihantar", "00")
                Return JsonConvert.SerializeObject(resp.GetResult())
            Else
                resp.Failed("Tiada Rekod Ditemui")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        End If
    End Function

    Private Function ProsesEmelKePenjamin(sendDt) As String
        Dim dbsm As New DBSMConn
        Dim param As New List(Of SqlParameter)
        Dim dtbl As DataTable
        Dim dtbl2 As DataTable

        ' read query
        Dim query As String = $"SELECT Top 1 MS01_Email As EmelStaf FROM MS01_Peribadi WHERE MS01_NoStaf = '{sendDt("NoStaffPenjamin")}'"

        Dim query2 As String = $"SELECT MS01_Nama As NamaPeminjam FROM MS01_Peribadi WHERE MS01_NoStaf = '{Session("ssusrID")}'"

        ' Execute the read query
        dtbl = dbsm.Read(query, param)
        dtbl2 = dbsm.Read(query2, param)
        ' Check if the data exist
        If dtbl.Rows.Count > 0 Then
            Dim subject As String = $"PENGUJIAN PERMOHONAN SKIM PEMBIAYAAN PERALATAN SUKAN STAF UTeM"
            Dim body As String = "<html><body>" &
                               "<p style='font-size:16px; font-weight:bold;'>PENGUJIAN PERMOHONAN SKIM PEMBIAYAAN PERALATAN SUKAN STAF UTeM</p><br/><br/>" &
                               $"<p>Dimaklumkan bahawa, tuan/puan telah disenaraikan sebagai penjamin bagi permohonan peralatan sukan {dtbl2.Rows(0).Item("NamaPeminjam")}</p>" &
                               "<p>Sehubungan dengan itu,dipohon kerjasama tuan/puan untuk mengesahkan maklumat penjamin didalam Portal SMKB sekiranya tuan/puan bersetuju untuk menjadi penjamin.</p>" &
                               "<p>Makluman ini adalah secara automatik daripada Sistem Maklumat Kewangan Bersepadu.</p>" &
                               "<p>Anda tidak perlu membalas email ini.</p>" &
                           "</body></html>"
            ' Send the email
            'dtbl.Rows(0).Item("EmelStaf")
            MyEmel(dtbl.Rows(0).Item("EmelStaf"), subject, body)
        End If
        Return 0
    End Function

    Public Function MyEmel(alamat, subject, body)
        Dim cnExec As OleDb.OleDbConnection
        Dim cmdExec As OleDb.OleDbCommand

        Try
            cnExec = New OleDb.OleDbConnection(strConEmail)
            cnExec.Open()

            cmdExec = New OleDb.OleDbCommand("EXEC msdb.dbo.sp_send_dbmail @profile_name= 'EmailSmkb', @recipients= '" & alamat & "', @subject = '" & subject & "', " &
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

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SemakKelayakan(postData As String) As String
        Dim resp As New ResponseRepository

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim tmpDT As DataTable = DataSemakKelayakan(postDt, Session("ssusrID"))
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function DataSemakKelayakan(postDt, noStaff) As DataTable
        Dim resultTable As New DataTable()
        Dim dtbl2 As DataTable

        Dim skimMksm As String
        Dim stsPrmhnan As String
        Dim jmlhAnsrn As String

        resultTable.Columns.Add("skimMksm", GetType(String))
        resultTable.Columns.Add("stsPrmhnan", GetType(String))
        resultTable.Columns.Add("jmlhAnsrn", GetType(String))
        resultTable.Columns.Add("status", GetType(Boolean))

        Dim db As New DBKewConn
        Dim query As String
        Dim param As New List(Of SqlParameter)

        query = "Select top 1 * from SMKB_Pinjaman_Kelayakan WHERE Jenis_Pinj = @jnsPnjmn And Status = '1'"

        param.Add(New SqlParameter("@jnsPnjmn", glbJenPinj))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            skimMksm = dtbl.Rows(0).Item("Max_Amaun")

            Dim getDt = GetStatusKelayakan(postDt)
            jmlhAnsrn = getDt("Ansuran")

            Dim statusLayak = getDt("StatusLayak")

            Dim query2 As String = "Select Butiran As StatusLayakTxt FROM SMKB_Lookup_Detail WHERE Kod = 'PJM25' And Kod_Detail = @statusLayak"
            param.Clear()
            param.Add(New SqlParameter("@statusLayak", statusLayak))

            dtbl2 = db.Read(query2, param)
            stsPrmhnan = dtbl2.Rows(0).Item("StatusLayakTxt")

            resultTable.Rows.Add(skimMksm, stsPrmhnan, jmlhAnsrn, True)
        Else
            resultTable.Rows.Add("-", "-", "-", True)
        End If

        Return resultTable

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmd(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        Return If(queryRB.execute(idValue, idKey, cmd) < 0, "X", "OK")
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmdMulti(idKey As Dictionary(Of String, String), strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        Dim key As New Dictionary(Of String, String)

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        Return If(queryRB.execute(idKey, cmd) < 0, "X", "OK")
    End Function
End Class