Imports System.Data.SqlClient
Public Class Individu
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'Me.lblNoStaf.Text = Session("ssusrID")

        End If
    End Sub

End Class