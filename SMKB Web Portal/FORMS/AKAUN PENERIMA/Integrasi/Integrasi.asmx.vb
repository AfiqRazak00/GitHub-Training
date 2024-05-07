Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Net.Http.Headers
Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Globalization
Imports System.Threading
Imports Microsoft.Ajax.Utilities
Imports AjaxControlToolkit
Imports System.Data.Entity.Core.Mapping
Imports System

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Integrasi
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiLulusInvois(Fakulti As String, isClicked As Boolean, KatPelajar As String, Sesi As String) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiInvois(Fakulti, KatPelajar, Sesi)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiInvois(Fakulti As String, KatPelajar As String, Sesi As String) As DataTable
        Dim db = New DBKewConn
        'Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)

        Dim query As String = "SELECT DISTINCT  B.Kod_Penghutang, B.No_Rujukan AS NO_MATRIK, B.Nama_Penghutang , 
                            B.Alamat_1,B.Alamat_2,B.Poskod,B.Bandar,B.Kod_Negeri, 
                            UPPER(Alamat_1+', '+Alamat_2+', '+Poskod+', '+E.Butiran+', '+D.Butiran+', '+C.Butiran) AS ALAMAT, B.Tel_Bimbit 
							FROM AR_Order_Hdr A
                            JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang=B.Kod_Penghutang
                            JOIN SMKB_Lookup_Detail C ON B.Kod_Negara=C.Kod_Detail AND C.Kod='0001'
                            JOIN SMKB_Lookup_Detail D ON B.Kod_Negeri=D.Kod_Detail AND D.Kod='0002'
                            JOIN SMKB_Lookup_Detail E ON B.Bandar=E.Kod_Detail AND E.Kod='0003'
                            WHERE B.Kod_Pejabat=@fakulti AND A.Sesi=@sesi AND B.Kategori_Penghutang=@KatPelajar
                            ORDER BY B.No_Rujukan"
        param.Add(New SqlParameter("@fakulti", Fakulti))
        param.Add(New SqlParameter("@sesi", Sesi))
        param.Add(New SqlParameter("@KatPelajar", KatPelajar))
        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKategoriPelajar(category As String, kod As String) As String
        Dim tmpDT As DataTable = GetKodKategoriPelajar(category, kod)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodKategoriPelajar(category As String, kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT TOP(10) Kod_Penghutang as value, Kategori_Penghutang + ' - ' + Nama_Penghutang as text FROM SMKB_Penghutang_Master WHERE Status='1'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Penghutang LIKE '%' + @kod + '%' OR Nama_Penghutang LIKE '%' + @kod2 + '%' OR No_Rujukan LIKE '%' + @kod3 + '%')"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
            param.Add(New SqlParameter("@kod3", kod))
        End If

        If category <> "" Then
            query &= " AND Kategori_Penghutang = @category"
            param.Add(New SqlParameter("@category", category))
        End If

        Return db.Read(query, param)
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPenajaList(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodPenaja(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodPenaja(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT No_Rujukan AS value,Nama_Penghutang AS text,Kod_Penghutang FROM SMKB_Penghutang_Master WHERE Kategori_Penghutang='PN' AND Status='1'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND (Kod_Penghutang LIKE '%' + @kod + '%' OR Nama_Penghutang LIKE '%' + @kod2 + '%' OR No_Rujukan LIKE '%' + @kod3 + '%')"
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
            param.Add(New SqlParameter("@kod3", kod))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_MaklumatBilTerperinciPelajar(isClicked As Boolean, custcode As String) As String
        Dim resp As New ResponseRepository

        dt = Get_MaklumatBilTerperinciPelajar(custcode)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_MaklumatBilTerperinciPelajar(custcode As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)
        Dim query As String = ""

        'If status = "03" Then
        query = "SELECT DISTINCT A.Kod_Transaksi,A.No_Order,A.No_Rujukan,C.No_Rujukan AS No_Matrik,CONVERT(varchar, A.Tkh_Transaksi, 103) AS Tkh_Transaksi,Pengirim_Mohon,A.Jumlah_Keseluruhan,A.Sesi,C.Nama_Penghutang
                    FROM AR_Order_Hdr A, AR_Order_Dtl B, SMKB_Penghutang_Master C
                    WHERE A.No_Order=B.No_Order AND A.Kod_Penghutang=C.Kod_Penghutang AND Pengirim IN ('SMP','SMPS','SMPSH') AND A.Kod_Penghutang=@kodpenghutang
                    AND A.No_Rujukan NOT IN (SELECT No_Rujukan FROM AR_Order_Hdr WHERE Kod_Penghutang=@kodpenghutang AND Kod_Transaksi='003')"
        param.Add(New SqlParameter("@kodpenghutang", custcode))

        'Else 'Dah bayar
        '    query = "Select A.No_Dok As No_Invois,
        '                B.Nama_Penghutang,
        '                C.Butiran As UrusNiaga,
        '                A.Tujuan,
        '                FORMAT(A.Tkh_Daftar, 'dd/MM/yyyy') AS TKHMOHON,
        '                A.Jumlah_Bayar as Jumlah
        '            FROM SMKB_Terima_Hdr A
        '            INNER JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang = B.Kod_Penghutang
        '            INNER JOIN SMKB_Kod_Urusniaga C ON A.Kod_Urusniaga = C.Kod_Urusniaga
        '            WHERE A.Status = '1' AND B.Kod_Penghutang = @kodpenghutang;"

        '    param.Add(New SqlParameter("@kodpenghutang", custcode))

        'End If

        Return db.Read(query, param)

        Try
            Return db.Read(query, param)
        Catch ex As SqlException
            ' Handle the exception, and log the error message.
            Console.WriteLine("SQL Exception Message: " & ex.Message)
        End Try

    End Function
    'Load_MaklumatOrder
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_MaklumatOrder(isClicked As Boolean, custcode As String) As String
        Dim resp As New ResponseRepository

        dt = Get_MaklumatOrder(custcode)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_MaklumatOrder(custcode As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)
        Dim query As String = ""

        'If status = "03" Then
        query = "SELECT DISTINCT A.Kod_Transaksi,A.No_Order,A.No_Rujukan,C.No_Rujukan AS No_Staf,CONVERT(varchar, A.Tkh_Transaksi, 103) AS Tkh_Transaksi,Pengirim_Mohon,A.Jumlah_Keseluruhan,A.Sesi,C.Nama_Penghutang,
                (CASE WHEN A.Pengirim = 'PINJ' THEN '1' WHEN A.Pengirim = 'ADV' THEN '2' END) AS JnsUrusniaga 
                FROM AR_Order_Hdr A, AR_Order_Dtl B, SMKB_Penghutang_Master C
                WHERE A.No_Order=B.No_Order AND A.Kod_Penghutang=C.Kod_Penghutang AND Pengirim NOT IN ('SMP','SMPS','SMPSH') AND A.Kod_Penghutang=@kodpenghutang
                AND A.No_Rujukan NOT IN (SELECT No_Rujukan FROM AR_Order_Hdr WHERE Kod_Penghutang=@kodpenghutang AND Kod_Transaksi='003')"
        param.Add(New SqlParameter("@kodpenghutang", custcode))

        'Else 'Dah bayar
        '    query = "Select A.No_Dok As No_Invois,
        '                B.Nama_Penghutang,
        '                C.Butiran As UrusNiaga,
        '                A.Tujuan,
        '                FORMAT(A.Tkh_Daftar, 'dd/MM/yyyy') AS TKHMOHON,
        '                A.Jumlah_Bayar as Jumlah
        '            FROM SMKB_Terima_Hdr A
        '            INNER JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang = B.Kod_Penghutang
        '            INNER JOIN SMKB_Kod_Urusniaga C ON A.Kod_Urusniaga = C.Kod_Urusniaga
        '            WHERE A.Status = '1' AND B.Kod_Penghutang = @kodpenghutang;"

        '    param.Add(New SqlParameter("@kodpenghutang", custcode))

        'End If

        Return db.Read(query, param)

        Try
            Return db.Read(query, param)
        Catch ex As SqlException
            ' Handle the exception, and log the error message.
            Console.WriteLine("SQL Exception Message: " & ex.Message)
        End Try

    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrInvois(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrInvois(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrInvois(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT A.No_Order AS No_Order,A.Kod_Penghutang AS Kod_Penghutang, '0' AS Kontrak,A.Pengirim_Mohon AS Tujuan , '03' AS Kod_Status_Dok, '12' AS Jns_Urusniaga, 'Yuran' AS But_Urusniaga,
                                CASE WHEN Tkh_Transaksi <> '' THEN FORMAT(Tkh_Transaksi, 'dd/MM/yyyy') END AS TkhMula,
                                CASE WHEN Tkh_Transaksi <> '' THEN FORMAT(Tkh_Transaksi, 'dd/MM/yyyy') END AS TkhTamat,Tkh_Transaksi AS Tkh_Mula,Tkh_Transaksi AS Tkh_Tamat,Tkh_Transaksi AS Tkh_Bil,C.No_Rujukan AS No_Matrik,C.Nama_Penghutang
                                FROM AR_Order_Hdr A, SMKB_Penghutang_Master C
                                WHERE A.Kod_Penghutang=C.Kod_Penghutang AND A.No_Order=@id"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@id", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordInvoisTerimaanBayaran(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetTransaksiInvoisForTerimaanBayaran(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetTransaksiInvoisForTerimaanBayaran(kod As String) As DataTable
        Dim db = New DBKewConn

        'Dim jumlahBayar As Decimal = GetJumlaBayarByNoDokFromTerimaHdr(kod)
        Dim query As String = "SELECT B.No_Item,
                                C.Kod_Kump_Wang AS colhidkw,
                                (SELECT Butiran FROM SMKB_Kump_Wang AS kw WHERE C.Kod_Kump_Wang = kw.Kod_Kump_Wang) AS colKW,
                                C.Kod_Operasi AS colhidko,
                                (SELECT Butiran FROM SMKB_Operasi AS ko WHERE C.Kod_Operasi = ko.Kod_Operasi) AS colKO,
                                C.Kod_Projek AS colhidkp,
                                (SELECT Butiran FROM SMKB_Projek AS kp WHERE C.Kod_Projek = kp.Kod_Projek) AS colKp,
                                C.Kod_PTJ AS colhidptj,
                                (SELECT F.Pejabat FROM VPejabat AS F
                                WHERE F.kodpejabat = LEFT(C.Kod_PTJ, 2)) AS ButiranPTJ,
                                C.Kod_Vot,
                                (SELECT Kod_Vot + ' - ' + Butiran FROM SMKB_Vot AS vot WHERE C.Kod_Vot = vot.Kod_Vot) AS ButiranVot,
                                (SELECT Butiran FROM SMKB_Vot AS vot WHERE C.Kod_Vot = vot.Kod_Vot) AS Perkara,
                                '1.00' AS Kuantiti,
                                B.Jumlah AS Kadar_Harga,
                                B.Jumlah AS Jumlah,
                                '0.00' AS Jumlah_Bayar,
                                '0.00' AS Diskaun,
                                '0.00' AS Cukai
                                FROM AR_Order_Hdr A, AR_Order_Dtl B, SMKB_COA_Master C
                                WHERE A.No_Order=B.No_Order AND B.Kod_Vot=C.Kod_Vot AND C.Kod_PTJ='500000'
                                AND A.No_Order=@kod"

        Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@jumlahBayar", jumlahBayar))
        param.Add(New SqlParameter("@kod", kod))

        Return db.Read(query, param)
    End Function

    Public Function GetJumlaBayarByNoDokFromTerimaHdr(noBil As String) As Decimal
        Dim db = New DBKewConn

        ' Create a SQL command for selecting No_Bil
        ' Dim selectQuery As String = "SELECT SUM(Jumlah_Bayar) as Jumlah FROM SMKB_Terima_Hdr WHERE No_Rujukan=@nobil"
        Dim selectQuery As String = "Select Jumlah_Bayar as Jumlah from SMKB_Terima_Hdr where No_Dok=@nodok"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@nodok", noBil))

        ' Execute the query to retrieve No_Bil
        Dim result As DataTable = db.Read(selectQuery, param)

        Dim jumlah As New Decimal

        ' handle error
        If Not IsDBNull(result.Rows(0)("Jumlah")) Then
            jumlah = result.Rows(0)("Jumlah")
        Else
            jumlah = 0.00
        End If

        Return jumlah
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiPelajarPenaja(Penaja As String, isClicked As Boolean, KatPelajar As String, Sesi As String) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiPelajarPenaja(Penaja, KatPelajar, Sesi)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiPelajarPenaja(Penaja As String, KatPelajar As String, Sesi As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)


        Dim query As String = "SELECT A.*,B.Nama_Penghutang FROM AR_Order_Hdr A, SMKB_Penghutang_Master B
                                WHERE A.Kod_Penghutang=B.Kod_Penghutang AND A.Kod_Penaja = @penaja AND 
                                Sesi = @kodsesi AND A.Kategori_Penghutang= @KatPel"
        param.Add(New SqlParameter("@penaja", Penaja))
        param.Add(New SqlParameter("@KatPel", KatPelajar))
        param.Add(New SqlParameter("@kodsesi", Sesi))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_MaklumatBilTerperinci(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, custcode As String) As String
        Dim resp As New ResponseRepository

        dt = Get_MaklumatBilTerperinci(category_filter, tkhMula, tkhTamat, custcode)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_MaklumatBilTerperinci(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, custcode As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)
        Dim query As String = ""

        query = "SELECT A.No_Pendahuluan as No_Akaun, Nama_Penghutang, Tarikh_Mohon, Tujuan, Jum_Lulus FROM ADV_Order_Hdr a
                  inner join ADV_Order_Dtl b ON b.No_Pendahuluan= a.No_Pendahuluan
                  INNER JOIN SMKB_Penghutang_Master C on c.No_Rujukan = a.No_Staf
                  WHERE A.No_Pendahuluan = @kodpenghutang;"

        param.Add(New SqlParameter("@kodpenghutang", custcode))


        Return db.Read(query, param)

        Try
            Return db.Read(query, param)
        Catch ex As SqlException
            ' Handle the exception, and log the error message.
            Console.WriteLine("SQL Exception Message: " & ex.Message)
        End Try

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiLulusPendahuluan(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiPendahuluan(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiPendahuluan(category_filter As String, tkhMula As String, tkhTamat As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)


        If category_filter = "1" Then 'Harini
            tarikhQuery = " WHERE CAST(A.Tarikh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE)"
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " WHERE CAST(A.Tarikh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE)"
        ElseIf category_filter = "3" Then '7 day
            tarikhQuery = " WHERE A.Tarikh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP"
        ElseIf category_filter = "4" Then '30 day
            tarikhQuery = " WHERE A.Tarikh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP"
        ElseIf category_filter = "5" Then '60 day
            tarikhQuery = " WHERE A.Tarikh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP"
        ElseIf category_filter = "6" Then ' custom
            tarikhQuery = " WHERE CAST(A.Tarikh_Mohon AS DATE) >= @tkhMula AND CAST(A.Tarikh_Mohon AS DATE) <= @tkhTamat"
        End If
        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))
        Dim query As String = "SELECT No_Pendahuluan as No_Akaun,Nama_Penghutang,No_Rujukan, " &
        "(B.Alamat_1 + ',' + B.Alamat_2 + ',' + B.Poskod + ',' + B.Bandar + ',' + C.Butiran + ',' + D.Butiran) AS ALAMAT " &
        "From ADV_Order_Hdr A " &
        "INNER JOIN SMKB_Penghutang_Master B On A.No_Staf = B.No_Rujukan " &
        "INNER JOIN SMKB_Lookup_Detail C ON C.Kod='0002' AND B.Kod_Negeri=C.Kod_Detail " &
        "INNER JOIN SMKB_Lookup_Detail D ON D.Kod='0001' AND B.Kod_Negara=D.Kod_Detail " & tarikhQuery


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetFakultiName(value As String) As String
        Dim tmpDT As DataTable = Getfakulti(value)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function Getfakulti(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT CONCAT(KodPejabat, '0000' ) AS value, Pejabat AS text
                                FROM VPEJABAT 
                                WHERE Pejabat LIKE 'FAKULTI%' AND KodPejabat <> '-'
                                AND KodPejabat=LEFT(@kod,2);"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@kod", kod))
        Return db.Read(query, param)
    End Function

    'insert Bil
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function insertBil(order As Terima_Order) As String
        'dok daftar
        Dim response As New Response
        response.Code = 200
        response.Message = "Berjaya disimpan"

        Dim query As New Query()
        Try
            'GENERATE ID
            order.No_Dok = SharedModulePembayaran.generateRunningNumberNoPTJ("12", "AR", "")

            If Not query.execute(order.No_Dok, "No_Dok", order.InsertCommand()) > 0 Then
                Throw New Exception("Failed to insert order bil header")
            End If
            Dim count As Integer = 1
            For Each dtl As Terima_Order_Dtl In order.details
                dtl.No_Dok = order.No_Dok
                dtl.No_Item = count
                dtl.Status = 1

                Dim id As New Dictionary(Of String, String)
                id.Add("No_Dok", dtl.No_Dok)
                id.Add("No_Item", dtl.No_Item)
                If Not query.execute(id, dtl.InsertCommand()) > 0 Then
                    Throw New Exception("Failed to insert order bil details")
                End If
                count = count + 1
            Next

            query.finish()

            'Return Ok("Saved")

        Catch ex As Exception
            query.rollback()

            'ERROR
            'Return InternalServerError(ex)
        End Try
    End Function

    'load data senarai penghutang
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiPenghutang(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SenaraiPenghutang(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SenaraiPenghutang(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST(A.Tkh_Transaksi AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST(A.Tkh_Transaksi AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND A.Tkh_Transaksi >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND A.Tkh_Transaksi < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND A.Tkh_Transaksi >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND A.Tkh_Transaksi < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND A.Tkh_Transaksi >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND A.Tkh_Transaksi < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND A.Tkh_Transaksi >= @tkhMula AND A.Tkh_Mohon <= @TkhTamat "
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "SELECT DISTINCT A.Kod_Penghutang AS NoAkaun,B.Nama_Penghutang,B.No_Rujukan,
        (B.Alamat_1 + ',' + B.Alamat_2 + ',' + B.Poskod + ',' + B.Bandar + ',' + D.Butiran + ',' + E.Butiran) AS ALAMAT, B.Tel_Bimbit,A.Tkh_Transaksi
        FROM AR_Order_Hdr A
        INNER JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang=B.Kod_Penghutang
        INNER JOIN SMKB_Lookup_Detail D ON D.Kod='0002' AND B.Kod_Negeri=D.Kod_Detail
        INNER JOIN SMKB_Lookup_Detail E ON E.Kod='0001' AND B.Kod_Negara=E.Kod_Detail
        WHERE  A.No_Rujukan NOT IN (SELECT No_Rujukan FROM AR_Order_Hdr WHERE Kod_Transaksi='003') AND A.Pengirim NOT IN ('SMP','SMPS','SMPSH')" & tarikhQuery &
        "ORDER BY A.Tkh_Transaksi DESC"

        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrOrder(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrOrder(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrOrder(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT A.No_Order, A.Kod_Penghutang, B.Nama_Penghutang, B.Emel, B.Kategori_Penghutang, D.Butiran as Butiran_Kategori, (CASE WHEN A.Pengirim = 'PINJ' THEN '1' WHEN A.Pengirim = 'ADV' THEN '2' END) AS JnsUrusniaga, '0' AS Kontrak, A.Pengirim_Mohon, 
                                CASE WHEN Tkh_Transaksi <> '' THEN FORMAT(Tkh_Transaksi, 'dd/MM/yyyy') END AS TkhMula,A.No_Rujukan
                                FROM AR_Order_Hdr A
                                LEFT JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang=B.Kod_Penghutang
                                LEFT JOIN SMKB_Lookup_Detail D ON B.Kategori_Penghutang = D.Kod_Detail AND  D.Kod='0152'
                                WHERE No_Order = @No_Order AND 
                                A.Status='1'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Order", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDtlOrder(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDtlOrder(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetDtlOrder(kod As String) As DataTable
        Dim db = New DBKewConn

        Dim jumlahBayar As Decimal = SenaraiKelulusanWS.GetJumlahByNoBilFromTerimaHdr(kod)

        Dim query As String =
            "DECLARE @Jumlah_Bayar DECIMAL(18, 2) -- Declare the variable to store Jumlah_Bayar
            DECLARE @remaining DECIMAL(18, 2) -- Declare the variable for remaining
            SET @Jumlah_Bayar = 0 -- Set the initial value
            SET @remaining = @Jumlah_Bayar; -- Initialize remaining with the initial value

            -- Create a temporary table to store the intermediate results
            CREATE TABLE #TempResults (
                dataid NVARCHAR(MAX),
                colhidkw NVARCHAR(MAX),
                colKW NVARCHAR(MAX),
                colhidko NVARCHAR(MAX),
                colKO NVARCHAR(MAX),
                colhidkp NVARCHAR(MAX),
                colKp NVARCHAR(MAX),
                colhidptj NVARCHAR(MAX),
                ButiranPTJ NVARCHAR(MAX),
                Kod_Vot NVARCHAR(MAX),
                ButiranVot NVARCHAR(MAX),
                Perkara NVARCHAR(MAX),
                Kuantiti DECIMAL(18, 2),
                Kadar_Harga DECIMAL(18, 2),
                Jumlah DECIMAL(18, 2),
                Diskaun DECIMAL(18, 2),
                Cukai DECIMAL(18, 2),
                Jumlah_Bayar DECIMAL(18, 2), -- Add Jumlah_Bayar column
                RowNum INT,
                NoItem INT
            );

            INSERT INTO #TempResults (
                dataid,
                colhidkw,
                colKW,
                colhidko,
                colKO,
                colhidkp,
                colKp,
                colhidptj,
                ButiranPTJ,
                Kod_Vot,
                ButiranVot,
                Perkara,
                Kuantiti,
                Kadar_Harga,
                Jumlah,
                Diskaun,
                Cukai,
                RowNum,
	            NoItem
            )
            SELECT
                a.No_Order + '|' + a.No_Item AS dataid,
                b.Kod_Kump_Wang AS colhidkw,
                (SELECT Butiran FROM SMKB_Kump_Wang AS kw WHERE b.Kod_Kump_Wang = kw.Kod_Kump_Wang) AS colKW,
                b.Kod_Operasi AS colhidko,
                (SELECT Butiran FROM SMKB_Operasi AS ko WHERE b.Kod_Operasi = ko.Kod_Operasi) AS colKO,
                b.Kod_Projek AS colhidkp,
                (SELECT Butiran FROM SMKB_Projek AS kp WHERE b.Kod_Projek = kp.Kod_Projek) AS colKp,
                b.Kod_PTJ AS colhidptj,
                (SELECT c.Pejabat FROM VPejabat AS c
                 WHERE c.kodpejabat = LEFT(b.Kod_PTJ, 2)) AS ButiranPTJ,
                b.Kod_Vot,
                (SELECT Kod_Vot + ' - ' + Butiran FROM SMKB_Vot AS vot WHERE b.Kod_Vot = vot.Kod_Vot) AS ButiranVot,
                '' AS Perkara,
                '1' AS Kuantiti,
                Jumlah AS Kadar_Harga,
                Jumlah,
                '0' AS Diskaun_Amaun,
                '0' AS Cukai_Amaun,
                ROW_NUMBER() OVER (PARTITION BY a.No_Item ORDER BY a.No_Item) AS RowNum, -- Add a row number for iteration,
                a.No_Item -- Include No_Item in the SELECT list
            FROM AR_Order_Dtl AS a
            LEFT JOIN SMKB_Terima_Hdr AS h ON a.No_Order = h.No_Rujukan
			LEFT JOIN SMKB_COA_Master AS b ON a.Kod_Vot=b.Kod_Vot AND b.Kod_PTJ='500000' AND B.Status='1'
            WHERE a.No_Order = @No_Order
                AND a.status = 1
            GROUP BY
                a.No_Order + '|' + a.No_Item, -- Use the expression directly in GROUP BY
                b.Kod_Kump_Wang,
                b.Kod_Operasi,
                b.Kod_Projek,
                b.Kod_PTJ,
                b.Kod_Vot,
                Jumlah,
                Diskaun_Amaun,
                Cukai_Amaun,
                a.No_Item; -- Include No_Item in GROUP BY

            -- Declare a cursor to loop through the rows
            DECLARE @dataid NVARCHAR(MAX);
            DECLARE @payment DECIMAL(18, 2);

            DECLARE paymentCursor CURSOR FOR
            SELECT dataid, Jumlah
            FROM #TempResults
            ORDER BY RowNum;

            -- Open the cursor
            OPEN paymentCursor;

            -- Fetch the first row
            FETCH NEXT FROM paymentCursor INTO @dataid, @payment;

            -- Loop through the rows and update Jumlah_Bayar and @remaining
            WHILE @@FETCH_STATUS = 0
            BEGIN
                IF @remaining >= @payment
                BEGIN
                    UPDATE #TempResults
                    SET Jumlah_Bayar = @payment
                    WHERE dataid = @dataid;

                    SET @remaining = @remaining - @payment;
                END
                ELSE
                BEGIN
                    IF @remaining > 0
                    BEGIN
                        UPDATE #TempResults
                        SET Jumlah_Bayar = @remaining
                        WHERE dataid = @dataid;

                        SET @remaining = 0.00;
                    END
                    ELSE
                    BEGIN
                        UPDATE #TempResults
                        SET Jumlah_Bayar = 0.00
                        WHERE dataid = @dataid;
                    END
                END

                -- Fetch the next row
                FETCH NEXT FROM paymentCursor INTO @dataid, @payment;
            END

            -- Close and deallocate the cursor
            CLOSE paymentCursor;
            DEALLOCATE paymentCursor;

            -- Select the final results
            SELECT
                dataid,
                colhidkw,
                colKW,
                colhidko,
                colKO,
                colhidkp,
                colKp,
                colhidptj,
                ButiranPTJ,
                Kod_Vot,
                ButiranVot,
                Perkara,
                Kuantiti,
                Kadar_Harga,
                Jumlah,
                Jumlah_Bayar,
                Diskaun,
                Cukai
            FROM #TempResults;

            -- Drop the temporary table
            DROP TABLE #TempResults;"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@jumlahBayar", jumlahBayar))
        param.Add(New SqlParameter("@No_Order", kod))

        Return db.Read(query, param)
    End Function
End Class