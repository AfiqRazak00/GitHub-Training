Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.EnterpriseServices

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PembukaWS
    ' Inherits System.Web.UI.Page
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiPembuka(category_filter As String, isClicked6 As Boolean, tkhMula As DateTime, tkhTamat As DateTime) As String
        Dim resp As New ResponseRepository

        If isClicked6 = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = Get_SenaraiPembuka(category_filter, tkhMula, tkhTamat)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function Get_SenaraiPembuka(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As List(Of SqlParameter) = New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = " and CAST(a.TarikhMasa AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -1, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhMasa AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and CAST(a.TarikhMasa AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.TarikhMasa >= DATEADD(month, -1, getdate()) and a.TarikhMasa <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.TarikhMasa >= DATEADD(month, -2, getdate()) and a.TarikhMasa <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.TarikhMasa >= @tkhMula and a.TarikhMasa <= @TkhTamat "
            param = New List(Of SqlParameter)
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If

        Dim query As String = "SELECT a.IDMesy, a.Kod_JK, a.TarikhMasa, a.Tempat, a.TarikhDaftar, a.status, b.Butiran
                                    FROM SMKB_Perolehan_Mesyuarat a
                                    INNER JOIN SMKB_Perolehan_Jawatankuasa b ON a.Kod_JK = b.Kod_Jawatankuasa
								    where a.status='1' " & tarikhQuery & "
								    ORDER BY TarikhMasa DESC"

        Return db.Read(query, param)
    End Function

End Class