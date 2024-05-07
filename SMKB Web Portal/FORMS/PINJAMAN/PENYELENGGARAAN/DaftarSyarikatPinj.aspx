<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="DaftarSyarikatPinj.aspx.vb" Inherits="SMKB_Web_Portal.DaftarSyarikatPinj" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
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

        input[readonly] {
            background-color: #e5e5e5; /* Adjust the color as needed */
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

        #tblSenarai td:hover {
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
            max-width: 1200px; /* Set the maximum width for the modal content */
            margin: auto; /* Center the modal horizontally */
        }

        .form-group {
            /* Optionally, adjust the width of the form elements if needed */
            max-width: 100%; /* Set the maximum width for the form elements */
        }

        .codx {
            display: none;
            visibility: hidden;
        }

        .incolor {
            background-color: #e9ecef;
            color: #ffffff;
        }

        .xddl {
            margin-bottom: 0px
        }
    </style>
    <link rel="stylesheet" href="../style.css" />
    <div class="panel panel-default">
        <div class="panel-heading">
        <div class="modal-body">
            <div class="table-title">
                <h6>Senarai Pendaftaran Syarikat Pembiayaan</h6>
                <div id="btnTambah" class="btn btn-primary">
                    <i class="fa fa-plus"></i>Syarikat Pembiayaan 
                </div>
            </div>
        </div>
        <br />
    </div>

    <div class="modal-body">
        <div class="col-md-12">
            <div class="transaction-table table-responsive">
                <table id="tblSenarai" class="table table-striped" style="width: 100%">
                    <thead>
                        <tr>
                            <th scope="col">Bil</th>
                            <th scope="col">No. Id Pembekal</th>
                            <th scope="col">Nama Syarikat</th>
                            <th scope="col">Status Syarikat Pembiayaan</th>
                            <th scope="col">Status Syarikat Insuran</th>
                            <th scope="col">Status</th>
                        </tr>
                    </thead>
                </table>
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
                <div class="modal-body">
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
    <!-- Modal Add/Edit Jadual Kelayakan -->
    <div class="modal fade" id="mdlKawalan" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"">Maklumat Syarikat Pembiayaan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="form-group input-group col-md-12 col-12 codx">
                                    <input type="text" class="idPembekal input-group__input" placeholder="" value="" disabled readonly/>
                                    <label class="input-group__label">No. Id Pembekal</label>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="form-group col-md-12 col-12">
                                    <input type="text" class="noSykt input-group__input" placeholder="" value="" />
                                    <label class="input-group__label">No. Syarikat <span style="color: red">*</span></label>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="form-group col-md-12 col-12">
                                    <input type="text" class="namaSykt input-group__input" placeholder="" value="" />
                                    <label class="input-group__label">Nama Syarikat <span style="color: red">*</span></label>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="form-group col-md-12 col-12 mb-2">
                                    <input type="text" class="alamat1 input-group__input" placeholder="" value="" />
                                    <label class="input-group__label">Alamat <span style="color: red">*</span></label>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="form-group col-md-12 col-12">
                                    <input type="text" class="alamat2 input-group__input" placeholder="" value="" />
                                </div>
                                <div class="col-md-6 col-12 xddl">
                                    <div class="form-group input-group">
                                        <select class="input-group__select ui search dropdown" placeholder="" name="ddlBandar" id="ddlBandar">
                                        </select>
                                        <label class="input-group__label" for="ddlBandar">Bandar <span style="color: red">*</span></label>
                                        <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small>
                                    </div>
                                </div>
                                <div class="col-md-6 col-12 xddl">
                                    <div class="form-group input-group">
                                        <select class="input-group__select ui search dropdown" placeholder="" name="ddlPoskod" id="ddlPoskod">
                                        </select>
                                        <label class="input-group__label" for="ddlPoskod">Poskod <span style="color: red">*</span></label>
                                        <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small>
                                    </div>
                                </div>
                                <div class="col-md-6 col-12 xddl">
                                    <div class="form-group input-group">
                                        <select class="input-group__select ui search dropdown" placeholder="" name="ddlNegeri" id="ddlNegeri">
                                        </select>
                                        <label class="input-group__label" for="ddlNegeri">Negeri <span style="color: red">*</span></label>
                                        <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small>
                                    </div>
                                </div>
                                <div class="col-md-6 col-12 xddl">
                                    <div class="form-group input-group">
                                        <select class="input-group__select ui search dropdown" placeholder="" name="ddlNegara" id="ddlNegara">
                                        </select>
                                        <label class="input-group__label" for="ddlNegara">Negara <span style="color: red">*</span></label>
                                        <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small></div>
                                    </div>
                                <div class="col-md-12 col-12 pb-3">
                                    <hr/>
                                </div>
                                <div class="col-md-6 col-12 xddl">
                                    <div class="form-group input-group">
                                        <select class="input-group__select ui search dropdown" placeholder="" name="ddlBank" id="ddlBank">
                                        </select>
                                        <label class="input-group__label" for="ddlBank">Bank <span style="color: red">*</span></label>
                                        <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small></div>
                                    </div>
                                <div class="form-group input-group col-md-6 col-12">
                                    <input type="text" class="noAcc input-group__input" placeholder="" value="" />
                                    <label class="input-group__label">No. Akaun <span style="color: red">*</span></label>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="form-group input-group col-md-6 col-12">
                                    <input type="text" class="noTel input-group__input" placeholder="" value="" />
                                    <label class="input-group__label">No. Telefon</label>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="form-group input-group col-md-6 col-12">
                                    <input type="text" class="emel input-group__input" placeholder="" value="" />
                                    <label class="input-group__label">Emel</label>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="col-md-4 col-12">
                                    <fieldset class="pb-2 pl-2 pr-2">
                                        <legend class="w-auto" style="font-size: 11px;"><b>Status Syarikat Pembiayaan </b></legend>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="staSyktPinj" id="staSyktPinj1" value="1" checked>
                                            <label class="form-check-label" for="inlineRadio1">Ya</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="staSyktPinj" id="staSyktPinj0" value="0">
                                            <label class="form-check-label" for="inlineRadio2">Tidak</label>
                                        </div>
                                    </fieldset>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="col-md-4 col-12">
                                    <fieldset class="pb-2 pl-2 pr-2">
                                        <legend class="w-auto" style="font-size: 11px;"><b>Status Syarikat Insuran </b></legend>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="staSyktIns" id="staSyktIns1" value="1" checked>
                                            <label class="form-check-label" for="inlineRadio1">Ya</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="staSyktIns" id="staSyktIns0" value="0">
                                            <label class="form-check-label" for="inlineRadio2">Tidak</label>
                                        </div>
                                    </fieldset>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="col-md-4 col-12">
                                    <fieldset class="pb-2 pl-2 pr-2">
                                        <legend class="w-auto" style="font-size: 11px;"><b>Status</b></legend>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="stAktif" id="stAktif1" value="1" checked>
                                            <label class="form-check-label" for="inlineRadio1">Aktif</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="stAktif" id="stAktif0" value="0">
                                            <label class="form-check-label" for="inlineRadio2">Tidak Aktif</label>
                                        </div>
                                    </fieldset>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<label>Status : <span style="color: red">*</span></label>--%>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                    <button type="button" id="btnSimpan" class="btn btn-secondary">Simpan</button>

                </div>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript">

    $(document).ready(function () {
        /*generateDropdown("id", "path", "place holder", "flag send data to web services or either", "parent dropdown (dependable)","function after ajax success");*/
        generateDropdown("ddlBandar", "DaftarSyarikatPinjWS.asmx/GetBandar", "Pilih Bandar", false, null);
        generateDropdown("ddlPoskod", "DaftarSyarikatPinjWS.asmx/GetPoskod", "Pilih Poskod", false, null);
        generateDropdown("ddlNegeri", "DaftarSyarikatPinjWS.asmx/GetNegeri", "Pilih Negeri", false, null);
        generateDropdown("ddlNegara", "DaftarSyarikatPinjWS.asmx/GetNegara", "Pilih Negara", false, null);
        generateDropdown("ddlBank", "DaftarSyarikatPinjWS.asmx/GetBank", "Pilih Bank", false, null);
    });

    var shouldPop = true, searchQuery = "", oldSearchQuery = "";
    var curTblRow = 0; 
    var isEdit = false;
    var postTargetId = "";

    //Run init
    init();

    function init() {
        loadSenarai();
    }

    var isClicked = false;
    function ShowPopup(elm) {
        console.log('try');
        if (elm == "1") {
            $('#modalJenisStok').modal('toggle');
        }
        else if (elm == "2") {
            $(".modal-body div").val("");
            $('#modalJenisStok2').modal('toggle');


            $('.btnSearch').click();

            $('.btnEmel').show();
            $('.btnCetak').show();
        }
    }

    function isSet(value) {
        if (value === null || value === '' || value === undefined) {
            return false;
        } else {
            return true;
        }
    }

    var dttable = $("#tblSenarai").DataTable({
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
        "rowCallback": async function (row, data, index) {

            $(row).hover(function () {
                $(this).addClass("hover pe-auto bg-warning");
            }, function () {
                $(this).removeClass("hover pe-auto bg-warning");
            });

            $(row).off('click').on('click', async function () {
                curTblRow = index;

                clearAndEnableEdit();
                $(".idPembekal").parent().removeClass('codx').find(".idPembekal").prop({ 'disabled': true, 'readonly': true });


                var value = data.IdPembekal;
                //Assign Value To Global Variable targetId
                targetId = value;
                var rdata = await ajaxPost("DaftarSyarikatPinjWS.asmx/GetSelectedRow", { id: value }, false);

                if (rdata.Status) {
                    var dt = rdata.Payload[0];
                    buildDdl('ddlBandar', dt.KodBandar, dt.TxtBandar);
                    buildDdl('ddlPoskod', dt.KodPoskod, dt.TxtPoskod);
                    buildDdl('ddlNegeri', dt.KodNegeri, dt.TxtNegeri);
                    buildDdl('ddlNegara', dt.KodNegara, dt.TxtNegara);
                    buildDdl('ddlBank', dt.KodBank, dt.TxtBank || '');
                    $(".idPembekal").val(data.IdPembekal || '');
                    $(".namaSykt").val(dt.NamaSykt || '');
                    $(".noSykt").val(dt.NoSykt || '');
                    $(".alamat1").val(dt.Almt1 || '');
                    $(".alamat2").val(dt.Almt2 || '');
                    $(".noAcc").val(dt.NoAkaun || '');
                    $(".noTel").val(dt.NoTelPej || '');
                    $(".emel").val(dt.Emel || '');

                    $("#staSyktPinj" + (dt.StatusSyktPinj || '0')).prop('checked', true);
                    $("#staSyktIns" + (dt.StatusSyktIns || '0')).prop('checked', true);
                    $("#stAktif" + (dt.StatusAktif || '0')).prop('checked', true);

                    postTargetId = data.IdPembekal;

                    //Set isEdit true - flag for btn simpan
                    isEdit = true;

                    //Show Modal Kelayakan
                    $("#mdlKawalan").modal('show');
                }
            });
        },
        "columnDefs": [
            // Header center align
            { className: "dt-head-center", targets: [0, 1, 2, 3, 4, 5] },
            // Amaun semua right align
            //{ className: "dt-body-right", targets: [2, 3, 5] },
            // Col yg bukan butiran center align
            { className: "dt-body-center", targets: [0, 3, 4, 5] },
        ],
        "columns": [
            {
                "data": "RowNum",
                "width": "5%"
            },
            {
                "data": "IdPembekal",
                "width": "10%"
            },
            {
                "data": "NamaSykt",
                "width": "20%"
            },
            {
                "data": "StatusSyktPinj",
                "width": "10%"
            },
            {
                "data": "StatusSyktIns",
                "width": "10%"
            },
            {
                "data": "StatusAktif",
                "width": "10%"
            },
        ],
    });

    $(".faedah").on('input', function (e) {
        if (e.which >= 37 && e.which <= 40) return;
        $(this).val(function (index, value) {
            return value
                // Keep only digits and decimal points:
                .replace(/[^\d.]/g, "")
                // Remove duplicated decimal point, if one exists:
                .replace(/^(\d*\.)(.*)\.(.*)$/, '$1$2$3')
                // Keep only two digits past the decimal point:
                .replace(/\.(\d{2})\d+/, '.$1')
        });
    });

    $(".faedah").on('blur', function () {
        $(this).val(function (index, value) {
            if (isSet(value)) {
                if (parseInt(value) <= 100.00){
                    if (/\./.test(value)) {
                        return value;
                    } else {
                        return (value + ".00");
                    }
                } else {
                    return "";
                }
            } else {
                return "";
            }
        });
    });

    $("#btnSimpan").off('click').on('click', async function () {

        var targetId = $(".idPembekal").val()
        var ddlBandar = isSet($("#ddlBandar").val())
        var ddlPoskod = isSet($("#ddlPoskod").val());
        var ddlNegeri = isSet($("#ddlNegeri").val());
        var ddlNegara = isSet($("#ddlNegara").val());
        var ddlBank = isSet($("#ddlBank").val());
        var namaSykt = isSet($(".namaSykt").val());
        var noSykt = isSet($(".noSykt").val());
        var alamat1 = isSet($(".alamat1").val())
        var alamat2 = isSet($(".alamat2").val());
        var noAcc = isSet($(".noAcc").val());
        var staSyktPinj = isSet($('input[name="staSyktPinj"]:checked').val());
        var staSyktIns = isSet($('input[name="staSyktIns"]:checked').val());
        var stAktif = isSet($('input[name="stAktif"]:checked').val());

        if (isEdit) {
            if (targetId && namaSykt && alamat1 && ddlBandar && ddlPoskod && ddlNegeri && ddlNegara && ddlBank && noAcc && stAktif && noSykt) {

                $("#mdlKawalan").modal('hide');

                var postDt = {
                    Id: viewDt(targetId, 'text'),
                    Bandar: viewDt($("#ddlBandar").val(), 'text'),
                    Poskod: viewDt($("#ddlPoskod").val(), 'text'),
                    Negeri: viewDt($("#ddlNegeri").val(), 'text'),
                    Negara: viewDt($("#ddlNegara").val(), 'text'),
                    Bank: viewDt($("#ddlBank").val(), 'text'),
                    NamaSykt: viewDt($(".namaSykt").val(), 'text'),
                    NoSykt: viewDt($(".noSykt").val(), 'text'),
                    Alamat1: viewDt($(".alamat1").val(), 'text'),
                    Alamat2: viewDt($(".alamat2").val(), 'text'),
                    NoAcc: viewDt($(".noAcc").val(), 'text'),
                    Emel: viewDt($(".emel").val(), 'text'),
                    Tel: viewDt($(".noTel").val(), 'text'),
                    StatusAktif: viewDt($('input[name="stAktif"]:checked').val(), 'int'),
                    StatusSyktPinj: viewDt($('input[name="staSyktPinj"]:checked').val(), 'int'),
                    StatusSyktIns: viewDt($('input[name="staSyktIns"]:checked').val(), 'int'),
                };

                var data = await ajaxPost("DaftarSyarikatPinjWS.asmx/KemaskiniData", postDt, true);

                if (data.Status) {
                    var dt = data.Payload[0];

                    // Get current page index
                    var currentPageIndex = dttable.page.info().page;

                    // Get the number of rows per page
                    var rowsPerPage = dttable.page.info().length;

                    // Calculate the adjusted row index based on pagination
                    var adjustedRowIndex = ((currentPageIndex * rowsPerPage) + curTblRow);

                    // Update DataTable current row
                    dttable.cell(adjustedRowIndex, 2).data(dt.NamaSykt); 
                    dttable.cell(adjustedRowIndex, 3).data(dt.StatusSyarikatPinj); 
                    dttable.cell(adjustedRowIndex, 4).data(dt.StatusSyarikatInsuran); 
                    dttable.cell(adjustedRowIndex, 5).data(dt.StatusAktif); 

                    // Redraw the table to reflect changes
                    dttable.draw('page');

                    // Restore pagination
                    dttable.page(currentPageIndex).draw('page');

                    $("#detailMakluman").text(data.Message);
                    $("#maklumanModal").modal('show');
                }
            } else {
                ////Show error on empty field
                const elementsToCheck = [
                    { condition: !noSykt, selector: ".noSykt" },
                    { condition: !namaSykt, selector: ".namaSykt" },
                    { condition: !alamat1, selector: ".alamat1" },
                    { condition: !ddlBandar, selector: "#ddlBandar" },
                    { condition: !ddlPoskod, selector: "#ddlPoskod" },
                    { condition: !ddlNegeri, selector: "#ddlNegeri" },
                    { condition: !ddlNegara, selector: "#ddlNegara" },
                    { condition: !ddlBank, selector: "#ddlBank" },
                    { condition: !noAcc, selector: ".noAcc" },
                ];

                fetchErrorMsg(elementsToCheck);

                //$("#detailMakluman").html("Sila isi semua ruangan yang bertanda <span class= 'text-danger' >*</span>");
                //$("#maklumanModal").modal('toggle');
            }
        } else {
            if (namaSykt && alamat1 && ddlBandar && ddlPoskod && ddlNegeri && ddlNegara && ddlBank && noAcc && stAktif && noSykt) {

                $("#mdlKawalan").modal('hide');

                var postDt = {
                    Bandar: viewDt($("#ddlBandar").val(), 'text'),
                    Poskod: viewDt($("#ddlPoskod").val(), 'text'),
                    Negeri: viewDt($("#ddlNegeri").val(), 'text'),
                    Negara: viewDt($("#ddlNegara").val(), 'text'),
                    Bank: viewDt($("#ddlBank").val(), 'text'),
                    NamaSykt: viewDt($(".namaSykt").val(), 'text'),
                    NoSykt: viewDt($(".noSykt").val(), 'text'),
                    Alamat1: viewDt($(".alamat1").val(), 'text'),
                    Alamat2: viewDt($(".alamat2").val(), 'text'),
                    NoAcc: viewDt($(".noAcc").val(), 'text'),
                    Emel: viewDt($(".emel").val(), 'text'),
                    Tel: viewDt($(".noTel").val(), 'text'),
                    StatusAktif: viewDt($('input[name="stAktif"]:checked').val(), 'int'),
                    StatusSyktPinj: viewDt($('input[name="staSyktPinj"]:checked').val(), 'int'),
                    StatusSyktIns: viewDt($('input[name="staSyktIns"]:checked').val(), 'int'),
                };

                var data = await ajaxPost("DaftarSyarikatPinjWS.asmx/TambahData", postDt, true);

                if (data.Status) {
                    //Reload Table
                    loadSenarai();

                    $("#detailMakluman").text(data.Message);
                    $("#maklumanModal").modal('show');
                } else {
                    $("#detailMakluman").text(data.Message);
                    $("#maklumanModal").modal('show');
                }
            } else {
                //Show error on empty field
                const elementsToCheck = [
                    { condition: !noSykt, selector: ".noSykt" },
                    { condition: !namaSykt, selector: ".namaSykt" },
                    { condition: !alamat1, selector: ".alamat1" },
                    { condition: !ddlBandar, selector: "#ddlBandar" },
                    { condition: !ddlPoskod, selector: "#ddlPoskod" },
                    { condition: !ddlNegeri, selector: "#ddlNegeri" },
                    { condition: !ddlNegara, selector: "#ddlNegara" },
                    { condition: !ddlBank, selector: "#ddlBank" },
                    { condition: !noAcc, selector: ".noAcc" },
                ];

                fetchErrorMsg(elementsToCheck);
                
                //$("#detailMakluman").html("Sila isi semua ruangan yang bertanda <span class= 'text-danger' >*</span>");
                //$("#maklumanModal").modal('toggle');
            }
        }
    });

    function fetchErrorMsg(data) {
        data.forEach(({ condition, selector }) => {
            const element = $(selector).closest('.form-group').find('.txtEror');
            if (condition) {
                if ($(selector).is('select')) {
                    $(selector).parent().addClass("border border-danger");
                } else {
                    $(selector).addClass("border border-danger");
                }
                element.removeClass('codx');
            } else {
                if ($(selector).is('select')) {
                    $(selector).parent().removeClass("border border-danger");
                } else {
                    $(selector).removeClass("border border-danger");
                }
                element.addClass('codx');
            }
        });
    }

    $("#btnTambah").off("click").on("click", function () {
        clearAndEnableEdit();
        $(".idPembekal").parent().addClass('codx');
        isEdit = false; //Set isEdit false - flag for btn simpan
        $("#mdlKawalan").modal('show');
    });

    function clearAndEnableEdit() {
        //Clear Field      
        $(".txtEror").addClass("codx");
        $('#mdlKawalan .input-group__select select').each(function () {
            const element = $(this).closest('.form-group').find('.txtEror');
            var tempSlctr = $(this).val();
            if (isSet(tempSlctr)) {
                $(this).dropdown("clear");
            }
            $(this).parent().removeClass("border border-danger");
            element.addClass('codx');
        });
        $('#mdlKawalan .input-group__input').each(function () {
            const element = $(this).closest('.form-group').find('.txtEror');
            $(this).val(''); // Set the value to an empty string
            $(this).removeClass("border border-danger");
            element.addClass('codx');
        });

        //Enable Field
        $('#mdlKawalan .input-group__select select').each(function () {
            $(this).parent().removeClass('disabled');
            $(this).parent().parent().removeClass('incolor')
        });
        $('#mdlKawalan .input-group__input').each(function () {
            $(this).prop('disabled', false).prop('readonly', false);
        });

        $("#staSyktPinj1").prop('checked', true);
        $("#staSyktIns1").prop('checked', true);
        $("#stAktif1").prop('checked', true);
    }

    function buildDdl(id, kodVal, txtVal) {
        if (isSet(kodVal) && isSet(txtVal)) {
            $("#" + id).html("<option value = '" + kodVal + "'>" + txtVal + "</option>")
            $("#" + id).dropdown('set selected', kodVal);
        }
    }

    async function loadSenarai() {

        var data = await ajaxPost("DaftarSyarikatPinjWS.asmx/FetchSenaraiSyarikatPinjaman", {}, true);

        if (isSet(data)) {
            dttable.clear();
            dttable.rows.add(data.Payload).draw();
            //var rowCount = tbl.rows().count();
        }
    }

    function viewDt(value, type) {
        var result = '';
        if (type == 'text') {
            (isSet(value)) ? result = value : result = ''
        } else if (type == 'int') {
            (isSet(value)) ? result = value : result = '0'
        } else if (type == 'double') {
            (isSet(value)) ? result = value : result = '0.00'
        }

        return result;
    }

    async function ajaxPost(url, postData, enableLoader, fn) {
        if (enableLoader) show_loader();

        var dtToString = JSON.stringify(postData);

        return new Promise((resolve, reject) => {
            $.ajax({
                url: url,
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ postData: dtToString }),
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    result = JSON.parse(data.d);
                    if (fn !== null && fn !== undefined) {
                        fn(result);
                    }
                    if (enableLoader) close_loader();
                    resolve(result);
                },
                error: function (xhr, status, error) {
                    if (enableLoader) close_loader();
                    console.error("Error fetching details:" + error);
                    reject(false);
                }
            });
        })
    }

    async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {

        var param = '';
        (sendData !== null && sendData !== undefined) ? param = '' : param = '?q={query}';

        $('#' + id).dropdown({
            fullTextSearch: true,
            placeholder: plchldr,
            apiSettings: {
                url: url + param,
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                //onChange: function (value, text, $selectedItem) {
                //    if (fn !== null && fn !== undefined) {
                //        return fn();
                //    }
                //},
                beforeSend: function (settings) {
                    if (send2ws) {
                        settings.data = JSON.stringify({
                            q: settings.urlData.query,
                            data: $('#' + sendData).val()
                        });
                        searchQuery = settings.urlData.query;
                        return settings;
                    } else {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({ q: settings.urlData.query });
                        searchQuery = settings.urlData.query;
                        return settings;
                    }
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

                    if (fn !== null && fn !== undefined) {
                        fn();
                    }

                    /*dependable ddl if sendata value == empty clear all option*/
                    if (sendData !== null && sendData !== undefined) {
                        var tempDt = $('#' + sendData).val();
                        if (tempDt == null && tempDt == undefined) {
                            $('#' + id + ' .dropdown').addClass("disableDdlIcon");
                            return false;
                        }
                    }

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
    }
</script>
</asp:Content>
