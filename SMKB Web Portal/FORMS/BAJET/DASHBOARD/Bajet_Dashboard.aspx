<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Bajet_Dashboard.aspx.vb" Inherits="SMKB_Web_Portal.Bajet_Dashboard" %>

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
        <!-- Create the dropdown filter -->
        <div class="search-filter">
         
                <div class="col-md-12" style="margin-top: 5px">
                    <div class="form-row justify-content-center">     
                        <div class="form-group col-md-1">
                        <%--<label class="col-sm-1 col-form-label" style="text-align:right">Carian:</label>--%>
                        </div>
                        <div class="form-group col-md-1">
                            <select class="input-group__select ui search dropdown ListTahun" name="ddlKW" id="ddlTahun" placeholder="&nbsp;">
                            </select>
                            <label class="input-group__label" for="ddlTahun">Tahun</label>
                        </div>
                        <div class="form-group col-md-4">
                        <select class="input-group__select ui search dropdown ListKW" name="ddlKW" id="ddlKW" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlKW">Kumpulan Wang</label>
                        </div>
                        <div class="form-group col-md-2">
                        <select class="input-group__select ui search dropdown ListOperasi" name="ddlKO" id="ddlKO" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlKO">Kod Operasi</label>
                        </div>
                        <div class="form-group col-md-2">
                            <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button">
                                <i class="fa fa-search"></i>
                                Cari
                            </button>
                        </div>
                    </div>
                </div>
      
        </div>
        <br />
        <br />
        <br />
        <br />
        <div class="col-md-12 container">
            <div class="form-row justify-content-center">

                <div class="col-12 col-md" style="z-index: 3;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #0047AB;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>PERUNTUKAN LULUS</b>
                            </div>
                            <div class="card-body">
                                <div id="jumAgih" class="text-center" style="font: bold; font-size: large"></div>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fa fa-check shadow h-auto" style="color: #0047AB; font-size: 40px!important; width: 100px"></i>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md" style="z-index: 3;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #808080;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>TAMBAH PERUNTUKAN</b>
                            </div>
                            <div class="card-body">
                                <div id="jumTambah" class="text-center" style="font: bold; font-size: large"></div>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fa fa-plus shadow h-auto" style="color: #808080; font-size: 40px!important; width: 100px"></i>
                        </div>
                    </div>
                </div>


                <div class="col-12 col-md" style="z-index: 3;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #FFA500;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>KURANG PERUNTUKAN</b>
                            </div>
                            <div class="card-body">
                                <div id="jumKurang" class="text-center" style="font: bold; font-size: large"></div>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fa fa-minus shadow h-auto" style="color: #FFA500; font-size: 40px!important; width: 100px"></i>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md" style="z-index: 3;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #27AE60;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>BELANJA</b>
                            </div>
                            <div class="card-body">
                                <div id="jumBelanja" class="text-center" style="font: bold; font-size: large"></div>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fa fa-calculator shadow h-auto" style="color: #27AE60; font-size: 40px!important; width: 100px"></i>
                        </div>
                    </div>
                </div>


                <div class="col-12 col-md" style="z-index: 3;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #ff0066;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>TANGGUNGAN BELUM BAYAR</b>
                            </div>
                            <div class="card-body">
                                <div id="jumLO" class="text-center" style="font: bold; font-size: large"></div>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fa fa-exclamation fa-3x shadow h-auto" style="color: #ff0066; font-size: 40px!important; width: 100px"></i>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md" style="z-index: 3;">
                    <div class="card-wrapper">
                        <div class="card gradient-card shadow h-auto py-2" style="background-color: #9933ff;">
                            <div class="gradient-header text-center mx-auto" style="width: 100%;">
                                <b>BAKI PERUNTUKAN SEBENAR</b>
                            </div>
                            <div class="card-body">
                                <div id="jumBaki" class="text-center" style="font: bold; font-size: large"></div>
                            </div>
                        </div>
                        <div class="rounded-top-icon">
                            <i class="fa fa-money fa-3x shadow h-auto" style="color: #9933ff; font-size: 40px!important; width: 100px"></i>
                        </div>
                    </div>
                </div>

            </div>
