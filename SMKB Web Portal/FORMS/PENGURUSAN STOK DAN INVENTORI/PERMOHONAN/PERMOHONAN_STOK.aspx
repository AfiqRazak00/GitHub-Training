<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PERMOHONAN_STOK.aspx.vb" Inherits="SMKB_Web_Portal.PERMOHONAN_STOK" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <style>
        .row-green {
            background-color: limegreen !important; /* Change to your desired green color */
        }
        .row-red{
            background-color: red !important;
        }

        .modal-backdrop {
            opacity: 0 !important; /* Make the backdrop transparent */
        }

        .box {
        width: 20px;
        height: 20px;
        margin: 0 auto 20px;
        margin-bottom: 10px;
        }

        .red {
        background-color: red;
        }

        .green {
        background-color: green;
        }

        .close {
          color: #aaa;
          float: right;
          font-size: 28px;
          font-weight: bold;
        }

        .close:hover,
        .close:focus {
          color: black;
          text-decoration: none;
          cursor: pointer;
        }

    </style>
   <contenttemplate>
      <div class="modal-body">
         <div class="tab-content" id="myTabContent">
               <div class="table-title">
                  <h5>Maklumat Pemohon</h5>
                    <hr>
                    <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                        Senarai Permohonan
                    </div>
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="row">
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="text" class="id_staff input-group__input form-control input-sm" placeholder="" name="" value="" readonly />
                              <label class="input-group__label">No. Pekerja</label>
                           </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="text" class="id_nama input-group__input form-control input-sm" placeholder="" name="" value="" readonly />
                              <label class="input-group__label">Nama Penuh</label>
                           </div>
                        </div>
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group">
                              <div class="form-group input-group">
                                 <select class="input-group__select ui search dropdown" placeholder="" name="ddlPtj" id="ddlPtj">
                                 </select>
                                 <label class="input-group__label" for="ddlPtj">PTJ <span style="color:red">*</span></label>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="text" class="tarikh_mohon input-group__input form-control input-sm" placeholder="" name="" value="" readonly />
                              <label class="input-group__label">Tarikh Mohon</label>
                           </div>
                        </div>
                         <div class="col-lg-4 col-md-6">
                           <div class="form-group input-group">
                              <input type="text" class="no_mohon input-group__input form-control input-sm" name="" readonly />
                              <label class="input-group__label">No. Permohonan</label>
                           </div>
                        </div>
                    </div>
                </div>
               </div>
               <div class="table-title">
                <h5>Senarai Barang PTJ <button type="button" class="btn" id="showModalButton"><i class="fas fa-info-circle"></i></button></h5>
                   
               </div>
             <%--<div class="modal-body">--%>
               <div class="col-md-13">
                  <div class="transaction-table table-responsive">
                     <span style="display: inline-block; height: 100%;"></span>
                     <table id="tblBarang" class="table table-striped">
                        <thead>
                           <tr style="width: 100%">
                               <th>No.</th>
                               <th style="width: 20% !important">Nama Barang</th>
                               <th>Takat Minima</th>
                               <th>Takat Maksima</th>
                               <th>Takat Menokok</th>
                               <th>Baki Stok Pusat</th>
                               <th>Baki Stok Ptj</th>
                               <th>Sedang Dipohon</th>
                               <th>Kuantiti Dipohon</th>
                           </tr>
                        </thead>
                        <tbody id="tableBody">
                           <tr style="width: 100%" class="table-list">
                              <td>1</td>
                                <td class="namaBarang"> </td>
                                 <td class="takatMinima"></td>
                                <td class="takatMaksima"></td>
                                <td class="takatMenokok"></td>
                                <td class="bakiStokPusat"></td>
                                <td class="bakiStokPtj"></td>
                                <td class="sedangDipohon"></td>
                                <td><input style="width: 50%" type="number" class="kuantitiDipohon" min="0" step="1"></td>
                           </tr>
                        </tbody>
                     </table>
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
            </div>
           <%-- </div>--%>
        </div>
      <%-- MODAL--%>
       <div class="modal fade" id="permohonan" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan Pengeluaran</h5>
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
                                     <table id="tblSenaraiPermohonan" class="table table-striped" style="width: 100% !important">
                                        <thead>
                                           <tr>
                                               <th>Bil</th>
                                               <th>No.Permohonan</th>
                                               <th>Tarikh Mohon</th>
                                               <th>No. Staf</th>
                                               <th>Nama Staf</th>
                                               <th>Jumlah Kuantiti</th>
                                               <th>Status Dokumen</th>
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
       <!-- Confirmation Modal Submit Bil -->
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
       <%--Modal info--%>
        <div class="modal fade" id="infomodal" tabindex="-1" aria-labelledby="showDetails" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <table class="" style="width: 100%; border: none">
                            <tr>
                                <td><div class="box red"></div></td>
                                <td> Baki Stok < Takat Minima</td>
                            </tr>
                            <tr>
                                <td><div class="box green"></div></td>
                                <td> Baki Stok <  Takat Menokok dan Baki Stok >= Takat Minima</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

       <script>
           const showModalButton = document.getElementById('showModalButton');
           const infomodal = new bootstrap.Modal(document.getElementById('infomodal'));

           showModalButton.addEventListener('click', () => {
               infomodal.show();
           });

           showModalButton.addEventListener('mouseenter', () => {
               const buttonRect = showModalButton.getBoundingClientRect();
               const modalDialog = infomodal._dialog;

               // Position the modal with the top left corner near the button with adjusted offsets
               const offsetLeft = 10; // Adjust this value to position the modal to the left
               const offsetTop = -40; // Adjust this value to position the modal upwards
               modalDialog.style.position = 'fixed';
               modalDialog.style.left = buttonRect.left + offsetLeft + 'px'; // Add the offset
               modalDialog.style.top = buttonRect.bottom + offsetTop + 'px'; // Add the offset

               infomodal.show();
           });


           showModalButton.addEventListener('mouseleave', () => {
               infomodal.hide();
           });
       </script>

       <script>
           var isClicked = false;
           var category_filter, startDate, endDate, selectedPtj, tbl, tbl2;
           $(document).ready(function () {
               // Get today's date
               var today = new Date();

               // Format the date as "YYYY-MM-DD"
               var formattedDate = today.getDate().toString().padStart(2, '0') + '/' + (today.getMonth() + 1).toString().padStart(2, '0') + '/' + today.getFullYear();

               // Set the default value of the input field
               document.querySelector('.tarikh_mohon').value = formattedDate;

               tbl = $("#tblSenaraiPermohonan").DataTable({
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
                       "url": "StokMohonWS.asmx/fetchSenaraiPermohonan",
                       method: 'POST',
                       data: function (d) {
                           return "{ category_filter: '" + category_filter + "',isClicked: '" + isClicked + "',tkhMula: '" + startDate + "',tkhTamat: '" + endDate + "',kodPtj: '" + selectedPtj + "'}";
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
                       { "data": "No_Staf" },
                       { "data": "MS01_Nama" },
                       { "data": "Total_Kuantiti_Mohon" },
                       { "data": "Status_Dok" },
                       {
                           "data": "Status",
                           "render": function (data, type, row) {
                               // Customize the rendering based on the data
                               return data == 1 ? "Aktif" : "Tidak Aktif";
                           }
                       }
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
           });

           $('.btnSearch').click(async function () {
               /*show_loader();*/
               selectedPtj = $('#ddlPtj').val();
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

           function ShowPopup(elm) {

               //alert("test");
               if (elm == "2") {
                   tbl.clear().draw();
                   $('#permohonan').modal('toggle');
               }
           }

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
           $(document).ready(function () {
               /*loadDdlBarang();*/
               $('.btnSimpan').click(function () {
                   // Show the confirmation modal
                   $('#confirmationModalSubmit').modal('show');
               });

               $('.btnPadam').click(function () {
                   var selectedPtj = $('#ddlPtj').val();
                   loadDdlBarang(selectedPtj);
                   $('.no_mohon').val("");
                   // Get today's date
                   var today = new Date();

                   // Format the date as "YYYY-MM-DD"
                   var formattedDate = today.getDate().toString().padStart(2, '0') + '/' + (today.getMonth() + 1).toString().padStart(2, '0') + '/' + today.getFullYear();

                   // Set the default value of the input field
                   document.querySelector('.tarikh_mohon').value = formattedDate;

                   $('.btnSimpan').show();

               });

               // Event listener for the "Ya" button in the confirmation modal
               $('#btnYaSubmit').click(function () {
                   //debugger
                   var isValid = true;

                   $('#tblBarang tbody tr').each(function (index, row) {
                       // Get the cells in the current row
                       var cells = $(this).find('td');

                       var takatMaksima = parseInt(cells.eq(3).text()) || 0;
                       var bakiStokPtj = parseInt(cells.eq(6).text()) || 0;
                       var sedangDipohon = parseInt(cells.eq(7).text()) || 0;
                       var kuantitiDipohon = parseInt(cells.eq(8).find('input').val()) || 0; // Assuming there's an input field in the last cell

                       var totalQuantity = bakiStokPtj + sedangDipohon + kuantitiDipohon;

                       // Check if total quantity exceeds the maximum threshold
                       if (totalQuantity > takatMaksima) {
                           isValid = false;
                           
                           return false;
                       }
                   });

                   // If all rows pass the validation, save the data to the database
                   if (isValid) {
                       saveFormDataToDatabase();
                       $('#confirmationModalSubmit').modal('hide');
                       var selectedPtj = $('#ddlPtj').val();
                       loadDdlBarang(selectedPtj);
                   }
                   else {
                       $('#confirmationModalSubmit').modal('hide');

                       $('#lblMessageModal').html("Jumlah bilangan permohonan melebihi Takat Maksima");

                       // Show the modal
                       $('#MessageModal').modal('show');
                   }
               });


               // Call loadDdlBarang function when ddlPtj selection changes
               $('#ddlPtj').on('change', function () {
                   $('.no_mohon').val("");
                   $('.btnSimpan').show();
                   var selectedPtj = $('#ddlPtj').val();
                   loadDdlBarang(selectedPtj);
               });

               // Trigger the AJAX request when the page finishes loading
               $.ajax({
                   url: "StokMohonWS.asmx/fetchUserDetails",
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       // Parse the JSON string within the "d" property
                       var responseData = JSON.parse(response.d);
                       // Check if responseData is an array and has at least one element
                       if (Array.isArray(responseData) && responseData.length > 0) {
                           // Access the properties of the first element
                           $(".id_nama").val(responseData[0].Nama);
                           $(".id_kp").val(responseData[0].NoKp);
                           $(".id_staff").val(responseData[0].NoStaf);
                       }
                   },
                   error: function (error) {
                       console.error(error.responseText); // Access the error message directly
                   }
               });

               $.ajax({
                   url: "StokMohonWS.asmx/fetchDdlPtj",
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       try {
                           var responseData = JSON.parse(response.d);
                           
                           if (Array.isArray(responseData) && responseData.length > 0) {
                               var ddlPtj = $("#ddlPtj");
                               ddlPtj.empty(); // Clear existing options
                               /*ddlPtj.append($("<option></option>").text("Pilih Ptj").val(""));*/
                               responseData.forEach(function (item) {
                                   if (item.KodPejabat && item.Pejabat) { // Check if properties are defined
                                       var optionText = item.KodPejabat + '-' + item.Pejabat;
                                       ddlPtj.append($("<option></option>").text(optionText).val(item.KodPejabat));
                                       loadDdlBarang(item.KodPejabat)
                                   }
                               });
                               ddlPtj.dropdown(); // Initialize dropdown
                           }
                       } catch (error) {
                           console.error("Error parsing response:", error);
                       }
                   },
                   error: function (error) {
                       console.error("AJAX error:", error.responseText);
                   }
               });
               // Add an event listener to the rows of tblSenaraiPermohonan
               $('#tblSenaraiPermohonan tbody').on('click', 'tr', function () {
                   var rowData = tbl.row(this).data(); // Get data of the clicked row
                   var noMohon = rowData['No_Mohon']; // Extract No_Mohon from the clicked row
                   var tkhMohon = rowData['Tkh_Mohon'];

                   var date = new Date(tkhMohon);

                   // Extract day, month, and year
                   var day = date.getDate();
                   var month = date.getMonth() + 1; // Months are zero-based
                   var year = date.getFullYear();

                   // Ensure leading zeros if necessary
                   day = (day < 10) ? '0' + day : day;
                   month = (month < 10) ? '0' + month : month;

                   // Construct the formatted date string
                   var formattedDate = day + '/' + month + '/' + year;

                   $('.no_mohon').val(noMohon);
                   $('.tarikh_mohon').val(formattedDate);

                   $('#permohonan').modal('hide');

                   show_loader();

                   // Use No_Mohon to fetch details from tblBarang
                   tbl2 = $("#tblBarang").DataTable({
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
                           "url": "StokMohonWS.asmx/fetchBarangTbl",
                           method: 'POST',
                           "contentType": "application/json; charset=utf-8",
                           "dataType": "json",
                           "data": function () {
                               var selectedPtj = $('#ddlPtj').val();
                               close_loader();
                               return JSON.stringify({
                                   noMohon: noMohon,
                                   kodPtj: selectedPtj
                               })
                           },
                           "dataSrc": function (json) {
                               var data = JSON.parse(json.d);
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
                           {
                               "data": null,
                               "render": function (data, type, row) {
                                   return row.Kod_Brg + "-" + row.Butiran;
                               }
                           },
                           { "data": "Takat_Min" },
                           { "data": "Takat_Max" },
                           { "data": "Takat_Menokok" },
                           { "data": "Baki_Unit_Pusat" },
                           { "data": "Baki_Unit_PTJ" },
                           { "data": "Kuantiti_PTJ_Sedang_Dipohon" },
                           {
                               "data": "Kuantiti_Mohon",
                               "render": function (data, type, row) {
                                   // Render an input box with the value of Kuantiti_Mohon
                                   return '<input type="number" class="kuantitiDipohon" min="0" step="1" value="' + data + '" readonly style="width: 75%;">';
                               }
                           }
                       ],
                       "createdRow": function (row, data, index) {
                           var bakiUnit = parseFloat(data['Baki_Unit_PTJ']) || 0;
                           var takatMin = parseFloat(data['Takat_Min']) || 0;
                           var takatMenokok = parseFloat(data['Takat_Menokok']) || 0;

                           if (bakiUnit < takatMin) {
                               $(row).addClass('row-red');
                           } else if (bakiUnit >= takatMin && bakiUnit <= takatMenokok) {
                               $(row).addClass('row-green');
                           }
                       }

                   });
                   $('.btnSimpan').hide();
               });

           });

           function loadDdlBarang(selectedPtj) {
               /*debugger*/
               show_loader();
               tbl2 = $("#tblBarang").DataTable({
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
                       "url": "StokMohonWS.asmx/fetchBarang",
                       method: 'POST',
                       "contentType": "application/json; charset=utf-8",
                       "dataType": "json",
                       "data": function () {
                           /*var selectedPtj = $('#ddlPtj').val();*/
                           return JSON.stringify({
                               kodPtj: selectedPtj
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
                       {
                           "data": null,
                           "render": function (data, type, row) {
                               return row.Kod_Brg + "-" + row.Butiran;
                           }
                       },
                       { "data": "Takat_Min" },
                       { "data": "Takat_Max" },
                       { "data": "Takat_Menokok" },
                       { "data": "Baki_Unit_Pusat" },
                       { "data": "Baki_Unit_PTJ" },
                       { "data": "Kuantiti_PTJ_Sedang_Dipohon" },
                       {
                           "data": null,
                           "render": function (data, type, row) {
                               // Render an input box in the last column
                               return '<input type="number" class="kuantitiDipohon" min="0" step="1" value="0" style="width: 75%;">';
                           }
                       }
                   ],
                   "createdRow": function (row, data, index) {
                       var bakiUnit = parseFloat(data['Baki_Unit_PTJ']) || 0;
                       var takatMin = parseFloat(data['Takat_Min']) || 0;
                       var takatMenokok = parseFloat(data['Takat_Menokok']) || 0;

                       if (bakiUnit < takatMin) {
                           $(row).addClass('row-red');
                       } else if (bakiUnit >= takatMin && bakiUnit <= takatMenokok) {
                           $(row).addClass('row-green');
                       }
                   }

               });
           }
           function saveFormDataToDatabase() {
               var kodPtj = $('#ddlPtj').val(); // Get the selected value of ddlPtj
               /*var noMohon = $('.no_mohon').val();*/
               var formDataArray = []; // Array to store form data from each row

               // Loop through each table row
               $("#tblBarang tbody tr").each(function () {
                   var secondColumnValue = $(this).find('td:eq(1)').text(); // Get text content of the second column
                   var IdBarang = secondColumnValue.split('-')[0].trim(); // Extract Kod_Brg from the concatenated value
                   var KuantitiDipohon = parseFloat($(this).find('.kuantitiDipohon').val());

                   if (KuantitiDipohon !== 0) {
                       formDataArray.push({ IdBarang: IdBarang, KuantitiDipohon: KuantitiDipohon });
                   }
               });

               if (formDataArray.length === 0) {
                   // Update the content of the modal with the message
                   $('#lblMessageModal').html("Sila pilih barang dan masukkan kuantiti.");

                   // Show the modal
                   $('#MessageModal').modal('show');
               } else {
                   // Send data to server via AJAX, including kodPtj
                   $.ajax({
                       url: 'StokMohonWS.asmx/SimpanPermohonanStok', // Replace with your web service endpoint
                       type: 'POST',
                       contentType: 'application/json',
                       data: JSON.stringify({ formDataArray: formDataArray, kodPtj: kodPtj }), // Include formDataArray and kodPtj
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

                           tbl2.clear().draw();
                       },
                       error: function (xhr, status, error) {
                           // Handle error
                           console.error('Error saving data:', error);
                           // Optionally, show an error message to the user
                           alert('An error occurred while saving data.');
                       }
                   });
               }
           }
       </script>
    </contenttemplate>
</asp:Content>
