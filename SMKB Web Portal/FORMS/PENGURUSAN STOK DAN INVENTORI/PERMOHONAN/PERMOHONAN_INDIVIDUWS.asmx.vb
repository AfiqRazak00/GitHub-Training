Imports System.ComponentModel
Imports System.Data.Entity.Core
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq


<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class PERMOHONAN_INDIVIDUWS
    Inherits System.Web.Services.WebService

    Dim dtbl As DataTable
    Dim queryRB As New Query 'Query rollback

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fGetUserInfo(strStaffID) As DataTable
        Dim dbconn As New DBKewConn


        Dim strSql As String = $"SELECT MS01_NoStaf, MS01_Nama, MS08_Pejabat, Pejabat from VPeribadi WHERE MS01_NoStaf = '{strStaffID}' AND MS01_Status = '1'"


        Using dt = dbconn.fselectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchUserInfo() As String
        Using dtUserInfo = fGetUserInfo(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            End If
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getKategori(strStaffID) As DataTable
        Dim dbconn As New DBKewConn

        Dim strSql As String = "SELECT Distinct a.Kod_Detail, a.Butiran as kategori 
                                FROM SMKB_Lookup_Detail a,
                                SMKB_SI_BARANG_Master b,
								SMKB_SI_Inventori c
                                WHERE a.KOD = 'SI001'
                                AND a.Kod_Detail = b.Kod_Kategori
								AND b.Kod_Brg = c.Kod_Brg"

        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchKategori() As String
        Using dtUserInfo = getKategori(Session("ssusrID"))
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            End If
        End Using
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSenaraiBekalan(kod_Ptj As String) As DataTable
        Dim dbconn As New DBKewConn

        'Dim strSql As String = "SELECT 
        '                            b.Kod_Brg, 
        '                            SUM(a.Baki_Unit) AS Total_Baki_Unit, 
        '                            c.Butiran AS kategori, 
        '                            b.Butiran AS SenaraiBekalan 
        '                        FROM 
        '                            SMKB_SI_Inventori a
        '                        INNER JOIN 
        '                            SMKB_SI_Barang_Master b ON a.Kod_Brg = b.Kod_Brg
        '                        INNER JOIN 
        '                            SMKB_Lookup_Detail c ON c.Kod_Detail = b.Kod_Kategori
        '                        WHERE 
        '                            c.Kod = 'SI001' 
        '                            AND a.Kat_Stor = 'SU'
        '                        GROUP BY 
        '                            b.Kod_Brg, 
        '                            c.Butiran, 
        '                            b.Butiran"

        Dim strSql As String = $"SELECT a.Kod_Brg, (select Butiran from SMKB_Lookup_Detail where Kod= 'SI001' AND Kod_Detail = b.Kod_Kategori) AS kategori,  b.Butiran AS SenaraiBekalan,
                                ISNULL((SELECT SUM(Baki_Unit) FROM SMKB_SI_Inventori WHERE Kod_Brg = a.Kod_Brg AND Kod_Ptj = a.Kod_Ptj),0) AS Total_Baki_Unit
                                FROM SMKB_SI_Barang_Stor a
                                INNER JOIN SMKB_SI_Barang_Master b ON b.Kod_Brg = a.Kod_Brg
                                WHERE a.Kod_Ptj = '{kod_Ptj}'"


        Using dt = dbconn.fSelectCommandDt(strSql)
            Return dt
        End Using
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fetchSenaraiBekalan(kod_Ptj) As String
        Using dtUserInfo = getSenaraiBekalan(kod_Ptj)
            If dtUserInfo.Rows.Count > 0 Then
                Return JsonConvert.SerializeObject(dtUserInfo)
            End If
        End Using
    End Function

    Private Function InsertPermohonanIndividu(IdMohon, kod_Ptj, status_dok) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_SI_Order_Hdr (No_Mohon, Kat_Mohon, Tkh_Mohon, Kat_Stor, Kod_Ptj, No_Staf, Status_Dok, Status) 
                                VALUES (@No_Mohon, @Kat_Mohon, @Tkh_Mohon, @Kat_Stor, @Kod_Ptj, @No_Staf, @Status_Dok, @Status)"
        Dim param As New List(Of SqlParameter)

        'tarikh mohon, idmohon
        param.Add(New SqlParameter("@No_Mohon", IdMohon))
        param.Add(New SqlParameter("@Kat_Mohon", "I"))
        param.Add(New SqlParameter("@Tkh_Mohon", Date.Now))
        param.Add(New SqlParameter("@Kat_Stor", "SU"))
        param.Add(New SqlParameter("@Kod_Ptj", kod_Ptj))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Status_Dok", status_dok))
        param.Add(New SqlParameter("@Status", "1"))


        Return RbQueryCmd("No_Mohon", IdMohon, query, param)
    End Function

    Private Function InsertButiranPermohonan(IdMohon, senaraiBekalan, kuantitiMohon, tujuan) As String


        Dim param As New List(Of SqlParameter)
        Dim query As String = $"INSERT INTO SMKB_SI_Order_Dtl (No_Mohon, ID_Mohon_Dtl, Kod_Brg, Kuantiti_Mohon, Tujuan) 
                                VALUES (@No_Mohon, @ID_Mohon_Dtl, @Kod_Brg, @Kuantiti_Mohon, @Tujuan)"

        param.Add(New SqlParameter("@No_Mohon", IdMohon))
        param.Add(New SqlParameter("@ID_Mohon_Dtl", DateTime.Now))
        param.Add(New SqlParameter("@Kod_Brg", senaraiBekalan))
        param.Add(New SqlParameter("@Kuantiti_Mohon", kuantitiMohon))
        param.Add(New SqlParameter("@Tujuan", tujuan))

        Return RbQueryCmd("No_Mohon", IdMohon, query, param)

    End Function


    'updatee butiran
    Private Function UpdateButiranPermohonan(ID_Mohon_Dtl, IdMohon, senaraiBekalan, kuantitiMohon, tujuan) As String


        Dim param As New List(Of SqlParameter)
        Dim query As String = $"UPDATE SMKB_SI_Order_Dtl SET Kod_Brg = @SenaraiBekalan, Kuantiti_Mohon = @Kuantiti_Mohon, Tujuan = @tujuan
                            WHERE ID_Mohon_Dtl = @ID_Mohon_Dtl"

        param.Add(New SqlParameter("@ID_Mohon_Dtl", ID_Mohon_Dtl))
        param.Add(New SqlParameter("@SenaraiBekalan", senaraiBekalan))
        param.Add(New SqlParameter("@Kuantiti_Mohon", kuantitiMohon))
        param.Add(New SqlParameter("@tujuan", tujuan))

        Return RbQueryCmd("ID_Mohon_Dtl", ID_Mohon_Dtl, query, param)

    End Function


    Public Function UpdateInsertButiranPermohonan(ID_Mohon_Dtl, IdMohon, senaraiBekalan, kuantitiMohon, tujuan)
        'Dim existingRowId = CheckIdExists(ID_Mohon_Dtl)

        If CheckIdExists(ID_Mohon_Dtl) IsNot Nothing Then
            Return UpdateButiranPermohonan(ID_Mohon_Dtl, IdMohon, senaraiBekalan, kuantitiMohon, tujuan)
        Else
            Return InsertButiranPermohonan(IdMohon, senaraiBekalan, kuantitiMohon, tujuan)
        End If
    End Function


    Public Function CheckIdExists(ID_Mohon_Dtl)
        Dim query As String = "SELECT ID_Mohon_Dtl FROM SMKB_SI_Order_Dtl WHERE ID_Mohon_Dtl = @ID_Mohon_Dtl"

        Dim db As New DBKewConn

        Dim param As New List(Of SqlParameter)()
        param.Add(New SqlParameter("@ID_Mohon_Dtl", ID_Mohon_Dtl))

        dtbl = db.Read(query, param)
        If dtbl.Rows.Count > 0 Then
            Return True
        Else
            Return Nothing
        End If

    End Function

    Private Function InsertPermohonanStatusDok(IdMohon, status_dok)
        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul, Kod_Status_Dok, No_Rujukan, No_Staf, Tkh_Tindakan, Tkh_Transaksi, Status_Transaksi, Status) 
                                VALUES (@Kod_Modul, @Kod_Status_Dok, @No_Rujukan, @No_Staf, @Tkh_Tindakan, @Tkh_Transaksi, @Status_Transaksi, @Status)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "28"))
        param.Add(New SqlParameter("@Kod_Status_Dok", status_dok))
        param.Add(New SqlParameter("@No_Rujukan", IdMohon))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Tkh_Tindakan", Date.Now))
        param.Add(New SqlParameter("@Tkh_Transaksi", Date.Now))
        param.Add(New SqlParameter("@Status_Transaksi", "1"))
        param.Add(New SqlParameter("@Status", "1"))

        Return RbQueryCmd("No_Rujukan", IdMohon, query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SubmitPermohonanIndividu(kod_Ptj, senaraiBekalan, kuantitiMohon, tujuan, action) As String
        Dim dbconn As New DBKewConn
        Dim resp As New ResponseRepository

        Dim IdMohon As String = GenerateIdMohon("28", "PU", "Mohon Stor Utama", $"{kod_Ptj}")

        queryRB = New Query()
        'Id mohon
        If IdMohon = "" Then
            resp.Failed("Permohonan tidak berjaya")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'status_dok based on user action
        Dim status_dok As String = ""
        If action = "Simpan Draf" Then
            status_dok = "01"
        ElseIf action = "Simpan dan Hantar" Then
            status_dok = "02"
        End If



        If InsertPermohonanIndividu(IdMohon, kod_Ptj, status_dok) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod 1")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'insert into SMKB_SI_Order_Dtl

        If InsertButiranPermohonan(IdMohon, senaraiBekalan, kuantitiMohon, tujuan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod 2")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'insert into Status_Dok

        If InsertPermohonanStatusDok(IdMohon, status_dok) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod 3")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        queryRB.finish()
        Dim result As New List(Of Object)()


        Dim rsData As New With {
            .IdMohon = IdMohon
        }

        resp.Success("Rekod telah berjaya disimpan ✅", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SubmitPermohonanIndividuID(ID_Mohon_Dtl, kod_Ptj, senaraiBekalan, kuantitiMohon, tujuan, action, No_Mohon) As String
        Dim dbconn As New DBKewConn
        Dim resp As New ResponseRepository

        Dim IdMohon As String = $"{No_Mohon}"
        queryRB = New Query()



        'status_dok based on user action
        Dim status_dok As String = ""
        If action = "Simpan Draf" Then
            status_dok = "01"
        ElseIf action = "Simpan dan Hantar" Then

            status_dok = "02"
        End If



        If UpdateInsertButiranPermohonan(ID_Mohon_Dtl, IdMohon, senaraiBekalan, kuantitiMohon, tujuan) <> "OK" Then
            queryRB.rollback()
            resp.Failed("Gagal menyimpan rekod 2")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim result As New List(Of Object)()
        queryRB.finish()

        Dim rsData As New With {
            .IdMohon = IdMohon
        }

        resp.Success("Rekod telah berjaya disimpan ✅", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SimpanDanHantar(IdMohon As String) As String
        Dim resp As New ResponseRepository
        Try
            If CheckExistingRecord(IdMohon) IsNot Nothing Then
                If UpdateStatusDok(IdMohon, "02") <> "OK" Then
                    queryRB.rollback()
                    resp.Failed("Gagal menyimpan rekod")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
                If InsertPermohonanStatusDok(IdMohon, "02") <> "OK" Then
                    queryRB.rollback()
                    resp.Failed("Gagal menyimpan status dok")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                If InsertPermohonanStatusDok(IdMohon, "02") <> "OK" Then
                    queryRB.rollback()
                    resp.Failed("Gagal menyimpan rekod")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

        Catch ex As Exception
            resp.Failed("An error occurred")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End Try

        Dim result As New List(Of Object)()
        queryRB.finish()

        Dim rsData As New With {
            .IdMohon = IdMohon
        }

        resp.Success("Rekod telah berjaya disimpan ✅", "00", rsData)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    'checkk IdMohon if exist
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function CheckExistingRecord(IdMohon As String)

        Dim query As String = "SELECT No_Mohon FROM SMKB_SI_Order_Dtl WHERE No_Mohon = @IdMohon"
        Dim param As New List(Of SqlParameter)()
        param.Add(New SqlParameter("@IdMohon", IdMohon))

        Dim result As String = RbQueryCmd("No_Mohon", IdMohon, query, param)

        If result <> "X" Then 'if result is not "X", record exist
            Return True
        Else
            Return False
        End If

    End Function


    'update status_dok from 01 to 02
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function UpdateStatusDok(IdMohon, status_dok) As String
        Dim query As String = "UPDATE SMKB_SI_Order_Hdr SET Status_Dok = @status_dok WHERE No_Mohon = @IdMohon"
        Dim param As New List(Of SqlParameter)()
        param.Add(New SqlParameter("@IdMohon", IdMohon))
        param.Add(New SqlParameter("@status_dok", status_dok))

        Return RbQueryCmd("No_Mohon", IdMohon, query, param)
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiPermohonan(category_filter As String, isClicked As Boolean, tkhMula As String, tkhTamat As String, kod_Ptj As String) As String
        Dim resp As New ResponseRepository
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dtbl = getSenaraiPermohonan(category_filter, tkhMula, tkhTamat, kod_Ptj)

        Return JsonConvert.SerializeObject(dtbl)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSenaraiPermohonan(category_filter As String, tkhMula As String, tkhTamat As String, kod_Ptj As String) As DataTable
        Dim dbconn As New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param As New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            tarikhQuery = " AND CAST( b.Tkh_Mohon AS DATE) = CAST(CURRENT_TIMESTAMP AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            tarikhQuery = " AND CAST( b.Tkh_Mohon AS DATE) = CAST(DATEADD(day, -1, CURRENT_TIMESTAMP) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            tarikhQuery = " AND b.Tkh_Mohon >= DATEADD(day, -7, CURRENT_TIMESTAMP) AND b.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " AND b.Tkh_Mohon >= DATEADD(day, -30, CURRENT_TIMESTAMP) AND b.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " AND b.Tkh_Mohon >= DATEADD(day, -60, CURRENT_TIMESTAMP) AND b.Tkh_Mohon < CURRENT_TIMESTAMP "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " AND b.Tkh_Mohon >= @tkhMula AND b.Tkh_Mohon <= @tkhTamat "
        End If


        param.Add(New SqlParameter("@tkhMula", tkhMula))
        param.Add(New SqlParameter("@tkhTamat", tkhTamat))

        Dim strSql As String = $"SELECT b.No_Mohon, 
                                   CONVERT(VARCHAR(10), MAX(b.Tkh_Mohon), 103) AS Tkh_Mohon, 
                                   MAX(a.Kuantiti_Mohon) AS Kuantiti_Mohon, 
                                   MAX(a.Kuantiti_Lulus) AS Kuantiti_Lulus, 
                                   MAX(c.Butiran) AS Status_Dok, 
                                   MAX(b.Status) AS Status,
                                   ISNULL(SUM(a.Kuantiti_Mohon), 0) AS Total_Kuantiti_Mohon
                            FROM SMKB_SI_Order_Dtl a
                            INNER JOIN SMKB_SI_Order_Hdr b ON a.No_Mohon = b.No_Mohon
							INNER JOIN SMKB_Lookup_Detail c ON b.Status_Dok = c.Kod_Detail and c.Kod = 'SI008'
                            WHERE b.Kod_Ptj = '{kod_Ptj}' 
                            AND b.Kat_Mohon = 'I'" & tarikhQuery &
                            "GROUP BY b.No_Mohon
                            ORDER BY MAX(b.Tkh_Mohon) DESC"

        Return dbconn.Read(strSql, param)
    End Function


    'fetch senarai barang
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiBarang(IdMohon) As String
        Dim resp As New ResponseRepository


        dtbl = getSenaraiBarang(IdMohon)

        Return JsonConvert.SerializeObject(dtbl)

    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSenaraiBarang(IdMohon) As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        'retrieve kod ptj
        Dim strSql As String = "SELECT CONCAT(a.Kod_Brg, '-', b.Butiran) AS Kod_Brg_Butiran, a.Kod_Brg, a.ID_Mohon_Dtl, a.No_Mohon, a.Kuantiti_Mohon, b.Butiran, c.Butiran AS KodButiran, a.tujuan
                                    FROM SMKB_SI_Order_Dtl a,
                                    SMKB_SI_Barang_Master b, 
                                    SMKB_Lookup_Detail c
                                    WHERE a.Kod_Brg = b.Kod_Brg
                                    AND a.No_Mohon = @No_Mohon
									AND b.Kod_Ukuran = c.Kod_Detail
									AND c.Kod = 'SI003'"

        param.Add(New SqlParameter("@No_Mohon", IdMohon))

        Return dbconn.Read(strSql, param)

    End Function


    'fetch senarai barang from permohonan
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiBarangPermohonan(IdMohon) As String
        Dim resp As New ResponseRepository


        dtbl = getSenaraiBarangPermohonan(IdMohon)

        Return JsonConvert.SerializeObject(dtbl)

    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getSenaraiBarangPermohonan(IdMohon) As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        'retrieve kod ptj
        Dim strSql As String = "SELECT CONCAT(a.Kod_Brg, '-', b.Butiran) AS Kod_Brg_Butiran, a.Kod_Brg, a.No_Mohon, a.Kuantiti_Mohon, b.Butiran, b.Kod_Ukuran, a.tujuan
                                    FROM SMKB_SI_Order_Dtl a,
                                    SMKB_SI_Barang_Master b
                                    WHERE a.Kod_Brg = b.Kod_Brg
                                    AND a.No_Mohon = @No_Mohon"

        param.Add(New SqlParameter("@No_Mohon", IdMohon))

        Return dbconn.Read(strSql, param)

    End Function


    'fetch barang from tblSenaraiBarang to Butiran part by Id_Mohon_Dtl
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function getBarangById(ID_Mohon_Dtl, IdMohon) As DataTable
        Dim dbconn As New DBKewConn
        Dim param As New List(Of SqlParameter)

        'retrieve kod ptj
        Dim strSql As String = "SELECT CONCAT(a.Kod_Brg, '-', b.Butiran) AS Kod_Brg_Butiran, c.Baki_Unit, 
                                a.Kod_Brg, a.No_Mohon, a.ID_Mohon_Dtl, a.Kuantiti_Mohon, b.Butiran, 
                            b.Kod_Ukuran, a.Tujuan, b.Kod_Kategori as kategori, c.Kod_Ptj
                                    FROM SMKB_SI_Order_Dtl a,
                                    SMKB_SI_Barang_Master b,
                                    SMKB_SI_Inventori c,
									SMKB_SI_Order_Hdr d
                                    WHERE a.Kod_Brg = b.Kod_Brg
									AND a.Kod_Brg = c.Kod_Brg
                                    AND a.No_Mohon = @No_Mohon
                                    AND a.ID_Mohon_Dtl = @ID_Mohon_Dtl
									AND c.Kod_Ptj = d.Kod_Ptj
									AND d.No_Mohon = a.No_Mohon"

        param.Add(New SqlParameter("@No_Mohon", IdMohon))
        param.Add(New SqlParameter("@ID_Mohon_Dtl", ID_Mohon_Dtl))

        Return dbconn.Read(strSql, param)

    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadBarangById(ID_Mohon_Dtl As String, IdMohon As String) As String
        Dim resp As New ResponseRepository

        dtbl = getBarangById(ID_Mohon_Dtl, IdMohon)

        Dim kategoriTable As DataTable = New DataTable()
        If dtbl.Rows.Count > 0 Then
            Dim kodKategori As String = dtbl.Rows(0)("kategori").ToString()
            kategoriTable = getKategori(kodKategori)
        End If

        ' Combine data into a single JSON object
        Dim result As New JObject()
        result("barang") = JToken.FromObject(dtbl)
        result("kategori") = JToken.FromObject(kategoriTable)

        Return JsonConvert.SerializeObject(dtbl)

    End Function


    'update permohonna
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPermohonanDetails(idMohon As String)
        Dim resp As New ResponseRepository
        Dim details As DataTable = fetchPermohonanDetails(idMohon)

        If details IsNot Nothing AndAlso details.Rows.Count > 0 Then
            Return JsonConvert.SerializeObject(details)
        Else
            resp.Failed("")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If
    End Function

    Private Function fetchPermohonanDetails(idMohon As String) As DataTable
        Dim dbconn As New DBKewConn
        Dim strSql As String = "SELECT * FROM SMKB_SI_Order_Dtl WHERE No_Mohon = @idMohon"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@idMohon", idMohon))
        Try
            ' Execute query to fetch details
            Return dbconn.Read(strSql, param)
        Catch ex As Exception
            ' Handle exception if any
            Throw ex
        End Try
    End Function


    'generate id mohon
    '28, PU, Stor Utama
    Private Function GenerateIdMohon(kodModul, prefix, butiran, kod_Ptj) As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newIdMohon As String

        Dim query As String = $"SELECT TOP 1 No_Akhir as id FROM SMKB_No_Akhir where Kod_Modul = '{kodModul}' AND Prefix = '{prefix}' AND  Tahun =@year AND Kod_PTJ = '{kod_Ptj}'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dtbl = db.Read(query, param)

        queryRB = New Query()

        If dtbl.Rows.Count > 0 Then
            lastID = CInt(dtbl.Rows(0).Item("id")) + 1
            Dim resultId As String = UpdateNoAkhir($"{kodModul}", $"{prefix}", $"{kod_Ptj}", year, lastID)
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        Else
            Dim resultId As String = InsertNoAkhir($"{kodModul}", $"{prefix}", year, lastID, butiran, $"{kod_Ptj}")
            If resultId <> "OK" Then
                queryRB.rollback()
                Return ""
            End If
        End If

        queryRB.finish()
        newIdMohon = $"{prefix}" + $"{kod_Ptj}" + Format(lastID, "000").ToString + month.ToString("00") + Right(year.ToString(), 2)
        Return newIdMohon

    End Function

    Private Function UpdateNoAkhir(kodModul As String, prefix As String, kod_Ptj As String, year As String, ID As String)
        Dim db As New DBKewConn
        'masuk kod ptj
        Dim query As String = "UPDATE SMKB_NO_Akhir set No_Akhir = @No_Akhir WHERE Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun=@Tahun AND Kod_PTJ=@Kod_PTJ"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Kod_PTJ", kod_Ptj))

        Dim key As New Dictionary(Of String, String)
        key.Add("No_Akhir", ID)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("Tahun", year)
        key.Add("Kod_Ptj", kod_Ptj)

        Return RbQueryCmdMulti(key, query, param)
    End Function

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String, Butiran As String, kod_Ptj As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir VALUES (@Kod_Modul, @Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", Butiran))
        param.Add(New SqlParameter("@Kod_PTJ", kod_Ptj))

        Dim key As New Dictionary(Of String, String)
        key.Add("Kod_Modul", kodModul)
        key.Add("Prefix", prefix)
        key.Add("No_Akhir", ID)
        key.Add("Tahun", year)
        key.Add("Butiran", Butiran)
        key.Add("Kod_PTJ", kod_Ptj)

        Return RbQueryCmdMulti(key, query, param)

    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmd(idKey As String, idValue As String, strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        If queryRB.execute(idValue, idKey, cmd) < 0 Then
            Return "X"
        Else
            Return "OK"
        End If
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function RbQueryCmdMulti(idKey As Dictionary(Of String, String), strQuery As String, paramDt As List(Of SqlParameter)) As String
        Dim cmd As New SqlCommand
        cmd.CommandText = strQuery

        Dim key As New Dictionary(Of String, String)

        If paramDt IsNot Nothing AndAlso paramDt.Count > 0 Then
            For Each parameter As SqlParameter In paramDt
                Dim paramName As String = parameter.ParameterName.ToString()
                Dim paramValue As Object = parameter.Value
                cmd.Parameters.Add(New SqlParameter(paramName, paramValue))
            Next
        End If

        Return If(queryRB.execute(idKey, cmd) < 0, "X", "OK")
    End Function

End Class