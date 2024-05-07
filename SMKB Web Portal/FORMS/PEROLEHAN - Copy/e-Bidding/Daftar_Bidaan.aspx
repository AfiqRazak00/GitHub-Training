<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Daftar_Bidaan.aspx.vb" Inherits="SMKB_Web_Portal.Daftar_Bidaan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    <style>
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
            background-color: #ffc83d !important;
        }

        #tblSenaraiBidaan td:hover {
            cursor: pointer;
        }
    </style>


    <div class="tabcontent" style="display: block">

        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Daftar Bidaan</h5>
                    </div>

                    <div class="card" style="margin: 20px">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="No Bidaan" id="txtIdBidaan" type="text" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="No Bidaan">Id Bidaan</label>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="Tarikh Mula" id="txtTarikhMula" type="date" />
                                            <label class="input-group__label" for="Tarikh Mula">Tarikh Mula</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="Masa Mula" id="txtMasaMula" type="time" />
                                            <label class="input-group__label" for="Masa Mula">Masa Mula</label>
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="Tarikh Tamat" id="txtTarikhTamat" type="date" />
                                            <label class="input-group__label" for="Tarikh Tamat">Tarikh Tamat</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="Masa Tamat" id="txtMasaTamat" type="time" />
                                            <label class="input-group__label" for="Masa Tamat">Masa Tamat</label>
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-8">
                                            <select class="input-group__select ui search dropdown" name="Sebut Harga" id="ddlsebutHarga" placeholder="&nbsp;">
                                            </select>
                                            <label class="input-group__label" for="Sebut Harga">Sebut Harga</label>
                                        </div>


                                        <input class="" id="idJualan" placeholder="&nbsp;" name="Id Jualan" type="hidden" />
                                        <input class="" id="noMohon" placeholder="&nbsp;" name="No Mohon" type="hidden" />

                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input form-control " id="txtHargaMula" type="text" placeholder="&nbsp;" name="Harga Mula Bidaan" />
                                            <label class="input-group__label" for="Harga Mula Bidaan">Harga Bidaan Maksima (RM)</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input form-control " id="kenaikanBidaanMinima" type="text" placeholder="&nbsp;" name="Kenaikan Bidaan Minima (RM)" />
                                            <label class="input-group__label" for="Kenaikan Bidaan Minima (RM)">Penurunan Bidaan Minima (RM)</label>
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div class="transaction-table table-responsive">
                                <table id="tblSenaraiPembida" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Kod</th>
                                            <th scope="col">Ranking Harga</th>
                                            <th scope="col">Peratus Teknikal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>

                            <div class="form-row" style="margin-top: 50px">
                                <div class="form-group col-md-12" align="center">
                                    <button type="button" id="btnDaftar" class="btn btn-secondary btnDaftar" data-toggle="tooltip" data-placement="bottom" title="Simpan" style="width: 160px">
                                        Daftar
                                    </button>
                                    <%--                                    <button type="button" id="btnDaftarHantar" class="btn btn-success btnDaftarHantar" data-toggle="tooltip" data-placement="bottom" title="Daftar Dan Hantar" style="width:160px">
                                        Daftar Dan Hantar
                                    </button>
                                    --%>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="card" style="margin: 20px">
                        <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai eBidding</h6>
                        <div class="card-body">

                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblSenaraiBidaan" class="table table-striped" style="width: 99%">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bil</th>
                                                <th scope="col">ID Bidaan</th>
                                                <th scope="col">No Sebut Harga / Tender</th>
                                                <th scope="col">Sebut Harga / Tender</th>
                                                <th scope="col">Tarikh Mula</th>
                                                <th scope="col">Tarikh Tamat</th>
                                            </tr>
                                        </thead>
                                        <tbody>
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


    <!-- Modal -->
    <div class="modal fade" id="transaksi" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header modal-header--sticky">
                    <h5 class="modal-title">Senarai Permohonan Perolehan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>


                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <input class="input-group__input" name="No Bidaan" id="txtIdBidaanT" type="text" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="No Bidaan">Id Bidaan</label>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">

                                <div class="form-group col-md-4">
                                    <input class="input-group__input" name="Tarikh Mula" id="txtTarikhMulaT" type="date" />
                                    <label class="input-group__label" for="Tarikh Mula">Tarikh Mula</label>
                                </div>

                                <div class="form-group col-md-4">
                                    <input class="input-group__input" name="Masa Mula" id="txtMasaMulaT" type="time" />
                                    <label class="input-group__label" for="Masa Mula">Masa Mula</label>
                                </div>

                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">

                                <div class="form-group col-md-4">
                                    <input class="input-group__input" name="Tarikh Tamat" id="txtTarikhTamatT" type="date" />
                                    <label class="input-group__label" for="Tarikh Tamat">Tarikh Tamat</label>
                                </div>

                                <div class="form-group col-md-4">
                                    <input class="input-group__input" name="Masa Tamat" id="txtMasaTamatT" type="time" />
                                    <label class="input-group__label" for="Masa Tamat">Masa Tamat</label>
                                </div>

                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">

                                <div class="form-group col-md-8">
                                    <input class="input-group__input" name="Sebut Harga" id="ddlsebutHargaT" type="text" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="Sebut Harga">Sebut Harga</label>
                                </div>

                                <%--                                     <div class="form-group col-md-8">
                                           <select class="input-group__select ui search dropdown" name="Sebut Harga" id="ddlsebutHargaT" placeholder="&nbsp;">
                                           </select>
                                           <label class="input-group__label" for="Sebut Harga">Sebut Harga</label>
                                       </div>--%>


                                <input class="" id="idJualanT" placeholder="&nbsp;" name="Id Jualan" type="hidden" />
                                <input class="" id="noMohonT" placeholder="&nbsp;" name="No Mohon" type="hidden" />

                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">

                                <div class="form-group col-md-4">
                                    <input class="input-group__input form-control " id="txtHargaMulaT" type="text" placeholder="&nbsp;" name="Harga Mula Bidaan" />
                                    <label class="input-group__label" for="Harga Mula Bidaan">Harga Bidaan Maksima (RM)</label>
                                </div>

                                <div class="form-group col-md-4">
                                    <input class="input-group__input form-control " id="kenaikanBidaanMinimaT" type="text" placeholder="&nbsp;" name="Kenaikan Bidaan Minima (RM)" />
                                    <label class="input-group__label" for="Kenaikan Bidaan Minima (RM)">Penurunan Bidaan Minima (RM)</label>
                                </div>

                            </div>
                        </div>
                    </div>

                    <%--                        <div class="transaction-table table-responsive">
                            <table id="tblSenaraiPembidaT" class="table table-striped" style="width: 99%">
                                <thead>
                                    <tr>
                                        <th scope="col">Kod</th>
                                        <th scope="col">Ranking Harga</th>
                                        <th scope="col">Peratus Teknikal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>


                        </div>--%>
                </div>

                <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">
                    <button type="button" class="btn btn-setsemula" data-toggle="tooltip" data-placement="bottom">Tutup</button>
                    <button type="button" class="btn btn-secondary btnUpdate" data-toggle="tooltip" data-placement="bottom">Simpan</button>
                </div>

            </div>
        </div>
    </div>


    <%--  modal lulus permohonan--%>
    <div class="modal fade" id="saveConfirmationModal10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabel10">Daftar Bidaan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessage10"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="simpanBidaan">Ya</button>
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
                    <div id="resultModalMessage10">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>



    <!-- Modal Pengesahan-->
    <div class="modal fade" id="saveConfirmationModal11" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabel11">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessage11"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="updateBidaan">Ya</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="resultModal11" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabel1">Makluman</h5>
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

    <table id="tblSenaraiPembelian" style="display: none">
        <thead>
            <tr>
                <th scope="col">Id Pembelian</th>
                <th scope="col">Id Jualan</th>
                <th scope="col">Nama Syarikat</th>
                <th scope="col">Email Syarikat</th>
                <th scope="col">ID Syarikat</th>
                
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

    <script type="text/javascript">

        loadbalik();

        var tblPembelian = null;

        $(document).ready(async function () {
            tblPembelian = $("#tblSenaraiPembelian").DataTable({
                "responsive": true,
                "searching": false,
                "info": false,
                "paging": false,
                "ordering": false,
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/LoadPerolehan_Pembelian_Hdr") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ Id_Jualan: noSebutHargaDATA });
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "columns": [
                    {
                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }
                            return `<input class = txt_Id_Pembelian' type="hidden" value ='${data.Id_Pembelian}'/>${data.Id_Pembelian}`;
                        },
                    },
                    {

                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }
                            return `<input class = 'txt_Id_Jualan' type="hidden" value ='${data.Id_Jualan}'/>${data.Id_Jualan}`;
                        },
                    },
                    {

                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }
                            return `<input class = 'txt_Nama_Sykt' type="hidden" value ='${data.Nama_Sykt}'/>${data.Nama_Sykt}`;
                        }
                    },

                    {
                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }
                            return `<input class = 'txt_Emel_Semasa' type="hidden" value ='${data.Emel_Semasa}'/>${data.Emel_Semasa}`;
                        },
                    },

                    {
                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }
                            return `<input class = 'txt_ID_Syarikat' type="hidden" value ='${data.ID_Syarikat}'/>${data.ID_Syarikat}`;
                        },
                    },

                ],

            });
        });

        var tbl = null;

        $(document).ready(function () {
            tbl = $("#tblSenaraiBidaan").DataTable({
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/Load_SenaraiBidaan1") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify();
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
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
                        no_bidaan = data.Id_Bidaan;

                        $("#txtIdBidaanT").val(data.Id_Bidaan);
                        const dateTime = new Date(data.Tarikh_Mula);
                        const datePart = dateTime.toISOString().slice(0, 10);
                        const timePart = dateTime.toTimeString().slice(0, 5);

                        const dateTime1 = new Date(data.Tarikh_Tamat);
                        const datePart1 = dateTime1.toISOString().slice(0, 10);
                        const timePart1 = dateTime1.toTimeString().slice(0, 5);

                        $("#txtTarikhMulaT").val(datePart);
                        $("#txtMasaMulaT").val(timePart);

                        $("#txtTarikhTamatT").val(datePart1);
                        $("#txtMasaTamatT").val(timePart1);

                        $("#ddlsebutHargaT").val(data.Details2);
                        $("#txtHargaMulaT").val(data.Harga_Mula_Bidaan);
                        $("#kenaikanBidaanMinimaT").val(data.KenaikanBidaanMin);

                        $('#transaksi').modal('show');
                    });
                },


                "columns": [
                    { "data": null },
                    { "data": "Id_Bidaan" },
                    { "data": "No_Sebut_Harga" },
                    { "data": "Tujuan" },
                    {
                        "data": "Tarikh_Mula",
                        "type": "date",
                        "render": function (data, type, row) {
                            {
                                return moment(data).format('DD/MM/YYYY hh:mm A');
                            }
                            return data;
                        },
                    },

                    {
                        "data": "Tarikh_Tamat",
                        "type": "date",
                        "render": function (data, type, row) {
                            {
                                return moment(data).format('DD/MM/YYYY hh:mm A');
                            }
                            return data;
                        },
                    },

                ],
                "columnDefs": [
                    {
                        "targets": 0,
                        visible: true,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                ]
            });
        });

        var NameSubMenu = "E-Bidding"
        var KodSubMenu = "023301"

        //buttton daftar bidaan
        $('.btnDaftar').off('click').on('click', async function () {

            var msg = "Anda pasti untuk mendaftar maklumat ini?";
            $('#confirmationMessage10').text(msg);
            $('#transaksi').modal('hide');
            $('#saveConfirmationModal10').modal('show');

            $('#simpanBidaan').off('click').on('click', async function () {
                $('#saveConfirmationModal10').modal('hide');

                var newBidaanDaftar = {
                    SaveBidaan: {
                        txtIdBidaan: $('#txtIdBidaan').val(),
                        txtTarikhMula: $('#txtTarikhMula').val(),
                        txtMasaMula: $('#txtMasaMula').val(),
                        txtTarikhTamat: $('#txtTarikhTamat').val(),
                        txtMasaTamat: $('#txtMasaTamat').val(),
                        noSebutHarga5: noSebutHargaDATA,
                        Id_Jualan: $('#idJualan').val(),
                        No_Mohon: $('#noMohon').val(),
                        txtHargaMula: $('#txtHargaMula').val(),
                        kenaikanBidaanMinima: $('#kenaikanBidaanMinima').val()

                    }
                }


                try {
                    var result = JSON.parse(await ajaxSimpanDaftarBidaan(newBidaanDaftar));
                    if (result.Status === true) {
                        showModal10("Success", result.Message, "success");
                        clearInput()
                        tbl.ajax.reload();
                        loadbalik();

                    } else {
                        showModal10("Error", result.Message, "error");
                    }
                }
                catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }

                $('#tblSenaraiPembelian tbody tr').each(async function (ind, obj) {
                    var row = $(this);

                    var newPembelian_Hdr = {
                        Pembelian_Hdr: {
                            ddlIdPembelian: row.find('.txt_Id_Pembelian').val(),
                            ddlIdJualan: row.find('.txt_Id_Jualan').val(),
                            dllNamaSykt: row.find('.txt_Nama_Sykt').val(),
                            ddlEmelSemasa: row.find('.txt_Emel_Semasa').val(),
                            ddLIDSyarikat: row.find('.txt_ID_Syarikat').val(),
                            dllNameSubMenu: NameSubMenu,
                            dllKodSubMenu: KodSubMenu,
                        }
                    };

                    console.log("test =", newPembelian_Hdr);

                    try {
                        var result = await SendEmailVendo(newPembelian_Hdr);
                        if (result.Status === true) {
                            showModal10("Success", result.Message, "success");
                        } else {
                            showModal10("Error", result.Message, "error");
                        }
                    } catch (error) {
                        console.error('Error:', error);
                        showModal10("Error", "An error occurred while sending email.", "error");
                    }
                });

            });
        });


        async function SendEmailVendo(Pembelian_Hdr) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/EmelStaf_Vendo") %>',
                    method: 'POST',
                    data: JSON.stringify(Pembelian_Hdr),
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

        async function ajaxSimpanDaftarBidaan(SaveBidaan) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/SimpanDaftarBidaan") %>',
                    method: 'POST',
                    data: JSON.stringify(SaveBidaan),
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

        function showModal10(title, message, type) {
            $('#resultModalTitle10').text(title);
            $('#resultModalMessage10').html(message);
            if (type === "success") {
                $('#resultModal10').removeClass("modal-error").addClass("modal-success");
            } else if (type === "error") {
                $('#resultModal10').removeClass("modal-success").addClass("modal-error");
            }
            $('#resultModal10').modal('show');
        }



        var noSebutHargaDATA = "";

        function loadbalik() {

            $('#ddlsebutHarga').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/Load_SenaraiSebutHarga?q={query}") %>',
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

                                noSebutHargaDATA = kodValue;
                                showDetail();
                                tbl3.ajax.reload();
                                tblPembelian.ajax.reload();
                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');

                    }
                }
            });


        }



        function showDetail() {
            $.ajax({
                type: 'POST',
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/showMaklumat") %>',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: JSON.stringify({ noSebutHarga: noSebutHargaDATA }),
                success: function (result) {

                    result = JSON.parse(result.d)
                    $('#idJualan').val(result[0].Id_Jualan);
                    $('#noMohon').val(result[0].No_Mohon);


                },
                error: function (error) {
                    console.error('AJAX error:', error);
                }
            });
        }


        function clearInput() {

            $('#txtIdBidaan').val("");
            $('#txtTarikhMula').val("");
            $('#txtMasaMula').val("");
            $('#txtTarikhTamat').val("");
            $('#txtMasaTamat').val("");
            $('#ddlsebutHarga').dropdown('clear');
            $('#idJualan').val("");
            $('#noMohon').val("");
            $('#txtHargaMula').val("");
            $('#kenaikanBidaanMinima').val("");
        }


        var tbl3 = null;
        tbl3 = $("#tblSenaraiPembida").DataTable({
            "responsive": true,
            "searching": false,
            "info": false,
            "paging": false,
            "ordering": false,
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
                "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/Load_SenaraiBidaan") %>',
                type: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: function (d) {
                    return JSON.stringify({ id: noSebutHargaDATA });
                },
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                }
            },
            "rowCallback": function (row, data) {
                // Add hover effect
                $(row).hover(function () {
                    $(this).addClass("hover pe-auto bg-warning");
                }, function () {
                    $(this).removeClass("hover pe-auto bg-warning");
                });
            },
            "columns": [
                { "data": "kod_pembuka" },
                { "data": "rank" },
                { "data": "peratus_teknikal" }
            ],

        });



        //buttton daftar bidaan
        $('.btnUpdate').off('click').on('click', async function () {

            var msg = "Anda pasti untuk mengemaskini maklumat ini?";
            $('#confirmationMessage11').text(msg);
            $('#transaksi').modal('hide');
            $('#saveConfirmationModal11').modal('show');

            $('#updateBidaan').off('click').on('click', async function () {
                $('#saveConfirmationModal11').modal('hide');

                var newBidaanUpdate = {
                    UpdateBidaan: {
                        txtIdBidaan: $('#txtIdBidaanT').val(),
                        txtTarikhMula: $('#txtTarikhMulaT').val(),
                        txtMasaMula: $('#txtMasaMulaT').val(),
                        txtTarikhTamat: $('#txtTarikhTamatT').val(),
                        txtMasaTamat: $('#txtMasaTamatT').val(),
                        txtHargaMula: $('#txtHargaMulaT').val(),
                        kenaikanBidaanMinima: $('#kenaikanBidaanMinimaT').val()

                    }
                }

                try {
                    var result = JSON.parse(await ajaxUpdateBidaan(newBidaanUpdate));
                    if (result.Status === true) {
                        showModal10("Success", result.Message, "success");
                        clearInput()
                        tbl.ajax.reload();

                    } else {
                        showModal10("Error", result.Message, "error");
                    }
                }
                catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }
            });
        });

        async function ajaxUpdateBidaan(UpdateBidaan) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/UpdateDaftarBidaan") %>',
                    method: 'POST',
                    data: JSON.stringify(UpdateBidaan),
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




    </script>


</asp:Content>
