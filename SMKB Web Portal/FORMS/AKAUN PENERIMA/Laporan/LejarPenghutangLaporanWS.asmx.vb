'Imports System.ComponentModel
'Imports System.Web.Services
'Imports System.Web.Services.Protocols

'' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
'' <System.Web.Script.Services.ScriptService()> _
Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Collections.Generic

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class LejarPenghutangLaporanWS
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_LejarPenghutang() As String
        Dim resp As New ResponseRepository


        dt = GetOrder_SenaraiTransaksiInvois()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiInvois() As DataTable
        Dim db = New DBKewConn


        Dim query As String = "SELECT Kod_Pelanggan,CONVERT(varchar,A.Tkh_Mula,103) AS Tarikh,C.Butiran AS Kump_Wang,D.Butiran AS Operasi,E.Butiran AS Projek, F.Pejabat AS Kod_PTJ,G.Butiran AS Kod_Vot,'0.00' AS Debit,B.jumlah AS Kredit
                                FROM SMKB_Bil_Hdr A
                                INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil
                                INNER JOIN SMKB_Kump_Wang AS C ON B.Kod_Kump_Wang=C.Kod_Kump_Wang
                                INNER JOIN SMKB_Operasi AS D ON B.Kod_Operasi=D.Kod_Operasi
                                INNER JOIN SMKB_Projek AS E ON B.Kod_Projek=E.Kod_Projek
                                INNER JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS F ON F.status = '1' and F.kodpejabat = left(B.Kod_PTJ,2)
                                INNER JOIN SMKB_Vot AS G ON B.Kod_Vot=G.Kod_Vot
                                WHERE Kod_Pelanggan='H00001170323'
                                UNION SELECT Kod_Pelanggan,CONVERT(varchar,B.Tarikh,103) AS Tarikh,C.Butiran AS Kump_Wang,D.Butiran AS Operasi,E.Butiran AS Projek, F.Pejabat AS Kod_PTJ,G.Butiran AS Kod_Vot,B.Amaun_Terima AS Debit,'0.00' AS Kredit
                                FROM SMKB_Terima_Hdr A
                                INNER JOIN SMKB_Terima_Transaksi B ON A.No_Dok=B.No_Dokumen
                                INNER JOIN SMKB_Kump_Wang AS C ON B.Kod_Kump_Wang=C.Kod_Kump_Wang
                                INNER JOIN SMKB_Operasi AS D ON B.Kod_Operasi=D.Kod_Operasi
                                INNER JOIN SMKB_Projek AS E ON B.Kod_Projek=E.Kod_Projek
                                INNER JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT AS F ON F.status = '1' and F.kodpejabat = left(B.Kod_PTJ,2)
                                INNER JOIN SMKB_Vot AS G ON B.Kod_Vot=G.Kod_Vot
                                WHERE A.Kod_Pelanggan='H00001170323' 
                                ORDER BY Tarikh"
        Return db.Read(query)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_Semasa() As String
        Dim resp As New ResponseRepository


        dt = GetOrder_SenaraiSemasa()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiSemasa() As DataTable
        Dim db = New DBKewConn


        Dim query As String = "SELECT '0.00' AS BAKI_MULA,SUM(Dr_5) AS DEBIT,SUM(CR_5)  AS CREDIT, REPLACE((SUM(Dr_5)-SUM(CR_5)),'-','') AS BAKI
                                FROM SMKB_Lejar_Penghutang
                                WHERE Kod_Penghutang='H00001170323'"
        Return db.Read(query)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordPenghutang() As String
        Dim resp As New ResponseRepository


        dt = GetPenghutang_dtl()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetPenghutang_dtl() As DataTable
        Dim db = New DBKewConn


        Dim query As String = "select Nama_Penghutang,Alamat_1+','+Alamat_2+','+A.Poskod+','+ (SELECT Butiran FROM SMKB_Negeri WHERE Kod_Negeri=A.Kod_Negeri)+','+
                                (SELECT Butiran FROM SMKB_Negara WHERE Kod_Negara=A.Kod_Negara) AS ALAMAT, Emel+'/'+Tel_Bimbit AS HUBUNGI,ID_Penghutang
                                FROM SMKB_Penghutang_Master A
                                WHERE Kod_Penghutang='H00001170323'"
        Return db.Read(query)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadHdrPenghutang(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetHdrPenghutang(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetHdrPenghutang(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT A.No_Bil,A.Kod_Pelanggan,B.Nama_Penghutang,A.Jenis_Urusniaga,C.Butiran, A.Kontrak,A.Tujuan,
                                CASE WHEN Tkh_Mula <> '' THEN FORMAT(Tkh_Mula, 'yyyy-MM-dd') END AS Tkh_Mula,
                                CASE WHEN Tkh_Tamat <> '' THEN FORMAT(Tkh_Tamat, 'yyyy-MM-dd') END AS Tkh_Tamat,Jumlah
                                FROM SMKB_Bil_Hdr A
                                INNER JOIN SMKB_Penghutang_Master B ON A.Kod_Pelanggan=B.Kod_Penghutang
                                INNER JOIN SMKB_Kod_Urusniaga C ON A.Jenis_Urusniaga=C.Kod_Urusniaga
                                WHERE No_Bil = @No_Invois AND A.Status='1'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Invois", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordLejarPenghutang(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetTransaksiLejarPenghutang(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetTransaksiLejarPenghutang(kod As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select Kod_Kump_Wang as colhidkw ,(select Butiran from SMKB_Kump_Wang as kw where a.Kod_Kump_Wang = kw.Kod_Kump_Wang) as colKW,
        Kod_Operasi  as colhidko, (select Butiran from SMKB_Operasi as ko where a.Kod_Operasi = ko.Kod_Operasi) as colKO,
        Kod_Projek as colhidkp,  (select Butiran from SMKB_Projek as kp where a.Kod_Projek = kp.Kod_Projek) as colKp,
        Kod_PTJ as colhidptj , (SELECT b.Pejabat FROM VPejabat as b
        WHERE b.kodpejabat = left(Kod_PTJ,2)) as ButiranPTJ ,
        Kod_Vot , (select Butiran from SMKB_Vot as vot where a.Kod_Vot = vot.Kod_Vot) as ButiranVot,
        Perkara ,Kuantiti, Kadar_Harga, Jumlah, Diskaun, Cukai
        from SMKB_Bil_Dtl as a
        where No_Bil = @No_Invois
        and status = 1
        order by No_Item"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Invois", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCarianVotList(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetCarianKodVotList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetCarianKodVotList(kodCariVot As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT CONCAT(a.Kod_Vot, ' - ', vot.Butiran, ', ', a.Kod_Operasi, ' - ', ko.Butiran, ', ', a.Kod_Projek, ', ', a.Kod_Kump_Wang, ' - ', REPLACE(kw.Butiran, 'KUMPULAN WANG', 'KW'), ', ', a.Kod_PTJ) AS text,
                            a.Kod_Kump_Wang + a.Kod_Operasi + a.Kod_PTJ + a.Kod_Projek + a.Kod_Vot AS value 
                            FROM SMKB_COA_Master AS a
                            JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                            JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                            JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
                            WHERE a.status = 1 "

        Dim param As New List(Of SqlParameter)
        If kodCariVot <> "" Then
            query &= "AND (a.Kod_Vot LIKE '%' + @kod + '%' OR a.Kod_Operasi LIKE '%' + @kod2 + '%' OR a.Kod_Projek LIKE '%' + @kod3 + '%' OR a.Kod_Kump_Wang LIKE '%' + @kod4 + '%' OR a.Kod_PTJ LIKE '%' + @kod5 + '%' OR vot.Butiran LIKE '%' + @kodButir + '%' OR ko.Butiran LIKE '%' + @kodButir1 + '%'  OR kw.Butiran LIKE '%' + @kodButir2 + '%')"

            param.Add(New SqlParameter("@kod", kodCariVot))
            param.Add(New SqlParameter("@kod2", kodCariVot))
            param.Add(New SqlParameter("@kod3", kodCariVot))
            param.Add(New SqlParameter("@kod4", kodCariVot))
            param.Add(New SqlParameter("@kod5", kodCariVot))
            param.Add(New SqlParameter("@kodButir", kodCariVot))
            param.Add(New SqlParameter("@kodButir1", kodCariVot))
            param.Add(New SqlParameter("@kodButir2", kodCariVot))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveOrders(id As String) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If id Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If id = "" Then
            If Save_Lulus(id) <> "OK" Then
                resp.Failed("Gagal Menyimpan order")
                Exit Function
            Else
                If update_lejar(id) <> "OK" Then
                    resp.Success("Rekod berjaya disimpan", "00", id)
                    Exit Function
                Else

                End If

            End If
        End If

        If success = 0 Then
            resp.Failed("Rekod order detail gagal disimpan")
        End If

        'If Not success = JumRekod Then
        '    resp.Success("Rekod order detail berjaya disimpan dengan beberapa rekod tidak disimpan", "00", id)
        'Else
        '    resp.Success("Rekod berjaya disimpan", "00", id)
        'End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function Save_Lulus(id As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Bil_Hdr
                                SET Flag_Lulus='1', Kod_Status_Dok='01'
                                WHERE No_Bil=@id"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id", id))

        Return db.Process(query, param)
    End Function

    Private Function update_lejar(id As String)
        Dim db As New DBKewConn
        Dim query1 As String = "SELECT A.Kod_Pelanggan,B.Kod_Vot,B.Kod_PTJ,B.Kod_Projek,B.Kod_Operasi,B.Kod_Kump_Wang, SUM(B.Jumlah), MONTH(A.Tkh_Mula) AS BULAN, YEAR(A.Tkh_Mula) AS TAHUN
                                FROM SMKB_Bil_Hdr A
                                INNER JOIN SMKB_Bil_Dtl B ON A.No_Bil=B.No_Bil
                                WHERE A.No_Bil=@id
                                GROUP BY A.Kod_Pelanggan,B.Kod_Vot,B.Kod_PTJ,B.Kod_Projek,B.Kod_Operasi,B.Kod_Kump_Wang, B.Jumlah, A.Tkh_Mula "
        Dim param1 As New List(Of SqlParameter)
        param1.Add(New SqlParameter("@id", id))
        Return db.Process(query1, param1)

        Dim query As String = "UPDATE SMKB_Bil_Hdr
                                SET Flag_Lulus='1', Kod_Status_Dok='01'
                                WHERE No_Bil=@id"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@id", id))
        Return db.Process(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPenghutangList(ByVal q As String) As String

        Dim tmpDT As DataTable = GetKodPenghutangList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodPenghutangList(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Kod_Penghutang as value, Nama_Penghutang as text FROM SMKB_Penghutang_Master WHERE Status='1'"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Penghutang LIKE '%' + @kod + '%' OR Nama_Penghutang LIKE '%' + @kod2 + '%' "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_TransaksiLejarPenghutang(tahun As String, syarikat As String, ptj As String) As String
        Dim resp As New ResponseRepository
        If tahun = "" Or syarikat = "" Or ptj = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If
        Session("tahun") = tahun
        Session("syarikat") = syarikat
        Session("ptj") = ptj
        dt = GetOrder_TransaksiLejarPenghutang(tahun, syarikat, ptj)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_TransaksiLejarPenghutang(tahun As String, syarikat As String, ptj As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb;pwd=Smkb@Dev2012;"

        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String

            If ptj = "00" Then

                query = "Select *,B.Nama_Penghutang from Smkb_Lejar_Penghutang A
                        INNER JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang=B.Kod_Penghutang
                        where Tahun = @tahun
                         Order by Kod_Vot,Kod_Kump_Wang"
            Else

                query = "Select *,B.Nama_Penghutang from Smkb_Lejar_Penghutang A
                        INNER JOIN SMKB_Penghutang_Master B ON A.Kod_Penghutang=B.Kod_Penghutang
                        where Tahun = @tahun
                        And Kod_PTJ >= @ptj and Kod_PTJ <= @ptj
                        Order by Kod_Vot,Kod_Kump_Wang"
            End If

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))
            cmd.Parameters.Add(New SqlParameter("@ptj", ptj))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_Penghutang(tahun As String)
        If tahun = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If
        dt = GetOrder_Penghutang(tahun)
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Penghutang(tahun As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb;pwd=Smkb@Dev2012;"

        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String

            query = "SELECT A.No_Bil,FORMAT(Tkh_Mohon, 'dd/MM/yyyy') AS Tkh_Mohon,C.Nama_Penghutang,C.Alamat_1 + ' , ' + C.Alamat_2 AS ALAMAT,'0' AS BAKIAWAL,
                    A.JUMLAH,'0.00' AS NOTADEBIT,'0.00' AS NOTAKREDIT,  ISNULL(B.Jumlah_Bayar, 0.0) AS Jumlah_Bayar,
                    '' AS CEKRETURN,
                    ISNULL(A.JUMLAH - ISNULL(B.Jumlah_Bayar, 0.0), 0.0) AS BAKITUTUP,
                    CASE
                        WHEN B.No_Dok IS NULL THEN ' '
                        ELSE B.No_Dok
                    END AS No_Dok,
                    A.Peringatan_1,A.Peringatan_2,A.Peringatan_3
                    FROM SMKB_Bil_Hdr A
                    LEFT JOIN SMKB_Terima_Hdr B ON A.No_Bil = B.No_Rujukan
                    INNER JOIN SMKB_Penghutang_Master C ON A.Kod_Penghutang = C.Kod_Penghutang
                    WHERE YEAR(Tkh_Mohon) = @tahun
                    ORDER BY Tkh_Mohon DESC;"

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_Pengumuran(vot As String)
        If vot = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If
        dt = GetOrder_Pengumuran(vot)
        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Pengumuran(vot As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        'Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb;pwd=Smkb@Dev2012;"

        'Using sqlconn As New SqlConnection(connectionString)
        'cmd As New SqlCommand
        'sqlconn.Open()
        Dim param As New List(Of SqlParameter)
        Dim query As String

        query = "SELECT
                        ROW_NUMBER() OVER (ORDER BY C.Butiran) AS Bil,
                        C.Butiran,
                        B.Kod_Vot,
                        B.Kod_Kump_Wang,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) <= 30 THEN 1 ELSE 0 END) AS BIL_30,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) <= 30 THEN A.Jumlah ELSE 0 END) AS Jumlah_30,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 31 AND 90 THEN 1 ELSE 0 END) AS BIL_90,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 31 AND 90 THEN A.Jumlah ELSE 0 END) AS Jumlah_90,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 91 AND 210 THEN 1 ELSE 0 END) AS BIL_210,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 91 AND 210 THEN A.Jumlah ELSE 0 END) AS Jumlah_210,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 211 AND 365 THEN 1 ELSE 0 END) AS BIL_365,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 211 AND 365 THEN A.Jumlah ELSE 0 END) AS Jumlah_365,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 366 AND 1080 THEN 1 ELSE 0 END) AS BIL_1080,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 366 AND 1080 THEN A.Jumlah ELSE 0 END) AS Jumlah_1080,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 1081 AND 2160 THEN 1 ELSE 0 END) AS BIL_2160,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) BETWEEN 1081 AND 2160 THEN A.Jumlah ELSE 0 END) AS Jumlah_2160,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) > 2160 THEN 1 ELSE 0 END) AS BIL_2161,
                        SUM(CASE WHEN DATEDIFF(day, A.Tkh_Bil, GETDATE()) > 2160 THEN A.Jumlah ELSE 0 END) AS Jumlah_2161,                          
                        COUNT(A.Tkh_Bil)  AS bil_keseluruhan,
                        SUM(A.Jumlah)  AS jumlah_keseluruhan
                    FROM SMKB_Bil_Hdr A
                    INNER JOIN SMKB_Lejar_Penghutang B ON A.Kod_Penghutang = B.Kod_Penghutang
                    INNER JOIN SMKB_Vot C ON B.Kod_Vot = C.Kod_Vot
                    WHERE B.Kod_Vot = @vot
                    GROUP BY C.Butiran, B.Kod_Vot, B.Kod_Kump_Wang"

        'cmd.Connection = sqlconn
        'cmd.CommandText = query

        'cmd.Parameters.Add(New SqlParameter("@vot", vot))
        param.Add(New SqlParameter("@vot", vot))
        'dt.Load(cmd.ExecuteReader())
        'Return dt
        Return db.Read(query, param)
        'End Using
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodVotList(q As String) As String
        Dim resp As New ResponseRepository
        dt = GetKodVot(q)

        ' Handle null or undefined values in the DataTable
        For Each row As DataRow In dt.Rows
            For Each col As DataColumn In dt.Columns
                If IsDBNull(row(col)) Then
                    row(col) = String.Empty ' Or any default value you prefer
                End If
            Next
        Next

        Return JsonConvert.SerializeObject(dt, Formatting.Indented)
    End Function

    Private Function GetKodVot(vot As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT DISTINCT A.Kod_Vot AS vot FROM SMKB_Lejar_Penghutang A INNER JOIN SMKB_Vot B ON A.Kod_Vot=B.Kod_Vot"
        Dim param As New List(Of SqlParameter)

        If (vot <> "") Then
            query = query & " WHERE A.Kod_Vot LIKE '%' + @kodv + '%'"

            param.Add(New SqlParameter("@kodv", vot))
        End If

        query &= " ORDER BY A.Kod_Vot"

        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecord_SenaraiPenghutang(tahun As String) As String
        Dim resp As New ResponseRepository

        If tahun = "" Then

            Return JsonConvert.SerializeObject(New DataTable)
        End If
        'Session("tkhMula") = tkhMula
        'Session("tkhHingga") = tkhHingga
        'Session("syarikat") = syarikat
        'Session("ptj") = ptj
        'Session("kodkw") = kodkw


        dt = GetOrder_SenaraiPenghutang(tahun)
        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiPenghutang(tahun As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable
        Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb_Pt;pwd=@Abcd@1234;"


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()


            Dim optionalWhere As String = ""
            Dim query As String = "SELECT B.No_Bil, A.Jenis, A.Kod_PTJ_Mohon,A.No_Staf_Penyedia,A.Utk_Perhatian,A.No_Rujukan, A.Jumlah,A.Kategori,C.Nama_Penghutang, C.Tel_Bimbit,
        B.Kod_Kump_Wang,Alamat_1+ ', ' + Alamat_2 + ', ' + Poskod + ', ' + D.Butiran + ' , ' + E.Butiran + ', ' + F.Butiran as ALAMAT FROM SMKB_Bil_Hdr A
        INNER JOIN SMKB_Bil_Dtl  B ON A.No_Bil = B.No_Bil
        INNER JOIN SMKB_Penghutang_Master C ON A.Kod_Penghutang = C.Kod_Penghutang
        INNER JOIN SMKB_Lookup_Detail D ON D.Kod='0003' AND C.Bandar=D.Kod_Detail
        INNER JOIN SMKB_Lookup_Detail E ON E.Kod='0002' AND C.Kod_Negeri=E.Kod_Detail
        INNER JOIN SMKB_Lookup_Detail F ON F.Kod='0001' AND C.Kod_Negara=F.Kod_Detail
        WHERE A.Tahun = @tahun"

            cmd.Connection = sqlconn
            cmd.CommandText = query



            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))




            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetZonKewanganPusat(tkhMula As String, tkhTamat As String, zon As String) As String
     Dim resp As New ResponseRepository

     If tkhMula = "" Or tkhTamat = "" Or zon = "" Then

         Return JsonConvert.SerializeObject(New DataTable)
     End If

     dt = GetKewanganPusat(tkhMula, tkhTamat, zon)
     Dim totalRecords As Integer = dt.Rows.Count

     Return JsonConvert.SerializeObject(dt)
 End Function

 <WebMethod()>
 <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
 Private Function GetKewanganPusat(tkhMula As String, tkhTamat As String, zon As String) As DataTable
     Dim db = New DBKewConn
     Dim dt As New DataTable
     Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb_Pt;pwd=@Abcd@1234;"


     Using sqlconn As New SqlConnection(connectionString)
         Dim cmd As New SqlCommand
         sqlconn.Open()


         Dim optionalWhere As String = ""
         Dim query As String = "SELECT A.No_Dok, A.Tkh_Daftar, D.Nama_Penghutang, C.Kod_Kump_Wang, C.Kod_PTJ, C.Kod_Vot, C.Debit, C.Kredit, E.Butiran as EButiran,B.Butiran AS Bbutiran, A.Staf_Terima
                                 FROM SMKB_Terima_Hdr A
                                 INNER JOIN SMKB_Kod_Urusniaga B ON A.Kod_Urusniaga = B.Kod_Urusniaga
                                 LEFT JOIN smkb_terima_dtl C ON A.No_Dok = C.No_Dok
                                 LEFT JOIN SMKB_Penghutang_Master D ON A.Kod_Penghutang = D.Kod_Penghutang
                                 LEFT JOIN SMKB_LOOKUP_DETAIL E ON A.Mod_Terima = E.Kod_Detail
                                 WHERE (A.Zon = @zon)
                                 AND (A.Tkh_Daftar >= CONVERT(DATETIME, @tkhMula, 102))
                                 AND (A.Tkh_Daftar <= CONVERT(DATETIME, @tkhTamat, 102))"


         cmd.Connection = sqlconn
         cmd.CommandText = query



         cmd.Parameters.Add(New SqlParameter("@tkhMula", tkhMula))
         cmd.Parameters.Add(New SqlParameter("@tkhTamat", tkhTamat))
         cmd.Parameters.Add(New SqlParameter("@zon", zon))



         dt.Load(cmd.ExecuteReader())
         Return dt
     End Using
 End Function


 <WebMethod()>
 <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
 Public Function GetAllSenaraiAudit(tkhMula As String, tkhTamat As String) As String
     Dim resp As New ResponseRepository

     If tkhMula = "" Or tkhTamat = "" Then

         Return JsonConvert.SerializeObject(New DataTable)
     End If
     dt = GetSenaraiAudit(tkhMula, tkhTamat)
     Dim totalRecords As Integer = dt.Rows.Count

     Return JsonConvert.SerializeObject(dt)
 End Function


 <WebMethod()>
 <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
 Private Function GetSenaraiAudit(tkhMula As String, tkhTamat As String) As DataTable
     Dim db = New DBKewConn
     Dim dt As New DataTable
     Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb_Pt;pwd=@Abcd@1234;"


     Using sqlconn As New SqlConnection(connectionString)
         Dim cmd As New SqlCommand
         sqlconn.Open()


         Dim optionalWhere As String = ""
         Dim query As String = " SELECT A.No_Dok, A.Tkh_Daftar, C.Nama_Penghutang, B.Kod_Kump_Wang, B.Kod_PTJ, B.Kod_Vot, B.Debit, B.Kredit, D.Butiran, C.No_Rujukan,A.Status, A.Staf_Terima
                       FROM smkb_terima_hdr A
                       LEFT JOIN smkb_terima_dtl B ON A.No_Dok = B.No_Dok
                       LEFT JOIN SMKB_Penghutang_Master C ON A.Kod_Penghutang = C.Kod_Penghutang
                       LEFT JOIN SMKB_LOOKUP_DETAIL D ON A.Mod_Terima = D.Kod_Detail
                    WHERE (D.Kod='AR01' AND D.Status='1') AND (A.Tkh_Daftar >= CONVERT(DATETIME, @tkhMula, 102)) AND (A.Tkh_Daftar <= CONVERT(DATETIME, @tkhTamat, 102))"

         cmd.Connection = sqlconn
         cmd.CommandText = query
         cmd.Parameters.Add(New SqlParameter("@tkhMula", tkhMula))
         cmd.Parameters.Add(New SqlParameter("@tkhTamat", tkhTamat))
         dt.Load(cmd.ExecuteReader())
         Return dt
     End Using
 End Function

 <WebMethod()>
 <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
 Public Function GetNoVotList(q As String) As String
     Dim resp As New ResponseRepository
     dt = GetNoVot(q)

     ' Handle null or undefined values in the DataTable
     For Each row As DataRow In dt.Rows
         For Each col As DataColumn In dt.Columns
             If IsDBNull(row(col)) Then
                 row(col) = String.Empty ' Or any default value you prefer
             End If
         Next
     Next

     Return JsonConvert.SerializeObject(dt, Formatting.Indented)
 End Function

 Private Function GetNoVot(kodv As String) As DataTable
     Dim db = New DBKewConn

     Dim query As String = "SELECT Kod_Vot as kodv, Butiran as nama FROM SMKB_Vot"
     Dim param As New List(Of SqlParameter)

     If (kodv <> "") Then
         query = query & " WHERE Kod_Klasifikasi = 'D' AND Status = '1' AND (LOWER(Butiran) LIKE '%' + @kodv + '%' OR Kod_Vot LIKE '%' + @kodv + '%')"

         param.Add(New SqlParameter("@kodv", kodv))
     End If

     query &= " ORDER BY Kod_Vot"

     Return db.Read(query, param)
 End Function


 <WebMethod()>
 <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
 Public Function GetAllTerimaanVot(tkhMula As String, tkhTamat As String, vot As String) As String
     Dim resp As New ResponseRepository

     If tkhMula = "" Or tkhTamat = "" Or vot = "" Then

         Return JsonConvert.SerializeObject(New DataTable)
     End If


     dt = GetSenaraiVot(tkhMula, tkhTamat, vot)
     Dim totalRecords As Integer = dt.Rows.Count

     Return JsonConvert.SerializeObject(dt)
 End Function


 <WebMethod()>
 <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
 Private Function GetSenaraiVot(tkhMula As String, tkhTamat As String, vot As String) As DataTable
     Dim db = New DBKewConn
     Dim dt As New DataTable
     Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb_Pt;pwd=@Abcd@1234;"


     Using sqlconn As New SqlConnection(connectionString)
         Dim cmd As New SqlCommand
         sqlconn.Open()

         Dim query As String = "SELECT A.No_Dok, A.Tkh_Daftar, C.Nama_Penghutang, B.Kod_Kump_Wang, B.Kod_PTJ, B.Debit, B.Kredit, B.Jumlah_Cukai
                       FROM smkb_terima_hdr A
                       LEFT JOIN smkb_terima_dtl B ON A.No_Dok = B.No_Dok
                       LEFT JOIN SMKB_Penghutang_Master C ON A.Kod_Penghutang = C.Kod_Penghutang
                       WHERE (B.Kod_Vot = @vot) AND (A.Tkh_Daftar >= CONVERT(DATETIME, @tkhMula, 102)) AND (A.Tkh_Daftar <= CONVERT(DATETIME, @tkhTamat, 102))"

         cmd.Connection = sqlconn
         cmd.CommandText = query
         cmd.Parameters.Add(New SqlParameter("@tkhMula", tkhMula))
         cmd.Parameters.Add(New SqlParameter("@tkhTamat", tkhTamat))
         cmd.Parameters.Add(New SqlParameter("@vot", vot)) ' Use the same parameter name as in your query

         dt.Load(cmd.ExecuteReader())
         Return dt
     End Using

 End Function




 <WebMethod()>
 <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
 Public Function GetNoZonList(ByVal q As String) As String
     Dim resp As New ResponseRepository
     dt = GetNoZon(q)

     ' Handle null or undefined values in the DataTable
     For Each row As DataRow In dt.Rows
         For Each col As DataColumn In dt.Columns
             If IsDBNull(row(col)) Then
                 row(col) = String.Empty ' Or any default value you prefer
             End If
         Next
     Next

     Return JsonConvert.SerializeObject(dt, Formatting.Indented)
 End Function

    Private Function GetNoZon(kodz As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT Kod_Zon as kodz, Butiran as nama_zon FROM SMKB_Zon"
        Dim param As New List(Of SqlParameter)

        If (kodz <> "") Then
            query = query & " WHERE Status = '1' AND (LOWER(Kod_Zon) LIKE '%' + @kodz + '%' OR Butiran LIKE '%' + @kodz + '%')"

            param.Add(New SqlParameter("@kodz", kodz))
        End If

        query &= " ORDER BY Kod_Zon"

        Return db.Read(query, param)
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadVotPhtgDetails(KodVot As String, KodPtj As String, Tahun As String, KodKW As String, KodOperasi As String, KodProjek As String, KodPhtg As String) As String
        Dim resp As New ResponseRepository

        If KodVot = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        Dim connectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=Smkb;pwd=Smkb@Dev2012;"

        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()
            dt = New DataTable

            Dim query As String
            query = "
            SELECT CONVERT(INT, Kod_Detail) AS bulan, Butiran AS namaBulan, Debit, Kredit
            FROM SMKB_Lookup_Detail A
            OUTER APPLY (
	            select CASE 
		            WHEN Butiran = 'January' THEN Dr_1 
		            WHEN Butiran = 'February' THEN Dr_2 
		            WHEN Butiran = 'March' THEN Dr_3
		            WHEN Butiran = 'April' THEN Dr_4 
		            WHEN Butiran = 'May' THEN Dr_5
		            WHEN Butiran = 'June' THEN Dr_6 
		            WHEN Butiran = 'July' THEN Dr_7
		            WHEN Butiran = 'August' THEN Dr_8 
		            WHEN Butiran = 'September' THEN Dr_9 
		            WHEN Butiran = 'October' THEN Dr_10
		            WHEN Butiran = 'November' THEN Dr_11
		            WHEN Butiran = 'December' THEN Dr_12
		            ELSE 0.00 
	            END as Debit,
	            CASE 
		            WHEN Butiran = 'January' THEN Cr_1 
		            WHEN Butiran = 'February' THEN Cr_2 
		            WHEN Butiran = 'March' THEN Cr_3
		            WHEN Butiran = 'April' THEN Cr_4 
		            WHEN Butiran = 'May' THEN Cr_5
		            WHEN Butiran = 'June' THEN Cr_6 
		            WHEN Butiran = 'July' THEN Cr_7
		            WHEN Butiran = 'August' THEN Cr_8 
		            WHEN Butiran = 'September' THEN Cr_9 
		            WHEN Butiran = 'October' THEN Cr_10
		            WHEN Butiran = 'November' THEN Cr_11
		            WHEN Butiran = 'December' THEN Cr_12
		            ELSE 0.00 
	            END as Kredit
	            from SMKB_Lejar_Penghutang
	            where Kod_Vot = @KodVot
	            and Tahun = @Tahun
	            and Kod_Kump_Wang = @KodKW
	            and Kod_Operasi = @KodOperasi
	            and Kod_PTJ = @KodPtj
                and Kod_Vot = @KodVot 
	            and Kod_Projek = @KodProjek
                and Kod_Penghutang = @KodPenghutang
            ) B
            WHERE kod = '0147'
            ORDER BY bulan"
            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@KodVot", KodVot))
            cmd.Parameters.Add(New SqlParameter("@KodPtj", KodPtj))
            cmd.Parameters.Add(New SqlParameter("@Tahun", Tahun))
            cmd.Parameters.Add(New SqlParameter("@KodKW", KodKW))
            cmd.Parameters.Add(New SqlParameter("@KodOperasi", KodOperasi))
            cmd.Parameters.Add(New SqlParameter("@KodProjek", KodProjek))
            cmd.Parameters.Add(New SqlParameter("@KodPenghutang", KodPhtg))

            dt.Load(cmd.ExecuteReader())
        End Using

        Return JsonConvert.SerializeObject(dt)
    End Function
End Class