Imports System
Imports System.Data.SqlClient
Imports System.IO
Imports System.Text
'Imports System.Data.SqlClient

Partial Class CetakJadualBayarBalik
    Inherits System.Web.UI.Page

    Public dsMaklumatKorporat As New DataSet
    Public dvMaklumatKorporat As New DataView
    Dim dbconn As New DBKewConn

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not IsPostBack Then

            Dim script As New StringBuilder()
            script.AppendLine("<script type='text/javascript'>")
            script.AppendLine("window.onload = function() {")
            script.AppendLine("    setTimeout(function() {")
            script.AppendLine("        window.print();")
            script.AppendLine("        window.onafterprint = function() { window.close(); };")
            script.AppendLine("    }, 100);")
            script.AppendLine("};")
            script.AppendLine("</script>")

            ClientScript.RegisterStartupScript(Me.GetType(), "Print", script.ToString(), False)

        End If
    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        ' Retrieve the content from the session variable and display it
        Dim content As String = TryCast(Session("PrintContent"), String)
        'lblContent.Text = content
    End Sub
    Function ConvertFileToBinary(ByVal fileStream As Stream) As Byte()
        ' Convert the file to binary data
        Using binaryReader As New BinaryReader(fileStream)
            Return binaryReader.ReadBytes(CInt(fileStream.Length))
        End Using
    End Function
End Class

