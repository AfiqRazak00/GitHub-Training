<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="report_Senarai_Perbelajaan_Pesanan_Tempatan.aspx.vb" Inherits="SMKB_Web_Portal.report_Senarai_Perbelajaan_Pesanan_Tempatan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js" crossorigin="anonymous"></script>



    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

    <!-- Optional theme -->

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous" />

    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="https://printjs-4de6.kxcdn.com/print.min.js"></script>

    <script src="https://cdn.datatables.net/rowgroup/1.1.4/js/dataTables.rowGroup.min.js"></script>

    <title></title>

    <style>
        .align-right{
            text-align: right;
        }

       .subtotal-label {
        border-top: 2px solid #000; 
/*        display: block; */ 
       padding-top: 2px; 
        }

        .subtotal-label2 {
        border-top: 2px solid #000; 
        border-bottom: 2px solid #000; 
/*        display: block; */
        padding-top: 2px; 
        padding-bottom: 2px; 
        }

        .subtotal-label3 {
        border-top: 2px solid #000; 
        border-bottom: 4px double #000; 
/*        display: block; 
*/      padding-top: 2px; 
        padding-bottom: 2px; 
        }

        table {
            border-collapse:separate;
        }
        .top-border {
            border-top: 1px solid black;
            min-width: 250px;
        }

        .topbottom-border{
            border-top: 1px solid black;
            border-bottom: 3px double black;
            min-width: 250px;
        }

        body {
            font-family: Arial, sans-serif;
            /*font-size: 12px!important;*/
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

        .pheader3 {
            text-align: center;
            font-size: 14px;
            margin-top:0px!important;
            margin-bottom:0px!important;
        }



        .ptarikh {
            font-size: 12px;
            margin-top:0px!important;
            margin-bottom:0px!important;

        }

        table {
            width: 100%;
        }

        th, td {
            padding: 1px;
        }

        .headerkiri {
            text-align: center;
        }

        .valuekanan {
            text-align: right;
        }

        .valuetengah {
            text-align:center;
        }

        .bold {
            font-weight: bold;
        }


         .table-custom th, .table-custom td {
            border: 0.5px solid black;
         }

         element.style {
                text-align: center;
                 border-right: 1px solid black; 
                width: 18px;
            }
            .table>thead>tr>th {
                 vertical-align: bottom; 
                 border-bottom: 0.5px solid #000; 
            }
            .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
                padding: 8px;
                line-height: 1.42857143;
                vertical-align: top;
                 border-top: 0.5px solid #000; 
            }


        @media print {

            .header, .header-space,
            .footer, .footer-space {
                height: 230px;
            }

            .header {
                position: fixed;
                top: 0;
            }

            .table-data{
                
                padding-top:200px;
            }



            .col-md-2 {
                float: right;
                /* margin-top: -50px; */
            }

            .print-div {
                break-after:page;
            }

            .print-div:last-child {
                page-break-after: auto;

            }

            .printButton {
                display: none !important;
            }

            #printButton {
                display: block;
            }

            #header, #nav, .noprint {
                display: none;
            }


        }

        @page {
        size: A4!important; /* or letter, legal, etc. */
        margin: 1cm; /* adjust margins as needed */
        }

        .auto-style1 {
            width: 25%;
        }

        .auto-style2 {
            width: 48%;
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div id="masterdiv" class="container">

                   <div class="header" id="headerreport" >
                    <table style="width: 100%"> 
                        <thead >
                         <tr>
                            <td style="width: 20%;text-align:right">
                                <asp:Image ID="imgMyImage" runat="server" style="width:140px; Height:80px;text-align:right"/>
                            </td>
                            <td style="width: 50%;text-align:left">
                                <p class="pheader"><strong><asp:label ID="lblNamaKorporat" runat="server"></asp:label></strong></p>
                                <p class="pheader2" style="font-size:12px!important;text-transform: capitalize"><asp:label ID="lblAlamatKorporat" runat="server"></asp:label></p>
                                <p class="pheader2" style="font-size:12px!important"><asp:label ID="lblNoTelFaks" runat="server"></asp:label></p>
                                <p class="pheader2" style="font-size:12px!important"><asp:label ID="lblEmailKorporat" runat="server"></asp:label></p>

                            </td>
                            <td style="width: 30%; text-align: right">
                                <span class="ptarikh">Tarikh : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span><br />
                                <span class="ptarikh">Laporan : CLS006</span><br />
                                <span class="ptarikh">Pengguna : <%= Session("ssusrID") %></span>

                            </td>
                        </tr>
                            </thead>
                        <tr>
                            <td></td>
                            <td style="text-align:center">
                                <br />
                                <p class="pheader3">PENUTUPAN AKAUN BAGI TAHUN BERAKHIR 31 DISEMBER  <%= Session("tahun") %></p>
                                <p class="pheader3">SENARAI PERBELANJAAN  - PEMIUTANG - PEMBEKAL/STAF  <asp:label runat="server" id="tahun"></asp:label></p>
                                <p class="pheader3"> JENIS : PESANAN TEMPATAN </p>
                            </td>
                             <td style="width: 25%"></td>

                        </tr>
                    </table>
                </div> <%--close header report--%>
                <br />

            <div  id="printreportcashflow">
               <table id="tblDataSenarai_LejarPemiutangPesananTempatan" class="table table-custom" >
                          <thead>
                              <tr class="header-space">
                              </tr>
                             <tr>
                                 <th scope="col" style="border:none"></th>
                                 <th scope="col" style="border:none"></th>
                                 <th scope="col" style="border:none"></th>
                                 <th scope="col" style="border:none"></th>
                                 <th scope="col" style="border:none"></th>
                                 <th scope="col" style="border:none"></th>
                                 <th scope="col" style="border:none"></th>
                                 <th scope="col" style="border:none"></th>
                                 <th scope="col" style="border:none"></th>
                             </tr>
                         </thead>
                         <tbody id="data-table-body" >
                
                         </tbody>
                           <tr id="sum-row">
                                 <td colspan="6" style="text-align:right; border-top:1px solid #000;">JUMLAH KESELURUHAN (RM)</td>
                                 <td id="sum-amaun-sebenar" style="text-align:right; border-top:1px solid #000;">0.00</td>
                                 <td colspan="3" border-top:1px solid #000;></td>
                             </tr>
                     </table>
               <br /><br /><br />
  
            <div class="">
                <table class="table">

                  <tbody>
                       <tr class="header-space">
                        </tr>
                    <tr >
                      <td style="border-top:0.5px solid #fff;">
                         <p class="mb-5">Disediakan Oleh :</p>
                         <p class="mt-5" style="margin-top:70px;">.......................................................</p>
                         <p style="margin-top: -15px;">Penolong Akauntan</p>
                      </td>
                      <td style="border-top:0.5px solid #fff;">
                        <p class="mb-5">Disediakan Oleh :</p>
                        <p class="mt-5" style="margin-top:70px;">.......................................................</p>
                        <p style="margin-top: -15px;">Ketua Unit</p>
                      </td>
                      <td style="border-top:0.5px solid #fff;">
                        <p class="mb-5">Disediakan Oleh :</p>
                        <p class="mt-5" style="margin-top:70px;">.......................................................</p>
                        <p style="margin-top: -15px;">Ketua Bahagian</p>
                      </td>
                    </tr>
                  </tbody>
                </table>
            </div>
             <div style="text-align:center">
                <span>
                    <strong>*** Laporan Tamat ***</strong>
                </span>
            </div>
            </div>
        </div>
        <%--close master div--%>
    </form>





             <script type="text/javascript">

                 var tbl = null;

                 $(document).ready(function () {


                     tbl = $("#tblDataSenarai_LejarPemiutangPesananTempatan").DataTable({
                         "responsive": false,
                         "searching": false,
                         cache: false,
                         paging: false,
                         "ajax":
                         {
                             "url": "<%=ResolveClientURL("~/FORMS/Pembayaran/LAPORAN/LejarPemiutangWS.asmx/LoadOrderRecord_PembayaranInvoisPesananTempatan")%>",
                             type: 'POST',
                             data: function (d) {
                                 return "{tahun: '', kod_kw3: ''}"
                             },
                             "contentType": "application/json; charset=utf-8",
                             "dataType": "json",
                             "dataSrc": function (json) {
                                 return JSON.parse(json.d);
                             }


                         },

                         "columns": [

                       
                             { "data": "Nama_Pemiutang" },
                             { "data": "No_PTempatan" },
                             { "data": "No_Invois" },
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
                             { "data": "Butiran" },
                             { "data": "APValue" },

                         ],
                         "rowGroup": {
                             dataSrc: "Kod_PTJ1_with_Zeros", // Column to group by

                             startRender: function (rows, group) {
                                 var columnTitles = '<tr>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">NAMA PEMBEKAL</th>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">NO PT</th>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">NO INVOIS</th>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">TARIKH INVOIS</th>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">KW</th>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">KOD VOT</th>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">JUMLAH (RM)</th>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">BUTIRAN</th>' +
                                     '<th style="text-align:center;border-right:1px solid lightgrey;">NOMBOR AP</th>' +
                                     '</tr>';

                                 var header = '<tr><th colspan="10" scope="col" style="border:none;  padding-top:30px;">PTj: ' + group + '</th></tr>';
                                 var repeatHeader = '<tr class="repeated-header">' + header + '</tr>';

                                 return $(repeatHeader + columnTitles );

                             },
                             endRender: function (rows, group) {
                                 var sum = rows.data().pluck('Jumlah_Bayar').reduce(function (a, b) {
                                     return a + b;
                                 }, 0);

                                 var sumAdd = sum.toLocaleString(undefined, {
                                     minimumFractionDigits: 2,
                                     maximumFractionDigits: 2,
                                 });
                                 return $('<tr/>')
                                     .append('<td colspan="6" style="text-align: center; border: none; ">' + 'JUMLAH (RM)' + '</td>')
                                     .append('<td class="group-sum" style="text-align: end; border: none; ">' + sumAdd + '</td>');
                             },
                         },
                         "drawCallback": function () {
                             var api = this.api();
                             var sum = api.column(6).data().reduce(function (a, b) {
                                 return parseFloat(a) + parseFloat(b);
                             }, 0);

                             // Format the sum with commas as thousands separators and limit to two decimal places
                             var formattedSum = sum.toLocaleString(undefined, {
                                 minimumFractionDigits: 2,
                                 maximumFractionDigits: 2,
                             });

                             $("#sum-amaun-sebenar").text(formattedSum);
                         }
                     });


                 setTimeout(() => {
                     callPrint()
                 }
                     , 1000);

             });



                 function callPrint() {
                     if (window.addEventListener) {
                         //getData();
                         window.print();
                     } else {
                         window.print();


                     }
                 }



             </script>    

</body>
</html>
