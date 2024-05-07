Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class COA_WS
    Inherits System.Web.Services.WebService

    ' Dim sqlcmd As SqlCommand
    ' Dim sqlcon As SqlConnection
    ' Dim sqlread As SqlDataReader
    Dim dt As DataTable


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_SenaraiCOA(isClicked As Boolean) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetOrder_SenaraiTransaksiCOA()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_SenaraiTransaksiCOA() As DataTable
        Dim db = New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select Kod_Kump_Wang as Kod, Butiran, Status from SMKB_Kump_Wang  order by Kod_Kump_Wang"

        'param.Add(New SqlParameter("@No_Bil", kod))

        Return db.Read(query)
    End Function


    '<WebMethod(EnableSession:=True)>
    '<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    'Public Function SaveOrders(order As Data_COA) As String
    '    Dim resp As New ResponseRepository
    '    resp.Success("Data telah disimpan")
    '    Dim success As Integer = 0
    '    Dim JumRekod As Integer = 0
    '    If order Is Nothing Then
    '        resp.Failed("Tidak disimpan")
    '        Return JsonConvert.SerializeObject(resp.GetResult())
    '    End If

    '    If order.Kod = "" Then
    '        If InsertNewOrder(order.Kod, order.Butiran, order.Status) <> "OK" Then
    '            resp.Failed("Gagal Menyimpan order")
    '            Exit Function
    '        End If
    '        'Else

    '        '    If Updateorder(order.OrderID, order.PenghutangID, order.TkhMula, order.TkhTamat, order.Kontrak, order.JenisUrusniaga, order.Tujuan, order.Jumlah) <> "OK" Then
    '        '        resp.Failed("Gagal Menyimpan order")
    '        '        Exit Function
    '        '    End If
    '    End If


    '    If success = 0 Then
    '        resp.Failed("Rekod order detail gagal disimpan")
    '    End If

    '    If Not success = JumRekod Then
    '        resp.Success("Rekod order detail berjaya disimpan dengan beberapa rekod tidak disimpan", "00", order)
    '    Else
    '        resp.Success("Rekod berjaya disimpan", "00", order)
    '    End If

    '    Return JsonConvert.SerializeObject(resp.GetResult())

    'End Function

    'Private Function InsertNewOrder(Kod As String, Butiran As String, Status As String)
    '    Dim db As New DBKewConn
    '    Dim query As String = "INSERT INTO SMKB_Kump_Wang (Kod_Kump_Wang , Butiran, Status)
    '    VALUES(@Kod_Kump_Wang , @Butiran, @Status)"
    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@Kod_Kump_Wang", Kod))
    '    param.Add(New SqlParameter("@Butiran", Butiran))
    '    param.Add(New SqlParameter("@Status", Status))


    '    Return db.Process(query, param)
    'End Function

End Class