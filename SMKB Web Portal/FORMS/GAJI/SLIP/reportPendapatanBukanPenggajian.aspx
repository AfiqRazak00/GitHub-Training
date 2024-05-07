<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="reportPendapatanBukanPenggajian.aspx.vb" Inherits="SMKB_Web_Portal.reportPendapatanBukanPenggajian" %>


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
            font-size: 17px;
            margin-top:0px!important;
            margin-bottom:0px!important;
        }

        .pheader3 {
            font-size: 20px;
            margin-top:0px!important;
            margin-bottom:0px!important;
        }
        th, td {
            padding: 1px;
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
                     <td style="width: 20%;text-align: right; padding-right:15px; padding-left:80px" >
                         <asp:Image ID="imgMyImage" runat="server" style="width:180px; Height:100px;text-align:right"/>
                     </td>
                      <td style="text-align:left; padding-left:15px; position: relative; font-size: 14px">
                         <div style="border-left: 2px solid #000; height: 90%; position: absolute; left: 0;"></div>
                         <p style="margin:0px;" class="pheader"><asp:label ID="lblNamaKorporat" runat="server"></asp:label></p>
                         <p class="pheader2" style="margin:0px;"><asp:label ID="lblAlamatKorporat" runat="server"></asp:label></p>
                           <p class="pheader2" style="margin:0px;"><asp:label ID="lblNoTelFaks" runat="server"></asp:label></p>
                          <p class="pheader2" style="margin:0px;"><asp:label ID="lblEmailKorporat" runat="server"></asp:label></p>
                     </td>
                 </tr>
             </table>
              <hr style="border-top: 2px solid #000; margin-top: 10px; margin-bottom: 10px;">
         </div> <%--close header report--%>
          <div id="bodyreport">
            <p style="text-align:center; font-size:18px; font-weight:bold;">LAPORAN PENYATA PENDAPATAN BUKAN PENGGAJIAN<br /> TAHUN : <span id="year"></span></p>
           
            <br />
            <table id="tblMaklumat" style="width:100%; text-align: left;"> 
                <tr>
                    <td>No. Siri</td>
                    <td>: 1</td>
                    <td colspan="2"></td>
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
                    <td>Bilangan Anak Dibawah 18 Tahun Pada 31/12/<span id="currentYear"></span></td>
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
              <table style="width: 100%" id="tblSenaraiPenyata">
                  <thead>
                      <tr style="font-weight: bold; border-bottom: 2px solid black; font-size: 15px !important; text-align:center;">
                          <th>TARIKH</th>
                          <th>NO. DOKUMEN</th>
                          <th>JENIS/TUJUAN BAYARAN</th>
                          <th>AMAUN (RM)</th>
                      </tr>
                  </thead>
                  <tbody>

                  </tbody>
                  <tfoot>
                      <tr>
                          <td colspan="2"></td>
                          <td style="text-align:right; padding-right: 20px;">JUMLAH BESAR (RM)</td>
                          <td id="totalAmaun"></td>
                      </tr>
                  </tfoot>
              </table>
              <br />
              <br />
              <br />
              <p><i>Nota : Slip ini adalah cetakan berkomputer dan tidak memerlukan tandatangan</i></p>
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
             $("#currentYear").text(getYear);
             $("#year").text(getYear);

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
                     }
                     fetchTbl();
                 },
                 error: function (error) {
                     console.error("Error parsing JSON response:", error); // Access the error message directly
                 }
             });
         }

         function fetchTbl() {
             tbl = $("#tblSenaraiPenyata").DataTable({
                 "responsive": false,
                 "searching": false,
                 "info": false,
                 "paging": false,
                 "ajax": {
                     "url": "Slip_WS.asmx/fetchTblDetails",
                     method: 'POST',
                     data: function (d) {
                         return "{ year: '" + getYear + "'}";
                     },
                     "contentType": "application/json; charset=utf-8",
                     "dataType": "json",
                     "dataSrc": function (json) {
                         return JSON.parse(json.d);
                     }

                 },
                 "columns": [
                     { "data": "Tarikh" },
                     { "data": "No_Baucar" },
                     { "data": "Butiran" },
                     {
                         "data": "Jumlah",
                         "render": function (data, type, row) {
                             if (type === 'display' || type === 'filter') {
                                 return '<div style="text-align: right;">' + data + '</div>';
                             }
                             return data;
                         }
                     }
                 ],
                 "footerCallback": function (row, data, start, end, display) {
                     var api = this.api();
                     var total = api.column(3).data().reduce(function (a, b) {
                         return parseFloat(a) + parseFloat(b);
                     }, 0);

                     // Set the id and style to the footer element
                     var footer = $(api.column(3).footer());
                     footer.attr("id", "totalAmaun");
                     footer.css("font-size", "inherit");
                     footer.css("font-weight", "normal");
                     footer.css("text-align", "right")
                     footer.css("border-top", "2px solid black");
                     footer.css("border-bottom", "2px solid black");

                     // Update the content of the footer with the calculated total
                     footer.html(parseFloat(total).toLocaleString(undefined, { minimumFractionDigits: 2 }));
                 },
                 "initComplete": function (settings, json) {
                     window.print();
                 }
             });
         }
     </script>
</body>

