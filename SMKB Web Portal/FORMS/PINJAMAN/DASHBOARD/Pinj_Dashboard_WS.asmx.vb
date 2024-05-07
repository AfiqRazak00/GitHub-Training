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
Public Class Pinj_Dashboard_WS
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
    Public Function LoadJumPinjAktif() As String
        Dim tmpDT As DataTable = GetJumPinjAktif()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetJumPinjAktif() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT SUM(Amaun) AS jumlahPembiayaan FROM SMKB_Pinjaman_Hdr WHERE Status = 'A'"
        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadJumBilAktif() As String
        Dim tmpDT As DataTable = GetJumBilAktif()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetJumBilAktif() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT COUNT(No_Pinj) AS bilPembiayaan FROM SMKB_Pinjaman_Hdr WHERE Status = 'A'"
        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataPinjPie() As String
        Dim tmpDT As DataTable = GetDataPinjPie()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetDataPinjPie() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT COUNT(No_Pinj) AS bilKenderaan,
                            (SELECT COUNT(No_Pinj) FROM SMKB_Pinjaman_Hdr WHERE Status = 'A' AND Kategori_Pinj = 'K00002') AS bilKomputer,
                            (SELECT COUNT(No_Pinj) FROM SMKB_Pinjaman_Hdr WHERE Status = 'A' AND Kategori_Pinj = 'K00003') AS bilSukan
                            FROM SMKB_Pinjaman_Hdr
                            WHERE Status = 'A' AND Kategori_Pinj = 'K00001'"
        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataPinjBar() As String

        Dim tmpDT As DataTable = GetDataPinjBar()
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetDataPinjBar() As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT TOP 5 YEAR(Tkh_Mohon) AS year,COUNT(No_Pinj) AS bil
                            FROM SMKB_Pinjaman_Hdr
                            WHERE Status = 'A'
                            GROUP BY YEAR(Tkh_Mohon)
                            ORDER BY YEAR(Tkh_Mohon) DESC"
        Return db.Read(query)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiSyarikat() As String

        Using dtUserInfo = fGetSenaraiSyarikat()
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            Else
                Dim errorMessage As New Dictionary(Of String, String)
                errorMessage("error") = "Data not found"
                Return JsonConvert.SerializeObject(errorMessage)
            End If
        End Using
    End Function

    Public Function fGetSenaraiSyarikat() As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        Dim query As String = $"SELECT 
                                a.Nama_Sykt, 
                                CONCAT(
                                    a.Almt_Semasa_1, 
                                    ', ', 
                                    a.Almt_Semasa_2, 
                                    ', ', 
                                    a.Poskod_Semasa, 
                                    ' ', 
		                            b.Butiran, 
                                    ', ', 
                                    (SELECT Butiran
                                     FROM SMKB_Lookup_Detail
                                     WHERE a.Kod_Negeri_Semasa = Kod_Detail AND Kod = '0002'), 
                                    ', ', 
                                    (SELECT Butiran
                                     FROM SMKB_Lookup_Detail
                                     WHERE a.Kod_Negara_Semasa = Kod_Detail AND Kod = '0001')
                                ) AS Alamat, 
                                a.Tel_Pej_Semasa
                            FROM 
                                SMKB_Syarikat_Master a
                            INNER JOIN 
                                SMKB_Lookup_Detail b ON a.Bandar_Semasa = b.Kod_Detail AND b.Kod = '0003'
                            WHERE 
                                a.Status_Sykt_Pinjam = @Status_Sykt_Pinjam;"

        param.Add(New SqlParameter("@Status_Sykt_Pinjam", "1"))

        Return dbconn.Read(query, param)
    End Function
End Class