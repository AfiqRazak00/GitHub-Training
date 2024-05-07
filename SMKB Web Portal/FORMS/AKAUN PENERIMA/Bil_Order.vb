Imports System.Data.SqlClient
Imports Microsoft.Build.Framework.XamlTypes
Imports System.Drawing
Imports System.EnterpriseServices

Public Class Bil_Order
    Public Property No_Bil As String
    Public Property Tahun As String
    Public Property Kod_Sesi As String
    Public Property Tkh_Mohon As String
    Public Property Jenis As String
    Public Property Kod_PTJ_Mohon As String
    Public Property No_Staf As String
    Public Property Utk_Perhatian As String
    Public Property No_Rujukan As String
    Public Property Jumlah As String
    Public Property Kod_Status_Dok As String
    Public Property Status_Cetak_Bil_Sbnr As String
    Public Property Status_Cetak_Bil_Smtr As String
    Public Property Flag_Adj As String
    Public Property Kod_Urusniaga As String
    Public Property Kategori As String
    Public Property Kod_Penghutang As String
    Public Property Tujuan As String
    Public Property Kontrak As String
    Public Property No_Memo As String
    Public Property Tkh_Mula As String
    Public Property Tkh_Tamat As String
    Public Property Tempoh_Kontrak As String
    Public Property Jenis_Tempoh As String
    Public Property Peringatan_1 As String
    Public Property Peringatan_2 As String
    Public Property Peringatan_3 As String
    Public Property Tkh_Peringatan_1 As String
    Public Property Tkh_Peringatan_2 As String
    Public Property Tkh_Peringatan_3 As String
    Public Property Tkh_Lulus As String
    Public Property No_Staf_Lulus As String
    Public Property Dok_Sokongan As String
    Public Property Flag_Lulus As String
    Public Property Status As String
    Public Property No_Staf_Penyedia As String
    Public Property Tkh_Bil As String
    Public Property Kod_Penaja As String
    Public Property details As List(Of Bil_Order_Dtl)

    Public Function InsertCommand() As SqlCommand
        If No_Bil Is Nothing Then
            Throw New Exception("No Bil tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String
        sql = "INSERT INTO SMKB_Bil_Hdr (No_Bil,Kod_Penghutang"
        values = "(@No_Bil,@Kod_Penghutang"
        cmd.Parameters.Add(New SqlParameter("@No_Bil", No_Bil))
        cmd.Parameters.Add(New SqlParameter("@Kod_Penghutang", Kod_Penghutang))

        If Tahun IsNot Nothing Then
            sql += ", Tahun"
            values += ", @Tahun"
            cmd.Parameters.Add(New SqlParameter("@Tahun", Tahun))
        End If

        If Kod_Sesi IsNot Nothing Then
            sql += ", Kod_Sesi"
            values += ", @Kod_Sesi"
            cmd.Parameters.Add(New SqlParameter("@Kod_Sesi", Kod_Sesi))
        End If

        If Tkh_Mohon IsNot Nothing Then
            sql += ", Tkh_Mohon"
            values += ", @Tkh_Mohon"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Mohon", Tkh_Mohon))
        End If

        If Jenis IsNot Nothing Then
            sql += ", Jenis"
            values += ", @Jenis"
            cmd.Parameters.Add(New SqlParameter("@Jenis", Jenis))
        End If

        If Kod_PTJ_Mohon IsNot Nothing Then
            sql += ", Kod_PTJ_Mohon"
            values += ", @Kod_PTJ_Mohon"
            cmd.Parameters.Add(New SqlParameter("@Kod_PTJ_Mohon", Kod_PTJ_Mohon))
        End If

        If No_Staf IsNot Nothing Then
            sql += ", No_Staf"
            values += ", @No_Staf"
            cmd.Parameters.Add(New SqlParameter("@No_Staf", No_Staf))
        End If

        If Utk_Perhatian IsNot Nothing Then
            sql += ", Utk_Perhatian"
            values += ", @Utk_Perhatian"
            cmd.Parameters.Add(New SqlParameter("@Utk_Perhatian", Utk_Perhatian))
        End If

        If No_Rujukan IsNot Nothing Then
            sql += ", No_Rujukan"
            values += ", @No_Rujukan"
            cmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        End If

        If Jumlah IsNot Nothing Then
            sql += ", Jumlah"
            values += ", @Jumlah"
            cmd.Parameters.Add(New SqlParameter("@Jumlah", Jumlah))
        End If

        If Kod_Status_Dok IsNot Nothing Then
            sql += ", Kod_Status_Dok"
            values += ", @Kod_Status_Dok"
            cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Kod_Status_Dok))
        End If

        If Status_Cetak_Bil_Sbnr IsNot Nothing Then
            sql += ", Status_Cetak_Bil_Sbnr"
            values += ", @Status_Cetak_Bil_Sbnr"
            cmd.Parameters.Add(New SqlParameter("@Status_Cetak_Bil_Sbnr", Status_Cetak_Bil_Sbnr))
        End If

        If Status_Cetak_Bil_Smtr IsNot Nothing Then
            sql += ", Status_Cetak_Bil_Smtr"
            values += ", @Status_Cetak_Bil_Smtr"
            cmd.Parameters.Add(New SqlParameter("@Status_Cetak_Bil_Smtr", Status_Cetak_Bil_Smtr))
        End If

        If Flag_Adj IsNot Nothing Then
            sql += ", Flag_Adj"
            values += ", @Flag_Adj"
            cmd.Parameters.Add(New SqlParameter("@Flag_Adj", Flag_Adj))
        End If

        If Kod_Urusniaga IsNot Nothing Then
            sql += ", Kod_Urusniaga"
            values += ", @Kod_Urusniaga"
            cmd.Parameters.Add(New SqlParameter("@Kod_Urusniaga", Kod_Urusniaga))
        End If

        If Kategori IsNot Nothing Then
            sql += ", Kategori"
            values += ", @Kategori"
            cmd.Parameters.Add(New SqlParameter("@Kategori", Kategori))
        End If

        If Tujuan IsNot Nothing Then
            sql += ", Tujuan"
            values += ", @Tujuan"
            cmd.Parameters.Add(New SqlParameter("@Tujuan", Tujuan))
        End If

        If Kontrak IsNot Nothing Then
            sql += ", Kontrak"
            values += ", @Kontrak"
            cmd.Parameters.Add(New SqlParameter("@Kontrak", Kontrak))
        End If

        If No_Memo IsNot Nothing Then
            sql += ", No_Memo"
            values += ", @No_Memo"
            cmd.Parameters.Add(New SqlParameter("@No_Memo", No_Memo))
        End If

        If Tkh_Mula IsNot Nothing Then
            sql += ", Tkh_Mula"
            values += ", @Tkh_Mula"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Mula", Tkh_Mula))
        End If

        If Tkh_Tamat IsNot Nothing Then
            sql += ", Tkh_Tamat"
            values += ", @Tkh_Tamat"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Tamat", Tkh_Tamat))
        End If

        If Tempoh_Kontrak IsNot Nothing Then
            sql += ", Tempoh_Kontrak"
            values += ", @Tempoh_Kontrak"
            cmd.Parameters.Add(New SqlParameter("@Tempoh_Kontrak", Tempoh_Kontrak))
        End If

        If Jenis_Tempoh IsNot Nothing Then
            sql += ", Jenis_Tempoh"
            values += ", @Jenis_Tempoh"
            cmd.Parameters.Add(New SqlParameter("@Jenis_Tempoh", Jenis_Tempoh))
        End If

        If Peringatan_1 IsNot Nothing Then
            sql += ", Peringatan_1"
            values += ", @Peringatan_1"
            cmd.Parameters.Add(New SqlParameter("@Peringatan_1", Peringatan_1))
        End If

        If Peringatan_2 IsNot Nothing Then
            sql += ", Peringatan_2"
            values += ", @Peringatan_2"
            cmd.Parameters.Add(New SqlParameter("@Peringatan_2", Peringatan_2))
        End If

        If Peringatan_3 IsNot Nothing Then
            sql += ", Peringatan_3"
            values += ", @Peringatan_3"
            cmd.Parameters.Add(New SqlParameter("@Peringatan_3", Peringatan_3))
        End If

        If Tkh_Peringatan_1 IsNot Nothing Then
            sql += ", Tkh_Peringatan_1"
            values += ", @Tkh_Peringatan_1"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Peringatan_1", Tkh_Peringatan_1))
        End If

        If Tkh_Peringatan_2 IsNot Nothing Then
            sql += ", Tkh_Peringatan_2"
            values += ", @Tkh_Peringatan_2"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Peringatan_2", Tkh_Peringatan_2))
        End If

        If Tkh_Peringatan_3 IsNot Nothing Then
            sql += ", Tkh_Peringatan_3"
            values += ", @Tkh_Peringatan_3"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Peringatan_3", Tkh_Peringatan_3))
        End If

        If Tkh_Lulus IsNot Nothing Then
            sql += ", Tkh_Lulus"
            values += ", @Tkh_Lulus"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Lulus", Tkh_Lulus))
        End If

        If No_Staf_Lulus IsNot Nothing Then
            sql += ", No_Staf_Lulus"
            values += ", @No_Staf_Lulus"
            cmd.Parameters.Add(New SqlParameter("@No_Staf_Lulus", No_Staf_Lulus))
        End If

        If Dok_Sokongan IsNot Nothing Then
            sql += ", Dok_Sokongan"
            values += ", @Dok_Sokongan"
            cmd.Parameters.Add(New SqlParameter("@Dok_Sokongan", Dok_Sokongan))
        End If

        If Flag_Lulus IsNot Nothing Then
            sql += ", Flag_Lulus"
            values += ", @Flag_Lulus"
            cmd.Parameters.Add(New SqlParameter("@Flag_Lulus", Flag_Lulus))
        End If

        If Status IsNot Nothing Then
            sql += ", Status"
            values += ", @Status"
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If

        If No_Staf_Penyedia IsNot Nothing Then
            sql += ", No_Staf_Penyedia"
            values += ", @No_Staf_Penyedia"
            cmd.Parameters.Add(New SqlParameter("@No_Staf_Penyedia", No_Staf_Penyedia))
        End If

        If Tkh_Bil IsNot Nothing Then
            sql += ", Tkh_Bil"
            values += ", @Tkh_Bil"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Bil", Tkh_Bil))
        End If

        If Kod_Penaja IsNot Nothing Then
            sql += ", Kod_Penaja"
            values += ", @Kod_Penaja"
            cmd.Parameters.Add(New SqlParameter("@Kod_Penaja", Kod_Penaja))
        End If

        ' Construct the final SQL command
        cmd.CommandText = sql + ") VALUES " + values + ")"

        Return cmd
    End Function
    Public Function updateCommand() As SqlCommand
        If String.IsNullOrEmpty(No_Bil) Then
            Throw New Exception("No Bil tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "UPDATE SMKB_Bil_Hdr SET "

        If Not String.IsNullOrEmpty(Kod_Penghutang) Then
            values += "Kod_Penghutang = @Kod_Penghutang,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Penghutang", Kod_Penghutang))
        End If

        If Not String.IsNullOrEmpty(Tahun) Then
            values += "Tahun = @Tahun,"
            cmd.Parameters.Add(New SqlParameter("@Tahun", Tahun))
        End If

        If Not String.IsNullOrEmpty(Kod_Sesi) Then
            values += "Kod_Sesi = @Kod_Sesi,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Sesi", Kod_Sesi))
        End If

        If Not String.IsNullOrEmpty(Tkh_Mohon) Then
            values += "Tkh_Mohon = @Tkh_Mohon,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Mohon", Tkh_Mohon))
        End If

        If Not String.IsNullOrEmpty(Jenis) Then
            values += "Jenis = @Jenis,"
            cmd.Parameters.Add(New SqlParameter("@Jenis", Jenis))
        End If

        If Not String.IsNullOrEmpty(Kod_PTJ_Mohon) Then
            values += "Kod_PTJ_Mohon = @Kod_PTJ_Mohon,"
            cmd.Parameters.Add(New SqlParameter("@Kod_PTJ_Mohon", Kod_PTJ_Mohon))
        End If

        If Not String.IsNullOrEmpty(No_Staf) Then
            values += "No_Staf = @No_Staf,"
            cmd.Parameters.Add(New SqlParameter("@No_Staf", No_Staf))
        End If

        If Not String.IsNullOrEmpty(Utk_Perhatian) Then
            values += "Utk_Perhatian = @Utk_Perhatian,"
            cmd.Parameters.Add(New SqlParameter("@Utk_Perhatian", Utk_Perhatian))
        End If

        If Not String.IsNullOrEmpty(No_Rujukan) Then
            values += "No_Rujukan = @No_Rujukan,"
            cmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        End If

        If Not String.IsNullOrEmpty(Jumlah) Then
            values += "Jumlah = @Jumlah,"
            cmd.Parameters.Add(New SqlParameter("@Jumlah", Jumlah))
        End If

        If Not String.IsNullOrEmpty(Kod_Status_Dok) Then
            values += "Kod_Status_Dok = @Kod_Status_Dok,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Kod_Status_Dok))
        End If

        If Not String.IsNullOrEmpty(Status_Cetak_Bil_Sbnr) Then
            values += "Status_Cetak_Bil_Sbnr = @Status_Cetak_Bil_Sbnr,"
            cmd.Parameters.Add(New SqlParameter("@Status_Cetak_Bil_Sbnr", Status_Cetak_Bil_Sbnr))
        End If

        If Not String.IsNullOrEmpty(Status_Cetak_Bil_Smtr) Then
            values += "Status_Cetak_Bil_Smtr = @Status_Cetak_Bil_Smtr,"
            cmd.Parameters.Add(New SqlParameter("@Status_Cetak_Bil_Smtr", Status_Cetak_Bil_Smtr))
        End If

        If Not String.IsNullOrEmpty(Flag_Adj) Then
            values += "Flag_Adj = @Flag_Adj,"
            cmd.Parameters.Add(New SqlParameter("@Flag_Adj", Flag_Adj))
        End If

        If Not String.IsNullOrEmpty(Kod_Urusniaga) Then
            values += "Kod_Urusniaga = @Kod_Urusniaga,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Urusniaga", Kod_Urusniaga))
        End If

        If Not String.IsNullOrEmpty(Kategori) Then
            values += "Kategori = @Kategori,"
            cmd.Parameters.Add(New SqlParameter("@Kategori", Kategori))
        End If

        If Not String.IsNullOrEmpty(Tujuan) Then
            values += "Tujuan = @Tujuan,"
            cmd.Parameters.Add(New SqlParameter("@Tujuan", Tujuan))
        End If

        If Not String.IsNullOrEmpty(Kontrak) Then
            values += "Kontrak = @Kontrak,"
            cmd.Parameters.Add(New SqlParameter("@Kontrak", Kontrak))
        End If

        If Not String.IsNullOrEmpty(No_Memo) Then
            values += "No_Memo = @No_Memo,"
            cmd.Parameters.Add(New SqlParameter("@No_Memo", No_Memo))
        End If

        If Not String.IsNullOrEmpty(Tkh_Mula) Then
            values += "Tkh_Mula = @Tkh_Mula,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Mula", Tkh_Mula))
        End If

        If Not String.IsNullOrEmpty(Tkh_Tamat) Then
            values += "Tkh_Tamat = @Tkh_Tamat,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Tamat", Tkh_Tamat))
        End If

        If Not String.IsNullOrEmpty(Tempoh_Kontrak) Then
            values += "Tempoh_Kontrak = @Tempoh_Kontrak,"
            cmd.Parameters.Add(New SqlParameter("@Tempoh_Kontrak", Tempoh_Kontrak))
        End If

        If Not String.IsNullOrEmpty(Jenis_Tempoh) Then
            values += "Jenis_Tempoh = @Jenis_Tempoh,"
            cmd.Parameters.Add(New SqlParameter("@Jenis_Tempoh", Jenis_Tempoh))
        End If

        If Not String.IsNullOrEmpty(Peringatan_1) Then
            values += "Peringatan_1 = @Peringatan_1,"
            cmd.Parameters.Add(New SqlParameter("@Peringatan_1", Peringatan_1))
        End If

        If Not String.IsNullOrEmpty(Peringatan_2) Then
            values += "Peringatan_2 = @Peringatan_2,"
            cmd.Parameters.Add(New SqlParameter("@Peringatan_2", Peringatan_2))
        End If

        If Not String.IsNullOrEmpty(Peringatan_3) Then
            values += "Peringatan_3 = @Peringatan_3,"
            cmd.Parameters.Add(New SqlParameter("@Peringatan_3", Peringatan_3))
        End If

        If Not String.IsNullOrEmpty(Tkh_Peringatan_1) Then
            values += "Tkh_Peringatan_1 = @Tkh_Peringatan_1,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Peringatan_1", Tkh_Peringatan_1))
        End If

        If Not String.IsNullOrEmpty(Tkh_Peringatan_2) Then
            values += "Tkh_Peringatan_2 = @Tkh_Peringatan_2,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Peringatan_2", Tkh_Peringatan_2))
        End If

        If Not String.IsNullOrEmpty(Tkh_Peringatan_3) Then
            values += "Tkh_Peringatan_3 = @Tkh_Peringatan_3,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Peringatan_3", Tkh_Peringatan_3))
        End If

        If Not String.IsNullOrEmpty(Tkh_Lulus) Then
            values += "Tkh_Lulus = @Tkh_Lulus,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Lulus", Tkh_Lulus))
        End If

        If Not String.IsNullOrEmpty(No_Staf_Lulus) Then
            values += "No_Staf_Lulus = @No_Staf_Lulus,"
            cmd.Parameters.Add(New SqlParameter("@No_Staf_Lulus", No_Staf_Lulus))
        End If

        If Not String.IsNullOrEmpty(Dok_Sokongan) Then
            values += "Dok_Sokongan = @Dok_Sokongan,"
            cmd.Parameters.Add(New SqlParameter("@Dok_Sokongan", Dok_Sokongan))
        End If

        If Not String.IsNullOrEmpty(Flag_Lulus) Then
            values += "Flag_Lulus = @Flag_Lulus,"
            cmd.Parameters.Add(New SqlParameter("@Flag_Lulus", Flag_Lulus))
        End If

        If Not String.IsNullOrEmpty(Status) Then
            values += "Status = @Status,"
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If

        If Not String.IsNullOrEmpty(No_Staf_Penyedia) Then
            values += "No_Staf_Penyedia = @No_Staf_Penyedia,"
            cmd.Parameters.Add(New SqlParameter("@No_Staf_Penyedia", No_Staf_Penyedia))
        End If

        If Not String.IsNullOrEmpty(Tkh_Bil) Then
            values += "Tkh_Bil = @Tkh_Bil,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Bil", Tkh_Bil))
        End If

        If Not String.IsNullOrEmpty(Kod_Penaja) Then
            values += "Kod_Penaja = @Kod_Penaja,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Penaja", Kod_Penaja))
        End If
        If Not String.IsNullOrEmpty(values) Then
            values = values.Substring(0, values.Length - 1) 'remove extra ,

        End If
        ' Construct the final SQL command
        cmd.CommandText = sql + values + " WHERE No_Bil = @No_Bil"
        cmd.Parameters.Add(New SqlParameter("@No_Bil", No_Bil))

        Return cmd
    End Function
