Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class Semakan_Bajet
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class



Public Class PermohonanReviewBajet_PTJ_Komitmen
    Public Property tahun As String
    Public Property PTJ As String
    Public Property KW As String
    Public Property KO As String
    Public Property ObjSbg As String
    Public Property Justifikasi As String
    Public Property Komitmen As String

    Public Sub New()
    End Sub

    Public Sub New(tahun_ As String, PTJ_ As String, KW_ As String, KO_ As String, ObjSbg_ As String, Justifikasi_ As String, Komitmen_ As String)
        tahun = tahun_
        PTJ = PTJ_
        KW = KW_
        KO = KO_
        ObjSbg = ObjSbg_
        Justifikasi = Justifikasi_
        Komitmen = Komitmen_
    End Sub


End Class