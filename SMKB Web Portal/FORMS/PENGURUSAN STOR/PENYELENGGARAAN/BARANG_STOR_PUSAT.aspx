<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="BARANG_STOR_PUSAT.aspx.vb" Inherits="SMKB_Web_Portal.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
   <link type="text/css" rel="stylesheet" href="../../../Scripts/jquery 1.13.3/css/jquery.dataTables.min.css" />
   <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/dataTables.bootstrap.min.css" />
   <link type="text/css" rel="stylesheet" href="../../../Scripts/bootstrap 3.3.7/bootstrap.min.js" />
   <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/responsive.bootstrap.min.css" />
   <style>
      .highlight {
      background-color: orange;
      cursor: pointer; /* Set the cursor to a pointer on hover */
      }
      .has-data {
      background-color: orange;
      }
      table {
      border-collapse: collapse;
      border: 1px solid #000; /* Outside border */
      width: 100%;
      }
      table, th, td {
      border: 1px solid rgba(0, 0, 0, 0.5); /* Inside border with 50% opacity */
      }
      th, td {
      padding: 10px;
      text-align: center;
      }
   </style>
   <!-------------------------------------------------------------------  STYLE END  -------------------------------------------------------------------------->
   <!------------------------------------------------------------------  CODE START  -------------------------------------------------------------------------->
   <contenttemplate>
      <div id="PermohonanTab" class="tabcontent" style="display: block">
         <%-- DIV PENDAFTARAN INVOIS --%>
         <div id="divpendaftaraninv" runat="server" visible="true">
            <div class="modal-body">
               <div class="table-title">
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="form-row">
                        <div class="form-group col-md-7">
                           <label>Kategori</label>
                           <div class="responsive">
                              <select class="form-control input-sm ui search dropdown" name="ddlJenInv" id="ddlJenInv">
                              </select>                                            
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="form-row">
                        <div class="form-group col-md-7">
                           <label>Barang</label>
                           <div class="responsive">
                              <select class="form-control input-sm ui search dropdown" name="ddlJenByr" id="ddlJenInv">
                              </select>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="form-row">
                        <div class="form-group col-md-3">
                           <label>Takat Minima</label>
                           <input type="text" class="form-control input-sm" placeholder="Takat Minima" id="txtnoDO" name="txtnoDO" oninput="this.value = this.value.replace(/[^0-9.]/g, '');"/>
                        </div>
                        <div class="form-group col-md-3">
                           <label>Takat Maksima</label>
                           <input type="text" class="form-control input-sm" placeholder="Takat Maksima" id="txtnoDO" name="txtnoDO" oninput="this.value = this.value.replace(/[^0-9.]/g, '');"/>
                        </div>
                        <div class="form-group col-md-3">
                           <label>Takat Menokok</label>
                           <input type="text" class="form-control input-sm" placeholder="Takat Menokok" id="txtnoDO" name="txtnoDO" oninput="this.value = this.value.replace(/[^0-9.]/g, '');"/>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div class="form-group col-md-9">
         <fieldset class="form-group border" style="border-radius: 5px; margin: 35px;">
            <legend class="w-auto px-2 h6 font-weight-bold">Lokasi</legend>
            <div class="row">
               <div class="form-group col-md-1"></div>
               <div class="col-md-11">
                  <div class="form-row">
                     <div class="form-group col-md-5">
                        <label>Senarai Pilihan</label>
                        <div class="responsive">
                           <select class="form-control input-sm ui search dropdown" name="ddlJenByr" id="ddlJenByr">
                           </select>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="form-group col-md-1"></div>
               <div class="col-md-5">
                  <div class="transaction-table table-responsive" >
                     <table id="table1" style="width:95%; border: 3px solid;">
                        <tbody>
                           <tr style="height: 50px; border-bottom: 1px">
                              <td id="row1">0 test</td>
                           </tr>
                           <tr style="height: 50px; border-bottom: 1px">
                              <td id="row2">1 test</td>
                           </tr>
                           <tr style="height: 50px; border-bottom: 1px">
                              <td>2 test</td>
                           </tr>
                           <tr style="height: 50px; border-bottom: 1px">
                              <td>3 test</td>
                           </tr>
                           <tr style="height: 50px;">
                              <td>4 test</td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
               <div class="col-md-5">
                  <div class="transaction-table table-responsive" >
                     <table id="targetTable" style="width:95%; border: 3px solid;">
                        <tbody>
                           <tr style="height: 50px; border-bottom: 1px">
                              <td></td>
                           </tr>
                           <tr style="height: 50px; border-bottom: 1px">
                              <td></td>
                           </tr>
                           <tr style="height: 50px; border-bottom: 1px">
                              <td></td>
                           </tr>
                           <tr style="height: 50px; border-bottom: 1px">
                              <td></td>
                           </tr>
                           <tr style="height: 50px;">
                              <td></td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
            <div class="form-row">
               <div class="form-group col-md-2"></div>
               <div class="form-group col-md-4">
                  <label>(Klik 2 Kali Untuk Tambah Ke Senarai)</label>
               </div>
               <div class="form-group col-md-1"></div>
               <div class="form-group col-md-5">
                  <label>(Klik 2 Kali Untuk Hapus Dari Senarai)</label>
               </div>
            </div>
         </fieldset>
      </div>
      <div class="form-group" style="border-radius: 5px; margin: 35px;">
         <table id="spekfikasi-table" class="table table-striped" border="1" width="75%">
            <thead>
               <tr style="background-color:#FFC83D">
                  <th style="width:3%">Bil.</th>
                  <th style="width:35%;text-align:center">Barang</th>
                  <th style="width:15%;text-align:center"">Lokasi</th>
                  <th style="width:15%;text-align:center">Takat Minima</th>
                  <th style="width:15%;text-align:center"">Takat Maksima</th>
                  <th style="width:15%;text-align:center">Takat Menokok</th>
               </tr>
            </thead>
            <tbody>
            </tbody>
         </table>
      </div>
      <br />
      <!------------------------------------------------------------------  CODE END    -------------------------------------------------------------------------->
      <!------------------------------------------------------------------- SCRIPT START ------------------------------------------------------------------------->
      <script type="text/javascript"> 
          // <==========================================SCRIPT TUKAR PAGE START========================================>
          function ShowPopup(elm) {
              // Memeriksa nilai parameter elm untuk menentukan tindakan yang sesuai.

              if (elm == "1") {
                  // Jika elm sama dengan "1", tampilkan modal '#permohonan'.
                  $('#permohonan').modal('toggle');
              } else if (elm == "2") {
                  // Jika elm sama dengan "2", kosongkan nilai input dalam modal dan tampilkan modal '#permohonan'.
                  $(".modal-body div").val("");
                  $('#permohonan').modal('toggle');
              }
          }
          // <==========================================SCRIPT TUKAR PAGE END==========================================>

          //  <---------------------------------- DATA TABLE KE TABLE ---------------------------------------->
          document.addEventListener('DOMContentLoaded', function () {
              // Get all rows from table1
              var rowsTable1 = document.getElementById('table1').getElementsByTagName('tbody')[0].getElementsByTagName('tr');

              // Get targetTable
              var targetTable = document.getElementById('targetTable').getElementsByTagName('tbody')[0];

              var currentTargetRowIndex = 0;

              // Add event listeners to each row in table1
              for (var i = 0; i < rowsTable1.length; i++) {
                  rowsTable1[i].addEventListener('mouseover', function () {
                      // Highlight the row on hover
                      this.classList.add('highlight');
                  });

                  rowsTable1[i].addEventListener('mouseout', function () {
                      // Remove the highlight on mouseout
                      this.classList.remove('highlight');
                  });

                  rowsTable1[i].addEventListener('dblclick', function () {
                      // Check if the content has already been transferred
                      if (!this.classList.contains('transferred')) {
                          // Get the content of the clicked row
                          var content = this.innerText;

                          // Find the first empty row in targetTable
                          var emptyRowIndex = findEmptyRow(targetTable);

                          // Fill the content in the first empty row
                          targetTable.rows[emptyRowIndex].cells[0].innerText = content;

                          // Mark the row as transferred
                          this.classList.add('transferred');

                          // Remove highlight from the previously selected row
                          var highlightedRow = document.querySelector('.highlight');
                          if (highlightedRow) {
                              highlightedRow.classList.remove('highlight');
                          }
                      }
                  });
              }

              // Add event listeners to each row in targetTable
              var rowsTargetTable = targetTable.getElementsByTagName('tr');
              for (var j = 0; j < rowsTargetTable.length; j++) {
                  rowsTargetTable[j].addEventListener('mouseover', function () {
                      // Highlight the row on hover if there's data
                      if (this.cells[0].innerText.trim() !== '') {
                          this.classList.add('highlight');
                      }
                  });

                  rowsTargetTable[j].addEventListener('mouseout', function () {
                      // Remove the highlight on mouseout
                      this.classList.remove('highlight');
                  });

                  rowsTargetTable[j].addEventListener('dblclick', function () {
                      // Clear the content when double-clicked
                      this.cells[0].innerText = '';

                      // Remove the transferred class to allow transfer again
                      var transferredRow = document.querySelector('.transferred');
                      if (transferredRow) {
                          transferredRow.classList.remove('transferred');
                      }

                      // Remove highlight from the previously selected row
                      var highlightedRow = document.querySelector('.highlight');
                      if (highlightedRow) {
                          highlightedRow.classList.remove('highlight');
                      }

                      // Move up the contents in subsequent rows
                      for (var k = this.rowIndex; k < targetTable.rows.length - 1; k++) {
                          targetTable.rows[k].cells[0].innerText = targetTable.rows[k + 1].cells[0].innerText;
                      }

                      // Clear the content in the last row
                      targetTable.rows[targetTable.rows.length - 1].cells[0].innerText = '';
                  });
              }

              // Function to find the index of the first empty row in a table
              function findEmptyRow(table) {
                  for (var rowIndex = 0; rowIndex < table.rows.length; rowIndex++) {
                      if (table.rows[rowIndex].cells[0].innerText.trim() === '') {
                          return rowIndex;
                      }
                  }
                  return 0; // Return 0 if no empty row is found
              }
          });
          //   <---------------------------------- DATA TABLE KE TABLE ---------------------------------------->


          // Add rows dynamically using JavaScript, for example:
          var tableBody = document.getElementById("tblDataSenarai").getElementsByTagName('tbody')[0];

          // Example row
          var newRow = tableBody.insertRow();
          var cell1 = newRow.insertCell(0);
          cell1.innerHTML = ""; // Content for the celln>

          //Take the category filter drop down and append it to the datatables_filter div. 
          //You can use this same idea to move the filter anywhere withing the datatable that you want.
          $("#tblDataSenarai_trans_filter.dataTables_filter").append($("#categoryFilter"));


          var tbl = null
          $(document).ready(function () {
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
                      "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                      "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                      "sEmptyTable": "Tiada rekod.",
                      "sSearch": "Carian"
                  },
                  "ajax": {
                      "url": "Transaksi_InvoisWS.asmx/LoadOrderRecord_SenaraiTransaksiInvois",
                      method: 'POST',
                      "contentType": "application/json; charset=utf-8",
                      "dataType": "json",
                      "dataSrc": function (json) {
                          return JSON.parse(json.d);
                      }

                  },
                  "columns": [
                      {
                          "data": "ID_Rujukan",
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
                      { "data": "NamaPemiutang" },
                      { "data": "Tarikh_Invois" },
                      { "data": "Tarikh_Terima_Invois" },
                      { "data": "JenisInv" },
                      { "data": "ButirByr" },
                      { "data": "Tujuan" },
                      { "data": "Jumlah_Sebenar" },
                      {
                          className: "btnView",
                          "data": "ID_Rujukan",
                          render: function (data, type, row, meta) {

                              if (type !== "display") {

                                  return data;

                              }

                              var link = `<button id="btnView" runat="server" class="btn btnView" type="button" style="color: blue" data-dismiss="modal">
                                             <i class="fa fa-edit"></i>
                                 </button>`;
                              return link;
                          }
                      }
                  ]

              });


              //Get the column index for the Category column to be used in the method below ($.fn.dataTable.ext.search.push)
              //This tells datatables what column to filter on when a user selects a value from the dropdown.
              //It's important that the text used here (Category) is the same for used in the header of the column to filter
              var categoryIndex = 0;
              $("#tblDataSenarai_trans th").each(function (i) {
                  if ($($(this)).html() == "Tarikh Terima") {
                      categoryIndex = i; return false;
                  }
              });


              //Use the built in datatables API to filter the existing rows by the Category column
              $.fn.dataTable.ext.search.push(
                  function (settings, data, dataIndex) {
                      var selectedItem = $('#categoryFilter').val()
                      if (selectedItem == "1") {
                          selectedItem = moment().format('DD-MM-YYYY');
                          // $('#txtTarikhStart').attr('readonly', true);
                          // $('#txtTarikhEnd').attr('readonly', true);

                          $('#txtTarikhStart').hide();
                          $('#txtTarikhEnd').hide();

                          $('#txtTarikhStart').val("")
                          $('#txtTarikhEnd').val("")

                          $('#lblMula').hide();
                          $('#lblTamat').hide();


                      }

                      else if (selectedItem == "2") {
                          selectedItem = moment().subtract(1, "days").format('DD-MM-YYYY');

                          $('#txtTarikhStart').hide();
                          $('#txtTarikhEnd').hide();

                          $('#txtTarikhStart').val("")
                          $('#txtTarikhEnd').val("")

                          $('#lblMula').hide();
                          $('#lblTamat').hide();
                      }

                      else if (selectedItem == "3") {
                          var min = moment().subtract(6, "days").format('DD-MM-YYYY');
                          var max = moment().format('DD-MM-YYYY');

                          var createdAt = data[categoryIndex]; // Our date column in the table
                          // selectedItem = moment().format('DD-MM-YYYY');


                          if (
                              (min <= createdAt && createdAt <= max)
                          ) {
                              return true;
                          }
                          return false;



                          $('#txtTarikhStart').hide();
                          $('#txtTarikhEnd').hide();

                          $('#txtTarikhStart').val("")
                          $('#txtTarikhEnd').val("")

                          $('#lblMula').hide();
                          $('#lblTamat').hide();

                          //var createdAt = data[categoryIndex]; // Our date column in the table
                          //// selectedItem = moment().format('DD-MM-YYYY');


                          //if (
                          //    (min === null && max === null) ||
                          //    (min === null && createdAt <= max) ||
                          //    (min <= createdAt && max === null) ||
                          //    (min <= createdAt && createdAt <= max)
                          //) {
                          //    return true;
                          //}
                          //return false;

                      }

                      else if (selectedItem == "4") {
                          var min = moment().subtract(29, "days").format('DD-MM-YYYY');
                          var max = moment().format('DD-MM-YYYY');


                          var createdAt = data[categoryIndex]; // Our date column in the table
                          // selectedItem = moment().format('DD-MM-YYYY');

                          if ((min <= createdAt && createdAt <= max)) {
                              return true;
                          }
                          return false;

                          $('#txtTarikhStart').hide();
                          $('#txtTarikhEnd').hide();

                          $('#txtTarikhStart').val("")
                          $('#txtTarikhEnd').val("")

                          $('#lblMula').hide();
                          $('#lblTamat').hide();
                      }

                      else if (selectedItem == "5") {
                          var min = moment().subtract(59, "days").format('DD-MM-YYYY');
                          var max = moment().format('DD-MM-YYYY');

                          var createdAt = data[categoryIndex]; // Our date column in the table
                          // selectedItem = moment().format('DD-MM-YYYY');


                          if (
                              (min === null && max === null) ||
                              (min === null && createdAt <= max) ||
                              (min <= createdAt && max === null) ||
                              (min <= createdAt && createdAt <= max)
                          ) {
                              return true;
                          }
                          return false;

                          $('#txtTarikhStart').hide();
                          $('#txtTarikhEnd').hide();

                          $('#txtTarikhStart').val("")
                          $('#txtTarikhEnd').val("")

                          $('#lblMula').hide();
                          $('#lblTamat').hide();
                      }

                      else if (selectedItem == "6") {


                          if (($('#txtTarikhStart').val() != "") || ($('#txtTarikhEnd').val() != "")) {


                              var min = new Date($('#txtTarikhStart').val());
                              var max = new Date($('#txtTarikhEnd').val());

                              min = ("0" + min.getDate()).slice(-2) + "-" + ("0" + (min.getMonth() + 1)).slice(-2) + "-" + min.getFullYear();
                              max = ("0" + max.getDate()).slice(-2) + "-" + ("0" + (max.getMonth() + 1)).slice(-2) + "-" + max.getFullYear();



                              var createdAt = data[categoryIndex]; // Our date column in the table
                              // selectedItem = moment().format('DD-MM-YYYY');


                              if (
                                  (min === null && max === null) ||
                                  (min === null && createdAt <= max) ||
                                  (min <= createdAt && max === null) ||
                                  (min <= createdAt && createdAt <= max)
                              ) {
                                  return true;
                              }
                              return false;



                          }
                          else {
                              $('#txtTarikhStart').show();
                              $('#txtTarikhEnd').show();

                              $('#txtTarikhStart').val("")
                              $('#txtTarikhEnd').val("")

                              $('#lblMula').show();
                              $('#lblTamat').show();
                          }


                      }

                      if (selectedItem != "6") {
                          var category = data[categoryIndex];

                          if (selectedItem === "" || category.includes(selectedItem)) {
                              return true;
                          }
                          return false;
                      }
                  }
              );

              //Set the change event for the Category Filter dropdown to redraw the datatable each time
              //a user selects a new filter.
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

              //// Re-draw the table when the a date range filter changes
              //$('.date-range-filter').change(function (e) {
              //    tbl.draw();
              //});

              // Refilter the table
              $('#btnSearch').click(function (e) {
                  tbl.draw();
              });

              //tbl.draw();

          });

          $('.btnSearch').click(async function () {

              var startDate = $('#txtTarikhStart').val()
              var endDate = $('#txtTarikhEnd').val()
              tbl.draw();

          })

          $('.btnPapar').click(async function () {
              tbl.ajax.reload();
          });

          var searchQuery = "";
          var oldSearchQuery = "";
          var curNumObject = 0;
          var tableID = "#tblData";
          var shouldPop = true;
          var totalID = "#total";
          var totalCukai = "#TotalTax";
          var totalDiskaun = "#TotalDiskaun";
          var totalwoCukai = "#totalwoCukai";
          var tableID_Senarai = "#tblDataSenarai_trans";

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

          $(function () {
              $('.btnAddRow.five').click();
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

          $('#ddlJenByr').dropdown({
              selectOnKeydown: true,
              fullTextSearch: true,
              apiSettings: {
                  url: 'Transaksi_InvoisWS.asmx/GetJenByrList?q={query}',
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

          $('#ddlPemiutang').dropdown({
              selectOnKeydown: true,
              fullTextSearch: true,
              apiSettings: {
                  url: 'Transaksi_InvoisWS.asmx/GetPemiutangList?q={query}',
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

          $('#ddlUrusniaga').dropdown({
              fullTextSearch: true,
              apiSettings: {
                  url: 'Transaksi_InvoisWS.asmx/GetUrusniagaList?q={query}',
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

          $('.btnSimpan').click(async function () {

              msg = "Anda pasti ingin menyimpan rekod ini?"

              show_message(msg, function () {
                  beginSave();
              });
          });

          // Fungsi async untuk memulakan penyimpanan data
          async function beginSave() {
              // Inisialisasi jumlah rekod dan jumlah rekod yang diterima
              var jumRecord = 0;
              var acceptedRecord = 0;
              var msg = "";

              // Pembentukan objek baru untuk pesanan
              var newOrder = {
                  order: {
                      OrderID: $('#txtidinv').val(),
                      JenisInvois: $('#ddlJenInv').val(),
                      JenisBayar: $('#ddlJenByr').val(),
                      NoInvois: $('#txtnoinv').val(),
                      TkhInvois: $('#tkhInv').val(),
                      TkhTerimaInvois: $('#tkhTerimaInv').val(),
                      NoDO: $('#txtnoDO').val(),
                      TkhDO: $('#tkhDO').val(),
                      TkhTerimaDO: $('#tkhTerimaDO').val(),
                      BayarKepada: $('#ddlPemiutang').val(),
                      Bil: $('#hdbyrid').val(),
                      Tujuan: $('#txtTujuan').val(),
                      Jumlah: $('#total').val(),
                      OrderDetails: []
                  }
              }

              // Loop melalui setiap elemen dengan kelas 'vot-carian-list'
              $('.vot-carian-list').each(function (index, obj) {
                  // Semak jika indeks lebih besar daripada 0
                  if (index > 0) {
                      // Dapatkan sel yang paling dekat
                      var tcell = $(obj).closest("td");

                      // Bentuk objek baru untuk butiran pesanan
                      var POrderDetail = {
                          OrderID: $('#txtidinv').val(),
                          ddlVot: $(obj).dropdown("get value"),
                          ddlPTJ: $('.Hid-ptj-list').eq(index).html(),
                          ddlKw: $('.Hid-kw-list').eq(index).html(),
                          ddlKo: $('.Hid-ko-list').eq(index).html(),
                          ddlKp: $('.Hid-kp-list').eq(index).html(),
                          details: $('.details').eq(index).val(),
                          quantity: $('.quantity').eq(index).val(),
                          price: $('.price').eq(index).val(),
                          Diskaun: $('.diskaun').eq(index).val(),
                          Cukai: $('.cukai').eq(index).val(),
                          amount: $('.amount').eq(index).val(),
                          id: $(tcell).find(".data-id").val()
                      };

                      // Log butiran pesanan ke konsol
                      console.log(POrderDetail);

                      // Semak jika nilai tertentu adalah kosong
                      if (POrderDetail.ddlVot === "" || POrderDetail.details === "" ||
                          POrderDetail.quantity === "" || POrderDetail.price === "") {
                          return;
                      }

                      // Tambahkan rekod yang diterima ke dalam objek pesanan
                      acceptedRecord += 1;
                      newOrder.order.OrderDetails.push(POrderDetail);
                  }
              });

              // Panggil fungsi penyimpanan AJAX dan teruskan objek pesanan
              var result = JSON.parse(await ajaxSaveOrder(newOrder));
              var result2 = await ajaxSaveOrder(newOrder);
              result2 = JSON.parse(result2);

              // Tampilkan mesej hasil penyimpanan
              show_message(result2.Message, function () {
                  console.log("test");
              });

              // Set mesej untuk div notifikasi
              $("#notify").html("Maklumat Telah Berjaya Disimpan");
              $("#NotifyModal").modal('show');

              // Bersihkan semua baris dalam header
              await clearAllRowsHdr();

              // Bersihkan semua baris dalam setiap elemen
              await clearAllRows();

              // Bersihkan butang tersembunyi
              await clearHiddenButton();

              // Tambahkan baris baru dengan nombor tertentu
              AddRow(5);
          }

          function show_message(msg, okfn, cancelfn) {

              $("#MessageModal .modal-body").text(msg);

              $('.btnYA').click(function () {
                  if (okfn !== null && okfn !== undefined) {
                      okfn();
                  }
              });

              //$('.btnTidak').click(function () {
              //    $("#notify").html("Maklumat Tidak Berjaya Disimpan");
              //    $("#NotifyModal").modal('show');
              //});

              //$("#MessageModal").modal('show');               
          }

          $('.btnHantar').click(async function () {

              var jumRecord = 0;
              var acceptedRecord = 0;
              var msg = "";
              var newOrder = {
                  order: {
                      OrderID: $('#txtidinv').val(),
                      JenisInvois: $('#ddlJenInv').val(),
                      JenisBayar: $('#ddlJenByr').val(),
                      NoInvois: $('#txtnoinv').val(),
                      TkhInvois: $('#tkhInv').val(),
                      TkhTerimaInvois: $('#tkhTerimaInv').val(),
                      NoDO: $('#txtnoDO').val(),
                      TkhDO: $('#tkhDO').val(),
                      TkhTerimaDO: $('#tkhTerimaDO').val(),
                      BayarKepada: $('#ddlPemiutang').val(),
                      Bil: $('#hdbyrid').val(),
                      Tujuan: $('#txtTujuan').val(),
                      Jumlah: $('#total').val(),
                      OrderDetails: []
                  }
              }

              $('.vot-carian-list').each(function (index, obj) {
                  if (index > 0) {
                      var tcell = $(obj).closest("td");
                      var POrderDetail = {
                          OrderID: $('#txtidinv').val(),
                          ddlVot: $(obj).dropdown("get value"),
                          ddlPTJ: $('.Hid-ptj-list').eq(index).html(),
                          ddlKw: $('.Hid-kw-list').eq(index).html(),
                          ddlKo: $('.Hid-ko-list').eq(index).html(),
                          ddlKp: $('.Hid-kp-list').eq(index).html(),
                          details: $('.details').eq(index).val(),
                          quantity: $('.quantity').eq(index).val(),
                          price: $('.price').eq(index).val(),
                          Diskaun: $('.diskaun').eq(index).val(),
                          Cukai: $('.cukai').eq(index).val(),
                          amount: $('.amount').eq(index).val(),
                          id: $(tcell).find(".data-id").val()
                      };
                      console.log(POrderDetail);

                      if (POrderDetail.ddlVot === "" || POrderDetail.details === "" ||
                          POrderDetail.quantity === "" || POrderDetail.price === "") {
                          return;
                      }

                      acceptedRecord += 1;
                      newOrder.order.OrderDetails.push(POrderDetail);
                  }
              });

              msg = "Anda pasti ingin menghantar " + acceptedRecord + " rekod ini?"

              $("#MessageModal .modal-body").text(msg);
              $("#MessageModal").modal('show');

              var result = JSON.parse(await ajaxSubmitOrder(newOrder));
              alert(result.Message);
              await clearAllRowsHdr();
              await clearAllRows();
              await clearHiddenButton();
              AddRow(5);

          });

          $('.btnReset').click(async function () {
              await clearAllRowsHdr();
              await clearAllRows();
              await clearHiddenButton();
              AddRow(5);
          });

          $('.btnDelete').click(async function () {
              var result = JSON.parse(await ajaxDeleteOrder($('#txtidinv').val()))
              alert(result.Message);
              $('#txtidinv').val("")
              await clearAllRows();
              AddRow(5);
          });

          $('.btnLoad').on('click', async function () {
              loadExistingRecords();
          });

          async function loadExistingRecords() {
              var record = await AjaxLoadOrderRecord($('#txtidinv').val());
              await clearAllRows();
              await AddRow(null, record);
          }

          async function clearAllRowsHdr() {
              $('#txtidinv').val("");
              $('#ddlJenInv').children().remove().end();
              $('#ddlJenByr').children().remove().end();
              $('#txtnoinv').val("");
              $('#tkhInv').val("");
              $("#tkhTerimaInv").val("");
              $("#tkhNoDO").val("");
              $("#tkhDO").val("");
              $("#tkhTerimaDO").val("");
              $('#ddlPemiutang').children().remove().end();
              $('.text').empty();
              $('#hdbyrid').val("");
              $('#txtTujuan').val("");

          }

          async function clearAllRows() {
              $(tableID + " > tbody > tr ").each(function (index, obj) {
                  if (index > 0) {
                      obj.remove();
                  }
              })
              $(totalID).val("0.00");

          }

          async function clearHiddenButton() {

              $('.btnSimpan').show();
              $('.btnHantar').show();
              $('.btnAddRow').show();

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

          async function ajaxSaveOrder(order) {
              return new Promise((resolve, reject) => {
                  $.ajax({

                      url: 'Transaksi_InvoisWS.asmx/SaveOrders',
                      method: 'POST',
                      data: JSON.stringify(order),
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
              })
              console.log("tst")
          }
          async function ajaxSubmitOrder(order) {

              return new Promise((resolve, reject) => {
                  $.ajax({

                      url: 'Transaksi_InvoisWS.asmx/SubmitOrders',
                      method: 'POST',
                      data: JSON.stringify(order),
                      dataType: 'json',
                      contentType: 'application/json; charset=utf-8',
                      success: function (data) {
                          resolve(data.d);
                          $("#MessageModal").modal('show');
                      },
                      error: function (xhr, textStatus, errorThrown) {
                          console.error('Error:', errorThrown);
                          reject(false);
                      }
                  });
              })
              console.log("tst")
          }
          async function ajaxDeleteOrder(id) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'Transaksi_InvoisWS.asmx/DeleteOrder',
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
                      url: 'Transaksi_InvoisWS.asmx/DeleteRecord',
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
                  const response = await fetch('Transaksi_InvoisWS.asmx/LoadOrderRecord', {
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

          $(tableID).on('keyup', '.quantity, .price, .amount, .diskaun, .cukai', async function () {
              var curTR = $(this).closest("tr");
              var quantity = $(curTR).find("td > .quantity");
              var price = $(curTR).find("td > .price");
              var amount = $(curTR).find("td > .amount");
              var cukai = $(curTR).find("td > .cukai");
              var JUMcukai = $(curTR).find("td > .JUMcukai");
              var diskaun = $(curTR).find("td > .diskaun");
              var JUMdiskaun = $(curTR).find("td > .JUMdiskaun");
              var amountwocukai = $(curTR).find("td > .amountwocukai");

              var totalPrice = NumDefault(quantity.val()) * NumDefault(price.val())
              var amauncukai = NumDefault(cukai.val()) / 100
              var total_cukai = totalPrice * amauncukai
              var amaundiskaun = NumDefault(diskaun.val()) / 100
              var total_diskaun = totalPrice * amaundiskaun
              var amountxcukai = totalPrice - total_diskaun
              //alert(amaundiskaun)
              totalPrice = totalPrice + total_cukai - total_diskaun
              amount.val(totalPrice.toFixed(2));
              JUMcukai.val(total_cukai.toFixed(2));
              JUMdiskaun.val(total_diskaun.toFixed(2));
              amountwocukai.val(amountxcukai.toFixed(2));
              calculateGrandTotal();
          });
          $(tableID).ready(function () {
              $(".price").change(function () {
                  $(this).val(parseFloat($(this).val()).toFixed(2));
              });
              $(".cukai").change(function () {
                  $(this).val(parseFloat($(this).val()).toFixed(2));
              });
              $(".diskaun").change(function () {
                  $(this).val(parseFloat($(this).val()).toFixed(2));
              });
          });
          async function calculateGrandTotal() {
              var grandTotal = $(totalID);
              var totalCukai_ = $(totalCukai);
              var totalDiskaun_ = $(totalDiskaun);
              var totalwoCukai_ = $(totalwoCukai);
              var curTotal = 0;
              var curCukai = 0;
              var curDiskaun = 0;
              var curwoCukai = 0;


              $('.amount').each(function (index, obj) {
                  curTotal += parseFloat(NumDefault($(obj).val()));
              });
              $('.JUMcukai').each(function (index, obj) {
                  curCukai += parseFloat(NumDefault($(obj).val()));
              });

              $('.JUMdiskaun').each(function (index, obj) {
                  curDiskaun += parseFloat(NumDefault($(obj).val()));
              });

              $('.amountwocukai').each(function (index, obj) {
                  curwoCukai += parseFloat(NumDefault($(obj).val()));
              });

              //$("[id*=TotalCoreProd]").html(TotalCoreProd.toFixed(2));
              totalCukai_.val(curCukai.toFixed(2));
              totalDiskaun_.val(curDiskaun.toFixed(2));
              totalwoCukai_.val(curwoCukai.toFixed(2));
              grandTotal.val(curTotal.toFixed(2));
          }

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


          async function initVot(id, idptj) {
              $('#' + id).dropdown({
                  fullTextSearch: true,
                  apiSettings: {
                      url: 'Transaksi_InvoisWS.asmx/GetVotList?q={query}&kodptj={kodptj}',
                      method: 'POST',
                      dataType: "json",
                      contentType: 'application/json; charset=utf-8',
                      cache: false,
                      beforeSend: function (settings) {
                          // Replace {query} placeholder in data with user-entered search term
                          var ptjID = $('#' + idptj).dropdown("get value");
                          //console.log(votID);
                          settings.urlData.kodptj = ptjID;
                          settings.data = JSON.stringify({ q: settings.urlData.query, kodptj: settings.urlData.kodptj });

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
          }

          async function initKW(id, idVot) {
              $('#' + id).dropdown({
                  fullTextSearch: true,
                  apiSettings: {
                      url: 'Transaksi_InvoisWS.asmx/GetKWList?q={query}&kodvot={kodvot}',
                      method: 'POST',
                      dataType: "json",
                      contentType: 'application/json; charset=utf-8',
                      cache: false,
                      beforeSend: function (settings) {
                          // Replace {query} placeholder in data with user-entered search term
                          var votID = $('#' + idVot).dropdown("get value");
                          settings.urlData.kodvot = votID;
                          settings.data = JSON.stringify({ q: settings.urlData.query, kodvot: settings.urlData.kodvot });

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
          }

          async function initKO(id, idKW) {
              $('#' + id).dropdown({
                  fullTextSearch: true,
                  apiSettings: {
                      url: 'Transaksi_InvoisWS.asmx/GetKOList?q={query}&kodkw={kodkw}',
                      method: 'POST',
                      dataType: "json",
                      contentType: 'application/json; charset=utf-8',
                      cache: false,
                      beforeSend: function (settings) {
                          // Replace {query} placeholder in data with user-entered search term
                          var KOID = $('#' + idKW).dropdown("get value");
                          settings.urlData.kodkw = KOID;
                          settings.data = JSON.stringify({ q: settings.urlData.query, kodkw: settings.urlData.kodkw });

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
          }

          async function initKP(id, idPTJ, idVot) {
              $('#' + id).dropdown({
                  fullTextSearch: true,
                  apiSettings: {
                      url: 'Transaksi_InvoisWS.asmx/GetProjekList?q={query}&kodptj={kodptj}&kodvot={kodvot}',
                      method: 'POST',
                      dataType: "json",
                      contentType: 'application/json; charset=utf-8',
                      cache: false,
                      beforeSend: function (settings) {
                          // Replace {query} placeholder in data with user-entered search term
                          var ptjID = $('#' + idPTJ).dropdown("get value");
                          var VotID = $('#' + idVot).dropdown("get value");
                          settings.urlData.kodptj = ptjID;
                          settings.urlData.kodvot = VotID;
                          settings.data = JSON.stringify({ q: settings.urlData.query, kodptj: settings.urlData.kodptj, kodvot: settings.urlData.kodvot });

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
          }

          $('.btnAddRow').click(async function () {
              var totalClone = $(this).data("val");

              await AddRow(totalClone);
          });

          $(tableID_Senarai).on('click', 'btnView', async function () {

              event.preventDefault();
              var curTR = $(this).closest("tr");
              var recordID = curTR.find("td > .lblNo");
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

          async function AddRowHeader(totalClone, objOrder) {
              var counter = 1;

              if (objOrder !== null && objOrder !== undefined) {
                  totalClone = objOrder.Payload.length;
              }

              if (counter <= objOrder.Payload.length) {
                  await setValueToRow_HdrJurnal(objOrder.Payload[counter - 1]);
              }
              // console.log(objOrder)
          }

          async function setValueToRow_HdrJurnal(POrderDetail) {

              $('#hdbyrid').val(POrderDetail.BilPemiutang)
              $('#txtidinv').val(POrderDetail.ID_Rujukan)
              $('#txtnoinv').val(POrderDetail.No_Invois)
              $('#tkhInv').val(POrderDetail.Tarikh_Invois)
              $('#tkhTerimaInv').val(POrderDetail.Tarikh_Terima_Invois)
              $('#txtnoDO').val(POrderDetail.No_DO)
              $('#tkhDO').val(POrderDetail.Tarikh_DO)
              $('#tkhTerimaDO').val(POrderDetail.Tarikh_Terima_DO)
              $('#txtTujuan').val(POrderDetail.Tujuan)

              var ddlJenInv = $('#ddlJenInv')
              var ddlSearchI = $('#ddlJenInv')
              var ddlTextI = $('#ddlJenInv')
              var selectObj_ddlJenInv = $('#ddlJenInv')
              $(ddlJenInv).dropdown('set selected', POrderDetail.Jenis_Invois);
              selectObj_ddlJenInv.append("<option value = '" + POrderDetail.Jenis_Invois + "'>" + POrderDetail.JenisInv + "</option>")

              var ddlJenByr = $('#ddlJenByr')
              var ddlSearch = $('#ddlJenByr')
              var ddlText = $('#ddlJenByr')
              var selectObj_ddlJenByr = $('#ddlJenByr')
              $(ddlJenByr).dropdown('set selected', POrderDetail.Jenis_Bayar);
              selectObj_ddlJenByr.append("<option value = '" + POrderDetail.Jenis_Bayar + "'>" + POrderDetail.ButirByr + "</option>")

              var ddlPemiutang = $('#ddlPemiutang')
              var ddlSearchP = $('#ddlPemiutang')
              var ddlTextP = $('#ddlPemiutang')
              var selectObj_ddlPemiutang = $('#ddlPemiutang')
              $(ddlPemiutang).dropdown('set selected', POrderDetail.KodPemiutang);
              ddlPemiutang.append("<option value = '" + POrderDetail.KodPemiutang + "'>" + POrderDetail.NamaPemiutang + "</option>")
          }

          async function AjaxGetRecordHdrJurnal(id) {

              try {

                  const response = await fetch('Transaksi_InvoisWS.asmx/LoadHdrInvois', {
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

          async function AjaxGetRecordJurnal(id) {

              try {

                  const response = await fetch('Transaksi_InvoisWS.asmx/LoadRecordInvois', {
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

          async function AddRow(totalClone, objOrder) {
              var counter = 1;
              var table = $('#tblData');

              if (objOrder !== null && objOrder !== undefined) {
                  //totalClone = objOrder.Payload.OrderDetails.length;
                  totalClone = objOrder.Payload.length;
                  //console.log(totalClone)
                  //if (totalClone < 5) {
                  //    totalClone = 5;
                  //}
              }

              while (counter <= totalClone) {
                  curNumObject += 1;
                  var newCarianVot = "ddlVotCarian" + curNumObject;

                  var row = $('#tblData tbody>tr:first').clone();
                  var votcarianlist = $(row).find(".vot-carian-list").attr("id", newCarianVot);

                  row.attr("style", "");
                  var val = "";

                  $('#tblData tbody').append(row);


                  await initCarianVot(newCarianVot)

                  //$(newId).api("query");
                  //(newVotID).api("query");
                  //$(newKwID).api("query");
                  //(newKOID).api("query");
                  //$(newKPID).api("query");
                  $(newCarianVot).api("query");

                  if (objOrder !== null && objOrder !== undefined) {
                      //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
                      if (counter <= objOrder.Payload.length) {
                          await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);

                      }
                  }
                  counter += 1;
              }
          }

          async function setValueToRow_Transaksi(row, orderDetail) {

              //console.log(orderDetail)
              var ddl = $(row).find("td > .vot-carian-list");
              var ddlSearch = $(row).find("td > .vot-carian-list > .search");
              var ddlText = $(row).find("td > .vot-carian-list > .text");
              var selectObj = $(row).find("td > .vot-carian-list > select");
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

              var details = $(row).find("td > .details");
              details.val(orderDetail.Butiran);

              var quantity = $(row).find("td > .quantity");
              quantity.val(orderDetail.Kuantiti_Sebenar);
              //console.log(orderDetail)
              var cukai = $(row).find("td > .cukai");
              cukai.val(orderDetail.Cukai.toFixed(2));

              var kdr_hrga = $(row).find("td > .price");
              kdr_hrga.val(orderDetail.Kadar_Harga.toFixed(2));

              var diskaun = $(row).find("td > .diskaun");
              diskaun.val(orderDetail.Diskaun.toFixed(2));

              var amount = $(row).find("td > .amount");
              r = orderDetail.Amaun_Sebenar.toFixed(2);
              q = addCommas(r);
              amount.val(q);

              var hddataid = $(row).find("td > .data-id");
              hddataid.val(orderDetail.dataid)
              //var quantity = $(curTR).find("td > .quantity");
              //var price = $(curTR).find("td > .price");
              //var amount = $(curTR).find("td > .amount");
              //var cukai = $(curTR).find("td > .cukai");
              var JUMcukai = $(row).find("td > .JUMcukai");
              //var diskaun = $(curTR).find("td > .diskaun");
              var JUMdiskaun = $(row).find("td > .JUMdiskaun");
              var amountwocukai = $(row).find("td > .amountwocukai");

              var totalPrice = NumDefault(quantity.val()) * NumDefault(kdr_hrga.val())
              var amauncukai = NumDefault(cukai.val()) / 100
              var total_cukai = totalPrice * amauncukai
              var amaundiskaun = NumDefault(diskaun.val()) / 100
              var total_diskaun = totalPrice * amaundiskaun
              var amountxcukai = totalPrice - total_diskaun
              //alert(amaundiskaun)

              totalPrice = totalPrice + total_cukai - total_diskaun
              amount.val(totalPrice.toFixed(2));
              JUMcukai.val(total_cukai.toFixed(2));
              JUMdiskaun.val(total_diskaun.toFixed(2));
              t = amountxcukai.toFixed(2);
              amountwocukai.val(t);
              calculateGrandTotal();

          }


          async function initCarianVot(id) {

              $('#' + id).dropdown({
                  fullTextSearch: true,
                  onChange: function (value, text, $selectedItem) {

                      console.log($selectedItem);

                      var curTR = $(this).closest("tr");

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
                      url: 'Transaksi_InvoisWS.asmx/GetVotCOA?q={query}',
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

          //async function initCarianPenerima(id) {
          //    $('#' + id).dropdown({
          //        fullTextSearch: true,
          //        apiSettings: {
          //            url: 'Transaksi_InvoisWS.asmx/GetCarianPenerimaList?q={query}',
          //            method: 'POST',
          //            dataType: "json",
          //            contentType: 'application/json; charset=utf-8',
          //            cache: false,
          //            beforeSend: function (settings) {
          //                // Replace {query} placeholder in data with user-entered search term
          //                settings.data = JSON.stringify({ q: settings.urlData.query });
          //                searchQuery = settings.urlData.query;
          //                return settings;
          //            },
          //            onSuccess: function (response) {
          //                // Clear existing dropdown options
          //                var obj = $(this);

          //                var objItem = $(this).find('.menu');
          //                $(objItem).html('');

          //                // Add new options to dropdown
          //                if (response.d.length === 0) {
          //                    $(obj.dropdown("clear"));
          //                    return false;
          //                }

          //                var listOptions = JSON.parse(response.d);

          //                $.each(listOptions, function (index, option) {
          //                    $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
          //                });

          //                // Refresh dropdown
          //                $(obj).dropdown('refresh');

          //                if (shouldPop === true) {
          //                    $(obj).dropdown('show');
          //                }
          //            }
          //        }
          //    });
          //}

          async function setValueToRow(row, POrderDetail) {
              var ddl = $(row).find("td > .vot-list");
              var ddlSearch = $(row).find("td > .vot-list > .search");
              var ddlText = $(row).find("td > .vot-list > .text");
              var kuantiti = $(row).find("td > .quantity");
              var details = $(row).find("td > .details");
              var price = $(row).find("td > .price");
              var amount = $(row).find("td > .amount");
              var OrderDetailsID = $(row).find("td > .data-id");
              var selectObj = $(row).find("td > .vot-list > select");

              $(ddl).dropdown('set selected', POrderDetail.ddlVot);
              kuantiti.val(POrderDetail.quantity)
              details.val(POrderDetail.details)
              price.val(POrderDetail.price)
              amount.val(POrderDetail.amount)
              OrderDetailsID.val(POrderDetail.id);
              ddlText.html(POrderDetail.detailvot);
              selectObj.append("<option value = '" + POrderDetail.ddlVot + "'>" + POrderDetail.detailvot + "</option>")
              await calculateGrandTotal();
          }

          function addCommas(nStr) {
              nStr += '';
              x = nStr.split('.');
              x1 = x[0];
              x2 = x.length > 1 ? '.' + x[1] : '';
              var rgx = /(\d+)(\d{3})/;
              while (rgx.test(x1)) {
                  x1 = x1.replace(rgx, '$1' + ',' + '$2');
              }
              return x1 + x2;
          }
      </script>
   </contenttemplate>
</asp:Content>