<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="DashboardPerolehan.aspx.vb" Inherits="SMKB_Web_Portal.DashboardPerolehan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
    <%--<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-datalabels/2.2.0/chartjs-plugin-datalabels.min.js"></script>--%>

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
            margin-bottom: 0px;
        }

        .card-title {
            background-color: white;
            padding: 10px;
            margin-top: -15px;
            /*z-index: 2;*/
        }

        .gradient-card {
            /*margin-bottom: 20px;*/
            /* background: linear-gradient(to right, #40E0D0, #87CEEB, #0000FF);*/
            /*background-color: rgb(40, 157, 246);*/
            width: 100% !important;
            color: white;
            border: 10px;
            padding-top: 10px;
            padding-bottom: 30px;
        }

        /*.gradient-card::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 50px;*/ /* Set the width of your stroke line */
        /*height: 10px;*/ /* Set the height of your stroke line */
        /*background-color: #3498db;*/ /* Set the color of your stroke line */
        /*}*/


        @media only screen and (max-width: 1440px) {

            .gradient-header {
                height: 100px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
        }


        @media only screen and (max-width: 720px) {

            .gradient-header {
                height: 75px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
        }




        .gradient-header {
            color: black;
            background-color: white;
            padding-top: 15px;
            padding-bottom: 15px;
            padding-left: 10px;
            padding-right: 10px;
            min-height: 80px;
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
            position: relative;
            top: 10px;
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
            width: 100%;
        }

        .box-custom {
            width: 20% !important;
        }

        .w-20 {
            width: 20% !important;
            padding: 5px;
        }

        @media screen and (max-width: 992px) {
            .w-20 {
                width: 33.33% !important;
                padding: 5px;
            }
            .tabcontent{
                padding:5px!important;
            }
        }

        @media only screen and (max-width: 600px) {
            .w-20 {
                width: 100% !important;
                padding: 5px;
            }
        }
    </style>

    <div id="dashboard" class="tabcontent" style="display: block;">
          <br /> 
        <div class="col-md-12 container">
            <div class="form-row justify-content-center">




                <div class="w-20" style="z-index: 3;">
                    <div class="rounded-top-icon">
                        <i class="fa fa-calculator shadow h-auto" style="color: #0047AB; font-size: 40px!important; width: 100px"></i>
                    </div>
                    <div class="card-wrapper d-flex justify-content-center">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #0047AB;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>Jumlah Anggaran</b>
                            </div>
                            <div class="card-body">
                                <div id="jumTunai" class="text-center" style="font: bold; font-size: large"></div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="w-20" style="z-index: 3;">
                    <div class="rounded-top-icon">
                        <i class="fa fa-file-alt shadow h-auto" style="color: #808080; font-size: 40px!important; width: 100px"></i>
                    </div>
                    <div class="card-wrapper d-flex justify-content-center">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #808080;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>JUMLAH PERMOHONAN PEROLEHAN</b>
                            </div>
                            <div class="card-body">
                                <div id="jumPermohonan" class="text-center" style="font: bold; font-size: large"></div>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="w-20" style="z-index: 3;">
                    <div class="rounded-top-icon">
                        <i class="fa fa-spinner fa-3x shadow h-auto" style="color: #FFA500; font-size: 40px!important; width: 100px"></i>
                    </div>
                    <div class="card-wrapper d-flex justify-content-center">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #FFA500;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>PERMOHONAN DALAM PROSES</b>
                            </div>
                            <div class="card-body">
                                <div id="" class="text-center" style="font: bold; font-size: large">8</div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="w-20" style="z-index: 3;">
                    <div class="rounded-top-icon">
                        <i class="fa fa-check fa-3x shadow h-auto" style="color: #27AE60; font-size: 40px!important; width: 100px"></i>
                    </div>
                    <div class="card-wrapper d-flex justify-content-center">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #27AE60;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>PERMOHONAN LULUS</b>
                            </div>
                            <div class="card-body">
                                <div id="" class="text-center" style="font: bold; font-size: large">3</div>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="w-20" style="z-index: 3;">
                    <div class="rounded-top-icon">
                        <i class="fa fa-times fa-3x shadow h-auto" style="color: #E74C3C; font-size: 40px!important; width: 100px"></i>
                    </div>
                    <div class="card-wrapper d-flex justify-content-center">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #E74C3C;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>PERMOHONAN TIDAK LULUS</b>
                            </div>
                            <div class="card-body">
                                <div id="" class="text-center" style="font: bold; font-size: large">5</div>
                            </div>
                        </div>

                    </div>
                </div>


            </div>
        </div>
        <div class="col-md-12">
            <div class="row">

                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card shadow">
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold " style="color: darkslategrey">Kategori Perolehan</h6>
                        </div>
                        <div class="card-body">
                            <div id="bar" class="chart-bar pt-4 pb-2 chart-container">
                                <canvas id="barChart"></canvas>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card shadow">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold " style="color: darkslategrey">Bekalan Dan Perkhidmatan</h6>
                        </div>
                        <div class="card-body">
                            <div id="pie" class="chart-pie pt-4 pb-2 chart-container">
                                <canvas id="pieChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <script type="text/javascript">

            var tbl = null;
            var id = null;
            var cloneCount = 1;
            var newCanvas;
            var count = 0;
            var index = 0;
            var TotalTunggak = 0;
            var TotalTerima = 0;

            $(document).ready(function () {

                $.ajax({
                    url: 'DashboardPO.asmx/LoadJum_Bill',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {
                        /* sini amik data dekat db macam aku amik column butiran dan baki*/
                        var data = JSON.parse(data.d);
                        data.forEach(function (item) {
                            Jum_Bill = item.Jum_Bil;
                            Pie();
                            bar();
                            index++;
                            count++;
                        })
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }
                })

                ////Get data for card
                $.ajax({
                    url: 'DashboardPO.asmx/LoadJumPermohonan',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {

                        var data = JSON.parse(data.d);
                        TotalTerima = data[0].JumlahPermohonan;

                        $("#jumPermohonan").html(TotalTerima);

                        $.ajax({
                            url: 'DashboardPO.asmx/LoadJumTunggakPeratus',
                            method: 'POST',
                            dataType: 'JSON',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({ TotalTerima: TotalTerima }),
                            success: function (data) {
                                /* sini amik data dekat db macam aku amik column butiran dan baki*/
                                var data = JSON.parse(data.d);
                                var formattedPercentage = parseFloat(data[0].PeratusTunggakan).toFixed(0) + '%';
                                $("#jumTunggakPeratus").html(formattedPercentage);
                            },
                            error: function () {
                                console.log('Error fetching data from the web service.');
                            }
                        });
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }
                });

                $.ajax({
                    url: 'DashboardPO.asmx/LoadJumTunggak',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {
                        /* sini amik data dekat db macam aku amik column butiran dan baki*/
                        var data = JSON.parse(data.d);
                        var formattedData = parseFloat(data[0].Total_Tunggak).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        $("#jumAnggaran").html(formattedData);
                        TotalTunggak = $("#jumAnggaran").html();
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }
                });

                $.ajax({
                    url: 'DashboardPO.asmx/LoadTunai',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {
                        var data = JSON.parse(data.d);
                        var formattedData = parseFloat(data[0].TotalJumlah).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        $("#jumTunai").html(formattedData);
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }
                });

            });

            function Pie(index) {
                $.ajax({
                    url: 'DashboardPO.asmx/LoadDataBP',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {
                        /* sini amik data dekat db macam aku amik column butiran dan baki*/
                        var chartData = JSON.parse(data.d);
                        var values = [];
                        chartData.forEach(function (item) {
                            values.push(item.Bayaran_TepatWaktu);
                            values.push(item.Hutang_lapuk);
                            values.push(item.JumBilTertunggak);
                        });
                        createPieChart(values);
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }
                });
            }

            function createPieChart(values) {

                var ctx = document.getElementById('pieChart').getContext('2d');
                return new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Pesanan Belian', 'Pembelian Terus PTJ', 'Sebut Harga PTJ'],
                        datasets: [{
                            data: values,
                            backgroundColor: [
                                "rgba(54, 162, 235, 0.6)",
                                "rgba(255, 193, 7, 0.6)",
                                "rgba(0, 123, 255, 0.6)",
                            ]
                        }]
                    },
                    options: {
                        /*aspectRatio: 1,*/
                        responsive: true,
                        maintainAspectRatio: false,
                        animation: {
                            animateScale: true,
                            animateRotate: true
                        },
                        plugins: {
                            datalabels: {
                                formatter: function (value, context) {
                                    var dataset = context.chart.data.datasets[context.datasetIndex];
                                    var total = dataset.data.reduce(function (previousValue, currentValue) {
                                        return previousValue + currentValue;
                                    });
                                    var currentValue = dataset.data[context.dataIndex];
                                    var percentage = ((currentValue / total) * 100).toFixed(2) + '%';
                                    return percentage;
                                    alert("masuk");
                                },
                                color: 'black',
                                font: {
                                    weight: 'bold',
                                },

                            },
                            legend: {
                                position: 'right', // Position the legend to the right
                                display: true,
                            },

                            title: {
                                display: true,
                                text: '',
                            }
                        }
                    }
                });
            }

            function bar() {
                $.ajax({
                    url: 'DashboardPO.asmx/JumlahKategoriPO',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        var chartData = JSON.parse(data.d);
                        var categorizeM = [];
                        var valuesL = [];

                        chartData.forEach(function (item) {
                            categorizeM.push(item.Butiran);
                            valuesL.push(parseFloat(item.JumlahPermohonan));
                        });

                        createBarChart(categorizeM, valuesL);
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }
                });
            }

            function createBarChart(categorizeM, valuesL) {
                var ctx = document.getElementById('barChart').getContext('2d');
                return new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: categorizeM,
                        datasets: [{
                            label: 'Kategori Permohonan Perolehan',
                            data: valuesL,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
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
                });
            }

        </script>
    </div>
</asp:Content>

