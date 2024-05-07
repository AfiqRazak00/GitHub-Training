﻿Imports System.ComponentModel
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Newtonsoft.Json

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
<ScriptService()>
Public Class KELULUSAN_STORWS
    Inherits System.Web.Services.WebService

    Dim dtbl As DataTable
    Dim queryRB As New Query 'Query rollback

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiPermohonan(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String) As String
        Dim resp As New ResponseRepository
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dtbl = getSenaraiPermohonan(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dtbl)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSenaraiPermohonan(category_filter As String, tkhMula As String, tkhTamat As String) As DataTable
        Dim dbconn As New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST( b.Tkh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST( b.Tkh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND b.Tkh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND b.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND b.Tkh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND b.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND b.Tkh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND b.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND b.Tkh_Mohon >= @tkhMula AND b.Tkh_Mohon <= @tkhTamat "
        End If

        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))

        Dim strSql As String = $"SELECT b.No_Mohon, b.Kod_Ptj, c.Pejabat,
                                   CONVERT(VARCHAR(10), MAX(b.Tkh_Mohon), 103) AS Tarikh_Mohon,
                                    CONVERT(VARCHAR(8), MAX(b.Tkh_Mohon), 108) AS Masa_Mohon,
                                    ISNULL(SUM(a.Kuantiti_Mohon), 0) AS Total_Kuantiti_Mohon
                            FROM SMKB_SI_Order_Dtl a
                            INNER JOIN SMKB_SI_Order_Hdr b ON a.No_Mohon = b.No_Mohon
                            INNER JOIN vPejabat c ON b.Kod_Ptj = c.KodPejPBU
                            WHERE b.Status_Dok = '03'
                            AND b.Kat_Mohon = 'S'
                            " & tarikhQuery &
                            "GROUP BY b.No_Mohon, b.Kod_Ptj, c.Pejabat
                            ORDER BY MAX(b.Tkh_Mohon) DESC"

        Return dbconn.Read(strSql, param)
    End Function

    'get permohonan detail based on id_mohon_dtl
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPermohonanDetails(idMohon As String)
        Dim resp As New ResponseRepository
        Dim details As DataTable = fetchPermohonanDetails(idMohon)

        If details IsNot Nothing AndAlso details.Rows.Count > 0 Then
            Return JsonConvert.SerializeObject(details)
        Else
            resp.Failed("")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    Private Function fetchPermohonanDetails(idMohon As String) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = "SELECT CONCAT(a.Kod_Brg, '-', b.Butiran) AS Kod_Brg_Butiran, a.Kod_Brg, a.No_Mohon, a.Kuantiti_Mohon, b.Butiran, b.Kod_Ukuran, a.tujuan, 
									CONVERT(VARCHAR(10), c.Tkh_Mohon, 103) AS Tkh_Mohon, c.Kod_Ptj, e.Pejabat
                                    FROM SMKB_SI_Order_Dtl a,
                                    SMKB_SI_Barang_Master b,
									SMKB_SI_Order_Hdr c,
									VPeribadi d,
									VPejabat e
                                    WHERE a.Kod_Brg = b.Kod_Brg
									AND a.No_Mohon = c.No_Mohon
									AND c.No_Staf = d.MS01_NoStaf
                                    AND a.No_Mohon = @idMohon
									AND c.Kod_Ptj = e.KodPejPBU"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idMohon", idMohon))
        Try
            ' Execute query to fetch details
            Return dbconn.Read(strSql, param)
        Catch ex As Exception
            ' Handle exception if any
            Throw ex
        End Try
    End Function

    'fetch senarai barang to table senarai kelulusan
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function loadListKelulusan(idMohon) As String
        Dim resp As New ResponseRepository


        dtbl = getListKelulusan(idMohon)

        Return JsonConvert.SerializeObject(dtbl)

    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getListKelulusan(idMohon) As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        'retrieve kod ptj
        Dim strSql As String = "SELECT DISTINCT CONCAT(b.Kod_Brg, '-', e.Butiran) AS Kod_Brg_Butiran, a.No_Mohon, a.Kod_Ptj,
											b.ID_Mohon_Dtl, 
											b.Kuantiti_Mohon, 
                                            b.Kuantiti_Lulus,
											(SELECT SUM(c.Baki_Unit) FROM SMKB_SI_Inventori c WHERE c.Kod_Ptj = '500000' AND c.Kod_Brg = b.Kod_Brg) AS Baki_Ptj,
											ISNULL((SELECT SUM(c.Baki_Unit) FROM SMKB_SI_Inventori c WHERE c.Kod_Brg = b.Kod_Brg and c.Kod_Ptj = a.Kod_Ptj),0) AS Baki_Stok,
                                            (SELECT SUM(Kuantiti_Mohon) FROM SMKB_SI_Order_Dtl c INNER JOIN SMKB_SI_Order_Hdr d ON d.no_mohon = c.No_Mohon 
											WHERE d.Kod_Ptj = A.Kod_Ptj and c.Kod_Brg = f.Kod_Brg and d.Status_Dok NOT IN ('07', '08') and d.Status = '1' and d.Kat_Mohon = 'S') 
											AS SdgDimohon,
											f.Takat_Min, 
											f.Takat_Max, 
											f.Takat_Menokok,
											(SELECT MAX(Kod_Detail) FROM SMKB_Lookup_Detail WHERE kod = 'SI004') AS Kod_Petunjuk
											FROM SMKB_SI_Order_Hdr a, SMKB_SI_Order_Dtl b, SMKB_SI_Barang_Master e, SMKB_SI_Barang_Stor f, SMKB_SI_Inventori c
											WHERE a.No_Mohon = b.No_Mohon
											AND a.No_Mohon = @No_Mohon
											AND b.Kod_Brg = e.Kod_Brg
											AND b.Kod_Brg = f.Kod_Brg
											AND f.Kod_Ptj = a.Kod_Ptj
											AND c.Kod_Ptj = '500000'
											AND c.Kod_Brg = b.Kod_Brg
											AND a.Kat_Mohon = 'S'
											AND a.Status_Dok = '03'
											AND a.Status = '1'"

        param.Add(New SqlParameter("@No_Mohon", idMohon))

        Return dbconn.Read(strSql, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchMaklumatPemohon(idMohon As String) As String
        Dim resp As New ResponseRepository


        dtbl = getMaklumatPemohon(idMohon)

        Return JsonConvert.SerializeObject(dtbl)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getMaklumatPemohon(idMohon) As DataTable
        Dim dbconn As New DBKewConn

        Dim strSql As String = $"SELECT b.MS01_Nama, b.MS01_NoStaf, b.JawGiliran, b.MS01_TelPejabat, CONVERT(VARCHAR(10), MAX(a.Tkh_Tindakan), 103) AS Tkh_Permohonan
                                FROM SMKB_Status_Dok a, VPeribadi b 
                                WHERE a.Kod_Modul = '28' AND a.Kod_Status_Dok = '02' AND a.No_Rujukan = '{idMohon}' AND a.No_Staf = b.MS01_NoStaf AND b.MS01_Status = '1'

								GROUP BY a.Tkh_Tindakan, b.MS01_Nama, b.MS01_NoStaf, b.JawGiliran, b.MS01_TelPejabat"


        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchMaklumatPengesah(idMohon As String) As String
        Dim resp As New ResponseRepository


        dtbl = getMaklumatPengesah(idMohon)

        Return JsonConvert.SerializeObject(dtbl)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getMaklumatPengesah(idMohon) As DataTable
        Dim dbconn As New DBKewConn

        Dim strSql As String = $"SELECT b.MS01_Nama, b.MS01_NoStaf, b.JawGiliran, b.MS01_TelPejabat, CONVERT(VARCHAR(10), MAX(a.Tkh_Tindakan), 103) AS Tkh_Pengesahan
                                FROM SMKB_Status_Dok a, VPeribadi b 
                                WHERE a.Kod_Modul = '28' AND a.Kod_Status_Dok = '03' AND a.No_Rujukan = '{idMohon}' AND a.No_Staf = b.MS01_NoStaf 
								GROUP BY a.Tkh_Tindakan, b.MS01_Nama, b.MS01_NoStaf, b.JawGiliran, b.MS01_TelPejabat"


        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function InsertKelulusanStatusDok(IdMohon, status_dok)
        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status) 
                                VALUES (@Kod_Modul, @Kod_Status_Dok, @No_Rujukan, @No_Staf, @Tkh_Tindakan, @Tkh_Transaksi, @Status_Transaksi, @Status)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "28"))
        param.Add(New SqlParameter("@Kod_Status_Dok", status_dok))
        param.Add(New SqlParameter("@No_Rujukan", IdMohon))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Tkh_Tindakan", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Status_Transaksi", "1"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("No_Rujukan", IdMohon, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function updateKuantitiLulus(ID_Mohon_Dtl, kuantitiLulus, kodPetunjuk) As String
        Dim db As New DBKewConn
        Dim param As New List(Of SqlParameter)
        'Dim query As String = "UPDATE SMKB_SI_Order_Dtl SET Kuantiti_Lulus = @KuantitiLulus AND WHERE ID_Mohon_Dtl = @ID_Mohon_Dtl"
        Dim query As String = "UPDATE SMKB_SI_Order_Dtl SET Kuantiti_Lulus = @KuantitiLulus, Kod_Petunjuk = @Kod_Petunjuk WHERE ID_Mohon_Dtl = @ID_Mohon_Dtl"

        param.Add(New SqlParameter("@ID_Mohon_Dtl", ID_Mohon_Dtl))
        param.Add(New SqlParameter("@KuantitiLulus", kuantitiLulus))
        param.Add(New SqlParameter("@Kod_Petunjuk", kodPetunjuk))

        Return RbQueryCmd("ID_Mohon_Dtl", ID_Mohon_Dtl, query, param)

    End Function

    'update status_dok from 03 to 04
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function UpdateStatusDok(IdMohon, status_dok) As String
        Dim query As String = "UPDATE SMKB_SI_Order_Hdr SET Status_Dok = @status_dok WHERE No_Mohon = @IdMohon"
        Dim param As New List(Of SqlParameter)()
        param.Add(New SqlParameter("@IdMohon", IdMohon))
        param.Add(New SqlParameter("@status_dok", status_dok))

        Return RbQueryCmd("No_Mohon", IdMohon, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function updateKelulusanKuantiti(rowDataArray As List(Of OrderDtl), IdMohon As String) As String
        Dim dbconn As New DBKewConn
        Dim resp As New ResponseRepository

        queryRB = New Query()

        ' Updating multiple records
        For Each rowData In rowDataArray

            If updateKuantitiLulus(rowData.ID_Mohon_Dtl, rowData.kuantitiLulus, rowData.kodPetunjuk) <> "OK" Then
                queryRB.rollback()
                resp.Failed("Gagal menyimpan rekod 1")
                Return JsonConvert.SerializeObject(resp.GetResult())
            End If
        Next

        'Update status here
        If UpdateStatusDok(IdMohon, "04") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod 2")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertKelulusanStatusDok(IdMohon, "04") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        ' Commit changes if no errors
        queryRB.finish()

        Dim rsData As New With {
        .IdMohon = IdMohon
    }

        resp.Success("Rekod telah berjaya disimpan ✅", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function updateTdkLulus(IdMohon, status_dok) As String
        Dim query As String = "UPDATE SMKB_SI_Order_Hdr SET Status_Dok = @status_dok WHERE No_Mohon = @IdMohon"
        Dim param As New List(Of SqlParameter)()
        param.Add(New SqlParameter("@IdMohon", IdMohon))
        param.Add(New SqlParameter("@status_dok", status_dok))

        Return RbQueryCmd("No_Mohon", IdMohon, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function TidakLulus(IdMohon As String) As String
        Dim dbconn As New DBKewConn
        Dim resp As New ResponseRepository

        queryRB = New Query()

        'Update status here
        If updateTdkLulus(IdMohon, "11") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod 2")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertKelulusanStatusDok(IdMohon, "11") <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod 3")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        ' Commit changes if no errors
        queryRB.finish()

        Dim rsData As New With {
        .IdMohon = IdMohon
    }

        resp.Success("Rekod telah berjaya disimpan ✅", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
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

    Public Class OrderDtl
        Public Property ID_Mohon_Dtl As String
        Public Property kuantitiLulus As String
        Public Property kodPetunjuk As String
    End Class

End Class