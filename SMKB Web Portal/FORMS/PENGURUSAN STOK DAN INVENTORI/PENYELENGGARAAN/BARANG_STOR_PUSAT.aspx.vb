Public Class webform3
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class BarangStorInsertDetail
    Public Property kategoriStorPengesahan As String
    Public Property pejabatLokasiPengesahan As String
    Public Property kategoriBarangPengesahan As String
    Public Property senaraiBarangPengesahan As String
    Public Property takatMinimaPengesahan As String
    Public Property takatMaksimaPengesahan As String
    Public Property takatMenokokPengesahan As String
    Public Property pejabatLokasiDetailPengesahan As String
    Public Property kodLokasiPengesahan As String
    Public Property statusPengesahan As String

    Public Sub New()
    End Sub
    Public Sub New(kategoriStorPengesahan_ As String, pejabatLokasiPengesahan_ As String, kategoriBarangPengesahan_ As String, senaraiBarangPengesahan_ As String, takatMinimaPengesahan_ As String, takatMaksimaPengesahan_ As String, takatMenokokPengesahan_ As String, pejabatLokasiDetailPengesahan_ As String, kodLokasiPengesahan_ As String, statusPengesahan_ As String)
        kategoriStorPengesahan = kategoriStorPengesahan_
        pejabatLokasiPengesahan = pejabatLokasiPengesahan_
        kategoriBarangPengesahan = kategoriBarangPengesahan_
        senaraiBarangPengesahan = senaraiBarangPengesahan_
        takatMinimaPengesahan = takatMinimaPengesahan_
        takatMaksimaPengesahan = takatMaksimaPengesahan_
        takatMenokokPengesahan = takatMenokokPengesahan_
        pejabatLokasiDetailPengesahan = pejabatLokasiDetailPengesahan_
        kodLokasiPengesahan = kodLokasiPengesahan_
        statusPengesahan = statusPengesahan_
    End Sub
End Class