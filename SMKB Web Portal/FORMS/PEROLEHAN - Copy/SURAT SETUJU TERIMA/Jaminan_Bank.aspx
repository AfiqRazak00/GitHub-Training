<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Jaminan_Bank.aspx.vb" Inherits="SMKB_Web_Portal.Jaminan_Bank" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    <style>
           .table-responsive {
            overflow-x: hidden ;
        }

        @media only screen and (max-width: 830px) {
       
            .table-responsive {
            overflow-x: auto !important;
            }
        }
      .modal-header--sticky {
      position: sticky;
      top: 0;
      background-color: inherit;
      z-index: 9999;
      }
      .modal-footer--sticky {
      position: sticky;
      bottom: 0;
      background-color: inherit;
      z-index: 9999;
      }
      .custom-table > tbody > tr:hover {
      background-color:#ffc83d !important;
      }
      #tblDataSenarai td:hover {
      cursor: pointer;
      }
      .modal-header--sticky {
      position: sticky;
      top: 0;
      background-color: inherit;
      z-index: 9999;
      }
      .modal-footer--sticky {
      position: sticky;
      bottom: 0;
      background-color: inherit;
      z-index: 9999;
      }
      .custom-table > tbody > tr:hover {
      background-color:#ffc83d !important;
      }
      #tblDataSenarai td:hover {
      cursor: pointer;
      }
      .ui.search.dropdown {
      height: 40px;
      }
      .tabcontent {
      padding: 0px 20px 20px 20px !important;
      }
      .table-title {
      padding-top: 0px !important;
      padding-bottom: 0px !important;
      }
      .custom-table > tbody > tr:hover {
      background-color: #ffc83d !important;
      }
      #tblCetakPembuka td:hover {
      cursor: pointer;
      }
      .default-primary {
      background-color: #007bff !important;
      color: white;
      }
      /*start sticky table tbody tfoot*/
      table {
      overflow: scroll;
      border-collapse: collapse;
      color: white;
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
      .sticky-footer th,
      .sticky-footer td {
      text-align: center; /* Center-align the content in footer cells */
      border-top: 1px solid #ddd; /* Add a border at the top to separate from data rows */
      padding: 10px; /* Adjust padding as needed */
      }
      #showModalButton:hover {
      background-color: #ffc107; /* Change background color on hover */
      color: #fff; /* Change text color on hover */
      border-color: #ffc107; /* Change border color on hover */
      cursor: pointer; /* Change cursor to indicate interactivity */
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
            /*color: #aaa;*/
            color: #000;
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
            font-size: 12px;
            color:black;
            font-weight:bold;
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
            font-size: 12px;
            color:black;
            font-weight:bold;
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
      .fix-hade{
      top: 0;
      position: sticky;
      background:white;
      }
      .border-container {
    border: 2px solid #000;
    border-radius: 5px;
    padding: 1rem;
    max-width: 600px;
    margin: 0 auto;
    }

    .text-container {
        margin: 0 1rem;
    }

    h2 {
        border-bottom: 1px solid #000;
        margin-bottom: 1rem;
        padding-bottom: 0.5rem;
    }
     .text-container p {
        text-align: justify;
    }
    </style>

            <div id="PermohonanTab" class="tabcontent" style="display: block">
                <!-- Modal -->
                <div id="permohonan">
                    <div >
                        <div class=" " >
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalCenterTitle">Jaminan Bank</h5>
                            </div>
                                 <div class="search-filter">
                  <div class="form-row justify-content-center">
                      <div class="form-group row col-md-6">
                                <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align:right">Carian :</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <select id="categoryFilter" class="custom-select" >
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
                           <div class="col-md-5">
                                    <div class="form-row">
                                         <div class="form-group col-md-5">
                                           <br />
                                        </div>
                                        </div>
                               </div>
                                <div class="col-md-11">
                                    <div class="form-row">
                                        <div class="form-group col-md-1">
                                            <label id="lblMula" style="text-align: right;display:none;"  >Mula: </label>
                                        </div>
                                        
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display:none;" class="form-control date-range-filter">
                                        </div>
                                         <div class="form-group col-md-1">
                                     
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label id="lblTamat" style="text-align: right;display:none;" >Tamat: </label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display:none;" class="form-control date-range-filter">
                                        </div>

                                    </div>
                                </div>
                            </div>
                  </div>
               </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="transaction-table table-responsive">
                                              <table id="tblCetakPembuka" class="table table-striped" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">Bil</th>
                                                        <th scope="col">No. Perolehan</th>
                                                        <th scope="col">No. Sebut Harga</th>
                                                        <th scope="col">Nama Syarikat</th>
                                                        <th scope="col">Telah dicetak</th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                             </table>
                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>


  <script type="text/javascript">
      var idSyarikat = '';
      var tbl_SST;
      var isClicked3 = false;
      var noMohonValue = ''; // Define globally
      $(document).ready(function () {
          //var tbl_CT;
          tbl_SST = $("#tblCetakPembuka").DataTable({
              "responsive": true,
              "searching": true,
              cache: true,
              dom: 'Bfrtip',
              "sPaginationType": "full_numbers",
              // Your language settings...
              "ajax": {
                  "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetRecord_SST") %>',
                      "type": "POST",
                      "data": function (d) {
                          var startDate = $('#txtTarikhStart').val();
                          var endDate = $('#txtTarikhEnd').val();
                          return JSON.stringify({
                              category_filter: $('#categoryFilter').val(),
                              isClicked3: isClicked3,
                              tkhMula: startDate,
                              tkhTamat: endDate,
                          })
                          console.log("Data sent to server:", data);
                          return JSON.stringify(data);
                          //console.log("hello world");
                          //console.log("hello noMohonValue = ", noMohonValue);
                          //return JSON.stringify({ noMohonValue: $('#noMohonValue').val() }); // Pass data properly
                      },
                      "contentType": "application/json; charset=utf-8",
                      "dataType": "json",
                      "dataSrc": function (json) {
                          return JSON.parse(json.d);
                      }
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
                          "data": "No_Perolehan",
                          "width": "15%"
                      },
                      {
                          "data": "No_Sebut_Harga",
                          "width": "15%"
                      },
                      {
                          "data": "Nama_Sykt",
                          "width": "15%"
                      },
                      {
                          "data": "null",
                          "type": "data", // This is optional but helps with sorting
                          render: function (data, type, row) {

                              return 'Cetak';

                          },
                          "width": "10%"
                      },
                  ],
                  "rowCallback": function (row, data) {
                      // Add hover effect
                      $(row).hover(function () {
                          $(this).addClass("hover pe-auto bg-warning");
                      }, function () {
                          $(this).removeClass("hover pe-auto bg-warning");
                      });

                      $(row).on("click", function () {
                          //console.log(data);
                          var rowData = data;
                          noMohonValue = rowData.No_Mohon;
                          noSebutHarga = rowData.No_Sebut_Harga;
                          txtTujuan = rowData.Tujuan;
                          idSyarikat = rowData.ID_Sykt;
                          totalHarga = rowData.totalHarga;
                          txtNamaSyarikat = rowData.Nama_Sykt;
                          console.log("noMohonValue zaq=", noMohonValue);
                          console.log("noSebutHarga zaq=", noSebutHarga);
                          console.log("txtTujuan zaq=", txtTujuan);
                          console.log("idSyarikat zaq=", idSyarikat);
                          console.log("totalHarga zaq=", totalHarga);
                          console.log("txtNamaSyarikat zaq=", txtNamaSyarikat);
                      });

                      // Add click event
                      $(row).on("click", function () {

                          var rowData = tbl_SST.row(this).data();
                          console.log("rowData:", rowData); // Debugging

                          // Example: Store the No_Pesanan value in session storage
                          sessionStorage.setItem('noMohonValue', rowData.No_Mohon);
                          sessionStorage.setItem('txtTujuan', rowData.Tujuan);
                          sessionStorage.setItem('noSebutHarga', rowData.No_Sebut_Harga);
                          sessionStorage.setItem('idSyarikat', rowData.ID_Sykt);
                          sessionStorage.setItem('totalHarga', rowData.totalHarga);
                          sessionStorage.setItem('txtNamaSyarikat', rowData.Nama_Sykt);

                          window.open('<%=ResolveClientUrl("~/FORMS/PEROLEHAN/SURAT SETUJU TERIMA/PrintReport/BG_Print.aspx")%>', '_blank');

                      });
              },
          });


          $('.btnSearch').click(async function () {

              //load_loader();
              isClicked3 = true;
              tbl_SST.ajax.reload();
              //    close_loader();
          })

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


  </script>



</asp:Content>
