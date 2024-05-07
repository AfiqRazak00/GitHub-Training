
<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pengiraan_PCB.aspx.vb" Inherits="SMKB_Web_Portal.Pengiraan_PCB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <%--<script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>--%>
   <%-- <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js" crossorigin="anonymous"></script>
    <%--<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.colVis.min.js" crossorigin="anonymous"></script>--%>

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

        .TableTerperinci {
            display: none;
        }

    </style>

    <div id="PermohonanTab" class="tabcontent" style="display: block">
        <!-- Modal -->
        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Pengiraan PCB Terperinci</h5>

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
                                <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">Ptj :</label>
                                <div class="col-sm-7">
                                    <div class="input-group">
                                        <%--<asp:DropDownList ID="ptjFilter" runat="server" DataTextField="Pejabat" DataValueField="KodPejabat" class="ui fluid search dropdown selection custom-select" AutoPostBack="true" OnSelectedIndexChanged="ptjFilter_SelectedIndexChanged"></asp:DropDownList>--%>
                                        <asp:DropDownList ID="ptjFilter" runat="server" DataTextField="Pejabat" DataValueField="KodPejabat" class="ui fluid search dropdown selection custom-select"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">Jenis Laporan :</label>
                                <div class="col-sm-7">
                                    <div class="input-group">
                                        <select id="jenisFilter" runat="server" class="ui fluid search dropdown selection custom-select">
                                            <option value="">-- Sila Pilih --</option>
                                            <option value="1">PENGIRAAN PCB</option>
                                            <option value="0">PENGIRAAN PCB TERPERINCI</option>                                             
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <%-- <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">No Staf :</label>
                                <div class="col-sm-7">
                                    <div class="input-group">
                                        <asp:DropDownList ID="staffFilter" runat="server" DataTextField="NamaStaf" DataValueField="NoStaf" class="ui fluid search dropdown selection custom-select"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div><br />--%>
                        <br />
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-md-9">
                                    <div class="form-row">
                                        <div class="col-md-2 order-md-1">
                                            </div>
                                        <div class="col-md-3 order-md-3">
                                            <div class="form-group">
                                               <label for="txtTarikh1" style="display: block; text-align: center; width: 100%;">Bulan</label>
                                               <select id="ddlMonths" runat="server" class="ui fluid search dropdown selection custom-select">
                                                    <option value="">-- Sila Pilih --</option>
                                                    <option value="1">Januari</option>
                                                    <option value="2">Februari</option>
                                                    <option value="3">Mac</option>
                                                    <option value="4">April</option>
                                                    <option value="5">Mei</option>
                                                    <option value="6">Jun</option>
                                                    <option value="7">Julai</option>
                                                    <option value="8">Ogos</option>
                                                    <option value="9">September</option>
                                                    <option value="10">Oktober</option>
                                                    <option value="11">November</option>
                                                    <option value="12">Disember</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-3 order-md-2">
                                            <div class="form-group">
                                                <label for="txtNoRujukan1" style="display: block; text-align: center; width: 100%;">Tahun</label>
                                                <select id="ddlyear" runat="server" class="ui fluid search dropdown selection custom-select">
                                                    <option value="">-- Sila Pilih --</option>
                                                    <option value="2023">2023</option>
                                                    <option value="2022">2022</option>
                                                    <option value="2021">2021</option>
                                                    <option value="2020">2020</option>                                                   
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3 order-md-4">
                                            <div class="form-group">
                                                <label></label>
                                                <button id="btnSearch" runat="server" class="btn btnSearch" onclick="return beginSearch();" type="button" style="margin-top: 33px">
                                               <%-- <button id="btnSearch" runat="server" class="btn btnSearch" type="button" style="margin-top: 33px">--%>
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans_rpt" class="table table-striped" style="width: 100%;">
                                    <thead>
                                        <%--<tr>
                                            <th scope="col" style="text-align: center; width: 10%;">No Staf</th>
                                            <th scope="col" style="text-align: center; width: 10%;">Nama Staf</th>
                                            <th scope="col" style="text-align: center; width: 10%;">Jumlah</th>
                                            <th scope="col" style="text-align: center; width: 10%;">Pot KWSP</th>
                                            <th scope="col" style="text-align: center; width: 10%;">Jum Pen. PCB</th>
                                            <th scope="col" style="text-align: center; width: 10%;">B/ BER/ BB/ BTB</th>
                                            <th scope="col" style="text-align: center; width: 10%;">Anak bwh 18</th>
                                            <th scope="col" style="text-align: center; width: 10%;">PCB</th>
                                            <th scope="col" style="text-align: center; width: 10%;">Pot. Zakat</th>
                                            <th scope="col" style="text-align: center; width: 10%;">Pot. PCB</th>
                                        </tr>--%>
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

           <%-- tbl = $("#tblDataSenarai_trans_rpt").DataTable({
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
                            window.open('<%= ResolveClientUrl("~/FORMS/GAJI/LAPORAN/PrintReport/reportPCBTerperinci.aspx") %>', '_blank');
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
                    "url": "Laporan_WS.asmx/LoadRecord_PCB",
                    type: 'POST',
                    data: function (d) {
                        return "{ bulan: '" + $('#<%=ddlMonths.ClientID%>').val() + "', tahun: '" + $('#<%=ddlyear.ClientID%>').val() + "',syarikat: '" + $('#<%=syarikatFilter.ClientID%>').val() + "', ptj: '" + $('#<%=ptjFilter.ClientID%>').val() + "', jenis: '" + $('#<%=jenisFilter.ClientID%>').val() + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },
                "columns": [
                    { "data": "No_Staf", "className": "text-center" }, // Adjust the class name for left alignment
                    { "data": "Nama", "className": "text-left" },    // Adjust the class name for left alignment
                    {
                        "data": "Gaji",
                        "render": function (data, type, row) {
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
                            }
                            return data;
                        },
                        "className": "text-right"
                    },
                    {
                        "data": "KWSP",
                        "render": function (data, type, row) {
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
                            }
                            return data;
                        },
                        "className": "text-right"
                    },    // Adjust the class name for right alignment
                    {
                        "data": "Jum_Pen_PCB",
                        "render": function (data, type, row) {
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
                            }
                            return data;
                        },
                        "className": "text-right"
                    }, // Adjust the class name for right alignment
                    { "data": "Kategori_Cukai", "className": "text-center" }, // Adjust the class name for left alignment
                    { "data": "anakbelow18", "className": "text-center" },  // Adjust the class name for right alignment
                    {
                        "data": "PCB",
                        "render": function (data, type, row) {
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
                            }
                            return data;
                        },
                        "className": "text-right"
                    },     // Adjust the class name for right alignment
                    {
                        "data": "Zakat",
                        "render": function (data, type, row) {
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
                            }
                            return data;
                        },
                        "className": "text-right"
                    },   // Adjust the class name for right alignment
                    {
                        "data": "Pot_PCB",
                        "render": function (data, type, row) {
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
                            }
                            return data;
                        },
                        "className": "text-right"
                    }   // Adjust the class name for right alignment
                ]

            });--%>

        });

        function beginSearch() {
            show_loader();
            // Destroy the existing DataTable
            if (tbl) {
                tbl.destroy();
                $("#tblDataSenarai_trans_rpt").empty();

            }

            // Make an AJAX request to get column information
            $.ajax({
                url: "Laporan_WS.asmx/LoadRecord_PCB",
                type: "POST",
                data: JSON.stringify({
                    bulan: $('#<%=ddlMonths.ClientID%>').val(),
                    tahun: $('#<%=ddlyear.ClientID%>').val(),
                    syarikat: $('#<%=syarikatFilter.ClientID%>').val(),
                    ptj: $('#<%=ptjFilter.ClientID%>').val(),
                    jenisFilter: $('#<%=jenisFilter.ClientID%>').val()
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var response = JSON.parse(data.d);

                    var columns = [];
                    // Add "No" column first
                    columns.push({ data: "No", title: "No", className: 'center-align' });
                    columns.push({ data: "Nama", title: "Nama" });
                    if (response.length > 0 && "Gaji" in response[0]) {
                        columns.push({
                            data: "Gaji",
                            title: "Gaji",
                            render: function (data, type, row) {
                                // Check if it's for display (type === 'display')
                                if (type === 'display') {
                                    // Handle NULL values and format the data as money with 2 decimal places
                                    if (data === null) {
                                        return '0.00';
                                    } else {
                                        // Format the data as money with 2 decimal places
                                        return parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                    }
                                }
                                // Return the original data for sorting and other purposes
                                return data;
                            },
                            className: 'text-right'
                        });
                    }
                    if (response.length > 0 && "OT" in response[0]) {
                        // Add "OT" column if it exists
                        columns.push({
                            data: "OT",
                            title: "OT",
                            render: function (data, type, row) {
                                // Check if it's for display (type === 'display')
                                if (type === 'display') {
                                    // Handle NULL values and format the data as money with 2 decimal places
                                    if (data === null) {
                                        return '0.00';
                                    } else {
                                        // Format the data as money with 2 decimal places
                                        return parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                    }
                                }
                                // Return the original data for sorting and other purposes
                                return data;
                            },
                            className: 'text-right'
                        });
                    }

                    if (Array.isArray(response) && response.length > 0) {
                        for (var key in response[0]) {
                            if (key != "No" && key != "Nama" && key != "Gaji" && key != "OT") {
                                if (key == "B/BER/BB/BTB" || key == "Anak Bwh 18") {
                                    columns.push({ data: key, title: key, className: 'center-align' });
                                }
                                else {
                                    if (key == "Nama") {
                                        columns.push({ data: key, title: key, width: '15%' });
                                    }
                                    else {
                                        // Format specific columns as money
                                        columns.push({
                                            data: key,
                                            title: key,
                                            render: function (data, type, row) {
                                                // Check if it's for display (type === 'display')
                                                if (type === 'display') {
                                                    // Handle NULL values and format the data as money with 2 decimal places
                                                    if (data === null) {
                                                        return '0.00';
                                                    } else {
                                                        // Format the data as money with 2 decimal places
                                                        return parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                                    }
                                                }
                                                // Return the original data for sorting and other purposes
                                                return data;
                                            },
                                            className: 'text-right'
                                        });
                                    }
                                }
                            }
                           
                        }
                    } else {
                        columns.push({ title: "No" });
                        columns.push({ title: "Nama" });
                    }
                    
                    // Initialize DataTable with dynamic column definitions
                    tbl = $("#tblDataSenarai_trans_rpt").DataTable({
                        "responsive": true,
                        "searching": true,
                        cache: true,
                        dom: 'Bfrtip',
                        buttons: ['csv', 'excel',
                            {
                                extend: 'print',
                                text: '<i class="fa fa-files-o green"></i> Print',
                                titleAttr: 'Print',
                                className: 'ui green basic button',
                                action: function (e, dt, button, config) {
                                    var option = $('#<%=jenisFilter.ClientID%>').val()
                                    if (option == 1) {
                                        window.open('<%= ResolveClientUrl("~/FORMS/GAJI/LAPORAN/PrintReport/reportPCB.aspx") %>', '_blank');
                                    }
                                    else {
                                        window.open('<%= ResolveClientUrl("~/FORMS/GAJI/LAPORAN/PrintReport/reportPCBTerperinci.aspx") %>', '_blank');
                                    }
                                    
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
                        "data": response,  // Provide the row data directly
                        "columns": columns, // Use the dynamically created column definitions
                        "bDeferRender": true
                    });

                    close_loader();
                },
                error: function (xhr, status, error) {
                    console.error(error);
                }
            });
            close_loader();
        }
    </script>
</asp:Content>