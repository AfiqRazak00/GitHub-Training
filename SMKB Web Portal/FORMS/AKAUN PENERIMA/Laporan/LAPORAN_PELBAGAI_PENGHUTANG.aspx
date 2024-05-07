<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="LAPORAN_PELBAGAI_PENGHUTANG.aspx.vb" Inherits="SMKB_Web_Portal.LAPORAN_PELBAGAI_PENGHUTANG" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <%--<script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>--%>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" />

    <style>
        tr {
            page-break-inside: avoid;
}
        .align-right {
            text-align: right;
        }

        .center-align {
            text-align: center;
        }
                .pheader {
/*            text-align: center;
*/            font-size: 14px;
            font-weight: bold;
            margin-top:0px!important;
            margin-bottom:0px!important;
        }

        .pheader2 {
/*            text-align: center;
*/            font-size: 14px;
            margin-top:0px!important;
            margin-bottom:0px!important;
        }

        
        th, td {
            padding: 1px;
        }
         @media print {
             table.table-striped > tbody > tr:nth-child(odd) {
                background-color: rgba(0, 0, 0, 0.05); /* Adjust as needed */
            }
            @page {
                size: A4; /* or letter, legal, etc. */
                margin: 1cm; /* adjust margins as needed */
            }

            .auto-style1 {
                width: 25%;
            }

            .auto-style2 {
                width: 48%;
            }
        }

    </style>
     <div id="PermohonanTab" class="tabcontent" style="display: block">
          <div id="headerreport" style="display:none">
              <table> 
                  <tr>
                     <td style="width: 20%;text-align: right">
                        <asp:Image ID="imgMyImage" runat="server" style="width:140px; Height:80px;text-align:right"/>
                    </td>
                    <td style="width:60% ;text-align:center;">
                        <p style="margin:0px;" class="pheader"><strong><asp:label ID="lblNamaKorporat" runat="server"></asp:label></strong></p>
                        <p class="pheader2" style="font-size:12px!important;margin:0px; text-transform: capitalize"><asp:label ID="lblAlamatKorporat" runat="server"></asp:label></p>
                        <p class="pheader2" style="font-size:12px!important;margin:0px;"><asp:label ID="lblNoTelFaks" runat="server"></asp:label></p>
                        <p class="pheader2" style="font-size:12px!important;margin:0px;"><asp:label ID="lblEmailKorporat" runat="server"></asp:label></p>

                    </td>
                    <td style="width: 20%; font-size:12px!important; text-align: right">
                        <span class="ptarikh">Tarikh : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span><br />
                        <span class="ptarikh">Laporan : CLS006</span><br />
                        <span class="ptarikh">Pengguna : <%= Session("ssusrID") %></span>

                    </td>
                 <tr>
                    <td colspan="3" style="text-align: center">
                        <br />
                        <p class="pheader3"><strong>SENARAI PELBAGAI PENGHUTANG - BIL TUNTUTAN</strong></p>
                        <asp:Label ID="selectedYearLabel" runat="server" Text=""></asp:Label>

                   </td>
                </tr>
             </table>
         </div> <%--close header report--%>
        <!-- Modal -->
        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" style="width:100%" id="exampleModalCenterTitle">Senarai Pelbagai Penghutang</h5>

                    </div>
                </div>
            </div>
        </div>
    </div>
                            <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-md-9">
                                    <div class="form-row">
                                        <div class="col-md-2 order-md-1">
                                            </div>
                                        

                                     <div class="col-md-6 order-md-2">
                                            <div class="form-row justify-content-center">
                                                <div class= "form-group row col-md-8">
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
                                    </div>

                                        <div class="col-md-4 order-md-8">
                                            <div class="form-group">
                                                <label></label>
                                                <button id="btnSearch" runat="server" class="btn btnSearch" onclick="return beginSearch();" type="button" style="margin-top: 33px">
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
     <div class="modal-body">
         <div class="col-md-12">
             <div class="transaction-table table-responsive">
                 <table id="tblDataSenarai_penghutang" class="table table-striped" style="width: 100%">
                     <thead>
                         <tr>
                             <th scope="col">No. Bil</th>
                             <th scope="col">Jenis</th>
                             <th scope="col">Kod PTJ Mohon</th>
                             <th scope="col">No Staff Mohon</th>
                             <th scope="col">Untuk Perhatian</th>
                             <th scope="col">No. Rujukan</th>
                             <th scope="col">Jumlah</th>
                             <th scope="col">Kategori</th>
                             <th scope="col">Nama Penerima</th>
                             <th scope="col">Alamat</th>
                             <th scope="col">No. Tel</th>
                             <th scope="col">Kump Wang</th>
