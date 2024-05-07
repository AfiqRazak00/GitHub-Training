<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CetakJadualBayarBalik.aspx.vb" Inherits="SMKB_Web_Portal.CetakJadualBayarBalik" %>

<!DOCTYPE html>
<html>
<head>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="<%=ResolveClientUrl("~/Content/js/jquery.min.js")%> "></script>
    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="https://printjs-4de6.kxcdn.com/print.min.js"></script>
    <title></title>

    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            width: 80%; /* Set the table width to 75% of its container */
            border-collapse: collapse; /* Optional: This removes the spacing between table cells */
        }

        .top-border {
            border-top: 1px solid black;
            min-width: 250px;
        }

        body {
            font-family: Arial, sans-serif;
        }

        .plabel {
            font-size: 14px;
        }

        .pheader {
            text-align: center;
            font-size: 14px;
            font-weight: bold;
        }

        .ptarikh {
            font-size: 12px;
        }

        th, td {
            padding: 3px;
        }

        .headerkiri {
            width: 10px;
        }

        .valuekanan {
            text-align: right;
        }

        .bold {
            font-weight: bold;
        }

        @media print {
            .col-md-2 {
                float: right;
                /* margin-top: -50px; */
            }

            #header, #nav, .noprint {
                display: none;
            }

            .header, .header-space,
            .footer, .footer-space {
                height: 180px;
            }

            .header {
                position: fixed;
                top: 0;
            }

            .footer {
                position: fixed;
                bottom: 0;
            }

            /*.table-content {
                padding-top: 52%
            }*/
        }

        .auto-style1 {
            text-align: left;
            width: 10%;
        }

        .auto-style2 {
            width: 40%;
        }

        .auto-style3 {
            text-align: left;
            width: 10%;
        }

        .auto-style4 {
            width: 40%;
        }

        /*.my-div {
            margin-top: 10px;
            margin-right: 20px;
            margin-bottom: 30px;
            margin-left: 40px;
        }*/

        #contentId .tblByrBalikPinjaman tr.bold {
            font-weight: bold;
        }

        .table-content {
            width: 80%;
            margin: 0 auto;
        }

        .pheader {
            /*       text-align: center;*/
            font-size: 14px;
            font-weight: bold;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .pheader2 {
            /*            text-align: left;*/
            font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .pheader3 {
            text-align: center;
            font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        #contentreport td {
            font-size: 14px;
        }

        th .wnormal {
            font-weight: normal;
        }

        .codx {
            display: none;
            visibility: hidden;
        }
    </style>
</head>
<body>
    <div id="contentId" class="table-content">

        <style>
            table {
                /*width: 85%;*/ /* Set the table width to 75% of its container */
                border-collapse: collapse; /* Optional: This removes the spacing between table cells */
            }

            .vot-list th,
            .vot-list td {
                font-size: 12px;
            }

            #tblByrBalikPinj table, #tblByrBalikPinj th, #tblByrBalikPinj td {
                border: 1px solid grey;
                border-collapse: collapse;
            }

            #tblByrBalikPinj th, #tblByrBalikPinj td {
                padding: 10px;
                text-align: left;
            }

            #noborder table, #noborder th, #noborder td {
                border: 0;
                border-collapse: collapse;
            }

            #noborder th, #noborder td {
                padding: 10px;
                text-align: left;
            }

            #noborder2 th, #noborder2 td {
                text-align: left;
            }

            #noborder2 table, #noborder2 th, #noborder2 td {
                border: 0;
                border-collapse: collapse;
            }

            #noborder3 th, #noborder3 td {
                padding: 10px;
                text-align: left;
            }

            #noborder3 table, #noborder3 th, #noborder3 td {
                border: 0;
                border-collapse: collapse;
            }
