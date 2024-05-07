<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Dashboard_EOT.aspx.vb" Inherits="SMKB_Web_Portal.Dashboard_EOT" %>
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
            
<%--                <div class="modal-content" >--%>
                  

                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                           
                            <div class="form-group row col-md-6">
                                <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align:right">Tahun :</label>
                                 <div class="col-sm-3">
                                    <div class="input-group">
                                      <select id="ddlTahun" class="custom-select" ></select>
                              
                                    </div>
                                   </div>
                                   <div class="col-sm-3">
                                          <button id="btnPapar" runat="server" class="btn btn-warning btnPapar" type="button" style="width:100%">Papar</button>
                                           
                                    </div>

                            </div>
                        </div>
                   </div>

              <%--  </div>--%>

            <div id="dashboard" class="tabcontent" style="display: block">

                <div class="col-md-12">
                    <div class="form-row justify-content-center">
                        <div class="col-md-4 card-deck">
                            <div class="card bg-info text-center">
                                <p class="card-text text-white font-weight-bold">Jumlah OT yang Lulus</p>
                                <span  style="font-size:20px;font-weight:bold" class="bg-white jumLulus"></span>
                            </div>
                        </div>
                        <div class="col-md-4 card-deck">
                            <div class="card bg-success text-center">
                                <p class="card-text text-white font-weight-bold">Jumlah OT Belum Lulus</p>
                                <span style="font-size:20px; font-weight:bold" class="bg-white jumBLulus"></span>
                            </div>
                        </div>
                    </div>   
               </div>
                <hr />
               <div class="col-md-12">
                <div class="row">
                    <!-- Bar Chart -->
                   <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card shadow">
                            <!-- Card Header - Dropdown -->
                            <div
                                class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold " style="color:darkslategrey;font-size:14px">Jumlah Pemohonan OT Mengikut Tahun</h6>
                            </div>
                            <!-- Card Body -->
                            <div class="card-body">
                                <div id="bar" class="chart-bar pt-4 pb-2 chart-container" style="width: 100%; height: 300px;">
                                    <canvas id="barChart" style="width: 100%; height: 100%;"></canvas>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- Bar Chart -->
                   <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card shadow">
                            <!-- Card Header - Dropdown -->
                            <div
                                class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold " style="color:darkslategrey;font-size:14px">Jumlah Pemohonan OT Mengikut Bulan bagi Tahun
                          
                                <label id="lblTahun"></label>

                                </h6>
                            </div>
                            <!-- Card Body -->
                            <div class="card-body">
                                <div id="bar1" class="chart-bar pt-4 pb-2 chart-container" style="width: 100%; height: 300px;">
                                    <canvas id="barChart1" style="width: 100%; height: 100%;"></canvas>
                                </div>
                            </div>
                        </div>
                     </div>                
                     <!-- Bar Chart -->
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card shadow">
                            <!-- Card Header - Dropdown -->
                            <div
                                class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold " style="color:darkslategrey;font-size:14px">Jumlah Pemohonan OT Mengikut PTJ bagi Tahun
                          
                                <label id="lblTahun1"></label>

                                </h6>
                            </div>
                            <!-- Card Body -->
                            <div class="card-body">
                                <div id="bar2" class="chart-bar pt-4 pb-2 chart-container" style="width: 100%; height: 300px;">
                                    <canvas id="lineChart" style="width: 100%; height: 100%;"></canvas>
                                </div>
                            </div>
                        </div>
                     </div>
                  </div>
               </div>   
        </div> 
      </div>
   
        <script type="text/javascript">
            var $chartBulan = null;
            var chartInstance = null;
            var $chartPtj = null;
            var chartPTJ = null;
            $(document).ready(function () {
                
                       var currentYear = new Date().getFullYear();
                       var previousYear = currentYear - 1;

                       // Populate current year option
                       $('<option>', {
                           value: currentYear,
                           text: currentYear
                       }).appendTo('#ddlTahun');

                       // Populate previous year option
                       $('<option>', {
                           value: previousYear,
                           text: previousYear
                       }).appendTo('#ddlTahun');

              
               })

            $('.btnPapar').click(async function () {


                var Tahun = $('#ddlTahun').val();
                $('#lblTahun').text(Tahun);
                $('#lblTahun1').text(Tahun);
                $('.jumLulus').html("0.00");
                $('.jumBLulus').html("0.00");

                if ($chartBulan !== null) {
                    $chartBulan.destroy();
                }
                if (chartInstance !== null) {
                    chartInstance.destroy();
                }

                if ($chartPtj !== null) {
                    $chartPtj.destroy();
                }

                if (chartPTJ !== null) {
                    chartPTJ.destroy();
                }

             
                $.ajax({
                    url: 'Transaksi_EOTs.asmx/LoadOTLulusDB',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Tahun: Tahun }),
                    success: function (data) {

                        var data = JSON.parse(data.d);

                       // TotalTerima = data[0].JumOTTerima;
                        var formattedData_1 = parseFloat(data[0].JumOTTerima).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        $('.jumLulus').html(formattedData_1);

                       
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }

                });

                $.ajax({
                    url: 'Transaksi_EOTs.asmx/LoadOTBlmLulusDB',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Tahun: Tahun }),
                    success: function (data) {

                        var data = JSON.parse(data.d);


                       // TotalBlTerima = data[0].JumOTBelumTerima;
                        var formattedData = parseFloat(data[0].JumOTBelumTerima).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        $('.jumBLulus').html(formattedData);

                       
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }


                });

                $.ajax({
                    url: 'Transaksi_EOTs.asmx/LoadPiechtJumMohonOT',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {

                        var chartData = JSON.parse(data.d);
                        var categorizeM = [];
                        var valuesL = [];
                        chartData.forEach(function (item) {
                            categorizeM.push(item.Tahun);
                            valuesL.push(parseFloat(item.JumMohon));
                        });


                        $chartBulan = createBarChart(categorizeM, valuesL);

                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }


                });
               

                $.ajax({
                    url: 'Transaksi_EOTs.asmx/LoadPiechtJumMohonOTBulan',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Tahun: Tahun }),
                    success: function (data) {

                        var chartData1 = JSON.parse(data.d);
                        var categorizeMonth = [];
                        var valuesLB = [];
                        chartData1.forEach(function (item) {
                            categorizeMonth.push(item.Month);
                            valuesLB.push(parseFloat(item.Total));
                        });

                       
                        console.log(categorizeMonth);
                        console.log(valuesLB);
                       
                       
                        chartInstance = createBarChartBulan(categorizeMonth, valuesLB);

                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }

                });

                $.ajax({
                    url: 'Transaksi_EOTs.asmx/LoadlinechtJumMohonOPTJ',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Tahun: Tahun }),
                    success: function (data) {

                        var chartData2 = JSON.parse(data.d);
                        var categorizePTJ = [];
                        var valuesPTJ = [];
                        chartData2.forEach(function (item) {
                            categorizePTJ.push(item.Pejabat);
                            valuesPTJ.push(parseFloat(item.Jumphmn));
                        });


                        $chartPtj = createBarChartPTJ(categorizePTJ, valuesPTJ);

                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }

                });

            })

            function createBarChart(categorizeM, valuesL) {
               
                var ctx = document.getElementById('barChart').getContext('2d');
              
                return new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: categorizeM,
                        datasets: [{
                            label: 'Jumlah Pemohon',
                            data: valuesL,

                            backgroundColor: 'rgb(255, 153, 51, 0.2)', // Bar color
           
                            borderColor: 'rgb(255, 166, 77, 1)',
                            
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
                                display: true,
                                position: 'top'
                            }
                        },
                    }
                });
            }
            function createBarChartBulan(categorizeMonth, valuesLB) {
                var ctx1 = document.getElementById('barChart1').getContext('2d');
                return new Chart(ctx1, {
                    type: 'bar',
                    data: {
                        labels: categorizeMonth,
                        datasets: [{
                            label: 'Jumlah Mohon OT Bulanan',
                            data: valuesLB,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(255, 159, 64, 0.2)',
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(255, 159, 64, 1)'

                            ],
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
                }); // <-- Add this closing parenthesis and semicolon
            }


            function createBarChartPTJ(categorizePTJ, valuesPTJ) {
                var ctx2 = document.getElementById('lineChart').getContext('2d');
                return new Chart(ctx2, {
                    type: 'line',
                    data: {
                        labels: categorizePTJ,
                        datasets: [{
                            label: 'Jumlah Pemohon',
                            data: valuesPTJ,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)', // Bar color
                            borderColor: 'rgba(75, 192, 192, 1)',
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
                                display: true,
                                position: 'top'
                            }
                        },
                    }
                }); // <-- Add this closing parenthesis and semicolon
            }

           
        </script>
    

  </div>

</asp:Content>