<%--                             <th scope="col">Jumlah Belum Bayar</th>--%>

                         </tr>
                     </thead>
                     <tbody id="tableID_Senarai_trans">
                     </tbody>
                
                 </table>
            </div>
        </div>

    </div>
            <script type="text/javascript">
                jQuery(document).ready(function () {


                    tbl = $("#tblDataSenarai_penghutang").DataTable({
                        "responsive": true,
                        "searching": true,
                        cache: true,
                        "paging": false, // Disable paging

                        dom: 'Bfrtip',
                        buttons: [
                            'csv', 'excel', {
                                extend: 'print',
                                text: '<i class="fa fa-files-o green"></i> Print',
                                titleAttr: 'Print',
                                className: 'ui green basic button',
                                action: function (e, dt, button, config) {
                                    var printWindow = window.open('', '_blank');
                                    printWindow.document.write('<html><head>');
                                    printWindow.document.write('<style>@page { size: A4; margin: 0.5cm; }</style>');
                                    printWindow.document.write('<style>.a4-container { width: 100%; height: 29.7cm; margin: 1cm auto; }</style>');
                                    printWindow.document.write('<style>#tblDataSenarai_penghutang { border-collapse: collapse; width: 100%; }</style>');
                                    printWindow.document.write('<style>#tblDataSenarai_penghutang th, #tblDataSenarai_penghutang td { border: 2px solid #000; padding: 4px; }</style>');
                                    printWindow.document.write('<style>#tblDataSenarai_penghutang td { text-align: center; }</style>');
                                    printWindow.document.write('</head><body>');
                                    printWindow.document.write('<div class="a4-container">');


                                    var headerContent = document.getElementById('headerreport').innerHTML;
                                    printWindow.document.write(headerContent);

                                    printWindow.document.write('<div style="height: 20px;"></div>');

                                    var tableContent = document.getElementById('tblDataSenarai_penghutang').outerHTML;
                                    printWindow.document.write(tableContent);

                                    printWindow.document.write('<div style="height: 20px;"></div>');
                                    printWindow.document.write('<div style="text-align:center">');
                                    printWindow.document.write('<span><strong>* Senarai Tamat *</strong></span>');
                                    printWindow.document.write('</div>');

                                    printWindow.document.write('</div>');
                                    printWindow.document.write('</body></html>');
                                    printWindow.document.close();
                                    printWindow.print();
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
                            "sLengthMenu": "Tunjuk MENU rekod",
                            "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                            "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                            "sInfoFiltered": "(ditapis dari MAX jumlah rekod)",
                            "sEmptyTable": "Tiada rekod.",
                            "sSearch": "Carian"
                        },
                        "ajax":
                        {
                            "url": "LejarPenghutanglaporanWS.asmx/LoadRecord_SenaraiPenghutang",
                            "type": "POST",
                            "contentType": "application/json; charset=utf-8",
                            data: function (d) {
                                return "{ tahun: '" + $('#<%=ddlyear.ClientID%>').val() + "'}"
                            },
                            "dataType": "json",
                            "dataSrc": function (json) {
                                return JSON.parse(json.d);
                            }
                        },
                        "columns": [
                            { "data": "No_Bil", "width": "20%", defaultContent: '-' },
                            { "data": "Jenis", "width": "20%", defaultContent: '-' },
                            { "data": "Kod_PTJ_Mohon", "width": "20%", defaultContent: '-' },
                            { "data": "No_Staf_Penyedia", "width": "20%", defaultContent: '-' },
                            { "data": "Utk_Perhatian", "width": "20%", defaultContent: '-' },
                            { "data": "No_Rujukan", "width": "20%", defaultContent: '-' },
                            {
                                "data": "Jumlah", "width": "20%", defaultContent: '-' ,
                                render: function (data, type, row, meta) {
                                    if (type !== "display") {

                                        return data;

                                    }
                                    var Jumlah = data.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                                    return Jumlah;
                                }
                            },
                            { "data": "Kategori", "width": "20%", defaultContent: '-' },
                            { "data": "Nama_Penghutang", "width": "20%", defaultContent: '-' },
                            { "data": "ALAMAT", "width": "20%", defaultContent: '-' },
                            { "data": "Tel_Bimbit", "width": "20%", defaultContent: '-' },
                            { "data": "Kod_Kump_Wang", "width": "20%", defaultContent: '-' },

                        ]
                    });
                });

                function beginSearch() {
                    var selectedYear = $('#<%=ddlyear.ClientID%>').val();
                    if (selectedYear) {
                        $('#<%=selectedYearLabel.ClientID%>').html('<strong>Tahun ' + selectedYear + '</strong>');
                    } else {
                        $('#<%=selectedYearLabel.ClientID%>').text('');
                    }

                    tbl.ajax.reload();
                }

            </script>
</asp:Content>