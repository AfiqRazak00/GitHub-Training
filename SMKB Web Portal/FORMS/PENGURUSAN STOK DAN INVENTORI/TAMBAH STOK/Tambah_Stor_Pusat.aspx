<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Tambah_Stor_Pusat.aspx.vb" Inherits="SMKB_Web_Portal.Tambah_Stor_Pusat" %>

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
                  <h5>Maklumat Bekalan</h5>
                    <hr>
                    <div class="btn btn-primary btnPapar" onclick="ShowPopup()">
                        Senarai Stok
                    </div>
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="row">
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group">
                              <div class="form-group input-group">
                                 <select class="input-group__select ui search dropdown" placeholder="" name="ddlKategori" id="ddlKategori">
                                 </select>
                                 <label class="input-group__label" for="ddlKategori">Kategori <span style="color:red">*</span></label>
                              </div>
                           </div>
                        </div>
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group">
                              <div class="form-group input-group">
                                 <select class="input-group__select ui search dropdown" placeholder="" name="ddlBekalan" id="ddlBekalan">
                                 </select>
                                 <label class="input-group__label" for="ddlBekalan">Senarai Bekalan <span style="color:red">*</span></label>
                              </div>
                           </div>
                        </div>
                       <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="text" class="id_ukuran input-group__input form-control input-sm" placeholder="" name="" value="" readonly />
                              <label class="input-group__label">Unit Ukuran</label>
                           </div>
                        </div>
                    </div>
                     <div class="row">
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="text" class="id_lokasi input-group__input form-control input-sm" placeholder="" name="" value="" readonly />
                              <label class="input-group__label">Lokasi</label>
                           </div>
                        </div>
                     </div>
                </div>
               </div>
               <div class="table-title">
                  <h5>Maklumat Terimaan</h5>
                    <hr>
               </div>
             <div class="row">
                  <div class="col-md-12">
                     <div class="row">
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group">
                              <div class="form-group input-group">
                                 <input type="date" id="tarikh" name="tarikh" class="input-group__input form-control date-range-filter">
                                <label class="input-group__label" for="tarikh">Tarikh <span style="color:red">*</span></label>
                                  <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                            </div>
                           </div>
                        </div>
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="time" class="id_masa input-group__input form-control input-sm" placeholder="" name="" value="" />
                              <label class="input-group__label">Masa <span style="color:red">*</span></label>
                               <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                           </div>
                        </div>
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group">
                              <div class="form-group input-group">
                                 <select class="input-group__select ui search dropdown" placeholder="" name="ddlSyarikat" id="ddlSyarikat">
                                 </select>
                                 <label class="input-group__label" for="ddlSyarikat">Syarikat<span style="color:red">*</span></label>
                                  <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                              </div>
                           </div>
                        </div>
                    </div>
                     <div class="row">
                       <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="number" class="id_kuantiti input-group__input form-control input-sm" placeholder="" name="" value="" />
                              <label class="input-group__label">Kuantiti <span style="color:red">*</span></label>
                               <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                           </div>
                        </div>
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="number" class="id_harga input-group__input form-control input-sm" placeholder="" name="" min="0" step="0.01"  />
                              <label class="input-group__label">Harga Seunit (RM) <span style="color:red">*</span></label>
                               <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                           </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="form-group input-group">
                                <input type="number" class="id_jumlah input-group__input form-control input-sm" placeholder="" name="" min="0" step="0.01" readonly/>
                                <label class="input-group__label">Jumlah (RM)</label>
                                <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                            </div>
                        </div>
                    </div>
                      <div class="row">
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="text" class="id_rujukan input-group__input form-control input-sm" placeholder="" name="" value=""  />
                              <label class="input-group__label">No. Rujukan <span style="color:red">*</span></label>
                               <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                           </div>
                        </div>
                     </div>
               <div class="table-title">
                <h5>Senarai Transaksi Terimaan Barangan</h5>
               </div>
               <div class="col-md-13">
                  <div class="transaction-table table-responsive">
                     <span style="display: inline-block; height: 100%;"></span>
                     <table id="tblTransaksi" class="table table-striped">
                        <thead>
                           <tr style="width: 100%">
                               <th>Bil</th>
                               <th>Tarikh</th>
                               <th>Masa</th>
                               <th>No. Rujukan</th>
                               <th style="width: 30% !important">Catatan</th>
                               <th>Kuantiti</th>
                               <th>Harga Seunit (RM)</th>
                               <th>Jumlah (RM)</th>
                           </tr>
                        </thead>
                        <tbody id="tableBody">
                        </tbody>
                     </table>
                    <div class="sticky-footer">
                        <br />
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <div class="float-right">
                                    <button type="button" class="btn btn-setsemula btnPadam ">Rekod Baru</button>
                                    <button type="button" class="btn btn-secondary btnSimpan">Simpan</button>
                                    <button type="button" class="btn btn-danger btnHapus" style="display: none;">Hapus</button>
                                </div>
                            </div>
                        </div>
                    </div>
                  </div>
               </div>
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
       <%-- MODAL--%>
       <div class="modal fade" id="permohonan" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Stok</h5>
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
                                     <table id="tblSenaraiStok" class="table table-striped" style="width: 100% !important">
                                        <thead>
                                           <tr>
                                               <th>Bil</th>
                                               <th>Tarikh</th>
                                               <th style="width: 30% !important">Nama Syarikat</th>
                                               <th>Barang</th>
                                               <th>Harga Unit</th>
                                               <th>Baki Unit</th>
                                               <th>Status</th>
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
                        <div id="confirmationMessage"></div>
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-danger"
                        data-dismiss="modal">Tidak</button>
                    <button id="btnYaSubmit" type="button" class="btn default-primary">Ya</button>
                    </div>
                </div>
            </div>
        </div>
       <script>
           // Get input fields
           const kuantitiInput = document.querySelector('.id_kuantiti');
           const hargaInput = document.querySelector('.id_harga');
           const jumlahInput = document.querySelector('.id_jumlah');

           // Add event listeners to kuantiti and harga fields
           kuantitiInput.addEventListener('input', updateJumlah);
           hargaInput.addEventListener('input', updateJumlah);

           // Function to update jumlah field
           function updateJumlah() {
               // Get values from input fields
               const kuantiti = parseFloat(kuantitiInput.value);
               const harga = parseFloat(hargaInput.value);

               // Calculate jumlah
               const jumlah = kuantiti * harga;

               // Update jumlah field
               jumlahInput.value = isNaN(jumlah) ? '' : jumlah.toFixed(2);
           }
       </script>
       <script>
           var tblTransaksi = null;
           var tbl = null;
           var isClicked = false;
           var category_filter, startDate, endDate, selectedBekalan;

           $(document).ready(function () {
               fetchDdlSyarikat();

               tbl = $("#tblSenaraiStok").DataTable({
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
                       "url": "StokTambahWS.asmx/fetchSenaraiStok",
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
                       { "data": "ID_Inv" },
                       { "data": "Nama_Sykt" },
                       { "data": "Butiran" },
                       { "data": "Harga_Unit" },
                       { "data": "Baki_Unit" },
                       {
                           "data": "Status",
                           "render": function (data, type, row) {
                               // Customize the rendering based on the data
                               return data == 1 ? "Aktif" : "Tidak Aktif";
                           }
                       }
                   ]
               });
           });


           $('.btnSearch').click(async function () {
               /*show_loader();*/
               /*selectedBekalan = $('#ddlBekalan').val();*/
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

           $(document).ready(function () {
               $(".txtEror").addClass("codx");

               $('.btnSimpan').click(function () {
                   var idBarang = $("#ddlBekalan").val();
                   var tarikhValue = $("#tarikh").val();
                   var kuantiti = $(".id_kuantiti").val(); // Properly declared variable
                   var masa = $(".id_masa").val(); // Properly declared variable
                   var harga_seunit = $(".id_harga").val();
                   var idSyarikat = $("#ddlSyarikat").val();
                   var jumlah = $(".id_jumlah").val();
                   var no_rujukan = $(".id_rujukan").val();

                   // Check if any of the required fields are empty
                   if (idBarang && tarikhValue && kuantiti && masa && harga_seunit && idSyarikat && jumlah && no_rujukan) {
                       $(".txtEror").addClass("codx");
                       $('#confirmationMessage').html("Anda pasti ingin menyimpan rekod ini ? ");
                       $('#confirmationModalSubmit').modal('show');
                       
                   } else {
                       // Some required fields are empty, display error message or highlight empty fields
                       const elementsToCheck = [
                           { condition: !idBarang, selector: "#ddlBekalan" },
                           { condition: !tarikhValue, selector: "#tarikh" },
                           { condition: !kuantiti, selector: ".id_kuantiti" },
                           { condition: !masa, selector: ".id_masa" },
                           { condition: !harga_seunit, selector: ".id_harga" },
                           { condition: !idSyarikat, selector: "#ddlSyarikat" },
                           { condition: !jumlah, selector: ".id_jumlah" },
                           { condition: !no_rujukan, selector: ".id_rujukan" }
                       ];

                       elementsToCheck.forEach(({ condition, selector }) => {
                           const element = $(selector).closest('.form-group').find('.txtEror');
                           if (condition) {
                               if ($(selector).is('select')) {
                                   $(selector).parent().addClass("border border-danger");
                               } else {
                                   $(selector).addClass("border border-danger");
                               }
                               element.removeClass('codx');
                           } else {
                               if ($(selector).is('select')) {
                                   $(selector).parent().removeClass("border border-danger");
                               } else {
                                   $(selector).removeClass("border border-danger");
                               }
                               element.addClass('codx');
                           }
                       });
                   }
               });

               // Event listener for the "Ya" button in the confirmation modal
               $('#btnYaSubmit').click(function () {
                   $('#confirmationModalSubmit').modal('hide');
                   saveData();
               });

               $('#btnTutup').click(function () {
                   // Reload the page when the "Tutup" button is clicked
                   window.location.reload();
               });

               $('.btnPadam').click(function () {
                   window.location.reload();
               });

               $('.btnHapus').click(function () {
                   idBarang = $("#ddlBekalan").val(),
                   tarikh = $("#tarikh").val(),
                   kuantiti = $(".id_kuantiti").val(),
                   masa = $(".id_masa").val(),
                   harga_seunit = $(".id_harga").val(),
                   idSyarikat = $("#ddlSyarikat").val()

                   $.ajax({
                       url: "StokTambahWS.asmx/UpdateTambahStok",
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       dataType: "json",
                       data: JSON.stringify({ idBarang: idBarang, tarikh: tarikh, kuantiti: kuantiti, masa: masa, harga_seunit: harga_seunit, idSyarikat: idSyarikat}),
                       success: function (response) {
                           // Handle success response from server
                           console.log('Data saved successfully:', response);

                           // Parse the response JSON string from 'd'
                           var responseData = JSON.parse(response.d);

                           // Extract the message from the responseData object
                           var message = responseData.Message;
                           console.log('message:', message);

                           // Update the content of the modal with the message
                           $('#lblMessageModal').html(message);

                           // Show the modal
                           $('#MessageModal').modal('show');
                       },
                       error: function (error) {
                           console.error("AJAX error:", error.responseText);
                       }
                   });
               });

               $.ajax({
                   url: "StokTambahWS.asmx/fetchDdlKategori",
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       try {
                           var responseData = JSON.parse(response.d);

                           if (Array.isArray(responseData) && responseData.length > 0) {
                               var ddlKategori = $("#ddlKategori");
                               ddlKategori.empty(); // Clear existing options
                               ddlKategori.append($("<option></option>").text("Pilih Kategori").val(""));
                               responseData.forEach(function (item) {
                                   if (item.Kod_Kategori && item.Butiran) { // Check if properties are defined
                                       var optionText = item.Kod_Kategori + '-' + item.Butiran;
                                       ddlKategori.append($("<option></option>").text(optionText).val(item.Kod_Kategori));
                                   }
                               });
                               ddlKategori.dropdown(); // Initialize dropdown
                           }
                       } catch (error) {
                           console.error("Error parsing response:", error);
                       }
                   },
                   error: function (error) {
                       console.error("AJAX error:", error.responseText);
                   }
               });
               
               $('#ddlKategori').on('change', function () {
                   var selectedKategori = $("#ddlKategori").val(); // Retrieve selected value from ddlKategori

                   $.ajax({
                       url: "StokTambahWS.asmx/fetchDdlBekalan",
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       data: JSON.stringify({ kodKategori: selectedKategori }),
                       dataType: "json",
                       success: function (response) {
                           try {
                               var responseData = JSON.parse(response.d);

                               if (Array.isArray(responseData) && responseData.length > 0) {
                                   var ddlBekalan = $("#ddlBekalan");
                                   ddlBekalan.empty(); // Clear existing options
                                   ddlBekalan.append($("<option></option>").text("Pilih Bekalan").val(""));
                                   responseData.forEach(function (item) {
                                       if (item.Kod_Brg && item.Butiran) { // Check if properties are defined
                                           var optionText = item.Kod_Brg + '-' + item.Butiran;
                                           ddlBekalan.append($("<option></option>").text(optionText).val(item.Kod_Brg));
                                       }
                                   });
                                   ddlBekalan.dropdown(); // Initialize dropdown
                               }
                           } catch (error) {
                               console.error("Error parsing response:", error);
                           }
                       },
                       error: function (error) {
                           console.error("AJAX error:", error.responseText);
                       }
                   });
               });

               $('#ddlBekalan').on('change', function () {
                   var selectedBekalan = $("#ddlBekalan").val(); // Retrieve selected value from ddlKategori

                   $(".txtEror").addClass("codx");
                   $("#ddlSyarikat").parent().removeClass("border border-danger");
                   $("#ddlBekalan").parent().removeClass("border border-danger");
                   $('.id_masa').removeClass("border border-danger");
                   $('.id_rujukan').removeClass("border border-danger");
                   $('.id_kuantiti').removeClass("border border-danger");
                   $('#tarikh').removeClass("border border-danger");
                   $('.id_harga').removeClass("border border-danger");
                   $('.id_jumlah').removeClass("border border-danger");

                   $.ajax({
                       url: "StokTambahWS.asmx/fetchBekalanDetails",
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       data: JSON.stringify({ kodBekalan: selectedBekalan }),
                       dataType: "json",
                       success: function (response) {
                           // Reset the values of input fields in Maklumat Terimaan section
                           $("#tarikh").val(""); // Reset Tarikh field
                           $(".id_masa").val(""); // Reset Masa field
                           $(".id_kuantiti").val(""); // Reset Kuantiti field
                           $(".id_harga").val(""); // Reset Harga Seunit field
                           $(".id_jumlah").val(""); // Reset Jumlah field
                           $(".id_rujukan").val(""); // Reset No. Rujukan field

                           // Parse the JSON string within the "d" property
                           var responseData = JSON.parse(response.d);
                           // Check if responseData is an array and has at least one element
                           if (Array.isArray(responseData) && responseData.length > 0) {
                               // Access the properties of the first element
                               $(".id_ukuran").val(responseData[0].Butiran);
                               $(".id_lokasi").val(responseData[0].Kod_Lokasi);
                           }
                       },
                       error: function (error) {
                           console.error("AJAX error:", error.responseText);
                       }
                   });

                   $('.btnSimpan').show();
                   $('.btnHapus').hide();
                   fetchDdlSyarikat();
                   loadTblTransaksi();
               });

               // Add an event listener to the rows of tblTransaksi
               $('#tblTransaksi tbody').on('click', 'tr', function () {
                   $(".txtEror").addClass("codx");
                   $("#ddlSyarikat").parent().removeClass("border border-danger");
                   $('.id_masa').removeClass("border border-danger");
                   $('.id_rujukan').removeClass("border border-danger");
                   $('.id_kuantiti').removeClass("border border-danger");
                   $('#tarikh').removeClass("border border-danger");
                   $('.id_harga').removeClass("border border-danger");
                   $('.id_jumlah').removeClass("border border-danger");

                   var rowData = tblTransaksi.row(this).data(); // Get data of the clicked row

                   var date = new Date(rowData['Tkh_Transaksi']);

                   // Extract day, month, and year
                   var day = date.getDate();
                   var month = date.getMonth() + 1; // Months are zero-based
                   var year = date.getFullYear();

                   // Ensure leading zeros if necessary
                   day = (day < 10) ? '0' + day : day;
                   month = (month < 10) ? '0' + month : month;

                   // Construct the formatted date string
                   var tarikh = year + '-' + month + '-' + day;

                   //var tarikh = rowData['Tkh_Transaksi'];
                   console.log(tarikh);
                   var masa = rowData['Masa_Transaksi']; // Extract Masa_Transaksi from the clicked row
                   var noRujukan = rowData['No_Rujukan'];
                   var syarikat = rowData['Nama_Sykt'];
                   var kuantiti = rowData['Kuantiti'];
                   var harga = rowData['Harga_Unit'];
                   var jumlah = rowData['Jum_Harga'];


                   $('.id_masa').val(masa);
                   $('.id_rujukan').val(noRujukan);
                   $('#tarikh').val(tarikh);
                   $('.id_kuantiti').val(kuantiti);
                   $('.id_harga').val(harga);
                   $('.id_jumlah').val(jumlah);

                   $.ajax({
                       url: "StokTambahWS.asmx/fetchSelectedDdlSyarikat",
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       data: JSON.stringify({ syarikat: syarikat }),
                       dataType: "json",
                       success: function (response) {
                           try {
                               var responseData = JSON.parse(response.d);

                               if (Array.isArray(responseData) && responseData.length > 0) {
                                   var ddlSyarikat = $("#ddlSyarikat");
                                   ddlSyarikat.empty(); // Clear existing options
                                   responseData.forEach(function (item) {
                                       if (item.ID_Sykt && item.Nama_Sykt) { // Check if properties are defined
                                           var optionText = item.ID_Sykt + '-' + item.Nama_Sykt;
                                           ddlSyarikat.append($("<option></option>").text(optionText).val(item.ID_Sykt));
                                       }
                                   });
                                   ddlSyarikat.dropdown(); // Initialize dropdown
                               }
                           } catch (error) {
                               console.error("Error parsing response:", error);
                           }
                       },
                       error: function (error) {
                           console.error("AJAX error:", error.responseText);
                       }
                   });

                   $('.btnSimpan').hide();
                   $('.btnHapus').show();
               });

           });

           function fetchDdlSyarikat() {
               var ddlSyarikat = $("#ddlSyarikat");
               ddlSyarikat.empty(); // Clear existing options
               ddlSyarikat.append($("<option></option>").text("Pilih Syarikat").val("").prop('selected', true)); // Set selected value to "Pilih Syarikat"

               $.ajax({
                   url: "StokTambahWS.asmx/fetchDdlSyarikat",
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       try {
                           var responseData = JSON.parse(response.d);

                           if (Array.isArray(responseData) && responseData.length > 0) {
                               responseData.forEach(function (item) {
                                   if (item.ID_Sykt && item.Nama_Sykt) { // Check if properties are defined
                                       var optionText = item.ID_Sykt + '-' + item.Nama_Sykt;
                                       ddlSyarikat.append($("<option></option>").text(optionText).val(item.ID_Sykt));
                                   }
                               });
                               ddlSyarikat.dropdown(); // Initialize dropdown
                           }
                       } catch (error) {
                           console.error("Error parsing response:", error);
                       }
                   },
                   error: function (error) {
                       console.error("AJAX error:", error.responseText);
                   }
               });
           }

           function saveData() {
               var idBarang = $("#ddlBekalan").val();
               var tarikhValue = $("#tarikh").val();
               var kuantiti = $(".id_kuantiti").val(); // Properly declared variable
               var masa = $(".id_masa").val(); // Properly declared variable
               var harga_seunit = $(".id_harga").val();
               var idSyarikat = $("#ddlSyarikat").val();
               var jumlah = $(".id_jumlah").val();
               var no_rujukan = $(".id_rujukan").val();

                $.ajax({
                    url: "StokTambahWS.asmx/SimpanTambahStok",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({
                        idBarang: idBarang,
                        tarikh: tarikhValue,
                        kuantiti: kuantiti,
                        masa: masa,
                        harga_seunit: harga_seunit,
                        idSyarikat: idSyarikat,
                        jumlah: jumlah,
                        no_rujukan: no_rujukan
                    }),
                    success: function (response) {
                        // Handle success response from server
                        console.log('Data saved successfully:', response);

                        // Parse the response JSON string from 'd'
                        var responseData = JSON.parse(response.d);

                        // Extract the message from the responseData object
                        var message = responseData.Message;
                        console.log('message:', message);

                        // Update the content of the modal with the message
                        $('#lblMessageModal').html(message);

                        // Show the modal
                        $('#MessageModal').modal('show');
                    },
                    error: function (error) {
                        console.error("AJAX error:", error.responseText);
                    }
                });
           }



           function loadTblTransaksi() {
               show_loader();
               tblTransaksi = $("#tblTransaksi").DataTable({
                   "destroy": true,
                   "responsive": true,
                   "searching": true,
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
                       "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                       "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                       "sEmptyTable": "Tiada rekod.",
                       "sSearch": "Carian"
                   },
                   "ajax": {
                       "url": "StokTambahWS.asmx/fetchTransaksi",
                       method: 'POST',
                       "contentType": "application/json; charset=utf-8",
                       "dataType": "json",
                       "data": function () {
                           var kodBekalan = $('#ddlBekalan').val(); // Get the selected value of ddlBekalan
                           return JSON.stringify({
                               kodBekalan: kodBekalan
                           })
                       },
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
                       /*{ "data": "Tarikh_Transaksi" },*/
                       {
                           "data": "Tkh_Transaksi",
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
                       { "data": "Masa_Transaksi" },
                       { "data": "No_Rujukan" },
                       { "data": "Nama_Sykt" },
                       { "data": "Kuantiti" },
                       { "data": "Harga_Unit" },
                       { "data": "Jum_Harga" },
                   ],
                   "rowCallback": function (row, data) {
                       // Add hover effect
                       $(row).hover(function () {
                           $(this).addClass("hover pe-auto bg-warning");
                       }, function () {
                           $(this).removeClass("hover pe-auto bg-warning");
                       });
                   }
               });
           }
       </script>
    </contenttemplate>
</asp:Content>