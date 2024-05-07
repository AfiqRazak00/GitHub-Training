Imports Microsoft.Build.Framework.XamlTypes
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.EnterpriseServices

Public Class Terima_Order
    Public Property No_Dok As String
    Public Property Kod_Penghutang As String
    Public Property No_Rujukan As String
    Public Property Tujuan As String
    Public Property Kod_Urusniaga As String
    Public Property Mod_Terima As String
    Public Property Tkh_Daftar As String
    Public Property Staf_Terima As String
    Public Property Jumlah_Sebenar As String
    Public Property Jumlah_Bayar As String
    Public Property Kategori_Bayar As String
    Public Property Zon As String
    Public Property Status_Cetak As String
    Public Property Staf_Batal As String
    Public Property Tkh_Batal As String
    Public Property Staf_Closing As String
    Public Property Flag_Closing As String
    Public Property Flag_Lulus As String
    Public Property Staf_Lulus As String
    Public Property Tkh_Closing As String
    Public Property Tkh_Lulus As String
    Public Property Diskaun_Amaun As String
    Public Property Cukai_Amaun As String
    Public Property Tkh_Dok As String
    Public Property Kod_Bank As String
    Public Property Status As String
    Public Property Kod_Terima As String
    Public Property Kod_Status_Dok As String
    Public Property Flag_Kaunter As String
    Public Property Kod_Penyesuaian As String
    Public Property ID_Penyesuaian As String
    Public Property Tkh_Penyesuaian As String
    Public Property details As List(Of Terima_Order_Dtl)

    Public Function InsertCommand() As SqlCommand
        If No_Dok Is Nothing Then
            Throw New Exception("No Resit tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String
        sql = "INSERT INTO SMKB_Terima_Hdr (No_Dok,Kod_Penghutang"
        values = "(@No_Dok,@Kod_Penghutang"
        cmd.Parameters.Add(New SqlParameter("@No_Dok", No_Dok))
        cmd.Parameters.Add(New SqlParameter("@Kod_Penghutang", Kod_Penghutang))

        If No_Rujukan IsNot Nothing Then
            sql += ", No_Rujukan"
            values += ", @No_Rujukan"
            cmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        End If

        If Tujuan IsNot Nothing Then
            sql += ", Tujuan"
            values += ", @Tujuan"
            cmd.Parameters.Add(New SqlParameter("@Tujuan", Tujuan))
        End If

        If Kod_Urusniaga IsNot Nothing Then
            sql += ", Kod_Urusniaga"
            values += ", @Kod_Urusniaga"
            cmd.Parameters.Add(New SqlParameter("@Kod_Urusniaga", Kod_Urusniaga))
        End If

        If Mod_Terima IsNot Nothing Then
            sql += ", Mod_Terima"
            values += ", @Mod_Terima"
            cmd.Parameters.Add(New SqlParameter("@Mod_Terima", Mod_Terima))
        End If

        If Tkh_Daftar IsNot Nothing Then
            sql += ", Tkh_Daftar"
            values += ", @Tkh_Daftar"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Daftar", Tkh_Daftar))
        End If

        If Staf_Terima IsNot Nothing Then
            sql += ", Staf_Terima"
            values += ", @Staf_Terima"
            cmd.Parameters.Add(New SqlParameter("@Staf_Terima", Staf_Terima))
        End If

        If Jumlah_Sebenar IsNot Nothing Then
            sql += ", Jumlah_Sebenar"
            values += ", @Jumlah_Sebenar"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Sebenar", Jumlah_Sebenar))
        End If

        If Jumlah_Bayar IsNot Nothing Then
            sql += ", Jumlah_Bayar"
            values += ", @Jumlah_Bayar"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Bayar", Jumlah_Bayar))
        End If

        If Kategori_Bayar IsNot Nothing Then
            sql += ", Kategori_Bayar"
            values += ", @Kategori_Bayar"
            cmd.Parameters.Add(New SqlParameter("@Kategori_Bayar", Kategori_Bayar))
        End If

        If Zon IsNot Nothing Then
            sql += ", Zon"
            values += ", @Zon"
            cmd.Parameters.Add(New SqlParameter("@Zon", Zon))
        End If

        If Status_Cetak IsNot Nothing Then
            sql += ", Status_Cetak"
            values += ", @Status_Cetak"
            cmd.Parameters.Add(New SqlParameter("@Status_Cetak", Status_Cetak))
        End If

        If Staf_Batal IsNot Nothing Then
            sql += ", Staf_Batal"
            values += ", @Staf_Batal"
            cmd.Parameters.Add(New SqlParameter("@Staf_Batal", Staf_Batal))
        End If

        If Tkh_Batal IsNot Nothing Then
            sql += ", Tkh_Batal"
            values += ", @Tkh_Batal"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Batal", Tkh_Batal))
        End If

        If Staf_Closing IsNot Nothing Then
            sql += ", Staf_Closing"
            values += ", @Staf_Closing"
            cmd.Parameters.Add(New SqlParameter("@Staf_Closing", Staf_Closing))
        End If

        If Flag_Closing IsNot Nothing Then
            sql += ", Flag_Closing"
            values += ", @Flag_Closing"
            cmd.Parameters.Add(New SqlParameter("@Flag_Closing", Flag_Closing))
        End If

        If Flag_Lulus IsNot Nothing Then
            sql += ", Flag_Lulus"
            values += ", @Flag_Lulus"
            cmd.Parameters.Add(New SqlParameter("@Flag_Lulus", Flag_Lulus))
        End If

        If Staf_Lulus IsNot Nothing Then
            sql += ", Staf_Lulus"
            values += ", @Staf_Lulus"
            cmd.Parameters.Add(New SqlParameter("@Staf_Lulus", Staf_Lulus))
        End If

        If Tkh_Closing IsNot Nothing Then
            sql += ", Tkh_Closing"
            values += ", @Tkh_Closing"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Closing", Tkh_Closing))
        End If

        If Tkh_Lulus IsNot Nothing Then
            sql += ", Tkh_Lulus"
            values += ", @Tkh_Lulus"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Lulus", Tkh_Lulus))
        End If

        If Diskaun_Amaun IsNot Nothing Then
            sql += ", Diskaun_Amaun"
            values += ", @Diskaun_Amaun"
            cmd.Parameters.Add(New SqlParameter("@Diskaun_Amaun", Diskaun_Amaun))
        End If

        If Cukai_Amaun IsNot Nothing Then
            sql += ", Cukai_Amaun"
            values += ", @Cukai_Amaun"
            cmd.Parameters.Add(New SqlParameter("@Cukai_Amaun", Cukai_Amaun))
        End If

        If Tkh_Dok IsNot Nothing Then
            sql += ", Tkh_Dok"
            values += ", @Tkh_Dok"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Dok", Tkh_Dok))
        End If

        If Kod_Bank IsNot Nothing Then
            sql += ", Kod_Bank"
            values += ", @Kod_Bank"
            cmd.Parameters.Add(New SqlParameter("@Kod_Bank", Kod_Bank))
        End If

        If Status IsNot Nothing Then
            sql += ", Status"
            values += ", @Status"
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If

        If Kod_Terima IsNot Nothing Then
            sql += ", Kod_Terima"
            values += ", @Kod_Terima"
            cmd.Parameters.Add(New SqlParameter("@Kod_Terima", Kod_Terima))
        End If

        If Kod_Status_Dok IsNot Nothing Then
            sql += ", Kod_Status_Dok"
            values += ", @Kod_Status_Dok"
            cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Kod_Status_Dok))
        End If

        If Flag_Kaunter IsNot Nothing Then
            sql += ", Flag_Kaunter"
            values += ", @Flag_Kaunter"
            cmd.Parameters.Add(New SqlParameter("@Flag_Kaunter", Flag_Kaunter))
        End If

        If Kod_Penyesuaian IsNot Nothing Then
            sql += ", Kod_Penyesuaian"
            values += ", @Kod_Penyesuaian"
            cmd.Parameters.Add(New SqlParameter("@Kod_Penyesuaian", Kod_Penyesuaian))
        End If

        If ID_Penyesuaian IsNot Nothing Then
            sql += ", ID_Penyesuaian"
            values += ", @ID_Penyesuaian"
            cmd.Parameters.Add(New SqlParameter("@ID_Penyesuaian", ID_Penyesuaian))
        End If

        If Tkh_Penyesuaian IsNot Nothing Then
            sql += ", Tkh_Penyesuaian"
            values += ", @Tkh_Penyesuaian"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Penyesuaian", Tkh_Penyesuaian))
        End If

        ' Construct the final SQL command
        cmd.CommandText = sql + ") VALUES " + values + ")"

        Return cmd
    End Function
End Class
