Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports SMKB_Web_Portal.Dalam_Negara
Imports Microsoft.Owin
Imports System.IO
Imports SMKB_Web_Portal.BatalBorang
Imports SMKB_Web_Portal.Luar_Negara

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class MohonTuntutan_WS
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
    Public Function GetUserInfo(nostaf As String)
        Dim db As New DBSMConn
        Dim query As String = $"SELECT  MS01_NoStaf as StafNo, MS01_Nama as Param1, MS08_Pejabat as Param2, JawGiliran as Param3, Kumpulan as Param4, 
                                Singkatan as Param5, MS02_GredGajiS as Param6, 
                                MS02_JumlahGajiS,  MS01_TelPejabat as Param7,  MS02_Kumpulan
                                FROM VK_AdvClm WHERE MS01_NoStaf = '{nostaf}'"
        Dim dt As DataTable = db.fselectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetListPTJStaf(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetDataListPTJStaf(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataListPTJStaf(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT  MS01_NoStaf, MS01_Nama, MS08_Pejabat, MS02_GredGajiS, JawGiliran
                        FROM            VK_AdvClm  "

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= "WHERE MS08_Pejabat = '43' AND RIGHT(MS02_GredGajiS,2) >=@kod "

            param.Add(New SqlParameter("@kod", kod))

        End If

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function fnCariStaf(ByVal q As String) As String


        Dim tmpDT As DataTable = GetListStaf(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetListStaf(kodPjbt As String) As DataTable
        Dim db = New DBSMConn
        kodPjbt = "41"
        Dim query As String = "SELECT  MS01_NoStaf as StafNo, MS01_Nama , MS08_Pejabat, JawGiliran, right(MS02_GredGajiS,2) as GredGaji
                    FROM VK_AdvClm "

        Dim param As New List(Of SqlParameter)

        If kodPjbt <> "" Then

            query &= "WHERE MS08_Pejabat = @kodPjbt  AND RIGHT(MS02_GredGajiS,2) >='41' "
            param.Add(New SqlParameter("@kodPjbt", kodPjbt))

        End If

        Return db.Read(query, param)

    End Function

    Private Function GetRecord_SenaraiPTJ(idPejabat As String, Optional draw As String = “”) As DataTable
        Dim db = New DBSMConn


        Dim query As String = "SELECT  MS01_NoStaf as StafNo, MS01_Nama , MS08_Pejabat, JawGiliran
                    FROM VK_AdvClm WHERE MS08_Pejabat = @idPejabat  "
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@idPejabat", idPejabat))
        Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisKumpWang(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetDataKumpWang(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataKumpWang(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Kump_Wang as value,B.Butiran as text
                                FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Kump_Wang B ON A.Kod_Kump_Wang=B.Kod_Kump_Wang"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 and (A.Kod_Kump_Wang LIKE '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKendAwam(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataKenderaanAwam(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataKenderaan(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataKenderaanPjln(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataKenderaanPjln(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT No_Staf, No_Kenderaan as value,No_Kenderaan as text, Jenis_Kenderaan FROM SMKB_Tuntutan_Dftr_Kenderaan "
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " WHERE (No_Staf LIKE '%' + @kod + '%' ) "
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@kod", kod))

        Return db.Read(query, param)
    End Function
    Private Function GetDataKenderaanAwam(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Butiran as text, Keutamaan, Status
                                FROM  SMKB_Lookup_Detail
                                WHERE        (Kod = 'AC11')"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Status = 1 and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisOperasi(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetDataOperasi(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataOperasi(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Operasi as value, B.Butiran As text
                                From SMKB_COA_Master A
                                INNER Join SMKB_Operasi B ON A.Kod_Operasi=B.Kod_Operasi"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 And (A.Kod_Operasi Like '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Kump_Wang =@kod3 order by A.Kod_Operasi"
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Kump_Wang =@kod3 order by A.Kod_Operasi"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kod))

        Return db.Read(query, param)
    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKWList(ByVal q As String, ByVal kodkw As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodKWList(q, kodkw)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodKWList(kod As String, kodkw As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Kump_Wang as value,B.Butiran as text
                                FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Kump_Wang B ON A.Kod_Kump_Wang=B.Kod_Kump_Wang"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 and (A.Kod_Kump_Wang LIKE '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
        Else
            query &= " where A.Status = 1 and A.Kod_Vot =@kod3 order by A.Kod_Kump_Wang"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kodkw))

        Return db.Read(query, param)
    End Function



    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKodPtj(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetKodPtjList(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetKodPtjList(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "Select distinct Kod_PTJ as value, 
        Kod_PTJ +' - '+(SELECT b.Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT as b
        WHERE b.STATUS = 1 and b.kodpejabat = left(Kod_PTJ,2)) as text
        from SMKB_COA_Master"

        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where Status = 1 and (Kod_PTJ LIKE '%' + @kod + '%' or 
        (left(Kod_PTJ,2) in (SELECT b.kodpejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT as b
        WHERE b.STATUS = 1 and b.kodpejabat = left(Kod_PTJ,2) and b.Pejabat like '%' + @kod2 + '%'))) order by Kod_PTJ"

            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If



        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisProjek(ByVal q As String) As String
        'Dim newList As List(Of ItemList)
        'newList = listItem

        'If (q <> "") Then
        '    newList = listItem.Where(
        '        Function(x) x.value.Contains(q) Or x.text.Contains(q)
        '    ).ToList()
        'End If

        Dim tmpDT As DataTable = GetDataProjek(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataProjek(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT DISTINCT A.Kod_Projek as value,B.Butiran as text FROM SMKB_COA_Master A
                                INNER JOIN SMKB_Projek B ON A.Kod_Projek = B.Kod_Projek"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " where A.Status = 1 and (A.Kod_Projek LIKE '%' + @kod + '%' or B.Butiran LIKE '%' + @kod2 + '%') and A.Kod_Operasi =@kod3 order by A.Kod_Projek"
            'Else
            '    query &= " where A.Status = 1 and A.Kod_Operasi =@kod3 order by A.Kod_Projek"
        End If

        param.Add(New SqlParameter("@kod", kod))
        param.Add(New SqlParameter("@kod2", kod))
        param.Add(New SqlParameter("@kod3", kod))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordAdv(AdvList As MhnAdvance) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If AdvList Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        resp.Success("Rekod berjaya disimpan", "00", AdvList)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisTugasTblSewaHotel(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisTugasTblHotel(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisTugasTblHotel(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  FROM   
                    SMKB_Lookup_Detail WHERE Kod='AC04' AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail='K' OR Kod_Detail='R' AND 
                        Butiran like 'Rasmi%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTugasElaunMkn(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisTugasElaunMkn(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisTugasElaunMkn(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  FROM   
                    SMKB_Lookup_Detail WHERE Kod='AC04' AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail='K' OR Kod_Detail='R' AND 
                        Butiran like 'Rasmi%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTugasElaunMknLojing(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisTugasElaunMknLojing(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisTugasElaunMknLojing(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  FROM   
                    SMKB_Lookup_Detail WHERE Kod='AC04' AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail='K' OR Kod_Detail='R' AND 
                        Butiran like 'Rasmi%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function
    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTempatTblHotel(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataTempatTblHotel(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataTempatTblHotel(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  
        FROM   SMKB_Lookup_Detail WHERE (Kod = 'AC03') AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail ='H' OR Kod_Detail='L' AND 
                        Butiran like 'Hotel%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTempatTblElaunMkn(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataTempatTblElaunMkn(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataTempatTblElaunMkn(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  
        FROM   SMKB_Lookup_Detail WHERE (Kod = 'AC03') AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail ='H' OR Kod_Detail='L' AND 
                        Butiran like 'Hotel%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetTempatTblLojing(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataTempatTblLojing(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataTempatTblLojing(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  
        FROM   SMKB_Lookup_Detail WHERE (Kod = 'AC03') AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail ='H' OR Kod_Detail='L' AND 
                        Butiran like 'Hotel%' and (Kod_Detail LIKE '%' + @kod + '%' or Butiran LIKE '%' + @kod2 + '%') "
            param.Add(New SqlParameter("@kod", kod))
            param.Add(New SqlParameter("@kod2", kod))
        End If

        Return db.Read(query, param)

    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisPelbagai(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisBelanjaPelbagai(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisBelanjaPelbagai(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT Kod_Detail as value, Kod_Detail +' - '+ Butiran as text  
        FROM   SMKB_Lookup_Detail WHERE (Kod = 'AC10') AND Kod_Korporat='UTeM' AND status=1"
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Detail ='01' OR Kod_Detail='02' AND 
                        Butiran like 'Tempat%' and (Kod_Detail LIKE '%' + @kod + '%') "
            param.Add(New SqlParameter("@kod", kod))

        End If

        Return db.Read(query, param)

    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecord_PermohonanPP(staffP As String) As String
        Dim resp As New ResponseRepository

        'If isClicked = False Then
        '    Return JsonConvert.SerializeObject(New DataTable)
        'End If

        dt = GetRecord_SenaraiSendiriPP(staffP)



        'dt = GetRecord_SenaraiSendiri(id)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    Private Function GetRecord_SenaraiSendiriPP(staffP As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT  No_Pendahuluan, No_Staf, Jenis_Pendahuluan,Tujuan, Jum_Lulus, isnull(No_Baucar,'-') as No_Baucar
                            FROM  SMKB_Pendahuluan_Hdr
                            WHERE (Jenis_Pendahuluan = 'PP') AND  No_Staf = @staffP "


        Dim param = New List(Of SqlParameter)
        param.Add(New SqlParameter("@staffP", staffP))
        Return db.Read(query, param)
    End Function
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadOrderRecord_PermohonanSendiri(category_filter As String, isClicked As Boolean, tkhMula As DateTime, tkhTamat As DateTime, staffP As String) As String
        Dim resp As New ResponseRepository

        If isClicked = False Then
            Return JsonConvert.SerializeObject(New DataTable)
        End If

        dt = GetRecord_SenaraiSendiri(category_filter, tkhMula, tkhTamat, staffP)
        resp.SuccessPayload(dt)
        'resp.GetResult()
        Return JsonConvert.SerializeObject(dt)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Private Function GetRecord_SenaraiSendiri(category_filter As String, tkhMula As DateTime, tkhTamat As DateTime, staffP As String) As DataTable
        Dim db = New DBKewConn
        Dim tarikhQuery As String = ""
        Dim param = New List(Of SqlParameter)

        If category_filter = "1" Then 'Harini
            'tarikhQuery = " and a.Tkh_Transaksi = getdate() "
            tarikhQuery = "and a.No_Staf = @staffP and CAST(a.Tarikh_Mohon AS DATE) = CAST(getdate() AS DATE) "
        ElseIf category_filter = "2" Then 'Semalam
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -2, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = "and a.No_Staf = @staffP and CAST(a.Tarikh_Mohon AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
        ElseIf category_filter = "3" Then 'seminggu
            'tarikhQuery = " and a.Tkh_Transaksi >= DATEADD(day, -8, getdate()) and a.Tkh_Transaksi <= getdate() "
            tarikhQuery = " and a.No_Staf = @staffP  and CAST(a.Tarikh_Mohon AS DATE) >= CAST(DATEADD(DAY, -7, GETDATE()) AS DATE) "
        ElseIf category_filter = "4" Then '30 hari
            tarikhQuery = " and a.No_Staf = @staffP and a.Tarikh_Mohon >= DATEADD(month, -1, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "5" Then '60 hari
            tarikhQuery = " and a.No_Staf = @staffP and a.Tarikh_Mohon >= DATEADD(month, -2, getdate()) and a.Tarikh_Mohon <= getdate() "
        ElseIf category_filter = "6" Then 'custom
            tarikhQuery = " and a.No_Staf = @staffP  and a.Tarikh_Mohon >= @tkhMula and a.Tarikh_Mohon <= @TkhTamat "
            param.Add(New SqlParameter("@tkhMula", tkhMula))
            param.Add(New SqlParameter("@TkhTamat", tkhTamat))
        End If


        Dim query As String = "SELECT a.No_Tuntutan, a.Tujuan_Tuntutan,  a.PTj, a.Bulan_Tuntut, a.Tahun_Tuntut, a.Status, a.No_Pendahuluan,
                FORMAT(a.Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon,  isnull(a.Jum_Pendahuluan,'0.00') as Jum_Pendahuluan,                      
                a.Kod_Kump_Wang, (select Butiran from SMKB_Kump_Wang as kw where a.Kod_Kump_Wang = kw.Kod_Kump_Wang) as colKW,
                a.Kod_Operasi, (select Butiran from SMKB_Operasi as ko where  ko.Kod_Operasi = a.Kod_Operasi) as colKO,
                a.Kod_Projek,  (select Butiran from SMKB_Projek as kp where kp.Kod_Projek = a.Kod_Projek) as colKp,
                a.Kod_PTJ,  (SELECT b.Pejabat FROM [DEVMIS\SQL_INS01].dbStaf.dbo.MS_PEJABAT as b WHERE b.STATUS = 1 and b.kodpejabat = left(a.Kod_PTJ,2)) as ButiranPTJ  ,
                 a.Status_Dok,
                b.Butiran, a.No_Staf + ' - ' + c.ms01_nama   as NamaPemohon, a.No_Staf as Nopemohon
                FROM SMKB_Tuntutan_Hdr as a INNER JOIN 
                SMKB_Kod_Status_Dok AS b ON a.Status_Dok = b.Kod_Status_Dok INNER JOIN
                [qa11].dbStaf.dbo.MS01_Peribadi as c ON a.No_Staf = c.ms01_noStaf
                WHERE  (b.Kod_Modul = '09') AND (b.Kod_Status_Dok = '02') AND (a.Jenis_Tuntutan ='DN')  " & tarikhQuery & " order by a.Tarikh_Mohon desc"
        ' WHERE a.Status_Dok='01' AND a.Pengesahan_Pemohon='0' " & tarikhQuery & " order by a.Tarikh_Mohon desc"

        param.Add(New SqlParameter("@staffP", staffP))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordTuntutan(listClaim As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        If listClaim Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If listClaim.OrderID = "" Then 'untuk permohonan baru
            listClaim.OrderID = GenerateOrderID()

            If InsertNewOrder(listClaim) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
            End If
        Else 'untuk permohonan sedia ada

            If UpdateNewOrder(listClaim) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If
        End If


        'If UpdateStatusDokOrder_Mohon(listClaim, "Y") <> "OK" Then

        '    'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order YX
        '    Return JsonConvert.SerializeObject(resp.GetResult())
        '    ' Exit Function

        'End If


        resp.Success("Rekod berjaya disimpan", "00", listClaim)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function InsertNewOrder(listClaim As MhnDlmNegara)
        Dim db As New DBKewConn
        'Dim year = Date.Now.ToString("yyyy")
        'Dim month = Date.Now.Month
        'Dim blnTuntut = month + "/" + year

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Hdr (No_Tuntutan, No_Staf, PTj, Tarikh_Mohon, Bulan_Tuntut,Tahun_Tuntut, Jenis_Tuntutan, 
                    No_Pendahuluan, Status_Dok, Status,  Jum_Pendahuluan, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, Kod_PTJ,  ID_Mohon, Pengesahan_Pemohon, Akuan_Pemohon, Sebab_Lewat)
                    VALUES (@No_Tuntutan, @No_Staf, @PTj, @Tarikh_Mohon,  @Bulan_Tuntut, @Tahun_Tuntut, 
                    @Jenis_Tuntutan, @No_Pendahuluan, @Status_Dok, @Status, @Jum_Pendahuluan, @Kod_Kump_Wang, @Kod_Operasi, @Kod_Projek,@Kod_PTJ, @ID_Mohon, @Pengesahan_Pemohon, @Akuan_Pemohon,@Sebab_Lewat)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listClaim.OrderID))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@PTj", listClaim.hidPtjPemohon))
        param.Add(New SqlParameter("@Tarikh_Mohon", listClaim.TkhMohon))
        param.Add(New SqlParameter("@Sebab_Lewat", listClaim.sebabLewat))
        param.Add(New SqlParameter("@Bulan_Tuntut", listClaim.Bulan))
        param.Add(New SqlParameter("@Tahun_Tuntut", listClaim.Tahun))
        param.Add(New SqlParameter("@Jenis_Tuntutan", "DN"))
        param.Add(New SqlParameter("@No_Pendahuluan", listClaim.noPendahuluan))
        param.Add(New SqlParameter("@Status_Dok", "02"))
        param.Add(New SqlParameter("@Status", "1"))
        param.Add(New SqlParameter("@Jum_Pendahuluan", listClaim.jumlahBaucer))
        param.Add(New SqlParameter("@Kod_Kump_Wang", listClaim.KumpWang))
        param.Add(New SqlParameter("@Kod_Operasi", listClaim.KodOperasi))
        param.Add(New SqlParameter("@Kod_Projek", listClaim.KodProjek))
        param.Add(New SqlParameter("@Kod_PTJ", listClaim.KodPtj))
        param.Add(New SqlParameter("@Id_Mohon", Session("ssusrID")))
        param.Add(New SqlParameter("@Pengesahan_Pemohon", listClaim.staPemohon))
        param.Add(New SqlParameter("@Akuan_Pemohon", "1"))



        Return db.Process(query, param)
    End Function

    Private Function UpdateNewOrder(listClaim As MhnDlmNegara)


        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Pendahuluan_Hdr SET 
                                Tarikh_Mula = @Tarikh_Mula, Tarikh_Tamat = @Tarikh_Tamat, Justifikasi_Prgm = @TunjukSebab, Peruntukan_Prgm = @Peruntukan_Prgm,  
                                Kod_Kump_Wang = @Kod_Kump_Wang , Kod_Operasi = @Kod_Operasi, Kod_Projek = @Kod_Projek, Kod_PTJ = @Kod_PTJ, Kod_Vot= @Kod_Vot,  
                                 Tkh_Adv_Perlu = @TkhAdvPerlu,  CaraBayar = @CaraBayar 
                                WHERE No_Pendahuluan = @No_Pendahuluan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Pendahuluan", listClaim.OrderID))
        param.Add(New SqlParameter("@PTj", listClaim.KodPtj))
        'param.Add(New SqlParameter("@Tujuan", listClaim.TujuanMohon))
        'param.Add(New SqlParameter("@TunjukSebab", listDetail.TunjukSebab))
        param.Add(New SqlParameter("@Peruntukan_Prgm", listClaim.KodPtj))
        param.Add(New SqlParameter("@Kod_Kump_Wang", listClaim.KumpWang))
        param.Add(New SqlParameter("@Kod_Operasi", listClaim.KodOperasi))
        param.Add(New SqlParameter("@Kod_Projek", listClaim.KodProjek))
        param.Add(New SqlParameter("@Kod_PTJ", listClaim.KodPtj))


        Return db.Process(query, param)
    End Function

    Private Function GenerateOrderID() As String
        Dim db As New DBKewConn

        Dim year = Date.Now.ToString("yyyy")
        Dim month = Date.Now.Month

        Dim lastID As Integer = 1
        Dim newOrderID As String = ""

        Dim query As String = $"select TOP 1 No_Akhir as id from SMKB_No_Akhir where Kod_Modul ='09' AND Prefix ='CL' AND Tahun =@year"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@year", year))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1

            UpdateNoAkhir("09", "CL", year, lastID)
        Else

            InsertNoAkhir("09", "CL", year, lastID)
        End If
        newOrderID = "CL" + Format(lastID, "000000").ToString + month.ToString("00") + Right(year.ToString(), 2)

        Return newOrderID
    End Function

    Private Function UpdateNoAkhir(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_No_Akhir
        set No_Akhir = @No_Akhir
        where Kod_Modul=@Kod_Modul and Prefix=@Prefix and Tahun =@Tahun"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@Tahun", year))

        Return db.Process(query, param)
    End Function

    Private Function InsertNoAkhir(kodModul As String, prefix As String, year As String, ID As String)
        Dim db As New DBKewConn
        Dim query As String = "INSERT INTO SMKB_No_Akhir
        VALUES(@Kod_Modul ,@Prefix, @No_Akhir, @Tahun, @Butiran, @Kod_PTJ)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", kodModul))
        param.Add(New SqlParameter("@Prefix", prefix))
        param.Add(New SqlParameter("@No_Akhir", ID))
        param.Add(New SqlParameter("@Tahun", year))
        param.Add(New SqlParameter("@Butiran", "Tuntutan Dalam Negara"))
        param.Add(New SqlParameter("@Kod_PTJ", "-"))


        Return db.Process(query, param)
    End Function

    'Private Function UpdateStatusDokOrder_Mohon(listClaim As MhnDlmNegara, statusLulus As String)
    '    Dim db As New DBKewConn

    '    Dim kodstatusLulus As String

    '    If statusLulus = "Y" Then

    '        kodstatusLulus = "02"

    '    End If


    '    Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
    '			VALUES
    '			(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

    '    Dim param As New List(Of SqlParameter)

    '    param.Add(New SqlParameter("@Kod_Modul", "04"))
    '    param.Add(New SqlParameter("@Kod_Status_Dok", "01"))
    '    param.Add(New SqlParameter("@No_Rujukan", listClaim.OrderID))
    '    param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
    '    param.Add(New SqlParameter("@Status_Transaksi", 1))
    '    param.Add(New SqlParameter("@Status", 1))
    '    param.Add(New SqlParameter("@Ulasan", "-"))

    '    Return db.Process(query, param)

    'End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordKenyataan(kenyataan As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        For Each listKenyataan As tblKenyataan In kenyataan.GroupKenyataan

            If listKenyataan.tujuan = "" Then
                Continue For
            End If

            JumRekod += 1

            If listKenyataan.mohonID <> "" Then
                If semakdataKeperluan(listKenyataan.mohonID, listKenyataan.idbil) = "wujud" Then
                    'updateDataKeperluan--
                    If UpdateOrderDetail(listKenyataan) = "OK" Then
                        success += 1

                    End If
                Else
                    'insert Data Keperluan
                    listKenyataan.idbil = GenerateOrderDetailID(listKenyataan.mohonID)
                    listKenyataan.mohonID = kenyataan.OrderID
                    If InsertDataItem(listKenyataan) = "OK" Then
                        success += 1

                    End If
                End If
            Else

            End If
        Next



        resp.Success("Rekod berjaya disimpan", "00", kenyataan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function GenerateOrderDetailID(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 Bil as id
        from SMKB_Tuntutan_Dlm_Kenyataan 
        where No_Tuntutan = @itemId
        ORDER BY id DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function semakdataKeperluan(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT   No_Tuntutan, Bil FROM SMKB_Tuntutan_Dlm_Kenyataan WHERE No_Tuntutan=@mohonID AND Bil=@id"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@id", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    Private Function InsertDataItem(listKenyataan As tblKenyataan)
        Dim db As New DBKewConn

        Dim masaMula As String
        Dim masaTamat As String

        masaMula = listKenyataan.MasaTolakJam + ":" + listKenyataan.MasaTolakMinit

        masaTamat = listKenyataan.MasaSampaiJam + ":" + listKenyataan.MasaSampaiMinit

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dlm_Kenyataan (No_Tuntutan, Bil, Tarikh, Masa_Bertolak, 
                            Masa_Sampai, Tujuan, Flag_Mula, Flag_Tamat, No_Kend, Flag_Kend_Sendiri, Jarak)
                            VALUES(@NoTuntutan, @bil,@tkhMula, @MasaMula, @MasaTamat, @Tujuan, @flagMula, @flagTamat, @No_Kend, @FlagKendSend, @Jarak)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@NoTuntutan", listKenyataan.mohonID))
        param.Add(New SqlParameter("@bil", listKenyataan.idbil))
        param.Add(New SqlParameter("@tkhMula", listKenyataan.tarikh))
        param.Add(New SqlParameter("@MasaMula", masaMula))
        param.Add(New SqlParameter("@MasaTamat", masaTamat))
        param.Add(New SqlParameter("@Tujuan", listKenyataan.tujuan))
        param.Add(New SqlParameter("@flagMula", listKenyataan.flagMula))
        param.Add(New SqlParameter("@flagTamat", listKenyataan.flagTamat))
        param.Add(New SqlParameter("@No_Kend", listKenyataan.Kenderaan))
        param.Add(New SqlParameter("@FlagKendSend", listKenyataan.staKenderaan))
        param.Add(New SqlParameter("@Jarak", listKenyataan.Jarak))



        Return db.Process(query, param)
    End Function

    Private Function UpdateOrderDetail(listKenyataan As tblKenyataan)
        Dim db = New DBKewConn
        Dim masaMula As String
        Dim masaTamat As String

        masaMula = listKenyataan.MasaTolakJam + ":" + listKenyataan.MasaTolakMinit
        masaTamat = listKenyataan.MasaSampaiJam + ":" + listKenyataan.MasaSampaiMinit

        Dim query As String = "UPDATE SMKB_Tuntutan_Dlm_Kenyataan
        set Tujuan = @Tujuan, Tarikh = @tkhMula, Masa_Bertolak = @MasaMula, Jarak = @Jarak, 
        Masa_Sampai = @MasaTamat, Flag_Mula = @flagMula, Flag_Tamat = @flagTamat, No_Kend = @No_Kend, Flag_Kend_Sendiri = @FlagKendSend
        where No_Tuntutan = @NoTuntutan  AND Bil = @bil"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoTuntutan", listKenyataan.mohonID))
        param.Add(New SqlParameter("@bil", listKenyataan.idbil))
        param.Add(New SqlParameter("@tkhMula", listKenyataan.tarikh))
        param.Add(New SqlParameter("@MasaMula", masaMula))
        param.Add(New SqlParameter("@MasaTamat", masaTamat))
        param.Add(New SqlParameter("@Tujuan", listKenyataan.tujuan))
        param.Add(New SqlParameter("@flagMula", listKenyataan.flagMula))
        param.Add(New SqlParameter("@flagTamat", listKenyataan.flagTamat))
        param.Add(New SqlParameter("@No_Kend", listKenyataan.Kenderaan))
        param.Add(New SqlParameter("@FlagKendSend", listKenyataan.staKenderaan))
        param.Add(New SqlParameter("@Jarak", listKenyataan.Jarak))
        Return db.Process(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordElaunPjln(itemEP As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim sumTotal As Decimal = 0.00


        For Each listItemEP As ElaunPjln_Item In itemEP.GroupItemTabElaunPjln

            If listItemEP.strJumJarak = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model

            If listItemEP.mohonID <> "" Then
                If semakdataElaunPjln(listItemEP.mohonID, listItemEP.strhidKM) = "wujud" Then
                    itemEP.OrderID = listItemEP.mohonID
                    'updateDataKeperluan--
                    If UpdateDataElaunPjln(listItemEP) = "OK" Then
                        success += 1
                        'listItemEP.strTotalEP += listItemEP.strJumlahEP
                        itemEP.Jumlah += listItemEP.strJumlahEP
                    End If
                Else
                    'insert Data Keperluan
                    listItemEP.strhidKM = GenerateIDDataElaunPjln(listItemEP.mohonID)
                    itemEP.OrderID = listItemEP.mohonID
                    If InsertDataElaunPjln(listItemEP) = "OK" Then
                        success += 1
                        itemEP.Jumlah += listItemEP.strJumlahEP
                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalElaunPjln(itemEP) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", itemEP)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateTotalElaunPjln(itemEP As MhnDlmNegara) As String


        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Elaun_Kend = @Jumlah_Elaun_Kend                                 
                                WHERE No_Tuntutan = @No_Tuntutan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", itemEP.OrderID))
        param.Add(New SqlParameter("@Jumlah_Elaun_Kend", itemEP.Jumlah))


        Return db.Process(query, param)
    End Function

    Private Function InsertDataElaunPjln(listItemEP As ElaunPjln_Item)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl(No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, Jenis_Kenderaan, No_Plat, KM, Flag_Kongsi_Kend, 
                         Kadar_Harga, Jumlah_anggaran)
                        VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Kenderaan , @No_Plat, @KM, @Flag_Kongsi_Kend,@Kadar_Harga,@Jumlah_anggaran)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listItemEP.mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EK"))
        param.Add(New SqlParameter("@No_Item", listItemEP.strhidKM))
        param.Add(New SqlParameter("@Jenis_Kenderaan", listItemEP.strHidJnsK))
        param.Add(New SqlParameter("@No_Plat", listItemEP.strKenderaan))
        param.Add(New SqlParameter("@KM", listItemEP.strJumJarak))
        param.Add(New SqlParameter("@Kadar_Harga", listItemEP.strKadarKM))
        param.Add(New SqlParameter("@Jumlah_anggaran", listItemEP.strJumlahEP))
        param.Add(New SqlParameter("@Flag_Kongsi_Kend", listItemEP.strFlagKend))


        Return db.Process(query, param)
    End Function
    Private Function GenerateIDDataElaunPjln(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='EK'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function


    Private Function UpdateDataElaunPjln(listItemEP As ElaunPjln_Item)
        Dim db = New DBKewConn

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Kenderaan = @Jenis_Kenderaan, No_Plat = @No_Plat, KM = @KM, Flag_Kongsi_Kend= @Flag_Kongsi_Kend,
        Kadar_Harga = @Kadar_Harga,Jumlah_anggaran = @Jumlah_anggaran 
        where No_Tuntutan = @No_Tuntutan AND No_Item= @No_Item"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listItemEP.mohonID))
        param.Add(New SqlParameter("@KM", listItemEP.strJumJarak))
        param.Add(New SqlParameter("@No_Item", listItemEP.strhidKM))
        param.Add(New SqlParameter("@Jenis_Kenderaan", listItemEP.strHidJnsK))
        param.Add(New SqlParameter("@No_Plat", listItemEP.strKenderaan))
        param.Add(New SqlParameter("@Flag_Kongsi_Kend", listItemEP.strFlagKend))
        param.Add(New SqlParameter("@Kadar_Harga", listItemEP.strKadarKM))
        param.Add(New SqlParameter("@Jumlah_anggaran", listItemEP.strJumlahEP))


        Return db.Process(query, param)
    End Function

    Private Function semakdataElaunPjln(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT   No_Tuntutan, No_Item FROM SMKB_Tuntutan_Dtl WHERE No_Tuntutan=@mohonID AND Jns_Dtl_Tuntutan='EK' AND No_Item = @bil"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@bil", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordTambangKendAwam(itemKendAwam As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim sumTotal As Decimal = 0.00


        For Each listItemTambang As TambangAwam In itemKendAwam.GroupItemKendAwam

            If listItemTambang.Tambang_jnsKend = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model

            If listItemTambang.Tambang_mohonID <> "" Then
                If semakdataTambangAwam(listItemTambang.Tambang_mohonID, listItemTambang.Tambang_hidID) = "wujud" Then
                    'updateData Tambang Awam--
                    itemKendAwam.OrderID = listItemTambang.Tambang_mohonID
                    If UpdateDataTambangAwam(listItemTambang) = "OK" Then
                        success += 1
                        listItemTambang.Tambang_Total += listItemTambang.Tambang_amaun
                    End If
                Else
                    'insert data Tambang Awam
                    listItemTambang.Tambang_hidID = GenerateIDTambangAwam(listItemTambang.Tambang_mohonID)
                    itemKendAwam.OrderID = listItemTambang.Tambang_mohonID
                    If InsertDataTambangAwam(listItemTambang) = "OK" Then
                        success += 1
                        'listItemTambang.Tambang_Total += listItemTambang.Tambang_amaun
                        itemKendAwam.Jumlah += listItemTambang.Tambang_amaun
                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalTambangAwam(itemKendAwam) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", itemKendAwam)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateTotalTambangAwam(itemKendAwam As MhnDlmNegara) As String

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Tambang_Awam = @Jumlah_Tambang_Awam                                 
                                WHERE No_Tuntutan = @No_Tuntutan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", itemKendAwam.OrderID))
        param.Add(New SqlParameter("@Jumlah_Tambang_Awam", itemKendAwam.Jumlah))


        Return db.Process(query, param)
    End Function
    Private Function InsertDataTambangAwam(listItemTambang As TambangAwam)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl( No_Tuntutan, Jns_Dtl_Tuntutan, No_Item,   Jenis_Tambang,  Flag_Resit, No_Resit,  
                         Jumlah_anggaran)
                        VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Tambang , @Flag_Resit, @No_Resit, @Jumlah_anggaran)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listItemTambang.Tambang_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "TA"))
        param.Add(New SqlParameter("@No_Item", listItemTambang.Tambang_hidID))
        param.Add(New SqlParameter("@Jenis_Tambang", listItemTambang.Tambang_jnsKend))
        param.Add(New SqlParameter("@Flag_Resit", listItemTambang.Tambang_dgnResit))
        param.Add(New SqlParameter("@No_Resit", listItemTambang.Tambang_noResit))
        param.Add(New SqlParameter("@Jumlah_anggaran", listItemTambang.Tambang_amaun))


        Return db.Process(query, param)
    End Function

    Private Function UpdateDataTambangAwam(listItemTambang As TambangAwam)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Tambang = @Jenis_Tambang, Flag_Resit = @Flag_Resit, No_Resit = @No_Resit, 
        Jumlah_anggaran = @Jumlah_anggaran
        where No_Tuntutan= @No_Tuntutan AND  No_Item = @No_Item AND Jns_Dtl_Tuntutan= @Jns_Dtl_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listItemTambang.Tambang_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "TA"))
        param.Add(New SqlParameter("@No_Item", listItemTambang.Tambang_hidID))
        param.Add(New SqlParameter("@Jenis_Tambang", listItemTambang.Tambang_jnsKend))
        param.Add(New SqlParameter("@Flag_Resit", listItemTambang.Tambang_dgnResit))
        param.Add(New SqlParameter("@No_Resit", listItemTambang.Tambang_noResit))
        param.Add(New SqlParameter("@Jumlah_anggaran", listItemTambang.Tambang_amaun))

        Return db.Process(query, param)
    End Function
    Private Function GenerateIDTambangAwam(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='TA'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function


    Private Function semakdataTambangAwam(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT   No_Tuntutan, No_Item   FROM SMKB_Tuntutan_Dtl WHERE No_Tuntutan=@mohonID AND Jns_Dtl_Tuntutan='TA' AND No_Item = @bil"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@bil", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataElaunMakan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordElaunMakan(id)

        'For Each x As DataRow In dt.Rows
        '    If Not IsDBNull(x.Item("Nama_Fail")) Then
        '        Dim url As String = GetBaseUrl() + Trim(x.Item("Path")) + "/" + x.Item("Nama_Fail")
        '        x.Item("Path") = url
        '    End If
        'Next
        'Return JsonConvert.SerializeObject(dt)


        resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallRecordElaunMakan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Tempat,b.Jenis_Tugas,
                        b.Flag_Mkn_Pagi, b.Flag_Mkn_Tghari,b.Flag_Mkn_Mlm, b.Flag_Elaun_Harian,
                        b.Kadar_Harga,  b.Jumlah_anggaran, g.Butiran as Tempat,
                        h.Butiran as JenisTugas
                        FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
                        SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN           
                        SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
                        SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
                        WHERE  g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EM' AND a.No_Tuntutan =@No_Tuntutan
                        ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordElaunMakan(itemElaunMakan As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim sumTotal As Decimal = 0.00


        For Each listElaunMkn As ElaunMakan In itemElaunMakan.GroupElaunMakan

            If listElaunMkn.EM_mohonID = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model

            If listElaunMkn.EM_mohonID <> "" Then
                If semakdataElaunMakan(listElaunMkn.EM_mohonID, listElaunMkn.EM_hidID) = "wujud" Then
                    'updateDataKeperluan--
                    itemElaunMakan.OrderID = listElaunMkn.EM_mohonID
                    If UpdateDataElaunMakan(listElaunMkn) = "OK" Then
                        success += 1
                        listElaunMkn.EM_harga += listElaunMkn.EM_Jumlah
                    End If
                Else
                    'insert Data Keperluan
                    listElaunMkn.EM_hidID = GenerateIDDataElaunMakan(listElaunMkn.EM_mohonID)
                    itemElaunMakan.OrderID = listElaunMkn.EM_mohonID
                    If InsertDataElaunMakan(listElaunMkn) = "OK" Then
                        success += 1
                        listElaunMkn.EM_harga += listElaunMkn.EM_Jumlah
                    End If
                End If
                'listElaunMkn.EM_hidID = listElaunMkn.EM_hidID + 1
            Else

            End If
            listElaunMkn.EM_hidID = listElaunMkn.EM_hidID + 1
        Next


        If UpdateTotalElaunMakan(itemElaunMakan) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", itemElaunMakan)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function UpdateTotalElaunMakan(itemElaunMakan As MhnDlmNegara)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Elaun_Mkn = @Jumlah_Elaun_Mkn                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", itemElaunMakan.OrderID))
        param.Add(New SqlParameter("@Jumlah_Elaun_Mkn", itemElaunMakan.Jumlah))

        Return db.Process(query, param)
    End Function
    Private Function InsertDataElaunMakan(listElaunMkn As ElaunMakan)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl(No_Tuntutan, Jns_Dtl_Tuntutan,No_Item, Jenis_Tempat, Jenis_Tugas, 
                      Flag_Mkn_Pagi, Flag_Mkn_Tghari,Flag_Mkn_Mlm, Flag_Elaun_Harian, Bil_Hari, Kadar_Harga, Jumlah_anggaran)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Tempat,@Jenis_Tugas, @Flag_Mkn_Pagi,@Flag_Mkn_Tghari,@Flag_Mkn_Mlm,@Flag_Elaun_Harian,
                    @Bil_Hari,@Kadar_Harga, @Jumlah_anggaran)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listElaunMkn.EM_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EM"))
        param.Add(New SqlParameter("@No_Item", listElaunMkn.EM_hidID))
        param.Add(New SqlParameter("@Jenis_Tempat", listElaunMkn.EM_tempat))
        param.Add(New SqlParameter("@Jenis_Tugas", listElaunMkn.EM_JnsPerjalanan))
        param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMkn.EM_MknPagi))
        param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMkn.EM_MknTghri))
        param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMkn.EM_MknMlm))
        param.Add(New SqlParameter("@Flag_Elaun_Harian", listElaunMkn.EM_ElaunHarian))
        param.Add(New SqlParameter("@Bil_Hari", listElaunMkn.EM_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", listElaunMkn.EM_harga))
        param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMkn.EM_Jumlah))


        Return db.Process(query, param)
    End Function

    Private Function GenerateIDDataElaunMakan(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='EM'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateDataElaunMakan(listElaunMkn As ElaunMakan)
        Dim db = New DBKewConn

        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas,Flag_Mkn_Pagi = @Flag_Mkn_Pagi,
        Flag_Mkn_Tghari = @Flag_Mkn_Tghari, Flag_Mkn_Mlm = @Flag_Mkn_Mlm,Bil_Hari = @Bil_Hari,  Kadar_Harga = @Kadar_Harga, 
        Jumlah_anggaran = @Jumlah_anggaran
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EM'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listElaunMkn.EM_mohonID))
        param.Add(New SqlParameter("@No_Item", listElaunMkn.EM_hidID))
        param.Add(New SqlParameter("@Jenis_Tempat", listElaunMkn.EM_tempat))
        param.Add(New SqlParameter("@Jenis_Tugas", listElaunMkn.EM_JnsPerjalanan))
        param.Add(New SqlParameter("@Flag_Mkn_Pagi", listElaunMkn.EM_MknPagi))
        param.Add(New SqlParameter("@Flag_Mkn_Tghari", listElaunMkn.EM_MknTghri))
        param.Add(New SqlParameter("@Flag_Mkn_Mlm", listElaunMkn.EM_MknMlm))
        param.Add(New SqlParameter("@Bil_Hari", listElaunMkn.EM_bilHari))
        param.Add(New SqlParameter("@Kadar_Harga", listElaunMkn.EM_harga))
        param.Add(New SqlParameter("@Jumlah_anggaran", listElaunMkn.EM_Jumlah))

        Return db.Process(query, param)
    End Function
    Private Function semakdataElaunMakan(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT  No_Tuntutan, No_Item FROM SMKB_Tuntutan_Dtl Where No_Tuntutan =@mohonID AND No_Item = @id AND Jns_Dtl_Tuntutan='EM'"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@id", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveDataSewaHotelWS(itemSewaHotel As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim sumTotal As Decimal = 0.00


        For Each listSewaHotel As SewaHotelTbl In itemSewaHotel.GroupSewaHotel

            If listSewaHotel.SH_mohonID = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model

            If listSewaHotel.SH_mohonID <> "" Then
                If semakdataSewaHotel(listSewaHotel.SH_mohonID, listSewaHotel.SH_hidID) = "wujud" Then
                    'updateDataKeperluan--
                    If UpdateDataSewaHotel(listSewaHotel) = "OK" Then
                        success += 1
                        listSewaHotel.SH_Jumlah += listSewaHotel.SH_Jumlah
                    End If
                Else
                    'insert Data Keperluan
                    listSewaHotel.SH_hidID = GenerateIDDataSewaHotel(listSewaHotel.SH_mohonID)
                    itemSewaHotel.OrderID = listSewaHotel.SH_mohonID
                    If InsertDataSewaHotel(listSewaHotel) = "OK" Then
                        success += 1
                        listSewaHotel.SH_Total += listSewaHotel.SH_Jumlah
                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalSewaHotel(itemSewaHotel) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", itemSewaHotel)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function UpdateTotalSewaHotel(SewaHotel As MhnDlmNegara)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Sewa_HotelLojing = @Jumlah_Sewa_HotelLojing                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", SewaHotel.OrderID))
        param.Add(New SqlParameter("@Jumlah_Sewa_HotelLojing", SewaHotel.Jumlah))


        Return db.Process(query, param)
    End Function

    Private Function InsertDataSewaHotel(listSewaHotel As SewaHotelTbl)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                    Jenis_Tempat, Jenis_Tugas, Bil_Hari, Jenis_Penginapan, Kadar_Harga, Jumlah_anggaran)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tempat, @Jenis_Tugas, @Bil_Hari,
                            @Jenis_Penginapan,@Kadar_Harga,@Jumlah_anggaran)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", listSewaHotel.SH_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", listSewaHotel.SH_hidID))
        param.Add(New SqlParameter("@No_Resit", listSewaHotel.SH_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", listSewaHotel.SH_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", listSewaHotel.SH_JnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", listSewaHotel.SH_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", listSewaHotel.SH_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", listSewaHotel.SH_Jumlah))


        Return db.Process(query, param)
    End Function

    Private Function GenerateIDDataSewaHotel(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 No_Item as id
        from SMKB_Pendahuluan_Dtl 
        where No_Pendahuluan = @itemId
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateDataSewaHotel(listSewaHotel As SewaHotelTbl)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Tempat = @Jenis_Tempat, Jenis_Tugas = @Jenis_Tugas, Bil_Hari = @Bil_Hari, 
        No_Resit = @No_Resit, Kadar_Harga=@Kadar_Harga, Jumlah_anggaran = @Jumlah_anggaran
        where No_Item = @No_Item AND No_Tuntutan=@No_Tuntutan AND Jns_Dtl_Tuntutan='EH' "

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listSewaHotel.SH_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EH"))
        param.Add(New SqlParameter("@No_Item", listSewaHotel.SH_hidID))
        param.Add(New SqlParameter("@No_Resit", listSewaHotel.SH_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", listSewaHotel.SH_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", listSewaHotel.SH_JnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", listSewaHotel.SH_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "H"))
        param.Add(New SqlParameter("@Kadar_Harga", listSewaHotel.SH_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", listSewaHotel.SH_Jumlah))

        Return db.Process(query, param)
    End Function
    Private Function semakdataSewaHotel(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT   No_Tuntutan, No_Item   FROM SMKB_Tuntutan_Dtl WHERE No_Tuntutan=@mohonID AND Jns_Dtl_Tuntutan='EH' AND No_Item = @bil"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@bil", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordSewaLojing(SewaLojing As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim sumTotal As Decimal = 0.00


        For Each listSewaLojing As SewaLojingTbl In SewaLojing.GroupSewaLojing

            If listSewaLojing.SL_mohonID = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model

            If listSewaLojing.SL_mohonID <> "" Then
                If semakdataSewaLojing(listSewaLojing.SL_mohonID, listSewaLojing.SL_hidID) = "wujud" Then
                    'updateDataKeperluan--
                    If UpdateDataSewaLojing(listSewaLojing) = "OK" Then
                        success += 1
                        listSewaLojing.SL_Jumlah += listSewaLojing.SL_Jumlah
                    End If
                Else
                    'insert Data Keperluan
                    listSewaLojing.SL_hidID = GenerateIDDataSewaLojing(listSewaLojing.SL_mohonID)
                    SewaLojing.OrderID = listSewaLojing.SL_mohonID
                    If InsertDataSewaLojing(listSewaLojing) = "OK" Then
                        success += 1
                        listSewaLojing.SL_Total += listSewaLojing.SL_Jumlah
                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalSewaLojing(SewaLojing) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", SewaLojing)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function UpdateTotalSewaLojing(SewaHotel As MhnDlmNegara)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Pendahuluan_Dtl
        set Butiran = @Butiran, Kuantiti = @Kuantiti, Kadar_Harga = @Kadar_Harga, 
        Jumlah_anggaran = @Jumlah_anggaran
        where No_Item = @No_Item AND No_Pendahuluan=@No_Pendahuluan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Pendahuluan", SewaHotel.OrderID))
        param.Add(New SqlParameter("@No_Item", SewaHotel.OrderID))
        param.Add(New SqlParameter("@Butiran", SewaHotel.OrderID))
        param.Add(New SqlParameter("@Kuantiti", SewaHotel.OrderID))
        param.Add(New SqlParameter("@Kadar_Harga", SewaHotel.OrderID))
        param.Add(New SqlParameter("@Jumlah_anggaran", SewaHotel.OrderID))

        Return db.Process(query, param)
    End Function
    Private Function InsertDataSewaLojing(listSewaLojing As SewaLojingTbl)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO  SMKB_Tuntutan_Dtl (No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, 
                    Jenis_Tempat, Jenis_Tugas, Bil_Hari, Jenis_Penginapan,Alamat_Lojing, Kadar_Harga, Jumlah_anggaran)
                     VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @No_Resit , @Jenis_Tempat, @Jenis_Tugas, @Bil_Hari,
                            @Jenis_Penginapan, @Alamat_Lojing, @Kadar_Harga,@Jumlah_anggaran)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listSewaLojing.SL_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EL"))
        param.Add(New SqlParameter("@No_Item", listSewaLojing.SL_hidID))
        param.Add(New SqlParameter("@No_Resit", listSewaLojing.SL_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", listSewaLojing.SL_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", listSewaLojing.SL_JnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", listSewaLojing.SL_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "L"))
        param.Add(New SqlParameter("@Kadar_Harga", listSewaLojing.SL_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", listSewaLojing.SL_Jumlah))



        Return db.Process(query, param)
    End Function

    Private Function GenerateIDDataSewaLojing(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "select TOP 1 No_Item as id
        from SMKB_Pendahuluan_Dtl 
        where No_Pendahuluan = @itemId
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateDataSewaLojing(listSewaLojing As SewaLojingTbl)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Pendahuluan_Dtl
        set Butiran = @Butiran, Kuantiti = @Kuantiti, Kadar_Harga = @Kadar_Harga, 
        Jumlah_anggaran = @Jumlah_anggaran
        where No_Item = @No_Item AND No_Pendahuluan=@No_Pendahuluan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", listSewaLojing.SL_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "EL"))
        param.Add(New SqlParameter("@No_Item", listSewaLojing.SL_hidID))
        param.Add(New SqlParameter("@No_Resit", listSewaLojing.SL_noResit))
        param.Add(New SqlParameter("@Jenis_Tempat", listSewaLojing.SL_JnsTempat))
        param.Add(New SqlParameter("@Jenis_Tugas", listSewaLojing.SL_JnsTugas))
        param.Add(New SqlParameter("@Bil_Hari", listSewaLojing.SL_bilHari))
        param.Add(New SqlParameter("@Jenis_Penginapan", "L"))
        param.Add(New SqlParameter("@Kadar_Harga", listSewaLojing.SL_ElaunHarian))
        param.Add(New SqlParameter("@Jumlah_anggaran", listSewaLojing.SL_Jumlah))

        Return db.Process(query, param)
    End Function
    Private Function semakdataSewaLojing(mohonID, id) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT   No_Tuntutan, No_Item   FROM SMKB_Tuntutan_Dtl WHERE No_Tuntutan=@mohonID AND Jns_Dtl_Tuntutan='EH' AND No_Item = @bil"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@bil", id))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadListKenyataan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataKenyataan(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GetDataKenyataan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT No_Tuntutan, Bil, FORMAT(Tarikh, 'yyyy-MM-dd') as Tarikh,Jarak, Masa_Bertolak,
                substring(CONVERT(varchar,Masa_Bertolak,108),1,2) as jamTolak, substring(CONVERT(varchar,Masa_Bertolak,108),4,2) as minitTolak, 
                Masa_Sampai,substring(CONVERT(varchar,Masa_Sampai,108),1,2) as jamSampai, substring(CONVERT(varchar,Masa_Sampai,108),4,2) as minitSampai,
                Tujuan, Flag_Mula, Flag_Tamat, No_Kend, Flag_Kend_Sendiri, Flag_Sokong_Kend_Sendiri
                FROM  SMKB_Tuntutan_Dlm_Kenyataan WHERE No_Tuntutan = @No_Permohonan ORDER BY Bil ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Permohonan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataFromKenyataan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataForElaunPerjln(id)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function GetDataForElaunPerjln(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"SELECT  TOP 1 No_Tuntutan, No_Kend, jumjarak, Jenis_Kenderaan, Butiran,KM, No_Staf,
                (SELECT TOP (1) Kadar
                FROM  SMKB_CLM_KdrKenderaan
                WHERE (KodKend = Jenis_Kenderaan) AND (jumjarak <= KM)
                ORDER BY KM) AS kadarHarga
                FROM (SELECT        a.No_Tuntutan, b.No_Kend, SUM(CONVERT(int, b.Jarak)) AS jumjarak, c.Jenis_Kenderaan, d.Butiran, h.KM, c.No_Staf
                FROM  SMKB_Tuntutan_Hdr AS a INNER JOIN
                SMKB_Tuntutan_Dlm_Kenyataan AS b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                SMKB_Tuntutan_Dftr_Kenderaan AS c ON b.No_Kend = c.No_Kenderaan AND a.No_Staf = c.No_Staf INNER JOIN
                SMKB_Lookup_Detail AS d ON c.Jenis_Kenderaan = d.Kod_Detail INNER JOIN 
                SMKB_CLM_KdrKenderaan as h ON h.KodKend = c.Jenis_Kenderaan
                WHERE        (d.Kod = 'AC09') AND a.No_Tuntutan=@No_Permohonan
                GROUP BY a.No_Tuntutan, b.No_Kend, c.Jenis_Kenderaan, d.Butiran, h.KM,  c.No_Staf) AS e"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Permohonan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataKendAwam(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = GetDataKenderaanAwamTab(id)

        For Each x As DataRow In dt.Rows
            If Not IsDBNull(x.Item("Nama_Fail")) Then
                Dim url As String = GetBaseUrl() + Trim(x.Item("Path")) + "/" + x.Item("Nama_Fail")
                x.Item("Path") = url
            End If
        Next
        Return JsonConvert.SerializeObject(dt)


        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Function GetBaseUrl() As String
        Dim curUrl As Uri = HttpContext.Current.Request.Url
        Dim scheme As String = curUrl.Scheme
        Dim host As String = curUrl.Host
        Dim port As Integer = curUrl.Port
        Dim segments As String() = curUrl.Segments

        If port <> 80 Then
            host = host + ":" + port.ToString()
        End If

        Return scheme + "://" + host + "/" + segments(1) + "/"
    End Function

    Private Function GetDataKenderaanAwamTab(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = $"SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Jenis_Tambang, b.Flag_Resit, 
                        b.No_Resit, b.Jumlah_anggaran, c.Butiran, b.Nama_Fail, b.Path  
                        FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
                        SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                        SMKB_Lookup_Detail  as c ON b.Jenis_Tambang = c.Kod_Detail 
                        WHERE c.kod='AC11' AND a.No_Tuntutan =@No_Tuntutan AND  b.Jns_Dtl_Tuntutan='TA'
                        ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        dt = db.Read(query, param)
        If dt.Rows.Count > 0 Then
            Return dt
        End If

        'Return db.Read(query, param)
    End Function


    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetKiraHotel(jtugas As String, jtempat As String, hadGaji As String)
        Dim db As New DBKewConn
        Dim query As String = $"SELECT JenisTugas, Tempat, GredDari, GredKe, KadarMkn, KadarHotel
                                FROM            SMKB_CLM_KdrMknHtlLjg
                                WHERE (GredDari<=@hadGaji AND GredKe >= @hadGaji) AND JenisTugas= @jtugas AND Tempat=@jtempat"
        Dim dt As DataTable = db.fSelectCommandDt(query)

        Return JsonConvert.SerializeObject(dt)
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordBelanjaPelbagai(itemPelbagai As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim sumTotal As Decimal = 0.00


        For Each tblListPelbagai As BelanjaPelbagai In itemPelbagai.ItemGroupPelbagai

            If tblListPelbagai.Pelbagai_mohonID = "" Then
                Continue For
            End If

            JumRekod += 1

            'orderDetail.kredit = 0 'orderDetail.quantity * orderDetail.debit 'This can be automated insie orderdetail model

            If tblListPelbagai.Pelbagai_mohonID <> "" Then
                If semakdataPelbagai(tblListPelbagai.Pelbagai_mohonID, tblListPelbagai.Pelbagai_hidID) = "wujud" Then
                    'updateData Tambang Awam--
                    If UpdateDataPelbagai(tblListPelbagai) = "OK" Then
                        success += 1
                        itemPelbagai.Jumlah += tblListPelbagai.strJumAmaunPel
                    End If
                Else
                    'insert data Tambang Awam
                    tblListPelbagai.Pelbagai_hidID = GenerateIDPelbagai(tblListPelbagai.Pelbagai_mohonID)
                    itemPelbagai.OrderID = tblListPelbagai.Pelbagai_mohonID
                    If InsertDataPelbagai(tblListPelbagai) = "OK" Then
                        success += 1
                        'listItemTambang.Tambang_Total += listItemTambang.Tambang_amaun
                        itemPelbagai.Jumlah += tblListPelbagai.strJumAmaunPel
                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalPelbagai(itemPelbagai) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", itemPelbagai)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GenerateIDPelbagai(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId AND Jns_Dtl_Tuntutan='BP'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateTotalPelbagai(itemPelbagai As MhnDlmNegara) As String

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Belanja_Pelbagai = @Jumlah_Pelbagai                                 
                                WHERE No_Tuntutan = @No_Tuntutan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", itemPelbagai.OrderID))
        param.Add(New SqlParameter("@Jumlah_Pelbagai", itemPelbagai.Jumlah))


        Return db.Process(query, param)
    End Function
    Private Function InsertDataPelbagai(tblListPelbagai As BelanjaPelbagai)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl( No_Tuntutan, Jns_Dtl_Tuntutan, No_Item,   Jenis_Belanja_Pelbagai,  Flag_Resit, No_Resit,  
                         Jumlah_anggaran)
                        VALUES(@No_Tuntutan , @Jns_Dtl_Tuntutan, @No_Item, @Jenis_Belanja_Pelbagai , @Flag_Resit, @No_Resit, @Jumlah_anggaran)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", tblListPelbagai.Pelbagai_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "BP"))
        param.Add(New SqlParameter("@No_Item", tblListPelbagai.Pelbagai_hidID))
        param.Add(New SqlParameter("@Jenis_Belanja_Pelbagai", tblListPelbagai.strJnsPel))
        param.Add(New SqlParameter("@Flag_Resit", tblListPelbagai.strResitPel))
        param.Add(New SqlParameter("@No_Resit", tblListPelbagai.strNoResitPel))
        param.Add(New SqlParameter("@Jumlah_anggaran", tblListPelbagai.strJumAmaunPel))


        Return db.Process(query, param)
    End Function
    Private Function UpdateDataPelbagai(tblListPelbagai As BelanjaPelbagai)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set Jenis_Belanja_Pelbagai = @Jenis_Belanja_Pelbagai, Flag_Resit = @Flag_Resit, No_Resit = @No_Resit, 
        Jumlah_anggaran = @Jumlah_anggaran
        where No_Tuntutan= @No_Tuntutan AND  No_Item = @No_Item AND Jns_Dtl_Tuntutan= @Jns_Dtl_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", tblListPelbagai.Pelbagai_mohonID))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "BP"))
        param.Add(New SqlParameter("@No_Item", tblListPelbagai.Pelbagai_hidID))
        param.Add(New SqlParameter("@Jenis_Belanja_Pelbagai", tblListPelbagai.strJnsPel))
        param.Add(New SqlParameter("@Flag_Resit", tblListPelbagai.strTResitPel))
        param.Add(New SqlParameter("@No_Resit", tblListPelbagai.strNoResitPel))
        param.Add(New SqlParameter("@Jumlah_anggaran", tblListPelbagai.strJumAmaunPel))

        Return db.Process(query, param)
    End Function

    Private Function semakdataPelbagai(mohonID, item) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT   No_Tuntutan, No_Item   FROM SMKB_Tuntutan_Dtl WHERE No_Tuntutan=@mohonID AND Jns_Dtl_Tuntutan='BP' AND No_Item = @bil"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@bil", item))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function





    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function kiraElaunHotel(ByVal jnsTugas As String, ByVal jnsTempat As String, ByVal hadGaji As String) As String
        Dim resp As New ResponseRepository

        dt = KiraElaunHotelTable(jnsTugas, jnsTempat, hadGaji)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function KiraElaunHotelTable(jnsTugas As String, jnsTempat As String, hadGaji As String) As DataTable
        Dim db = New DBKewConn
        Dim had As String
        had = Right(hadGaji, 2)

        Dim query As String = $"SELECT JenisTugas, Tempat, GredDari, GredKe, KadarMkn, KadarHotel,  KadarLojing
                                FROM            SMKB_CLM_KdrMknHtlLjg
                                WHERE (GredDari<=@had AND GredKe >=@had) AND JenisTugas=@JenisTugas AND Tempat=@Tempat"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@had", had))
        param.Add(New SqlParameter("@Tempat", jnsTempat))
        param.Add(New SqlParameter("@JenisTugas", jnsTugas))

        Return db.Read(query, param)
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataSewaHotel(ByVal id As String) As String
        Dim resp As New ResponseRepository

        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan,b.Jenis_Tempat,b.Jenis_Tugas, 
            b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran , g.Butiran as Tempat,
            h.Butiran as JenisTugas
            FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
            SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
            SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
            SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
            WHERE c.kod='AC01'  AND g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EH' AND a.No_Tuntutan =@No_Tuntutan
            ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        dt = db.Read(query, param)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallRecordSewaHotel(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Jns_Dtl_Tuntutan,b.No_Item,b.Bil_Hari,b.Jenis_Penginapan,b.Jenis_Tempat,b.Jenis_Tugas, 
            b.Kadar_Harga,  b.No_Resit, b.Jumlah_anggaran, c.Butiran , g.Butiran as Tempat,
            h.Butiran as JenisTugas
            FROM SMKB_Tuntutan_Hdr AS a INNER JOIN 
            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
            SMKB_Lookup_Detail  as c ON b.Jenis_Penginapan = c.Kod_Detail  INNER JOIN 
            SMKB_Lookup_Detail  as g ON b.Jenis_Tempat = g.Kod_Detail  INNER JOIN
            SMKB_Lookup_Detail as h ON h.Kod_Detail = b.Jenis_Tugas 
            WHERE c.kod='AC01'  AND g.Kod='AC03' AND h.kod='AC04' AND   b.Jns_Dtl_Tuntutan='EH' AND a.No_Tuntutan =@No_Tuntutan
            ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveDataHotel(itemSewaHotel As MhnDlmNegara) As String
        Dim resp As New ResponseRepository


        resp.Success("Rekod berjaya disimpan", "00", itemSewaHotel)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveUploadResitTA() As String
        Dim resp As New ResponseRepository
        Dim postedFile As HttpPostedFile = Nothing


        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = ""
        Dim fileSize As String = ""
        Dim checkList As New UploadResitTA
        Dim savePath As String = ""
        Dim folder As String = ""
        Dim returnURL As String = ""
        checkList.idItem = HttpContext.Current.Request.Form("idItem")
        checkList.mohonID = HttpContext.Current.Request.Form("mohonID")
        checkList.ResitNo = HttpContext.Current.Request.Form("NoResit")
        checkList.FlagResit = HttpContext.Current.Request.Form("staResit")
        checkList.JenisKenderaan = HttpContext.Current.Request.Form("JnsKenderaan")
        checkList.Jumlah = HttpContext.Current.Request.Form("jumlah")
        checkList.jumlahSemua = HttpContext.Current.Request.Form("jumlahSemua")

        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        If HttpContext.Current.Request.Files.Count > 0 Then
            postedFile = HttpContext.Current.Request.Files(0)
        End If
        Session("UploadedFileName") = ""
        Try
            If postedFile IsNot Nothing Then
                fileName = postedFile.FileName
                fileSize = postedFile.ContentLength

                ' Convert the base64 string to byte array
                'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

                ' Specify the file path where you want to save the uploaded file
                savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID & "//" & fileName)
                folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID

                ' Save the file to the specified path
                postedFile.SaveAs(savePath)
                returnURL = GetBaseUrl() + folder + "/" + fileName
                ' Store the uploaded file name in session
                Session("UploadedFileName") = fileName
            End If



            '---Save File kat table----
            Dim db As New DBKewConn
            Dim BilSemasa As Integer = 1
            checkList.idItem = checkList.idItem - BilSemasa

            Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl
                                    WHERE  (No_Tuntutan =) AND (Jns_Dtl_Tuntutan = 'TA') AND (No_Item = @No_Item)"

            Dim paramC As New List(Of SqlParameter)
            paramC.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
            paramC.Add(New SqlParameter("@No_Item", checkList.idItem))

            dt = db.Read(queryC, paramC)

            If dt.Rows.Count > 0 Then
                If UpdateResitTambangA(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            Else
                checkList.idItem = GenerateIDTblKenderaanAwam(checkList.mohonID)
                If InsertResitTambangA(checkList) <> "OK" Then
                    resp.Failed("Gagal Menyimpan order 1266")
                    Return JsonConvert.SerializeObject(resp.GetResult())
                End If
            End If

            If UpdateTotalTambang(checkList) <> "OK" Then
                'If InsertNewOrder(OtherList) <> "OK" Then
                resp.Failed("Gagal Menyimpan order 1266")
                Return JsonConvert.SerializeObject(resp.GetResult())
                ' Exit Function
                'End If
            End If


            resp.SuccessPayload(New With {.FileName = fileName, .Url = returnURL})
            Return JsonConvert.SerializeObject(resp.GetResult())
            'Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    Private Function UpdateTotalTambang(checkList As UploadResitTA) As String

        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jumlah_Tambang_Awam = @Jumlah_Tambang_Awam                                 
                                WHERE No_Tuntutan = @No_Tuntutan"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@Jumlah_Tambang_Awam", checkList.jumlahSemua))


        Return db.Process(query, param)
    End Function

    Private Function GenerateIDTblKenderaanAwam(MohonID As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "Select TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @No_Tuntutan AND Jns_Dtl_Tuntutan='TA'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@No_Tuntutan", MohonID))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function
    Private Function UpdateResitTambangA(checkList As UploadResitTA)

        Dim db As New DBKewConn
        Dim fileName As String = Session("UploadedFileName")
        Dim folder As String = ""


        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        If Not String.IsNullOrEmpty(fileName) Then
            folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID
        End If

        Dim queryU As String = "UPDATE  SMKB_Tuntutan_Dtl SET Jenis_Tambang = @Jenis_Tambang,
                No_Resit =@No_Resit, Jumlah_anggaran = Jumlah_anggaran, Flag_Resit = @Flag_Resit, Nama_Fail = @Nama_Fail, Path = @Path
                                WHERE  No_Tuntutan = @No_Tuntutan AND No_Item = @No_Item AND (Jns_Dtl_Tuntutan = 'TA')"

        Dim paramU As New List(Of SqlParameter)
        paramU.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        paramU.Add(New SqlParameter("@No_Item", checkList.idItem))
        paramU.Add(New SqlParameter("@Jenis_Tambang", checkList.JenisKenderaan))
        paramU.Add(New SqlParameter("@No_Resit", checkList.ResitNo))
        paramU.Add(New SqlParameter("@Jumlah_anggaran", checkList.Jumlah))
        paramU.Add(New SqlParameter("@Flag_Resit", checkList.FlagResit))
        paramU.Add(New SqlParameter("@Nama_Fail", fileName))
        paramU.Add(New SqlParameter("@Path", folder))

        Return db.Process(queryU, paramU)

    End Function



    Private Function InsertResitTambangA(checkList As UploadResitTA)

        Dim db As New DBKewConn
        Dim fileName As String = Session("UploadedFileName")
        Dim folder As String = ""
        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & checkList.mohonID)
        End If

        If Not String.IsNullOrEmpty(fileName) Then
            folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & checkList.mohonID
        End If


        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl (No_Tuntutan, Jns_Dtl_Tuntutan,Jenis_Tambang,
                No_Item, No_Resit, Jumlah_anggaran, Flag_Resit, Nama_Fail, Path)
                 VALUES(@No_Tuntutan, @Jns_Dtl_Tuntutan, @Jenis_Tambang, @No_Item, @No_Resit, @Jumlah_anggaran,  @Flag_Resit,  @Nama_Fail, @Path)"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@No_Item", checkList.idItem))
        param.Add(New SqlParameter("@Jenis_Tambang", checkList.JenisKenderaan))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "TA"))
        param.Add(New SqlParameter("@No_Resit", checkList.ResitNo))
        param.Add(New SqlParameter("@Jumlah_anggaran", checkList.Jumlah))
        param.Add(New SqlParameter("@Flag_Resit", checkList.FlagResit))
        param.Add(New SqlParameter("@Nama_Fail", fileName))
        param.Add(New SqlParameter("@Path", folder))
        Return db.Process(query, param)

    End Function



    'Delete Lampiran
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function BatalUploadResitTA(ByVal id As String, nomohon1 As String) As String
        Dim resp As New ResponseRepository

        'Dim namaFail As String = NamaFailPdf
        Dim noMohon As String = nomohon1

        'Baca data berdasarkan id mohon dan n0 item
        Dim db As New DBKewConn
        Dim clone As Integer = 1
        id = id - clone
        Dim namaFail As String

        Dim queryC As String = $"SELECT No_Tuntutan, Jns_Dtl_Tuntutan, No_Item, No_Resit, Nama_Fail, Path
                                    FROM SMKB_Tuntutan_Dtl
                                    WHERE  (No_Tuntutan =@No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'TA') AND (No_Item = @No_Item)"

        Dim paramC As New List(Of SqlParameter)
        paramC.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        paramC.Add(New SqlParameter("@No_Item", id))

        dt = db.Read(queryC, paramC)

        If dt.Rows.Count > 0 Then
            namaFail = dt.Rows(0).Item("Nama_Fail")
        Else
            namaFail = ""
        End If



        If Query_deleteLampiran(id, nomohon1) <> "OK" Then
            resp.Failed("Gagal memadam data")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        Dim filePath As String = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & noMohon & "/" & namaFail
        If System.IO.File.Exists(filePath) Then
            System.IO.File.Delete(filePath)
        End If

        resp.Success("Rekod berjaya dipadam", "00", id)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function
    Private Function Query_deleteLampiran(id As String, nomohon1 As String)
        Dim db As New DBKewConn


        Dim query As String = "DELETE  FROM SMKB_Tuntutan_Dtl
                            WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'TA') AND (No_Item = @No_Item)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", nomohon1))
        param.Add(New SqlParameter("@No_Item", id))


        Return db.Process(query, param)
    End Function



    Private Function PadamDataUpload(checkList As BatalListTA)

        Dim db As New DBKewConn

        checkList.bilItem = checkList.bilItem - 1
        Dim query As String = "DELETE  FROM SMKB_Tuntutan_Dtl
                            WHERE  (No_Tuntutan = @No_Tuntutan) AND (Jns_Dtl_Tuntutan = 'TA') AND (No_Item = @No_Item)"
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@No_Tuntutan", checkList.mohonID))
        param.Add(New SqlParameter("@No_Item", checkList.bilItem))


        Return db.Process(query, param)
    End Function


    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function kiraElaunMakan(ByVal jnsTugas As String, ByVal jnsTempat As String, ByVal hadGaji As String) As String
        Dim resp As New ResponseRepository

        dt = KiraElaunMakanTable(jnsTugas, jnsTempat, hadGaji)
        resp.SuccessPayload(dt)

        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function


    Private Function KiraElaunMakanTable(jnsTugas As String, jnsTempat As String, hadGaji As String) As DataTable
        Dim db = New DBKewConn
        Dim had As String
        had = Right(hadGaji, 2)

        Dim query As String = $"SELECT JenisTugas, Tempat, GredDari, GredKe, KadarMkn, KadarHotel,  KadarLojing
                                FROM            SMKB_CLM_KdrMknHtlLjg
                                WHERE (GredDari<=@had AND GredKe >=@had) AND JenisTugas=@JenisTugas AND Tempat=@Tempat"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@had", had))
        param.Add(New SqlParameter("@Tempat", jnsTempat))
        param.Add(New SqlParameter("@JenisTugas", jnsTugas))

        Return db.Read(query, param)

    End Function


    Sub test()

        '                Declare @Tarikh smalldatetime
        '        DEclare @MasaMula time(7)
        'Declare @MasaTamat time(7)
        'Declare @JumHari tinyint
        '        Declare @BilJam float,
        '        @FlagMula bit, @FlagTamat bit

        '        IF OBJECT_ID(N'tempdb..#TempData') IS NOT NULL --kalau ada temp table ni drop kan
        '            begin
        '                DROP TABLE #TempData 
        '            end

        'IF OBJECT_ID(N'tempdb..#TempData2') IS NOT NULL --kalau ada temp table ni drop kan
        '            begin
        '                DROP TABLE #TempData2 
        '            end

        '        Create table #TempData (
        '        	Tarikh smalldatetime,
        '            MasaMula time(7),
        '        	MasaTamat time(7)
        '        )

        '        CREATE TABLE #TempData2 (
        '        	BilHari int,
        '            BilJam  float
        '        )

        '        declare cur cursor for
        '        SELECT Tarikh, Masa_Bertolak, Masa_Sampai, Flag_Mula, FLag_Tamat 
        '        	FROM SMKB_Tuntutan_Dlm_Kenyataan
        '        	--WHERE No_Tuntutan = ''
        '        	ORDER BY Tarikh ASC, Masa_Bertolak ASC
        '        open cur
        '        FETCH next from cur into @Tarikh, @MasaMula, @MasaTamat, @FlagMula, @FlagTamat
        '        While @@FETCH_STATUS = 0
        '        Begin
        '              If @FlagMula = 1 
        '        		Begin 
        '        			DELETE FROM #TempData
        '        		End

        '        	INSERT INTO #TempData
        '        	VALUES (@Tarikh, @MasaMula, @MasaTamat)

        '        	if @FlagTamat = 1 
        '        		Begin

        '        			SELECT @JumHari = DATEDIFF(Day, MIN(Tarikh), MAX(Tarikh)) , 
        '        			@BilJam = SUM(datediff(minute, MasaMula, MasaTamat) / 60.0) 
        '        			FROM #TempData

        '        			INSERT INTO #TempData2
        '        			VALUES(@JumHari, @BilJam)
        '        		End

        '              FETCH next from cur into @Tarikh, @MasaMula, @MasaTamat, @FlagMula, @FlagTamat
        '        End
        '        Close cur
        '        deallocate cur

        'SELECT * FROM #TempData2

        '    End Sub

    End Sub

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataStoreProceHari(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordHariMakan(id)


        resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallRecordHariMakan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "Declare @Tarikh smalldatetime
                               DEclare @MasaMula time(7)
                                Declare @MasaTamat time(7)
                                Declare @JumHari tinyint
                                Declare @BilJam float,
                                @FlagMula bit, @FlagTamat bit

                                IF OBJECT_ID(N'tempdb..#TempData') IS NOT NULL 
                                    begin
                                        DROP TABLE #TempData 
                                    end

                        IF OBJECT_ID(N'tempdb..#TempData2') IS NOT NULL  
                                    begin
                                        DROP TABLE #TempData2 
                                    end

                                Create table #TempData (
            	                    Tarikh smalldatetime,
                                    MasaMula time(7),
            	                    MasaTamat time(7)
                                )

                                CREATE TABLE #TempData2 (
            	                    Bil_Hari int,
                                    BilJam  float
                                )

                                declare cur cursor for
                                SELECT Tarikh, Masa_Bertolak, Masa_Sampai, Flag_Mula, FLag_Tamat 
            	                    FROM SMKB_Tuntutan_Dlm_Kenyataan
            	                    WHERE No_Tuntutan = @No_Tuntutan
            	                    ORDER BY Tarikh ASC, Masa_Bertolak ASC
                                open cur
                                FETCH next from cur into @Tarikh, @MasaMula, @MasaTamat, @FlagMula, @FlagTamat
                                While @@FETCH_STATUS = 0
                                Begin
                                      If @FlagMula = 1 
            		                    Begin 
            			                    DELETE FROM #TempData
            		                    End

            	                    INSERT INTO #TempData
            	                    VALUES (@Tarikh, @MasaMula, @MasaTamat)

            	                    if @FlagTamat = 1 
            		                    Begin

            			                    SELECT @JumHari = DATEDIFF(Day, MIN(Tarikh), MAX(Tarikh)) , 
            			                    @BilJam = SUM(datediff(minute, MasaMula, MasaTamat) / 60.0) 
            			                    FROM #TempData

            			                    INSERT INTO #TempData2
            			                    VALUES(@JumHari, @BilJam)
            		                    End

                                      FETCH next from cur into @Tarikh, @MasaMula, @MasaTamat, @FlagMula, @FlagTamat
                                End
                                Close cur
                                deallocate cur

                        SELECT * FROM #TempData2 "


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDataPengesahan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallRecordPengesahan(id)

        'For Each x As DataRow In dt.Rows
        '    If Not IsDBNull(x.Item("Nama_Fail")) Then
        '        Dim url As String = GetBaseUrl() + Trim(x.Item("Path")) + "/" + x.Item("Nama_Fail")
        '        x.Item("Path") = url
        '    End If
        'Next
        'Return JsonConvert.SerializeObject(dt)


        resp.SuccessPayload(dt)
        Return JsonConvert.SerializeObject(resp.GetResult())
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallRecordPengesahan(id As String) As DataTable
        Dim db = New DBKewConn


        Dim query As String = "SELECT No_Tuntutan, FORMAT(Tarikh_Mohon, 'yyyy-MM-dd') AS Tarikh_Mohon, No_Pendahuluan, Jum_Pendahuluan, No_Baucar, 
                                Jumlah_Tambang_Awam, Jumlah_Elaun_Kend, Jumlah_Elaun_Mkn, Jumlah_Sewa_HotelLojing,Jum_Sumbangan, 
                                Jumlah_Belanja_Pelbagai
                                FROM            SMKB_Tuntutan_Hdr
                                WHERE (No_Tuntutan = @No_Tuntutan)"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetJenisSumbangan(ByVal q As String) As String


        Dim tmpDT As DataTable = GetDataJenisSumbangan(q)
        Return JsonConvert.SerializeObject(tmpDT)
    End Function

    Private Function GetDataJenisSumbangan(kod As String) As DataTable
        Dim db As New DBKewConn
        Dim query As String = "SELECT  Kod_Tabung as value, Kod_Tabung +' - ' + Butiran as text, Status
                        FROM SMKB_Ptj_Tabung WHERE Status=1 "
        Dim param As New List(Of SqlParameter)
        If kod <> "" Then
            query &= " AND Kod_Tabung ='K03001' OR Kod_Tabung='K03001' AND 
                        Butiran like 'Tabung%' and (Kod_Tabung LIKE '%' + @kod + '%') "
            param.Add(New SqlParameter("@kod", kod))

        End If

        Return db.Read(query, param)

    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDatSumbangan(ByVal id As String) As String
        Dim resp As New ResponseRepository

        dt = CallDataSumbangan(id)


        Return JsonConvert.SerializeObject(dt)


        'resp.SuccessPayload(dt)
        'Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function CallDataSumbangan(id As String) As DataTable
        Dim db = New DBKewConn

        Dim query As String = "SELECT a.No_Tuntutan, b.Kod_Tabung, c.Butiran, b.Jumlah_anggaran, a.Jum_Sumbangan
                            From SMKB_Tuntutan_Hdr as a INNER JOIN
                            SMKB_Tuntutan_Dtl as b ON a.No_Tuntutan = b.No_Tuntutan INNER JOIN
                            SMKB_Ptj_Tabung as c ON b.Kod_Tabung = c.Kod_Tabung
                            WHERE a.No_Tuntutan = @No_Tuntutan ORDER BY b.No_Item ASC"


        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", id))

        Return db.Read(query, param)
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordSumbanganDN(tabung As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0

        For Each listSumbangan As tblSumbangan In tabung.GroupSumbangan

            If listSumbangan.mohonID = "" Then
                Continue For
            End If

            JumRekod += 1

            If listSumbangan.mohonID <> "" Then
                If semakdataSumbangan(listSumbangan.mohonID, listSumbangan.KodTabung) = "wujud" Then
                    'updateDataKeperluan--
                    If UpdateOrderDetail(listSumbangan) = "OK" Then
                        success += 1

                    End If
                Else
                    'insert Data Keperluan
                    listSumbangan.idbil = GenerateOrderDetailIDSumbangan(listSumbangan.mohonID)
                    listSumbangan.mohonID = tabung.OrderID
                    If InsertDataItem(listSumbangan) = "OK" Then
                        success += 1

                    End If
                End If
            Else

            End If
        Next

        If UpdateTotalSumbangan(tabung) <> "OK" Then
            'If InsertNewOrder(OtherList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
            'End If
        End If

        resp.Success("Rekod berjaya disimpan", "00", tabung)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function GenerateOrderDetailIDSumbangan(itemId As String) As String
        Dim db = New DBKewConn
        Dim lastID As Integer = 1
        Dim newOrderID As String = ""
        Dim param As New List(Of SqlParameter)

        Dim query As String = "SELECT TOP 1 No_Item as id
        from SMKB_Tuntutan_Dtl 
        where No_Tuntutan = @itemId  AND Jns_Dtl_Tuntutan='ST'
        ORDER BY No_Item DESC"

        param.Add(New SqlParameter("@itemId", itemId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            lastID = CInt(dt.Rows(0).Item("id")) + 1
        End If

        newOrderID = lastID

        Return newOrderID
    End Function

    Private Function semakdataSumbangan(mohonID, tabung) As String
        Dim db As New DBKewConn

        Dim statusLampiran As String = ""

        Dim query As String = $"SELECT No_Tuntutan, Kod_Tabung, Jumlah_anggaran FROM SMKB_Tuntutan_Dtl 
                                WHERE No_Tuntutan=@mohonID AND Kod_Tabung=@tabung AND Jns_Dtl_Tuntutan='ST'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@mohonID", mohonID))
        param.Add(New SqlParameter("@tabung", tabung))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            statusLampiran = "wujud"
        Else

            statusLampiran = "tidakWujud"
        End If

        Return statusLampiran
    End Function

    Private Function InsertDataItem(listSumbangan As tblSumbangan)
        Dim db As New DBKewConn

        Dim query As String = "INSERT INTO SMKB_Tuntutan_Dtl (No_Tuntutan, No_Item, Jns_Dtl_Tuntutan, Kod_Tabung, 
                            Jumlah_anggaran)
                            VALUES(@NoTuntutan, @No_Item,@Jns_Dtl_Tuntutan, @Kod_Tabung, @Jumlah_anggaran)"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoTuntutan", listSumbangan.mohonID))
        param.Add(New SqlParameter("@No_Item", listSumbangan.idbil))
        param.Add(New SqlParameter("@Kod_Tabung", listSumbangan.KodTabung))
        param.Add(New SqlParameter("@Jumlah_anggaran", listSumbangan.Jumlah))
        param.Add(New SqlParameter("@Jns_Dtl_Tuntutan", "ST"))


        Return db.Process(query, param)
    End Function


    Private Function UpdateTotalSumbangan(tabung As MhnDlmNegara)
        Dim db = New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jum_Sumbangan = @Jum_Sumbangan                                 
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", tabung.OrderID))
        param.Add(New SqlParameter("@Jum_Sumbangan", tabung.Jumlah))

        Return db.Process(query, param)
    End Function
    Private Function UpdateOrderDetail(listSumbangan As tblSumbangan)
        Dim db = New DBKewConn


        Dim query As String = "UPDATE SMKB_Tuntutan_Dtl
        set  Kod_Tabung = @Kod_Tabung, Jumlah_anggaran = @Jumlah_anggaran
        where No_Tuntutan = @NoTuntutan  AND No_Item = @No_Item AND Jns_Dtl_Tuntutan='ST'"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@NoTuntutan", listSumbangan.mohonID))
        param.Add(New SqlParameter("@No_Item", listSumbangan.idbil))
        param.Add(New SqlParameter("@Kod_Tabung", listSumbangan.KodTabung))
        param.Add(New SqlParameter("@Jumlah_anggaran", listSumbangan.Jumlah))

        Return db.Process(query, param)
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function UploadFile() As String
        Dim postedFile As HttpPostedFile = HttpContext.Current.Request.Files(0)
        Dim fileUpload = HttpContext.Current.Request.Form("fileSurat")
        Dim fileName As String = HttpContext.Current.Request.Form("fileName")
        Dim idMohon As String = HttpContext.Current.Request.Form("idMohon")
        Dim jnsBelanja As String = HttpContext.Current.Request.Form("jnsBelanja")

        Dim savePath As String = ""
        Dim folder As String = ""

        Try
            ' Convert the base64 string to byte array
            'Dim fileBytes As Byte() = Convert.FromBase64String(fileData)

            ' Specify the file path where you want to save the uploaded file
            If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & idMohon)) Then
                System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/"))
            End If


            ' Specify the file path where you want to save the uploaded file
            savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & idMohon)
            folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & idMohon

            ' Save the file to the specified path
            postedFile.SaveAs(savePath & "/" & fileName)

            ' Store the uploaded file name in session
            Session("UploadedFileName") = fileName

            Return " File uploaded successfully."
        Catch ex As Exception
            Return "Error uploading file: " & ex.Message
        End Try
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function SaveRecordPengesahan(PengesahanList As MhnDlmNegara) As String
        Dim resp As New ResponseRepository
        resp.Success("Data telah disimpan")
        Dim success As Integer = 0
        Dim JumRekod As Integer = 0
        Dim strTkhToday2 As String = Now.ToString("yyyy-MM-dd")
        Dim dtTkhToday2 As DateTime = CDate(strTkhToday2)
        Dim folder As String = ""
        Dim postedFile As HttpPostedFile = Nothing
        Dim returnURL As String = ""
        Dim fileName As String = ""
        Dim savePath As String = ""

        'Check if File is available.
        If HttpContext.Current.Request.Files.Count > 0 Then
            postedFile = HttpContext.Current.Request.Files(0)
        End If



        If PengesahanList.File_Name <> "" Then

            If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & PengesahanList.OrderID) Then
                System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & PengesahanList.OrderID)
            End If

            ' Specify the file path where you want to save the uploaded file
            savePath = Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & PengesahanList.OrderID & "/" & PengesahanList.File_Name)
            folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & PengesahanList.OrderID
            PengesahanList.Folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & PengesahanList.OrderID


            ' Save the file to the specified path
            'postedFile.SaveAs(savePath)
            'returnURL = GetBaseUrl() + folder + "/" + fileName
            ' Store the uploaded file name in session
            'Session("UploadedFileName") = fileName

            simpanBuktiBelanja(PengesahanList)
        End If



        If PengesahanList Is Nothing Then
            resp.Failed("Tiada simpan")
            Return JsonConvert.SerializeObject(resp.GetResult())
        End If

        If UpdateDataPengesahan(PengesahanList) <> "OK" Then
            'If InsertNewOrder(AdvList) <> "OK" Then
            resp.Failed("Gagal Menyimpan order 1266")
            Return JsonConvert.SerializeObject(resp.GetResult())
            '    ' Exit Function
            'End If
        End If


        If UpdateStatusDokOrder_Mohon(PengesahanList, "Y") <> "OK" Then

            'resp.Failed("Berjaya simpan") 'Gagal Menyimpan order YX
            Return JsonConvert.SerializeObject(resp.GetResult())
            ' Exit Function
        Else
            'hantar email function

        End If

        resp.Success("Rekod berjaya disimpan", "00", PengesahanList)
        Return JsonConvert.SerializeObject(resp.GetResult())
    End Function

    Private Function simpanBuktiBelanja(PengesahanList As MhnDlmNegara)
        Dim db As New DBKewConn

        If Not System.IO.Directory.Exists(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & PengesahanList.OrderID) Then
            System.IO.Directory.CreateDirectory(Server.MapPath("~/UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/") & PengesahanList.OrderID)
        End If

        PengesahanList.Folder = "UPLOAD/PENDAHULUAN DAN TUNTUTAN/TUNTUTAN/" & PengesahanList.OrderID

        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Nama_Fail_Belanja = @Nama_Fail_Belanja, 
                                Path_Belanja = @Path_Belanja                                
                                WHERE No_Tuntutan = @No_Tuntutan"

        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@No_Tuntutan", PengesahanList.OrderID))
        param.Add(New SqlParameter("@Nama_Fail_Belanja", PengesahanList.File_Name))
        param.Add(New SqlParameter("@Path_Belanja", PengesahanList.Folder))


        Return db.Process(query, param)
    End Function


    Private Function UpdateStatusDokOrder_Mohon(PengesahanList As MhnDlmNegara, statusLulus As String)
        Dim db As New DBKewConn

        Dim kodstatusLulus As String = ""

        If statusLulus = "Y" Then
            kodstatusLulus = "02"
        End If

        Dim query As String = "INSERT INTO SMKB_Status_Dok (Kod_Modul  , Kod_Status_Dok  ,  No_Rujukan , No_Staf , Tkh_Tindakan , Tkh_Transaksi , Status_Transaksi , Status , Ulasan )
    			VALUES
    			(@Kod_Modul , @Kod_Status_Dok , @No_Rujukan , @No_Staf , getdate() , getdate(), @Status_Transaksi , @Status , @Ulasan)"

        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Kod_Modul", "04"))
        param.Add(New SqlParameter("@Kod_Status_Dok", kodstatusLulus))
        param.Add(New SqlParameter("@No_Rujukan", PengesahanList.OrderID))
        param.Add(New SqlParameter("@No_Staf", Session("ssusrID")))
        param.Add(New SqlParameter("@Status_Transaksi", 1))
        param.Add(New SqlParameter("@Status", 1))
        param.Add(New SqlParameter("@Ulasan", "-"))

        Return db.Process(query, param)

    End Function

    Private Function UpdateDataPengesahan(PengesahanList As MhnDlmNegara)


        Dim db As New DBKewConn
        Dim query As String = "UPDATE SMKB_Tuntutan_Hdr SET Jum_Tuntut = @Jum_Tuntut, Jum_Baki_Tuntut = @Jum_Baki_Tuntut, 
                               Jum_Belanja_Sendiri = @Jum_Belanja_Sendiri,Status_Dok = @Status_Dok                               
                                WHERE No_Tuntutan = @No_Tuntutan "
        Dim param As New List(Of SqlParameter)

        param.Add(New SqlParameter("@Jum_Tuntut", PengesahanList.JumAllTuntutan))
        param.Add(New SqlParameter("@Jum_Baki_Tuntut", PengesahanList.JumBersihTuntut))
        param.Add(New SqlParameter("@Jum_Belanja_Sendiri", PengesahanList.JumBelanjaSendiri))
        param.Add(New SqlParameter("@Status_Dok", "02"))
        param.Add(New SqlParameter("@No_Tuntutan", PengesahanList.OrderID))


        Return db.Process(query, param)
    End Function
End Class