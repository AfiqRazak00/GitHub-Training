<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="LaporanTerimaan.aspx.vb" Inherits="SMKB_Web_Portal.LaporanTerimaan" %>

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
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" />
    <style>
     .jumlah-subsection {
        width: 100%;
         border-collapse: collapse;
        border: 1px solid #ccc; /* Add border styles as needed */
    }

    .jumlah-subsection td {
        padding: 4px;
    }

    .jumlah-subsection strong {
        font-weight: bold;
    }


       .text-right {
                text-align: right;
        }
       #printTable {
            width: 100%;
            table-layout: fixed;
        }
       #printTable_vot {
         width: 100%;
         table-layout: fixed;
         }

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


        .narrow-input {
            width: 100px; /* Adjust the width as needed */
        }
        
        .tblPendapatan {
            display: none;
        }
        @media print {
        table.table-striped > tbody > tr:nth-child(odd) {
            background-color: rgba(0, 0, 0, 0.05); /* Adjust as needed */
        }

        #printTable {
        width: 100%;
        table-layout: auto;
                }
         }
         #printTable_vot {
         width: 100%;
         table-layout: auto;
                 }
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

       
    </style>

             <contenttemplate>
                <div id="PermohonanTab" class="tabcontent" style="display: block">
            <!-- Modal -->
            <div id="permohonan">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Terimaan</h5>
                    </div>

                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-8">
                                <label for="tahun" class="col-sm-4 col-form-label" style="text-align: right">Jenis :</label>
                                <div class="col-sm-6">
                                    <select id="terimaanReportFilter" class="form-control">
                                        <option value="" selected hidden>-- Sila Pilih --</option>
                                        <option value="PAP">Senarai Terimaan Harian</option>
                                        <option value="PLAP">Senarai Audit</option>
                                        <option value="LPAT">Laporan Terimaan Vot</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="search-filter-second" id="zonSection">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-8">
                                <label for="ptj" class="col-sm-4 col-form-label" style="text-align: right">Zon :</label>
                                <div class="col-sm-6">
                                    <select id="ddlnoZon" class="ui search dropdown" name="ddlnoZon"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="search-filter-third" id="votSection">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-8">
                                <label for "ptj" class="col-sm-4 col-form-label" style="text-align: right">Vot :</label>
                                <div class="col-sm-6">
                                    <select id="ddlnoVot" class="ui search dropdown" name="ddlnoVot"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-11">
                        <div class="form-row justify-content-center">
                            <div class="form-group col-md-1">
                                <label id="lblMula" style="text-align: right;">Dari:</label>
                            </div>
                            <div class="form-group col-md-2">
                                <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control date-range-filter">
                            </div>
                            <div class="form-group col-md-1">
                            </div>
                            <div class="form-group col-md-1">
                                <label id="lblTamat" style="text-align: right;">Hingga:</label>
                            </div>
                            <div class="form-group col-md-2">
                                <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control date-range-filter">
                            </div>
                        </div>
                    </div>

                    <div class="form-row justify-content-center mt-4" id="btnSearchSection">
                        <button id="btnSearch" class="btn btn-primary btnSearch" onclick="" type="button">
                            Text
                        </button>
                    </div>
                </div>
            </div>
        </div>

            <div id="headerreport" style="display: none">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 20%; text-align: right">
                            <asp:Image ID="imgMyImage" runat="server" style="width:140px; Height:80px; text-align:right" />
                        </td>
                        <td style="text-align: center;">
                            <p style="margin: 0px;" class="pheader"><strong>
                                <asp:Label ID="lblNamaKorporat" runat="server"></asp:Label></strong></p>
                            <p class="pheader2" style="font-size: 12px!important; margin: 0px; text-transform: capitalize">
                                <asp:Label ID="lblAlamatKorporat" runat="server"></asp:Label></p>
                            <p class="pheader2" style="font-size: 12px!important; margin: 0px;">
                                <asp:Label ID="lblNoTelFaks" runat="server"></asp:Label></p>
                            <p class="pheader2" style="font-size: 12px!important; margin: 0px;">
                                <asp:Label ID="lblEmailKorporat" runat="server"></asp:Label></p>
                        </td>
                        <td style="width: 30%; font-size: 12px!important; text-align: right">
                            <span class="ptarikh">Tarikh : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span><br />
<%--                            <span class="ptarikh">Laporan : CLS006</span><br />--%>
                            <span class="ptarikh">Laporan : <span id="laporanName"></span></span><br />
                            <span class="ptarikh">Pengguna : <%= Session("ssusrID") %></span>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <br />
                            <p class="pheader3" style="text-align: center; border-top: 1px solid #000;"><br /><strong></strong></p>
                            <div class="col-md-12">
                                <p style="text-align: center;">
                                    <asp:Label ID="lblStartDate" runat="server" />&nbsp;&nbsp;&nbsp;<asp:Label ID="lblEndDate" runat="server" />
                                </p>
                            </div>
                            <span id="selectedNamaZon" style="font-weight: bold; text-align: left; display:none "></span>
                            <span id="selectedVot" style="font-weight: bold; text-align: left; display:none "></span>
                        </td>
                    </tr>
                </table>
            </div> <!-- close header report -->

            <div class="modal-body-zon">
                <div class="col-md-12">
                    <div id="tblData_terimaan_harian" class="transaction-table table-responsive" style=" display: none">
                        <table id="tblDataSenarai_terimaan_harian" class="table table-striped" style="width: 100%">
                            <!-- Table Header -->
                            <thead>
                                <tr>
                                    <th scope="col">Bil</th>
                                    <th scope="col">No Resit</th>
                                    <th scope="col">Tarikh</th>
                                    <th scope="col">Pembayar</th>
                                    <th scope="col">Kump Wang</th>
                                    <th scope="col">PTJ</th>
                                    <th scope="col">VOT</th>
                                    <th scope="col">Debit (RM)</th>
                                    <th scope="col">Kredit (RM)</th>
                                    <th scope="col">MOD</th>
                                    <th scope="col">Urusniaga</th>
                                    <th scope="col">No. Staf</th>
                                    <!-- Additional table headers as needed -->
                                </tr>
                            </thead>
                            <tbody id="tableID_Senarai_trans">
                                <!-- Table content -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <div class="col-md-12">
             <div id="tblData_audit" class="transaction-table table-responsive" style= "display:none">
                 <table id="tblDataSenarai_audit" class="table table-striped" style="width: 100%">
                     <thead>
                         <tr>
                             <th scope="col">Bil</th>
                             <th scope="col">No Resit</th>
                             <th scope="col">Tarikh</th>
                             <th scope="col">Pembayar</th>
                             <th scope="col">Kump Wang</th>
                             <th scope="col">PTJ</th>
                             <th scope="col">VOT</th>
                             <th scope="col">Debit (RM)</th>
                             <th scope="col">Kredit (RM)</th>
                             <th scope="col">MOD</th>
                             <th scope="col">No Dokumen</th>                                    
                             <th scope="col">Status</th>
                             <th scope="col">No. Staf</th>
