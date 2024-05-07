<%@ Page Language="vb" AutoEventWireup="false"  MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PEMBATALAN_STOK.aspx.vb" Inherits="SMKB_Web_Portal.PEMBATALAN_STOK" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
   <script type="text/javascript">
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
   </script>
   <style>
      input[readonly] {
      background-color: #e5e5e5;
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
      max-width: 1200px;
      margin: auto;
      }
      .form-group {
      max-width: 100%;
      }
      #permohonan .modal-body {
        max-height: 60vh;  /* Adjust height as needed to fit your layout */
        min-height: 50vh;
      }
      #detailTotal .modal-body {
        max-height: 20vh;  /* Adjust height as needed for #detailTotal */
        min-height: 20vh;
      }

      #MessageModal .modal-body {
        max-height: 10vh;  /* Adjust height as needed for #detailTotal */
        min-height: 10vh;
      }



   </style>
   <contenttemplate>
      <div id="PermohonanTab" class="tabcontent" style="display: block">
         <div class="modal-body">

            <div class="form-group row col-md-6 align-middle">
               <label for="inputEmail3" class="col-sm-3 col-form-label" style="text-align:right">Carian :</label>
               <div class="col-sm-6">
                  <div class="input-group">
                     <select id="categoryFilter" class="custom-select">
                        <option value="">SEMUA</option>
                        <option value="1" selected="selected">Hari Ini</option>
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
               <div class="col-md-3">
                  <div class="form-row">
                     <div class="form-group col-md-5">
                        <br />
                     </div>
                  </div>
               </div>
               <div class="col-md-11">
                  <div class="form-row">
                     <div class="form-group col-md-2"></div>
                     <div class="form-group col-md-1 align-middle">
                        <label id="lblMula" style="text-align: right;display:none;" class="col-sm-3 col-form-label">Mula: </label>
                     </div>
                     <div class="form-group col-md-3">
                        <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display:none;" class="form-control date-range-filter">
                     </div>
                     <div class="form-group col-md-1">
                     </div>
                     <div class="form-group col-md-1 align-middle">
                        <label id="lblTamat" style="text-align: right;display:none;" class="col-sm-3 col-form-label">Tamat: </label>
                     </div>
                     <div class="form-group col-md-3">
                        <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display:none;" class="form-control date-range-filter">
                     </div>
                  </div>
                  <div class="form-group col-md-2"></div>
               </div>
            </div>
            <div class="col-md-12 ">
                <div class="row">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblListPermohonan" class="table table-striped" style="width:100%">
                                <thead>
                                    <tr>
                                        <th style="width:5%" >No</th>
                                        <th style="width:10%" >No Permohonan</th>
                                        <th style="width:7%" >Tkh. Mohon</th>
                                        <th style="width:7%" >Masa Mohon</th>
                                        <th style="width:7%" >Kuantiti Mohon</th>
                                        <th style="width:20%" >Kod Ptj</th>
                                        <th style="width:20%" >Pejabat</th>
 
                                    </tr>
                                </thead>
                                <tbody id="" onclick="ShowPopup('1')">
                                   <tr style="width: 100%" class="table-list">
                                      <td style="width: 5%"></td>
                                      <td style="width: 10%"></td>
                                      <td style="width: 7%"></td>
                                      <td style="width: 7%"></td>
                                      <td style="width: 7%"></td>
                                      <td style="width: 20%"></td>
                                      <td style="width: 20%"></td>
                                   </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                </div>
         </div>
         <div class="modal fade bd-example-modal-xl " id="permohonan" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static" >
            <div class="modal-dialog modal-dialog-centered modal-xl"  role="document">
               <div class="modal-content modal-xl">
                  
                     <!-- ~~~ TAB 1 START ~~~-->
                        <div id="divpendaftaraninv" runat="server" visible="true">
                            <div class="modal-header modal-header--sticky">
                                <h5 class="modal-title" id="ModalCenterTitle">Pembatalan Info</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                           <div class="modal-body" style="overflow-y: auto;">
                              <div>
                                 <div class="row">
                                    <div class="col-md-12">
                                         <div class="table-title">
                                            <h5>Maklumat Permohonan</h5>
                                        </div>
                                       <div class="form-row">
                                           <div class="form-group col-md-4">
                                               <input class="input-group__input" name="idMohon" id="idMohon" type="text" readonly disabled/>
                                               <label class="input-group__label" for="idMohon">Id Mohon</label>
                                            </div>
                                          <div class="form-group col-md-4">
                                             <input class="input-group__input" name="Bahagian/Fakulti" id="ptj" type="text" readonly disabled/>
                                             <label class="input-group__label" for="Bahagian/Fakulti">Bahagian/Fakulti</label>
                                          </div>
                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="Tarikh Permohonan" id="tarikhPermohonan" type="text" readonly disabled/>
                                                <label class="input-group__label" for="Tarikh Permohonan">Tarikh Permohonan</label>
                                             </div>
                                           <div class="form-group col-md-4">
                                                <input class="input-group__input" name="Nama Pemohon" id="namaPemohon" type="text" readonly disabled/>
                                                <label class="input-group__label" for="Nama Pemohon">Nama</label>
                                             </div>
                                           <div class="form-group col-md-4">
                                             <input class="input-group__input" name="No.Staf" id="id_staff" type="text" readonly disabled/>
                                             <label class="input-group__label" for="No.Staf">No.Staf</label>
                                          </div>
                                            </div>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-md-12">
                                 <div class="transaction-table table-responsive">
                                    <span style="display: inline-block; height: 100%;"></span>
                                    <table  id="tblListPembatalan"  class="table table-striped" style="width:100%">
                                       <thead>
                                          <tr>

                                             <th scope="col" style="width: 5%;">Bil</th>
                                             <th scope="col"  style="width: 30%;">Nama Barang</th>
                                             <th scope="col"  style="width: 15%;">Tkt.Min</th>
                                             <th scope="col"  style="width: 15%;">Tkt.Max</th>
                                             <th scope="col"  style="width: 15%;">Tkt.Menokok</th>
                                             <th scope="col"  style="width: 15%;">Baki Stok</th>
                                             <th scope="col"  style="width: 15%;">Baki Ptj</th>
                                             <th scope="col"  style="width: 15%;">Sedang Dimohon</th>
                                             <th scope="col"  style="width: 15%;">Kuantiti Mohon</th>

                                          </tr>
                                       </thead>
                                       <tbody>
                                           <tr>
                                            <td style="width: 5%"></td>
                                            <td style="width: 20%"></td>
                                            <td style="width: 30%"></td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 15%"></td>
                                            <td style="width: 15%"></td>

                                            </tr>
                                            </tbody>
                                    </table>
                                 </div>
                              </div>
                                <br />
                                <div align="right" style="padding-bottom:20px; padding-right:20px;">
                                   <button type="button" class="btn btn-danger" id="btnBatal"
                                      data-toggle="tooltip" data-placement="bottom"
                                      title="Batal Permohonan" value="05">
                                   Batal Permohonan</button>
                                </div>
                           </div>
                        </div>
                     </div>
                </div>
                     <!-- ~~~ TAB 1 END   ~~~-->   
              </div>
        </div>
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger btnTidak"
                            data-dismiss="modal">
                            Tidak</button>
                        <button type="button" class="btn btn-secondary btnYA" data-toggle="modal"
                            data-target="#ModulForm" data-dismiss="modal">
                            Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="NotifyModal" role="dialog" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblNotify">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="notify"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
      <script>

          //untuk txtMohon get current date
          // Get the current date
          var today = new Date();

          var tblListPermohonan = null
          var isClicked = false;
          var category_filter, startDate, endDate;

          $(document).ready(function () {

              tblListPermohonan = $("#tblListPermohonan").DataTable({

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
                      "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                      "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                      "sEmptyTable": "Tiada rekod.",
                      "sSearch": "Carian"

                  },


                  "ajax": {
                      url: 'PEMBATALAN_STOKWS.asmx/LoadSenaraiPermohonan',
                      type: 'POST',
                      "contentType": "application/json; charset=utf-8",
                      "dataType": "json",
                      "dataSrc": function (json) {
                          return JSON.parse(json.d);
                      },
                      "data": function () {
                          var startDate = $('#txtTarikhStart').val();
                          var endDate = $('#txtTarikhEnd').val();
                          return JSON.stringify({
                              category_filter: $('#categoryFilter').val(),
                              isClicked: isClicked,
                              tkhMula: startDate,
                              tkhTamat: endDate
                          })
                          console.log("Data sent to server:", data);
                          return JSON.stringify(data);
                      },
                      "error": function (xhr, error, thrown) {
                          console.log("Ajax error:", error);
                      }
                  },

                  "drawCallback": function (settings) {
                      close_loader();
                  },
                  "columns": [
                      {
                          "data": null,
                          "render": function (data, type, row, meta) {
                              return meta.row + 1;
                          }
                      },
                      { "data": "No_Mohon" },
                      { "data": "Tarikh_Mohon" },
                      { "data": "Masa_Mohon" },
                      { "data": "Total_Kuantiti_Mohon" },
                      { "data": "Kod_Ptj", "visible": false },
                      { "data": "Pejabat" }
                  ],



                  "rowCallback": function (row, data) {// Add hover effect
                      $(row).hover(function () {
                          $(this).addClass("hover pe-auto bg-warning");
                      }, function () {
                          $(this).removeClass("hover pe-auto bg-warning");
                      });
                  },

              });

              $('.btnSearch').click(async function () {
                  show_loader();
                  isClicked = true;
                  category_filter = $('#categoryFilter').val();

                  if (category_filter == "6") {
                      startDate = $('#tkhMula').val();
                      endDate = $('#tkhTamat').val();
                      if (startDate == "") {
                          notification("Sila pilih tarikh carian")
                          return
                      }
                  } else {
                      startDate = "";
                      endDate = "";
                  }
                  tblListPermohonan.ajax.reload();
              });

              $("#categoryFilter").change(function () {

                  var selectedValue = $('#categoryFilter').val()

                  if (selectedValue === "6") {
                      // Show the date inputs
                      $('#divDatePicker').removeClass("d-none").addClass("d-flex");
                  } else {
                      // Hide the date inputs
                      $('#divDatePicker').removeClass("d-flex").addClass("d-none");

                  }
              });

              


              $('#tblListPermohonan tbody').on('click', 'tr', function () {

                  var data = tblListPermohonan.row(this).data(); //get data from clicked row
                  console.log(data); // Check the structure of the data

                  var idMohon = data['No_Mohon']; //extract the idMohon from the clickable row
                  console.log("idMohon:", idMohon);
                  var kod_Ptj = data['Kod_Ptj'];

                  //$('#permohonan').modal('hide');


                  $.ajax({
                      url: "PEMBATALAN_STOKWS.asmx/GetPermohonanDetails",
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      data: JSON.stringify({ idMohon: idMohon, kod_Ptj: kod_Ptj }),
                      dataType: "json",
                      success: function (response) {
                          var data = JSON.parse(response.d);
                          loadListPembatalan(idMohon)
                          console.log(response.d)
                          // Populate form fields with the retrieved data
                          $('#idMohon').val(data[0].No_Mohon);
                          $('#tarikhPermohonan').val(data[0].Tkh_Mohon);
                          $("#ptj").val(data[0].Kod_Ptj + " - " + data[0].Pejabat);


                      },
                      error: function (xhr, status, error) {
                          console.error(xhr.responseText);
                          notification("Gagal papar maklumat.");
                      }
                  });

                  $.ajax({
                      url: "PEMBATALAN_INDIVIDUWS.asmx/fetchMaklumatPemohon",
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      data: JSON.stringify({ idMohon: idMohon }),
                      dataType: "json",
                      success: function (response) {
                          // Parse the JSON string within the "d" property
                          var responseData = JSON.parse(response.d);
                          // Check if responseData is an array and has at least one element
                          if (Array.isArray(responseData) && responseData.length > 0) {
                              // Access the properties of the first element
                              $("#namaPemohon").val(responseData[0].MS01_Nama);
                              $("#id_staff").val(responseData[0].MS01_NoStaf);
                          }
                      },
                      error: function (error) {
                          console.error(error.responseText); // Access the error message directly
                      }
                  });

              });

          });



          var tblListPembatalan = null;
          function loadListPembatalan(idMohon) {

              tblListPembatalan = $("#tblListPembatalan").DataTable({
                  "destroy": true,
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
                      "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                      "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                      "sEmptyTable": "Tiada rekod.",
                      "sSearch": "Carian"
                  },

                  "ajax":
                  {
                      "url": "PEMBATALAN_STOKWS.asmx/loadListPembatalan",
                      type: 'POST',
                      data: function (d) {
                          return "{ idMohon: '" + idMohon + "'}";
                      },
                      "contentType": "application/json; charset=utf-8",
                      "dataType": "json",
                      "dataSrc": function (json) {
                          return JSON.parse(json.d);
                      },
                      "drawCallback": function (settings) {
                          close_loader();
                      },

                  },

                  "columns": [
                      {
                          "data": null,
                          "render": function (data, type, row, meta) {
                              return meta.row + 1;
                          }
                      },
                      { "data": "Kod_Brg_Butiran" },
                      { "data": "Takat_Min" },
                      { "data": "Takat_Max" },
                      { "data": "Takat_Menokok" },
                      { "data": "Baki_Stok" },
                      { "data": "Baki_Ptj" },
                      { "data": "SdgDimohon" },
                      { "data": "Kuantiti_Mohon" }
                  ],

                  "rowCallback": function (row, data) {// Add hover effect
                      $(row).hover(function () {
                          $(this).addClass("hover pe-auto bg-warning");
                      }, function () {
                          $(this).removeClass("hover pe-auto bg-warning");
                      });
                  },
              });
          }

          $('#btnBatal').click(function () {
              var IdMohon;
              btnBatal(IdMohon);
              //window.location.reload();
          });



          function btnBatal(IdMohon) {
              var IdMohon = $("#idMohon").val();
              //var status_dok;

              var data = {
                  IdMohon: IdMohon,
              };

              show_message_async("Adakah anda pasti untuk menghantar permohonan ini?").then(function (confirmed) {
                  if (confirmed) {
                      $.ajax({
                          url: "PEMBATALAN_STOKWS.asmx/updatePembatalan",
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          data: JSON.stringify(data),
                          dataType: "json",
                          success: function (response) {
                              var data = JSON.parse(response.d);
                              if (data.Code === "00") {
                                  notification("Pembatalan Permohonan Berjaya");

                                  $('#NotifyModal').one('hidden.bs.modal', function () {
                                      window.location.reload();
                                  });

                              } else {
                                  notification("Pembatalan Permohonan Gagal");
                              }
                          },
                          error: function (xhr, status, error) {
                              console.log(xhr.responseText);
                              notification("Gagal menyimpan maklumat.");
                          }
                      });
                  }
              });
          }


          function show_message_async(msg) {
              $("#MessageModal .modal-body").text(msg);

              return new Promise(function (resolve, reject) {
                  $('.btnYA').one('click', function () {
                      $("#MessageModal").modal('hide');
                      resolve(true); // User confirmed
                  });

                  $('.btnTidak').one('click', function () {
                      $("#MessageModal").modal('hide');
                      resolve(false); // User canceled
                  });

                  $("#MessageModal").modal('show');
              });
          }


          function show_message(msg, okfn, cancelfn) {

              $("#MessageModal .modal-body").text(msg);

              $('.btnYA').click(function () {
                  if (okfn !== null && okfn !== undefined) {
                      okfn();
                  }
              });

              $("#MessageModal").modal('show');
          }

          function notification(msg) {
              $("#notify").html(msg);
              $("#NotifyModal").modal('show');
          }


      </script>
   </contenttemplate>
</asp:Content>

