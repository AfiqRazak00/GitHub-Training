
Imports System.Data.SqlClient
Imports System.Net.Http.Headers

Public Class OrderBil

    Public Property No_Dokumen As String
    Public Property Tahun As String
    Public Property Kod_Sesi As String
    Public Property Tkh_Mohon As String
    Public Property Jenis As String
    Public Property Kod_PTJ_Mohon As String
    Public Property No_Staf As String
    Public Property Utk_Perhatian As String
    Public Property No_Rujukan As String
    Public Property Jumlah As Double
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
    Public Property Flag_Terima As String
    Public Property Sender As String
    Public Property Receiver As String
    Public Property details As List(Of OrderBilDtl)

    Public Function insertCommand() As SqlCommand
        Dim cmd As New SqlCommand
        cmd.CommandText = "INSERT INTO SMP_Bil_Order_Hdr (No_Dokumen,Tahun,Kod_Sesi,Tkh_Mohon,No_Staf,No_Rujukan,Jumlah,Kod_Status_Dok,Kod_Urusniaga,Kategori,Kod_Penghutang,
                                Tujuan,Status,No_Staf_Penyedia,Tkh_Bil,Kod_Penaja,Sender,Receiver) VALUES 
                            (@No_Dokumen,@Tahun,@Kod_Sesi,getdate(),@No_Staf,@No_Rujukan,@Jumlah,@Kod_Status_Dok,@Kod_Urusniaga,@Kategori,@Kod_Penghutang,
                                @Tujuan,@Status,@No_Staf_Penyedia,getdate(),@Kod_Penaja,@Sender,@Receiver)"
        cmd.Parameters.Add(New SqlParameter("@No_Dokumen", No_Dokumen))
        cmd.Parameters.Add(New SqlParameter("@Tahun", Tahun))
        cmd.Parameters.Add(New SqlParameter("@Kod_Sesi", Kod_Sesi))
        ' cmd.Parameters.Add(New SqlParameter("@Tkh_Mohon", Tkh_Mohon))
        cmd.Parameters.Add(New SqlParameter("@No_Staf", No_Staf))
        cmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        cmd.Parameters.Add(New SqlParameter("@Jumlah", Jumlah))
        cmd.Parameters.Add(New SqlParameter("@Kod_Status_Dok", Kod_Status_Dok))
        cmd.Parameters.Add(New SqlParameter("@Kod_Urusniaga", Kod_Urusniaga))
        cmd.Parameters.Add(New SqlParameter("@Kategori", Kategori))
        cmd.Parameters.Add(New SqlParameter("@Kod_Penghutang", Kod_Penghutang))
        cmd.Parameters.Add(New SqlParameter("@Tujuan", Tujuan))
        cmd.Parameters.Add(New SqlParameter("@Status", Status))
        cmd.Parameters.Add(New SqlParameter("@No_Staf_Penyedia", No_Staf_Penyedia))
        '  cmd.Parameters.Add(New SqlParameter("@Tkh_Bil", Tkh_Bil))
        cmd.Parameters.Add(New SqlParameter("@Kod_Penaja", Kod_Penaja))
        cmd.Parameters.Add(New SqlParameter("@Sender", Sender))
        cmd.Parameters.Add(New SqlParameter("@Receiver", Receiver))
        Return cmd
    End Function


End Class
