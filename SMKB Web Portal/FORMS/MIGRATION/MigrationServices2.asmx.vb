Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Web.Script.Services
Imports System.Threading
Imports System.EnterpriseServices

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class MigrationServices2
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Function TestFunction(id As String) As String
        Return "test"
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function TransferData(kodbank As String, bulan As String, tahun As String) As Tasks.Task(Of String)
        Try
            Dim myGetTicket As New TokenResponseModel()
            Dim servicex As New ValuesService()
            'Dim values As String = Await servicex.migrateTransBank(myGetTicket.GetTicket("smkb", HttpContext.Current.Session("ssusrID")), kodbank, bulan, tahun)
            servicex.migrateTransBank(myGetTicket.GetTicket("smkb", HttpContext.Current.Session("ssusrID")), kodbank, bulan, tahun)
            Return "Transfer Berjaya. <br>"
            'lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception
            Return "Ralat."
            'lblModalMessaage.Text = "Ralat."
            'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Function

    <WebMethod(EnableSession:=True)>
    <ScriptMethod(UseHttpGet:=False, ResponseFormat:=ResponseFormat.Json)>
    Public Async Function GetTotalTransfer(ByVal kodbank As String, ByVal bulan As String, ByVal tahun As String) As Tasks.Task(Of String)
        Try
            Dim myGetTicket As New TokenResponseModel()

            Dim servicex As New ValuesService()
            Dim arrValues As String() = Await servicex.getTotalTransfer(myGetTicket.GetTicket("smkb", HttpContext.Current.Session("ssusrID")), kodbank, bulan, tahun)

            If (arrValues(0) <> "200") Then
                Exit Function
            End If

            Dim percent As Decimal = (CDbl(arrValues(1)) / CDbl(arrValues(2))) * 100

            Return percent
            'lblModalMessaage.Text = "Transfer Berjaya. <br>" & values
            'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        Catch ex As Exception
            Return "Ralat."
            'lblModalMessaage.Text = "Ralat."
            'ClientScript.RegisterStartupScript([GetType](), "alert", "SaveSucces();", True)
        End Try
    End Function

End Class