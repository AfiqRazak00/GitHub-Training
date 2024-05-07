Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System
Imports System.Collections.Generic
Imports Newtonsoft.Json.Linq
Imports System.Reflection


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class BayarBalikWS
    Inherits System.Web.Services.WebService
	Dim sqlcmd As SqlCommand
	Dim sqlcon As SqlConnection
	Dim sqlread As SqlDataReader
	Dim dt As DataTable
	Dim dtbl As DataTable

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function GetSenaraiPinjaman(ByVal q As String) As String
		Dim tmpDT As DataTable = GetDataSenaraiPinjaman(q, Session("ssusrID"))
		Return JsonConvert.SerializeObject(tmpDT)
	End Function

	Private Function GetDataSenaraiPinjaman(q As String, stafid As String) As DataTable
		Dim resultTable As New DataTable()
		Dim db As New DBKewConn
        'Dim query As String = $"Select
        '					No_Pinj As NoPinj,
        '					B.MS01_Nama AS NamaPeminjam
        '					From SMKB_Pinjaman_Hdr A
        '					INNER JOIN [DEVMIS\SQL_INS01].dbStaf.dbo.MS01_Peribadi B ON A.No_Staf = B.MS01_NoStaf"
        Dim query As String = $"Select
        					No_Pinj As NoPinj,
        					B.MS01_Nama AS NamaPeminjam
        					From SMKB_Pinjaman_Hdr A
        					INNER JOIN VPeribadi B ON A.No_Staf = B.MS01_NoStaf"

        Dim param As New List(Of SqlParameter)

		If Not String.IsNullOrEmpty(q) Then
			query &= " AND (No_Pinj LIKE @kod2 OR B.MS01_Nama LIKE @kod2) "
			param.Add(New SqlParameter("@kod2", "%" & q & "%"))
		End If

		dtbl = db.Read(query, param)

		' Custom return datatable
		resultTable.Columns.Add("text", GetType(String))
		resultTable.Columns.Add("value", GetType(String))

		If dtbl.Rows.Count > 0 Then
			For Each row As DataRow In dtbl.Rows
				resultTable.Rows.Add($"{row.Item("NoPinj")} - {row.Item("NamaPeminjam")}", row.Item("NoPinj"))
			Next
		Else
			resultTable.Rows.Add("-", "-")
		End If

		Return resultTable

	End Function

    'PROSES DPT KAN DATA
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Function FetchData(postData As String) As String
        Dim resp As New ResponseRepository
        Dim resultDt As New Dictionary(Of String, Object)

        ' Deserialize JSON data
        Dim postDt As Dictionary(Of String, String) = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(postData)

        'GetData
        Dim db As New DBKewConn
        Dim dbsm As New DBSMConn
        Dim param As New List(Of SqlParameter)

        'Check Jika Data Ada
        Dim query As String = $"select a.Nama_Sing, a.Nama, a.Almt1, a.Almt2, a.Bandar, a.Poskod, b.Butiran as Negeri, a.Kod_Negara, a.No_Tel1, a.No_Tel2, 
                            a.No_Faks1, a.No_Faks2, a.Laman_Web, a.Logo, a.Emel, a.Kategori, a.No_GST
                            from SMKB_Korporat a, SMKB_Lookup_Detail b
                            where b.Kod_Detail = a.Kod_Negeri
                            and b.Kod = '0002'
                            and a.status = 1"
        dtbl = db.Read(query, param)

        If dtbl.Rows.Count > 0 Then
            Dim dataDt As New Dictionary(Of String, Object)
            Dim imageData As Byte() = DirectCast(dtbl.Rows(0).Item("Logo"), Byte())
            Dim base64String As String = Convert.ToBase64String(imageData)
            dataDt("imageUrl") = String.Format("data:image/jpg;base64,{0}", base64String)
            dataDt("lblNamaKorporat") = dtbl.Rows(0).Item("Nama")
            dataDt("lblAlamatKorporat") = dtbl.Rows(0).Item("Almt1") & ", " & dtbl.Rows(0).Item("Almt1") & ", " & dtbl.Rows(0).Item("Almt2") & ", " & dtbl.Rows(0).Item("Poskod") & ", " & dtbl.Rows(0).Item("Bandar") & ", " & dtbl.Rows(0).Item("Negeri")
            dataDt("lblNoTelFaks") = "No Tel: " & dtbl.Rows(0).Item("No_Tel1") & " Fax: " & dtbl.Rows(0).Item("No_Faks1")
            dataDt("lblEmailKorporat") = dtbl.Rows(0).Item("Emel")
            resultDt("DataTab1") = JsonConvert.SerializeObject(dataDt)
        Else
            resultDt("DataTab1") = ""
        End If

        param.Clear()
        'Dim query2 As String = $"Select a.No_Pinj, a.No_Staf, c.MS01_Nama,  e.pejabat, isnull(a.No_Jilid,'-') as No_Jilid, a.Tempoh_Pinj, e.pejabat, 
        '                        (Select FORMAT(Faedah, 'N2') From SMKB_Pinjaman_Kawalan Where Kategori_Pinj = a.Kategori_Pinj And Jenis_Pinj = a.Jenis_Pinj) As faedah,
        '                        FORMAT(a.Amaun, 'N2', 'en-us') AS Amaun,
        '                        (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM22' And Kod_Detail = a.Kod_Skim) As txtskim
        '                        from SMKB_Pinjaman_Hdr AS a, [devmis\sql_ins01].dbstaf.dbo.MS01_Peribadi AS c,
        '                        [devmis\sql_ins01].dbstaf.dbo.MS08_Penempatan AS d, [devmis\sql_ins01].dbstaf.dbo.MS_pejabat AS e
        '                        where 1 = 1
        '                        and a.No_Pinj = '{postDt("NoPinj")}'
        '                        and a.No_Staf = c.MS01_NoStaf
        '                        and a.No_Staf = d.MS01_NoStaf
        '                        and d.MS08_StaTerkini = 1
        '                        and SUBSTRING(d.MS08_Unit,1,2) = e.kodpejabat"

        Dim query2 As String = $"Select a.No_Pinj, a.No_Staf, c.MS01_Nama,  c.pejabat, isnull(a.No_Jilid,'-') as No_Jilid, a.Tempoh_Pinj,
                                (Select FORMAT(Faedah, 'N2') From SMKB_Pinjaman_Kawalan Where Kategori_Pinj = a.Kategori_Pinj And Jenis_Pinj = a.Jenis_Pinj) As faedah,
                                FORMAT(a.Amaun, 'N2', 'en-us') AS Amaun,
                                (Select Butiran FROM SMKB_Lookup_Detail WHERE Kod = 'PJM22' And Kod_Detail = a.Kod_Skim) As txtskim
                                from SMKB_Pinjaman_Hdr AS a, VPeribadi AS c
                                where 1 = 1
                                and a.No_Pinj = '{postDt("NoPinj")}'
                                and a.No_Staf = c.MS01_NoStaf"

        dtbl = db.Read(query2, param)

        If dtbl.Rows.Count > 0 Then
            Dim dataDt As New Dictionary(Of String, Object)
            dataDt("lblNama") = dtbl.Rows(0).Item("MS01_Nama")
            dataDt("lblNoSkim") = If(dtbl.Rows(0).Item("txtskim") Is DBNull.Value, " - ", dtbl.Rows(0).Item("txtskim"))
            dataDt("lblNoPinj") = dtbl.Rows(0).Item("No_Pinj")
            dataDt("lblJumlah") = dtbl.Rows(0).Item("Amaun")
            dataDt("lblNoStaf") = dtbl.Rows(0).Item("No_Staf")
            dataDt("lblTempoh") = dtbl.Rows(0).Item("Tempoh_Pinj")
            dataDt("lblNamaPTj") = dtbl.Rows(0).Item("pejabat")
            dataDt("lblKeuntungan") = If(dtbl.Rows(0).Item("faedah") Is DBNull.Value, " - ", $"{dtbl.Rows(0).Item("faedah")}%")
            resultDt("DataTab2") = JsonConvert.SerializeObject(dataDt)
        Else
            resultDt("DataTab2") = ""
        End If

        param.Clear()
        Dim query3 As String = $"Select Bil_Byr, 
                                FORMAT(CONVERT(DATE, (Tahun_Byrn + Bulan_Byrn) + '01'), 'MM/yyyy') AS Bln_GJ,
                                FORMAT(Ansuran, 'N2', 'en-us') As Ansuran, 
                                FORMAT(Faedah, 'N2', 'en-us') As Faedah,
                                FORMAT(Pokok, 'N2', 'en-us') As Pokok,
                                FORMAT(SUM(Faedah) OVER (ORDER BY Bil_Byr), 'N2', 'en-us') AS FaedahPlus,
                                FORMAT(SUM(Pokok) OVER (ORDER BY Bil_Byr), 'N2', 'en-us') AS PokokPlus,
                                FORMAT(Baki_Pokok, 'N2', 'en-us') As Baki_Pokok,
                                Status_GJ
                                From SMKB_Pinjaman_Jadual_Bayar_Balik
                                Where No_Pinj = '{postDt("NoPinj")}'
                                Order By Bil_Byr Asc"

        dtbl = db.Read(query3, param)

        resultDt("DataTab3") = If(dtbl.Rows.Count > 0, JsonConvert.SerializeObject(dtbl), "")

        resp.Success("Rekod Ditemui", "00", resultDt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

End Class