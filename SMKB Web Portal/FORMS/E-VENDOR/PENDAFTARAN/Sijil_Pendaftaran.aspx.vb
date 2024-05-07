Public Class Sijil_Pendaftaran
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
End Class

Public Class MklmtSijil
    Public Property IdDaftar As String
    Public Property IdSya As String
    Public Property KodDaftar As String
    Public Property NoDaftar As String
    Public Property TkhMula As String
    Public Property TkhTamat As String

    Public Property SijilBumi As MklmtTarafBumi
    Public Property ListFile As List(Of MklmtFile)

    Public Sub New()
        ListFile = New List(Of MklmtFile)
    End Sub
End Class

Public Class MKlmtBidangMOF
    Public Property NoDaftar As String
    Public Property Bil As String
    Public Property KodBidang As String

    Public Sub New()

    End Sub
End Class

Public Class MklmtPicMof
    Public Property IdSya As String
    Public Property Gelaran As String
    Public Property NamaPegMof As String
    Public Property NoICPegMof As String
    Public Property JawatanMof As String
    Public Property NoTelPegMof As String
    Public Property IdRujukan As String
End Class

Public Class MklmtPicCIDB
    Public Property IdSya As String
    Public Property Gelaran As String
    Public Property NamaPeg As String
    Public Property NoICPeg As String
    Public Property Jawatan As String
    Public Property NoTelPeg As String
    Public Property IdRujukan As String
End Class

Public Class MklmtTarafBumi
    Public Property IdDaftar As String
    Public Property IdSya As String
    Public Property StatBumi As String
    Public Property NoDaftar As String
    Public Property TkhMula As String
    Public Property TkhTamat As String
    Public Property ListFile As List(Of MklmtFile)

    Public Sub New()
        ListFile = New List(Of MklmtFile)
    End Sub
End Class

Public Class MklmtKatCIDB
    Public Property NoDaftar As String
    Public Property Bil As String
    Public Property KodKategori As String
    Public Property KodKhusus As String
    Public Property KodGred As String
End Class