<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Senarai_Staf_Kontrak.aspx.vb" Inherits="SMKB_Web_Portal.Senarai_Staf_Kontrak" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <%-- <script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>--%>
    <%--<script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js" crossorigin="anonymous"></script>
<%--<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.colVis.min.js" crossorigin="anonymous"></script>--%>
  <%--  <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-rc.0/js/select2.min.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" />
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-rc.0/css/select2.min.css" rel="stylesheet" />--%>


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

        .TableTransaksi {
            display: none;
        }

    </style>

    <div id="PermohonanTab" class="tabcontent" style="display: block">
        <!-- Modal -->
        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Staf Kontrak</h5>

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
                                <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">Warganegara :</label>
                                <div class="col-sm-7">
                                    <div class="input-group">
                                        <%--<asp:DropDownList ID="ptjFilter" runat="server" DataTextField="Pejabat" DataValueField="KodPejabat" class="ui fluid search dropdown selection custom-select" AutoPostBack="true" OnSelectedIndexChanged="ptjFilter_SelectedIndexChanged"></asp:DropDownList>--%>
                                <select id="Select1" runat="server" class="ui fluid search dropdown selection custom-select">
                                                                            <option value="%">KESELURUHAN</option>
                                                                             <option value="M01">WARGANEGARA</option>
                                                                             <option value="0">BUKAN WARGANEGARA</option>  
                                  </select>       

                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                         <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">Tahun :</label>
                                <div class="col-sm-7">
                                    <div class="input-group">
                                            <select id="ddlyear" runat="server" class="ui fluid search dropdown selection custom-select">
                                                <option value="">-- Sila Pilih --</option>
                                                <option value="2023">2023</option>
                                                <option value="2022">2022</option>
                                                <option value="2021">2021</option>
                                                <option value="2020">2020</option>                                                   
                                            </select>
                                    </div>
                                </div>
                                <button id="Button1" runat="server" class="btn btnSearch" onclick="return beginSearch();" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <br />
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans_rpt" class="table table-striped" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="text-align: center">No</th>
                                            <th scope="col" style="width: 15%">Nama</th>
                                            <th scope="col" style="text-align: center;">Gred</th>
                                            <th scope="col" style="text-align: center;">Tahun Kelahiran</th>
                                            <th scope="col" style="text-align: center;">Umur</th>
                                            <th scope="col" style="text-align: center;">Warganegara</th>
                                            <th scope="col" style="text-align: center;">Tarikh Mula Kontrak Terkini</th>
                                            <th scope="col" style="text-align: center">Tarikh Tamat Kontrak Terkini</th>
                                            <th scope="col" style="text-align: center">Gaji Pokok (RM)</th>
                                            <th scope="col" style="text-align: center">Caruman KWSP (%)</th>
                                            <th scope="col" style="text-align: center">Tempoh Kontrak (Bulan)</th>
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
    </div>

    <script type="text/javascript">
        var tbl = null

        $(document).ready(function () {
            $(".ui.dropdown").dropdown({
                fullTextSearch: true
            });

            $("#<%=Select1.ClientID%>").change(function () {
                var selectedValue = $(this).val();

                // You can do more with the selected value here if needed

            });
            tbl = $("#tblDataSenarai_trans_rpt").DataTable({
                "responsive": true,
                "searching": true,
                cache: true,
                dom: 'Bfrtip',
                buttons: [
                    'csv', 'excel',
                    {
                        extend: 'print',
                        text: '<i class="fa fa-files-o green"></i> Print',
                        titleAttr: 'Print',
                        className: 'ui green basic button',
                        action: function (e, dt, button, config) {
                            var selectedValue = $('#<%=Select1.ClientID%>').val();
                            var selectedText = $('#<%=Select1.ClientID%> option:selected').text(); // Get the selected option text

                            // Include the selected name in the URL
                            var url = '<%= ResolveClientUrl("~/FORMS/GAJI/LAPORAN/PrintReport/reportStafKontrak.aspx") %>?selectedvalue=' + selectedValue + '&selectedname=' + encodeURIComponent(selectedText);

                            window.open(url, '_blank');                        }
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
                "bDeferRender": true,
                "ajax": {
                    "url": "Laporan_WS.asmx/LoadRecord_StafKontrak",
                    type: 'POST',
                    data: function (d) {
                        return "{tahun: '" + $('#<%=ddlyear.ClientID%>').val() + "',syarikat: '" + $('#<%=syarikatFilter.ClientID%>').val() + "', selectedWarga: '" + $('#<%=Select1.ClientID%>').val() + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },
                "columns": [
                    { "data": "MS01_NoStaf", "className": "center-align" },
                    { "data": "MS01_Nama" },
                    { "data": "Gred", "className": "center-align" },
                    { "data": "TahunLahir", "className": "center-align" },
                    { "data": "Umur", "className": "center-align" },
                    { "data": "Warganegara", "className": "center-align" },
                    { "data": "TkhMulaFormatted", "className": "center-align" },
                    { "data": "MS09_TkhTamat", "className": "center-align" },
                    {
                        "data": "gaji_pokok",
                        "render": function (data, type, row) {
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
                            }
                            return data;
                        },
                        "className": "text-right"
                    },
                    { "data": "kwsp", "className": "center-align"},
                    { "data": "TempohBulan", "className": "center-align" }
                ]
            });
        });


        function beginSearch() {
            debugger;
            show_loader();
            tbl.ajax.reload();
            close_loader();
        }


    </script>
</asp:Content>