End Class

Public Class Bil_Adj
    Public Property No_Pelarasan As String
    Public Property No_Bil As String
    Public Property Tkh_Pelarasan As String
    Public Property Ulasan As String
    Public Property Jumlah_Besar As String
    Public Property Bil_Pel As String
    Public Property Tujuan As String
    Public Property Jumlah_Blm_Byr As String
    Public Property Jumlah_Cukai As String
    Public Property Jumlah_Diskaun As String
    Public Property Kod_Status_Dok As String
    Public Property Status As String
    Public Property Petunjuk As String
    Public Property Kod_Penghutang As String
    Public Property details As List(Of Bil_Adj_Dtl)

    Public Function InsertCommand() As SqlCommand
        If No_Pelarasan Is Nothing Then
            Throw New Exception("No Pelarasan tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String
        sql = "INSERT INTO SMKB_Bil_Adj_Hdr (No_Pelarasan,No_Bil"
        values = "(@No_Pelarasan,@No_Bil"
        cmd.Parameters.Add(New SqlParameter("@No_Pelarasan", No_Pelarasan))
        cmd.Parameters.Add(New SqlParameter("@No_Bil", No_Bil))
        'If Tkh_Pelarasan IsNot Nothing Then
        '    sql += ", Tkh_Pelarasan"
        '    values += ", @Tkh_Pelarasan"
        '    cmd.Parameters.Add(New SqlParameter("@Tkh_Pelarasan", Tkh_Pelarasan))
        'End If

        If Ulasan IsNot Nothing Then
            sql += ", Ulasan"
            values += ", @Ulasan"
            cmd.Parameters.Add(New SqlParameter("@Ulasan", Ulasan))
        End If

        If Jumlah_Besar IsNot Nothing Then
            sql += ", Jumlah_Besar"
            values += ", @Jumlah_Besar"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Besar", Jumlah_Besar))
        End If
        If Bil_Pel IsNot Nothing Then
            sql += ", Bil_Pel"
            values += ", @Bil_Pel"
            cmd.Parameters.Add(New SqlParameter("@Bil_Pel", Bil_Pel))
        End If

        If Tujuan IsNot Nothing Then
            sql += ", Tujuan"
            values += ", @Tujuan"
            cmd.Parameters.Add(New SqlParameter("@Tujuan", Tujuan))
        End If

        If Jumlah_Blm_Byr IsNot Nothing Then
            sql += ", Jumlah_Blm_Byr"
            values += ", @Jumlah_Blm_Byr"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Blm_Byr", Jumlah_Blm_Byr))
        End If

        If Jumlah_Cukai IsNot Nothing Then
            sql += ", Jumlah_Cukai"
            values += ", @Jumlah_Cukai"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Cukai", Jumlah_Cukai))
        End If

        If Jumlah_Diskaun IsNot Nothing Then
            sql += ", Jumlah_Diskaun"
            values += ", @Jumlah_Diskaun"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Diskaun", Jumlah_Diskaun))
        End If

        If Kod_Status_Dok IsNot Nothing Then
            sql += ", Kod_Status_Dok"
            values += ", @Kod_Status_Dok"
            cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Kod_Status_Dok))
        End If

        If Status IsNot Nothing Then
            sql += ", Status"
            values += ", @Status"
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If

        ' Construct the final SQL command
        cmd.CommandText = sql + ") VALUES " + values + ")"

        Return cmd
    End Function
    Public Function updateCommand() As SqlCommand
        If String.IsNullOrEmpty(No_Pelarasan) Then
            Throw New Exception("No Pelarasan tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String = ""
        sql = "UPDATE SMKB_Bil_Adj_Hdr SET "

        If Not String.IsNullOrEmpty(Tkh_Pelarasan) Then
            values += "Tkh_Pelarasan = @Tkh_Pelarasan,"
            cmd.Parameters.Add(New SqlParameter("@Tkh_Pelarasan", Tkh_Pelarasan))
        End If

        If Not String.IsNullOrEmpty(Ulasan) Then
            values += "Ulasan = @Ulasan,"
            cmd.Parameters.Add(New SqlParameter("@Ulasan", Ulasan))
        End If

        If Not String.IsNullOrEmpty(Jumlah_Besar) Then
            values += "Jumlah_Besar = @Jumlah_Besar,"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Besar", Jumlah_Besar))
        End If

        If Not String.IsNullOrEmpty(Bil_Pel) Then
            values += "Bil_Pel = @Bil_Pel,"
            cmd.Parameters.Add(New SqlParameter("@Bil_Pel", Bil_Pel))
        End If

        If Not String.IsNullOrEmpty(Tujuan) Then
            values += "Tujuan = @Tujuan,"
            cmd.Parameters.Add(New SqlParameter("@Tujuan", Tujuan))
        End If

        If Not String.IsNullOrEmpty(Jumlah_Blm_Byr) Then
            values += "Jumlah_Blm_Byr = @Jumlah_Blm_Byr,"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Blm_Byr", Jumlah_Blm_Byr))
        End If

        If Not String.IsNullOrEmpty(Jumlah_Cukai) Then
            values += "Jumlah_Cukai = @Jumlah_Cukai,"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Cukai", Jumlah_Cukai))
        End If

        If Not String.IsNullOrEmpty(Jumlah_Diskaun) Then
            values += "Jumlah_Diskaun = @Jumlah_Diskaun,"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Diskaun", Jumlah_Diskaun))
        End If

        If Not String.IsNullOrEmpty(Kod_Status_Dok) Then
            values += "Kod_Status_Dok = @Kod_Status_Dok,"
            cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Kod_Status_Dok))
        End If

        If Not String.IsNullOrEmpty(Status) Then
            values += "Status = @Status,"
            cmd.Parameters.Add(New SqlParameter("@Status", Status))
        End If


        If Not String.IsNullOrEmpty(values) Then
            values = values.Substring(0, values.Length - 1) 'remove extra ,

        End If
        ' Construct the final SQL command
        cmd.CommandText = sql + values + " WHERE No_Pelarasan = @No_Pelarasan"
        cmd.Parameters.Add(New SqlParameter("@No_Pelarasan", No_Pelarasan))

        Return cmd
    End Function
End Class
