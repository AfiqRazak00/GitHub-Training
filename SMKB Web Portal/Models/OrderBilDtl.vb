Imports System.Data.SqlClient

Public Class OrderBilDtl
    Public Property No_Bil As String
    Public Property No_Item As Integer
    Public Property Kod_Kump_Wang As String
    Public Property Kod_Operasi As String
    Public Property Kod_PTJ As String
    Public Property Kod_Projek As String
    Public Property Kod_Vot As String
    Public Property Perkara As String
    Public Property Kuantiti As Double
    Public Property Kadar_Harga As Double
    Public Property Jumlah As Double
    Public Property Tahun As String
    Public Property Status_Bayaran As String
    Public Property Diskaun As Double
    Public Property Cukai As Double
    Public Property Status As String

    Public Function insertCommand() As SqlCommand
        Dim cmd As New SqlCommand

        cmd.CommandText = "INSERT INTO SMP_Bil_Order_Dtl (No_Bil,No_Item,Kod_Vot,Perkara,Kuantiti,Kadar_Harga,Jumlah,Diskaun,Cukai,Status)
                           VALUES (@No_Bil,@No_Item,@Kod_Vot,@Perkara,@Kuantiti,@Kadar_Harga,@Jumlah,@Diskaun,@Cukai,@Status)"
        cmd.Parameters.Add(New SqlParameter("@No_Bil", No_Bil))
        cmd.Parameters.Add(New SqlParameter("@No_Item", No_Item))
        cmd.Parameters.Add(New SqlParameter("@Kod_Vot", Kod_Vot))
        cmd.Parameters.Add(New SqlParameter("@Perkara", Perkara))
        cmd.Parameters.Add(New SqlParameter("@Kuantiti", Kuantiti))
        cmd.Parameters.Add(New SqlParameter("@Kadar_Harga", Kadar_Harga))
        cmd.Parameters.Add(New SqlParameter("@Jumlah", Jumlah))
        cmd.Parameters.Add(New SqlParameter("@Diskaun", Diskaun))
        cmd.Parameters.Add(New SqlParameter("@Cukai", Cukai))
        cmd.Parameters.Add(New SqlParameter("@Status", Status))
        Return cmd
    End Function
End Class
