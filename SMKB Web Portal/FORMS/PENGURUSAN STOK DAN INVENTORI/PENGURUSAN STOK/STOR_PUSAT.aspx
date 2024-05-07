<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="STOR_PUSAT.aspx.vb" Inherits="SMKB_Web_Portal.STOR_PUSAT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
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
   </style>
   <!-------------------------------------------------------------------  STYLE END  -------------------------------------------------------------------------->
   <!------------------------------------------------------------------  CODE START  -------------------------------------------------------------------------->
   <div id="PermohonanTab" class="tabcontent" style="display: block">
      <div id="SenaraiPermohonan">
         <fieldset class="form-group border" style="border-radius: 5px; margin: 35px;">
            <legend class="w-auto px-2 h6 font-weight-bold">Stor Pusat</legend>
            <div class="modal-body">
               <div class="row">
                  <div class="col-md-12">
                     <div class="form-row">
                        <div class="form-group col-md-5">
                           <label>Kategori</label>
                           <div class="responsive">
                              <select class="form-control input-sm ui search dropdown" name="kategoriBarang" id="kategoriBarang">
                              </select>                                            
                           </div>
                        </div>
                        <div class="form-group col-md-3" ></div>
                        <div class="form-group col-md-3" >
                           <label>Unit Ukuran</label>
                           <input type="text" class="form-control input-sm" placeholder="Unit Ukuran" id="ukuranBarang" name="ukuranBarang" readonly />
                        </div>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="form-row">
                        <div class="form-group col-md-5">
                           <label>Senarai Bekalan</label>
                           <div class="responsive">
                              <select class="form-control input-sm ui search dropdown" name="bekalanBarang" id="bekalanBarang">
                              </select>                                            
                           </div>
                        </div>
                        <div class="form-group col-md-3" ></div>
                        <div class="form-group col-md-3" >
                           <label>Lokasi</label>
                           <input type="text" class="form-control input-sm" placeholder="Lokasi" id="lokasiBarang" name="lokasiBarang" readonly />
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </fieldset>
      </div>
   </div>
   <fieldset>
      <div class="modal-header">
         <div class="modal-title"><strong>Senarai Transaksi Terimaan Barangan</strong></div>
      </div>
      <div class=" -body">
         <div class="col-md-12">
            <div class="transaction-table table-responsive">
               <span style="display:inline-block;height:50%;"></span>
               <table id="tblDataSenarai_trans" class="table table-striped" style="width: 100%">
                  <thead>
                     <tr>
                        <th scope="col">Bil.</th>
                        <th scope="col">Nama Barang</th>
                        <th scope="col">Tujuan Kegunaan</th>
                        <th scope="col">Baki Ptj</th>
                        <th scope="col">Kuantiti</th>
                        <th scope="col">Tkt. Minima</th>
                        <th scope="col">Tkt. Menokok</th>
                        <th scope="col">Baki Stok</th>
                        <th scope="col">Kuantiti</th>
                        <th scope="col">Petunjuk</th>
                     </tr>
                  </thead>
                  <tbody id="tableID_Senarai_trans">
                  </tbody>
               </table>
            </div>
         </div>
      </div>
   </fieldset>
   <br />
   <fieldset class="form-group border" style="border-radius: 5px; margin: 35px;">
      <legend class="w-auto px-2 h6 font-weight-bold">Maklumat Terimaan</legend>
      <div class="row">
         <div class="col-md-12">
            <div class="form-row">
               <div class="form-group col-md-1">
               </div>
               <div class="form-group col-md-2">
                  <label>Tarikh</label>
                  <input type="date" class="form-control input-sm" placeholder="Tarikh Invois" name="tkhInv" id="tkhInv">
               </div>
               <div class="form-group col-md-6">
               </div>
               <div class="form-group col-md-2" >
                  <label>Kuantiti</label>
                  <input type="text" class="form-control input-sm" placeholder="Kuantiti" id="txtidinv" name="txtidinv" readonly />
               </div>
            </div>
            <div class="form-row">
               <div class="form-group col-md-1">
               </div>
               <div class="form-group col-md-2" >
                  <label>Unit Ukuran</label>
                  <input type="time" class="form-control input-sm" placeholder="Unit Ukuran" id="txtidinv" name="txtidinv" readonly />
               </div>
               <div class="form-group col-md-6">
               </div>
               <div class="form-group col-md-2" >
                  <label>Harga Seunit (RM)</label>
                  <input type="text" class="form-control input-sm" placeholder="Harga Seunit" id="txtidinv" name="txtidinv" readonly />
               </div>
            </div>
            <div class="form-row">
               <div class="form-group col-md-1">
               </div>
               <div class="form-group col-md-4" >
                  <label>Syarikat</label>
                  <input type="text" class="form-control input-sm" placeholder="Syarikat" id="txtidinv" name="txtidinv" readonly />
               </div>
               <div class="form-group col-md-4"></div>
               <div class="form-group col-md-2" >
                  <label>Jumlah (RM)</label>
                  <input type="text" class="form-control input-sm" placeholder="Jumlah" id="txtidinv" name="txtidinv" readonly />
               </div>
            </div>
            <div class="form-row">
               <div class="form-group col-md-1">
               </div>
               <div class="form-group col-md-4" >
                  <label>No. Rujukan</label>
                  <input type="text" class="form-control input-sm" placeholder="No. Rujukan" id="txtidinv" name="txtidinv" readonly />
               </div>
            </div>
         </div>
      </div>
   </fieldset>
   <br />
   <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
      aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan Pengeluaran Untuk Proses Pengeluaran</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
               </button>
            </div>
         </div>
      </div>
   </div>
   <!------------------------------------------------------------------  CODE END    -------------------------------------------------------------------------->
   <!------------------------------------------------------------------- SCRIPT START ------------------------------------------------------------------------->
   <script type="text/javascript">
      var isClicked = false;
      
      function ShowPopup(elm) {
      
          //alert("test" + elm);
          if (elm == "1") {
              $('#permohonan').modal('toggle');
          }
          else if (elm == "2") { // open modal and load data
      
              $(".modal-body div").val("");
              $('#permohonan').modal('toggle');
      
              // set datepicker to empty and hide it as default state
              $('#txtTarikhStart').val("");
              $('#txtTarikhEnd').val("");
              $('#divDatePicker').removeClass("d-flex").addClass("d-none");
      
              // set categoryFilter to Semua as default state
              $('#categoryFilter').val("");
      
              // run click event on the .btnSearch button
              $('.btnSearch').click();
      
              // set btnEmel and btnCetak to show when modal is open
              $('.btnEmel').show();
              $('.btnCetak').show();
          }
      }
      
      
      
      var tbl = null
      $(document).ready(function () {
          //Take the category filter drop down and append it to the datatables_filter div. 
          //You can use this same idea to move the filter anywhere withing the datatable that you want.
      
          //$("#tblDataSenarai_trans_filter.dataTables_filter").append($("#categoryFilter"));
          tbl = $("#tblDataSenarai_trans").DataTable({
      
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
                  "url": "Transaksi_WS.asmx/LoadOrderRecord_SenaraiLulusTransaksiJurnal",
                  method: 'POST',
                  "contentType": "application/json; charset=utf-8",
                  "dataType": "json",
                  "dataSrc": function (json) {
                      return JSON.parse(json.d);
                  },
                  data: function () {
                      //Filter date bermula dari sini - 20 julai 2023
                      var startDate = $('#txtTarikhStart').val()
                      var endDate = $('#txtTarikhEnd').val()
                      return JSON.stringify({
                          category_filter: $('#categoryFilter').val(),
                          isClicked: isClicked,
                          tkhMula: startDate,
                          tkhTamat: endDate
                      })
                      //akhir sini
                  }
      
              },
      
              "columns": [
                  {
                      "data": "No_Jurnal",
                      render: function (data, type, row, meta) {
      
                          if (type !== "display") {
      
                              return data;
      
                          }
      
                          var link = `<td style="width: 10%" >
                                        <label id="lblNo" name="lblNo" class="lblNo" value="${data}" >${data}</label>
                                        <input type ="hidden" class = "lblNo" value="${data}"/>
                                    </td>`;
                          return link;
                      }
                  },
                  { "data": "No_Rujukan" },
                  { "data": "No_Staf" },
                  { "data": "Butiran" },
                  { "data": "Jenis_Trans" },
                  { "data": "Tkh_Transaksi" },
                  { "data": "Tkh_Transaksi" },
                  { "data": "Tkh_Transaksi" },
                  {
                      "data": "Kod_Status_Dok",
                      render: function (data, type, row, meta) {
      
                          var link
      
                          if (data === "SELESAI KELULUSAN") {
                              link = `<td style="width: 10%" >
                                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:blue;" >${data}</p>                                              
                                    </td>`;
      
                          }
                          else if (data === "GAGAL KELULUSAN") {
                              link = `<td style="width: 10%" >
                                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:blue;" >${data}</p>                                              
                                    </td>`;
      
                          }
                          else {
                              link = `<td style="width: 10%" >
                                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:red;" >${data}</p>                                              
                                    </td>`;
                          }
      
      
                          return link;
                      }
                  }
      
                  ,
                  {
                      className: "btnView",
                      "data": "No_Jurnal",
                      render: function (data, type, row, meta) {
      
                          if (type !== "display") {
      
                              return data;
      
                          }
      
                          var link = `<button id="btnView" runat="server" class="btn btnView" type="button" style="color: blue" onclick="ShowPopup('2')">
                                            <i class="fa fa-edit"></i>
                                </button>`;
                          return link;
                      }
                  }
      
              ]
          });
      
          tbl = $("#tblDataSenarai_trans2").DataTable({
      
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
                  "url": "Transaksi_WS.asmx/LoadOrderRecord_SenaraiLulusTransaksiJurnal",
                  method: 'POST',
                  "contentType": "application/json; charset=utf-8",
                  "dataType": "json",
                  "dataSrc": function (json) {
                      return JSON.parse(json.d);
                  },
                  data: function () {
                      //Filter date bermula dari sini - 20 julai 2023
                      var startDate = $('#txtTarikhStart').val()
                      var endDate = $('#txtTarikhEnd').val()
                      return JSON.stringify({
                          category_filter: $('#categoryFilter').val(),
                          isClicked: isClicked,
                          tkhMula: startDate,
                          tkhTamat: endDate
                      })
                      //akhir sini
                  }
      
              },
      
              "columns": [
                  {
                      "data": "No_Jurnal",
                      render: function (data, type, row, meta) {
      
                          if (type !== "display") {
      
                              return data;
      
                          }
      
                          var link = `<td style="width: 10%" >
                                        <label id="lblNo" name="lblNo" class="lblNo" value="${data}" >${data}</label>
                                        <input type ="hidden" class = "lblNo" value="${data}"/>
                                    </td>`;
                          return link;
                      }
                  },
                  { "data": "No_Rujukan" },
                  { "data": "No_Staf" },
                  { "data": "Butiran" },
                  {
                      "data": "Kod_Status_Dok",
                      render: function (data, type, row, meta) {
      
                          var link
      
                          if (data === "SELESAI KELULUSAN") {
                              link = `<td style="width: 10%" >
                                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:blue;" >${data}</p>                                              
                                    </td>`;
      
                          }
                          else if (data === "GAGAL KELULUSAN") {
                              link = `<td style="width: 10%" >
                                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:blue;" >${data}</p>                                              
                                    </td>`;
      
                          }
                          else {
                              link = `<td style="width: 10%" >
                                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:red;" >${data}</p>                                              
                                    </td>`;
                          }
      
      
                          return link;
                      }
                  }
      
                  ,
                  { "data": "No Jurnal" },
      
              ]
          });
      
          $(document).ready(function () {
              $('#categoryFilter').select2(); // Apply Select2 to the dropdown
          });
      
          $("#categoryFilter").change(function (e) {
      
              var selectedItem = $('#categoryFilter').val()
              if (selectedItem == "6") {
                  $('#txtTarikhStart').show();
                  $('#txtTarikhEnd').show();
      
                  $('#lblMula').show();
                  $('#lblTamat').show();
      
                  $('#txtTarikhStart').val("")
                  $('#txtTarikhEnd').val("")
              }
              else {
                  $('#txtTarikhStart').hide();
                  $('#txtTarikhEnd').hide();
      
                  $('#txtTarikhStart').val("")
                  $('#txtTarikhEnd').val("")
      
                  $('#lblMula').hide();
                  $('#lblTamat').hide();
      
              }
      
          });
      
      
      });
      
      var searchQuery = "";
      var oldSearchQuery = "";
      var curNumObject = 0;
      var tableID = "#tblData";
      var tableID_Senarai = "#tblDataSenarai_trans";
      var shouldPop = true;
      var totalID = "#totalBeza";
      
      var totalDebit = "#totalDbt";
      var totalKredit = "#totalKt";
      
      var objMetadata = [{
          "obj1": {
              "id": "",
              "oldSearchQurey": "",
              "searchQuery": ""
          }
      }, {
          "obj2": {
              "id": "",
              "oldSearchQurey": "",
              "searchQuery": ""
          }
      }]
      
      $(document).ready(function () {
      
          $('#ddlJenTransaksi').dropdown({
              apiSettings: {
                  url: 'Transaksi_WS.asmx/GetJenisTransaksi?q={query}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
                      settings.data = JSON.stringify({ q: settings.urlData.query });
                      searchQuery = settings.urlData.query;
                      return settings;
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
      
                      //if (searchQuery !== oldSearchQuery) {
                      // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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
      });
      
      $(function () {
          $('.btnAddRow.five').click();
      });
      
      $('.btnHantar').click(async function () {
          var jumRecord = 0;
          var acceptedRecord = 0;
          var msg = "";
          var newOrder = {
              order: {
                  OrderID: $('#lblNoJurnal').val(),
                  NoRujukan: $('#txtNoRujukan').val(),
                  Perihal: $('#txtPerihal').val(),
                  Tarikh: $('#txtTarikh').val(),
                  JenisTransaksi: $('#ddlJenTransaksi').val(),
                  JumlahDebit: $('#totalDbt').val(),
                  Jumlahkredit: $('#totalkt').val(),
                  JumlahBeza: $('#totalBeza').val(),
                  OrderDetails: []
              }
      
          }
      
      
          $('.ptj-list').each(function (index, obj) {
      
              if (index > 0) {
                  var tcell = $(obj).closest("td");
                  //alert("ce;; "+tcell)
                  var orderDetail = {
                      OrderID: $('#lblNoJurnal').val(),
                      ddlPTJ: $(obj).dropdown("get value"),
                      ddlVot: $('.vot-list').eq(index).dropdown("get value"),
                      ddlKw: $('.kw-list').eq(index).dropdown("get value"),
                      ddlKo: $('.ko-list').eq(index).dropdown("get value"),
                      ddlKp: $('.kp-list').eq(index).dropdown("get value"),
                      debit: $('.Debit').eq(index).val(),
                      kredit: $('.Kredit').eq(index).val(),
                      id: $(tcell).find(".data-id").val()
                  };
      
                  //console.log(orderDetail);
      
                  //if (orderDetail.ddlPTJ === "" || orderDetail.ddlVot === "" || orderDetail.ddlKw === "" || orderDetail.ddlKo === "" || orderDetail.ddlKp === "" ||
                  //    orderDetail.debit === "" ||  orderDetail.kredit === "") {
                  //    return;
                  //}
      
                  acceptedRecord += 1;
                  newOrder.order.OrderDetails.push(orderDetail);
      
              }
      
          });
      
          //console.log(newOrder.order);
      
          msg = "Anda pasti ingin menghantar " + acceptedRecord + " rekod ini?"
      
          if (!confirm(msg)) {
              return false;
          }
      
          var result = JSON.parse(await ajaxSubmitOrder(newOrder));
          alert(result.Message)
          //$('#orderid').val(result.Payload.OrderID)
      
          //loadExistingRecords();
          //await clearAllRows();
          // AddRow(5);
      
      });
      
      $('.btnLulus').click(async function () {
      
      
      
          var jumRecord = 0;
          var acceptedRecord = 0;
          var msg = "";
          var newOrder = {
              order: {
                  OrderID: $('#lblNoJurnal').val(),
                  NoRujukan: $('#txtNoRujukan').val(),
                  Perihal: $('#txtPerihal').val(),
                  Tarikh: $('#txtTarikh').val(),
                  JenisTransaksi: $('#ddlJenTransaksi').val(),
                  JumlahDebit: $('#totalDbt').val(),
                  Jumlahkredit: $('#totalkt').val(),
                  JumlahBeza: $('#totalBeza').val(),
                  OrderDetails: []
              }
      
          }
      
      
          $('.COA-list').each(function (index, obj) {
      
              if (index > 0) {
                  var tcell = $(obj).closest("td");
                  //alert("ce;; "+tcell)
                  var orderDetail = {
                      OrderID: $('#lblNoJurnal').val(),
                      ddlVot: $(obj).dropdown("get value"),
                      ddlPTJ: $('.Hid-ptj-list').eq(index).html(),
                      ddlKw: $('.Hid-kw-list').eq(index).html(),
                      ddlKo: $('.Hid-ko-list').eq(index).html(),
                      ddlKp: $('.Hid-kp-list').eq(index).html(),
                      debit: $('.Debit').eq(index).val(),
                      kredit: $('.Kredit').eq(index).val(),
                      id: $(tcell).find(".data-id").val()
                  };
      
      
                  //console.log( orderDetail);
      
                  //if (orderDetail.ddlPTJ === "" || orderDetail.ddlVot === "" || orderDetail.ddlKw === "" || orderDetail.ddlKo === "" || orderDetail.ddlKp === "" ||
                  //    orderDetail.debit === "" ||  orderDetail.kredit === "") {
                  //    return;
                  //}
      
                  acceptedRecord += 1;
                  newOrder.order.OrderDetails.push(orderDetail);
      
              }
      
          });
      
      
          msg = "Anda pasti ingin meluluskan jurnal ini?"
      
          if (!confirm(msg)) {
              return false;
          }
      
          var result = JSON.parse(await ajaxSaveOrderLulus(newOrder));
          alert(result.Message)
      
      
          $(".modal-body div").val("");
          $('#transaksi').modal('toggle');
      
          tbl.ajax.reload();
      
      });
      
      
      $('.btnXLulus').click(async function () {
          var jumRecord = 0;
          var acceptedRecord = 0;
          var msg = "";
          var newOrder = {
              order: {
                  OrderID: $('#lblNoJurnal').val(),
                  NoRujukan: $('#txtNoRujukan').val(),
                  Perihal: $('#txtPerihal').val(),
                  Tarikh: $('#txtTarikh').val(),
                  JenisTransaksi: $('#ddlJenTransaksi').val(),
                  JumlahDebit: $('#totalDbt').val(),
                  Jumlahkredit: $('#totalkt').val(),
                  JumlahBeza: $('#totalBeza').val(),
                  OrderDetails: []
              }
      
          }
      
      
          $('.COA-list').each(function (index, obj) {
      
              if (index > 0) {
                  var tcell = $(obj).closest("td");
                  //alert("ce;; "+tcell)
                  var orderDetail = {
                      OrderID: $('#lblNoJurnal').val(),
                      ddlVot: $(obj).dropdown("get value"),
                      ddlPTJ: $('.Hid-ptj-list').eq(index).html(),
                      ddlKw: $('.Hid-kw-list').eq(index).html(),
                      ddlKo: $('.Hid-ko-list').eq(index).html(),
                      ddlKp: $('.Hid-kp-list').eq(index).html(),
                      debit: $('.Debit').eq(index).val(),
                      kredit: $('.Kredit').eq(index).val(),
                      id: $(tcell).find(".data-id").val()
                  };
      
      
                  //console.log(orderDetail);
      
                  //if (orderDetail.ddlPTJ === "" || orderDetail.ddlVot === "" || orderDetail.ddlKw === "" || orderDetail.ddlKo === "" || orderDetail.ddlKp === "" ||
                  //    orderDetail.debit === "" ||  orderDetail.kredit === "") {
                  //    return;
                  //}
      
                  acceptedRecord += 1;
                  newOrder.order.OrderDetails.push(orderDetail);
      
              }
      
          });
      
      
          msg = "Anda pasti ingin TIDAK meluluskan jurnal ini?"
      
          if (!confirm(msg)) {
              return false;
          }
      
          var result = JSON.parse(await ajaxSaveOrderXLulus(newOrder));
          alert(result.Message)
      
      
          $(".modal-body div").val("");
          $('#transaksi').modal('toggle');
      
          tbl.ajax.reload();
      
      });
      
      $('#ddlJenInv').dropdown({
          selectOnKeydown: true,
          fullTextSearch: true,
          apiSettings: {
              url: 'Transaksi_InvoisWS.asmx/GetJenInvList?q={query}',
              method: 'POST',
              dataType: "json",
              contentType: 'application/json; charset=utf-8',
              cache: false,
              beforeSend: function (settings) {
                  // Replace {query} placeholder in data with user-entered search term
                  settings.data = JSON.stringify({ q: settings.urlData.query });
                  //searchQuery = settings.urlData.query;
                  return settings;
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
      
                  // Refresh dropdown
                  $(obj).dropdown('refresh');
      
                  if (shouldPop === true) {
                      $(obj).dropdown('show');
                  }
              }
          }
      });
      
      $('#abcddlJenInv').dropdown({
          selectOnKeydown: true,
          fullTextSearch: true,
          apiSettings: {
              url: 'Transaksi_InvoisWS.asmx/GetJenInvList?q={query}',
              method: 'POST',
              dataType: "json",
              contentType: 'application/json; charset=utf-8',
              cache: false,
              beforeSend: function (settings) {
                  // Replace {query} placeholder in data with user-entered search term
                  settings.data = JSON.stringify({ q: settings.urlData.query });
                  //searchQuery = settings.urlData.query;
                  return settings;
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
      
                  // Refresh dropdown
                  $(obj).dropdown('refresh');
      
                  if (shouldPop === true) {
                      $(obj).dropdown('show');
                  }
              }
          }
      });
      
      $('.btnSearch').click(async function () {
          isClicked = true;
          tbl.ajax.reload();
      
      })
      
      
      $('.btn-danger').click(async function () {
          //alert("test");
          //var result = JSON.parse(await ajaxDeleteOrder($('#lblNoJurnal').val()))
          $('#lblNoJurnal').val("")
          await clearAllRows();
          await clearAllRowsHdr();
          AddRow(5);
      });
      
      //$('.btnPapar').click(async function () {
      //    var record = await AjaxLoadOrderRecord_Senarai("");
      //    $('#lblNoJurnal').val("")
      //    await clearAllRows_senarai();
      //    await paparSenarai(null, record);
      //});
      
      $('.btnLoad').on('click', async function () {
          loadExistingRecords();
      });
      
      
      //async function loadKelulusanRecords() {
      //    var record = await AjaxLoadOrderRecord_Senarai("");
      //    $('#lblNoJurnal').val("")
      //    await clearAllRows_senarai();
      //    await paparSenarai(null, record);
      //}
      
      async function loadExistingRecords() {
          var record = await AjaxLoadOrderRecord($('#lblNoJurnal').val());
          await clearAllRows();
          await AddRow(null, record);
      }
      
      async function clearAllRows() {
          $(tableID + " > tbody > tr ").each(function (index, obj) {
              if (index > 0) {
                  obj.remove();
              }
          })
          $(totalDebit).val("0.00");
          $(totalKredit).val("0.00");
          $(totalID).val("0.00"); //total beza
      }
      
      async function clearAllRowsHdr() {
      
          $('#lblNoJurnal').val("");
          $('#txtNoRujukan').val("");
          $('#txtTarikh').val("");
          $('#txtPerihal').val("");
          $('#ddlJenTransaksi').empty();
      
      
      }
      
      async function clearAllRows_senarai() {
          $(tableID_Senarai + " > tbody > tr ").each(function (index, obj) {
              if (index > 0) {
                  obj.remove();
              }
          })
      }
      
      $(tableID).on('click', '.btnDelete', async function () {
          event.preventDefault();
          var curTR = $(this).closest("tr");
          var recordID = curTR.find("td > .data-id");
          var bool = true;
          var id = setDefault(recordID.val());
      
          if (id !== "") {
              bool = await DelRecord(id);
          }
      
          if (bool === true) {
              curTR.remove();
          }
      
          calculateGrandTotal();
          return false;
      })
      
      async function ajaxSubmitOrder(order) {
      
          return new Promise((resolve, reject) => {
              $.ajax({
                  url: 'Transaksi_WS.asmx/SubmitOrders',
                  method: 'POST',
                  data: JSON.stringify(order),
                  dataType: 'json',
                  contentType: 'application/json; charset=utf-8',
                  success: function (data) {
                      resolve(data.d);
                      //alert(resolve(data.d));
                  },
                  error: function (xhr, textStatus, errorThrown) {
                      console.error('Error:', errorThrown);
                      reject(false);
                  }
      
              });
          })
      
      }
      
      async function ajaxSaveOrder(order) {
      
          return new Promise((resolve, reject) => {
              $.ajax({
                  url: 'Transaksi_WS.asmx/Lulusorder',
                  method: 'POST',
                  data: JSON.stringify(order),
                  dataType: 'json',
                  contentType: 'application/json; charset=utf-8',
                  success: function (data) {
                      resolve(data.d);
                      //alert(resolve(data.d));
                  },
                  error: function (xhr, textStatus, errorThrown) {
                      console.error('Error:', errorThrown);
                      reject(false);
                  }
      
              });
          })
      
      }
      
      async function ajaxSaveOrderLulus(order) {
      
          return new Promise((resolve, reject) => {
              $.ajax({
                  url: 'Transaksi_WS.asmx/Lulusorder',
                  method: 'POST',
                  data: JSON.stringify(order),
                  dataType: 'json',
                  contentType: 'application/json; charset=utf-8',
                  success: function (data) {
                      resolve(data.d);
                      //alert(resolve(data.d));
                  },
                  error: function (xhr, textStatus, errorThrown) {
                      console.error('Error:', errorThrown);
                      reject(false);
                  }
      
              });
          })
      
      }
      
      async function ajaxSaveOrderXLulus(order) {
      
          return new Promise((resolve, reject) => {
              $.ajax({
                  url: 'Transaksi_WS.asmx/XLulusorder',
                  method: 'POST',
                  data: JSON.stringify(order),
                  dataType: 'json',
                  contentType: 'application/json; charset=utf-8',
                  success: function (data) {
                      resolve(data.d);
                      //alert(resolve(data.d));
                  },
                  error: function (xhr, textStatus, errorThrown) {
                      console.error('Error:', errorThrown);
                      reject(false);
                  }
      
              });
          })
      
      }
      
      async function ajaxDeleteOrder(id) {
          return new Promise((resolve, reject) => {
              $.ajax({
                  url: 'Transaksi_WS.asmx/DeleteOrder',
                  method: 'POST',
                  data: JSON.stringify({ id: id }),
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
      async function AjaxDelete(id) {
          return new Promise((resolve, reject) => {
              $.ajax({
                  url: 'Transaksi_WS.asmx/DeleteRecord',
                  method: 'POST',
                  data: JSON.stringify({ id: id }),
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
      
      async function AjaxLoadOrderRecord(id) {
      
          try {
              const response = await fetch('Transaksi_WS.asmx/LoadOrderRecord', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify({ id: id })
              });
              const data = await response.json();
              return JSON.parse(data.d);
          } catch (error) {
              console.error('Error:', error);
              return false;
          }
      }
      
      async function AjaxLoadOrderRecord_Senarai(id) {
      
          try {
              const response = await fetch('Transaksi_WS.asmx/LoadOrderRecord_SenaraiLulusTransaksiJurnal', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify({ id: id })
              });
      
              const data = await response.json();
              return JSON.parse(data.d);
          } catch (error) {
              console.error('Error:', error);
              return false;
          }
      }
      async function DelRecord(id) {
          var bool = false;
          var result = JSON.parse(await AjaxDelete(id));
      
          if (result.Code === "00") {
              bool = true;
          }
      
          return bool;
      }
      
      
      $(tableID).on('keyup', '.Debit , .Kredit', async function () {
      
          var curTR = $(this).closest("tr");
      
          var debit_ = $(curTR).find("td > .Debit");
          var totalDebit = NumDefault(debit_.val())
      
          var kredit_ = $(curTR).find("td > .Kredit");
          calculateGrandTotal();
      
          var totalKredit = NumDefault(kredit_.val())
          calculateGrandTotal();
      
      
      });
      
      async function calculateGrandTotal() {
      
          //debit
          var grandTotal_Dt = $(totalDebit);
      
          var curTotal_Dt = 0;
      
          $('.Debit').each(function (index, obj) {
              curTotal_Dt += parseFloat(NumDefault($(obj).val()));
          });
      
          grandTotal_Dt.val(curTotal_Dt.toFixed(2));
      
          //kredit
          var grandTotal_Kt = $(totalKredit);
          var curTotal_Kt = 0;
      
          $('.Kredit').each(function (index, obj) {
              curTotal_Kt += parseFloat(NumDefault($(obj).val()));
          });
      
          grandTotal_Kt.val(curTotal_Kt.toFixed(2));
      
          //beza
          var grandTotal_Beza = $(totalID);
          var cal = curTotal_Dt - curTotal_Kt
          grandTotal_Beza.val(cal.toFixed(2));
      
      }
      
      
      //async function calculateGrandBeza() {
      //    var grandTotal = $(totalID);
      
      //    var totalDebit = 0;
      //    var totalKredit = 0;
      
      //    var curTR = $(this).closest("tr");
      
      //    var debit_ = $(curTR).find("td > .totalDbt");
      //    var totalDebit = parseFloat(NumDefault(debit_.val()));
      
      
      //    var kredit_ = $(curTR).find("td > .totalKt");
      //    var totalKredit = parseFloat(NumDefault(kredit_.val()));
      
      //    alert("a " + totalDebit)
      //    grandTotal.val(totalDebit - totalKredit);
      
      //}
      
      function NumDefault(theVal) {
      
          return setDefault(theVal, 0)
      }
      
      function setDefault(theVal, defVal) {
      
          if (defVal === null || defVal === undefined) {
              defVal = "";
          }
      
          if (theVal === "" || theVal === undefined || theVal === null) {
              theVal = defVal;
          }
          return theVal;
      }
      
      async function initDropdownKw(id, idVot) {
      
          $('#' + id).dropdown({
              fullTextSearch: true,
              apiSettings: {
                  url: 'Transaksi_WS.asmx/GetKWList?q={query}&kodkw={kodkw}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
      
                      var kodVot = $('#' + idVot).dropdown("get value");
                      settings.urlData.kodkw = kodVot;
                      settings.data = JSON.stringify({ q: settings.urlData.query, kodkw: settings.urlData.kodkw });
                      searchQuery = settings.urlData.query;
                      return settings;
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
      
                      //if (searchQuery !== oldSearchQuery) {
                      // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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
      
      async function initDropdownKo(id, idKw) {
      
      
          $('#' + id).dropdown({
              fullTextSearch: true,
              apiSettings: {
                  url: 'Transaksi_WS.asmx/GetKoList?q={query}&kodko={kodko}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
                      var kodkw = $('#' + idKw).dropdown("get value");
                      settings.urlData.kodko = kodkw;
                      settings.data = JSON.stringify({ q: settings.urlData.query, kodko: settings.urlData.kodko });
                      searchQuery = settings.urlData.query;
                      return settings;
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
      
                      //if (searchQuery !== oldSearchQuery) {
                      // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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
      
      async function initDropdownKp(id, idKo) {
      
          $('#' + id).dropdown({
              fullTextSearch: true,
              apiSettings: {
                  url: 'Transaksi_WS.asmx/GetKpList?q={query}&kodko={kodko}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
      
                      var kodkp = $('#' + idKo).dropdown("get value");
                      settings.urlData.kodko = kodkp;
                      settings.data = JSON.stringify({ q: settings.urlData.query, kodko: settings.urlData.kodko });
                      searchQuery = settings.urlData.query;
                      return settings;
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
      
                      //if (searchQuery !== oldSearchQuery) {
                      // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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
      
      $(tableID_Senarai).on('click', '.btnView', async function () {
      
          event.preventDefault();
          var curTR = $(this).closest("tr");
          var recordID = curTR.find("td > .lblNo");
          //var bool = true;
          var id = setDefault(recordID.html());
      
      
          if (id !== "") {
      
              //BACA HEADER JURNAL
              var recordHdr = await AjaxGetRecordHdrJurnal(id);
              await AddRowHeader(null, recordHdr);
      
              //BACA DETAIL JURNAL
              var record = await AjaxGetRecordJurnal(id);
              await clearAllRows();
              await AddRow(null, record);
      
          }
      
          return false;
      })
      
      async function initDropdownVot(id, idPtj) {
      
          $('#' + id).dropdown({
              fullTextSearch: true,
              apiSettings: {
                  url: 'Transaksi_WS.asmx/GetVotList?q={query}&kodVot={kodVot}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
      
                      var kodPtj = $('#' + idPtj).dropdown("get value");
                      settings.urlData.kodVot = kodPtj;
                      settings.data = JSON.stringify({ q: settings.urlData.query, kodVot: settings.urlData.kodVot });
                      searchQuery = settings.urlData.query;
                      return settings;
      
      
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
      
                      //if (searchQuery !== oldSearchQuery) {
                      // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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
      
      async function initDropdownPtj(id) {
      
          $('#' + id).dropdown({
              fullTextSearch: true,
              apiSettings: {
                  url: 'Transaksi_WS.asmx/GetVotPTJ?q={query}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
                      settings.data = JSON.stringify({ q: settings.urlData.query });
                      searchQuery = settings.urlData.query;
                      return settings;
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
      
                      //if (searchQuery !== oldSearchQuery) {
                      // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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
      
      $('.btnAddRow').click(async function () {
          var totalClone = $(this).data("val");
      
          await AddRow(totalClone);
      });
      
      //async function AddRow(totalClone, objOrder) {
      //    var counter = 1;
      //    var table = $('#tblData');
      
      //    if (objOrder !== null && objOrder !== undefined) {
      //        //totalClone = objOrder.Payload.OrderDetails.length;
      //        totalClone = objOrder.Payload.length;
      
      //        //if (totalClone < 5) {
      //        //    totalClone = 5;
      //        //}
      //    }
      
      //    while (counter <= totalClone) {
      //        curNumObject += 1;
      //        var newId_kw = "ddlKW" + curNumObject;
      //        var newId_Ko = "ddlKo" + curNumObject;
      //        var newId_Kp = "ddlKp" + curNumObject;
      //        var newId_vot = "ddlVot" + curNumObject;
      //        var newId_ptj = "ddlPTJ" + curNumObject;
      
      //        var row = $('#tblData tbody>tr:first').clone();
      
      //        var dropdown = $(row).find(".kw-list").attr("id", newId_kw);
      //        var dropdown1 = $(row).find(".ko-list").attr("id", newId_Ko);
      //        var dropdown2 = $(row).find(".kp-list").attr("id", newId_Kp);
      //        var dropdown3 = $(row).find(".vot-list").attr("id", newId_vot);
      //        var dropdown4 = $(row).find(".ptj-list").attr("id", newId_ptj);
      
      //        row.attr("style", "");
      //        var val = "";
      
      //        $('#tblData tbody').append(row);
      
      //        await initDropdownPtj(newId_ptj)
      //        $(newId_ptj).api("query");
      
      
      //        await initDropdownVot(newId_vot, newId_ptj)
      //        $(newId_vot).api("query");
      
      //        await initDropdownKw(newId_kw, newId_vot)
      //        $(newId_kw).api("query");
      
      //        await initDropdownKo(newId_Ko, newId_kw)
      //        $(newId_Ko).api("query");
      
      //        await initDropdownKp(newId_Kp, newId_Ko)
      //        $(newId_Kp).api("query");
      
      
      //        if (objOrder !== null && objOrder !== undefined) {
      //            //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
      //            if (counter <= objOrder.Payload.length) {
      //                await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);
      //            }
      //        }
      //        counter += 1;
      //    }
      //}
      
      async function AddRow(totalClone, objOrder) {
      
          var counter = 1;
          var table = $('#tblData');
      
      
          if (objOrder !== null && objOrder !== undefined) {
              //totalClone = objOrder.Payload.OrderDetails.length;
              totalClone = objOrder.Payload.length;
      
              //if (totalClone < 5) {
              //    totalClone = 5;
              //}
          }
      
          //console.log(objOrder)
      
          while (counter <= totalClone) {
      
              console.log("totalClone " + counter + " " + totalClone)
      
              curNumObject += 1;
      
              var newId_coa = "ddlCOA" + curNumObject;
      
              var row = $('#tblData tbody>tr:first').clone();
      
              var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
      
              row.attr("style", "");
              var val = "";
      
              $('#tblData tbody').append(row);
      
              await initDropdownCOA(newId_coa)
              $(newId_coa).api("query");
      
      
      
              if (objOrder !== null && objOrder !== undefined) {
      
                  //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
                  if (counter <= objOrder.Payload.length) {
                      await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);
      
                  }
              }
      
      
              counter += 1;
          }
      }
      
      async function initDropdownCOA(id) {
      
          $('#' + id).dropdown({
              fullTextSearch: true,
              onChange: function (value, text, $selectedItem) {
      
                  //console.log($selectedItem);
      
                  var curTR = $(this).closest("tr");
      
                  var recordIDVotHd = curTR.find("td > .Hid-vot-list");
                  recordIDVotHd.html($($selectedItem).data("coltambah5"));
      
                  //var selectObj = $($selectedItem).find("td > .COA-list > select");
                  //selectObj.val($($selectedItem).data("coltambah5"));
      
      
      
                  var recordIDPtj = curTR.find("td > .label-ptj-list");
                  recordIDPtj.html($($selectedItem).data("coltambah1"));
      
                  var recordIDPtjHd = curTR.find("td > .Hid-ptj-list");
                  recordIDPtjHd.html($($selectedItem).data("coltambah5"));
      
                  var recordID_ = curTR.find("td > .label-kw-list");
                  recordID_.html($($selectedItem).data("coltambah2"));
      
                  var recordIDkwHd = curTR.find("td > .Hid-kw-list");
                  recordIDkwHd.html($($selectedItem).data("coltambah6"));
      
                  var recordID_ko = curTR.find("td > .label-ko-list");
                  recordID_ko.html($($selectedItem).data("coltambah3"));
      
                  var recordIDkoHd = curTR.find("td > .Hid-ko-list");
                  recordIDkoHd.html($($selectedItem).data("coltambah7"));
      
                  var recordID_kp = curTR.find("td > .label-kp-list");
                  recordID_kp.html($($selectedItem).data("coltambah4"));
      
                  var recordIDkpHd = curTR.find("td > .Hid-kp-list");
                  recordIDkpHd.html($($selectedItem).data("coltambah8"));
      
      
              },
              apiSettings: {
                  url: 'Transaksi_WS.asmx/GetVotCOA?q={query}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  fields: {
      
                      value: "value",      // specify which column is for data
                      name: "text",      // specify which column is for text
                      colPTJ: "colPTJ",
                      colhidptj: "colhidptj",
                      colKW: "colKW",
                      colhidkw: "colhidkw",
                      colKO: "colKO",
                      colhidko: "colhidko",
                      colKp: "colKp",
                      colhidkp: "colhidkp",
      
                  },
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
      
                      //settings.urlData.param2 = "secondvalue";
      
                      settings.data = JSON.stringify({ q: settings.urlData.query });
      
                      //searchQuery = settings.urlData.query;
      
                      return settings;
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
                          //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                          $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                      });
      
                      // Refresh dropdown
                      $(obj).dropdown('refresh');
      
                      if (shouldPop === true) {
                          $(obj).dropdown('show');
                      }
                  }
              }
      
      
      
          });
      }
      
      async function paparSenarai(totalClone, objOrder) {
          var counter = 1;
          var table = $('#tblDataSenarai');
      
          if (objOrder !== null && objOrder !== undefined) {
              totalClone = objOrder.Payload.length;
      
          }
          // console.log(objOrder)
      
          while (counter <= totalClone) {
      
      
              var row = $('#tblDataSenarai tbody>tr:first').clone();
              row.attr("style", "");
              var val = "";
      
              $('#tblDataSenarai tbody').append(row);
      
              if (objOrder !== null && objOrder !== undefined) {
      
                  if (counter <= objOrder.Payload.length) {
                      await setValueToRow(row, objOrder.Payload[counter - 1]);
                  }
              }
      
              counter += 1;
          }
      }
      
      async function initDropdownCOA_trans(id) {
      
          $('#' + id).dropdown({
              fullTextSearch: true,
      
              apiSettings: {
                  url: 'Transaksi_WS.asmx/GetVotCOA?q={query}',
                  method: 'POST',
                  dataType: "json",
                  contentType: 'application/json; charset=utf-8',
                  cache: false,
                  fields: {
      
                      value: "value",      // specify which column is for data
                      name: "text"      // specify which column is for text
      
      
                  },
                  beforeSend: function (settings) {
                      // Replace {query} placeholder in data with user-entered search term
      
                      //settings.urlData.param2 = "secondvalue";
      
                      settings.data = JSON.stringify({ q: settings.urlData.query });
      
                      //searchQuery = settings.urlData.query;
      
                      return settings;
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
                          //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                          $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                      });
      
                      // Refresh dropdown
                      $(obj).dropdown('refresh');
      
                      if (shouldPop === true) {
                          $(obj).dropdown('show');
                      }
                  }
              }
      
      
      
          });
      }
      
      
      async function setValueToRow_HdrJurnal(orderDetail) {
      
          //console.log(orderDetail)
          if (orderDetail.Kod_Status_Dok == "04") {
      
              $('.btnLulus').hide();
              $('.btnXLulus').hide();
              $('.btnAddRow').hide();
              $('.btnDelete').prop('disabled', true);
          }
          else if (orderDetail.Kod_Status_Dok == "09") {
      
              $('.btnLulus').hide();
              $('.btnXLulus').hide();
              $('.btnAddRow').hide();
              $('.btnDelete').prop('disabled', true);
          }
          else {
      
              $('.btnLulus').show();
              $('.btnXLulus').show();
              $('.btnAddRow').hide();
              $('.btnDelete').show();
          }
      
          $('#lblNoJurnal').val(orderDetail.No_Jurnal)
          $('#txtNoRujukan').val(orderDetail.No_Rujukan)
          $('#txtTarikh').val(orderDetail.Tkh_Transaksi)
          $('#txtPerihal').val(orderDetail.Butiran)
      
          var newId = $('#ddlJenTransaksi')
      
          //await initDropdownPtj(newId)
          //$(newId).api("query");
      
          var ddlJenTransaksi = $('#ddlJenTransaksi')
          var ddlSearch = $('#ddlJenTransaksi')
          var ddlText = $('#ddlJenTransaksi')
          var selectObj_JenisTransaksi = $('#ddlJenTransaksi')
          $(ddlJenTransaksi).dropdown('set selected', orderDetail.Jenis_Trans);
          selectObj_JenisTransaksi.append("<option value = '" + orderDetail.Jenis_Trans + "'>" + orderDetail.ButiranJenis + "</option>")
      }
      
      async function setValueToRow(row, orderDetail) {
      
          //console.log(orderDetail.No_Jurnal)
          var no = $(row).find("td > .lblNo");
          var no1 = $(row).find("td > .lblNo");
          var rujukan = $(row).find("td > .lblRujukan");
          var butiran = $(row).find("td > .lblButiran");
          var jumlah = $(row).find("td > .lblJumlah");
          var tarikh = $(row).find("td > .lblTkh");
      
          no.html(orderDetail.No_Jurnal);
          no1.val(orderDetail.No_Jurnal);
          rujukan.html(orderDetail.No_Rujukan);
          butiran.html(orderDetail.Butiran);
          jumlah.html(orderDetail.Jumlah);
          tarikh.html(orderDetail.Tkh_Transaksi);
      
      
      
      }
      
      async function setValueToRow_Transaksi(row, orderDetail) {
      
      
          var ddl = $(row).find("td > .COA-list");
          var ddlSearch = $(row).find("td > .COA-list > .search");
          var ddlText = $(row).find("td > .COA-list > .text");
          var selectObj = $(row).find("td > .COA-list > select");
          $(ddl).dropdown('set selected', orderDetail.Kod_Vot);
          selectObj.append("<option value = '" + orderDetail.Kod_Vot + "'>" + orderDetail.ButiranVot + "</option>")
      
      
          var butirptj = $(row).find("td > .label-ptj-list");
          butirptj.html(orderDetail.ButiranPTJ);
      
          var hidbutirptj = $(row).find("td > .Hid-ptj-list");
          hidbutirptj.html(orderDetail.colhidptj);
      
          var butirKW = $(row).find("td > .label-kw-list");
          butirKW.html(orderDetail.colKW);
      
          var hidbutirkw = $(row).find("td > .Hid-kw-list");
          hidbutirkw.html(orderDetail.colhidkw);
      
          var butirKo = $(row).find("td > .label-ko-list");
          butirKo.html(orderDetail.colKO);
      
          var hidbutirko = $(row).find("td > .Hid-ko-list");
          hidbutirko.html(orderDetail.colhidko);
      
          var butirKp = $(row).find("td > .label-kp-list");
          butirKp.html(orderDetail.colKp);
      
          var hidbutirkp = $(row).find("td > .Hid-kp-list");
          hidbutirkp.html(orderDetail.colhidkp);
      
          var debit = $(row).find("td > .Debit");
          debit.val(orderDetail.Debit);
      
          var kredit = $(row).find("td > .Kredit");
          kredit.val(orderDetail.Kredit);
      
          await calculateGrandTotal();
      
      }
      
      
      
      
      
      async function AddRowHeader(totalClone, objOrder) {
          var counter = 1;
          //var table = $('#tblDataSenarai');
      
          if (objOrder !== null && objOrder !== undefined) {
              totalClone = objOrder.Payload.length;
          }
      
      
          if (counter <= objOrder.Payload.length) {
              await setValueToRow_HdrJurnal(objOrder.Payload[counter - 1]);
          }
          // console.log(objOrder)
      }
      
      
      async function AjaxGetRecordJurnal(id) {
      
          try {
      
              const response = await fetch('Transaksi_WS.asmx/LoadRecordJurnal', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify({ id: id })
              });
              const data = await response.json();
              return JSON.parse(data.d);
          } catch (error) {
              console.error('Error:', error);
              return false;
          }
      }
      
      async function AjaxGetRecordHdrJurnal(id) {
      
          try {
      
              const response = await fetch('Transaksi_WS.asmx/LoadHdrJurnal', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify({ id: id })
              });
              const data = await response.json();
              return JSON.parse(data.d);
          } catch (error) {
              console.error('Error:', error);
              return false;
          }
      }
      
      //$(document).ready(function () {
      //    $('#tblDataSenarai').DataTable({
      //        "responsive": true,
      //        "sPaginationType": "full_numbers",
      //        "oLanguage": {
      //            "oPaginate": {
      //                "sNext": '<i class="fa fa-forward"></i>',
      //                "sPrevious": '<i class="fa fa-backward"></i>',
      //                "sFirst": '<i class="fa fa-step-backward"></i>',
      //                "sLast": '<i class="fa fa-step-forward"></i>'
      //            },
      //            "sLengthMenu": "Tunjuk _MENU_ rekod",
      //            "sZeroRecords": "Tiada rekod yang sepadan ditemui",
      //            "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
      //            "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
      //            "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
      //            "sEmptyTable": "Tiada rekod.",
      //            "sSearch": "Carian"
      //        }
      //    });
      //});
   </script>
</asp:Content>