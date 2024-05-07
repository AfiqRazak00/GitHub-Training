<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Laporan.aspx.vb" Inherits="SMKB_Web_Portal.Laporan1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    <contenttemplate>
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div id="divpendaftaraninv" runat="server" visible="true">
                <div class="modal-body">
                    <div>  
                        <h5>Laporan Permohonan Perolehan</h5>
                        <hr />

                        <!-- Create the dropdown filter -->
                        <div class="search-filter">
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Carian :</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <select id="categoryFilter" class="custom-select">
                                                <option value="" selected="selected">SEMUA</option>
                                                <option value="1" >Hari Ini</option>
                                                <option value="2">Semalam</option>
                                                <option value="3">7 Hari Lepas</option>
                                                <option value="4">30 Hari Lepas</option>
                                                <option value="5">60 Hari Lepas</option>
                                            </select>

                                            <div class="input-group-append">
                                                <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button">
                                                    <i class="fa fa-search"></i>
                                                    Cari
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div class="form-row">
                                            <div class="form-group col-md-5">
                                                <br />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblReportPemohonan" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">No Perolehan</th>
                                            <th scope="col">Tujuan</th>
                                            <th scope="col">Kategori</th>
                                            <th scope="col">Tarikh Mohon</th>
                                            <th scope="col">Status Kelulusan</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>

                                    </tfoot>

                                </table>

                            </div>
                        </div>




                    </div> 
                </div> 
            </div> 
        </div> 

        <script type="text/javascript">           
            var isClicked = false;

            var tbl = null;
            $(document).ready(function () {
                tbl = $("#tblReportPemohonan").DataTable({
                    "responsive": true,
                    "searching": true,
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
                    },
                    "ajax":
                    {
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadLaporanPo") %>',
                        type: 'POST',
                        "data": function () {
                            return JSON.stringify({
                                category_filter: $('#categoryFilter').val(),
                            })
                        },
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        }

                    },
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });

                    },
                    "columns": [
                        { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                        { "data": "No_Mohon", "title": "No Perolehan" },
                        { "data": "Tujuan", "title": "Tujuan" },
                        { "data": "kategori_butiran", "title": "Kategori" },
                        { "data": "Tarikh_Mohon", "title": "Tarikh Mohon" },
                        { "data": "Status_Lulus", "title": "Status Kelulusan" }
                    ],
                    "columnDefs": [
                        {
                            "targets": 0,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                        {
                            "targets": -1,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                if (data === '0') {
                                    return '<span class="badge badge-danger">Tidak Lulus</span>';
                                } else if (data === '1') {
                                    return '<span class="badge badge-success">Lulus</span>';
                                } else if (data === null) {
                                    return '<span class="badge badge-warning">Dalam Proses</span>';
                                } else {
                                    return data;
                                }
                            }
                        }
                    ]
                });
            });

            //Button to reload the table based on dropdown
            $('.btnSearch').click(async function () {
                show_loader();
                isClicked = true;
                tbl.ajax.reload();
                close_loader();
            })












        </script>
    </contenttemplate>
</asp:Content>
