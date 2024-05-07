
<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Stok_Senarai_Barang.aspx.vb" Inherits="SMKB_Web_Portal.Stok_Senarai_Barang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
       <%-- <script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>--%>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" />

    <style>
        .dropdown-list {
            width: 100%; /* You can adjust the width as needed */
        }

        .align-right {
            text-align: right;
        }

        .center-align {
            text-align: center;
        }

        .left-align{
            text-align: left;
        }

        .TableCukaiBulanan {
            display: none;
        }


    </style>
    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
        <div id="permohonan">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Barangan</h5>
        </div>
        <!-- Create the dropdown filter -->
        <div class="search-filter">
            <div class="form-row justify-content-center">
                <div class="form-group row col-md-6">
                    <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Syarikat :</label>
                    <div class="col-sm-7">
                        <div class="input-group">
                            <asp:DropDownList ID="syarikatFilter" runat="server" DataTextField="Nama" DataValueField="Nama" class="ui fluid search dropdown selection custom-select"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="form-row justify-content-center">
                <div class="form-group row col-md-6">
                    <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">Kategori Stor:</label>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="kategoriFilter" runat="server" DataTextField="Kategori" DataValueField="Kategori" class="ui fluid search dropdown selection custom-select"></asp:DropDownList>
                   
                        </div>
                    <div class="col-md-3 order-md-4 align-self-end"> <!-- Added align-self-end to align the button at the bottom of the column -->
                        <div class="button1">
                            <label></label>
                            <button id="Button1" runat="server" class="btn btnSearch" onclick="return beginSearch();" type="button" style="margin-top: 5px">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="form-row justify-content-center">
                <div class="form-group row col-md-6">
                    <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">Ptj :</label>
                    <div class="col-sm-7">
                        <div class="input-group">
                            <asp:DropDownList ID="ptjFilter" runat="server" DataTextField="Pejabat" DataValueField="KodPejabat" class="ui fluid search dropdown selection custom-select"></asp:DropDownList>
                        </div>
                    </div>
                     <div class="col-md-3 order-md-4">
                         <div class="form-group">
                             <label></label>
                             <button id="btnSearch" runat="server" class="btn btnSearch" onclick="return beginSearch();" type="button" style="margin-top: 10px">
                            <%-- <button id="btnSearch" runat="server" class="btn btnSearch" type="button" style="margin-top: 33px">--%>
                                 <i class="fa fa-search"></i>
                             </button>
                         </div>
                     </div>
                </div>
            </div>
            <br />
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblDataSenarai_trans_rpt" class="table table-striped" style="width: 100%">
                            <thead>
                                <tr>
                                    <th scope="col" style="text-align: center; width: 10%;">Bil</th>
                                    <th scope="col" style="text-align: center; width: 5%;">Kod</th>
                                    <th scope="col" style="text-align: center; width: 10%;">Barang</th>
                                    <th scope="col" style="text-align: center; width: 10%;">Ukuran</th>
                                    <th scope="col" style="text-align: center; width: 10%;">Takat Minima</th>
                                    <th scope="col" style="text-align: center; width: 10%;">Takat Maksima</th>
                                    <th scope="col" style="text-align: center; width: 10%;">Takat Menokok</th>
                                    <th scope="col" style="text-align: center; width: 10%;">Baki</th>
                                </tr>
                            </thead>
                            <tbody id="tableID_Senarai_trans">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


    <script type="text/javascript">
        var tbl = null
        $(document).ready(function () {
            $(".ui.dropdown").dropdown({
                fullTextSearch: true
            });

            $("#<%=kategoriFilter.ClientID%>").change(function () {
                // Get the selected value
                var selectedValue = $(this).val();

                // Check if the selected value is "STOR UTAMA"
                if (selectedValue === "STOR UTAMA") {
                    // Show the PTJ section
                    $(".button1").hide();

                    $("#<%=ptjFilter.ClientID%>").closest(".form-row").show();
                } else {
                    $(".button1").show();

                    // Hide the PTJ section
                    $("#<%=ptjFilter.ClientID%>").closest(".form-row").hide();
                }


            });

            var initialSelectedValue = $("#<%=kategoriFilter.ClientID%>").val();
            if (initialSelectedValue === "STOR UTAMA") {
                $("#<%=ptjFilter.ClientID%>").closest(".form-row").show();
            } else {
                $("#<%=ptjFilter.ClientID%>").closest(".form-row").hide();
            }
            tbl = $("#tblDataSenarai_trans_rpt").DataTable({
                "responsive": true,
                "searching": true,
                cache: true,
                dom: 'Bfrtip',
                buttons: [
                    'csv', 'excel', {
                        extend: 'print',
                        text: '<i class="fa fa-files-o green"></i> Print',
                        titleAttr: 'Print',
                        className: 'ui green basic button',
                        action: function (e, dt, button, config) {


                            window.open('<%=ResolveClientUrl("~/FORMS/PENGURUSAN STOR/LAPORAN/reportStokBarang.aspx")%>', '_blank');

                            }
                        }
                    ],
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
                        "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                        "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                        "sEmptyTable": "Tiada rekod.",
                        "sSearch": "Carian"
                    },
                    "ajax": {
                        "url": "LaporanPS.asmx/LoadRecord_Pinjaman",
                        type: 'POST',
                        data: function (d) {
                            return "{ ptj: '" + $('#<%=ptjFilter.ClientID%>').val() + "', syarikat: '" + $('#<%=syarikatFilter.ClientID%>').val() + "',  kategori: '" + $('#<%=kategoriFilter.ClientID%>').val() + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        debugger;
                        return JSON.parse(json.d);
                    }

                },
                "columns": [
                    {
                        "data": "No", "className": "center-align"
                    },
                    { "data": "Kod_Brg", "className": "center-align" },
                    { "data": "Butiran", "className": "left-align" },
                    {
                        "data": "Ukuran", "className": "left-align"

                    },
                    {
                        "data": "takat_Min", "className": "center-align"
                    },
                    {
                        "data": "takat_max", "className": "center-align"
                    },
                    {
                        "data": "Takat_menokok", "className": "center-align"
                    },
                    { "data": "Baki", "className": "center-align" }
                ],
                "rowCallback": function (row, data) {
                    if (parseInt(data.Baki) < parseInt(data.Takat_menokok) && parseInt(data.Baki) < parseInt(data.takat_Min)) {
                        $(row).css("color", "red");
                    } else if (parseInt(data.Baki) < parseInt(data.Takat_menokok)) {
                        $(row).css("color", "green");
                    }
                }

            });

        });

        function beginSearch() {
            show_loader();
            // Reload DataTable with new data
            tbl.ajax.reload();
            close_loader();
        }

    </script>
        </div>
</asp:Content>
