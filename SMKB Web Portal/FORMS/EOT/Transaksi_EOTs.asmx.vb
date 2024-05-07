Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Globalization
Imports System.IO
Imports System.Collections.Generic
Imports System.Drawing
Imports System.Web.Configuration

Imports System.Net.Http

Imports System.Web
Imports System.Net
Imports System.Net.Mail
Imports System.ValueTuple

Imports System.Threading
Imports System.Data.OleDb

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Transaksi_EOTs
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    'Dim sqlquery As New Query
    Private strConn As String = "Data Source=devmis12.utem.edu.my;Initial Catalog=dbKewanganV4;Persist Security Info=True;User ID=smkb;Password=Smkb@Dev2012"
    'Private strConn As String = "Data Source=qa12.utem.edu.my;Initial Catalog=dbKewanganV4;Persist Security Info=True;User ID=smkb;Password=smkb*pwd"

    Public Function HelloWorld() As String
        Return "Hello World"
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetUserInfo(nostaf As String)
        Dim db As New DBSMConn

        Dim query As String = $"Select a.NoStaf As StafNo, a.Nama As Param1, a.KodPejabat As Param2, a.JGiliran As Param3, a.MS02_Taraf As Param4, 
                                a.Singkat as Param5, a.GredGaji As Param6, Right(a.GredGaji, 2) As GredGaji, 
                                a.MS02_JumlahGajiS, a.NoTelBimbit As Param7,a.ms08_Unit as KodPejPemohon
                                From vperibadi12 As a   
                                Where a.NoStaf = '{nostaf}' "

        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJumJamLulusdanAmaunTuntut(nomohon As String)
        Dim db = New DBKewConn


        Dim query As String = $"Select  SUBSTRING(e.jam, 1, 2) + ' JAM ' + SUBSTRING(e.jam,4,5) + ' MINIT ' AS DetJam,
        SUBSTRING(e.JamLulus, 1, 2) + ' JAM ' + SUBSTRING(e.JamLulus,4,5) + ' MINIT ' AS DetJamLulus, * from
        (Select RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,				
		sum(d.AmaunTuntut) as AmaunTuntut,
        Right('00' + CAST(SUM(d.JamLulus) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.JamLulus) % 60 AS VARCHAR(2)), 2) AS JamLulus,sum(d.AmaunLulus) as AmaunLulus
        from
        (SELECT sum(convert(int,substring(b.Jum_Jam_Tuntut,1,2)) * 60 + convert(int,substring(b.Jum_Jam_Tuntut,3,2))) as Jam, 
        sum(b.Amaun_Tuntut) As AmaunTuntut , sum(convert(int,substring(b.Jum_Jam_Lulus,1,2)) * 60 + convert(int,substring(b.Jum_Jam_Lulus,3,2))) As Jamlulus,
        sum(b.Amaun_Lulus) As AmaunLulus
        From SMKB_EOT_Mohon_Hdr a INNER Join
        SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon			
        Where (b.Status_Sah ='S')  and b.No_Mohon = '{nomohon}') d) e"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJumJamLulusdanAmaunTerima(nomohon As String)
        Dim db = New DBKewConn


        Dim query As String = $"Select  SUBSTRING(e.jam, 1, 2) + ' JAM ' + SUBSTRING(e.jam,4,5) + ' MINIT ' AS DetJam,
        SUBSTRING(e.JamLulus, 1, 2) + ' JAM ' + SUBSTRING(e.JamLulus,4,5) + ' MINIT ' AS DetJamLulus, * from
        (Select RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,				
		sum(d.AmaunTerima) as AmaunTerima,
        Right('00' + CAST(SUM(d.JamLulus) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.JamLulus) % 60 AS VARCHAR(2)), 2) AS JamLulus,sum(d.AmaunLulus) as AmaunLulus
        from
        (SELECT sum(convert(int,substring(b.Jum_Jam_Terima,1,2)) * 60 + convert(int,substring(b.Jum_Jam_Terima,3,2))) as Jam, 
        sum(b.Amaun_Terima) As AmaunTerima , sum(convert(int,substring(b.Jum_Jam_Lulus,1,2)) * 60 + convert(int,substring(b.Jum_Jam_Lulus,3,2))) As Jamlulus,
        sum(b.Amaun_Lulus) As AmaunLulus
        From SMKB_EOT_Mohon_Hdr a INNER Join
        SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon			
        Where (b.Status_Lulus ='L')  and  b.No_Mohon = '{nomohon}') d) e"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPermohonanPemohonPengesahan(nomohon As String, noturutan As Integer)
        Dim db = New DBKewConn


        Dim query As String = $"select e.ID, format(e.Tkh_Tuntut,'dd/MM/yyyy') as Tkh_Tuntut,e.No_Staf_Sah,f.ms01_nama,
        (e.No_Staf_Sah + '-'+ f.ms01_nama) as NamaPegawai,
		e.Jam_Mula,e.Jam_Tamat,e.Jam_Mula_Sah,e.Jam_Tamat_Sah,
		SUBSTRING(e.jam, 1, 2) + ' JAM ' + SUBSTRING(e.jam,4,5) + ' MINIT ' AS DetJam,
        SUBSTRING(e.JamSah, 1, 2) + ' JAM ' + SUBSTRING(e.JamSah,4,5) + ' MINIT ' AS DetJamSah,
		sum(e.AmaunTuntut) as AmaunTuntut,sum(e.AmaunSah) as AmaunSah,sum(e.Kadar_Tuntut) as Kadar_Tuntut,sum(e.Kadar_Lulus) as Kadar_Lulus from
        (Select d.ID,d.Tkh_Tuntut, d.No_Staf_Sah,d.Jam_Mula,d.Jam_Tamat,
		d.Jam_Mula_Sah,d.Jam_Tamat_Sah,RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,				
		sum(d.AmaunTuntut) as AmaunTuntut,
        Right('00' + CAST(SUM(d.JamSah) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.JamSah) % 60 AS VARCHAR(2)), 2) AS JamSah,sum(d.AmaunSah) as AmaunSah,sum(d.Kadar_Tuntut) as Kadar_Tuntut,
		sum(d.Kadar_Lulus) as Kadar_Lulus,d.No_Turutan
		 from
        (SELECT b.id,b.Tkh_Tuntut,b.No_Staf_Sah,b.Jam_Mula,b.Jam_Tamat,
		b.Jam_Mula_Sah,b.Jam_Tamat_Sah,
		sum(convert(int,substring(b.Jum_Jam_Tuntut,1,2)) * 60 + convert(int,substring(b.Jum_Jam_Tuntut,3,2))) as Jam, 
        sum(b.Amaun_Tuntut) As AmaunTuntut , sum(convert(int,substring(b.Jum_Jam_Sah,1,2)) * 60 + convert(int,substring(b.Jum_Jam_Sah,3,2))) As JamSah,
        sum(b.Amaun_Sah) As AmaunSah,sum(b.Kadar_Tuntut) as Kadar_Tuntut,sum(b.Kadar_Lulus) as Kadar_Lulus,No_Turutan
        From SMKB_EOT_Mohon_Hdr a INNER Join
        SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon			
        Where (b.No_Mohon = '{nomohon}') and (No_Turutan = '{noturutan}') group by b.Tkh_Tuntut,b.ID,b.No_Staf_Sah,b.Jam_Mula,b.Jam_Tamat,
		b.Jam_Mula_Sah,b.Jam_Tamat_Sah, b.No_Turutan)d group by d.Tkh_Tuntut,d.ID,d.No_Staf_Sah,d.Jam_Mula,d.Jam_Tamat,
		d.Jam_Mula_Sah,d.Jam_Tamat_Sah,d.No_Turutan) e		
		inner join VPeribadi f on e.No_Staf_Sah = f.ms01_nostaf
		group by e.Tkh_Tuntut,e.ID,e.No_Staf_Sah,f.ms01_nama,e.Jam_Mula,e.Jam_Tamat,e.Jam_Mula_Sah,e.Jam_Tamat_Sah,
		e.Jam,e.JamSah,e.AmaunTuntut,e.AmaunSah,e.Kadar_Tuntut,e.Kadar_Lulus,e.No_Turutan"


        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetOTBelumLulus(ptj As String)
        Dim db = New DBKewConn
        Dim query As String = $"select SUM(Amaun_Sah) AS JumOtBL from SMKB_EOT_Mohon_Dtl a inner join SMKB_EOT_Mohon_Hdr b
        on a.No_Mohon = b.No_Mohon where Status_Lulus = 'BL' or Status_Lulus IS NULL  AND B.Status_Mohon = '02'
        and b.OT_Ptj = '{ptj}' "

        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPegPengesah(ByVal q As String, ByVal chk As Boolean, ByVal ptj As String) As String
        Dim tmpDT As DataTable = GetPengesah(q, chk, ptj)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetPengesah(q As String, chk As String, ptj As String) As DataTable
        Dim db As New DBKewConn("smsm")
        Dim where As String = ""
        Dim where2 As String = ""
        'nd c.ms08_Pejabat= @kodPTJ "
        Dim query As String = "SELECT distinct a.MS01_NoStaf,a.MS01_Nama FROM MS01_Peribadi a 
                            inner join MS02_Perjawatan b ON a.MS01_NoStaf = b.MS01_NoStaf   "
        Dim param As New List(Of SqlParameter)
        If q <> "" Then
            where = " AND (a.MS01_NoStaf LIKE '%' + @q + '%' or a.MS01_Nama LIKE '%' + @q2 + '%')  and a.MS01_Status='1'"
            param.Add(New SqlParameter("@q", q))
            param.Add(New SqlParameter("@q2", q))
        End If

        If chk = False Then
            query &= " INNER JOIN MS08_Penempatan c ON a.MS01_NoStaf = c.MS01_NoStaf "


            'param.Add(New SqlParameter("@kodPTJ", ptj.Substring(0, 2)))
            where2 = " and a.MS01_Status='1' and c.ms08_staterkini='1' AND  RIGHT(b.MS02_GredGajiS,2) >= '41'  "
        Else
            where2 = " and  a.MS01_Status='1' and c.ms08_staterkini='1' AND  RIGHT(b.MS02_GredGajiS,2) >= '41'  "
        End If
        query = query + " WHERE 1 = 1 " + where + where2 + " ORDER BY a.MS01_Nama "
        Return db.ReadDB(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKetuaJabatan(ByVal q As String, ByVal chk As Boolean, ByVal ptj As String) As String
        Dim tmpDT As DataTable = GetLoadKetuaJabatan(q, chk, ptj)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    Private Function GetLoadKetuaJabatan(q As String, chk As String, ptj As String) As DataTable
        Dim db As New DBKewConn("smsm")
        Dim where As String = ""
        Dim where2 As String = ""

        'and c.ms08_Pejabat= @kodPTJ "
        Dim query As String = "SELECT distinct a.MS01_NoStaf,a.MS01_Nama FROM MS01_Peribadi a 
                            inner join MS02_Perjawatan b ON a.MS01_NoStaf = b.MS01_NoStaf   "
        Dim param As New List(Of SqlParameter)
        If q <> "" Then
            where = " AND (a.MS01_NoStaf LIKE '%' + @q + '%' or a.MS01_Nama LIKE '%' + @q2 + '%')  and a.MS01_Status='1'"
            param.Add(New SqlParameter("@q", q))
            param.Add(New SqlParameter("@q2", q))
        End If

        If chk = False Then
            query &= " INNER JOIN MS08_Penempatan c ON a.MS01_NoStaf = c.MS01_NoStaf"


            ' param.Add(New SqlParameter("@kodPTJ", ptj.Substring(0, 2)))
            where2 = " and a.MS01_Status='1' and c.ms08_staterkini='1' AND  RIGHT(b.MS02_GredGajiS,2) >= '44'  "
        Else
            where2 = " and  a.MS01_Status='1' AND and c.ms08_staterkini='1' and  RIGHT(b.MS02_GredGajiS,2) >= '44'  "
        End If
        query = query + " WHERE 1 = 1 " + where + where2 + " ORDER BY a.MS01_Nama "
        Return db.ReadDB(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetStaf() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select NoStaf, Nama, singkat As PTJ from vperibadi12"

        Return db.Read(query)
    End Function

    Private Function fGetARNo() As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "SELECT   Kod_Modul, Prefix, No_Akhir, Tahun, Butiran, Kod_PTJ, ID
                               FROM  SMKB_No_Akhir WHERE Kod_Modul = 'EOT' AND Prefix = 'AR'
                               AND Tahun = '{Date.Now.Year}'"

        dt = db.Read(query)
        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("No_Akhir")) + 1
        End If

        newOrderID = lastID
        Return newOrderID
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordStafArahan(idarahan As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordStafArahan(idarahan)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordStafArahan(idarahan As String) As DataTable
        Dim db As New DBKewConn


        Dim query As String = "select a.No_Arahan,a.No_Staf,b.MS01_Nama from SMKB_EOT_Arahan_Kerja_Dtl a inner join
            vperibadi  b on a.No_Staf = b.ms01_nostaf where a.No_Arahan = @No_Arahan ORDER BY a.No_Staf"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Arahan", idarahan))


        Return db.ReadDB(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordArahanEOT() As String
        Dim resp As New ResponseRepository

        dt = GetRecordArahanEOT()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordArahanEOT() As DataTable
        Dim db As New DBKewConn


        Dim query As String = "SELECT a.No_Arahan, a.No_Surat, a.No_Staf_Peg_AK, a.Kod_PTJ, a.Tkh_Mula, a.Tkh_Tamat, a.Lokasi, a.PeneranganK
            FROM            SMKB_EOT_Arahan_Kerja_Hdr a inner join SMKB_EOT_Arahan_Kerja_Dtl b on a.No_Arahan = b.No_Arahan where a.No_Staf_Peg_AK = '" & Session("ssusrID") & "'
            ORDER BY a.Date_Created"

        Return db.ReadDB(query)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSemakanPermohonan(category_filter As String, category_OT As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetSemakanPermohonan(category_filter, category_OT, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetSemakanPermohonan(category_filter As String, category_OT As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        ' Dim query As String = "select a.No_Mohon,a.No_Arahan,a.No_Staf,b.MS01_nama,FORMAT (a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon,c.Butiran from [dbo].[SMKB_EOT_Mohon_Hdr] a
        'inner join [qa11].dbstaf.dbo.MS01_Peribadi b on a.No_Staf = b.ms01_nostaf
        'inner join SMKB_EOT_Status_Dok c on a.Status_Mohon = c.KodStatus order by c.Butiran"

        Dim tarikhQuery As String = ""



        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " where CAST(Tkh_Mohon AS DATE) = CAST(getdate() AS DATE)  "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -2, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " where CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " where CAST(Tkh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " where Tkh_Mohon >= DATEADD(month, -1, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " where Tkh_Mohon >= DATEADD(month, -2, getdate()) and Tkh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " where  Tkh_Mohon >= @tkhMula and Tkh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        Else
            tarikhQuery = "ORDER BY a.Butiran"

        End If


        If category_OT = "2" Then


            Dim query As String = "select a.No_Mohon as No_Mohon, a.No_Arahan as No_Arahan, a.No_Staf AS No_Staf,a.nama as nama,a.NPejabat as NPejabat,a.Pejabat as Pejabat,
                 Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon,a.MS01_KpB as MS01_KpB ,a.Butiran as Butiran
                from (select a.No_Mohon AS No_Mohon,a.No_Arahan AS No_Arahan,a.No_Staf AS No_Staf ,b.nama as nama,b.NPejabat as NPejabat ,
                Singkat as Pejabat,MS01_KpB,a.Tkh_Mohon as Tkh_Mohon,c.Butiran as Butiran from [dbo].[SMKB_EOT_Mohon_Hdr] a
			    inner join VPeribadi12 b on a.No_Staf = b.nostaf
			    inner join SMKB_EOT_Status_Dok c on a.Status_Mohon = c.KodStatus)  a  " & tarikhQuery & " "
            Return db.Read(query, param)
        Else



            Dim query As String = "select a.No_Mohon as No_Mohon, a.No_Arahan as No_Arahan, a.No_Staf AS No_Staf,a.nama as nama,a.NPejabat as NPejabat,a.Pejabat as Pejabat,
                 Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon,a.MS01_KpB as MS01_KpB,a.Butiran as Butiran from (Select Case when d.No_Mohon Is NULL then '-' else  d.No_Mohon end as No_Mohon,a.No_Arahan AS No_Arahan,b.No_Staf as No_Staf ,
                c.nama as nama ,c.NPejabat as NPejabat , c.Singkat as Pejabat, c.MS01_KpB as MS01_KpB ,
                 a.Date_Modified as Tkh_Mohon,case when d.No_Mohon IS NULL then  'BELUM MOHON OT'  else   (SELECT e.Butiran  FROM SMKB_EOT_Status_Dok e inner join
                SMKB_EOT_Mohon_Hdr f on f.Status_Mohon = e.KodStatus
                where  f.no_mohon = d.no_mohon)  end as Butiran
                From SMKB_EOT_Arahan_Kerja_Hdr a inner Join SMKB_EOT_Arahan_Kerja_Dtl b on a.No_Arahan = b.No_Arahan
                inner Join VPeribadi12 c on b.No_Staf = c.nostaf
                Left outer join SMKB_EOT_Mohon_Hdr d on d.No_Arahan = a.No_Arahan) a   " & tarikhQuery & " "
            Return db.Read(query, param)

        End If



    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSemakanPermohonanInd(category_filter As String, category_OT As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository
        Dim Nostaf = Session("ssusrID")
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetSemakanPermohonanInd(category_filter, category_OT, tkhMula, tkhTamat, Nostaf)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetSemakanPermohonanInd(category_filter As String, category_OT As String, tkhMula As DateTime, tkhTamat As DateTime, Nostaf As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim tarikhQuery As String = ""

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and (CAST(Tkh_Mohon AS DATE) = CAST(getdate() AS DATE))  "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -2, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and (CAST(Tkh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(Tkh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and (Tkh_Mohon >= DATEADD(month, -1, getdate()) and Tkh_Mohon <= getdate()) "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and (Tkh_Mohon >= DATEADD(month, -2, getdate()) and Tkh_Mohon <= getdate()) "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and  (Tkh_Mohon >= @tkhMula and Tkh_Mohon <= @TkhTamat) "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        Else
            tarikhQuery = "ORDER BY a.Butiran"

        End If


        If category_OT = "2" Then


            Dim query As String = "select a.No_Mohon as No_Mohon, a.No_Arahan as No_Arahan, a.No_Staf AS No_Staf,a.nama as nama,a.NPejabat as NPejabat,a.Pejabat as Pejabat,
                 Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon,a.MS01_KpB as MS01_KpB ,a.Butiran as Butiran
                from (select a.No_Mohon AS No_Mohon,a.No_Arahan AS No_Arahan,a.No_Staf AS No_Staf ,b.nama as nama,b.NPejabat as NPejabat ,
                Singkat as Pejabat,MS01_KpB,a.Tkh_Mohon as Tkh_Mohon,c.Butiran as Butiran from [dbo].[SMKB_EOT_Mohon_Hdr] a
			    inner join VPeribadi12 b on a.No_Staf = b.nostaf
			    inner join SMKB_EOT_Status_Dok c on a.Status_Mohon = c.KodStatus )  a  
                where a.No_Staf = @No_staf    " & tarikhQuery & " "
            param.Add(New SqlParameter("@No_staf", Nostaf))
            Return db.Read(query, param)
        Else



            Dim query As String = "select a.No_Mohon as No_Mohon, a.No_Arahan as No_Arahan, a.No_Staf AS No_Staf,a.nama as nama,a.NPejabat as NPejabat,a.Pejabat as Pejabat,
                 Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon,a.MS01_KpB as MS01_KpB,a.Butiran as Butiran from (Select Case when d.No_Mohon Is NULL then '-' else  d.No_Mohon end as No_Mohon,a.No_Arahan AS No_Arahan,b.No_Staf as No_Staf ,
                c.nama as nama ,c.NPejabat as NPejabat , c.Singkat as Pejabat, c.MS01_KpB as MS01_KpB ,
                 a.Date_Modified as Tkh_Mohon,case when d.No_Mohon IS NULL then  'BELUM MOHON OT'  else   (SELECT e.Butiran  FROM SMKB_EOT_Status_Dok e inner join
                SMKB_EOT_Mohon_Hdr f on f.Status_Mohon = e.KodStatus
                where  f.no_mohon = d.no_mohon)  end as Butiran
                From SMKB_EOT_Arahan_Kerja_Hdr a inner Join SMKB_EOT_Arahan_Kerja_Dtl b on a.No_Arahan = b.No_Arahan
                inner Join VPeribadi12 c on b.No_Staf = c.nostaf
                Left outer join SMKB_EOT_Mohon_Hdr d on d.No_Arahan = a.No_Arahan) a where a.No_Staf = @No_staf   " & tarikhQuery & " "
            param.Add(New SqlParameter("@No_staf", Nostaf))
            Return db.Read(query, param)

        End If



    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordArahanInd(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository
        Dim id As String = Session("ssusrID")
        dt = GetRecordArahanInd(category_filter, tkhMula, tkhTamat, id)
        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
        Return JsonConvert.SerializeObject(dt)
    End Function

    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordArahanInd(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, id As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        'Dim id As String = "02636"
        '
        ' @No_staf = Session("ssusrID")
        'id = Session("ssusrID")

        Dim tarikhQuery As String = ""


        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tkh_Mula AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -2, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tkh_Mula AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tkh_Mula AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tkh_Mula >= DATEADD(month, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tkh_Mula >= DATEADD(month, -2, getdate()) and a.Tkh_Transaksi <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and  a.Tkh_Mula >= @tkhMula and a.Tkh_Tamat <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        Else
            tarikhQuery = "ORDER BY a.No_Arahan"

        End If

        Dim query As String = "select a.No_Arahan,a.No_Surat,a.No_Staf_Peg_AK,b.ms01_nama, e.ms01_nama as Nama_Staf_Sah, 
                    d.No_Staf_SahB,d.No_Staf_SahB +' - '+ e.ms01_nama as Nama_Sah,g.ms01_nostaf as No_Staf_LulusB,
                    g.ms01_nama as Nama_Staf_LulusB,g.ms01_nostaf + ' - ' + g.ms01_nama as Staf_lulusB,
                    a.Kod_PTJ,c.pejabat,a.KW,a.Kod_Vot, FORMAT (a.Tkh_Mula, 'dd/MM/yyyy') as Tkh_Mula,FORMAT (a.Tkh_Tamat, 'dd/MM/yyyy')  AS Tkh_Tamat,
                    a.Lokasi,a.PeneranganK, isnull(f.File_Name,'-') as File_name, isnull(f.Folder,'-') as Folder,h.No_Staf 
                    from SMKB_EOT_Arahan_Kerja_Hdr a inner join SMKB_EOT_Arahan_Kerja_Dtl h
					on a.No_Arahan= h.No_Arahan 					
                    inner join VPeribadi b on a.No_Staf_Peg_AK = b.ms01_Nostaf
                    inner join VPejabat c on a.Kod_PTJ = c.kodPejabat
                    inner join SMKB_EOT_Pegawai d on a.No_Arahan = d.No_Mohon inner join
                    VPeribadi e on d.No_Staf_SahB = e.ms01_nostaf 
                    inner join VPeribadi g on  d.No_Staf_LulusB = g.ms01_nostaf
                    left outer join SMKB_EOT_Dok_ArahanK f on  f.No_Mohon = a.No_Arahan
				    where h.No_Staf = @No_staf " & tarikhQuery & " "

        param.Add(New SqlParameter("@No_staf", id))
        Return db.Read(query, param)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordArahan(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetRecordArahan(category_filter, tkhMula, tkhTamat)
        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())


        'resp.SuccessPayload(dt)
        For Each x As DataRow In dt.Rows
            If Not IsDBNull(x.Item("File_Name")) Then
                Dim url As String = GetBaseUrl() + Trim(x.Item("Folder")) + "/" + x.Item("File_Name")
                x.Item("url") = url
            End If

        Next
        Return JsonConvert.SerializeObject(dt)


    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordArahan(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db As New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " where CAST(a.Tkh_Mula AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -2, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " where CAST(a.Tkh_Mula AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " where CAST(a.Tkh_Mula AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " where a.Tkh_Mula >= DATEADD(month, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " where a.Tkh_Mula >= DATEADD(month, -2, getdate()) and a.Tkh_Transaksi <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " where  a.Tkh_Mula >= @tkhMula and a.Tkh_Tamat <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        Else
            tarikhQuery = "ORDER BY a.No_Arahan"

        End If

        Dim query As String = "select a.No_Arahan,a.No_Surat,a.No_Staf_Peg_AK,b.ms01_nama, e.ms01_nama as Nama_Staf_Sah, 
                    d.No_Staf_SahB,g.ms01_nostaf as No_Staf_LulusB,g.ms01_nama as Nama_Staf_LulusB,
                    g.ms01_nostaf + ' - ' + g.ms01_nama as Staf_lulusB,
                    a.Kod_PTJ,c.pejabat,a.KW,a.Kod_Vot, FORMAT(a.Tkh_Mula, 'yyyy-MM-dd') as Tkh_Mula,FORMAT(a.Tkh_Tamat, 'dd/MM/yyyy')  AS Tkh_Tamat,
                    a.Lokasi,a.PeneranganK, isnull(f.File_Name,'-') as File_name, isnull(f.Folder,'-') as Folder, f.Folder as url,replace(f.Jen_Dok,'','-') as Jen_Dok 
                    from SMKB_EOT_Arahan_Kerja_Hdr a 
                    inner join VPeribadi b on a.No_Staf_Peg_AK = b.ms01_Nostaf
                    inner join VPejabat c on a.Kod_PTJ = c.kodPejabat
                    inner join SMKB_EOT_Pegawai d on a.No_Arahan = d.No_Mohon inner join
                    VPeribadi e on d.No_Staf_SahB = e.ms01_nostaf 
                    inner join VPeribadi g on  d.No_Staf_LulusB = g.ms01_nostaf
                    left outer join SMKB_EOT_Dok_ArahanK f on  f.No_Mohon = a.No_Arahan   " & tarikhQuery & ""


        Return db.ReadDB(query)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordByNoArahan(id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordByNoArahan(id)
        'resp.SuccessPayload(dt)
        For Each x As DataRow In dt.Rows
            If Not IsDBNull(x.Item("File_Name")) Then
                Dim url As String = GetBaseUrl() + Trim(x.Item("Folder")) + "/" + x.Item("File_Name")
                x.Item("url") = url
            End If

        Next
        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordByNoArahan(id As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select a.No_Arahan,a.No_Surat,a.No_Staf_Peg_AK,b.ms01_nama, e.ms01_nama as Nama_Staf_Sah, 
                    d.No_Staf_SahB,g.ms01_nostaf as No_Staf_LulusB,g.ms01_nama as Nama_Staf_LulusB,
                    d.No_Staf_SahB + ' - ' + e.ms01_nama as Nama_Sah,
                    g.ms01_nostaf + ' - ' + g.ms01_nama as Staf_lulusB,
                    Kod_PTJ,c.pejabat,a.KW,a.Kod_Vot, FORMAT (a.Tkh_Mula, 'dd/MM/yyyy') as Tkh_Mula, FORMAT (a.Tkh_Tamat, 'dd/MM/yyyy')  AS Tkh_Tamat,
                    a.Lokasi,a.PeneranganK, isnull(f.File_Name,'-') as File_name, isnull(f.Folder,'-') as Folder , f.Folder as url,
                    (select butiran from SMKB_Kump_Wang where Kod_Kump_Wang = a.kw) as colKW,
					'00' as colhidko, (select Butiran from SMKB_Operasi as ko where  ko.Kod_Operasi = '00') as colKO,
                    '0000000' as colhidkp, (select Butiran from SMKB_Projek as kp where kp.Kod_Projek = '0000000') as colKp,
                    (select Kod_Vot+' - '+ Butiran from SMKB_Vot where Kod_Vot = a.Kod_Vot) as ButiranVot
                    from SMKB_EOT_Arahan_Kerja_Hdr a 
                    inner join VPeribadi b on a.No_Staf_Peg_AK = b.ms01_Nostaf
                    inner join VPejabat c on a.Kod_PTJ = c.kodPejabat
                    inner join SMKB_EOT_Pegawai d on a.No_Arahan = d.No_Mohon inner join
                    VPeribadi e on d.No_Staf_SahB = e.ms01_nostaf 
                    inner join Vperibadi g on  d.No_Staf_LulusB = g.ms01_nostaf
                    left outer join SMKB_EOT_Dok_ArahanK f on  f.No_Mohon = a.No_Arahan
                    where a.No_Arahan = @NoArahan"


        param.Add(New SqlParameter("@NoArahan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordBySemakanNoArahan(id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordBySemakanNoArahan(id)
        'resp.SuccessPayload(dt)
        For Each x As DataRow In dt.Rows
            If Not IsDBNull(x.Item("File_Name")) Then
                Dim url As String = GetBaseUrl() + Trim(x.Item("Folder")) + "/" + x.Item("File_Name")
                x.Item("url") = url
            End If

        Next
        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordBySemakanNoArahan(id As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select a.No_Arahan,a.No_Surat,a.No_Staf_Peg_AK,b.ms01_nama, e.ms01_nama as Nama_Staf_Sah, 
                    d.No_Staf_SahB,g.ms01_nostaf as No_Staf_LulusB,g.ms01_nama as Nama_Staf_LulusB,
                    d.No_Staf_SahB + ' - ' + e.ms01_nama as Nama_Sah,
                    g.ms01_nostaf + ' - ' + g.ms01_nama as Staf_lulusB,
                    Kod_PTJ,c.pejabat,a.KW,a.Kod_Vot, FORMAT (a.Tkh_Mula, 'yyyy-MM-dd') as Tkh_Mula, FORMAT (a.Tkh_Tamat, 'yyyy-MM-dd')  AS Tkh_Tamat,
                    a.Lokasi,a.PeneranganK, isnull(f.File_Name,'-') as File_name, isnull(f.Folder,'-') as Folder , f.Folder as url,
                    (select butiran from SMKB_Kump_Wang where Kod_Kump_Wang = a.kw) as colKW,
					'00' as colhidko, (select Butiran from SMKB_Operasi as ko where  ko.Kod_Operasi = '00') as colKO,
                    '0000000' as colhidkp, (select Butiran from SMKB_Projek as kp where kp.Kod_Projek = '0000000') as colKp,
                    (select Kod_Vot+' - '+ Butiran from SMKB_Vot where Kod_Vot = a.Kod_Vot) as ButiranVot
                    from SMKB_EOT_Arahan_Kerja_Hdr a 
                    inner join VPeribadi b on a.No_Staf_Peg_AK = b.ms01_Nostaf
                    inner join VPejabat c on a.Kod_PTJ = c.kodPejabat
                    inner join SMKB_EOT_Pegawai d on a.No_Arahan = d.No_Mohon inner join
                    VPeribadi e on d.No_Staf_SahB = e.ms01_nostaf 
                    inner join VPeribadi g on  d.No_Staf_LulusB = g.ms01_nostaf
                    left outer join SMKB_EOT_Dok_ArahanK f on  f.No_Mohon = a.No_Arahan
                    where a.No_Arahan = @NoArahan"


        param.Add(New SqlParameter("@NoArahan", id))

        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordEOTbyNoMohon(id As String) As String
        Dim resp As New ResponseRepository

        dt = GetRecordEOTbyNoMohon(id)
        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordEOTbyNoMohon(id As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        'Kadar_Tuntut AS DECIMAL(10, 3))
        'Dim query As String = "SELECT No_Mohon, No_Turutan, FORMAT (Tkh_Tuntut, 'dd/MM/yyyy') as Tkh_Tuntut, Jam_Mula, Jam_Tamat, Jum_Jam_Tuntut, Kadar_Tuntut, Amaun_Tuntut
        'From'  SMKB_EOT_Mohon_Dtl where No_Mohon = @NoMohon"


        Dim query As String = "Select case when a.MonthName = 'January' then 'Januari'
	    when a.MonthName = 'February' then 'Januari'
	    when a.MonthName = 'March' then 'Mac'
	    when a.MonthName = 'April' then 'April'
	    when a.MonthName = 'May' then 'Mei'
	    when a.MonthName = 'June' then 'Jun'
	    when a.MonthName = 'July' then 'Julai'
	    when a.MonthName = 'August' then 'Ogos'
	    when a.MonthName = 'September' then 'September'
	    when a.MonthName = 'October' then 'Oktober'
	    when a.MonthName = 'November' then 'November' 
	    when a.MonthName = 'December' then 'Disember'  end  as Bulan,
        a.Tahun_Tuntut,a.No_Mohon, a.No_Turutan,a.Tkh_Tuntut, a.Jam_Mula, a.Jam_Tamat, 
        a.Jum_Jam_Tuntut, a.Kadar_Tuntut, a.Amaun_Tuntut	from
        (SELECT case when Bulan_tuntut Is null then  '-' else FORMAT(DATEFROMPARTS('2024', convert(int,Bulan_tuntut), 1), 'MMMM') end AS MonthName ,Tahun_Tuntut,
        No_Mohon, No_Turutan, Format(Tkh_Tuntut, 'dd/MM/yyyy') as Tkh_Tuntut, Jam_Mula, Jam_Tamat, 
        Jum_Jam_Tuntut, Kadar_Tuntut, Amaun_Tuntut from SMKB_EOT_Mohon_Dtl where    No_Mohon = @NoMohon) a"

        param.Add(New SqlParameter("@NoMohon", id))

        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordEOTbyNoMohonPenyelia(id As String, Tarikhtuntut As Date) As String
        Dim resp As New ResponseRepository

        If id = "" Then
            Return JsonConvert.SerializeObject(New DataTable())
        End If

        dt = GetRecordEOTbyNoMohonPenyelia(id, Tarikhtuntut)
        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
        Return JsonConvert.SerializeObject(dt)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordEOTbyNoMohonPenyelia(id As String, Tarikhtuntut As Date) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "SELECT No_Mohon, No_Turutan, FORMAT (Tkh_Tuntut, 'dd/MM/yyyy') as Tkh_Tuntut, Jam_Mula_Sah, Jam_Tamat_Sah, 
                               Jum_Jam_Sah, Kadar_Sah, Amaun_Sah,Tujuan,Catatan,No_Staf_Sah,OT_Ptj,ID,Ulasan_Sah
                               FROM  SMKB_EOT_Mohon_Dtl where No_Mohon = @NoMohon and Tkh_Tuntut =@Tkhtuntut"


        param.Add(New SqlParameter("@NoMohon", id))
        param.Add(New SqlParameter("@Tkhtuntut", Tarikhtuntut))

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordStaf() As String
        Dim resp As New ResponseRepository

        dt = GetRecordStaf()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordStaf() As DataTable
        Dim db As New DBKewConn("smsm")
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select  A.MS01_NOSTAF, A.MS01_NAMA,D.Singkatan FROM  MS01_Peribadi A INNER JOIN MS02_Perjawatan B ON A.MS01_NoStaf = B.MS01_NoStaf INNER JOIN
        MS08_Penempatan C ON B.MS01_NoStaf = C.MS01_NoStaf and c.MS08_StaTerkini = 1 INNER JOIN MS_Pejabat D 
        ON C.MS08_Pejabat = D.KodPejabat  AND A.MS01_Status =1 where b.MS02_KumpStaf = 0 and b.MS02_Kumpulan  in ('10','4','5')
		order by A.MS01_NOSTAF"
        'param.Add(New SqlParameter("@noarahan", noarahan))
        Return db.ReadDB(query)
    End Function



    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenarai(ByVal NoAk As String) As String
        Dim resp As New ResponseRepository

        dt = GetSenarai(NoAk)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetSenarai(NoAk As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "SELECT   A.No_Arahan, A.No_Staf,B.MS01_NAMA FROM SMKB_EOT_Arahan_Kerja_Dtl A inner join Vperibadi B 
        ON A.No_Staf = B.MS01_NOSTAF WHERE A.No_Arahan = @NoAk"
        param.Add(New SqlParameter("@NoAk", NoAk))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenEOTPengesahanPenyelia(ByVal NoPegSah As String) As String
        Dim resp As New ResponseRepository

        dt = GetSenEOTPengesahanPenyelia(NoPegSah)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetSenEOTPengesahanPenyelia(NoPegSah As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        'AND (a.Status_Cetak='1')
        '     Dim query As String = "select d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        '     RIGHT('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,d.AmaunTuntut  from
        '     (SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama as Nama,FORMAT (a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
        '         sum(convert(int,substring(b.jum_jam_sah,1,2)) * 60 + convert(int,substring(b.jum_jam_sah,3,2))) as Jam, 
        '         sum(b.Amaun_Sah) as AmaunTuntut 
        '         FROM SMKB_EOT_Mohon_Hdr a INNER JOIN 
        '         SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        'inner join [qa11].dbstaf.dbo.ms01_peribadi c on c.ms01_nostaf = a.no_staf
        '         WHERE (a.Status_Mohon='07') 
        'and b.No_Staf_Sah  = @NoPegSah
        '         GROUP BY b.No_Mohon, a.No_Staf,  c.ms01_nama,a.Tkh_Mohon) d
        'group by d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon,d.Jam,d.AmaunTuntut"


        Dim query As String = "Select d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,d.AmaunTuntut,d.folder, d.Filename,d.Folder as url  from
        (SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
            sum(Convert(Int, substring(b.jum_jam_sah, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_sah, 3, 2))) As Jam, 
            sum(b.Amaun_Sah) As AmaunTuntut, isnull(a.FileName,'-') as Filename, isnull(a.Folder,'-') as Folder 
            From SMKB_EOT_Mohon_Hdr a INNER Join
            SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
			inner Join VPeribadi c on c.ms01_nostaf = a.no_staf
            WHERE(a.Status_Mohon ='07') 
            And b.No_Staf_Sah = @NoPegSah
            Group BY b.No_Mohon, a.No_Staf, c.ms01_nama, a.Tkh_Mohon, a.Folder, a.FileName) d
			Group by d.No_Mohon, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam, d.AmaunTuntut, d.folder, d.Filename"

        param.Add(New SqlParameter("@NoPegSah", NoPegSah))


        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenEOTPengesahanPenyeliaDtl(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetSenEOTPengesahanPenyeliaDtl(id)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetSenEOTPengesahanPenyeliaDtl(idMohon As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)


        Dim query As String = "Select d.No_Mohon,d.Tkh_Tuntut, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
            Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jum_Jam_Sah,d.Amaun_Sah,d.Kadar_Sah,d.Tujuan,d.Catatan,
            d.No_Staf_Sah, d.OT_Ptj, d.Bulan_Tuntut, d.Tahun_Tuntut, d.No_Staf_Lulus from
            (SELECT Distinct b.No_Mohon, Format(b.Tkh_Tuntut, 'dd/MM/yyyy') as Tkh_Tuntut, 
            sum(Convert(Int, substring(b.Jum_Jam_Sah, 1, 2)) * 60 + Convert(Int, substring(b.Jum_Jam_Sah, 3, 2))) As Jam, sum(b.Kadar_Sah) As Kadar_Sah,
            sum(b.Amaun_Sah) As Amaun_Sah,b.Tujuan,b.Catatan,b.No_Staf_Sah,b.OT_Ptj,b.Bulan_Tuntut,b.Tahun_Tuntut,b.No_Staf_Lulus
            From SMKB_EOT_Mohon_Hdr a INNER Join
            SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon	
            Where (a.Status_Mohon ='07') 
            And b.No_Mohon =  @NoMohon
            Group BY b.No_Mohon, a.No_Staf,b.Tkh_tuntut,b.Tujuan,b.Catatan,b.No_Staf_Sah,b.OT_Ptj,b.Bulan_Tuntut,b.Tahun_Tuntut,b.No_Staf_Lulus) d
            Group By d.No_Mohon, d.Tkh_Tuntut, d.Jam, d.Amaun_Sah, d.Kadar_Sah, d.Tujuan, d.Catatan, d.No_Staf_Sah, d.OT_Ptj,
            d.Bulan_Tuntut, d.Tahun_Tuntut, d.No_Staf_Lulus"


        param.Add(New SqlParameter("@NoMohon", idMohon))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadGetSenEOTMohon(ByVal NoStaf As String) As String
        Dim resp As New ResponseRepository

        dt = GetSenEOTMohon(NoStaf)
        'resp.SuccessPayload(dt)

        For Each x As DataRow In dt.Rows
            If Not IsDBNull(x.Item("File_Name")) Then
                Dim urlU As String = GetBaseUrl() + Trim(x.Item("Folder")) + "/" + x.Item("File_Name")
                x.Item("url") = urlU
            End If

        Next
        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function GetSenEOTMohon(NoStaf As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "Select d.No_Mohon, d.No_Staf,d.No_Arahan,d.Tkh_Tuntut,FORMAT (f.Tkh_Mula, 'dd/MM/yyyy') as Tkh_Mula,
            Format(f.Tkh_Tamat, 'dd/MM/yyyy') as Tkh_Tamat, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,d.Amaun_Tuntut,d.Kadar_Tuntut,d.No_Staf_Lulus, d.No_Staf_Sah,d.OT_Ptj,
        (d.No_Staf_Sah +'-'+(select ms01_nama from VPeribadi where ms01_nostaf = d.No_Staf_Sah)) as Nama_Sah,
        (d.No_Staf_Lulus +'-'+(select ms01_nama from VPeribadi where ms01_nostaf = d.No_Staf_Lulus)) as Nama_Lulus ,
        f.Lokasi, f.PeneranganK, isnull(e.File_Name,'-') as File_name,isnull(e.Folder,'-') as Folder,e.Folder  as url,f.No_Surat,d.Filename  as File_NameTS  from
        (SELECT Distinct b.No_Mohon, a.No_Staf,a.No_Arahan, FORMAT(b.Tkh_Tuntut, 'dd/MM/yyyy') as Tkh_Tuntut, 
        sum(Convert(Int, substring(b.Jum_Jam_Tuntut, 1, 2)) * 60 + Convert(Int, substring(b.Jum_Jam_Tuntut, 3, 2))) As Jam, 
        sum(b.Amaun_Tuntut) As Amaun_Tuntut , sum(b.Kadar_Tuntut) As Kadar_Tuntut,b.No_Staf_Lulus, b.No_Staf_Sah,b.OT_Ptj, ISNULL(a.Filename, '-') AS Filename
        From SMKB_EOT_Mohon_Hdr a INNER Join
        SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        Where (a.Status_Mohon ='01') 
        And a.No_Staf =@NoStaf
        Group BY b.No_Mohon, a.No_Staf,a.no_arahan,b.Tkh_Tuntut,b.No_Staf_Lulus, b.No_Staf_Sah,b.OT_Ptj ,a.Filename) d
		inner  Join SMKB_EOT_Dok_ArahanK e on  e.No_Mohon = d.No_Arahan
        inner Join SMKB_EOT_Arahan_Kerja_Hdr f on f.No_Arahan = d.No_Arahan
        Group by d.No_Mohon, d.No_Staf, d.No_Arahan, f.Tkh_Mula, f.Tkh_Tamat, d.Tkh_Tuntut, d.Jam, d.Amaun_Tuntut, d.Kadar_Tuntut,
        d.No_Staf_Lulus, d.No_Staf_Sah, d.OT_Ptj, f.Lokasi, f.PeneranganK, e.File_Name, e.Folder, f.No_Surat, d.Filename order by d.No_Mohon desc"


        param.Add(New SqlParameter("@NoStaf", NoStaf))


        Return db.Read(query, param)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenEOTSokongKJ(ByVal NoPegSah As String) As String
        Dim resp As New ResponseRepository

        dt = GetLoadSenEOTSokongKJ(NoPegSah)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetLoadSenEOTSokongKJ(NoPegSah As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        'Dim query As String = "Select d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        '    Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,d.AmaunTuntut,d.OT_Ptj,d.Pejabat,d.Tkh_Sah from(
        '    SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
        '    sum(Convert(Int, substring(b.jum_jam_sah, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_sah, 3, 2))) As Jam, 
        '    sum(b.Amaun_Sah) As AmaunTuntut,a.OT_Ptj,(a.OT_Ptj + '-'+ e.Pejabat) as Pejabat,Format(b.Tkh_Sah, 'dd/MM/yyyy') as Tkh_Sah
        '    From SMKB_EOT_Mohon_Hdr a INNER Join
        '    SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        '    inner Join [qa11].dbstaf.dbo.ms01_peribadi c on c.ms01_nostaf = a.no_staf
        '    inner Join  [qa11].dbstaf.dbo.ms_pejabat e on e.KodPejPBU = a.OT_Ptj
        '    WHERE(b.Status_Sah ='S') AND (b.Status_Lulus ='BL')
        '    And (a.Status_Mohon ='02' OR a.Status_Mohon='03')
        '    And b.No_Staf_Sah =  @NoPegSah
        '    Group BY b.No_Mohon, a.No_Staf, c.ms01_nama, a.Tkh_Mohon, a.OT_Ptj, e.pejabat, a.Gaji, b.Tkh_Sah) d
        '    Group by d.No_Mohon, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam, d.AmaunTuntut, d.OT_Ptj, d.Pejabat, d.Tkh_Sah"



        Dim query As String = "Select d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam_Sah) / 60 AS VARCHAR(2)), 2) + ':' +
            Right('00' + CAST(SUM(d.Jam_Sah) % 60 AS VARCHAR(2)), 2) AS Jam_Sah,d.AmaunSah,d.OT_Ptj,d.Pejabat,d.Tkh_Sah,d.File_name,d.Folder from(
            SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
            sum(Convert(Int, substring(b.jum_jam_sah, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_sah, 3, 2))) As Jam_Sah, 
            sum(b.Amaun_Sah) As AmaunSah,a.OT_Ptj,(a.OT_Ptj + '-'+ e.Pejabat) as Pejabat,Format(b.Tkh_Sah, 'dd/MM/yyyy') as Tkh_Sah,
			isnull(a.Filename,'-') as File_name,isnull(a.Folder,'-') as Folder,a.Folder  as url
            From SMKB_EOT_Mohon_Hdr a INNER Join
            SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
            inner Join VPeribadi c on c.ms01_nostaf = a.no_staf
            inner Join VPejabat e on e.KodPejPBU = a.OT_Ptj
            WHERE(b.Status_Sah ='S') AND (b.Status_Lulus ='BL')
            And (a.Status_Mohon ='02' OR a.Status_Mohon='03')
            And b.No_Staf_Sah =  @NoPegSah
            Group BY b.No_Mohon, a.No_Staf, c.ms01_nama, a.Tkh_Mohon, a.OT_Ptj, e.pejabat, a.Gaji, b.Tkh_Sah, a.Filename, a.Folder) d
            Group by d.No_Mohon, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam_Sah, d.AmaunSah, d.OT_Ptj, d.Pejabat, d.Tkh_Sah, d.File_name, d.Folder"

        param.Add(New SqlParameter("@NoPegSah", Session("ssusrID")))


        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJadual() As String
        Dim resp As New ResponseRepository

        dt = GetJadual()
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetJadual() As DataTable
        Dim db = New DBKewConn
        Dim id = "14101"
        Dim query As String = "SELECT Butiran,Kadar FROM SMKB_Gaji_OT WHERE Vot_TETAP = @Vottetap"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Vottetap", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListingOT(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataOT(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetDataOT(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT DISTINCT 'Lulus' as statLulus,  Tkh_Tuntut,
        a.Jam_Mula_Lulus as Jam_Mula_Lulus ,a.Jam_Tamat_Lulus as Jam_Tamat_Lulus ,a.Jum_Jam_Lulus as Jum_Jam_Lulus,
        a.Kadar_Lulus as Kadar_Lulus,a.No_Mohon,
        a.Amaun_Lulus as Amaun_Lulus,a.OT_Ptj as OT_Ptj,a.Ulasan_Lulus as Ulasan_Lulus,No_Turutan,ID
        FROM SMKB_EOT_Mohon_Dtl a INNER JOIN SMKB_EOT_Mohon_Hdr b on a.No_Mohon =  b.No_Mohon
        AND (a.No_Mohon=@No_Permohonan) AND (a.Status_Sah='S' and a.Status_lulus='BL')"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Permohonan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListingTerima(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataTerima(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetDataTerima(id As String) As DataTable
        Dim db = New DBKewConn
        'Format(a.Tkh_Tuntut, 'dd/MM/yyyy') as
        Dim query As String = "SELECT DISTINCT 'Terima' as statTerima, Tkh_Tuntut,
        a.Jam_Mula_Terima as Jam_Mula_Terima ,a.Jam_Tamat_Terima as Jam_Tamat_Terima ,a.Jum_Jam_Terima as Jum_Jam_Terima,
        a.Kadar_Terima as Kadar_Terima,a.No_Mohon,
        a.Amaun_Terima as Amaun_Terima,a.OT_Ptj as OT_Ptj,a.Ulasan_Terima as Ulasan_Terima,No_Turutan,ID
        FROM SMKB_EOT_Mohon_Dtl a INNER JOIN SMKB_EOT_Mohon_Hdr b on a.No_Mohon =  b.No_Mohon
        AND (a.No_Mohon=@No_Permohonan) AND (a.Status_lulus='L' and a.Status_Terima='BT') order by Tkh_Tuntut, No_Turutan"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Permohonan", id))

        Return db.Read(query, param)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenEOTLulusKJ(ByVal NoPegSah As String) As String
        Dim resp As New ResponseRepository

        dt = GetLoadSenEOTLulusKJ(NoPegSah)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetLoadSenEOTLulusKJ(NoPegSah As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        '     Dim query As String = "SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama as Nama,FORMAT (a.Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Mohon, 
        '         sum(convert(int,substring(b.jum_jam_sah,1,2)) * 60 + convert(int,substring(b.jum_jam_sah,3,2))) as Jam, 
        '         sum(b.Amaun_Sah) as AmaunTuntut 
        '         FROM SMKB_EOT_Mohon_Hdr a INNER JOIN 
        '         SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        'inner join [qa11].dbstaf.dbo.ms01_peribadi c on c.ms01_nostaf = a.no_staf
        '         WHERE  (b.Status_Terima ='BT')
        'and (a.Status_Mohon='03')
        'and b.No_Staf_Sah = @NoPegSah
        '         GROUP BY b.No_Mohon, a.No_Staf,  c.ms01_nama,a.Tkh_Mohon"






        Dim query As String = "Select d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam_Lulus) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam_Lulus) % 60 AS VARCHAR(2)), 2) AS Jam_Lulus,d.AmaunLulus,d.Tkh_Sah,d.Tkh_Lulus  from(
        SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
        sum(Convert(Int, substring(b.jum_jam_lulus, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_lulus, 3, 2))) As Jam_Lulus, 
        sum(b.Amaun_Lulus) As AmaunLulus,Format(b.Tkh_Sah, 'dd/MM/yyyy') as Tkh_Sah,Format(b.Tkh_Lulus, 'dd/MM/yyyy') as Tkh_Lulus
        From SMKB_EOT_Mohon_Hdr a INNER Join
        SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        inner Join VPeribadi c on c.ms01_nostaf = a.no_staf
        WHERE(b.Status_Terima ='BT')
        And (a.Status_Mohon ='03')
        And b.No_Staf_Sah = @NoPegSah
        Group BY b.No_Mohon, a.No_Staf, c.ms01_nama, a.Tkh_Mohon, b.Tkh_Sah, b.Tkh_Lulus) d
        Group by d.No_Mohon, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam_Lulus, d.AmaunLulus, d.Tkh_Sah, d.Tkh_Lulus"



        param.Add(New SqlParameter("@NoPegSah", Session("ssusrID")))


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenEOTBelumSahTerima() As String
        Dim resp As New ResponseRepository

        dt = GetLoadSenEOTBelumSahTerima()
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetLoadSenEOTBelumSahTerima() As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)


        Dim query As String = "Select d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam_Lulus) / 60 AS VARCHAR(2)), 2) + ':' +
            Right('00' + CAST(SUM(d.Jam_Lulus) % 60 AS VARCHAR(2)), 2) AS Jam_Lulus,d.AmaunLulus,d.OT_Ptj,d.Pejabat,d.Tkh_Sah,d.Tkh_Lulus,d.File_name,d.Folder from(
            SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
            sum(Convert(Int, substring(b.jum_jam_lulus, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_lulus, 3, 2))) As Jam_Lulus, 
            sum(b.Amaun_Lulus) As AmaunLulus,a.OT_Ptj,(a.OT_Ptj + '-'+ e.Pejabat) as Pejabat,Format(b.Tkh_Sah, 'dd/MM/yyyy') as Tkh_Sah,
			Format(b.Tkh_Lulus, 'dd/MM/yyyy') as Tkh_Lulus,isnull(a.Filename,'-') as File_name,isnull(a.Folder,'-') as Folder,a.Folder  as url
            From SMKB_EOT_Mohon_Hdr a INNER Join
            SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
            inner Join VPeribadi c on c.ms01_nostaf = a.no_staf
            inner Join VPejabat e on e.KodPejPBU = a.OT_Ptj
            WHERE (b.Status_Terima ='BT') AND (b.Status_Lulus ='L')
            And (a.Status_Mohon ='03' OR a.Status_Mohon='04')
            Group BY b.No_Mohon, a.No_Staf, c.ms01_nama, a.Tkh_Mohon, a.OT_Ptj, e.pejabat, a.Gaji, b.Tkh_Sah,b.Tkh_Lulus,a.Filename,a.Folder) d
            Group by d.No_Mohon, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam_Lulus, d.AmaunLulus, d.OT_Ptj, d.Pejabat, d.Tkh_Sah,d.Tkh_Lulus,d.File_name,d.Folder"



        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenEOTSahTerima() As String
        Dim resp As New ResponseRepository

        dt = GetLoadSenEOTSahTerima()
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetLoadSenEOTSahTerima() As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        '     Dim query As String = "SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama as Nama,FORMAT (a.Tkh_Mohon, 'yyyy-MM-dd') as Tkh_Mohon, 
        '         sum(convert(int,substring(b.jum_jam_sah,1,2)) * 60 + convert(int,substring(b.jum_jam_sah,3,2))) as Jam, 
        '         sum(b.Amaun_Sah) as AmaunTuntut 
        '         FROM SMKB_EOT_Mohon_Hdr a INNER JOIN 
        '         SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        'inner join [qa11].dbstaf.dbo.ms01_peribadi c on c.ms01_nostaf = a.no_staf
        '         WHERE  (b.Status_Terima ='TT') AND (b.Status_Lulus ='T')
        '         AND Status_Mohon in ('04')				
        '         GROUP BY b.No_Mohon, a.No_Staf,  c.ms01_nama,a.Tkh_Mohon"



        Dim query As String = "Select d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
            Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,d.AmaunTuntut,d.Tkh_Sah,d.Tkh_Lulus ,d.Tkh_Terima from(
            SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
            sum(Convert(Int, substring(b.jum_jam_sah, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_sah, 3, 2))) As Jam, 
            sum(b.Amaun_Sah) As AmaunTuntut,Format(b.Tkh_Sah, 'dd/MM/yyyy') as Tkh_Sah,Format(b.Tkh_Lulus, 'dd/MM/yyyy') as Tkh_Lulus,
            Format(b.Tkh_Terima, 'dd/MM/yyyy') as Tkh_Terima
            From SMKB_EOT_Mohon_Hdr a INNER Join
            SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
            inner Join VPeribadi c on c.ms01_nostaf = a.no_staf
            WHERE (b.Status_Terima ='TT') AND (b.Status_Lulus ='T')
            And Status_Mohon in ('04')				
            Group BY b.No_Mohon, a.No_Staf, c.ms01_nama, a.Tkh_Mohon,b.Tkh_Sah,b.Tkh_Lulus,b.Tkh_Terima) d
            Group by d.No_Mohon, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam, d.AmaunTuntut,d.Tkh_Sah,d.Tkh_Lulus,d.Tkh_Terima"

        'param.Add(New SqlParameter("@NoPegSah", NoPegSah))


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenEOTHantaCetak(ByVal NoStaf As String) As String
        Dim resp As New ResponseRepository

        dt = GetSenEOTHantarCetak(NoStaf)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetSenEOTHantarCetak(NoStaf As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)


        Dim query As String = "Select d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,d.AmaunTuntut,d.No_Staf_Sah,d.Namapengesah  from(
        Select b.No_Mohon, a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
        sum(Convert(Int, substring(b.jum_jam_sah, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_sah, 3, 2))) As Jam, 
        sum(b.Amaun_Sah) As AmaunTuntut,b.No_Staf_Sah,e.ms01_nama as Namapengesah
        From SMKB_EOT_Mohon_Hdr a INNER Join
        SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        inner Join VPeribadi c on c.ms01_nostaf = a.no_staf
		inner join VPeribadi e on e.ms01_nostaf = b.No_Staf_Sah
        WHERE (a.Status_Mohon='01')
        And a.No_Staf = @NoStaf
        Group BY b.No_Mohon, a.No_Staf, c.ms01_nama, a.Tkh_Mohon,b.No_Staf_Sah,e.ms01_nama ) d
        Group by d.No_Mohon, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam, d.AmaunTuntut,d.AmaunTuntut,d.No_Staf_Sah,d.Namapengesah order by d.Tkh_Mohon desc"

        param.Add(New SqlParameter("@NoStaf", NoStaf))


        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenBatalEOT(ByVal NoStaf As String) As String
        Dim resp As New ResponseRepository

        dt = GetSenSenBatalEOT(NoStaf)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetSenSenBatalEOT(NoStaf As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "Select  d.No_Mohon, d.No_Staf, d.Nama,d.Tkh_Mohon, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,d.AmaunTuntut  from(
        SELECT Distinct b.No_Mohon, a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
        sum(Convert(Int, substring(b.jum_jam_sah, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_sah, 3, 2))) As Jam, 
        sum(b.Amaun_Sah) As AmaunTuntut 
        From SMKB_EOT_Mohon_Hdr a INNER Join
        SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        inner Join VPeribadi c on c.ms01_nostaf = a.no_staf
        WHERE(a.Status_Mohon ='01')			
        And a.No_Staf =  @NoStaf
        Group BY b.No_Mohon, a.No_Staf, c.ms01_nama, a.Tkh_Mohon) d
        Group by d.No_Mohon, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam, d.AmaunTuntut"

        param.Add(New SqlParameter("@NoStaf", NoStaf))


        Return db.Read(query, param)
    End Function
    Private Function GetOrder(kod As String) As DataTable
        Dim db = New db

        Dim query As String = "SELECT A.order_id, B.id, b.order_id, b.ddlVot,  
        C.details as detailvot, b.details, b.quantity, b.price, b.amount 
        FROM orders A
        INNER JOIN orderDetails B
	        ON A.order_id = B.order_id 
        INNER JOIN vot C 
	        on B.ddlvot = C.ddlvot"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "  WHERE A.order_id = @ord "
            param.Add(New SqlParameter("@ord", kod))
        End If

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getKJ(ptj As String) As String
        Dim db1 As New DBKewConn("smsm")

        dt = GetRecordKJ(ptj)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)

    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanEOT(MohonEOT As MohonEOT, q As String) As String
        Dim resp As New ResponseRepository
        ' resp.Success("Rekod telah disimpan")
        Dim success As Integer = 0
        Dim X As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim sqlComm As New SqlCommand
        Dim kodPTJ As String
        Dim amaun As Decimal
        Dim kadar As Decimal
        'sqlquery = New Query
        Dim db As New DBKewConn

        amaun = MohonEOT.Amaun
        kadar = MohonEOT.Kadar
        kodPTJ = MohonEOT.OT_Ptj.ToString.PadRight(6, "0")

        If MohonEOT Is Nothing Then
            resp.Failed("Rekod Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        MohonEOT.No_Mohon = q
        MohonEOT.Folder = "UPLOAD/EOT/"

        Dim Tujuan As String = MohonEOT.Tujuan
        Dim Catatan As String = MohonEOT.Catatan
        Dim No_Staf_Sah As String = MohonEOT.No_Staf_Sah

        Dim No_Staf_Lulus As String = MohonEOT.No_Staf_Lulus
        Dim No_Mohon As String = MohonEOT.No_Mohon
        Dim Tarikh As Date = MohonEOT.Tkh_Tuntut
        Dim Nostaf As String = Session("ssusrID")

        If SemakHariBercuti(Nostaf, MohonEOT.Tkh_Tuntut) <> "OK" Then
            success = 0
            resp.Failed("Anda bercuti. Permohonan Tuntutan Kerla Lebih Masa  Tidak Dibenarkan")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If SemakWaktuAnjal(Nostaf, MohonEOT.Tkh_Tuntut, MohonEOT.Jam_Mula, MohonEOT.Jam_Tamat) <> "OK" Then
            success = 0
            resp.Failed("Permohonan Tuntutan Kerja Lebih Masa Tidak Dibenarkan . Sila Semak Kategori(Waktu Anjal) Kehadiran.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If q = "" Then

            'SEMAK DATA TELAH WUJUD BERSTATUS BERSTATUS LULUS ATAU SAH
            If SemakNoMohonLulus(Nostaf, Tarikh) > 0 Then
                success = 0
                resp.Failed("Permohonan Tuntutan Kerla Lebih Masa Pada Tarikh Tersebut Telah Wujud")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function

            End If

            'SEMAK AMAUN DAN KADAR
            If SemakAmaunEOT(MohonEOT.No_Mohon, MohonEOT.Amaun, MohonEOT.Kadar) <> "OK" Then
                success = 0
                resp.Failed("Semak Jumlah amaun dan kadar tidak melebihi gaji dan kadar yang telah ditetap")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            End If

            MohonEOT.No_Mohon = GenerateEOTIDMohon()

            If InsertEOTHdr(MohonEOT.No_Arahan, MohonEOT.No_Mohon, dtTkhToday2, kodPTJ, MohonEOT.File_Name, MohonEOT.Folder) <> "OK" Then
                success = 0
                resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa (Header)")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            Else

                sqlcon = New SqlConnection(strConn)
                Using (sqlcon)



                    sqlComm.Connection = sqlcon

                    sqlComm.CommandText = "USP_SIMPANAMTEOT_VER1"
                    sqlComm.CommandType = CommandType.StoredProcedure

                    sqlComm.Parameters.AddWithValue("nomohon", MohonEOT.No_Mohon)
                    sqlComm.Parameters.AddWithValue("nostaf", Session("ssusrID"))
                    sqlComm.Parameters.AddWithValue("tarikh", MohonEOT.Tkh_Tuntut)
                    sqlComm.Parameters.AddWithValue("jam_mula", MohonEOT.Jam_Mula)
                    sqlComm.Parameters.AddWithValue("jam_tamat", MohonEOT.Jam_Tamat)
                    sqlComm.Parameters.AddWithValue("l_success", 0)

                    sqlcon.Open()
                    X = sqlComm.ExecuteNonQuery()
                    If X > 0 Then


                        'Dim myList As New List(Of (Tujuan As String, Test As String))()
                        'Dim datalist As New List(Of (Tujuan As String, Catatan As String, No_Staf_Sah As String, kodPTJ As String, No_Staf_Lulus As String, No_Mohon As String, Tarikh As Date))()

                        'If UpdateMultipleEOTDtl(datalist) <> "OK" Then

                        If UpdateEOTDtl(MohonEOT.Tujuan, MohonEOT.Catatan, MohonEOT.No_Staf_Sah, kodPTJ, MohonEOT.No_Staf_Lulus, MohonEOT.No_Mohon, MohonEOT.Tkh_Tuntut, MohonEOT.Bulan, MohonEOT.Tahun) <> "OK" Then
                            'sqlquery.rollback()

                            'db.sConnRollbackTrans()
                            resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa (Detail)")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            Exit Function
                        Else
                            success = 1
                        End If
                    Else
                        'sqlquery.rollback()
                        db.sConnRollbackTrans()
                        resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa Detail SP")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                        Exit Function
                    End If

                End Using

            End If
        Else 'NO MOHON DA WUJUD
            ' If SemakEOTDtl(MohonEOT.No_Mohon, MohonEOT.Tkh_Tuntut) > 0 Then
            '.Failed("Transaksi Rekod EOT Telah Wujud. ")
            'rn JsonConvert.SerializeObject(resp.GetResult())
            'Exit Function
            'Else
            'SEMAK MASA EXISTS DI TABLE 

            If SemakJamMulaTamat(MohonEOT.No_Mohon, MohonEOT.Tkh_Tuntut, MohonEOT.Jam_Mula, MohonEOT.Jam_Tamat) <> "OK" Then

                resp.Failed("Rekod Telah Wujud.")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            Else
                sqlcon = New SqlConnection(strConn)
                Using (sqlcon)

                    sqlComm.Connection = sqlcon

                    sqlComm.CommandText = "USP_SIMPANAMTEOT_VER1"
                    sqlComm.CommandType = CommandType.StoredProcedure

                    sqlComm.Parameters.AddWithValue("nomohon", MohonEOT.No_Mohon)
                    sqlComm.Parameters.AddWithValue("nostaf", Session("ssusrID"))
                    sqlComm.Parameters.AddWithValue("tarikh", MohonEOT.Tkh_Tuntut)
                    sqlComm.Parameters.AddWithValue("jam_mula", MohonEOT.Jam_Mula)
                    sqlComm.Parameters.AddWithValue("jam_tamat", MohonEOT.Jam_Tamat)
                    sqlComm.Parameters.AddWithValue("l_success", 0)

                    sqlcon.Open()
                    X = sqlComm.ExecuteNonQuery()
                    If X > 0 Then

                        If UpdateEOTDtl(MohonEOT.Tujuan, MohonEOT.Catatan, MohonEOT.No_Staf_Sah, kodPTJ, MohonEOT.No_Staf_Lulus, MohonEOT.No_Mohon, MohonEOT.Tkh_Tuntut, MohonEOT.Bulan, MohonEOT.Tahun) <> "OK" Then
                            'sqlquery.rollback()
                            db.sConnRollbackTrans()
                            resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa Detail")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            Exit Function
                        Else
                            success = 1
                        End If
                    Else
                        'sqlquery.rollback()
                        db.sConnRollbackTrans()
                        resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                        Exit Function
                    End If

                End Using


            End If
        End If
            'End If
            If success = 1 Then
            'sqlquery.finish()
            db.sConnCommitTrans()
            resp.Success("Rekod berjaya disimpan", "00", MohonEOT)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            'sqlquery.rollback()
            db.sConnRollbackTrans()
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function SemakHariBercuti(No_Staf As String, TkhTuntut As Date) As String
        Dim StrCuti As String

        Dim db As New DBSMConn
        Dim query As String = "SELECT * FROM MS26_CutiStaf WHERE MS01_NoStaf = @No_Staf
                                AND MS26_StatusCuti not in ('Tidak Lulus','Tidak Sokong','Pembetulan','Batal') 
                                And  @TkhTuntut BETWEEN MS26_TkhMula and  MS26_TkhTamat"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Staf", No_Staf))
        param.Add(New SqlParameter("@TkhTuntut", TkhTuntut))
        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            StrCuti = "XOK"
        Else
            StrCuti = "OK"
        End If

        Return StrCuti

    End Function

    Private Function SemakWaktuAnjal(No_Staf As String, TkhTuntut As Date, Jam_Mula As String, Jam_Tamat As String) As String
        Dim StrCuti As String
        Dim StrJenhdr As String
        Dim StrMsMasukXFlexi As String
        Dim StrMsKeluarXFlexi As String
        Dim StrBaca As Integer

        Dim db As New DBSMConn

        'StrBaca = 0 tidak memenuhi, 1 memenuhi

        Dim query As String = "select  ms21_JenHdr  from MS21_PerakamWaktu  where  ms21_nostaf = @No_Staf"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Staf", No_Staf))
        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            StrJenhdr = dt.Rows(0).Item("ms21_JenHdr")

        Else
            StrJenhdr = ""

        End If

        If StrJenhdr = "06" Or StrJenhdr = "15" Or StrJenhdr = "16" Then
            'DAPATKAN MASA MULA DAN MASA TAMAT KEHADIRAN
            Dim query1 As String = "SELECT PW03_MsMasuk,PW03_MsKeluar FROM pw03_masaanjal WHERE MS21_NoStaf = @No_Staf and  @TkhTuntut BETWEEN pw03_tkhmasuk AND pw03_tkhkeluar  And pw03_catatan not Like '%OFF%'"
            Dim param1 As New List(Of SqlParameter)
            param1.Add(New SqlParameter("@No_Staf", No_Staf))
            param1.Add(New SqlParameter("@TkhTuntut", TkhTuntut))

            dt = db.Read(query1, param1)
            If dt.Rows.Count > 0 Then
                StrMsMasukXFlexi = dt.Rows(0).Item("PW03_MsMasuk")
                StrMsKeluarXFlexi = dt.Rows(0).Item("PW03_MsKeluar")

                'If Jam_Mula > StrMsMasukXFlexi Or Jam_Tamat < StrMsKeluarXFlexi Then
                If (Jam_Mula < StrMsMasukXFlexi And Jam_Tamat > StrMsMasukXFlexi) Or
                    (Jam_Mula >= StrMsMasukXFlexi And Jam_Tamat <= StrMsKeluarXFlexi) Or
                    (Jam_Mula <= StrMsMasukXFlexi And Jam_Tamat >= StrMsKeluarXFlexi) Then
                    StrBaca = 0
                Else
                    StrBaca = 1
                End If
            Else
                StrBaca = 0
            End If
        ElseIf StrJenhdr = "08" Then
            If SemakHariCutiUmum(TkhTuntut) = "OK" Then

                'PERMOHONAN MASUK PEJABAT PUKUL 09:00
                If (Jam_Mula < "0900" And Jam_Tamat > "0900") Or
                    (Jam_Mula >= "0900" And Jam_Tamat <= "1700") Or
                    (Jam_Mula <= "0900" And Jam_Tamat >= "1700") Then
                    StrBaca = 0
                Else
                    StrBaca = 1
                End If
            Else
                StrBaca = 1
            End If
        Else  'FLEKSI BIASA 8 JAM BEKERJA
            If SemakHariCutiUmum(TkhTuntut) = "OK" Then
                If (Jam_Mula < "0830" And Jam_Tamat > "0830") Or
                    (Jam_Mula >= "0830" And Jam_Tamat <= "1630") Or
                    (Jam_Mula <= "0830" And Jam_Tamat >= "1630") Then


                    StrBaca = 0
                Else
                    StrBaca = 1
                End If
            Else
                StrBaca = 1
            End If

        End If
            If StrJenhdr = "" Or StrBaca = 0 Then
            StrCuti = "XOK"
        Else
            StrCuti = "OK"
        End If

        Return StrCuti

    End Function

    Private Function SemakHariCutiUmum(TkhTuntut As Date) As String
        'SEMAK KALENDAR SMSM
        Dim StrSemak As String = "OK"
        Dim db As New DBSMConn
        Dim query As String = "SELECT PW09_Tarikh FROM PW09_Kalendar WHERE (PW09_Tarikh =@TkhTuntut)"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@TkhTuntut", TkhTuntut))
        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            StrSemak = "XOK"
        Else
            StrSemak = "OK"
        End If

        Return StrSemak
    End Function
    Private Function SemakJamMulaTamat(NoMohon As String, TkhTuntut As Date, JamMula As String, JamTamat As String) As String


        Dim StrBaca As String

        Dim db As New DBKewConn

        If NoMohon <> "" Then
            Dim query As String = $"Select * From SMKB_EOT_Mohon_Dtl Where   No_Mohon = @No_Mohon
            And Day(Tkh_Tuntut) = day(@TkhTuntut)
            And Month(Tkh_Tuntut) =Month(@TkhTuntut) and 
            Year(Tkh_Tuntut) =year(@TkhTuntut)
            And Jam_Mula >= @JamMula  and Jam_Tamat <= @JamTamat"
            Dim param As New List(Of SqlParameter)
            param.Add(New SqlParameter("@No_Mohon", NoMohon))
            param.Add(New SqlParameter("@TkhTuntut", TkhTuntut))
            param.Add(New SqlParameter("@JamMula", JamMula))
            param.Add(New SqlParameter("@JamTamat", JamTamat))
            dt = db.Read(query, param)

            If dt.Rows.Count > 0 Then
                StrBaca = "XOK"
            Else
                StrBaca = "OK"
            End If

            Return StrBaca

        End If



    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanEOTPenyelia(MohonEOT As MohonEOT, q As String) As String
        Dim resp As New ResponseRepository
        resp.Success("Rekod telah disimpan")
        Dim success As Integer = 0
        Dim X As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim sqlComm As New SqlCommand

        Dim No_Staf_Sah As String

        'Dim test = Mohon_EOT.ID

        No_Staf_Sah = Session("ssusrID")
        'kodPTJ = MohonEOT.OT_Ptj.ToString.PadRight(6, "0")

        If MohonEOT Is Nothing Then
            resp.Failed("Rekod Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        MohonEOT.No_Mohon = q
        'SEMAK AMAUN DAN KADAR
        If SemakAmaunEOT(MohonEOT.No_Mohon, MohonEOT.Amaun, MohonEOT.Kadar) <> "OK" Then
            resp.Failed("Semak Jumlah amaun dan kadar tidak melebihi gaji dan kadar yang telah ditetap")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If q <> "" Then
            If UpdateEOTPenyelia(MohonEOT.ID, MohonEOT.No_Mohon, MohonEOT.Amaun, MohonEOT.Kadar, MohonEOT.Jum_Jam, MohonEOT.Jam_Mula, MohonEOT.Jam_Tamat, MohonEOT.Ulasan, No_Staf_Sah) <> "OK" Then
                resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa Detail")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            Else
                success = 1
            End If
        Else
            resp.Failed("Gagal Menyimpan Tuntutan Kerja Lebih Masa")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If



        'End If
        If success = 1 Then

            resp.Success("Rekod berjaya disimpan", "00", MohonEOT)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function UpdateEOTPenyelia(ID As Long, No_Mohon As String, Amaun As Decimal, Kadar As Decimal, Jum_Jam As String, Jam_Mula As String, Jam_Tamat As String, Catatan As String, No_Staf_Sah As String)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)


        Dim query As String = "UPDATE SMKB_EOT_Mohon_Dtl Set Jam_Mula_Sah = @Jam_Mula_Sah, Jam_Tamat_Sah = @Jam_Tamat_Sah, 
        Ulasan_Sah=@Ulasan_Sah,No_Staf_Lulus = @No_Staf_Lulus, Kadar_Sah = @Kadar_Sah,Amaun_Sah=@Amaun_Sah, Jam_Mula_Lulus = @Jam_Mula_Lulus,
        Jam_Tamat_Lulus = @Jam_Tamat_Lulus,Jum_Jam_Sah = @Jum_Jam_Sah,Kadar_Lulus = @Kadar_Lulus,Jum_Jam_Lulus = @Jum_Jam_Lulus,Amaun_Lulus = @Amaun_Lulus,
        Jam_Mula_Terima = @Jam_Mula_Terima, Jam_Tamat_Terima = @Jam_Tamat_Terima,Jum_Jam_Terima = @Jum_Jam_Terima,
        Kadar_Terima = @Kadar_Terima, Amaun_Terima = @Amaun_Terima
        WHERE No_Mohon = @No_Mohon and ID = @ID"

        'For Each updateData As UpdateData In updates
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Jam_Mula_Sah", Jam_Mula))
        param.Add(New SqlParameter("@Jam_Tamat_Sah", Jam_Tamat))
        param.Add(New SqlParameter("@Ulasan_Sah", Catatan))
        param.Add(New SqlParameter("@No_Staf_Lulus", No_Staf_Sah))
        param.Add(New SqlParameter("@Kadar_Sah", Kadar))
        param.Add(New SqlParameter("@Amaun_Sah", Amaun))
        param.Add(New SqlParameter("@Jam_Mula_Lulus", Jam_Mula))
        param.Add(New SqlParameter("@Jam_Tamat_Lulus", Jam_Tamat))
        param.Add(New SqlParameter("@Jum_Jam_Sah", Jum_Jam))
        param.Add(New SqlParameter("@Amaun_Lulus", Amaun))
        param.Add(New SqlParameter("@Kadar_Lulus", Kadar))
        param.Add(New SqlParameter("@Jum_Jam_Lulus", Jam_Mula))
        param.Add(New SqlParameter("@Jam_Mula_Terima", Jam_Tamat))
        param.Add(New SqlParameter("@Jam_Tamat_Terima", Jam_Tamat))
        param.Add(New SqlParameter("@Jum_Jam_Terima", Jum_Jam))
        param.Add(New SqlParameter("@Kadar_Terima", Kadar))
        param.Add(New SqlParameter("@Amaun_Terima", Amaun))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@ID", ID))

        Return db.Process(query, param)

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function UpdateEOTPenyeliaSah(Tujuan As String, Catatan As String, No_Staf_Sah As String, OT_Ptj As String, No_Staf_Lulus As String, No_Mohon As String, tarikh As Date, BulanT As String, TahunT As String, Ulasan As String)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        If Ulasan = "" Or IsDBNull(Ulasan) Then
            Ulasan = "-"
        End If


        Dim query As String = "UPDATE SMKB_EOT_Mohon_Dtl Set Tujuan = @Tujuan, Catatan=@Catatan,No_Staf_Sah = @No_Staf_Sah, 
        OT_Ptj = @OT_Ptj,No_Staf_Lulus = @No_Staf_Lulus, Bulan_Tuntut = @BTuntut, Tahun_Tuntut = @TTuntut ,Status_Cetak = @stacetak,Ulasan_Sah=@Ulasan WHERE No_Mohon = @No_Mohon and Tkh_Tuntut = @tarikh"

        'For Each updateData As UpdateData In updates
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Tujuan", Tujuan))
        param.Add(New SqlParameter("@Catatan", Catatan))
        param.Add(New SqlParameter("@No_Staf_Sah", No_Staf_Sah))
        param.Add(New SqlParameter("@OT_Ptj", OT_Ptj))
        param.Add(New SqlParameter("@No_Staf_Lulus", No_Staf_Lulus))
        param.Add(New SqlParameter("@BTuntut", BulanT))
        param.Add(New SqlParameter("@TTuntut", TahunT))
        param.Add(New SqlParameter("@stacetak", 1))
        param.Add(New SqlParameter("@Ulasan", Ulasan))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@tarikh", tarikh))

        Return db.Process(query, param)

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function UpdateEOTDtlPenyelia(Tujuan As String, Catatan As String, No_Staf_Sah As String, OT_Ptj As String, No_Staf_Lulus As String, No_Mohon As String, tarikh As Date, BulanT As String, TahunT As String, Ulasan As String)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim strBulTuntut As DateTime = tarikh.ToString("MM")
        Dim strTahunTuntut As DateTime = tarikh.ToString("YYYY")
        If Ulasan = "" Or IsDBNull(Ulasan) Then
            Ulasan = "-"
        End If

        Dim query As String = "UPDATE SMKB_EOT_Mohon_Dtl Set Tujuan = @Tujuan, Catatan=@Catatan,No_Staf_Sah = @No_Staf_Sah, 
        OT_Ptj = @OT_Ptj,No_Staf_Lulus = @No_Staf_Lulus, Bulan_Tuntut = @BTuntut, Tahun_Tuntut = @TTuntut ,Status_Cetak = @stacetak,
        Ulasan_Sah=@Ulasan WHERE No_Mohon = @No_Mohon and YEAR(Tkh_Tuntut) = @YTUNTUT"

        'For Each updateData As UpdateData In updates
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Tujuan", Tujuan))
        param.Add(New SqlParameter("@Catatan", Catatan))
        param.Add(New SqlParameter("@No_Staf_Sah", No_Staf_Sah))
        param.Add(New SqlParameter("@OT_Ptj", OT_Ptj))
        param.Add(New SqlParameter("@No_Staf_Lulus", No_Staf_Lulus))
        param.Add(New SqlParameter("@BTuntut", BulanT))
        param.Add(New SqlParameter("@TTuntut", TahunT))
        param.Add(New SqlParameter("@stacetak", 1))
        param.Add(New SqlParameter("@Ulasan", Ulasan))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@tarikh", tarikh))

        Return db.Process(query, param)

    End Function
    Public Function SemakAmaunEOT(nomohon As String, jumamaun As Decimal, jumkadar As Decimal) As String
        Dim strGajiS As Double
        Dim strNoTel As String
        Dim JumAmAll As Double
        Dim JumJamAll As Double
        Dim SucBaca As String

        Dim db As New DBKewConn

        Dim Jumkadarseb As Double
        Jumkadarseb = CInt((Mid(jumkadar, 1, 2)) * 60 + CInt(Mid(jumkadar, 3, 2)))

        Using dtUserInfo = fGetUserInfo(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                strGajiS = dtUserInfo.Rows.Item(0).Item("GajiS")
                strNoTel = dtUserInfo.Rows.Item(0).Item("NoTel")
            End If
        End Using

        If nomohon <> "" Then
            Dim query As String = $"select     isnull(SUM(Amaun_Tuntut),0) AS JumAmTuntut,  
       isnull(sum(convert(int,substring(Jum_Jam_Tuntut,1,2)) * 60 + convert(int,substring(Jum_Jam_Tuntut,3,2))),0) as JumJam  
        from SMKB_EOT_Mohon_Dtl WHERE No_Mohon = @No_Mohon"
            Dim param As New List(Of SqlParameter)
            param.Add(New SqlParameter("@No_Mohon", nomohon))

            dt = db.Read(query, param)

            If dt.Rows.Count > 0 Then

                JumAmAll = CInt(dt.Rows(0).Item("JumAmTuntut")) + jumamaun
                JumJamAll = CInt(dt.Rows(0).Item("JumJam")) + Jumkadarseb
            Else
                JumAmAll = jumamaun
                JumJamAll = Jumkadarseb
            End If
        Else
            JumAmAll = jumamaun
            JumJamAll = Jumkadarseb
        End If

        If JumAmAll > strGajiS Then
            SucBaca = "XOK"
        ElseIf JumJamAll > 6240 Then
            SucBaca = "XOK"
        Else
            SucBaca = "OK"
        End If
        Return SucBaca
    End Function


    '    'SEMAK TUNTUTAN EOT (GAJI)
    '    If MohonEOT.Amaun > strGajiS Then
    '        resp.Failed("Jumlah Keseluruhan Tuntutan Melebihi 1/3 Daripada Gaji Pokok.")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '        Exit Function
    '    ElseIf MohonEOT.Amaun > 6240 Then
    '        resp.Failed("Jumlah Keseluruhan Tuntutan Melebihi 104 Jam.")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '        Exit Function
    '    End If
    'End Function
    Private Function SemakEOTDtl(No_Mohon As String, Tkh_Tuntut As Date) As String
        Dim db As New DBKewConn
        Dim JumRekod As Integer

        Dim query As String = $"select * from SMKB_EOT_Mohon_Dtl WHERE No_Mohon = @No_Mohon And YEAR(Tkh_Tuntut) = @Tahun  And Month(Tkh_Tuntut) = @Bulan And Day(Tkh_Tuntut) = @Hari"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@Tahun", Tkh_Tuntut.Year))
        param.Add(New SqlParameter("@Bulan", Tkh_Tuntut.Month))
        param.Add(New SqlParameter("@Hari", Tkh_Tuntut.Day))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            JumRekod = 1
        Else
            JumRekod = 0
        End If
        Return JumRekod

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanAK(ArahanK As ArahanK) As String
        'Public Function SimpanAK(No_Arahan As String, No_Surat As String, No_Staf_Peg_AK As String, Kod_PTJ As String, KW As String, Kod_Vot As String, Tkh_Mula As String Tkh_Tamat As String, Lokasi As String, PeneranganK As String,  Jen_Dok as string, File_Name as string) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        ' sqlquery = New Query

        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim db As New DBKewConn


        If ArahanK Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        ArahanK.No_Staf_Peg_AK = Session("ssusrID")
        ArahanK.No_Mohon = "-"
        ArahanK.Folder = "UPLOAD/EOT/"
        ArahanK.Tkh_Upload = dtTkhToday2

        If ArahanK.No_Arahan = "" Then
            ArahanK.No_Arahan = GenerateEOTID()

            If InsertNewEOT(ArahanK.No_Arahan, ArahanK.No_Surat, ArahanK.No_Staf_Peg_AK, ArahanK.Kod_PTJ, ArahanK.KW, ArahanK.Kod_Vot, ArahanK.Tkh_Mula, ArahanK.Tkh_Tamat, ArahanK.Lokasi, ArahanK.PeneranganK) <> "OK" Then
                ' sqlquery.rollback()
                resp.Failed("Gagal Menyimpan Arahan kerja")
                Return JsonConvert.SerializeObject(resp.GetResult())

                Exit Function
            Else

                If InsertPegawai(ArahanK.No_Arahan, ArahanK.No_Staf_Sah, ArahanK.No_Staf_Lulus) <> "OK" Then
                    ' sqlquery.rollback()
                    'db.sConnRollbackTrans()
                    resp.Failed("Gagal Menyimpan Pegawai Pengesah dan Ketua Jabatan")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    Exit Function
                Else
                    If InsertLampiran(ArahanK.No_Arahan, ArahanK.Jen_Dok, ArahanK.Folder, ArahanK.File_Name, ArahanK.Tkh_Upload) <> "OK" Then
                        ' sqlquery.rollback()
                        'db.sConnRollbackTrans()
                        resp.Failed("Gagal Menyimpan Lampiran")
                        Return JsonConvert.SerializeObject(resp.GetResult())
                        Exit Function
                    Else
                        success = 1

                    End If
                End If

            End If
        Else

            If UpdateNewEOT(ArahanK.No_Arahan, ArahanK.No_Surat, ArahanK.Tkh_Mula, ArahanK.Tkh_Tamat, ArahanK.Lokasi, ArahanK.PeneranganK) <> "OK" Then
                ' sqlquery.rollback()
                resp.Failed("Gagal Menyimpan Arahan kerja")
                Return JsonConvert.SerializeObject(resp.GetResult())

                Exit Function
            Else

                If UpdatePegawai(ArahanK.No_Arahan, ArahanK.No_Staf_Sah, ArahanK.No_Staf_Lulus) <> "OK" Then
                    ' sqlquery.rollback()
                    'db.sConnRollbackTrans()
                    resp.Failed("Gagal Menyimpan Pegawai Pengesah dan Ketua Jabatan")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    Exit Function
                Else
                    If SemakLampiran(ArahanK.No_Arahan) > 0 Then
                        If UpdateLampiran(ArahanK.No_Arahan, ArahanK.File_Name, ArahanK.Tkh_Upload) <> "OK" Then
                            ' sqlquery.rollback()
                            db.sConnRollbackTrans()
                            resp.Failed("Gagal Menyimpan Lampiran")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            Exit Function
                        Else
                            success = 1

                        End If
                    Else
                        If InsertLampiran(ArahanK.No_Arahan, ArahanK.Jen_Dok, ArahanK.Folder, ArahanK.File_Name, ArahanK.Tkh_Upload) <> "OK" Then
                            'sqlquery.rollback()
                            'db.sConnRollbackTrans()
                            resp.Failed("Gagal Menyimpan Lampiran")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            Exit Function
                        Else
                            success = 1

                        End If
                    End If

                End If

            End If
        End If

        If success = 1 Then
            ' sqlquery.finish()
            db.sConnCommitTrans()
            Session("NoArahan") = ArahanK.No_Arahan
            resp.Success("Rekod berjaya disimpan", "00", ArahanK)
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'Return JsonConvert.SerializeObject(resp.GetResult())

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function KemaskiniAK(SemakArahan As SemakArahan) As String
        Dim db As New DBKewConn
        Dim resp As New ResponseRepository
        resp.Success("Rekod telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        ' sqlquery = New Query

        If SemakArahan Is Nothing Then
            resp.Failed("Rekod Tidak dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If



        If SemakArahan.No_Arahan <> "" Then

            SemakArahan.Folder = "UPLOAD/EOT/"
            SemakArahan.Tkh_Upload = dtTkhToday2
            If UpdateNewEOT(SemakArahan.No_Arahan, SemakArahan.No_Surat, SemakArahan.Tkh_Mula, SemakArahan.Tkh_Tamat, SemakArahan.Lokasi, SemakArahan.PeneranganK) <> "OK" Then
                'sqlquery.rollback()
                db.sConnRollbackTrans()
                resp.Failed("Gagal Menyimpan Arahan kerja")
                Return JsonConvert.SerializeObject(resp.GetResult())
                Exit Function
            Else

                If UpdatePegawai(SemakArahan.No_Arahan, SemakArahan.No_Staf_Sah, SemakArahan.No_Staf_Lulus) <> "OK" Then
                    ' sqlquery.rollback()
                    db.sConnRollbackTrans()
                    resp.Failed("Gagal Menyimpan No Pengesah dan Pelulus")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                    Exit Function
                Else
                    If SemakLampiran(SemakArahan.No_Arahan) > 0 Then
                        If UpdateLampiran(SemakArahan.No_Arahan, SemakArahan.File_Name, SemakArahan.Tkh_Upload) <> "OK" Then
                            ' sqlquery.rollback()
                            db.sConnRollbackTrans()
                            resp.Failed("Gagal Menyimpan Lampiran")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            Exit Function
                        Else
                            success = 1

                        End If
                    Else
                        If InsertLampiran(SemakArahan.No_Arahan, SemakArahan.Jen_Dok, SemakArahan.Folder, SemakArahan.File_Name, SemakArahan.Tkh_Upload) <> "OK" Then
                            'sqlquery.rollback()
                            'db.sConnRollbackTrans()
                            resp.Failed("Gagal Menyimpan Lampiran")
                            Return JsonConvert.SerializeObject(resp.GetResult())
                            Exit Function
                        Else
                            success = 1

                        End If
                    End If

                End If

            End If
        End If

        If success = 1 Then
            'sqlquery.finish()
            db.sConnCommitTrans()
            Session("NoArahan") = SemakArahan.No_Arahan
            resp.Success("Rekod berjaya dikemaskini", "00", SemakArahan)

            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            ' sqlquery.rollback()
            resp.Failed("Rekod tidak berjaya dikemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
#Disable Warning' Function doesn't return a value on all code paths
    End Function


    Function GetRecordKJ(ptj As String)

        Dim db1 As New DBKewConn("smsm")


        Dim param As New List(Of SqlParameter)
        Dim query1 As String = "SELECT TOP 1  a.MS01_NoStaf, a.MS01_Nama ,(a.MS01_Nostaf + ' - ' + a.ms01_nama) as NamaStaf, MS08_Pejabat as KodPejabat FROM MS01_Peribadi a inner join ms08_penempatan b on a.ms01_nostaf=b.ms01_nostaf 
											 inner join MS02_Perjawatan c on a.ms01_nostaf=c.ms01_nostaf where a.MS01_Status='1' and b.ms08_staterkini='1' 
											 And b.MS08_Pejabat =@Ptj and ms02_kumpulan in ('1','2','3','6','7','8','9') "
        param.Add(New SqlParameter("@Ptj", ptj.Substring(0, 2)))

        Return db1.ReadDB(query1, param)
    End Function


    Private Function UpdateNoAkhirEOT()
        Dim year = Date.Now.Year
        Dim RunningNoAR As String = ""
        Dim day = Date.Now.Day.ToString()
        Dim month = Date.Now.Month.ToString()
        Dim year1 = Date.Now.Year.ToString.Substring(2, 2)
        'Dim KodPtj = Session("ssusrKodPTj").ToString.PadRight(6, "0")

        Dim strSql = "SELECT Kod_Modul, Prefix, No_Akhir, Tahun, Butiran, kod_PTJ From SMKB_No_Akhir WHERE Kod_Modul = '23' AND Prefix = 'OT' AND Tahun = @years"
        Dim paramSql() As SqlParameter = {
            New SqlParameter("@KodModull", "23"),
            New SqlParameter("@Prefixx", "OT"),
            New SqlParameter("@years", Date.Now.Year)
            }

        Dim dbconn As New DBKewConn
        Dim ds = dbconn.fSelectCommand(strSql, "MKNoAkhir", paramSql)

        If ds.Tables(0).Rows.Count > 0 Then
            ds.Tables("MKNoAkhir").Rows(0)("No_Akhir") = ds.Tables("MKNoAkhir").Rows(0)("No_Akhir") + 1
            RunningNoAR = ds.Tables("MKNoAkhir").Rows(0)("No_Akhir")
        Else
            Dim dr As DataRow
            dr = ds.Tables("MKNoAkhir").NewRow
            dr("Kod_Modul") = "23"
            dr("Prefix") = "OT"
            dr("no_akhir") = 1
            dr("Tahun") = year
            dr("Butiran") = "No OT"

            ds.Tables("MKNoAkhir").Rows.Add(dr)
            RunningNoAR = 1
        End If

        dbconn.sUpdateCommand(ds, strSql)
        RunningNoAR = RunningNoAR.ToString.PadLeft(6, "0")

        Dim NoPermohonanAR As String = "OT" + RunningNoAR + month + year1
        Return NoPermohonanAR

    End Function
    Private Function GenerateEOTID() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newEOTID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='23' AND Prefix ='AR' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("23", "AR", year, lastID)
        Else

            InsertNoAkhir("23", "AR", year, lastID)
        End If
        newEOTID = "AR" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newEOTID
    End Function

    Private Function GenerateEOTIDMohon() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newEOTID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='23' AND Prefix ='EOT' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("23", "EOT", year, lastID)
        Else

            InsertNoAkhir("23", "EOT", year, lastID)
        End If
        newEOTID = "OT" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newEOTID
    End Function

    'Public Function GetWebMethodValue() As String
    '    Dim newEOTID As String = GenerateEOTID()
    '    Return newEOTID
    'End Function
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
        param.Add(New SqlParameter("@Butiran", "Arahan_Kerja"))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))


        Return db.Process(query, param)
    End Function

    Private Function InsertPegawai(No_Arahan As String, No_Staf_Sah As String, No_Staf_Lulus As String)
        Dim db As New DBKewConn


        Dim query As String = $"INSERT INTO SMKB_EOT_Pegawai (No_Mohon,No_Staf_SahL,No_Staf_SahB,No_Staf_LulusL,No_Staf_LulusB)
                            VALUES(@No_Mohon,@No_Staf_SahL,@No_Staf_SahB,@No_Staf_LulusL,@No_Staf_LulusB)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Mohon", No_Arahan))
        param.Add(New SqlParameter("@No_Staf_SahL", No_Staf_Sah))
        param.Add(New SqlParameter("@No_Staf_SahB", No_Staf_Sah))
        param.Add(New SqlParameter("@No_Staf_LulusL", No_Staf_Lulus))
        param.Add(New SqlParameter("@No_Staf_LulusB", No_Staf_Lulus))

        'Return RbQueryCmd("No_Mohon", No_Arahan, query, param)
        Return db.Process(query, param)

    End Function

    Private Function UpdatePegawai(No_Arahan As String, No_Staf_Sah As String, No_Staf_Lulus As String)
        Dim db As New DBKewConn


        Dim query As String = $"UPDATE SMKB_EOT_Pegawai set No_Staf_SahL = @No_Staf_SahL , No_Staf_SahB = @No_Staf_SahB,
        No_Staf_LulusL = @No_Staf_LulusL , No_Staf_LulusB = @No_Staf_LulusB
        where No_Mohon = @No_Mohon"

        Dim param As New List(Of SqlParameter)


        param.Add(New SqlParameter("@No_Staf_SahL", No_Staf_Sah))
        param.Add(New SqlParameter("@No_Staf_SahB", No_Staf_Sah))
        param.Add(New SqlParameter("@No_Staf_LulusL", No_Staf_Lulus))
        param.Add(New SqlParameter("@No_Staf_LulusB", No_Staf_Lulus))
        param.Add(New SqlParameter("@No_Mohon", No_Arahan))

        'Return RbQueryCmd("No_Mohon", No_Arahan, query, param)
        Return db.Process(query, param)

    End Function
    Private Function SemakLampiran(No_Arahan As String) As String
        Dim db As New DBKewConn
        Dim JumRekod As Integer
        Dim query As String = $"SELECT No_Mohon FROM SMKB_EOT_Dok_ArahanK WHERE No_Mohon = @No_Arahan"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Arahan", No_Arahan))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            JumRekod = 1
        Else
            JumRekod = 0
        End If
        Return JumRekod

    End Function



    Private Function InsertLampiran(No_Arahan As String, Jen_Dok As String, Folder As String, File_Name As String, Tkh_Upload As Date)
        Dim db As New DBKewConn

        Dim query As String = $"INSERT INTO SMKB_EOT_Dok_ArahanK (No_Mohon, Jen_Dok, Folder, File_Name, Tkh_Upload)
                            VALUES(@No_Mohon,@Jen_Dok,@Folder,@File_Name,@Tkh_Upload)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", No_Arahan))
        param.Add(New SqlParameter("@Jen_Dok", Jen_Dok))
        param.Add(New SqlParameter("@Folder", Folder))
        param.Add(New SqlParameter("@File_Name", File_Name))
        param.Add(New SqlParameter("@Tkh_Upload", Tkh_Upload))

        'Return RbQueryCmd("No_Mohon", No_Arahan, query, param)
        Return db.Process(query, param)


    End Function

    Private Function UpdateLampiran(No_Arahan As String, File_Name As String, Tkh_Upload As Date)
        Dim db As New DBKewConn

        Dim query As String = $"UPDATE SMKB_EOT_Dok_ArahanK SET File_Name = @File_Name,Tkh_Upload=@Tkh_Upload
                                WHERE No_Mohon=@No_Mohon "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@File_Name", File_Name))
        param.Add(New SqlParameter("@Tkh_Upload", Tkh_Upload))
        param.Add(New SqlParameter("@No_Mohon", No_Arahan))


        Return db.Process(query, param)


    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function InsertNewEOT(No_Arahan As String, No_Surat As String, No_Staf_Peg_AK As String, Kod_PTJ As String, KW As String, Kod_Vot As String, Tkh_Mula As Date, Tkh_Tamat As Date, Lokasi As String, PeneranganK As String)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim kodPTJ As String = Kod_PTJ.Substring(0, 2)
        Dim query As String = "INSERT INTO SMKB_EOT_Arahan_Kerja_Hdr
        VALUES(@No_Arahan, @No_Mohon,@No_Surat, @No_Staf_Peg_AK, @Kod_PTJ, @KW, @Kod_Vot, @Tkh_Mula, @Tkh_Tamat, @Lokasi, @PeneranganK,@Login_Created,@date_Created,@Login_modified,@date_modified)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Arahan", No_Arahan))
        param.Add(New SqlParameter("@No_Mohon", "-"))
        param.Add(New SqlParameter("@No_Surat", No_Surat))
        param.Add(New SqlParameter("@No_Staf_Peg_AK", Session("ssusrID")))
        param.Add(New SqlParameter("@Kod_PTJ", kodPTJ))
        param.Add(New SqlParameter("@KW", KW))
        param.Add(New SqlParameter("@Kod_Vot", Kod_Vot))
        param.Add(New SqlParameter("@Tkh_Mula", Tkh_Mula))
        param.Add(New SqlParameter("@Tkh_Tamat", Tkh_Tamat))
        param.Add(New SqlParameter("@Lokasi", Lokasi))
        param.Add(New SqlParameter("@PeneranganK", PeneranganK))
        param.Add(New SqlParameter("@Login_Created", No_Staf_Peg_AK))
        param.Add(New SqlParameter("@Date_Created", dtTkhToday))
        param.Add(New SqlParameter("@Login_modified", No_Staf_Peg_AK))
        param.Add(New SqlParameter("@Date_modified", dtTkhToday))


        'Return RbQueryCmd("No_Arahan", No_Arahan, query, param)

        Return db.Process(query, param)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function InsertEOTHdr(No_Arahan As String, No_Mohon As String, Tkh_Mohon As Date, OT_Ptj As String, Namafail As String, folder As String)
        Dim db As New DBKewConn
        Dim strGajiS As String
        Dim strNoTel As String
        Dim param As New List(Of SqlParameter)

        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Using dtUserInfo = fGetUserInfo(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                strGajiS = dtUserInfo.Rows.Item(0).Item("GajiS")
                strNoTel = dtUserInfo.Rows.Item(0).Item("NoTel")
            End If
        End Using

        If (String.IsNullOrEmpty(Namafail)) Then
            Namafail = "-"
            folder = "-"
        End If


        Dim query As String = "INSERT INTO SMKB_EOT_Mohon_Hdr
        VALUES(@No_Mohon,@No_Arahan,@No_Staf, @Gaji, @Tkh_Mohon, @Status_Mohon, @Samb, @OT_Ptj, @Status_Cetak,@Folder,@Filename,@Tkh_Upload)"

        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@No_Arahan", No_Arahan))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Gaji", strGajiS))
        param.Add(New SqlParameter("@Tkh_Mohon", Tkh_Mohon))
        param.Add(New SqlParameter("@Status_Mohon", "01"))
        param.Add(New SqlParameter("@Samb", strNoTel))
        param.Add(New SqlParameter("@OT_Ptj", OT_Ptj))
        param.Add(New SqlParameter("@Status_Cetak", "0"))
        param.Add(New SqlParameter("@Folder", folder))
        param.Add(New SqlParameter("@Filename", Namafail))
        If (String.IsNullOrEmpty(Namafail)) Then
            param.Add(New SqlParameter("@Tkh_Upload", DBNull.Value))
        Else
            param.Add(New SqlParameter("@Tkh_Upload", Tkh_Mohon))
        End If

        Return db.Process(query, param)

        'Return RbQueryCmd("No_Mohon", No_Mohon, query, param)

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function UpdateEOTHdr(No_Arahan As String, No_Mohon As String, Namafail As String, folder As String)
        Dim db As New DBKewConn
        Dim strGajiS As String
        Dim strNoTel As String
        Dim param As New List(Of SqlParameter)
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr SET Folder = @Folder ,  Filename = @Filename,Tkh_Upload =@Tkh_Upload
        WHERE No_Mohon = @No_Mohon AND No_Arahan = @No_Arahan"


        param.Add(New SqlParameter("@folder", folder))
        param.Add(New SqlParameter("@Filename", Namafail))
        param.Add(New SqlParameter("@Tkh_Upload", dtTkhToday))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@No_Arahan", No_Arahan))


        Return db.Process(query, param)

        ' Return RbQueryCmd("No_Mohon", No_Mohon, query, param)

    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function UpdateEOTDtl(Tujuan As String, Catatan As String, No_Staf_Sah As String, OT_Ptj As String, No_Staf_Lulus As String, No_Mohon As String, tarikh As Date, BulanT As Integer, TahunT As Integer)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)



        Dim oDate As DateTime = Convert.ToDateTime(tarikh)
        Dim Tahun As String = oDate.Year
        Dim Bulan As String = oDate.Month
        Dim Hari As String = oDate.Day



        Dim query As String = "UPDATE SMKB_EOT_Mohon_Dtl Set Tujuan = @Tujuan, Catatan=@Catatan,No_Staf_Sah = @No_Staf_Sah, 
        OT_Ptj = @OT_Ptj,No_Staf_Lulus = @No_Staf_Lulus, Bulan_Tuntut = @BTuntut, Tahun_Tuntut = @TTuntut
        WHERE No_Mohon = @No_Mohon and year(Tkh_Tuntut) = @Tahun  and month(Tkh_Tuntut) = @Bulan
        and day(Tkh_Tuntut) = @Hari"

        'For Each updateData As UpdateData In updates
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Tujuan", Tujuan))
        param.Add(New SqlParameter("@Catatan", Catatan))
        param.Add(New SqlParameter("@No_Staf_Sah", No_Staf_Sah))
        param.Add(New SqlParameter("@OT_Ptj", OT_Ptj))
        param.Add(New SqlParameter("@No_Staf_Lulus", No_Staf_Lulus))
        param.Add(New SqlParameter("@BTuntut", BulanT))
        param.Add(New SqlParameter("@TTuntut", TahunT))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@Tahun", Tahun))
        param.Add(New SqlParameter("@Bulan", Bulan))
        param.Add(New SqlParameter("@Hari", Hari))
        'Return RbQueryCmd("No_Mohon", No_Mohon, query, param)
        Return db.Process(query, param)

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function UpdateNewEOT(No_Arahan As String, No_Surat As String, Tkh_Mula As Date, Tkh_Tamat As Date, Lokasi As String, PeneranganK As String)
        Dim db As New DBKewConn
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        Dim query As String = "UPDATE SMKB_EOT_Arahan_Kerja_Hdr
        SET No_Surat = @No_Surat, Tkh_Mula= @Tkh_Mula, Tkh_Tamat = @Tkh_Tamat, Lokasi = @Lokasi, 
        PeneranganK = @PeneranganK,Login_modified = @Login_modified , Date_modified = @date_modified WHERE No_Arahan = @No_Arahan"
        Dim param As New List(Of SqlParameter)



        param.Add(New SqlParameter("@No_Surat", No_Surat))
        param.Add(New SqlParameter("@Tkh_Mula", Tkh_Mula))
        param.Add(New SqlParameter("@Tkh_Tamat", Tkh_Tamat))
        param.Add(New SqlParameter("@Lokasi", Lokasi))
        param.Add(New SqlParameter("@PeneranganK", PeneranganK))
        param.Add(New SqlParameter("@Login_modified", Session("ssusrID")))
        param.Add(New SqlParameter("@Date_modified", dtTkhToday))
        param.Add(New SqlParameter("@No_Arahan", No_Arahan))

        'Return RbQueryCmd("No_Arahan", No_Arahan, query, param)

        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanStafAK(selectedData As String(), noarahan As String) As String
        Dim resp As New ResponseRepository
        Dim temps As String
        Dim success As String
        resp.Success("Rekod Berjaya Disimpan")
        'sqlquery = New Query
        If noarahan = "" Then
            Exit Function
        End If


        For Each data As String In selectedData
            If SemakStafAK(noarahan, data) = 0 Then
                If SimpanStafAK_(noarahan, data) = "OK" Then
                    SendEmail(noarahan, data)
                    success = +1

                End If

            End If
        Next



        If success = 0 Then
            resp.Failed("Rekod Tidak Berjaya Disimpan")
        Else

            resp.Success("Rekod Berjaya Disimpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())


    End Function


    'Private Function SimpanStafAK_(selectedData As String(), noarahan As String) As String

    '    Dim db As New DBKewConn
    '    'sqlquery = New Query
    '    If noarahan = "" Then
    '        Exit Function
    '    End If
    '    For Each data As String In selectedData
    '        If SemakStafAK(noarahan, data) = 0 Then
    '            Dim query As String = "INSERT INTO SMKB_EOT_Arahan_Kerja_Dtl VALUES(@No_Arahan,@No_Staf)"
    '            Dim param As New List(Of SqlParameter)

    '            param.Add(New SqlParameter("@No_Arahan", noarahan))
    '            param.Add(New SqlParameter("@No_Staf", data))

    '            'db.Process(query, param)


    '            RbQueryCmd("No_Arahan", noarahan, query, param)
    '            SendEmail(noarahan, data)
    '        End If
    '    Next

    'End Function


    Private Function SimpanStafAK_(noarahan As String, data As String) As String
        Dim db As New DBKewConn
        If noarahan = "" Then
            Exit Function
        End If

        Dim query As String = "INSERT INTO SMKB_EOT_Arahan_Kerja_Dtl VALUES(@No_Arahan,@No_Staf)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Arahan", noarahan))
        param.Add(New SqlParameter("@No_Staf", data))

        Return db.Process(query, param)
        ' Dim key As New Dictionary(Of String, String)
        ' key.Add("No_Arahan", noarahan)
        'key.Add("No_Staf", data)


        'Return RbQueryCmdMulti(key, query, param)



    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanSahPenyelia(senaraiSah As String(), senaraiTidakSah As String(), nomohon As String) As String
        Dim resp As New ResponseRepository

        SimpanSahPenyeliaDetail(senaraiSah, senaraiTidakSah, nomohon)
        resp.Success("Rekod Berjaya Disimpan")
        Return JsonConvert.SerializeObject(resp.GetResult())
        ' Return a response message

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanSokongEOT(order As List(Of OrderEot), nomohon As String) As String
        Dim resp As New ResponseRepository
        Dim strJamlulus As String
        Dim success As Integer = 0
        resp.Success("Data telah disimpan")
        Dim strTurutan As Integer
        'sqlquery = New Query
        If nomohon = "" Then
            Exit Function
        End If

        Dim db As New DBKewConn
        If SemakNoMohon(nomohon) > 0 Then
            Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr set Status_Mohon =@staMohon WHERE No_Mohon = @No_Mohon"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@No_Mohon", nomohon))
            param.Add(New SqlParameter("@staMohon", "03"))

            db.Process(query, param)
            'RbQueryCmd("No_Mohon", nomohon, query, param)

            For Each singleOrder As OrderEot In order
                If UpdateEotSokong(singleOrder, nomohon) = "OK" Then
                    success += 1

                End If
            Next
        Else
            'sqlquery.rollback()
            resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If success = 0 Then
            'sqlquery.rollback()
            resp.Failed("Rekod  gagal disimpan")
        Else
            'sqlquery.finish()
            resp.Success("Rekod  telah Dikemaskini")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function
    Public Function UpdateEotSokong(singleOrder As OrderEot, nomohon As String)
        Dim StatusMohon As String = singleOrder.StatusMohon
        Dim strStaTerima As String
        Dim strStatus As String
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        Dim db As New DBKewConn

        If StatusMohon = "LULUS" Then
            strStatus = "L"
            strStaTerima = "BT"
        ElseIf StatusMohon = "TLULUS" Then
            strStatus = "TL"
            strStaTerima = "TT"
        ElseIf StatusMohon = "BLULUS" Then
            strStatus = "BL"
            strStaTerima = "BT"
        End If
        Dim jamtamatlulus As String = singleOrder.Jamtamatlulus
        Dim Jammulalulus As String = singleOrder.Jammulalulus
        Dim Jumjamlulus As String = singleOrder.Jumjamlulus
        Dim Amaunlulus As String = singleOrder.Amaunlulus
        Dim Turutan As String = singleOrder.Turutan
        Dim ID As Integer = singleOrder.ID

        Dim UlasanLulus As String = singleOrder.UlasanLulus

        Dim query1 As String = "UPDATE SMKB_EOT_Mohon_Dtl Set
                No_Staf_Lulus = @No_Staf_Lulus, Amaun_Lulus=@Amaun_Lulus, Jam_Mula_Lulus = @Jam_Mula_Lulus,
                Jam_Tamat_Lulus = @Jam_Tamat_Lulus,Jum_Jam_Lulus = @Jum_Jam_Lulus,Tkh_Lulus = @Tarikh_Lulus,Amaun_Terima = @Amaun_Terima,
                Jam_Mula_Terima = @Jam_Mula_Terima, Jam_Tamat_Terima = @Jam_Tamat_Terima,Jum_Jam_Terima = @Jum_Jam_Terima,
                Status_Lulus = @Status_Lulus,Status_Terima = @Status_Terima,Flag_Lulus = @Flag_Lulus,Ulasan_Lulus=@Ulasan_Lulus
                WHERE No_Mohon = @No_Mohon and ID = @ID"

        'For Each updateData As UpdateData In updates
        Dim param1 As New List(Of SqlParameter)
        param1.Add(New SqlParameter("@No_Staf_Lulus", Session("ssusrID")))
        param1.Add(New SqlParameter("@Amaun_Lulus", Amaunlulus))
        param1.Add(New SqlParameter("@Jam_Mula_Lulus", Jammulalulus))
        param1.Add(New SqlParameter("@Jam_Tamat_Lulus", jamtamatlulus))
        param1.Add(New SqlParameter("@Jum_Jam_Lulus", Jumjamlulus))
        param1.Add(New SqlParameter("@Tarikh_Lulus", dtTkhToday))
        param1.Add(New SqlParameter("@Amaun_Terima", Amaunlulus))
        param1.Add(New SqlParameter("@Jam_Mula_Terima", Jammulalulus))
        param1.Add(New SqlParameter("@Jam_Tamat_Terima", jamtamatlulus))
        param1.Add(New SqlParameter("@Jum_Jam_Terima", Jumjamlulus))
        param1.Add(New SqlParameter("@Status_Lulus", strStatus))
        param1.Add(New SqlParameter("@Status_Terima", strStaTerima))
        param1.Add(New SqlParameter("@Flag_Lulus", "1"))
        param1.Add(New SqlParameter("@Ulasan_Lulus", UlasanLulus))
        param1.Add(New SqlParameter("@No_Mohon", nomohon))
        param1.Add(New SqlParameter("@ID", ID))

        Return db.Process(query1, param1)
        'Return RbQueryCmd("No_Mohon", nomohon, query1, param1)

    End Function
    Private Function UpdateEotTerima(singleOrder As DataEot, nomohon As String) As String

        Dim strStaTerima As String
        Dim strStatus As String
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        Dim jamtamatterima As String = singleOrder.Jamtamatterima
        Dim Jammulaterima As String = singleOrder.Jammulaterima
        Dim Jumjamterima As String = singleOrder.Jumjamterima
        Dim Amaunterima As String = singleOrder.Amaunterima
        Dim Turutan As String = singleOrder.Turutan
        Dim ID As String = singleOrder.ID
        Dim StatusMohon As String = singleOrder.StatusMohon
        Dim UlasanTerima As String = singleOrder.UlasanTerima


        Dim db As New DBKewConn

        If StatusMohon = "TERIMA" Then
            strStatus = "T"
        ElseIf StatusMohon = "TTERIMA" Then
            strStatus = "TT"
        ElseIf StatusMohon = "BTERIMA" Then
            strStatus = "BT"
        End If

        Dim query1 As String = "UPDATE SMKB_EOT_Mohon_Dtl Set Jam_Mula_Terima = @Jam_Mula_Terima, Jam_Tamat_Terima = @Jam_Tamat_Terima, 
                Jum_Jam_Terima = @Jum_Jam_Terima,Ulasan_Terima=@Ulasan_Terima,No_Staf_Terima = @No_Staf_Terima, Amaun_Terima=@Amaun_Terima ,
                Status_Terima = @Status_Terima,Tkh_Terima = @Tarikh_Terima WHERE No_Mohon = @No_Mohon and ID = @ID"

        'For Each updateData As UpdateData In updates
        Dim param1 As New List(Of SqlParameter)

        param1.Add(New SqlParameter("@No_Staf_Terima", Session("ssusrID")))
        param1.Add(New SqlParameter("@Ulasan_Terima", UlasanTerima))
        param1.Add(New SqlParameter("@Amaun_Terima", Amaunterima))
        param1.Add(New SqlParameter("@Jam_Mula_Terima", Jammulaterima))
        param1.Add(New SqlParameter("@Jam_Tamat_Terima", jamtamatterima))
        param1.Add(New SqlParameter("@Jum_Jam_Terima", Jumjamterima))
        param1.Add(New SqlParameter("@Status_Terima", strStatus))
        param1.Add(New SqlParameter("@Tarikh_Terima", dtTkhToday))
        param1.Add(New SqlParameter("@No_Mohon", nomohon))
        param1.Add(New SqlParameter("@ID", ID))

        Return db.Process(query1, param1)
        'Return RbQueryCmd("No_Mohon", nomohon, query1, param1)


    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanTerimaEOT(order_terima As List(Of DataEot), nomohon As String) As String
        Dim resp As New ResponseRepository
        Dim strJamlulus As String
        Dim strStatus As String
        Dim strTurutan As Integer

        'sqlquery = New Query
        Dim success As Integer = 0
        resp.Success("Data telah disimpan")
        If IsDBNull(nomohon) Or nomohon = "" Then
            Exit Function
        End If
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        Dim db As New DBKewConn

        If SemakNoMohon(nomohon) > 0 Then
            Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr set Status_Mohon =@staMohon WHERE No_Mohon = @No_Mohon"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@No_Mohon", nomohon))
            param.Add(New SqlParameter("@staMohon", "04"))

            db.Process(query, param)

            'RbQueryCmd("No_Mohon", nomohon, query, param)

            For Each singleOrder As DataEot In order_terima

                If UpdateEotTerima(singleOrder, nomohon) = "OK" Then
                    success += 1

                End If
            Next

        Else
            resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa")
            'sqlquery.rollback()
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If

        If success = 0 Then
            'sqlquery.rollback()
            resp.Failed("Rekod  Gagal Disimpan")
        Else
            'sqlquery.finish()
            resp.Success("Rekod Telah Dikemaskini")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function


    Private Function SimpanSahPenyeliaDetail(senaraiSah As String(), senaraiTidakSah As String(), nomohon As String) As String
        Dim resp As New ResponseRepository
        'sqlquery = New Query
        If nomohon = "" Or IsDBNull(nomohon) Then
            Exit Function
        End If
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")

        Dim dtTkhToday As DateTime = CDate(strTkhToday)

        Dim db As New DBKewConn

        If SemakNoMohon(nomohon) > 0 Then
            Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr set Status_Mohon =@staMohon WHERE No_Mohon = @No_Mohon"
            Dim param As New List(Of SqlParameter)

            param.Add(New SqlParameter("@No_Mohon", nomohon))
            param.Add(New SqlParameter("@staMohon", "02"))

            db.Process(query, param)
            'RbQueryCmd("No_Mohon", nomohon, query, param)


            For Each tarikhtuntut As String In senaraiSah

                Dim strtkhTuntut1 As DateTime = CDate(tarikhtuntut)


                Dim query1 As String = "UPDATE SMKB_EOT_Mohon_Dtl set Status_Sah =@Status_Sah, Tkh_Sah =@Tkh_Sah,Flag_Sah=@Flag_Sah WHERE No_Mohon = @No_Mohon AND Tkh_Tuntut=@Tkh_Tuntut"
                Dim param1 As New List(Of SqlParameter)

                param1.Add(New SqlParameter("@Status_Sah", "S"))
                param1.Add(New SqlParameter("@Tkh_Sah", dtTkhToday))
                param1.Add(New SqlParameter("@Flag_Sah", 1))
                param1.Add(New SqlParameter("@No_Mohon", nomohon))
                param1.Add(New SqlParameter("@Tkh_Tuntut", strtkhTuntut1))

                db.Process(query1, param1)
                'RbQueryCmd("No_Mohon", nomohon, query1, param1)

            Next


            For Each tarikhtuntut As String In senaraiTidakSah

                Dim strtkhTuntut2 As DateTime = CDate(tarikhtuntut)

                Dim query2 As String = "UPDATE SMKB_EOT_Mohon_Dtl set Status_Sah =@Status_Sah, Tkh_Sah =@Tkh_Sah,Flag_Sah=@Flag_Sah,
                Status_Lulus=@Status_Lulus,Status_Terima= @Status_Terima WHERE No_Mohon = @No_Mohon AND Tkh_Tuntut=@Tkh_Tuntut"
                Dim param2 As New List(Of SqlParameter)

                param2.Add(New SqlParameter("@Status_Sah", "TS"))
                param2.Add(New SqlParameter("@Tkh_Sah", dtTkhToday))
                param2.Add(New SqlParameter("@Flag_Sah", 1))
                param2.Add(New SqlParameter("@Status_Lulus", "TL"))
                param2.Add(New SqlParameter("@Status_Terima", "TT"))
                param2.Add(New SqlParameter("@No_Mohon", nomohon))
                param2.Add(New SqlParameter("@Tkh_Tuntut", strtkhTuntut2))


                db.Process(query2, param2)
                'RbQueryCmd("No_Mohon", nomohon, query2, param2)


            Next
            'sqlquery.finish()
            resp.Success("Rekod telah Disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            'sqlquery.rollback()
            resp.Failed("Gagal Menyimpan Tuntutan Kerla Lebih Masa")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If




    End Function

    Private Function SemakNoMohonLulus(NoStaf As String, TkhTuntut As Date) As String
        Dim db As New DBKewConn
        Dim JumRekod As Integer
        Dim query As String = $"SELECT No_Arahan,No_Staf FROM SMKB_EOT_Mohon_Hdr a 
        inner join SMKB_EOT_Mohon_Dtl b  on a.no_mohon = b.no_mohon WHERE a.No_Staf= @NoStaf
        and a.Status_Mohon not in ('01','06') and b.Tkh_Tuntut = @TkhTuntut "
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoStaf", NoStaf))
        param.Add(New SqlParameter("@TkhTuntut", TkhTuntut))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            JumRekod = 1
        Else
            JumRekod = 0
        End If
        Return JumRekod

    End Function

    Private Function SemakNoMohon(No_Mohon As String) As String
        Dim db As New DBKewConn
        Dim JumRekod As Integer
        Dim query As String = $"SELECT No_Arahan,No_Staf FROM SMKB_EOT_Mohon_Hdr WHERE No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))


        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            JumRekod = 1
        Else
            JumRekod = 0
        End If
        Return JumRekod

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function KiraAmtEOT(MohonEOT As MohonEOT) As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn
        Dim amaun As Decimal = 0.00

        'Dim dtTkh As Date = DateTime.ParseExact(MohonEOT.Tkh_Tuntut, "dd/MM/yyyy", CultureInfo.CurrentCulture)
        'Dim strTkh As String = dtTkh.ToString("yyyy-MM-dd")
        Try
            Dim param1 As SqlParameter = New SqlParameter("@nostaf", SqlDbType.VarChar)
            param1.Value = Session("ssusrID")
            param1.Direction = ParameterDirection.Input
            param1.IsNullable = False

            Dim param2 As SqlParameter = New SqlParameter("@tarikh", SqlDbType.DateTime)
            param2.Value = MohonEOT.Tkh_Tuntut
            param2.Direction = ParameterDirection.Input
            param2.IsNullable = False

            Dim param3 As SqlParameter = New SqlParameter("@jammula", SqlDbType.VarChar)
            param3.Value = MohonEOT.Jam_Mula
            param3.Direction = ParameterDirection.Input
            param3.IsNullable = False

            Dim param4 As SqlParameter = New SqlParameter("@jamtamat", SqlDbType.VarChar)
            param4.Value = MohonEOT.Jam_Tamat
            param4.Direction = ParameterDirection.Input
            param4.IsNullable = False

            Dim param5 As SqlParameter = New SqlParameter("@amaun", SqlDbType.Decimal)
            param5.Value = amaun
            param5.Precision = 19
            param5.Scale = 2
            param5.Direction = ParameterDirection.Output
            param5.IsNullable = False
            Dim paramSql() As SqlParameter = {param1, param2, param3, param4, param5}

            Dim jumamaun = db.fExecuteSP("USP_KIRAAMTEOT_VER1", paramSql, param5, amaun)

        Catch ex As Exception
            fErrorLog("KiraAmtEOT - " & ex.Message.ToString)
        End Try

        'Return amaun
        MohonEOT.Amaun = amaun
        resp.Success("Amaun berjaya dikira", "00", MohonEOT.Amaun)
        Return JsonConvert.SerializeObject(resp.GetResult())


    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function BakiPeruntukanKasar(ptj As String, nostaf As String)
        Dim resp As New ResponseRepository
        Dim year = Date.Now.Year
        Dim strTkhToday As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday As DateTime = CDate(strTkhToday)
        Dim strTaraf As String
        Dim strKod As String
        Dim strKodVot As String
        Dim amaunbaki As Decimal = 0.00
        Dim db As New DBKewConn


        Using dtUserInfo = fGetUserInfo(nostaf)
            If dtUserInfo.Rows.Count > 0 Then
                strTaraf = dtUserInfo.Rows.Item(0).Item("MS02_Taraf")
            End If
        End Using

        If strTaraf = "01" Or strTaraf = "02" Then
            strKodVot = "14000"
        Else
            strKodVot = "29000"
        End If



        If semakPerutTabung(ptj) = True Then
            Try
                Dim param1 As SqlParameter = New SqlParameter("@Tahun", SqlDbType.DateTime)
                param1.Value = year
                param1.Direction = ParameterDirection.Input
                param1.IsNullable = False

                Dim param2 As SqlParameter = New SqlParameter("@Tarikh", SqlDbType.DateTime)
                param2.Value = dtTkhToday
                param2.Direction = ParameterDirection.Input
                param2.IsNullable = False

                Dim param3 As SqlParameter = New SqlParameter("@Kod", SqlDbType.VarChar)
                param3.Value = "08"
                param3.Direction = ParameterDirection.Input
                param3.IsNullable = False

                Dim param4 As SqlParameter = New SqlParameter("@Ptj", SqlDbType.VarChar)
                param4.Value = ptj
                param4.Direction = ParameterDirection.Input
                param4.IsNullable = False

                Dim param5 As SqlParameter = New SqlParameter("@Amaunbaki", SqlDbType.Decimal)
                param5.Value = amaunbaki
                param5.Precision = 19
                param5.Scale = 2
                param5.Direction = ParameterDirection.Output
                param5.IsNullable = False
                Dim paramSql() As SqlParameter = {param1, param2, param3, param4, param5}

                Dim jumamaun = db.fExecuteSP("USP_BAKITABUNG", paramSql, param5, amaunbaki)

            Catch ex As Exception
                fErrorLog("BakiPeruntukanKasar - " & ex.Message.ToString)
            End Try

            Return amaunbaki

            ' resp.Success("Amaun berjaya dikira", "00", MohonEOT.Amaun)
            Return JsonConvert.SerializeObject(resp.GetResult())


        Else
            Try


                Dim param1 As SqlParameter = New SqlParameter("@Tahun", SqlDbType.DateTime)
                param1.Value = year
                param1.Direction = ParameterDirection.Input
                param1.IsNullable = False

                Dim param2 As SqlParameter = New SqlParameter("@Tarikh", SqlDbType.DateTime)
                param2.Value = dtTkhToday
                param2.Direction = ParameterDirection.Input
                param2.IsNullable = False

                Dim param3 As SqlParameter = New SqlParameter("@Kod", SqlDbType.VarChar)
                param3.Value = "07"
                param3.Direction = ParameterDirection.Input
                param3.IsNullable = False

                Dim param4 As SqlParameter = New SqlParameter("@Operasi", SqlDbType.VarChar)
                param4.Value = "00"
                param4.Direction = ParameterDirection.Input
                param4.IsNullable = False

                Dim param5 As SqlParameter = New SqlParameter("@projek", SqlDbType.VarChar)
                param5.Value = "0000000"
                param5.Direction = ParameterDirection.Input
                param5.IsNullable = False

                Dim param6 As SqlParameter = New SqlParameter("@Ptj", SqlDbType.VarChar)
                param6.Value = ptj
                param6.Direction = ParameterDirection.Input
                param6.IsNullable = False

                Dim param7 As SqlParameter = New SqlParameter("@Kodvot", SqlDbType.VarChar)
                param7.Value = strKodVot
                param7.Direction = ParameterDirection.Input
                param7.IsNullable = False


                Dim param8 As SqlParameter = New SqlParameter("@Akt", SqlDbType.VarChar)
                param8.Value = "00"
                param8.Direction = ParameterDirection.Input
                param8.IsNullable = False

                Dim param9 As SqlParameter = New SqlParameter("@Amaunbaki", SqlDbType.Decimal)
                param9.Value = amaunbaki
                param9.Precision = 19
                param9.Scale = 2
                param9.Direction = ParameterDirection.Output
                param9.IsNullable = False
                Dim paramSql() As SqlParameter = {param1, param2, param3, param4, param5, param6, param7, param8, param9}

                Dim jumamaun = db.fExecuteSP("USP_BAKISBNR_BAJET", paramSql, param9, amaunbaki)

            Catch ex As Exception
                fErrorLog("BakiPeruntukanKasar - " & ex.Message.ToString)
            End Try

            Return amaunbaki

            ' resp.Success("Amaun berjaya dikira", "00", MohonEOT.Amaun)
            Return JsonConvert.SerializeObject(resp.GetResult())

        End If

        'If semakPerutTabung(Left(Me.cmbPtj.Text, 6)) = True Then
        '    BakiPerutk = getBakiTabung(CInt(Thn), Tarikh, "08", getKodTabung(Left(Me.cmbPtj.Text, 6)))
        'Else
        '    BakiPerutk = getBakiSbnr(CInt(Thn), Tarikh, "07", Left(Me.cmbPtj.Text, 6), KodVot, "00")
        'End If



    End Function
    Private Function semakPerutTabung(VotPTJ As String) As Boolean
        Dim db As New DBKewConn
        Dim JumRekod As Integer
        Dim query As String = $"SELECT Kod_PTJ FROM   SMKB_COA_Master where  Kod_Kategori_PTJ = 'T' and Kod_PTJ = @KodPTJ and Status = 1"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodPTJ", VotPTJ))


        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            semakPerutTabung = True
        Else
            semakPerutTabung = False
        End If
        Return semakPerutTabung

    End Function


    'Private Function getBakiTabung(thn As String, tkh As Date)
    '    Dim db As New DBKewConn
    '    Dim JumRekod As Integer
    '    Dim query As String = $"SELECT Kod_PTJ, Status_Pusat FROM  SMKB_PTJ_Pusat where Kod_PTJ = @Kod_PTJ"
    '    Dim param As New List(Of SqlParameter)
    '    param.Add(New SqlParameter("@Kod_PTJ", VotPTJ))


    '    dt = db.Read(query, param)

    '    If dt.Rows.Count > 0 Then
    '        getBakiTabung = True
    '    Else
    '        getBakiTabung = False
    '    End If
    '    Return getBakiTabung

    'End Function

    Private Function SemakStafAK(No_Arahan As String, No_Staf As String) As String
        Dim db As New DBKewConn
        Dim JumRekod As Integer
        Dim query As String = $"SELECT No_Arahan,No_Staf FROM SMKB_EOT_Arahan_Kerja_Dtl WHERE No_Arahan = @No_Arahan and No_Staf =@No_Staf"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Arahan", No_Arahan))
        param.Add(New SqlParameter("@No_Staf", No_Staf))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            JumRekod = 1
        Else
            JumRekod = 0
        End If
        Return JumRekod

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDeleteStafAK(id As String, id1 As String) As String
        Dim resp As New ResponseRepository
        'sqlquery = New Query
        ' DeleteStafAK(id, id1)

        ' Return a response message
        'Return "Data saved successfully"

        If DeleteStafAK(id, id1) <> "OK" Then
            'sqlquery.rollback()
            resp.Failed("Rekod Gagal dihapuskan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            'sqlquery.finish()
            resp.Success("Rekod telah dihapuskan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If





    End Function

    Private Function DeleteStafAK(idnostaf As String, idnoarahan As String) As String
        If idnoarahan = "" Then
            Exit Function
        End If

        Dim db As New DBKewConn

        Dim query As String = "DELETE FROM SMKB_EOT_Arahan_Kerja_Dtl WHERE No_Arahan = @No_Arahan AND  No_Staf = @No_Staf "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Arahan", idnoarahan))
        param.Add(New SqlParameter("@No_Staf", idnostaf))

        Return db.Process(query, param)
        'Return RbQueryCmd("No_Arahan", idnoarahan, query, param)
    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DelRecbyTkhNoMohn(MohonEOT As MohonEOT) As String
        Dim resp As New ResponseRepository


        If DelTransaksiEOT(MohonEOT.Tkh_Tuntut, MohonEOT.No_Mohon, MohonEOT.Jam_Mula, MohonEOT.Jam_Tamat) <> "OK" Then
            resp.Failed("Rekod Gagal dihapuskan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod telah dihapuskan")
        Return JsonConvert.SerializeObject(resp.GetResult())



    End Function

    Private Function DelTransaksiEOT(Tkh_Tuntut As Date, No_Mohon As String, Jam_Mula As String, Jam_Tamat As String)
        If No_Mohon = "" Then
            Exit Function
        End If

        Dim db As New DBKewConn

        Dim query As String = "DELETE FROM SMKB_EOT_Mohon_Dtl WHERE No_Mohon = @No_Mohon AND  Tkh_Tuntut = @TkhTuntut and Jam_Mula >= @Jam_Mula
        and Jam_Tamat <= @Jam_Tamat"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@TkhTuntut", Tkh_Tuntut))
        param.Add(New SqlParameter("@No_Mohon", No_Mohon))
        param.Add(New SqlParameter("@Jam_Mula", Jam_Mula))
        param.Add(New SqlParameter("@Jam_Tamat", Jam_Tamat))

        Return db.Process(query, param)

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBatalEOT(id As String) As String
        Dim resp As New ResponseRepository

        If GetBatalEOT(id) <> "OK" Then
            resp.Failed("Rekod Gagal dihapuskan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod telah dihapuskan")
        Return JsonConvert.SerializeObject(resp.GetResult())



    End Function

    Private Function GetBatalEOT(idnomohon As String) As String
        If idnomohon = "" Then
            Exit Function
        End If

        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr set Status_Mohon =@staMohon WHERE No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@staMohon", "06"))
        param.Add(New SqlParameter("@No_Mohon", idnomohon))


        Return db.Process(query, param)

    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSokongEOT(id As String) As String
        Dim resp As New ResponseRepository

        If GetSokongEOT(id) <> "OK" Then
            resp.Failed("Rekod Gagal disokong")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod telah disokong")
        Return JsonConvert.SerializeObject(resp.GetResult())



    End Function

    Private Function GetSokongEOT(idnomohon As String) As String
        If idnomohon = "" Then
            Exit Function
        End If
        'dari sistem smkb
        '----------------tambahan jika menggunakan peruntukkan tabung-------------
        'If semakPerutTabung(Left(Me.cmbPtj.Text, 6)) = True Then
        '    BakiPerutk = getBakiTabung(CInt(Thn), Tarikh, "08", Left(Me.cmbPtj.Text, 6))
        'Else
        '    BakiPerutk = getBakiSbnr(CInt(Thn), Tarikh, "07", Left(Me.cmbPtj.Text, 6), kodvot, "00")
        'End If



        ' Set rs = myDB("SELECT SUM(EOT01_AmaunSah) AS JumOTL" _
        '& " From dbo.EOT01_MohonDT" _
        '& " WHERE (EOT01_StatusLulus = 'L') AND (EOT01_StatusTerima = 'BT') AND (EOT01_StatusProses = 'BP') AND (EOT01_OTPtj = '" & Left(Me.cmbPtj.Text, 6) & "')", adLockReadOnly)
        'If rs.EOF = False Then
        '            If IsNull(rs("JumOTL")) Then
        '                JumOtL = 0
        '            Else
        '                JumOtL = rs("JumOTL")
        '            End If
        '        End If
        'Set rs = Nothing

        'Me.lblBakiPerutk.caption = FormatNumber(BakiPerutk, 2)
        'Me.lblBakiOT.caption = FormatNumber(BakiPerutk - JumOtL, 2)


        'semakan bulan utk lulus OT ptj
        '-------------------------------------
        'Set rs1 = myDB("SELECT distinct month(EOT01_TkhTuntut) as eot01_bulantuntut FROM EOT01_MohonDT where EOT01_NoMohon='" & NoMohon & "'", adLockOptimistic)
        'If rs1.EOF = False Then
        '            If rs1.RecordCount > 1 Then
        '                MsgBox "Terdapat permohonan bulan yang berbeza. Mohon semak semula."
        '        Exit Function
        '            Else
        '                If rs1("eot01_bulantuntut") = 11 Or rs1("eot01_bulantuntut") = 12 Then

        '                Else
        '                    Bajet = CDbl(Me.lblBakiOT.caption) - CDbl(Me.lblAmaun.caption)
        '                    If Bajet < 0 Then
        '                        MsgBox "Permohonan tidak diluluskan. Bajet tidak mencukupi."
        '                Exit Function
        '                    End If
        '                End If
        '            End If
        '        End If
        'Set rs1 = Nothing
        '-------------------------------------

        'UNTUK SIMPAN
        '    For i = 1 To Me.iGrid1.Rowcount
        '        NoTurutan = Me.iGrid1.CellValue(i, 10)
        '        If Me.iGrid1.CellValue(i, 1) = "Tidak Lulus" Then

        '    'DETAIL PERMOHONAN
        '    Set rs = myDB("UPDATE EOT01_MohonDT SET EOT01_JamMulaLulus='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatLulus='" & Me.iGrid1.CellValue(i, 4) & "', " & _
        '    " EOT01_JumJamLulus='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarLulus='" & Me.iGrid1.CellValue(i, 6) & "', " & _
        '    " EOT01_AmaunLulus='" & Me.iGrid1.CellValue(i, 7) & "',EOT01_OTPTJ='" & Left(Me.cmbPtj.Text, 6) & "', EOT01_StatusLulus='TL'," & _
        '    " EOT01_FlagLulus='1',EOT01_TkhLulus='" & Tarikh & "', EOT01_UlasanLulus='" & Me.iGrid1.CellValue(i, 9) & "', " & _
        '    " EOT01_JamMulaTerima='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatTerima='" & Me.iGrid1.CellValue(i, 4) & "', " & _
        '    " EOT01_JumJamTerima='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarTerima='" & Me.iGrid1.CellValue(i, 6) & "', " & _
        '    " EOT01_AmaunTerima='" & Me.iGrid1.CellValue(i, 7) & "', EOT01_StatusTerima='TT' WHERE EOT01_NoMohon='" & NoMohon & "' and EOT01_NoTurutan='" & NoTurutan & "'", adLockOptimistic)
        '    Set rs = Nothing

        'ElseIf Me.iGrid1.CellValue(i, 1) = "Lulus" Then

        '        'DETAIL PERMOHONAN
        '    Set rs = myDB("UPDATE EOT01_MohonDT SET EOT01_JamMulaLulus='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatLulus='" & Me.iGrid1.CellValue(i, 4) & "', " & _
        '    " EOT01_JumJamLulus='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarLulus='" & Me.iGrid1.CellValue(i, 6) & "', " & _
        '    " EOT01_AmaunLulus='" & Me.iGrid1.CellValue(i, 7) & "',EOT01_OTPTJ='" & Left(Me.cmbPtj.Text, 6) & "', EOT01_StatusLulus='L'," & _
        '    " EOT01_FlagLulus='1',EOT01_TkhLulus='" & Tarikh & "', EOT01_UlasanLulus='" & Me.iGrid1.CellValue(i, 9) & "', " & _
        '    " EOT01_JamMulaTerima='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatTerima='" & Me.iGrid1.CellValue(i, 4) & "', " & _
        '    " EOT01_JumJamTerima='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarTerima='" & Me.iGrid1.CellValue(i, 6) & "', " & _
        '    " EOT01_AmaunTerima='" & Me.iGrid1.CellValue(i, 7) & "', EOT01_StatusTerima='BT' WHERE EOT01_NoMohon='" & NoMohon & "' and EOT01_NoTurutan='" & NoTurutan & "'", adLockOptimistic)
        '    Set rs = Nothing

        'ElseIf Me.iGrid1.CellValue(i, 1) = "Belum Lulus" Then
        '        'DETAIL PERMOHONAN
        '    Set rs = myDB("UPDATE EOT01_MohonDT SET EOT01_JamMulaLulus='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatLulus='" & Me.iGrid1.CellValue(i, 4) & "', " & _
        '    " EOT01_JumJamLulus='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarLulus='" & Me.iGrid1.CellValue(i, 6) & "', " & _
        '    " EOT01_AmaunLulus='" & Me.iGrid1.CellValue(i, 7) & "',EOT01_OTPTJ='" & Left(Me.cmbPtj.Text, 6) & "', EOT01_StatusLulus='BL'," & _
        '    " EOT01_FlagLulus='1',EOT01_TkhLulus='" & Tarikh & "', EOT01_UlasanLulus='" & Me.iGrid1.CellValue(i, 9) & "', " & _
        '    " EOT01_JamMulaTerima='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatTerima='" & Me.iGrid1.CellValue(i, 4) & "', " & _
        '    " EOT01_JumJamTerima='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarTerima='" & Me.iGrid1.CellValue(i, 6) & "', " & _
        '    " EOT01_AmaunTerima='" & Me.iGrid1.CellValue(i, 7) & "', EOT01_StatusTerima='BT' WHERE EOT01_NoMohon='" & NoMohon & "' and EOT01_NoTurutan='" & NoTurutan & "'", adLockOptimistic)
        '    Set rs = Nothing
        'End If
        '    Next
        '----------------------------------------------------------------------





        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr set Status_Mohon =@staMohon WHERE No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@staMohon", "03"))
        param.Add(New SqlParameter("@No_Mohon", idnomohon))


        Return db.Process(query, param)

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSahEOT(id As String) As String
        Dim resp As New ResponseRepository

        If GetSahEOT(id) <> "OK" Then
            resp.Failed("Rekod Gagal disahkan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod telah disahkan")
        Return JsonConvert.SerializeObject(resp.GetResult())



    End Function

    Private Function GetSahEOT(idnomohon As String) As String
        If idnomohon = "" Then
            Exit Function
        End If

        'dari sistem client smkb ---

        'If Me.iGrid1.CellValue(i, 1) = "Tidak Terima" Then

        '        Set rs = myDB("UPDATE EOT01_Mohon SET EOT01_Gaji='" & gaji & "',EOT01_StatusMohon='04',EOT01_Samb='" & Me.lblTel.caption & "', " _
        '        & " EOT01_OTPtj='" & Left(Me.cmbPtj.Text, 6) & "' WHERE EOT01_NoMohon='" & NoMohon & "'", adLockOptimistic)
        '        Set rs = Nothing

        '        Set rs = myDB("UPDATE EOT01_MohonDT SET EOT01_NoStafTerima='" & RefPengguna & "',EOT01_OTPTJ='" & Left(Me.cmbPtj.Text, 6) & "',EOT01_TkhTerima='" & Tarikh & "', " _
        '        & " EOT01_UlasanTerima='" & Me.iGrid1.CellValue(i, 9) & "',EOT01_JamMulaTerima='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatTerima='" & Me.iGrid1.CellValue(i, 4) & "', " _
        '        & " EOT01_JumJamTerima='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarTerima='" & Me.iGrid1.CellValue(i, 6) & "',EOT01_AmaunTerima='" & Me.iGrid1.CellValue(i, 7) & "', " _
        '        & " EOT01_StatusTerima='TT' WHERE EOT01_NoMohon='" & NoMohon & "' and eot01_noturutan='" & NoTurutan & "'", adLockOptimistic)
        '        Set rs = Nothing

        '    ElseIf Me.iGrid1.CellValue(i, 1) = "Terima" Then

        '        Set rs = myDB("UPDATE EOT01_Mohon SET EOT01_Gaji='" & gaji & "',EOT01_StatusMohon='04',EOT01_Samb='" & Me.lblTel.caption & "', " _
        '        & " EOT01_OTPtj='" & Left(Me.cmbPtj.Text, 6) & "' WHERE EOT01_NoMohon='" & NoMohon & "'", adLockOptimistic)
        '        Set rs = Nothing

        '            'DETAIL PERMOHONAN
        '        Set rs = myDB("UPDATE EOT01_MohonDT SET EOT01_NoStafTerima='" & RefPengguna & "',EOT01_OTPTJ='" & Left(Me.cmbPtj.Text, 6) & "',EOT01_TkhTerima='" & Tarikh & "', " _
        '        & " EOT01_UlasanTerima='" & Me.iGrid1.CellValue(i, 9) & "',EOT01_JamMulaTerima='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatTerima='" & Me.iGrid1.CellValue(i, 4) & "', " _
        '        & " EOT01_JumJamTerima='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarTerima='" & Me.iGrid1.CellValue(i, 6) & "',EOT01_AmaunTerima='" & Me.iGrid1.CellValue(i, 7) & "', " _
        '        & " EOT01_StatusTerima='T' WHERE EOT01_NoMohon='" & NoMohon & "' and eot01_noturutan='" & NoTurutan & "'", adLockOptimistic)
        '        Set rs = Nothing

        '    ElseIf Me.iGrid1.CellValue(i, 1) = "Belum Terima" Then

        '        Set rs = myDB("UPDATE EOT01_Mohon SET EOT01_Gaji='" & gaji & "',EOT01_StatusMohon='04',EOT01_Samb='" & Me.lblTel.caption & "', " _
        '        & " EOT01_OTPtj='" & Left(Me.cmbPtj.Text, 6) & "' WHERE EOT01_NoMohon='" & NoMohon & "'", adLockOptimistic)
        '        Set rs = Nothing

        '            'DETAIL PERMOHONAN
        '        Set rs = myDB("UPDATE EOT01_MohonDT SET EOT01_NoStafTerima='" & RefPengguna & "',EOT01_OTPTJ='" & Left(Me.cmbPtj.Text, 6) & "',EOT01_TkhTerima='" & Tarikh & "', " _
        '        & " EOT01_UlasanTerima='" & Me.iGrid1.CellValue(i, 9) & "',EOT01_JamMulaTerima='" & Me.iGrid1.CellValue(i, 3) & "',EOT01_JamTamatTerima='" & Me.iGrid1.CellValue(i, 4) & "', " _
        '        & " EOT01_JumJamTerima='" & Me.iGrid1.CellValue(i, 5) & "',EOT01_KadarTerima='" & Me.iGrid1.CellValue(i, 6) & "',EOT01_AmaunTerima='" & Me.iGrid1.CellValue(i, 7) & "', " _
        '        & " EOT01_StatusTerima='BT' WHERE EOT01_NoMohon='" & NoMohon & "' and eot01_noturutan='" & NoTurutan & "'", adLockOptimistic)
        '        Set rs = Nothing

        '    End If


        '----------------



        Dim db As New DBKewConn

        Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr set Status_Mohon =@staMohon WHERE No_Mohon = @No_Mohon"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@staMohon", "03"))
        param.Add(New SqlParameter("@No_Mohon", idnomohon))

        db.Process(query, param)

        Dim query1 As String = "UPDATE SMKB_EOT_Mohon_Dtl set Status_Terima= @staTerima WHERE No_Mohon = @No_Mohon"
        Dim param1 As New List(Of SqlParameter)
        param1.Add(New SqlParameter("@Status_Terima", "BT"))
        param1.Add(New SqlParameter("@No_Mohon", idnomohon))

        'db.Process(query1, param1)

        Return db.Process(query1, param1)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFile() As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")

        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

            ' Specify the file path where you want to save the uploaded file
            Dim savePath As String = Server.MapPath("~/UPLOAD/EOT/" & fileName)


            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileTS() As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSuratTS")
        Dim fileName As String = HttpContext.Current.Request.Form("fileNameTS")

        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

            ' Specify the file path where you want to save the uploaded file
            Dim savePath As String = Server.MapPath("~/UPLOAD/EOT/" & fileName)


            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileNameTS") = fileName

            Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFileTSUpdt() As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSuratTS")
        Dim fileName As String = HttpContext.Current.Request.Form("fileNameTS")
        Dim NoMohon As String = HttpContext.Current.Request.Form("fileNoMohonTS")
        Dim NoArahan As String = HttpContext.Current.Request.Form("fileNoArahanTS")
        Dim Folder As String = "/UPLOAD/EOT/"
        Dim resp As New ResponseRepository

        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

            ' Specify the file path where you want to save the uploaded file
            Dim savePath As String = Server.MapPath("~/UPLOAD/EOT/" & fileName)


            ' Save the file to the specified path
            postedFile.SaveAs(savePath)

            ' Store the uploaded file name in session
            Session("UploadedFileNameTS") = fileName



            'Save into database
            If fileName <> "" Then


                If UpdateEOTHdr(NoArahan, NoMohon, fileName, Folder) <> "OK" Then
                    'sqlquery.rollback()
                    resp.Failed("Muatnaik fail tidak berjaya.")
                    Return JsonConvert.SerializeObject(resp.GetResult())

                Else
                    'sqlquery.finish()

                    resp.Failed("Muatnaik fail berjaya.")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                'sqlquery.rollback()
                resp.Failed("Muatnaik fail tidak berjaya.")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If

            'Return "&nbsp;&nbsp;File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetVotCOA(ByVal q As String, ByVal ptj As String) As String

        ' Dim kdptj As String = Session("ssusrKodPTj")
        Dim tmpDT As DataTable = GetKodCOAList(q, ptj)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodCOAList(kodCariVot As String, kptj As String) As DataTable
        Dim db = New DBKewConn
        '  AND a.Kod_PTJ = @ptj  
        Dim query As String = "SELECT   CONCAT(a.Kod_Vot, ' - ', vot.Butiran, ', ', a.Kod_Operasi, ' - ', ko.Butiran, ' , ', a.Kod_Projek, ' - ', kp.Butiran, ', ', a.Kod_Kump_Wang, ' - ', 
					REPLACE(kw.Butiran, 'KUMPULAN WANG', 'KW'), ', ', LEFT(a.Kod_PTJ,2), ' - ', mj.Pejabat) AS text,
                    a.Kod_Vot AS value ,
                    mj.Pejabat as colPTJ , kw.Butiran as colKW , ko.Butiran as colKO ,  kp.Butiran as colKp , 
                    a.Kod_PTJ as colhidptj , a.Kod_Kump_Wang as colhidkw , a.Kod_Operasi as colhidko , a.Kod_Projek as colhidkp
                    FROM SMKB_COA_Master AS a 
                    JOIN SMKB_Vot AS vot ON a.Kod_Vot = vot.Kod_Vot
                    JOIN SMKB_Operasi AS ko ON a.Kod_Operasi = ko.Kod_Operasi
                    JOIN SMKB_Kump_Wang AS kw ON a.Kod_Kump_Wang = kw.Kod_Kump_Wang
					JOIN SMKB_Projek as kp on kp.Kod_Projek = a.Kod_Projek
					JOIN VPejabat AS mj ON mj.status = '1' and mj.kodpejabat = left(a.Kod_PTJ,2) 
                    WHERE a.status = 1 and a.Kod_Vot = '14101'"

        Dim param As New List(Of SqlParameter)


        'param.Add(New SqlParameter("@ptj", kptj))
        If kodCariVot <> "" Then
            query &= "AND (a.Kod_Vot LIKE '%' + @kod + '%' OR a.Kod_Operasi LIKE '%' + @kod2 + '%' OR a.Kod_Projek LIKE '%' + @kod3 + '%' OR a.Kod_Kump_Wang LIKE '%' + @kod4 + '%' OR a.Kod_PTJ LIKE '%' + @kod5 + '%' OR vot.Butiran LIKE '%' + @kodButir + '%' OR ko.Butiran LIKE '%' + @kodButir1 + '%'  OR kw.Butiran LIKE '%' + @kodButir2 + '%' OR mj.pejabat LIKE '%' + @kodButir3 + '%') "

            param.Add(New SqlParameter("@kod", kodCariVot))
            param.Add(New SqlParameter("@kod2", kodCariVot))
            param.Add(New SqlParameter("@kod3", kodCariVot))
            param.Add(New SqlParameter("@kod4", kodCariVot))
            param.Add(New SqlParameter("@kod5", kodCariVot))
            param.Add(New SqlParameter("@kodButir", kodCariVot))
            param.Add(New SqlParameter("@kodButir1", kodCariVot))
            param.Add(New SqlParameter("@kodButir2", kodCariVot))
            param.Add(New SqlParameter("@kodButir3", kodCariVot))
            ' param.Add(New SqlParameter("@kptj", Session("ssusrKodPTj")))

        End If

        Return db.Read(query, param)
    End Function

    Public strConEmail As String = "Provider=SQLOLEDB;Driver={SQL Server};server=V-SQL12.utem.edu.my\SQL_INS02;database=dbKewangan;uid=Smkb;pwd=smkb*pwd;"

    Public Function myEmel(alamat, subject, body)
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
    Private Function SendEmail(noarahan As String, nostaf As String) As String

        Dim Email As String
        Dim Nama As String
        Dim TkhMula As Date
        Dim TkhTamat As Date
        Dim Lokasi As String
        Dim Penerangan As String

        Using dtUserInfo = fGetUserInfo(nostaf)
            If dtUserInfo.Rows.Count > 0 Then
                Nama = dtUserInfo.Rows.Item(0).Item("MS01_Nama")
                Email = dtUserInfo.Rows.Item(0).Item("MS01_Email")
            End If
        End Using


        Using dtUserInfoEOT = fGetEOTinfo(noarahan, nostaf)
            If dtUserInfoEOT.Rows.Count > 0 Then
                TkhMula = dtUserInfoEOT.Rows.Item(0).Item("Tkh_Mula")
                TkhTamat = dtUserInfoEOT.Rows.Item(0).Item("Tkh_Tamat")
                Lokasi = dtUserInfoEOT.Rows.Item(0).Item("Lokasi")
                Penerangan = dtUserInfoEOT.Rows.Item(0).Item("PeneranganK")
            End If
        End Using

        Nama = "Rozana binti Abu Bakar"
        Email = "rozana@utem.edu.my"

        ' Send the new password to the user's email
        Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
        Dim body As String = "Arahan Kerja " _
        & "<br><br>" _
        & vbCrLf & "Assalamualaikum Dan Salam Sejahtera " & Nama & "," _
        & "<br><br>" _
        & vbCrLf & "Sila buat permohonan EOT mengikut no arahan " & noarahan & "." _
        & "<br>" _
        & vbCrLf & "Keterangan adalah seperti tertera di bawah :-" _
        & "<br><br>" _
        & vbCrLf & "Tarikh : " & TkhMula & " sehingga " & TkhTamat & "" _
        & "<br>" _
        & vbCrLf & "Lokasi : " & Lokasi & "" _
        & "<br>" _
        & vbCrLf & "Tujuan : " & Penerangan & "" _
        & "<br><br>" _
        & vbCrLf & "Sila log masuk ke dalam UTeM - Sistem Maklumat Kewangan Bersepadu. " _
        & "<br>" _
        & vbCrLf & "Sila layari <a href='https://portal.utem.edu.my/iutem'>https://portal.utem.edu.my/iutem</a>" _
        & "<br><br>" _
        & vbCrLf & "Email ini dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " _
        & "<br><br>"

        myEmel(Email, subject, body)


    End Function


    Public Function fGetEOTinfo(noarahan, nostaf) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"SELECT No_Arahan, format(Tkh_Mula,'dd/MM/yyyy') as Tkh_Mula , format(Tkh_Tamat,'dd/MM/yyyy') as Tkh_Tamat,
                                Lokasi, PeneranganK FROM   SMKB_EOT_Arahan_Kerja_Hdr
                                WHERE (No_Arahan ='{noarahan}');"

        Using dt = dbconn.fselectCommandDt(strSql)
            Return dt
        End Using
    End Function


    Private Function SendEmailHantar(Noarahan As String, Nostaf As String, NoStafSah As String) As String
        Dim nama As String
        Dim email As String
        Dim KodSubMenu As String
        Dim clsCrypto As New clsCrypto
        Dim db As New DBKewConn

        Using dtUserInfo = fGetUserInfo(Nostaf)
            If dtUserInfo.Rows.Count > 0 Then
                nama = dtUserInfo.Rows.Item(0).Item("MS01_Nama")
            End If
        End Using

        Using dtUserInfo = fGetUserInfo(NoStafSah)
            If dtUserInfo.Rows.Count > 0 Then
                email = dtUserInfo.Rows.Item(0).Item("MS01_Email")
            End If
        End Using

        'set id pka
        Nostaf = "02634"
        'Nostaf = "00926"
        email = "syafiqah@utem.edu.my"
        'email = "rozana@utem.edu.my"
        KodSubMenu = "230401" 'pengesahan OT

        'create token
        Dim combineData = Nostaf + Now() + Noarahan
        ' Dim id = clsCrypto.fEncrypt(combineData)

        Dim id = Replace(Replace(Replace(clsCrypto.fEncrypt(combineData), "/", "@"), "+", "@"), "%", "@")

        Dim currentUrl As Uri = HttpContext.Current.Request.Url

        ' Construct the URL using the current request URL
        Dim url As String = currentUrl.Scheme & "://" & currentUrl.Authority & "/SMKBNet/loginsmkb?id=" & id


        'mula insert SMKB_Emel_Auth
        Dim paramSqlBtrn() As SqlParameter = Nothing
        Dim strSqlButiran = "INSERT INTO SMKB_Emel_Auth (ID_Token, No_Staf_Penerima, Emel_Penerima, Tarikh_Luput_URL, Kod_Sub_Menu, No_Rujukan)
                                            VALUES (@ID_Token, @No_Staf_Penerima, @Emel_Penerima, @Tarikh_Luput_URL, @Kod_Sub_Menu, @No_Rujukan)"
        paramSqlBtrn = {New SqlParameter("@ID_Token", id),
                                New SqlParameter("@No_Staf_Penerima", Nostaf),
                                New SqlParameter("@Emel_Penerima", email),
                                New SqlParameter("@Tarikh_Luput_URL", "2024-04-29"),
                                New SqlParameter("@Kod_Sub_Menu", KodSubMenu),
                                New SqlParameter("@No_Rujukan", Noarahan)
                            }


        If db.fInsertCommand(strSqlButiran, paramSqlBtrn) > 0 Then


            ' Send the new password to the user's email
            Dim subject As String = "UTeM - Sistem Maklumat Kewangan Bersepadu"
            Dim body As String = "Permohonan Elaun Lebih Masa " _
            & "<br><br>" _
            & vbCrLf & "Assalamualaikum Dan Salam Sejahtera " _
            & "<br><br>" _
            & vbCrLf & "Dimaklumkan bahawa, staf " & nama & " yang dibawah penyeliaan tuan/puan telah memohon tuntutan Elaun Lebih Masa melalui portal e-ot." _
            & vbCrLf & "Sehubungan dengan itu, dipohon kerjasama tuan/puan untuk menyokong atau meluluskan tuntutan" _
            & vbCrLf & "tersebut sekiranya tuan/puan berpuas hati dengan tuntutan kerja yang dibuat oleh staf seliaan tuan/puan." _
            & "<br><br>" _
            & vbCrLf & "Sila klik di link ini untuk menyemak transaksi bil untuk kelulusan melalui <a href=" + url + ">" + url + "</a>" _
            & "<br><br>" _
            & vbCrLf & "Email ini dijanakan secara automatik daripada UTeM - Sistem Maklumat Kewangan Bersepadu. " _
            & "<br><br>"

            myEmel(email, subject, body)
            fMobileNotis(id, Nostaf)
        Else
            db.sConnRollbackTrans()



        End If

    End Function


    Public Async Function fMobileNotis(id As String, NoStaff_Penerima As String) As Tasks.Task(Of String)
        Dim resp As New ResponseRepository
        Dim response = New Response
        Dim apiUrl As String = "https://devmobile.utem.edu.my/smkbnotification/api/notification/smkb/SISTEM MAKLUMAT KEWANGAN BERSEPADU/Kelulusan Tuntutan Kerja Lebih Masa.Memerlukan kelulusan anda untuk Tuntutan Kerja Lebih Masa./" + id + "/" + NoStaff_Penerima
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
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSessionData() As String
        Dim sessionData As String = Session("NoRujukan").ToString()
        Return sessionData
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function GetBaseUrl() As String
        Dim curUrl As Uri = HttpContext.Current.Request.Url
        Dim scheme As String = curUrl.Scheme
        Dim host As String = curUrl.Host
        Dim port As Integer = curUrl.Port
        Dim segments As String() = curUrl.Segments

        If port <> 80 Then
            host = host + ":" + port.ToString()
        End If

        Return scheme + "://" + host + "/" + segments(1) + "/"
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function HantarEOT(MohonEOT As MohonEOT) As String
        Dim resp As New ResponseRepository
        Dim NoMohon = MohonEOT.No_Mohon
        Dim NoStafSah = MohonEOT.No_Staf_Sah
        Dim NoStaf = MohonEOT.No_Staf
        'sqlquery = New Query
        If NoStafSah = "" Then
            Using dtUserInfo = fGetEOTInfo(NoMohon)
                If dtUserInfo.Rows.Count > 0 Then
                    NoStafSah = dtUserInfo.Rows.Item(0).Item("No_Staf_Sah")
                    NoStaf = dtUserInfo.Rows.Item(0).Item("No_Staf")
                End If
            End Using

        End If
        If UpdateHantarEOT(MohonEOT.No_Mohon, NoStaf, NoStafSah) <> "OK" Then
            'sqlquery.rollback()
            resp.Failed("Rekod Gagal dihantar")
            Return JsonConvert.SerializeObject(resp.GetResult())
        Else
            SendEmailHantar(MohonEOT.No_Mohon, NoStaf, NoStafSah)
            'sqlquery.finish()

            resp.Success("Rekod telah dihantar ke Penyelia untuk pengesahan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function
    Private Function UpdateHantarEOT(idMohon As String, noStaf As String, NoStafSah As String) As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn
        If idMohon = "" Then
            Exit Function
        End If

        Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr SET Status_Mohon = @StaMohon  WHERE No_Mohon = @idMohon and Status_Mohon =@lastStatus "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@StaMohon", "07"))
        param.Add(New SqlParameter("@idMohon", idMohon))
        param.Add(New SqlParameter("@lastStatus", "01"))

        'Return RbQueryCmd("No_Mohon", idMohon, query, param)
        Return db.Process(query, param)

    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function CetakEOT(MohonEOT As MohonEOT) As String
        Dim resp As New ResponseRepository

        If UpdateCetakEOT(MohonEOT.No_Mohon) <> "OK" Then
            resp.Failed("Status Cetak Gagal diKemaskini")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        ' resp.Success("Status Cetak telah dikemaskini.")
        Return JsonConvert.SerializeObject(resp.GetResult())

    End Function
    Private Function UpdateCetakEOT(idMohon As String) As String
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn
        If idMohon = "" Then
            Exit Function
        End If

        Dim query As String = "UPDATE SMKB_EOT_Mohon_Hdr SET Status_Cetak = @StaCetak  WHERE No_Mohon = @idMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@StaCetak", 1))
        param.Add(New SqlParameter("@idMohon", idMohon))


        Return db.Process(query, param)

    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fProsesGaji_EOT()
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim counter As Integer = 0
        Dim BulanGaji As Integer
        Dim TahunGaji As Integer
        Dim sqlComm As New SqlCommand
        Dim cmd = New SqlCommand
        Dim dt As New DataTable
        Dim problem As String = ""
        Dim dbconn As New DBKewConn
        'Dim query As New Query


        dt = dbconn.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            BulanGaji = dt.Rows(0).Item("bulan")
            TahunGaji = dt.Rows(0).Item("tahun")
        End If

        Dim strSql1 = "select count(*) from SMKB_Gaji_Tarikh_Gaji  where bulan =  '" & BulanGaji & "' and tahun =  '" & TahunGaji & "'"
        Dim intCnt1 As Integer = dbconn.fSelectCount(strSql1)
        If intCnt1 <= 0 Then
            resp.Failed("Proses gaji tidak boleh dilakukan lagi kerana Tarikh Gaji tidak lengkap!")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function
        End If


        Using sqlcon = New SqlConnection(strConn)
            sqlComm.Connection = sqlcon
            sqlComm.CommandTimeout = 600
            sqlComm.CommandText = "USP_PROSES_EOT_GAJI"
            sqlComm.CommandType = CommandType.StoredProcedure

            sqlComm.Parameters.Clear()

            sqlComm.Parameters.AddWithValue("@No_StafProseS", Session("ssusrID"))
            'sqlComm.Parameters.AddWithValue("@iBulan", BulanGaji)
            'sqlComm.Parameters.AddWithValue("@iTahun", TahunGaji)
            'sqlComm.Parameters.AddWithValue("@strStafDr", nostafDr)
            'sqlComm.Parameters.AddWithValue("@strStafHg", nostafHg)
            'sqlComm.Parameters.AddWithValue("@strPtjDr", ptjDr)
            'sqlComm.Parameters.AddWithValue("@strPtjHg", ptjHg)

            sqlcon.Open()

            'sqlComm.ExecuteNonQuery()
            'Dim rowsAffected As Integer = sqlComm.ExecuteNonQuery()
            Dim X = sqlComm.ExecuteNonQuery()
            If X > 0 Then
                success = 1
            Else

                success = 0
            End If
        End Using

        If success = 1 Then
            resp.Success("Rekod berjaya disimpan")
        Else
            resp.Failed("Rekod tidak berjaya disimpan")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBlnThnGaji()
        Dim db As New DBKewConn


        Dim query As String = $"select bulan,tahun,cast(bulan as varchar(2)) + '/' + cast(tahun as varchar(5)) as butir from SMKB_Gaji_bulan;"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Public Function fGetEOTInfo(NoMohon) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = $"select  DISTINCT a.No_Staf_Sah , b.No_Staf    from SMKB_EOT_Mohon_Dtl a inner join SMKB_EOT_Mohon_Hdr b
         on a.No_Mohon = b.No_Mohon    where a.No_Mohon = '{NoMohon}'"

        Using dt = dbconn.fselectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fGetRekodProsesGaji()
        Dim db As New DBKewConn


        Dim query As String = $"select count (distinct a.No_Mohon)  as JumRekod,isnull(SUM(b.AMAUN_TERIMA),0) AS JumAmaun from  SMKB_EOT_Mohon_Hdr a 
				inner join SMKB_EOT_Mohon_Dtl b on a.No_Mohon = b.No_Mohon where a.Status_Mohon = '04' and 
				b.Status_terima  = 'T' AND b.Status_Proses = 'BP'"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOTLulusDB(ByVal Tahun As String) As String
        Dim resp As New ResponseRepository

        dt = GetOTLulusDB(Tahun)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetOTLulusDB(Tahun As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "Select isnull(SUM(Amaun_Terima), 0) As JumOTTerima,tahun from smkb_eot_mohon_hdr a  inner join  SMKB_EOT_Mohon_Dtl b 
                On a.No_Mohon = b.No_Mohon where a.status_mohon in ('05') and tahun = @Tahun
				And Status_Proses = 'P' group by Tahun order by Tahun"

        param.Add(New SqlParameter("@Tahun", Tahun))


        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOTBlmLulusDB(ByVal Tahun As String) As String
        Dim resp As New ResponseRepository

        dt = GetOTBlmLulusDB(Tahun)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetOTBlmLulusDB(Tahun As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select isnull(SUM(Amaun_Terima),0) AS JumOTBelumTerima,year(a.Tkh_Mohon) as TahunMohon from smkb_eot_mohon_hdr a  inner join  SMKB_EOT_Mohon_Dtl b 
				on a.No_Mohon = b.No_Mohon where a.status_mohon not in ('05','06') and year(a.tkh_mohon) = @Tahun
				 group by year(a.tkh_mohon) order by year(a.tkh_mohon)"

        param.Add(New SqlParameter("@Tahun", Tahun))
        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPiechtJumMohonOT() As String
        Dim resp As New ResponseRepository

        dt = GetOTPiechtJumMohonOT()
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetOTPiechtJumMohonOT() As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "SELECT  count(No_Mohon) as JumMohon, year(Tkh_Mohon) as Tahun  FROM SMKB_EOT_Mohon_Hdr  WHERE  year(Tkh_Mohon) >=  YEAR(GETDATE()) - 5  group by  year(Tkh_Mohon) 
        order by year(Tkh_Mohon) "

        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPiechtJumMohonOTBulan(Tahun As String) As String
        Dim resp As New ResponseRepository

        dt = GetOTPiechtJumMohonOTBulan(Tahun)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetOTPiechtJumMohonOTBulan(Tahun As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select * from (
         SELECT 1 as indM, 'Jan' AS Month, COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '1' THEN a.No_Mohon END) AS Total FROM SMKB_EOT_Mohon_DTL a WHERE YEAR(a.tkh_tuntut) =@Tahun
        UNION
        SELECT 2,'Feb', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '2' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun 
        UNION
        SELECT 3,'Mar', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '3' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 4,'Apr', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '4' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 5,'May', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '5' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 6,'Jun', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '6' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 7,'Jul', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '7' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 8,'Aug', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '8' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 9,'Sep', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '9' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 10,'Oct', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '10' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 11,'Nov', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '11' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun
        UNION
        SELECT 12 ,'Dec', COUNT(CASE MONTH(a.Tkh_Tuntut) WHEN '12' THEN a.No_Mohon END) FROM SMKB_EOT_Mohon_DTL a inner join  SMKB_EOT_Mohon_Hdr b on a.No_Mohon = b.No_Mohon WHERE b.Status_Mohon not in ('06') and YEAR(a.tkh_tuntut) = @Tahun ) b
        order by b.indM"

        param.Add(New SqlParameter("@Tahun", Tahun))

        Return db.Read(query, param)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadlinechtJumMohonOPTJ(Tahun As String) As String
        Dim resp As New ResponseRepository

        dt = GetLoadlinechtJumMohonOPTJ(Tahun)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetLoadlinechtJumMohonOPTJ(Tahun As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "select b.KodPejabat, b.Singkatan as Pejabat, (select count(*) as JumPmhn from SMKB_EOT_Mohon_Hdr a inner join vperibadi12 c
		on a.No_Staf = c.nostaf  inner join SMKB_EOT_Mohon_DTL d on a.No_Mohon= d.No_Mohon 
		where  c.kodpejabat = b.KodPejabat and a.Status_Mohon not in ('06') and year(d.Tkh_Tuntut) = @Tahun)as Jumphmn from 
		(select a.KodPejabat, a.Singkatan from VPejabat a where status = 1 and a.kodPejabat <> '-'
		) b  
		group by b.KodPejabat, b.Singkatan
		order by b.Kodpejabat"
        param.Add(New SqlParameter("@Tahun", Tahun))

        Return db.Read(query, param)

    End Function



    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fnLaporanOTInd(ByVal NoMohon As String) As String
        Dim resp As New ResponseRepository

        dt = GetLaporanOTInd(NoMohon)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetLaporanOTInd(NoMohon As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)



        Dim query As String = "select a.No_Mohon,b.Jum_Jam_Tuntut,b.Kadar_Tuntut, b.Amaun_Tuntut , b.Jum_Jam_Sah,b.Kadar_Sah, b.Amaun_Sah,
				b.Jum_Jam_Lulus,b.Kadar_Lulus, b.Amaun_Lulus,b.Jum_Jam_Terima,b.Kadar_Terima, b.Amaun_Terima
				from SMKB_EOT_Mohon_Hdr a inner join SMKB_EOT_Mohon_Dtl  b
				on a.No_Mohon = b.No_Mohon  WHERE a.No_Mohon = @NoMohon"

        param.Add(New SqlParameter("@NoMohon", NoMohon))


        Return db.Read(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadKemaskiniOT(ByVal NoStaf As String) As String
        Dim resp As New ResponseRepository

        dt = GetKemaskiniOT(NoStaf)
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetKemaskiniOT(NoStaf As String) As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)


        Dim query As String = "Select d.No_Mohon,d.No_Arahan,d.No_Staf, d.Nama,d.Tkh_Mohon,d.Tkh_Tuntut, RIGHT('00' + CAST(SUM(d.Jam) / 60 AS VARCHAR(2)), 2) + ':' +
        Right('00' + CAST(SUM(d.Jam) % 60 AS VARCHAR(2)), 2) AS Jam,d.AmaunTuntut  from(
        Select b.No_Mohon,a.No_Arahan,  a.No_Staf, c.ms01_nama As Nama, Format(a.Tkh_Mohon, 'dd/MM/yyyy') as Tkh_Mohon, 
		Format(b.Tkh_Tuntut, 'dd/MM/yyyy') as Tkh_Tuntut,
        sum(Convert(Int, substring(b.jum_jam_sah, 1, 2)) * 60 + Convert(Int, substring(b.jum_jam_sah, 3, 2))) As Jam, 
        sum(b.Amaun_Sah) As AmaunTuntut
        From SMKB_EOT_Mohon_Hdr a INNER Join
        SMKB_EOT_Mohon_Dtl b ON a.No_Mohon = b.No_Mohon
        inner Join VPeribadi c on c.ms01_nostaf = a.no_staf
        WHERE (a.Status_Mohon='01')
        And a.No_Staf = @NoStaf
        Group BY b.No_Mohon,a.No_Arahan, a.No_Staf, c.ms01_nama, a.Tkh_Mohon, b.Tkh_Tuntut) d
        Group by d.No_Mohon,d.No_Arahan, d.No_Staf, d.Nama, d.Tkh_Mohon, d.Jam, d.AmaunTuntut,d.Tkh_Tuntut order by d.Tkh_Mohon desc"

        param.Add(New SqlParameter("@NoStaf", NoStaf))


        Return db.Read(query, param)
    End Function



    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenGajiOT() As String
        Dim resp As New ResponseRepository

        dt = GetSenGajiOT()
        'resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function GetSenGajiOT() As DataTable
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        ' [qa11].dbstaf.dbo.

        Dim query As String = "select a.No_Mohon ,a.No_Staf,c.nama,c.singkat, c.jgiliran, isnull(sum(b.Amaun_Terima),0) as Amaun_Terima from  SMKB_EOT_Mohon_Hdr a 
			inner join SMKB_EOT_Mohon_Dtl b on a.No_Mohon = b.No_Mohon 
			inner join vperibadi12 c on a.No_Staf = c.nostaf
			where a.Status_Mohon = '04' and 
			b.Status_terima  = 'T' AND b.Status_Proses = 'BP'
			group by a.No_Mohon,a.No_Staf,c.nama,c.singkat, c.jgiliran"

        Return db.Read(query, param)
    End Function


    '    <WebMethod(EnableSession:=True)>
    '    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    '    Public Function RbQueryCmd(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
    '        'MODUL PINJAMAN
    '        Dim cmd As New SqlCommand
    '        cmd.CommandText = strQuery

    '        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
    '            For Each parameter As SqlParameter In paramDt
    '                Dim paramName As String = parameter.ParameterName.ToString()
    '                Dim paramValue As Object = parameter.Value
    '                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
    '            Next
    '        End If

    '        If sqlquery.execute(idValue, idKey, cmd) < 0 Then
    '            Return "X"
    '        Else
    '            Return "OK"
    '        End If
    '    End Function

    '    <WebMethod(EnableSession:=True)>
    '    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    '    Public Function RbQueryCmdMulti(idKey As Dictionary(Of String, String), strQuery As String, paramDt As List(Of SqlParameter)) As String
    '        'MODUL PINJAMAN
    '        Dim cmd As New SqlCommand
    '        cmd.CommandText = strQuery

    '        Dim key As New Dictionary(Of String, String)

    '        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
    '            For Each parameter As SqlParameter In paramDt
    '                Dim paramName As String = parameter.ParameterName.ToString()
    '                Dim paramValue As Object = parameter.Value
    '                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
    '            Next
    '        End If

    '        Return If(sqlquery.execute(idKey, cmd) < 0, "X", "OK")
    '    End Function


End Class

