<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="KW_Gaji.aspx.vb" Inherits="SMKB_Web_Portal.KW_Gaji" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
   <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
  <style>


       .card {
          border: none;
          border-top-left-radius: 0;
          border-top-right-radius: 0;
          position: relative;
          z-index: 3;
          margin-bottom: 30px;
      }

      .card-wrapper {
          margin-bottom: 100px;
      }

      .card-title {
          background-color: white;
          padding: 10px;
          margin-top: -15px;
          /*z-index: 2;*/
      }

      .gradient-card {
       
          color: white;
          border: 10px;
          padding-top: 10px;
          padding-bottom: 30px;
      }


      .gradient-header {
          color: black;
          background-color: white;
          padding-top: 15px;
          padding-bottom: 15px;
      }

      .card-footer {
          padding: 10px 20px;
          text-align: center;
      }

      .card-body {
          padding: 20px;
      }

      .rounded-top-icon {
          text-align: center;
          margin-top: -30px;
          position: absolute;
          top: -100px;
          left: 30%;
          padding-top: 40px;
          z-index: -2;
      }

          .rounded-top-icon i {
              background-color: white;
              border-radius: 100%;
              padding: 30px;
              box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.5);
          }

      .chart-container {
          position: relative;
          margin: auto;
          height: 40vh;
          width: 35vw;
      }
  </style>
  
  <div id="PermohonanTab" class="tabcontent" style="display: block">

      <!-- Modal -->
      <div id="permohonan">
          
              <div class="modal-content" >
                

                  <div class="container">
                            
                            <div class="row justify-content-center">
                                <div class="col-md-9">
                                    <div class="form-row">
                                        <div class="col-md-3 order-md-1">
                                            </div>
                                        <div class="col-md-2 order-md-1">
                                            <div class="form-group">
                                                <label for="txtTarikh1" style="display: block; text-align: center; width: 100%;">Bulan</label>
                                               <select id="ddlMonths" runat="server" class="ui fluid search dropdown selection custom-select">
                                                    <option value="">-- Sila Pilih --</option>
                                                    <option value="1">Januari</option>
                                                    <option value="2">Februari</option>
                                                    <option value="3">Mac</option>
                                                    <option value="4">April</option>
                                                    <option value="5">Mei</option>
                                                    <option value="6">Jun</option>
                                                    <option value="7">Julai</option>
                                                    <option value="8">Ogos</option>
                                                    <option value="9">September</option>
                                                    <option value="10">Oktober</option>
                                                    <option value="11">November</option>
                                                    <option value="12">Disember</option>
                                                </select>
                                            </div>
                                            </div>

                                        <div class="col-md-2 order-md-1">
                                            <div class="form-group">
                                                <label for="txtNoRujukan1" style="display: block; text-align: center; width: 100%;">Tahun</label>
                                                <select id="ddlyear" runat="server" class="ui fluid search dropdown selection custom-select">
                                                    <option value="">-- Sila Pilih --</option>
                                                    <option value="2019">2019</option>
                                                    <option value="2020">2020</option>
                                                    <option value="2021">2021</option>
                                                    <option value="2022">2022</option>
                                                    <option value="2023">2023</option>
                                                    <option value="2024">2024</option>
                                                </select>
                                            </div>
                                        </div>
                    
                                        <div class="col-md-4 order-md-1">
                                            <div class="form-group">
                                                <label></label>
                                                <button runat="server" class="btn btnSearch" type="button" style="margin-top: 33px">
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                  <hr />

                            <div id="dashboard" class="tabcontent" style="display: block">

