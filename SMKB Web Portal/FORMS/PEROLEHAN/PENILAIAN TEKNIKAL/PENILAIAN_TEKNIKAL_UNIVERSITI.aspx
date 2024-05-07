<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PENILAIAN_TEKNIKAL_UNIVERSITI.aspx.vb" Inherits="SMKB_Web_Portal.PENILAIAN_TEKNIKAL_UNIVERSITI" %>


<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
        .containerSenaraiSebutHarga {
            border: 1px solid #dddddd;
            padding: 1rem;
            margin-top: 1rem;
            background-color: #f0f0f0;
            border-radius: 10px;
            content: 'drag me';
        }

        .draggable label {
            font-size: 10px;
        }

        .draggable {
            will-change: transform;
            border: 1px solid #b6b6b6;
            border-radius: 15px;
            list-style-type: none;
            margin: 10px;
            background-color: white;
            width: 100%;
            cursor: move;
            transition: all 200ms;
            user-select: none;
            margin: 10px auto;
            position: relative;
            padding: 5px;
        }

            .draggable:after {
                content: 'drag me';
                color: #0072ff;
                font-weight: 900;
                right: 7px;
                font-size: 10px;
                position: absolute;
                cursor: pointer;
                line-height: 5;
                transition: all 200ms;
                transition-timing-function: cubic-bezier(0.48, 0.72, 0.62, 1.5);
                transform: translateX(120%);
                opacity: 0;
            }

            .draggable:hover:after {
                opacity: 1;
                transform: translate(0);
            }
    </style>

    <style>
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

        #tblDataSenarai_trans td:hover {
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

        .dropdown-list {
            width: 100%;
            /* You can adjust the width as needed */
        }

        .secondaryContainer {
            overflow: visible !important;
        }
    </style>


    <div id="pendaftaranTab" class="tabcontent" style="display: block">

        <div class="">
            <div class="table-title mt-3">
                <h5>Maklumat Pendaftaran Mesyuarat</h5>
            </div>

            <hr>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-row">

                        <div class="form-group col-md-3">
                            <input class="input-group__input " id="txtIdMesy" type="text" placeholder="&nbsp;" name="ID Mesyuarat" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="ID Mesyuarat">ID Mesyuarat</label>
                        </div>


                        <div class="form-group col-md-6">
                            <select class="input-group__select ui search dropdown JenTransaksi" name="JawatankuasaData" id="JawatankuasaData" placeholder="&nbsp;">
                            </select>
                            <label class="input-group__label" for="PanelJaw">Jawatankuasa</label>
                        </div>

                    </div>
                </div>

                <div class="col-md-12" style="margin-top: 5px">
                    <div class="form-row">

                        <div class="form-group col-md-2">
                            <input class="input-group__input form-control " id="txtTarikh" type="date" placeholder="&nbsp;" name="Tarikh Mesyuarat" />
                            <label class="input-group__label" for="Tarikh Mesyuarat">Tarikh Mesyuarat</label>
                        </div>

                        <div class="form-group col-md-2">
                            <input class="input-group__input form-control " id="txtMasa" type="time" placeholder="&nbsp;" name="masa" />
                            <label class="input-group__label" for="masa">masa</label>
                        </div>

                    </div>
                    <div class="form-row">

                        <div class="form-group col-md-9">
                            <input class="input-group__input form-control " id="txtTempat" type="text" placeholder="&nbsp;" name="Tempat :" />
                            <label class="input-group__label" for="Perihal">Tempat</label>
                        </div>

                    </div>
                </div>

                <h6 class="m-3">Senarai Sebut Harga/TD</h6>
                <%--<div class="col-md-12">
                    <div class="secondaryContainer transaction-table table-responsive">

                        <table id="tblDataSenaraiSebutHarga" class="table table-striped" style="width: 95%">
                            <thead>
                               <tr>
                                    <th class="text-center" scope="col">Bil</th>
                                    <th class="text-center" scope="col">No. Permohonan</th>
                                    <th class="text-center" scope="col">Tujuan</th>
                                    <th class="text-center" scope="col">Tarikh Lulus</th>
                                    <th class="text-center" scope="col">PTJ</th>
                                    <th class="text-center" scope="col">Turutan Pembentangan</th>
                                </tr>
                            </thead>
                            <tbody >
        
                            </tbody>

                        </table>
                      

                    </div>
                </div>--%>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <h6 style="position: absolute; background: white; margin-left: 5px; padding: 5px 5px 0px 5px; border-radius: 10px;">Senarai Mesyuarat</h6>
                <div style="position: absolute; top: 60px; text-align: center; width: 100%; color: #c1c1c1;">
                    <i>Tiada Rekod.</i>
                </div>
                <div style="min-height: 123px;" class="containerSenaraiSebutHarga js-containerSenaraiSebutHarga-right">

                    <%--<div class="draggable row" draggable="true" ondragstart="drag(event)" id="drag1">
                   
                     <div class="col-4">
                       <label >No. Permohonan</label>
                       <div>BS4100000002140923</div>
                     </div>
                     <div class="col-6">
                       <label>Tujuan</label>
                       <div>Pembelian alat tulis untuk pelajar UTeM.</div>
                     </div>
                     <div class="col-2">
                       <label >PTJ</label>
                         <div>030000</div>
                     </div>
                 </div>
                 <div class="draggable" draggable="true" ondragstart="drag(event)" id="drag2">SCSS</div>
                 <div class="draggable" draggable="true" ondragstart="drag(event)" id="drag3">HTML5</div>
                 <div class="draggable" draggable="true" ondragstart="drag(event)" id="drag4">Awesome DnD</div>
                 <div class="draggable" draggable="true" ondragstart="drag(event)" id="drag5">Follow me</div>--%>
                </div>
            </div>
            <div class="col-md-6">
                <h6 style="position: absolute; background: white; margin-left: 5px; padding: 5px 5px 0px 5px; border-radius: 10px;">Senarai Daftar Mesyuarat</h6>
                <div style="position: absolute; top: 60px; text-align: center; width: 100%; color: #c1c1c1;">
                    <i>Drop Here</i>
                </div>
                <div style="min-height: 123px;" class="containerSenaraiSebutHarga js-right-container" id="dropTarget"></div>
            </div>



        </div>

        <div class="draggable row data-template" draggable="true" id="dragDummy" style="display: none;">
            <div class="col-md-4">
                <label>No. Permohonan</label>
                <div class="js-no-permohonan"></div>
            </div>
            <div class="col-md-6">
                <label>Tujuan</label>
                <div class="js-tajuk"></div>
            </div>
            <div class="col-md-2">
                <label>PTJ</label>
                <div class="js-ptj"></div>
            </div>

            <input hidden id="indexNum" />
        </div>


        <div class="">
            <div class="table-title mt-3">
                <h5>Senarai Jawatankuasa</h5>
            </div>

            <hr>
            <div class="row">
                <!--<h6 class="m-3">Senarai Sebut Harga/TD</h6>-->
                <div class="col-md-12">
                    <div class=" transaction-table table-responsive">
                        <table id="tblDataSenaraiJawatankuasaLuar" class="table table-striped">
                            <thead>
                                <tr>
                                    <th class="text-center" scope="col">Bil</th>
                                    <th class="text-center" scope="col">No Staf</th>
                                    <th class="text-center" scope="col">Nama</th>
                                    <th class="text-center" scope="col">PTJ</th>
                                    <th class="text-center" scope="col">Jawatan</th>
                                    <th class="text-center" scope="col">Email</th>
                                    <th class="text-center" scope="col"></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>

                    </div>
                </div>
                <div class="col text-center m-3">
                    <button type="button" id="btnSimpanInfo" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                </div>

            </div>
        </div>

    </div>

    <!-- Start Modal -->
    <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenterTitle">Maklumat Lanjut</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <!-- Create the dropdown filter -->
                <div class="search-filter">
                    <div class="form-row justify-content-center">
                        <div class="form-group row col-md-8">
                            <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Carian :</label>
                            <div class="col-sm-8">
                                <div class="input-group">

                                    <div class="form-group">
                                        <input class="input-group__input form-control " id="cexttxtTarikh" type="text" placeholder="&nbsp;" name="Tarikh Mesyuarat" />
                                        <label class="input-group__label" for="Tarikh Mesyuarat">Jabatan </label>
                                    </div>

                                    <select id="categoryFilter" class="custom-select mx-3">
                                        <option value="1" selected="selected">Name</option>
                                        <option value="2">No Staf</option>
                                        <option value="3">PTJ</option>
                                    </select>


                                    <button id="Button1" runat="server" class="btn btn-outline btnSearch" type="button">
                                        <i class="fa fa-search"></i>
                                        Cari
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
                            <div class="col-md-11">
                                <div class="form-row">
                                    <div class="form-group col-md-1">
                                        <label id="lblMula" style="text-align: right; display: none;">Mula: </label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display: none;" class="form-control date-range-filter">
                                    </div>
                                    <div class="form-group col-md-1">
                                    </div>
                                    <div class="form-group col-md-1">
                                        <label id="lblTamat" style="text-align: right; display: none;">Tamat: </label>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display: none;" class="form-control date-range-filter">
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="" class="table table-striped" style="width: 95%">
                                <thead>
                                    <tr>
                                        <th scope="col">Bil</th>
                                        <th scope="col">No Staf</th>
                                        <th scope="col">Nama</th>
                                        <th scope="col">KodPtj</th>
                                        <th scope="col">Jawatan Kuasa</th>
                                        <th scope="col">Emel</th>
                                        <th scope="col">Tindakan</th>

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
    <!-- End Modal -->

    <!-- Modal Pengesahan-->
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
                    <button type="button" class="btn btn-secondary" id="confirmSaveButton1">Ya</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="resultModal1" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true" data-target="#staticBackdrop">
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="relodePage()">Tutup</button>
                </div>
            </div>
        </div>
    </div>





    <script type="text/javascript">

        function relodePage() {
            location.reload();
        }

        var KodPTj = '<%= Session("ssusrKodPTj") %>';

        //Insert data with bootstrap modal
        $('#btnSimpanInfo').off('click').on('click', async function () {


            // Set message in the modal
            var msg = "Anda pasti ingin menyimpan rekod ini?(maklumat perolehan)";
            $('#confirmationMessage1').text(msg);
            // Open the Bootstrap modal
            $('#saveConfirmationModal1').modal('show');

            $('#confirmSaveButton1').off('click').on('click', async function () {
                $('#saveConfirmationModal1').modal('hide'); // Hide the modal

                console.log("sebelum JawatankuasaData =", $('#JawatankuasaData').val())
                var JawatankuasaValue = $('#JawatankuasaData').val();
                var Jawatankuasa_kod = KodJawatanKuas;
                console.log("Jawatankuasa_kod selepas=", Jawatankuasa_kod);

                var tTarikh = $('#txtTarikh').val();
                var tMasa = $('#txtMasa').val();
                var tTempat = $('#txtTempat').val();

                var newPerolehan_Mesyuarat_Hdr = {
                    Perolehan_Mesyuarat_Header: {
                        ddlTarikh: $('#txtTarikh').val(),
                        ddlMasa: $('#txtMasa').val(),
                        ddlTempat: $('#txtTempat').val(),
                        ddlJawatankuasa_kod: Jawatankuasa_kod,
                        ddlKodPTj: KodPTj,
                    }
                }

                var result = JSON.parse(await ajaxSavePerolehan_Mesyuarat_Hdr(newPerolehan_Mesyuarat_Hdr));

                if (result.Status === true) {
                    showModal1("Success", result.Message, "success");
                    //$('#txtNoMohon').val(result.Payload.txtNoMohon);
                    //$('#txtNoPO').val(result.Payload.txtNoPO);
                } else {
                    showModal1("Error", result.Message, "error");
                }

                const dropTarget = document.getElementById("dropTarget");
                const draggableElements = dropTarget.querySelectorAll(".draggable");

                draggableElements.forEach(async (element, index) => {
                    const itemData = JSON.parse(element.dataset.itemData); // Example of retrieving structured data

                    console.log("itemData:", itemData);
                    const noPermohonan = itemData.noPermohonan;
                    const tujuan = itemData.tujuan;
                    const ptj = itemData.ptj;
                    const Turutan = index + 1;

                    // Do something with the extracted data:
                    console.log("No Permohonan:", noPermohonan);
                    console.log("Tujuan:", tujuan);
                    console.log("PTJ:", ptj);
                    console.log("Turutan:", Turutan);

                    var newPerolehan_Mesyuarat_Dtl = {
                        Perolehan_Mesyuarat_Detail: {
                            ddlNo_Mohon: noPermohonan,
                            ddlTurutan: Turutan,
                        }
                    }

                    var result = JSON.parse(await ajaxSavePerolehan_Mesyuarat_Dtl(newPerolehan_Mesyuarat_Dtl));


                    if (result.Status === true) {
                        showModal1("Success", result.Message, "success");
                        //$('#txtNoMohon').val(result.Payload.txtNoMohon);
                        //$('#txtNoPO').val(result.Payload.txtNoPO);
                    } else {
                        showModal1("Error", result.Message, "error");
                    }
                });

                var param = {
                    JawatanKuasaList: []
                };

                var kodSubmanu = "020602"
                var NameSubMenu = "Penilaian Teknikal"

                $('.chkpilihSpekDetail').each(async function (ind, obj) {
                    if (obj.checked === false) {
                        return;
                    }
                    var newJawatanKuasaList = {
                        Perolehan_Mesyuarat_JKD: {
                            ddlName: $('.txt_Name').eq(ind).val(),
                            ddlEmel: $('.txt_Emel').eq(ind).val(),
                            dllJawatan: $('.txt_JawGiliran').eq(ind).val(),
                            ddlNo_Tel: $('.txt_No_Tel').eq(ind).val(),
                            ddlNo_Staf: $('.txt_No_Staf').eq(ind).val(),
                            dllKodSubMenu: kodSubmanu,
                            dllNameSubMenu: NameSubMenu,
                            ddlTarikh: tTarikh,
                            ddlMasa: tMasa,
                            ddlTempat: tTempat
                        }
                    }

                    console.log("test =", newJawatanKuasaList)

                    var result2 = JSON.parse(await beginSaveJawatanKuasaListDetail(newJawatanKuasaList));


                    if (result2.Status === true) {
                        showModal1("Success", result.Message, "success");
                        //location.reload();
                    } else {
                        showModal1("Error", result.Message, "error");
                    }
                });

            });


        });

        async function beginSaveJawatanKuasaListDetail(Perolehan_Mesyuarat_JKD) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SavePerolehan_Mesyuarat_JK") %>',
                method: 'POST',
                data: JSON.stringify(Perolehan_Mesyuarat_JKD),
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

        async function ajaxSavePerolehan_Mesyuarat_Hdr(Perolehan_Mesyuarat_Header) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/mesyuaratWS.asmx/SavePerolehan_Mesyuarat_Hdr_Teknikal") %>',
                method: 'POST',
                data: JSON.stringify(Perolehan_Mesyuarat_Header),
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

        async function ajaxSavePerolehan_Mesyuarat_Dtl(Perolehan_Mesyuarat_Detail) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/mesyuaratWS.asmx/SavePerolehan_Mesyuarat_Dtl_Teknikal") %>',
                method: 'POST',
                data: JSON.stringify(Perolehan_Mesyuarat_Detail),
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


        var KodJawatanKuas = '';

        function beginSearch() {
            console.log("testing bb")
            tblJawatankuasa.ajax.reload();
        }


        $(document).ready(function () {



            tblJawatankuasa = $("#tblDataSenaraiJawatankuasaLuar").DataTable({
                "responsive": true,
                "searching": true,
                cache: true,
                dom: 'Bfrtip',


                "paging": false,
                "ajax":
                {
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPerolehan_JawatankuasaDT") %>',
                type: 'POST',
                data: function (d) {
                    return "{ KodJawatanKuas: '" + KodJawatanKuas + "'}"

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
                    "width": "5%",

                },

                {
                    "data": null,
                    "width": "10%",
                    "render": function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }
                        return `<input class = 'txt_No_Staf' type="hidden" value='${data.No_Staf}' />${data.No_Staf}`;

                    },
                },

                {
                    "data": null,
                    "width": "20%",
                    "render": function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }
                        return `<input class = 'txt_Name' type="hidden" value ='${data.MS01_Nama}'/>${data.MS01_Nama}`;
                    },
                },

                {
                    "data": null,
                    "width": "25%",
                    "render": function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }
                        return `<input class = 'txt_Pejabat' type="hidden" value='${data.Pejabat}'/>${data.Pejabat}`;

                    },
                },

                {
                    "data": null,
                    "width": "20%",
                    "render": function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }
                        return `<input class = 'txt_JawGiliran' type="hidden" value='${data.JawGiliran}'/>${data.JawGiliran}`;
                    },
                },

                {
                    "data": null,
                    "width": "15%",
                    "render": function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }
                        return `<input class = 'txt_Emel' type="hidden" value='${data.MS01_Email}'/><input class = 'txt_No_Tel' type="hidden"  value='${data.MS01_NoTelBimbit}'/>${data.MS01_Email}`;
                    },
                },

                {
                    "data": null,
                    "width": "5%",
                    "render": function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }
                        return `<input type = 'checkbox' class = 'chkpilihSpekDetail'/> `;
                    },
                },


            ],

        });

        $('#btnSimpanInfo').click(async function (evt) {
            evt.preventDefault();


        })



        console.log("- KodJawatanKuas =", KodJawatanKuas)
    });




        // Create a new Date object
        var currentDate = new Date();

        // Get the current year
        var currentYear = currentDate.getFullYear();
        //var tahunSemasa = currentYear;
        var tahunSemasa = '2022';
        var arrData = [];



        var IdMohon = '';


        document.addEventListener("DOMContentLoaded", function () {
            let index;
            containerSenaraiSebutHarga = document.querySelectorAll('.containerSenaraiSebutHarga');

            $(document).ready(async function () {



                var senaraiData = JSON.parse(await getDataTable());
                $container = $('.js-containerSenaraiSebutHarga-right');
                $container.html("");

                senaraiData.forEach(function (obj) {

                    const itemData = {
                        noPermohonan: obj.No_Mohon,
                        tujuan: obj.Tujuan,
                        ptj: obj.Kod_Ptj_Mohon

                    };



                    $template = $('.data-template').clone();

                    $template.removeClass("data-template");

                    $template.attr("data-item-data", JSON.stringify(itemData));
                    $template.find(".js-no-permohonan").html(obj.No_Perolehan)
                    $template.find(".js-tajuk").html(obj.Tujuan)
                    $template.find(".js-ptj").html(obj.Kod_Ptj_Mohon)

                    $template.attr("style", "");

                    $container.append($template);

                })


                // Set index when draggable is touched
                const draggables = document.querySelectorAll('.draggable');
                const containerSenaraiSebutHargas = document.querySelectorAll('.containerSenaraiSebutHarga');


                draggables.forEach(draggable => {
                    draggable.addEventListener('touchstart', (event) => {
                        event.preventDefault();
                        //draggable.classList.add('dragging');
                        //index = Array.from(draggables).indexOf(draggable) + 1;
                        //document.getElementById('indexNum').innerText = index;
                        const parent = draggable.parentElement;

                        const afterElement = getDragAfterElement(containerSenaraiSebutHarga[0], event.touches[0].clientY);
                        // const draggable = document.querySelector('.dragging');

                        if (parent.className.trim() !== "containerSenaraiSebutHarga js-right-container") {
                            containerSenaraiSebutHargas[1].appendChild(draggable);
                        } else {
                            containerSenaraiSebutHargas[0].insertBefore(draggable, afterElement);
                        }
                    });

                    draggable.addEventListener('touchend', () => {
                        draggable.classList.remove('dragging');
                        document.getElementById('indexNum').innerText = '';
                        index = undefined; // Reset index when touch ends
                    });

                });



                draggables.forEach(draggable => {
                    draggable.addEventListener('dragstart', () => {
                        draggable.classList.add('dragging')

                        // Get the current index of the draggable
                        const index = Array.from(draggables).indexOf(draggable) + 1;

                        // Update the content of the indexNum element with the current index
                        document.getElementById('indexNum').innerText = index;
                    })

                    draggable.addEventListener('dragend', () => {
                        draggable.classList.remove('dragging')

                        // Clear the content of the indexNum element when dragging ends
                        document.getElementById('indexNum').innerText = '';
                    })
                })

                containerSenaraiSebutHargas.forEach(containerSenaraiSebutHarga => {
                    containerSenaraiSebutHarga.addEventListener('dragover', e => {
                        e.preventDefault()
                        const afterElement = getDragAfterElement(containerSenaraiSebutHarga, e.clientY)
                        const draggable = document.querySelector('.dragging')
                        if (afterElement == null) {
                            containerSenaraiSebutHarga.appendChild(draggable)
                        } else {
                            containerSenaraiSebutHarga.insertBefore(draggable, afterElement)
                        }
                    })
                })

                function getDragAfterElement(containerSenaraiSebutHarga, y) {
                    const draggableElements = [...$(containerSenaraiSebutHarga).find('.draggable:not(.dragging)')]

                    return draggableElements.reduce((closest, child) => {
                        const box = child.getBoundingClientRect()
                        const offset = y - box.top - box.height / 2
                        if (offset < 0 && offset > closest.offset) {
                            return { offset: offset, element: child }
                        } else {
                            return closest
                        }
                    }, { offset: Number.NEGATIVE_INFINITY }).element
                }

                // Draggable Lable function END

                async function getDataTable() {
                    return new Promise((resolve, reject) => {
                        $.ajax({
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/mesyuaratWS.asmx/LoadSenarai_Sebut_Harga_PenTeknikal") %>',
                    type: "POST",
                    data: "{ IdMohon: '" + IdMohon + "'}",
                    dataType: "json", //expected data from server
                    contentType: "application/json;charset=utf-8",
                    success: function (result) {
                        resolve(result.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                    }
                });
            });
            }

            function isTurutanExists(arr, turutan) {
                return arr.some(function (item) {
                    return item.Turutan === turutan;
                });
            }


            // Debugging: Check if the element with id 'indexNum' exists
            var indexNumElement = document.getElementById('indexNum');
            if (indexNumElement) {
                console.log("Element with id 'indexNum' found.");
            } else {
                console.log("Element with id 'indexNum' not found.");
            }

            // Update 'innerText' property only if the element exists
            if (indexNumElement) {
                indexNumElement.innerText = index;
            } else {
                console.error("Cannot set 'innerText': Element with id 'indexNum' not found.");
            }

        });




    });



        $(document).ready(function () {
            // Dropdown Syarikat Bidang Utama
            $('#JawatankuasaData').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/mesyuaratWS.asmx/Get_Jawatan_Kuasa_Teknikal?q={query}") %>',
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                beforeSend: function (settings) {
                    settings.data = JSON.stringify({ q: settings.urlData.query });
                    return settings;
                },
                onSuccess: function (response) {
                    var obj = $(this);
                    var objItem = $(this).find('.menu');
                    $(objItem).html('');

                    if (response.d.length === 0) {
                        $(obj.dropdown("clear"));
                        return false;
                    }

                    var listOptions = JSON.parse(response.d);

                    $.each(listOptions, function (index, option) {
                        $(objItem).append($('<div class="item" data-value="' + option.kodValue + '">').html(option.text));
                    });

                    $(obj).dropdown('refresh');

                    // Handle selection change
                    $(obj).dropdown({
                        onChange: function (kodValue, text, $selectedItem) {
                            // Do something with the selected value
                            console.log("Selected Value:", kodValue);
                            console.log("Selected Text:", text);
                            console.log("Selected Item:", $selectedItem);

                            KodJawatanKuas = kodValue;

                            console.log("+ KodJawatanKuas", KodJawatanKuas)

                            beginSearch();

                        }
                    });

                    // Show dropdown
                    $(obj).dropdown('show');
                }
            }
        });
    });






        // Declare variables
        var sequenceNumber = 0;
        var currentSequence1, currentSequence2, currentSequence3;


        function ShowPopup(elm) {



            $(".modal-body div").val("");
            $('#permohonan').modal('toggle');


        }

        var tbl = null
        var isClicked = false;
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
                    "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax": {
                    "url": "Transaksi_WS.asmx/LoadOrderRecord_SenaraiTransaksiJurnal",
                    "method": 'POST',
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
                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    // Add click event
                    $(row).on("click", function () {
                        rowClickHandler(data.No_Jurnal);

                    });
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
                    { "data": "Butiran" },
                    { "data": "Jumlah" },
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



                ]

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
            // alert("test")
            $('#ddlJenTransaksi').dropdown({
                fullTextSearch: false,
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



                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                    /*if (shouldPop === true)*/ {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });
        });


        $('.btnSearch').click(async function () {

            isClicked = true;
            tbl.ajax.reload();


        })


        $(function () {
            $('.btnAddRow.five').click();
        });

        $('.btnHantar').click(async function () {
            console.log("test")
            $('#confirmationModal_Hantar').modal('toggle');


        });

        $('.btnYa_Hantar').click(async function () {

            $('#confirmationModal_Hantar').modal('toggle');

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

                    acceptedRecord += 1;
                    newOrder.order.OrderDetails.push(orderDetail);

                }

            });



            var result = JSON.parse(await ajaxSubmitOrder(newOrder));


            if (result.Status !== "Failed") {
                // open modal makluman and show message
                $('#maklumanModalBil_Hantar').modal('toggle');
                $('#detailMaklumanBil_Hantar').html(result.Message);

                $('#ddlJenTransaksi').dropdown('clear');
                $('#ddlJenTransaksi').dropdown('refresh');

                $('#lblNoJurnal').val("");
                await clearAllRows();
                await clearAllRowsHdr();
                await clearHiddenButton();
                AddRow(5);

                // refresh page after 2 seconds


                setTimeout(function () {
                    tbl.ajax.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModalBil_Hantar').modal('toggle');
                $('#detailMaklumanBil_Hantar').html(result.Message);



            }



        });

        $('.btnSet').click(async function () {
            $('#lblNoJurnal').val("");
            $('#ddlJenTransaksi').dropdown('clear');
            $('#ddlJenTransaksi').dropdown('refresh');

            await clearAllRows();
            await clearAllRowsHdr();
            await clearHiddenButton();
            AddRow(5);
        })



        $('.btnSimpan').click(async function () {

            // open modal confirmation
            $('#confirmationModal').modal('toggle');

        })

        $('.btnYa').click(async function () {

            $('#confirmationModal').modal('toggle');

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



                    acceptedRecord += 1;
                    newOrder.order.OrderDetails.push(orderDetail);

                }

            });



            var result = JSON.parse(await ajaxSaveOrder(newOrder));

            if (result.Status !== "Failed") {
                //$('#modalPenghutang').modal('toggle');
                // open modal makluman and show message
                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html(result.Message);
                //clearAllFields();

                $('#ddlJenTransaksi').dropdown('clear');
                $('#ddlJenTransaksi').dropdown('refresh');

                $('#lblNoJurnal').val("");
                await clearAllRows();
                await clearAllRowsHdr();
                await clearHiddenButton();
                AddRow(5);

                // refresh page after 2 seconds


                setTimeout(function () {
                    tbl.ajax.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html(result.Message);



            }





        });




        $('.btnLoad').on('click', async function () {
            loadExistingRecords();
        });

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
            $("#ddlJenTransaksi").empty();

        }

        async function clearHiddenButton() {

            $('.btnSimpan').show();
            $('.btnHantar').show();
            $('.btnAddRow').show();

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
                    url: 'Transaksi_WS.asmx/SaveOrders',
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
                const response = await fetch('Transaksi_WS.asmx/LoadOrderRecord_SenaraiTransaksiJurnal', {
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
            //calculateGrandTotal();
            var totalKredit = NumDefault(kredit_.val())

            calculateGrandTotal();

            //START BIL COUNT DATATABLE...
            var columnIndexToCount = 3; // Change this to the desired column index (0-based)
            var rowCount = 0;

            $("#tableID").find("tr").each(function () {
                var cellValue = $(this).find("td:eq(" + columnIndexToCount + ")").text();

                // Check if the cell has data
                if (cellValue.trim() !== "") {
                    rowCount++;
                }
            });

            //console.log("Number of rows with data in column " + columnIndexToCount + ": " + rowCount);
            document.getElementById('result').textContent = rowCount + " Item :";

            //END BIL COUNT


        });

        async function calculateGrandTotal() {

            //debit
            var grandTotal_Dt = $(totalDebit);

            var curTotal_Dt = 0;

            $('.Debit').each(function (index, obj) {
                curTotal_Dt += parseFloat(NumDefault($(obj).val()));
            });


            grandTotal_Dt.val(formatPrice(curTotal_Dt));

            //kredit
            var grandTotal_Kt = $(totalKredit);
            var curTotal_Kt = 0;

            $('.Kredit').each(function (index, obj) {
                curTotal_Kt += parseFloat(NumDefault($(obj).val()));
            });

            grandTotal_Kt.val(formatPrice(curTotal_Kt));

            //beza
            var grandTotal_Beza = $(totalID);
            var cal = curTotal_Dt - curTotal_Kt
            grandTotal_Beza.val(formatPrice(cal));

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



                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });


        }

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



                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });
        }
        async function initDropdownCOA(id) {

            $('#' + id).dropdown({
                fullTextSearch: true,
                onChange: function (value, text, $selectedItem) {


                    var curTR = $(this).closest("tr");

                    var recordIDVotHd = curTR.find("td > .Hid-vot-list");
                    recordIDVotHd.html($($selectedItem).data("coltambah5"));




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


                        settings.data = JSON.stringify({ q: settings.urlData.query });


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

        async function AddRow(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblData');

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;

            }

            while (counter <= totalClone) {

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
                    if (counter <= objOrder.Payload.length) {
                        await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);

                    }
                }
                counter += 1;
            }
        }

        async function paparSenarai(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblDataSenarai');

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;

            }

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

        async function setValueToRow_HdrJurnal(orderDetail) {

            $('#lblNoJurnal').val(orderDetail.No_Jurnal)
            $('#txtNoRujukan').val(orderDetail.No_Rujukan)

            $('#txtTarikh').val(orderDetail.Tkh_Transaksi)
            $('#txtPerihal').val(orderDetail.Butiran)

            var newId = $('#ddlJenTransaksi')


            var ddlJenTransaksi = $('#ddlJenTransaksi')
            var ddlSearch = $('#ddlJenTransaksi')
            var ddlText = $('#ddlJenTransaksi')
            var selectObj_JenisTransaksi = $('#ddlJenTransaksi')
            $(ddlJenTransaksi).dropdown('set selected', orderDetail.Jenis_Trans);
            selectObj_JenisTransaksi.append("<option value = '" + orderDetail.Jenis_Trans + "'>" + orderDetail.ButiranJenis + "</option>")


            if (orderDetail.Kod_Status_Dok != "01") {

                $('.btnSimpan').hide();
                $('.btnHantar').hide();
                $('.btnAddRow').hide();

            }
            else {

                $('.btnSimpan').show();
                $('.btnHantar').show();
                $('.btnAddRow').show();


            }


        }

        async function setValueToRow(row, orderDetail) {


            var no = $(row).find("td > .lblNo");
            var no1 = $(row).find("td > .lblNo");
            var rujukan = $(row).find("td > .lblRujukan");
            var butiran = $(row).find("td > .lblButiran");
            var jumlah = $(row).find("td > .lblJumlah");
            var tarikh = $(row).find("td > .lblTkh");
            var statusDok = $(row).find("td > .lblStatusDok");


            no.html(orderDetail.No_Jurnal);
            no1.val(orderDetail.No_Jurnal);
            rujukan.html(orderDetail.No_Rujukan);
            butiran.html(orderDetail.Butiran);
            jumlah.html(orderDetail.Jumlah);
            tarikh.html(orderDetail.Tkh_Transaksi);
            statusDok.html(orderDetail.Kod_Status_Dok);


        }

        async function setValueToRow_Transaksi(row, orderDetail) {

            var ddl = $(row).find("td > .COA-list");
            var ddlSearch = $(row).find("td > .COA-list > .search");
            var ddlText = $(row).find("td > .COA-list > .text");
            var selectObj = $(row).find("td > .COA-list > select");
            $(ddl).dropdown('set selected', orderDetail.Kod_Vot);
            selectObj.append("<option value = '" + orderDetail.Kod_Vot + "'>" + orderDetail.Kod_Vot + ' - ' + orderDetail.ButiranVot + "</option>")


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

                        settings.data = JSON.stringify({ q: settings.urlData.query });


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

        // add clickable event in DataTable row
        async function rowClickHandler(id) {
            if (id !== "") {
                // modal dismiss
                $('#permohonan').modal('toggle');

                //BACA HEADER JURNAL
                var recordHdr = await AjaxGetRecordHdrJurnal(id);
                await AddRowHeader(null, recordHdr);

                //BACA DETAIL JURNAL
                var record = await AjaxGetRecordJurnal(id);
                await clearAllRows();
                await AddRow(null, record);
            }
        }


        async function AddRowHeader(totalClone, objOrder) {
            var counter = 1;

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;
            }


            if (counter <= objOrder.Payload.length) {
                await setValueToRow_HdrJurnal(objOrder.Payload[counter - 1]);
            }
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



    </script>
</asp:Content>
