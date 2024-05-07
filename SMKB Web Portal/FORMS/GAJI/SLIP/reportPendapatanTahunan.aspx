<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="reportPendapatanTahunan.aspx.vb" Inherits="SMKB_Web_Portal.reportPendapatanTahunan" %>

<script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>
 <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
 <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

    <style>
        body {
            width: 210mm; /* A4 width */
            height: 297mm; /* A4 height */
            margin: 0 auto; /* Center content on page */
        }
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
            font-weight: bold;
           font-size: 17px;
            margin-top:0px!important;
            margin-bottom:0px!important;
        }

        .pheader2 {
            font-size: 14px;
            margin-top:0px!important;
            margin-bottom:0px!important;
        }

        .pheader3 {
            font-size: 20px;
            margin-top:0px!important;
            margin-bottom:0px!important;
        }

        th, td {
            padding: 2px;
        }

        #tblCukai tbody {
            font-size: 12px;
            padding: 3px;
        }

         #tblMaklumat tbody {
            font-size: medium;
            padding: 3px;
        }

        #tblTidakCukai tbody {
            font-size: 12px;
            padding: 3px;
        }

        #tblPotongan tbody {
            font-size: 12px;
            padding: 3px;
        }

          .gridview-style {
            border-collapse: collapse;
        }

        .gridview-style th, .gridview-style td {
            border: 1px solid black;
            padding: 10px;
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
<body>
     <div id="PermohonanTab" class="tabcontent" style="display: block">
          <div id="headerreport">
             <table style="width:100%"> 
                  <tr>
                     <td style="width: 20%;text-align: right; padding-left:200px" >
                         <asp:Image ID="imgMyImage" runat="server" style="width:140px; Height:80px;text-align:right"/>
                     </td>
                      <td style="text-align:left; padding-left:15px; position: relative;">
                         <p style="margin:0px;" class="pheader">UNIVERSITI TEKNIKAL MALAYSIA MELAKA</p>
                         <p class="pheader" style="margin:0px;">LAPORAN PENYATA PENDAPATAN TAHUNAN</p>
                          <p class="pheader" style="margin:0px;">TAHUN : <asp:label ID="selectedYear" runat="server"></asp:label></p>
                     </td>
                 </tr>
             </table>
              <hr style="border-top: 2px solid #000; margin-top: 10px; margin-bottom: 10px;">
         </div> <%--close header report--%>
          <div id="bodyreport">
            <table id="tblMaklumat" style="width:100%; text-align: left;"> 
                <tr>
                    <td style="font-weight: bold; text-decoration: underline;">Maklumat Diri</td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td style="width: 20%;">No. Fail Majikan</td>
                    <td style="width: 45%;">: <span id ="noFailMajikan"></span></td>
                    <td style="width: 20%;">No. Fail Cukai</td>
                    <td style="width: 15%;">: <span id ="noFailCukai"></span></td>
                </tr>
                <tr>
                    <td>Nama</td>
                    <td>: <span id ="nama"></span></td>
                    <td>Jantina</td>
                    <td>: <span id ="jantina"></span></td>
                </tr>
                <tr>
                    <td>No. K/P</td>
                    <td>: <span id ="noKP"></span></td>
                    <td>No. Staf</td>
                    <td>: <span id ="noStaf"></span></td>
                </tr>
                <tr>
                    <td>Jabatan</td>
                    <td>: <span id ="jabatan"></span></td>
                    <td>No. KWSP</td>
                    <td>: <span id ="noKWSP"></span></td>
                </tr>
                <tr>
                    <td>Alamat Kediaman</td>
                    <td>: <span id ="alamat1"></span></td>
                    <td>No. Pencen</td>
                    <td>: <span id ="noPencen"></span></td>
                </tr>
                 <tr>
                     <td rowspan="2"></td>
                    <td>  <span id ="alamat2"></span></td>
                    <td>No. Perkeso</td>
                    <td>: <span id ="noPerkeso"></span></td>
                </tr>
                 <tr>
                    <td>  <span id ="negeri"></span></td>
                    <td>Tarikh Berhenti Kerja</td>
                    <td>: <span id ="trkhBerhentiKerja"></span></td>
                </tr>
                <tr>
                    <td>Jawatan</td>
                    <td>: <span id ="jawatan"></span></td>
                    <td>Tarikh Perkahwinan</td>
                    <td>: <span id ="trkhKahwin"></span></td>
                </tr>
                <tr>
                    <td>Tarikh Mula Bekerja</td>
                    <td>: <span id ="trkhMulaKerja"></span></td>
                    <td>Taraf Perkahwinan</td>
                    <td>: <span id ="tarafKahwin"></span></td>
                </tr>
                <tr style="height: 20px; display: block;" colspan="4"></tr>
                <tr> 
                    <td style="font-weight: bold; text-decoration: underline;">Maklumat Pasangan</td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td>Nama Suami/Isteri</td>
                    <td>: <span id ="namaPasangan"></span></td>
                    <td>No. KP Lama Suami/Isteri</td>
                    <td>: <span id ="noKPLamaPasangan"></span></td>
                </tr>
                <tr>
                    <td>No KP Baru Suami/Isteri</td>
                    <td>: <span id ="noKPBaruPasangan"></span></td>
                    <td>Bilangan Anak Dibawah 18 Tahun Pada 31/12/2018</td>
                    <td>: <span id ="bilAnak"></span></td>
                </tr>
                <tr>
                    <td>Alamat Tempat Kerja Suami/Isteri</td>
                    <td>: <span id ="alamatKerjaPasangan"></span></td>
                    <td>No. Fail Cukai Suami/Isteri</td>
                    <td>: <span id ="noFailCukaiPasangan"></span></td>
                </tr>
                <tr>
                    <td rowspan="3"></td>
                    <td>  <span id ="alamat1Pasangan"></span></td>
                    <td rowspan="3"></td>
                </tr>
                <tr>
                    <td>  <span id ="alamat2Pasangan"></span></td>
                </tr>
                <tr>
                    <td>  <span id ="negeriPasangan"></span></td>
                </tr>
            </table>
            <br />
              <table style="width:100%; text-align:center;">
                  <colgroup>
                    <col style="width: 20%;">
                    <col span="13" style="width: 6.15%;">
                </colgroup>
                  <thead>
                    <tr style="font-weight: bold; border-bottom: 2px solid black; font-size: 14px !important; ">
                        <th style="text-align:left;">PERKARA</th>
                        <th>JAN</th>
                        <th>FEB</th>
                        <th>MAC</th>
                        <th>APRIL</th>
                        <th>MEI</th>
                        <th>JUN</th>
                        <th>JULAI</th>
                        <th>OGOS</th>
                        <th>SEPT</th>
                        <th>OKT</th>
                        <th>NOV</th>
                        <th>DIS</th>
                        <th>JUMLAH</th>
                    </tr>
                    <tr style="font-weight: bold; font-size: 13px;">
                        <th style="text-align:left;">PENDAPATAN</th>
                        <th colspan="13"></th>
                    </tr>
                  </thead>
              </table>
            <table id="tblCukai" style="width:100%;"> 
                <colgroup>
                    <col style="width: 20%;">
                    <col span="13" style="width: 6.15%;">
                </colgroup>
                <thead>
                    <tr style="text-decoration: underline; font-size: 12px; ">
                        <th style="font-weight: normal;">PENDAPATAN BERCUKAI</th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot>
                    <tr>
                         <td colspan="13"></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
              <table id="tblTidakCukai" style="width:100%;"> 
                   <colgroup>
                        <col style="width: 20%;">
                        <col span="13" style="width: 6.15%;">
                    </colgroup>
                <thead>
                    <tr style="text-decoration: underline; font-size: 12px; ">
                        <th style="font-weight: normal;">PENDAPATAN TIDAK BERCUKAI</th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                 <tfoot>
                    <tr>
                         <td colspan="13"></td>
                        <td></td>
                    </tr>
                     <tr>
                         <td style="font-weight: bold; font-size: 13px;">JUMLAH PENDAPATAN</td>
                         <td colspan="12"></td>
                         <td id="totalJumlahPendapatan" style="font-size: 12px; font-weight: normal; text-align: right; border-top: 2px solid black; border-bottom: 2px solid black"></td>
                     </tr>
                </tfoot>
            </table>
              <br />
              <br />
              <br />
              <table id="tblPotongan" style="width:100%;"> 
                   <colgroup>
                        <col style="width: 20%;">
                        <col span="13" style="width: 6.15%;">
                    </colgroup>
                <thead>
                    <tr>
                        <th style="font-weight: bold; font-size: 13px;">POTONGAN</th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                 <tfoot>
                    <tr>
                        <td style="font-weight: bold; font-size: 13px;">JUMLAH POTONGAN</td>
                         <td colspan="12"></td>
                        <td></td>
                    </tr>
                     <tr>
                         <td colspan="14" style="height: 50px;"></td>
                     </tr>
                     <tr>
                         <td style="font-weight: bold; font-size: 13px;">JUMLAH PENDAPATAN BERSIH</td>
                         <td colspan="12"></td>
                         <td style="font-size: 12px; border-top: 2px solid black; border-bottom: 2px solid black; text-align: right" id="jumlahPendapatanBersih"></td>
                     </tr>
                </tfoot>
            </table>
            <br />
            <p id="printDate" style="font-weight: bold; font-size: 13px;"></p>

        </div> <%--close body report--%>
    </div>
   <script>
       // Get the query string from the URL
       var queryString = window.location.search;

       // Create a URLSearchParams object from the query string
       var queryParams = new URLSearchParams(queryString);

       // Get the value of the "year" parameter
       var getYear = queryParams.get('year');

       $(document).ready(function () {
           // Get the current date and time
           var currentDate = new Date();

           // Format the date
           var day = currentDate.getDate();
           var month = currentDate.getMonth() + 1;
           var year = currentDate.getFullYear();

           // Format the time
           var hours = currentDate.getHours();
           var minutes = currentDate.getMinutes();
           var seconds = currentDate.getSeconds();

           // Add leading zero if needed
           day = (day < 10 ? "0" : "") + day;
           month = (month < 10 ? "0" : "") + month;
           hours = (hours < 10 ? "0" : "") + hours;
           minutes = (minutes < 10 ? "0" : "") + minutes;
           seconds = (seconds < 10 ? "0" : "") + seconds;

           // Create the formatted date and time string
           var formattedDateTime = day + "/" + month + "/" + year + " " + hours + ":" + minutes + ":" + seconds;

           // Set the formatted date and time into the <p> element
           document.getElementById("printDate").textContent = "PENYATA INI ADALAH CETAKAN BERKOMPUTER DAN TIDAK MEMERLUKAN TANDATANGAN. TARIKH CETAKAN: " + formattedDateTime;

           $.ajax({
               url: "Slip_WS.asmx/fetchUserDetails",
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (response) {
                   // Parse the JSON string within the "d" property
                   var responseData = JSON.parse(response.d);
                   // Check if responseData is an array and has at least one element
                   if (Array.isArray(responseData) && responseData.length > 0) {
                       // Access the properties of the first element
                      // $("#noFailMajikan").text(responseData[0].Nama);
                       $("#noFailCukai").text(responseData[0].NoCukai);
                       $("#nama").text(responseData[0].Nama);
                       $("#jantina").text(responseData[0].Jantina);
                       $("#noKP").text(responseData[0].KpB);
                       $("#noStaf").text(responseData[0].NoStaf);
                       $("#jabatan").text(responseData[0].NamaPejabat);
                       $("#noKWSP").text(responseData[0].NoKwsp);
                       var optionText = responseData[0].AlamatT1 + ',' + responseData[0].AlamatT2;
                       $("#alamat1").text(optionText);
                       $("#noPencen").text(responseData[0].NoPencen);
                       var optionText2 = responseData[0].PoskodT + ' ' + responseData[0].BandarT;
                       $("#alamat2").text(optionText2);
                       $("#noPerkeso").text(responseData[0].NoPerkeso);
                       $("#negeri").text(responseData[0].NamaNegeri);
                       $("#trkhBerhentiKerja").text(responseData[0].TarikhBerhenti);
                       $("#jawatan").text(responseData[0].NamaJawatan);
                       $("#trkhKahwin").text(responseData[0].TarikhNikahSp);
                       $("#trkhMulaKerja").text(responseData[0].TarikhKhidmat);
                       $("#tarafKahwin").text(responseData[0].TarafKahwin);
                       $("#namaPasangan").text(responseData[0].NamaSp);
                       $("#noKPLamaPasangan").text(responseData[0].KpLSp);
                       $("#noKPBaruPasangan").text(responseData[0].KpBSp);
                       $("#alamatKerjaPasangan").text(responseData[0].NamaMSp);
                       $("#noFailCukaiPasangan").text(responseData[0].NoCukaiSp);
                       var optionText3 = responseData[0].AlamatM1Sp + ' ' + responseData[0].AlamatM2Sp;
                       $("#alamat1Pasangan").text(optionText3);
                       var optionText4 = responseData[0].PoskodMSp + ' ' + responseData[0].BandarMSp;
                       $("#alamat2Pasangan").text(optionText4);
                       $("#negeriPasangan").text(responseData[0].NamaNegeriSp);

                       fetchChild();
                   }
               },
               error: function (error) {
                   console.error("Error parsing JSON response:", error); // Access the error message directly
               }
           });
       });
       function fetchChild() {
           $.ajax({
               url: "Slip_WS.asmx/fetchUserChild",
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               data: JSON.stringify({ year: getYear }),
               success: function (response) {
                   // Parse the JSON string within the "d" property
                   var responseData = JSON.parse(response.d);
                   // Check if responseData is an array and has at least one element
                   if (Array.isArray(responseData) && responseData.length > 0) {
                       // Access the properties of the first element
                       $("#bilAnak").text(responseData[0].BilAnak);
                       fetchMajikan();
                   }
               },
               error: function (error) {
                   console.error("Error parsing JSON response:", error); // Access the error message directly
               }
           });
       }

       function fetchMajikan() {
           $.ajax({
               url: "Slip_WS.asmx/fetchNoMajikan",
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (response) {
                   // Parse the JSON string within the "d" property
                   var responseData = JSON.parse(response.d);
                   // Check if responseData is an array and has at least one element
                   if (Array.isArray(responseData) && responseData.length > 0) {
                       // Access the properties of the first element
                       $("#noFailMajikan").text(responseData[0].No_Cukai);
                       callTblCukai();
                   }
               },
               error: function (error) {
                   console.error("Error parsing JSON response:", error); // Access the error message directly
               }
           });
       }

       function callTblCukai() {
           tblCukai = $("#tblCukai").DataTable({
               "searching": false,
               "info": false,
               "paging": false,
               "ajax": {
                   "url": "Slip_WS.asmx/fetchCukaiTbl",
                   method: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   "data": function () {
                       return JSON.stringify({
                           year: getYear
                       })
                   },
                   "dataSrc": function (json) {
                       return JSON.parse(json.d);
                   }

               },
               "columns": [
                   { "data": "Butiran" },
                   { "data": "1" },
                   { "data": "2" },
                   { "data": "3" },
                   { "data": "4" },
                   { "data": "5" },
                   { "data": "6" },
                   { "data": "7" },
                   { "data": "8" },
                   { "data": "9" },
                   { "data": "10" },
                   { "data": "11" },
                   { "data": "12" },
                   { "data": "Total" }
               ],
               "columnDefs": [
                   {
                       "targets": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
                       "render": function (data, type, row) {
                           // Convert the data to a number with two decimal places
                           var formattedNumber = parseFloat(data).toFixed(2);
                           // Add thousand separators
                           formattedNumber = parseFloat(formattedNumber).toLocaleString(undefined, { minimumFractionDigits: 2 });
                           return formattedNumber;
                       },
                       "className": "text-right"
                   }
               ],
               "footerCallback": function (row, data, start, end, display) {
                   var api = this.api();
                   var total = api.column(13).data().reduce(function (a, b) {
                       return parseFloat(a) + parseFloat(b);
                   }, 0);

                   // Set the id and style to the footer element
                   var footer = $(api.column(13).footer());
                   footer.attr("id", "totalCukaiFooter");
                   footer.css("font-size", "12px");
                   footer.css("font-weight", "normal");
                   footer.css("border-top", "2px solid black");

                   // Update the content of the footer with the calculated total
                   footer.html(parseFloat(total).toLocaleString(undefined, { minimumFractionDigits: 2 }));
               },
               "initComplete": function (settings, json) {
                   callTblTidakCukai();
               }
           });
       }

       function callTblTidakCukai() {
           tblTidakCukai = $("#tblTidakCukai").DataTable({
               "searching": false,
               "info": false,
               "paging": false,
               "ajax": {
                   "url": "Slip_WS.asmx/fetchTidakCukaiTbl",
                   method: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   "data": function () {
                       return JSON.stringify({
                           year: getYear
                       })
                   },
                   "dataSrc": function (json) {
                       return JSON.parse(json.d);
                   }
               },
               "columns": [
                   { "data": "Butiran" },
                   { "data": "1" },
                   { "data": "2" },
                   { "data": "3" },
                   { "data": "4" },
                   { "data": "5" },
                   { "data": "6" },
                   { "data": "7" },
                   { "data": "8" },
                   { "data": "9" },
                   { "data": "10" },
                   { "data": "11" },
                   { "data": "12" },
                   { "data": "Total" }
               ],
               "columnDefs": [
                   {
                       "targets": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
                       "render": function (data, type, row) {
                           // Convert the data to a number with two decimal places
                           var formattedNumber = parseFloat(data).toFixed(2);
                           // Add thousand separators
                           formattedNumber = parseFloat(formattedNumber).toLocaleString(undefined, { minimumFractionDigits: 2 });
                           return formattedNumber;
                       },
                       "className": "text-right"
                   }
               ],
               "footerCallback": function (row, data, start, end, display) {
                   var api = this.api();
                   var total = api.column(13).data().reduce(function (a, b) {
                       return parseFloat(a) + parseFloat(b);
                   }, 0);

                   // Set the id and style to the footer element
                   var footer = $(api.column(13).footer());
                   footer.attr("id", "totalTidakCukaiFooter");
                   footer.css("font-size", "12px");
                   footer.css("font-weight", "normal");
                   footer.css("border-top", "2px solid black");

                   // Update the content of the footer with the calculated total
                   footer.html(parseFloat(total).toLocaleString(undefined, { minimumFractionDigits: 2 }));
               },
               "initComplete": function (settings, json) {
                   // Calculate the sum of footer values from both tables
                   var totalCukai = parseFloat($('#totalCukaiFooter').text().replace(/,/g, ''));
                   var totalTidakCukai = parseFloat($('#totalTidakCukaiFooter').text().replace(/,/g, ''));
                   var totalJumlahPendapatan = totalCukai + totalTidakCukai;

                   // Display the total sum in totalJumlahPendapatan element
                   $('#totalJumlahPendapatan').text(totalJumlahPendapatan.toLocaleString(undefined, { minimumFractionDigits: 2 }));
                   callTblPotongan();
               }
           });
       }

       function callTblPotongan() {
           tblPotongan = $("#tblPotongan").DataTable({
               "searching": false,
               "info": false,
               "paging": false,
               "ajax": {
                   "url": "Slip_WS.asmx/fetchPotongan",
                   method: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   "data": function () {
                       return JSON.stringify({
                           year: getYear
                       })
                   },
                   "dataSrc": function (json) {
                       return JSON.parse(json.d);
                   }
               },
               "columns": [
                   { "data": "Butiran" },
                   { "data": "1" },
                   { "data": "2" },
                   { "data": "3" },
                   { "data": "4" },
                   { "data": "5" },
                   { "data": "6" },
                   { "data": "7" },
                   { "data": "8" },
                   { "data": "9" },
                   { "data": "10" },
                   { "data": "11" },
                   { "data": "12" },
                   { "data": "Total" }
               ],
               "columnDefs": [
                   {
                       "targets": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
                       "render": function (data, type, row) {
                           // Convert the data to a number with two decimal places
                           var formattedNumber = parseFloat(data).toFixed(2);
                           // Add thousand separators
                           formattedNumber = parseFloat(formattedNumber).toLocaleString(undefined, { minimumFractionDigits: 2 });
                           return formattedNumber;
                       },
                       "className": "text-right"
                   }
               ],
               "footerCallback": function (row, data, start, end, display) {
                   var api = this.api();
                   var total = api.column(13).data().reduce(function (a, b) {
                       return parseFloat(a) + parseFloat(b);
                   }, 0);

                   // Set the id and style to the footer element
                   var footer = $(api.column(13).footer());
                   footer.attr("id", "totalPotongan");
                   footer.css("font-size", "12px");
                   footer.css("font-weight", "normal");
                   footer.css("border-top", "2px solid black");
                   footer.css("border-bottom", "2px solid black");

                   // Update the content of the footer with the calculated total
                   footer.html(parseFloat(total).toLocaleString(undefined, { minimumFractionDigits: 2 }));
               },
               "initComplete": function (settings, json) {
                   // Calculate the sum of footer values from both tables
                   var totalJumlahPendapatan = parseFloat($('#totalJumlahPendapatan').text().replace(/,/g, ''));
                   var totalPotongan = parseFloat($('#totalPotongan').text().replace(/,/g, ''));
                   var jumlahPendapatanBersih = totalJumlahPendapatan - totalPotongan;
                   console.log(jumlahPendapatanBersih);

                   // Display the total sum in jumlahPendapatanBersih element
                   $('#jumlahPendapatanBersih').text(jumlahPendapatanBersih.toLocaleString(undefined, { minimumFractionDigits: 2 }));
                   window.print();
               }
           });
       }
   </script>

</body>
