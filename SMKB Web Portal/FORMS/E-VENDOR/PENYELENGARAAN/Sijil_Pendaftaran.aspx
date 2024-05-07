<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Sijil_Pendaftaran.aspx.vb" Inherits="SMKB_Web_Portal.Sijil_Pendaftaran1" %>

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
        <div class="tab-content">
            <div class="col-md-12 mt-3 mb-3">
                <div class="row">
                    <div class="col-md-6" style="display: flex; justify-content: flex-start; align-items: flex-start;">
                        <div class="form-group" style="align-self: flex-start;">
                            <h6 class="modal-title" id="titleSijilDaftar" style="visibility: hidden;">Senarai Sijil Pendaftaran
                            </h6>
                        </div>
                    </div>
                    <div class="col-md-6" style="display: flex; justify-content: flex-end; align-items: flex-end;">
                        <div class="form-group" style="align-self: flex-end;">
                            <div class="btn btn-primary btnSijilDaftar">
                                <i class="fa fa-plus"></i>Sijil Pendaftaran 
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <hr />

            <div class="col-md-12">
                <div class="transaction-table table-responsive">
                    <table id="tblListSijil" class="table table-striped" style="width: 100%">
                        <thead>
                            <tr data-id="">
                                <th scope="col">Bil</th>
                                <th scope="col">Kod</th>
                                <th scope="col">Butiran</th>
                                <th scope="col">Tindakan</th>
                            </tr>
                        </thead>
                        <tbody id="tblRowSijil">
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="modal fade" id="SijilModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="titleFormSijil">Tambah Sijil Pendaftaran</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="KodSijil" name="KodSijil" />
                                    <label class="input-group__label">Kod</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <textarea class="input-group__input form-control input-sm" placeholder="" id="ButiranSijil" name="ButiranSijil"></textarea>
                                    <label class="input-group__label">Butiran</label>
                                </div>
                            </div>
                            <%--<div class="col-md-12">
                                    <div class="form-group input-group">
                                        <input type="text" class="input-group__input form-control input-sm" placeholder="" id="ButiranGred" name="ButiranGred" />
                                        <label class="input-group__label">Butiran</label>
                                    </div>
                                </div>--%>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            <button type="button" runat="server" id="Button1" class="btn btn-secondary btnSimpanSijil">Simpan</button>
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


        ////////////////////////////////////////////////////////////////////////////////////////////////////////////

        $('.btnSijilDaftar').on('click', async function () {
            clearValueDataSijil();
            $('#titleFormSijil').html("Tambah Sijil Pendaftaran");
            $('#KodSijil').prop('disabled', false);
            $('#SijilModal').modal("toggle");
        })

        async function clearValueDataSijil() {
            $('#KodSijil').val("");
            $('#ButiranSijil').val("");
        }

        var tblListSijil;
        /* show_loader();*/
        tblListSijil = $("#tblListSijil").DataTable({
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
                "url": "SelengaraSijil_WS.asmx/LoadList_SijilDaftar",
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
                { "data": "Kod" },
                { "data": "Butiran" },
                {
                    className: "btnEdit",
                    "data": "Kod",
                    render: function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }

                        var link = `<button id="btnEditSijil" runat="server" class="btn btnEditSijil" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteSijil" runat="server" class="btn btnDeleteSijil" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                        return link;
                    }
                },

            ]
        });

        $('#tblListSijil').on('click', '.btnEditSijil', async function (event) {
            debugger;
            $('#titleFormSijil').html("Kemaskini Sijil Pendaftaran");
            $('#KodSijil').prop('disabled', true);
            $('#SijilModal').modal("toggle");

            event.stopPropagation();
            var KodSijil = $(this).data("id");
            if (KodSijil != "") {
                var DataSijil = JSON.parse(await AjaxLoadDataSijil(KodSijil));
                console.log("Data SIJIL: ", DataSijil);

                if (DataSijil.length > 0) {
                    $('#SijilModal').attr('data-mode', 'edit');
                    SetValueToForm_Sijil(DataSijil);
                } else {
                    console.log("Tiada respon Data Sijil");
                    DisplayMaklumanModal("Maaf, Kod Sijil Tidak Sah");
                }
            }
        });

        $('#tblListSijil').on('click', '.btnDeleteSijil', async function (event) {
            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var KodSijil = $(this).data("id");

            DisplayPengesahanModal("Adakah Anda Pasti ingin Memadam data ini?", "delete", KodSijil, curTR);
        });

        $('.btnSimpanSijil').click(async function () {
            debugger;
            if ($('#KodSijil').val() == "" || $('#ButiranSijil').val() == "") {
                DisplayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
            } else {
                //$('#GredKerjaModal').modal("toggle");
                var mode = $('#SijilModal').attr('data-mode');

                if (mode === 'edit') {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Mengemaskini rekod ini?", "edit", null, null)
                } else {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Menghantar rekod ini?", "save", null, null)
                }
            }
        });

        async function DeleteSijil(KodGred) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteSijil(KodGred));

            if (result.Code === "00") {
                bool = true;
            }

            return bool;
        }

        async function SetValueToForm_Sijil(DataSijil) {

            $('#KodSijil').val(DataSijil[0].Kod);
            $('#ButiranSijil').val(DataSijil[0].Butiran);

        }

        async function AjaxDeleteSijil(KodSijil) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraSijil_WS.asmx/DeleteSijil',
                    method: 'POST',
                    data: JSON.stringify({ KodSijil: KodSijil }),
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

        async function AjaxLoadDataSijil(KodSijil) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraSijil_WS.asmx/LoadData_Sijil',
                    method: 'POST',
                    data: JSON.stringify({ KodSijil: KodSijil }),
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

        async function AjaxSaveSijilDaftar(SijilDaftar) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraSijil_WS.asmx/SaveSijilDaftar',
                    method: 'POST',
                    data: JSON.stringify(SijilDaftar),
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

        async function AjaxEditSijil(SijilDaftar) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraSijil_WS.asmx/EditSijilDaftar',
                    method: 'POST',
                    data: JSON.stringify(SijilDaftar),
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


        ////////////////////////////////////////////////////    GLOBAL     ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        async function DisplayMaklumanModal(msg) {
            $('#detailMakluman').html(msg);
            $('#maklumanModal').modal("toggle");
        }

        async function DisplayPengesahanModal(msg, action, id, curTR) {
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
                $('#confirmationModal').modal("toggle")

            } else {
                $('#confirmContent').html("Maaf");
                $('#confirmationModal').modal("toggle");
            }
        }

        var Hantar = false;
        var Edit = false;
        var Delete = false;
        var action = "";

        $(".btnYa").on('click', async function () {
            $("#confirmationModal").modal("toggle");
            debugger;
            var action = $(this).data("action");
            var Kod = $(this).data("id");
            var curTR = $(this).data("curTR")
            var bool = false;

            //Handle different actions
            switch (action) {
                case "delete":

                    if (Kod !== "") {
                        bool = await DeleteSijil(Kod);
                    }

                    if (bool === true) {
                        curTR.remove();
                    }

                    DisplayMaklumanModal("Maklumat Berjaya Dipadam");
                    tblListSijil.ajax.reload();

                    return false;

                    break;
                case "save":

                    var newSijilDaftar = {
                        SijilDaftar: {
                            KodSijil: $('#KodSijil').val(),
                            ButiranSijil: $('#ButiranSijil').val()
                        }
                    }

                    var result = JSON.parse(await AjaxSaveSijilDaftar(newSijilDaftar));
                    if (result.Code == 00) {

                        $('#SijilModal').modal("toggle");
                        DisplayMaklumanModal(result.Message);
                        tblListSijil.ajax.reload();

                    } else {
                        DisplayMaklumanModal(result.Message);
                    }

                    break;
                case "edit":

                    var newSijilDaftar = {
                        SijilDaftar: {
                            KodSijil: $('#KodSijil').val(),
                            ButiranSijil: $('#ButiranSijil').val()
                        }
                    }

                    var result = JSON.parse(await AjaxEditSijil(newSijilDaftar));
                    if (result.Code == 00) {

                        $('#SijilModal').modal("toggle");
                        DisplayMaklumanModal(result.Message);
                        tblListSijil.ajax.reload();

                    } else {
                        DisplayMaklumanModal(result.Message);
                    }

                    break;
            }
        });



    </script>

</asp:Content>
