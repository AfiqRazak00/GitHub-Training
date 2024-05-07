<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Pesanan_Tempatan_Print.aspx.vb" Inherits="SMKB_Web_Portal.Pesanan_Tempatan_Print" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js" crossorigin="anonymous"></script>



    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

    <!-- Optional theme -->

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous" />

    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="https://printjs-4de6.kxcdn.com/print.min.js"></script>
    <title></title>

    <style>
        .align-right {
            text-align: right;
        }

        .subtotal-label {
            border-top: 2px solid #000;
            /*        display: block; */
            padding-top: 2px;
        }

        .subtotal-label2 {
            border-top: 2px solid #000;
            border-bottom: 2px solid #000;
            /*        display: block; */
            padding-top: 2px;
            padding-bottom: 2px;
        }

        .subtotal-label3 {
            border-top: 2px solid #000;
            border-bottom: 4px double #000;
            /*        display: block; 
*/ padding-top: 2px;
            padding-bottom: 2px;
        }

        table {
            border-collapse: separate;
        }

        .top-border {
            border-top: 1px solid black;
            min-width: 250px;
        }

        .topbottom-border {
            border-top: 1px solid black;
            border-bottom: 3px double black;
            min-width: 250px;
        }

        body {
            font-family: Arial, sans-serif;
            /*font-size: 12px!important;*/
        }

        .pheader {
            /*            text-align: center;
*/ font-size: 14px;
            font-weight: bold;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .pheader2 {
            /*            text-align: center;
*/ font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .pheader3 {
            text-align: center;
            font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }



        .ptarikh {
            font-size: 12px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        table {
            width: 100%;
        }

        th, td {
            padding: 1px;
        }

        .headerkiri {
            text-align: center;
        }

        .valuekanan {
            text-align: right;
        }

        .valuetengah {
            text-align: center;
        }

        .bold {
            font-weight: bold;
        }


        .table-custom th, .table-custom td {
            border: 0.5px solid black;
        }

        element.style {
            text-align: center;
            border-right: 1px solid black;
            width: 18px;
        }

        .table > thead > tr > th {
            vertical-align: bottom;
            border-bottom: 0.5px solid #000;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            padding: 8px;
            line-height: 1.42857143;
            vertical-align: top;
            border-top: 0.5px solid #000;
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

        /*@media print {
  table {
    page-break-before: auto;
    page-break-after: auto;
  }

  #tblDataSenarai_Pesanan thead {
    display: table-header-group;*/ /* Enable header repetition */
        /*position: sticky;*/ /* Keep header visible on top */
        /*top: 0;*/ /* Align header to page top */
        /*}
}*/
    </style>


</head>
<body>
    <form id="form1" runat="server">
        <div id="masterdiv" class="container">

            <div id="printreportcashflow" class="">
                <table id="tblDataSenarai_Pesanan" class="table table-custom">

                    <thead class=" ">
                        <tr style="width: 100%;">
                            <th colspan="9" style="border: none;">
                                <div style="width: 100%; display: flex;">
                                    <div style="width: 100%; display: flex;">
                                        <div style="width: 30%; text-align: center;">
                                            <asp:Image ID="imgMyImage" runat="server" Style="width: 140px; height: 80px; text-align: right" />
                                        </div>
                                        <div style="width: 70%; border-bottom: 2px solid; border-top: 2px solid;">
                                            <h4 class="text-center" style="font-weight: 900; padding-top: 15px; padding-bottom: 10px;">PESANAN TEMPATAN UTeM</h4>

                                        </div>
                                    </div>


                                    <div style="width: 20%; text-align: center;"></div>
                                </div>
                            </th>

                        </tr>
                        <tr style="width: 100%; font-size: 10px;">
                            <th colspan="9">
                                <div style="width: 100%; display: flex; text-align: left">
                                    <div style="padding-top: 20px; width: 60%;">
                                        <div style="width: 100%; display: flex;">
                                            <div style="width: 10%;">
                                                Kepada 
                                            </div>
                                            <div style="width: 5%;">
                                                :
                                            </div>
                                            <div style="width: 60%">
                                                <p class="text-uppercase" id="txtNamaSykt"></p>
                                                <p id="txtAlamatSykt"></p>
                                                <p id="txtAlamatSykt2"></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="padding-top: 20px; width: 40%;">
                                        <div style="width: 100%;">
                                            <div style="width: 100%; display: flex;">
                                                <div style="width: 48%;">
                                                    No. Pesanan Tempatan
                                                </div>
                                                <div style="width: 4%;">
                                                    :
                                                </div>
                                                <div style="width: 48%">
                                                    <p class="" id="txtNo_Pesanan"></p>
                                                </div>
                                            </div>
                                            <div style="width: 100%; display: flex;">
                                                <div style="width: 48%;">
                                                    Tarkh Akhir Bekalan / Perkhidmatan
                                                </div>
                                                <div style="width: 4%;">
                                                    :
                                                </div>
                                                <div style="width: 48%">
                                                    <p class="" id="txtTarikh_Pesanan"></p>
                                                </div>
                                            </div>
                                            <div style="width: 100%; display: flex;">
                                                <div style="width: 48%;">
                                                    No. Sebut Harga / Tender
                                                </div>
                                                <div style="width: 4%;">
                                                    :
                                                </div>
                                                <div style="width: 48%">
                                                    <p class="" id="txtNo_SHT"></p>
                                                </div>
                                            </div>
                                            <div style="width: 100%; display: flex;">
                                                <div style="width: 48%;">
                                                    No. Pelarasan Pesanan Tempatan
                                                </div>
                                                <div style="width: 4%;">
                                                    :
                                                </div>
                                                <div style="width: 48%">
                                                    <p class="">-</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </th>

                        </tr>
                        <tr>
                            <th colspan="9" style="border: none;"></th>
                        </tr>
                        <tr style="font-size: 12px;">
                            <th scope="col" style="text-align: center;">Bil.</th>
                            <th scope="col" style="text-align: center">KW</th>
                            <th scope="col" style="text-align: center;">PTj</th>
                            <th scope="col" style="text-align: center;">Vot</th>
                            <th scope="col" style="text-align: center;">Butiran</th>
                            <th scope="col" style="text-align: center;">Kuantiti</th>
                            <th scope="col" style="text-align: center;">Unit Ukuran</th>
                            <th scope="col" style="text-align: center;">Kadar Harga (RM)</th>
                            <th scope="col" style="text-align: center;">Jumlah (RM)</th>
                        </tr>
                    </thead>
                    <tbody id="data-table-body ">
                    </tbody>
                    <tbody>
                        <tr id="sum-row">
                            <td colspan="8" style="text-align: right; border: none;">JUMLAH KESELURUHAN (RM)</td>
                            <td colspan="1" id="sum-amaun-sebenar" style="text-align: right; border: none;">0.00</td>

                        </tr>
                        <tr>
                            <td colspan="9" style="text-align: right; border: none;"></td>
                        </tr>
                        <tr style="padding-top: 50px">
                            <td colspan="7" style="border-top: 0.5px solid #fff; width: 70%; border: 1px solid" colspan="2">
                                <p class="mb-2" style="margin-bottom: 20px;">Sila Bekalkan / laksanakan perkhidmatan yang dinyatakan di atas bersama pesanan tempatan ini, nota hantaran dan invois syarikat kepada :</p>
                                <p class="" style="font-weight: 700; line-height: 0.5" id="txtNama"></p>
                                <p class="" style="font-weight: 700; line-height: 0.5;" id="TxtVoIP"></p>
                                <p class="" style="font-weight: 700; line-height: 0.5;" id="txtPerjabat"></p>
                                <p class="" style="font-weight: 700; line-height: 0.5;" id="txtNamaKorporat"></p>
                                <p class="" style="font-weight: 700; line-height: 0.5;" id="txtAlamatKorporat"></p>

                                <p class="mt-2" style="margin-top: 20px;">Pesanan Tempatan ini akan dibatalkan jika bekalan perkhidmatan diterima selepas tarikh akhir bekalan/ perkhidmatan di atas.</p>
                            </td>
                            <td colspan="2" style="border-top: 0.5px solid #fff; width: 30%; border: 1px solid; text-align: center">

                                <p class="mt-5" style="margin-top: 140px;">.......................................................</p>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="9" style="border: none;">
                                <div style="border-top: 1px solid;"></div>
                                <h4 class="mb-5" style="font-weight: 700; text-align: center;">PEMBAYARAN TIDAK AKAN DIBUAT JIKA PERAKUAN MUTU TIDAK DIPENUHKAN ATAU JIKA PESANAN TEMPATAN TIDAK DIKEMBALIKAN</h4>
                                <div style="border-bottom: 1px solid;"></div>

                            </td>

                        </tr>
                        <tr>
                            <td colspan="9" style="border: none;">

                                <h5 class="mb-5" style="font-weight: 700"><u>PERAKUAN PEMABEKAL</u></h5>
                                <p class="mb-5">Saya memperakui bahawa saya telah *membekalkan barang-barang atau *melaksanakan perhidmatan yang tersebut di atas :  </p>

                            </td>

                        </tr>
                        <tr>
                            <td colspan="9" style="border: none;">
                                <div style="width: 100%; display: flex;">
                                    <div style="display: block; width: 30%; margin: 0px 10px">

                                        <p class="mt-5" style="margin-top: 70px;">.......................................................</p>
                                        <p style="margin-top: -15px;">Tandatangan Pembekal</p>
                                    </div>
                                    <div style="display: block; width: 30%; margin: 0px 10px">

                                        <p class="mt-5" style="margin-top: 70px;">.......................................................</p>
                                        <p style="margin-top: -15px;">Cop Pembekal</p>
                                    </div>
                                    <div style="display: block; width: 30%; margin: 0px 10px">

                                        <p class="mt-5" style="margin-top: 70px;">.......................................................</p>
                                        <p style="margin-top: -15px;">Tarikh</p>
                                    </div>
                                </div>
                                <div style="border-bottom: 1px solid; margin-top: 10px;"></div>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="9" style="border: none;">

                                <h5 class="mb-5" style="font-weight: 700"><u>PERAKUAN PTj</u></h5>
                                <p class="mb-5">Saya memperakui bahawa *Bekalan / *Perkhidmatan yang dibutirkan di atas telah *diterima / *dilaksanakan dengan muaskan dan saya juga memperakui amaun dan butiran yang dinyayakan dalam <strong>Pesanan Tempatan</strong> ini adalah sama dengan amaun yang dinyatakan dalam <strong>invois pembekal</strong> </p>

                            </td>

                        </tr>
                        <tr>
                            <td colspan="9" style="border: none;">
                                <div style="width: 100%; display: flex;">
                                    <div style="display: block; width: 30%; margin: 0px 10px">

                                        <p class="mt-5" style="margin-top: 70px;">.......................................................</p>
                                        <p style="margin-top: -15px;">Tandatangan Pemohon</p>
                                    </div>
                                    <div style="display: block; width: 30%; margin: 0px 10px">

                                        <p class="mt-5" style="margin-top: 70px;">.......................................................</p>
                                        <p style="margin-top: -15px;">Cop Pemohon</p>
                                    </div>
                                    <div style="display: block; width: 30%; margin: 0px 10px">
                                        <p class="mt-5" style="margin-top: 70px;">.......................................................</p>
                                        <p style="margin-top: -15px;">Tarikh</p>
                                    </div>
                                </div>
                            </td>

                        </tr>
                    </tbody>

                </table>

                <div style="display: none">
                    <table class="table">
                        <thead>
                            <tr class="header-space">
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="">
                            </tr>
                            <tr>
                                <td style="border-top: 0.5px solid #fff; width: 70%; border: 1px solid" colspan="2">
                                    <p class="mb-2" style="margin-bottom: 20px;">Sila Bekalkan / laksanakan perkhidmatan yang dinyatakan di atas bersama pesanan tempatan ini, nota hantaran dan invois syarikat kepada :</p>
                                    <p class="" style="font-weight: 700; line-height: 0.5" id="txtNama"></p>
                                    <p class="" style="font-weight: 700; line-height: 0.5;" id="TxtVoIP"></p>
                                    <p class="" style="font-weight: 700; line-height: 0.5;" id="txtPerjabat"></p>
                                    <p class="" style="font-weight: 700; line-height: 0.5;">
                                        <asp:Label ID="lblNamaKorporat" runat="server"></asp:Label>
                                    </p>
                                    <p class="" style="font-weight: 700; line-height: 0.5;">
                                        <asp:Label ID="lblAlamatKorporat" runat="server"></asp:Label>
                                    </p>
                                    <p class="mt-2" style="margin-top: 20px;">Pesanan Tempatan ini akan dibatalkan jika bekalan perkhidmatan diterima selepas tarikh akhir bekalan/ perkhidmatan di atas.</p>
                                </td>
                                <td style="border-top: 0.5px solid #fff; width: 30%; border: 1px solid; text-align: center">

                                    <p class="mt-5" style="margin-top: 140px;">.......................................................</p>

                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>

            </div>

            <script type="text/javascript">


                var Pesanan_ID = sessionStorage.getItem('No_Pesanan');

                // Check if the value exists
                if (Pesanan_ID !== null) {
                    // Value exists, do something with it
                    console.log("No_Pesanan:", Pesanan_ID);
                } else {
                    // Value does not exist in session storage
                    console.log("No_Pesanan not found in session storage");
                }

                // Get the label element by its ID
                var label1 = document.getElementById('lblNamaKorporat');
                var label2 = document.getElementById('lblAlamatKorporat');

                // Get the text content of the label
                document.getElementById('txtNamaKorporat').textContent = label1.textContent;
                document.getElementById('txtAlamatKorporat').textContent = label2.textContent;


                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/LoadPerolehan_Pesanan_print_Dtl") %>',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify({ IdPesanan: Pesanan_ID }), // Convert the data to a JSON string
                        success: function (data) {
                            // Parse the JSON data
                            var jsonData = JSON.parse(data.d);

                            console.log('jsonData', jsonData)
                            var Almt_Semasa_1
                            var Almt_Semasa_2
                            var Poskod_Semasa
                            var Bandar_name
                            var Negeri_name

                            if (jsonData[0].Almt_Semasa_1 === null || jsonData[0].Almt_Semasa_1 === '') {
                                Almt_Semasa_1 = '-'; // Replace with '-' if null or empty string
                            } else {
                                Almt_Semasa_1 = jsonData[0].Almt_Semasa_1;
                            }

                            if (jsonData[0].Almt_Semasa_2 === null || jsonData[0].Almt_Semasa_2 === '') {
                                Almt_Semasa_2 = ' '; // Replace with '-' if null or empty string
                            } else {
                                Almt_Semasa_2 = jsonData[0].Almt_Semasa_2;
                            }


                            if (jsonData[0].Poskod_Semasa === null || jsonData[0].Poskod_Semasa === '') {
                                Poskod_Semasa = '-'; // Replace with '-' if null or empty string
                            } else {
                                Poskod_Semasa = jsonData[0].Poskod_Semasa;
                            }

                            if (jsonData[0].Bandar_name === null || jsonData[0].Bandar_name === '') {
                                Bandar_name = '-'; // Replace with '-' if null or empty string
                            } else {
                                Bandar_name = jsonData[0].Bandar_name;
                            }

                            if (jsonData[0].Negeri_name === null || jsonData[0].Negeri_name === '') {
                                Negeri_name = '-'; // Replace with '-' if null or empty string
                            } else {
                                Negeri_name = jsonData[0].Negeri_name;
                            }

                            var AlamatSykt = Almt_Semasa_1 + ' ' + Almt_Semasa_2;
                            var AlamatSykt2 = Poskod_Semasa + ', ' + Bandar_name + ', ' + Negeri_name;
                            document.getElementById('txtNamaSykt').textContent = jsonData[0].Nama_Sykt;
                            document.getElementById('txtAlamatSykt').textContent = AlamatSykt
                            document.getElementById('txtAlamatSykt2').textContent = AlamatSykt2
                            document.getElementById('txtNo_SHT').textContent = jsonData[0].No_Sebut_Harga;
                            document.getElementById('txtNo_Pesanan').textContent = jsonData[0].No_Pesanan;
                            document.getElementById('txtNama').textContent = jsonData[0].MS01_Nama;
                            document.getElementById('txtPerjabat').textContent = jsonData[0].Pejabat;
                            document.getElementById('TxtVoIP').textContent = jsonData[0].MS01_VoIP;

                            // Assuming jsonData[0].Tarikh_Pesanan contains the date string in ISO format (e.g., "2024-02-20T12:00:00")
                            var tarikhPesanan = new Date(jsonData[0].Tarikh_Pesanan);

                            // Define a function to format the date as required
                            function formatDate(date) {
                                var year = date.getFullYear();
                                var month = (date.getMonth() + 1).toString().padStart(2, '0'); // Add leading zero if needed
                                var day = date.getDate().toString().padStart(2, '0'); // Add leading zero if needed
                                return day + '/' + month + '/' + year; // Adjust the format as needed (e.g., 'dd/mm/yyyy')
                            }

                            // Format the date and set the text content of txtTarikh_Pesanan
                            if (jsonData[0].Tarikh_Pesanan != null) {
                                document.getElementById('txtTarikh_Pesanan').textContent = formatDate(tarikhPesanan);
                            } else {
                                document.getElementById('txtTarikh_Pesanan').textContent = "-";
                            }



                        },
                        error: function (error) {
                            console.log("Error: " + error);
                        }
                    });
                });

                $(document).ready(function () {


                    tbl = $("#tblDataSenarai_Pesanan").DataTable({
                        "responsive": false,
                        "searching": false,
                        cache: false,
                        paging: false,
                        "ajax":
                        {
                            "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/LoadPerolehan_Pesanan_print") %>',
                            type: 'POST',
                            data: function (d) {
                                return "{ IdPesanan: '" + Pesanan_ID + "'}"
                            },
                            "contentType": "application/json; charset=utf-8",
                            "dataType": "json",
                            "dataSrc": function (json) {
                                return JSON.parse(json.d);
                            }

                        },



                        "columns": [

                            {
                                "data": "Bil",
                                render: function (data, type, row, meta) {
                                    return meta.row + meta.settings._iDisplayStart + 1;
                                },
                                "width": "5%"
                            },
                            {
                                "data": "Kod_Kump_Wang",
                                "width": "5%"
                            },
                            {
                                "data": "Kod_Ptj",
                                "width": "10%"
                            },
                            {
                                "data": "Kod_Vot",
                                "width": "10%"
                            },
                            {
                                "data": "Butiran",
                                "width": "30%"
                            },
                            {
                                "data": "Kuantiti",
                                "width": "10%"
                            },
                            {
                                "data": "Unit_Ukuran",
                                "width": "10%"
                            },
                            {
                                "data": "Kadar_Harga",
                                "width": "10%",
                                "render": function (data) {
                                    // Format the data with minimumFractionDigits: 2 and maximumFractionDigits: 2
                                    return parseFloat(data).toLocaleString(undefined, {
                                        minimumFractionDigits: 2,
                                        maximumFractionDigits: 2,
                                    });
                                },
                                "className": "text-right" // Align the content to the right
                            },
                            {
                                "data": "Jumlah_Harga",
                                "width": "10%",
                                "render": function (data) {
                                    // Format the data with minimumFractionDigits: 2 and maximumFractionDigits: 2
                                    return parseFloat(data).toLocaleString(undefined, {
                                        minimumFractionDigits: 2,
                                        maximumFractionDigits: 2,
                                    });
                                },
                                "className": "text-right" // Align the content to the right
                            },

                        ],



                        "drawCallback": function () {
                            var api = this.api();
                            var sum = api.column(8).data().reduce(function (a, b) {
                                return parseFloat(a) + parseFloat(b);
                            }, 0);

                            // Format the sum with commas as thousands separators and limit to two decimal places
                            var formattedSum = sum.toLocaleString(undefined, {
                                minimumFractionDigits: 2,
                                maximumFractionDigits: 2,
                            });

                            $("#sum-amaun-sebenar").text(formattedSum);
                        },

                        "initComplete": function () {
                            callPrint();
                        }



                    });


                    // Function to group and aggregate data
                    function groupAndAggregateData(data) {
                        var groupedData = {};
                        data.forEach(function (row) {
                            console.log(row);
                            var id = row.ID_Rujukan;
                            if (!groupedData[id]) {
                                groupedData[id] = {
                                    ID_Rujukan: id,
                                    Nama_PemiutangList: [],
                                    TotalJumlah_Bayar: [],
                                    TotalAmaun_Akan_Bayar: [],
                                    Kod_Kump_WangList: [],
                                    Kod_PTJList: [],
                                    Kod_VotList: [],
                                    TujuanList: [],
                                    APValueList: [],
                                    Jumlah_SebenarList: 0,
                                    JUMLAH_KESELURUHAN: 0
                                };
                            }
                            groupedData[id].Nama_PemiutangList.push(row.Nama_Pemiutang);
                            groupedData[id].TotalJumlah_Bayar.push(row.Jumlah_Bayar);
                            groupedData[id].TotalAmaun_Akan_Bayar.push(row.Amaun_Akan_Bayar);
                            groupedData[id].Kod_Kump_WangList.push(row.Kod_Kump_Wang);
                            groupedData[id].Kod_PTJList.push(row.Kod_PTJ);
                            groupedData[id].Kod_VotList.push(row.Kod_Vot);
                            groupedData[id].TujuanList.push(row.Butiran);
                            groupedData[id].APValueList.push(row.APValue);
                            groupedData[id].Jumlah_SebenarList += parseFloat(row.Jumlah_Sebenar);
                            //groupedData[id].JUMLAH_KESELURUHAN += parseFloat(row.Jumlah_Sebenar);

                        });

                        console.log(groupedData);
                        // Convert grouped data into an array of objects
                        var result = Object.values(groupedData);

                        console.log(result);

                        return result;
                    }



                });





                function callPrint() {
                    if (window.addEventListener) {
                        //getData();
                        window.print();
                    } else {
                        window.print();


                    }
                }



            </script>


        </div>
        <%--close master div--%>
    </form>
</body>
</html>


