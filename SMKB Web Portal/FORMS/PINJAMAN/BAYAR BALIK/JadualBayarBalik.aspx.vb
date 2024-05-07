Imports Microsoft.AspNet.Identity
Imports System.Globalization
Imports System.Threading
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Collections.Specialized
Imports System.Reflection
Imports System
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Net.NetworkInformation
Imports System.Diagnostics.Eventing
Imports System.Runtime.InteropServices.ComTypes
Imports System.Drawing.Printing
Imports System.IO
'Imports iTextSharp.text
'Imports iTextSharp.text.html.simpleparser
'Imports iTextSharp.text.pdf

Public Class JadualBayarBalik
    Inherits System.Web.UI.Page

    Public dsTahapSkrin As New DataSet
    Public dvTahapSkrin As New DataView
    Dim dbconn As New DBKewConn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then


        End If
    End Sub

End Class