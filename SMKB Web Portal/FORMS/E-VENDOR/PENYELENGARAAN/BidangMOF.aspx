<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="BidangMOF.aspx.vb" Inherits="SMKB_Web_Portal.BidangMOF" %>

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

        <!-- Bidang tab -->
        <ul class="nav nav-tabs" id="myTabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#BidangUtama">Bidang Utama</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#SubBidang">Sub Bidang</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Bidang">Bidang</a>
            </li>
        </ul>

        <div class="tab-content">

            <!-------------------     Tab 1 (Bidang Utama)   ------------------------>
            <div class="tab-pane fade show active" id="BidangUtama">

                <div class="col-md-12 mt-3 mb-3">
                    <div class="row">
                        <div class="col-md-6" style="display: flex; justify-content: flex-start; align-items: flex-start;">
                            <div class="form-group" style="align-self: flex-start;">
                                <h6 class="modal-title" id="titleBidangUtama" style="visibility: hidden;">Senarai Bidang Utama</h6>
                            </div>
                        </div>
                        <div class="col-md-6" style="display: flex; justify-content: flex-end; align-items: flex-end;">
                            <div class="form-group" style="align-self: flex-end;">
                                <div class="btn btn-primary btnBidangUtama">
                                    <i class="fa fa-plus"></i>Bidang Utama   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />

                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblListBidangUtama" class="table table-striped" style="width: 100%">
                            <thead>
                                <tr data-id="">
                                    <th scope="col">Bil</th>
                                    <th scope="col">Kod</th>
                                    <th scope="col">Bidang Utama</th>
                                    <th scope="col">Tindakan</th>
                                </tr>
                            </thead>
                            <tbody id="tblRowBidangUtama">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!------ Maklumat Bidang Utama -------------->
            <div class="modal fade" id="BidangUtamaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="titleFormBidangUtama">Tambah Bidang Utama</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="KodBU" name="KodBU" />
                                    <label class="input-group__label">Kod</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <textarea class="input-group__input form-control input-sm" placeholder="" id="ButiranBU" name="ButiranBU" rows="2"></textarea>
                                    <label class="input-group__label">Butiran</label>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            <button type="button" runat="server" id="btnSimpanBU" class="btn btn-secondary btnSimpanBU">Simpan</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Confirmation Modal -->
            <div class="modal fade" id="confirmationModalBU" tabindex="-1" role="dialog"
                aria-labelledby="confirmationModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmationModalLabel">Pengesahan</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" id="confirmContentBU">
                            Anda pasti ingin menyimpan rekod ini?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger"
                                data-dismiss="modal">
                                Tidak</button>
                            <button type="button" class="btn btn-secondary btnYaBU">Ya</button>
                            <button type="button" class="btn btn-secondary btnYaEditBU" style="display: none;">Ya</button>
                            <button type="button" class="btn btn-secondary btnYaDeleteBU" style="display: none;">Ya</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Makluman Modal -->
            <div class="modal fade" id="maklumanModalBU" tabindex="-1" role="dialog"
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

            <!-------------------     Tab 2 (Sub Bidang)   ------------------------>

            <div class="tab-pane fade show" id="SubBidang">

                <div class="col-md-12 mt-5 mb-3">

                    <div class="row">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="lblCarian" style="display: flex; justify-content: flex-end; align-items: flex-end;">Kod Bidang Utama : </label>
                                </div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <select id="categoryFilterBU" class="input-group__input form-control input_sm ui search dropdown categoryFilterBU ">
                                        </select>
                                        <div class="input-group-append">
                                            <button id="btnSearchBU" runat="server" class="btn btnSearchBU" type="button">
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
                                <h6 class="modal-title" id="titleSubBidang" style="visibility: hidden;">Senarai Sub Bidang</h6>
                            </div>
                        </div>
                        <div class="col-md-6" style="display: flex; justify-content: flex-end; align-items: flex-end;">
                            <div class="form-group" style="align-self: flex-end;">
                                <div class="btn btn-primary btnSubBidang">
                                    <i class="fa fa-plus"></i>Sub Bidang   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />

                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblListSubBidang" class="table table-striped" style="width: 100%">
                            <thead>
                                <tr data-id="">
                                    <th scope="col">Bil</th>
                                    <th scope="col">Kod</th>
                                    <th scope="col">Sub Bidang</th>
                                    <th scope="col">Kod Bidang Utama</th>
                                    <th scope="col">Tindakan</th>
                                </tr>
                            </thead>
                            <tbody id="tblRowSubBidang">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="SubBidangModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="titleFormSubBidang">Tambah Sub Bidang</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <select class="input-group__input form-control input_sm ui search dropdown ddlKodBU " name="ddlKodBU" id="ddlKodBU">
                                    </select>
                                    <label class="input-group__label">Kod Bidang Utama</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="KodSB" name="KodSB" />
                                    <label class="input-group__label">Kod</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <textarea class="input-group__input form-control input-sm" placeholder="" id="ButiranSB" name="ButiranSB" rows="2"></textarea>
                                    <label class="input-group__label">Butiran</label>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            <button type="button" runat="server" id="Button1" class="btn btn-secondary btnSimpanSB">Simpan</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Confirmation Modal -->
            <div class="modal fade" id="confirmationModalSB" tabindex="-1" role="dialog"
                aria-labelledby="confirmationModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmationModalLabelSB">Pengesahan</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" id="confirmContentSB">
                            Anda pasti ingin menyimpan rekod ini?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger"
                                data-dismiss="modal">
                                Tidak</button>
                            <button type="button" class="btn btn-secondary btnYaSB">Ya</button>
                            <button type="button" class="btn btn-secondary btnYaEditSB" style="display: none;">Ya</button>
                            <button type="button" class="btn btn-secondary btnYaDeleteSB" style="display: none;">Ya</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Makluman Modal -->
            <div class="modal fade" id="maklumanModalSB" tabindex="-1" role="dialog"
                aria-labelledby="maklumanModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="maklumanModalLabelSB">Makluman</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <span id="detailMaklumanSB"></span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="tutupMaklumanSB"
                                data-dismiss="modal">
                                Tutup</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-------------------     Tab 3 (Bidang)       ------------------------>

            <div class="tab-pane fade show" id="Bidang">

                <div class="col-md-12 mt-5 mb-3">

                    <div class="row">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="lblCarian" style="display: flex; justify-content: flex-end; align-items: flex-end;">Kod Sub Bidang : </label>
                                </div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <select id="categoryFilterBdg" class="input-group__input form-control input_sm ui search dropdown categoryFilterBdg ">
                                        </select>
                                        <div class="input-group-append">
                                            <button id="Button3" runat="server" class="btn btnSearchBdg" type="button">
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
                                <h6 class="modal-title" id="titleBidang" style="visibility: hidden;">Senarai Sub Bidang</h6>
                            </div>
                        </div>
                        <div class="col-md-6" style="display: flex; justify-content: flex-end; align-items: flex-end;">
                            <div class="form-group" style="align-self: flex-end;">
                                <div class="btn btn-primary btnBidang">
                                    <i class="fa fa-plus"></i>Bidang   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />

                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblListBidang" class="table table-striped" style="width: 100%">
                            <thead>
                                <tr data-id="">
                                    <th scope="col">Bil</th>
                                    <th scope="col">Kod</th>
                                    <th scope="col">Bidang</th>
                                    <th scope="col">Kod Sub Bidang</th>
                                    <th scope="col">Tindakan</th>
                                </tr>
                            </thead>
                            <tbody id="tblRowBidang">
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

            <div class="modal fade" id="BidangModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="titleFormBidang">Tambah Bidang</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <select class="input-group__input form-control input_sm ui search dropdown ddlKodSB " name="ddlKodSB" id="ddlKodSB">
                                    </select>
                                    <label class="input-group__label">Kod Sub Bidang</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="KodBdg" name="KodBdg" />
                                    <label class="input-group__label">Kod</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <textarea class="input-group__input form-control input-sm" placeholder="" id="ButiranBdg" name="ButiranBdg" rows="2"></textarea>
                                    <label class="input-group__label">Butiran</label>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            <button type="button" runat="server" id="Button2" class="btn btn-secondary btnSimpanBdg">Simpan</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Confirmation Modal -->
            <div class="modal fade" id="confirmationModalBdg" tabindex="-1" role="dialog"
                aria-labelledby="confirmationModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmationModalLabelBdg">Pengesahan</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" id="confirmContentBdg">
                            Anda pasti ingin menyimpan rekod ini?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger"
                                data-dismiss="modal">
                                Tidak</button>
                            <button type="button" class="btn btn-secondary btnYaBdg">Ya</button>
                            <button type="button" class="btn btn-secondary btnYaEditBdg" style="display: none;">Ya</button>
                            <button type="button" class="btn btn-secondary btnYaDeleteBdg" style="display: none;">Ya</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Makluman Modal -->
            <div class="modal fade" id="maklumanModalBdg" tabindex="-1" role="dialog"
                aria-labelledby="maklumanModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="maklumanModalLabelBdg">Makluman</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <span id="detailMaklumanBdg"></span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="tutupMaklumanBdg"
                                data-dismiss="modal">
                                Tutup</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <script type="text/javascript">

        //-------------------     Tab 1 (Bidang Utama)   ------------------------

        $(document).ready(function () {

            $('.btnBidangUtama').on('click', async function () {
                clearValueDataBU();
                $('#BidangUtamaModal').modal('toggle');
            });

            var tblBidangUtama = null;
            $(document).ready(function () {
                /* show_loader();*/
                tblBidangUtama = $("#tblListBidangUtama").DataTable({
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
                        "url": "EVendorPenyelengaraan_WS.asmx/LoadList_BidangUtama",
                        "method": 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        },
                        "data": function () {
                            //Filter by Session Syarikat
                            return JSON.stringify({
                                IdSya: '<%=Session("ssusrID")%>',
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
                        { "data": "Kod" },
                        { "data": "Butiran" },
                        {
                            className: "btnEdit",
                            "data": "Kod",
                            render: function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }

                                var link = `<button id="btnEdit" runat="server" class="btn btnEditBU" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDelete" runat="server" class="btn btnDeleteBU" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                                return link;
                            }
                        },

                    ]
                });
            });

            $('#tblListBidangUtama').on('click', '.btnEditBU', async function (event) {
                $('#titleFormBidangUtama').html("Kemaskini Bidang Utama");
                $('#BidangUtamaModal').modal("toggle");

                event.stopPropagation();
                var KodBU = $(this).data("id");

                if (KodBU != "") {
                    var DataBU = JSON.parse(await AjaxLoadDataBU(KodBU));

                    if (DataBU.length > 0) {
                        SetValueDataBU(DataBU);
                    } else {
                        console.log("Tiada respon Data Bidang Utama");
                    }
                }

                return false;
            });

            async function SetValueDataBU(DataBU) {
                $('#KodBU').val(DataBU[0].Kod);
                $('#ButiranBU').val(DataBU[0].Butiran);

            }

            async function clearValueDataBU(DataBU) {
                $('#KodBU').val("");
                $('#ButiranBU').val("");

            }

            $('#tblListBidangUtama').on('click', '.btnDeleteBU', async function (event) {
                event.stopPropagation();
                var curTR = $(this).closest("tr");
                var bool = true;
                var KodBU = $(this).data("id");

                $('.btnYaDeleteBU').show();
                $('.btnYaEditBU').hide();
                $('.btnYaBU').hide();
                $('#confirmContentBU').html("Adakah Anda Pasti ingin Memadam data ini?");
                $('#confirmationModalBU').modal("toggle");

                $('.btnYaDeleteBU').click(async function () {
                    $('#confirmationModalBU').modal("toggle");

                    if (KodBU !== "") {
                        bool = await DelBU(KodBU);
                    }

                    if (bool === true) {
                        curTR.remove();
                    }

                    displayMaklumanModal("Maklumat Berjaya Dipadam");
                    tblBidangUtama.ajax.reload();

                    return false;
                });
            });

            async function DelBU(KodBU) {
                var bool = false;
                var result = JSON.parse(await AjaxDeleteBU(KodBU));

                if (result.Code === "00") {
                    bool = true;
                }
                return bool;
            }

            $('.btnSimpanBU').on('click', async function () {
                if ($('#KodBU').val() == "" || $('#ButiranBU').val() == "") {
                    displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
                } else {
                    $('#BidangUtamaModal').modal("toggle");
                    $('.btnYaDeleteBU').hide();
                    $('.btnYaEditBU').hide();
                    $('.btnYaBU').show();
                    $('#confirmContentBU').html("Anda pasti ingin menyimpan rekod ini?")
                    $('#confirmationModalBU').modal("toggle");
                }
            });

            $('.btnYaBU').click(async function () {
                $('#confirmationModalBU').modal("toggle");
                //let KodBU = $(this).data("id");

                var BidangUtama = {
                    bdgUtama: {
                        KodBU: $('#KodBU').val(),
                        ButiranBU: $('#ButiranBU').val()
                    }
                }

                console.log("RecordBU: ", BidangUtama);
                var result = JSON.parse(await AjaxSaveBidangUtama(BidangUtama));

                console.log("Result: ", result.Message)
                if (result.Code == 00) {
                    tblBidangUtama.ajax.reload();
                    displayMaklumanModal(result.Message);
                } else {
                    displayMaklumanModal(result.Message);
                }
            });

            async function AjaxLoadDataBU(KodBU) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'EVendorPenyelengaraan_WS.asmx/LoadDataBU',
                        method: 'POST',
                        data: JSON.stringify({ KodBU: KodBU }),
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

            async function AjaxSaveBidangUtama(bdgUtama) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'EVendorPenyelengaraan_WS.asmx/SaveBidangUtama',
                        method: 'POST',
                        data: JSON.stringify(bdgUtama),
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

            async function AjaxDeleteBU(KodBU) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: 'EVendorPenyelengaraan_WS.asmx/DeleteBU',
                        method: 'POST',
                        data: JSON.stringify({ KodBU: KodBU }),
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
        });

        //-------------------     Tab 2 ( Sub Bidang)   ------------------------

        $(document).ready(function () {
            $('.btnSubBidang').on('click', async function () {
                clearValueDataSB();
                $('#SubBidangModal').modal('toggle');
            });

            $('#categoryFilterBU').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'EVendorPenyelengaraan_WS.asmx/GetKodBdgUtama?q={query}',
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
                        $('#categoryFilterBU').data('apiResponse', listOptions);

                        // Update the options of the second dropdown on page load
                        //updateSecondDropdown($(this).dropdown('get value'), '#ddlKat');
                    },
                }
            });

            $('#ddlKodBU').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'EVendorPenyelengaraan_WS.asmx/GetKodBdgUtama?q={query}',
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

                        //if (shouldPop === true) {
                        //    $(obj).dropdown('show');
                        //}
                    }
                }
            });

            var tblSubBidang = null;
            $(document).ready(function () {

                let IsClicked = false;

                $('.btnSearchBU').on('click', async function () {
                    IsClicked = true;
                    tblSubBidang.ajax.reload();
                });

                /* show_loader();*/
                tblSubBidang = $("#tblListSubBidang").DataTable({
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
                        "url": "EVendorPenyelengaraan_WS.asmx/LoadList_SubBidang",
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
                                categoryFilterBU: $('#categoryFilterBU').val()
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
                        { "data": "Kod" },
                        { "data": "Butiran" },
                        { "data": "KodBU" },
                        {
                            className: "btnEdit",
                            "data": "Kod",
                            render: function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }

                                var link = `<button id="btnEditSB" runat="server" class="btn btnEditSB" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteSB" runat="server" class="btn btnDeleteSB" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                                return link;
                            }
                        },

                    ]
                });
            });

            $('#tblListSubBidang').on('click', '.btnEditSB', async function (event) {
                $('#titleFormSubBidang').html("Kemaskini Sub Bidang");
                $('#SubBidangModal').modal("toggle");

                event.stopPropagation();
                var KodSB = $(this).data("id");

                if (KodSB != "") {
                    var DataSB = JSON.parse(await AjaxLoadDataSB(KodSB));

                    if (DataSB.length > 0) {
                        SetValueDataSB(DataSB);
                    } else {
                        console.log("Tiada respon Data Bidang Utama")
                    }
                }

                return false;
            });

            async function SetValueDataSB(DataSB) {

                var ddlKodBU = $('#ddlKodBU');
                var selectObj_KodBU = $('#ddlKodBU');
                $(ddlKodBU).dropdown('set selected', DataSB[0].Kod_Bdg_Utama);
                selectObj_KodBU.append("<option value = '" + DataSB[0].Kod_Bdg_Utama + "'>" + DataSB[0].ButiranBU + "</option>")

                $('#KodSB').val(DataSB[0].Kod);
                $('#ButiranSB').val(DataSB[0].Butiran);
            }

            async function clearValueDataSB() {
                $('#ddlKodBU').dropdown("clear");
                $('#KodSB').val("");
                $('#ButiranSB').val("");

            }

            $('#tblListSubBidang').on('click', '.btnDeleteSB', async function (event) {
                event.stopPropagation();

                var curTR = $(this).closest("tr");
                var bool = true;
                var KodSB = $(this).data("id");

                $('.btnYaDeleteSB').show();
                $('.btnYaEditSB').hide();
                $('.btnYaSB').hide();
                $('#confirmContentSB').html("Adakah Anda Pasti ingin Memadam data ini?")
                $('#confirmationModalSB').modal("toggle")
                //$('#confirmationModalSB').modal("toggle")
                //return false;

                $('.btnYaDeleteSB').click(async function () {
                    $('#confirmationModalSB').modal("toggle");

                    if (KodSB !== "") {
                        bool = await DelSB(KodSB);
                    }

                    if (bool === true) {
                        curTR.remove();
                    }

                    displayMaklumanModal("Maklumat Berjaya Dipadam");
                    tblSubBidang.ajax.reload();

                    return false;
                });
            })

            $('.btnSimpanSB').on('click', async function () {
                if ($('#KodSB').val() == "" || $('#ButiranSB').val() == "" || $('#ddlKodBU').val() == "") {
                    displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
                } else {
                    $('.btnYaDeleteSB').hide();
                    $('.btnYaEditSB').hide();
                    $('.btnYaSB').show();
                    $('#SubBidangModal').modal("toggle");
                    $('#confirmContentSB').html("Anda pasti ingin menyimpan rekod ini?")
                    $('#confirmationModalSB').modal("toggle");
                }
            });

            $('.btnYaSB').click(async function () {
                $('#confirmationModalSB').modal("toggle");
                //let KodBU = $(this).data("id");

                var SubBidang = {
                    SubBdg: {
                        KodBU: $('#ddlKodBU').val(),
                        KodSB: $('#KodSB').val(),
                        ButiranSB: $('#ButiranSB').val(),
                    }
                }

                console.log("RecordSB: ", SubBidang);
                var result = JSON.parse(await AjaxSaveSubBidang(SubBidang));

                console.log("ResultSB: ", result.Message)
                if (result.Code == 00) {
                    tblSubBidang.ajax.reload();
                    displayMaklumanModal(result.Message);
                } else {
                    displayMaklumanModal(result.Message);
                }
            });

            async function DelSB(KodSB) {
                var bool = false;
                var result = JSON.parse(await AjaxDelSubBidang(KodSB));

                if (result.Code === "00") {
                    bool = true;
                }
                return bool;
            }

            async function AjaxLoadDataSB(KodSB) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'EVendorPenyelengaraan_WS.asmx/LoadDataSB',
                        method: 'POST',
                        data: JSON.stringify({ KodSB: KodSB }),
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

            async function AjaxSaveSubBidang(SubBdg) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'EVendorPenyelengaraan_WS.asmx/SaveSubBidang',
                        method: 'POST',
                        data: JSON.stringify(SubBdg),
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

            async function AjaxDelSubBidang(KodSB) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'EVendorPenyelengaraan_WS.asmx/DeleteSB',
                        method: 'POST',
                        data: JSON.stringify({ KodSB: KodSB }),
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
        });

        //-------------------     Tab 3 (Bidang)        ------------------------
        $(document).ready(function () {
            $('.btnBidang').on('click', async function () {
                clearValueDataBdg();
                $('#titleFormBidang').html("Tambah Bidang");
                $('#BidangModal').modal('toggle');
            });

            $('#categoryFilterBdg').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'EVendorPenyelengaraan_WS.asmx/GetKodSubBidang?q={query}',
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
                        $('#categoryFilterBdg').data('apiResponse', listOptions);

                        // Update the options of the second dropdown on page load
                        //updateSecondDropdown($(this).dropdown('get value'), '#ddlKat');
                    },
                }
            });

            $('#ddlKodSB').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'EVendorPenyelengaraan_WS.asmx/GetKodSubBidang?q={query}',
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

                        //if (shouldPop === true) {
                        //    $(obj).dropdown('show');
                        //}
                    }
                }
            });

            var tblBidang = null;
            $(document).ready(function () {
                /* show_loader();*/

                let IsClicked = false;

                $('.btnSearchBdg').on('click', async function () {
                    IsClicked = true;
                    tblBidang.ajax.reload();
                });

                tblBidang = $("#tblListBidang").DataTable({
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
                        "url": "EVendorPenyelengaraan_WS.asmx/LoadList_Bidang",
                        "method": 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        },
                        "data": function () {
                            //Filter by Session Syarikat
                            return JSON.stringify({
                                IsClickedBdg: IsClicked,
                                categoryFilterBdg: $('#categoryFilterBdg').val()
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
                        { "data": "KodBidang" },
                        { "data": "Butiran" },
                        { "data": "KodSB" },
                        {
                            className: "btnEdit",
                            "data": "KodBidang",
                            render: function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }

                                var link = `<button id="btnEditBdg" runat="server" class="btn btnEditBdg" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteBdg" runat="server" class="btn btnDeleteBdg" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                                return link;
                            }
                        },

                    ]
                });
            });

            $('#tblListBidang').on('click', '.btnEditBdg', async function (event) {
                $('#titleFormBidang').html("Kemaskini Bidang");
                $('#BidangModal').modal("toggle");

                event.stopPropagation();
                var KodBdg = $(this).data("id");

                if (KodBdg != "") {
                    var DataBdg = JSON.parse(await AjaxLoadDataBdg(KodBdg));

                    if (DataBdg.length > 0) {
                        SetValueDataBdg(DataBdg);
                    } else {
                        console.log("Tiada respon Data Bidang Utama")
                    }
                }

                return false;
            });

            async function SetValueDataBdg(DataBdg) {
                //$('#ddlKodSB').val(DataBdg[0].KodSubBidang);

                var ddlKodSB = $('#ddlKodSB');
                var selectObj_KodSB = $('#ddlKodSB');
                $(ddlKodSB).dropdown('set selected', DataBdg[0].KodSubBidang);
                selectObj_KodSB.append("<option value = '" + DataBdg[0].KodSubBidang + "'>" + DataBdg[0].ButiranSB + "</option>")

                $('#KodBdg').val(DataBdg[0].KodBidang);
                $('#ButiranBdg').val(DataBdg[0].Butiran);
            }

            async function clearValueDataBdg() {
                $('#ddlKodSB').dropdown("clear");
                $('#KodBdg').val("");
                $('#ButiranBdg').val("");

            }

            $('#tblListBidang').on('click', '.btnDeleteBdg', async function (event) {
                event.stopPropagation();

                var curTR = $(this).closest("tr");
                var bool = true;
                var KodBdg = $(this).data("id");

                $('.btnYaDeleteBdg').show();
                $('.btnYaEditBdg').hide();
                $('.btnYaBdg').hide();
                $('#confirmContentBdg').html("Adakah Anda Pasti ingin Memadam data ini?")
                $('#confirmationModalBdg').modal("toggle")
                //$('#confirmationModalBdg').modal("toggle")
                //return false;

                $('.btnYaDeleteBdg').click(async function () {
                    $('#confirmationModalBdg').modal("toggle");

                    if (KodBdg !== "") {
                        bool = await DelBdg(KodBdg);
                    }

                    if (bool === true) {
                        curTR.remove();
                    }

                    displayMaklumanModal("Maklumat Berjaya Dipadam");
                    tblSubBidang.ajax.reload();

                    return false;
                });
            })

            async function DelBdg(KodBdg) {
                var bool = false;
                var result = JSON.parse(await AjaxDelBidang(KodBdg));

                if (result.Code === "00") {
                    bool = true;
                }
                return bool;
            }

            $('.btnSimpanBdg').on('click', async function () {
                if ($('#ddlKodSB').val() == "" || $('#ButiranBdg').val() == "" || $('#KodBdg').val() == "") {
                    displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
                } else {
                    $('#BidangModal').modal("toggle");
                    $('#confirmationModalBdg').modal("toggle");
                }
            });

            $('.btnYaBdg').click(async function () {
                $('#confirmationModalBdg').modal("toggle");
                //let KodBU = $(this).data("id");

                var newBidang = {
                    bidang: {
                        KodBdg: $('#KodBdg').val(),
                        KodSB: $('#ddlKodSB').val(),
                        ButiranBdg: $('#ButiranBdg').val(),
                    }
                }

                console.log("RecordSB: ", newBidang);
                var result = JSON.parse(await AjaxSaveBidang(newBidang));

                console.log("ResultSB: ", result.Message)
                if (result.Code == 00) {
                    tblBidang.ajax.reload();
                    displayMaklumanModal(result.Message);
                } else {
                    displayMaklumanModal(result.Message);
                }
            });

            async function AjaxLoadDataBdg(KodBdg) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'EVendorPenyelengaraan_WS.asmx/LoadDataBdg',
                        method: 'POST',
                        data: JSON.stringify({ KodBdg: KodBdg }),
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

            async function AjaxSaveBidang(bidang) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'EVendorPenyelengaraan_WS.asmx/SaveBidang',
                        method: 'POST',
                        data: JSON.stringify(bidang),
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

            async function AjaxDelBidang(KodBdg) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'EVendorPenyelengaraan_WS.asmx/DeleteBdg',
                        method: 'POST',
                        data: JSON.stringify({ KodBdg: KodBdg }),
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

        });


        async function displayMaklumanModal(message) {
            $('#detailMakluman').html(message);
            $('#maklumanModalBU').modal('toggle');
        }

        async function displayPengesahanModal(msg) {
            $('#confirmContentBU').html(msg);
        }


    </script>
</asp:Content>
