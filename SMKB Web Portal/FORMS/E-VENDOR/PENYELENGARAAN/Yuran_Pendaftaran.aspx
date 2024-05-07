<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Yuran_Pendaftaran.aspx.vb" Inherits="SMKB_Web_Portal.Yuran_Pendaftaran" %>

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
                            <h6 class="modal-title" id="titleYuran" style="visibility: hidden;">Senarai Yuran Pendaftaran
                            </h6>
                        </div>
                    </div>
                    <div class="col-md-6" style="display: flex; justify-content: flex-end; align-items: flex-end;">
                        <div class="form-group" style="align-self: flex-end;">
                            <div class="btn btn-primary btnYuranDaftar">
                                <i class="fa fa-plus"></i>Yuran Pendaftaran 
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- tblListYuran -->
            <hr />

            <div class="col-md-12">
                <div class="transaction-table table-responsive">
                    <table id="tblListYuran" class="table table-striped" style="width: 100%">
                        <thead>
                            <tr data-id="">
                                <th scope="col">Bil</th>
                                <th scope="col">Kod</th>
                                <th scope="col">Butiran</th>
                                <th scope="col">Amaun</th>
                                <th scope="col">Status</th>
                                <th scope="col">Tindakan</th>
                            </tr>
                        </thead>
                        <tbody id="tblRowYuranDaftar">
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Modal Form Tambah/Kemaskini Yuran Pendaftaran -->
            <div class="modal fade" id="YuranModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="titleFormYuran">Tambah Yuran Pendaftaran</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="KodYuran" name="KodYuran" />
                                    <label class="input-group__label">Kod</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <textarea class="input-group__input form-control input-sm" placeholder="" id="ButiranYuran" name="ButiranYuran"></textarea>
                                    <label class="input-group__label">Butiran</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <input type="text" class="input-group__input form-control input-sm"  placeholder="" id="AmaunYuran" name="AmaunYuran" />
                                    <label class="input-group__label">Amaun</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group input-group">
                                    <label class="mr-2">Status Yuran:</label>
                                    <div>
                                        <label class="mr-2">
                                            <input type="radio" name="StatYuran" id="StatYuranAktif" value="1" checked>
                                            Aktif
                                        </label>
                                        <label>
                                            <input type="radio" name="StatYuran" id="StatYuranTidakAktif" value="0">
                                            Tidak Aktif
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            <button type="button" runat="server" id="Button1" class="btn btn-secondary btnSimpanYuran">Simpan</button>
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

        $('.btnYuranDaftar').on('click', async function () {
            clearValueDataYuran();
            $('#titleFormYuran').html("Tambah Yuran Pendaftaran");
            //$('#KodYuran').prop('disabled', false);
            //$('#AmaunYuran').val("0.00");
            //$('#StatYuranAktif').prop('checked', true)
            $('#YuranModal').modal("toggle");
        })

        $('#AmaunYuran').change(function () {
            // Remove non-numeric characters and leading zeros
            let sanitizedValue = $(this).val().replace(/[^0-9.]/g, '').replace(/^0+/, '');

            // Format the number with commas and set to Malaysian currency
            if (sanitizedValue !== "") {
                sanitizedValue = parseFloat(sanitizedValue).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
            } else {
                sanitizedValue = "0.00";
            }

            // Update the input value
            $(this).val(sanitizedValue);
        });

        $('#AmaunYuran').on('keypress', function (event) {
            const inputChar = String.fromCharCode(event.which);
            const isDigit = /[0-9]/.test(inputChar);
            const isDecimalSeparator = inputChar === "." && $(this).val().indexOf('.') === -1;

            if (!(isDigit || isDecimalSeparator)) {
                event.preventDefault();
            }
        });

        async function clearValueDataYuran() {
            $('#KodYuran').val("");
            $('#KodYuran').prop('disabled', false);
            $('#ButiranYuran').val("");
            $('#AmaunYuran').val("0.00");
            $('#StatYuranAktif').prop('checked', true)
        }

        var tblListYuran;
        /* show_loader();*/
        tblListYuran = $("#tblListYuran").DataTable({
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
                "url": "SelengaraYuran_WS.asmx/LoadList_YuranDaftar",
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
                    "data": "Amaun",
                    "render": function (data, type, row) {
                        // Assuming data is a numeric value representing the total tunggak
                        return parseFloat(data).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                    }
                },
                {
                    "data": "Status",
                    render: function (data, type, row, meta) {
                        if (data === "0") {
                            return "TIDAK AKTIF";
                        } else if (data === "1") {
                            return "AKTIF"
                        } else {
                            return "Data Tidak Sah"
                        }
                    }
                },
                {
                    className: "btnEdit",
                    "data": "Kod",
                    render: function (data, type, row, meta) {
                        if (type !== "display") {
                            return data;
                        }

                        var link = `<button id="btnEditYuran" runat="server" class="btn btnEditYuran" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                       <!-- <button id="btnDeleteYuran" runat="server" class="btn btnDeleteYuran" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button> -->`;

                        return link;
                    }
                },

            ]
        });

        $('#tblListYuran').on('click', '.btnEditYuran', async function (event) {
            debugger;
            $('#titleFormYuran').html("Kemaskini Yuran Pendaftaran");
            $('#KodYuran').prop('disabled', true);
            $('#YuranModal').modal("toggle");

            event.stopPropagation();
            var KodYuran = $(this).data("id");
            if (KodYuran != "") {
                var DataYuran = JSON.parse(await AjaxLoadDataYuran(KodYuran));
                console.log("Data Yuran: ", DataYuran);

                if (DataYuran.length > 0) {
                    $('#YuranModal').attr('data-mode', 'edit');
                    SetValueToForm_Yuran(DataYuran);
                } else {
                    console.log("Tiada respon Data Sijil");
                    DisplayMaklumanModal("Maaf, Kod Sijil Tidak Sah");
                }
            }
        });

        $('#tblListYuran').on('click', '.btnDeleteYuran', async function (event) {
            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var KodYuran = $(this).data("id");

            DisplayPengesahanModal("Adakah Anda Pasti ingin Memadam data ini?", "delete", KodYuran, curTR);
        });

        $('.btnSimpanYuran').click(async function () {
            debugger;
            if ($('#KodYuran').val() == "" || $('#ButiranYuran').val() == "" || $('#AmaunYuran').val() == "" || $("input[name='StatYuran']:checked").val() == "") {
                DisplayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
            } else {
                //$('#GredKerjaModal').modal("toggle");
                var mode = $('#YuranModal').attr('data-mode');

                if (mode === 'edit') {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Mengemaskini rekod ini?", "edit", null, null)
                } else {
                    DisplayPengesahanModal("Adakah Anda Pasti Ingin Menghantar rekod ini?", "save", null, null)
                }
            }
        });

        async function DeleteYuran(KodYuran) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteYuran(KodYuran));

            if (result.Code === "00") {
                bool = true;
            }

            return bool;
        }

        async function SetValueToForm_Yuran(DataYuran) {

            console.log(DataYuran[0].Kod);

            $('#KodYuran').val(DataYuran[0].Kod);
            $('#ButiranYuran').val(DataYuran[0].Butiran);
            $('#AmaunYuran').val(DataYuran[0].Amaun);

            if (DataYuran[0].Status == "1") {
                $('#StatYuranAktif').prop('checked', true);
                $('#StatYuranTidakAktif').prop('checked', false);
            } else {
                $('#StatYuranTidakAktif').prop('checked', true);
                $('#StatYuranAktif').prop('checked', false);
            }

        }

        async function AjaxDeleteYuran(KodYuran) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraSijil_WS.asmx/DeleteYuran',
                    method: 'POST',
                    data: JSON.stringify({ KodYuran: KodYuran }),
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

        async function AjaxLoadDataYuran(KodYuran) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraYuran_WS.asmx/LoadData_Yuran',
                    method: 'POST',
                    data: JSON.stringify({ KodYuran: KodYuran }),
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

        async function AjaxSaveYuran(YuranDaftar) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraYuran_WS.asmx/SaveYuranDaftar',
                    method: 'POST',
                    data: JSON.stringify(YuranDaftar),
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

        async function AjaxEditYuran(YuranDaftar) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SelengaraYuran_WS.asmx/EditYuranDaftar',
                    method: 'POST',
                    data: JSON.stringify(YuranDaftar),
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

        ///////////////////////////////////////////////      GLOBAL        //////////////////////////////////////////////////////////////////////////////

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
                        bool = await DeleteYuran(Kod);
                    }

                    if (bool === true) {
                        curTR.remove();
                    }

                    DisplayMaklumanModal("Maklumat Berjaya Dipadam");
                    tblListYuran.ajax.reload();

                    return false;

                    break;
                case "save":

                    var amaunYuranString = $('#AmaunYuran').val(); // Assuming this is something like "RM 100.00"

                    // Extract numeric part and convert to a number
                    var amaunYuranNumeric = parseFloat(amaunYuranString.replace(/[^\d.-]/g, ''));

                    var newYuranDaftar = {
                        YuranDaftar: {
                            KodYuran: $('#KodYuran').val(),
                            ButiranYuran: $('#ButiranYuran').val(),
                            AmaunYuran: amaunYuranNumeric,
                            StatYuran: $("input[name='StatYuran']:checked").val()
                        }
                    }

                    var result = JSON.parse(await AjaxSaveYuran(newYuranDaftar));
                    if (result.Code == 00) {

                        $('#YuranModal').modal("toggle");
                        DisplayMaklumanModal(result.Message);
                        tblListYuran.ajax.reload();

                    } else {
                        DisplayMaklumanModal(result.Message);
                    }

                    break;
                case "edit":

                    var amaunYuranString = $('#AmaunYuran').val(); // Assuming this is something like "RM 100.00"

                    // Extract numeric part and convert to a number
                    var amaunYuranNumeric = parseFloat(amaunYuranString.replace(/[^\d.-]/g, ''));

                    var newYuranDaftar = {
                        YuranDaftar: {
                            KodYuran: $('#KodYuran').val(),
                            ButiranYuran: $('#ButiranYuran').val(),
                            AmaunYuran: amaunYuranNumeric,
                            StatYuran: $("input[name='StatYuran']:checked").val()
                        }
                    }

                    var result = JSON.parse(await AjaxEditYuran(newYuranDaftar));
                    if (result.Code == 00) {

                        $('#YuranModal').modal("toggle");
                        DisplayMaklumanModal(result.Message);
                        tblListYuran.ajax.reload();

                    } else {
                        DisplayMaklumanModal(result.Message);
                    }

                    break;
            }
        });

    </script>

</asp:Content>
