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
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)> _
Public Class Slip_WS
    Inherits System.Web.Services.WebService
	Dim sqlcmd As SqlCommand
	Dim sqlcon As SqlConnection
	Dim sqlread As SqlDataReader
	Dim dt As DataTable

	Public Function HelloWorld() As String
        Return "Hello World"
    End Function


	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_CukaiBulanan(bulan As String, tahun As String, syarikat As String, ptj As String) As String
		Dim resp As New ResponseRepository
		If bulan = "" Or tahun = "" Or syarikat = "" Or ptj = "" Then
			Return JsonConvert.SerializeObject(New DataTable)
		End If
		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		dt = GetRecord_CukaiBulanan(bulan, tahun, syarikat, ptj)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_CukaiBulanan(bulan As String, tahun As String, syarikat As String, ptj As String) As DataTable
		Dim sqlcmd As New SqlCommand
		Dim dt As New DataTable

		Try
			Using sqlconn As New SqlConnection(dbSMKB.strCon)
				sqlconn.Open()
				sqlcmd.Connection = sqlconn

				Dim query As String

				If ptj = "00" Then
					query = $"SELECT A.No_Staf,C.MS01_Nama AS Nama,B.No_Cukai AS No_Cukai,C.MS01_KpB AS No_KP, B.Kategori_Cukai,A.Amaun,A.Jenis_Trans
                         FROM SMKB_Gaji_Lejar A
                         LEFT JOIN SMKB_Gaji_Staf B ON B.No_Staf = A.No_Staf
                         LEFT JOIN {DBStaf}MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
                         WHERE A.Jenis_Trans = 'T' AND A.Bulan = @bulan AND A.Tahun = @tahun;"
				ElseIf ptj = "-0000" Then
					query = $"SELECT A.No_Staf,C.MS01_Nama AS Nama,B.No_Cukai AS No_Cukai,C.MS01_KpB AS No_KP, B.Kategori_Cukai,A.Amaun,A.Jenis_Trans
                         FROM SMKB_Gaji_Lejar A
                         LEFT JOIN SMKB_Gaji_Staf B ON B.No_Staf = A.No_Staf
                         LEFT JOIN {DBStaf}MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
                         WHERE A.Jenis_Trans = 'T' AND A.Bulan = @bulan AND A.Tahun = @tahun AND A.Kod_PTJ= '-';"
				Else
					query = $"SELECT A.No_Staf,C.MS01_Nama AS Nama,B.No_Cukai AS No_Cukai,C.MS01_KpB AS No_KP, B.Kategori_Cukai,A.Amaun,A.Jenis_Trans
                         FROM SMKB_Gaji_Lejar A
                         LEFT JOIN SMKB_Gaji_Staf B ON B.No_Staf = A.No_Staf
                         LEFT JOIN {DBStaf}MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
                         WHERE A.Jenis_Trans = 'T' AND A.Bulan = @bulan AND A.Tahun = @tahun AND A.Kod_PTJ= @ptj;"
				End If

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))

				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_RingkasanGaji(bulan As String, tahun As String, syarikat As String, ptj As String) As String
		Dim resp As New ResponseRepository
		If bulan = "" Or tahun = "" Or syarikat = "" Or ptj = "" Then
			Return JsonConvert.SerializeObject(New DataTable)
		End If
		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		dt = GetRecord_RingkasanGaji(bulan, tahun, syarikat, ptj)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_RingkasanGaji(bulan As String, tahun As String, syarikat As String, ptj As String) As DataTable
		Dim sqlcmd As New SqlCommand
		Dim dt As New DataTable

		Try
			Using sqlconn As New SqlConnection(dbSMKB.strCon)
				sqlconn.Open()
				sqlcmd.Connection = sqlconn

				Dim optWhere As String

				If ptj = "00" Then
					optWhere &= ""
				ElseIf ptj = "-0000" Then
					optWhere &= "AND A.Kod_PTJ = '-'"
				Else
					optWhere &= "AND A.Kod_PTJ = @ptj"
				End If

				Dim query As String = $"SELECT No_Staf,Nama,
	                            COALESCE([G],0.00) AS G,
	                            COALESCE([B],0.00) AS B,
	                            COALESCE([E],0.00) AS E,
	                            COALESCE([O],0.00) AS O,
	                            (COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) AS Gaji_Kasar,
	                            COALESCE([P],0.00) AS P,
	                            COALESCE([C],0.00) AS C,
	                            COALESCE([KWSP],0.00) AS KWSP,
	                            COALESCE([SOCP],0.00) AS SOCP,
	                            COALESCE([T],0.00) AS T,
	                            (
			                        (COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) -
			                        (COALESCE([P],0.00)+COALESCE([C],0.00)+COALESCE([KWSP],0.00)+COALESCE([SOCP],0.00)+COALESCE([T],0.00))
		                        ) AS Gaji_Bersih,
	                            COALESCE([KWSM],0.00) AS KWSM, 
		                        COALESCE([SOCM],0.00) AS SOCM
                        FROM (
	                        SELECT A.No_Staf,B.MS01_Nama AS Nama,A.Jenis_Trans,A.Amaun,A.Bulan,A.Tahun,KWSM.KWSM,KWSP.KWSP,SOCM.SOCM,SOCP.SOCP
	                        FROM SMKB_Gaji_Lejar A
	                        LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
	                        LEFT JOIN (
		                        SELECT No_Staf, Amaun AS KWSM FROM SMKB_Gaji_Lejar WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSM'
	                        ) AS KWSM ON KWSM.No_Staf = A.No_Staf
	                        LEFT JOIN (
		                        SELECT No_Staf, Amaun AS KWSP FROM SMKB_Gaji_Lejar WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSP'
	                        ) AS KWSP ON KWSP.No_Staf = A.No_Staf
	                        LEFT JOIN (
		                        SELECT No_Staf, Amaun AS SOCM FROM SMKB_Gaji_Lejar WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCM'
	                        ) AS SOCM ON SOCM.No_Staf = A.No_Staf
	                        LEFT JOIN (
		                        SELECT No_Staf, Amaun AS SOCP FROM SMKB_Gaji_Lejar WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCP'
	                        ) AS SOCP ON SOCP.No_Staf = A.No_Staf
	                        WHERE A.Bulan = @bulan AND A.Tahun = @tahun " + optWhere + "
                        ) AS SourceTable
                        PIVOT(
	                        SUM(Amaun)
	                        FOR Jenis_Trans IN([B],[C],[E],[G],[O],[P],[T])
                        ) AS PivotTable;"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))
				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_Transaksi(bulan As String, tahun As String, syarikat As String, ptj As String, kumpStaf As String, tarafPkhd As String, warga As String) As String
		Dim resp As New ResponseRepository
		If bulan = "" Or tahun = "" Or syarikat = "" Or ptj = "" Then
			Return JsonConvert.SerializeObject(New DataTable)
		End If
		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		Session("kumpStaf") = kumpStaf
		Session("tarafPkhd") = tarafPkhd
		Session("warga") = warga
		dt = GetRecord_Transaksi(bulan, tahun, syarikat, ptj, kumpStaf, tarafPkhd, warga)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_Transaksi(bulan As String, tahun As String, syarikat As String, ptj As String, kumpStaf As String, tarafPkhd As String, warga As String) As DataTable
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
					ptj = ptj
				End If

				Dim query As String = $"SELECT StaffNo,Nama,KP,MS02_GredGajiS AS GredGaji,
					COALESCE([G],0.00) AS Gaji_Pokok,
					COALESCE([B],0.00) AS Bonus,
					COALESCE([E],0.00) AS Elaun,
					COALESCE([O],0.00) AS OT, 
					(COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) AS Gaji_Kasar,
					COALESCE([P],0.00) AS Potongan,
					COALESCE([C],0.00) AS Cuti,
					No_KWSP,
					(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSM') AS KWSM,
					(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSP') AS KWSP,
					No_Cukai, Kategori_Cukai,
					COALESCE([T],0.00) AS Cukai,
					No_Perkeso,
					(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCM') AS SOCM,
					(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCP') AS SOCP,
					(
					(COALESCE([G],0.00)+COALESCE([B],0.00)+COALESCE([E],0.00)+COALESCE([O],0.00)) -
					(COALESCE([P],0.00)+COALESCE([C],0.00)+(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'SOCP')+(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'KWSP')+COALESCE([T],0.00))
					) AS Gaji_Bersih,
					No_Pencen,
					COALESCE([N],0.00) AS Pencen,
					(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = StaffNo AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = 'ASB') AS ASB
					FROM(
					SELECT A.No_Staf AS StaffNo, C.MS01_Nama AS Nama, C.MS01_KpB AS KP, A.Jenis_Trans,A.Amaun,
					B.No_Cukai, B.Kategori_Cukai, C.MS01_NoPencen AS No_Pencen, C.MS01_NoKWSP AS No_KWSP, B.No_Perkeso, D.MS02_GredGajiS
					FROM SMKB_Gaji_Lejar A
					LEFT JOIN SMKB_Gaji_Staf B ON B.No_Staf = A.No_Staf
					LEFT JOIN {DBStaf}MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
					LEFT JOIN {DBStaf}MS02_Perjawatan AS D ON D.MS01_NoStaf = A.No_Staf
					WHERE A.Bulan LIKE @bulan AND A.Tahun = @tahun AND A.Kod_PTJ LIKE @ptj AND C.MS01_Warganegara LIKE @warga AND D.MS02_KumpStaf LIKE @kumpStaf AND D.MS02_Taraf LIKE @tarafPkhd
					)AS SourceTable
					PIVOT(
					Sum(Amaun)
					FOR Jenis_Trans IN ([B],[C],[E],[G],[O],[P],[T],[N])
					) AS PivotTable;"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))
				sqlcmd.Parameters.Add(New SqlParameter("@kumpStaf", kumpStaf))
				sqlcmd.Parameters.Add(New SqlParameter("@tarafPkhd", tarafPkhd))
				sqlcmd.Parameters.Add(New SqlParameter("@warga", warga))

				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function SetSelectedValues(selectedValues As String)
		' Store the selectedValues in the session
		Session("selectedValues") = selectedValues
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_TransaksiPotonganBulanan(bulan As String, tahun As String, syarikat As String, ptj As String, kodpotongan As String) As String
		Dim resp As New ResponseRepository
		If bulan = "" Or tahun = "" Or syarikat = "" Or ptj = "" Then
			Return JsonConvert.SerializeObject(New DataTable)
		End If
		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		Session("kodpotongan") = kodpotongan
		dt = GetRecord_TransaksiPotonganBulanan(bulan, tahun, syarikat, ptj, kodpotongan)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_TransaksiPotonganBulanan(bulan As String, tahun As String, syarikat As String, ptj As String, kodpotongan As String) As DataTable
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

				If kodpotongan = "00" Then
					kodpotongan = "%"
				Else
					kodpotongan = kodpotongan + "%"
				End If

				Dim query As String = $"DECLARE @DynamicSQL NVARCHAR(MAX);
										DECLARE @ColumnList NVARCHAR(MAX);

										-- Create a comma-separated list of distinct Category values to be used as columns
										SELECT @ColumnList = COALESCE(@ColumnList + ', ', '') + QUOTENAME(Kod_Trans)
										FROM (SELECT DISTINCT Kod_Trans FROM SMKB_Gaji_Lejar WHERE Jenis_Trans = 'P' AND Bulan = @bulan AND Tahun = @tahun AND Kod_PTJ LIKE @ptj AND Kod_Trans LIKE @kodpotongan) AS Categories;

										-- Build the dynamic SQL query to pivot the table
										SET @DynamicSQL = N'
											SELECT *
											FROM (
												SELECT A.No_Staf AS No, B.MS01_Nama AS Nama, A.Kod_Trans, Amaun
												FROM SMKB_Gaji_Lejar A
												LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
												WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_PTJ LIKE @ptj AND Kod_Trans LIKE @kodpotongan
											) AS SourceTable
											PIVOT (
												SUM(Amaun)
												FOR Kod_Trans IN (' + @ColumnList + ')
											) AS PivotTable;';

										-- Execute the dynamic SQL query with the new parameter
										EXEC sp_executesql @DynamicSQL, N'@bulan INT, @tahun INT, @ptj NVARCHAR(50), @kodpotongan NVARCHAR(50)', @bulan, @tahun, @ptj, @kodpotongan;"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))
				sqlcmd.Parameters.Add(New SqlParameter("@kodpotongan", kodpotongan))

				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_TransaksiElaunBulanan(bulan As String, tahun As String, syarikat As String, ptj As String, kodelaun As String) As String
		Dim resp As New ResponseRepository
		If bulan = "" Or tahun = "" Or syarikat = "" Or ptj = "" Then
			Return JsonConvert.SerializeObject(New DataTable)
		End If
		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		Session("kodelaun") = kodelaun
		dt = GetRecord_TransaksiElaunBulanan(bulan, tahun, syarikat, ptj, kodelaun)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_TransaksiElaunBulanan(bulan As String, tahun As String, syarikat As String, ptj As String, kodelaun As String) As DataTable
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

				If kodelaun = "00" Then
					kodelaun = "%"
				Else
					kodelaun = kodelaun + "%"
				End If

				Dim query As String = $"DECLARE @DynamicSQL NVARCHAR(MAX);
										DECLARE @ColumnList NVARCHAR(MAX);

										-- Create a comma-separated list of distinct Category values to be used as columns
										SELECT @ColumnList = COALESCE(@ColumnList + ', ', '') + QUOTENAME(Kod_Trans)
										FROM (SELECT DISTINCT Kod_Trans FROM SMKB_Gaji_Lejar WHERE Jenis_Trans = 'E' AND Bulan = @bulan AND Tahun = @tahun AND Kod_PTJ LIKE @ptj AND Kod_Trans LIKE @kodelaun) AS Categories;

										-- Build the dynamic SQL query to pivot the table
										SET @DynamicSQL = N'
											SELECT *
											FROM (
												SELECT A.No_Staf AS No, B.MS01_Nama AS Nama, A.Kod_Trans, Amaun
												FROM SMKB_Gaji_Lejar A
												LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
												WHERE Bulan = @bulan AND Tahun = @tahun AND Kod_PTJ LIKE @ptj AND Kod_Trans LIKE @kodelaun
											) AS SourceTable
											PIVOT (
												SUM(Amaun)
												FOR Kod_Trans IN (' + @ColumnList + ')
											) AS PivotTable;';

										-- Execute the dynamic SQL query with the new parameter
										EXEC sp_executesql @DynamicSQL, N'@bulan INT, @tahun INT, @ptj NVARCHAR(50), @kodelaun NVARCHAR(50)', @bulan, @tahun, @ptj, @kodelaun;"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))
				sqlcmd.Parameters.Add(New SqlParameter("@kodelaun", kodelaun))
				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_TransaksiElaunBulananVot(bulan As String, tahun As String, syarikat As String, ptj As String) As String
		Dim resp As New ResponseRepository
		If bulan = "" Or tahun = "" Or syarikat = "" Or ptj = "" Then
			Return JsonConvert.SerializeObject(New DataTable)
		End If
		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		dt = GetRecord_TransaksiElaunBulananVot(bulan, tahun, syarikat, ptj)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_TransaksiElaunBulananVot(bulan As String, tahun As String, syarikat As String, ptj As String) As DataTable
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

				Dim query As String = $"-- Create a dynamic SQL statement to generate the pivot query
									DECLARE @sql AS NVARCHAR(MAX);
									DECLARE @vot_tetap_columns AS NVARCHAR(MAX);

									-- Get the distinct values in the Vot_Tetap column from SMKB_Gaji_Kod_Trans
									SET @vot_tetap_columns = STUFF(
										(SELECT DISTINCT ', [' + K.Vot_Tetap + ']' FROM SMKB_Gaji_Kod_Trans K WHERE K.Kod_Trans IN (SELECT DISTINCT L.Kod_Trans
																FROM SMKB_Gaji_Lejar L
																WHERE L.Bulan LIKE @bulan AND L.Tahun = @tahun AND L.Jenis_Trans = 'E' AND L.Kod_PTJ LIKE @ptj)
										FOR XML PATH('')), 1, 2, '');

									-- Build the dynamic SQL query
									SET @sql = N'
									SELECT No_Staf AS No, Nama, ' + @vot_tetap_columns + '
									FROM (
										SELECT L.No_Staf,B.MS01_Nama AS Nama,K.Vot_Tetap,L.Amaun
										FROM SMKB_Gaji_Lejar L
										INNER JOIN SMKB_Gaji_Kod_Trans K ON L.Kod_Trans = K.Kod_Trans
										LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = L.No_Staf
										WHERE L.Bulan LIKE @bulan AND L.Tahun = @tahun AND L.Jenis_Trans = ''E''  AND L.Kod_PTJ LIKE @ptj
									) AS SourceTable
									PIVOT (
										SUM(Amaun) FOR Vot_Tetap IN (' + @vot_tetap_columns + ')
									) AS PivotTable
									ORDER BY No_Staf;';

									-- Execute the dynamic SQL
									EXEC sp_executesql @sql,N'@bulan NVARCHAR(10), @tahun INT, @ptj NVARCHAR(50)', @bulan, @tahun, @ptj;"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))

				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_PinjamanBulanan(syarikat As String, ptj As String, kodpinjaman As String) As String
		Dim resp As New ResponseRepository
		'If syarikat = "" Or ptj = "" Then
		'	Return JsonConvert.SerializeObject(New DataTable)
		'End If

		Session("syarikat") = syarikat
		Session("ptj") = ptj
		Session("kodpinjaman") = kodpinjaman

		If kodpinjaman = "PK01" Then
			Session("Pinjaman") = "Kenderaan"
		Else
			Session("Pinjaman") = "Komputer"
		End If

		dt = GetRecord_PinjamanBulanan(syarikat, ptj, kodpinjaman)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_PinjamanBulanan(syarikat As String, ptj As String, kodpinjaman As String) As DataTable
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

				Dim query As String = $"SELECT A.Kod_Trans,A.Bulan, A.Tahun,B.No_Trans,A.No_Staf, E.MS01_Nama AS Nama, C.Amaun AS Pinjaman,A.Amaun AS Pot_bulanan, D.Pokok, (A.Amaun - D.Pokok) AS Untung
									FROM SMKB_Gaji_Lejar A
									INNER JOIN SMKB_Gaji_Master B ON B.No_Staf = A.No_Staf AND B.Kod_Trans = @kodpinjaman AND B.Tkh_Tamat > GETDATE()
									INNER JOIN SMKB_Pinjaman_Hdr C ON C.No_Pinj = B.No_Trans 
									INNER JOIN SMKB_Pinjaman_Jadual_Bayar_Balik D ON D.No_Pinj = B.No_Trans AND RIGHT(D.Bln_GJ, 2) = MONTH(GETDATE()) AND LEFT(D.Bln_GJ,4) = YEAR(GETDATE())
									LEFT JOIN {DBStaf}MS01_Peribadi AS E ON E.MS01_NoStaf = A.No_Staf
									WHERE A.Tahun = YEAR(GETDATE()) AND A.Bulan = MONTH(GETDATE()) AND A.Kod_PTJ LIKE @ptj AND A.Kod_Trans = @kodpinjaman;"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))
				sqlcmd.Parameters.Add(New SqlParameter("@kodpinjaman", kodpinjaman))

				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_APBulanan(bulan As String, tahun As String) As String
		Dim resp As New ResponseRepository

		Session("bulan") = bulan
		Session("tahun") = tahun
		dt = GetRecord_APBulanan(bulan, tahun)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_APBulanan(bulan As String, tahun As String) As DataTable
		Dim sqlcmd As New SqlCommand
		Dim dt As New DataTable

		Try
			Using sqlconn As New SqlConnection(dbSMKB.strCon)
				sqlconn.Open()
				sqlcmd.Connection = sqlconn

				Dim query As String = "SELECT Kod_Param,Kod_Kump_Wang,Kod_PTJ,Kod_Projek,Kod_Vot,'Posted' AS Status, Butiran, Debit, Kredit
					FROM SMKB_Gaji_AP WHERE Jenis_Proses = 'HD' AND RIGHT(Kod_Param, 2) = @bulan AND LEFT(Kod_Param,4) = @tahun"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_Terperinci(bulan As String, tahun As String, syarikat As String, ptj As String) As String
		Dim resp As New ResponseRepository
		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		dt = GetRecord_Terperinci(bulan, tahun, syarikat, ptj)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_Terperinci(bulan As String, tahun As String, syarikat As String, ptj As String) As DataTable
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

				Dim query As String = "SELECT A.Kod_Trans,SUM(A.Amaun) As Amaun, A.Jenis_Trans, B.Butiran AS Butiran_Jenis, C.Butiran As Butiran_Kod
					FROM SMKB_Gaji_Lejar A
					INNER JOIN SMKB_Gaji_Jenis_Trans B ON B.Jenis_Trans = A.Jenis_Trans
					LEFT JOIN SMKB_Gaji_Kod_Trans C ON C.Kod_Trans = A.Kod_Trans
					WHERE A.Kod_PTJ LIKE @ptj AND A.Bulan = @bulan AND A.Tahun = @tahun
					GROUP BY A.Kod_Trans,A.Jenis_Trans,B.Butiran,C.Butiran
					ORDER BY A.Kod_Trans"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))

				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_AmanahGaji(bulan As String, tahun As String, syarikat As String, ptj As String) As String
		Dim resp As New ResponseRepository
		'If syarikat = "" Or ptj = "" Then
		'     Return JsonConvert.SerializeObject(New DataTable)
		'End If

		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		dt = GetRecord_AmanahGaji(bulan, tahun, syarikat, ptj)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_AmanahGaji(bulan As String, tahun As String, syarikat As String, ptj As String) As DataTable
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

				Dim query As String = $"SELECT A.No_Staf,B.MS01_Nama AS Nama,SUM(A.Amaun) AS Gaji_Bersih
                     FROM SMKB_Gaji_Lejar A
                     LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = A.No_Staf
                     WHERE A.Kod_PTJ LIKE @ptj AND A.Bulan = @bulan AND A.Tahun = @tahun AND A.Kod_Trans = 'GAJI'
                     AND (SELECT Tahan_Gaji FROM SMKB_Gaji_Staf WHERE No_Staf = A.No_Staf) = 1
                     GROUP BY A.Amaun,A.No_Staf,B.MS01_Nama
                     ORDER BY A.No_Staf;"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))

				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_TransaksiOTBulanan(bulan As String, tahun As String, syarikat As String, ptj As String) As String
		Dim resp As New ResponseRepository
		If bulan = "" Or tahun = "" Or syarikat = "" Or ptj = "" Then
			Return JsonConvert.SerializeObject(New DataTable)
		End If
		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		dt = GetRecord_TransaksiOTBulanan(bulan, tahun, syarikat, ptj)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_TransaksiOTBulanan(bulan As String, tahun As String, syarikat As String, ptj As String) As DataTable
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

				Dim query As String = $"SELECT A.No_Mohon,C.MS01_Nama AS Nama, B.Tkh_Tuntut, FORMAT(B.Tkh_Tuntut, 'dd/MM/yyyy') AS formatted_date,A.Gaji, A.OT_Ptj, A.No_Staf,B.Jum_Jam_Tuntut,B.Kadar_Tuntut,B.Amaun_Tuntut,B.Jum_Jam_Sah,B.Kadar_Sah,B.Amaun_Sah,B.Jum_Jam_Lulus,B.Kadar_Lulus,B.Amaun_Lulus,
                     B.Bulan,B.Tahun,B.Jum_Jam_Terima,B.Kadar_Terima,B.Amaun_Terima
                     FROM SMKB_EOT_Mohon_Hdr A
                     INNER JOIN SMKB_EOT_Mohon_Dtl B ON B.No_Mohon = A.No_Mohon
                     LEFT JOIN {DBStaf}MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
                     WHERE B.Bulan = @bulan AND B.Tahun = @tahun AND A.OT_Ptj LIKE @ptj
                     ORDER BY A.No_Staf,B.Tkh_Tuntut;"

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))

				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_PCB(bulan As String, tahun As String, syarikat As String, ptj As String, jenisFilter As String) As String
		Dim resp As New ResponseRepository
		'If syarikat = "" Or ptj = "" Then
		'     Return JsonConvert.SerializeObject(New DataTable)
		'End If

		Session("bulan") = bulan
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("ptj") = ptj
		Session("jenisFilter") = jenisFilter
		dt = GetRecord_PCB(bulan, tahun, syarikat, ptj, jenisFilter)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_PCB(bulan As String, tahun As String, syarikat As String, ptj As String, jenisFilter As String) As DataTable
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

				Dim query As String

				If jenisFilter = "0" Then
					query = $"SELECT No_Staf AS No ,Nama,
						COALESCE([GAJI],0.00) AS Jumlah,
						COALESCE([KWSP],0.00) AS [Pot KWSP],
						(COALESCE([GAJI],0.00) - COALESCE([KWSP],0.00)) AS [Jum Pen PCB],Kategori_Cukai AS [B/BER/BB/BTB],
						(SELECT COUNT(*)
						FROM {DBStaf}MS05_Anak
						WHERE MS01_NoStaf = No_Staf AND (YEAR(GETDATE()) - YEAR(MS05_TkhLahir)) <= 18) AS [Anak Bwh 18],
						COALESCE([TAX],0.00) AS PCB,
						COALESCE([ZK01],0.00) AS [Pot Zakat],
						CASE
							WHEN (COALESCE([TAX], 0.00) - COALESCE([ZK01], 0.00)) < 0 THEN 0.00
							ELSE (COALESCE([TAX], 0.00) - COALESCE([ZK01], 0.00))
						END AS [Pot PCB]
						FROM(
						SELECT A.No_Staf, C.MS01_Nama AS Nama,A.Kod_Trans,A.Amaun,B.Kategori_Cukai
						FROM SMKB_Gaji_Lejar A
						INNER JOIN SMKB_Gaji_Staf B ON B.No_Staf = A.No_Staf
						LEFT JOIN {DBStaf}MS01_Peribadi AS C ON C.MS01_NoStaf = A.No_Staf
						WHERE A.Bulan = @bulan AND A.Tahun = @tahun AND Kod_PTJ LIKE @ptj
						)AS SourceTable
						PIVOT(
						Sum(Amaun)
						FOR Kod_Trans IN ([TAX],[TAV],[ZK01],[GAJI],[KWSP])
						) AS PivotTable
						ORDER BY No_Staf;"
				Else
					query = $"-- Create a dynamic SQL statement to generate the pivot query
						DECLARE @sql AS NVARCHAR(MAX);
						DECLARE @vot_tetap_columns AS NVARCHAR(MAX);

						-- Get the distinct values in the Vot_Tetap column from SMKB_Gaji_Kod_Trans
						SET @vot_tetap_columns = STUFF(
							(SELECT DISTINCT ', [' + K.Vot_Tetap + ']' FROM SMKB_Gaji_Kod_Trans K WHERE K.Kod_Trans IN (SELECT DISTINCT L.Kod_Trans
													FROM SMKB_Gaji_Lejar L
													WHERE L.Bulan LIKE @bulan AND L.Tahun = @tahun AND L.Jenis_Trans = 'E' AND L.Kod_PTJ LIKE '%')
							FOR XML PATH('')), 1, 2, '');

						-- Build the dynamic SQL query
						SET @sql = N'
						SELECT nostaf AS No, Nama, 
						(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = nostaf AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = ''GAJI'') AS Gaji,
						(SELECT COALESCE(SUM(Amaun),0.00) FROM SMKB_Gaji_Lejar WHERE No_Staf = nostaf AND Bulan LIKE @bulan AND Tahun = @tahun AND Kod_Trans = ''1'') AS OT,
						' + @vot_tetap_columns + '
						FROM (
							SELECT L.No_Staf AS nostaf,B.MS01_Nama AS Nama,K.Vot_Tetap,L.Amaun
							FROM SMKB_Gaji_Lejar L
							INNER JOIN SMKB_Gaji_Kod_Trans K ON L.Kod_Trans = K.Kod_Trans
							LEFT JOIN {DBStaf}MS01_Peribadi AS B ON B.MS01_NoStaf = L.No_Staf
							WHERE L.Bulan LIKE @bulan AND L.Tahun = @tahun AND L.Jenis_Trans = ''E''  AND L.Kod_PTJ LIKE @ptj
						) AS SourceTable
						PIVOT (
							SUM(Amaun) FOR Vot_Tetap IN (' + @vot_tetap_columns + ')
						) AS PivotTable
						ORDER BY nostaf;';

						-- Execute the dynamic SQL
						EXEC sp_executesql @sql,N'@bulan NVARCHAR(10), @tahun INT, @ptj NVARCHAR(50)', @bulan, @tahun, @ptj;"
				End If

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@bulan", bulan))
				sqlcmd.Parameters.Add(New SqlParameter("@ptj", ptj))
				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function LoadRecord_StafKontrak(tahun As String, syarikat As String, selectedWarga As String) As String
		Dim resp As New ResponseRepository
		If tahun = "" Or syarikat = "" Or selectedWarga = "" Then
			Return JsonConvert.SerializeObject(New DataTable)
		End If
		Session("tahun") = tahun
		Session("syarikat") = syarikat
		Session("selectedWarga") = selectedWarga

		dt = GetRecord_StafKontrak(tahun, syarikat, selectedWarga)
		Dim totalRecords As Integer = dt.Rows.Count

		Return JsonConvert.SerializeObject(dt)
	End Function

	<WebMethod()>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Private Function GetRecord_StafKontrak(tahun As String, syarikat As String, selectedWarga As String) As DataTable
		Dim sqlcmd As New SqlCommand
		Dim dt As New DataTable

		Try
			Using sqlconn As New SqlConnection(dbSMKB.strCon)
				sqlconn.Open()
				sqlcmd.Connection = sqlconn

				Dim query As String = $"SELECT A.MS01_NoStaf, B.MS01_Nama, (SELECT MS02_GredGajiS FROM {DBStaf}MS02_Perjawatan WHERE MS01_NoStaf = A.MS01_NoStaf) AS Gred,
									YEAR(CONVERT(DATETIME, B.MS01_TkhLahir, 103)) AS TahunLahir,
									(YEAR(GETDATE()) - YEAR(CONVERT(DATETIME, B.MS01_TkhLahir, 103))) AS Umur,
									B.MS01_Warganegara, (SELECT NamaNegara FROM {DBStaf}MS_Negara WHERE KodNegara = B.MS01_Warganegara) AS Warganegara,
									A.MS09_TkhMula,CONVERT(VARCHAR(10), A.MS09_TkhMula, 103) AS TkhMulaFormatted, A.MS09_TkhTamat,
									(SELECT MS02_JumlahGajiS FROM {DBStaf}MS02_Perjawatan WHERE MS01_NoStaf = A.MS01_NoStaf) AS gaji_pokok,
									CASE
										WHEN year(GETDATE()) - substring(B.MS01_TkhLahir,7,4) > 60 THEN '5.5'
										WHEN year(GETDATE()) - substring(B.MS01_TkhLahir,7,4) <= 60 THEN '11'
									END AS kwsp, 
									DATEDIFF(MONTH, CONVERT(DATETIME, A.MS09_TkhMula, 103), CONVERT(DATETIME, A.MS09_TkhTamat, 103)) AS TempohBulan
									FROM {DBStaf}MS09_Kontrak A
									INNER JOIN {DBStaf}MS01_Peribadi B ON B.MS01_NoStaf = A.MS01_NoStaf
									WHERE @tahun BETWEEN YEAR(A.MS09_TkhMula) AND YEAR(CONVERT(DATETIME, A.MS09_TkhTamat, 103))"

				If (selectedWarga = "0") Then
					query = query & " AND B.MS01_Warganegara <> 'M01' ORDER BY B.MS01_Nama;"
				Else
					query = query & " AND B.MS01_Warganegara LIKE @selectedWarga ORDER BY B.MS01_Nama;"
				End If

				sqlcmd.CommandText = query
				sqlcmd.Parameters.Add(New SqlParameter("@tahun", tahun))
				sqlcmd.Parameters.Add(New SqlParameter("@selectedWarga", selectedWarga))
				dt.Load(sqlcmd.ExecuteReader())
			End Using
		Catch ex As Exception

			Dim strex As String = ex.Message
		End Try
		Return dt
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function fetchUserDetails() As String
		Using dtUserInfo = fGetUserDetails(Session("ssusrID"))
			If dtUserInfo.Rows.Count > 0 Then
				Return JsonConvert.SerializeObject(dtUserInfo)
			Else
				Return "Error"
			End If
		End Using
	End Function
	<WebMethod()>
	Public Function fGetUserDetails(strStaffID) As DataTable
		Dim dbconn As New DBSMConn
		Dim strSql As String = $"SELECT a.NoStaf, a.KpB, a.KpL, a.Pasport, a.Nama, a.KodGelaran, a.KodJantina, a.KodTarafKahwin, a.AlamatT1, a.AlamatT2, a.PoskodT, a.BandarT, a.KodNegeriT, a.KodNegaraT, a.TarikhBerhenti, a.NoKwsp, a.NoPencen, a.NoCukai,
									a.NoPerkeso, a.TarikhKhidmat, a.KodJawatan, a.StatusTerkini, a.KodPejabat, a.NamaPejabat, a.Jantina, a.NamaNegeri, a.TarafKahwin, a.NamaGelaran, a.NamaJawatan, a.MS08_Unit, b.MS01_NoStaf, b.KpLSp, b.KpBSp,
									b.PasportSp, b.NamaSp, b.TarikhNikahSp, b.TarikhLahirSp, b.NoCukaiSp, b.NamaMSp, b.AlamatM1Sp, b.AlamatM2Sp, b.PoskodMSp, b.BandarMSp, b.KodNegeriSp, b.BilIsteri, b.NamaNegeriSp
									FROM (SELECT dbo.MS01_Peribadi.MS01_NoStaf AS NoStaf, dbo.MS01_Peribadi.MS01_KpB AS KpB, dbo.MS01_Peribadi.MS01_KpL AS KpL, dbo.MS01_Peribadi.MS01_NoPasport AS Pasport,
									dbo.MS01_Peribadi.MS01_Nama AS Nama, dbo.MS01_Peribadi.MS01_Gelaran AS KodGelaran, dbo.MS01_Peribadi.MS01_Jantina AS KodJantina, dbo.MS01_Peribadi.MS01_TarafKahwin AS KodTarafKahwin,
									dbo.MS01_Peribadi.MS01_AlamatT1 AS AlamatT1, dbo.MS01_Peribadi.MS01_AlamatT2 AS AlamatT2, dbo.MS01_Peribadi.MS01_PoskodTetap AS PoskodT, dbo.MS01_Peribadi.MS01_BandarTetap AS BandarT,
									dbo.MS01_Peribadi.MS01_NegeriTetap AS KodNegeriT, dbo.MS01_Peribadi.MS01_NegaraTetap AS KodNegaraT, dbo.MS01_Peribadi.MS01_TkhBerhenti AS TarikhBerhenti,
									dbo.MS01_Peribadi.MS01_NoKWSP AS NoKwsp, dbo.MS01_Peribadi.MS01_NoPencen AS NoPencen, dbo.MS01_Peribadi.MS01_NoCukai AS NoCukai, dbo.MS01_Peribadi.MS01_NoSOCSO AS NoPerkeso,
									dbo.MS01_Peribadi.MS01_TkhKhidmat AS TarikhKhidmat, dbo.MS02_Perjawatan.MS02_JawSandang AS KodJawatan, dbo.MS08_Penempatan.MS08_StaTerkini AS StatusTerkini,
									dbo.MS08_Penempatan.MS08_Pejabat AS KodPejabat, dbo.MS_Pejabat.Pejabat AS NamaPejabat, dbo.MS_Jantina.Jantina, dbo.MS_Negeri.NamaNegeri, dbo.MS_TarafKahwin.TarafKahwin,
									dbo.MS_Gelaran.Gelaran AS NamaGelaran, dbo.MS_Jawatan.JawGiliran AS NamaJawatan, dbo.MS08_Penempatan.MS08_Unit
									FROM dbo.MS01_Peribadi INNER JOIN
									dbo.MS02_Perjawatan ON dbo.MS01_Peribadi.MS01_NoStaf = dbo.MS02_Perjawatan.MS01_NoStaf INNER JOIN
									dbo.MS08_Penempatan ON dbo.MS01_Peribadi.MS01_NoStaf = dbo.MS08_Penempatan.MS01_NoStaf INNER JOIN
									dbo.MS_Jawatan ON dbo.MS02_Perjawatan.MS02_JawSandang = dbo.MS_Jawatan.KodJawatan INNER JOIN
									dbo.MS_Pejabat ON dbo.MS08_Penempatan.MS08_Pejabat = dbo.MS_Pejabat.KodPejabat INNER JOIN
									dbo.MS_Jantina ON dbo.MS01_Peribadi.MS01_Jantina = dbo.MS_Jantina.KodJantina INNER JOIN
									dbo.MS_Negeri ON dbo.MS01_Peribadi.MS01_NegeriTetap = dbo.MS_Negeri.KodNegeri INNER JOIN
									dbo.MS_TarafKahwin ON dbo.MS01_Peribadi.MS01_TarafKahwin = dbo.MS_TarafKahwin.KodTarafKahwin INNER JOIN
									dbo.MS_Gelaran ON dbo.MS01_Peribadi.MS01_Gelaran = dbo.MS_Gelaran.KodGelaran
									WHERE (dbo.MS08_Penempatan.MS08_StaTerkini = 1)) AS a LEFT OUTER JOIN
									(SELECT dbo.MS03_Pasangan.MS01_NoStaf, dbo.MS03_Pasangan.MS03_KpL AS KpLSp, dbo.MS03_Pasangan.MS03_KpB AS KpBSp, dbo.MS03_Pasangan.MS03_NoPasport AS PasportSp,
									dbo.MS03_Pasangan.MS03_Nama AS NamaSp, dbo.MS03_Pasangan.MS03_TkhNikah AS TarikhNikahSp, dbo.MS03_Pasangan.MS03_TkhLahir AS TarikhLahirSp,
									dbo.MS03_Pasangan.MS03_NoCukai AS NoCukaiSp, dbo.MS03_Pasangan.MS03_NamaM AS NamaMSp, dbo.MS03_Pasangan.MS03_AlamatM1 AS AlamatM1Sp,
									dbo.MS03_Pasangan.MS03_AlamatM2 AS AlamatM2Sp, dbo.MS03_Pasangan.MS03_PoskodM AS PoskodMSp, dbo.MS03_Pasangan.MS03_BandarM AS BandarMSp,
									dbo.MS03_Pasangan.MS03_NegeriM AS KodNegeriSp, dbo.MS03_Pasangan.MS03_Bil AS BilIsteri, MS_Negeri_1.NamaNegeri AS NamaNegeriSp
									FROM dbo.MS03_Pasangan INNER JOIN
									dbo.MS_Negeri AS MS_Negeri_1 ON dbo.MS03_Pasangan.MS03_NegeriM = MS_Negeri_1.KodNegeri
									WHERE (dbo.MS03_Pasangan.MS03_StaPasangan = '01')) AS b ON b.MS01_NoStaf = a.NoStaf WHERE a.NoStaf='{strStaffID}'"

		Using dt = dbconn.fselectCommandDt(strSql)
			Return dt
		End Using
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function fetchUserChild(year) As String
		Using dtUserInfo = fGetUserChild(Session("ssusrID"), year)
			If dtUserInfo.Rows.Count > 0 Then
				Return JsonConvert.SerializeObject(dtUserInfo)
			Else
				Return "Error"
			End If
		End Using
	End Function
	<WebMethod()>
	Public Function fGetUserChild(strStaffID As String, year As Integer) As DataTable
		Dim dbconn As New DBSMConn
		Dim strSql As String = $"SELECT COUNT(*) AS BilAnak
                             FROM ms05_anak 
                             WHERE ms01_nostaf = '{strStaffID}' 
                             AND DATEDIFF(year, ms05_tkhlahir, '{year}') < 18;"

		Using dt = dbconn.fselectCommandDt(strSql)
			Return dt
		End Using
	End Function


	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function fetchNoMajikan() As String
		Using dtUserInfo = fGetNoMajikan()
			If dtUserInfo.Rows.Count > 0 Then
				Return JsonConvert.SerializeObject(dtUserInfo)
			Else
				Return "Error"
			End If
		End Using
	End Function
	<WebMethod()>
	Public Function fGetNoMajikan() As DataTable
		Dim dbconn As New DBKewConn
		Dim strSql As String = $"SELECT No_Cukai FROM SMKB_Gaji_No_Majikan WHERE Kod_Organisasi = 'UTeM'"

		Using dt = dbconn.fSelectCommandDt(strSql)
			Return dt
		End Using
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function fetchCukaiTbl(year) As String
		Using dtUserInfo = fGetCukaiTbl(Session("ssusrID"), year)
			If dtUserInfo.Rows.Count > 0 Then
				Return JsonConvert.SerializeObject(dtUserInfo)
			Else
				Dim errorMessage As New Dictionary(Of String, String)
				errorMessage("error") = "Data not found"
				Return JsonConvert.SerializeObject(errorMessage)
			End If
		End Using
	End Function

	Public Function fGetCukaiTbl(strStaffID, year) As DataTable
		Dim dbconn As New DBKewConn
		Dim strSql As String = $"WITH PivotData AS (
									SELECT 
										a.No_staf,
										a.Jenis_Trans,
										b.Butiran,
										a.Kod_Trans,
										SUM(a.Amaun) AS amaun,
										a.Bulan
									FROM 
										SMKB_Gaji_Lejar a
									INNER JOIN 
										SMKB_Gaji_Kod_Trans b ON a.Kod_Trans = b.Kod_Trans
									WHERE 
										a.No_Staf = '{strStaffID}'  
										AND a.tahun = '{year}' 
										AND b.Kira_Cukai = 1 
										AND a.Bayar_Drpd = 'P'
									GROUP BY 
										a.No_staf,
										a.Jenis_Trans,
										a.Kod_Trans,
										a.Bulan,
										b.Butiran
								),
								PivotTable AS (
									SELECT 
										No_staf,
										Jenis_Trans,
										Kod_Trans,
										Butiran,
										SUM(CASE WHEN Bulan = 1 THEN amaun ELSE 0 END) AS [1],
										SUM(CASE WHEN Bulan = 2 THEN amaun ELSE 0 END) AS [2],
										SUM(CASE WHEN Bulan = 3 THEN amaun ELSE 0 END) AS [3],
										SUM(CASE WHEN Bulan = 4 THEN amaun ELSE 0 END) AS [4],
										SUM(CASE WHEN Bulan = 5 THEN amaun ELSE 0 END) AS [5],
										SUM(CASE WHEN Bulan = 6 THEN amaun ELSE 0 END) AS [6],
										SUM(CASE WHEN Bulan = 7 THEN amaun ELSE 0 END) AS [7],
										SUM(CASE WHEN Bulan = 8 THEN amaun ELSE 0 END) AS [8],
										SUM(CASE WHEN Bulan = 9 THEN amaun ELSE 0 END) AS [9],
										SUM(CASE WHEN Bulan = 10 THEN amaun ELSE 0 END) AS [10],
										SUM(CASE WHEN Bulan = 11 THEN amaun ELSE 0 END) AS [11],
										SUM(CASE WHEN Bulan = 12 THEN amaun ELSE 0 END) AS [12],
										SUM(amaun) AS Total
									FROM 
										PivotData
									GROUP BY 
										No_staf,
										Jenis_Trans,
										Kod_Trans,
										Butiran
								)
								SELECT * FROM PivotTable;"

		Using dt = dbconn.fSelectCommandDt(strSql)
			Return dt
		End Using
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function fetchTidakCukaiTbl(year) As String
		Using dtUserInfo = fGetTidakCukaiTbl(Session("ssusrID"), year)
			If dtUserInfo.Rows.Count > 0 Then
				Return JsonConvert.SerializeObject(dtUserInfo)
			Else
				Dim errorMessage As New Dictionary(Of String, String)
				errorMessage("error") = "Data not found"
				Return JsonConvert.SerializeObject(errorMessage)
			End If
		End Using
	End Function

	Public Function fGetTidakCukaiTbl(strStaffID, year) As DataTable
		Dim dbconn As New DBKewConn
		Dim strSql As String = $"SELECT *,
									ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0) + ISNULL([5], 0) + ISNULL([6], 0) + ISNULL([7], 0) + ISNULL([8], 0) + ISNULL([9], 0) + ISNULL([10], 0) + ISNULL([11], 0) + ISNULL([12], 0) AS Total
								FROM (
									SELECT 
										No_staf,
										Jenis_Trans,
										Butiran,
										Kod_Trans,
										ISNULL([1], 0) AS [1],
										ISNULL([2], 0) AS [2],
										ISNULL([3], 0) AS [3],
										ISNULL([4], 0) AS [4],
										ISNULL([5], 0) AS [5],
										ISNULL([6], 0) AS [6],
										ISNULL([7], 0) AS [7],
										ISNULL([8], 0) AS [8],
										ISNULL([9], 0) AS [9],
										ISNULL([10], 0) AS [10],
										ISNULL([11], 0) AS [11],
										ISNULL([12], 0) AS [12]
									FROM (
										SELECT 
											a.No_staf,
											a.Jenis_Trans,
											b.Butiran,
											a.Kod_Trans,
											a.Bulan,
											SUM(ISNULL(a.Amaun, 0)) AS Amaun 
										FROM 
											SMKB_Gaji_Lejar a
										INNER JOIN 
											SMKB_Gaji_Kod_Trans b ON a.Kod_Trans = b.Kod_Trans
										WHERE 
											a.No_Staf = '{strStaffID}' 
											AND a.tahun = '{year}' 
											AND b.Kira_Cukai = 0 
											AND a.Bayar_Drpd = 'P'
											AND a.Jenis_Trans NOT IN ('P','T')
										GROUP BY 
											a.No_staf,
											a.Jenis_Trans,
											a.Kod_Trans,
											a.Bulan,
											b.Butiran
									) AS SourceTable
									PIVOT (
										MAX(Amaun) FOR Bulan IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
									) AS PivotTable
								) AS FinalPivot;"

		Using dt = dbconn.fSelectCommandDt(strSql)
			Return dt
		End Using
	End Function

	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function fetchPotongan(year) As String
		Using dtUserInfo = fGetPotonganTbl(Session("ssusrID"), year)
			If dtUserInfo.Rows.Count > 0 Then
				Return JsonConvert.SerializeObject(dtUserInfo)
			Else
				Dim errorMessage As New Dictionary(Of String, String)
				errorMessage("error") = "Data not found"
				Return JsonConvert.SerializeObject(errorMessage)
			End If
		End Using
	End Function

	Public Function fGetPotonganTbl(strStaffID, year) As DataTable
		Dim dbconn As New DBKewConn
		Dim strSql As String = $"SELECT *,
									ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0) + ISNULL([5], 0) + ISNULL([6], 0) + ISNULL([7], 0) + ISNULL([8], 0) + ISNULL([9], 0) + ISNULL([10], 0) + ISNULL([11], 0) + ISNULL([12], 0) AS Total
								FROM (
									SELECT 
										No_staf,
										Jenis_Trans,
										Butiran,
										Kod_Trans,
										ISNULL([1], 0) AS [1],
										ISNULL([2], 0) AS [2],
										ISNULL([3], 0) AS [3],
										ISNULL([4], 0) AS [4],
										ISNULL([5], 0) AS [5],
										ISNULL([6], 0) AS [6],
										ISNULL([7], 0) AS [7],
										ISNULL([8], 0) AS [8],
										ISNULL([9], 0) AS [9],
										ISNULL([10], 0) AS [10],
										ISNULL([11], 0) AS [11],
										ISNULL([12], 0) AS [12]
									FROM (
										SELECT 
											a.No_staf,
											a.Jenis_Trans,
											b.Butiran,
											a.Kod_Trans,
											a.Bulan,
											SUM(ISNULL(a.Amaun, 0)) AS Amaun 
										FROM 
											SMKB_Gaji_Lejar a
										INNER JOIN 
											SMKB_Gaji_Kod_Trans b ON a.Kod_Trans = b.Kod_Trans
										WHERE 
											a.No_Staf = '{strStaffID}' 
											AND a.tahun = '{year}' 
											AND a.Bayar_Drpd = 'P'
											AND a.Jenis_Trans = 'P'
										GROUP BY 
											a.No_staf,
											a.Jenis_Trans,
											a.Kod_Trans,
											a.Bulan,
											b.Butiran
									) AS SourceTable
									PIVOT (
										MAX(Amaun) FOR Bulan IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
									) AS PivotTable
								) AS FinalPivot;"

		Using dt = dbconn.fSelectCommandDt(strSql)
			Return dt
		End Using
	End Function
	<WebMethod(EnableSession:=True)>
	<ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
	Public Function fetchTblDetails(year) As String
		Using dtUserInfo = fGetTblDetails(Session("ssusrID"), year)
			If dtUserInfo.Rows.Count > 0 Then
				Return JsonConvert.SerializeObject(dtUserInfo)
			Else
				Dim errorMessage As New Dictionary(Of String, String)
				errorMessage("error") = "Data not found"
				Return JsonConvert.SerializeObject(errorMessage)
			End If
		End Using
	End Function

	Public Function fGetTblDetails(strStaffID, year) As DataTable
		Dim dbconn As New DBKewConn
		Dim strSql As String = $"SELECT a.No_Baucar,
									   FORMAT(a.Tarikh, 'dd/MM/yyyy') AS Tarikh,
									   a.Butiran,
									   a.Jumlah,
									   b.Kod_Pemiutang
								FROM SMKB_Pembayaran_Baucar_Hdr a
								JOIN SMKB_Pembayaran_Baucar_Dtl b ON a.No_Baucar = b.No_Baucar
								JOIN SMKB_Pemiutang_Master c ON b.Kod_Pemiutang = c.Kod_Pemiutang
								WHERE YEAR(a.Tarikh) = '{year}'
								  AND c.Kategori_Pemiutang = 'ST'
								  AND b.Kod_Cukai = '12'
								  AND b.Kod_Pemiutang = '{strStaffID}'
								  AND SUBSTRING(a.No_Baucar, 1, 2) = 'BK';"

		Using dt = dbconn.fSelectCommandDt(strSql)
			Return dt
		End Using
	End Function
End Class