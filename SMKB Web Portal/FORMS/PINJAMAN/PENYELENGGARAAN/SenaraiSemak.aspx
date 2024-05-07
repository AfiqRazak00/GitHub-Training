﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="SenaraiSemak.aspx.vb" Inherits="SMKB_Web_Portal.SenaraiSemak" %>
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
                    <h6>Senarai Semak Permohonan</h6>
                    <div id="btnTambah" class="btn btn-primary">
                        <i class="fa fa-plus"></i>Senarai Semak 
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
                                <th scope="col">Kategori Pembiayaan</th>
                                <th scope="col">Jenis Pembiayaan</th>
                                <th scope="col">Butiran</th>
                                <th scope="col">Taraf Khidmat</th>
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
        <!-- Modal Add/Edit Senarai Semak -->
        <div class="modal fade" id="mdlSnraiSemk" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"">Maklumat Senarai Semak</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row pt-2">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-12 col-12 xddl">
                                        <div class="form-group input-group">
                                            <select class="input-group__select ui search dropdown" placeholder="" name="ddlKatPinj" id="ddlKatPinj">
                                            </select>
                                            <label class="input-group__label" for="ddlKatPinj">Kategori Pembiayaan <span style="color:red">*</span></label>
                                            <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-12 col-12 xddl">
                                        <div class="form-group input-group">
                                            <select class="input-group__select ui search dropdown" placeholder="" name="ddlJenPinj" id="ddlJenPinj">
                                            </select>
                                            <label class="input-group__label" for="ddlJenPinj">Jenis Pembiayaan <span style="color: red">*</span></label>
                                            <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small>
                                        </div>
                                    </div>
                                    <div class="form-group col-md- col-12 xddl">
                                        <div class="form-group input-group">
                                            <select class="input-group__select ui search dropdown" placeholder="" name="ddlButiran" id="ddlButiran">
                                            </select>
                                            <label class="input-group__label" for="ddlButiran">Butiran <span style="color: red">*</span></label>
                                            <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small>
                                        </div>
                                    </div>
                                    <div class="form-row col-md-12 col-12">
                                        <div class="form-group input-group col-md-6 col-12 ">
                                            <input type="text" class="tarafk input-group__input" placeholder="" value="" />
                                            <label class="input-group__label">Taraf Khidmat <span style="color:red">*</span></label>
                                            <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                        </div>
                                    </div>
                                    <div class="col-md-12 col-12"></div>
                                    <label>Status <span style="color:red">*</span></label>
                                    <div class="col-md-12 col-12">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="statusRadio" id="statusRadio1" value="1" checked>
                                            <label class="form-check-label" for="inlineRadio1">Aktif</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="statusRadio" id="statusRadio0" value="0">
                                            <label class="form-check-label" for="inlineRadio2">Tidak Aktif</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
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
            generateDropdown("ddlKatPinj", "SenaraiSemakWS.asmx/GetKategoriPinjaman", "Pilih Kategori Pembiayaan", false, null);
            generateDropdown("ddlJenPinj", "SenaraiSemakWS.asmx/GetJenisPinjaman", "Pilih Jenis Pembiayaan", false, null);
            generateDropdown("ddlButiran", "SenaraiSemakWS.asmx/GetButiran", "Pilih Butiran", false, null);
        });

        var shouldPop = true, searchQuery = "", oldSearchQuery = "", targetId = "";
        var curTblRow = 0;
        var isEdit = false;

        //Run init
        init();

        function init() {
            loadSenarai();
        }

        var isClicked = false;
     

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
                    var value = data.Id;
                    //Assign Value To Global Variable targetId
                    targetId = value;
                    var rdata = await ajaxPost("SenaraiSemakWS.asmx/GetSelectedRow", { id: value }, false);

                    if (rdata.Status) {
                        var dt = rdata.Payload[0];
                        buildDdl('ddlKatPinj', dt.KodKatPinj, dt.TxtKatPinj);
                        buildDdl('ddlJenPinj', dt.KodJenPinj, dt.TxtJenPinj);
                        buildDdl('ddlButiran', dt.KodButiran, dt.TxtButiran);
                        $(".tarafk").val(dt.TarafKhidmat);
                        $("#statusRadio" + dt.Status).prop('checked', true);

                        //Set isEdit true - flag for btn simpan
                        isEdit = true;

                        //Show Modal Kelayakan
                        $("#mdlSnraiSemk").modal('show');
                    }
                });
            },
            "columnDefs": [
                // Header center align
                { className: "dt-head-center", targets: [0, 1, 2, 3, 4, 5] },
                //// Amaun semua right align
                //{ className: "dt-body-right", targets: [0, 1, 2, 3, 4, 5] },
                // Col yg bukan butiran center align
                { className: "dt-body-center", targets: [0, 1, 2, 4, 5] },
            ],
            "columns": [
                {
                    "data": "RowNum",
                    "width": "5%"
                },
                {
                    "data": "KatPinj",
                    "width": "15%"
                },
                {
                    "data": "JenPinj",
                    "width": "15%"
                },
                { "data": "Butiran" },
                {
                    "data": "TarafKhidmat",
                    "width": "10%"
                },
                {
                    "data": "Status",
                    "width": "10%",
                    "render": function (data, type, row) {
                        if (data == '1' || data == 1) {
                            return 'Aktif';
                        } else {
                            return 'Tidak Aktif';
                        }
                    }
                },
            ],
        });

        //NUMERIC INPUT Text
        $(".amaun, .ansuran").on('input', function (e) {
            if (e.which >= 37 && e.which <= 40) return;
            $(this).val(function (index, value) {
                return value
                    // Keep only digits and decimal points:
                    .replace(/[^\d.]/g, "")
                    // Remove duplicated decimal point, if one exists:
                    .replace(/^(\d*\.)(.*)\.(.*)$/, '$1$2$3')
                    // Keep only two digits past the decimal point:
                    .replace(/\.(\d{2})\d+/, '.$1')
                    // Add thousands separators:
                    .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
            });
        });

        $(".tempoh").on('input', function (e) {
            if (e.which >= 37 && e.which <= 40) return;
            $(this).val(function (index, value) {
                return value
                    // Keep only digits:
                    .replace(/[^\d]/g, "");
            });
        });

        $(".amaun, .ansuran").on('blur', function () {
            $(this).val(function (index, value) {
                if (isSet(value)) {
                    if (/\./.test(value)) {
                        return value;
                    } else {
                        return (value + ".00");
                    }
                } else {
                    return "";
                }
            });
        });

        $("#btnSimpan").off('click').on('click', async function () {

            var slctdStatus = isSet($('input[name="statusRadio"]:checked').val());
            var ddlKatPinj = isSet($("#ddlKatPinj").val());
            var ddlJenPinj = isSet($("#ddlJenPinj").val());
            var ddlButiran = isSet($("#ddlButiran").val());
            var tarafk = isSet($(".tarafk").val());

            if (isEdit) {
                if (ddlKatPinj && ddlJenPinj && ddlButiran && slctdStatus && tarafk) {

                    $("#mdlSnraiSemk").modal('hide');

                    var postDt = {
                        KategoriPinj: viewDt($("#ddlKatPinj").val(), 'text'),
                        JenisPinj: viewDt($("#ddlJenPinj").val(), 'text'),
                        Butiran: viewDt($("#ddlButiran").val(), 'text'),
                        Status: viewDt($('input[name="statusRadio"]:checked').val(), 'int'),
                        TarafK: viewDt($(".tarafk").val(), 'int'),
                        TargetId: viewDt(targetId.toString(), 'text'),
                    };

                    var data = await ajaxPost("SenaraiSemakWS.asmx/KemaskiniSenaraiSemak", postDt, true);

                    if (data.Status) {
                        var dt = data.Payload[0];
                        // Get current page index
                        var currentPageIndex = dttable.page.info().page;

                        // Get the number of rows per page
                        var rowsPerPage = dttable.page.info().length;

                        // Calculate the adjusted row index based on pagination
                        var adjustedRowIndex = ((currentPageIndex * rowsPerPage) + curTblRow);

                        // Update DataTable current row
                        dttable.cell(adjustedRowIndex, 1).data(dt.TxtKatPinj); // Gaji Ke
                        dttable.cell(adjustedRowIndex, 2).data(dt.TxtJenPinj); // Max Tempoh
                        dttable.cell(adjustedRowIndex, 3).data(dt.TxtButiran); // Max Amaun
                        dttable.cell(adjustedRowIndex, 4).data(postDt.TarafK); // Status
                        dttable.cell(adjustedRowIndex, 5).data(postDt.Status); // Status

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
                        { condition: !ddlKatPinj, selector: "#ddlKatPinj" },
                        { condition: !ddlJenPinj, selector: "#ddlJenPinj" },
                        { condition: !ddlButiran, selector: "#ddlButiran" },
                        { condition: !tarafk, selector: ".tarafk" },
                    ];

                    elementsToCheck.forEach(({ condition, selector }) => {
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

                    //$("#detailMakluman").html("Sila isi semua ruangan yang bertanda <span class= 'text-danger' >*</span>");
                    //$("#maklumanModal").modal('toggle');
                }
            } else {
                if (ddlKatPinj && ddlJenPinj && ddlButiran && slctdStatus && tarafk) {

                    $("#mdlSnraiSemk").modal('hide');

                    var postDt = {
                        KategoriPinj: viewDt($("#ddlKatPinj").val(), 'text'),
                        JenisPinj: viewDt($("#ddlJenPinj").val(), 'text'),
                        Butiran: viewDt($("#ddlButiran").val(), 'text'),
                        Status: viewDt($('input[name="statusRadio"]:checked').val(), 'int'),
                        TarafK: viewDt($(".tarafk").val(), 'int'),
                    };

                    var data = await ajaxPost("SenaraiSemakWS.asmx/TambahSenaraiSemak", postDt, true);

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
                        { condition: !ddlKatPinj, selector: "#ddlKatPinj" },
                        { condition: !ddlJenPinj, selector: "#ddlJenPinj" },
                        { condition: !tarafk, selector: ".tarafk" },
                        { condition: !ddlButiran, selector: "#ddlButiran" },
                    ];

                    elementsToCheck.forEach(({ condition, selector }) => {
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

                    //$("#detailMakluman").html("Sila isi semua ruangan yang bertanda <span class= 'text-danger' >*</span>");
                    //$("#maklumanModal").modal('toggle');
                }
            }
        });

        $("#btnTambah").off("click").on("click", function () {
            clearAndEnableEdit();
            isEdit = false; //Set isEdit false - flag for btn simpan
            $("#mdlSnraiSemk").modal('show');
        });

        function clearAndEnableEdit() {
            //Clear Field      
            $(".txtEror").addClass("codx");
            $('#mdlSnraiSemk .input-group__select select').each(function () {
                const element = $(this).closest('.form-group').find('.txtEror');
                var tempSlctr = $(this).val();
                if (isSet(tempSlctr)) {
                    $(this).dropdown("clear");
                }
                $(this).parent().removeClass("border border-danger");
                element.addClass('codx');
            });
            $('#mdlSnraiSemk .input-group__input').each(function () {
                const element = $(this).closest('.form-group').find('.txtEror');
                $(this).val(''); // Set the value to an empty string
                $(this).removeClass("border border-danger");
                element.addClass('codx');
            });

            //Enable Field
            $('#mdlSnraiSemk .input-group__select select').each(function () {
                $(this).parent().removeClass('disabled');
                $(this).parent().parent().removeClass('incolor')
            });
            $('#mdlSnraiSemk .input-group__input').each(function () {
                $(this).prop('disabled', false).prop('readonly', false);
            });
        }

        function buildDdl(id, kodVal, txtVal) {
            if (isSet(kodVal) && isSet(txtVal)) {
                $("#" + id).html("<option value = '" + kodVal + "'>" + txtVal + "</option>")
                $("#" + id).dropdown('set selected', kodVal);
            }
        }

        async function loadSenarai() {

            var data = await ajaxPost("SenaraiSemakWS.asmx/FetchSenarai", {}, true);

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
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.value +' - '+ option.text));
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