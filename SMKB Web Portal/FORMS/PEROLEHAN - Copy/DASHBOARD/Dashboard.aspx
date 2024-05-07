<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Dashboard.aspx.vb" Inherits="SMKB_Web_Portal.Dashboard" %>
<asp:Content ID="FormContents" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.1.1/chart.min.js"></script>

    <style>
        .card-icon {
              position: relative; /* Make the parent div a positioned container */
              display: inline-flex; /* Make sure it's displayed as a flex container */
              align-items: center; /* Center the content vertically */
              justify-content: center; /* Center the content horizontally */
              width: 50px; /* Set the width of the circle */
              height: 50px; /* Set the height of the circle */
              border-radius: 50%; /* Make it a circle by setting border-radius to 50% */
              background-color: #FFC83D; /* Set the background color of the circle */
              margin-right: 10px; /* Add some spacing if needed */
        }

        .card-icon::before {
              content: ''; /* Add content to the pseudo-element */
              position: absolute; /* Position it absolutely inside the parent div */
              top: 0; /* Position it at the top of the parent div */
              left: 0; /* Position it at the left of the parent div */
              width: 100%; /* Make it take the full width of the parent div */
              height: 100%; /* Make it take the full height of the parent div */
              border-radius: inherit; /* Inherit the border-radius to maintain the circle shape */
              background-color: transparent; /* Set the background color to transparent */
              border: 2px solid #333; /* Add a border to create the circle outline */
              box-sizing: border-box; /* Include the border in the box dimensions */
        }

        .card-icon i {
              color: #000; /* Set the color of the icon to yellow */
        }

        .tab-pane {
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            border-radius: 0px 0px 5px 5px;
            padding: 10px;
        }

        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active{
            color: #edb018;
            font-weight:bold;
        }
    </style>
    <contenttemplate>

        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div id="divpendaftaraninv" runat="server" visible="true">
                <div class="modal-body">
                    <div>  
                        <h5>Dashboard Perolehan</h5>
                        <hr />


                        <div class="row">

                            <div class="col-xxl-4 col-xl-4">
                                <div class="card" style="height: 100%;">
                                    <div class="card-body">
                                        <h6 class="card-title">Jumlah Permohonan Perolehan</h6>
                                        <div class="d-flex align-items-center">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="fa fa-archive fa-2x" aria-hidden="true"></i>
                                            </div>
                                        <div class="ps-3">
                                            <br />
                                            <h5 class="text-success"> <span id="total_mohon"></span> <span class="small pt-1" style="color:rgba(121,129,137,255)">Permohonan Dibuat</span></h5>
                                            <br />
                                        </div>
                                      </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xxl-4 col-xl-4">
                                <div class="card" style="height: 100%;">
                                    <div class="card-body">
                                        <h6 class="card-title">Kelulusan Permohonan Perolehan</h6>
                                        <div class="d-flex align-items-center">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="fa fa-paperclip fa-2x" aria-hidden="true"></i>
                                            </div>
                                        <div class="ps-3">
                                            <h5 class="text-success"> <span id="lulus"></span> <span class="small pt-1" style="color:rgba(121,129,137,255)">Permohonan Lulus</span></h5>
                                            <h5 class="text-warning"> <span id="pendingLulus"></span> <span class="small pt-1" style="color:rgba(121,129,137,255)">Permohonan Dalam Proses</span></h5>
                                            <h5 class="text-danger"> <span id="takLulus"></span> <span class="small pt-1" style="color:rgba(121,129,137,255)">Permohonan Tidak Lulus</span></h5>
                                        </div>
                                      </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xxl-4 col-xl-4">
                                <div class="card" style="height: 100%;">
                                    <div class="card-body">
                                        <h6 class="card-title">Jumlah Anggaran Perbelanjaan</h6>
                                        <div class="d-flex align-items-center">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="fas fa-credit-card fa-2x" aria-hidden="true"></i>
                                            </div>
                                        <div class="ps-3">
                                             <br />
                                            <h5 class="text-success"> <span class="small pt-1" style="color:rgba(121,129,137,255)">RM </span><span id="jumlah"></span> </h5>
                                            <br />
                                        </div>
                                      </div>
                                    </div>
                                </div>
                            </div>
                        </div>







                        &nbsp;
                        <nav>
                            <div class="nav nav-tabs justify-content-center" id="nav-tab" role="tablist">
                                <button class="nav-link active" id="nav-home-tab" data-toggle="tab" data-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true"><b>Graf Kategori Perolehan</b></button>
                                <button class="nav-link" id="nav-profile-tab" data-toggle="tab" data-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false"><b>Graf Kelulusan</b></button>
                                <button class="nav-link" id="nav-contact-tab" data-toggle="tab" data-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false"><b>Graf Permohonan Perolehan Berdasarkan Bulan</b></button>
                            </div>
                        </nav>
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">

                                <div class="row">
                                    <div class="col-xxl-12 col-xl-12">     
                                        <div style="width: 60%; margin: auto;">
                                            <canvas id="barChart" style="max-height: 400px;"></canvas>
                                        </div>            
                                    </div>
                                </div>

                            </div>
                            <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">

                                <div class="row">
                                    <div class="col-xxl-12 col-xl-12">
                                        <div style="width: 60%; margin: auto;">
                                            <canvas id="pieChart" style="max-height: 400px;"></canvas>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">

                                <div class="row">
                                    <div class="col-xxl-12 col-xl-12">
                                        <div style="width: 60%; margin: auto;">
                                            <canvas id="barChart2" style="max-height: 400px;"></canvas>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div> 
                </div> 
            </div> 
        </div> 



        <script  type="text/javascript">           
            //Display Jumlah Permohonan Perolehan
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetTotalMohon") %>',
                    //url: "PermohonanPoWS.asmx/GetTotalMohon",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);

                        // Assuming the query returns a single value, you can directly set the input value.
                        // If the query returns multiple rows, you may need to iterate through the data to display it appropriately.
                        $("#total_mohon").text(jsonData[0].tot_mohon);
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });
            });


            //Display info about kelulusan perolehan
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetKelulusanInfo") %>',
                    //url: "PermohonanPoWS.asmx/GetKelulusanInfo",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);

                        // Assuming the query returns a single value, you can directly set the input value.
                        // If the query returns multiple rows, you may need to iterate through the data to display it appropriately.
                        $("#lulus").text(jsonData[0].kelulusan_lulus);
                        $("#takLulus").text(jsonData[0].kelulusan_tak_lulus);
                        $("#pendingLulus").text(jsonData[0].kelulusan_pending);
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });
            });



            //Display info about kelulusan perolehan
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetAnggaran") %>',
                    //url: "PermohonanPoWS.asmx/GetAnggaran",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);

                        // Assuming the query returns a single value, you can directly set the input value.
                        // If the query returns multiple rows, you may need to iterate through the data to display it appropriately.
                        $("#jumlah").text(jsonData[0].tot_Jumlah_Harga);
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });
            });












            //1st Graph: Kategori Perolehan (Bar Graph)
            var kerja = "";
            var perkhidmatan = "";
            var bekalan = "";
            var bekalan_ict = "";
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadGraphKategoriPo") %>',
                    //url: "PermohonanPoWS.asmx/LoadGraphKategoriPo",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);

                        // Assuming the query returns a single value, you can directly set the input value.
                        // If the query returns multiple rows, you may need to iterate through the data to display it appropriately.
                        kerja = jsonData[0].kerja_count;
                        perkhidmatan = jsonData[0].perkhidmatan_count;
                        bekalan = jsonData[0].bekalan_count;
                        bekalan_ict = jsonData[0].ict_count;

                        new Chart(document.querySelector('#barChart'), {
                            type: 'bar',
                            data: {
                                labels: ['KERJA', 'BEKALAN', 'BEKALAN ICT', 'PERKHIDMATAN'],
                                datasets: [{
                                    label: 'Kategori Perolehan',
                                    data: [kerja, bekalan, bekalan_ict, perkhidmatan],
                                    backgroundColor: [
                                        'rgba(255, 99, 132, 0.5)',
                                        'rgba(255, 159, 64, 0.5)',
                                        'rgba(255, 205, 86, 0.5)',
                                        'rgba(75, 192, 192, 0.5)'
                                    ],
                                    borderColor: [
                                        'rgb(255, 99, 132)',
                                        'rgb(255, 159, 64)',
                                        'rgb(255, 205, 86)',
                                        'rgb(75, 192, 192)'
                                    ],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });
            });



            //2nd Graph: Kategori Perolehan (Pie Chart)
            var lulus = "";
            var tak_lulus = "";
            var dalam_proses = "";
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetKelulusanInfo") %>',
                    //url: "PermohonanPoWS.asmx/GetKelulusanInfo",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);

                        // Assuming the query returns a single value, you can directly set the input value.
                        // If the query returns multiple rows, you may need to iterate through the data to display it appropriately.
                        lulus = jsonData[0].kelulusan_lulus;
                        tak_lulus = jsonData[0].kelulusan_tak_lulus;
                        dalam_proses = jsonData[0].kelulusan_pending;

                        new Chart(document.querySelector('#pieChart'), {
                            type: 'pie',
                            data: {
                                labels: ['Permohonan Lulus', 'Permohonan Tidak Lulus', 'Permohonan Dalam Proses'],
                                datasets: [{
                                    label: 'Bar Chart',
                                    data: [lulus, tak_lulus, dalam_proses],
                                    backgroundColor: [
                                        'rgba(75, 192, 192)',
                                        'rgba(255, 99, 132)', 
                                        'rgba(255, 214, 117)' 
                                    ],
                                    borderColor: [
                                        'rgb(75, 192, 192)', 
                                        'rgb(255, 99, 132)',
                                        'rgb(255, 159, 64)'  
                                    ],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });
            });
           

            //3rd Graph: Number of permohonan
            var ogos = "";
            var sep = "";
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetPemohonMonth") %>',
                    //url: "PermohonanPoWS.asmx/GetPemohonMonth",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);

                        // Assuming the query returns a single value, you can directly set the input value.
                        // If the query returns multiple rows, you may need to iterate through the data to display it appropriately.
                        ogos = jsonData[0].row_count;
                        sep = jsonData[1].row_count;

                        new Chart(document.querySelector('#barChart2'), {
                            type: 'bar',
                            data: {
                                labels: ['Ogos', 'September'],
                                datasets: [{
                                    label: 'Permohonan Perolehan Berdasarkan Bulan',
                                    data: [ogos, sep],
                                    backgroundColor: [
                                        'rgba(255, 99, 132, 0.5)',
                                        'rgba(75, 192, 192, 0.5)'
                                    ],
                                    borderColor: [
                                        'rgb(255, 99, 132)',
                                        'rgb(75, 192, 192)'
                                    ],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });
            });








        </script>
    </contenttemplate>
</asp:Content>
