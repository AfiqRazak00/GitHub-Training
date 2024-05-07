Imports System.Net
Imports System.Net.Http.Headers
Imports System.Web.Http
Imports Newtonsoft.Json

<RoutePrefix("api/AP")>
Public Class APController
    Inherits ApiController

    ' POST api/products
    <HttpPost>
    Public Function Add_Order_Invois(<FromBody> ByVal order As AP_Order) As IHttpActionResult
        Dim headers As HttpHeaders = Request.Headers

        If order Is Nothing Then
            Return BadRequest("Invalid product data")
        End If

        order.Kod_Korporat = "UTeM"
        order.Penerima = "AP"
        order.Status = 1

        Dim query As New Query
        query.userId = headers.GetValues("UID").FirstOrDefault()

        Try
            'generate id
            order.No_Order = SharedModulePembayaran.generateRunningNumberNoPTJ("03", "IAP", "")


            If Not query.execute(order.No_Order, "No_Order", order.InsertCommand()) > 0 Then
                Throw New Exception("Failed to insert AP Order header")
            End If
            Dim count As Integer = 1
            For Each dtl As AP_Order_Dtl In order.details
                dtl.No_Order = order.No_Order
                dtl.No_Item = count
                dtl.Status = 1

                Dim id As New Dictionary(Of String, String)
                id.Add("No_Order", dtl.No_Order)
                id.Add("No_Item", dtl.No_Item)
                If Not query.execute(id, dtl.insertCommand()) > 0 Then
                    Throw New Exception("Failed to insert AP Order details")
                End If
                count = count + 1
            Next

            query.finish()

            Return Ok("Saved")

        Catch ex As Exception
            query.rollback()

            'sepatutnye jgn tunjuk too detail error, save ke db only for review
            Return InternalServerError(ex)
        End Try


    End Function

End Class
