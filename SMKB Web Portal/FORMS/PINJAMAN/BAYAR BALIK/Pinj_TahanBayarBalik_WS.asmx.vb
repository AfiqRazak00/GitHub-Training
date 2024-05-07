Imports System.ComponentModel
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Newtonsoft.Json

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Pinj_TahanBayarBalik_WS
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    'senarai invois yg belum ada atau masih draf baucar
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function loadListPermohonanData(ByVal DateStart As String, ByVal DateEnd As String) As String
        'Dim userID As String = Session("ssusrID")
        Dim req As Response = getListPermohonan(DateStart, DateEnd)
        Return JsonConvert.SerializeObject(req)
    End Function

    Private Function getListPermohonan(DateStart As String, DateEnd As String) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"SELECT ROW_NUMBER() OVER (ORDER BY A.No_Pinj) AS Bil,
                                        A.No_Pinj, A.No_Staf, B.MS01_Nama, A.Tkh_Mohon, FORMAT(CONVERT(datetime, A.Tkh_Mohon), 'dd/MM/yyyy') AS FormattedDate, A.Jenis_Pinj, 
                                        (SELECT Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM01' AND Kod_Detail = A.Jenis_Pinj) AS Jenis_Pinj_Desc, 
                                        FORMAT(Amaun, 'N2') AS Amaun,A.Status_Dok
                                        FROM SMKB_Pinjaman_Hdr A
                                        INNER JOIN {DBStaf}MS01_Peribadi B ON B.MS01_NoStaf = A.No_Staf
                                        WHERE A.Status_Dok IN ('08','09') 
                                        And A.Status = 'A'  
                                        "

                If DateStart IsNot Nothing And DateStart <> "" Then
                    sqlText += " AND A.Tkh_Mohon >= @DateStart "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateStart", DateStart))
                End If

                If DateEnd IsNot Nothing And DateEnd <> "" Then
                    sqlText += " AND A.Tkh_Mohon <= @DateEnd "
                    sqlcmd.Parameters.Add(New SqlParameter("@DateEnd", DateEnd))
                End If

                sqlText += " ORDER BY Bil DESC;"

                'sqlcmd.Parameters.Add(New SqlParameter("@kodpejabat", kodpejabat))
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

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadMaklumatPinjaman(ByVal No_Pinj As String) As String
        Dim pinj As Response = GetMaklumatPinjaman(No_Pinj)
        If pinj.Code <> "200" Then
            Return JsonConvert.SerializeObject(pinj)
        End If

        Dim data As New Dictionary(Of String, Object)()
        data.Add("hdr", pinj.Payload)

        Return JsonConvert.SerializeObject(pinj)
    End Function

    Private Function GetMaklumatPinjaman(No_Pinj As String) As Response
        Dim res As New Response
        res.Code = 200
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn
                sqlcmd.CommandText = $"SELECT A.No_Pinj, A.No_Staf,B.MS01_Nama AS Nama,FORMAT(A.Amaun,'N2') AS Amaun_Formatted, A.Tempoh_Pinj, A.Amaun,
                                    (SELECT Faedah FROM SMKB_Pinjaman_Kawalan WHERE Kategori_Pinj = A.Kategori_Pinj AND Jenis_Pinj = A.Jenis_Pinj) AS faedahpercent,
                                    (SELECT TOP 1 Kod_Trans FROM SMKB_Gaji_Master WHERE No_Staf = A.No_Staf AND Catatan = A.No_Pinj) AS Kod_Trans
                                    FROM SMKB_Pinjaman_Hdr A
                                    INNER JOIN {DBStaf}MS01_Peribadi B ON B.MS01_NoStaf = A.No_Staf
                                    WHERE A.No_Pinj = @No_Pinj
                                    "
                sqlcmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
                dt.Load(sqlcmd.ExecuteReader())
                res.Payload = dt
            End Using

        Catch ex As Exception
            res.Code = 500
            res.Message = ex.Message
        End Try
        Return res
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function loadJadualBayarBalik(ByVal No_Pinj As String) As String
        Dim req As Response = getJadualBayarBalik(No_Pinj)
        Return JsonConvert.SerializeObject(req)
    End Function

    Private Function getJadualBayarBalik(ByVal No_Pinj As String) As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = "SELECT ROW_NUMBER() OVER (ORDER BY Bil_Byr) AS bil,
                                        No_Pinj,Bil_Byr,Bulan_Byrn,Tahun_Byrn, (Bulan_Byrn + ' - ' + Tahun_Byrn) AS Bulan_Tahun,
                                        FORMAT(Pokok,'N2') AS Pokok,FORMAT(Faedah,'N2') AS Faedah, FORMAT(Ansuran,'N2') AS Ansuran,FORMAT(Baki_Pokok,'N2') AS Baki_Pokok, Status, Status_GJ
                                        FROM SMKB_Pinjaman_Jadual_Bayar_Balik
                                        WHERE No_Pinj = @No_Pinj AND Status_Byrn NOT IN ('TA')
                                        "
                sqlcmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
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

    Public Class ChecklistItem
        Public Property ID As String 'Bil_Byr
        Public Property isChecked As Boolean
        Public Property pokok As Decimal
        Public Property faedah As Decimal
        Public Property ansuran As Decimal
        Public Property bakiPokok As Decimal
        Public Property bulan As String
        Public Property tahun As String
        Public Property statusGJ As String
    End Class

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function saveTahanBayarBalik(pinjaman As PinjamanTahanBayarBalik, checklistData As ChecklistItem()) As String
        Dim response As New Response
        response.Code = 200
        response.Message = "Proses Tahan Bayar Balik berjaya"

        Dim userID As String = HttpContext.Current.Session("ssusrID")
        Dim query As New Query
        Dim multikey As New Dictionary(Of String, String)

        Dim countTahan As Integer = 0
        Dim indTahan As Integer = 0
        Dim lastIdSudahBayar, lastIdBeforeTahan As Integer
        Dim stDateBeforeTahan, edDateBeforeTahan As DateTime
        Dim lastAnsuranBeforeTahan As Decimal

        pinjaman.Status_Dok = "09"

        Dim dtTemp As New DataTable
        Dim newRow As DataRow
        dtTemp.Columns.Add("No_Pinj", GetType(String))
        dtTemp.Columns.Add("Bil_Byr", GetType(Integer))
        dtTemp.Columns.Add("Pokok", GetType(Decimal))
        dtTemp.Columns.Add("Faedah", GetType(Decimal))
        dtTemp.Columns.Add("Ansuran", GetType(Decimal))
        dtTemp.Columns.Add("Baki_Pokok", GetType(Decimal))
        dtTemp.Columns.Add("Status_Byrn", GetType(String))
        dtTemp.Columns.Add("Bulan_Byrn", GetType(String))
        dtTemp.Columns.Add("Tahun_Byrn", GetType(String))


        Dim dtTempGajiMasterBeforeTahan As New DataTable
        Dim newRowGajiMasterBeforeTahan As DataRow
        dtTempGajiMasterBeforeTahan.Columns.Add("No_Pinj", GetType(String))
        dtTempGajiMasterBeforeTahan.Columns.Add("Bil_Byr", GetType(Integer))
        dtTempGajiMasterBeforeTahan.Columns.Add("Bulan_Byrn", GetType(String))
        dtTempGajiMasterBeforeTahan.Columns.Add("Tahun_Byrn", GetType(String))

        'update status in SMKB_Pinjaman_Jadual_Bayar_Balik
        For Each item As Object In checklistData
            Try
                Dim id As String = item.ID 'Bil_Byr
                Dim isChecked As Integer = If(item.isChecked, 1, 0)  'if checked tahan, else not
                Dim isGajiBayar As String = item.statusGJ   'if Y then already paid, else not
                pinjaman.Status_Byrn = If(item.isChecked, "T", "A")
                pinjaman.Status = If(item.isChecked, 0, 1)

                'get last monthyear tahan
                If (isChecked) Then
                    indTahan = 1
                    countTahan += 1
                    pinjaman.Status_Byrn = "T"
                    pinjaman.Bulan_Byrn = item.bulan 'to start new jadual record
                    pinjaman.Tahun_Byrn = item.tahun 'to start new jadual record
                End If

                'update Status_Byrn and Status in current jadual bayar balik if tahan exists
                If (indTahan) = 1 Then
                    pinjaman.Status_Byrn = If(pinjaman.Status_Byrn = "A", "TA", pinjaman.Status_Byrn)
                    pinjaman.Status = If(pinjaman.Status = "1", 0, pinjaman.Status)

                    multikey.Clear()
                    multikey.Add("No_Pinj", pinjaman.No_Pinj)
                    multikey.Add("Bil_Byr", id)
                    If query.execute(multikey, pinjaman.updateCommand(pinjaman.No_Pinj, id)) < 0 Then
                        response.Code = 500
                        response.Message = "Maklumat tahan bayar balik gagal di simpan"
                        query.rollback()
                        Return JsonConvert.SerializeObject(response)
                    End If

                    'save record after end of tahan into temptable
                    newRow = dtTemp.NewRow()
                    newRow("No_Pinj") = pinjaman.No_Pinj
                    newRow("Bil_Byr") = id
                    newRow("Pokok") = item.pokok
                    newRow("Faedah") = item.faedah
                    newRow("Ansuran") = item.ansuran
                    newRow("Baki_Pokok") = item.bakiPokok
                    newRow("Status_Byrn") = "N"
                    dtTemp.Rows.Add(newRow)
                End If

                'CASE 1 - no payment done
                'get first record before tahan to insert into SMKB_Gaji_Master
                If isGajiBayar.Equals("N") And countTahan = 0 And isGajiBayar <> "Y" Then
                    lastIdSudahBayar = id
                    Dim existingRow As DataRow = Nothing

                    ' Iterate through the rows to find a matching row based on some criteria
                    For Each row As DataRow In dtTempGajiMasterBeforeTahan.Rows
                        If row("No_Pinj").ToString() = pinjaman.No_Pinj Then
                            existingRow = row
                            Exit For
                        End If
                    Next

                    If existingRow IsNot Nothing Then
                        'do nothing
                    Else
                        ' save only first record
                        newRowGajiMasterBeforeTahan = dtTempGajiMasterBeforeTahan.NewRow()
                        newRowGajiMasterBeforeTahan("No_Pinj") = pinjaman.No_Pinj
                        newRowGajiMasterBeforeTahan("Bil_Byr") = id
                        newRowGajiMasterBeforeTahan("Bulan_Byrn") = item.bulan
                        newRowGajiMasterBeforeTahan("Tahun_Byrn") = item.tahun
                        dtTempGajiMasterBeforeTahan.Rows.Add(newRowGajiMasterBeforeTahan)
                        stDateBeforeTahan = New DateTime(item.tahun, item.bulan, 1)
                        lastAnsuranBeforeTahan = item.ansuran
                    End If
                ElseIf countTahan = 1 Then
                    lastIdBeforeTahan = id - 1
                    edDateBeforeTahan = New DateTime(item.tahun, item.bulan, 1).AddDays(-1)
                End If

            Catch ex As Exception
                response.Code = 500
                response.Message = ex.Message
                query.rollback()
                Return JsonConvert.SerializeObject(response)
            End Try
        Next

        'to store record gaji master after tahan
        Dim dtTempGajiMasterAfterTahan As New DataTable
        Dim newRowGajiMasterAfterTahan As DataRow
        dtTempGajiMasterAfterTahan.Columns.Add("No_Staf", GetType(String))
        dtTempGajiMasterAfterTahan.Columns.Add("Kod_Trans", GetType(String))
        dtTempGajiMasterAfterTahan.Columns.Add("Amaun", GetType(String))
        dtTempGajiMasterAfterTahan.Columns.Add("stDate", GetType(DateTime))
        dtTempGajiMasterAfterTahan.Columns.Add("No_Pinjaman", GetType(String))
        dtTempGajiMasterAfterTahan.Columns.Add("Bil", GetType(String))

        'generate new row of jadual bayar balik
        Dim count As Integer = pinjaman.Tempoh_Pinj + 1
        Dim newDate As DateTime
        For Each row As DataRow In dtTemp.Rows
            newDate = New DateTime(pinjaman.Tahun_Byrn, pinjaman.Bulan_Byrn, 1).AddMonths(1)
            ' Iterate through each row in the DataTable
            pinjaman.Pokok = row("Pokok")
            pinjaman.Faedah = row("Faedah")
            pinjaman.Ansuran = row("Ansuran")
            pinjaman.Baki_Pokok = row("Baki_Pokok")
            pinjaman.Bulan_Byrn = newDate.Month.ToString("00")
            pinjaman.Tahun_Byrn = newDate.Year
            pinjaman.Bln_GJ = pinjaman.Tahun_Byrn & pinjaman.Bulan_Byrn

            multikey.Clear()
            multikey.Add("No_Pinj", pinjaman.No_Pinj)
            multikey.Add("Bil_Byr", count)
            If query.execute(multikey, pinjaman.insertCommand(count)) < 0 Then
                response.Message = "Jadual bayar balik gagal di simpan"
                response.Code = 500
                query.rollback()
                Return JsonConvert.SerializeObject(response)
            End If

            'store record first payment after tahan
            If count = pinjaman.Tempoh_Pinj + 1 Then
                newRowGajiMasterAfterTahan = dtTempGajiMasterAfterTahan.NewRow()
                newRowGajiMasterAfterTahan("No_Staf") = pinjaman.No_Staf
                newRowGajiMasterAfterTahan("Kod_Trans") = pinjaman.Kod_Trans
                newRowGajiMasterAfterTahan("Amaun") = pinjaman.Ansuran
                newRowGajiMasterAfterTahan("stDate") = newDate
                newRowGajiMasterAfterTahan("No_Pinjaman") = pinjaman.No_Pinj
                newRowGajiMasterAfterTahan("Bil") = count
                dtTempGajiMasterAfterTahan.Rows.Add(newRowGajiMasterAfterTahan)
            End If
            count += 1
        Next

        'update current SMKB_Gaji_Master Status = 'B'
        multikey.Clear()
        multikey.Add("No_Staf", pinjaman.No_Staf)
        multikey.Add("Kod_Sumber", "PNJM")
        multikey.Add("Catatan", pinjaman.No_Pinj)
        If query.execute(multikey, updateGajiMaster(pinjaman.No_Staf, pinjaman.No_Pinj)) < 0 Then
            response.Message = "Gaji Master gagal di kemaskini"
            response.Code = 500
            query.rollback()
            Return JsonConvert.SerializeObject(response)
        End If

        'insert SMKB_Gaji_Master payment before tahan not yet clear exists
        If dtTempGajiMasterBeforeTahan.Rows.Count > 0 Then
            multikey.Clear()
            multikey.Add("No_Staf", pinjaman.No_Staf)
            multikey.Add("Kod_Sumber", "PNJM")
            multikey.Add("Catatan", pinjaman.No_Pinj)
            multikey.Add("No_Trans", lastIdBeforeTahan)
            multikey.Add("Status", "A")
            If query.execute(multikey, insertGajiMaster(pinjaman.No_Staf, pinjaman.Kod_Trans, lastAnsuranBeforeTahan, stDateBeforeTahan, edDateBeforeTahan, pinjaman.No_Pinj, lastIdBeforeTahan)) < 0 Then
                response.Message = "Gaji Master bayaran terakhir gagal di simpan"
                response.Code = 500
                query.rollback()
                Return JsonConvert.SerializeObject(response)
            End If
        End If

        'insert SMKB_Gaji_Master first payment after tahan
        For Each row As DataRow In dtTempGajiMasterAfterTahan.Rows
            multikey.Clear()
            multikey.Add("No_Staf", row("No_Staf"))
            multikey.Add("Kod_Sumber", "PNJM")
            multikey.Add("Catatan", row("No_Pinjaman"))
            multikey.Add("No_Trans", row("Bil"))
            multikey.Add("Status", "A")

            'Dim edDate = row("stDate").AddMonths(dtTemp.Rows.Count)
            Dim edDate = row("stDate").AddMonths(1 + (dtTemp.Rows.Count - countTahan))
            ' Move to the first day of the next month
            Dim firstDayOfNextMonth As DateTime = New DateTime(edDate.Year, edDate.Month, 1).AddMonths(1)
            ' Subtract one day to get the last day of the month
            Dim lastDayOfMonth As DateTime = firstDayOfNextMonth.AddDays(-1)

            If query.execute(multikey, insertGajiMaster(row("No_Staf"), row("Kod_Trans"), row("Amaun"), row("stDate"), lastDayOfMonth, row("No_Pinjaman"), row("Bil"))) < 0 Then
                response.Message = "Gaji Master bayaran terakhir gagal di simpan"
                response.Code = 500
                query.rollback()
                Return JsonConvert.SerializeObject(response)
            End If
        Next

        'insert SMKB_Gaji_Master last payment after tahan
        multikey.Clear()
        multikey.Add("No_Staf", pinjaman.No_Staf)
        multikey.Add("Kod_Sumber", "PNJM")
        multikey.Add("Catatan", pinjaman.No_Pinj)
        multikey.Add("No_Trans", count - 1)
        multikey.Add("Status", "A")
        If query.execute(multikey, insertGajiMaster(pinjaman.No_Staf, pinjaman.Kod_Trans, pinjaman.Ansuran, newDate, New Date(newDate.Year, newDate.Month, Date.DaysInMonth(newDate.Year, newDate.Month)), pinjaman.No_Pinj, count - 1)) < 0 Then
            response.Message = "Gaji Master bayaran terakhir gagal di simpan"
            response.Code = 500
            query.rollback()
            Return JsonConvert.SerializeObject(response)
        End If

        query.finish()

        Return JsonConvert.SerializeObject(response)
    End Function
    Private Function updateGajiMaster(No_Staf As String, No_Pinj As String) As SqlCommand
        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "UPDATE SMKB_Gaji_Master 
            SET Status = @Status 
            WHERE No_Staf = @No_Staf AND Catatan = @No_Pinj AND Status = 'A'"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@No_Staf", No_Staf))
        cmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
        cmd.Parameters.Add(New SqlParameter("@Status", "B"))

        Return cmd
    End Function
    Private Function insertGajiMaster(No_Staf As String, Kod_Trans As String, Amaun As Decimal, Tkh_Mula As DateTime, Tkh_Tamat As DateTime, No_Pinj As String, Bil As Integer) As SqlCommand
        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Gaji_Master (No_Staf,Kod_Sumber,Jenis_Trans,Kod_Trans,Amaun,Tkh_Mula,Tkh_Tamat,Status,Bayar_Drpd,Catatan,No_Trans)
                VALUES (@No_Staf,@Kod_Sumber,@Jenis_Trans,@Kod_Trans,@Amaun,@Tkh_Mula,@Tkh_Tamat,@Status,@Bayar_Drpd,@Catatan,@No_Trans)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@No_Staf", No_Staf))
        cmd.Parameters.Add(New SqlParameter("@Kod_Sumber", "PNJM"))
        cmd.Parameters.Add(New SqlParameter("@Jenis_Trans", "P"))
        cmd.Parameters.Add(New SqlParameter("@Kod_Trans", Kod_Trans))
        cmd.Parameters.Add(New SqlParameter("@Amaun", Amaun))
        cmd.Parameters.Add(New SqlParameter("@Tkh_Mula", Tkh_Mula))
        cmd.Parameters.Add(New SqlParameter("@Tkh_Tamat", Tkh_Tamat))
        cmd.Parameters.Add(New SqlParameter("@Status", "A"))
        cmd.Parameters.Add(New SqlParameter("@Bayar_Drpd", "P"))
        cmd.Parameters.Add(New SqlParameter("@Catatan", No_Pinj))
        cmd.Parameters.Add(New SqlParameter("@No_Trans", Bil))

        Return cmd
    End Function

    Private Function logInvoisDok(No_Rujukan As String, userID As String, Status_Dok As String) As SqlCommand
        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Status_Dok (Kod_Modul,Kod_Status_Dok,No_Rujukan,No_Staf,Tkh_Tindakan,Tkh_Transaksi,Status_Transaksi,Status,Ulasan)
                VALUES (@Kod_Modul,@Kod_Status_Dok,@No_Rujukan,@No_Staf,getdate(),getdate(),@Status_Transaksi,@Status,@Ulasan)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@Kod_Modul", "13"))
        'cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", "03uyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyttttttt"))
        cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Status_Dok))
        cmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        cmd.Parameters.Add(New SqlParameter("@No_Staf", userID))
        cmd.Parameters.Add(New SqlParameter("@Status_Transaksi", "1"))
        cmd.Parameters.Add(New SqlParameter("@Status", "1"))
        cmd.Parameters.Add(New SqlParameter("@Ulasan", "-"))

        Return cmd
    End Function


