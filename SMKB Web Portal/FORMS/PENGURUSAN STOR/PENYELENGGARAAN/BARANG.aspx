<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="BARANG.aspx.vb" Inherits="SMKB_Web_Portal.BARANG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
   <link type="text/css" rel="stylesheet" href="../../../Scripts/jquery 1.13.3/css/jquery.dataTables.min.css" />
   <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/dataTables.bootstrap.min.css" />
   <link type="text/css" rel="stylesheet" href="../../../Scripts/bootstrap 3.3.7/bootstrap.min.js" />
   <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/responsive.bootstrap.min.css" />
   <style>
      .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
      color: #000;
      font-weight: bold;
      background-color: #FFC83D;
      }
      .tab-pane {
      border-left: 1px solid #ddd;
      border-right: 1px solid #ddd;
      border-bottom: 1px solid #ddd;
      border-radius: 0px 0px 5px 5px;
      padding: 10px;
      }
      .nav-tabs .nav-link {
      padding: 0.25rem 0.5rem;
      }
      #bidang_mof_table {
      width: 75%;
      }
      #cidb_table th, #cidb_table td {
      padding: 7px;
      }
      #bidang_mof_table th, #bidang_mof_table td {
      padding: 7px;
      }
      #cidb_table {
      width: 50%;
      }
      /* Chrome, Safari, Edge, Opera */
      input::-webkit-outer-spin-button,
      input::-webkit-inner-spin-button {
      -webkit-appearance: none;
      margin: 0;
      }
      /* Firefox */
      input[type=number] {
      -moz-appearance: textfield;
      }
      /*input CSS */
      .input-group {
      margin-bottom: 20px;
      position: relative;
      }
      .input-group__label {
      display: block;
      position: absolute;
      top: 0;
      line-height: 40px;
      color: #aaa;
      left: 5px;
      padding: 0 5px;
      transition: line-height 200ms ease-in-out, font-size 200ms ease-in-out, top 200ms ease-in-out;
      pointer-events: none;
      }
      .input-group__input {
      width: 100%;
      height: 40px;
      border: 1px solid #dddddd;
      border-radius: 5px;
      padding: 0 10px;
      }
      .input-group__input:not(:-moz-placeholder-shown) + label {
      background-color: white;
      line-height: 10px;
      opacity: 1;
      font-size: 10px;
      top: -5px;
      }
      .input-group__input:not(:-ms-input-placeholder) + label {
      background-color: white;
      line-height: 10px;
      opacity: 1;
      font-size: 10px;
      top: -5px;
      }
      .input-group__input:not(:placeholder-shown) + label, .input-group__input:focus + label {
      background-color: white;
      line-height: 10px;
      opacity: 1;
      font-size: 10px;
      top: -5px;
      }
      .input-group__input:focus {
      outline: none;
      border: 1px solid #01080D;
      }
      .input-group__input:focus + label {
      color: #01080D;
      }
      .input-group__select + label {
      background-color: white;
      line-height: 10px;
      opacity: 1;
      font-size: 10px;
      top: -5px;
      }
      .input-group__select:focus + label {
      color: #01080D;
      }
      /* Styles for the focused dropdown */
      .input-group__select:focus {
      outline: none;
      border: 1px solid #01080D;
      }
      .input-group__label-floated {
      /* Apply styles for the floating label */
      /* For example: */
      top: -5px;
      font-size: 10px;
      line-height: 10px;
      color: #01080D;
      opacity: 1;
      }
      #tblSenaraiPerolehan td:hover {
      cursor: pointer;
      }
      .speksize {
      width: 800px;
      height: 90px;
      }
      .spacekanan {
      margin-right: 20px;
      }
      .modal-header--sticky {
      position: sticky;
      top: 0;
      background-color: inherit;
      z-index: 1055;
      }
      .modal-footer--sticky {
      position: sticky;
      bottom: 0;
      background-color: inherit;
      z-index: 1055;
      }
      p {
      line-height: 0.1;
      }
      .modal-content2 {
      border-top: 5px solid #ddd;
      }
      .form-group.border.p-3 {
      padding: 20px;
      }
      .modal-content {
      max-width: 650px; /* Set the maximum width for the modal content */
      margin: auto; /* Center the modal horizontally */
      }
      .form-group {
      /* Optionally, adjust the width of the form elements if needed */
      max-width: 100%; /* Set the maximum width for the form elements */
      }
   </style>
   <!-------------------------------------------------------------------  STYLE END  -------------------------------------------------------------------------->
   <!------------------------------------------------------------------  CODE START  -------------------------------------------------------------------------->
   <contenttemplate>
      <div id="PermohonanTab" class="tabcontent" style="display: block">
         <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <div class="modal-title">
                        <h6>Tambah Barang</h6>
                     </div>
                  </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="col-md-12">
                           <div class="form-row">
                              <div class="form-group col-md-6">
                                 <input class="input-group__input" id="kodBarang" placeholder="&nbsp;" name="Kod" />
                                 <label class="input-group__label" for="Kod">Kod Barang</label>
                              </div>
                              <div class="form-group col-md-6">
                                 <div class="form-group col-md-6">
                                    <select class="ui search dropdown barangUkuran" name="ukuranBarang" id="ukuranBarang"></select>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-md-12">
                           <div class="form-row">
                              <div class="form-group col-md-6">
                                 <input class="input-group__input" id="butiranBarang" placeholder="&nbsp;" name="butiranBarang" />
                                 <label class="input-group__label" for="butiranBarang">Butiran</label>
                              </div>
                              <div class="form-group col-md-6">
                                 <div class="form-group col-md-6">
                                    <select class="ui search dropdown barangKategori" name="kategoriBarang" id="kategoriBarang"></select>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="form-group col-md-2">
                        <label>Status</label>
                        <div class="radio-btn-form" id="rdstatusBarang" name="rdAktif">
                           <div class="form-check form-check-inline radio-size">
                              <input type="radio" id="rdYa" name="inlineRadioOptions" id="inlineRadio1"
                                 value="1" />&nbsp; Aktif
                           </div>
                           <div class="form-check form-check-inline radio-size">
                              <input type="radio" id="rdTidak" id="inlineRadio2"
                                 name="inlineRadioOptions" value="0" />&nbsp; Tidak
                           </div>
                        </div>
                     </div>
                     <div align="right">
                        <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                        <button type="button" class="btn btn-secondary btnSimpan" id="btnSimpan"
                           data-toggle="tooltip" data-placement="bottom"
                           title="Draft">
                        Simpan</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <div class="modal fade" id="permohonan2" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <div class="modal-title">
                        <h6>Barang</h6>
                     </div>
                  </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="col-md-12">
                           <div class="form-row">
                              <div class="form-group col-md-6">
                                 <input class="input-group__input" name="kodBarang2" id="kodBarang2" type="text" readonly style="background-color: #f0f0f0" />
                                 <label class="input-group__label" for="kodBarang2">Kod Barang</label>
                              </div>
                              <div class="form-group col-md-6">
                                 <div class="form-group col-md-6">
                                    <select class="ui search dropdown barangUkuran" name="ukuranBarang2" id="ukuranBarang2"></select>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-md-12">
                           <div class="form-row">
                              <div class="form-group col-md-6">
                                 <input class="input-group__input" iname="butiranBarang2" id="butiranBarang2" type="text" readonly style="background-color: #f0f0f0" />
                                 <label class="input-group__label" for="butiranBarang2">Butiran</label>
                              </div>
                              <div class="form-group col-md-6">
                                 <div class="form-group col-md-6">
                                    <select class="ui search dropdown barangKategori" name="kategoriBarang2" id="kategoriBarang2"></select>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="form-group col-md-2">
                        <label>Status</label>
                        <div class="radio-btn-form" id="rdStatusBarangContainer2" name="rdAktif">
                           <div class="form-check form-check-inline radio-size">
                              <input type="radio" name="inlineRadioOptions2" id="rdYa2" value="1" />&nbsp; Aktif
                           </div>
                           <div class="form-check form-check-inline radio-size">
                              <input type="radio" name="inlineRadioOptions2" id="rdTidak2" value="0" />&nbsp; Tidak
                           </div>
                        </div>
                     </div>
                     <div align="right">
                        <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                        <button type="button" class="btn btn-secondary btnUpdate" id="btnUpdate"
                           data-toggle="tooltip" data-placement="bottom"
                           title="Kemaskini">
                        Simpan</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- Modal Pengesahan-->
         <div class="modal fade" id="saveConfirmationModal1" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
            <div class="modal-dialog " role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="saveConfirmationModalLabel1">Pengesahan</h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                     <p id="confirmationMessage1"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                     <button type="button" class="btn btn-secondary" id="confirmSaveButton1">Ya</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- Modal Pengesahan Update-->
         <div class="modal fade" id="updateConfirmationModal1" tabindex="-1" role="dialog" aria-labelledby="updateConfirmationModalLabel">
            <div class="modal-dialog " role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="updateConfirmationModalLabel1">Pengesahan</h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                     <p id="updateConfirmationMessage1"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                     <button type="button" class="btn btn-secondary" id="confirmUpdateButton1">Ya</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- Modal Result -->
         <div class="modal fade" id="resultModal1" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="resultModalLabel1">Makluman</h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                     <p id="resultModalMessage1"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- Modal Result Update -->
         <div class="modal fade" id="updateResultModal1" tabindex="-1" role="dialog" aria-labelledby="updateResultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="updateResultModalLabel1">Makluman</h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                     <p id="updateResultModalMessage1"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                  </div>
               </div>
            </div>
         </div>
         <div class="modal-body">
            <div class="table-title">
               <h6>Senarai Barang</h6>
               <div class="btn btn-primary btnPapar" onclick="ShowPopup('1')">
                  <i class="fa fa-plus"></i>Tambah Barang  
               </div>
            </div>
            <div class="modal-body">
               <div class="col-md-13">
                  <div class="transaction-table table-responsive">
                     <span style="display: inline-block; height: 100%;"></span>
                     <table id="tblBarang" class="table table-striped">
                        <thead>
                           <tr style="width: 100%">
                              <th scope="col" style="width: 5%">Bil</th>
                              <th scope="col" style="width: 25%">Kod Barang</th>
                              <th scope="col" style="width: 25%">Butiran</th>
                              <th scope="col" style="width: 25%">Ukuran</th>
                              <th scope="col" style="width: 25%">Status</th>
                           </tr>
                        </thead>
                        <tbody id="" onclick="ShowPopup('2')">
                           <tr style="width: 100%" class="table-list">
                              <td style="width: 10%"></td>
                              <td style="width: 15%"></td>
                              <td style="width: 30%"></td>
                              <td style="width: 25%"></td>
                              <td style="width: 15%"></td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
            <hr>
         </div>
      </div>
      <br />
      <!------------------------------------------------------------------  CODE END    -------------------------------------------------------------------------->
      <!------------------------------------------------------------------- SCRIPT START ------------------------------------------------------------------------->
      <script type="text/javascript">
          // ---------------------- UNTUK POPUP START -----------------------
          var isClicked = false;
          function ShowPopup(elm) {

              if (elm == "1") {
                  $('#permohonan').modal('toggle');
              }
              else if (elm == "2") {

                  $(".modal-body div").val("");
                  $('#permohonan2').modal('toggle');

                  $('#txtTarikhStart').val("");
                  $('#txtTarikhEnd').val("");
                  $('#divDatePicker').removeClass("d-flex").addClass("d-none");

                  $('#categoryFilter').val("");

                  $('.btnSearch').click();

                  $('.btnEmel').show();
                  $('.btnCetak').show();
              }
          }
          // ---------------------- UNTUK POPUP END -------------------------
          // ---------------------- UNTUK TABLE START -----------------------
          var tbl11 = null;
          var isClicked6 = false;

          $(document).ready(function () {
              tbl11 = $("#tblBarang").DataTable({
                  "responsive": true,
                  "searching": true,
                  "info": false,
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
                      url: 'PengesahanPenjamin.asmx/LoadPengesahanPenjaminData',
                      //"url": "Invois.asmx/LoadMesyPH",
                      "method": 'POST',
                      "contentType": "application/json; charset=utf-8",
                      "dataType": "json",
                      "dataSrc": function (json) {
                          return JSON.parse(json.d);
                      },
                      "data": function () {

                          var startDate = $('#txtTarikhStart').val()
                          var endDate = $('#txtTarikhEnd').val()

                          return JSON.stringify({
                              category_filter: $('#categoryFilter').val(),
                              isClicked6: isClicked6,
                              tkhMula: startDate,
                              tkhTamat: endDate
                          })
                      }
                  },
                  "rowCallback": function (row, data) {
                      // Add hover effect
                      $(row).hover(function () {
                          $(this).addClass("hover pe-auto bg-warning");
                      }, function () {
                          $(this).removeClass("hover pe-auto bg-warning");
                      });
                      // Add click event ---> untuk baca/get data dari db
                      $(row).on("click", function () {
                          console.log(data);
                          var rowData = data;

                          no_mohon = rowData.No_Mohon;
                          // Update the modal content with the No_Mohon and Tujuan values
                          $("#kodBarang2").val(rowData.Kod_Brg);
                          $("#butiranBarang2").val(rowData.Butiran);

                          // Set selected value for dropdowns
                          $('#ukuranBarang2')
                              .dropdown('setup menu', {
                                  values: [
                                      {
                                          value: rowData.Kod_Ukuran,
                                          text: rowData.keteranganUkuran,
                                      }
                                  ]
                              })
                              .dropdown('set selected', rowData.Kod_Ukuran)

                          // Set selected value for dropdowns
                          $('#kategoriBarang2')
                              .dropdown('setup menu', {
                                  values: [
                                      {
                                          value: rowData.Kod_Kategori,
                                          text: rowData.keteranganKategori,
                                      }
                                  ]
                              })
                              .dropdown('set selected', rowData.Kod_Kategori)


                          console.log(rowData);
                          // Set radio button based on 'Status' column
                          if (rowData.Status === '1') {
                              $('#rdYa2').prop('checked', true);
                              $('#rdTidak2').prop('checked', false);
                          } else if (rowData.Status === '0') {
                              $('#rdYa2').prop('checked', false);
                              $('#rdTidak2').prop('checked', true);
                          }
                      });
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
                          "data": "Kod_Brg",
                          "width": "10%"
                      },
                      {
                          "data": "Butiran",
                          "width": "20%"
                      },
                      {
                          "data": "Kod_Kategori",
                          "width": "20%"
                      },
                      {
                          "data": "Status",
                          "render": function (data) {
                              if (data == 1) {
                                  return 'Aktif';
                              } else if (data == 0) {
                                  return 'Tak Aktif';
                              } else {
                                  return 'Data Error';
                              }
                          },
                          "width": "10%"
                      }
                  ]
              });

              $('.btnSearch').click(async function () {
                  show_loader();
                  isClicked6 = true;
                  tbl11.ajax.reload();
              })

          });

          /* Penjelasan keseluruhan skrip:
          Skrip ini menginisialisasi dan mengkonfigurasi objek DataTable pada halaman web.
          DataTable digunakan untuk menampilkan data dalam bentuk tabel dengan fungsionalitas tambahan.
          Terdapat pengaturan tombol navigasi, tata bahasa, dan responsifitas pada tampilan.
          Data tabel diambil dari web service menggunakan teknologi Ajax dengan metode POST.
          Terdapat callback untuk setiap baris tabel, termasuk efek hover dan event click untuk membaca data dari database.
          Selain itu, skrip juga menangani perubahan nilai pada dropdown dan menyesuaikan tampilan sesuai dengan nilai terpilih. */
          // ---------------------- UNTUK TABLE END -------------------------
          // ---------------------- UNTUK DROPDOWN START --------------------
          var shouldPop = true;
          $(document).ready(function () {
              generateDropdown("ukuranBarang", "Barang_WS.asmx/GetBarangUkuran", "Ukuran", false, null);
              generateDropdown("ukuranBarang2", "Barang_WS.asmx/GetBarangUkuran", "Ukuran", false, null);
              generateDropdown("kategoriBarang", "Barang_WS.asmx/GetBarangKategori", "Kategori", false, null);
              generateDropdown("kategoriBarang2", "Barang_WS.asmx/GetBarangKategori", "Kategori", false, null);
              /generateDropdown("id", "path", "place holder", "flag send data to web services or either", "parent dropdown (dependable)","function after ajax success");/
          });
          /*
          Fungsi generateDropdown digunakan untuk menghasilkan dropdown dengan parameter berikut:
          1. ID: ID elemen dropdown.
          2. URL Web Service: URL untuk mendapatkan data dropdown dari web service.
          3. Placeholder: Teks tempat holder untuk dropdown.
          4. Flag: Menentukan sama ada data akan dihantar ke web service atau tidak.
          5. Dropdown Induk: ID dropdown yang menjadi induk (bergantung) jika ada.
          6. Fungsi selepas kejayaan AJAX: Fungsi yang akan dijalankan selepas kejayaan permintaan AJAX.
          */
          // ---------------------- UNTUK DROPDOWN END ----------------------
          // ---------------------- UNTUK DROPDOWN UKURAN START --------------------
          async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {

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

                          /dependable ddl if sendata value == empty clear all option/
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
          /*
          Fungsi generateDropdown adalah fungsi asinkron yang digunakan untuk membuat dropdown dengan menggunakan jQuery dan AJAX.
          Fungsi ini menerima beberapa parameter untuk mengonfigurasi dropdown.
          
          1. id: ID elemen dropdown yang akan dihasilkan.
          2. url: URL Web Service untuk mendapatkan data dropdown.
          3. plchldr: Teks placeholder untuk dropdown.
          4. send2ws: Flag untuk menentukan sama ada data akan dihantar ke web service atau tidak.
          5. sendData: ID elemen dropdown induk (bergantung) jika ada.
          6. fn: Fungsi yang akan dijalankan selepas kejayaan permintaan AJAX.
          
          Penjelasan setiap bahagian dalam fungsi generateDropdown:
          
          a. Parameter "param": Menentukan sama ada parameter "q" akan ditambahkan kepada URL Web Service atau tidak berdasarkan kehadiran nilai "sendData".
          
          b. Konfigurasi dropdown menggunakan jQuery Dropdown:
          - "fullTextSearch": Aktifkan pencarian teks penuh.
          - "placeholder": Tetapkan teks placeholder untuk dropdown.
          - "apiSettings": Konfigurasi untuk pengaturcaraan AJAX.
          - "url": URL Web Service yang akan digunakan untuk mendapatkan data dropdown.
          - "method": Jenis kaedah HTTP yang akan digunakan (POST dalam kes ini).
          - "dataType": Jenis data yang dijangkakan (JSON dalam kes ini).
          - "contentType": Jenis kandungan yang dihantar ke server (application/json; charset=utf-8).
          - "cache": Flag untuk menonaktifkan penyimpanan cache pada permintaan AJAX.
          
          c. Fungsi "beforeSend": Dilaksanakan sebelum permintaan AJAX dihantar.
          - Jika "send2ws" benar, kemasukan data akan disusun berdasarkan URL dan nilai dropdown induk.
          - Jika tidak, gantikan {query} dalam data dengan frasa carian pengguna.
          
          d. Fungsi "onSuccess": Dilaksanakan selepas kejayaan permintaan AJAX.
          - Membersihkan pilihan dropdown sedia ada.
          - Menambah pilihan baru ke dalam dropdown berdasarkan data yang diterima.
          - Memanggil fungsi "fn" jika diberikan.
          - Menetapkan dropdown sebagai "disableDdlIcon" jika nilai dropdown induk kosong.
          - Menyegarkan dropdown.
          - Memaparkan dropdown jika "shouldPop" adalah benar.
          */
          // ---------------------- UNTUK DROPDOWN UKURAN END ----------------------
          // ---------------------- UNTUK DROPDOWN KATEGORI START -----------
          async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {

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

                          /dependable ddl if sendata value == empty clear all option/
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
          /*
          Fungsi generateDropdown adalah fungsi asinkron yang digunakan untuk membuat dropdown dengan menggunakan jQuery dan AJAX.
          Fungsi ini menerima beberapa parameter untuk mengonfigurasi dropdown.
          
          1. id: ID elemen dropdown yang akan dihasilkan.
          2. url: URL Web Service untuk mendapatkan data dropdown.
          3. plchldr: Teks placeholder untuk dropdown.
          4. send2ws: Flag untuk menentukan sama ada data akan dihantar ke web service atau tidak.
          5. sendData: ID elemen dropdown induk (bergantung) jika ada.
          6. fn: Fungsi yang akan dijalankan selepas kejayaan permintaan AJAX.
          
          Penjelasan setiap bahagian dalam fungsi generateDropdown:
          
          a. Parameter "param": Menentukan sama ada parameter "q" akan ditambahkan kepada URL Web Service atau tidak berdasarkan kehadiran nilai "sendData".
          
          b. Konfigurasi dropdown menggunakan jQuery Dropdown:
          - "fullTextSearch": Aktifkan pencarian teks penuh.
          - "placeholder": Tetapkan teks placeholder untuk dropdown.
          - "apiSettings": Konfigurasi untuk pengaturcaraan AJAX.
          - "url": URL Web Service yang akan digunakan untuk mendapatkan data dropdown.
          - "method": Jenis kaedah HTTP yang akan digunakan (POST dalam kes ini).
          - "dataType": Jenis data yang dijangkakan (JSON dalam kes ini).
          - "contentType": Jenis kandungan yang dihantar ke server (application/json; charset=utf-8).
          - "cache": Flag untuk menonaktifkan penyimpanan cache pada permintaan AJAX.
          - "beforeSend": Fungsi yang dijalankan sebelum permintaan AJAX dihantar.
          - Jika "send2ws" benar, kemasukan data akan disusun berdasarkan URL dan nilai dropdown induk.
          - Jika tidak, gantikan {query} dalam data dengan frasa carian pengguna.
          - "onSuccess": Fungsi yang dijalankan selepas kejayaan permintaan AJAX.
          - Membersihkan pilihan dropdown sedia ada.
          - Menambah pilihan baru ke dalam dropdown berdasarkan data yang diterima.
          - Memanggil fungsi "fn" jika diberikan.
          - Menetapkan dropdown sebagai "disableDdlIcon" jika nilai dropdown induk kosong.
          - Menyegarkan dropdown.
          - Memaparkan dropdown jika "shouldPop" adalah benar.
          */
          // ---------------------- UNTUK DROPDOWN KATEGORI END -------------
          // ---------------------- UNTUK SIMPAN DATA BARANG START ----------
          $('.btnSimpan').off('click').on('click', async function () {
              var msg = "";

              var msg = "Anda pasti ingin menyimpan rekod ini? ";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function () {
                  $('#saveConfirmationModal1').modal('hide'); // Hide the modal

                  // Include selected values in the object
                  var newBarang = {
                      mohonBarang: {
                          kodBarang: $('#kodBarang').val(),
                          ukuranBarang: $('#ukuranBarang').val(),
                          butiranBarang: $('#butiranBarang').val(),
                          kategoriBarang: $('#kategoriBarang').val(),
                          statusBarang: $("input[name='inlineRadioOptions']:checked").val(),
                      }
                  }

                  var result = JSON.parse(await ajaxSaveBarang(newBarang));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
                  tbl11.ajax.reload();
                  // Save No_Mohon which will be used later on other tabs
                  //sessionStorage.setItem("nombor_mohon", result.Payload.txtNoMohon);
              });
          });

          async function ajaxSaveBarang(mohonBarang) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'Barang_WS.asmx/Save_Barang',
                      method: 'POST',
                      data: JSON.stringify(mohonBarang),
                      dataType: 'json',
                      contentType: 'application/json; charset=utf-8',
                      success: function (data) {
                          resolve(data.d);
                      },
                      error: function (xhr, textStatus, errorThrown) {
                          console.error('Error:', errorThrown);
                          reject(false);
                      }
                  });
              });
          }

          function showModal1(title, message, type) {
              $('#resultModalTitle1').text(title);
              $('#resultModalMessage1').text(message);
              if (type === "success") {
                  $('#resultModal1').removeClass("modal-error").addClass("modal-success");
              } else if (type === "error") {
                  $('#resultModal1').removeClass("modal-success").addClass("modal-error");
              }
              $('#resultModal1').modal('show');
          }
          /*
          Skrip ini merangkumi tiga fungsi JavaScript yang berkaitan dengan pengurusan penyimpanan data dan pengurusan mesej dalam suatu aplikasi.
          
          1. Fungsi untuk Menyimpan Data:
          - Menggunakan class selector untuk elemen dengan kelas 'btnSimpan'.
          - Memaparkan mesej pengesahan untuk penyimpanan rekod.
          - Membuka modal pengesahan dan menetapkan fungsi untuk butang pengesahan.
          - Selepas butang pengesahan ditekan, menyembunyikan modal, membentuk objek data baru, dan menjalankan AJAX untuk menyimpan data.
          - Mengendalikan keputusan AJAX dan memaparkan mesej berdasarkan kejayaan atau kegagalan penyimpanan.
          - Mengemaskini kembali jadual data dengan memanggil ajax.reload() pada elemen jadual.
          
          2. Fungsi AJAX untuk Menyimpan Data:
          - Menerima objek "mohonBarang" sebagai parameter.
          - Menggunakan AJAX untuk menghantar data ke URL 'Barang_WS.asmx/Save_Barang'.
          - Menggunakan promise untuk menangani kejayaan atau kegagalan AJAX.
          - Jika berjaya, memecahkan data JSON dan mengembalikan hasil.
          - Jika gagal, mencetak kesalahan ke konsol dan menolak promise.
          
          3. Fungsi untuk Memaparkan Modal Mesej:
          - Menerima tajuk, mesej, dan jenis mesej sebagai parameter.
          - Menetapkan elemen modal dengan mesej dan jenis mesej yang sesuai.
          - Membuka modal mesej.
          
          */
          // ---------------------- UNTUK SIMPAN DATA BARANG END ------------
          // ---------------------- UNTUK UPDATE DATA BARANG START ----------
          $('.btnUpdate').off('click').on('click', async function () {
              var msg = "";

              var msg = "Anda pasti ingin menyimpan rekod ini? ";
              $('#updateConfirmationMessage1').text(msg);
              $('#updateConfirmationModal1').modal('show');

              $('#confirmUpdateButton1').off('click').on('click', async function () {
                  $('#updateConfirmationModal1').modal('hide'); // Hide the modal

                  // Include selected values in the object
                  var newBarang = {
                      mohonBarang: {
                          kodBarang: $('#kodBarang2').val(),
                          ukuranBarang: $('#ukuranBarang2').val(),
                          butiranBarang: $('#butiranBarang2').val(),
                          kategoriBarang: $('#kategoriBarang2').val(),
                          statusBarang: $("input[name='inlineRadioOptions2']:checked").val(),
                      }
                  }

                  var result = JSON.parse(await ajaxUpdateBarang(newBarang));

                  if (result.Status === true) {
                      showUpdateModal1("Success", result.Message, "success");
                  }
                  else {
                      showUpdateModal1("Error", result.Message, "error");
                  }
                  tbl11.ajax.reload();
                  // Save No_Mohon which will be used later on other tabs
                  //sessionStorage.setItem("nombor_mohon", result.Payload.txtNoMohon);
              });
          });

          async function ajaxUpdateBarang(mohonBarang) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'Barang_WS.asmx/Update_Barang',
                      method: 'POST',
                      data: JSON.stringify(mohonBarang),
                      dataType: 'json',
                      contentType: 'application/json; charset=utf-8',
                      success: function (data) {
                          resolve(data.d);
                      },
                      error: function (xhr, textStatus, errorThrown) {
                          console.error('Error:', errorThrown);
                          reject(false);
                      }
                  });
              });
          }

          function showUpdateModal1(title, message, type) {
              $('#updateResultUpdateModalTitle1').text(title);
              $('#updateResultModalMessage1').text(message);
              if (type === "success") {
                  $('#updateResultModal1').removeClass("modal-error").addClass("modal-success");
              } else if (type === "error") {
                  $('#updateResultModal1').removeClass("modal-success").addClass("modal-error");
              }
              $('#updateResultModal1').modal('show');
          }
          /*
          Skrip ini merangkumi fungsi JavaScript untuk menguruskan pengemaskinan data dan memaparkan modal mesej dalam suatu aplikasi.
         
          1. Fungsi untuk Mengemaskini Data:
          - Menggunakan class selector untuk elemen dengan kelas 'btnUpdate'.
          - Memaparkan mesej pengesahan untuk pengemaskinan rekod.
          - Membuka modal pengesahan dan menetapkan fungsi untuk butang pengesahan.
          - Selepas butang pengesahan ditekan, menyembunyikan modal, membentuk objek data baru, dan menjalankan AJAX untuk mengemaskini data.
          - Mengendalikan keputusan AJAX dan memaparkan mesej berdasarkan kejayaan atau kegagalan pengemaskinan.
          - Mengemaskini kembali jadual data dengan memanggil ajax.reload() pada elemen jadual.
         
          2. Fungsi AJAX untuk Mengemaskini Data:
          - Menerima objek "mohonBarang" sebagai parameter.
          - Menggunakan AJAX untuk menghantar data ke URL 'Barang_WS.asmx/Update_Barang'.
          - Menggunakan promise untuk menangani kejayaan atau kegagalan AJAX.
          - Jika berjaya, memecahkan data JSON dan mengembalikan hasil.
          - Jika gagal, mencetak kesalahan ke konsol dan menolak promise.
         
          3. Fungsi untuk Memaparkan Modal Mesej Pengemaskinan:
          - Menerima tajuk, mesej, dan jenis mesej sebagai parameter.
          - Menetapkan elemen modal dengan mesej dan jenis mesej yang sesuai.
          - Membuka modal mesej.
         
          */
          // ---------------------- UNTUK UPDATE DATA BARANG END ------------
      </script>
   </contenttemplate>
</asp:Content>