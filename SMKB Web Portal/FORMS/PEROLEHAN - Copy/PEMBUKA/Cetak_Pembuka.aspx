<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Cetak_Pembuka.aspx.vb" Inherits="SMKB_Web_Portal.Cetak_Pembuka" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    <style>
        .default-primary {
            background-color: #007bff !important;
            color: white;
        }


       /*start sticky table tbody tfoot*/
        table {
            
        }
        .secondaryContainer {
            overflow: scroll;
            border-collapse: collapse;
            height: 500px;
            border-radius: 10px;
        }

        .sticky-footer {
            position: sticky;
            bottom: 0;
            background-color: white;
            z-index: 2;
        }

        #showModalButton:hover {
            /* Add your hover styles here */
            background-color: #ffc107; /* Change background color on hover */
            color: #fff; /* Change text color on hover */
            border-color: #ffc107; /* Change border color on hover */
            cursor: pointer; /* Change cursor to indicate interactivity */
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


        #rdKeseluruhan {
            height: 20px;
        }

      .fix-hade{
      top: 0;
      position: sticky;
      background:white;
      }

        .dataTables_filter input {
        width: 1600px !important; 
        }

    </style>

            <div id="PermohonanTab" class="tabcontent" style="display: block">
                
                <!-- Modal -->
                <div id="permohonan">
                    <div >
                        <div class=" " >
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalCenterTitle">Maklumat Perolehan</h5>
                            </div>
                               <div class="card-body">
                                     <div class="form-row">
                                            <div class="form-group col-md-6 form-inline">
                                                <div class="radio-btn-form d-flex " id="rdKontrak" name="rdKontrak">
                                                    <div class="form-check form-check-inline">
                                                        <input type="radio" id="rdKeseluruhan" name="inlineRadioOptions" value="1" class="w-200" />
                                                        <label class="form-check-label" for="rdKeseluruhan">&nbsp;&nbsp;Keseluruhan</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input type="radio" id="rdSH" name="inlineRadioOptions" value="0" class="w-200" />
                                                        <label class="form-check-label" for="rdSH">&nbsp;&nbsp;No. Sebut Harga</label>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-3 mt-4 d-none" id="divDatePicker"></div>
                                                      <div class="input-group d-flex">
                                                         <input type="text" id="categoryFilter" class="form-control input-group__input" placeholder="No. Sebut Harga" name="noMohonValue">
                                                            <div class="input-group-append">
                                                                 <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button">
                                                                        <i class="fa fa-search"></i>Cari
                                                                 </button>
                                                            </div> 
                                                        </div>
                                                </div>
                                </div>

                                    <div class="row">
                                 <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                   <%-- <div style="max-height: 400px; overflow-y: auto;">--%>
                                    <table id="tblDataSenarai2" class="table table-striped" style="width: 100%">
                                        <thead class="fix-hade">
                                            <tr style="width: 100%">
                                                <th scope="col" style="width: 2%">No. Bil</th>
                                                <th scope="col" style="width: 10%">No Sebut Harga</th>
                                                <th scope="col" style="width: 10%">Tarikh Pembuka</th>
                                                <th scope="col" style="width: 10%">Tajuk Sebut Harga</th>
                                                <th scope="col" style="width: 2%">Cetak</th>
                                            </tr>
                                        </thead>
                                        <tbody id="">
                                             <tr style=" width: 100%" class="table-list">
                                            </tr>
                                        </tbody>
                                    </table>
                                <%--</div>--%>
                                     
                                    <%--<div style="max-height: 400px; overflow-y: auto;">--%>
                                     <table id="tblDataSenarai3" class="table table-striped" style="width: 100%">
                                        <thead class="fix-hade">
                                            <tr style="width: 100%">
                                                <th scope="col" style="width: 2%">No. Bil</th>
                                                <th scope="col" style="width: 10%">No Sebut Harga</th>
                                                <th scope="col" style="width: 10%">Tarikh Pembuka</th>
                                                <th scope="col" style="width: 10%">Tajuk Sebut Harga</th>
                                                <th scope="col" style="width: 2%">Cetak</th>
                                            </tr>
                                        </thead>
                                        <tbody id="">
                                             <tr style=" width: 100%" class="table-list">
                                            </tr>
                                        </tbody>
                                    </table>
                                <%--</div>--%>
                                </div>
                            </div>

                     </div>

                        </div>
                    </div>
                </div>
            </div>


  <script type="text/javascript">
           function ShowPopup(elm) {

               //alert("test");
               if (elm == "1") {

                   $('#Senarai').modal('toggle');


               }
               else if (elm == "2") {

                   $(".modal-body div").val("");
                   $('#Senarai').modal('toggle');

               }
      }

      var tbl = null
      var tbl2 = null
      var noMohonValue = null;
      var isClicked = false;
      var radioClicked = false;
      $(document).ready(function () {

          //table keseluruhan
          tbl = $("#tblDataSenarai2").DataTable({
              "responsive": true,
              "searching": false,
              "info": false,
              "dom": "lfrti",
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
              "rowCallback": function (row, data) {
                  // Add hover effect
                  $(row).hover(function () {
                      $(this).addClass("hover pe-auto bg-warning");
                  }, function () {
                      $(this).removeClass("hover pe-auto bg-warning");
                  });
              },
              "drawCallback": function (settings) {
                  // Your function to be called after loading data
                  close_loader();
              },
              "ajax": {
                  url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadMesyPH") %>',
                  "method": 'POST',
                  "contentType": "application/json; charset=utf-8",
                  "dataType": "json",
                  "dataSrc": function (json) {
                      return JSON.parse(json.d);
                  },
                  "data": function () {
                      //var startDate = $('#txtTarikhStart').val();
                      //var endDate = $('#txtTarikhEnd').val();
                      //var categoryFilter = $('#categoryFilter').val();
                      var data = {
                          category_filter: $('#categoryFilter').val(),
                          isClicked: isClicked,
                          noMohonValue: noMohonValue,
                          //tkhTamat: endDate
                      };
                      console.log("Data sent to server:", data);
                      return JSON.stringify(data);
                  },
                  "error": function (xhr, error, thrown) {
                      console.log("Ajax error:", error);
                      console.log("Details:", xhr.responseText); // Log the responseText for more details
                      // Add logic to display user-friendly error messages or handle errors appropriately
                  }
              },
              "columns": [
                  {
                      "data": "Bil",
                      render: function (data, type, row, meta) {
                          return meta.row + meta.settings._iDisplayStart + 1;
                      },
                      "width": "2%"
                  },
                  { "data": "IDMesy", "width": "10%" },
                  { "data": "Tempat", "width": "10%" },
                  { "data": "TarikhMasa", "width": "10%" },
                  {
                      "data": null,
                      "defaultContent": '<i class="fa fa-print fa-lg"></i>',
                      "className": "text-center",
                      "width": "2%"
                  }
              ],
          });

          //table sebutharga - nomohon
          tbl2 = $("#tblDataSenarai3").DataTable({
              "responsive": true,
              "searching": true,
              "info": false,
              "dom": "lfrti",
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
              "rowCallback": function (row, data) {
                  // Add hover effect
                  $(row).hover(function () {
                      $(this).addClass("hover pe-auto bg-warning");
                  }, function () {
                      $(this).removeClass("hover pe-auto bg-warning");
                  });
              },
              "drawCallback": function (settings) {
                  // Your function to be called after loading data
                  close_loader();
              },
              "ajax": {
                  url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadMesyTest") %>',
                   "method": 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   "dataSrc": function (json) {
                       return JSON.parse(json.d);
                   },
                   "data": function () {
                       var data = {
                           category_filter: $('#categoryFilter').val(),
                           isClicked: isClicked,
                           noMohonValue: noMohonValue,
                           //tkhTamat: endDate
                       };
                       console.log("Data sent to server:", data);
                       return JSON.stringify(data);
                   },
                  "error": function (xhr, error, thrown) {
                      console.log("Ajax error:", error);
                      console.log("Details:", xhr.responseText); // Log the responseText for more details
                      // Add logic to display user-friendly error messages or handle errors appropriately
                  }
               },
               "columns": [
                   {
                       "data": "Bil",
                       render: function (data, type, row, meta) {
                           return meta.row + meta.settings._iDisplayStart + 1;
                       },
                       "width": "2%"
                   },
                   { "data": "JualanID", "width": "10%" },
                   { "data": "NoMohon", "width": "10%" },
                   { "data": "JenisPenilaian", "width": "10%" },
                   {
                       "data": null,
                       "defaultContent": '<i class="fa fa-print fa-lg"></i>',
                       "className": "text-center",
                       "width": "2%"
                   }
               ],
           });

          // Handle radio button clicks
          $('input[type="radio"]').change(function () {
              radioClicked = true;
              updateTableVisibility();
              updateTextInputState();
          });

          $('.btnSearch').click(async function () {
              // show_loader(); // Uncomment if needed
              isClicked = true;
              // Check if any radio button is selected
              if (!$('input[type="radio"]').is(':checked')) {
                  alert('Sila pilih jenis carian.');
                  return;
              }

              // Check if rdSH is clicked and categoryFilter is empty
              var categoryFilterValue = $('#categoryFilter').val();
              //if ($('#rdSH').prop('checked') && (categoryFilterValue === undefined || categoryFilterValue.trim() === '')) {
              if ($('#rdSH').prop('checked') && (!categoryFilterValue || categoryFilterValue.trim() === '')) {
                  alert('Sila isi no sebut harga!');
                  return;
              }

              // Show #tblDataSenarai3 when btnSearch is clicked
              $("#tblDataSenarai3").show();

              // Reload the table data
              tbl.ajax.reload();
              tbl2.ajax.reload();
          });

          function updateTableVisibility() {
              if ($("#rdKeseluruhan").prop("checked")) {
                  $("#tblDataSenarai2").show();
                  $("#tblDataSenarai3").hide();
              } else if ($("#rdSH").prop("checked")) {
                  $("#tblDataSenarai2").hide();
                  $("#tblDataSenarai3").hide(); // Hide #tblDataSenarai3 when rdSH is clicked
              } else {
                  $("#tblDataSenarai2").hide();
                  $("#tblDataSenarai3").hide();
              }
          }

          // Assuming you have click event handlers for your radio buttons
          //$("#rdKeseluruhan, #rdSH").on("click", updateTableVisibility);
          $("#rdKeseluruhan, #rdSH").on("click", function () {
              updateTableVisibility();
              updateTextInputState();
          });

          // Function to update text input state based on radio button click
          function updateTextInputState() {
              var noMohonValue = $('input[name="noMohonValue"]');
              var alertMessage = $('#alertMessage');

              if ($('#rdSH').prop('checked')) {
                  noMohonValue.prop('required', true);
                  noMohonValue.prop('disabled', false);
                  //alertMessage.text("Please enter a value in the input field.");
                  //alertMessage.show();
              } else if ($('#rdKeseluruhan').prop('checked')) {
                  noMohonValue.prop('required', false);
                  noMohonValue.prop('disabled', true);
                  alertMessage.hide();
              } else {
                  noMohonValue.prop('required', false);
                  noMohonValue.prop('disabled', false);
                  alertMessage.hide();
              }
          }

          // Initial table visibility and text input state
          updateTableVisibility();
          updateTextInputState();
      });

      //searching cat. filter
      $("#categoryFilter").change(function (e) {
          console.log("Category filter changed");
          console.log("Selected category: " + $('#categoryFilter').val());
          tbl.draw();

          var selectedItem = $('#categoryFilter').val();

          // Always hide the date picker and reset the value of #txtNoMohon
          $('#divDatePicker').removeClass("d-flex").addClass("d-none");
          $('#noMohonValue').val("");

          // Check if selectedItem is not empty (not necessary to check for "6")
          if (selectedItem !== "") {
              // If selectedItem is not empty, show the date picker for any value of selectedItem
              $('#divDatePicker').addClass("d-flex").removeClass("d-none");
          }
      });

  </script></asp:Content>
