<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Maklumat_Pengalaman.aspx.vb" Inherits="SMKB_Web_Portal.Maklumat_Pengalaman" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
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

        .text-right {
            text-align: right;
        }

    </style>

    <div class="panel panel-default">
        <div class="panel-heading">
            <br />
            <div class="modal-body">
                <div class="table-title">
                    <h6>Maklumat Pengalaman Vendor</h6>
                    <div class="btn btn-primary btnPengalaman" onclick="ShowPopup('1')">
                        <i class="fa fa-plus"></i>Pengalaman  
                    </div>
                </div>
            </div>
            <br />
        </div>

        <div class="modal fade" id="modalPengalaman" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleMklmtPengalaman">Tambah Maklumat Pengalaman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <h6>Maklumat Pengalaman</h6>
                                <label id="IdPengalaman" style="visibility: hidden;">IDPengalaman</label>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group input-group">
                                <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtTajukPerolehan" name="txtTajukPerolehan" />
                                <label class="input-group__label">Tajuk Perolehan</label>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtSyaPerolehan" name="txtSyaPerolehan" />
                                <label class="input-group__label">Syarikat Yang Menawarkan Perolehan</label>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" onfocus="(this.type='date')" placeholder="" name="tkhMula" id="tkhMula">
                                        <label class="input-group__label">Tarikh Mula</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" onfocus="(this.type='date')" placeholder="" name="tkhTamat" id="tkhTamat">
                                        <label class="input-group__label">Tarikh Tamat Projek</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" class=" input-group__input form-control input-sm text-right" placeholder="" id="txtNilaiProjek" name="txtNilaiProjek" />
                                <label class="input-group__label">Nilai Projek (RM)</label>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                        <button type="button" runat="server" id="lbtnSimpan" class="btn btn-secondary lbtnSimpan">Simpan</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal-body">
            <div class="col-md-12">
                <div class="transaction-table table-responsive">
                    <table id="tblDataPengalaman" class="table table-striped" style="width: 95%">
                        <thead>
                            <tr data-id="idPengalaman">
                                <th scope="col">Bil</th>
                                <th scope="col">Tajuk Project</th>
                                <th scope="col">Syarikat yang Menawarkan Kerja</th>
                                <th scope="col">Tarikh Mula Projek</th>
                                <th scope="col">NIlai Projek(RM)</th>
                                <th scope="col">Tindakan</th>

                            </tr>
                        </thead>
                        <tbody id="tableID_Senarai_Pengalaman">
                        </tbody>

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
                    <div class="modal-body" id="confirmContent">
                        Anda pasti ingin menyimpan rekod ini?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">
                            Tidak</button>
                        <button type="button" class="btn btn-secondary btnYa">Ya</button>
                        <button type="button" class="btn btn-secondary btnYaDelete" style="display: none;">Ya</button>
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
    <script type="text/javascript">

        var bil = 0;
        var tbl = null
        $(document).ready(function () {
            /* show_loader();*/
            tbl = $("#tblDataPengalaman").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_SenaraiPengalaman",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            idSemSya: '<%=Session("ssusrID")%>',
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

                    // Add click event
                    //$(row).on("click", function () {
                    //    rowClickHandler(data);
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
                    { "data": "TajukProjek" },
                    { "data": "NamaSyarikat" },
                    { "data": "TarikhMula" },
                    {
                        "data": "NilaiJualan",
                        "className": "text-right",
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {

                                return data;

                            }
                            var Nilai = data.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                            return Nilai;
                        }
                    },
                    {
                        className: "btnEdit",
                        "data": "IdPengalaman",
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEdit" runat="server" class="btn btnEdit" type="button" style="color: blue" data-dismiss="modal" data-id="${data}" onclick="ShowPopup('1')">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDelete" runat="server" class="btn btnDelete" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        $('#txtNilaiProjek').change(function () {
            if ($(this).val() === "") {
                $(this).val("0.00");
            } else (
                $(this).val(parseFloat($(this).val()).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }))
            )
        });

        $('#tblDataPengalaman').on('click', '.btnEdit', async function (event) {

            $("#titleMklmtPengalaman").html("Kemaskini Maklumat Pengalaman");

            event.stopPropagation();
            var idPengalaman = $(this).data("id");
            var IdSya = '<%=Session("ssusrID")%>'

            $.ajax({
                url: 'Pendaftaran_WS.asmx/LoadDataPengalaman',
                method: 'POST',
                data: JSON.stringify({
                    IdSya: IdSya,
                    idPengalaman: idPengalaman
                }),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    /*resolve(data.d);*/
                    var Result = JSON.parse(data.d);
                    if (Result.length > 0) {
                        var DataPengalaman = Result[0];

                        $('#IdPengalaman').html(DataPengalaman.IdPengalaman);
                        $('#txtTajukPerolehan').val(DataPengalaman.TajukProjek);
                        $('#txtSyaPerolehan').val(DataPengalaman.NamaSyarikat);

                        $('#tkhMula').val(DataPengalaman.TarikhMula);
                        $('#tkhTamat').val(DataPengalaman.TarikhTamat);

                        var formattedNilai = parseFloat(DataPengalaman.NilaiJualan).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        $('#txtNilaiProjek').val(formattedNilai);
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                    /*reject(false);*/
                }
            });
        });

        $('#tblDataPengalaman').on('click', '.btnDelete', async function (event) {

            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var idPengalaman = $(this).data("id");
            var IdSya = '<%=Session("ssusrID")%>';
            $('.btnYaDelete').show();

            $('#confirmationModal').modal('toggle');
            $("#confirmContent").text("Adakah Anda Pasti Ingin Memadam Data Ini?");
            $('.btnYa').hide();

            $('.btnYaDelete').click(async function () {
                if (idPengalaman !== "") {
                    bool = await DelPengalaman(idPengalaman, IdSya);
                }

                if (bool === true) {
                    $('#confirmationModal').modal('toggle');
                    curTR.remove();
                }

                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                return false;

            });
        });

        async function DelPengalaman(idPengalaman, IdSya) {
            var bool = false;
            var result = JSON.parse(await AjaxDeletePengalaman(idPengalaman, IdSya));

            if (result.Code === "00") {
                bool = true;
            }
            return bool;
        }

        async function AjaxDeletePengalaman(idPengalaman, IdSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Pendaftaran_WS.asmx/DeleteRecordPengalaman',
                    method: 'POST',
                    data: JSON.stringify({
                        IdPengalaman: idPengalaman,
                        IdSya: IdSya
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
            });
        }

        function ShowPopup(elm) {

            if (elm == "1") {
                $(".modal-body input").val("");
                $('#modalPengalaman').modal('toggle');
                $("#titleMklmtPengalaman").html("Tambah Maklumat Pengalaman");
            }
        }

        $('#txtNilaiProjek').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $(document).ready(function () {
            $('#tkhMula').change(function () {
                var startDate = $(this).val();
                $('#tkhTamat').rules('add', {
                    max: function () {
                        $(this).val(startDate);
                    }
                });
            });

            $('#tkhTamat').change(function () {
                var endDate = $(this).val();
                $('#tkhMula').rules('add', {
                    max: function () {
                        $(this).val(endDate);
                    }
                });
            });
        });

        $('.lbtnSimpan').click(async function () {
            if ($('#txtTajukPerolehan').val() == "" || $('#txtSyaPerolehan').val() == "" || $('#tkhMula').val() == "" || $("#tkhTamat").val() == "" || $('#txtNilaiProjek').val() == "") {
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila isi semua ruangan yang bertanda *");
            } else {
                // open modal confirmation
                $('#confirmationModal').modal('toggle');
            }

        });

        $('.lbtnKemaskini').click(async function () {
            //enable button
            $('#confirmationModal').modal('toggle');
        });

        $('.btnYa').click(async function () {
            //close modal confirmation
            $('#confirmationModal').modal('toggle');

            var nilaiProjek = parseFloat($('#txtNilaiProjek').val().replace(/[^\d.]/g, ''));

            var newPengalaman = {
                pengalaman: {
                    IdPengalaman: $('#IdPengalaman').html(),
                    IdSemSya: '<%=Session("ssusrID")%>',
                    Tajuk: $('#txtTajukPerolehan').val(),
                    NamaSyarikat: $('#txtSyaPerolehan').val(),
                    TkhMula: $('#tkhMula').val(),
                    TkhTamat: $("#tkhTamat").val(),
                    NilaiProjek: nilaiProjek.toFixed(2),
                    OrderID: 'MA12345',
                }
            }

            //parseFloat( $('#txtNilaiProjek').val().replace(/,/g, ''))

            console.log("NilaiHarga: ", newPengalaman);
            var result = JSON.parse(await ajaxSavePengalaman(newPengalaman));

            if (result.Status !== "Failed") {
                $("modalPengalaman").modal('toggle');
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
                /*clearAllFields();*/
                // refresh page after 2 seconds
                setTimeout(function () {
                    tbl.ajax.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
            }

        });

        async function ajaxSavePengalaman(pengalaman) {

            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SavePengalaman',
                    method: 'POST',
                    data: JSON.stringify(pengalaman),
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


    </script>
</asp:Content>
