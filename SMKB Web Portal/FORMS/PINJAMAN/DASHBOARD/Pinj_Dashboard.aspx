<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pinj_Dashboard.aspx.vb" Inherits="SMKB_Web_Portal.Pinj_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

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
            /*margin-bottom: 20px;*/
            /* background: linear-gradient(to right, #40E0D0, #87CEEB, #0000FF);*/
            /*background-color: rgb(40, 157, 246);*/
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

    <div id="dashboard" class="tabcontent" style="display: block;">
        <br />
        <br />
        <br />
        <br />
        <div class="col-md-12 container">
            <div class="form-row justify-content-center">

                <div class="col-md-3" style="z-index: 3;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #d0581c;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                 <b>JUMLAH PEMBIAYAAN STAF UTEM</b>
                            </div>
                            <div class="card-body">
                                <div id="jumPinjAktif" class="text-center" style="font:bold;font-size:large"></div>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fas la-hand-holding-usd fa-4x shadow h-auto" style="color: #d0581c"></i>
                        </div>
                    </div>
                </div>

                <div class="col-md-3" style="z-index: 3;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #f1ac88;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>JUMLAH BILANGAN PEMBIAYAAN AKTIF</b>
                            </div>
                            <div class="card-body">
                                <div id="bilPinjAktif" class="text-center" style="font:bold;font-size:large"></div>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fas la-address-book fa-4x shadow h-auto" style="color: #f1ac88;"></i>
                        </div>
                    </div>
                </div>
        </div>
        <div class="col-md-12">
            <div class="row">
                <!-- Bar Chart -->
                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card shadow">
                        <!-- Card Header - Dropdown -->
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold " style="color:darkslategrey">Pembiayaan Staf UTeM Mengikut Tahun</h6>
                        </div>
                        <!-- Card Body -->
                        <div class="card-body">
                            <div id="bar" class="chart-bar pt-4 pb-2 chart-container">
                                <canvas id="barChart"></canvas>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Doughnut Chart -->
                <div class="col-xl-6 col-md-6 mb-4">
                    <div class="card shadow">
                        <!-- Card Header - Dropdown -->
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold " style="color:darkslategrey">Bilangan Pembiayaan Mengikut Jenis</h6>
                        </div>
                        <!-- Card Body -->
                        <div class="card-body">
                            <div id="pie" class="chart-pie pt-4 pb-2 chart-container">
                                <canvas id="pieChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <div class="col-md-12">
            <div class="row">
                <!-- Bar Chart -->
                <div class="col-xl-12 col-md-6 mb-4">
                    <div class="card shadow">
                        <!-- Card Header - Dropdown -->
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold " style="color:darkslategrey">Senarai Syarikat Pembiayaan</h6>
                        </div>
                        <!-- Card Body -->
                        <div class="card-body">
                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblSenaraiSyarikat" class="table table-striped" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Bil</th>
                                                    <th scope="col">Nama Syarikat</th>
                                                    <th scope="col">Alamat Syarikat</th>
                                                    <th scope="col">Nombor Pejabat</th>
                                                </tr>
                                            </thead>
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
            $(document).ready(function () {
                Pie();
                bar();

                $.ajax({
                    url: 'Pinj_Dashboard_WS.asmx/LoadJumPinjAktif',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {
                        /* sini amik data dekat db macam aku amik column butiran dan baki*/
                        var data = JSON.parse(data.d);
                        var formattedData = parseFloat(data[0].jumlahPembiayaan).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        $("#jumPinjAktif").html(formattedData);
                       /* TotalTunggak = $("#jumTunggak").html();*/
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }
                });

                $.ajax({
                    url: 'Pinj_Dashboard_WS.asmx/LoadJumBilAktif',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {
                        var data = JSON.parse(data.d);
                        /*var formattedData = parseFloat(data[0].bilPembiayaan).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });*/
                        $("#bilPinjAktif").html(data[0].bilPembiayaan);
                    },
                    error: function () {
                        console.log('Error fetching data from the web service.');
                    }
                });

                tbl = $("#tblSenaraiSyarikat").DataTable({
                    "responsive": true,
                    "searching": true,
                    "info": true,
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
                        "url": "Pinj_Dashboard_WS.asmx/fetchSenaraiSyarikat",
                        method: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            close_loader();
                            return JSON.parse(json.d);
                        }

                    },
                    "columns": [
                        {
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Auto-incrementing number starting from 1
                                return meta.row + 1;
                            }
                        },
                        { "data": "Nama_Sykt" },
                        { "data": "Alamat" },
                        { "data": "Tel_Pej_Semasa" }
                    ],
                });

            });

            function Pie(index) {
                $.ajax({
                    url: 'Pinj_Dashboard_WS.asmx/LoadDataPinjPie',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {
                        /* sini amik data dekat db macam aku amik column butiran dan baki*/
                        var chartData = JSON.parse(data.d);
                        var values = [];
                        chartData.forEach(function (item) {
                            values.push(item.bilKenderaan);
                            values.push(item.bilKomputer);
                            values.push(item.bilSukan);
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
                        labels: ['Kenderaan', 'Komputer/Telepon Pintar', 'Peralatan Sukan'],     //category untuk value
                        datasets: [{
                            data: values,   //nilai data dekat pie
                            backgroundColor: [                //color untuk setiap category
                                //"rgba(255, 99, 132, 0.6)",
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
                            animateScale: true, // Enable animation for scaling
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
                                    return percentage; // Display the percentage on the pie chart segment
                                    alert("masuk");
                                },
                                color: 'black', // Color of the percentage text
                                font: {
                                    weight: 'bold', // Font weight of the percentage text
                                },
                            },
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: 'Bilangan Pembiayaan Mengikut Jenis',
                            }
                        }
                    }
                });
            }

            function bar() {
                $.ajax({
                    url: 'Pinj_Dashboard_WS.asmx/LoadDataPinjBar',
                    method: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({}),
                    success: function (data) {
                        /* sini amik data dekat db macam aku amik column butiran dan baki*/
                        var chartData = JSON.parse(data.d);
                        var categorizeM = [];
                        var valuesL = [];
                        chartData.forEach(function (item) {
                            categorizeM.push(item.year);
                            valuesL.push(item.bil);
                        });
                        /*ni untuk buat pie chart*/
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
                            label: 'Pembiayaan Staf UTeM Mengikut Tahun',
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

