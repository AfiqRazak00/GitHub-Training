Imports System.Web.Services
Imports Newtonsoft.Json

Imports System.Net
Imports System.Net.Mail
Imports System.Web.Configuration

Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports clsMail
Imports System.Reflection


Public Class KPT
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Class HantarPerolehan_Mesyuarat_Detail
        Public Property txtNoMohonH As String
        Public Property txtIDMesyH As String
        Public Property txtUlasanH As String
        Public Property txtStatusDokH As String
        Public Property txtFlag_PenentuanTeknikal As String

    End Class

    Public Class UpdateStatusHantar_Dt
        Public Property txtNoMohonH As String
        Public Property txtStatusDokH As String

    End Class


End Class

