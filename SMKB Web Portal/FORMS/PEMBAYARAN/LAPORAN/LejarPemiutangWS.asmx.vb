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
Imports System.IO
Imports System.Runtime.InteropServices

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class LejarPemiutangWS
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_TransaksiLejarPemiutang(tahun As String, syarikat As String, ptj As String) As String
        Dim resp As New ResponseRepository
        If tahun = "" Or syarikat = "" Or ptj = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If
        Session("tahun") = tahun
        Session("syarikat") = syarikat
        Session("ptj") = ptj
        dt = GetOrder_TransaksiLejarPemiutang(tahun, syarikat, ptj)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_TransaksiLejarPemiutang(tahun As String, syarikat As String, ptj As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String

            If ptj = "00" Then

                query = "Select *,B.Nama_Pemiutang from SMKB_Lejar_Pemiutang A
                        INNER JOIN SMKB_Pemiutang_Master B ON A.Kod_Pemiutang=B.Kod_Pemiutang
                        where Tahun = @tahun
                        Order by Kod_Vot,Kod_Kump_Wang"
            Else

                query = "Select *,B.Nama_Pemiutang from SMKB_Lejar_Pemiutang A
                        INNER JOIN SMKB_Pemiutang_Master B ON A.Kod_Pemiutang=B.Kod_Pemiutang
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
    'SENARAI_PERBELANJAAN Start


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PembayaranInvoisIndividu(tahun As String, kod_kw1 As String) As String
        Dim resp As New ResponseRepository

        If tahun = "" Then
            tahun = Session("tahun")
        Else
            Session("tahun") = tahun
        End If

        If kod_kw1 = "" Then
            kod_kw1 = Session("kod_kw1")
        Else
            Session("kod_kw1") = kod_kw1
        End If

        If tahun = "" Or kod_kw1 = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_PembayaranInvoisIndividu(tahun, kod_kw1)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function



    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_PembayaranInvoisIndividu(tahun As String, kod_kw1 As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            If kod_kw1 = "00" Then
                optionalwhere = "and kod_kump_wang >=1 and kod_kump_wang <=11"
            Else
                optionalwhere = "and kod_kump_wang = @kod_kw1"


            End If


            query = "SELECT
                       'AP' + SUBSTRING(A.No_Rujukan, CHARINDEX('AP', A.No_Rujukan) + 2, LEN(A.No_Rujukan)) AS APValue,
                       A.No_Rujukan AS Bil,
                       Nama_Pemiutang,
                       Kod_Kump_Wang,
                       Kod_PTJ,
                       B.Kod_Vot,
                       Amaun_Sebenar,
                       Jumlah_Bayar,
                       Tujuan,
                       Butiran,
                       Amaun_Akan_Bayar,
                       Jumlah_Sebenar,
                       Kadar_Harga,
                       A.No_Rujukan, A.ID_Rujukan
                    FROM SMKB_Pembayaran_Invois_Hdr A
                    INNER JOIN SMKB_Pembayaran_Invois_Dtl B ON A.ID_Rujukan = B.ID_Rujukan
                    INNER JOIN SMKB_Pemiutang_Master C ON B.Kod_Pemiutang = C.Kod_Pemiutang
                    WHERE
                        YEAR(A.Tarikh_Invois) = @tahun
                        " + optionalwhere + "
                        AND A.Jenis_Invois IN ('J10')
                        AND C.Kategori_Pemiutang <> 'SY'
                        AND A.Kod_Vot IN ('81101')
                    ORDER BY A.No_Rujukan;
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query


            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))
            cmd.Parameters.Add(New SqlParameter("@kod_kw1", kod_kw1))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'SENARAI_PERBELANJAAN END

    'SENARAI_PERBELANJAAN_BIL START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PembayaranInvoisBil(tahun As String, kod_kw2 As String) As String
        Dim resp As New ResponseRepository

        If tahun = "" Then
            tahun = Session("tahun")
        Else
            Session("tahun") = tahun
        End If

        If kod_kw2 = "" Then
            kod_kw2 = Session("kod_kw2")
        Else
            Session("kod_kw2") = kod_kw2
        End If

        If tahun = "" Or kod_kw2 = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_PembayaranInvoisBil(tahun, kod_kw2)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_PembayaranInvoisBil(tahun As String, kod_kw2 As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            If kod_kw2 = "00" Then
                optionalwhere = "and kod_kump_wang >=1 and kod_kump_wang <=11"
            Else
                optionalwhere = "and kod_kump_wang = @kod_kw2"


            End If



            query = "SELECT
                        DISTINCT LEFT(B.Kod_Ptj, 2) + '0000' + '-' + D.Pejabat AS Kod_PTJ1_with_Zeros, D.Pejabat,
                       'AP' + SUBSTRING(A.No_Rujukan, CHARINDEX('AP', A.No_Rujukan) + 2, LEN(A.No_Rujukan)) AS APValue,
                       A.No_Rujukan AS Bil,
                       A.*,
                       B.*,
                       C.*
                    FROM SMKB_Pembayaran_Invois_Hdr A
                    INNER JOIN SMKB_Pembayaran_Invois_Dtl B ON A.ID_Rujukan = B.ID_Rujukan
                    INNER JOIN SMKB_Pemiutang_Master C ON B.Kod_Pemiutang = C.Kod_Pemiutang
                    JOIN [devmis\SQL_INS01].dbStaf.dbo.MS_PEJABAT D ON LEFT(B.Kod_Ptj, 2) = D.KodPejabat
                    WHERE
                        YEAR(A.Tarikh_Invois) = @tahun
                        " + optionalwhere + "
                        AND A.Jenis_Invois IN ('J02')
                        AND C.Kategori_Pemiutang <> 'SY'
                        AND A.Kod_Vot IN ('81101')
                    ORDER BY Kod_PTJ;
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))
            cmd.Parameters.Add(New SqlParameter("@kod_kw2", kod_kw2))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'SENARAI_PERBELANJAAN_BIL END

    'SENARAI_PERBELANJAAN_PESANAN_TEMPATAN START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PembayaranInvoisPesananTempatan(tahun As String, kod_kw3 As String) As String
        Dim resp As New ResponseRepository

        If tahun = "" Then
            tahun = Session("tahun")
        Else
            Session("tahun") = tahun
        End If

        If kod_kw3 = "" Then
            kod_kw3 = Session("kod_kw3")
        Else
            Session("kod_kw3") = kod_kw3
        End If

        If tahun = "" Or kod_kw3 = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_PembayaranInvoisPesananTempatan(tahun, kod_kw3)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_PembayaranInvoisPesananTempatan(tahun As String, kod_kw3 As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            If kod_kw3 = "00" Then
                optionalwhere = "and kod_kump_wang >=1 and kod_kump_wang <=11"
            Else
                optionalwhere = "and kod_kump_wang = @kod_kw3"


            End If



            query = "SELECT
                        DISTINCT LEFT(B.Kod_Ptj, 2) + '0000' + '-' + D.Pejabat AS Kod_PTJ1_with_Zeros, D.Pejabat,
                       'AP' + SUBSTRING(A.No_Rujukan, CHARINDEX('AP', A.No_Rujukan) + 2, LEN(A.No_Rujukan)) AS APValue,
                       A.No_Rujukan AS Bil,
                       A.*,
                       B.*,
                       C.*
                    FROM SMKB_Pembayaran_Invois_Hdr A
                    INNER JOIN SMKB_Pembayaran_Invois_Dtl B ON A.ID_Rujukan = B.ID_Rujukan
                    INNER JOIN SMKB_Pemiutang_Master C ON B.Kod_Pemiutang = C.Kod_Pemiutang
                    JOIN [devmis\SQL_INS01].dbStaf.dbo.MS_PEJABAT D ON LEFT(B.Kod_Ptj, 2) = D.KodPejabat
                    WHERE
                        YEAR(A.Tarikh_Invois) = @tahun
                        " + optionalwhere + "
                        AND A.Jenis_Invois IN ('J01')
                        AND C.Kategori_Pemiutang = 'SY' 
                        AND A.Kod_Vot IN ('81101')
                    ORDER BY Kod_PTJ;
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))
            cmd.Parameters.Add(New SqlParameter("@kod_kw3", kod_kw3))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'SENARAI_PERBELANJAAN_PESANAN_TEMPATAN END


    'BELANJA_AKRUAN_YANG_LAIN_BIL START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_BelanjaAkaruanInvoisBil(tahun As String, kod_kw4 As String) As String
        Dim resp As New ResponseRepository

        If tahun = "" Then
            tahun = Session("tahun")
        Else
            Session("tahun") = tahun
        End If

        If kod_kw4 = "" Then
            kod_kw4 = Session("kod_kw4")
        Else
            Session("kod_kw4") = kod_kw4
        End If

        If tahun = "" Or kod_kw4 = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_BelanjaAkaruanInvoisBil(tahun, kod_kw4)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_BelanjaAkaruanInvoisBil(tahun As String, kod_kw4 As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            If kod_kw4 = "00" Then
                optionalwhere = "and kod_kump_wang >=1 and kod_kump_wang <=11"
            Else
                optionalwhere = "and kod_kump_wang = @kod_kw4"


            End If



            query = "SELECT
                        DISTINCT LEFT(B.Kod_Ptj, 2) + '0000' + '-' + D.Pejabat AS Kod_PTJ1_with_Zeros, D.Pejabat,
                       'AP' + SUBSTRING(A.No_Rujukan, CHARINDEX('AP', A.No_Rujukan) + 2, LEN(A.No_Rujukan)) AS APValue,
                       A.No_Rujukan AS Bil,
                       A.*,
                       B.*,
                       C.*
                    FROM SMKB_Pembayaran_Invois_Hdr A
                    INNER JOIN SMKB_Pembayaran_Invois_Dtl B ON A.ID_Rujukan = B.ID_Rujukan
                    INNER JOIN SMKB_Pemiutang_Master C ON B.Kod_Pemiutang = C.Kod_Pemiutang
                    JOIN [devmis\SQL_INS01].dbStaf.dbo.MS_PEJABAT D ON LEFT(B.Kod_Ptj, 2) = D.KodPejabat
                    WHERE
                        YEAR(A.Tarikh_Invois) = @tahun
                        " + optionalwhere + "
                        AND A.Jenis_Invois IN ('J02')
                        AND C.Kategori_Pemiutang <> 'SY'
                        AND A.Kod_Vot IN ('81402')
                    ORDER BY Kod_PTJ;
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))
            cmd.Parameters.Add(New SqlParameter("@kod_kw4", kod_kw4))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'BELANJA_AKRUAN_YANG_LAIN_BIL END

    ' BELANJA_AKRUAN_YANG_LAIN_INDIVIDU START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_BelanjaAkaruanInvoisIndividu(tahun As String, kod_kw5 As String) As String
        Dim resp As New ResponseRepository

        If tahun = "" Then
            tahun = Session("tahun")
        Else
            Session("tahun") = tahun
        End If

        If kod_kw5 = "" Then
            kod_kw5 = Session("kod_kw5")
        Else
            Session("kod_kw5") = kod_kw5
        End If

        If tahun = "" Or kod_kw5 = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_BelanjaAkaruanInvoisIndividu(tahun, kod_kw5)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_BelanjaAkaruanInvoisIndividu(tahun As String, kod_kw5 As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            If kod_kw5 = "00" Then
                optionalwhere = "and kod_kump_wang >=1 and kod_kump_wang <=11"
            Else
                optionalwhere = "and kod_kump_wang = @kod_kw5"


            End If



            query = "SELECT
                        DISTINCT LEFT(B.Kod_Ptj, 2) + '0000' + '-' + D.Pejabat AS Kod_PTJ1_with_Zeros, D.Pejabat,
                       'AP' + SUBSTRING(A.No_Rujukan, CHARINDEX('AP', A.No_Rujukan) + 2, LEN(A.No_Rujukan)) AS APValue,
                       A.No_Rujukan AS Bil,
                       A.*,
                       B.*,
                       C.*
                    FROM SMKB_Pembayaran_Invois_Hdr A
                    INNER JOIN SMKB_Pembayaran_Invois_Dtl B ON A.ID_Rujukan = B.ID_Rujukan
                    INNER JOIN SMKB_Pemiutang_Master C ON B.Kod_Pemiutang = C.Kod_Pemiutang
                    JOIN [devmis\SQL_INS01].dbStaf.dbo.MS_PEJABAT D ON LEFT(B.Kod_Ptj, 2) = D.KodPejabat
                    WHERE
                        YEAR(A.Tarikh_Invois) = @tahun
                        " + optionalwhere + "
                        AND A.Jenis_Invois IN ('J10')
                        AND C.Kategori_Pemiutang <> 'SY'
                        AND A.Kod_Vot IN ('81402')
                    ORDER BY Kod_PTJ;
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))
            cmd.Parameters.Add(New SqlParameter("@kod_kw5", kod_kw5))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    'BELANJA_AKRUAN_YANG_LAIN_INDIVIDU END

    ' BELANJA_AKRUAN_YANG_LAIN_Pesanan_Tempatan START

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_BelanjaAkaruanInvoisPesananTempatan(tahun As String, kod_kw6 As String) As String
        Dim resp As New ResponseRepository

        If tahun = "" Then
            tahun = Session("tahun")
        Else
            Session("tahun") = tahun
        End If

        If kod_kw6 = "" Then
            kod_kw6 = Session("kod_kw6")
        Else
            Session("kod_kw6") = kod_kw6
        End If

        If tahun = "" Or kod_kw6 = "" Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_BelanjaAkaruanInvoisPesananTempatan(tahun, kod_kw6)

        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_BelanjaAkaruanInvoisPesananTempatan(tahun As String, kod_kw6 As String) As DataTable
        Dim db = New DBKewConn
        Dim dt As New DataTable

        Dim connectionString As String = strCon


        Using sqlconn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand
            sqlconn.Open()

            Dim query As String
            Dim optionalwhere = ""

            If kod_kw6 = "00" Then
                optionalwhere = "and kod_kump_wang >=1 and kod_kump_wang <=11"
            Else
                optionalwhere = "and kod_kump_wang = @kod_kw6"


            End If



            query = "SELECT
                        DISTINCT LEFT(B.Kod_Ptj, 2) + '0000' + '-' + D.Pejabat AS Kod_PTJ1_with_Zeros, D.Pejabat,
                       'AP' + SUBSTRING(A.No_Rujukan, CHARINDEX('AP', A.No_Rujukan) + 2, LEN(A.No_Rujukan)) AS APValue,
                       A.No_Rujukan AS Bil,
                       A.*,
                       B.*,
                       C.*
                    FROM SMKB_Pembayaran_Invois_Hdr A
                    INNER JOIN SMKB_Pembayaran_Invois_Dtl B ON A.ID_Rujukan = B.ID_Rujukan
                    INNER JOIN SMKB_Pemiutang_Master C ON B.Kod_Pemiutang = C.Kod_Pemiutang
                    JOIN [devmis\SQL_INS01].dbStaf.dbo.MS_PEJABAT D ON LEFT(B.Kod_Ptj, 2) = D.KodPejabat
                    WHERE
                        YEAR(A.Tarikh_Invois) = @tahun
                        " + optionalwhere + "
                        AND A.Jenis_Invois IN ('J01')
                        AND C.Kategori_Pemiutang = 'SY' 
                        AND A.Kod_Vot IN ('81402')
                    ORDER BY Kod_PTJ;
                    "

            cmd.Connection = sqlconn
            cmd.CommandText = query

            cmd.Parameters.Add(New SqlParameter("@tahun", tahun))
            cmd.Parameters.Add(New SqlParameter("@kod_kw6", kod_kw6))
            dt.Load(cmd.ExecuteReader())
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadVotPmtgDetails(KodVot As String, KodPtj As String, Tahun As String, KodKW As String, KodOperasi As String, KodProjek As String, KodPmtg As String) As String
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
	            from SMKB_Lejar_Pemiutang
	            where Kod_Vot = @KodVot
	            and Tahun = @Tahun
	            and Kod_Kump_Wang = @KodKW
	            and Kod_Operasi = @KodOperasi
	            and Kod_PTJ = @KodPtj
                and Kod_Vot = @KodVot 
	            and Kod_Projek = @KodProjek
                and Kod_Pemiutang = @KodPemiutang
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
            cmd.Parameters.Add(New SqlParameter("@KodPemiutang", KodPmtg))

            dt.Load(cmd.ExecuteReader())
        End Using

        Return JsonConvert.SerializeObject(dt)
    End Function

    'BELANJA_AKRUAN_YANG_LAIN_Pesanan_Tempatan END

End Class
