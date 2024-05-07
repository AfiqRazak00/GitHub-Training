<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pengeluaran_Stor_Pusat.aspx.vb" Inherits="SMKB_Web_Portal.Pengeluaran_Stor_Pusat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
   <style>
       .codx {
            display: none;
            visibility: hidden;
        }
   </style>
    
    <contenttemplate>
      <div class="modal-body">
         <div class="tab-content" id="myTabContent">
               <div class="table-title">
                  <h5>Maklumat Permohonan</h5>
                    <hr>
                    <div class="btn btn-primary btnPapar" onclick="ShowPopup()">
                        Senarai Pengeluaran
                    </div>
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="row">
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group">
                              <div class="form-group input-group">
                                 <input type="text" id="noSiri" name="noSiri" class="input-group__input form-control input-sm" readonly>
                                <label class="input-group__label" for="noSiri">No Siri Permohonan</label>
                            </div>
                           </div>
                        </div>
                         <div class="col-lg-4 col-md-6">
                             <div class="form-group">
                               <div class="form-group input-group">
                                  <input type="text" id="ptj" name="ptj" class="input-group__input form-control input-sm" readonly />
                                  <label class="input-group__label">Bahagian/Fakulti</label>
                               </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="text" class="input-group__input form-control input-sm" id="tkhMohon" name="tkhMohon" readonly />
                              <label class="input-group__label">Tarikh Permohonan</label>
                           </div>
                        </div>
                    </div>
                </div>
               </div>
                <div class="table-title">
                <h5>Senarai Barangan</h5>
               </div>
               <div class="col-md-13">
                  <div class="transaction-table table-responsive">
                     <span style="display: inline-block; height: 100%;"></span>
                     <table id="tblBarangan" class="table table-striped">
                        <thead>
                           <tr style="width: 100%">
                               <th>Bil</th>
                               <th>Nama Barang</th>
                               <th>Tujuan Kegunaan</th>
                               <th >Unit Ukuran</th>
                               <th>Baki Stok</th>
                               <th>Kuantiti Mohon</th>
                               <th>Kuantiti Lulus</th>
                               <th>Lokasi</th>
                           </tr>
                        </thead>
                        <tbody id="tableBody">
                        </tbody>
                     </table>
                  </div>
               </div>
             <br />
             <br />
                <fieldset class="form-group border p-3" style="border-radius: 5px;">
                    <legend class="w-auto px-2 h6 font-weight-bold">Maklumat Pemohon</legend>
                 <div class="row">
                      <div class="col-md-12">
                         <div class="row">
                             <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="namaPemohon" name="namaPemohon" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="namaPemohon">Nama</label>
                                </div>
                               </div>
                            </div>
                             <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="jawatanPemohon" name="jawatanPemohon" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="jawatanPemohon">Jawatan</label>
                                </div>
                               </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="telPemohon" name="telPemohon" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="telPemohon">Telefon</label>
                                </div>
                               </div>
                            </div>
                        </div>
                         <div class="row">
                           <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="tkhPemohon" name="tkhPemohon" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="tkhPemohon">Tarikh Permohonan</label>
                                </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
             </fieldset>
             <fieldset class="form-group border p-3" style="border-radius: 5px;">
                <legend class="w-auto px-2 h6 font-weight-bold">Maklumat Pengesah</legend>
                 <div class="row">
                      <div class="col-md-12">
                         <div class="row">
                             <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="namaPengesah" name="namaPengesah" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="namaPengesah">Nama</label>
                                </div>
                               </div>
                            </div>
                             <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="jawatanPengesah" name="jawatanPengesah" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="jawatanPengesah">Jawatan</label>
                                </div>
                               </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="telPengesah" name="telPengesah" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="telPengesah">Telefon</label>
                                </div>
                               </div>
                            </div>
                        </div>
                         <div class="row">
                           <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="tkhPengesah" name="tkhPengesah" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="tkhPengesah">Tarikh Pengesahan</label>
                                </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
            <fieldset class="form-group border p-3" style="border-radius: 5px;">
                <legend class="w-auto px-2 h6 font-weight-bold">Maklumat Pelulus</legend>
                 <div class="row">
                      <div class="col-md-12">
                         <div class="row">
                             <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="namaPelulus" name="namaPelulus" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="namaPelulus">Nama</label>
                                </div>
                               </div>
                            </div>
                             <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group"> 
                                     <input type="text" id="jawatanPelulus" name="jawatanPelulus" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="jawatanPelulus">Jawatan</label>
                                </div>
                               </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="telPelulus" name="telPelulus" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="telPelulus">Telefon</label>
                                </div>
                               </div>
                            </div>
                        </div>
                         <div class="row">
                           <div class="col-lg-4 col-md-6">
                               <div class="form-group">
                                  <div class="form-group input-group">
                                     <input type="text" id="tkhPelulus" name="tkhPelulus" class="input-group__input form-control input-sm" readonly>
                                    <label class="input-group__label" for="tkhPelulus">Tarikh Kelulusan</label>
                                </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
            <div class="sticky-footer">
                <br />
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <div class="float-right">
                            <button type="button" class="btn btn-setsemula btnPadam ">Rekod Baru</button>
                            <button type="button" class="btn btn-secondary btnSimpan">Simpan</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
       <%-- MODAL--%>
       <div class="modal fade" id="permohonan" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan Untuk Proses Pengeluaran</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="search-filter">
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                                        style="text-align: right">
                                        Carian :</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <select id="categoryFilter" class="custom-select">
                                                <option value="" selected>Semua</option>
                                                <option value="1">Hari Ini</option>
                                                <option value="2">Semalam</option>
                                                <option value="3">7 Hari Lepas</option>
                                                <option value="4">30 Hari Lepas</option>
                                                <option value="5">60 Hari Lepas</option>
                                                <option value="6">Pilih Tarikh</option>
                                            </select>
                                            <div class="input-group-append">
                                                 <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button">
                                                     <i class="fa fa-search"></i>
                                                     Cari
                                                 </button>
                                             </div> 
                                        </div>
                                    </div>
                                    <div class="mt-4 d-none" id="divDatePicker">
                                        <div class="d-flex flex-row justify-content-around align-items-center">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label text-nowrap">Mula :</label>
                                                <div class="col-sm-9">
                                                    <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control date-range-filter">
                                                </div>
                                            </div>

                                            <div class="form-group row ml-3">
                                                <label class="col-sm-3 col-form-label text-nowrap">Tamat :</label>
                                                <div class="col-sm-9">
                                                    <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control date-range-filter">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                             <div class="modal-body">
                               <div class="col-md-13">
                                  <div class="transaction-table table-responsive">
                                     <span style="display: inline-block; height: 100%;"></span>
                                     <table id="tblSenaraiPengeluaran" class="table table-striped" style="width: 100% !important">
                                        <thead>
                                           <tr>
                                               <th>Bil</th>
                                               <th>No. Permohonan</th>
                                               <th>Tarikh Mohon</th>
                                               <th>Kuantiti Mohon</th>
                                               <th>Kuantiti Lulus</th>
                                               <th>Ptj</th>
                                           </tr>
                                        </thead>
                                        <tbody id="">
                                        </tbody>
                                     </table>
                                  </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           </div>

        <!-- Confirmation Modal-->
       <div class="modal fade" id="confirmationModalSubmit" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabelSubmit" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabelSubmit">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    </div>
                    <div class="modal-body">
                    Anda pasti ingin menyimpan rekod ini?
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-danger"
                        data-dismiss="modal">Tidak</button>
                    <button id="btnYaSubmit" type="button" class="btn default-primary">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <%--Modal Alert--%>
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    <h6 class="modal-title">Sistem Maklumat Kewangan Bersepadu</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    </div>
                    <div class="modal-body">
                    <div id="lblMessageModal"></div>
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnTutup">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var tblTransaksi = null;
            var tbl = null;
            var isClicked = false;
            var category_filter, startDate, endDate, selectedBekalan;
            $(document).ready(function () {

                $('.btnPadam').click(function () {
                    window.location.reload();
                });

                $('.btnSimpan').click(function () {
                    $('#confirmationModalSubmit').modal('show');
                });

                // Event listener for the "Ya" button in the confirmation modal
                $('#btnYaSubmit').click(function () {
                    $('#confirmationModalSubmit').modal('hide');
                    var NoMohon = $('#noSiri').val();

                    $.ajax({
                        url: 'PengeluaranWS.asmx/SimpanPengeluaran',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ NoMohon: NoMohon }),
                        success: function (response) {
                            // Parse the response JSON string from 'd'
                            var responseData = JSON.parse(response.d);

                            // Extract the message from the responseData object
                            var message = responseData.Message;
                            //console.log('message:', message);

                            // Update the content of the modal with the message
                            $('#lblMessageModal').html(message);

                            // Show the modal
                            $('#MessageModal').modal('show');
                        },
                        error: function (xhr, status, error) {
                            // Handle error
                            console.error('Error saving data:', error);
                            // Optionally, show an error message to the user
                            alert('An error occurred while saving data.');
                        }
                    });
                });

                $('#btnTutup').click(function () {
                    // Reload the page when the "Tutup" button is clicked
                    window.location.reload();
                });

                tbl = $("#tblSenaraiPengeluaran").DataTable({
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
                        "url": "PengeluaranWS.asmx/fetchSenaraiPengeluaran",
                        method: 'POST',
                        data: function (d) {
                            return "{ category_filter: '" + category_filter + "',isClicked: '" + isClicked + "',tkhMula: '" + startDate + "',tkhTamat: '" + endDate + "'}";
                        },
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
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

                        { "data": "No_Mohon" },
                        {
                            "data": "Tkh_Mohon",
                            "render": function (data, type, row, meta) {
                                // Parse the date string
                                var date = new Date(data);

                                // Extract day, month, and year
                                var day = date.getDate();
                                var month = date.getMonth() + 1; // Months are zero-based
                                var year = date.getFullYear();

                                // Ensure leading zeros if necessary
                                day = (day < 10) ? '0' + day : day;
                                month = (month < 10) ? '0' + month : month;

                                // Construct the formatted date string
                                var formattedDate = day + '/' + month + '/' + year;

                                return formattedDate;
                            }
                        },
                        { "data": "Kuantiti_Mohon" },
                        { "data": "Kuantiti_Lulus" },
                        { "data": "Kod_Ptj" }
                    ],
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });
                    },
                });

                $('#tblSenaraiPengeluaran tbody').on('click', 'tr', function () {
                    var rowData = tbl.row(this).data(); // Get data of the clicked row
                    var noMohon = rowData['No_Mohon']; // Extract No_Mohon from the clicked row
                    $('#noSiri').val(noMohon);

                    $('#permohonan').modal('hide');

                    show_loader();

                    tbl2 = $("#tblBarangan").DataTable({
                        "destroy": true,
                        "responsive": false,
                        "searching": false,
                        "paging": false,
                        scrollX: false, // Disable horizontal scrolling
                        scrollY: false, // Disable vertical scrolling
                        "language": {
                            "info": "", // Hide the "Showing 1 to 1 of 1 entries" message
                            "infoEmpty": "",
                            "infoFiltered": "",
                            "zeroRecords": "No data available"
                            // You can customize other language options as needed
                        },
                        "ajax": {
                            "url": "PengeluaranWS.asmx/fetchPengeluaranDetails",
                            method: 'POST',
                            "contentType": "application/json; charset=utf-8",
                            "dataType": "json",
                            "data": function () {
                                return JSON.stringify({
                                    noMohon: noMohon,
                                })
                            },
                            "dataSrc": function (json) {
                                close_loader();
                                var data = JSON.parse(json.d);
                                var NoStaf = data[0].No_Staf;
                                var tkh_mohon = data[0].Tkh_Mohon; // Assuming tkh_mohon is a property in the first object of the response array
                                var formattedDate = formatDate(tkh_mohon); // Call a function to format the date
                                $('#tkhMohon').val(formattedDate); // Display the formatted date
                                $('#tkhPemohon').val(formattedDate);

                                var optionText = data[0].KodPejabat + '-' + data[0].Pejabat;
                                $('#ptj').val(optionText);

                                getPemohonDetails(NoStaf);

                                return data;
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
                            { "data": "NamaBarang" },
                            { "data": "Tujuan" },
                            { "data": "Butiran" },
                            { "data": "Total_Baki_Unit" },
                            { "data": "Kuantiti_Mohon" },
                            { "data": "Kuantiti_Lulus" },
                            { "data": "Kod_Lokasi" }
                        ]
                    });

                    $.ajax({
                        url: 'PengeluaranWS.asmx/fetchPengesah',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ noMohon: noMohon }), // Include formDataArray and kodPtj
                        success: function (response) {

                            // Parse the response JSON string from 'd'
                            var data = JSON.parse(response.d);

                            var NoStaf1 = data[0].No_Staf;
                            var Tkh_Tindakan = data[0].Tkh_Tindakan;
                            var formattedDate = formatDate(Tkh_Tindakan);
                            $('#tkhPengesah').val(formattedDate);

                            getPengesahDetails(NoStaf1);

                        },
                        error: function (xhr, status, error) {
                            // Handle error
                            console.error('Error saving data:', error);
                            // Optionally, show an error message to the user
                            alert('An error occurred while saving data.');
                        }
                    });

                    $.ajax({
                        url: 'PengeluaranWS.asmx/fetchPelulus', 
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ noMohon: noMohon }), // Include formDataArray and kodPtj
                        success: function (response) {

                            // Parse the response JSON string from 'd'
                            var data = JSON.parse(response.d);

                            var NoStaf2 = data[0].No_Staf;
                            var Tkh_Tindakan1 = data[0].Tkh_Tindakan;
                            var formattedDate = formatDate(Tkh_Tindakan1);
                            $('#tkhPelulus').val(formattedDate);

                            getPelulusDetails(NoStaf2);

                        },
                        error: function (xhr, status, error) {
                            // Handle error
                            console.error('Error saving data:', error);
                            // Optionally, show an error message to the user
                            alert('An error occurred while saving data.');
                        }
                    });
                });
            });

            function formatDate(dateString) {
                var dateObject = new Date(dateString);
                var day = dateObject.getDate().toString().padStart(2, '0');
                var month = (dateObject.getMonth() + 1).toString().padStart(2, '0');
                var year = dateObject.getFullYear();
                return day + '/' + month + '/' + year;
            }

            function getPemohonDetails(NoStaf) {
                $.ajax({
                    url: 'PengeluaranWS.asmx/fetchPemohonDetails', // Replace with your web service endpoint
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ NoStaf: NoStaf }), // Include formDataArray and kodPtj
                    success: function (response) {

                        // Parse the response JSON string from 'd'
                        var data = JSON.parse(response.d);

                        $('#namaPemohon').val(data[0].Nama);
                        $('#jawatanPemohon').val(data[0].NamaJawatan);
                        $('#telPemohon').val(data[0].NoTel);

                    },
                    error: function (xhr, status, error) {
                        // Handle error
                        console.error('Error saving data:', error);
                        // Optionally, show an error message to the user
                        alert('An error occurred while saving data.');
                    }
                });
            }

            function getPengesahDetails(NoStaf1) {
                $.ajax({
                    url: 'PengeluaranWS.asmx/fetchPemohonDetails', // Replace with your web service endpoint
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ NoStaf: NoStaf1 }), // Include formDataArray and kodPtj
                    success: function (response) {

                        // Parse the response JSON string from 'd'
                        var data = JSON.parse(response.d);

                        $('#namaPengesah').val(data[0].Nama);
                        $('#jawatanPengesah').val(data[0].NamaJawatan);
                        $('#telPengesah').val(data[0].NoTel);

                    },
                    error: function (xhr, status, error) {
                        // Handle error
                        console.error('Error saving data:', error);
                        // Optionally, show an error message to the user
                        alert('An error occurred while saving data.');
                    }
                });
            }

            function getPelulusDetails(NoStaf2) {
                $.ajax({
                    url: 'PengeluaranWS.asmx/fetchPemohonDetails', // Replace with your web service endpoint
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ NoStaf: NoStaf2 }), // Include formDataArray and kodPtj
                    success: function (response) {

                        // Parse the response JSON string from 'd'
                        var data = JSON.parse(response.d);

                        $('#namaPelulus').val(data[0].Nama);
                        $('#jawatanPelulus').val(data[0].NamaJawatan);
                        $('#telPelulus').val(data[0].NoTel);

                    },
                    error: function (xhr, status, error) {
                        // Handle error
                        console.error('Error saving data:', error);
                        // Optionally, show an error message to the user
                        alert('An error occurred while saving data.');
                    }
                });
            }

            $('.btnSearch').click(async function () {
                isClicked = true;
                category_filter = $('#categoryFilter').val();

                if (category_filter == "6") {
                    startDate = $('#txtTarikhStart').val();
                    endDate = $('#txtTarikhEnd').val();
                } else {
                    startDate = "";
                    endDate = "";
                }
                tbl.ajax.reload();
            })

            $("#categoryFilter").change(function (e) {
                var selectedItem = $('#categoryFilter').val()
                if (selectedItem == "6" && selectedItem !== "") {
                    $('#divDatePicker').addClass("d-flex").removeClass("d-none");
                    $('#txtTarikhStart').val("")
                    $('#txtTarikhEnd').val("")
                }
                else {
                    $('#divDatePicker').removeClass("d-flex").addClass("d-none");
                    $('#txtTarikhStart').val("")
                    $('#txtTarikhEnd').val("")
                }
            });

            function ShowPopup() {
                tbl.clear().draw();
                $('#permohonan').modal('toggle');
            }
        </script>
    </contenttemplate>
</asp:Content>
