<%@ Page Title="" Language="vb" Async="true" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PELARASAN_Pt.aspx.vb" Inherits="SMKB_Web_Portal.PELARASAN_Pt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    <style>
        #permohonan .modal-body {
            max-height: 70vh; /* Adjust height as needed to fit your layout */
            min-height: 70vh;
            overflow-y: scroll;
            scrollbar-width: thin;
        }

        tr .odd .selected {
            background-color: none !important;
        }

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

        #tblDataSenarai_permohonan td:hover {
            cursor: pointer;
        }



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

        .nav-tabs .nav-link {
            padding: 0.25rem 0.5rem;
        }



        .right_radius {
            border-bottom-right-radius: 0px !important;
            border-top-right-radius: 0px !important;
        }

        .left_radius {
            border-bottom-left-radius: 0px !important;
            border-top-left-radius: 0px !important;
        }

        .ui.search.dropdown {
            height: auto !important;
            min-width: 80%;
            top: 0px;
            left: 0px;
        }

        .codx {
            display: none;
            visibility: hidden;
        }
    </style>

    <div id="PermohonanTab" class="tabcontent" style="display: block">
        <div id="divpendaftaraninv" runat="server" visible="true">
            <div class="modal-body">
                <div class="table-title">
                    <h5>Pelarasan Pesanan Tempatan PTJ</h5>
                    <hr>
                    <div class="btn btn-primary btnPapar"">
                        Senarai Permohonan  
                    </div>
                </div>
                <hr />
                <div class="">
                    <div class="form-row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <input class="input-group__input " id="txtNoPelarasan_PT" type="text" placeholder="&nbsp;" name="No Pelarasan PT" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="No Pelarasan PT">No Pelarasan PT :</label>
                            </div>

                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <input class="input-group__input " id="txtTarikh_Pelarasan_PT" type="date" placeholder="&nbsp;" name="txtTarikh_Pelarasan_PT" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtTarikh_Pelarasan_PT">Tarikh Pelarasan PT :</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <input class="input-group__input " id="txtNo_PT" type="text" placeholder="&nbsp;" name="No PT" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="No PT">No PT :</label>
                            </div>

                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <input class="input-group__input " id="txtTarikh_PT" type="date" placeholder="&nbsp;" name="txtTarikh_PT" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtTarikh_PT">Tarikh PT :</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-6">
                            <div class=" form-group">
                                <input class="input-group__input " id="txtNo_TSH" type="text" placeholder="&nbsp;" name="txtNo_TSH" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtNo_TSH">No. Tender / Sebut Harga :</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <input class="input-group__input " id="txtTrarikh_Tender" type="date" placeholder="&nbsp;" name="txtTrarikh_Tender" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtTrarikh_Tender">Tarikh Tender :</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-6">
                            <div class=" form-group">

                                <textarea class="input-group__input" id="txtPembekalDT" readonly style="background-color: #f0f0f0; height: auto" rows="2"></textarea>
                                <label class="input-group__label" for="Pembekal">Pembekal :</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class=" form-group">
                                <textarea class="input-group__input" id="txtPembekal_Kepada" readonly style="background-color: #f0f0f0; height: auto" rows="2"></textarea>
                                <label class="input-group__label" for="Tujuan">Pembekal Kepada :</label>
                            </div>
                        </div>

                    </div>
                    <div class="form-row">
                        <div class="col-md-6">
                            <div class=" form-group">
                                <input class="input-group__input " id="txtRujukan_Pembekal" type="text" placeholder="&nbsp;" name="txtRujukan_Pembekal" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtRujukan_Pembekal">Rujukan Pembekal :</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <input class="input-group__input " id="txtBekal_Sebelum" type="text" placeholder="&nbsp;" name="txtBekal_Sebelum" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtBekal_Sebelum">Bekal Sebelum :</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">

                        <div class="col-md-6">
                            <div class="form-group">
                                <input class="input-group__input " id="txtNama_Pemohon" type="text" placeholder="&nbsp;" name="txtNama_Pemohon" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtNama_Pemohon">Nama Pemohon :</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <input class="input-group__input " id="txtBayar_Atas_Nama" type="text" placeholder="&nbsp;" name="txtBayar_Atas_Nama" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtBayar_Atas_Nama">Bayar Atas Nama :</label>
                            </div>

                        </div>
                    </div>
                    <div class="form-row">

                        <div class="col-md-6">
                            <div class="form-group">
                                <input class="input-group__input " id="txtNo_Tel_Pemohon" type="text" placeholder="&nbsp;" name="txtNo_Tel_Pemohon" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="txtNo_Tel_Pemohon">No.Tel Pemohon :</label>
                            </div>
                        </div>

                    </div>

                </div>

                <hr />
                <div class="table-title">
                    <h5>Kuantiti :</h5>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <div class="col-md-12 divtbl">
                                <table id="tblDataPerolehanTbl" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="display: none"></th>
                                            <th scope="col">Vot</th>
                                            <th scope="col">KO</th>
                                            <th scope="col">PTJ</th>
                                            <th scope="col">KP</th>
                                            <th scope="col">KW</th>
                                            <th scope="col">Barang / Perkara</th>
                                            <th scope="col">Kuantiti</th>
                                            <th scope="col">Ukuran</th>
                                            <th scope="col">Baki Peruntukan (RM)</th>
                                            <th scope="col">Anggaran Harga Seunit (RM)</th>
                                            <th scope="col">Jumlah Anggaran Harga (RM)</th>
                                            <th>Tindakan</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr align="center">
                                            <td scope="col" colspan="12">Tiada rekod.</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-md-2">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-warning btnAddRow font-weight-bold" data-val="1">+ Tambah</button>
                                            <button type="button" class="btn btn-warning dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <span class="sr-only">Toggle Dropdown</span>
                                            </button>
                                            <div class="dropdown-menu">
                                                <a class="dropdown-item btnAddRow" data-val="5" style="cursor:pointer">Tambah 5</a>
                                                <a class="dropdown-item btnAddRow" data-val="10" style="cursor:pointer">Tambah 10</a>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row justify-content-end mt-2">
                                    <div class="col-md-2 text-right">
                                        <label class="col-form-label ">Jumlah Besar (RM) :</label>

                                    </div>
                                    <div class="col-md-2">
                                        <input class="form-control  underline-input" id="txtJumlah_Besar" name="totalwoCukai" style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00" readonly />

                                    </div>
                                </div>
                                <div class="row justify-content-end mt-2">
                                    <div class="col-md-2 text-right">
                                        <label class="col-form-label ">Jumlah Bersih (RM) :</label>

                                    </div>
                                    <div class="col-md-2">
                                        <input class="form-control  underline-input" id="txtJumlah_Bersih" name="TotalTax" style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00" readonly />
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <textarea class="input-group__input" id="txtUlasan_Perbezaan" style="height: auto" rows="2"></textarea>
                            <label class="input-group__label" for="txtUlasan_Perbezaan">Ulasan Perbezaan :</label>
                        </div>
                    </div>


                </div>


            </div>
            <div class="form-row">

                <div class="form-group col-md-12" align="right">
                    <button id="btnShow" type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft"">Simpan</button>
                </div>
            </div>
        </div>
    </div>



    <!-- Modal permohonan-->

    <div class="modal fade" id="permohonanListModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Senarai Pesanan Tempatan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-10">
                                <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Carian :</label>
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
                                        <button id="btnSearch" class="btn btnSearch btn-outline" type="button">
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
                                <div class="col-md-11">
                                    <div class="form-row justify-content-center">
                                        <div class="form-group col-md-1 align-middle">
                                            <label id="lblMula" style="text-align: right; display: none;" class="col-sm-3 col-form-label">Mula: </label>
                                        </div>
                                        <div class="form-group col-md-3">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display: none;" class="form-control date-range-filter">
                                        </div>
                                        <div class="form-group col-md-1">
                                        </div>
                                        <div class="form-group col-md-1 align-middle">
                                            <label id="lblTamat" style="text-align: right; display: none;" class="col-sm-3 col-form-label">Tamat: </label>
                                        </div>
                                        <div class="form-group col-md-3">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display: none;" class="form-control date-range-filter">
                                        </div>
                                    </div>
                                    <div class="form-group col-md-2"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="row">
                            <div class="transaction-table table-responsive">
                                <table id="tblPelarasan" class="table table-striped" width="100%">
                                    <thead>
                                        <tr style="width: 100%">
                                            <th scope="col">Bil</th>
                                            <th scope="col">No PT</th>
                                            <th scope="col">Tarikh PT</th>
                                            <th scope="col">No PT Adj</th>
                                            <th scope="col">Tarikh PT Adj</th>
                                            <th scope="col">Kaedah</th>
                                            <th scope="col">Vendor</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Pengesahan-->
    <div class="modal fade" id="saveConfirmationModal10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabel10">Hantar Permohonan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessage10"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="confirmSaveButton10">Ya</button>
                </div>
            </div>
        </div>
    </div>

    <%--Modal Alert--%>
    <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title">Sistem Maklumat Kewangan Bersepadu</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="lblMessageModal"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
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
                    <p id="resultModalMessage10"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        var tbl_List;
        var isClicked7 = false, alreadyLoad = false;
        var dllNo_mohon = '', idPembelian = '', tempNoPelarasan = '', kodPmtg = '';
        var tempJumlahAsal = '';
        var listItem = {}, copiedJson = {};

        $('.input-group__input').each(function () {
            $(this).val(''); // Set the value to an empty string
        });

        $(".btnPapar").click(function () {
            $('#permohonanListModal').modal('toggle'); //modal

            // set datepicker to empty and hide it as default state
            $('#txtTarikhStart').val("");
            $('#txtTarikhEnd').val("");

            // clear table setiap kali click utk papar listing
            //tbl_CT.clear().draw()
        });

        $("#txtJumlah_Besar").val('');
        $("#txtJumlah_Bersih").val('');

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

        $('.btnSearch').click(async function () {
            isClicked7 = true;

            var startDate = $('#txtTarikhStart').val();
            var endDate = $('#txtTarikhEnd').val();

            var postDt = {
                category_filter: $('#categoryFilter').val(),
                isClicked7: isClicked7,
                tkhMula: startDate,
                tkhTamat: endDate
            }

            var data = await ajaxPost('<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/LoadPerolehan_Pesanan_Pelarasan") %>', postDt, false);

            if (isSet(data)) {
                tbl_CT.clear();
                tbl_CT.rows.add(data.Payload).draw();
                //var rowCount = tbl.rows().count();
            }
        });

        //List Of Datatable
        var tbl_CT = $("#tblPelarasan").DataTable({
            "responsive": true,
            "searching": true,
            cache: true,
            dom: 'Bfrtip',
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
            "rowCallback": function (row, data) {
                // Add hover effect
                $(row).hover(function () {
                    $(this).addClass("hover pe-auto bg-warning");
                }, function () {
                    $(this).removeClass("hover pe-auto bg-warning");
                });

                $(row).on("click", function () {
                    ajaxPost('<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/LoadPerolehan_Pesanan_Pelarasan_Dtl") %>', { TargetId: data.No_Pesanan }, false, loadPesananTempatan)
                });
            },
            "columns": [
                {
                    "data": "Bil",
                    render: function (data, type, row, meta) {
                        return meta.row + meta.settings._iDisplayStart + 1;
                    },
                },
                {
                    "data": "No_Pesanan"
                },
                {
                    "data": "Tarikh_Pesanan",
                    "type": "date", // This is optional but helps with sorting
                    render: function (data, type, row) {
                        // Format the date using moment.js
                        if (data == null) {
                            return '-';
                        } else {
                            return moment(data).format('DD/MM/YYYY, h:mm a ').toUpperCase(); // Adjust the format as needed
                        }
                    }
                },
                {
                    "data": "No_Pelarasan"
                },
                {
                    "data": "Tarikh_Pelarasan",
                    "type": "date", // This is optional but helps with sorting
                    render: function (data, type, row) {
                        // Format the date using moment.js
                        if (data == null) {
                            return '-';
                        } else {
                            return moment(data).format('DD/MM/YYYY, h:mm a ').toUpperCase(); // Adjust the format as needed
                        }
                    }
                },
                {
                    "data": "Jenis_Dokumen"
                },
                {
                    "data": "Nama_Sykt",
                    "width": "30%"
                },
            ],
        });

        async function buildTblDataPerolehanTbl() {
            alreadyLoad = true;
            tbl_List = $("#tblDataPerolehanTbl").DataTable({
                //"responsive": true,
                "searching": true,
                cache: true,
                scrollX: true,
                dom: 'Bfrtip',
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/LoadPerolehan_Pesanan_Pelarasan_Tbl") %>',
                    type: 'POST',
                    data: function (d) {
                        return "{ dllNo_mohon: '" + dllNo_mohon + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        listItem = {};
                        $.each(JSON.parse(json.d), function (index, value) {
                            var Id = value.Id_Mohon_Dtl;
                            if (!(Id in listItem)) {
                                listItem[Id] = value;
                            }
                        });

                        copiedJson = $.extend(true, {}, listItem);

                        var totalSum = calcSum(listItem);

                        console.log(listItem)

                        $("#txtJumlah_Besar").val(formatNumber(totalSum));
                        $("#txtJumlah_Bersih").val(formatNumber(totalSum));

                        return JSON.parse(json.d);
                    }
                },
                "columns": [
                    { "data": "Id_Mohon_Dtl", "visible": false }, // Hide the Id_Dtl column
                    {
                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (isSet(data.Kod_Vot)) {
                                return '<select class="form-control ui dropdown search ddlCOA" name="ddlCOA_update" id="ddlCOA_update' + meta.row + '"><option value="' + data.Kod_Vot + '" selected>' + data.Kod_Kump_Wang + ' - ' + data.Txt_Kump_Wang + ', ' + data.Kod_Operasi + ' - ' + data.Txt_Operasi + ', ' + data.Kod_Projek + ' - ' + data.Txt_Projek + ', ' + data.Kod_Ptj + ' - ' + data.Txt_Ptj + ', ' + data.Kod_Vot + ' - ' + data.Txt_Vot + '</option></select>';
                            } else {
                                return '<select class="form-control ui dropdown search ddlCOA" name="ddlCOA_update" id="ddlCOA_update' + meta.row + '"><option value="' + data.Kod_Vot + '" selected>' + data.Txt_Vot + '</option></select>';
                            }
                        },
                        "width": "50%"
                    },
                    {
                        "data": "Txt_Operasi",
                        "className": "ddlKodOperasi_update"
                    },
                    {
                        "data": "Txt_Ptj",
                        "className": "ddlPTj_update"
                    },
                    {
                        "data": "Txt_Projek",
                        "className": "ddlKodProjek_update"
                    },
                    {
                        "data": "Txt_Kump_Wang",
                        "className": "ddlKW_update"
                    },
                    {
                        "data": "Butiran",
                        render: function (data, type, row, meta) {
                            return ' <input class="form-control txtinput" type="text" name="Butiran" value="' + data + '"/>'
                        },
                        //"width": "20%"
                    },
                    {
                        "data": "Kuantiti",
                        render: function (data, type, row, meta) {
                            return '<input class="form-control numinput" type="text" name="Kuantiti" value="' + data + '"/>'
                        },
                    },
                    {
                        "data": null, // ddl ukuran
                        "render": function (data, type, row, meta) {
                            return '<select class="form-control ui dropdown search ddlUkur" name="ddlUkuran" id="ddlUkuran' + meta.row + '"><option value="' + data.Ukuran + '" selected>' + data.Txt_Ukuran + '</option></select>';
                        },
                        //"width": "15%"
                    },
                    {
                        "data": null, //baki peruntukan //col = Baki_Peruntukan
                        "render": function (data, type, row, meta) {
                            var showtxt = '<span class="txt_Baki_Peruntukan" data-kkw="' + data.Kod_Kump_Wang + '" data-ko="' + data.Kod_Operasi + '" data-kptj="' + data.Kod_Ptj + '" data-kprjk="' + data.Kod_Projek + '" data-kodvot="' + data.Kod_Vot + '">0.00</span>'
                            //var showtxt = '<span class="txt_Baki_Peruntukan">' + formatNumber(data) + '</span>';
                            return showtxt;
                        },
                        //"width": "15%",
                    },
                    {
                        "data": "Harga_Seunit",
                        render: function (data, type, row, meta) {
                            return '<input class="form-control numinput" type="text" name="Harga_Seunit" value="' + data + '"/>'
                        },
                        "className": "text-right",
                        //"width": "10%"
                    },
                    {
                        "data": "Jumlah_Harga",
                        render: function (data, type, row, meta) {
                            return '<input class="form-control" type="text" name="Jumlah_Harga" value="' + data + '" disabled readonly/>'
                        },
                        "className": "text-right",
                        //"width": "15%"
                    },
                    {
                        "data": "Tindakan",
                        render: function (data, type, row, meta) {
                            return '<div class="btn btnDelete"> <i class="fa fa-trash" style="color: red;font-size:1.5em"></i> </div>'
                        }
                    }
                ],
                "rowCallback": function (row, data, displayNum, displayIndex, dataIndex) {
                    var slctRowDt = data.Id_Mohon_Dtl || ('newdt' + dataIndex); // Access Id_Dtl for the clicked row

                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    // on input number event / masa user type
                    $(row).on("input", ".numinput", function () {
                        numberInput(this);
                        // Dynamically adjust column width to a larger size
                        var table = $(this).closest('table').DataTable();
                        var columnIndex = $(this).closest('td').index() + 1;
                        table.column(columnIndex).nodes().to$().css('width', '500px'); // Adjust width to 200px or any desired value
                    });

                    // on blur number event / type is done
                    $(row).on("blur", ".numinput", function () {

                        var qty = $('input[name="Kuantiti"]', row).val();
                        var hrgseunit = $('input[name="Harga_Seunit"]', row).val();
                        var jumlah = performMultiplication(qty, hrgseunit);

                        var compareVal = parseFloat(jumlah.replace(/,/g, '')) < parseFloat($('.txt_Baki_Peruntukan', row).text().replace(/,/g, ''));
                        console.log("Jumlah_Harga", parseFloat(jumlah.replace(/,/g, '')))
                        console.log("txt_Baki_Peruntukan", parseFloat($('.txt_Baki_Peruntukan', row).text().replace(/,/g, '')))
                        if (!compareVal) {
                            if ($("#ddlCOA_update" + dataIndex).val() != '') {
                                $("#lblMessageModal").html("Baki peruntukan bagi item ini tidak mencukupi.");
                                $("#MessageModal").modal('show');
                            } else {
                                $("#lblMessageModal").html("Sila pilih vot terlebih dahulu.");
                                $("#MessageModal").modal('show');
                            }
                            $('input[name="Kuantiti"]', row).val(listItem[slctRowDt].Kuantiti);
                            $('input[name="Harga_Seunit"]', row).val(listItem[slctRowDt].Harga_Seunit);
                        } else {
                            $('input[name="Jumlah_Harga"]', row).val(jumlah); //Update Field

                            listItem[slctRowDt].Kuantiti = qty;
                            listItem[slctRowDt].Harga_Seunit = hrgseunit.replace(/,/g, '');
                            var beza = calcBeza(listItem[slctRowDt].Jumlah_Harga_Asal, jumlah);
                            if (beza != '0.00') {
                                listItem[slctRowDt].Beza = beza;
                            } else {
                                delete listItem[slctRowDt].Beza;
                            }
                            listItem[slctRowDt].Jumlah_Harga = jumlah.replace(/,/g, '');

                            var totalSum = calcSum(listItem);

                            $("#txtJumlah_Besar").val(formatNumber(totalSum));
                            $("#txtJumlah_Bersih").val(formatNumber(totalSum));

                            console.log(listItem)
                        }
                    });

                    // on input text event
                    $(row).on("blur", ".txtinput[name='Butiran']", function () {
                        listItem[slctRowDt].Butiran = $(this).val();
                        console.log($(this).val())
                    });

                    $(row).off('click').on('click', '.btnDelete', function () {
                        //Padam list
                        if (slctRowDt) {
                            // Padam current row table
                            tbl_List.row(dataIndex).remove().draw();
                            delete listItem[slctRowDt]; //Padam data json
                        }

                        var totalSum = calcSum(listItem);

                        $("#txtJumlah_Besar").val(formatNumber(totalSum));
                        $("#txtJumlah_Bersih").val(formatNumber(totalSum));
                        console.log(listItem)
                    })
                },
                createdRow: async function (row, data, displayNum, displayIndex, dataIndex) {
                    $('.ui.dropdown[name="ddlCOA_update"]', row).dropdown({
                        selectOnKeydown: true,
                        fullTextSearch: true,
                        apiSettings: {
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/GetVot_COA?q={query}") %>',
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
                                    $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                                });

                                $('.item', objItem).on('click', async function () {
                                    var selectedOption = $(this);
                                    var slctRowDt = data.Id_Mohon_Dtl || ('newdt' + dataIndex);
                                    var bakiP = await getBakiBajet($(this).data('coltambah6'), $(this).data('coltambah7'), $(this).data('coltambah5'), $(this).data('coltambah8'), $(this).data('value'));

                                    if (bakiP.trim() === '0.00') {
                                        // Show Message
                                        $("#lblMessageModal").html("Baki peruntukan bagi item ini tidak ditetapkan, Sila pilih vot yang lain.");
                                        $("#MessageModal").modal('show');
                                    } else {
                                        var compareVal = parseFloat(listItem[slctRowDt].Jumlah_Harga.replace(/,/g, '')) < parseFloat(bakiP.trim().replace(/,/g, ''));
                                       
                                        if (compareVal) {
                                            $('.txt_Baki_Peruntukan', row).text(bakiP);
                                            $('.ddlPTj_update', row).text(selectedOption.data('coltambah1'));
                                            $('.ddlKW_update', row).text(selectedOption.data('coltambah2'));
                                            $('.ddlKodOperasi_update', row).text(selectedOption.data('coltambah3'));
                                            $('.ddlKodProjek_update', row).text(selectedOption.data('coltambah4'));
                                            listItem[slctRowDt].Kod_Vot = $(this).data('value');
                                            listItem[slctRowDt].Kod_Ptj = $(this).data('coltambah5');
                                            listItem[slctRowDt].Kod_Kump_Wang = $(this).data('coltambah6');
                                            listItem[slctRowDt].Kod_Operasi = $(this).data('coltambah7');
                                            listItem[slctRowDt].Kod_Projek = $(this).data('coltambah8');
                                            listItem[slctRowDt].Baki_Peruntukan = bakiP.replace(/,/g, '').substring(1);

                                            if (isSet(copiedJson[slctRowDt])) {
                                                if (copiedJson[slctRowDt].Kod_Vot == listItem[slctRowDt].Kod_Vot) {
                                                    if (copiedJson[slctRowDt].Jumlah_Harga == listItem[slctRowDt].Jumlah_Harga) {
                                                        if (listItem[slctRowDt].hasOwnProperty('Beza')) {
                                                            delete listItem[slctRowDt].Beza;
                                                        }
                                                    } else {
                                                        var beza = calcBeza(listItem[slctRowDt].Jumlah_Harga_Asal, listItem[slctRowDt].Jumlah_Harga);
                                                        if (beza != '0.00') {
                                                            listItem[slctRowDt].Beza = beza;
                                                        } else {
                                                            delete listItem[slctRowDt].Beza;
                                                        }
                                                    }
                                                } else {
                                                    listItem[slctRowDt].Beza = copiedJson[slctRowDt].Jumlah_Harga;

                                                    var newKeyId = "delitem" + listItem[slctRowDt].Id_Mohon_Dtl;
                                                    var newDataTbl = {
                                                        "Kod_Kump_Wang": copiedJson[slctRowDt].Kod_Kump_Wang,
                                                        "Kod_Operasi": copiedJson[slctRowDt].Kod_Operasi,
                                                        "Kod_Projek": copiedJson[slctRowDt].Kod_Projek,
                                                        "Kod_Ptj": copiedJson[slctRowDt].Kod_Ptj,
                                                        "Kod_Vot": copiedJson[slctRowDt].Kod_Vot,
                                                        "Beza": '-' + copiedJson[slctRowDt].Jumlah_Harga,
                                                        Jumlah_Harga: '0.00'
                                                    }

                                                    listItem[newKeyId] = newDataTbl;
                                                }
                                            }
                                        } else {
                                            $("#lblMessageModal").html("Baki peruntukan bagi item ini tidak mencukupi.");
                                            $("#MessageModal").modal('show');
                                            buildDdl("#ddlCOA_update" + dataIndex.toString(), listItem[slctRowDt].Kod_Vot, listItem[slctRowDt].Kod_Kump_Wang + ' - ' + listItem[slctRowDt].Txt_Kump_Wang + ', ' + listItem[slctRowDt].Kod_Operasi + ' - ' + listItem[slctRowDt].Txt_Operasi + ', ' + listItem[slctRowDt].Kod_Projek + ' - ' + listItem[slctRowDt].Txt_Projek + ', ' + listItem[slctRowDt].Kod_Ptj + ' - ' + listItem[slctRowDt].Txt_Ptj + ', ' + listItem[slctRowDt].Kod_Vot + ' - ' + listItem[slctRowDt].Txt_Vot);
                                        }
                                    }
                                });

                                $(obj).dropdown('refresh');
                                $(obj).dropdown('show');
                            }
                        }
                    });

                    $('.ui.dropdown[name="ddlUkuran"]', row).dropdown({
                        selectOnKeydown: true,
                        fullTextSearch: true,
                        apiSettings: {
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetUkuran?q={query}") %>',
                            //url: 'PermohonanPoWs.asmx/GetUkuran?q={query}',
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
                                    $(objItem).append($('<div class="item" data-value="' + option.value + '" data-text="' + option.text + '" >').html(option.text));
                                });

                                $('.item', objItem).on('click', function () {
                                    ukuranValue = $(this).data('value'); // Store the value ('04')
                                    ukuranText = $(this).data('text'); // Retrieve the text ('KM')

                                    var slctRowDt = data.Id_Mohon_Dtl || ('newdt' + dataIndex); // Access Id_Dtl for the clicked row
                                    listItem[slctRowDt].Ukuran = ukuranValue;
                                    listItem[slctRowDt].Txt_Ukuran = ukuranText;
                                });

                                // Refresh dropdown
                                $(obj).dropdown('refresh');

                                //if (shouldPop === true) {
                                $(obj).dropdown('show');
                                //}
                            }
                        }
                    });

                    // Baki P
                    var kkw = $(".txt_Baki_Peruntukan", row).data("kkw");
                    var ko = $(".txt_Baki_Peruntukan", row).data("ko");
                    var kptj = $(".txt_Baki_Peruntukan", row).data("kptj");
                    var kprjk = $(".txt_Baki_Peruntukan", row).data("kprjk");
                    var kodvot = $(".txt_Baki_Peruntukan", row).data("kodvot");

                    var bakiP = await getBakiBajet(kkw, ko, kptj, kprjk, kodvot);
                    $(".txt_Baki_Peruntukan", row).text(bakiP);
                }
            });
        }

        $(".btnAddRow").off("click").on("click", function () {
            var totalRow = tbl_List.rows().count();
            var totalAddRow = parseInt($(this).data("val"));
            for (var i = 0; i < totalAddRow; i++) {
                totalRow++;
                var newKeyId = "newitem" + totalRow.toString();
                var newDataTbl = {
                    "Id_Mohon_Dtl": newKeyId,
                    "Txt_Operasi": '',
                    "Txt_Ptj": '',
                    "Txt_Projek": '',
                    "Txt_Kump_Wang": '',
                    "Butiran": '',
                    "Butiran": '',
                    "Kuantiti": '',
                    "Txt_Ukuran": 'Sila pilih ukuran',
                    "Ukuran": '',
                    "Harga_Seunit": '0.00',
                    "Jumlah_Harga": '0.00',
                    "Jumlah_Harga_Asal": '0.00',
                    "Kod_Vot": '',
                    "Txt_Vot": 'Sila pilih vot',
                    "Baki_Peruntukan": ""
                }

                tbl_List.row.add(newDataTbl).draw(false);
                tbl_List.order([0, 'asc']).draw();

                listItem[newKeyId] = newDataTbl;
            }
        });

        function formatNumber(number) {
            return new Intl.NumberFormat('en-US', {
                style: 'decimal',
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(number);
        }

        function fetchErrorMsg4EveryClass(className, jenis) {
            var arrError = []
            $(className).each(function (index) {
                var value = '';
                if (jenis == "select") {
                    value = $(this).children('input, select').val();
                } else {
                    value = $(this).val();
                }
                var check = isSet(value);
                if (!check) {
                    $(this).addClass("border border-danger");
                    arrError.push(false);
                } else {
                    //$(this).is('select')
                    $(this).removeClass("border border-danger");
                }
            });

            if (arrError.includes(false)) {
                return false; // Exit the loop completely
            } else {
                return true;
            }
        }

        async function getBakiBajet(kod_KW, kod_Operasi, kod_PTj, kod_Projek, kod_coa_vot) {
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            today = yyyy + '-' + mm + '-' + dd;

            // Specify the URL you want to fetch data from
            const url = '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/FGetBakiSebenar") %>';

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: url,
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({
                        year: yyyy,
                        tarikh: today,
                        ptj: kod_PTj,
                        kw: kod_KW,
                        ko: kod_Operasi,
                        kp: kod_Projek,
                        vot: kod_coa_vot
                    }),
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        var rdata = JSON.parse(data.d);
                        var result = rdata.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }).replace('RM', '');
                        resolve(result);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching details:" + error);
                        // Check if callback is a function before calling it
                        reject(false);
                    }
                });
            })
            
        }

        function buildDdl(id, kodVal, txtVal) {
            if (isSet(kodVal) && isSet(txtVal)) {
                $(id).html("<option value = '" + kodVal + "'>" + txtVal + "</option>")
                $(id).dropdown('set selected', kodVal);
            }
        }

        function calcSum(list) {
            var result = 0.00;
            if (list != {}) {
                for (const key in list) {
                    if (list.hasOwnProperty(key)) {
                        result += parseFloat(list[key].Jumlah_Harga.replace(/,/g, ''));
                    }
                }
            }

            return result.toFixed(2);
        }

        function calcBeza(oldVal, newVal) {
            var result = 0.00;
            if (oldVal != '' && newVal != '') {
                var oldValNum = parseFloat(oldVal.replace(/,/g, ''));
                var newValNum = parseFloat(newVal.replace(/,/g, ''));
                var result = newValNum - oldValNum;
            }

            return result.toFixed(2);
        }

        function numberInput(input) {
            const cleanedValue = input.value.replace(/[^0-9.]/g, '');
            const parts = cleanedValue.split('.');
            parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');

            if (parts[1] && parts[1].length > 2) {
                parts[1] = parts[1].substring(0, 2);
            }

            input.value = parts.join('.');
        }

        function performMultiplication(valKuantiti, valHrgaSeunit) {
            const kuantitiValue2 = parseFloat(valKuantiti.replace(/,/g, '')) || 0; // Remove all commas
            const angHrgSeunitValue2 = parseFloat(valHrgaSeunit.replace(/,/g, '')) || 0; // Remove all commas
            const result2 = kuantitiValue2 * angHrgSeunitValue2;
            return result2.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }

        function loadPesananTempatan(data) {
            if (data.Status) {
                $('#permohonanListModal').modal('toggle'); //tutup modal
                var dt = data.Payload[0];

                dllNo_mohon = dt.No_Mohon;
                idPembelian = dt.IdPembelian
                var DDPembekalDT = dt.ID_Sykt + ' - ' + dt.Nama_Sykt;
                var DDNama_pemohon = dt.Id_Pemohon + ' - ' + dt.NamaPemohon;

                //$("txtKaedah_Perolehan").val(dt.Tujuan);
                tempNoPelarasan = dt.No_Pelarasan || '';
                tempJumlahAsal = dt.Jumlah_Asal || ''
                kodPmtg = dt.KodPemiutang || '';
                $("#txtNoPelarasan_PT").val(dt.No_Pelarasan || '-');
                $("#txtNo_PT").val(dt.No_Pesanan);
                $("#txtNo_TSH").val(dt.No_Sebut_Harga);
                $("#txtPembekalDT").val(DDPembekalDT);
                $("#txtPembekal_Kepada").val(dt.Bekal_Kepada || '');
                $("#txtRujukan_Pembekal").val(dt.Skop || '');
                $("#txtBekal_Sebelum").val(dt.Bekal_Sebelum || '');
                $("#txtNama_Pemohon").val(DDNama_pemohon);
                $("#txtBayar_Atas_Nama").val(dt.Nama_Sykt || '');
                $("#txtNo_Tel_Pemohon").val(dt.NoTelBimbit);
                $("#txtTarikh_Pelarasan_PT").val(dt.Tarikh_Pelarasan || '');
                $("#txtTarikh_PT").val(dt.Tarikh_Pesanan || '');
                $("#txtUlasan_Perbezaan").val(dt.Ulasan_Pelarasan || '');

                if (!alreadyLoad) {
                    buildTblDataPerolehanTbl();
                } else {
                    tbl_List.ajax.reload();
                }
            }
        }

        function isSet(value) {
            if (value === null || value === '' || value === undefined) {
                return false;
            } else {
                return true;
            }
        }

        function compareJSON(obj1, obj2) {
            // Check if both objects have the same number of keys
            if (Object.keys(obj1).length !== Object.keys(obj2).length) {
                return false;
            }

            // Check each key-value pair in obj1
            for (var key in obj1) {

                // Check if the key exists in obj2
                if (!obj2.hasOwnProperty(key)) {
                    return false;
                }

                // Check if the values for the same key are equal
                if (JSON.stringify(obj1[key]) !== JSON.stringify(obj2[key])) {
                    return false;
                }
            }

            // If all checks pass, the objects are equal
            return true;
        }

        function checkUlasan() {
            var value = $("#txtUlasan_Perbezaan").val();
            if (isSet(value)) {
                $("#txtUlasan_Perbezaan").removeClass("border border-danger");
                return true
            } else {
                $("#txtUlasan_Perbezaan").addClass("border border-danger");
                return false
            }
        }

        $(".btnSimpan").off('click').on('click', async function () {
            //Simpan

            var check1 = fetchErrorMsg4EveryClass("#tblDataPerolehanTbl .ddlCOA", "select");
            var check2 = fetchErrorMsg4EveryClass("#tblDataPerolehanTbl .ddlUkur", "select");
            var check3 = fetchErrorMsg4EveryClass("#tblDataPerolehanTbl .numinput", "input");
            var check4 = fetchErrorMsg4EveryClass("#tblDataPerolehanTbl .txtinput", "input");
            var check5 = checkUlasan();

            // Count the number of rows
            var rowCount = tbl_List.rows().count();

            // Check if the table contains any rows
            if (rowCount > 0) {
                if (check1 && check2 && check3 && check4 && check5) {
                    // Check perubahan pada list
                    if (compareJSON(listItem, copiedJson)) { // Compare json
                        //console.log('xde perubahan')
                        $("#lblMessageModal").html("Pemberitahuan: Tiada perubahan yang dibuat.");
                        $("#MessageModal").modal('show');
                    } else {

                        //console.log('ada perubahan')
                        var postDt = {
                            noPelarasan: tempNoPelarasan,
                            noPesanan: $("#txtNo_PT").val(),
                            kodPemiutang: kodPmtg,
                            jumlahAsal: (tempJumlahAsal == '') ? calcSum(copiedJson) : tempJumlahAsal,
                            jumlahSlpsPelarasan: calcSum(listItem),
                            jumlahBeza: calcBeza(calcSum(copiedJson), calcSum(listItem)),
                            noMohon: dllNo_mohon,
                            idPembelian: idPembelian,
                            ulasanPelarasan: $("#txtUlasan_Perbezaan").val(),
                            data: listItem
                        };

                        console.log(postDt)

                        // Tutup Modal Transaksi
                        $('#transaksi').modal('toggle');
                        if (parseFloat(postDt.jumlahSlpsPelarasan) <= parseFloat(postDt.jumlahAsal)) {
                            debugger
                            if (tempNoPelarasan != '') {
                                //Edit
                                var result = await ajaxPostAsync('<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/KemaskiniPelarasan") %>', postDt, true);

                                if (result.Status) {
                                    var dt = result.Payload;
                                    var tkhPelarasan = moment(dt.TkhPelarasan, "YYYY-MM-DD HH:mm:ss").format('YYYY-MM-DD');
                                    $("#txtTarikh_Pelarasan_PT").val(tkhPelarasan);
                                    $("#txtNoPelarasan_PT").val(dt.NoPelarasan);
                                    tempNoPelarasan = dt.NoPelarasan;
                                    tbl_List.ajax.reload();
                                    //tbl_CT.ajax.reload();
                                    // Show Message
                                    $("#lblMessageModal").html(result.Message);
                                    $("#MessageModal").modal('show');
                                } else {
                                    $("#lblMessageModal").html(result.Message);
                                    $("#MessageModal").modal('show');
                                }
                            } else {
                                //New
                                var result = await ajaxPostAsync('<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/SubmitPelarasan") %>', postDt, true);

                                if (result.Status) {
                                    var dt = result.Payload;
                                    var tkhPelarasan = moment(dt.TkhPelarasan, "YYYY-MM-DD HH:mm:ss").format('YYYY-MM-DD');
                                    $("#txtTarikh_Pelarasan_PT").val(tkhPelarasan);
                                    $("#txtNoPelarasan_PT").val(dt.NoPelarasan);
                                    tempNoPelarasan = dt.NoPelarasan;
                                    tbl_List.ajax.reload();
                                    //tbl_CT.ajax.reload();

                                    // Show Message
                                    $("#lblMessageModal").html(result.Message);
                                    $("#MessageModal").modal('show');
                                } else {
                                    $("#lblMessageModal").html(result.Message);
                                    $("#MessageModal").modal('show');
                                }
                            }
                        } else {
                            $("#lblMessageModal").html('Jumlah pelarasan terkini lebih besar daripada jumlah asal RM ' + postDt.jumlahAsal);
                            $("#MessageModal").modal('show');
                        }
                    }
                } else {
                    // Show Message
                    $("#lblMessageModal").html("Sila lengkapkan semua butiran.");
                    $("#MessageModal").modal('show');
                }
            } else {
                // Show Message
                $("#lblMessageModal").html("Tiada item ditemui, sila tambah item.");
                $("#MessageModal").modal('show');
            }
        });

        //ajaxPost(url,data in JSON,enable loader, function after success)
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
        //ajaxpostasync digunakan di ws bg func yang mempunyai async / Tasks.Task(Of String)
        async function ajaxPostAsync(url, postData, enableLoader, fn) {
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
                        result = JSON.parse(data.d.Result);
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
    </script>
</asp:Content>





