Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols

Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System
Imports System.Web.Script.Serialization
'Imports SMKB_Web_Portal.Penetapan_Tarikh


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Pertengahan_Tahun_WS
    Inherits System.Web.Services.WebService

    Dim sqlcmd As SqlCommand
    Dim sqlcon As SqlConnection
    Dim sqlread As SqlDataReader
    Dim dt As DataTable



    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveOrders_Bajet(Order_Pertengahan As Order_Pertengahan) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If Order_Pertengahan Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If


        If InsertNewOrderTkh(Order_Pertengahan.TahunBajet, Order_Pertengahan.TkhPertengahan, Order_Pertengahan.TkhAkhir) <> "OK" Then
            resp.Failed("Gagal Menyimpan Maklumat.")
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function

        End If



        If UpdateStatusDokOrder_Mohon(Order_Pertengahan.TahunBajet, "Y") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order_Bajet YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            Exit Function

        End If

        success = 1

        If success = 0 Then
            resp.Failed("Rekod order_Bajet detail gagal disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        'If Not success = JumRekod Then
        '    resp.Success("Rekod order_Bajet detail berjaya disimpan dengan beberapa rekod tidak disimpan", "00", Order_Pertengahan)
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        'Else
        resp.Success("Rekod berjaya disimpan", "00", Order_Pertengahan)
        Return JsonConvert.SerializeObject(resp.GetResult())

        'End If

        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertNewOrderTkh(TahunBajet As String, TkhPertengahan As String, TkhAkhir As String)
        Dim db As New DBKewConn
        Dim queryCheck As String = $"SELECT Tahun_Bajet FROM SMKB_Bajet_KawalanTarikh WHERE Tahun_Bajet = '{TahunBajet}'"
        Dim existingRecord As Boolean = False

        ' Check if the record already exists
        Dim existingRecordQueryResult As DataTable = db.Read(queryCheck)
        If existingRecordQueryResult IsNot Nothing AndAlso existingRecordQueryResult.Rows.Count > 0 Then
            existingRecord = True
        End If

        Dim query As String = ""
        Dim param As New List(Of SqlParameter)

        If existingRecord Then
            ' Update the existing record
            query = "UPDATE SMKB_Bajet_KawalanTarikh SET Tarikh_View_Belanja_Semakan_Bajet = @Tarikh_View_Belanja_Semakan_Bajet, " &
                "Tarikh_View_Belanja_Akhir_Tahun = @Tarikh_View_Belanja_Akhir_Tahun " &
                "WHERE Tahun_Bajet = @Tahun_Bajet"
        Else
            ' Insert a new record
            query = "INSERT INTO SMKB_Bajet_KawalanTarikh (Tahun_Bajet, Tarikh_View_Belanja_Semakan_Bajet, Kategori, Tarikh_View_Belanja_Akhir_Tahun) " &
                "VALUES (@Tahun_Bajet, @Tarikh_View_Belanja_Semakan_Bajet, 'REVIEW', @Tarikh_View_Belanja_Akhir_Tahun)"
        End If

        ' Add parameters
        param.Add(New SqlParameter("@Tahun_Bajet", TahunBajet))
        param.Add(New SqlParameter("@Tarikh_View_Belanja_Semakan_Bajet", TkhPertengahan))
        param.Add(New SqlParameter("@Tarikh_View_Belanja_Akhir_Tahun", TkhAkhir))

        ' Execute the query
        Return db.Process(query, param)
    End Function


    Private Function UpdateStatusDokOrder_Mohon(orderid As String, statusLulus As String)
        Dim db As New DBKewConn


        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
							VALUES
							(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "01"))
        param.Add(New SqlParameter("@Kod_Status_Dok", "00"))
        param.Add(New SqlParameter("@No_Rujukan", orderid))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        'param.Add(New SqlParameter("@Tkh_Tindakan", orderid))
        'param.Add(New SqlParameter("@Tkh_Transaksi", orderid))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", "-"))

        Return db.Process(query, param)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadSenaraiTarikhBajet() As String

        Dim resp As New ResponseRepository

        dt = GetOrder_Senarai_Tarikh_Bajet()
        'resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetOrder_Senarai_Tarikh_Bajet() As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT Tahun_Bajet, FORMAT (Tarikh_View_Belanja_Semakan_Bajet, 'dd-MM-yyyy')  AS Tarikh_View_Belanja_Semakan_Bajet, FORMAT (Tarikh_View_Belanja_Akhir_Tahun, 'dd-MM-yyyy')  AS Tarikh_View_Belanja_Akhir_Tahun FROM SMKB_Bajet_KawalanTarikh ORDER BY Tahun_Bajet DESC"

        Return db.Read(query)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDataTkh(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetTkh(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetTkh(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT Tahun_Bajet, FORMAT (Tarikh_View_Belanja_Semakan_Bajet, 'yyyy-MM-dd')  AS Tarikh_View_Belanja_Semakan_Bajet, FORMAT (Tarikh_View_Belanja_Akhir_Tahun, 'yyyy-MM-dd')  AS Tarikh_View_Belanja_Akhir_Tahun FROM SMKB_Bajet_KawalanTarikh
                              WHERE Tahun_Bajet = @Tahun_Bajet"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@Tahun_Bajet", id))

        Return db.Read(query, param)
    End Function

    'Display PTj
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPTj(ByVal ssusrKodPTj As String) As String
        Dim tmpDT As DataTable = GetKodPTjPO(ssusrKodPTj)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function
    Private Function GetKodPTjPO(ByVal ssusrKodPTj As String) As DataTable
        Dim db = New DBKewConn
        Dim query As String = "SELECT Concat(KodPejabat,'0000') as value, Concat(KodPejabat,'0000') + ' - ' + Pejabat as text FROM VPejabat WHERE KodPejabat = Left('" & ssusrKodPTj & "',2) "

        Return db.Read(query)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadDateNow()
        Dim db As New DBKewConn


        Dim query As String = $"select Year(getdate()) as value, Year(getdate()) as text"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListKW(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiKW(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiKW(kod As String) As DataTable
        Dim db As New DBKewConn
        'Dim query As String = "SELECT distinct a.Kod_Kump_Wang , b.Butiran as text FROM SMKB_COA_Master as a , SMKB_Kump_Wang as b
        '                        where a.Kod_Kump_Wang = b.Kod_Kump_Wang and  Kod_PTJ = @ptj and a.Status = @status AND a.Kod_Kump_Wang IN ('01','07')"
        Dim query As String = "select Kod_Kump_Wang as value, Butiran as text from SMKB_Kump_Wang where Status = 1 and Kod_Kump_Wang in ('01','07') "
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (Kod_Kump_Wang LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') order by a.Kod_Kump_Wang"
        End If

        'param.Add(New SqlParameter("@status", "1"))
        'param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListKO(ByVal q As String) As String

        Dim tmpDT As DataTable = GetSenaraiKO(q)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenaraiKO(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "select Kod_Operasi as value, Butiran as text from SMKB_Operasi where Status = @status"
        Dim param As New List(Of SqlParameter)

        If kod <> "" Then
            query &= " and (Kod_Operasi LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') order by Kod_Operasi"
        End If

        param.Add(New SqlParameter("@status", 1))
        param.Add(New SqlParameter("@ptj", Session("ssusrKodPTj")))
        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))


        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_Komitmen_Sbg(ByVal tahun As String, ByVal kodVotSbg As String, ByVal PTJ As String, ByVal KW As String, ByVal KO As String) As String

        Dim tmpDT As DataTable = GetSenarai_Komitmen(tahun, kodVotSbg, PTJ, KW, KO)
        Return JsonConvert.SerializeObject(tmpDT)

    End Function

    Private Function GetSenarai_Komitmen(tahun As String, kodVotSbg As String, PTJ As String, KW As String, KO As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT id,  KodKW , KodKO, KodVot, Justifikasi ,JumlahKomitmen FROM BG21_JumSemakanBajet
                               WHERE  KodKW = @KodKW AND KodKO = @KodKO AND KodPTj =@KodPTj AND KodVot =@KodVot"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@KodKW", KW))
        param.Add(New SqlParameter("@KodKO", KO))
        param.Add(New SqlParameter("@KodPTj", PTJ))
        param.Add(New SqlParameter("@KodVot", kodVotSbg))

        Return db.Read(query, param)
    End Function


    'Load DataTable ReviewBajetPTJ
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_DataReviewPTJ(ByVal tahun As String, isClicked As Boolean, ByVal kw As String, ByVal ko As String, ByVal ptj As String) As String
        Dim resp As New ResponseRepository

        Dim db = New DBKewConn
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        Dim query As String = "select Kod_Vot, Butiran
                    from SMKB_Vot 
                    where Kod_Klasifikasi = 'H1'
                    and status = '1' and left(Kod_Vot,1) BETWEEN 1 AND 4 
                    order by Kod_Vot"

        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@nombor_mohon", id))
        ' Create a list to hold the record data

        Dim dataTable As DataTable = db.Read(query)

        ' Create a list to hold the record data
        Dim recordList As New List(Of RecordData_ReviewPTJ)()


        For Each row As DataRow In dataTable.Rows
            ' Example: Modify data before saving to another table
            Dim kodVot As String = row("Kod_Vot").ToString()
            Dim butiran As String = row("Butiran").ToString()

            ' Create a new RecordData instance and populate it with the extracted values
            Dim record As New RecordData_ReviewPTJ()
            record.KodVot = kodVot
            record.Butiran = butiran
            record.Bajet_Asal = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "AM", "AL")
            record.Bajet_TK = fGetBakiSebenar("2024", "2024-04-23", kw, ko, ptj, "0000000", kodVot, "AM", "TK")
            record.Bajet_Viremen = fGetBakiSebenar("2024", "2024-04-23", kw, ko, ptj, "0000000", kodVot, "AM", "VR")
            record.Jumlah_Peruntukan = record.Bajet_Asal + record.Bajet_TK + record.Bajet_Viremen

            record.Bajet_Belanja = fGetBakiSebenar("2024", "2024-04-23", kw, ko, ptj, "0000000", kodVot, "AM", "BJ")
            record.Bajet_PT = fGetBakiSebenar("2024", "2024-04-23", kw, ko, ptj, "0000000", kodVot, "AM", "PT")
            record.Jumlah_BAKI_PERUNTUKAN = record.Jumlah_Peruntukan - record.Bajet_Belanja - record.Bajet_PT

            record.Bajet_Komitemen = fGetBakiSebenar("2024", "2024-04-23", kw, ko, ptj, "0000000", kodVot, "AM", "KM")
            record.Bajet_Bajet_Pusat = fGetBakiSebenar("2024", "2024-04-23", kw, ko, ptj, "0000000", kodVot, "AM", "SM")
            record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA = record.Jumlah_BAKI_PERUNTUKAN - record.Bajet_Komitemen

            If record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA > 0 Then
                record.Bajet_Lebihan_Peruntukan = record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA
            Else
                record.Bajet_Pengurangan_Peruntukan = 0.00
            End If

            If record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA < 0 Then
                record.Bajet_Pengurangan_Peruntukan = record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA
            Else
                record.Bajet_Lebihan_Peruntukan = 0.00

            End If
            record.Bajet_Mohon_Pusat = fGetBakiSebenar("2024", "2024-04-23", kw, ko, ptj, "0000000", kodVot, "AM", "PM")

            ' Add the record to the list
            recordList.Add(record)

        Next

        ' Serialize the list of records to JSON using JavaScriptSerializer

        Return JsonConvert.SerializeObject(recordList)

    End Function

    'Load DataTable ReviewBajetPTJ
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_DataReviewPTJ_Bend(ByVal tahun As String, isClicked As Boolean, ByVal kw As String, ByVal ko As String) As String
        Dim resp As New ResponseRepository

        Dim db = New DBKewConn
        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        Dim query As String = "select KodPTJ, Butiran from MK_PTJ_Client where Status = '1'
                        and KodKategoriPTJ ='P' AND Right(KodPTJ,4) = '0000' and Butiran not like '%KOMITED%'
                        ORDER  BY KodPTJ"

        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@nombor_mohon", id))
        ' Create a list to hold the record data

        Dim dataTable As DataTable = db.Read(query)

        ' Create a list to hold the record data
        Dim recordList As New List(Of RecordData_ReviewPTJ)()


        For Each row As DataRow In dataTable.Rows
            ' Example: Modify data before saving to another table
            Dim ptj As String = row("KodPTJ").ToString()
            Dim butiran As String = row("Butiran").ToString()

            ' Create a new RecordData instance and populate it with the extracted values
            Dim record As New RecordData_ReviewPTJ()
            record.KodVot = ptj
            record.Butiran = butiran
            record.Bajet_Asal = fGetBakiSebenar_Bend(tahun, "2024-04-23", kw, ko, ptj, "0000000", "AL")
            record.Bajet_TK = fGetBakiSebenar_Bend(tahun, "2024-04-23", kw, ko, ptj, "0000000", "TK")
            record.Bajet_Viremen = fGetBakiSebenar_Bend(tahun, "2024-04-23", kw, ko, ptj, "0000000", "VR")
            record.Jumlah_Peruntukan = record.Bajet_Asal + record.Bajet_TK + record.Bajet_Viremen

            record.Bajet_Belanja = fGetBakiSebenar_Bend(tahun, "2024-04-23", kw, ko, ptj, "0000000", "BJ")
            record.Bajet_PT = fGetBakiSebenar_Bend(tahun, "2024-04-23", kw, ko, ptj, "0000000", "PT")
            record.Jumlah_BAKI_PERUNTUKAN = record.Jumlah_Peruntukan - record.Bajet_Belanja - record.Bajet_PT

            record.Bajet_Komitemen = fGetBakiSebenar_Bend(tahun, "2024-04-23", kw, ko, ptj, "0000000", "KM")
            record.Bajet_Bajet_Pusat = fGetBakiSebenar_Bend(tahun, "2024-04-23", kw, ko, ptj, "0000000", "SM")
            record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA = record.Jumlah_BAKI_PERUNTUKAN - record.Bajet_Komitemen

            If record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA > 0 Then
                record.Bajet_Lebihan_Peruntukan = record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA
            Else
                record.Bajet_Pengurangan_Peruntukan = 0.00
            End If

            If record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA < 0 Then
                record.Bajet_Pengurangan_Peruntukan = record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA
            Else
                record.Bajet_Lebihan_Peruntukan = 0.00

            End If
            record.Bajet_Mohon_Pusat = fGetBakiSebenar_Bend("2024", "2024-04-23", kw, ko, ptj, "0000000", "PM")

            ' Add the record to the list
            recordList.Add(record)

        Next

        ' Serialize the list of records to JSON using JavaScriptSerializer

        Return JsonConvert.SerializeObject(recordList)

    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_DataReviewPTJ_Sbg(ByVal tahun As String, ByVal kodVotam As String, ByVal ptj As String, ByVal kw As String, ByVal ko As String) As String
        Dim resp As New ResponseRepository

        Dim db = New DBKewConn

        Dim query As String = $"select Kod_Vot, Butiran
                    from SMKB_Vot 
                    where Kod_Klasifikasi = 'H2'
                    and status = '1' and left(Kod_Vot,1) BETWEEN 1 AND 4 and Concat(Left(Kod_Vot,1),'0000') = '{kodVotam}'
                    order by Kod_Vot"

        'Dim param As New List(Of SqlParameter)
        'param.Add(New SqlParameter("@nombor_mohon", id))
        ' Create a list to hold the record data

        Dim dataTable As DataTable = db.Read(query)

        ' Create a list to hold the record data
        Dim recordList As New List(Of RecordData_ReviewPTJ)()


        For Each row As DataRow In dataTable.Rows
            ' Example: Modify data before saving to another table
            Dim kodVot As String = row("Kod_Vot").ToString()
            Dim butiran As String = row("Butiran").ToString()

            ' Create a new RecordData instance and populate it with the extracted values
            Dim record As New RecordData_ReviewPTJ()
            record.KodVot = kodVot
            record.Butiran = butiran
            record.Bajet_Asal = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "AL")
            record.Bajet_TK = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "TK")
            record.Bajet_Viremen = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "VR")
            record.Jumlah_Peruntukan = record.Bajet_Asal + record.Bajet_TK + record.Bajet_Viremen

            record.Bajet_Belanja = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "BJ")
            record.Bajet_PT = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "PT")
            record.Jumlah_BAKI_PERUNTUKAN = record.Jumlah_Peruntukan - record.Bajet_Belanja - record.Bajet_PT

            record.Bajet_Komitemen = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "KM")
            record.Bajet_Bajet_Pusat = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "SM")

            record.Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA = record.Jumlah_BAKI_PERUNTUKAN - record.Bajet_Komitemen
            record.Bajet_Lebihan_Peruntukan = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "DL")
            record.Bajet_Pengurangan_Peruntukan = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "DK")
            record.Bajet_Mohon_Pusat = fGetBakiSebenar(tahun, "2024-04-23", kw, ko, ptj, "0000000", kodVot, "SBG", "PM")

            ' Add the record to the list
            recordList.Add(record)

        Next

        ' Serialize the list of records to JSON using JavaScriptSerializer

        Return JsonConvert.SerializeObject(recordList)

    End Function

    ' Define a class to represent the data structure for JSON serialization
    Public Class RecordData_ReviewPTJ
        Public Property KodVot As String
        Public Property Butiran As String
        Public Property Bajet_Asal As Decimal
        Public Property Bajet_TK As Decimal
        Public Property Bajet_Viremen As Decimal
        Public Property Jumlah_Peruntukan As Decimal
        Public Property Bajet_Belanja As Decimal
        Public Property Bajet_PT As Decimal
        Public Property Bajet_Komitemen As Decimal
        Public Property Bajet_Bajet_Pusat As Decimal
        Public Property Bajet_Lebihan_Peruntukan As Decimal
        Public Property Bajet_Pengurangan_Peruntukan As Decimal
        Public Property Bajet_Mohon_Pusat As Decimal
        Public Property Jumlah_BAKI_PERUNTUKAN As Decimal
        Public Property Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA As Decimal

    End Class

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fGetBakiSebenar(ByVal year As Integer, ByVal tarikh As String, ByVal kw As String, ByVal ko As String, ByVal ptj As String, ByVal kp As String, ByVal vot As String, ByVal kategoriAm As String, ByVal kategoriVal As String) As Decimal
        Dim dbconn As New DBKewConn
        Dim bakiSebenar As Decimal = 0.00
        Try
            Dim param1 As SqlParameter = New SqlParameter("@arg_tahun", SqlDbType.Int)
            param1.Value = year
            param1.Direction = ParameterDirection.Input
            param1.IsNullable = False

            Dim param2 As SqlParameter = New SqlParameter("@arg_tarikh", SqlDbType.VarChar)
            param2.Value = tarikh
            param2.Direction = ParameterDirection.Input
            param2.IsNullable = False

            Dim param3 As SqlParameter = New SqlParameter("@arg_kw", SqlDbType.VarChar)
            param3.Value = kw
            param3.Direction = ParameterDirection.Input
            param3.IsNullable = False

            Dim param4 As SqlParameter = New SqlParameter("@arg_KO", SqlDbType.VarChar)
            param4.Value = ko
            param4.Direction = ParameterDirection.Input
            param4.IsNullable = False

            'Dim param5 As SqlParameter = New SqlParameter("@arg_projek", SqlDbType.VarChar)
            'param5.Value = kp
            'param5.Direction = ParameterDirection.Input
            'param5.IsNullable = False

            Dim param6 As SqlParameter = New SqlParameter("@arg_jbt", SqlDbType.VarChar)
            param6.Value = ptj
            param6.Direction = ParameterDirection.Input
            param6.IsNullable = True

            Dim param7 As SqlParameter = New SqlParameter("@arg_vot", SqlDbType.VarChar)
            param7.Value = vot
            param7.Direction = ParameterDirection.Input
            param7.IsNullable = False

            Dim param8 As SqlParameter = New SqlParameter("@arg_kategoriAm", SqlDbType.VarChar)
            param8.Value = kategoriAm
            param8.Direction = ParameterDirection.Input
            param8.IsNullable = False

            Dim param9 As SqlParameter = New SqlParameter("@arg_kategoriVal", SqlDbType.VarChar)
            param9.Value = kategoriVal
            param9.Direction = ParameterDirection.Input
            param9.IsNullable = False

            Dim param10 As SqlParameter = New SqlParameter("@l_bakisbnr", SqlDbType.Decimal)
            param10.Value = bakiSebenar
            param10.Direction = ParameterDirection.Output
            param10.IsNullable = False

            Dim paramSql() As SqlParameter = {param1, param2, param3, param4, param6, param7, param8, param9, param10}

            Dim l_bakisbnr = dbconn.fExecuteSP("USP_BAKIREVIEW_BAJET", paramSql, param10, bakiSebenar)

            Return JsonConvert.SerializeObject(bakiSebenar)
        Catch ex As Exception

        End Try
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fGetBakiSebenar_Bend(ByVal year As Integer, ByVal tarikh As String, ByVal kw As String, ByVal ko As String, ByVal ptj As String, ByVal kp As String, ByVal kategoriVal As String) As Decimal
        Dim dbconn As New DBKewConn
        Dim bakiSebenar As Decimal = 0.00
        Try
            Dim param1 As SqlParameter = New SqlParameter("@arg_tahun", SqlDbType.Int)
            param1.Value = year
            param1.Direction = ParameterDirection.Input
            param1.IsNullable = False

            Dim param2 As SqlParameter = New SqlParameter("@arg_tarikh", SqlDbType.VarChar)
            param2.Value = tarikh
            param2.Direction = ParameterDirection.Input
            param2.IsNullable = False

            Dim param3 As SqlParameter = New SqlParameter("@arg_kw", SqlDbType.VarChar)
            param3.Value = kw
            param3.Direction = ParameterDirection.Input
            param3.IsNullable = False

            Dim param4 As SqlParameter = New SqlParameter("@arg_KO", SqlDbType.VarChar)
            param4.Value = ko
            param4.Direction = ParameterDirection.Input
            param4.IsNullable = False

            'Dim param5 As SqlParameter = New SqlParameter("@arg_projek", SqlDbType.VarChar)
            'param5.Value = kp
            'param5.Direction = ParameterDirection.Input
            'param5.IsNullable = False

            Dim param6 As SqlParameter = New SqlParameter("@arg_jbt", SqlDbType.VarChar)
            param6.Value = ptj
            param6.Direction = ParameterDirection.Input
            param6.IsNullable = True

            'Dim param7 As SqlParameter = New SqlParameter("@arg_vot", SqlDbType.VarChar)
            'param7.Value = VOT
            'param7.Direction = ParameterDirection.Input
            'param7.IsNullable = False

            'Dim param8 As SqlParameter = New SqlParameter("@arg_kategoriAm", SqlDbType.VarChar)
            'param8.Value = kategoriAm
            'param8.Direction = ParameterDirection.Input
            'param8.IsNullable = False

            Dim param9 As SqlParameter = New SqlParameter("@arg_kategoriVal", SqlDbType.VarChar)
            param9.Value = kategoriVal
            param9.Direction = ParameterDirection.Input
            param9.IsNullable = False

            Dim param10 As SqlParameter = New SqlParameter("@l_bakisbnr", SqlDbType.Decimal)
            param10.Value = bakiSebenar
            param10.Direction = ParameterDirection.Output
            param10.IsNullable = False

            Dim paramSql() As SqlParameter = {param1, param2, param3, param4, param6, param9, param10}

            Dim l_bakisbnr = dbconn.fExecuteSP("USP_BAKIREVIEW_BAJET_BEND", paramSql, param10, bakiSebenar)

            Return JsonConvert.SerializeObject(bakiSebenar)
        Catch ex As Exception

        End Try
    End Function

    'Update data (Maklumat Bajet dan Spesifikasi)
    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveKomitmen_PTJ(mohonDetails As PermohonanReviewBajet_PTJ_Komitmen) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")

        If mohonDetails Is Nothing Then
            resp.Failed("Tidak disimpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If InsertKomitmen(mohonDetails) <> "OK" Then
            resp.Failed("Gagal mengemaskini rekod")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dikemaskini", "00", mohonDetails)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertKomitmen(mohonDetails As PermohonanReviewBajet_PTJ_Komitmen) As String
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO BG21_JumSemakanBajet (TahunBajet, KodKW, KodKO, KodKP , 
                              KodVot, KodPTj, JumlahKomitmen, JumlahKomitmenKetua,
                              JumlahKomitmenBend , JumlahKomitmenNC , Justifikasi,  JumlahLebihanPTJ )
                              values( @TahunBajet, @KodKW,  @KodKO,  @KodKP, 
                               @KodVot,  @KodPTj,  @JumlahKomitmen, @JumlahKomitmenKetua,
                               @JumlahKomitmenBend ,  @JumlahKomitmenNC , @Justifikasi , @JumlahLebihanPTJ) "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@TahunBajet", mohonDetails.Tahun))
        param.Add(New SqlParameter("@KodKW", mohonDetails.KW))
        param.Add(New SqlParameter("@KodKO", mohonDetails.KO))
        param.Add(New SqlParameter("@KodKP", "0000000"))
        param.Add(New SqlParameter("@KodVot", mohonDetails.ObjSbg))
        param.Add(New SqlParameter("@KodPTj", mohonDetails.PTJ))
        param.Add(New SqlParameter("@JumlahKomitmen", mohonDetails.Komitmen))
        param.Add(New SqlParameter("@JumlahKomitmenKetua", mohonDetails.Komitmen))
        param.Add(New SqlParameter("@JumlahKomitmenBend", mohonDetails.Komitmen))
        param.Add(New SqlParameter("@JumlahKomitmenNC", mohonDetails.Komitmen))
        param.Add(New SqlParameter("@Justifikasi", mohonDetails.Komitmen))
        param.Add(New SqlParameter("@JumlahLebihanPTJ", mohonDetails.Komitmen))

        Return db.Process(query, param)
    End Function

    'Delete Row DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function DeleteKomitmen_PTJ(ByVal id As String) As String
        Dim resp As New ResponseRepository

        If Query_deleteKomitmen_PTJ(id) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deleteKomitmen_PTJ(id As String)
        Dim db = New DBKewConn

        Dim query As String = "DELETE FROM BG21_JumSemakanBajet WHERE Id = @id"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id", id))

        Return db.Process(query, param)
    End Function

    'Load data for Update Row DataTable tblDataPerolehanDtl
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadPoDtlRowData(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = Query_loadPoDtlRowData(id)
        Return JsonConvert.SerializeObject(dt)
    End Function
    Private Function Query_loadPoDtlRowData(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "select * from BG21_JumSemakanBajet where id = @id_mohon_dtl"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@id_mohon_dtl", id))

        Return db.Read(query, param)
    End Function
End Class

