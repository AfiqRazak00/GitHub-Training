Imports System.Data.SqlClient
Imports System.EnterpriseServices

Public Class Terima_Order_Dtl
    Public Property No_Dok As String
    Public Property No_Item As String
    Public Property Kod_Kump_Wang As String
    Public Property Kod_Operasi As String
    Public Property Kod_PTJ As String
    Public Property Kod_Projek As String
    Public Property Kod_Vot As String
    Public Property Butiran As String
    Public Property Rujukan As String
    Public Property Debit As String
    Public Property Kredit As String
    Public Property Jumlah_Cukai As String
    Public Property Jumlah_Diskaun As String
    Public Property Status As String

    Public Function InsertCommand() As SqlCommand
        If String.IsNullOrEmpty(No_Dok) Then
            Throw New Exception("No Resit tidak sah")
        End If

        If String.IsNullOrEmpty(No_Item) Then
            Throw New Exception("No Item tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim columns As New List(Of String)
        Dim values As New List(Of String)
        sql = "INSERT INTO SMKB_Terima_Dtl ("

        'wajib
        columns.Add("No_Dok")
        values.Add("@No_Dok")
        cmd.Parameters.Add(New SqlParameter("@No_Dok", No_Dok))

        columns.Add("No_Item")
        values.Add("@No_Item")
        cmd.Parameters.Add(New SqlParameter("@No_Item", No_Item))

        If Not String.IsNullOrEmpty(Kod_Kump_Wang) Then
            columns.Add("Kod_Kump_Wang")
            values.Add("@Kod_Kump_Wang")
            cmd.Parameters.Add(New SqlParameter("@Kod_Kump_Wang", Kod_Kump_Wang))
        End If

        If Not String.IsNullOrEmpty(Kod_Operasi) Then
            columns.Add("Kod_Operasi")
            values.Add("@Kod_Operasi")
            cmd.Parameters.Add(New SqlParameter("@Kod_Operasi", Kod_Operasi))
        End If

        If Not String.IsNullOrEmpty(Kod_PTJ) Then
            columns.Add("Kod_Ptj")
            values.Add("@Kod_Ptj")
            cmd.Parameters.Add(New SqlParameter("@Kod_Ptj", Kod_PTJ))
        End If

        If Not String.IsNullOrEmpty(Kod_Projek) Then
            columns.Add("Kod_Projek")
            values.Add("@Kod_Projek")
            cmd.Parameters.Add(New SqlParameter("@Kod_Projek", Kod_Projek))
        End If

        If Not String.IsNullOrEmpty(Kod_Vot) Then
            columns.Add("Kod_Vot")
            values.Add("@Kod_Vot")
            cmd.Parameters.Add(New SqlParameter("@Kod_Vot", Kod_Vot))
        End If

        If Not String.IsNullOrEmpty(Butiran) Then
            columns.Add("Butiran")
            values.Add("@Butiran")
            cmd.Parameters.Add(New SqlParameter("@Butiran", Butiran))
        End If

        If Not String.IsNullOrEmpty(Rujukan) Then
            columns.Add("Rujukan")
            values.Add("@Rujukan")
            cmd.Parameters.Add(New SqlParameter("@Rujukan", Rujukan))
        End If

        If Not String.IsNullOrEmpty(Debit) Then
            columns.Add("Debit")
            values.Add("@Debit")
            cmd.Parameters.Add(New SqlParameter("@Debit", Debit))
        End If

        If Not String.IsNullOrEmpty(Kredit) Then
            columns.Add("Kredit")
            values.Add("@Kredit")
            cmd.Parameters.Add(New SqlParameter("@Kredit", Kredit))
        End If

        If Not String.IsNullOrEmpty(Jumlah_Cukai) Then
            columns.Add("Jumlah_Cukai")
            values.Add("@Jumlah_Cukai")
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Cukai", Jumlah_Cukai))
        End If

        If Not String.IsNullOrEmpty(Jumlah_Diskaun) Then
            columns.Add("Jumlah_Diskaun")
            values.Add("@Jumlah_Diskaun")
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Diskaun", Jumlah_Diskaun))
        End If

        If Not String.IsNullOrEmpty(Status) Then
            columns.Add("Status")
            values.Add("@Status")
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If

        ' Combine columns and values lists into SQL format
        sql += String.Join(",", columns) + ") VALUES (" + String.Join(",", values) + ")"
        cmd.CommandText = sql

        Return cmd
    End Function
End Class