<%--                             <th scope="col">Jumlah Belum Bayar</th>--%>

                         </tr>
                     </thead>
                     <tbody id="tableID_Senarai_trans2">
                     </tbody>
                
                 </table>
                 <!-- Add these two rows at the bottom of your table -->
            </div>
        </div>

        <div class="col-md-12">
            <div id="tblData_vot" class="transaction-table table-responsive" display="none">
                <table id="tblDataSenarai_vot" class="table table-striped" style="width: 100%">
                    <thead>
                        <tr>
                            <th scope="col">Bil</th>
                            <th scope="col">No Resit</th>
                            <th scope="col">Tarikh</th>
                            <th scope="col">Pembayar</th>
                            <th scope="col">Kump Wang</th>
                            <th scope="col">PTJ</th>
                            <th scope="col">Debit (RM)</th>
                            <th scope="col">Kredit (RM)</th>
                            <th scope="col">Baki</th>
                        </tr>
                    </thead>
                    <tbody id="tableID_Senarai_trans_vot">
                        <!-- Add your table rows here -->
                    </tbody>
      
                </table>
                 
            </div>
        </div>
        <div id="jumlah-4" class="transaction-table table-responsive" style="display:none">
            <table class="jumlah-subsection">
                <tbody>
                    <tr>
                        <td style="width: 50%;"></td>
                        <td style="width: 30%; text-align: right;"><strong>Jumlah Besar (RM) :</strong></td>
                        <td style="width: 9%; text-align: right;"><span id="JumlahDebit"></span></td>
                        <td style="width: 5%; text-align: right;"><span id="JumlahKredit"></span></td>
                        <td style="width: 6%;"></td>

                     </tr>

                     <tr>
                         <td style="width: 50%;"></td>
                         <td style="width: 30%; text-align: right;"><strong>Jumlah Pembatalan (RM) :</strong></td>
                         <td style="width: 9%; text-align: right;"><span id="JumlahPembatalanDebit"></span></td>
                         <td style="width: 5%; text-align: right;"><span id="JumlahPembatalanKredit"></span></td>     
                         <td style="width: 6%;"></td>
                     </tr

                     <tr>
                        <td style="width: 50%;"></td>
                        <td style="width: 30%; text-align: right;"><strong>Jumlah Bersih (RM) :</strong></td>
                        <td style="width: 9%; text-align: right;"><span id="JumlahBersihDebit"></span></td>
                        <td style="width: 5%; text-align: right;"><span id="JumlahBersihKredit"></span></td>
                        <td style="width: 6%;"></td>



                    </tr>

                     <tr>
                        <td style="width: 50%;"></td>
                        <td style="width: 30%; text-align: right;"><strong>Jumlah Keseluruhan (RM) :</strong></td>
                        <td style="width: 9%; text-align: right;"><span id="JumlahKeseluruhanDebit"></span></td>
                        <td style="width: 5%; text-align: right;"><span id="JumlahKeseluruhanKredit"></span></td>
                        <td style="width: 6%;"></td>
                    </tr>
                </tbody>
            </table>
        </div>



            
    </contenttemplate>
  
    <script type="text/javascript">
        var shouldPop = true;
        var totalDebit = 0;
        var totalKredit = 0;
        $(document).ready(function () {


            // set #penghutangReportFilter to default value
            // Function to update the header based on the selected report type
            function updateHeader() {
                var selectedValue = document.getElementById('terimaanReportFilter').value;
                var headerText = '';

                switch (selectedValue) {
                    case 'PAP':
                        headerText = 'Senarai Terimaan Harian';
                        break;
                    case 'PLAP':
                        headerText = 'Senarai Audit';
                        break;
                    case 'LPAT':
                        headerText = 'Laporan Terimaan Vot';

                        break;
                    default:
                        headerText = 'Unknown Report';
                }

                document.querySelector('.pheader3 strong').textContent = headerText;
            }

            // Add an event listener to the dropdown to update the header when the selection changes
            document.getElementById('terimaanReportFilter').addEventListener('change', updateHeader);

            // Initialize the header based on the initial selected value
            updateHeader();

            function laporanName() {
                var selectedValue_hdr = document.getElementById('terimaanReportFilter').value;
                var laporanHdr = '';

                switch (selectedValue_hdr) {
                    case 'PAP':
                        laporanHdr = 'Senarai Terimaan Harian';
                        break;
                    case 'PLAP':
                        laporanHdr = 'Senarai Audit';
                        break;
                    case 'LPAT':
                        laporanHdr = 'Laporan Terimaan Vot';

                        break;
                    default:
                        laporanHdr = 'Unknown Report';
                }

                document.querySelector('#laporanName').textContent = laporanHdr;
            }

            // Add an event listener to the dropdown to update the header when the selection changes
            document.getElementById('terimaanReportFilter').addEventListener('change', laporanName);

            // Initialize the header based on the initial selected value
            laporanName();

            $('#terimaanReportFilter').val('');
            // trigger change event
            $('#terimaanReportFilter').trigger('change');

            $('#ddlnoZon').dropdown({

                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'LejarPenghutangLaporanWS.asmx/GetNoZonList?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({ q: settings.urlData.query });
                        //searchQuery = settings.urlData.query;
                        return settings;
                    },
                    onSuccess: function (response) {
                        console.log(response); // Log the response to the console

                        // Clear existing dropdown options
                        var obj = $(this);

                        var objItem = $(this).find('.menu');
                        $(objItem).html('');

                        // Add new options to dropdown
                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            var text = option.kodz + " - " + option.nama_zon;
                            $(objItem).append($('<div class="item" data-value="' + option.kodz + '">').html(text));
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        $(obj).dropdown('setting', 'onChange', function (value, text, element) {
                            // When an item is selected, display the selected values on the page
                            $('#selectedKodz').text(value);
                            $('#selectedNamaZon').text(text);
                        });

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });


            $('#ddlnoVot').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true, // Enable full text search
                apiSettings: {
                    url: 'LejarPenghutangLaporanWS.asmx/GetNoVotList?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // You can send the search term in a format that allows your server to search by both ID and name
                        settings.data = JSON.stringify({ q: settings.urlData.query });
                        return settings;
                    },
                    onSuccess: function (response) {
                        console.log(response); // Log the response to the console

                        var obj = $(this);
                        var objItem = $(this).find('.menu');
                        $(objItem).html('');

                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            var text = option.kodv + " - " + option.nama;
                            $(objItem).append($('<div class="item" data-value="' + option.kodv + '">').html(text));
                        });

                        $(obj).dropdown('refresh');

                        $(obj).dropdown('setting', 'onChange', function (value, text, element) {
                            // When an item is selected, display the selected values on the page
                            $('#selectedVot').text("NO AKAUN :" + value);

                        });


                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });



            $("#txtTarikhStart").change(function () {
                // Get the selected start date
                var startDate = $(this).val();
                var formattedStartDate = new Date(startDate);
                // Format the date as DD MM YYYY (with spaces)
                var formattedStartDateString = formattedStartDate.toLocaleDateString('en-GB').replace(/-/g, ' ');
                // Update the "Dari" label
                $("#<%= lblStartDate.ClientID %>").text("Dari: " + formattedStartDateString);
            });

            $("#txtTarikhEnd").change(function () {
                var endDate = $(this).val();
                var formattedEndDate = new Date(endDate);
                var formattedEndDateString = formattedEndDate.toLocaleDateString('en-GB').replace(/-/g, ' ');
                // Update the "Hingga" label
                $("#<%= lblEndDate.ClientID %>").text("Hingga: " + formattedEndDateString); // Removed the dash before "Hingga"
            });
        });

        $('#terimaanReportFilter').on('change', function () {
            var selectedValue = $(this).val();


            if (selectedValue == 'PAP') {
                $('#zonSection').show();
                $('#votSection').hide();

                $('#tblData_terimaan_harian').hide();
                $('#tblData_audit').hide();
                $('#tblData_vot').hide();

                $('#txtTarikhStart').show();
                $('#txtTarikhEnd').show();
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
                $('#lblMula').show();
                $('#lblTamat').show();

                $('#jumlah-4').hide();

                $('#btnSearchSection').show();
                $('#btnSearch').text('Cari')

            } else if (selectedValue == 'PLAP') {
                $('#zonSection').hide();
                $('#tblData_terimaan_harian').hide();
                $('#tblData_audit').hide();
                $('#tblData_vot').hide();
                $('#jumlah-4').hide();

                $('#txtTarikhStart').show();
                $('#txtTarikhEnd').show();
                $('#tblDataSenarai_audit').show();
                $('#tblDataSenarai_vot').hide();
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
                $('#tblDataSenarai_terimaan_harian').hide();
                $('#votSection').hide();
                $('#lblMula').show();
                $('#lblTamat').show();
                // show #btnSearchSection
                $('#btnSearchSection').show();
                $('#btnSearch').text('Cari')

            } else if (selectedValue == 'LPAT') {
                $('#zonSection').hide();
                $('#votSection').show();
                $('#jumlah-4').hide();

                $('#tblDataSenarai_audit').hide();
                $('#tblDataSenarai_vot').show();
                $('#tblDataSenarai_terimaan_harian').hide();
                $('#tblData_terimaan_harian').hide();
                $('#tblData_audit').hide();
                $('#tblData_vot').hide();

                $('#txtTarikhStart').show();
                $('#txtTarikhEnd').show();
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
                $('#lblMula').show();
                $('#lblTamat').show();


                // show #btnSearchSection
                $('#btnSearchSection').show();
                $('#btnSearch').text('Cari')

            } else {
                $('#zonSection').hide();
                $('#votSection').hide();
                $('#jumlah-4').hide();

                $('#txtTarikhStart').hide();
                $('#txtTarikhEnd').hide();
                $('#txtTarikhStart').val("");
                $('#txtTarikhEnd').val("");
                $('#lblMula').hide();
                $('#lblTamat').hide();

                $('#tblDataSenarai_terimaan_harian').hide();
                $('#tblDataSenarai_audit').hide();
                $('#tblDataSenarai_vot').hide();
                $('#tblData_audit').hide();
                $('#tblData_terimaan_harian').hide();
                $('#tblData_vot').hide();
                $('.jumlah-subsection').hide();

                // hide #btnSearchSection
                $('#btnSearchSection').hide();
            }

        });

        $('.btnSearch').click(async function () {
            var selectedValue = $('#terimaanReportFilter').val();
            var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;


            if (selectedValue == 'PAP') {
                $('#tblData_terimaan_harian').show();
                $('#jumlah-4').show();
                // Check if a DataTable is already initialized
                if ($.fn.DataTable.isDataTable('#tblDataSenarai_terimaan_harian')) {
                    // If it is, destroy the existing DataTable
                    var table = $('#tblDataSenarai_terimaan_harian').DataTable();
                    table.clear().draw().destroy();
                }
                $('#tblDataSenarai_terimaan_harian').show();

                $('.jumlah-subsection').show();
                tbl = $("#tblDataSenarai_terimaan_harian").DataTable({
                    // After initializing your DataTable, calculate the totals
                    "responsive": true,
                    "searching": true,
                    dom: 'Bfrtip',
                    "buttons": [
                        'csv', 'excel', {
                            extend: 'print',
                            text: '<i class="fa fa-files-o green"></i> Print',
                            titleAttr: 'Print',
                            className: 'ui green basic button',
                            action: function (e, dt, button, config) {
                                //config.pageLength = -1;

                                var printWindow = window.open('', '_blank');
                                printWindow.document.write('<html><head>');
                                printWindow.document.write('<style>@page { size: A4;  }</style>');
                                printWindow.document.write('<style>.a4-container { width: 100%; height: 29.7cm; margin: 1cm auto; }</style>'); // Add this line to set up the A4 container
                                printWindow.document.write('<style>#printTable { border-collapse: collapse; } #printTable th, #printTable td { border: 2px solid #000; padding: 8px;  }</style>'); // Add table striping styles                  

                                printWindow.document.write('</head><body>');

                                // Add the A4 container here
                                printWindow.document.write('<div class="a4-container">');

                                // Append the header content to the print window
                                var headerContent = document.getElementById('headerreport').innerHTML;
                                printWindow.document.write(headerContent);

                                var selectedZon = document.getElementById('selectedNamaZon').innerHTML;
                                // Wrap the selectedZon content in <strong> tags to make it bold
                                var boldSelectedZon = '<br><strong>' + selectedZon + '</strong>';
                                printWindow.document.write(boldSelectedZon);


                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed
                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed                       

                                printWindow.document.write('<table id="printTable"  style="width:100%">' +
                                    '<thead>' +
                                    '<tr>' +
                                    '<th scope="col" style="text-align: left;">Bil</th>' +
                                    '<th scope="col" style="text-align: left;">No Resit</th>' +
                                    '<th scope="col" style="text-align: left;">Tarikh</th>' +
                                    '<th scope="col" style="text-align: left;">Pembayar</th>' +
                                    '<th scope="col" style="text-align: left;">Kump Wang</th>' +
                                    '<th scope="col" style="text-align: left;">PTJ</th>' +
                                    '<th scope="col" style="text-align: left;">Vot</th>' +
                                    '<th scope="col" style="text-align: right;">Debit (RM)</th>' +
                                    '<th scope="col" style="text-align: right;">Kredit (RM)</th>' +
                                    '<th scope="col" style="text-align: left;">MOD</th>' +
                                    '<th scope="col" style="text-align: left;">Urusniaga</th>' +
                                    '<th scope="col" style="text-align: left;">No Staf</th>' +

                                    '</tr>' +
                                    ' </thead>' +
                                    '</table > ');

                                // Create a DataTable for the print table
                                var printTable = $('#printTable', printWindow.document).DataTable({
                                    "pageLength": -1,
                                    "searching": false,
                                    "paging": false,
                                    "dom": 't', // Display table only (no info, pagination, etc.)
                                    "columns": [
                                        {
                                            "data": null, // Use null to provide a custom value
                                            "render": function (data, type, row, meta) {
                                                return meta.row + 1; // Add 1 to start numbering from 1
                                            },
                                            "width": "10%"
                                        },
                                        { "data": "No_Dok", "width": "20%", defaultContent: '-' },
                                        {
                                            "data": "Tkh_Daftar",
                                            "width": "20%",
                                            "render": function (data) {
                                                // Check if the data is a valid date
                                                if (data) {
                                                    var date = new Date(data);

                                                    // Format the date as "DD-MM-YYYY"
                                                    var formattedDate = date.getDate() + '-' + (date.getMonth() + 1) + '-' + date.getFullYear();

                                                    return formattedDate;
                                                }

                                                // Return the data as is if it's not a valid date
                                                return data;
                                            }

                                        },
                                        { "data": "Nama_Penghutang", "width": "20%", defaultContent: '-' },
                                        { "data": "Kod_Kump_Wang", "width": "20%", defaultContent: '-' },
                                        { "data": "Kod_PTJ", "width": "20%", defaultContent: '-' },
                                        { "data": "Kod_Vot", "width": "20%", defaultContent: '-' },

                                        {
                                            "data": "Debit",
                                            "width": "20%",
                                            "defaultContent": '-',
                                            "render": function (data, type, row) {
                                                if (type === 'display' && data !== null) {
                                                    var formattedDebit = parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                                    return '<div style="text-align: right;">' + formattedDebit + '</div>';
                                                }
                                                return data;
                                            }
                                        },
                                        {
                                            "data": "Kredit",
                                            "width": "20%",
                                            "defaultContent": '-',
                                            "render": function (data, type, row) {
                                                if (type === 'display' && data !== null) {
                                                    var formattedKredit = parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                                    return '<div style="text-align: right;">' + formattedKredit + '</div>';
                                                }
                                                return data;
                                            }
                                        },

                                        { "data": "EButiran", "width": "20%", defaultContent: '-' },
                                        { "data": "Bbutiran", "width": "20%", defaultContent: '-' },
                                        { "data": "Staf_Terima", "width": "20%", defaultContent: '-' },
                                    ],


                                });

                                // Fetch and append the data from the original DataTable
                                var tableData = dt.rows().data().toArray();
                                for (var i = 0; i < tableData.length; i++) {
                                    printTable.row.add(tableData[i]);
                                }

                                printTable.draw();

                                var totalDebit = tableData.reduce(function (total, item) {
                                    return total + (parseFloat(item.Debit) || 0);
                                }, 0);

                                var totalCredit = tableData.reduce(function (total, item) {
                                    return total + (parseFloat(item.Kredit) || 0);
                                }, 0);

                                // Calculate Jumlah Pembatalan by subtracting totalCredit from totalDebit
                                var jumlahPembatalan = '';

                                // Calculate Jumlah Besar as the sum of total Debit and total Credit
                                var jumlahBesar_debit = totalDebit;
                                var jumlahBesar_kredit = totalCredit;

                                // Calculate Jumlah Bersih by subtracting Jumlah Pembatalan from Jumlah Besar
                                var jumlahBersih_debit = jumlahBesar_debit - jumlahPembatalan;
                                var jumlahBersih_kredit = jumlahBesar_kredit - jumlahPembatalan;

                                // Calculate Jumlah Keseluruhan by adding Jumlah Bersih to the total amount
                                var jumlahKeseluruhan_debit = jumlahBersih_debit;
                                var jumlahKeseluruhan_kredit = jumlahBersih_kredit;

                                printWindow.document.write('<table style="width: 100%;">' +
                                    '<tr>' +
                                    '<td colspan="1"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Besar (RM)</strong>&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align" style="width: 5%;">' + jumlahBesar_debit.toFixed(2) + '&ensp;&ensp;&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align" style="width:28%;">' + jumlahBesar_kredit.toFixed(2) + '&ensp;</td>' +
                                    '</tr>' +

                                    '<tr>' +
                                    '<td colspan="1"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Pembatalan (RM)</strong>&ensp;&ensp;&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahPembatalan).toFixed(2) + '&ensp;</td>' +
                                    '</tr>' +
                                    '<tr>' +
                                    '<td colspan="1"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Bersih (RM)</strong>&ensp;&ensp;&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahBersih_debit).toFixed(2) + '&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahBersih_kredit).toFixed(2) + '&ensp;</td>' +

                                    '</tr>' +
                                    '<tr>' +
                                    '<td colspan="1"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Keseluruhan (RM)</strong>&ensp;&ensp;&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahKeseluruhan_debit).toFixed(2) + '&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahKeseluruhan_kredit).toFixed(2) + '&ensp;</td>' +

                                    '</tr>' +
                                    '</table>');


                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed

                                // Add the additional div with centered text
                                printWindow.document.write('<div style="text-align:center">');
                                printWindow.document.write('<span><strong>*** Laporan Tamat ***</strong></span>');
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
                        "url": "LejarPenghutangLaporanWS.asmx/GetZonKewanganPusat",
                        "type": "POST",
                        data: function (d) {
                            // console.log($('#MainContent_FormContents_DropDownList1').val()+" text " + $('#txtVotDari').val())
                            return "{ tkhMula: '" + $('#txtTarikhStart').val() + "', tkhTamat: '" + $('#txtTarikhEnd').val() + "', zon: '" + $('#ddlnoZon').val() + "'}";
                        },
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            var data = JSON.parse(json.d);

                            var totalDebit = data.reduce(function (total, item) {
                                return total + (parseFloat(item.Debit) || 0);
                            }, 0);

                            var totalCredit = data.reduce(function (total, item) {
                                return total + (parseFloat(item.Kredit) || 0);
                            }, 0);


                            var jumlahKeseluruhan_debit = totalDebit;
                            var jumlahKeseluruhan_kredit = totalCredit;

                            document.getElementById('JumlahDebit').textContent = totalDebit.toFixed(2);
                            document.getElementById('JumlahKredit').textContent = totalCredit.toFixed(2);
                            document.getElementById('JumlahKeseluruhanDebit').textContent = jumlahKeseluruhan_debit.toFixed(2);
                            document.getElementById('JumlahKeseluruhanKredit').textContent = jumlahKeseluruhan_kredit.toFixed(2);

                            return data;
                        }
                    },

                    "columns": [
                        {
                            "data": null, // Use null to provide a custom value
                            "render": function (data, type, row, meta) {
                                return meta.row + 1; // Add 1 to start numbering from 1
                            },
                            "width": "10%"
                        },
                        { "data": "No_Dok", "width": "20%", defaultContent: '-' },
                        {
                            "data": "Tkh_Daftar",
                            "width": "20%",
                            "render": function (data) {
                                // Check if the data is a valid date
                                if (data) {
                                    var date = new Date(data);

                                    // Format the date as "DD-MM-YYYY"
                                    var formattedDate = date.getDate() + '-' + (date.getMonth() + 1) + '-' + date.getFullYear();

                                    return formattedDate;
                                }

                                // Return the data as is if it's not a valid date
                                return data;
                            }

                        },
                        { "data": "Nama_Penghutang", "width": "20%", defaultContent: '-' },
                        { "data": "Kod_Kump_Wang", "width": "20%", defaultContent: '-' },
                        { "data": "Kod_PTJ", "width": "20%", defaultContent: '-' },
                        { "data": "Kod_Vot", "width": "20%", defaultContent: '-' },
            
                        {
                            "data": "Debit",
                            "width": "20%",
                            "defaultContent": '-',
                            "render": function (data, type, row) {
                                if (type === 'display' && data !== null) {
                                    return parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                }
                                return data;
                            },
                            "className": "text-right"
                        },
                        {
                            "data": "Kredit",
                            "width": "20%",
                            "defaultContent": '-',
                            "render": function (data, type, row) {
                                if (type === 'display' && data !== null) {
                                    return parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                }
                                return data;
                            },
                            "className": "text-right"
                        },

                        { "data": "EButiran", "width": "20%", defaultContent: '-' },
                        { "data": "Bbutiran", "width": "20%", defaultContent: '-' },
                        { "data": "Staf_Terima", "width": "20%", defaultContent: '-' },

                    ],
                    "createdRow": function (row, data, dataIndex) {
                        // You can use this callback to customize the appearance of rows if needed.
                    }
                });

            } else if (selectedValue == 'PLAP') {
                $('#tblData_audit').show();
                $('#jumlah-4').show();
                // Handle other cases if needed
                if ($.fn.DataTable.isDataTable('#tblDataSenarai_audit')) {
                    // If it is, destroy the existing DataTable
                    var table = $('#tblDataSenarai_audit').DataTable();
                    table.clear().draw().destroy();
                }
                //getjumlah()
                tbl = $("#tblDataSenarai_audit").DataTable({
                    // After initializing your DataTable, calculate the totals
                    "responsive": true,
                    "searching": true,
                    dom: 'Bfrtip',
                    "buttons": [
                        'csv', 'excel', {
                            extend: 'print',
                            text: '<i class="fa fa-files-o green"></i> Print',
                            titleAttr: 'Print',
                            className: 'ui green basic button',
                            action: function (e, dt, button, config) {

                                //config.pageLength = -1;

                                var printWindow = window.open('', '_blank');
                                printWindow.document.write('<html><head>');
                                printWindow.document.write('<style>@page { size: A4;  }</style>');
                                printWindow.document.write('<style>.a4-container { width: 100%; height: 29.7cm; margin: 1cm auto; }</style>'); // Add this line to set up the A4 container
                                printWindow.document.write('<style>#printTable_audit { border-collapse: collapse; } #printTable_audit th, #printTable_audit td { border: 2px solid #000; padding: 2px;  }</style>'); // Add table striping styles                  

                                printWindow.document.write('</head><body>');

                                // Add the A4 container here
                                printWindow.document.write('<div class="a4-container">');

                                // Append the header content to the print window
                                var headerContent = document.getElementById('headerreport').innerHTML;
                                printWindow.document.write(headerContent);


                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed
                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed                       
                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed                       

                                printWindow.document.write('<table id="printTable_audit" style="width:100%" >' +
                                    '<thead>' +
                                    '<tr>' +
                                    '<th scope="col" style="text-align: left;">Bil</th>' +
                                    '<th scope="col" style="text-align: left;">No Resit</th>' +
                                    '<th scope="col" style="text-align: left;">Tarikh</th>' +
                                    '<th scope="col" style="text-align: left;">Pembayar</th>' +
                                    '<th scope="col" style="text-align: left;">Kump Wang</th>' +
                                    '<th scope="col" style="text-align: left;">PTJ</th>' +
                                    '<th scope="col" style="text-align: left;">Vot</th>' +
                                    '<th scope="col" style="text-align: right;">Debit (RM)</th>' +
                                    '<th scope="col" style="text-align: right;">Kredit (RM)</th>' +
                                    '<th scope="col" style="text-align: left;">MOD</th>' +
                                    '<th scope="col" style="text-align: left;">No Dokumen</th>' +
                                    '<th scope="col" style="text-align: left;">Status</th>' +
                                    '<th scope="col" style="text-align: left;">No Staf</th>' +

                                    '</tr>' +
                                    ' </thead>' +
                                    '</table > ');

                                // Create a DataTable for the print table
                                var printTable_audit = $('#printTable_audit', printWindow.document).DataTable({
                                    "pageLength": -1,
                                    "searching": false,
                                    "paging": false,
                                    "dom": 't', // Display table only (no info, pagination, etc.)
                                    "columns": [
                                        {
                                            "data": null, // Use null to provide a custom value
                                            "render": function (data, type, row, meta) {
                                                return meta.row + 1; // Add 1 to start numbering from 1
                                            },
                                            "width": "10%"
                                        },
                                        { "data": "No_Dok", "width": "20%", defaultContent: '-' },
                                        {
                                            "data": "Tkh_Daftar",
                                            "width": "20%",
                                            "render": function (data) {
                                                // Check if the data is a valid date
                                                if (data) {
                                                    var date = new Date(data);

                                                    // Format the date as "DD-MM-YYYY"
                                                    var formattedDate = date.getDate() + '-' + (date.getMonth() + 1) + '-' + date.getFullYear();

                                                    return formattedDate;
                                                }

                                                // Return the data as is if it's not a valid date
                                                return data;
                                            }

                                        },
                                        { "data": "Nama_Penghutang", "width": "20%", defaultContent: '-' },
                                        { "data": "Kod_Kump_Wang", "width": "20%", defaultContent: '-' },
                                        { "data": "Kod_PTJ", "width": "20%", defaultContent: '-' },
                                        { "data": "Kod_Vot", "width": "20%", defaultContent: '-' },

                                        {
                                            "data": "Debit",
                                            "width": "20%",
                                            "defaultContent": '-',
                                            "render": function (data, type, row) {
                                                if (type === 'display' && data !== null) {
                                                    var formattedDebit = parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                                    return '<div style="text-align: right;">' + formattedDebit + '</div>';
                                                }
                                                return data;
                                            }
                                        },
                                        {
                                            "data": "Kredit",
                                            "width": "20%",
                                            "defaultContent": '-',
                                            "render": function (data, type, row) {
                                                if (type === 'display' && data !== null) {
                                                    var formattedKredit = parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                                    return '<div style="text-align: right;">' + formattedKredit + '</div>';
                                                }
                                                return data;
                                            }
                                        },

                                        { "data": "Butiran", "width": "20%", defaultContent: '-' },
                                        { "data": "No_Rujukan", "width": "20%", defaultContent: '-' },
                                        { "data": "Status", "width": "20%", defaultContent: '-' },

                                        { "data": "Staf_Terima", "width": "20%", defaultContent: '-' },
                                    ],
                                    "createdRow": function (row, data, dataIndex) {
                                        // You can use this callback to customize the appearance of rows if needed.
                                    }

                                    // ... other DataTable options
                                });

                                // Fetch and append the data from the original DataTable
                                var tableData = dt.rows().data().toArray();
                                for (var i = 0; i < tableData.length; i++) {
                                    printTable_audit.row.add(tableData[i]);
                                }

                                printTable_audit.draw();
                                var totalDebit = tableData.reduce(function (total, item) {
                                    return total + (parseFloat(item.Debit) || 0);
                                }, 0);

                                var totalCredit = tableData.reduce(function (total, item) {
                                    return total + (parseFloat(item.Kredit) || 0);
                                }, 0);

                                // Calculate Jumlah Pembatalan by subtracting totalCredit from totalDebit
                                var jumlahPembatalan = '';

                                // Calculate Jumlah Besar as the sum of total Debit and total Credit
                                var jumlahBesar_debit = totalDebit;
                                var jumlahBesar_kredit = totalCredit;

                                // Calculate Jumlah Bersih by subtracting Jumlah Pembatalan from Jumlah Besar
                                var jumlahBersih_debit = jumlahBesar_debit - jumlahPembatalan;
                                var jumlahBersih_kredit = jumlahBesar_kredit - jumlahPembatalan;

                                // Calculate Jumlah Keseluruhan by adding Jumlah Bersih to the total amount
                                var jumlahKeseluruhan_debit = jumlahBersih_debit;
                                var jumlahKeseluruhan_kredit = jumlahBersih_kredit;

                                printWindow.document.write('<table style="width: 100%;">' +
                                    '<tr>' +
                                    '<td colspan="1"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Besar (RM)</strong>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align" style="width:7%";&ensp;&ensp;>' + jumlahBesar_debit.toFixed(2) + '&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align" style="width:38%";>' + jumlahBesar_kredit.toFixed(2) + '&ensp;</td>' +

                                    '</tr>' +
                                    '<tr>' +
                                    '<td colspan="1"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Pembatalan (RM)</strong>&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahPembatalan).toFixed(2) + '&ensp;</td>' +
                                    '</tr>' +
                                    '<tr>' +
                                    '<td colspan="1"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Bersih (RM)</strong>&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahBersih_debit).toFixed(2) + '&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahBersih_kredit).toFixed(2) + '&ensp;</td>' +

                                    '</tr>' +
                                    '<tr>' +
                                    '<td colspan="1"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Keseluruhan (RM)</strong>&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahKeseluruhan_debit).toFixed(2) + '&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahKeseluruhan_kredit).toFixed(2) + '&ensp;</td>' +

                                    '</tr>' +
                                    '</table>');

                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed

                                // Add the additional div with centered text
                                printWindow.document.write('<div style="text-align:center">');
                                printWindow.document.write('<span><strong>*** Laporan Tamat ***</strong></span>');
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
                        "url": "LejarPenghutangLaporanWS.asmx/GetAllSenaraiAudit",
                        "type": "POST",
                        data: function (d) {
                            // console.log($('#MainContent_FormContents_DropDownList1').val()+" text " + $('#txtVotDari').val())
                            return "{ tkhMula: '" + $('#txtTarikhStart').val() + "', tkhTamat: '" + $('#txtTarikhEnd').val() + "'}";
                        },
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            var data = JSON.parse(json.d);

                            var totalDebit = data.reduce(function (total, item) {
                                return total + (parseFloat(item.Debit) || 0);
                            }, 0);

                            var totalCredit = data.reduce(function (total, item) {
                                return total + (parseFloat(item.Kredit) || 0);
                            }, 0);


                            var jumlahKeseluruhan_debit = totalDebit;
                            var jumlahKeseluruhan_kredit = totalCredit;


                            document.getElementById('JumlahDebit').textContent = totalDebit.toFixed(2);
                            document.getElementById('JumlahKredit').textContent = totalCredit.toFixed(2);
                            document.getElementById('JumlahKeseluruhanDebit').textContent = jumlahKeseluruhan_debit.toFixed(2);
                            document.getElementById('JumlahKeseluruhanKredit').textContent = jumlahKeseluruhan_kredit.toFixed(2);

                            return data;
                        }
                    },

                    "columns": [
                        {
                            "data": null, // Use null to provide a custom value
                            "render": function (data, type, row, meta) {
                                return meta.row + 1; // Add 1 to start numbering from 1
                            },
                            "width": "10%"
                        },
                        { "data": "No_Dok", "width": "20%", defaultContent: '-' },
                        {
                            "data": "Tkh_Daftar",
                            "width": "20%",
                            "render": function (data) {
                                // Check if the data is a valid date
                                if (data) {
                                    var date = new Date(data);

                                    // Format the date as "DD-MM-YYYY"
                                    var formattedDate = date.getDate() + '-' + (date.getMonth() + 1) + '-' + date.getFullYear();

                                    return formattedDate;
                                }

                                // Return the data as is if it's not a valid date
                                return data;
                            }

                        },
                        { "data": "Nama_Penghutang", "width": "20%", defaultContent: '-' },
                        { "data": "Kod_Kump_Wang", "width": "20%", defaultContent: '-' },
                        { "data": "Kod_PTJ", "width": "20%", defaultContent: '-' },
                        { "data": "Kod_Vot", "width": "20%", defaultContent: '-' },
                        {
                            "data": "Debit",
                            "width": "20%",
                            "defaultContent": '-',
                            "render": function (data, type, row) {
                                if (type === 'display' && data !== null) {
                                    return parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                }
                                return data;
                            },
                            "className": "text-right"
                        },
                        {
                            "data": "Kredit",
                            "width": "20%",
                            "defaultContent": '-',
                            "render": function (data, type, row) {
                                if (type === 'display' && data !== null) {
                                    return parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                }
                                return data;
                            },
                            "className": "text-right"
                        },

                        { "data": "Butiran", "width": "20%", defaultContent: '-' },
                        { "data": "No_Rujukan", "width": "20%", defaultContent: '-' },
                        { "data": "Status", "width": "20%", defaultContent: '-' },
                        { "data": "Staf_Terima", "width": "20%", defaultContent: '-' },

                    ],

                });

                $('.jumlah-subsection').show();

            } else if (selectedValue == 'LPAT') {
                // Handle other cases if needed
                $('#tblData_vot').show();
                $('#jumlah-4').show();

                if ($.fn.DataTable.isDataTable('#tblDataSenarai_vot')) {
                    // If it is, destroy the existing DataTable
                    var table = $('#tblDataSenarai_vot').DataTable();
                    table.destroy();
                }


                var totalDebit = 0;
                var totalKredit = 0;
                tbl = $("#tblDataSenarai_vot").DataTable({
                    // After initializing your DataTable, calculate the totals
                    "responsive": true,
                    "searching": true,
                    dom: 'Bfrtip',
                    "buttons": [
                        'csv', 'excel', {
                            extend: 'print',
                            text: '<i class="fa fa-files-o green"></i> Print',
                            titleAttr: 'Print',
                            className: 'ui green basic button',
                            action: function (e, dt, button, config) {

                                //config.pageLength = -1;

                                var printWindow = window.open('', '_blank');
                                printWindow.document.write('<html><head>');
                                printWindow.document.write('<style>@page { size: A4;  }</style>');
                                printWindow.document.write('<style>.a4-container { width: 100%; height: 29.7cm; margin: 1cm auto; }</style>'); // Add this line to set up the A4 container
                                printWindow.document.write('<style>#printTable_vot { border-collapse: collapse; } #printTable_vot th, #printTable_vot td { border: 2px solid #000; padding: 8px;  }</style>'); // Add table striping styles                  

                                printWindow.document.write('</head><body>');

                                // Add the A4 container here
                                printWindow.document.write('<div class="a4-container">');

                                // Append the header content to the print window
                                var headerContent = document.getElementById('headerreport').innerHTML;
                                printWindow.document.write(headerContent);

                                var selectedVot = document.getElementById('selectedVot').innerHTML;
                                // Wrap the selectedZon content in <strong> tags to make it bold
                                var boldSelectedVot = '<br><strong>' + selectedVot + '</strong>';
                                printWindow.document.write(boldSelectedVot);

                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed
                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed                       

                                printWindow.document.write('<table id="printTable_vot" style="width:100%"  >' +
                                    '<thead>' +
                                    '<tr>' +
                                    '<th scope="col" style="text-align: left;">Bil</th>' +
                                    '<th scope="col" style="text-align: left;">No Resit</th>' +
                                    '<th scope="col" style="text-align: left;">Tarikh</th>' +
                                    '<th scope="col" style="text-align: left;">Pembayar</th>' +
                                    '<th scope="col" style="text-align: left;">Kump Wang</th>' +
                                    '<th scope="col" style="text-align: left;">PTJ</th>' +
                                    '<th scope="col" style="text-align: right;">Debit (RM)</th>' +
                                    '<th scope="col" style="text-align: right;">Kredit (RM)</th>' +
                                    '<th scope="col" style="text-align: right;">Baki (RM)</th>' +
                                    '</tr>' +
                                    ' </thead>' +
                                    '</table > ');

                                // Create a DataTable for the print table
                                var printTable_vot = $('#printTable_vot', printWindow.document).DataTable({
                                    "pageLength": -1,
                                    "searching": false,
                                    "paging": false,
                                    "dom": 't', // Display table only (no info, pagination, etc.)
                                    "columns": [
                                        {
                                            "data": null, // Use null to provide a custom value
                                            "render": function (data, type, row, meta) {
                                                return meta.row + 1; // Add 1 to start numbering from 1
                                            },
                                            "width": "10%"
                                        },
                                        { "data": "No_Dok", "width": "20%", defaultContent: '-' },
                                        {
                                            "data": "Tkh_Daftar",
                                            "width": "20%",
                                            "render": function (data) {
                                                // Check if the data is a valid date
                                                if (data) {
                                                    var date = new Date(data);

                                                    // Format the date as "DD-MM-YYYY"
                                                    var formattedDate = date.getDate() + '-' + (date.getMonth() + 1) + '-' + date.getFullYear();

                                                    return formattedDate;
                                                }

                                                // Return the data as is if it's not a valid date
                                                return data;
                                            }

                                        },
                                        { "data": "Nama_Penghutang", "width": "20%", defaultContent: '-' },
                                        { "data": "Kod_Kump_Wang", "width": "20%", defaultContent: '-' },
                                        { "data": "Kod_PTJ", "width": "20%", defaultContent: '-' },
                                        {
                                            "data": "Debit",
                                            "width": "20%",
                                            "defaultContent": '-',
                                            "render": function (data, type, row) {
                                                if (type === 'display' && data !== null) {
                                                    var formattedDebit = parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                                    return '<div style="text-align: right;">' + formattedDebit + '</div>';
                                                }
                                                return data;
                                            }
                                        },
                                        {
                                            "data": "Kredit",
                                            "width": "20%",
                                            "defaultContent": '-',
                                            "render": function (data, type, row) {
                                                if (type === 'display' && data !== null) {
                                                    var formattedKredit = parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                                    return '<div style="text-align: right;">' + formattedKredit + '</div>';
                                                }
                                                return data;
                                            }
                                        },
                                        { "data": "Jumlah_Cukai", "width": "20%", defaultContent: '-' },
                                    ],
                                    "createdRow": function (row, data, dataIndex) {
                                        // You can use this callback to customize the appearance of rows if needed.
                                    }

                                    // ... other DataTable options
                                });

                                // Fetch and append the data from the original DataTable
                                var tableData = dt.rows().data().toArray();
                                for (var i = 0; i < tableData.length; i++) {
                                    printTable_vot.row.add(tableData[i]);
                                }

                                printTable_vot.draw();

                                var totalDebit = tableData.reduce(function (total, item) {
                                    return total + (parseFloat(item.Debit) || 0);
                                }, 0);

                                var totalCredit = tableData.reduce(function (total, item) {
                                    return total + (parseFloat(item.Kredit) || 0);
                                }, 0);

                                // Calculate Jumlah Pembatalan by subtracting totalCredit from totalDebit
                                var jumlahPembatalan = '';

                                // Calculate Jumlah Besar as the sum of total Debit and total Credit
                                var jumlahBesar_debit = totalDebit;
                                var jumlahBesar_kredit = totalCredit;

                                // Calculate Jumlah Bersih by subtracting Jumlah Pembatalan from Jumlah Besar
                                var jumlahBersih_debit = jumlahBesar_debit - jumlahPembatalan;
                                var jumlahBersih_kredit = jumlahBesar_kredit - jumlahPembatalan;

                                // Calculate Jumlah Keseluruhan by adding Jumlah Bersih to the total amount
                                var jumlahKeseluruhan_debit = jumlahBersih_debit;
                                var jumlahKeseluruhan_kredit = jumlahBersih_kredit;

                                printWindow.document.write('<table style="width: 100%;">' +
                                    '<tr>' +
                                    '<td colspan="2"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Besar (RM)</strong>&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + jumlahBesar_debit.toFixed(2) + '&ensp;</td>' +
                                    '<td class="right-align">' + jumlahBesar_kredit.toFixed(2) + '&ensp;</td>' +

                                    '</tr>' +
                                    '<tr>' +
                                    '<td colspan="2"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Pembatalan (RM)</strong>&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahPembatalan).toFixed(2) + '&ensp;</td>' +
                                    '</tr>' +
                                    '<tr>' +
                                    '<td colspan="2"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Bersih (RM)</strong>&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahBersih_debit).toFixed(2) + '&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahBersih_kredit).toFixed(2) + '&ensp;</td>' +

                                    '</tr>' +
                                    '<tr>' +
                                    '<td colspan="2"><br>&ensp;&ensp;&ensp;&ensp;&ensp;<strong>Jumlah Keseluruhan (RM)</strong>&ensp;&ensp;&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahKeseluruhan_debit).toFixed(2) + '&ensp;</td>' +
                                    '<td class="right-align">' + Math.abs(jumlahKeseluruhan_kredit).toFixed(2) + '&ensp;</td>' +

                                    '</tr>' +
                                    '</table>');

                                printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed

                                // Add the additional div with centered text
                                printWindow.document.write('<div style="text-align:center">');
                                printWindow.document.write('<span><strong>*** Laporan Tamat ***</strong></span>');
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
                        "url": "LejarPenghutangLaporanWS.asmx/GetAllTerimaanVot",
                        "type": "POST",
                        data: function (d) {
                            // console.log($('#MainContent_FormContents_DropDownList1').val()+" text " + $('#txtVotDari').val())
                            return "{ tkhMula: '" + $('#txtTarikhStart').val() + "', tkhTamat: '" + $('#txtTarikhEnd').val() + "', vot: '" + $('#ddlnoVot').val() + "'}";
                        },
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {

                            var data = JSON.parse(json.d);

                            var totalDebit = data.reduce(function (total, item) {
                                return total + (parseFloat(item.Debit) || 0);
                            }, 0);

                            var totalCredit = data.reduce(function (total, item) {
                                return total + (parseFloat(item.Kredit) || 0);
                            }, 0);

                            var jumlahKeseluruhan_debit = totalDebit;
                            var jumlahKeseluruhan_kredit = totalCredit;

                            document.getElementById('JumlahDebit').textContent = totalDebit.toFixed(2);
                            document.getElementById('JumlahKredit').textContent = totalCredit.toFixed(2);
                            //document.getElementById("JumlahBersih").textContent = jumlahBersih.toFixed(2);
                            document.getElementById('JumlahKeseluruhanDebit').textContent = jumlahKeseluruhan_debit.toFixed(2);
                            document.getElementById('JumlahKeseluruhanKredit').textContent = jumlahKeseluruhan_kredit.toFixed(2);

                            return data;
                        }
                    },



                    "columns": [
                        {
                            "data": null, // Use null to provide a custom value
                            "render": function (data, type, row, meta) {
                                return meta.row + 1; // Add 1 to start numbering from 1
                            },
                            "width": "10%"
                        },
                        { "data": "No_Dok", "width": "20%", defaultContent: '-' },
                        {
                            "data": "Tkh_Daftar",
                            "width": "20%",
                            "render": function (data) {
                                // Check if the data is a valid date
                                if (data) {
                                    var date = new Date(data);

                                    // Format the date as "DD-MM-YYYY"
                                    var formattedDate = date.getDate() + '-' + (date.getMonth() + 1) + '-' + date.getFullYear();

                                    return formattedDate;
                                }

                                // Return the data as is if it's not a valid date
                                return data;
                            }

                        },
                        { "data": "Nama_Penghutang", "width": "20%", defaultContent: '-' },
                        { "data": "Kod_Kump_Wang", "width": "20%", defaultContent: '-' },
                        { "data": "Kod_PTJ", "width": "20%", defaultContent: '-' },
                        {
                            "data": "Debit",
                            "width": "20%",
                            "defaultContent": '-',
                            "render": function (data, type, row) {
                                if (type === 'display' && data !== null) {
                                    var formattedDebit = parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                    return '<div style="text-align: right;">' + formattedDebit + '</div>';
                                }
                                return data;
                            }
                        },
                        {
                            "data": "Kredit",
                            "width": "20%",
                            "defaultContent": '-',
                            "render": function (data, type, row) {
                                if (type === 'display' && data !== null) {
                                    var formattedKredit = parseFloat(data).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR' });
                                    return '<div style="text-align: right;">' + formattedKredit + '</div>';
                                }
                                return data;
                            }
                        },


                        { "data": "Jumlah_Cukai", "width": "20%", defaultContent: '-' },
                    ],


                });
                $('.jumlah-subsection').show();

            } else {
                $('#tblDataSenarai_terimaan_harian').hide();
                $('.jumlah-subsection').hide();
                $('#tblDataSenarai_audit').hide();


            }


        });

        function beginSearch() {
            tbl.ajax.reload();
        }
    </script>
</asp:Content>