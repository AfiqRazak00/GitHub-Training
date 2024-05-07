Public Class SST_Print
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class SST
    Public Property idPembelian As String
    Public Property txtTujuan As String
    Public Property txtTujuanDisplay As String
    Public Property noMohonValue As String
    Public Property noSebutHarga As String
    Public Property totalHarga As String

    Public Sub New()
    End Sub
    Public Sub New(idPembelian_ As String, txtTujuan_ As String, txtTujuanDisplay_ As String, noMohonValue_ As String, noSebutHarga_ As String, totalHarga_ As String)

        idPembelian = idPembelian_
        txtTujuan = txtTujuan_
        txtTujuanDisplay = txtTujuanDisplay_
        noSebutHarga = noSebutHarga_
        totalHarga = totalHarga_

    End Sub

End Class