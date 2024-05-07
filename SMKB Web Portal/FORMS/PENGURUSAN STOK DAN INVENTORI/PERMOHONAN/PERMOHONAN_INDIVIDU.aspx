<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PERMOHONAN_INDIVIDU.aspx.vb" Inherits="SMKB_Web_Portal.PERMOHONAN_INDIVIDU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"
        crossorigin="anonymous"></script>


    <style>
        .nospn {
            -moz-appearance: textfield;
        }

            .nospn::-webkit-outer-spin-button,
            .nospn::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }



        /*#permohonan .modal-body {
            max-height: 70vh;*/
            /* Adjust height as needed to fit your layout */
            /*min-height: 70vh;
            overflow-y: scroll;
            scrollbar-width: thin;
        }*/

        #subTab a {
            cursor: pointer;
        }

        .error-border,
.error-border select {
    border: 1px solid red;
}


        #tblData {
            margin: 0 auto;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .sticky-col-start {
            position: sticky;
            left: 0;
            box-sizing: border-box !important;
        }

        .col-ddl:focus-within {
            z-index: 1;
        }

        .sticky-col-end {
            position: sticky;
            right: 0;
            box-sizing: border-box !important;
        }

        .left-200 {
            left: 200px;
        }

        .right-50 {
            right: 50px;
        }

        .spn-ddl-dtl {
            display: none;
        }

        .ddlKodVot:focus-within .spn-ddl-dtl {
            display: inline-block;
        }

        .spn-dtl {
            width: 100%;
            cursor: pointer;
        }

            .spn-dtl::after {
                top: 0;
                font-size: .8em;
                line-height: 1em;
                vertical-align: text-top;
                content: "\f05a";
                /* Unicode for the FontAwesome icon you want to use */
                font-family: FontAwesome;
                /* Specify the font family */
                margin-left: 2px;
                /* Adjust as needed for spacing */
            }
            .inv-only{
                display:none;
            }
    </style>
    <link rel="stylesheet" />
    <contenttemplate>

        <%--<form id="form1" runat="server">--%>
        <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <%-- div permohonan --%>
            <div id="divpermohonanindv" runat="server" visible="true">
                <div class="modal-body">
                     <div class="table-title">
                        <h5>Maklumat Pemohon</h5>
                         <hr />
                         <div class="btn btn-primary btnPapar" id="senaraiPermohonan" onclick="ShowPopup('2')">
                            Senarai Permohonan
                        </div>
                    </div>
                    <div class="row">
                       <div class="col-md-12">
                          <div class="row">
                              <div class="col-md-12"></div>
                               <div class=" col-md-4">
                                   <div class="form-group input-group">
                                      <input type="text" id= "id_staff" class="input-group__input form-control input-sm " placeholder="" name="" value="" readonly disabled />
                                      <label class="input-group__label">No.Staf</label>
                                   </div>
                                </div>
                             <div class=" col-md-4">
                                <div class="form-group input-group">
                                   <input id="namaPemohon" type="text" class=" input-group__input form-control input-sm" placeholder="" readonly disabled />
                                   <label class="input-group__label">Nama</label>
                                </div>
                             </div>
                              
                             <div class="col-md-4">
                               <div class="form-group input-group">
                                  <input type="text" id="ptj" class="input-group__input form-control input-sm" placeholder="" name="" value="" readonly disabled />
                                  <label class="input-group__label">PTj</label>
                               </div>
                            </div>
                             <div class="col-md-4">
                                <div class="form-group input-group">
                                   <input type="text" id="tarikhMohon" class="input-group__input form-control input-sm" placeholder="" name="" value="" readonly disabled />
                                   <label class="input-group__label">Tarikh Mohon</label>
                                </div>
                             </div>
                              <div class=" col-md-4">
                               <div class="form-group input-group">
                                  <input type="text" id="idMohon" class="input-group__input form-control input-sm" placeholder="" name="" value="" readonly disabled />
                                  <label class="input-group__label">Id.Mohon</label>
                               </div>
                            </div>
                            <div class=" col-md-4" >
                                <div class="form-group input-group" style="visibility:hidden">
                                    <input type="text" id="IdMohonDtl" class="input-group__input form-control input-sm" placeholder="" name="" value="" readonly disabled />
                                    <label class="input-group__label">IdMohonDtl</label>
                                </div>
                            </div>
                          </div>
                       </div>
                    </div>
                    <hr />
                    <div class="table-title">
                        <h5>Butiran Permohonan</h5>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group input-group">
                                <select class=" input-group__select ui search dropdown"
                                    placeholder="" name="kategori" id="kategori" required>
                                    <option value="" disabled selected></option>
                                </select>
                                <label class="input-group__label">Kategori<span style="color:red">*</span></label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group input-group">
                                <select
                                    class=" input-group__input form-control input-sm ui search dropdown"
                                    name="senaraiBekalan" id="senaraiBekalan" required>
                                    <option value="" disabled selected></option>
                                </select>
                                <label class="input-group__label">Senarai Bekalan<span style="color:red">*</span></label>
                            </div>
                        </div>
                         <div class="col-md-3">
                             <div class="form-group input-group">
                                 <input type="text"
                                     class=" input-group__input form-control input-sm "
                                     placeholder="" id="bakistok" name="txtbakistok" readonly disabled/>
                                 <label class="input-group__label">Baki Stok</label>
                             </div>
                         </div>
                         <div class="col-md-3">
                             <div class="form-group input-group">
                                 <input type="text"
                                     class="input-group__input form-control input-sm "
                                     placeholder="" id="txtkuantitiMohon" name="txtkuantitiMohon" required />
                                 <label class="input-group__label">Kuantiti Mohon<span style="color:red">*</span></label>
                             </div>
                         </div>
                         <div class="col-md-6">
                             <div class="form-group input-group">
                                 <textarea id="txtTujuan" class="input-group__input form-control"
                                     name="message" rows="2" placeholder="" required></textarea>
                                 <label class="input-group__label">Tujuan Kegunaan<span style="color:red">*</span></label>
                             </div>
                         </div>
                    </div>
                    <hr />

                    <div class="table-title">
                       <h5>Senarai Barang</h5>
                    </div>
                    <div class="modal-body">
                       <div class="col-md-13">
                          <div class="transaction-table table-responsive">
                             <span style="display: inline-block; height: 100%;"></span>
                             <table id="tblSenaraiBarang" class="table table-striped" style="width:100%">
                                <thead>
                                   <tr >
                                      <th scope="col" style="width: 5%">No</th>
                                      <th scope="col" style="width: 25%">Nama Barang</th>
                                      <th scope="col" style="width: 25%">Tujuan</th>
                                      <th scope="col" style="width: 25%">Kuantiti</th>
                                      <th scope="col" style="width: 25%">U.Ukuran</th>
                                   </tr>
                                </thead>
                                <tbody>
                                   <tr class="table-list">
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
                </div>

                <div class="sticky-footer">
                    <br />
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <div class="float-right">
                                <button type="button" class="btn btn-setsemula"
                                    onclick="btnReset()" id="resetBtn">
                                    Rekod Baru</button>

                                 <button type="button" class="btn btn-secondary"
                                    id="simpanDrafBtn">
                                     Simpan Draf</button>
                                <button type="button" class="btn btn-success"
                                     id="simpanHantarBtn">
                                    Simpan dan Hantar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan</h5>
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
                                                <option value="">SEMUA</option>
                                                <option value="1" selected="selected">Hari Ini</option>
                                                <option value="2">Semalam</option>
                                                <option value="3">7 Hari Lepas</option>
                                                <option value="4">30 Hari Lepas</option>
                                                <option value="5">60 Hari Lepas</option>
                                                <option value="6">Pilih Tarikh</option>
                                            </select>
                                            <button id="btnSearch" class="btn btnSearch btn-outline"
                                                type="button">
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
                                    <div class="col-sm-10 mt-4 d-none" id="divDatePicker">
                                        <div class="d-flex flex-row justify-content-around align-items-center">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label text-nowrap">Mula:</label>
                                                <div class="col-sm-9">
                                                    <input type="date" id="tkhMula" name="tkhMula" class="form-control date-range-filter">
                                                </div>
                                            </div>

                                            <div class="form-group row ml-3">
                                                <label class="col-sm-3 col-form-label text-nowrap">Tamat:</label>
                                                <div class="col-sm-9">
                                                    <input type="date" id="tkhTamat" name="tkhTamat" class="form-control date-range-filter">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 ">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblSenaraiPermohonan" class="table table-striped" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th style="width:10%" >No</th>
                                                    <th style="width:10%" >Tkh. Mohon</th>
                                                    <th style="width:10%" >Id. Mohon</th>
                                                    <th style="width:10%" >Kuantiti Mohon</th>
                                                    <th style="width:10%" >Kuantiti Lulus</th>
                                                    <th style="width:10%" >Status Dok</th>
                                                    <th style="width:10%" >Status</th>
                                                </tr>
                                            </thead>
                                            <tbody id="">
                                               <tr style="width: 100%" class="table-list">
                                                  <td style="width: 15%"></td>
                                                  <td style="width: 15%"></td>
                                                  <td style="width: 30%"></td>
                                                  <td style="width: 25%"></td>
                                                  <td style="width: 15%"></td>
                                                  <td style="width: 15%"></td>
                                                  <td style="width: 15%"></td>
                                               </tr>
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
        <!--modal total end-->
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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="../../../Content/js/SharedFunction.js"></script>
        <script type="text/javascript" src="../../../Content/js/xlsx.full.min.js"></script>
        <script type="text/javascript">
           
        // Trigger the AJAX request when the page finishes loading
        $.ajax({
            url: "PERMOHONAN_INDIVIDUWS.asmx/fetchUserInfo",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                // Parse the JSON string within the "d" property
                var responseData = JSON.parse(response.d);
                // Check if responseData is an array and has at least one element
                if (Array.isArray(responseData) && responseData.length > 0) {
                    // Access the properties of the first element
                    $("#namaPemohon").val(responseData[0].MS01_Nama);
                    $("#id_staff").val(responseData[0].MS01_NoStaf);
                    $("#ptj").val(responseData[0].MS08_Pejabat + "0000" + " - " + responseData[0].Pejabat);
                    var kod_Ptj = responseData[0].MS08_Pejabat + "0000";
                    populateSenaraiBekalan(kod_Ptj);
                    var currentDate = new Date().toISOString().slice(0, 10); //current date
                    $("#tarikhMohon").val(currentDate);

                }
            },
            error: function (error) {
                console.error(error.responseText); // Access the error message directly
            }
        });

            function populateKategori() {
                $.ajax({
                    url: "PERMOHONAN_INDIVIDUWS.asmx/fetchKategori",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // Parse the JSON string within the "d" property
                        var responseData = JSON.parse(response.d);
                        // Check if responseData is an array and has at least one element
                        if (Array.isArray(responseData) && responseData.length > 0) {
                            // Access the properties of the first element
                            var ddlKategori = $("#kategori");

                            ddlKategori.empty();
                            //ddlKategori.append($("<option></option>").text("Pilih Jenis Kategori"));


                            responseData.forEach(function (item) {
                                var optionText = item.kategori;
                                ddlKategori.append($("<option></option>").val(item.Kod_Detail).text(optionText));
                            })
                            //ddlKategori.dropdown();
                            ddlKategori.prepend($("<option disabled selected></option>").text("Pilih Jenis Kategori"));

                        }
                    },
                    error: function (error) {
                        console.error(error.responseText); // Access the error message directly
                    }
                });
            }
            populateKategori();


            function populateSenaraiBekalan(kod_Ptj) {
                debugger
                $.ajax({
                    url: "PERMOHONAN_INDIVIDUWS.asmx/fetchSenaraiBekalan",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ kod_Ptj: kod_Ptj }),
                    dataType: "json",
                    success: function (response) {
                        // Parse the JSON string within the "d" property
                        var responseData = JSON.parse(response.d);
                        // Check if responseData is an array and has at least one element
                        if (Array.isArray(responseData) && responseData.length > 0) {

                            // Access the properties of the first element
                            var ddlSenaraiBekalan = $("#senaraiBekalan");

                            ddlSenaraiBekalan.empty();
                            responseData.forEach(function (item) {
                                var optionText = item.Kod_Brg + " - " + item.SenaraiBekalan;
                                ddlSenaraiBekalan.append($("<option></option>").val(item.Kod_Brg).text(optionText));
                            });
                            //ddlSenaraiBekalan.dropdown();
                            ddlSenaraiBekalan.prepend($("<option disabled selected></option>").text("Pilih Jenis Barang"));


                            // Set initial value for bakistok
                            $("#bakistok").val("");


                            // Add onChange event handler to dropdown
                            ddlSenaraiBekalan.on('change', function () {
                                var selectedValue = $(this).val();
                                // Find the corresponding item in responseData
                                var selectedItem = responseData.find(function (item) {
                                    return item.Kod_Brg == selectedValue;
                                });
                                if (selectedItem) {
                                    // Update bakistok field with the selected item's Baki_Unit
                                    $("#bakistok").val(selectedItem.Total_Baki_Unit);
                                }
                            });
                        }
                    },
                    error: function (error) {
                        console.error(error.responseText); // Access the error message directly
                    }
                });
            }
            

        //untuk pop up senarai permohonan
        function ShowPopup(elm) {
            if (elm == "1") {

                $('#permohonan').modal('toggle');
            }
            else if (elm == "2") {
                $('#tblSenaraiPermohonan').DataTable().clear().draw();
                $(".modal-body div").val("");
                $('#permohonan').modal('toggle');


            }
        }

            function btnReset() {
                // Clear all input fields
                window.location.reload();
            }



            function clearFields() {
                // Clear all input fields - when user click button simpan draf
                $('#IdMohonDtl').val('');
                $('#txtkuantitiMohon').val('');
                $('#txtTujuan').val('');

            }

            //clear field when user click permohonan from table senarai permohonan
            function clearFields3() {
                $('#IdMohonDtl').val('');
                $('#txtkuantitiMohon').val('');
                $('#bakistok').val('');
                $('#txtTujuan').val('');

            }

            function clearFields2() {
                // Clear all input fields - simpan dan hantar
                $('#idMohon').val('');
                $('#IdMohonDtl').val('');
                $('#txtkuantitiMohon').val('');
                $('#bakistok').val('');
                $('#txtTujuan').val('');

            }

            $('#simpanDrafBtn').click(function () {

                validateForm();

            });


            $('#simpanHantarBtn').click(function () {
                var IdMohon;
                simpanDanHantar(IdMohon);

            });



            function simpanDanHantar(IdMohon) {
                var kod_Ptj = $('#ptj').val().split(" - ")[0];
                var IdMohon = $("#idMohon").val();

                var data = {
                    kod_Ptj: kod_Ptj,
                    IdMohon: IdMohon
                };

                show_message_async("Adakah anda pasti untuk menghantar permohonan ini?").then(function (confirmed) {
                    if (confirmed) {
                        $.ajax({
                            url: "PERMOHONAN_INDIVIDUWS.asmx/SimpanDanHantar",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(data),
                            dataType: "json",
                            success: function (response) {
                                debugger
                                var data = JSON.parse(response.d);
                                if (data.Code === "00") {
                                    notification("Permohonan Berjaya");
                                    $('#NotifyModal').one('hidden.bs.modal', function () {
                                        window.location.reload();
                                    });
                                } else {
                                    notification("Permohonan Gagal");
                                }
                            },
                            error: function (xhr, status, error) {
                                console.log(xhr.responseText);
                                alert("An error occurred while saving data.");
                            }
                        });
                        

                    }
                });
            }

            function simpanMaklumat(action) {
                
                var kod_Ptj = $('#ptj').val().split(" - ")[0];
                var senaraiBekalan = $("#senaraiBekalan").val();
                var kuantitiMohon = $("#txtkuantitiMohon").val();
                var tujuan = $("#txtTujuan").val();
                var No_Mohon = $("#idMohon").val();
                var ID_Mohon_Dtl = $("#IdMohonDtl").val();

                if (No_Mohon === "") {

                    var data = {
                        kod_Ptj: kod_Ptj,
                        senaraiBekalan: senaraiBekalan,
                        kuantitiMohon: kuantitiMohon,
                        tujuan: tujuan,
                        action: action,
                    };

                    $.ajax({
                        url: "PERMOHONAN_INDIVIDUWS.asmx/SubmitPermohonanIndividu",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(data),
                        dataType: "json",
                        success: function (response) {
                            var data = JSON.parse(response.d);
                            if (data.Code === "00") {
                                $('#successModal').modal('show');
                                $("#idMohon").val(data.Payload.IdMohon);
                                simpanMaklumat2(data.Payload.IdMohon)

                            }
                            else {
                                alert("Gagal simpan maklumat.");
                            }
                            
                        },

                        error: function (xhr, status, error) {
                            console.log(xhr.responseText);
                            alert("An error occurred while saving data.");
                        }
                    });
                }

                // dah ada idMohon
                else {

                    var data = {
                        kod_Ptj: kod_Ptj,
                        senaraiBekalan: senaraiBekalan,
                        kuantitiMohon: kuantitiMohon,
                        tujuan: tujuan,
                        action: action,
                        No_Mohon: No_Mohon,
                        ID_Mohon_Dtl: ID_Mohon_Dtl
                    };

                    $.ajax({
                        url: "PERMOHONAN_INDIVIDUWS.asmx/SubmitPermohonanIndividuID",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(data),
                        dataType: "json",
                        success: function (response) {
                            var data = JSON.parse(response.d);
                            if (data.Code === "00") {
                                $('#successModal').modal('show');
                                $("#idMohon").val(data.Payload.IdMohon);
                                simpanMaklumat2(data.Payload.IdMohon)


                            }
                            else {
                                alert("Gagal simpan maklumat.");
                            }
                            
                        },

                        error: function (xhr, status, error) {
                            console.log(xhr.responseText);
                            alert("An error occurred while saving data.");
                        }
                    });
                }
            }

            var tbl = null;
            function simpanMaklumat2(IdMohon) {
                
                tbl = $("#tblSenaraiBarang").DataTable({
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
                        "url": "PERMOHONAN_INDIVIDUWS.asmx/LoadSenaraiBarang",
                        type: 'POST',
                        data: function (d) {
                            return "{ IdMohon: '" + IdMohon + "'}";
                        },
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            console.log("Data from server:", json.d);

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
                        { "data": "tujuan" },
                        { "data": "Kuantiti_Mohon" },
                        { "data": "KodButiran" }
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


        //load senarai permohononan from database
        var tbl2 = null
        var isClicked = false;
            var category_filter, startDate, endDate;

            $(document).ready(function () {


                tbl2 = $("#tblSenaraiPermohonan").DataTable({

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
                "ajax":
                {
                    "url": "PERMOHONAN_INDIVIDUWS.asmx/LoadSenaraiPermohonan",
                    type: 'POST',
                    data: function (d) {
                        var kod_Ptj = $('#ptj').val().split(" - ")[0];

                        return "{ category_filter: '" + category_filter + "',isClicked: '" + isClicked + "',tkhMula: '" + startDate + "',tkhTamat: '" + endDate + "', kod_Ptj: '" + kod_Ptj + "'}";
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
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
                    { "data": "Tkh_Mohon" },
                    { "data": "No_Mohon" },
                    { "data": "Total_Kuantiti_Mohon" },
                    { "data": "Kuantiti_Lulus" },
                    { "data": "Status_Dok" },
                    {
                        "data": "Status",
                        "render": function (data, type, row) {
                            if (data === "1") {
                                return "Aktif";
                            } else if (data === "0") {
                                return "Tidak Aktif";
                            } else {
                                return data;
                            }
                        }

                    }
                ],



                "rowCallback": function (row, data) {// Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },


                });



                $('#tblSenaraiPermohonan tbody').on('click', 'tr', function () {
                
                    var data = tbl2.row(this).data(); //get data from clicked row
                    console.log(data); // Check the structure of the data

                    var idMohon = data['No_Mohon']; //extract the idMohon from the clickable row

                    $('#permohonan').modal('hide');

                    clearFields3();
                    populateKategori();
                    populateSenaraiBekalan();



                    $.ajax({
                        url: "PERMOHONAN_INDIVIDUWS.asmx/GetPermohonanDetails",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ idMohon: idMohon }),
                        dataType: "json",
                        success: function (response) {
                            var data = JSON.parse(response.d);

                            // Populate form fields with the retrieved data
                            $('#idMohon').val(data[0].No_Mohon);

                        },
                        error: function (xhr, status, error) {
                            console.error(xhr.responseText);
                            alert("Gagal papar maklumat.");
                        }
                    })

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
                    tbl2.ajax.reload();
                })

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
                
            });


           


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

            $(document).ready(function () {

                // Event listener for clicking table rows in tblSenaraiPermohonan
                $('#tblSenaraiPermohonan tbody').on('click', 'tr', function () {

                
                
                    var data = tbl2.row(this).data(); // Get data from clicked row
                    var IdMohon = data.No_Mohon; // Extract idMohon from the clickable row
                    var status_dok = data.Status_Dok;

                    if (status_dok === "DRAF PERMOHONAN") {
                        $('#simpanDrafBtn').show();
                        $('#simpanHantarBtn').show();

                    } else {
                        $('#simpanDrafBtn').hide();
                       $('#simpanHantarBtn').hide();

                    }

                    $('#permohonan').modal('hide');
                    $('#tblSenaraiPermohonan').DataTable().clear().draw();

                    //fetch data for tblSenaraiBarang
                    simpanMaklumat2(IdMohon)
                });
            });

             $('#tblSenaraiBarang tbody').on('click', 'tr', function () {
                //debugger
                var data = tbl.row(this).data(); //get data from clicked row
                var ID_Mohon_Dtl = data['ID_Mohon_Dtl']; //extract the idMohonDtl from the clickable row
                var IdMohon = data['No_Mohon'];

                $.ajax({
                    url: "PERMOHONAN_INDIVIDUWS.asmx/LoadBarangById",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ ID_Mohon_Dtl: ID_Mohon_Dtl, IdMohon: IdMohon}),
                    dataType: "json",
                    success: function (response) {
                        //debugger
                        var data = JSON.parse(response.d);

                        if (data.length > 0) {
                            // Populate form fields with the retrieved data
                            $('#kategori').val(data[0].kategori).trigger('change');
                            $('#senaraiBekalan').val(data[0].Kod_Brg).trigger('change');
                            $('#bakistok').val(data[0].Baki_Unit);
                            $('#txtkuantitiMohon').val(data[0].Kuantiti_Mohon);
                            $('#txtTujuan').val(data[0].Tujuan);

                            //
                            $('#IdMohonDtl').val(ID_Mohon_Dtl);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error(xhr.responseText);
                        alert("Gagal papar maklumat.");
                    }
                })
            });


            function validateForm() {
                var kategori = $("#kategori");
                var senaraiBekalan = $("#senaraiBekalan");
                var kuantitiMohon = $("#txtkuantitiMohon");
                var tujuan = $("#txtTujuan");

                if (kategori.val() === "") {
                    kategori.addClass("error-border");
                } else {
                    kategori.removeClass("error-border");
                }

                if (senaraiBekalan.val() === "") {
                    senaraiBekalan.addClass("error-border");
                } else {
                    senaraiBekalan.removeClass("error-border");
                }

                if (kuantitiMohon.val() === "") {
                    kuantitiMohon.addClass("error-border");
                } else {
                    kuantitiMohon.removeClass("error-border");
                }

                if (tujuan.val() === "") {
                    tujuan.addClass("error-border");
                } else {
                    tujuan.removeClass("error-border");
                }

                // Check if any field is empty
                if (kategori.val() === "" || senaraiBekalan.val() === "" || kuantitiMohon.val() === "" || tujuan.val() === "") {
                    notification("Sila isi ruang bertanda *");
                } else {
                    // All fields are filled, proceed with form submission or any other action
                    simpanMaklumat('Simpan Draf');
                    clearFields();
                    populateKategori();
                    populateSenaraiBekalan();
                }
            }

        </script>
</asp:Content>
