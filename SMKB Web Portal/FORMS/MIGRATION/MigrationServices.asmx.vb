Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Newtonsoft.Json
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
'Imports System.Web.Http
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Globalization
'Imports System.Globalization
Imports System.Threading

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.

<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class MigrationServices
    Inherits System.Web.Services.WebService
    Dim dt As DataTable

    Dim selectConnectionString As String = "server=V-SQL12.utem.edu.my;database=DbKewangan;uid=smkb;pwd=smkb*pwd;"
    Dim insertConnectionString As String = "server=devmis12.utem.edu.my;database=DbKewanganV4;uid=smkb;pwd=Smkb@Dev2012;"

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function TestFunction(id As String) As String
        Return "test"
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function LoadRecordInvois(ByVal id As String)
        Dim resp As New ResponseRepository
        resp.Success("Masuk Payload")
        Return resp.GetResult()
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function InsertViremenHdr(tahun As String) As Boolean
        Dim success As Boolean = False
        Dim resp As New ResponseRepository

        Try
            ' Selecting data from DbKew
            Using selectConn As New SqlConnection(selectConnectionString)
                selectConn.Open()
                Dim param As New List(Of SqlParameter)

                Dim selectQuery As String = $"select distinct a.BG07_NoViremen, BG07_Tujuan, BG07_Amaun, BG07_StatusKJ, BG07_StatusBen, BG07_NoStaf, a.KodStatusDok, BG07_RujSurat , BG07_RujSuratLulus, BG07_TkhLulusNC 
                                            from BG07_Viremen a
                                            inner join BG09_StatusDok b on a.BG07_NoViremen = b.BG07_NoViremen
                                            WHERE year(b.BG09_TkhProses) ='{tahun}' and b.KodStatusDok = '01'"

                Using selectCmd As New SqlCommand(selectQuery, selectConn)
                    Dim dt As New DataTable()
                    dt.Load(selectCmd.ExecuteReader())

                    ' Inserting data into devmis12 database
                    Using insertConn As New SqlConnection(insertConnectionString)
                        insertConn.Open()
                        For Each row As DataRow In dt.Rows
                            Dim insertQuery As String = "INSERT INTO SMKB_BG_Viremen (No_Viremen, Tujuan, Amaun, Status_KJ, Status_Ben, No_Staf, Kod_Status_Dok, Ruj_Surat, Ruj_Surat_Lulus, Tkh_Lulus_NC) VALUES (@No_Viremen, @Tujuan, @Amaun, @Status_KJ, @Status_Ben, @No_Staf, @Kod_Status_Dok, @Ruj_Surat, @Ruj_Surat_Lulus, @Tkh_Lulus_NC)"
                            Using insertCmd As New SqlCommand(insertQuery, insertConn)
                                insertCmd.Parameters.AddWithValue("@No_Viremen", row("BG07_NoViremen"))
                                insertCmd.Parameters.AddWithValue("@Tujuan", row("BG07_Tujuan"))
                                insertCmd.Parameters.AddWithValue("@Amaun", row("BG07_Amaun"))
                                insertCmd.Parameters.AddWithValue("@Status_KJ", row("BG07_StatusKJ"))
                                insertCmd.Parameters.AddWithValue("@Status_Ben", row("BG07_StatusBen"))
                                insertCmd.Parameters.AddWithValue("@No_Staf", row("BG07_NoStaf"))
                                insertCmd.Parameters.AddWithValue("@Kod_Status_Dok", row("KodStatusDok"))
                                insertCmd.Parameters.AddWithValue("@Ruj_Surat", row("BG07_RujSurat"))
                                insertCmd.Parameters.AddWithValue("@Ruj_Surat_Lulus", row("BG07_RujSuratLulus"))
                                insertCmd.Parameters.AddWithValue("@Tkh_Lulus_NC", row("BG07_TkhLulusNC"))
                                insertCmd.ExecuteNonQuery()
                            End Using
                        Next
                        success = True ' Set success flag if insertion is successful

                        insertConn.Close()
                    End Using
                End Using
                selectConn.Close()
            End Using
        Catch ex As Exception
            ' Handle exceptions here
            Console.WriteLine("Error: " & ex.Message)
        End Try

        Return success
    End Function

    <WebMethod()>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function InsertViremenDtl(tahun As String) As Boolean
        Dim success As Boolean = False
        Dim resp As New ResponseRepository

        Try
            ' Selecting data from DbKew
            Using selectConn As New SqlConnection(selectConnectionString)
                selectConn.Open()
                Dim param As New List(Of SqlParameter)

                tahun = Right(tahun, 2)
                Dim selectQuery As String = $"select BG07_NoViremen, KodKw, KodPTJ, KodVot, BG07_BakiSms, KodVir, KodVotUris from BG07_ViremenDT where BG07_NoViremen like '%{tahun}'"

                Using selectCmd As New SqlCommand(selectQuery, selectConn)
                    Dim dt As New DataTable()
                    dt.Load(selectCmd.ExecuteReader())

                    ' Inserting data into devmis12 database
                    Using insertConn As New SqlConnection(insertConnectionString)
                        insertConn.Open()
                        For Each row As DataRow In dt.Rows


                            Dim insertQuery As String = "INSERT INTO SMKB_BG_ViremenDtl (No_Viremen, Kod_Kump_Wang, Kod_Operasi, Kod_PTJ, Kod_Projek, Kod_Vot, Baki_Sms , Kod_Vir , Kod_Vir_URIS) VALUES (@No_Viremen, @Kod_Kump_Wang, @Kod_Operasi, @Kod_PTJ, @Kod_Projek, @Kod_Vot, @Baki_Sms , @Kod_Vir , @Kod_Vir_URIS)"
                            Using insertCmd As New SqlCommand(insertQuery, insertConn)
                                insertCmd.Parameters.AddWithValue("@No_Viremen", row("BG07_NoViremen"))
                                insertCmd.Parameters.AddWithValue("@Kod_Kump_Wang", row("KodKw"))

                                'CHECK IF PTJ OPERASI
                                Dim CheckQuery01 As String = $"SELECT  KODPTJ, PTJ  from MK_PTJ_Client WHERE KodKategoriPTJ IN ('P','-') AND KODPTJ = '{row("KodPTJ")}' and butiran not like '%Komited%'"
                                Using Checkcmd01 As New SqlCommand(CheckQuery01, insertConn)
                                    Dim Checkdt01 As New DataTable()
                                    Checkdt01.Load(Checkcmd01.ExecuteReader())

                                    ' check data mk_ptj
                                    Using CheckinsertConn01 As New SqlConnection(insertConnectionString)
                                        CheckinsertConn01.Open()

                                        For Each Checkrow01 As DataRow In Checkdt01.Rows
                                            insertCmd.Parameters.AddWithValue("@Kod_Operasi", "01")
                                            insertCmd.Parameters.AddWithValue("@Kod_PTJ", Checkrow01("PTJ"))
                                            insertCmd.Parameters.AddWithValue("@Kod_Projek", "NULL")
                                        Next

                                        CheckinsertConn01.Close()
                                    End Using
                                End Using

                                'CHECK IF PTJ KOMITED
                                Dim CheckQuery02 As String = $"SELECT  KODPTJ, PTJ  from MK_PTJ_Client WHERE KodKategoriPTJ = 'P' AND KODPTJ = '{row("KodPTJ")}' and butiran like '%Komited%'"
                                Using Checkcmd02 As New SqlCommand(CheckQuery02, insertConn)
                                    Dim Checkdt02 As New DataTable()
                                    Checkdt02.Load(Checkcmd02.ExecuteReader())

                                    ' check data mk_ptj
                                    Using CheckinsertConn02 As New SqlConnection(insertConnectionString)
                                        CheckinsertConn02.Open()

                                        For Each Checkrow02 As DataRow In Checkdt02.Rows
                                            insertCmd.Parameters.AddWithValue("@Kod_Operasi", "02")
                                            insertCmd.Parameters.AddWithValue("@Kod_PTJ", Checkrow02("PTJ"))
                                            insertCmd.Parameters.AddWithValue("@Kod_Projek", "NULL")
                                        Next

                                        CheckinsertConn02.Close()
                                    End Using
                                End Using

                                'CHECK IF research
                                Dim CheckQuery03 As String = $"SELECT  KODPTJ, PTJProjek  from MK_PTJ_Client WHERE KodKategoriPTJ IN ('R','C','T') AND KODPTJ = '{row("KodPTJ")}'"
                                Using Checkcmd03 As New SqlCommand(CheckQuery03, insertConn)
                                    Dim Checkdt03 As New DataTable()
                                    Checkdt03.Load(Checkcmd03.ExecuteReader())

                                    ' check data mk_ptj
                                    Using CheckinsertConn03 As New SqlConnection(insertConnectionString)
                                        CheckinsertConn03.Open()

                                        For Each Checkrow03 As DataRow In Checkdt03.Rows
                                            insertCmd.Parameters.AddWithValue("@Kod_Operasi", "01")
                                            insertCmd.Parameters.AddWithValue("@Kod_PTJ", Checkrow03("PTJProjek"))
                                            insertCmd.Parameters.AddWithValue("@Kod_Projek", Checkrow03("KODPTJ"))
                                        Next

                                        CheckinsertConn03.Close()
                                    End Using
                                End Using

                                insertCmd.Parameters.AddWithValue("@Kod_Vot", row("KodVot"))
                                insertCmd.Parameters.AddWithValue("@Baki_Sms", row("BG07_BakiSms"))
                                insertCmd.Parameters.AddWithValue("@Kod_Vir", row("KodVir"))
                                insertCmd.Parameters.AddWithValue("@Kod_Vir_URIS", row("KodVotUris"))
                                insertCmd.ExecuteNonQuery()
                            End Using
                        Next
                        success = True ' Set success flag if insertion is successful

                        insertConn.Close()
                    End Using
                End Using
                selectConn.Close()
            End Using
        Catch ex As Exception
            ' Handle exceptions here
            Console.WriteLine("Error: " & ex.Message)
        End Try

        Return success
    End Function

End Class