<%--      <div class="col-md-12">
          <div class="form-row justify-content-center">
              <div class="col-md-4 card-deck">
                  <div class="card bg-info text-center">
                      <p class="card-text text-white font-weight-bold">Bayaran Gaji</p>
                      <span  style="font-size:20px;font-weight:bold" class="bg-white jumLulus"></span>
                  </div>
              </div>

              <div class="col-md-4 card-deck">
                  <div class="card bg-success text-center">
                      <p class="card-text text-white font-weight-bold">Bayaran Elaun</p>
                      <span style="font-size:20px; font-weight:bold" class="bg-white jumBLulus"></span>
                  </div>
              </div>

            

          </div>
 

      </div>--%>
      <div class="col-md-12 container">
            <div class="form-row justify-content-center">
                 <div class="col-md-3" style="z-index: 3;top: 80px;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #fbdaac;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                 <b>JUMLAH GAJI</b>
                            </div>
                            <div class="card-body">
                                 <span  style="font-size:15px;font-weight:bold;color:black" class="jumLulus"></span><br />
                                 <span  style="font-size:15px;font-weight:bold;color:black" class="gaji"></span><br />
                                 <span  style="font-size:15px;font-weight:bold;color:black" class="bonus"></span><br />
                                 <span  style="font-size:15px;font-weight:bold;color:black" class="ot"></span><br />
                                 <span  style="font-size:15px;font-weight:bold;color:black" class="ott"></span>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fas la-file-invoice fa-4x shadow h-auto" style="color: #d0581c"></i>
                        </div>
                    </div>
                </div>

               <div class="col-md-3" style="z-index: 3;top: 80px;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #b7f7fe;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>JUMLAH ELAUN</b>
                            </div>
                            <div class="card-body">
                                <span  style="font-size:15px;font-weight:bold;color:black" class="jumElaun"></span><br />
                                <span  style="font-size:15px;font-weight:bold;color:black" class="itka"></span><br />
                                <span  style="font-size:15px;font-weight:bold;color:black" class="itp"></span><br />
                                <span  style="font-size:15px;font-weight:bold;color:black" class="itk"></span><br />
                                <span  style="font-size:15px;font-weight:bold;color:black" class="sara"></span>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fas la-hand-holding-usd shadow h-auto" style="color: #f1ac88;font-size:48px;"></i>
                        </div>
                    </div>
                </div>

                <div class="col-md-3" style="z-index: 3;top: 80px;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #fab1b1;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>JUMLAH POTONGAN</b>
                            </div>
                            <div class="card-body">
                                <span  style="font-size:15px;font-weight:bold;color:black" class="jumPot"></span><br />
                                <span  style="font-size:15px;font-weight:bold;color:black" class="kwsp"></span><br />
                                <span  style="font-size:15px;font-weight:bold;color:black" class="perkeso"></span><br />
                                <span  style="font-size:15px;font-weight:bold;color:black" class="pencen"></span><br />
                                <span  style="font-size:15px;font-weight:bold;color:black" class="cukai"></span>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fas la-clock fa-4x shadow h-auto" style="color: #f1ac88;"></i>
                        </div>
                    </div>
                </div>
        </div>
       </div>
     <div class="col-xl-16"  style="z-index: 3;">
     <div class="row">
         <!-- Bar Chart -->
         <div class="col-xl-16 col-md-6 mb-4">
             <div class="card shadow">
                 <!-- Card Header - Dropdown -->
                 <div
                     class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                     <h8 class="m-0 font-weight-bold " style="color:darkslategrey">Jumlah Bayaran OT Mengikut PTj</h8>
                 </div>
                 <!-- Card Body -->
                 <div class="card-body">
                     <div id="bar" class="chart-bar pt-4 pb-2 chart-container">
                         <canvas id="barChart"></canvas>
                     </div>
                 </div>

             </div>
         </div>

     </div>
 </div> 
<%--     <div class="col-md-12">
          <div class="row">
              <!-- Bar Chart -->
              <div class="col-xl-6 col-md-6 mb-4">
                  <div class="card shadow">
                      <!-- Card Header - Dropdown -->
                      <div
                          class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                          <h6 class="m-0 font-weight-bold " style="color:darkslategrey">Jumlah Pemohon OT Mengikut Tahun</h6>
                      </div>
                      <!-- Card Body -->
                      <div class="card-body">
                          <div id="bar" class="chart-bar pt-4 pb-2 chart-container">
                              <canvas id="barChart"></canvas>
                          </div>
                      </div>

                  </div>
              </div>

          </div>
      </div> --%>
    </div>
              </div>


