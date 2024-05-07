<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CetakLaporanPengumuran.aspx.vb" Inherits="SMKB_Web_Portal.CetakLaporanPengumuran" %>

 <script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>
 <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
 <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

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
        th, td {
            padding: 1px;
            font-size: 12px;
            text-align: center;
        }
          .gridview-style {
            border-collapse: collapse;
        }

        .gridview-style th, .gridview-style td, .gridview-style thead th {
            border: 1px solid black;
            padding: 5px;
        }

        .dataTables_info {
            display: none;
        }

         @media print {
            @page {
               size: A4 landscape; /* or letter, legal, etc. */
               margin: 1cm;
            }

            .auto-style1 {
                width: 25%;
            }

            .auto-style2 {
                width: 48%;
            }
        }

    </style>
    <body>
         <div id="PermohonanTab" class="tabcontent" style="display: block">
              <div id="headerreport">
                 <table style="width:100%"> 
                      <tr>
                         <td style="width: 20%;text-align: right; padding-right:15px" >
                             <asp:Image ID="imgMyImage" runat="server" style="width:160px; Height:100px;text-align:right"/>
                         </td>
                          <td style="text-align: center; position: relative; font-size: 20px; ">
                              <p style="margin-top:40px; margin-bottom:0px"><strong>LAPORAN PENGUMURAN (AGING) HASIL TUNTUTAN TERTUNGGAK</strong></p>
                              <p style="margin-top: 0px; margin-bottom:5px"><strong>PADA :  <%= DateTime.Now.ToString("dd/MM/yyyy") %></strong></p>
                               <p style="font-size:15px; margin-bottom:0px"><asp:label ID="votButiranDisplay" runat="server"></asp:label></p>                       
                          </td>
                     </tr>
                 </table>
             </div> <%--close header report--%>
             <table id="tblVot" class="table table-striped gridview-style" style="width: 100%; margin-top: 10px">
                 <thead>
                     <tr>
                         <th rowspan="3" style="width: 1%">Bil</th>
                         <th rowspan="3" style="width: 15%">Hasil - hasil Universiti</th>
                         <th rowspan="3" style="width: 2%">Vot</th>
                         <th rowspan="3" style="width: 2%">KW</th>
                         <td colspan="14"> </td>
                         <th rowspan="2" colspan="2">Jumlah Tunggakan</th>
                     </tr>
                     <tr style="font-weight:bold">
                         <td colspan="2">0 > 30 Hari</td>
                         <td colspan="2">> 1 bln hingga 3 bln</td>
                         <td colspan="2">> 3 bln hingga 7 bln</td>
                         <td colspan="2">> 7 bln hingga 12 bln</td>
                         <td colspan="2">> 12 bln hingga 36 bln</td>
                         <td colspan="2">> 36 bln hingga 72 bln</td>
                         <td colspan="2">> 72 bln</td>
                     </tr>
                     <tr style="font-weight:bold">
                        <td style="width: 3%">Bil</td>
                        <td style="width: 7%">RM</td>
                        <td style="width: 3%">Bil</td>
                        <td style="width: 7%">RM</td>
                        <td style="width: 3%">Bil</td>
                        <td style="width: 7%">RM</td>
                        <td style="width: 3%">Bil</td>
                        <td style="width: 7%">RM</td>
                        <td style="width: 3%">Bil</td>
                        <td style="width: 7%">RM</td>
                        <td style="width: 3%">Bil</td>
                        <td style="width: 7%">RM</td>
                        <td style="width: 3%">Bil</td>
                        <td style="width: 7%">RM</td>
                        <td style="width: 3%">Bil</td>
                        <td style="width: 7%">RM</td>
                     </tr>
                 </thead>
                 <tbody id="tblVotBody">

                 </tbody>
                 <tfoot>
                    <tr id="totalRow">
                        <td colspan="4" style="text-align: center">JUMLAH</td>
                        <td class="align-right" id="sumBIL_30">0</td>
                        <td class="align-right" id="sumJumlah_30">0</td>
                        <td class="align-right" id="sumBIL_90">0</td>
                        <td class="align-right" id="sumJumlah_90">0</td>
                        <td class="align-right" id="sumBIL_210">0</td>
                        <td class="align-right" id="sumJumlah_210">0</td>
                        <td class="align-right" id="sumBIL_365">0</td>
                        <td class="align-right" id="sumJumlah_365">0</td>
                        <td class="align-right" id="sumBIL_1080">0</td>
                        <td class="align-right" id="sumJumlah_1080">0</td>
                        <td class="align-right" id="sumBIL_2160">0</td>
                        <td class="align-right" id="sumJumlah_2160">0</td>
                        <td class="align-right" id="sumBIL_2161">0</td>
                        <td class="align-right" id="sumJumlah_2161">0</td>
                        <td class="align-right" id="sumBIL">0</td>
                        <td class="align-right" id="sumJumlah">0</td>
                        <!-- Add the rest of the columns with colspan and class attributes as needed -->
                    </tr>
                </tfoot>
             </table>
         </div>