/**/
            #noborder4 th, #noborder4 td {
                padding: 10px;
                text-align: left;
            }

            #noborder4 table, #noborder4 th, #noborder4 td {
                border: 0;
                border-collapse: collapse;
            }
        </style>
        <table>
            <tbody>
                <tr>
                    <td id="tblByrBalikPinjaman_lblTajuk"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <div class="vot-list">
            <table id="tblByrBalikPinj" class="tblByrBalikPinjaman table">
                <thead id="headId">
                    <tr id="noborder">
                        <th style="width: 25%; text-align: left" colspan="2">
                            <img id="imgMyImage" src="#" style="width: 140px; height: 80px; text-align: right">
                        </th>
                        <th style="width: 50%; text-align: center" colspan="5">
                            <p class="pheader2">
                                <strong>
                                    <span id="lblNamaKorporat"></span>
                                </strong>
                            </p>
                            <p class="pheader2">
                                <span class="wnormal" id="lblAlamatKorporat"></span>
                            </p>
                        </th>
                        <th style="width: 25%; text-align: right" colspan="2">
                            <span class="ptarikh wnormal">Tarikh : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span><br />
                            <span class="ptarikh wnormal">Laporan : PJM001</span><br />
                            <span class="ptarikh wnormal">Pengguna : <%= Session("ssusrID") %></span>
                        </th>
                    </tr>
                    <tr id="noborder2">
                        <th style="text-align: center" colspan="9">
                            <span class="pheader">PENYATA KEWANGAN BAYARAN BALIK PEMBIAYAAN KENDERAAN UTeM</span>
                        </th>
                    </tr>
                    <tr id="noborder3">
                        <td style="text-align: center" colspan="9">
                        </td>
                    </tr>
                </thead>
                <tbody id="idTbody">
                    <tr id="noborder4">
                        <td colspan="9">
                            <table style="width: 100%; border-collapse: collapse;">
                                <tr>
                                    <td><b>Nama</b></td>
                                    <td>&nbsp;:<span id="lblNama"></span></td>
                                    <td><b>Skim Pembiayaan</b></td>
                                    <td>&nbsp;:<span id="lblNoSkim"></span></td>
                                </tr>
                                <tr>
                                    <td><b>No Pembiayaan</b></td>
                                    <td>&nbsp;:<span id="lblNoPinj"></span></td>
                                    <td><b>Jumlah Pembiayaan</b></td>
                                    <td>&nbsp;:<span id="lblJumlah"></span></td>
                                </tr>
                                <tr>
                                    <td><b>No Pekerja</b></td>
                                    <td>&nbsp;:<span id="lblNoStaf"></span></td>
                                    <td><b>Tempoh Pembiayaan</b> </td>
                                    <td>&nbsp;:<span id="lblTempoh"></span></td>
                                </tr>
                                <tr>
                                    <td><b>Keuntungan</b></td>
                                    <td>&nbsp;:<span id="lblKeuntungan"></span></td>
                                </tr>
                                <tr>
                                    <td><b>Ptj</b></td>
                                    <td>&nbsp;:<span id="lblNamaPTj"></span></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 1%">Bil</th>
                        <th style="width: 5%">Bulan/Tahun</th>
                        <th style="width: 5%">Bayaran</th>
                        <th style="width: 5%">Untung</th>
                        <th style="width: 5%">Pokok</th>
                        <th style="width: 5%">Jumlah Untung</th>
                        <th style="width: 5%">Jumlah Pokok</th>
                        <th style="width: 5%">Baki Pokok</th>
                        <th style="width: 15%">Status</th>
                    </tr>
                    <tr id="tblByrBalikPinjaman_headx" class="codx">
                        <th style="text-align: center" colspan="9"><span class="wnormal">Tiada Rekod Ditemui.</span></th>
                    </tr>
                    <%--append list using jquery here--%>
                </tbody>
               <%-- <tfoot>
                    <tr>
                        <th style="width: 1%">Bil</th>
                        <th style="width: 5%">Bulan/Tahun</th>
                        <th style="width: 5%">Bayaran</th>
                        <th style="width: 5%">Untung</th>
                        <th style="width: 5%">Pokok</th>
                        <th style="width: 5%">Jumlah Untung</th>
                        <th style="width: 5%">Jumlah Pokok</th>
                        <th style="width: 5%">Baki Pokok</th>
                        <th style="width: 15%">Status</th>
                    </tr>
                </tfoot>--%>
            </table>
        </div>
    </div>

    <div class="pt-2" style="text-align: center;"><span style="font-size: 14px;"><strong>*** Laporan Tamat ***</strong></span></div>
</body>
</html>
<script src="../../../Scripts/jquery 1.12.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>

<script>
    init()
    function init() {
        var data = JSON.parse(sessionStorage.getItem("data4cjbb")); // data dari jadualbayarbalik.aspx
        var dt1 = JSON.parse(data.DataTab1);

        if (isSet(dt1)) {
            $("#imgMyImage").attr("src", dt1.imageUrl);
            $("#lblNamaKorporat").text(dt1.lblNamaKorporat);
            $("#lblAlamatKorporat").text(dt1.lblAlamatKorporat);
            $("#lblNoTelFaks").text(dt1.lblNoTelFaks);
            $("#lblEmailKorporat").text(dt1.lblEmailKorporat);
        }

        var dt2 = JSON.parse(data.DataTab2);

        if (isSet(dt2)) {
            $("#lblNama").text(dt2.lblNama);
            $("#lblNoSkim").text(dt2.lblNoSkim);
            $("#lblNoPinj").text(dt2.lblNoPinj);
            $("#lblJumlah").text(dt2.lblJumlah);
            $("#lblNoStaf").text(dt2.lblNoStaf);
            $("#lblTempoh").text(dt2.lblTempoh);
            $("#lblNamaPTj").text(dt2.lblNamaPTj);
            $("#lblKeuntungan").text(dt2.lblKeuntungan);
        }

        if (isSet(data.DataTab3)) {
            var dt3 = JSON.parse(data.DataTab3);
            if (isSet(dt3)) {
                $.each(dt3, function (index, value) {
                    var status = (value.Status_GJ == "Y") ? "Telah Dibayar" : "Belum Dibayar";
                    var html = '<tr>' +
                        '<td class="headerkiri" >' + value.Bil_Byr + '</td >' +
                        '<td class="align-center">' + (isSet(value.Bln_GJ) ? value.Bln_GJ : '-') + '</td>' +
                        '<td class="valuekanan">' + value.Ansuran + '</td>' +
                        '<td class="valuekanan">' + value.Faedah + '</td>' +
                        '<td class="valuekanan">' + value.Pokok + '</td>' +
                        '<td class="valuekanan">' + value.FaedahPlus + '</td>' +
                        '<td class="valuekanan">' + value.PokokPlus + '</td>' +
                        '<td class="valuekanan">' + value.Baki_Pokok + '</td>' +
                        '<td class="align-center">' + status + '</td>' +
                        '</tr >';
                    $("#idTbody").append(html);
                });
            }
        } else {
            $("#tblByrBalikPinjaman_headx").removeClass("codx");
        }

        //open print 
         window.print();
    }

    function isSet(value) {
        if (value === null || value === '' || value === undefined) {
            return false;
        } else {
            return true;
        }
    }

    //masa print
    $(window).on('beforeprint', function (e) {
        //$("#headId").removeClass('codx');
        $("#contentId").removeClass('table-content');
    });

    //selepas print
    $(window).on('afterprint', function () {
        //$("#headId").addClass('codx');
        $("#contentId").addClass('table-content');
    });
</script>