</div>

      <script type="text/javascript">
          var $chartBulan = null;
          var TotalTerima = 0;
          var TotalElaun = 0;
          $(document).ready(function () {
              $('.btnSearch').click(async function () {
                  var promises = [];
                  var vBln = $('#<%=ddlMonths.ClientID%>').val();
                  var vThn = $('#<%=ddlyear.ClientID%>').val();

                  if ($chartBulan !== null) {
                      $chartBulan.destroy();
                  }

                  $('.jumLulus').html("0.00");
                  $('.jumBLulus').html("0.00");

                  //Pie();
                  //bar();

                  promises.push($.ajax({
                      url: '<%=ResolveClientUrl("~/FORMS/GAJI/PROSES/Proses_WS.asmx/LoadBayarOT")%>',
                      method: 'POST',
                      dataType: 'JSON',
                      contentType: "application/json; charset=utf-8",
                      data: JSON.stringify({ Tahun: vThn, Bulan: vBln }),
                      success: function (data) {

                          var chartData = JSON.parse(data.d);
                          var categorizeM = [];
                          var valuesL = [];
                          chartData.forEach(function (item) {
                              categorizeM.push(item.kod_ptj);
                              valuesL.push(parseFloat(item.jumlah_ot));
                          });

                          $chartBulan = createBarChart(categorizeM, valuesL);



                      },
                      error: function () {
                          console.log('Error fetching data from the web service.');
                      }


                  }));

                  promises.push($.ajax({
                      url: '<%=ResolveClientUrl("~/FORMS/GAJI/PROSES/Proses_WS.asmx/LoadBayarGaji")%>',
                      method: 'POST',
                      dataType: 'JSON',
                      contentType: "application/json; charset=utf-8",
                      data: JSON.stringify({ Tahun: vThn, Bulan: vBln }),
                      success: function (data) {

                          var data = JSON.parse(data.d);

                          TotalTerima = data[0].jumlah_gaji;
                          //alert(data[0].jumlah_gaji);
                          var formattedData_1 = parseFloat(data[0].jumlah_gaji).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                          $('.jumLulus').html(formattedData_1);
                          $('.gaji').html('GAJI : ' + parseFloat(data[0].GAJI).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.bonus').html('BONUS : ' + parseFloat(data[0].BONUS).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.ot').html('KERJA LEBIH MASA : ' + parseFloat(data[0].OT).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));

                          //Pie();

                      },
                      error: function () {
                          console.log('Error fetching data from the web service.');
                      }


                  }));
                  promises.push($.ajax({
                      url: '<%=ResolveClientUrl("~/FORMS/GAJI/PROSES/Proses_WS.asmx/LoadBayarElaun")%>',
                      method: 'POST',
                      dataType: 'JSON',
                      contentType: "application/json; charset=utf-8",
                      data: JSON.stringify({ Tahun: vThn, Bulan: vBln }),
                      success: function (data) {
                          /* sini amik data dekat db macam aku amik column butiran dan baki*/
                          var data = JSON.parse(data.d);

                          TotalElaun = data[0].jumlah_elaun;
                          var formattedData = parseFloat(data[0].jumlah_elaun).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                          $('.jumElaun').html(formattedData);
                          $('.itka').html('ITKA : ' + parseFloat(data[0].ITKA).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.itp').html('ITP : ' + parseFloat(data[0].ITP).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.itk').html('ITK : ' + parseFloat(data[0].ITK).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.itk').html('ITK : ' + parseFloat(data[0].ITK).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.sara').html('COLA : ' + parseFloat(data[0].SARA).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
       
                          //TotalTunggak = $("#jumTunggak").html();
                      },
                      error: function () {
                          console.log('Error fetching data from the web service.');
                      }
                  }));

                  promises.push($.ajax({
                      url: '<%=ResolveClientUrl("~/FORMS/GAJI/PROSES/Proses_WS.asmx/LoadBayarPot")%>',
                      method: 'POST',
                      dataType: 'JSON',
                      contentType: "application/json; charset=utf-8",
                      data: JSON.stringify({ Tahun: vThn, Bulan: vBln }),
                      success: function (data) {
                          /* sini amik data dekat db macam aku amik column butiran dan baki*/
                          var data = JSON.parse(data.d);

                          TotalElaun = data[0].jumlah_pot;
                          var formattedData = parseFloat(data[0].jumlah_pot).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                          $('.jumPot').html(formattedData);
                          $('.kwsp').html('KWSP : ' + parseFloat(data[0].KWSP).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.perkeso').html('PERKESO : ' + parseFloat(data[0].PERKESO).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.pencen').html('PENCEN : ' + parseFloat(data[0].PENCEN).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                          $('.cukai').html('CUKAI : ' + parseFloat(data[0].CUKAI).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));

                          //TotalTunggak = $("#jumTunggak").html();
                      },
                      error: function () {
                          console.log('Error fetching data from the web service.');
                      }
                  }));

                  



                  
              })

              
          });

          function createBarChart(categorizeM, valuesL) {
              var ctx = document.getElementById('barChart').getContext('2d');
              return new Chart(ctx, {
                  type: 'bar',
                  data: {
                      labels: categorizeM,
                      datasets: [{
                          label: 'Kod PTj',
                          data: valuesL,
                          backgroundColor: 'rgba(75, 192, 192, 0.2)', // Bar color
                          borderColor: 'rgba(75, 192, 192, 1)', // Border color
                          borderWidth: 1
                      }]
                  },
                  options: {
                      maintainAspectRatio: false,

                      scales: {
                          y: {
                              animation: {
                                  duration: 2000,
                                  easing: 'easeInOutQuart',
                              },
                              beginAtZero: true,


                          }
                      },
                      responsive: true,
                      plugins: {
                          legend: {
                              display: false,
                              position: 'top'
                          }
                      },
                  }
              });
          }

          //function Pie() {
          //    $.ajax({
          //        url: 'DashboardAR_WS.asmx/LoadPiePot',
          //        method: 'POST',
          //        dataType: 'JSON',
          //        contentType: "application/json; charset=utf-8",
          //        data: JSON.stringify({ Tahun: vThn, Bulan: vBln }),
          //        success: function (data) {
          //            /* sini amik data dekat db macam aku amik column butiran dan baki*/
          //            var chartData = JSON.parse(data.d);
          //            var values = [];
          //            chartData.forEach(function (item) {
          //                values.push(item.KWSP);
          //                values.push(item.PENC);
          //                values.push(item.SOCP);
          //            });
          //            createPieChart(values);
          //        },
          //        error: function () {
          //            console.log('Error fetching data from the web service.');
          //        }
          //    });
          //}

