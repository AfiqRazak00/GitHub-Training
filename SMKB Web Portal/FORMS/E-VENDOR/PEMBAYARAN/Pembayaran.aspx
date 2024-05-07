<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pembayaran.aspx.vb" Inherits="SMKB_Web_Portal.Pembayaran" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
        .circle-icon {
            font-size: 50px;
            color: #28a745; /* Green color */
        }

        .center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 50vh;
        }
    </style>

    <div id="permohonan" class="tabcontent" style="display: block;">
        <div class="tab-content m-4">
            <asp:MultiView ID="mvSyarikat" runat="server" ActiveViewIndex="0">
                <div class="col-md-12">
                    <asp:View ID="View7" runat="server">
                        <div class="panel panel-default">
                            <div class="row" runat="server" visible="false" id="divStatusBayar">
                                <%--<table class="table table-borderless table-striped">
                                    <tr>
                                        <th style="width: 20%; text-align: center" colspan="2">Status Pembayaran Terkini</th>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">Status Pembayaran</td>
                                        <td>
                                            <asp:Label ID="lblStatusBayar" runat="server" CssClass="form-control" Width="150px" BackColor="#FFFFCC"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">Tahun Aktif</td>
                                        <td>
                                            <asp:Label ID="lblThnAktif" runat="server" CssClass="form-control" Width="80px" BackColor="#FFFFCC"></asp:Label></td>
                                    </tr>
                                </table>--%>

                                <div class="container">
                                    <div class="row center">
                                        <div class="col-md-4 text-center">
                                            <div class="text-center" runat="server" id="divStatusIcon"></div>
                                            <%--<i class="fas fa-check-circle circle-icon"></i>--%>

                                            <%--<p class="mt-3" ID="MsgStatus">Pembayaran Berjaya!</p>--%>
                                            <asp:Label ID="MsgStatusBayar" class="mt-4" runat="server"></asp:Label>
                                            <p class="mt-1" ID="">Terima Kasih!</p>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="row" runat="server" visible="false" id="divBayar">
                                <h3>Pembayaran Melalui MIGS </h3>
                                <p></p>
                                <iframe runat="server" scrolling="auto" id="frame1" name="frame1" frameborder="0" style="width: 98%; height: 800px; display: inline"></iframe>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="row" style="text-align: center">
                            <asp:LinkButton ID="lbtnPrevPembayaran" runat="server" CssClass="btn btn-default btn-circle btn-lg" ToolTip="Sebelumnya">
                                <i class="glyphicon glyphicon-chevron-left"></i>
                            </asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="lbtnNextPembayaran" runat="server" CssClass="btn btn-default btn-circle btn-lg" ToolTip="Seterusnya">
                            <i class="glyphicon glyphicon-chevron-right"></i>
                </asp:LinkButton>
                        </div>
                    </asp:View>
                </div>
            </asp:MultiView>
        </div>
    </div>

    <!-- Makluman Modal -->
    <div class="modal fade" id="maklumanModal" tabindex="-1" role="dialog"
        aria-labelledby="maklumanModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="maklumanModalLabel">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <span id="detailMakluman"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="tutupMakluman"
                        data-dismiss="modal">
                        Tutup</button>
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript">

</script>

</asp:Content>
