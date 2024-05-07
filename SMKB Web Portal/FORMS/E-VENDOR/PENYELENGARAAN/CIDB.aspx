<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="CIDB.aspx.vb" Inherits="SMKB_Web_Portal.CIDB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
        .nospn {
            -moz-appearance: textfield;
        }

            .nospn::-webkit-outer-spin-button,
            .nospn::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

        #subTab a {
            cursor: pointer;
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
            z-index: 3;
        }

        .input-group__input {
            width: 100%;
            height: 40px;
            border: 1px solid #dddddd;
            border-radius: 5px;
        }

            .input-group__input:not(:-moz-placeholder-shown) + label {
                background-color: white;
                line-height: 10px;
                opacity: 1;
                font-size: 10px;
                top: -5px;
            }

            .input-group__input:not(:empty) + label {
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

            .input-group__input:not(:placeholder-shown) + label,
            .input-group__input:focus + label {
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


        .input-group__select + label,
        .input-group__select:focus-within + label {
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

    <div id="permohonan" class="tabcontent" style="display: block;">

        <!-- CIDB tab -->
        <ul class="nav nav-tabs" id="myTabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#GredKerja">Gred Kerja</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#KategoriCIDB">kategori CIDB</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#KhususanCIDB">Maklumat Pengkhususan</a>
            </li>
        </ul>

        <div class="tab-content">

            <div class="tab-pane fade show active" id="GredKerja">

                <div class="col-md-12 mt-3 mb-3">
                    <div class="row">
                        <div class="col-md-6" style="display: flex; justify-content: flex-start; align-items: flex-start;">
                            <div class="form-group" style="align-self: flex-start;">
                                <h6 class="modal-title" id="titleSubBidang" style="visibility: hidden;">Senarai Gred Kerja
                                </h6>
                            </div>
                        </div>
                        <div class="col-md-6" style="display: flex; justify-content: flex-end; align-items: flex-end;">
                            <div class="form-group" style="align-self: flex-end;">
                                <div class="btn btn-primary btnGredKerja">
                                    <i class="fa fa-plus"></i>Gred Kerja   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />

                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblListGredKerja" class="table table-striped" style="width: 100%">
                            <thead>
                                <tr data-id="">
                                    <th scope="col">Bil</th>
                                    <th scope="col">Kod Gred</th>
                                    <th scope="col">Had Upaya</th>
                                    <th scope="col">Butiran</th>
                                    <th scope="col">Tindakan</th>
                                </tr>
                            </thead>
                            <tbody id="tblRowGredKerja">
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="modal fade" id="GredKerjaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="titleFormGredKerja">Tambah Gred Kerja</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="KodGred" name="KodGred" />
                                        <label class="input-group__label">Gred Kerja</label>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group input-group">
                                        <input class="input-group__input form-control input-sm" placeholder="" id="HadUpaya" name="HadUpaya" />
                                        <label class="input-group__label">Had Upaya</label>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group input-group">
                                        <input type="text" class="input-group__input form-control input-sm" placeholder="" id="ButiranGred" name="ButiranGred" />
                                        <label class="input-group__label">Butiran</label>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                                <button type="button" runat="server" id="Button1" class="btn btn-secondary btnSimpanGred">Simpan</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="tab-pane fade show" id="KategoriCIDB">
                <div class="col-md-12 mt-3 mb-3">
                    <div class="row">
                        <div class="col-md-6" style="display: flex; justify-content: flex-start; align-items: flex-start;">
                            <div class="form-group" style="align-self: flex-start;">
                                <h6 class="modal-title" id="titleKatCIDB" style="visibility: hidden;">Senarai Kategori CIDB
                                </h6>
                            </div>
                        </div>
                        <div class="col-md-6" style="display: flex; justify-content: flex-end; align-items: flex-end;">
                            <div class="form-group" style="align-self: flex-end;">
                                <div class="btn btn-primary btnKatCIDB">
                                    <i class="fa fa-plus"></i>Kategori CIDB
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />

                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblListKatCIDB" class="table table-striped" style="width: 100%">
                            <thead>
                                <tr data-id="">
                                    <th scope="col">Bil</th>
                                    <th scope="col">Kod Kategori</th>
                                    <th scope="col">Butiran</th>
                                    <th scope="col">Tindakan</th>
                                </tr>
                            </thead>
                            <tbody id="tblRowKatCIDB">
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="modal fade" id="KatCIDBModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="titleFormKatCIDB">Tambah Kategori</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="KodKatCIDB" name="KodKatCIDB" />
                                        <label class="input-group__label">Kod</label>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group input-group">
                                        <input type="text" class="input-group__input form-control input-sm" placeholder="" id="ButiranKatCIDB" name="ButiranKatCIDB" />
                                        <label class="input-group__label">Butiran</label>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                                <button type="button" runat="server" id="Button2" class="btn btn-secondary btnSimpanKat">Simpan</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="confirmationModalKat" tabindex="-1" role="dialog"
                    aria-labelledby="confirmationModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmationModalLabelKat">Pengesahan</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" id="confirmContentKat">
                                Anda pasti ingin menyimpan rekod ini?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger"
                                    data-dismiss="modal">
                                    Tidak</button>
                                <button type="button" class="btn btn-secondary btnYaKat">Ya</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="tab-pane fade show" id="KhususanCIDB">

                <div class="col-md-12 mt-5 mb-3">

                    <div class="row">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="lblCarian" style="display: flex;justify-content: flex-end; align-items: flex-end;">Kod Kategori CIDB : </label>
                                </div>
                                <div class="col-sm-8">
                                    <div class="input-group">
                            <select id="categoryFilter" class="custom-select">
                            </select>
                            <div class="input-group-append">
                                <button id="btnSearch" runat="server" class="btn btnSearch" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3"></div>
                    </div>

                </div>

                <div class="col-md-12 mt-3 mb-3">
                    <div class="row">
                        <div class="col-md-6" style="display: flex; justify-content: flex-start; align-items: flex-start;">
                            <div class="form-group" style="align-self: flex-start;">
                                <h6 class="modal-title" id="titleKhusus" style="visibility: hidden;">Senarai Pengkhususan
                                </h6>
                            </div>
                        </div>
                        <div class="col-md-6" style="display: flex; justify-content: flex-end; align-items: flex-end;">
                            <div class="form-group" style="align-self: flex-end;">
                                <div class="btn btn-primary btnKhusus">
                                    <i class="fa fa-plus"></i>Pengkhususan
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />

                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblListKhusus" class="table table-striped" style="width: 100%">
                            <thead>
                                <tr data-id="">
                                    <th scope="col">Bil</th>
                                    <th scope="col">Kod Pengkhususan</th>
                                    <th scope="col">Butiran Pengkhususan</th>
                                    <th scope="col">Kod Kategori</th>
                                    <th scope="col">Butiran Kategori</th>
                                    <th scope="col">Tindakan</th>
                                </tr>
                            </thead>
                            <tbody id="tblRowKhusus">
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="modal fade" id="KhususModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="titleFormKhusus">Tambah Pengkhususan</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="form-group input-group">
                                        <select class="input-group__input form-control input_sm ui search dropdown ddlKat " name="ddlKat" id="ddlKat">
                                        </select>
                                        <label class="input-group__label">Kategori CIDB</label>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="KodKhusus" name="KodKhusus" />
                                        <label class="input-group__label">Kod Pengkhususan</label>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group input-group">
                                        <input class="input-group__input form-control input-sm" placeholder="" id="ButiranKhusus" name="ButiranKhusus" />
                                        <label class="input-group__label">Butiran</label>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                                <button type="button" runat="server" id="Button3" class="btn btn-secondary btnSimpanKhusus">Simpan</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Confirmation Modal -->
            <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog"
                aria-labelledby="confirmationModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmationModalLabel">Pengesahan</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" id="confirmContent">
                            Anda pasti ingin menyimpan rekod ini?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger"
                                data-dismiss="modal">
                                Tidak</button>
                            <button type="button" class="btn btn-secondary btnYa">Ya</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Makluman Modal -->
            <div class="modal fade" id="maklumanModal" tabindex="-1" role="dialog"
                aria-labelledby="maklumanModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="maklumanModalLabel">Makluman</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <span id="detailMakluman"></span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="tutupMakluman"
                                data-dismiss="modal">
                                Tutup</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script type="text/javascript">
        /////////////////////////////  GLOBAL  ////////////////////////////////////////

        async function DisplayMaklumanModal(msg) {
            $('#detailMakluman').html(msg);
            $('#maklumanModal').modal("toggle");
        }

        async function DisplayPengesahanModal(msg, action, tab, id, curTR) {
            if (arguments.length === 1) {

                $('#confirmContent').html(msg);
                $('#confirmationModal').modal("toggle");

            } else if (arguments.length === 2) {

                $('#confirmContent').html(msg);
                $('.btnYa').data("action", action);
                $('#confirmationModal').modal("toggle");

            } else if (arguments.length === 3) {

                $('#confirmContent').html(msg);
                $('.btnYa').data("action", action);
                $('.btnYa').data("id", id);
                $('#confirmationModal').modal("toggle");

            } else if (arguments.length === 4) {

                $('#confirmContent').html(msg);
                $('.btnYa').data("action", action);
                $('.btnYa').data("id", id);
                $('.btnYa').data("curTR", curTR);
                $('#confirmationModal').modal("toggle");

            } else if (arguments.length === 5) {

                $('#confirmContent').html(msg);
                $('.btnYa').data("action", action);
                $('.btnYa').data("tab", tab);
                $('.btnYa').data("id", id);
                $('.btnYa').data("curTR", curTR);
                $('#confirmationModal').modal("toggle")

            } else {
                $('#confirmContent').html("Maaf");
                $('#confirmationModal').modal("toggle");
            }
        }

        /////////////////////////////  Tab 1 (Gred Kerja)      ////////////////////////////////////////


        $('.btnGredKerja').on('click', async function () {
            clearValueDataGred();
            $('#titleFormGredKerja').html("Tambah Gred Kerja");
            $('#GredKerjaModal').modal("toggle");
        });

        var tblGredKerja;
        /* show_loader();*/
        tblGredKerja = $("#tblListGredKerja").DataTable({
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
                "url": "SelengaraCIDB_WS.asmx/LoadList_GredKerja",
                "method": 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                },
                "data": function () {
                    //Filter by Session Syarikat
                    return JSON.stringify({
                            //IdSya: '<%=Session("ssusrID")%>',
                    })
                }
            },
            "rowCallback": function (row, data) {
                // Add hover effect
                //$(row).hover(function () {
                //    $(this).addClass("hover pe-auto bg-warning");
                //}, function () {
                //    $(this).removeClass("hover pe-auto bg-warning");
                //});

                ////Add click event
                //$(row).on("click", function () {
                //    var startDateTime = data.TkhPamer;
                //    var EndDateTime = data.TkhTutup;
                //    rowClickHandler(startDateTime, EndDateTime);
                //});
            },
            "drawCallback": function (settings) {
                // Your function to be called after loading data
                /*close_loader();*/
            },
            "columns": [
                {
                    "target": 0,
                    "render": function (data, type, row, meta) {
                        return meta.row + 1;
                    },
                    "orderable": false,
                },
                /*{ "data": "IdPengalaman"},*/
                { "data": "Kod_Gred" },
                { "data": "Had_Upaya" },
                { "data": "Butiran" },
                {
                    className: "btnEdit",
                    "data": "Kod_Gred",
                    render: function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }

                        var link = `<button id="btnEditGred" runat="server" class="btn btnEditGred" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteGred" runat="server" class="btn btnDeleteGred" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                        return link;
                    }
                },

            ]
        });

        async function clearValueDataGred() {

            $('#KodGred').val("");
            $('#HadUpaya').val("");
            $('#ButiranGred').val("");

        }

        $('#tblListGredKerja').on('click', '.btnEditGred', async function (event) {
            debugger;
            $('#titleFormGredKerja').html("Kemaskini Gred Kerja");
            $('#GredKerjaModal').modal("toggle");

            event.stopPropagation();
            var KodGred = $(this).data("id");
            if (KodGred != "") {
                var DataGred = JSON.parse(await AjaxLoadDataGredKerja(KodGred));

                if (DataGred.length > 0) {
                    $('#GredKerjaModal').attr('data-mode', 'edit');
                    SetValueToForm_GredKerja(DataGred);
                } else {
                    DisplayMaklumanModal("Tiada respon Data Bidang Utama");
                }
            }
        });

        $('#tblListGredKerja').on('click', '.btnDeleteGred', async function (event) {
            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var KodBU = $(this).data("id");

            DisplayPengesahanModal("Adakah Anda Pasti ingin Memadam data ini?", "delete", 1, KodBU, curTR);
        });

        $('.btnSimpanGred').click(async function () {
            debugger;
            if ($('#KodGred').val() == "" || $('#HadUpaya').val() == "" || $('#ButiranGred').val() == "") {
                DisplayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
            } else {
                //$('#GredKerjaModal').modal("toggle");
                var mode = $('#GredKerjaModal').attr('data-mode');

                if (mode === 'edit') {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Mengemaskini rekod ini?", "edit", 1, null, null)
                } else {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Menghantar rekod ini?", "save", 1, null, null)
                }
            }
        });

        async function DeleteGredKerja(KodGred) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteGred(KodGred));

            if (result.Code === "00") {
                bool = true;
            }

            return bool;
        }

        async function SetValueToForm_GredKerja(DataGred) {

            $('#KodGred').val(DataGred[0].Kod_Gred);
            $('#HadUpaya').val(DataGred[0].Had_Upaya);
            $('#ButiranGred').val(DataGred[0].Butiran);

        }

        async function AjaxDeleteGred(KodGred) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/DeleteGred',
                    method: 'POST',
                    data: JSON.stringify({ KodGred: KodGred }),
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

        async function AjaxLoadDataGredKerja(KodGred) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/LoadData_GredKerja',
                    method: 'POST',
                    data: JSON.stringify({ KodGred: KodGred }),
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

        async function AjaxSaveGredKerja(gredKerja) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/SaveGredKerja',
                    method: 'POST',
                    data: JSON.stringify(gredKerja),
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

        async function AjaxEditGredKerja(gredKerja) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/EditGredKerja',
                    method: 'POST',
                    data: JSON.stringify(gredKerja),
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

        /////////////////////////////  Tab 2 (Kategori CIDB)  ////////////////////////////////////////

        $('.btnKatCIDB').on('click', async function () {
            clearValueDataKat();
            $('#titleFormKatCIDB').html("Tambah Kategori CIDB");
            $('#KatCIDBModal').modal('toggle');
        });

        async function clearValueDataKat() {
            $('#KodKatCIDB').val("");
            $('#ButiranKatCIDB').val("");
        }

        var tblKatCIDB;
        $(document).ready(function () {
            /* show_loader();*/
            tblKatCIDB = $("#tblListKatCIDB").DataTable({
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
                    "url": "SelengaraCIDB_WS.asmx/LoadList_KategoriSyarikat",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                                //IdSya: '<%=Session("ssusrID")%>',
                        })
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    //$(row).hover(function () {
                    //    $(this).addClass("hover pe-auto bg-warning");
                    //}, function () {
                    //    $(this).removeClass("hover pe-auto bg-warning");
                    //});

                    ////Add click event
                    //$(row).on("click", function () {
                    //    var startDateTime = data.TkhPamer;
                    //    var EndDateTime = data.TkhTutup;
                    //    rowClickHandler(startDateTime, EndDateTime);
                    //});
                },
                "drawCallback": function (settings) {
                    // Your function to be called after loading data
                    /*close_loader();*/
                },
                "columns": [
                    {
                        "target": 0,
                        "render": function (data, type, row, meta) {
                            return meta.row + 1;
                        },
                        "orderable": false,
                    },
                    /*{ "data": "IdPengalaman"},*/
                    { "data": "Kod_Detail" },
                    { "data": "Butiran" },
                    {
                        className: "btnEdit",
                        "data": "Kod_Detail",
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditKat" runat="server" class="btn btnEditKat" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteKat" runat="server" class="btn btnDeleteKat" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    },

                ]
            });
        });

        async function AjaxLoadDataKatCIDB(KodKat) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/LoadData_KategoriSyarikat',
                    method: 'POST',
                    data: JSON.stringify({ KodDetail: KodKat }),
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

        $('#tblListKatCIDB').on('click', '.btnEditKat', async function (event) {
            $('#titleFormKatCIDB').html("Kemaskini Kategori");
            $('#KatCIDBModal').modal("toggle");

            event.stopPropagation();
            var KodKat = $(this).data("id");

            if (KodKat != "") {
                var DataKat = JSON.parse(await AjaxLoadDataKatCIDB(KodKat));

                if (DataKat.length > 0) {
                    $('#KatCIDBModal').attr('data-mode', 'edit');
                    SetValueDataKatCIDB(DataKat);
                } else {
                    console.log("Tiada respon Data Bidang Utama");
                }
            }

            return false;
        });

        $('.btnSimpanKat').on('click', async function () {
            if ($('#KodKatCIDB').val() == "" || $('#ButiranKatCIDB').val() == "") {
                DisplayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
            } else {
                //$('#GredKerjaModal').modal("toggle");
                var mode = $('#KatCIDBModal').attr('data-mode');

                if (mode === 'edit') {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Mengemaskini rekod ini?", "edit", 2, null, null)
                } else {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Menghantar rekod ini?", "save", 2, null, null)
                }
            }
        })

        async function SetValueDataKatCIDB(DataKat) {
            $('#KodKatCIDB').val(DataKat[0].Kod_Detail);
            $('#ButiranKatCIDB').val(DataKat[0].Butiran);
        }

        $('#tblListKatCIDB').on('click', '.btnDeleteKat', async function (event) {
            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var KodKat = $(this).data("id");

            DisplayPengesahanModal("Adakah Anda Pasti ingin Memadam data ini?", "delete", 2, KodKat, curTR);
        });

        async function DeleteKatCIDB(KodKat) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteKat(KodKat));

            if (result.Code === "00") {
                bool = true;
            }

            return bool;
        }

        async function AjaxDeleteKat(KodKat) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/DeleteKatCIDB',
                    method: 'POST',
                    data: JSON.stringify({ KodKat: KodKat }),
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

        async function AjaxSaveKatCIDB(KatCIDB) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/SaveKatCIDB',
                    method: 'POST',
                    data: JSON.stringify(KatCIDB),
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

        async function AjaxEditKatCIDB(KatCIDB) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/EditKatCIDB',
                    method: 'POST',
                    data: JSON.stringify(KatCIDB),
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


        /////////////////////////////  Tab 3 (Pengkhususan)  ////////////////////////////////////////

        $('.btnKhusus').on('click', async function () {
            clearValueDataKhusus();
            $('#titleFormKhusus').html("Tambah Pengkhususan");
            $('#KhususModal').modal('toggle');
        });

        async function clearValueDataKhusus() {
            $('#ddlKat').dropdown("clear");
            $('#KodKhusus').val("");
            $('#ButiranKhusus').val("");
        }

        // Function to update the options of the second dropdown based on the selected value of the first dropdown
        //function updateSecondDropdown(selectedValue, secondDropdownId) {
        //    debugger;
        //    // Get the API response stored in the data attribute of the first dropdown
        //    var apiResponse = $('#categoryFilter').data('apiResponse');

        //    // Check if apiResponse is defined and not null
        //    if (apiResponse) {
        //        // Filter options based on the selected value
        //        var filteredOptions = apiResponse.filter(function (option) {
        //            //return option.parentValue === selectedValue;
        //            console.log("Option", option);
        //            return option.value === selectedValue;
        //        });

        //        console.log("filteredOptions", filteredOptions);
        //        console.log("filteredOptions.Value: ", filteredOptions[0].value);
              

        //        // Clear existing options in the second dropdown
        //        $(secondDropdownId).dropdown('clear');

        //        // Add filtered options to the second dropdown
        //        $.each(filteredOptions, function (index, option) {
        //            console.log("Option in each loop: ", option.value);
        //            $('#ddlKat').append($('<div class="item" data-value="' + option.value + '">').html(option.text));
        //        });

        //        // Refresh the second dropdown
        //        $(secondDropdownId).dropdown('refresh');
        //    }
        //}

        // Assuming the first dropdown has the id 'categoryFilter'
        $('#categoryFilter').dropdown({
            selectOnKeydown: true,
            fullTextSearch: true,
            apiSettings: {
                url: 'SelengaraCIDB_WS.asmx/GetKodKategoriCIDB?q={query}',
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                beforeSend: function (settings) {
                    // Replace {query} placeholder in data with user-entered search term
                    settings.data = JSON.stringify({ q: settings.urlData.query });
                    return settings;
                },
                onSuccess: function (response) {

                    debugger;
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

                    // Store the API response in the data attribute of the first dropdown
                    $('#categoryFilter').data('apiResponse', listOptions);

                    // Update the options of the second dropdown on page load
                    updateSecondDropdown($(this).dropdown('get value'), '#ddlKat');
                },
            }
        });

        // Assuming the second dropdown has the id 'ddlKat'
        $('#ddlKat').dropdown({
            selectOnKeydown: true,
            fullTextSearch: true,
            apiSettings: {
                url: 'SelengaraCIDB_WS.asmx/GetKodKategoriCIDB?q={query}',
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                beforeSend: function (settings) {
                    // Replace {query} placeholder in data with user-entered search term
                    settings.data = JSON.stringify({ q: settings.urlData.query });
                    return settings;
                },
                onSuccess: function (response) {
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
                    /*$(obj).dropdown('refresh');*/

                    //if (shouldPop === true) {
                    //    $(obj).dropdown('show');
                    //}
                }
            }
        });

        // Assuming the first dropdown has the id 'categoryFilter'
        //$('#categoryFilter').on('change', function () {
        //    // Get the selected value from the first dropdown
        //    var selectedValue = $(this).dropdown('get value');

        //    // Update the options of the second dropdown based on the selected value of the first dropdown
        //    updateSecondDropdown(selectedValue, '#ddlKat');
        //});

        var tblKhusus;
        $(document).ready(function () {
            /* show_loader();*/

            let IsClicked = false;

            $('.btnSearch').on('click', async function () {
                IsClicked = true;
                tblKhusus.ajax.reload();
            });

            tblKhusus = $("#tblListKhusus").DataTable({
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
                    "url": "SelengaraCIDB_WS.asmx/LoadList_Pengkhususan",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            IsClicked: IsClicked,
                            categoryFilter: $('#categoryFilter').val()
                        })
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    //$(row).hover(function () {
                    //    $(this).addClass("hover pe-auto bg-warning");
                    //}, function () {
                    //    $(this).removeClass("hover pe-auto bg-warning");
                    //});

                    ////Add click event
                    //$(row).on("click", function () {
                    //    var startDateTime = data.TkhPamer;
                    //    var EndDateTime = data.TkhTutup;
                    //    rowClickHandler(startDateTime, EndDateTime);
                    //});
                },
                "drawCallback": function (settings) {
                    // Your function to be called after loading data
                    /*close_loader();*/
                },
                "columns": [
                    {
                        "target": 0,
                        "render": function (data, type, row, meta) {
                            return meta.row + 1;
                        },
                        "orderable": false,
                    },
                    { "data": "KodKhusus" },
                    { "data": "Butiran" },
                    { "data": "KodKategori" },
                    { "data": "KodButiran" },
                    {
                        className: "btnEdit",
                        "data": "KodKhusus",
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditKhusus" runat="server" class="btn btnEditKhusus" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteKhusus" runat="server" class="btn btnDeleteKhusus" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    },

                ]
            });
        });

        async function AjaxLoadDataKhusus(KodKhusus) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/LoadData_Pengkhususan',
                    method: 'POST',
                    data: JSON.stringify({ KodKhusus: KodKhusus }),
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

        $('#tblListKhusus').on('click', '.btnEditKhusus', async function (event) {
            $('#titleFormKhusus').html("Kemaskini Pengkhususan");
            $('#KhususModal').modal("toggle");

            debugger;
            event.stopPropagation();
            var KodKhusus = $(this).data("id");

            if (KodKhusus != "") {
                var DataKhusus = JSON.parse(await AjaxLoadDataKhusus(KodKhusus));

                if (DataKhusus.length > 0) {
                    $('#KhususModal').attr('data-mode', 'edit');
                    SetValueDataKhusus(DataKhusus);
                } else {
                    DisplayMaklumanModal("Maaf Tiada Makluman Pengkhususan");
                }
            }

            return false;
        });

        $('.btnSimpanKhusus').on('click', async function () {

            if ($('#ddlKat').val() == "" || $('#KodKhusus').val() == "" || $('#ButiranKhusus').val() == "") {
                DisplayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
            } else {
                //$('#GredKerjaModal').modal("toggle");
                var mode = $('#KhususModal').attr('data-mode');

                if (mode === 'edit') {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Mengemaskini rekod ini?", "edit", 3, null, null)
                } else {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Menghantar rekod ini?", "save", 3, null, null)
                }
            }
        });

        async function SetValueDataKhusus(DataKhusus) {

            var ddlKodKat = $('#ddlKat');
            var selectObj_KodKat = $('#ddlKat');
            $(ddlKodKat).dropdown('set selected', DataKhusus[0].value);
            selectObj_KodKat.append("<option value = '" + DataKhusus[0].value + "'>" + DataKhusus[0].text + "</option>");

            $('#KodKhusus').val(DataKhusus[0].KodKhusus);
            $('#ButiranKhusus').val(DataKhusus[0].Butiran);
        }

        $('#tblListKhusus').on('click', '.btnDeleteKhusus', async function (event) {
            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var KodKhusus = $(this).data("id");

            DisplayPengesahanModal("Adakah Anda Pasti ingin Memadam data ini?", "delete", 3, KodKhusus, curTR);
        });

        async function DeleteKhusus(KodKhusus) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteKhusus(KodKhusus));

            if (result.Code === "00") {
                bool = true;
            }

            return bool;
        }

        async function AjaxDeleteKhusus(KodKhusus) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/DeleteKhusus',
                    method: 'POST',
                    data: JSON.stringify({ KodKhusus: KodKhusus }),
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

        async function AjaxSaveKhusus(DataKhusus) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/SaveKhusus',
                    method: 'POST',
                    data: JSON.stringify(DataKhusus),
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

        async function AjaxEditKhusus(DataKhusus) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraCIDB_WS.asmx/EditKhusus',
                    method: 'POST',
                    data: JSON.stringify(DataKhusus),
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


        /////////////////////////////  GLOBAL  ////////////////////////////////////////

        var Hantar = false;
        var Edit = false;
        var Delete = false;
        var action = "";

        $(".btnYa").on('click', async function () {
            $("#confirmationModal").modal("toggle");
            debugger;
            var action = $(this).data("action");
            var tab = $(this).data("tab")
            var Kod = $(this).data("id");
            var curTR = $(this).data("curTR")
            var bool = false;

            //Handle different actions
            switch (action) {
                case "delete":

                    if (tab == 1) {

                        if (Kod !== "") {
                            bool = await DeleteGredKerja(Kod);
                        }

                        if (bool === true) {
                            curTR.remove();
                        }

                        DisplayMaklumanModal("Maklumat Berjaya Dipadam");
                        tblGredKerja.ajax.reload();

                        return false;

                    } else if (tab == 2) {

                        if (Kod !== "") {
                            bool = await DeleteKatCIDB(Kod);
                        }

                        if (bool === true) {
                            curTR.remove();
                        }

                        DisplayMaklumanModal("Maklumat Berjaya Dipadam");
                        tblKatCIDB.ajax.reload();

                        return false;

                    } else if (tab == 3) {

                        if (Kod !== "") {
                            bool = await DeleteKhusus(Kod);
                        }

                        if (bool === true) {
                            curTR.remove();
                        }

                        DisplayMaklumanModal("Maklumat Berjaya Dipadam");
                        tblKhusus.ajax.reload();

                        return false;
                    }
                    //console.log(Kod);
                    //alert("Delete MMMAAATTT");

                    break;
                case "save":

                    if (tab == 1) {

                        var newGredKerja = {
                            gredKerja: {
                                KodGred: $('#KodGred').val(),
                                HadUpaya: $('#HadUpaya').val(),
                                Butiran: $('#ButiranGred').val()
                            }
                        }

                        var result = JSON.parse(await AjaxSaveGredKerja(newGredKerja));
                        if (result.Code == 00) {

                            $('#GredKerjaModal').modal("toggle");
                            DisplayMaklumanModal(result.Message);
                            tblGredKerja.ajax.reload();

                        } else {
                            DisplayMaklumanModal(result.Message);
                        }

                    } else if (tab == 2) {
                        var NewKatCIDB = {
                            KatCIDB: {
                                KodKat: $('#KodKatCIDB').val(),
                                Butiran: $('#ButiranKatCIDB').val()
                            }
                        }

                        var result = JSON.parse(await AjaxSaveKatCIDB(NewKatCIDB));
                        if (result.Code == 00) {

                            $('#KatCIDBModal').modal("toggle");
                            tblKatCIDB.ajax.reload();
                            DisplayMaklumanModal(result.Message);

                        } else {
                            DisplayMaklumanModal(result.Message);
                        }

                    } else if (tab == 3) {
                        var NewKhusus = {
                            DataKhusus: {
                                KodKhusus: $('#KodKhusus').val(),
                                ButiranKhusus: $('#ButiranKhusus').val(),
                                KodKat: $('#ddlKat').val(),
                                ButiranKat: ''
                            }
                        }

                        var result = JSON.parse(await AjaxSaveKhusus(NewKhusus));
                        if (result.Code == 00) {
                            tblKhusus.ajax.reload();
                            DisplayMaklumanModal(result.Message);
                        } else {
                            DisplayMaklumanModal(result.Message);
                        }
                    }
                    //alert("SAVEE MMMMMAATTT");
                    break;
                case "edit":
                    if (tab == 1) {

                        var newGredKerja = {
                            gredKerja: {
                                KodGred: $('#KodGred').val(),
                                HadUpaya: $('#HadUpaya').val(),
                                Butiran: $('#ButiranGred').val()
                            }
                        }

                        var result = JSON.parse(await AjaxEditGredKerja(newGredKerja));
                        if (result.Code == 00) {

                            $('#GredKerjaModal').modal("toggle");
                            DisplayMaklumanModal(result.Message);


                            tblGredKerja.ajax.reload();


                        } else {
                            DisplayMaklumanModal(result.Message);
                        }

                    } else if (tab == 2) {

                        var NewKatCIDB = {
                            KatCIDB: {
                                KodKat: $('#KodKatCIDB').val(),
                                Butiran: $('#ButiranKatCIDB').val()
                            }
                        }

                        var result = JSON.parse(await AjaxEditKatCIDB(NewKatCIDB));
                        if (result.Code == 00) {

                            $('#KatCIDBModal').modal("toggle");
                            DisplayMaklumanModal(result.Message);

                            tblKatCIDB.ajax.reload();

                        } else {
                            DisplayMaklumanModal(result.Message);
                        }

                    } else if (tab == 3) {

                        var NewKhusus = {
                            DataKhusus: {
                                KodKhusus: $('#KodKhusus').val(),
                                ButiranKhusus: $('#ButiranKhusus').val(),
                                KodKat: $('#ddlKat').val(),
                                ButiranKat: $('#ButiranKat').val()
                            }
                        }

                        var result = JSON.parse(await AjaxEditKhusus(NewKhusus));
                        if (result.Code == 00) {
                            tblKhusus.ajax.reload();
                            DisplayMaklumanModal(result.Message);
                        } else {
                            DisplayMaklumanModal(result.Message);
                        }
                    }
            }

        });

    </script>
</asp:Content>
