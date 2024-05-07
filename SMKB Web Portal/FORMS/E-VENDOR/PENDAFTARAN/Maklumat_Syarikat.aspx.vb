Public Class Maklumat_Syarikat
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class MklmtSyarikat
    Public Property NoSya As String
    Public Property IdSya As String
    Public Property IdCaw As String
    Public Property Bekalan As String
    Public Property Perkhidmatan As String
    Public Property Kerja As String
    Public Property KatSya As String
    Public Property KodBank As String
    Public Property NoAkaun As String
    Public Property AlmtSya As List(Of AlmtSyarikat)
    Public Property ListFile As List(Of MklmtFile)
    Public Property ListPegawai As List(Of MklmtSyaPegawai)

    Public Sub New()
        AlmtSya = New List(Of AlmtSyarikat)
        ListFile = New List(Of MklmtFile)
        ListPegawai = New List(Of MklmtSyaPegawai)
    End Sub

End Class

Public Class MklmtSyaPegawai
    Public Property IdPeg As String
    Public Property KatPegawai As String
    Public Property NoBil As String
    Public Property NamaPegawai As String
    Public Property JwtPegawai As String
    Public Property EmailPegawai As String
    Public Property NoTelPeg As String
    Public Property NoTelPejPeg As String

    Public Sub New()

    End Sub

End Class

Public Class AlmtSyarikat
    Public Property Almt1 As String
    Public Property Almt2 As String
    Public Property Bandar As String
    Public Property Poskod As String
    Public Property Negeri As String
    Public Property Negara As String
    Public Property Web As String
    Public Property EmailSya As String
    Public Property TelBimbitSya As String
    Public Property TelPejSya As String
    Public Property NoFaxSya As String
End Class

Public Class MklmtFile
    'Public Property IdDok As String
    Public Property IdSya As String
    Public Property NoRujukan As String
    Public Property JenDok As String
    Public Property FileName As String
    Public Property Bil As String
    Public Property filePath As String
    Public Property JenFile As String

    Public Sub New()

    End Sub

End Class