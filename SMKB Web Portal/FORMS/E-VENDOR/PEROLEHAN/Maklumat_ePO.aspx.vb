Public Class Maklumat_ePO
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class MklmtPO
    Public Property IdPembelian As String
    Public Property BilTempoh As Integer
    Public Property JenTempoh As String
End Class

Public Class MklmtPengesahan
    Public Property IdSya As String
    Public Property IdPembelian As String
    Public Property KodDokumen As String
    Public Property KodBuku As String
    Public Property ValueSah As String

End Class

Public Class MklmtPengesahanKatalog
    Public Property IdSya As String
    Public Property IdPembelian As String
    Public Property KodDokumen As String
    Public Property KodBuku As String
    Public Property ValueSah As String
    Public Property ListFile As List(Of MklmtFile)

    Public Sub New()
        ListFile = New List(Of MklmtFile)
    End Sub
End Class

Public Class MklmtJadual
    Public Property IdSya As String
    Public Property JadualDetail As List(Of JadualDetails)

    Public Sub New()
        JadualDetail = New List(Of JadualDetails)
    End Sub
End Class

Public Class JadualDetails
    Public Property IdDtl As String
    Public Property Jenama As String
    Public Property Model As String
    Public Property Negara As String
    Public Property Kuantiti As Integer
    Public Property HargaUnit As Double
    Public Property HargaUnitCukai As Double
    Public Property JumHarga As Double
    Public Property JumHargaCukai As Double
End Class

Public Class JawapanAm
    Public Property IdPembelian As String
    Public Property IdAm As DateTime
    Public Property JawapanAm As String
End Class

'Public Class JawapanAm
'    Public Property IdPembelian As String
'    Public Property JawapanAmDetail As List(Of JawapanAmDetails)

'    Public Sub New()
'        JawapanAmDetail = New List(Of JawapanAmDetails)
'    End Sub
'End Class

'Public Class JawapanAmDetails
'    Public Property IdAm As DateTime
'    Public Property JawapanAm As String

'End Class

Public Class JawapanTeknikal
    Public Property IdPembelian As String
    Public Property JawapanTeknikalDetail As List(Of JawapanTeknikalDetails)

    Public Sub New()
        JawapanTeknikalDetail = New List(Of JawapanTeknikalDetails)
    End Sub
End Class

Public Class JawapanTeknikalDetails
    Public Property IdTeknikal As DateTime
    Public Property JawapanTeknikal As String
    Public Property Sampel As String
    Public Property Katalog As String

End Class

Public Class JadualKerja
    Public Property IdPembelian As String
    Public Property ListFile As List(Of MklmtFile)

    Public Sub New()
        ListFile = New List(Of MklmtFile)
    End Sub
End Class

Public Class SijilBank
    Public Property IdPembelian As String
    Public Property ListFile As List(Of MklmtFile)

    Public Sub New()
        ListFile = New List(Of MklmtFile)
    End Sub
End Class

Public Class AuthorLetter
    Public Property IdPembelian As String
    Public Property ListFile As List(Of MklmtFile)

    Public Sub New()
        ListFile = New List(Of MklmtFile)
    End Sub
End Class

Public Class DelKatalog
    Public Property IdPembelian As String
    Public Property IdTeknikal As String
End Class

