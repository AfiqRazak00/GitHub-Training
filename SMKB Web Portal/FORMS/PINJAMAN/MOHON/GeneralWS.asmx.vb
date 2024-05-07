Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System
Imports System.Collections.Generic
Imports Newtonsoft.Json.Linq
Imports System.Reflection


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class GeneralWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBadanKenderaan(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataBadanKenderaan(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataBadanKenderaan(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM02"))

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBahanBakar(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataBahanBakar(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataBahanBakar(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM03"))

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisPinjaman(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataJenisPinjaman(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisPinjaman(q As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select Kod_Detail As value, Butiran As text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'
                                And Kod_Detail IN ('J00001','J00002','J00003','J00004')"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM01"))

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenamaKenderaan(ByVal data As String, ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataJenamaKenderaan(data, q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenamaKenderaan(ByVal id As String, ByVal q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1' "

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM05"))

        If Not String.IsNullOrEmpty(id) Then
            Dim kodKenderaan As String = ""
            If id = "J00001" Or id = "J00002" Then
                kodKenderaan = "jk"
            Else
                kodKenderaan = "jm"
            End If
            query &= $" And Kod_Detail Like '{kodKenderaan}%' "
        End If

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        dtbl2 = db.Read(query, param)

        If Not String.IsNullOrEmpty(id) Then
            If dtbl2.Rows.Count > 0 Then
                For Each row As DataRow In dtbl2.Rows
                    resultTable.Rows.Add(row.Item("text"), row.Item("value"))
                Next
            Else
                resultTable.Rows.Add("-", "-")
            End If
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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetModelKenderaan(ByVal data As String, ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataModelKenderaan(data, q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataModelKenderaan(ByVal id As String, ByVal q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail where Kod = @kod and status = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM19"))

        If Not String.IsNullOrEmpty(id) Then
            query &= " AND (Kod_Detail LIKE @kod3) "
            param.Add(New SqlParameter("@kod3", "%" & id))
        End If

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Butiran LIKE @kod2) "
            param.Add(New SqlParameter("@kod2", "%" & q & "%"))
        End If

        dtbl2 = db.Read(query, param)

        If Not String.IsNullOrEmpty(id) Then
            If dtbl2.Rows.Count > 0 Then
                For Each row As DataRow In dtbl2.Rows
                    resultTable.Rows.Add(row.Item("text"), row.Item("value"))
                Next
            Else
                resultTable.Rows.Add("-", "-")
            End If
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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSukatSilinder(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataSukatSilinder(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataSukatSilinder(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM04"))

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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKelasKenderaan(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataKelasKenderaan(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataKelasKenderaan(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1' "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "PJM16"))

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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSyarikat(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataSyarikat(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataSyarikat(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn
        Dim query As String = " SELECT ID_Sykt as value, 
                                Nama_Sykt as text 
                                FROM SMKB_Syarikat_Master 
                                WHERE Status_Sykt_Pinjam = '1' and 
                                STATUS = '1' "
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(q) Then
            query &= $" AND Nama_Sykt LIKE '%{q}%'"
        End If

        dtbl2 = db.Read(query, param)

        If dtbl2.Rows.Count > 0 Then
            Return dtbl2
        Else
            Dim resultTable As New DataTable()
            resultTable.Columns.Add("value", GetType(String))
            resultTable.Columns.Add("text", GetType(String))
            resultTable.Rows.Add("-", "-")
            Return resultTable
        End If

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTempohBayarBalik(ByVal data As String, ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataTempohBayarBalik(data, q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataTempohBayarBalik(ByVal data As String, ByVal q As String) As DataTable
        Dim result As Integer
        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(Integer))

        Dim divisor As Integer = 6

        Dim db As New DBKewConn
        Dim query As String = "Select top 1 * from SMKB_Pinjaman_Kelayakan WHERE Jenis_Pinj = @kod And Status = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", data))

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
            'filteredRows.CopyToDataTable(filteredTable, LoadOption.PreserveChanges)
            'For Each row As DataRow In filteredRows
            '    filteredTable.ImportRow(row)
            'Next
        End If

        Return filteredTable

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJumlahMohon(ByVal data As String, ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataJumlahMohon(data, q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJumlahMohon(ByVal data As String, ByVal q As String) As DataTable
        Dim result As Integer
        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))
        resultTable.Columns.Add("sort", GetType(Integer))

        Dim divisor As Integer = 100

        Dim db As New DBKewConn
        Dim query As String = "Select top 1 * from SMKB_Pinjaman_Kelayakan WHERE Jenis_Pinj = @kod And Status = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", data))

        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            result = CInt(dtbl.Rows(0).Item("Max_Amaun")) / divisor
            For i As Integer = 1 To result
                Dim numericValue As Integer = i * divisor
                resultTable.Rows.Add(numericValue.ToString("N0"), numericValue.ToString(), numericValue)
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
            'filteredRows.CopyToDataTable(filteredTable, LoadOption.PreserveChanges)
            'For Each row As DataRow In filteredRows
            '    filteredTable.ImportRow(row)
            'Next
        End If

        Return filteredTable

    End Function

    <WebMethod(EnableSession:=False)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetMaklumatSyarikat(ByVal id As String) As String
        Dim dbconn As New DBKewConn
        Dim strSql = $"Select 
                        No_Sykt as NoSykt,
                        Nama_Sykt as NmSykt,
                        Almt_Semasa_1 as Almt1,
                        Almt_Semasa_2 as Almt2,
                        Poskod_Semasa as Poskod,
                        (Select Butiran From SMKB_Lookup_Detail Where Kod_Detail = Bandar_Semasa And Kod In ('0003')) As Bandar,
                        (Select Butiran From SMKB_Lookup_Detail Where Kod_Detail = Kod_Negeri_Semasa And Kod In ('0002')) As Negeri, 
                        (Select Butiran From SMKB_Lookup_Detail Where Kod_Detail = Kod_Negara_Semasa And Kod In ('0001')) As Negara
                        From SMKB_Syarikat_Master 
                        Where ID_Sykt = '{id}'"
        Using dtUserInfo = dbconn.fSelectCommandDt(strSql)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Return 0
            End If
        End Using
    End Function

    <WebMethod(EnableSession:=False)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetMaklumatPenjamin(ByVal id As String) As String
        Dim resultTable As New DataTable()

        resultTable.Columns.Add("Nama", GetType(String))
        resultTable.Columns.Add("NoKp", GetType(String))
        resultTable.Columns.Add("TkhLahir", GetType(String))
        resultTable.Columns.Add("Jawatan", GetType(String))
        resultTable.Columns.Add("TkhSah", GetType(String))
        resultTable.Columns.Add("Alamat", GetType(String))

        Dim dbconn As New DBSMConn
        Dim db As New DBKewConn

        Dim strSql = $"SELECT MS01_Nama As Nama, 
                        MS01_KpB As NoKp,
                        MS01_TkhLahir As TkhLahir,
                        MS02_JawSandang, (SELECT JawGiliran FROM MS_Jawatan WHERE KodJawatan = MS02_JawSandang) AS Jawatan,
                        MS02_TkhSah As TkhSah
                        FROM MS01_Peribadi
                        INNER JOIN MS02_Perjawatan ON MS01_Peribadi.MS01_NoStaf = MS02_Perjawatan.MS01_NoStaf
                        Where MS01_Peribadi.MS01_NoStaf = '{id}'
                        And MS01_Status = 1"

        Dim strSql2 = $"Select Nama, Almt1,Almt2,Bandar,Poskod, 
                        (Select Butiran From SMKB_Lookup_Detail Where Kod_Detail = Kod_Negeri And Kod In ('0002')) As Negeri, 
                        (Select Butiran From SMKB_Lookup_Detail Where Kod_Detail = Kod_Negara And Kod In ('0001')) As Negara
                        From SMKB_Korporat"

        Using dtUserInfo = dbconn.fselectCommandDt(strSql)
            If dtUserInfo.Rows.Count > 0 Then
                dtbl = db.fSelectCommandDt(strSql2)
                resultTable.Rows.Add(ExtRow(dtUserInfo, "Nama"),
                                     ExtRow(dtUserInfo, "NoKp"),
                                     ExtRow(dtUserInfo, "TkhLahir"),
                                     ExtRow(dtUserInfo, "Jawatan"),
                                     ExtRow(dtUserInfo, "TkhSah"),
                                     ExtRow(dtbl, "Nama") & ", " & ExtRow(dtbl, "Almt1") & ", " & ExtRow(dtbl, "Almt2") & ", " & ExtRow(dtbl, "Bandar") & ", " & ExtRow(dtbl, "Poskod") & ", " & ExtRow(dtbl, "Negeri") & ", " & ExtRow(dtbl, "Negara"))
                Return JsonConvert.SerializeObject(resultTable)
            Else
                Return 0
            End If
        End Using
    End Function

    Public Function ExtRow(table As DataTable, colName As String) As String
        Return table.Rows(0).Item(colName)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSenaraiPotonganStaf(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)
        Dim dtbl2 As New DataTable()
        Dim resultTable As New DataTable()

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        'Check Row, Ada: Update, Xde: Insert
        Dim query As String = $"Select 
                                Amaun,b.Butiran
                                From SMKB_Gaji_Master a, SMKB_Gaji_Kod_Trans b 
                                Where No_Staf = '{Session("ssusrID")}' AND (a.Jenis_Trans = 'P' OR a.Kod_Trans IN ('KWSP','SOCP','TAX'))
                                AND a.Kod_Trans = b.Kod_Trans AND Tkh_Tamat > CURRENT_TIMESTAMP AND Status = 'A'"
        Dim query2 As String = $"Select 
                                SUM(Amaun) As TotalAmaun
                                From SMKB_Gaji_Master a, SMKB_Gaji_Kod_Trans b 
                                Where No_Staf = '{Session("ssusrID")}' AND (a.Jenis_Trans = 'P' OR a.Kod_Trans IN ('KWSP','SOCP','TAX'))
                                AND a.Kod_Trans = b.Kod_Trans AND Tkh_Tamat > CURRENT_TIMESTAMP AND Status = 'A'"

        dtbl = db.Read(query, param)
        dtbl2 = db.Read(query2, param)

        If dtbl.Rows.Count > 0 Then
            resultDt("ArrData") = dtbl
            resultDt("TotalAmaun") = dtbl2.Rows(0).Item("TotalAmaun")
            resp.Success("Rekod Ditemui", "00", resultDt)
        Else
            resp.Failed("Tiada Rekod Ditemui")
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Public Function fGetUserDetails(strStaffID) As DataTable
        Dim dbconn As New DBSMConn
        Dim strSql As String = $"Select a.MS01_Nama as Nama, 
                                a.MS01_NoStaf as NoStaf,
                                a.MS01_KpB as NoKp,
                                DATEDIFF(YEAR, CONVERT(DATE, a.MS01_TkhLahir, 103), GETDATE()) -
                                        IIF(MONTH(CONVERT(DATE, a.MS01_TkhLahir, 103)) > MONTH(GETDATE()) OR 
                                            (MONTH(CONVERT(DATE, a.MS01_TkhLahir, 103)) = MONTH(GETDATE()) AND 
                                             DAY(CONVERT(DATE, a.MS01_TkhLahir, 103)) > DAY(GETDATE())), 1, 0) AS AgeYear,
                                DATEDIFF(MONTH, CONVERT(DATE, a.MS01_TkhLahir, 103), GETDATE()) % 12 AS AgeMonth,
                                a.MS01_TkhLahir as TkhLahir, 
                                e.Pejabat, 
                                e.KodPejabat, 
                                d.MS08_Bahagian as Bahagian, 
								f.KodTarafKhidmat,
                                f.TarafKhidmat,
                                d.MS08_Unit as Unit, 
                                a.MS01_Email as Email, 
                                c.JawGiliran,
								b.MS02_Kumpulan As Kumpulan,
                                b.MS02_GredGajiS as GredGajiS,
                                a.MS01_TelPejabat as NoTel,
                                a.MS01_NoTelBimbit as NoHp,
                                b.MS02_JumlahGajiS as GajiS,
                                a.MS01_NoLesen as NoLesen,
                                a.MS01_KelasLesen as KelasLesen,
                                FORMAT(b.MS02_TkhLantikKUTKM, 'dd/MM/yyyy') as TkhLantik,
                                b.MS02_TkhSah as TkhSah,
                                a.MS01_AlamatSurat1 as AlamatSurat1,
                                a.MS01_AlamatSurat2 as AlamatSurat2,
                                a.MS01_PoskodSurat as PoskodSurat,
                                (Select NamaNegeri From MS_Negeri Where KodNegeri = a.MS01_NegeriSurat) As Negeri,
                                (Select NamaNegara From MS_Negara Where KodNegara = a.MS01_NegaraSurat) As Negara
                                FROM MS01_Peribadi a, 
                                ms02_perjawatan b, 
                                MS_Jawatan c,
                                MS08_Penempatan d, 
                                MS_Pejabat e,
                                MS_TarafKhidmat f
                                WHERE a.MS01_NoStaf = '{strStaffID}'
                                AND b.MS01_NoStaf = a.MS01_NoStaf
                                AND b.ms02_jawsandang = c.KodJawatan
                                AND e.KodPejabat = d.MS08_Pejabat
                                AND d.MS01_NoStaf = a.MS01_NoStaf
                                ANd f.KodTarafKhidmat = b.MS02_Taraf
                                AND d.MS08_StaTerkini = 1"

        Using dt = dbconn.fselectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchUserDetails() As String
        Using dtUserInfo = fGetUserDetails(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            End If
        End Using
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPenjamin(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataPenjamin(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataPenjamin(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBSMConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT a.MS01_NoStaf As value, 
                                b.MS01_Nama As text
                                FROM MS02_Perjawatan a, 
                                MS01_Peribadi b
                                WHERE 
                                a.MS01_NoStaf = b.MS01_NoStaf AND
                                MS02_Taraf IN ('02') 
                                AND (SUBSTRING(MS02_GredGajiS, 3, 2) >= '27'
                                AND (SUBSTRING(MS02_GredGajiS, 1, 1) <> 'V'))"

        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(q) Then
            query &= "AND (MS01_Nama LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & q & "%"))
        End If

        query &= " Order By MS01_Nama"

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
End Class

'idmodem
'idkadbunyi
'idcakeracd
'idtetikus
'idhargaperanti