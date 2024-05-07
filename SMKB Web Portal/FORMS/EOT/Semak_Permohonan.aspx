<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Semak_Permohonan.aspx.vb" Inherits="SMKB_Web_Portal.Semak_Permohonan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js" crossorigin="anonymous"></script>
    <style>
     
          /*input CSS for placeholder */
        .input-group {
        margin-bottom: 20px;
        position: relative;
     
        }
        .input-group__label {
        display: block;
        position: absolute;
        top: 0;
        line-height: 40px;
        color: #aaa;
        left: 5px;
        padding: 0 5px;
        transition: line-height 200ms ease-in-out, font-size 200ms ease-in-out, top 200ms ease-in-out;
        pointer-events: none;
        }
        

        .input-group__input {
        width: 100%;
        height: 40px;
        border: 1px solid #dddddd;
        border-radius: 5px;
        padding: 0 10px;
        }
        .input-group__input:not(:-moz-placeholder-shown) + label {
        background-color: white;
        line-height: 10px;
        opacity: 1;
        font-size: 10px;
        top: -5px;
        }
        .input-group__input:not(:-ms-input-placeholder) + label {
        background-color: white;
        line-height: 10px;
        opacity: 1;
        font-size: 10px;
        top: -5px;
        }
        .input-group__input:not(:placeholder-shown) + label, .input-group__input:focus + label {
        background-color: white;
        line-height: 10px;
        opacity: 1;
        font-size: 10px;
        top: -5px;
        color:black;
        }
        .input-group__input:focus {
        outline: none;
        border: 1px solid #01080D;
        }
        .input-group__input:focus + label {
        color: #01080D;
        }
        .input-group__select + label {
        background-color: white;
        line-height: 10px;
        opacity: 1;
        font-size: 10px;
        top: -5px;
        color:black;
        }
        .input-group__select:focus + label {
        color: #01080D;
        }
        /* Styles for the focused dropdown */
        .input-group__select:focus {
        outline: none;
        border: 1px solid #01080D;
        }
        .input-group__label-floated {
        /* Apply styles for the floating label */
        /* For example: */
        top: -5px;
        font-size: 10px;
        line-height: 10px;
        color: #01080D;
        opacity: 1;
        }

        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
        }

        /* Firefox */
        input[type=number] {
        -moz-appearance: textfield;
        }
        .baccolor{
	        background-color:lightgray;
	    }
          /*end input CSS for placeholder */
      
    .pheader {
            /*text-align: center;*/ 
            font-size: 14px;
            font-weight: bold;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .pheader2 {
            /*text-align: center;*/ 
            font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }
        .dt-right{
            text-align:right;
        }

        .pheader3 {
            text-align: center;
            font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
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


        <div id="headerreport" class="header" style="display: none;">
            <table style="width=100%;">
                <tr>
                    <td style="width: 20%; text-align: right">
                        <img src="../../Images/logo.png" />
                        <%--<asp:Image ID="imgMyImage" runat="server" style="width:140px; Height:80px;text-align:right"/>--%>
                    </td>
                    <td style="width: 50%; text-align: center">
                        <p class="pheader"><strong>Universiti Teknikal Malaysia Melaka</strong></p>
                        <p class="pheader2">Hang Tuah Jaya,76100, Durian Tunggal,Melaka</p>
                        <p class="pheader2">No Tel: +606-270 1019  Fax:+606-331 6115</p>
                    </td>
                    <td style="width: 30%; text-align: right">
                        <span class="ptarikh">Tarikh : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span><br />
                         <span class="ptarikh">laporan : EOT001</span><br />
                      
                        <%--<span class="ptarikh">Pengguna : <%= Session("ssusrID") %></span>--%>

                    </td>
                </tr>
                 <tr>
                    <td></td>
                    <td style="text-align: center">
                        <br />
                         <p><strong>Laporan Transaksi OT :</strong>

                             <span id="lblNoMohonStafValue" class="lblNoMohonStaf"></span>
                         </p>
                  

                      
                        
                    </td>
                    <td style="width: 25%"></td>
                </tr>
                 <tr>
                   
                    <td style="text-align: left">
                     
                        <p><strong>No Staf :</strong>
                              <span id="lblNoStaf" class="lblNoStaf"></span>
                        </p>
                    
                    </td>
                   
                </tr>
                 <tr>
                   
                    <td style="text-align: left">
                     
                        <p><strong>Nama :</strong>
                            <span id="lblNama" class="lblNama" style="width:450px"></span>

                        </p>
                      
                    </td>
                   </tr>
                   <tr>
                 
                    <td style="text-align: left">
                     
                        <p><strong>Gaji Kasar :</strong>
                            <span id="lblGajiKasar" class="lblGajiKasar"></span>
                        </p>
                     
                    </td>
                   
                </tr>
               
               
            </table>
        </div>


        <!-- Modal -->
        <div id="permohonan">
            
                <div class="modal-content" >
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Semakan Permohonan Tuntutan Kerja Lebih Masa</h5>

                    </div>

                       <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                           
                            <div class="form-group row col-md-8">
                                <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align:right">Kategori :</label>
                                 <div class="col-sm-2">
                                    <div class="input-group">
                                      <select id="categoryFilterOT" class="input-group__select ui search dropdown categoryFilterOT" style="width:150%">
                                            <option value="0" selected="selected">Arahan Kerja</option>
                                            <option value="2">Permohonan OT</option>                                       
                                        </select>
                                    </div>
                                </div>

                                <label for="inputCarian" class="col-sm-2 col-form-label" style="text-align:right">Carian :</label>
                                <div class="col-sm-2">
                                    <div class="input-group">
                                        <select id="categoryFilter" class="input-group__select ui search dropdown categoryFilter">
                                            <option value="0">SEMUA</option>
                                            <option value="1" selected="selected">Hari Ini</option>
                                            <option value="2">Semalam</option>
                                            <option value="3">7 Hari Lepas</option>
                                            <option value="4">30 Hari Lepas</option>
                                            <option value="5">60 Hari Lepas</option>
                                            <option value="6">Pilih Tarikh</option>
                                        </select>
                                         
                                    </div>
                                 </div>
                                <div class="col-sm-2">

                                    <button id="btnSearch" runat="server" class="btn btnSearch" type="button">
                                           
                                                <i class="fa fa-search"></i>
                                            </button>
                                </div>
                               
                                
                           <div class="col-md-5">
                                    <div class="form-row">
                                         <div class="form-group col-md-5">
                                           <br />
                                        </div>
                                    </div>
                               </div>
                                <div class="col-md-11">
                                    <div class="form-row">
                                        <div class="form-group col-md-1">
                                            <label id="lblMula" style="text-align: right;display:none;"  >Mula: </label>
                                        </div>
                                        
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display:none;" class="form-control date-range-filter">
                                        </div>
                                         <div class="form-group col-md-1">
                                     
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label id="lblTamat" style="text-align: right;display:none;" >Tamat: </label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display:none;" class="form-control date-range-filter">
                                        </div>
                                    </div>
                                </div>
                                 

                            </div>
                        </div>
                   </div>


                    <div class=" -body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans" class="table table-striped"   style="width: 95%">
                                    <thead>
                                        <tr>                                          
                                            <th scope="col">No. Permohonan</th>
                                            <th scope="col">No. Arahan</th>
                                            <th scope="col">No. Staf</th>
                                            <th scope="col">Nama</th>
                                            <th scope="col">Pejabat</th>
                                            <th scope="col">Singkatan Pejabat</th>
                                            <th scope="col">No IC</th>
                                            <th scope="col">Tarikh Mohon</th>
                                            <th scope="col">Status</th> 
                                            
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


                   <!-- Modal -->
    <div class="modal fade" id="infoOTstaf" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="fMCTitle">Laporan Transaksi OT</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                           
                           <div class="form-row"> 
                                <div class="form-group col-md-4">
                                        <label for="txtNomohonOT" class="input-group__label"  style="cursor: pointer;">No. Mohon :  </label>
                                     <asp:TextBox runat="server" ID="txtNomohonOT" ReadOnly="true" Style="width: 50%;"  ></asp:TextBox> 
                                  
                                                       
                                </div>

                           </div>
                           <div class="form-row">
                                <div class="form-group col-md-2">
                                       <label for="txtNostaf">No. Staf :</label>
                                     <asp:TextBox runat="server" ID="txtNostaf" ReadOnly="true" Style="width: 30%;" ></asp:TextBox> 
                                  
                                                       
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="txtNamaOT">Nama :</label>  
                                    <asp:TextBox runat="server" ID="txtNamaOT"  ReadOnly="true" Style="width: 80%;" ></asp:TextBox> 
                                                                                         
                                </div>

                                 <div class="form-group col-md-4">
                                       <label for="txtGajiKasar">Gaji Kasar :</label>     
                                      <asp:TextBox runat="server" ID="txtGajiKasar"  ReadOnly="true" Style="width: 30%;text-align: right"></asp:TextBox>
                                                                                                             
                                </div>
                               
                            </div>
                          <div class="form-row">
                                        <div class="col-md-12">
                                           
                                            <br />
                                            <div class="transaction-table table-responsive">
                                                <table id="tblData2" class="table table-striped" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                           
                                                            <th scope="col">Jam Tuntut</th>
                                                            <th scope="col">Kadar Tuntut</th> 
                                                            <th scope="col">Amaun Tuntut</th>
                                                            <th scope="col">Jam Sah</th>
                                                            <th scope="col">Kadar Sah</th> 
                                                            <th scope="col">Amaun Sah</th>
                                                            <th scope="col">Jam Lulus</th>
                                                            <th scope="col">Kadar Lulus</th> 
                                                            <th scope="col">Amaun Lulus</th>
                                                            <th scope="col">Jam Terima</th>
                                                            <th scope="col">Kadar Terima</th> 
                                                            <th scope="col">Amaun Terima</th>
                                                            
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tableID2">
                                               
                                                    </tbody>               
                                                   <tfoot>
                                                       
                                                        <tr>
                                                            <td colspan ="4"></td>
                                                            <td colspan ="4"><strong>Jumlah Keseluruhan</strong></td>&nbsp;&nbsp
                                                            <%--<td>
                                                                <input  type="text" class="form-control" id="totalKadar" runat="server"  style="text-align: right; font-weight: bold" width="10%" value="0.000" readonly />
                                                            </td>--%>
                                                            <td>
                                                               
                                                                <%--<input class="form-control" id="totalAmaunNomohon"  runat="server"  style="text-align: center; font-weight: bold" width="10%" value="0.00" readonly />--%>
                                                                  <span id="totalAmaunNomohonP" class="totalAmaunNomohonP"></span>
                                                            
                                                            </td>
                                                       </tr>
                                                    </tfoot>            
                                            </table>                             
                                            </div>
                                        </div>
                                </div>
             </div>
         </div>
        </div>
       </div>
    </div>
 

<script type="text/javascript">
    var isClicked = false;
    var tbl = null;
    var tbl1 = null;
    var curNumObject = 0;
    var nomohonStaf = "";
    $(document).ready(function () {
       
        tbl = $("#tblDataSenarai_trans").DataTable({
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
            "ajax": {
                "url": "Transaksi_EOTs.asmx/LoadSemakanPermohonan",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                },

                 data: function () {
                    //Filter date bermula dari sini - 20 julai 2023
                    var startDate = $('#txtTarikhStart').val()
                     var endDate = $('#txtTarikhEnd').val()
                   
                    return JSON.stringify({
                        category_filter: $('#categoryFilter').val(),
                        category_OT : $('#categoryFilterOT').val(),
                        isClicked: isClicked,
                        tkhMula: startDate,
                        tkhTamat: endDate
                    })
                    //akhir sini
                }
            },

            "columns": [
                {
                    "data": "No_Mohon",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }
                        var link = `<td style="width: 10%" >
                                                <label id="lblNoMohon" name="lblNoMohon" class="lblNoMohon" value="${data}" style="color: blue; cursor: pointer;" <a id="lnk" class="lblNoMohon" href="#">${data}</a></label>
                                                <input type ="hidden" class = "lblNoMohon" value="${data}"/>
                                            </td>`;
                        return link;
                    }
                },
                { "data": "No_Arahan", width: '10%' },
                { "data": "No_Staf", width: '5%' },
                { "data": "nama", width: '10%' },
                { "data": "NPejabat", width: '20%' },
                { "data": "Pejabat", width: '10%'},
                { "data": "MS01_KpB", width: '10%' },
                { "data": "Tkh_Mohon", width: '5%' },
                { "data": "Butiran", width: '20%' }
                
            ]

        });
    

    $("#categoryFilter").change(function (e) {

        var selectedItem = $('#categoryFilter').val()
        if (selectedItem == "6") {
            $('#txtTarikhStart').show();
            $('#txtTarikhEnd').show();

            $('#lblMula').show();
            $('#lblTamat').show();

            $('#txtTarikhStart').val("")
            $('#txtTarikhEnd').val("")
        }
        else {
            $('#txtTarikhStart').hide();
            $('#txtTarikhEnd').hide();

            $('#txtTarikhStart').val("")
            $('#txtTarikhEnd').val("")

            $('#lblMula').hide();
            $('#lblTamat').hide();

        }

    });


        tbl1 = $("#tblData2").DataTable({
            "responsive": true,
            "searching": false,
            dom: 'Bfrtip',
            buttons: [
                'csv', 'excel',  {
                    extend: 'print',
                    text: '<i class="fa fa-files-o green"></i> Print',
                    titleAttr: 'Print',
                    className: 'ui green basic button',
                    action: function (e, dt, button, config) {
                        var printWindow = window.open('', '_blank');
                        printWindow.document.write('<html><head>');
                        printWindow.document.write('<style>@page { size: A4 landscape; margin: 1cm; }</style>');
                        printWindow.document.write('<style>.a4-container { width: 30cm; height: 29.7cm; margin: 1cm auto; }</style>'); // Add this line to set up the A4 container

                        printWindow.document.write('<style>#tblData2 th, #tblData2_rpt th { background-color: lightgrey; }</style>'); // Add this line to set the background color of header cells
                        printWindow.document.write('<style>#tblData2 thead tr { background-color: lightgrey; }</style>'); // Add this line to set the background color of header row
                        
                        printWindow.document.write('<style>#tblData2 { border-collapse: collapse; } #tblData2 th, #tblData2_rpt td { border: 1px solid #000; padding: 8px; }</style>'); // Add table striping styles
                        printWindow.document.write('</head><body>');

                        // Add the A4 container here
                        printWindow.document.write('<div class="a4-container">');

                        // Append the header content to the print window
                        var headerContent = document.getElementById('headerreport').innerHTML;
                        printWindow.document.write(headerContent);

                        printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed

                        // Append the table content
                        var tableContent = document.getElementById('tblData2').outerHTML;

                        tableContent = tableContent.replace('<table', '<table style="text-align: center;"');

                        // Set the style for the second column's data cells (left-aligned)
                        tableContent = tableContent.replace(/<td>(.*?)<\/td>/g, '<td style="text-align: left;">$1</td>');
                        printWindow.document.write(tableContent);

                        printWindow.document.write('<div style="height: 20px;"></div>'); // Adjust the height as needed

                        // Add the additional div with centered text
                        printWindow.document.write('<div style="text-align:center">');
                       
                        printWindow.document.write('</div>');

                        // Close the A4 container
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
                "sLengthMenu": "Tunjuk _MENU_ rekod",
                "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                "sEmptyTable": "Tiada rekod.",
                "sSearch": "Carian"
            },
            "ajax": {
                "url": "Transaksi_EOTs.asmx/fnLaporanOTInd",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: function () {
                    console.log(nomohonStaf)
                    return JSON.stringify({ NoMohon: nomohonStaf });

                },
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                }

            },
        
            "columns": [
               
                {
                    "data": "Jum_Jam_Tuntut",
                    "render": function (data, type, row, meta) {
                        if (type === 'display') {
                            const formattedNumber = parseFloat(data).toFixed(0);
                            return formattedNumber.padStart(4, '0');
                        } else {
                            return parseFloat(data);
                        }
                    }
                   
                },
                {
                    "data": "Kadar_Tuntut",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {

                            return parseFloat(data).toFixed(3);
                        }
                        return data;
                    }
                },
                {
                    "data": "Amaun_Tuntut",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(2);
                         
                        }
                        return data;
                    }
                },
               
                {
                    "data": "Jum_Jam_Sah",
                    render: function (data, type, row, meta) {
                        if (type === 'display') {
                            const formattedNumber = parseFloat(data).toFixed(0);
                            return formattedNumber.padStart(4, '0');
                        } else {
                            return parseFloat(data);
                        }
                     
                    }
                },
                {
                    "data": "Kadar_Sah",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(3);
                        }
                        return data;
                    }
                },
                {
                    "data": "Amaun_Sah",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(2);
                          
                        }
                        return data;
                    }
                },
                {
                    "data": "Jum_Jam_Lulus",
                    render: function (data, type, row, meta) {
                      
                        if (type === 'display') {
                            const formattedNumber = parseFloat(data).toFixed(0);
                            return formattedNumber.padStart(4, '0');
                        } else {
                            return parseFloat(data);
                        }
                    }
                },
                {
                    "data": "Kadar_Lulus",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(3);
                        }
                        return data;
                    }
                },
                {
                    "data": "Amaun_Lulus",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(2);
                        
                        }
                        return data;
                    }
                },
                {
                    "data": "Jum_Jam_Terima",
                    render: function (data, type, row, meta) {
                        if (type === 'display') {
                            const formattedNumber = parseFloat(data).toFixed(0);
                            return formattedNumber.padStart(4, '0');
                        } else {
                            return parseFloat(data);
                        }
                        
                    }
                },
                {
                    "data": "Kadar_Terima",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(3);
                        }
                        return data;
                    }
                },
                {
                    "data": "Amaun_Terima",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(2);
                          
                        }
                        return data;
                    }
                }
            ],

            "columnDefs": [
                { targets: 0, width: '8%', className: 'dt-right' },
                { targets: 1, width: '8%', className: 'dt-right' },
                { targets: 2, width: '8%', className: 'dt-right' },
                { targets: 3, width: '8%', className: 'dt-right' },
                { targets: 4, width: '8%', className: 'dt-right' },
                { targets: 5, width: '8%', className: 'dt-right' },
                { targets: 6, width: '8%', className: 'dt-right' },
                { targets: 7, width: '8%', className: 'dt-right' },
                { targets: 8, width: '8%', className: 'dt-right' },
                { targets: 9, width: '8%', className: 'dt-right' },
                { targets: 10, width: '8%', className: 'dt-right' },
                { targets: 11, width: '8%', className: 'dt-right' },
            
            ],

            "drawCallback": function (settings) {
                var api = this.api();
                var counter = 0;
                var listofdata = api.rows().data();
                var totaldata = listofdata.length;
                var jumlahAmaun = 0.00;

                while (counter < totaldata) {

                    jumlahAmaun += parseFloat(listofdata[counter].Amaun_Terima)
                    console.log(jumlahAmaun)
                    counter += 1;
                }


                var fixedAmaun = parseFloat(jumlahAmaun).toFixed(2);

              //  $('#MainContent_FormContents_totalAmaunNomohon').val(fixedAmaun);
                $('.totalAmaunNomohonP').html(fixedAmaun);

                // Output the data for the visible rows to the browser's console
            }
        });


    });


    $('.btnSearch').click(async function () {
        isClicked = true;
        tbl.ajax.reload();

    })
        var tableID_Senarai = "#tblDataSenarai_trans";
    var searchQuery = "";
    var curNumObject = 0;
        var oldSearchQuery = "";
        var objMetadata = [{
            "obj1": {
                "id": "",
                "oldSearchQurey": "",
                "searchQuery": ""
            }
        }, {
            "obj2": {
                "id": "",
                "oldSearchQurey": "",
                "searchQuery": ""
            }
        }]

    $('#tblDataSenarai_trans').on('click', '.lblNoMohon', function () {

        var nomohon = $(this).closest('tr').find('td:eq(0)').text().trim();
        var nostaf = $(this).closest('tr').find('td:eq(2)').text().trim();
      
      
        $('#<%=txtNomohonOT.ClientID%>').val(nomohon);
        $('.lblNoMohonStaf').text(nomohon);
        getDataPeribadiPemohon(nostaf)
        $('#infoOTstaf').modal('toggle');
       
        nomohonStaf = nomohon;
       
        tbl1.ajax.reload();

          

    });


    function getDataPeribadiPemohon(nostaf) {

        fetch('Transaksi_EOTs.asmx/GetUserInfo', {
            method: 'POST',
            headers: {

                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ nostaf: nostaf })
        })
            .then(response => response.json())
            .then(data => setDataPeribadi(data.d))
    }
    
    function setDataPeribadi(data) {

        data = JSON.parse(data);

        if (data.StafNo === "") {
            Notification("Tiada data");
            return false;
        }

       


        $('#<%=txtNamaOT.ClientID%>').val(data[0].Param1);
        $('#<%=txtNostaf.ClientID%>').val(data[0].StafNo);
        $('#<%=txtGajiKasar.ClientID%>').val(data[0].MS02_JumlahGajiS.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }));

        $('.lblNoStaf').text(data[0].StafNo);
        $('.lblNama').text(data[0].Param1);
        $('.lblGajiKasar').text(data[0].MS02_JumlahGajiS.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }));

    }

</script>
        </div>




</asp:Content>
