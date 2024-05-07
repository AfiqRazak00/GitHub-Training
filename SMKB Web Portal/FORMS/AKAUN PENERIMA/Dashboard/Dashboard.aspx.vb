Public Class Dashboard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    ' Set the number for txtStatusDraf
    Private Sub txtStatusDraf_PreRender(sender As Object, e As EventArgs) Handles txtStatusDraf.PreRender

        Dim queryString As String = "
            SELECT COUNT(No_Bil) as count
            FROM SMKB_Bil_Hdr
            WHERE Kod_Status_Dok='01'"

        Dim db As New DBKewConn
        Dim result As DataTable = db.Read(queryString)

        Dim count As Integer = result.Rows(0)("count")

        txtStatusDraf.InnerText = count.ToString()

    End Sub

    ' Set the number for txtTungguKelulusan
    Private Sub txtTungguKelulusan_PreRender(sender As Object, e As EventArgs) Handles txtTungguKelulusan.PreRender

        Dim queryString As String = "
            SELECT COUNT(No_Bil) as count
            FROM SMKB_Bil_Hdr
            WHERE Kod_Status_Dok='02'"

        Dim db As New DBKewConn
        Dim result As DataTable = db.Read(queryString)

        Dim count As Integer = result.Rows(0)("count")

        txtTungguKelulusan.InnerText = count.ToString()

    End Sub

    ' Set the number for txtDiluluskan
    Private Sub txtDiluluskan_PreRender(sender As Object, e As EventArgs) Handles txtDiluluskan.PreRender

        Dim queryString As String = "
            SELECT COUNT(No_Bil) as count
            FROM SMKB_Bil_Hdr
            WHERE Kod_Status_Dok='03'"

        Dim db As New DBKewConn
        Dim result As DataTable = db.Read(queryString)

        Dim count As Integer = result.Rows(0)("count")

        txtDiluluskan.InnerText = count.ToString()

    End Sub

    ' Set the number for txtTerkumpul
    Private Sub txtTerkumpul_PreRender(sender As Object, e As EventArgs) Handles txtTerkumpul.PreRender

        Dim queryString As String = "
            SELECT COUNT(No_Bil) as count
            FROM SMKB_Bil_Hdr"

        Dim db As New DBKewConn
        Dim result As DataTable = db.Read(queryString)

        Dim count As Integer = result.Rows(0)("count")

        txtTerkumpul.InnerText = count.ToString()

    End Sub

    ' Set the number for txtTungguPembayaran
    Private Sub txtTungguPembayaran_PreRender(sender As Object, e As EventArgs) Handles txtTungguPembayaran.PreRender

        Dim queryString As String = "
            SELECT COUNT(No_Bil) as count
            FROM SMKB_Bil_Hdr
            WHERE Kod_Status_Dok='03'"

        Dim db As New DBKewConn
        Dim result As DataTable = db.Read(queryString)

        Dim count As Integer = result.Rows(0)("count")

        txtTungguPembayaran.InnerText = count.ToString()

    End Sub

    ' Set the number for txtTertunggak
    Private Sub txtTertunggak_PreRender(sender As Object, e As EventArgs) Handles txtTertunggak.PreRender

        Dim queryString As String = "
            SELECT SUM(Jumlah) as jumlah
            FROM SMKB_Bil_Hdr
            WHERE No_Bil NOT IN (SELECT No_Rujukan FROM SMKB_Terima_Hdr WHERE No_Rujukan <> 'NULL')
            AND Kod_Status_Dok = '03' AND Flag_Lulus='1'"

        Dim db As New DBKewConn
        Dim result As DataTable = db.Read(queryString)

        Dim count As Decimal = result.Rows(0)("jumlah")

        txtTertunggak.InnerText = count.ToString()

    End Sub

End Class