<%--          function bar() {
              $.ajax({
                  url: '<%='ResolveClientUrl("~/FORMS/GAJI/PROSES/Proses_WS.asmx/LoadBayarOT")%>',
                  method: 'POST',
                  dataType: 'JSON',
                  contentType: "application/json; charset=utf-8",
                  data: JSON.stringify({ Tahun: vThn, Bulan: vBln }),
                  success: function (data) {

                      var chartData = JSON.parse(data.d);
                      var categorizeM = [];
                      var valuesL = [];
                      chartData.forEach(function (item) {
                          categorizeM.push(item.kod_ptj);
                          valuesL.push(parseFloat(item.jumlah_ot));
                      });

                      createBarChart(categorizeM, valuesL);



                  },
                  error: function () {
                      console.log('Error fetching data from the web service.');
                  }


              });
                    }--%>

          //function createPieChart(values) {

          //    var ctx = document.getElementById('pieChart').getContext('2d');
          //    return new Chart(ctx, {
          //        type: 'doughnut',
          //        data: {
          //            labels: ['KWSP', 'PENCEN', 'PERKESO'],     //category untuk value
          //            datasets: [{
          //                data: values,   //nilai data dekat pie
          //                backgroundColor: [                //color untuk setiap category
          //                    //"rgba(255, 99, 132, 0.6)",
          //                    "rgba(54, 162, 235, 0.6)",
          //                    "rgba(255, 193, 7, 0.6)",
          //                    "rgba(0, 123, 255, 0.6)",
          //                ]
          //            }]
          //        },
          //        options: {
          //            /*aspectRatio: 1,*/
          //            responsive: true,
          //            maintainAspectRatio: false,
          //            animation: {
          //                animateScale: true, // Enable animation for scaling
          //                animateRotate: true
          //            },
          //            plugins: {
          //                datalabels: {
          //                    formatter: function (value, context) {
          //                        var dataset = context.chart.data.datasets[context.datasetIndex];
          //                        var total = dataset.data.reduce(function (previousValue, currentValue) {
          //                            return previousValue + currentValue;
          //                        });
          //                        var currentValue = dataset.data[context.dataIndex];
          //                        var percentage = ((currentValue / total) * 100).toFixed(2) + '%';
          //                        return percentage; // Display the percentage on the pie chart segment
          //                        alert("masuk");
          //                    },
          //                    color: 'black', // Color of the percentage text
          //                    font: {
          //                        weight: 'bold', // Font weight of the percentage text
          //                    },
          //                },
          //                legend: {
          //                    position: 'top',
          //                },
          //                title: {
          //                    display: true,
          //                    text: 'Bil Mengikut Status',
          //                }
          //            }
          //        }
          //    });
          //}

              //$.ajax({
              //    url: 'Transaksi_EOTs.asmx/LoadOTBlmLulusDB',
              //    method: 'POST',
              //    dataType: 'JSON',
              //    contentType: "application/json; charset=utf-8",
              //    data: JSON.stringify({ Tahun: Tahun }),
              //    success: function (data) {

              //        var data = JSON.parse(data.d);


              //        TotalBlTerima = data[0].JumOTBelumTerima;
              //        var formattedData = parseFloat(data[0].JumOTBelumTerima).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
              //        $('.jumBLulus').html(formattedData);

                     
              //    },
              //    error: function () {
              //        console.log('Error fetching data from the web service.');
              //    }


              //});

              //$.ajax({
              //    url: 'Transaksi_EOTs.asmx/LoadPiechtJumMohonOT',
              //    method: 'POST',
              //    dataType: 'JSON',
              //    contentType: "application/json; charset=utf-8",
              //    data: JSON.stringify({}),
              //    success: function (data) {

              //        var chartData = JSON.parse(data.d);
              //        var categorizeM = [];
              //        var valuesL = [];
              //        chartData.forEach(function (item) {
              //            categorizeM.push(item.Tahun);
              //            valuesL.push(parseFloat(item.JumMohon));
              //        });
                    
              //        createBarChart(categorizeM, valuesL);

                     

              //    },
              //    error: function () {
              //        console.log('Error fetching data from the web service.');
              //    }


              //});
          //})


      </script>
  

</div>
</asp:Content>
