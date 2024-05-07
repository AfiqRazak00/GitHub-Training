Imports System.Data.Entity.Core.Metadata.Edm
Imports System.Data.SqlClient
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Web.Services
Imports Newtonsoft.Json

Public Class PertanyaanPinjamanIndividu
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

End Class

Public Class PertanyaanIndividuInsertDetail
    Public Property setujuPengesahan As String
    Public Property tarikhPengesahan As String
    Public Property tarikhmesyuaratPengesahan As String
    Public Property skimPengesahan As String
    Public Property tempatPengesahan As String
    Public Property filePengesahan As String
    Public Property tempohPengesahan As String
    Public Property bilPengesahan As String
    Public Property nopinjamanPengesahan As String
    Public Property emailPengesahan As String
    Public Property namaPengesahan As String
    Public Property nopinjPengesahan As String
    Public Property namapinjPengesahan As String
    Public Property amaunPengesahan As String
    Public Property butiranPengesahan As String
    Public Property kategoriPengesahan As String
    Public Property jenisPengesahan As String
    Public Property confirmPengesahan As String
    Public Property nofailrujukanPengesahan As String
    Public Property novotPengesahan As String
    Public Property ptjPengesahan As String
    Public Property kumpulanwangPengesahan As String
    Public Property operasiPengesahan As String
    Public Property projekPengesahan As String
    Public Property kodpemiutangPengesahan As String

    Public Sub New()
    End Sub
    Public Sub New(setujuPengesahan_ As String, tarikhPengesahan_ As String, tarikhmesyuaratPengesahan_ As String, emailPengesahan_ As String, namaPengesahan_ As String, nopinjPengesahan_ As String, namapinjPengesahan_ As String, amaunPengesahan_ As String, kategoriPengesahan_ As String, jenisPengesahan_ As String, skimPengesahan_ As String, tempatPengesahan_ As String, filePengesahan_ As String, tempohPengesahan_ As String, bilPengesahan_ As String, nopinjamanPengesahan_ As String, confirmPengesahan_ As String, NofailrujukanPengesahan_ As String, novotPengesahan_ As String, ptjPengesahan_ As String, kumpulanwangPengesahan_ As String, operasiPengesahan_ As String, projekPengesahan_ As String, kodpemiutangPengesahan_ As String)
        setujuPengesahan = setujuPengesahan_
        tarikhPengesahan = tarikhPengesahan_
        emailPengesahan = emailPengesahan_
        namaPengesahan = namaPengesahan_
        nopinjPengesahan = nopinjPengesahan_
        namapinjPengesahan = namapinjPengesahan_
        amaunPengesahan = amaunPengesahan_
        kategoriPengesahan = kategoriPengesahan_
        jenisPengesahan = jenisPengesahan_
        skimPengesahan = skimPengesahan_
        tempatPengesahan = tempatPengesahan_
        filePengesahan = filePengesahan_
        tempohPengesahan = tempohPengesahan_
        bilPengesahan = bilPengesahan_
        nopinjamanPengesahan = nopinjamanPengesahan_
        confirmPengesahan = confirmPengesahan_
        nofailrujukanPengesahan = NofailrujukanPengesahan_
        tarikhmesyuaratPengesahan = tarikhmesyuaratPengesahan_
        novotPengesahan = novotPengesahan_
        ptjPengesahan = ptjPengesahan_
        kumpulanwangPengesahan = kumpulanwangPengesahan_
        operasiPengesahan = operasiPengesahan_
        projekPengesahan = projekPengesahan_
        kodpemiutangPengesahan = kodpemiutangPengesahan_
    End Sub
End Class