End Class

<Serializable>
Public Class PinjamanTahanBayarBalik
    Public Property No_Pinj As String
    Public Property Bil_Byr As Integer
    Public Property Pokok As Decimal
    Public Property Faedah As Decimal
    Public Property Ansuran As Decimal
    Public Property Baki_Pokok As Decimal
    Public Property Status_Byrn As String
    Public Property Bln_GJ As String
    Public Property Status_GJ As String
    Public Property Status As String
    Public Property Status_Dok As String
    Public Property No_Staf As String
    Public Property Tempoh_Pinj As String
    Public Property Amaun As Decimal
    Public Property Bulan_Byrn As String
    Public Property Tahun_Byrn As String
    Public Property faedahpercent As Decimal
    Public Property Kod_Trans As String
    Public Function insertCommand(Bil As Integer) As SqlCommand
        If No_Pinj Is Nothing Then
            Throw New Exception("No Pinjaman tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "INSERT INTO SMKB_Pinjaman_Jadual_Bayar_Balik (No_Pinj,Bil_Byr,Pokok,Faedah,Ansuran,Baki_Pokok,Status_Byrn,Bln_GJ,Status_GJ,Status,Bulan_Byrn,Tahun_Byrn)
                VALUES (@No_Pinj,@Bil_Byr,@Pokok,@Faedah,@Ansuran,@Baki_Pokok,@Status_Byrn,@Bln_GJ,@Status_GJ,@Status,@Bulan_Byrn,@Tahun_Byrn)"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
        cmd.Parameters.Add(New SqlParameter("@Bil_Byr", Bil))
        cmd.Parameters.Add(New SqlParameter("@Pokok", Pokok))
        cmd.Parameters.Add(New SqlParameter("@Faedah", Faedah))
        cmd.Parameters.Add(New SqlParameter("@Ansuran", Ansuran))
        cmd.Parameters.Add(New SqlParameter("@Baki_Pokok", Baki_Pokok))
        cmd.Parameters.Add(New SqlParameter("@Status_Byrn", "A"))
        cmd.Parameters.Add(New SqlParameter("@Bln_GJ", Bln_GJ))
        cmd.Parameters.Add(New SqlParameter("@Status_GJ", "N"))
        cmd.Parameters.Add(New SqlParameter("@Status", "1"))
        cmd.Parameters.Add(New SqlParameter("@Bulan_Byrn", Bulan_Byrn))
        cmd.Parameters.Add(New SqlParameter("@Tahun_Byrn", Tahun_Byrn))

        Return cmd
    End Function
    Public Function updateCommand(No_Pinj As String, Bil As Integer) As SqlCommand
        If No_Pinj Is Nothing Then
            Throw New Exception("No Pinjaman tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "UPDATE SMKB_Pinjaman_Jadual_Bayar_Balik 
            SET Status_Byrn = @Status_Byrn, Status = @Status 
            WHERE No_Pinj = @No_Pinj AND Bil_Byr = @Bil_Byr"

        cmd.CommandText = sql
        cmd.Parameters.Add(New SqlParameter("@No_Pinj", No_Pinj))
        cmd.Parameters.Add(New SqlParameter("@Bil_Byr", Bil))
        cmd.Parameters.Add(New SqlParameter("@Status_Byrn", Status_Byrn))
        cmd.Parameters.Add(New SqlParameter("@Status", Status))

        Return cmd
    End Function

End Class
