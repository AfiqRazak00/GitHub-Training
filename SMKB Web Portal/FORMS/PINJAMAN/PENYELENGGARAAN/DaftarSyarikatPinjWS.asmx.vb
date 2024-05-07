Imports System.ComponentModel
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
Imports System.Data.Entity.Core
Imports System.Collections.Generic
Imports System

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class DaftarSyarikatPinjWS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dtbl As DataTable
    Dim queryRB As New Query()

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FetchSenaraiSyarikatPinjaman() As String
        'Dim dok As New List(Of String) From {"03"}
        Dim req As Response = FetchDataSenaraiSyarikatPinjaman()
        Return JsonConvert.SerializeObject(req)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function FetchDataSenaraiSyarikatPinjaman() As Response
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Dim res As New Response
        res.Code = 200
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                Dim sqlText As String = $"SELECT ROW_NUMBER() OVER (ORDER BY ID_Sykt) AS RowNum,
                                        ID_Sykt As IdPembekal,
                                        Nama_Sykt As NamaSykt,
                                        CASE WHEN Status_Sykt_Pinjam = 1 THEN 'Ya' ELSE 'Tidak' END As StatusSyktPinj,
                                        CASE WHEN Syarikat_Insurans = 1 THEN 'Ya' ELSE 'Tidak' END As StatusSyktIns,
                                        CASE WHEN Status = 1 THEN 'Aktif' ELSE 'Tidak Aktif' END As StatusAktif
                                        From SMKB_Syarikat_Master"

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

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetBandar(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataBandar(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataBandar(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "0003"))

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
    Public Function GetPoskod(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataPoskod(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataPoskod(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "0079"))

        If Not String.IsNullOrEmpty(q) Then
            query &= " AND (Kod_Detail LIKE @kod2) "
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
    Public Function GetNegeri(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataNegeri(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataNegeri(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, UPPER(Butiran) as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "0002"))

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
    Public Function GetNegara(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataNegara(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataNegara(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, UPPER(Butiran) as text FROM SMKB_Lookup_Detail WHERE Kod = @kod and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "0001"))

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
    Public Function GetBank(ByVal q As String) As String
        Dim tmpDT As DataTable = GetDataBank(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataBank(q As String) As DataTable
        Dim dtbl2 As DataTable
        Dim db As New DBKewConn

        Dim resultTable As New DataTable()

        resultTable.Columns.Add("text", GetType(String))
        resultTable.Columns.Add("value", GetType(String))

        Dim query As String = "SELECT Kod_Detail as value, Butiran as text FROM SMKB_Lookup_Detail WHERE Kod IN(@kod) and STATUS = '1'"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@kod", "0150"))

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
    Function GetSelectedRow(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        Dim query As String = $"SELECT 
                            No_Sykt As NoSykt,
                            Nama_Sykt As NamaSykt,
                            Almt_Semasa_1 As Almt1,
                            Almt_Semasa_2 As Almt2,
                            Bandar_Semasa As KodBandar,
                            (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0003' And Kod_Detail = Bandar_Semasa) As TxtBandar, 
                            Poskod_Semasa As KodPoskod,
                            Poskod_Semasa As TxtPoskod,
                            Kod_Negeri_Semasa As KodNegeri,
                            UPPER((Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0002' And Kod_Detail = Kod_Negeri_Semasa)) As TxtNegeri,
                            Kod_Negara_Semasa As KodNegara,
                            (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = '0001' And Kod_Detail = Kod_Negara_Semasa) As TxtNegara,
                            Kod_Bank As KodBank,
                            (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod In('0150') And Kod_Detail = Kod_Bank) As TxtBank,
                            No_Akaun As NoAkaun,
                            Tel_Pej_Semasa As NoTelPej,
                            Emel_Semasa As Emel,
                            Status_Sykt_Pinjam As StatusSyktPinj,
                            Syarikat_Insurans As StatusSyktIns,
                            Status As StatusAktif
                            From SMKB_Syarikat_Master Where ID_Sykt = '{postDt("id")}'"

        dtbl = db.Read(query)

        If dtbl.Rows.Count > 0 Then
            resp.Success("Rekod ditemui", "00", dtbl)
        Else
            resp.Failed("Tiada rekod ditemui")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function KemaskiniData(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim resp As New ResponseRepository
        Dim db As New DBKewConn

        queryRB = New Query()
        Dim query As String = $"UPDATE SMKB_Syarikat_Master
                    Set No_Sykt = '{postDt("NoSykt")}', Nama_Sykt = '{postDt("NamaSykt")}', Almt_Semasa_1 = '{postDt("Alamat1")}', Almt_Semasa_2 = '{postDt("Alamat2")}', Bandar_Semasa = '{postDt("Bandar")}', 
                    Poskod_Semasa = '{postDt("Poskod")}', Kod_Negeri_Semasa = '{postDt("Negeri")}', Kod_Negara_Semasa = '{postDt("Negara")}', Kod_Bank = '{postDt("Bank")}', 
                    No_Akaun = '{postDt("NoAcc")}', Tel_Pej_Semasa = '{postDt("Tel")}', Emel_Semasa = '{postDt("Emel")}', Status_Sykt_Pinjam = '{postDt("StatusSyktPinj")}',
                    Syarikat_Insurans = '{postDt("StatusSyktIns")}', Status = '{postDt("StatusAktif")}'
                    Where ID_Sykt = '{postDt("Id")}'"

        ' Update SMKB_Pinjaman_Kelayakan
        If RbQueryCmd("ID_Sykt", postDt("Id"), query, param) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Maklumat kelayakan gagal di simpan")
        Else
            queryRB.finish()

            Dim query2 As String = $"Select Nama_Sykt As NamaSykt,
                    CASE WHEN Status_Sykt_Pinjam = 1 THEN 'Ya' ELSE 'Tidak' END As StatusSyarikatPinj,
                    CASE WHEN Syarikat_Insurans = 1 THEN 'Ya' ELSE 'Tidak' END As StatusSyarikatInsuran,
                    CASE WHEN Status = 1 THEN 'Aktif' ELSE 'Tidak Aktif' END As StatusAktif
                    From SMKB_Syarikat_Master Where ID_Sykt = '{postDt("Id")}'"

            dtbl = db.Read(query2, param)

            resp.Success("Data berjaya di kemaskini", "00", dtbl)
        End If

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function TambahData(postData As String) As String
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)
        Dim param As New List(Of SqlParameter)
        Dim db As New DBKewConn
        Dim resp As New ResponseRepository
        Dim dtbl2 As DataTable

        'Check Jenis_Pinj Is Available Or Not

        'Dim query As String = $"Select * From SMKB_Syarikat_Master Where No_Sykt = '{}'"

        'dtbl = db.Read(query, param)

        'If dtbl.Rows.Count > 0 Then

        'resp.Failed("Maklumat gagal disimpan, rekod telah wujud")

        'Else

        ' Generate New Prefix
        Dim NewIdSykt As String = GenerateSyarikatID()

        queryRB = New Query()
        Dim query3 As String = $"INSERT INTO SMKB_Syarikat_Master
                (ID_Sykt, No_Sykt, Nama_Sykt, Almt_Semasa_1, Almt_Semasa_2, Bandar_Semasa, Poskod_Semasa, Kod_Negeri_Semasa, Kod_Negara_Semasa, Kod_Bank, No_Akaun,
                Tel_Pej_Semasa, Emel_Semasa, Status_Sykt_Pinjam, Syarikat_Insurans, Status) 
                VALUES ('{NewIdSykt}','{postDt("NoSykt")}','{postDt("NamaSykt")}','{postDt("Alamat1")}','{postDt("Alamat2")}','{postDt("Bandar")}', '{postDt("Poskod")}', '{postDt("Negeri")}', 
                '{postDt("Negara")}', '{postDt("Bank")}', '{postDt("NoAcc")}', '{postDt("Tel")}', '{postDt("Emel")}', '{postDt("StatusSyktPinj")}', '{postDt("StatusSyktPinj")}', '{postDt("StatusAktif")}')"

        If RbQueryCmd("ID_Sykt", NewIdSykt, query3, param) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Maklumat syarikat pembiayaan gagal di simpan")
        Else
            queryRB.finish()
            resp.Success("Maklumat berjaya di disimpan", "00")
        End If

        'End If
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GenerateSyarikatID() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newSyarikatID As String = ""

        Dim query As String = "SELECT TOP 1 No_Akhir as id, Tahun as tahun FROM SMKB_No_Akhir WHERE Kod_Modul ='20' AND Prefix ='RC'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dtbl = db.Read(query, param)

        queryRB = New Query()
        If dtbl.Rows.Count > 0 Then
            lastID = CInt(dtbl.Rows(0).Item("id")) + 1
            Dim resultId As String = UpdateNoAkhir("20", "RC", dtbl.Rows(0).Item("tahun"), lastID)
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        Else
            Dim resultId As String = InsertNoAkhir("20", "RC", year, lastID)
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        End If
        queryRB.finish()
        'newSyarikatID = "RC" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)
        newSyarikatID = "RC" + Format(lastID, "000000").ToString

        Return newSyarikatID
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

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "SYARIKAT"))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))

        Dim key As New Dictionary(Of String, String)
        key.Add("No_Akhir", ID)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("Tahun", year)

        Return RbQueryCmdMulti(key, query, param)
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

        If queryRB.execute(idValue, idKey, cmd) < 0 Then
            Return "X"
        Else
            Return "OK"
        End If
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