<script type="text/javascript">
    var tbl = null;
    $(document).ready(function () {
        const params = new URLSearchParams(window.location.search);
        const vot = params.get('kodvot');

        tbl = $("#tblVot").DataTable({
            "responsive": false,
            "searching": false,
            "paging": false, // Disable paging
            "ajax": {
                url: "LejarPenghutangLaporanWS.asmx/LoadOrderRecord_Pengumuran",
                type: "POST",
                data: function (d) {
                    return "{ vot: '" + vot + "'}"
                },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                }
            },
            "columns": [
                { "data": "Bil" },
                { "data": "Butiran" },
                { "data": "Kod_Vot" },
                { "data": "Kod_Kump_Wang" },
                {
                    "data": "BIL_30",
                    "className": "align-right"
                },
                {
                    "data": "Jumlah_30", "render": function (data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        }
                        return data;
                    },
                    "className": "align-right"
                },
                {
                    "data": "BIL_90",
                    "className": "align-right"
                },
                {
                    "data": "Jumlah_90", "render": function (data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        }
                        return data;
                    },
                    "className": "align-right"
                },
                {
                    "data": "BIL_210",
                    "className": "align-right"
                },
                {
                    "data": "Jumlah_210", "render": function (data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        }
                        return data;
                    },
                    "className": "align-right"
                },
                {
                    "data": "BIL_365",
                    "className": "align-right"
                },
                {
                    "data": "Jumlah_365", "render": function (data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        }
                        return data;
                    },
                    "className": "align-right"
                },
                {
                    "data": "BIL_1080",
                    "className": "align-right"
                },
                {
                    "data": "Jumlah_1080", "render": function (data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        }
                        return data;
                    },
                    "className": "align-right"
                },
                {
                    "data": "BIL_2160",
                    "className": "align-right"
                },
                {
                    "data": "Jumlah_2160", "render": function (data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        }
                        return data;
                    },
                    "className": "align-right"
                },
                {
                    "data": "BIL_2161",
                    "className": "align-right"
                },
                {
                    "data": "Jumlah_2161", "render": function (data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        }
                        return data;
                    },
                    "className": "align-right"
                },
                {
                    "data": "bil_keseluruhan",
                    "className": "align-right"
                },
                {
                    "data": "jumlah_keseluruhan", "render": function (data, type, row) {
                        if (type === 'display') {
                            return parseFloat(data).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        }
                        return data;
                    },
                    "className": "align-right"
                },
            ],
            "footerCallback": function (row, data, start, end, display) {
                var api = this.api();
                var totalBil30 = api
                    .column(4) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var sumJumlah30 = api
                    .column(5) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var totalBil90 = api
                    .column(6) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var sumJumlah90 = api
                    .column(7) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var totalBil210 = api
                    .column(8) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var sumJumlah210 = api
                    .column(9) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var totalBil365 = api
                    .column(10) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var sumJumlah365 = api
                    .column(11) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var totalBil1080 = api
                    .column(12) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var sumJumlah1080 = api
                    .column(13) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var totalBil2160 = api
                    .column(14) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var sumJumlah2160 = api
                    .column(15) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var totalBil2161 = api
                    .column(16) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var sumJumlah2161 = api
                    .column(17) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var totalBil = api
                    .column(18) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var sumJumlah = api
                    .column(19) // Index of the "BIL_30" column (0-based index)
                    .data()
                    .reduce(function (a, b) {
                        return parseFloat(a) + parseFloat(b);
                    }, 0);

                var jumlah30 = parseFloat(sumJumlah30).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                var jumlah90 = parseFloat(sumJumlah90).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                var jumlah210 = parseFloat(sumJumlah210).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                var jumlah365 = parseFloat(sumJumlah365).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                var jumlah1080 = parseFloat(sumJumlah1080).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                var jumlah2160 = parseFloat(sumJumlah2160).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                var jumlah2161 = parseFloat(sumJumlah2161).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                var jumlah = parseFloat(sumJumlah).toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

                $(api.column(4).footer()).html(totalBil30); // Update the footer with the total
                $(api.column(5).footer()).html(jumlah30);
                $(api.column(6).footer()).html(totalBil90);
                $(api.column(7).footer()).html(jumlah90);
                $(api.column(8).footer()).html(totalBil210);
                $(api.column(9).footer()).html(jumlah210);
                $(api.column(10).footer()).html(totalBil365);
                $(api.column(11).footer()).html(jumlah365);
                $(api.column(12).footer()).html(totalBil1080);
                $(api.column(13).footer()).html(jumlah1080);
                $(api.column(14).footer()).html(totalBil2160);
                $(api.column(15).footer()).html(jumlah2160);
                $(api.column(16).footer()).html(totalBil2161);
                $(api.column(17).footer()).html(jumlah2161);
                $(api.column(18).footer()).html(totalBil);
                $(api.column(19).footer()).html(jumlah);
            }
        });
    });
    window.onload = function () {
        setTimeout(function () {
            window.print();
        }, 1000); // Adjust the delay if necessary
    }
</script>
    </body>
