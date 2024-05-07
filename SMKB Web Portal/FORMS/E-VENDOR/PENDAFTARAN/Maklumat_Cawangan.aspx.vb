Public Class Maklumat_Cawangan
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Class MklmtCawangan
        Public Property IdSya As String
        Public Property IdCaw As String
        Public Property NamaCaw As String
        Public Property Kodbank As String
        Public Property NoAkaun As String
        'Public Property Almt1 As String
        'Public Property Almt2 As String
        'Public Property Poskod As String
        'Public Property Bandar As String
        'Public Property Negeri As String
        'Public Property Negara As String
        'Public Property Web As String
        'Public Property Email As String
        'Public Property NoTel1 As String
        'Public Property NoTel2 As String
        'Public Property NoFax As String
        'Public Property IdPeg1 As String
        'Public Property IdPeg2 As String
        'Public Property KatPegawai1 As String
        'Public Property KatPegawai2 As String
        'Public Property NamaPeg1 As String
        'Public Property JwtPeg1 As String
        'Public Property EmailPeg1 As String
        'Public Property NoTelPeg1 As String
        'Public Property NoTelPejPeg1 As String
        'Public Property NamaPeg2 As String
        'Public Property JwtPeg2 As String
        'Public Property EmailPeg2 As String
        'Public Property NoTelPeg2 As String
        'Public Property NoTelPejPeg2 As String
        Public Property AlmtCaw As List(Of AlmtSyarikat)
        Public Property ListFile As List(Of MklmtFile)
        Public Property ListPegawai As List(Of MklmtSyaPegawai)

        Public Sub New()
            AlmtCaw = New List(Of AlmtSyarikat)
            ListFile = New List(Of MklmtFile)
            ListPegawai = New List(Of MklmtSyaPegawai)
        End Sub
    End Class
End Class