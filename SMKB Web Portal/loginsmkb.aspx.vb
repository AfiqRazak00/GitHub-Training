Imports System.Web.Services
Imports Newtonsoft.Json

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration

Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports clsMail
Imports System.Reflection

Imports CLMPass.CLM

Public Class loginsmkb
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        ' Assuming you're passing `encodedIdToken` as a query parameter in the URL

        ' Reading the query string parameter and decoding it
        Dim idToken As String = Request.QueryString("id").Replace(" ", "+")

        Dim emelPenerima As String = "syafiqah"

        HdIdToken.Value = idToken


        'Response.Redirect(combine)

        fcheckToken(idToken)




    End Sub

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Dim CLM As New CLMPass.CLM

        Dim UserId As String = txtIdStaf.Value
        Dim userPassword As String = txtPassStaf.Value

        Dim ConvertUsrPWD As String = CLM.getPwD(userPassword)

        If ConvertUsrPWD = callPassClmDb(UserId) Then
            'fGlobalAlert("Padanan password berjaya!", Me.Page, Me.[GetType]())

            Dim TokenID As String = HdIdToken.Value
            fGetSubmenu(TokenID)
        Else
            fGlobalAlert("Padanan password tidak berjaya!", Me.Page, Me.[GetType]())
        End If

    End Sub

    Private Function callPassClmDb(UserId As String) As String
        Dim db As New DBClmConn
        Dim dt As DataTable
        Dim newOrderID As String = ""

        Dim query As String = $"select CLM_loginPWD from CLM_Pengguna where CLM_loginID =@CLM_loginID"
        Dim param As New List(Of SqlParameter)
        param.Add(New SqlParameter("@CLM_loginID", UserId))

        dt = db.Read(query, param)

        If dt.Rows.Count > 0 Then
            newOrderID = dt.Rows(0).Item("CLM_loginPWD")
        Else
            newOrderID = "XOK"

        End If


        Return newOrderID
    End Function

    Private Sub fcheckToken(idToken As String)
        Try

            Dim strSql As String = $"SELECT No_Staf_Penerima , Tarikh_Luput_URL, Kod_Sub_Menu , No_Rujukan FROM SMKB_Emel_Auth WHERE ID_Token  = '{idToken}' "


            Dim ds As New DataSet
            Dim dbconn As New DBKewConn
            Dim dt As New DataTable
            Dim dateCurrent As DateTime = DateTime.Now

            ds = dbconn.fSelectCommand(strSql)
            If ds.Tables(0).Rows.Count > 0 Then

                Dim NoStaf As String = ds.Tables(0).Rows(0)("No_Staf_Penerima").ToString()

                Dim KodSubMenu As String = ds.Tables(0).Rows(0)("Kod_Sub_Menu").ToString()
                Dim NoRujukan As String = ds.Tables(0).Rows(0)("No_Rujukan").ToString()
                Dim TarikhLuput As DateTime = DateTime.Parse(ds.Tables(0).Rows(0)("Tarikh_Luput_URL").ToString())

                If dateCurrent > TarikhLuput Then


                    Dim script As String = "
                        $(document).ready(function() { 
                            $('#maklumanExpiredLink').modal('toggle'); 
                            $('#maklumanExpiredLink').on('hidden.bs.modal', function () {
                                window.location.href = 'https://portal.utem.edu.my/iutem/'; 
                            });
                        });
                    "
                    ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal", script, True)

                Else
                    ' masukkan password portal
                    txtIdStaf.Value = NoStaf
                    'baca kod sub menu
                    'Response.Redirect($"~/FORMS/JURNAL/JURNAL KEWANGAN/Kelulusan_JK_emel.aspx?KodSubMenu={KodSubMenu}&no={NoRujukan}")

                End If
            End If
        Catch ex As Exception

        End Try
    End Sub


    'Private Sub fGetSubmenu(idToken As String)
    '    Try

    '        Dim strSql As String = $"SELECT No_Staf_Penerima , Tarikh_Luput_URL, Kod_Sub_Menu , No_Rujukan FROM SMKB_Emel_Auth WHERE ID_Token  = '{idToken}' "


    '        Dim ds As New DataSet
    '        Dim dbconn As New DBKewConn
    '        Dim dt As New DataTable
    '        Dim dateCurrent As DateTime = DateTime.Now

    '        ds = dbconn.fSelectCommand(strSql)
    '        If ds.Tables(0).Rows.Count > 0 Then

    '            Dim NoStaf As String = ds.Tables(0).Rows(0)("No_Staf_Penerima").ToString()

    '            Dim KodSubMenu As String = ds.Tables(0).Rows(0)("Kod_Sub_Menu").ToString()
    '            Dim NoRujukan As String = ds.Tables(0).Rows(0)("No_Rujukan").ToString()
    '            Dim TarikhLuput As DateTime = DateTime.Parse(ds.Tables(0).Rows(0)("Tarikh_Luput_URL").ToString())

    '            txtIdStaf.Value = NoStaf
    '            'baca kod sub menu

    '            Session("KodSubMenu") = KodSubMenu
    '            Session("NoRujukan") = NoRujukan
    '            Session("DariEmel") = "Ya"




    '            Response.Redirect($"~/FORMS/PEROLEHAN/PERMOHONAN PEROLEHAN/KELULUSANPTJ.aspx?KodSubMenu={KodSubMenu}&no={NoRujukan}")
    '            'Response.Redirect($"~/FORMS/JURNAL/JURNAL KEWANGAN/Kelulusan1_JK.aspx?KodSubMenu={KodSubMenu}")
    '        End If
    '    Catch ex As Exception

    '    End Try
    'End Sub


    Private Sub fGetSubmenu(idToken As String)
        Try
            Dim strSql As String = $"SELECT No_Staf_Penerima, Tarikh_Luput_URL, Kod_Sub_Menu, No_Rujukan FROM SMKB_Emel_Auth WHERE ID_Token = '{idToken}' "

            Dim ds As New DataSet
            Dim dbconn As New DBKewConn
            Dim dt As New DataTable
            Dim dateCurrent As DateTime = DateTime.Now

            ds = dbconn.fSelectCommand(strSql)
            If ds.Tables(0).Rows.Count > 0 Then
                Dim NoStaf As String = ds.Tables(0).Rows(0)("No_Staf_Penerima").ToString()
                Dim KodSubMenu As String = ds.Tables(0).Rows(0)("Kod_Sub_Menu").ToString()
                Dim NoRujukan As String = ds.Tables(0).Rows(0)("No_Rujukan").ToString()
                Dim TarikhLuput As DateTime = DateTime.Parse(ds.Tables(0).Rows(0)("Tarikh_Luput_URL").ToString())

                txtIdStaf.Value = NoStaf
                ' Read KodSubMenu
                Session("KodSubMenu") = KodSubMenu
                Session("NoRujukan") = NoRujukan
                Session("DariEmel") = "Ya"

                Dim namaFail As String = GetNamaFail(KodSubMenu)

                If Not String.IsNullOrEmpty(namaFail) Then
                    Response.Redirect($"{namaFail}?KodSubMenu={KodSubMenu}&no={NoRujukan}")
                Else
                    ' Handle case when dynamic URL is not found
                End If
            End If
        Catch ex As Exception
            ' Handle exceptions
        End Try
    End Sub

    Private Function GetNamaFail(ByVal KodSubMenu As String) As String
        Dim strSql As String = "SELECT Nama_Fail FROM SMKB_Sub_Menu WHERE Kod_Sub_Menu = @KodSubMenu"
        Dim namaFail As String = String.Empty

        Try
            Using connection As New SqlConnection(strCon)
                Using command As New SqlCommand(strSql, connection)
                    command.Parameters.AddWithValue("@KodSubMenu", KodSubMenu)
                    connection.Open()
                    Dim result = command.ExecuteScalar()
                    If result IsNot Nothing Then
                        namaFail = result.ToString()
                    End If
                End Using
            End Using
        Catch ex As Exception
            ' Handle exceptions
        End Try

        Return namaFail
    End Function



End Class