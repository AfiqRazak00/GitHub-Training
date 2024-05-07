Imports System.ComponentModel
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Newtonsoft.Json

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Bajet_Dashboard_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadTahun() As String
        Dim tmpDT As DataTable = GetListTahun()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetListTahun() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "select Tahun as value, Tahun as text from SMKB_Kod_Tahun order by Tahun Desc"
        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListKW(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiKW(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiKW(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT distinct a.Kod_Kump_Wang as value, b.Butiran as text FROM SMKB_COA_Master as a , SMKB_Kump_Wang as b
                                where a.Kod_Kump_Wang = b.Kod_Kump_Wang and  Kod_PTJ = @ptj and a.Status = @status AND a.Kod_Kump_Wang IN ('01','07')"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (a.Kod_Kump_Wang LIKE '%' + @kod + '%' or b.Butiran LIKE '%' + @kod2 + '%') order by a.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@status", "1"))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListKO(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiKO(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiKO(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "select Kod_Operasi as value, Butiran as text from SMKB_Operasi where Status = @status"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (Kod_Operasi LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') order by Kod_Operasi"
        End If

        param.Add(New SqlParameter("@status", 1))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumAgih(ByVal Tahun As String, ByVal KW As String, ByVal KO As String) As String
        Dim tmpDT As DataTable = GetJumAgihan(Tahun, KW, KO)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetJumAgihan(Tahun As String, KW As String, KO As String) As DataTable
        Dim db As New DBKewConn

        Dim param As New List(Of SqlParameter)
        Dim query As String = "select ISNULL(SUM(a.Jumlah_Bendahari),0) AS Jumlah from SMKB_Agihan_Bajet_Hdr A, SMKB_Agihan_Bajet_Dtl B  
                where A.Kod_Agih = 'AL'
                AND A.No_Mohon = B.No_Mohon
                AND A.Kod_PTJ = @ptj
                and A.Kod_Kump_Wang = @KW
                and A.Kod_Operasi = @KO
                and year(a.Tkh_LPU) = @Tahun
                and b.Jumlah_Bendahari <> 0  and a.Status_Dok = '11'"

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@KW", KW))
        param.Add(New SqlParameter("@KO", KO))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumTambah(ByVal Tahun As String, ByVal KW As String, ByVal KO As String) As String
        Dim tmpDT As DataTable = GetJumTambah(Tahun, KW, KO)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetJumTambah(Tahun As String, KW As String, KO As String) As DataTable
        Dim db As New DBKewConn

        Dim param As New List(Of SqlParameter)
        Dim query As String = "
                select ISNULL(sum(jumlah),0) as Jumlah
                from (

                Select ISNULL(SUM(Amaun),0) as Jumlah  from SMKB_BG_ViremenDtl b , SMKB_BG_Viremen a
                WHERE a.Kod_Status_Dok = '05'
                and a.No_Viremen = b.No_Viremen
                and b.Kod_Vir ='M'
                AND b.Kod_PTJ = @ptj
                and b.Kod_Kump_Wang = @KW
                and b.Kod_Operasi = @KO
                and year(a.Tkh_Lulus_NC) = @Tahun 

                union all

                select ISNULL(SUM(a.Jumlah_Bendahari),0) AS Jumlah from SMKB_Agihan_Bajet_Hdr A, SMKB_Agihan_Bajet_Dtl B  
                where A.Kod_Agih = 'BJTTAMBAH'
                AND A.No_Mohon = B.No_Mohon
                AND A.Kod_PTJ = @ptj
                and A.Kod_Kump_Wang = @KW
                and A.Kod_Operasi = @KO
                and year(a.Tkh_LPU) = @Tahun
                and b.Jumlah_Bendahari <> 0  and a.Status_Dok = '03'
                ) a"

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@KW", KW))
        param.Add(New SqlParameter("@KO", KO))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumKurang(ByVal Tahun As String, ByVal KW As String, ByVal KO As String) As String
        Dim tmpDT As DataTable = GetJumKurang(Tahun, KW, KO)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetJumKurang(Tahun As String, KW As String, KO As String) As DataTable
        Dim db As New DBKewConn

        Dim param As New List(Of SqlParameter)
        Dim query As String = "
                select ISNULL(sum(jumlah),0) as Jumlah
                from (

                Select ISNULL(SUM(Amaun),0) as Jumlah  from SMKB_BG_ViremenDtl b , SMKB_BG_Viremen a
                WHERE a.Kod_Status_Dok = '05'
                and a.No_Viremen = b.No_Viremen
                and b.Kod_Vir ='K'
                AND b.Kod_PTJ = @ptj
                and b.Kod_Kump_Wang = @KW
                and b.Kod_Operasi = @KO
                and year(a.Tkh_Lulus_NC) = @Tahun 

                union all

                select ISNULL(SUM(a.Jumlah_Bendahari),0) AS Jumlah from SMKB_Agihan_Bajet_Hdr A, SMKB_Agihan_Bajet_Dtl B  
                where A.Kod_Agih = 'BJTKURANG'
                AND A.No_Mohon = B.No_Mohon
                AND A.Kod_PTJ = @ptj
                and A.Kod_Kump_Wang = @KW
                and A.Kod_Operasi = @KO
                and year(a.Tkh_LPU) = @Tahun
                and b.Jumlah_Bendahari <> 0  and a.Status_Dok = '03'
                ) as a
                "

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@KW", KW))
        param.Add(New SqlParameter("@KO", KO))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumBelanja(ByVal Tahun As String, ByVal KW As String, ByVal KO As String) As String
        Dim tmpDT As DataTable = GetJumBelanja(Tahun, KW, KO)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetJumBelanja(Tahun As String, KW As String, KO As String) As DataTable
        Dim db As New DBKewConn

        Dim param As New List(Of SqlParameter)
        Dim query As String = "
                select isnull(sum(jumDebit - jumKredit),0) as Jumlah
                from 
                (

                SELECT  sum(jrnl_dt_kt.jumDebit) as jumDebit, sum(jrnl_dt_kt.jumKredit) as jumKredit
                FROM(
                -- jrnl_debit AR (Kewangan & stud)
                SELECT sum(Debit) as jumDebit , sum(Kredit) as jumKredit FROM SMKB_Terima_Dtl B ,SMKB_Terima_Hdr A 
                WHERE YEAR(A.Tkh_Lulus) = @Tahun and a.No_Dok = b.No_Dok
                and a.Kod_Status_Dok ='06'
                and B.Kod_Kump_Wang = @KW
                and b.Kod_Operasi = @KO
                and b.Kod_PTJ = @ptj

                UNION ALL

                -- jrnl_debit BK, BP 
                SELECT 0 AS jumDebit, sum(Jumlah_Bayar) as jumKredit FROM SMKB_Pembayaran_Baucar_Dtl b ,SMKB_Pembayaran_Baucar_Hdr A 
                WHERE YEAR(a.Tarikh) = @Tahun and a.No_Baucar = b.No_Baucar
                and Status_Dok = '11'
                and B.Kod_Kump_Wang =  @KW
                and b.Kod_Operasi =  @KO
                and b.Kod_PTJ = @ptj

                UNION ALL

                -- invois AP - pemiutang
                SELECT 0 as jumDebit, 
				CASE WHEN @ptj = '500000' THEN sum(a.Jumlah_Bayar) 
				ELSE  0  END  AS jumKredit
				FROM SMKB_Pembayaran_Invois_Dtl b ,SMKB_Pembayaran_Invois_Hdr A 
                WHERE YEAR(a.Tarikh_Invois) = '2024' and a.ID_Rujukan = b.ID_Rujukan
                and Status_Dok in ('07','42')
                and a.Kod_Vot = '81101'
                and b.Kod_Operasi =  '01'

				union all
				-- invois AP - coa dt
                SELECT sum(b.Amaun_Sebenar) as jumDebit,  0 AS jumKredit FROM SMKB_Pembayaran_Invois_Dtl b ,SMKB_Pembayaran_Invois_Hdr A 
                WHERE YEAR(a.Tarikh_Invois) = @Tahun and a.ID_Rujukan = b.ID_Rujukan
                and Status_Dok in ('07','42')
                and B.Kod_Kump_Wang =  @KW
                and b.Kod_Operasi =  @KO
                and b.Kod_PTJ = @ptj

                UNION ALL

                -- jurnal JP
                SELECT sum(Debit) as jumDebit, sum(Kredit) AS jumKredit FROM SMKB_Jurnal_Dtl b ,SMKB_Jurnal_Hdr A 
                WHERE YEAR(a.Tkh_Transaksi) = @Tahun and a.No_Jurnal = b.No_Jurnal
                and Kod_Status_Dok = '04'
                AND Kod_Trans ='GL-JP'
                and B.Kod_Kump_Wang =  @KW
                and b.Kod_Operasi =  @KO
                and b.Kod_PTJ = @ptj

                ) AS jrnl_dt_kt

                union all
                --JK
                SELECT sum(Debit) as jumDebit, 0 AS jumKredit FROM SMKB_Jurnal_Dtl b ,SMKB_Jurnal_Hdr A 
                WHERE YEAR(a.Tkh_Transaksi) = @Tahun and a.No_Jurnal = b.No_Jurnal
                and Kod_Status_Dok = '04'
                AND Kod_Trans ='GL-JE'
                and B.Kod_Kump_Wang =  @KW
                and b.Kod_Operasi =  @KO
                and b.Kod_PTJ = @ptj
                and (A.Status_Lejar is null or A.Status_Lejar = 0)
                ) as jumBelanja
                "

        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@KW", KW))
        param.Add(New SqlParameter("@KO", KO))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))

        Return db.Read(query, param)
    End Function

End Class