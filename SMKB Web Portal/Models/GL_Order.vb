﻿Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Net.Http.Headers
Imports System.Threading
Public Class GL_Order
    Public Property Kod_Transaksi As String
    Public Property No_Rujukan As String
    Public Property No_Order As String
    Public Property Kod_Korporat As String
    Public Property Tkh_Transaksi As String
    Public Property Pengirim As String
    Public Property Pengirim_Mohon As String
    Public Property Penerima As String
    Public Property Penerima_Mohon As String
    Public Property Jumlah_Keseluruhan As String
    Public Property Jumlah_Item As String
    Public Property Status As String
    Public Property details As List(Of GL_Order_Dtl)

    Public Function InsertCommand() As SqlCommand
        If No_Order Is Nothing Then
            Throw New Exception("No Order tidak sah")
        End If

        Dim cmd As New SqlCommand
        Dim sql As String
        Dim values As String
        sql = "INSERT INTO GL_Order_Hdr (Kod_Transaksi,No_Rujukan,No_Order,Kod_Korporat,Tkh_Transaksi"
        values = "(@Kod_Transaksi,@No_Rujukan,@No_Order,@Kod_Korporat,getdate()"
        cmd.Parameters.Add(New SqlParameter("@Kod_Transaksi", Kod_Transaksi))
        cmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        cmd.Parameters.Add(New SqlParameter("@No_Order", No_Order))
        cmd.Parameters.Add(New SqlParameter("@Kod_Korporat", Kod_Korporat))

        If Pengirim IsNot Nothing Then
            sql += ", Pengirim"
            values += ", @Pengirim"
            cmd.Parameters.Add(New SqlParameter("@Pengirim", Pengirim))
        End If

        If Pengirim_Mohon IsNot Nothing Then
            sql += ", Pengirim_Mohon"
            values += ", @Pengirim_Mohon"
            cmd.Parameters.Add(New SqlParameter("@Pengirim_Mohon", Pengirim_Mohon))
        End If
        If Penerima IsNot Nothing Then
            sql += ", Penerima"
            values += ", @Penerima"
            cmd.Parameters.Add(New SqlParameter("@Penerima", Penerima))
        End If

        If Penerima_Mohon IsNot Nothing Then
            sql += ", Penerima_Mohon"
            values += ", @Penerima_Mohon"
            cmd.Parameters.Add(New SqlParameter("@Penerima_Mohon", Penerima_Mohon))
        End If

        If Jumlah_Keseluruhan IsNot Nothing Then
            sql += ", Jumlah_Keseluruhan"
            values += ", @Jumlah_Keseluruhan"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Keseluruhan", Jumlah_Keseluruhan))
        End If

        If Jumlah_Item IsNot Nothing Then
            sql += ", Jumlah_Item"
            values += ", @Jumlah_Item"
            cmd.Parameters.Add(New SqlParameter("@Jumlah_Item", Jumlah_Item))
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
End Class