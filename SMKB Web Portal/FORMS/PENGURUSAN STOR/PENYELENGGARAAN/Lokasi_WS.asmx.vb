Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic

' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Lokasi_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable

    '-------------------- REFERENCE tblLokasi START -----------------------
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadLokasiData() As String
        Dim resp As New ResponseRepository

        dt = GetRecordLoadLokasiData()
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecordLoadLokasiData() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT 
A.Kod_Lokasi AS KodLokasi, 
A.Butiran AS Butiran, 
A.Kod_Ptj,
B.Pejabat,
A.Kat_Stor, 
A.Status 
FROM SMKB_SI_Lokasi A
INNER JOIN VPejabat B ON B.KodPejabat = A.Kod_Ptj"

        Return db.Read(query)
    End Function
    '-------------------- REFERENCE tblLokasi END -------------------------
    '-------------------- REFERENCE pejabatLokasi START -------------------
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetLokasiPejabat(ByVal q As String) As String
        Dim tmpDT As DataTable = GetKodLokasiPejabat(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodLokasiPejabat(kod As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "select 
                                KodPejabat as value,
                                Pejabat as text
                                from VPejabat"
        Dim param As New List(Of SqlParameter)

        If Not String.IsNullOrEmpty(kod) Then
            query &= "AND (Pejabat LIKE @kod) "
            param.Add(New SqlParameter("@kod", "%" & kod & "%"))
        End If

        Return db.Read(query, param)
    End Function
    '-------------------- REFERENCE pejabatLokasi END   -------------------
End Class
