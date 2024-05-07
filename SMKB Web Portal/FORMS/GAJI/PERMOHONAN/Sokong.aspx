<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Sokong.aspx.vb" Inherits="SMKB_Web_Portal.Sokong" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <style>
    

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

    #tblDataSenarai_trans td:hover {
        cursor: pointer;
    }


    .default-primary {
        background-color: #007bff !important;
        /*color: white;*/
    }


    /*start sticky table tbody tfoot*/
    table {
        overflow: scroll;
        border-collapse: collapse;
        /*color: white;*/
    }

    .table-wrapper{
    width : 100%;
    box-shadow: 0px 35px 50px rgba( 0, 0, 0, 0.2 );
    font-size: 8px;
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
</style>
<div id="PermohonanTab" class="tabcontent" style="display: block">

     <label id="hidBulan" style="visibility:hidden" ></label>
     <label id="hidTahun" style="visibility:hidden"></label>
     <label id="hidIdMohon" style="visibility:hidden" ></label>
     <label id="hidKodTrans" style="visibility:hidden" ></label>
     <label id="hidAmaun" style="visibility:hidden" ></label>
     <div class="hidParam" style="display:none"></div>
        <div class="form-row">
            <div class="form-group col-md-3">
                <asp:TextBox runat="server" ID="txtBlnThn" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>       
                <label class="input-group__label" for="Bulan/Tahun Gaji">Bulan/Tahun Gaji</label>
            </div>

        </div>

                <div id="divpendaftaraninv" runat="server" visible="true">
                <div class="modal-body">
                    <div>
                        <hr />
                        <h6>Senarai Permohonan Potongan Staf Yang Belum Di Sokong</h6>
                        <hr />
                        <!-- Create the dropdown filter -->

                        <div class="search-filter">
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Carian :</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <select id="invoisDateFilter" class="custom-select" onchange="dateFilterHandler(event)">
                                                <option value="all">SEMUA</option>
                                                <option value="0" selected="selected">Hari Ini</option>
                                                <option value="1">Semalam</option>
                                                <option value="7">7 Hari Lepas</option>
                                                <option value="30">30 Hari Lepas</option>
                                                <option value="60">60 Hari Lepas</option>
                                                <option value="select">Pilih Tarikh</option>
                                            </select>
                                            <button id="btnSearch" class="btn btnSearch btn-outline" type="button" onclick="loadPermohonan()">
                                                <i class="fa fa-search"></i>Cari
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div class="form-row">
                                            <div class="form-group col-md-5">
                                                <br />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-11" id="specificDateFilter" style="display: none">
                                        <div class="form-row">
                                            <div class="form-group col-md-1">
                                                <label id="lblMula" style="text-align: right;">Mula:</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control input-sm date-range-filter">
                                            </div>
                                            <div class="form-group col-md-1">
                                            </div>
                                            <div class="form-group col-md-1">
                                                <label id="lblTamat" style="text-align: right;">Tamat:</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control input-sm date-range-filter">
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblSenaraiPermohonan" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="width:10px">Bil</th>
                                                 <th scope="col" style="width:50px">No. Mohon</th>
                                                 <th scope="col" style="width:50px">Tarikh Mohon</th>
                                                 <th scope="col" style="width:150px">No. Staf | Nama</th>
                                                 <th scope="col" style="width:100px">Jenis Potongan</th>
                                                 <th scope="col" style="width:50px">Tarikh Mula</th>
                                                 <th scope="col" style="width:50px">Tarikh Tamat</th>
                                                 <th scope="col" style="width:50px">Amaun Potongan (RM)</th>           
                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        <!-- Modal -->
                <div class="modal fade" id="modalInvoisData" tabindex="-1" role="dialog"
                    aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="eMCTitle">Maklumat Staf</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body">
                                 
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            
                                            <asp:TextBox runat="server" ID="txtNoStaf" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                            <label class="input-group__label" for="No. Staf">No. Staf</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            
                                            <asp:TextBox runat="server" ID="txtGjPokok" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                             <label class="input-group__label" for="Gaji Pokok">Gaji Pokok</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <%-- <label>No. KP</label>--%>
                                            <asp:TextBox runat="server" ID="txtNoKp" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                          <label class="input-group__label" for="No. KP">No. KP</label>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                           
                                            <asp:TextBox runat="server" ID="txtNama" TextMode="MultiLine" Rows="2" Enabled="false"  CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                              <label class="input-group__label" for="Nama">Nama</label>
                                        </div>

                                        <div class="form-group col-md-4">
                   
                                           <asp:TextBox runat="server" ID="txtJwtn" TextMode="MultiLine" Rows="2" Enabled="false"  CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                            <label class="input-group__label" for="Jawatan">Jawatan</label>
                                        </div>
                                        <div class="form-group col-md-4">
                   
                                            <asp:TextBox runat="server" ID="txtPjbt" TextMode="MultiLine" Rows="2" Enabled="false" CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                             <label class="input-group__label" for="Pejabat">Pejabat</label>
                                        </div>

                                    </div>      
                               
                                <h6><b>Butiran Gaji Staf</b></h6>
                                <hr>
                                    <div class="row">
                                       <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="table-wrapper">
                                                <table id="tblListHdr" style="width:100%" class="table table-bordered table-sm"  cellspacing="0px" cellpadding="0px">

                                                    <thead style="font-size:12px;background-color:lightgrey;">
                                                        <tr >
                                                        <td colspan="3" style="border-right:1px solid gainsboro;text-align:center"><b>PENDAPATAN</b></td>
                                                        <td colspan="3" style="border-right:1px solid gainsboro;text-align:center"><b>POTONGAN</b></td>
                                                    </tr>
                                                    <tr >
                                                        <td scope="col" style="width:50px"><b>KOD</b></td>
                                                        <td scope="col" style="width:100px;text-align:left"><b>BUTIRAN</b></td>
                                                        <td scope="col" style="width:100px;border-right:1px solid gainsboro;text-align:right"><b>AMAUN (RM)</b></td>
                                                        <td scope="col" style="width:50px"><b>KOD</b></td>
                                                        <td scope="col" style="width:100px;text-align:left"><b>BUTIRAN</b></td>
                                                        <td scope="col" style="width:100px;text-align:right"><b>AMAUN (RM)</b></td>
                                                    </tr>
                                                    </thead>

                                                    <tbody id="tbllistbody" style="font-size:12px">

                                                    </tbody>

                                                <tfoot style="font-size:12px">
                             
                                                    <tr style="background-color:beige;" rowspan="4"> 
                                                        <td colspan="2" ><b>PENDAPATAN KASAR (RM) </b></td>
                                                        <td colspan="1" id="lblAmaunPendapatan" style="border-right:1px solid gainsboro;text-align:right;font-weight:bold"></td>
                                                        <td colspan="2" ><b>JUMLAH POTONGAN (RM) </b></td>
                                                        <td colspan="1" id="lblAmaunPotongan" style="text-align:right;font-weight:bold"></td>
                                                    </tr>
                                                    <tr style="background-color:beige;" rowspan="4">
       
                                                        <td colspan="2" ></td>
                                                        <td colspan="1" id="lblPencen" style="text-align:right; font-weight:bold"></td>
                                
                                                        <td colspan="2" ><b>PENDAPATAN BERSIH (RM) </b></td>
                                                        <td colspan="1" id="lblAmaunbersih" style="text-align:right; font-weight:bold" ></td>
                                                    </tr>
                           
                                                   
                                                </tfoot>
                            
                                            </table>
                                        </div>
                                        </div>
                                    </div>

                                    </div> 

                                     <hr>

                            </div>

                            <div class="modal-footer">
                                 <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">                        
                                    
                                    <button type="button" class="btn btn-success btnLulus" data-toggle="tooltip" data-placement="bottom">Sokong</button> 
                                    <button type="button" class="btn btn-danger btnKemaskini" data-toggle="tooltip" data-placement="bottom">Tidak Sokong</button>
                                </div>
                                
                            </div>
                        </div>
                    </div>
         </div>
        <!-- End Modal -->       

                   <%--  modal lulus permohonan--%>
        <div class="modal fade" id="saveConfirmationModal10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel10">Sokong Permohonan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage10"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="confirmSaveButton10">Ya</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Result Lulus -->
        <div class="modal fade" id="resultModal10" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="resultModalLabel10">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="resultModalMessage10"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>




        <%--modal untuk kemaskini button--%>
         <div class="modal fade" id="saveConfirmationModal11" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="saveConfirmationModalLabel11">Ulasan</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                      <div class="row">
                          <div class="col-md-12">
                              <div class="form-row">
                                  <div class="form-group col-md-12">
                                      <textarea class="input-group__input js-group-one" id="txtUlasan" placeholder="&nbsp;" name="Tajuk / Tujuan" style="height:140px" ></textarea>
                                      <label class="input-group__label" for="Tajuk / Tujuan">Sila Masukkan Ulasan</label>
                                  </div>
                              </div>
                          </div>
                      </div>

                  </div>
                  <div class="modal-footer" style="padding:0px" >
                      <button type="button" class="btn btn-setsemula" data-dismiss="modal">Tutup</button>
                      <button type="button" class="btn btn-secondary" id="confirmSaveButton11">Hantar</button>
                  </div>
              </div>
          </div>
      </div>

      <!-- Modal Result Kemaskini -->
      <div class="modal fade" id="resultModal11" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="resultModalLabel11">Makluman</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                      <p id="resultModalMessage11"></p>
                  </div>
                  <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                  </div>
              </div>
          </div>
      </div>

                        <!-- Modal -->
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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="ReloadPage();">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
</div>


<script type="text/javascript">

    function notification(msg) {
        $("#notify").html(msg);
        $("#NotifyModal").modal('show');
    }

    function showModalAndReadSessionData() {
        var modalElement = document.getElementById('transaksi');
        var modal = new bootstrap.Modal(modalElement, {
            backdrop: 'static',
            dataBackdrop: 'false'
        });

        btnHome.style.visibility = 'visible';
        btnSignOut.style.visibility = 'visible';
        btnClose.style.visibility = 'hidden';


        var iconElement = document.createElement('i');

        iconElement.classList.add("fa", "fa-home");

        // Clear the existing content of btnModalLulus and append the iconElement
        btnHome.innerHTML = '';
        btnHome.appendChild(iconElement);
        // Set visibility of btnHome to 'visible'
        btnHome.style.visibility = 'visible';


        var iconElement2 = document.createElement('i');

        iconElement2.classList.add("fa", "fa-sign-out");


        // Clear the existing content of btnModalLulus and append the iconElement
        btnSignOut.innerHTML = '';
        btnSignOut.appendChild(iconElement2);

        modalElement.classList.add('modal-background');
        modal.show();

        // Call the function to read session data
        readSessionData();
    }

    function readSessionData() {
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/FORMS/JURNAL/JURNAL KEWANGAN/Transaksi_WS.asmx/GetSessionData") %>',
         contentType: "application/json; charset=utf-8",
         dataType: "json",
         success: function (response) {
             //console.log("Session data:", response.d);

             var id = response.d;

             // Find the DataTable instance
             var table = $("#tblSenaraiPermohonan").DataTable();


             // Search for the row with the matching No_Mohon value
             var matchedRow = table.rows().data().filter(function (row) {

                 return row.No_Mohon === id;
             });

             // Check if a matching row is found
             if (matchedRow.length > 0) {
                 // Access the first matched row's data
                 var rowData = matchedRow[0];
                 ssss
                 // Perform any action with the matched row data
                 console.log("Matched row data:", rowData);

                 // Pass the matched row data to another function if needed
                 rowClickHandler(rowData);
             } else {
                 console.log("No row found with ID:", id);
             }

             //$('#tblDataSenarai_trans').dataTable().fnDestroy();

             // Handle the session data received from the server as needed
         },
         error: function (xhr, status, error) {
             console.error("Error reading session:", error);
             // Handle errors
         }
     });
    }


    var tbl = null;
    var bln = "";
    var thn = "";
    getBlnThn();

    $(document).ready(function () {
        var today = toSqlDateString(new Date())

        document.getElementById('txtTarikhStart').setAttribute('max', today);
        document.getElementById('txtTarikhEnd').setAttribute('max', today);
        tbl = $("#tblSenaraiPermohonan").DataTable({
            "responsive": true,
            "searching": true,
            "rowCallback": function (row, data) {
                // Add hover effect
                $(row).hover(function () {
                    $(this).addClass("hover pe-auto bg-warning");
                }, function () {
                    $(this).removeClass("hover pe-auto bg-warning");
                });
            },
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
            columnDefs: [
                { targets: [5] }
            ],
            "columns": [
                { "data": "Bil", "className": "text-center" },
                { "data": "ID_Mohon", "className": "text-center" },
                { "data": "FormattedDate", "className": "text-center" },
                { "data": "nama", "className": "text-center" },
                { "data": "Butiran" },
                { "data": "Tkh_Mula", className: "text-center" },
                { "data": "Tkh_Tamat", className: "text-center" },
                { "data": "amaun", "className": "text-right" }
            ],
            createdRow: function (row, data, dataIndex) {
                row.dataset.idrujukan = data["ID_Mohon"]
                row.onclick = showInvoisData
            }

        });

    });


    async function showInvoisData(e) {
        var target = e.target
        if (target.tagName == "TD") {
            target = target.parentElement
        }
        show_loader()
        let invHdr = await getInvoisHdr(target.dataset.idrujukan)
        close_loader()

        $("#modalInvoisData").modal('show')
    }

    function getBlnThn() {
        //Cara Pertama

        fetch('Mohon_WS.asmx/LoadBlnThnGaji', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify()
        })
            .then(response => response.json())
            .then(data => setBlnThn(data.d))

    }
    function setBlnThn(data) {
        var sBulan = "";
        data = JSON.parse(data);

        if (data.bulan === "") {
            alert("Tiada data");
            return false;
        }
        if (data[0].bulan < 10) {
            sBulan = '0' + data[0].bulan;
        }
        else {
            sBulan = data[0].bulan;
        }
        $('#<%=txtBlnThn.ClientID%>').val(data[0].butir);
        $('#hidBulan').text(data[0].bulan);
        $('#hidTahun').text(data[0].tahun);
        $('.hidParam').html(data[0].tahun + sBulan);


    }
    //$("#selectAll").on("change", function () {
    //    //tbl.$("input[type='checkbox']").attr('checked', $(this.checked));
    //    if (this.checked) {
    //            $(".checkSingle").each(function () {
    //                this.checked = true;
    //            });
    //        } else {
    //            $(".checkSingle").each(function () {
    //                this.checked = false;
    //            });
    //        }

    //});


    function ShowPopup(obj) {
        $('#infostaf').modal('toggle');
    }
    function getInvoisHdr(No_Mohon) {
        return new Promise(function (resolve, reject) {
            $.ajax({

            url: '<%= ResolveUrl("Mohon_WS.asmx/getFullSokonganData") %>',
            method: "POST",
            data: JSON.stringify({
                No_Mohon: No_Mohon

            }),
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success: async function (data) {
                data = JSON.parse(data.d)
                data = data.Payload
                fillInvoisHdr(data.hdr[0])
                //console.log('Kat_Pij ' + data.hdr[0].Kategori_Pinj)
                //retrive table ulasan
                //retrieveUlasanSokongan(data.hdr[0].Kategori_Pinj)
                resolve(true)
            },
            error: function (xhr, status, error) {
                console.error(error);
                reject(false)
            }
        })
    })
    }

    var cacheInvois = null
    function fillInvoisHdr(inv) {
        cacheInvois = inv
       
        $('#<%=txtNoStaf.ClientID%>').val(inv.MS01_NoStaf);
        $('#<%=txtNoKp.ClientID%>').val(inv.MS01_KpB);
        $('#<%=txtNama.ClientID%>').val(inv.MS01_Nama);
        $('#<%=txtJwtn.ClientID%>').val(inv.JawatanS); 
        $('#<%=txtPjbt.ClientID%>').val(inv.PejabatS); 
        $('#hidIdMohon').val(inv.ID_Mohon)
        getAllData(inv.MS01_NoStaf);
    }


    async function getAllData(vNostaf) {
        
        var dataIncome = await getIncome(vNostaf);
        var dataPotongan = await getPotongan(vNostaf);
        //var dataMajikan = await getMajikan();
        var counter = 0;
        var bil = 0;

        dataIncome = JSON.parse(dataIncome)
        dataPotongan = JSON.parse(dataPotongan)
        $('#tbllistbody').html("");

        var totalData = dataIncome.length;
        //alert(dataPotongan.length);
        if (dataPotongan.length > totalData) {
            totalData = dataPotongan.length;
        }
        var totalIncome = 0.00;
        var totalPotongan = 0.00;
        var totalBersih = 0.00;

        while (counter < totalData) {

            var potongan1 = ""
            var potongan2 = ""
            var potongan3 = ""


            var income1 = ""
            var income2 = ""
            var income3 = ""


            if (dataIncome[counter] !== null && dataIncome[counter] !== undefined) {
                income1 = dataIncome[counter].Kod_Trans
                income2 = dataIncome[counter].Butiran
                income3 = parseFloat(dataIncome[counter].Amaun).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                totalIncome += parseFloat(dataIncome[counter].Amaun);
            }

            if (dataPotongan[counter] !== null && dataPotongan[counter] !== undefined) {
                potongan1 = dataPotongan[counter].Kod_Trans
                potongan2 = dataPotongan[counter].Butiran
                potongan3 = parseFloat(dataPotongan[counter].Amaun).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                totalPotongan += parseFloat(dataPotongan[counter].Amaun);
            }
            var tr = null;

            tr = $('<tr>')
                .append($('<td>').html(income1))
                .append($('<td>').html(income2))
                .append($('<td style = "border-right:1px solid grey;text-align:right;">').html(income3))
                .append($('<td>').html(potongan1))
                .append($('<td>').html(potongan2))
                .append($('<td style = "text-align:right">').html(potongan3))

            $('#tbllistbody').append(tr);
            counter += 1;
        }
        totalBersih = totalIncome - totalPotongan;
        $('#lblAmaunPendapatan').html(parseFloat(totalIncome).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }));
        $('#lblAmaunPotongan').html(parseFloat(totalPotongan).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }));
        $('#lblAmaunbersih').html(parseFloat(totalBersih).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }));


    }

    async function getIncome(vNostaf) {
        var vBln = $('#hidBulan').text();
        var vThn = $('#hidTahun').text();


        return new Promise((resolve, reject) => {
            $.ajax({
                url: "Mohon_WS.asmx/LoadListIncome",
                method: 'POST',
                data: JSON.stringify({
                    nostaf: vNostaf,
                    tahun: vThn,
                    bulan: vBln
                }),
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
    }

    async function getPotongan(vNostaf) {
        var vBln = $('#hidBulan').text();
        var vThn = $('#hidTahun').text();

        return new Promise((resolve, reject) => {
            $.ajax({
                url: "Mohon_WS.asmx/LoadListPotonganSlip",
                method: 'POST',
                data: JSON.stringify({
                    nostaf: vNostaf,
                    tahun: vThn,
                    bulan: vBln
                }),
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
    }


    //buttton kemaskini ptj
    $('.btnKemaskini').off('click').on('click', async function () {

        $('#transaksi').modal('hide');
        $('#saveConfirmationModal11').modal('show');

        $('#confirmSaveButton11').off('click').on('click', async function () {
            $('#saveConfirmationModal11').modal('hide');

            var UpdateStatusKemaskiniPTJ = {
                txtNoMohonR: $('#hidIdMohon').val(),
                Ulasan: $('#txtUlasan').val()
            };

            try {
                var result = JSON.parse(await ajaxKemaskiniSemakanPTJ(UpdateStatusKemaskiniPTJ));
                if (result.Status === true) {
                    showModal11("Success", result.Message, "success");

                } else {
                    showModal11("Error", result.Message, "error");
                }

            } catch (error) {
                console.error('Error:', error);
                showModal11("Error", "An error occurred during the request.", "error");
            }
        });
    });

    async function ajaxKemaskiniSemakanPTJ(UpdateStatusKemaskiniPTJ) {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: '<%= ResolveClientUrl("Mohon_WS.asmx/KemaskiniPTJ") %>',
                        method: 'POST',
                        data: JSON.stringify(UpdateStatusKemaskiniPTJ),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var response = JSON.parse(data.d);
                            resolve(data.d);
                            notification(response.Message);
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            reject(false);
                        }
                    });
                });
            }

    //$(document).ready(function () {
    //    $("#checkedAll").change(function () {
    //        if (this.checked) {
    //            $(".checkSingle").each(function () {
    //                this.checked = true;
    //            });
    //        } else {
    //            $(".checkSingle").each(function () {
    //                this.checked = false;
    //            });
    //        }
    //    });

    //    $(".checkSingle").click(function () {
    //        if ($(this).is(":checked")) {
    //            var isAllChecked = 0;

    //            $(".checkSingle").each(function () {
    //                if (!this.checked)
    //                    isAllChecked = 1;
    //            });

    //            if (isAllChecked == 0) {
    //                $("#checkedAll").prop("checked", true);
    //            }
    //        }
    //        else {
    //            $("#checkedAll").prop("checked", false);
    //        }
    //    });
    //});

    function ReloadPage() {
        window.location.reload();
    }
    $('.btnSimpan').click(function () {
        var data = {
            data: []
        };
        var vparam = $('.hidParam').html();
        $('.checkROC:checked').each(function () {
            var tr = $(this).closest("tr");
            data.data.push({ NoMohon: tr.find("td:eq(1)").text()})
        });

        if (data.data.length === 0) {
            alert('Sila buat pilihan untuk diproses.');
            return false;
        }
        show_loader();
        $.ajax({
            "url": "Mohon_WS.asmx/SimpanSokong",
            method: 'POST',
            "contentType": "application/json; charset=utf-8",
            "dataType": "json",
            data: JSON.stringify(data),
            success: function (response) {
                console.log('Success', response);
                var response = JSON.parse(response.d);
                console.log(response);
                notification(response.Message);
               // window.location.reload(1);
            }

        });
    });
    ///////// senarai invois
     function loadInvoisLists(dateStart, dateEnd) {
        //console.log('load invois')

        if (!dateEnd) {
            dateEnd = ""
        }
        if (!dateStart) {
            dateStart = ""
        }

        show_loader()
        $.ajax({
            url: '<%= ResolveUrl("Mohon_WS.asmx/LoadListMohon") %>',
        method: "POST",
        data: JSON.stringify({
            DateStart: dateStart,
            DateEnd: dateEnd
        }),
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (data) {
            close_loader()

            data = JSON.parse(data.d)
           // console.log(data);
            tbl.clear();
            
            tbl.rows.add(data.Payload).draw()
        },
        drawCallback: function (settings) {
                // Your function to be called after loading data
                close_loader();
            },
            error: function (xhr, status, error) {
                close_loader()
                console.error(error);
            }
        })
     }

    function dateFilterHandler(e) {
        if (e.target.value == "select") {
            $("#specificDateFilter").show()
        }
        else {
            $("#specificDateFilter").hide()
        }
    }

    function loadPermohonan() {
        if ($("#invoisDateFilter").val() == "select") {
            let dateStart = $("#txtTarikhStart").val()
            let dateEnd = $("#txtTarikhEnd").val()
            if (dateStart == "") {
                dialogMakluman("sila pilih tarikh carian")
                return
            }
            loadInvoisLists(dateStart, dateEnd)
        }
        else if ($("#invoisDateFilter").val() == "all") {
            loadInvoisLists()

        }
        else {
            let days = $("#invoisDateFilter").val()
            let dateString = toSqlDateString(getDateBeforeDays(days))
            loadInvoisLists(dateString, "")
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    function dateStrFromSQl(dateString) {
        try {

            var dateComponents = dateString.split("T")[0].split("-");
            var year = dateComponents[0];
            var month = dateComponents[1];
            var day = dateComponents[2];

            return formattedDate = year + "-" + month + "-" + day;
        }
        catch (e) {
            return ''
        }
    }

    function showError(errors) {
        let msg = ""
        errors.forEach(e => {
            msg += e + "<br>"
        })
        dialogMakluman(msg)
    }

    function dialogPengesahan(msg) {
        $("#dialogConfirmContent").html(msg)
        var decision = false

        return new Promise(function (resolve) {
            $("#modalDialogConfirm").modal('show')

            $('#btnDialogModalConfirm').on('click', function () {
                decision = true // Confirm button clicked
            });
            $('#modalDialogConfirm').on('hidden.bs.modal', function (e) {
                resolve(decision); // Modal closed without confirming
            });

        });
    }

    var queueMakluman = []
    function dialogMakluman(msg) {
        queueMakluman.push(msg)
        if (!$('#modalDialogInfo').hasClass('show')) {
            showDialogMakluman();
        }

    }

    function showDialogMakluman() {

        if (queueMakluman.length > 0) {
            var msg = queueMakluman.shift()
            $("#dialogInfoContent").html(msg)
            $('#modalDialogInfo').modal('show');

            $('#modalDialogInfo').one('hidden.bs.modal', function () {
                showDialogMakluman(); // Process the next alert after the modal is closed 
            });
        }
    }

    function show_message_async(msg) {
        $("#MessageModal .modal-body").html(msg);
        var decision = false
        return new Promise(function (resolve) {

            $('.btnYA').click(function () {
                console.log("rreessoollvveedd")
                decision = true
            });
            $("#MessageModal").on('hidden.bs.modal', function () {
                resolve(decision);
            });


            $("#MessageModal").modal('show');
        })

    }

    function toSqlDateString(date) {
        let dd = date.getDate();
        let mm = date.getMonth() + 1; // January is 0!
        let yyyy = date.getFullYear();

        if (dd < 10) {
            dd = '0' + dd;
        }

        if (mm < 10) {
            mm = '0' + mm;
        }

        return yyyy + '-' + mm + '-' + dd;
    }

    function getDateBeforeDays(days) {
        let pastDate = new Date();
        pastDate.setDate(pastDate.getDate() - days);
        return pastDate;
    }

    //buttton lulus
    $('.btnLulus').off('click').on('click', async function () {
        var msg = "Anda pasti ingin meluluskan permohonan potongan staf ini?";
        $('#confirmationMessage10').text(msg);
        $('#transaksi').modal('hide');
        $('#saveConfirmationModal10').modal('show');

        $('#confirmSaveButton10').off('click').on('click', async function () {
            $('#saveConfirmationModal10').modal('hide');
            //alert($('#hidIdMohon').val());
            var UpdateStatusSokong = {
                txtNoMohonR: $('#hidIdMohon').val(),

            };

            try {
                var result = JSON.parse(await ajaxLulusPermohonan1(UpdateStatusSokong));
                if (result.Status === true) {
                    showModal10("Success", result.Message, "success");
                    tbl.ajax.reload();

                } else {
                    showModal10("Error", result.Message, "error");
                }
            } catch (error) {
                console.error('Error:', error);
                showModal1("Error", "An error occurred during the request.", "error");
            }
        });
    });

    async function ajaxLulusPermohonan1(UpdateStatusSokong) {
        return new Promise((resolve, reject) => {
            //alert('masuk');
            $.ajax({
                url: '<%= ResolveClientUrl("Mohon_WS.asmx/PtjLulusPermohonan") %>',
              method: 'POST',
                data: JSON.stringify(UpdateStatusSokong),
              dataType: 'json',
              contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var response = JSON.parse(data.d);
                  resolve(data.d);
                  notification(response.Message);
              },
              error: function (xhr, textStatus, errorThrown) {
                  console.error('Error:', errorThrown);
                  reject(false);
              }
          });
      });
  }
</script>
</asp:Content>
