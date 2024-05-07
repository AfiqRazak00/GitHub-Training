Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Globalization
Imports System.Threading
Imports Microsoft.Ajax.Utilities
Imports AjaxControlToolkit
Imports System.Data.Entity.Core.Mapping

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PertanyaanAC_WS
    Inherits System.Web.Services.WebService

    'Dim sqlcmd As SqlCommand
    'Dim sqlcon As SqlConnection    
    'Dim sqlread As SqlDataReader
    Dim dt As DataTable


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PertanyaanPendahuluan(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_PertanyaanPendahuluan(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_PertanyaanPendahuluan(category_filter As String, tkhMula As String, tkhTamat As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)
        Try

            If category_filter = "1" Then 'Harini
                tarikhQuery = " AND CAST(A.Tarikh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
            ElseIf category_filter = "2" Then 'Semalam
                tarikhQuery = " AND CAST(A.Tarikh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
            ElseIf category_filter = "3" Then 'seminggu
                tarikhQuery = " AND A.Tarikh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP "
            ElseIf category_filter = "4" Then '30 hari
                tarikhQuery = " AND A.Tarikh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP "
            ElseIf category_filter = "5" Then '60 hari
                tarikhQuery = " AND A.Tarikh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP "
            ElseIf category_filter = "6" Then 'custom
                tarikhQuery = " AND CAST(A.Tarikh_Mohon AS DATE) >= @tkhMula AND CAST(A.Tarikh_Mohon AS DATE) <= @tkhTamat"
            End If

            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@tkhTamat", tkhTamat))

            Dim query As String = "SELECT A.No_Pendahuluan ,E.Butiran as Jenis_Tugas ,b.Butiran as Jenis_Perjalanan , A.Tujuan,
                                CASE WHEN A.Tarikh_Mohon <> '' THEN FORMAT(A.Tarikh_Mohon, 'dd/MM/yyyy') END AS Tkh_Daftar,
                                ISNULL(A.Jum_Mohon,0) AS JumMohon,ISNULL(A.Jum_Lulus,0) AS JumLulus , C.Butiran AS JENIS_Pendahuluan, (SELECT COUNT(No_Item) FROM SMKB_Pendahuluan_Dtl WHERE No_Pendahuluan=A.No_Pendahuluan) AS BILITEM,
                                F.MS01_Nama ,G.Butiran as Status
                                FROM SMKB_Pendahuluan_Hdr A
                                LEFT JOIN SMKB_Pendahuluan_Jns_Pjln B ON A.JenisPjln =B.Kod
                                LEFT JOIN SMKB_Pendahuluan_Jenis_ADV C ON A.Jenis_Pendahuluan=C.Kod
                                LEFT JOIN SMKB_Pendahuluan_Jns_Tugas E ON E.Kod=A.JenisTugas
                                LEFT JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_Peribadi as F on F.MS01_NoStaf = A.No_Staf
                                INNER JOIN SMKB_Kod_Status_Dok G ON G.Kod_Modul='09' AND A.Status_Dok=G.Kod_Status_Dok
                                WHERE  A.Status='1' " & tarikhQuery
            Return db.Read(query, param)
        Catch ex As SqlException
            Throw
        End Try
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PertanyaanTuntutan(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_PertanyaanTuntutan(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_PertanyaanTuntutan(category_filter As String, tkhMula As String, tkhTamat As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)
        Try

            If category_filter = "1" Then 'Harini
                tarikhQuery = " AND CAST(A.Tarikh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
            ElseIf category_filter = "2" Then 'Semalam
                tarikhQuery = " AND CAST(A.Tarikh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
            ElseIf category_filter = "3" Then 'seminggu
                tarikhQuery = " AND A.Tarikh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP "
            ElseIf category_filter = "4" Then '30 hari
                tarikhQuery = " AND A.Tarikh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP "
            ElseIf category_filter = "5" Then '60 hari
                tarikhQuery = " AND A.Tarikh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND A.Tarikh_Mohon < CURRENT_TIMESTAMP "
            ElseIf category_filter = "6" Then 'custom
                tarikhQuery = " AND CAST(A.Tarikh_Mohon AS DATE) >= @tkhMula AND CAST(A.Tarikh_Mohon AS DATE) <= @tkhTamat"
            End If

            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@tkhTamat", tkhTamat))

            Dim query As String = "SELECT A.No_Tuntutan , C.Butiran  AS JenisTuntutan, A.Bulan_Tuntut, A.Tahun_Tuntut  ,A.Tujuan_Tuntutan,
            CASE WHEN A.Tarikh_Mohon <> '' THEN FORMAT(A.Tarikh_Mohon, 'dd/MM/yyyy') END AS Tkh_Daftar,
            ISNULL(A.Jum_Tuntut,0) AS JumMohon ,ISNULL(A.Jum_Tuntut_Lulus,0) AS JumLulus ,
            (SELECT COUNT(No_Item) FROM SMKB_Tuntutan_Dtl WHERE No_Tuntutan = A.No_Tuntutan) AS BILITEM,
            F.MS01_Nama ,G.Butiran as Status
            FROM SMKB_Tuntutan_Hdr A
            LEFT JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_Peribadi as F on F.MS01_NoStaf = A.No_Staf
            LEFT JOIN SMKB_Lookup_Detail C ON  Kod = 'AC08' and C.KOD_DETAIL =A.Jenis_Tuntutan
            INNER JOIN SMKB_Kod_Status_Dok G ON G.Kod_Modul='09' AND A.Status_Dok=G.Kod_Status_Dok
            WHERE  A.Status='1'  " & tarikhQuery
            Return db.Read(query, param)
        Catch ex As SqlException
            Throw
        End Try
    End Function

End Class