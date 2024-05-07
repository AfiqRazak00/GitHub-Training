<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="BELANJA_AKRUAN_YAN_LAIN_PESANAN_TEMPATAN.aspx.vb" Inherits="SMKB_Web_Portal.BELANJA_AKRUAN_YAN_LAIN_PESANAN_TEMPATAN" %>


<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js" crossorigin="anonymous"></script>

    <style>
        .dropdown-list {
            width: 100%;
            /* You can adjust the width as needed */
        }
    
        .align-right {
            text-align: right;
        }
    
        .center-align {
            text-align: center;
        }
    </style>
    <contenttemplate>
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <!-- Modal -->
            <div id="permohonan">
                <div>
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle">SENARAI PERBELANJAAN - PEMIUTANG - PEMBEKAL/STAF JENIS : PESANAN TEMPATAN</h5>
                        </div>
            
                        <!-- Create the dropdown filter -->
                        <div class="search-filter">

                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="kodKewangan" class="col-sm-3 col-form-label" style="text-align: right">Kod KW :</label>
                                    <div class="col-sm-7">
                                        <div class="input-group">
                                            <asp:DropDownList ID="kodkw" runat="server" DataTextField="Butiran" DataValueField="Kod_Kump_Wang" class="ui fluid search dropdown selection custom-select"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />

                              <div class="form-row justify-content-center">
                              <div class="form-group row col-md-6">
                                  <label for="tahun" class="col-sm-3 col-form-label" style="text-align: right">Tahun :</label>
                                  <div class="col-sm-8" style="display: flex;">
                                      <select id="txtyear" runat="server" class="ui fluid search dropdown selection custom-select">
                                          <option value="">-- Sila Pilih --</option>
                                          <option value="2023">2023</option>
                                          <option value="2022">2022</option>
                                          <option value="2021">2021</option>
                                          <option value="2020">2020</option>
                                      </select>
                                      <button id="btnSearch" runat="server" class="btn btnSearch" onclick="return beginSearch();" type="button" style="margin-left: 10px;">
                                          <i class="fa fa-search"></i>
                                      </button>
                                  </div>
                              </div>
                                  </div>

                        </div>
            
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataSenarai_LejarPemiutangBil" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Bil</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">NAMA PEMBEKAL</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">NO PT</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">NO INVOIS</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">TARIKH INVOIS</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">KW</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">KOD VOT</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">JUMLAH (RM)</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">BUTIRAN</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">NOMBOR AP</th>
                                            </tr>
                                        </thead>
                                        <tbody >
                                           
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        
        
    </contenttemplate>
    <script type="text/javascript">

        $(".ui.dropdown").dropdown({
            fullTextSearch: true
        });


        var tbl = null;
        var thn = '';

        $(document).ready(function () {

           

            // set asp:DropDownList ID="ptj" to default value
            

            tbl = $("#tblDataSenarai_LejarPemiutangBil").DataTable({
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
                            window.open('<%=ResolveClientUrl("~/FORMS/PEMBAYARAN/LAPORAN/PrintReport/report_Belanja_Akruan_Yang_Lain_Pesanan_Tempatan.aspx")%>', '_blank');

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
                "ajax":
                {
                    "url": "LejarPemiutangWS.asmx/LoadOrderRecord_BelanjaAkaruanInvoisPesananTempatan",
                    type: 'POST',
                    data: function (d) {
                        return "{ tahun: '" + $('#MainContent_FormContents_txtyear').val() + "', kod_kw6: '" + $('#MainContent_FormContents_kodkw').val() + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },

                "columns": [

                    {
                        "data": "Bil",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        }
                    },
                    { "data": "Nama_Pemiutang"},
                    { "data": "No_PTempatan"},
                    { "data": "No_Invois"},
                    {
                        "data": "Tarikh_Invois",
                        "render": function (data, type, row) {
                            if (type === "display" || type === "filter") {
                                return moment(data).format("DD/MM/YYYY");
                            }
                            return data;
                        }
                    },
                    { "data": "Kod_Kump_Wang" },
                    { "data": "Kod_Vot" },
                    {
                        "data": "Jumlah_Sebenar",
                        "render": $.fn.dataTable.render.number(',', '.', 2),
                        "type": "numeric", // This is optional but helps with sorting
                        "className": "text-right"
                    },
                    { "data": "Butiran"},
                    { "data": "APValue"},

                ],
            });
        });

        function beginSearch() {
            /*show_loader();*/
            tbl.ajax.reload();
        }
    </script>
</asp:Content>