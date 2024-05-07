Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.IO
Imports System.Collections.Generic
Imports System.Drawing
Imports System.Globalization
Imports System.Web.Configuration

Imports System.Net
Imports System.Net.Mail

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Laporan
    Inherits System.Web.Services.WebService
    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecord_Pinjaman(syarikat As String, kategori As String, ptj As String) As String
        Dim resp As New ResponseRepository
        'If syarikat = "" Or ptj = "" Then
        '	Return JsonConvert.SerializeObject(New DataTable)
        'End If

        Session("syarikat") = syarikat
        Session("kategori") = kategori
        Session("ptj") = ptj

        dt = GetRecord_Pinjaman(syarikat, kategori, ptj)
        Dim totalRecords As Integer = dt.Rows.Count

        Return JsonConvert.SerializeObject(dt)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_Pinjaman(kategori As String, syarikat As String, ptj As String) As DataTable
        Dim sqlcmd As New SqlCommand
        Dim dt As New DataTable
        Try
            Using sqlconn As New SqlConnection(dbSMKB.strCon)
                sqlconn.Open()
                sqlcmd.Connection = sqlconn

                If ptj = "00" Then
                    ptj = "%"
                ElseIf ptj = "-0000" Then
                    ptj = "-"
                Else
                    ptj = ptj + "%"
                End If

                Dim query As String = ""

                If kategori = "STOR UTAMA" Then
                    query = $"SELECT    ROW_NUMBER() OVER (ORDER BY A.Kod_Brg) AS No, A.Kod_Brg,A.Butiran,C.Butiran AS Ukuran, B.takat_Min, b.takat_max, b.Takat_menokok, '-' as Baki
                                FROM SMKB_SI_Barang_Hdr A
                                INNER JOIN smkb_si_barang_dtl B ON B.Kod_brg = A.Kod_Brg
                                INNER JOIN SMKB_Lookup_Detail C ON C.Kod_Detail = A.Kod_Ukuran AND C.KOD IN ('SI003') 
                                INNER JOIN SMKB_Lookup_Detail D ON D.Kod_Detail = B.kat_stor AND D.KOD IN ('SI002') 
                                INNER JOIN {DBStaf}MS_PEJABAT E ON E.KodPejPBU = B.Kod_Ptj
                                WHERE D.Butiran = '{kategori}' and Kod_Ptj='{ptj}'"
                Else
                    query = $"SELECT ROW_NUMBER() OVER (ORDER BY A.Kod_Brg) AS No,A.Kod_Brg,A.Butiran,C.Butiran AS Ukuran, B.takat_Min, b.takat_max, b.Takat_menokok, '-' as Baki
                                FROM SMKB_SI_Barang_Hdr A
                                INNER JOIN smkb_si_barang_dtl B ON B.Kod_brg = A.Kod_Brg
                                INNER JOIN SMKB_Lookup_Detail C ON C.Kod_Detail = A.Kod_Ukuran AND C.KOD IN ('SI003') 
                                INNER JOIN SMKB_Lookup_Detail D ON D.Kod_Detail = B.kat_stor AND D.KOD IN ('SI002') 
                                WHERE D.Butiran = '{kategori}'"
                End If

                sqlcmd.CommandText = query
                sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))
                sqlcmd.Parameters.Add(New SqlParameter("@kategori", kategori))
                dt.Load(sqlcmd.ExecuteReader())
            End Using
        Catch ex As Exception
            Dim strex As String = ex.Message
        End Try
        Return dt
    End Function

End Class