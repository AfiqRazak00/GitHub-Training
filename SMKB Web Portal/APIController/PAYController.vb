Imports System.Net
Imports System.Net.Http.Headers
Imports System.Web.Http

<RoutePrefix("api/PAY")>
Public Class PAYController
    Inherits ApiController

    ' POST api/products
    <HttpPost>
    Public Function Add_Order_Payroll(<FromBody> ByVal order As PAY_Order) As IHttpActionResult
        Dim headers As HttpHeaders = Request.Headers

        If order Is Nothing Then
            Return BadRequest("Invalid product data")
        End If

        order.Kod_Korporat = "UTeM"
        order.Penerima = "PAY"
        order.Status = 1

        Dim query As New Query
        query.userId = headers.GetValues("UID").FirstOrDefault()

        Try
            'generate id
            order.No_Order = SharedModulePembayaran.generateRunningNumberNoPTJ("08", "IPAY", "")


            If Not query.execute(order.No_Order, "No_Order", order.InsertCommand()) > 0 Then
                Throw New Exception("Failed to insert GL Order header")
            End If
            Dim count As Integer = 1
            For Each dtl As PAY_Order_Dtl In order.details
                dtl.No_Order = order.No_Order
                dtl.No_Item = count
                dtl.Status = 1

                Dim id As New Dictionary(Of String, String)
                id.Add("No_Order", dtl.No_Order)
                id.Add("No_Item", dtl.No_Item)
                If Not query.execute(id, dtl.InsertCommand()) > 0 Then
                    Throw New Exception("Failed to insert order bil details")
                End If
                count = count + 1
            Next

            query.finish()

            Return Ok("Saved")

        Catch ex As Exception
            query.rollback()

            'RETURN ERROR
            Return InternalServerError(ex)
        End Try


    End Function
End Class
