Imports System.Data.SqlClient
Public Class AP_Order_Dtl
    Public Property No_Order As String
    Public Property No_Item As Integer
    Public Property Jumlah As String
    Public Property No_Dokumen As String
    Public Property Sesi As String
    Public Property Kod_Kump_Wang As String
    Public Property Kod_Operasi As String
    Public Property Kod_Ptj As String
    Public Property Kod_Projek As String
    Public Property Kod_Vot As String
    Public Property Status As String
    Public Property Kat_Pemiutang As String

    Public Function InsertCommand() As SqlCommand
        If String.IsNullOrEmpty(No_Order) Then
            Throw New Exception("No Order tidak sah")
        End If

        If String.IsNullOrEmpty(No_Item) Then
            Throw New Exception("No Item tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim columns As New List(Of String)
        Dim values As New List(Of String)
        sql = "INSERT INTO AP_Order_Dtl ("

        'wajib
        columns.Add("No_Order")
        values.Add("@No_Order")
        cmd.Parameters.Add(New SqlParameter("@No_Order", No_Order))

        columns.Add("No_Item")
        values.Add("@No_Item")
        cmd.Parameters.Add(New SqlParameter("@No_Item", No_Item))

        columns.Add("Jumlah")
        values.Add("@Jumlah")
        cmd.Parameters.Add(New SqlParameter("@Jumlah", Jumlah))

        If Not String.IsNullOrEmpty(No_Dokumen) Then
            No_Dokumen = SMKB_API.GetPemiutang(No_Dokumen, Kat_Pemiutang)
            If Not String.IsNullOrEmpty(No_Dokumen) Then
                columns.Add("No_Dokumen")
                values.Add("@No_Dokumen")
                cmd.Parameters.Add(New SqlParameter("@No_Dokumen", No_Dokumen))
                'Else
                '    No_Dokumen = AkaunPemiutangWS.GetNoAkaunPemiutangList(No_Dokumen)
            End If

        End If

        If Not String.IsNullOrEmpty(Sesi) Then
            columns.Add("Sesi")
            values.Add("@Sesi")
            cmd.Parameters.Add(New SqlParameter("@Sesi", Sesi))
        End If

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

        If Not String.IsNullOrEmpty(Kod_Ptj) Then
            columns.Add("Kod_Ptj")
            values.Add("@Kod_Ptj")
            cmd.Parameters.Add(New SqlParameter("@Kod_Ptj", Kod_Ptj))
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
