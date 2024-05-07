<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Ulasan_KJ.aspx.vb" Inherits="SMKB_Web_Portal.Ulasan_KJ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
   <script type="text/javascript">
       function ShowPopup(elm) {

           if (elm == "1") {
               clearFormFields();
               $('#permohonan').modal('toggle');

           }
           else if (elm == "2") {
               clearFormFields();
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
   </script>
   <style>
      .txtEror {
      display: none; /* Initially hide the error messages */
      }
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
      input[readonly] {
      background-color: #e5e5e5; /* Adjust the color as needed */
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
      .input-group__select:disabled {
      font-weight: bold;
      background-color: #CCCCCC; /* kode warna untuk abu-abu */
      color: #333333; /* warna teks */
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
      max-width: 1200px; /* Set the maximum width for the modal content */
      margin: auto; /* Center the modal horizontally */
      }
      .form-group {
      /* Optionally, adjust the width of the form elements if needed */
      max-width: 100%; /* Set the maximum width for the form elements */
      }
      .incolor {
      background-color: #e9ecef;
      color: #ffffff;
      }
   </style>
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
   <contenttemplate>
      <!------------------------------------------------------------------- CODE START --------------------------------------------------------------------------->
      <div id="PermohonanTab" class="tabcontent" style="display: block">
         <div class="modal-body">
            <div class="table-title">
               <h6>Senarai Ulasan KJ</h6>
               <div id="btnTambah" class="btn btn-primary" onclick="ShowPopup('2')">
                  <i class="fa fa-plus"></i>Tambah Ulasan 
               </div>
            </div>
            <div class="modal-body">
               <div class="col-md-13">
                  <div class="transaction-table table-responsive">
                     <span style="display: inline-block; height: 100%;"></span>
                     <table id="tblPenjamin" class="table table-striped">
                        <thead>
                           <tr>
                              <th scope="col">Bil</th>
                              <th scope="col">Ulasan</th>
                              <th scope="col">Kategori Pinjaman</th>
                              <th scope="col">Status</th>
                           </tr>
                        </thead>
                        <tbody id="" onclick="ShowPopup('1')">
                           <tr style="width: 100%" class="table-list">
                              <td style="width: 5%"></td>
                              <td style="width: 70%"></td>
                              <td style="width: 15%"></td>
                              <td style="width: 10%"></td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 START ~~~-->
         <div class="modal fade bd-example-modal-xl" id="permohonan" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl"  role="document">
               <div class="modal-content modal-xl">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title"">Maklumat Ulasan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-12 col-12">
                                    <div class="form-group input-group incolor">
                                       <select class="input-group__select ui search dropdown disabled" placeholder="" name="ulasanPinjaman" id="ulasanPinjaman">
                                       </select>
                                       <label class="input-group__label" for="ulasanPinjaman">Ulasan <span style="color: red">*</span></label>
                                    </div>
                                 </div>
                                 <div class="form-group col-md-12 col-12">
                                    <div class="form-group input-group incolor">
                                       <select class="input-group__select ui search dropdown" placeholder="" name="kategoriPinjaman" id="kategoriPinjaman" disabled>
                                       </select>
                                       <label class="input-group__label" for="kategoriPinjaman">Kategori Pinjaman<span style="color: red">*</span></label>
                                    </div>
                                 </div>
                                 <label>Status <span style="color: red">*</span></label>
                                 <div class="col-md-12 col-12">
                                    <div class="form-check form-check-inline">
                                       <input class="form-check-input" type="radio" name="statusRadio" id="statusRadioYa1" value="1" checked>
                                       <label class="form-check-label" for="inlineRadio1">Aktif</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                       <input class="form-check-input" type="radio" name="statusRadio" id="statusRadioTidak1" value="0">
                                       <label class="form-check-label" for="inlineRadio2">Tidak Aktif</label>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                        <button type="button" id="btnSimpan1" class="btn btn-secondary btnSimpan1" data-dismiss="modal">Simpan</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 END   ~~~ -->
         <!-- ~~~ Modal 2 START ~~~-->
         <div class="modal fade bd-example-modal-xl" id="permohonan2" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl"  role="document">
               <div class="modal-content modal-xl">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title"">Tambah Ulasan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <div class="row">
                           <div class="col-md-12">
                                  <div class="form-row">
                                     <div class="form-group col-md-12 col-12">
                                        <div class="form-group input-group">
                                           <select class="input-group__select ui search dropdown" placeholder="" name="ulasanPinjaman" id="ulasanPinjaman2">
                                           </select>
                                           <label class="input-group__label" for="ulasanPinjaman">Ulasan <span style="color: red">*</span></label>
                                           <small class="txtEror text-danger font-italic form-row col-md-12 col-12" style="display: none;">Sila buat pilihan</small>
                                        </div>
                                        <div class="form-group input-group">
                                           <select class="input-group__select ui search dropdown" placeholder="" name="kategoriPinjaman" id="kategoriPinjaman2">
                                           </select>
                                           <label class="input-group__label" for="kategoriPinjaman">Kategori Pinjaman<span style="color: red">*</span></label>
                                           <small class="txtEror text-danger font-italic form-row col-md-12 col-12" style="display: none;">Sila buat pilihan</small>
                                        </div>
                                        <div class="col-md-12 col-12"></div>
                                        <label>Status <span style="color:red">*</span></label>
                                        <div class="col-md-12 col-12">
                                           <div class="form-check form-check-inline">
                                              <input class="form-check-input" type="radio" name="statusRadio" id="statusRadioYa2" value="1" checked>
                                              <label class="form-check-label" for="inlineRadio1">Aktif</label>
                                           </div>
                                           <div class="form-check form-check-inline">
                                              <input class="form-check-input" type="radio" name="statusRadio" id="statusRadioTidak2" value="0">
                                              <label class="form-check-label" for="inlineRadio2">Tidak Aktif</label>
                                           </div>
                                        </div>
                                     </div>
                                  </div>
                           </div>
                        </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                        <button type="button" id="btnSimpan2" class="btn btn-secondary btnSimpan2">Simpan</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 2 END   ~~~ -->
         <!-- ~~~ Modal 1 PENGESAHAN EDIT START   ~~~ -->
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
                     <button type="button" class="btn btn-secondary" id="confirmSaveButton1" value="1">Ya</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 PENGESAHAN EDIT END    ~~~ -->
         <!-- ~~~ Modal 1 PENGESAHAN TIDAK START   ~~~ -->
         <div class="modal fade" id="saveConfirmationModal2" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
            <div class="modal-dialog " role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="saveConfirmationModalLabel2">Pengesahan</h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                     <p id="confirmationMessage2"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                     <button type="button" class="btn btn-secondary" id="confirmSaveButton2" value="0">Ya</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 PENGESAHAN TIDAK END     ~~~ -->
         <!-- ~~~ Modal SELESAI START      ~~~ -->
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
         <!-- ~~~ Modal  CONFIRM END        ~~~ -->
      </div>
      <!------------------------------------------------------------------- CODE START --------------------------------------------------------------------------->
      <!------------------------------------------------------------------- SCRIPT START ------------------------------------------------------------------------->
      <script>
          // ---------------------- UNTUK TABLE START -----------------------
          var tbl11 = null;
          var isClicked6 = false;
          var shouldPop = true;

          $(document).ready(function () {
              show_loader();
              tbl11 = $("#tblPenjamin").DataTable({

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
                      url: 'UlasanKJWS.asmx/LoadPengesahanUlasanData',
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
                          sessionStorage.setItem('Rujukan', rowData.Rujukan)
                          $('#ulasanPinjaman')
                              .dropdown('setup menu', {
                                  values: [
                                      {
                                          value: rowData.IDUlasan,
                                          text: rowData.ButiranUlasan,
                                      }
                                  ]
                              })
                              .dropdown('set selected', rowData.ButiranUlasan)
                          $('#kategoriPinjaman')
                              .dropdown('setup menu', {
                                  values: [
                                      {
                                          value: rowData.KategoriPinjaman,
                                          text: rowData.ButiranKenderaan,
                                      }
                                  ]
                              })
                              .dropdown('set selected', rowData.ButiranKenderaan)

                          console.log(rowData);
                          // Set radio button based on 'Status' column
                          if (rowData.Status === '1') {
                              $('#statusRadioYa1').prop('checked', true);
                              $('#statusRadioTidak2').prop('checked', false);
                          } else if (rowData.Status === '0') {
                              $('#statusRadioYa2').prop('checked', false);
                              $('#statusRadioTidak1').prop('checked', true);
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
                          "data": "ButiranUlasan",
                          "width": "65%"
                      },
                      {
                          "data": "ButiranKenderaan",
                          "width": "15%"
                      },
                      {
                          "data": "Status",
                          "width": "10%",
                          render: function (data, type, row, meta) {
                              return data === '1' ? 'Aktif' : 'Tidak Aktif';
                          }
                      }
                  ]
              });

              $('.btnSearch').click(async function () {
                  isClicked6 = true;

                  tbl11.ajax.reload();
              })

              close_loader();
          });
          // ---------------------- UNTUK TABLE END -------------------------
          // ---------------------- UNTUK DROPDOWN START --------------------
          $('#ulasanPinjaman').dropdown({
              selectOnKeydown: true,
              fullTextSearch: true,
              apiSettings: {
                  url: 'UlasanKJWS.asmx/ulasanPinjaman?q={query}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
                      settings.data = JSON.stringify({ q: settings.urlData.query });
                      return settings;
                  },
                  onSuccess: function (response) {
                      console.log('Response from web service:', response);

                      // Clear existing dropdown options
                      var $dropdown = $(this);
                      var $menu = $dropdown.find('.menu');
                      $menu.html('');

                      // Add new options to dropdown
                      var listOptions = JSON.parse(response.d);

                      if (listOptions.length === 0) {
                          $dropdown.dropdown('clear');
                          return false;
                      }

                      $.each(listOptions, function (index, option) {
                          $menu.append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                      });

                      // Refresh dropdown
                      $dropdown.dropdown('refresh');

                      if (shouldPop) {
                          $dropdown.dropdown('show');
                      }
                  }
              }
          });
          // ---------------------- UNTUK DROPDOWN END -------------------------
          // ---------------------- UNTUK DROPDOWN 2 START ---------------------
          $('#kategoriPinjaman').dropdown({
              selectOnKeydown: true,
              fullTextSearch: true,
              apiSettings: {
                  url: 'UlasanKJWS.asmx/kategoriPinjaman?q={query}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
                      settings.data = JSON.stringify({ q: settings.urlData.query });
                      return settings;
                  },
                  onSuccess: function (response) {
                      console.log('Response from web service:', response);

                      // Clear existing dropdown options
                      var $dropdown = $(this);
                      var $menu = $dropdown.find('.menu');
                      $menu.html('');

                      // Add new options to dropdown
                      var listOptions = JSON.parse(response.d);

                      if (listOptions.length === 0) {
                          $dropdown.dropdown('clear');
                          return false;
                      }

                      $.each(listOptions, function (index, option) {
                          $menu.append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                      });

                      // Refresh dropdown
                      $dropdown.dropdown('refresh');

                      if (shouldPop) {
                          $dropdown.dropdown('show');
                      }
                  }
              }
          });
          // ---------------------- UNTUK DROPDOWN 2 END -----------------------
          // ---------------------- UNTUK DROPDOWN 3 START --------------------
          $('#ulasanPinjaman2').dropdown({
              selectOnKeydown: true,
              fullTextSearch: true,
              apiSettings: {
                  url: 'UlasanKJWS.asmx/ulasanPinjaman?q={query}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
                      settings.data = JSON.stringify({ q: settings.urlData.query });
                      return settings;
                  },
                  onSuccess: function (response) {
                      console.log('Response from web service:', response);

                      // Clear existing dropdown options
                      var $dropdown = $(this);
                      var $menu = $dropdown.find('.menu');
                      $menu.html('');

                      // Add new options to dropdown
                      var listOptions = JSON.parse(response.d);

                      if (listOptions.length === 0) {
                          $dropdown.dropdown('clear');
                          return false;
                      }

                      $.each(listOptions, function (index, option) {
                          $menu.append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                      });

                      // Refresh dropdown
                      $dropdown.dropdown('refresh');

                      if (shouldPop) {
                          $dropdown.dropdown('show');
                      }
                  }
              }
          });
          // ---------------------- UNTUK DROPDOWN 3 END -------------------------
          // ---------------------- UNTUK DROPDOWN 4 START ---------------------
          $('#kategoriPinjaman2').dropdown({
              selectOnKeydown: true,
              fullTextSearch: true,
              apiSettings: {
                  url: 'UlasanKJWS.asmx/kategoriPinjaman?q={query}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
                      settings.data = JSON.stringify({ q: settings.urlData.query });
                      return settings;
                  },
                  onSuccess: function (response) {
                      console.log('Response from web service:', response);

                      // Clear existing dropdown options
                      var $dropdown = $(this);
                      var $menu = $dropdown.find('.menu');
                      $menu.html('');

                      // Add new options to dropdown
                      var listOptions = JSON.parse(response.d);

                      if (listOptions.length === 0) {
                          $dropdown.dropdown('clear');
                          return false;
                      }

                      $.each(listOptions, function (index, option) {
                          $menu.append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                      });

                      // Refresh dropdown
                      $dropdown.dropdown('refresh');

                      if (shouldPop) {
                          $dropdown.dropdown('show');
                      }
                  }
              }
          });
          // ---------------------- UNTUK DROPDOWN 4 END -----------------------
          // ---------------------- UNTUK EDIT START ---------------------------
          $('.btnSimpan1').off('click').on('click', async function () {
              var msg = "";

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function () {
                  $('#saveConfirmationModal1').modal('hide');

                  var statusValue = $("input[name='statusRadio']:checked").val();
                  var newPengesahan = {
                      mohonPengesahan: {
                          ulasanPengesahan: $('#ulasanPinjaman').val(),
                          kategoripinjPengesahan: $('#kategoriPinjaman').val(),
                          statusPengesahan: statusValue,
                          rujukanPengesahan: sessionStorage.getItem('Rujukan'),
                      }
                  }

                  var result = JSON.parse(await ajaxSavePengesahan2(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      show_loader();
                      tbl11.ajax.reload();
                      close_loader();
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });

          async function ajaxSavePengesahan2(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'UlasanKJWS.asmx/Save_Pengesahan1',
                      method: 'POST',
                      data: JSON.stringify(mohonPengesahan),
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
          // ---------------------- UNTUK EDIT END ------------------------------
          // ---------------------- UNTUK ADD START ---------------------------
          $('.btnSimpan2').off('click').on('click', async function () {

              var ulasanPinjaman = $('#ulasanPinjaman2').val();
              var kategoriPinjaman = $('#kategoriPinjaman2').val();
              var statusValue = $("input[name='statusRadio']:checked").val();

              if (!ulasanPinjaman || !kategoriPinjaman || !statusValue) {
                  console.log("Fields are empty. Calling clearAndEnableEdit()...");
                  clearAndEnableEdit();
                  $('.txtEror').show();
                  return;
              } else {
                  $('.txtEror').hide();
              }

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');



              $('#confirmSaveButton1').off('click').on('click', async function () {
                  debugger
                  $('#saveConfirmationModal1').modal('hide');
                  $('#permohonan2').modal('hide');
                  var newPengesahan = {
                      mohonPengesahan: {
                          ulasanPengesahan: ulasanPinjaman,
                          kategoripinjPengesahan: kategoriPinjaman,
                          statusPengesahan: statusValue,
                      }
                  }


                  var result = JSON.parse(await ajaxSavePengesahahahahahaha(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      show_loader();
                      tbl11.ajax.reload();
                      close_loader(); // Refresh the page
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });


          async function ajaxSavePengesahahahahahaha(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'UlasanKJWS.asmx/Save_Pengesahan2',
                      method: 'POST',
                      data: JSON.stringify(mohonPengesahan),
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
          // ---------------------- UNTUK ADD END ------------------------------ 
          function clearAndEnableEdit() {
              debugger
              // Remove hiding of .txtEror elements
              $(".txtEror").removeClass("codx");
              $('#ulasanPinjaman .input-group__select select').each(function () {
                  const element = $(this).closest('.form-group').find('.txtEror');
                  var tempSlctr = $(this).val();
                  if (isSet(tempSlctr)) {
                      $(this).dropdown("clear");
                  }
                  $(this).parent().removeClass("border border-danger");
                  // Hide the error message initially
                  element.hide();
              });

              // Enable Field
              $('#ulasanPinjaman .input-group__select select').each(function () {
                  $(this).parent().removeClass('disabled');
                  $(this).parent().parent().removeClass('incolor')
              });
          }

          function clearFormFields() {
              // Clear the selected option for each dropdown
              $('#ulasanPinjaman2').dropdown('clear');
              $('#kategoriPinjaman2').dropdown('clear');

              // Reset the radio buttons to default (Aktif)
              $('#statusRadioYa2').prop('checked', true);
              $('#statusRadioTidak2').prop('checked', false);

              // Hide any error messages
              $('.txtEror').hide();
          }
      </script>
      <!------------------------------------------------------------------- SCRIPT END ------------------------------------------------------------------------->
   </contenttemplate>
</asp:Content>