<%--            <div class="col-md-12">
                <div class="row">
                    <!-- Bar Chart -->
                    <div class="col-xl-6 col-md-6 mb-4">
                        <div class="card shadow">
                            <!-- Card Header - Dropdown -->
                            <div
                                class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold " style="color: darkslategrey">Pembiayaan Staf UTeM Mengikut Tahun</h6>
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
                                <h6 class="m-0 font-weight-bold " style="color: darkslategrey">Bilangan Pembiayaan Mengikut Jenis</h6>
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

            </div>--%>

            <script type="text/javascript">
                $(document).ready(function () {
                    var shouldPop = true
             
                    // Get the current year
                    var currentYear = new Date().getFullYear();

                    // Call the generateDropdown function with the current year as the default value
                    generateDropdown("ddlTahun", "Bajet_Dashboard_WS.asmx/LoadTahun", null, false, null);

                    generateDropdown("ddlKW", "Bajet_Dashboard_WS.asmx/GetListKW", null, false, null);
                    generateDropdown("ddlKO", "Bajet_Dashboard_WS.asmx/GetListKO", null, false, null);

                    async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {
                        //console.log("a")
                        var param = '';
                        (sendData !== null && sendData !== undefined) ? param = '' : param = '?q={query}';

                        $('#' + id).dropdown({
                            fullTextSearch: true,
                            placeholder: plchldr,
                            apiSettings: {
                                url: url + param,
                                method: 'POST',
                                dataType: "json",
                                contentType: 'application/json; charset=utf-8',
                                cache: false,
                                //onChange: function (value, text, $selectedItem) {
                                //    if (fn !== null && fn !== undefined) {
                                //        return fn();
                                //    }
                                //},
                                beforeSend: function (settings) {
                                    if (send2ws) {
                                        settings.data = JSON.stringify({
                                            q: settings.urlData.query,
                                            data: $('#' + sendData).val()
                                        });
                                        searchQuery = settings.urlData.query;
                                        return settings;
                                    } else {
                                        // Replace {query} placeholder in data with user-entered search term
                                        settings.data = JSON.stringify({ q: settings.urlData.query });
                                        searchQuery = settings.urlData.query;
                                        return settings;
                                    }
                                },
                                onSuccess: function (response) {
                                    // Clear existing dropdown options
                                    var obj = $(this);

                                    var objItem = $(this).find('.menu');
                                    $(objItem).html('');

                                    // Add new options to dropdown
                                    if (response.d.length === 0) {
                                        $(obj.dropdown("clear"));
                                        return false;
                                    }

                                    var listOptions = JSON.parse(response.d);

                                    $.each(listOptions, function (index, option) {
                                        $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                                    });

                                    if (fn !== null && fn !== undefined) {
                                        fn();
                                    }

                                    /*dependable ddl if sendata value == empty clear all option*/
                                    if (sendData !== null && sendData !== undefined) {
                                        var tempDt = $('#' + sendData).val();
                                        if (tempDt == null && tempDt == undefined) {
                                            $('#' + id + ' .dropdown').addClass("disableDdlIcon");
                                            return false;
                                        }
                                    }

                                    //if (searchQuery !== oldSearchQuery) {
                                    //$(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
                                    //}

                                    //oldSearchQuery = searchQuery;

                                    // Refresh dropdown
                                    $(obj).dropdown('refresh');

                                    if (shouldPop === true) {
                                        $(obj).dropdown('show');
                                    }
                                }
                            }
                        });
                    }

                    //default 0.00
                    var formattedData = parseFloat(0).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                    $("#jumAgih").html(formattedData);

                    var formattedData = parseFloat(0).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                    $("#jumTambah").html(formattedData);

                    var formattedData = parseFloat(0).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                    $("#jumKurang").html(formattedData);

                    var formattedData = parseFloat(0).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                    $("#jumBelanja").html(formattedData);

                    var formattedData = parseFloat(0).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                    $("#jumLO").html(formattedData);

                    var formattedData = parseFloat(0).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                    $("#jumBaki").html(formattedData);


                    $('.btnSearch').click(async function () {

                        var promises = [];

                        promises.push($.ajax({
                            url: 'Bajet_Dashboard_WS.asmx/LoadJumAgih',
                            method: 'POST',
                            dataType: 'JSON',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({
                                Tahun: $('#ddlTahun').val(),
                                KW: $('#ddlKW').val(),
                                KO: $('#ddlKO').val()
                            }),
                            success: function (data) {
                                var data = JSON.parse(data.d);
                                var formattedData = parseFloat(data[0].Jumlah).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                                $("#jumAgih").html(formattedData);
                            },
                            error: function () {
                                console.log('Error fetching data from the web service.');
                            }
                        }));

                        promises.push($.ajax({
                            url: 'Bajet_Dashboard_WS.asmx/LoadJumTambah',
                            method: 'POST',
                            dataType: 'JSON',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({
                                Tahun: $('#ddlTahun').val(),
                                KW: $('#ddlKW').val(),
                                KO: $('#ddlKO').val()
                            }),
                            success: function (data) {
                                var data = JSON.parse(data.d);
                                var formattedData = parseFloat(data[0].Jumlah).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                                $("#jumTambah").html(formattedData);
                            },
                            error: function () {
                                console.log('Error fetching data from the web service.');
                            }
                        }));

                        promises.push($.ajax({
                            url: 'Bajet_Dashboard_WS.asmx/LoadJumKurang',
                            method: 'POST',
                            dataType: 'JSON',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({
                                Tahun: $('#ddlTahun').val(),
                                KW: $('#ddlKW').val(),
                                KO: $('#ddlKO').val()
                            }),
                            success: function (data) {
                                var data = JSON.parse(data.d);
                                var formattedData = parseFloat(data[0].Jumlah).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                                $("#jumKurang").html(formattedData);
                            },
                            error: function () {
                                console.log('Error fetching data from the web service.');
                            }
                        }));

                        promises.push($.ajax({
                            url: 'Bajet_Dashboard_WS.asmx/LoadJumBelanja',
                            method: 'POST',
                            dataType: 'JSON',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({
                                Tahun: $('#ddlTahun').val(),
                                KW: $('#ddlKW').val(),
                                KO: $('#ddlKO').val()
                            }),
                            success: function (data) {
                                var data = JSON.parse(data.d);
                                var formattedData = parseFloat(data[0].Jumlah).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                                $("#jumBelanja").html(formattedData);
                            },
                            error: function () {
                                console.log('Error fetching data from the web service.');
                            }
                        }));

                        // Execute all AJAX requests concurrently
                        Promise.all(promises)
                            .then(function (results) {
                                var sum = parseFloat($("#jumAgih").text().replace(/[^0-9.-]+/g, '')) +
                                    parseFloat($("#jumTambah").text().replace(/[^0-9.-]+/g, '')) -
                                    parseFloat($("#jumKurang").text().replace(/[^0-9.-]+/g, '')) -
                                    parseFloat($("#jumBelanja").text().replace(/[^0-9.-]+/g, '')) -
                                    parseFloat($("#jumLO").text().replace(/[^0-9.-]+/g, ''));

                                var formattedSum = sum.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });

                                $("#jumBaki").html(formattedSum);

                            })
                            .catch(function (error) {
                                console.error('Error fetching data:', error);
                            });
                    });

                });
            </script>
        </div>
    </div>
</asp:Content>

