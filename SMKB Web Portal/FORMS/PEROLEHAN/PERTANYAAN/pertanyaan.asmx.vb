Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.EnterpriseServices
Imports System.IO
Imports iTextSharp.text.log
Imports System.Data.Entity.Core.Mapping
Imports System.Globalization
Imports System
Imports System.Collections.Generic

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class pertanyaan
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    'Status - Individu

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiPermohonanIndividu(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_SenaraiPermohonanIndividu(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_SenaraiPermohonanIndividu(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim noStaf As String = Session("ssusrID")
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@noStaf", noStaf))

        Dim query = "SELECT  a.No_Mohon, a.No_Perolehan,FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Skop,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,                    
                    a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, CONCAT('RM ', a.Perolehan_Terdahulu) AS Perolehan_Terdahulu,a.Justifikasi, 
                    kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    StatusPO.Butiran As ButiranKodDok,
					SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP
                    FROM SMKB_Perolehan_Permohonan_Hdr AS a
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
					INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
					INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
                    where id_pemohon= @noStaf and StatusPO.Kod_Modul='02' " & tarikhQuery & "
                    ORDER BY a.Tarikh_Mohon Desc"

        Return db.Read(query, param)
    End Function

    'Status - Bendahari

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function Load_SenaraiPermohonanBendahari(category_filter As String, isClicked5 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked5 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_Load_SenaraiPermohonanBendahari(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function Get_Load_SenaraiPermohonanBendahari(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If


        Dim query = "SELECT  a.No_Mohon, a.No_Perolehan,FORMAT(a.Tarikh_Mohon,'dd/MM/yyyy') AS Tarikh_Mohon, a.Tujuan,a.Skop,a.Id_Pemohon,a.Jenis_Barang,a.Status_Dok,                    
                    a.Kod_Ptj_Mohon,FORMAT(a.Tarikh_Perlu,'dd/MM/yyyy') AS Tarikh_Perlu, CONCAT('RM ', a.Perolehan_Terdahulu) AS Perolehan_Terdahulu,a.Justifikasi, 
                    kategori.Butiran AS kategori_butiran,CONCAT(kategori.Kod_Detail, ' - ', kategori.Butiran) AS ButiranB,
                    StatusPO.Butiran As ButiranKodDok,
					SMSM.MS01_Nama As Nama, CONCAT((SMSM.MS08_Pejabat +'0000'), ' - ', SMSM.Pejabat) As KP
                    FROM SMKB_Perolehan_Permohonan_Hdr AS a
                    INNER JOIN SMKB_Lookup_Detail AS kategori ON a.Jenis_Barang = kategori.Kod_Detail AND kategori.Kod = 'PO03' 
					INNER JOIN SMKB_Kod_Status_Dok AS StatusPO ON a.Status_Dok = StatusPO.Kod_Status_Dok
					INNER JOIN VPeribadi As SMSM ON a.Id_Pemohon = SMSM.MS01_NoStaf
                    where StatusPO.Kod_Modul='02' " & tarikhQuery & "
                    ORDER BY a.Tarikh_Mohon Desc"

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SetNoMohon(IdMohon As String)
        Session("no_mohon_spek") = IdMohon
        Return True
    End Function

End Class