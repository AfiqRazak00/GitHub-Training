Imports System.Data.SqlClient
Imports System.EnterpriseServices

Public Class Bil_Order_Dtl
    Public Property No_Bil As String
    Public Property No_Item As String
    Public Property Kod_Kump_Wang As String
    Public Property Kod_Operasi As String
    Public Property Kod_PTJ As String
    Public Property Kod_Projek As String
    Public Property Kod_Vot As String
    Public Property Perkara As String
    Public Property Kuantiti As String
    Public Property Kadar_Harga As String
    Public Property Jumlah As String
    Public Property Tahun As String
    Public Property Status_Bayaran As String
    Public Property Diskaun As String
    Public Property Cukai As String
    Public Property Status As String

    Public Function InsertCommand() As SqlCommand
        If String.IsNullOrEmpty(No_Bil) Then
            Throw New Exception("No Bil tidak sah")
        End If

        If String.IsNullOrEmpty(No_Item) Then
            Throw New Exception("No Item tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim columns As New List(Of String)
        Dim values As New List(Of String)
        sql = "INSERT INTO SMKB_Bil_Dtl ("

        'wajib
        columns.Add("No_Bil")
        values.Add("@No_Bil")
        cmd.Parameters.Add(New SqlParameter("@No_Bil", No_Bil))

        columns.Add("No_Item")
        values.Add("@No_Item")
        cmd.Parameters.Add(New SqlParameter("@No_Item", No_Item))

        columns.Add("Jumlah")
        values.Add("@Jumlah")
        cmd.Parameters.Add(New SqlParameter("@Jumlah", Jumlah))

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

        If Not String.IsNullOrEmpty(Perkara) Then
            columns.Add("Perkara")
            values.Add("@Perkara")
            cmd.Parameters.Add(New SqlParameter("@Perkara", Perkara))
        End If

        If Not String.IsNullOrEmpty(Kuantiti) Then
            columns.Add("Kuantiti")
            values.Add("@Kuantiti")
            cmd.Parameters.Add(New SqlParameter("@Kuantiti", Kuantiti))
        End If

        If Not String.IsNullOrEmpty(Kadar_Harga) Then
            columns.Add("Kadar_Harga")
            values.Add("@Kadar_Harga")
            cmd.Parameters.Add(New SqlParameter("@Kadar_Harga", Kadar_Harga))
        End If

        If Not String.IsNullOrEmpty(Tahun) Then
            columns.Add("Tahun")
            values.Add("@Tahun")
            cmd.Parameters.Add(New SqlParameter("@Tahun", Tahun))
        End If

        If Not String.IsNullOrEmpty(Status_Bayaran) Then
            columns.Add("Status_Bayaran")
            values.Add("@Status_Bayaran")
            cmd.Parameters.Add(New SqlParameter("@Status_Bayaran", Status_Bayaran))
        End If

        If Not String.IsNullOrEmpty(Diskaun) Then
            columns.Add("Diskaun")
            values.Add("@Diskaun")
            cmd.Parameters.Add(New SqlParameter("@Diskaun", Diskaun))
        End If

        If Not String.IsNullOrEmpty(Cukai) Then
            columns.Add("Cukai")
            values.Add("@Cukai")
            cmd.Parameters.Add(New SqlParameter("@Cukai", Cukai))
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
    Overridable Function getSum() As Double
        Return 0
    End Function
End Class

Public Class Bil_Adj_Dtl
    Public Property No_Pelarasan As String
    Public Property No_Bil As String
    Public Property No_Item As String
    Public Property Kod_Kump_Wang As String
    Public Property Kod_Operasi As String
    Public Property Kod_PTJ As String
    Public Property Kod_Projek As String
    Public Property Kod_Vot As String
    Public Property Perkara As String
    Public Property Kuantiti As String
    Public Property Kadar_Harga As String
    Public Property Jumlah As String
    Public Property Tahun As String
    Public Property Bil_Pel As String
    Public Property Petunjuk As String
    Public Property Status As String

    Public Function InsertCommand() As SqlCommand

        If String.IsNullOrEmpty(No_Pelarasan) Then
            Throw New Exception("No Pelarasan tidak sah")
        End If

        If String.IsNullOrEmpty(No_Bil) Then
            Throw New Exception("No Bil tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim columns As New List(Of String)
        Dim values As New List(Of String)
        sql = "INSERT INTO SMKB_Bil_Adj_Dtl ("

        'wajib
        columns.Add("No_Pelarasan")
        values.Add("@No_Pelarasan")
        cmd.Parameters.Add(New SqlParameter("@No_Pelarasan", No_Pelarasan))

        columns.Add("No_Bil")
        values.Add("@No_Bil")
        cmd.Parameters.Add(New SqlParameter("@No_Bil", No_Bil))


        If Not String.IsNullOrEmpty(No_Item) Then
            columns.Add("No_Item")
            values.Add("@No_Item")
            cmd.Parameters.Add(New SqlParameter("@No_Item", No_Item))
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

        If Not String.IsNullOrEmpty(Kod_PTJ) Then
            columns.Add("Kod_PTJ")
            values.Add("@Kod_PTJ")
            cmd.Parameters.Add(New SqlParameter("@Kod_PTJ", Kod_PTJ))
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

        If Not String.IsNullOrEmpty(Perkara) Then
            columns.Add("Perkara")
            values.Add("@Perkara")
            cmd.Parameters.Add(New SqlParameter("@Perkara", Perkara))
        End If

        If Not String.IsNullOrEmpty(Kuantiti) Then
            columns.Add("Kuantiti")
            values.Add("@Kuantiti")
            cmd.Parameters.Add(New SqlParameter("@Kuantiti", Kuantiti))
        End If

        If Not String.IsNullOrEmpty(Kadar_Harga) Then
            columns.Add("Kadar_Harga")
            values.Add("@Kadar_Harga")
            cmd.Parameters.Add(New SqlParameter("@Kadar_Harga", Kadar_Harga))
        End If

        If Not String.IsNullOrEmpty(Jumlah) Then
            columns.Add("Jumlah")
            values.Add("@Jumlah")
            cmd.Parameters.Add(New SqlParameter("@Jumlah", Jumlah))
        End If

        If Not String.IsNullOrEmpty(Tahun) Then
            columns.Add("Tahun")
            values.Add("@Tahun")
            cmd.Parameters.Add(New SqlParameter("@Tahun", Tahun))
        End If

        If Not String.IsNullOrEmpty(Bil_Pel) Then
            columns.Add("Bil_Pel")
            values.Add("@Bil_Pel")
            cmd.Parameters.Add(New SqlParameter("@Bil_Pel", Bil_Pel))
        End If

        If Not String.IsNullOrEmpty(Petunjuk) Then
            columns.Add("Petunjuk")
            values.Add("@Petunjuk")
            cmd.Parameters.Add(New SqlParameter("@Petunjuk", Petunjuk))
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

