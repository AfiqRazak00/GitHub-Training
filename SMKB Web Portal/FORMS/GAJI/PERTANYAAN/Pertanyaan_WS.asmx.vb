Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic


Imports System.Drawing
Imports System.Globalization

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration
Imports Newtonsoft.Json.Linq
Imports Org.BouncyCastle.Asn1.Sec

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Pertanyaan_WS
    Inherits System.Web.Services.WebService

    Dim sqlComm As New SqlCommand
    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    Dim dtbl As DataTable
    'Private strCon As String = "Data Source=devmis12.utem.edu.my;Initial Catalog=dbKewanganV4;Persist Security Info=True;User ID=smkb;Password=Smkb@Dev2012;"
    Dim BulanGaji As String
    Dim TahunGaji As String
    Dim KodParam As String

    <WebMethod()> _
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListMaster(nostaf) As String
        Dim resp As New ResponseRepository


        dt = GetListMaster(nostaf)
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetListMaster(nostaf) As DataTable
        Dim db = New DBKewConn

        Dim dt As New DataTable

        dt = db.Read("SELECT bulan,tahun FROM SMKB_Gaji_Bulan ")
        If dt.Rows.Count > 0 Then
            BulanGaji = dt.Rows(0).Item("bulan").ToString()
            TahunGaji = dt.Rows(0).Item("tahun").ToString()
        End If

        'Dim query As String = $"select Kod_Sumber, Jenis_Trans, Kod_Trans,CONVERT(VARCHAR,ISNULL(Tkh_Mula,GETDATE()),103) Tkh_Mula,
        '                    CONVERT(VARCHAR,ISNULL(Tkh_Tamat,GETDATE()),103) Tkh_Tamat , Amaun, isnull(No_Trans,'') as no_trans,isnull(catatan,'') as catatan, 
        '                    case when status='A' then 'AKTIF' when status='B' then 'BATAL' else '-' end as status,no_staf from SMKB_Gaji_Master where no_staf = '{nostaf}' order by (CASE WHEN Jenis_Trans = 'G' THEN 0 WHEN Jenis_Trans = 'E' THEN 1 ELSE 2 END),Kod_Trans"

        Dim query As String = $"Select a.Kod_Sumber, a.Jenis_Trans+'|'+c.Butiran Jenis_Trans, a.Kod_Trans+'|'+b.Butiran as Kod_Trans,CONVERT(VARCHAR,ISNULL(a.Tkh_Mula,GETDATE()),103) Tkh_Mula,
                            Convert(VARCHAR, ISNULL(a.Tkh_Tamat, GETDATE()), 103) Tkh_Tamat , a.Amaun, isnull(a.No_Trans,'') as no_trans,isnull(a.catatan,'') as catatan, 
                            Case when status='A' then 'AKTIF' when status='B' then 'BATAL' else '-' end as status,no_staf 
                            from SMKB_Gaji_Master a,SMKB_Gaji_Kod_Trans b,SMKB_Gaji_Jenis_Trans c  where a.Kod_Trans = b.Kod_Trans and a.Jenis_Trans=c.Jenis_Trans and a.no_staf = '{nostaf}'  
                            Order by(CASE WHEN a.Jenis_Trans = 'G' THEN 0 WHEN a.Jenis_Trans = 'E' THEN 1 ELSE 2 END),a.Kod_Trans;"
        Return db.Read(query)
    End Function
End Class