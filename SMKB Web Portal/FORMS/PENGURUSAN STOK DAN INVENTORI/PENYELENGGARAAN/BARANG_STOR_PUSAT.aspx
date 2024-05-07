<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="BARANG_STOR_PUSAT.aspx.vb" Inherits="SMKB_Web_Portal.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
   <script src="https://cdn.datatables.net/scroller/2.0.5/js/dataTables.scroller.min.js"></script>

    <style>
        .disabled-dropdown {
            background-color: #cccccc; /* Light gray for disabled state */
            opacity: 0.7; /* Reduce opacity to indicate disabled state */
            cursor: not-allowed; /* Set cursor to indicate non-interactiveness */
        }
    </style>
   <!-------------------------------------------------------------------  STYLE END  -------------------------------------------------------------------------->
   <!------------------------------------------------------------------  CODE START  -------------------------------------------------------------------------->
   <contenttemplate>
      <div id="PermohonanTab" class="tabcontent" style="display: block">
         <%-- MENU --%>
         <div id="divpendaftaraninv" runat="server" visible="true">
            <div class="modal-body">
               <div class="table-title">
                  <h6>Barang Stor</h6>
               </div>
               <div class="col-md-12">
                  <div id="btnTambah" class="btn btn-primary" onclick="ShowPopup('1')" style="float: right;">
                     <i class="fa fa-plus"></i>Tambah Barang
                  </div>
                  <br />
                  <br />
                  <div class="transaction-table table-responsive" style="width: 100%;">
                     <table id="tblBarangStor" class="table table-striped" style="width: 100%;">
                        <thead>
                           <tr>
                              <th scope="col" style="width: 5%;">Bil</th>
                              <th scope="col" style="width: 20%;">Barang</th>
                              <th scope="col" style="width: 20%;">Lokasi</th>
                              <th scope="col" style="width: 20%;">Takat Minima</th>
                              <th scope="col" style="width: 20%;">Takat Maksima</th>
                              <th scope="col" style="width: 20%;">Takat Menokok</th>
                           </tr>
                        </thead>
                        <tbody id="" onclick="ShowPopup('2')" style="width: 100%;">
                           <tr class="table-list">
                              <td style="width: 5%; text-align: center;"></td>
                              <td style="width: 20%; text-align: center;"></td>
                              <td style="width: 20%; text-align: center;"></td>
                              <td style="width: 20%; text-align: center;"></td>
                              <td style="width: 20%; text-align: center;"></td>
                              <td style="width: 20%; text-align: center;"></td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ TAB ADD START ~~~-->
         <div class="modal fade bd-example-modal-md" id="permohonanAdd" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
               <div class="modal-content modal-md">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title"">Barang Stor</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <div class="form-group input-group">
                                       <select class="input-group__select ui search dropdown" placeholder="" name="kategoriStor" id="kategoriStor">
                                       </select>
                                       <label class="input-group__label" for="kategoriStor">Kategori Stor<span style="color: red">*</span></label>
                                    </div>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <div class="form-group input-group">
                                       <select class="input-group__select ui search dropdown" placeholder="" name="pejabatLokasi" id="pejabatLokasi">
                                       </select>
                                       <label class="input-group__label" for="pejabatLokasi">PTJ<span style="color: red">*</span></label>
                                       <div id="lokasiMessage" style="color: red; font-style: italic; display: none;">Sila pilih Kategori Stor terlebih dahulu</div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <div class="form-group input-group">
                                       <select class="input-group__select ui search dropdown" placeholder="" name="kategoriBarang" id="kategoriBarang">
                                       </select>
                                       <label class="input-group__label" for="kategoriBarang">Kategori Stok<span style="color: red">*</span></label>
                                    </div>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <div class="form-group input-group">
                                       <select class="input-group__select ui search dropdown" placeholder="" name="senaraiBarang" id="senaraiBarang">
                                       </select>
                                       <label class="input-group__label" for="senaraiBarang">Barang<span style="color: red">*</span></label>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="takatMinima" placeholder="&nbsp;" name="takatMinima" />
                                    <label class="input-group__label" for="takatMinima">Takat Minima</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="takatMaksima" placeholder="&nbsp;" name="takatMaksima" />
                                    <label class="input-group__label" for="takatMaksima">Takat Maksima</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="takatMenokok" placeholder="&nbsp;" name="takatMenokok" />
                                    <label class="input-group__label" for="takatMenokok">Takat Menokok</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div>
                           <span style="display: inline-block; height: 100%;"></span>
                           <table id="spekfikasi-table" class="table table-striped" style="width: 100%">
                              <thead>
                                 <tr>
                                    <th scope="col" style="width: 10%; text-align: left">Pilih</th>
                                    <th scope="col" style="width: 90%; text-align: left">Lokasi</th>
                                 </tr>
                              </thead>
                              <tbody>
                              </tbody>
                           </table>
                        </div>
                        <div align="right" class="pt-3">
                           <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                           <button type="button" class="btn btn-secondary btnSimpan2" id="btnSimpan2"
                              data-toggle="tooltip" data-placement="bottom" data-dismiss="modal"
                              title="Draft">
                           Simpan</button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ TAB ADD END   ~~~-->
         <!-- ~~~ TAB EDIT START ~~~-->
         <div class="modal fade bd-example-modal-md" id="permohonan" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
               <div class="modal-content modal-md">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title"">Barang Stor</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                     <div class="form-group input-group">
                                         <select class="input-group__select ui search dropdown disabled-dropdown"
                                             placeholder="" name="kategoriStor" id="kategoriStor2" disabled>
                                         </select>
                                         <label class="input-group__label" for="kategoriStor">Kategori Stor<span style="color: red">*</span></label>
                                     </div>

                                 </div>
                                 <div class="form-group col-md-6">
                                    <div class="form-group input-group">
                                       <select class="input-group__select ui search dropdown" placeholder="" name="pejabatLokasi" id="pejabatLokasi2" disabled>
                                       </select>
                                       <label class="input-group__label" for="pejabatLokasi">PTJ<span style="color: red">*</span></label>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <div class="form-group input-group">
                                       <select class="input-group__select ui search dropdown" placeholder="" name="kategoriBarang" id="kategoriBarang2">
                                       </select>
                                       <label class="input-group__label" for="kategoriBarang">Kategori Stok<span style="color: red">*</span></label>
                                    </div>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <div class="form-group input-group">
                                       <select class="input-group__select ui search dropdown" placeholder="" name="senaraiBarang" id="senaraiBarang2" disabled>
                                       </select>
                                       <label class="input-group__label" for="senaraiBarang">Barang<span style="color: red">*</span></label>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="takatMinima2" placeholder="&nbsp;" name="takatMinima" />
                                    <label class="input-group__label" for="takatMinima">Takat Minima</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="takatMaksima2" placeholder="&nbsp;" name="takatMaksima" />
                                    <label class="input-group__label" for="takatMaksima">Takat Maksima</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="takatMenokok2" placeholder="&nbsp;" name="takatMenokok" />
                                    <label class="input-group__label" for="takatMenokok">Takat Menokok</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div>
                           <span style="display: inline-block; height: 100%;"></span>
                           <table id="spekfikasi-table2" class="table table-striped" style="width: 100%">
                              <thead>
                                 <tr>
                                    <th scope="col" style="width: 10%; text-align: left">Pilih</th>
                                    <th scope="col" style="width: 90%; text-align: left">Lokasi</th>
                                 </tr>
                              </thead>
                              <tbody>
                              </tbody>
                           </table>
                        </div>
                        <div align="right" class="pt-3">
                           <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                           <button type="button" class="btn btn-secondary btnSimpan3" id="btnSimpan3"
                              data-toggle="tooltip" data-placement="bottom" data-dismiss="modal"
                              title="Draft">
                           Simpan</button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ TAB EDIT END   ~~~-->
         <!-- ~~~ Modal 1 PENGESAHAN YA START   ~~~ -->
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
         <!-- ~~~ Modal 1 PENGESAHAN YA END    ~~~ -->
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
         <!-- ~~~ Modal  SELESAI END      ~~~ -->
      </div>
      <br />
      <!------------------------------------------------------------------  CODE END    -------------------------------------------------------------------------->
      <!------------------------------------------------------------------- SCRIPT START ------------------------------------------------------------------------->
      <script type="text/javascript"> 
          // <==========================================SCRIPT TUKAR PAGE START========================================>
          function ShowPopup(elm) {

              if (elm == "1") {
                  $('#permohonanAdd').modal('toggle');
              } else if (elm == "2") {
                  $(".modal-body div").val("");
                  $('#permohonan').modal('toggle');
              }
          }
          // <==========================================SCRIPT TUKAR PAGE END==========================================>
          // ---------------------- UNTUK TABLE1 START -----------------------
          var tbl11 = null;
          var isClicked6 = false;
          var shouldPop = true;

          $(document).ready(function () {
              show_loader();
              tbl11 = $("#tblBarangStor").DataTable({

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
                      url: 'BarangStor_WS.asmx/LoadBarangData',
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
                      $(row).on("click", function () {

                          console.log(data);
                          var rowData = data;

                          $("#takatMinima2").val(rowData.TakatMin);
                          $("#takatMaksima2").val(rowData.TakatMax);
                          $("#takatMenokok2").val(rowData.TakatMenokok);
                          buildDdl("senaraiBarang2", rowData.KodBarang, rowData.ButiranBarang);
                          buildDdl("kategoriBarang2", rowData.KategoriStok, rowData.keteranganKategori);
                          buildDdl("pejabatLokasi2", rowData.KodPtj, rowData.TxtPtj);
                          buildDdl("kategoriStor2", rowData.KategoriStor, rowData.ButiranKategoriStor);

                          var KodLokasiDtl = rowData.KodLokasiDetail.split(', ');
                          for (var i = 0; i < KodLokasiDtl.length; i++) {
                              console.log(KodLokasiDtl[i]);
                          }
                          var value1 = rowData.KategoriStor;
                          var value2 = String(rowData.KodPtj).slice(0, -4);
                          var value3 = rowData.KodBarang;

                          checkDropdown2(value1, value2, value3);
                      }
                      );
                  },
                  "columns": [
                      {
                          "data": "Bil",
                          "render": function (data, type, row, meta) {
                              return meta.row + meta.settings._iDisplayStart + 1;
                          },
                          "width": "5%",
                          "className": "dt-center"
                      },
                      {
                          "data": "ButiranBarang",
                          "width": "10%",
                          "className": "dt-center"
                      },
                      {
                          "data": "ButiranLokasi",
                          "width": "20%",
                      },
                      {
                          "data": "TakatMin",
                          "width": "20%",
                      },
                      {
                          "data": "TakatMax",
                          "width": "20%",
                          "className": "dt-center"
                      },
                      {
                          "data": "TakatMenokok",
                          "width": "20%",
                          "className": "dt-center"
                      },
                  ]

              });

              $('.btnSearch').click(async function () {
                  isClicked6 = true;

                  tbl11.ajax.reload();
              })

              close_loader();
          });
          // ---------------------- UNTUK TABLE1 END -------------------------
          // ---------------------- UNTUK DROPDOWN START ------------------------
          var shouldPop = true;
          $(document).ready(function () {
              generateDropdown("kategoriBarang", "Barang_WS.asmx/GetBarangKategori", "Kategori Stok", false, null);
              generateDropdown("kategoriStor", "Lokasi_WS.asmx/GetKategoriStor", "Kategori Stor", false, null, function () {
                  $('#kategoriStor').dropdown('setting', 'onChange', function (value, text, $selectedItem) {
                      if ($selectedItem.index() == 0) {
                          buildDdl('pejabatLokasi', '50', 'BERPUSAT');
                          $('#pejabatLokasi').parent().addClass('disabled');
                          $('#pejabatLokasi').parent().parent().addClass('disabled-dropdown');
                      } else {
                          $('#pejabatLokasi').parent().removeClass('disabled');
                          $('#pejabatLokasi').parent().parent().removeClass('disabled-dropdown');
                      }
                      // Call checkDropdown whenever Kategori Stor changes
                      checkDropdown(value, $('#pejabatLokasi').val());
                  });
              });
              generateDropdown("pejabatLokasi", "Lokasi_WS.asmx/GetLokasiPejabat", "Pejabat", false, null, function () {
                  $('#pejabatLokasi').dropdown('setting', 'onChange', function (value, text, $selectedItem) {
                      // Call checkDropdown whenever Pejabat changes
                      checkDropdown($('#kategoriStor').dropdown('get value'), value);
                  });
              });
              generateDropdown("senaraiBarang", "BarangStor_WS.asmx/GetsenaraiBarang", "Barang", false, null);
              // <~~ modal edit ~~>
              generateDropdown("kategoriBarang2", "Barang_WS.asmx/GetBarangKategori", "Kategori Stok", false, null);
              generateDropdown("kategoriStor2", "Lokasi_WS.asmx/GetKategoriStor", "Kategori Stor", false, null, function () {
                  $('#kategoriStor2').dropdown('setting', 'onChange', function (value, text, $selectedItem) {
                      if ($selectedItem.index() == 0) {
                          buildDdl('pejabatLokasi2', '50', 'BERPUSAT');
                          $('#pejabatLokasi2').parent().addClass('disabled');
                          $('#pejabatLokasi2').parent().parent().addClass('disabled-dropdown');
                      } else {
                          $('#pejabatLokasi2').parent().removeClass('disabled');
                          $('#pejabatLokasi2').parent().parent().removeClass('disabled-dropdown');
                      }
                      // Call checkDropdown whenever Kategori Stor changes
                      checkDropdown2(value, $('#pejabatLokasi2').val());
                  });
              });
              generateDropdown("pejabatLokasi2", "Lokasi_WS.asmx/GetLokasiPejabat", "Pejabat", false, null, function () {
                  $('#pejabatLokasi2').dropdown('setting', 'onChange', function (value, text, $selectedItem) {
                      // Call checkDropdown whenever Pejabat changes
                      checkDropdown2($('#kategoriStor2').dropdown('get value'), value);
                  });
              });
              generateDropdown("senaraiBarang2", "BarangStor_WS.asmx/GetsenaraiBarang", "Barang", false, null);
              /generateDropdown("id", "path", "place holder", "flag send data to web services or either", "parent dropdown (dependable)","function after ajax success");/
          });

          async function checkDropdown(value1, value2) {
              if (value1 && value2) {
                  console.log(value1, value2)
                  fetchSecondTableData(value1, value2);
              }
              else if (!value1 && value2) {
                  $('#pejabatLokasi').dropdown('clear');
                  $('#lokasiMessage').show();
              }

          }

          async function checkDropdown2(value1, value2, value3) {
              if (value1 && value2) {
                  console.log(value1, value2)
                  fetchThirdTableData(value1, value2, value3); // Pass the values to fetchThirdTableData
              } else if (!value1 && value2) {
                  $('#pejabatLokasi2').dropdown('clear');
                  $('#lokasiMessage2').show();
              }
          }

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
          // ---------------------- UNTUK DROPDOWN  END -------------------------
          // ---------------------- UNTUK ADD START -----------------------------
          $('.btnSimpan2').off('click').on('click', async function () {
              var checkedValues = [];

              $('#spekfikasi-table tbody tr').each(function () {
                  var checkbox = $(this).find('.checkLokasi');
                  if (checkbox.prop('checked')) {
                      checkedValues.push({
                          value: checkbox.val(),
                          status: 1 // Set Status to 1 for checked checkboxes
                      });
                  } else {
                      checkedValues.push({
                          value: checkbox.val(),
                          status: 0 // Set Status to 0 for unchecked checkboxes
                      });
                  }
              });

              console.log("Checked Values:", checkedValues);

              var msg = "";

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function () {
                  $('#saveConfirmationModal1').modal('hide');

                  var pejabatLokasiDetailPengesahan = [];
                  var kodLokasiPengesahan = [];
                  var statusPengesahan = []; // Array to hold status values

                  checkedValues.forEach(function (item) {
                      var splitValues = item.value.split('|');
                      pejabatLokasiDetailPengesahan.push(splitValues[0]); // KodLokasiDtl
                      kodLokasiPengesahan.push(splitValues[1]); // KodLokasi
                      statusPengesahan.push(item.status); // Push the status value into the array
                  });

                  var newPengesahan = {
                      mohonPengesahan: {
                          kategoriStorPengesahan: $('#kategoriStor').val(),
                          pejabatLokasiPengesahan: $('#pejabatLokasi').val(),
                          kategoriBarangPengesahan: $('#kategoriBarang').val(),
                          senaraiBarangPengesahan: $('#senaraiBarang').val(),
                          takatMinimaPengesahan: $('#takatMinima').val(),
                          takatMaksimaPengesahan: $('#takatMaksima').val(),
                          takatMenokokPengesahan: $('#takatMenokok').val(),
                          pejabatLokasiDetailPengesahan: pejabatLokasiDetailPengesahan.join(', '), //for KodLokasiDtl 
                          kodLokasiPengesahan: kodLokasiPengesahan.join(', '), //for KodLokasi
                          statusPengesahan: statusPengesahan.join(', '), // Join status values
                      }
                  };

                  console.log(newPengesahan);

                  var result = JSON.parse(await ajaxSavePengesahahahahahaha(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      tbl11.ajax.reload();
                      close_loader(); // Refresh the page
                  } else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });

          async function ajaxSavePengesahahahahahaha(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'BarangStor_WS.asmx/Save_Pengesahan2',
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
          // ---------------------- UNTUK ADD END -------------------------------
          // ---------------------- UNTUK EDIT START -----------------------------
          $('.btnSimpan3').off('click').on('click', async function () {

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function () {
                  $('#saveConfirmationModal1').modal('hide');

                  var pejabatLokasiDetail = [];
                  var statusPengesahan = [];

                  // Iterate over checked checkboxes
                  $('.Status:checked').each(function () {
                      pejabatLokasiDetail.push($(this).data('kodLokasiDtl'));
                      statusPengesahan.push('1');
                  });

                  // Iterate over unchecked checkboxes
                  $('.Status:not(:checked)').each(function () {
                      pejabatLokasiDetail.push($(this).data('kodLokasiDtl'));
                      statusPengesahan.push('0');
                  });

                  var newPengesahan = {
                      mohonPengesahan: {
                          kategoriStorPengesahan: $('#kategoriStor2').val(),
                          pejabatLokasiPengesahan: $('#pejabatLokasi2').val(),
                          kategoriBarangPengesahan: $('#kategoriBarang2').val(),
                          senaraiBarangPengesahan: $('#senaraiBarang2').val(),
                          takatMinimaPengesahan: $('#takatMinima2').val(),
                          takatMaksimaPengesahan: $('#takatMaksima2').val(),
                          takatMenokokPengesahan: $('#takatMenokok2').val(),
                          pejabatLokasiDetailPengesahan: pejabatLokasiDetail.join(','), // Combine pejabatLokasiDetail array into a string
                          statusPengesahan: statusPengesahan.join(',') // Combine statusPengesahan array into a string
                      },
                  };

                  console.log('Semua Data:', newPengesahan);

                  var result = JSON.parse(await ajaxUpdatePengesahan(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      tbl11.ajax.reload();
                      close_loader();
                  } else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });

          async function ajaxUpdatePengesahan(mohonPengesahan) {
              debugger;
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'BarangStor_WS.asmx/Update_Barang',
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
          // ---------------------- UNTUK EDIT END -------------------------------
          var dtbl2 = $("#spekfikasi-table").DataTable({
              responsive: true,
              searching: false,
              info: false,
              lengthChange: false,
              paging: false,
              pageLength: 5,
              ordering: false
          });
          var dtbl2 = $("#spekfikasi-table2").DataTable({
              responsive: true,
              searching: false,
              info: false,
              lengthChange: false,
              paging: false,
              pageLength: 5,
              ordering: false
          });

          function fetchSecondTableData(value1, value2) {
              $.ajax({
                  type: "POST",
                  url: "BarangStor_WS.asmx/Get_SecondTableData",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  data: JSON.stringify({ value1: value1, value2: value2 }), // Adjust the data object
                  success: function (response) {
                      var table = $("#spekfikasi-table").DataTable();
                      table.clear().draw(); // Clear existing data

                      var dataArray = JSON.parse(response.d);
                      if (dataArray && dataArray.length > 0) {
                          for (var i = 0; i < dataArray.length; i++) {
                              var row = dataArray[i];
                              // Concatenate KodLokasiDtl and KodLokasi
                              var combinedValue = row.KodLokasiDtl + '|' + row.KodLokasi;
                              // Add data to the table with combined value
                              table.row.add([
                                  "<input class='checkLokasi' value='" + combinedValue + "' type='checkbox'>",
                                  row.Butiran || ' - ' // Butiran holds the value of KodLokasiDtl
                              ]).draw(false); // Draw each row without updating paging
                          }
                      } else {
                          // Show a message when no data available
                          table.row.add(["No data available", ""]).draw(false);
                      }
                  },
                  error: function (xhr, error, thrown) {
                      console.log("Ajax error:", error);
                  }
              });
          }

          function fetchThirdTableData(value1, value2, value3) {
              $.ajax({
                  type: "POST",
                  url: "BarangStor_WS.asmx/Get_CombinedTableData",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  data: JSON.stringify({ value1: value1, value2: value2, value3: value3 }),
                  success: function (response) {
                      var data = JSON.parse(response.d);
                      console.log(data);

                      // Clear existing rows
                      dtbl2.clear().draw();

                      // Loop through each row in the data
                      data.forEach(function (row) {
                          var isChecked = row.Status === "1";
                          var newRow = dtbl2.row.add([
                              '<input type="checkbox" class="Status"' + (isChecked ? ' checked' : '') + '>',
                              row.Butiran
                          ]).draw().node();

                          // Set data attribute for the checkbox
                          $(newRow).find('input[type="checkbox"]').data('kodLokasiDtl', row.KodLokasiDtl);
                      });
                  }
              });
          }


          function buildDdl(id, kodVal, txtVal) {
              if (kodVal && txtVal) {
                  $("#" + id).dropdown('set selected', kodVal);
                  $("#" + id).html("<option value = '" + kodVal + "'>" + txtVal + "</option>");
              }
          }
      </script>
   </contenttemplate>
</asp:Content>