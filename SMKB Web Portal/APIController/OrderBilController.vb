Imports System.Net
Imports System.Net.Http.Headers
Imports System.Web.Http
Imports Newtonsoft.Json

<RoutePrefix("api/OrderBil")>
Public Class OrderBilController
    Inherits ApiController

    ' POST api/products
    <HttpPost>
    Public Function addBil(<FromBody> ByVal order As OrderBil) As IHttpActionResult
        Dim headers As HttpHeaders = Request.Headers

        If order Is Nothing Then
            Return BadRequest("Invalid product data")
        End If

        order.Kod_Status_Dok = 3
        order.Kod_Urusniaga = 12
        order.Status = 1
        order.Receiver = "AR"

        Dim query As New Query
        query.userId = headers.GetValues("UID").FirstOrDefault()

        Try
            'generate no dokumen, ptj user get from where? session? not suitable. token? 
            order.No_Dokumen = SharedModulePembayaran.generateRunningNumberNoPTJ("12", "AR", "")


            If Not query.execute(order.No_Dokumen, "No_Dokumen", order.insertCommand()) > 0 Then
                Throw New Exception("Failed to insert order bil header")
            End If
            Dim count As Integer = 1
            For Each dtl As OrderBilDtl In order.details
                dtl.No_Bil = order.No_Dokumen
                dtl.No_Item = count
                dtl.Status = 1

                Dim id As New Dictionary(Of String, String)
                id.Add("No_Bil", dtl.No_Bil)
                id.Add("No_Item", dtl.No_Item)
                If Not query.execute(id, dtl.insertCommand()) > 0 Then
                    Throw New Exception("Failed to insert order bil details")
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