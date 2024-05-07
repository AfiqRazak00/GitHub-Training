<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="SENARAI_PERBELANJAAN.aspx.vb" Inherits="SMKB_Web_Portal.SENARAI_PERBELANJAAN" %>


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
                            <h5 class="modal-title" id="exampleModalCenterTitle">SENARAI PERBELANJAAN - PEMIUTANG - PEMBEKAL/STAF JENIS :LAIN - LAIN BAYARAN (INDIVIDU) </h5>
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
                                    <table id="tblDataSenarai_LejarPemiutang" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Bil</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">NAMA PENERIMA</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">JUMLAH PENERIMA(RM)</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">KW</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">PTj</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kod Vot</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Jumlah VOT(RM)</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">JUMLAH(RM)</th>
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
            

            tbl = $("#tblDataSenarai_LejarPemiutang").DataTable({
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
                            window.open('<%=ResolveClientUrl("~/FORMS/PEMBAYARAN/LAPORAN/PrintReport/report_Senarai_Perbelajaan.aspx")%>', '_blank');

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
                    "url": "LejarPemiutangWS.asmx/LoadOrderRecord_PembayaranInvoisIndividu",
                    type: 'POST',
                    data: function (d) {
                        return "{ tahun: '" + $('#MainContent_FormContents_txtyear').val() + "', kod_kw1: '" + $('#MainContent_FormContents_kodkw').val() + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        var data = JSON.parse(json.d);
                        var groupedData = groupAndAggregateData(data);
                        return groupedData;
                    }

                },

                "drawCallback": function (settings) {
                    // Your function to be called after loading data
                    close_loader();
                },
                "columns": [

                    {
                        "data": "Bil",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        }
                    },
                    {
                        "data": "Nama_PemiutangList",
                        "render": function (data) {
                            return data.join(',  <br />'); // Display the list of Nama_Pemiutang values
                        },
                        "title": "Nama Pemiutang"
                    },
                    {
                        "data": "TotalJumlah_Bayar",
                        "render": function (data) {
                            return data.map(function (value) {

                                var sumAdd = value.toLocaleString(undefined, {
                                    minimumFractionDigits: 2,
                                    maximumFractionDigits: 2,
                                });
                                // Format as a number with 2 decimal places
                                return parseFloat(sumAdd).toFixed(2);
                            }).join('<br />');
                        },
                        "className": "text-right",
                        "title": "JUMLAH PENERIMA(RM)"
                    },
                    {
                        "data": "Kod_Kump_WangList",
                        "render": function (data) {
                            return data.join('<br />'); // Display the list of Kod_Kump_Wang values
                        },
                        "title": "KW"
                    },
                    {
                        "data": "Kod_PTJList",
                        "render": function (data) {
                            return data.join('<br />'); // Display the list of Kod_PTJ values
                        },
                        "title": "PTj"
                    },
                    {
                        "data": "Kod_VotList",
                        "render": function (data) {
                            return data.join(' <br />'); // Display the list of Kod_Vot values
                        },
                        "title": "Kod Vot"
                    },
                    {
                        "data": "TotalAmaun_Akan_Bayar",
                        "render": function (data) {
                            return data.map(function (value) {
                                // Format as a number with 2 decimal places
                                return parseFloat(value).toFixed(2);
                            }).join('<br />');
                        },
                        "className": "text-right",
                        "title": "Jumlah VOT(RM)"
                    },
                    //{
                    //    "data": "Jumlah_Sebenar",
                    //    "render": function (data) {
                    //        return parseFloat(data).toFixed(2);
                    //    },
                    //    "className": "align-right" // Add CSS class for right alignment
                    //},
                    {
                        "data": "Jumlah_SebenarList",
                        "render": $.fn.dataTable.render.number(',', '.', 2), // Format as currency
                        "className": "text-right",
                        "title": "JUMLAH(RM)"
                    },
                    {
                        "data": "TujuanList",
                        "render": function (data) {
                            return data.join('<br />'); // Display the list of Tujuan values
                        },
                        "title": "BUTIRAN"
                    },
                    {
                        "data": "APValueList", defaultContent: '-',
                        "render": function (data) {
                            return data.join('<br />'); // Display the list of AP values
                        },
                        "title": "NOMBOR AP"
                    },




                ],



            });


            // Function to group and aggregate data
            function groupAndAggregateData(data) {
                var groupedData = {};
                data.forEach(function (row) {
                    console.log(row);
                    var id = row.ID_Rujukan;
                    if (!groupedData[id]) {
                        groupedData[id] = {
                            ID_Rujukan: id,
                            Nama_PemiutangList: [],
                            TotalJumlah_Bayar: [],
                            TotalAmaun_Akan_Bayar: [],
                            Kod_Kump_WangList: [],
                            Kod_PTJList: [],
                            Kod_VotList: [],
                            TujuanList: [],
                            APValueList: [],
                            Jumlah_SebenarList: 0

                        };
                    }
                    groupedData[id].Nama_PemiutangList.push(row.Nama_Pemiutang);
                    groupedData[id].TotalJumlah_Bayar.push(row.Jumlah_Bayar);
                    groupedData[id].TotalAmaun_Akan_Bayar.push(row.Amaun_Akan_Bayar);
                    groupedData[id].Kod_Kump_WangList.push(row.Kod_Kump_Wang);
                    groupedData[id].Kod_PTJList.push(row.Kod_PTJ);
                    groupedData[id].Kod_VotList.push(row.Kod_Vot);
                    groupedData[id].TujuanList.push(row.Butiran);
                    groupedData[id].APValueList.push(row.APValue);
                    groupedData[id].Jumlah_SebenarList += parseFloat(row.Jumlah_Sebenar);

                });

                console.log(groupedData);
                // Convert grouped data into an array of objects
                var result = Object.values(groupedData);

                console.log(result);

                return result;
            }

        });

        function beginSearch() {
            show_loader();
            tbl.ajax.reload();
        }
    </script>
</asp:Content>

