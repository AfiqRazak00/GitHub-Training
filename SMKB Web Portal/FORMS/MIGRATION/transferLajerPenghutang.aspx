<%@ Page Title="" Language="vb" AutoEventWireup="false" Async="true" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="transferLajerPenghutang.aspx.vb" Inherits="SMKB_Web_Portal.transferLajerPenghutang" %>

<asp:Content ID="FormContents" ContentPlaceHolderID="FormContents" runat="server">


    <link type="text/css" rel="stylesheet" href="../../../Scripts/jquery 1.13.3/css/jquery.dataTables.min.css" />
    <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/dataTables.bootstrap.min.css" />

    <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/responsive.bootstrap.min.css" />
    <script type="text/javascript" src="../../../Scripts/jquery 1.13.3/js/jquery.dataTables.min.js"></script>




    <%--    <script type="text/javascript">
        var gvTestClientId = '<% =gvkod.ClientID %>';
    </script>--%>

    <script type="text/javascript">


        async function ShowTransfer(elm) {

            //alert("a " + elm )
            if (elm === "VR_Header") {
                await ajaxInsert_ViremenHeader();
            }

            else if (elm === "VR_Detail") {
                await ajaxInsert_ViremenDetail();
            }
        }

        async function ajaxInsertViremenHeader() {

            var tahunValue = $('[id$=ddlTahun]').val();

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MigrationServices.asmx/InsertViremenHdr',
                    method: 'POST',
                    data: JSON.stringify({ tahun: tahunValue }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            });
        }

        async function ajaxInsert_ViremenDetail() {

            var tahunValue = $('[id$=ddlTahun]').val();

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MigrationServices.asmx/InsertViremenDtl',
                    method: 'POST',
                    data: JSON.stringify({ tahun: tahunValue }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            });
        }

    </script>

    <script type="text/javascript">

        $(function () {
            $(".grid").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
                "responsive": true,
                "sPaginationType": "full_numbers",
                "oLanguage": {
                    "oPaginate": {
                        "sNext": '<i class="fa fa-forward"></i>',
                        "sPrevious": '<i class="fa fa-backward"></i>',
                        "sFirst": '<i class="fa fa-step-backward"></i>',
                        "sLast": '<i class="fa fa-step-forward"></i>'
                    },
                    "sLengthMenu": "Tunjuk _MENU_ rekod",
                    "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                    "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                    "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                }
            });
        })

        function Search_Gridview(strKey, strGV) {
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById(strGV);

            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }

        function SaveSucces() {
            $('#MessageModal').modal('toggle');

        }

        function ShowPopup(elm) {

            if (elm == "1") {
                $('#permohonan').modal('toggle');

            }
            else if (elm == "2") {

                $(".modal-body input").val("");
                $('#permohonan').modal('toggle');
            }

        }

        $(function () {
            $('#txtSearch').keyup(function () {
                $.ajax({
                    url: "VOT.aspx/GetAutoCompleteData",
                    data: "{'username':'" + $('#txtSearch').val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var val = '<ul id="userlist">';
                        $.map(data.d, function (item) {
                            var itemval = item.split('/')[0];
                            val += '<li class=tt-suggestion>' + itemval + '</li>'
                        })
                        val += '</ul>'
                        $('#divautocomplete').show();
                        $('#divautocomplete').html(val);
                        $('#userlist li').click(function () {
                            $('#txtSearch').val($(this).text());
                            $('#divautocomplete').hide();
                        })
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            })
            $(document).mouseup(function (e) {
                var closediv = $("#divautocomplete");
                if (closediv.has(e.target).length == 0) {
                    closediv.hide();
                }
            });
        });
    </script>

    <style type="text/css">
        .hideGridColumn {
            display: none;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button {
            padding: 7px;
            margin-left: 5px;
            display: inline;
            border: 1px;
        }

            .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                border: 1px;
            }

        .ul li {
            list-style: none;
        }
    </style>


    <div id="PermohonanTab" class="tabcontent" style="display: block">
        <div class="">

            <div class="modal-body" >
                <div>
                    <span id="errorMessage" runat="server" style="color: red;"></span>
                </div>
                <div class="form-row col-md-12 justify-content-center">
                    <label for="" class="col-sm-1 col-form-label  text-right" >Tahun:</label>
                    <div class="form-group col-sm-2">
                        <asp:DropDownList ID="ddlTahun" runat="server" CssClass="form-control textinput"></asp:DropDownList>
                    </div>
                </div>
                <br />
                <div class="dashboard-content">
                    <div class="row">
                        <div id="menumain" runat="server" class="menu-card" style="height: auto; width: 250px;">
                            <h6><b>AKAUN BELUM TERIMA</b></h6>
                            <div>
                                <asp:Button ID="btnBilHdr" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Bil_Hdr" Text="Bil" OnClick="btnBilHdr_Click" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="blnTerimaanHdr" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Terimaan_Hdr" Text="Terimaan Hdr" OnClick="blnTerimaanHdr_Click" />

                            </div>
                            <br />
                            <div>
                                <asp:Button ID="blnTerimaanDtl" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Terimaan_Dtl" Text="Terimaan Detail" OnClick="blnTerimaanDtl_Click" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="blnTerimaanTrans" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Terimaan_Transaksi" Text="Terimaan Transaksi" OnClick="blnTerimaanTrans_Click" />
                            </div>
                        </div>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <div id="Div1" runat="server" class="menu-card" style="height: auto; width: 250px;">
                            <h6><b>AKAUN PEMBAYARAN</b></h6>
                            <div>
                                <asp:Button ID="btnInvoisHdr" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Invois_Hdr" Text="Invois Hdr" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="btnInvoisDtl" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Invois_Dtl" Text="Invois Detail" OnClick="btnInvoisDtl_Click" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="btnBaucarHdr" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Baucar_Hdr" Text="Baucar Header" OnClick="btnBaucarHdr_Click" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="btnBaucarDtl" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Baucar_Dtl" Text="Baucar Detail" OnClick="btnBaucarDtl_Click" />
                            </div>
                        </div>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <div id="Div2" runat="server" class="menu-card" style="height: auto; width: 250px;">
                            <h6 style="text-align:center"><b>TUNTUTAN KERJA LEBIH MASA</b></h6>
                            <div>
                                <asp:Button ID="Button1" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Eot_Hdr" Text="EOT Hdr" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="Button2" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Eot_Dtl" Text="EOT Detail" />
                            </div>
                            <br />
                        </div>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <div id="Div4" runat="server" class="menu-card" style="height: auto; width: 250px;">
                            <h6 style="text-align:center"><b>PENDAHULUAN DAN TUNTUTAN</b></h6>
                            <div>
                                <asp:Button ID="Button3" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Advance_Hdr" Text="Pendahuluan Hdr" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="Button4" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Advance_Dtl" Text="Pendahuluan Detail" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="Button5" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Tuntutan_Hdr" Text="Tuntutan Hdr" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="Button6" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Tuntutan_Dtl" Text="Tuntutan Dtl" />

                            </div>
                        </div>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <div id="Div5" runat="server" class="menu-card" style="height: auto; width: 250px;">
                            <h6 style="text-align:center"><b>PINJAMAN</b></h6>
                            <div>
                                <asp:Button ID="Button7" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Loan_Hdr" Text="Pinjaman Hdr" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="Button8" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Loan_Dtl" Text="Pinjaman Kenderaan Detail" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="Button9" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Loan_Dtl" Text="Pinjaman Sukan Detail" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="Button10" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke SMKB_Pembayaran_Loan_Dtl" Text="Pinjaman Komputer Detail" />
                            </div>
                        </div>
                        &nbsp;&nbsp;&nbsp;
                        <div id="Div3" runat="server" class="menu-card" style="height: auto; width: 250px;display:none" >
                            <div>
                                <asp:Button ID="InsertData" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke dbKewanganV4" Text="Lejar Resit" OnClick="InsertData_Click" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="btnBil" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Transfer Data ke dbKewanganV4" Text="Lejar Bil" OnClick="btnBil_Click" />
                            </div>
                        </div>
                        &nbsp;&nbsp;&nbsp;
                        <div class="menu-card" style="height: auto; width: 250px;">
                            <h6 style="text-align:center"><b>BAJET</b></h6>
                            <div>
                                <button id="btnViremenHdr" type="button" class="btn btn-success btnViremenHdr" onclick="ShowTransfer('VR_Header')">Viremen Header</button>
                            </div>
                            <br />
                            <div>
                                <button id="btnViremenDtl" type="button" class="btn btn-success btnViremenDtl" onclick="ShowTransfer('VR_Detail')">Viremen Detail</button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div id="Div6" runat="server" class="menu-card" style="height: auto; width: 250px;">
                            <div>
                                <asp:Button ID="btnUpdateEmail" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Update data email Staf (Penghutang Master)" Text="Update Email Staf" OnClick="btnUpdateEmail_Click" />
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="btnUpdateIRRujukanBaucar" runat="server" class="btn btn-success btnHantar"
                                    data-toggle="tooltip" data-placement="bottom"
                                    title="Update data IR Rujukan di Baucar Hdr" Text="Update ID Rujukan" OnClick="btnUpdateIRRujukanBaucar_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h6 class="modal-title" id="exampleModalLabel">Sistem Maklumat Kewangan Bersepadu</h6>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <asp:Label runat="server" ID="lblModalMessaage" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    </div>
</asp:Content>
