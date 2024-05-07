Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class tab3
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class


Public Class PermohonanPo
    Public Property nombor_mohon As String

    Public Sub New()
    End Sub


    Public Sub New(nombor_mohon_ As String)
        nombor_mohon = nombor_mohon_

    End Sub
End Class