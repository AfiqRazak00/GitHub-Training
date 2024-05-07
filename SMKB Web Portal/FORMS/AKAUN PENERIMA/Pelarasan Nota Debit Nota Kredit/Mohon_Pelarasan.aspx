<%@ Page Title="" Language="vb" Async="true" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Mohon_Pelarasan.aspx.vb" Inherits="SMKB_Web_Portal.Mohon_Pelarasan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <contenttemplate>
        <style>
        .default-primary {
            background-color: #007bff !important;
            color: white;
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

        #showModalButton:hover {
            /* Add your hover styles here */
            background-color: #ffc107; /* Change background color on hover */
            color: #fff; /* Change text color on hover */
            border-color: #ffc107; /* Change border color on hover */
            cursor: pointer; /* Change cursor to indicate interactivity */
        }
        </style>
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div id="SenaraiKelulusan">
                <div>
                    <div class="modal-body">
                        <div class="modal-header">
                            <h5 class="modal-title">Senarai Bil</h5>
                        </div>
                        <!-- Create the dropdown filter -->
                        <div class="search-filter">
                            <div class="form-row justify-content-center">
                                 <div class="form-group row col-md-6">
                                    <label for="" class="col-sm-1 col-form-label">Carian:</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <select id="categoryFilter" class="custom-select">
                                                <option value="" selected>Semua</option>
                                                <option value="1">Hari Ini</option>
                                                <option value="2">Semalam</option>
                                                <option value="3">7 Hari Lepas</option>
                                                <option value="4">30 Hari Lepas</option>
                                                <option value="5">60 Hari Lepas</option>
                                                <option value="6">Pilih Tarikh</option>
                                            </select>
                                            <div class="input-group-append">
                                                <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button">
                                                    <i class="fa fa-search"></i>
                                                    Cari
                                                </button>
                                            </div> 
                                        </div>
                                    </div>
                                    <div class="col-sm-10 mt-4 d-none" id="divDatePicker">
                                        <div class="d-flex flex-row justify-content-around align-items-center">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label text-nowrap">Mula:</label>
                                                <div class="col-sm-9">
                                                    <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control date-range-filter">
                                                </div>
                                            </div>

                                            <div class="form-group row ml-3">
                                                <label class="col-sm-3 col-form-label text-nowrap">Tamat:</label>
                                                <div class="col-sm-9">
                                                    <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control date-range-filter">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">   
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataSenarai" class="table table-striped">
                                        <thead>
                                            <tr style="width: 100%">
                                                <th scope="col" style="width: 10%">No. Bil</th>
                                                <th scope="col" style="width: 10%">Nama Penghutang</th>
                                                <th scope="col" style="width: 10%">Tarikh Mohon</th>
                                                <th scope="col" style="width: 10%">Tarikh Mula</th>
                                                <th scope="col" style="width: 10%">Tarikh Tamat</th>
                                                <th scope="col" style="width: 15%">Jenis Urusniaga</th>
                                                <th scope="col" style="width: 20%">Tujuan</th>
                                                <th scope="col" style="width: 10%">Jumlah (RM)</th>
                                            </tr>
                                        </thead>
                                        <tbody id=" " style="cursor:pointer;overflow:auto">
                                            <tr style="display: none" class="table-list">

                                                <td>
                                                    <label id="lblNo" name="lblNo" class="lblNo"></label>
                                                </td>
                                                <td>
                                                    <label id="lblPenghutang" name="lblPenghutang" class="lblPenghutang"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTkhMohon" name="lblTkhMohon" class="lblTkhMohon"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTkhMula" name="lblTkhMula" class="lblTkhMula"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTkhTamat" name="lblTkhTamat" class="lblTkhTamat"></label>
                                                </td>
                                                <td>
                                                    <label id="lblJnsUrus" name="lblJnsUrus" class="lblJnsUrus"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTujuan" name="lblTujuan" class="lblTujuan"></label>
                                                </td>
                                                <td>
                                                    <label id="lblJumlah" name="lblJumlah" class="lblJumlah" style="text-align: right"></label>
                                                </td>
                          
                                            </tr>
                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--modal--%>
        <div class="modal fade" id="Senarai" tabindex="-1" role="dialog"
            aria-labelledby="ModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title" id="ModalCenterTitle">Maklumat Bil</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="txtnoinv" name="txtnoinv" readonly />
                                        <label class="input-group__label" for="txtnoinv">No. Bil</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <textarea type="text" class="form-control input-group__input" id="txtNamaPenghutang" name="txtNamaPenghutang" readonly></textarea>
                                        <label class="input-group__label" for="txtNamaPenghutang">Kepada</label>
                                        <div style="display:none">
                                            <select class="form-control ui search dropdown" name="ddlPenghutang" id="ddlPenghutang" >
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-3 form-inline">
                                        <label>Berkontrak</label>
                                        <div class="radio-btn-form d-flex" id="rdKontrak" name="rdKontrak" >
                                            <div class="form-check form-check-inline ">
                                                <input type="radio" id="rdYa" name="inlineRadioOptions" value="1" class="w-50"/>Ya
                                            </div>
                                            <div class="form-check form-check-inline ">
                                                <input type="radio" id="rdTidak" name="inlineRadioOptions" value="0" class="w-50"/>Tidak
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" name="tkhBil" id="tkhBil" readonly>
                                        <label class="input-group__label" for="tkhBil">Tarikh Bil</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" name="tkhMula" id="tkhMula" readonly>
                                        <label class="input-group__label" for="tkhMula">Tarikh Mula</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="tkhTamat" name="tkhTamat" readonly>
                                        <label class="input-group__label" for="tkhTamat">Tarikh Tamat</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" name="Tempoh" id="Tempoh" readonly>
                                        <label class="input-group__label" for="Tempoh">Tempoh</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="JnsTempoh" name="JnsTempoh" readonly>
                                        <label class="input-group__label" for="JnsTempoh">Jenis Tempoh</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="txtUrusniaga" name="txtUrusniaga" readonly/>
                                        <label class="input-group__label" for="txtUrusniaga">Jenis Urusniaga</label>
                                        <div style="display:none"><select id="ddlUrusniaga" class="ui search dropdown" name="ddlUrusniaga" ></select></div>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="NoRujukan" name="NoRujukan" readonly>
                                        <label class="input-group__label" for="NoRujukan">No. Rujukan</label>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <textarea class="form-control input-group__input" name="txtTujuan" id="txtTujuan" readonly></textarea>
                                        <label class="input-group__label" for="txtTujuan">Tujuan</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <h6>Transaksi</h6>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table class="table table-striped" id="tblData" style="width: 100%;">
                                            <thead>
                                                <tr style="width: 100%; text-align: center;">
                                                    <th scope="col" >Vot</th>
                                                    <th scope="col">Kod PTJ</th>
                                                    <th scope="col" >Kump. Wang</th>
                                                    <th scope="col" >Kod Operasi</th>
                                                    <th scope="col" >Kod Projek</th>
                                                    <th scope="col" >Perkara</th>
                                                    <th scope="col">Petunjuk</th>
                                                    <th scope="col">Kuantiti</th>
                                                    <th scope="col">Harga Seunit (RM)</th>
                                                    <th scope="col">Cukai (%)</th>
                                                    <th scope="col">Diskaun (%)</th>
                                                    <th scope="col">Jumlah (RM)</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableID">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modal-footer--sticky">
                        <div class="form-group col-md-12" align="right">
                            <span><b>Jumlah (<span id="stickyJumlahItem"
                                        style="margin-right:5px">0</span> item) :RM <span id="stickyJumlah"
                                        style="margin-right:5px">0.00</span></b></span>
                            <button type="button" class="btn" id="showModalButton"><i class="fas fa-angle-up"></i></button>
                            <button type="button" class="btn btn-danger btnTidakLulus" style="display:none">Tidak Lulus</button>
                            <button type="button" class="btn btn-secondary btnLulus" data-toggle="tooltip" data-placement="bottom" title="Simpan">Simpan</button>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        </div>
        <!-- Confirmation Modal-->
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
                        Anda pasti ingin membuat pelarasan untuk rekod ini?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn default-primary btnYaLulus">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Confirmation Modal Tidak Lulus-->
        <div class="modal fade" id="confirmationModalxLulus" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabelxLulus" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabelxLulus">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Anda pasti untuk tidak meluluskan rekod ini?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn default-primary btnYaxLulus">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Makluman Modal-->
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
                        <button type="button" class="btn default-primary" id="tutupMakluman"
                            data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Jumlah Detail Sticky Modal -->
        <div class="modal fade" id="detailTotal" tabindex="-1" aria-labelledby="showDetails" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Jumlah Terperinci</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="" style="width: 100%; border: none">
                            <tr>
                                <td class="pr-2" style="text-align: right; font-size: medium;">Jumlah<br />
                                </td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="totalwoCukai" name="totalwoCukai"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>
        
                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: medium;">Jumlah
                                    Cukai</td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="TotalTax" name="TotalTax"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>
        
                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: medium;">Jumlah
                                    Diskaun</td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="TotalDiskaun" name="TotalDiskaun"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>
        
                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: large">JUMLAH (RM)
                                </td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="total" name="total"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </contenttemplate>
    <script>
        const showModalButton = document.getElementById('showModalButton');
        const detailTotalModal = new bootstrap.Modal(document.getElementById('detailTotal'));

        showModalButton.addEventListener('click', () => {
            detailTotalModal.show();
        });

        showModalButton.addEventListener('mouseenter', () => {
            const buttonRect = showModalButton.getBoundingClientRect();
            const modalDialog = detailTotalModal._dialog;

            // Position the modal above and to the left of the button with adjusted offsets
            const offsetLeft = 360; // Adjust this value to move the modal to the left
            const offsetBottom = -30; // Adjust this value to move the modal downwards
            modalDialog.style.position = 'fixed';
            modalDialog.style.left = buttonRect.left - offsetLeft + 'px'; // Subtract the offset
            modalDialog.style.bottom = window.innerHeight - buttonRect.top + offsetBottom + 'px'; // Add the offset

            detailTotalModal.show();
        });

        showModalButton.addEventListener('mouseleave', () => {
            detailTotalModal.hide();
        });
    </script>
    <script type="text/javascript">
        function ShowPopup(elm) {
            if (elm == "1") {
                $('#Senarai').modal('toggle');
            }
            else if (elm == "2") {
                $(".modal-body div").val("");
                $('#Senarai').modal('toggle');
            }
        }
        var tbl = null
        var isClicked = false;
        var pemiutangKeyCache = []
        var pemiutangValueCache = []
        
        $(document).ready(function () {

            tbl = $("#tblDataSenarai").DataTable({
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
                columnDefs: [
                    { targets: [7], className: 'text-right' },
                ],
                "ajax": {
                    "url": "PelarasanWS.asmx/LoadOrderRecord_SenaraiLulusInvois",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
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
                        rowClickHandler(data.No_Invois);
                    });
                },
                "drawCallback": function (settings) {
                    // Your function to be called after loading data
                    close_loader();
                },
                "columns": [
                    { "data": "No_Invois" },
                    { "data": "Nama_Penghutang" },
                    { "data": "TKHMOHON" },
                    { "data": "Tkh_Mula" },
                    { "data": "Tkh_Tamat" },
                    { "data": "UrusNiaga" },
                    { "data": "Tujuan" },
                    {
                        "data": "Jumlah",
                        render: function (data, type, row, meta) {
                            if (type !== "display") {

                                return data;

                            }
                            var Jumlah = data.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                            return Jumlah;
                        }
                    }
                ],
            });

            tblTransaksi = $("#tblData").DataTable({
                "responsive": true,
                "searching": false, ordering: true,
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
                "drawCallback": function (settings) {
                    // Your function to be called after loading data
                    close_loader();
                },
                "columns":
                    [
                        { data: 'Kod_Vot', },
                        { data: 'Kod_PTJ', },
                        { data: 'Kod_Kump_Wang', },
                        { data: 'Kod_Operasi', },
                        { data: 'Kod_Projek', },
                        { "data": "Perkara" },
                        {
                            "data": "Kuantiti",
                            "render": function (data, type, row) {
                                // Creating the select input with default options
                                var selectInput = '<select class="form-control petunjuk" style="width:60px">';

                                // Default options
                                var defaultOptions = [
                                    { value: '0', label: '' },
                                    { value: '1', label: '+' },
                                    { value: '2', label: '-' }
                                ];

                                // Additional options, if any
                                //var additionalOptions = getAdditionalOptions();

                                // Combine default and additional options
                                //var allOptions = defaultOptions.concat(additionalOptions);

                                defaultOptions.forEach(function (option) {
                                    selectInput += '<option value="' + option.value + '"';
                                    if (option.value === data) {
                                        selectInput += ' selected';
                                    }
                                    selectInput += '>' + option.label + '</option>';
                                });
                                selectInput += '</select>';

                                return selectInput;
                            }
                        },
                        {
                            "data": "Kuantiti",
                            render: function (data, type, row) {
                                return '<input type="text" class="form-control kuantiti" style="width:60px;text-align:center" value="' + data + '" maxlength="10">';
                            }
                        },
                        {
                            "data": "Kadar_Harga",
                            render: function (data, type, row) {
                                var kuantiti = parseFloat(row.Kuantiti) || 0;

                                // Calculate the total by multiplying Kadar_Harga with Kuantiti
                                var total = parseFloat(data) * kuantiti;

                                // Return the formatted total
                                return '<input type="text" class="form-control kadar_harga" style="width:100px;text-align:right" value="' + formatPrice(data) + '" maxlength="18"><span class="Kadar_Harga_Sebenar" style="display:none">' + formatPrice(total) + '</span>';
                            }
                        },
                        {
                            "data": "Cukai",
                            render: function (data, type, row) {
                                var kuantiti = parseFloat(row.Kuantiti) || 0;
                                var Kadar_Harga = parseFloat(row.Kadar_Harga) || 0;
                                var total = Kadar_Harga * kuantiti;
                                var total_cukai = parseFloat(data)/100 * total;
                                return '<input type="text" class="form-control cukai" style="width:80px;text-align:right" value="' + formatPrice(data) + '" maxlength="6"><span class="Jumlah_Cukai" style="display:none">' + formatPrice(total_cukai) + '</span>';
                            }
                        },
                        {
                            "data": "Diskaun",
                            render: function (data, type, row) {
                                var kuantiti = parseFloat(row.Kuantiti) || 0;
                                var Kadar_Harga = parseFloat(row.Kadar_Harga) || 0;
                                var total = Kadar_Harga * kuantiti;
                                var total_diskaun = parseFloat(data) / 100 * total;
                                return '<input type="text" class="form-control diskaun" style="width:80px;text-align:right" value="' + formatPrice(data) + '" maxlength="6"><span class="Jumlah_Diskaun" style="display:none">' + formatPrice(total_diskaun) + '</span>';
                            }
                        },
                        {
                            "data": "Jumlah",
                            "render": function (data, type, row) {
                                return '<span class="jumlah">' + formatPrice(data) + '</span>';
                            }
                        }
                    ],
                columnDefs: [
                    { targets: 0, width: '5%' },
                    { targets: 1, width: '5%' },
                    { targets: 2, width: '5%' },
                    { targets: 3, width: '5%' },
                    { targets: 4, width: '10%' },
                    { targets: 5, width: '15%' },
                    { targets: 6, width: '5%' },
                    { targets: 7, width: '4%' },
                    { targets: 8, width: '10%' },
                    { targets: 9, width: '5%' },
                    { targets: 10, width: '5%' },
                    { targets: 11, width: '10%' },
                    { targets: [8, 9, 10, 11], className: 'text-right' },
                    { targets: [7], className: 'text-center' }
                ],
                createdRow: function (row, data, dataIndex) {
                    row.dataset.noitem = data["No_Item"];
                    // $(row).find('.additional-info').hide();
                }

            });

            $('.btnSearch').click(async function () {
                show_loader();
                isClicked = true;
                tbl.ajax.reload();
            })

            $(tableID).on('keyup', '.kuantiti, .kadar_harga, .cukai, .diskaun', async function () {
                var curTR = $(this).closest("tr");
                var quantity = $(curTR).find("td > .kuantiti");

                var price = $(curTR).find("td > .kadar_harga");
                console.log(price.val())
                var amount = $(curTR).find("td > .jumlah");
                console.log("amount", amount.val())
                var cukai = $(curTR).find("td > .cukai");
                console.log("cukai", cukai.val())
                var diskaun = $(curTR).find("td > .diskaun");
                console.log("diskaun", diskaun.val())
                var amountwocukai = $(curTR).find("td > .Kadar_Harga_Sebenar");
                var JUMcukai = $(curTR).find("td > .Jumlah_Cukai");
                var JUMdiskaun = $(curTR).find("td > .Jumlah_Diskaun");

                var totalPrice_ = NumDefault(quantity.val()) * NumDefault(price.val().replace(/,/g, ''))
                console.log("totalPrice", totalPrice)
                var amauncukai = NumDefault(cukai.val()) / 100
                console.log("amauncukai", amauncukai)
                var total_cukai = totalPrice_ * amauncukai
                //console.log("total_cukai", total_cukai)
                var amaundiskaun = NumDefault(diskaun.val()) / 100
                //console.log("amaundiskaun", amaundiskaun)
                var total_diskaun = totalPrice_ * amaundiskaun
                console.log("total_diskaun", total_diskaun)
                var amountxcukai = totalPrice_ - total_diskaun
                console.log("amountxcukai", amountxcukai)

                var totalPrice = totalPrice_ + total_cukai - total_diskaun
                amount.html(formatPrice(totalPrice));
                JUMcukai.html(total_cukai);
                JUMdiskaun.html(total_diskaun);
                amountwocukai.html(totalPrice_);
                calculateGrandTotal();

                //START BIL COUNT DATATABLE...
                var columnIndexToCount = 0; // Change this to the desired column index (0-based)
                var rowCount = 0;

                $("#tableID").find("tr").each(function () {
                    var cellValue = $(this).find("td:eq(" + columnIndexToCount + ")").text();

                    // Check if the cell has data
                    if (cellValue.trim() !== "") {
                        rowCount++;
                    }
                });

                totalItems = rowCount;

                $('#stickyJumlahItem').text(totalItems);
                //END BIL COUNT
                async function calculateGrandTotal() {
                    var grandTotal = $("#total");
                    var totalCukai_ = $("#TotalTax");
                    var totalDiskaun_ = $("#TotalDiskaun");
                    var totalwoCukai_ = $("#totalwoCukai");
                    var curTotal = 0;
                    var curCukai = 0;
                    var curDiskaun = 0;
                    var curwoCukai = 0;

                    $('.jumlah').each(function (index, obj) {
                        curTotal += parseFloat(NumDefault($(obj).html().replace(/,/g, '')));
                    });
                    $('.Jumlah_Cukai').each(function (index, obj) {
                        curCukai += parseFloat(NumDefault($(obj).html().replace(/,/g, '')));
                        console.log("curCukai", curCukai)
                    });

                    $('.Jumlah_Diskaun').each(function (index, obj) {
                        curDiskaun += parseFloat(NumDefault($(obj).html().replace(/,/g, '')));
                    });

                    $('.Kadar_Harga_Sebenar').each(function (index, obj) {
                        curwoCukai += parseFloat(NumDefault($(obj).html().replace(/,/g, '')));
                    });

                    //$("[id*=TotalCoreProd]").html(TotalCoreProd.toFixed(2));
                    totalCukai_.val(curCukai.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }));
                    totalDiskaun_.val(curDiskaun.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }));
                    totalwoCukai_.val(curwoCukai.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }));

                    curTotal = roundCurrency(curTotal);

                    grandTotal.val(curTotal.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }));

                    //STICKYJUMLAH
                    document.getElementById('stickyJumlah').textContent = curTotal.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                }
            });

            $(tableID).on('change', '.kadar_harga', async function () {
                $(this).val(parseFloat($(this).val()).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }));
            });
            $(tableID).on('change', '.cukai,.diskaun', async function () {
                $(this).val(parseFloat($(this).val()).toFixed(2));
            });
             
        });

        function roundCurrency(value) {
            const cents = Math.round((value - Math.floor(value)) * 100) / 100;
            let roundedValue;

            if (cents >= 1.01 && cents <= 1.02) {
                roundedValue = Math.floor(value);
            } else if (cents >= 1.03 && cents <= 1.04) {
                roundedValue = Math.floor(value) + 0.05;
            } else if (cents === 1.05) {
                roundedValue = value;
            } else if (cents >= 1.06 && cents <= 1.08) {
                roundedValue = Math.ceil(value) + 0.02;
            } else {
                roundedValue = Math.round(value * 20) / 20; // Default rounding to the nearest 0.05 if not in specified ranges
            }

            const difference = roundedValue - value;
            const differenceText = difference.toFixed(2);

            $('#rounding').val(differenceText);

            return roundedValue;
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

        var searchQuery = "";
        var oldSearchQuery = "";
        var curNumObject = 0;
        var tableID = "#tblData";
        var shouldPop = true;
        var totalID = "#total";
        var totalCukai = "#TotalTax";
        var totalDiskaun = "#TotalDiskaun";
        var totalwoCukai = "#totalwoCukai";
        var tableID_Senarai = "#tblDataSenarai";

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

        async function clearAllRows_senarai() {
            $(tableID_Senarai + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
        }

        $("#categoryFilter").change(function (e) {
            var selectedItem = $('#categoryFilter').val()
            if (selectedItem == "6" && selectedItem !== "") {
                $('#divDatePicker').addClass("d-flex").removeClass("d-none");
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
            }
            else {
                $('#divDatePicker').removeClass("d-flex").addClass("d-none");
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
            }
        });

        async function paparSenarai(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblDataSenarai');
            //alert("hai")
            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.length;

            }
            console.log(objOrder)

            while (counter <= totalClone) {

                var row = $('#tblDataSenarai tbody>tr:first').clone();
                row.attr("style", "");
                var val = "";

                $('#tblDataSenarai tbody').append(row);

                if (objOrder !== null && objOrder !== undefined) {

                    if (counter <= objOrder.length) {
                        await setValueToRow(row, objOrder[counter - 1]);
                    }
                }

                counter += 1;
            }
        }


        // add clickable event in DataTable row
        async function rowClickHandler(id) {
            event.preventDefault();

            if (id !== "") {
                // open modal
                $('#Senarai').modal('toggle');
                show_loader()
                let invHdr = await getInvoisHdr(id)
                close_loader()

                //BACA HEADER JURNAL
                //var recordHdr = await AjaxGetRecordHdrJurnal(id);
                /*await AddRowHeader(null, recordHdr);*/

                //BACA DETAIL JURNAL
                //var record = await AjaxGetRecordJurnal(id);
                //await clearAllRows();
                //await AddRow(null, record);
            }
        }
        function getInvoisHdr(ID_Rujukan) {
            return new Promise(function (resolve, reject) {
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/AKAUN PENERIMA/Invois/SenaraiKelulusanWS.asmx/getFullInvoisData") %>',
                    method: "POST",
                    data: JSON.stringify({
                        ID_Rujukan: ID_Rujukan

                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: async function (data) {
                        data = JSON.parse(data.d)
                        data = data.Payload
                        fillInvoisHdr(data.hdr[0])

                        //grand totals
                        let gJumplahPB = 0
                        let gJumlahDiskaun = 0
                        let gJumlahCukai = 0
                        let gJumlahRaw = 0
                        console.log(data.dtl)
                        if (data.dtl) {

                            let arrvot = []
                            //let arrpm = []
                            data.dtl.forEach(dtl => {
                                arrvot.push(dtl.Kod_Vot)
                                //arrpm.push(dtl.Kod_Pemiutang)
                            })
                            cacheKodPair = []
                            data.dtl.forEach(dtl => {


                                let jumlah_raw = readInt(dtl.Kadar_Harga) * readInt(dtl.Kuantiti)
                                let jumlah_cukai = readInt(dtl.Cukai) / 100 * jumlah_raw
                                let jumlah_diskaun = readInt(dtl.Diskaun) / 100 * jumlah_raw
                                let Jumlah_Perlu_Bayar = jumlah_raw + jumlah_cukai - jumlah_diskaun
                                dtl.Jumlah = to2Decimal(Jumlah_Perlu_Bayar)
                                saveKodPair(dtl.Kod_Kump_Wang, dtl.Kod_Operasi, dtl.Kod_Projek, dtl.Jumlah)
                                gJumlahRaw += jumlah_raw
                                gJumplahPB += Jumlah_Perlu_Bayar
                                gJumlahDiskaun += jumlah_diskaun
                                gJumlahCukai += jumlah_cukai
                                dtl.Kadar_Harga = to2Decimal(dtl.Kadar_Harga)

                            })
                            $("#TotalTax").val(formatPrice(gJumlahCukai))
                            $("#totalwoCukai").val(formatPrice(gJumlahRaw))
                            $("#TotalDiskaun").val(formatPrice(gJumlahDiskaun))
                            $("#total").val(formatPrice(gJumplahPB))

                            $("#stickyJumlah").html(formatPrice(gJumplahPB))
                            $("#stickyJumlahItem").html(data.dtl.length)

                        }
                        tblTransaksi.clear()
                        tblTransaksi.rows.add(data.dtl).draw()



                        //let kreditDtl = []
                        //let defVot = cachepilihanVot[0]
                        //selectedVot = defVot.Kod_Vot
                        //let hcptj = "500000" //hardcode, mana nk dpt kalau dari table vot bole skalikn dlm query pilihan
                        //console.log("cache pair")
                        //console.log(cacheKodPair)
                        //cacheKodPair.forEach(kp => {
                        //    let vtinfo = getCOAVot(defVot.Kod_Vot, hcptj, kp.Kod_Kump_Wang, kp.Kod_Projek, kp.Kod_Operasi)

                        //    kreditDtl.push({
                        //        Kod_Pemiutang: '',
                        //        Kod_Vot: defVot.Kod_Vot,
                        //        Kod_PTJ: hcptj,
                        //        Kod_Kump_Wang: kp.Kod_Kump_Wang,
                        //        Kod_Operasi: kp.Kod_Operasi,
                        //        Kod_Projek: kp.Kod_Projek,
                        //        credit: true,
                        //        Jumlah_Perlu_Bayar: kp.Jumlah_Perlu_Bayar,
                        //        VOTINFO: vtinfo

                        //    })
                        //})
                        //let datalejar = data.dtl
                        //datalejar.push(...kreditDtl)
                        //$("#lejarTC").html(formatPrice(gJumplahPB))
                        //$("#lejarTD").html(formatPrice(gJumplahPB))
                        ////  datalejar.push(datalast)
                        //// datalejar.push(datafooter)
                        //tblLejar.clear()
                        //tblLejar.rows.add(datalejar).draw()


                        //resolve(true)
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                        reject(false)
                    }
                })
            })
        }
        var cacheInvois = null
        function fillInvoisHdr(inv) {
            cacheInvois = inv
            //let arrpm = []
            //arrpm.push(dtl.Kod_Pemiutang)
            searchPemiutang(inv.Kod_Penghutang)
            $("#txtnoinv").val(inv.No_Bil)
            $("#txtNamaPenghutang").val(inv.Nama_Penghutang);
            $("#tkhMula").val(dateStrFromSQl(inv.Tkh_Mula))
            $("#tkhTamat").val(dateStrFromSQl(inv.Tkh_Mula))
            if (inv.Kontrak == '0') {
                $(':radio[name=inlineRadioOptions][value="0"]').prop('checked', true);
                $(':radio[name=inlineRadioOptions][value="1"]').prop('checked', false);
            } else {
                $(':radio[name=inlineRadioOptions][value="1"]').prop('checked', true);
                $(':radio[name=inlineRadioOptions][value="0"]').prop('checked', false);
            }
            $("#txtUrusniaga").val(inv.Butiran)
            $("#txtTujuan").val(inv.Tujuan)
            $("#tkhBil").val(dateStrFromSQl(inv.Tkh_Mohon))
            $("#Tempoh").val(inv.Tempoh_Kontrak)
            $("#JnsTempoh").val(inv.JNSTEMPOH)
            $("#NoRujukan").val(inv.No_Rujukan)

        }
        function getPemiutang(kod) {
            console.log(pemiutangValueCache)
            return pemiutangValueCache.filter(item =>
                item.Kod_Penghutang === kod
            )[0]
        }

        function searchPemiutang(arrKod) {
            console.log("hello")
            //kod vot yang belum search je
            return loadPemiutang(arrKod)
        }

        function loadPemiutang(arrKod) {
            return new Promise(function (resolve, reject) {
                if (arrKod.length > 0) {
                    $.ajax({
                        url: '<%= ResolveUrl("~/FORMS/AKAUN PENERIMA/Bil_WS.asmx/getSpecificPenghutang") %>',
                        method: "POST",
                        data: JSON.stringify({ Kod: arrKod }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            if (data.d) {
                                data = JSON.parse(data.d)
                                data.forEach(d => {
                                    let butiranAlamat = d.Butiran_Kod_Alamat
                                    try {
                                        d.Negeri_Detail = butiranAlamat.split('|')[1].split('--')[1]
                                        d.Bandar_Detail = butiranAlamat.split('|')[2].split('--')[1]
                                        d.Negara_Detail = butiranAlamat.split('|')[0].split('--')[1]

                                    }
                                    catch (e) {

                                    }

                                })

                                pemiutangValueCache.push(...data)
                                pemiutangKeyCache.push(...arrKod)
                            }
                            resolve(true)

                        },
                        error: function (xhr, status, error) {
                            console.error(error);
                            reject()
                        }
                    })

                }
                else {
                    resolve(true)
                }
            })
        }
        function dateStrFromSQl(dateString) {
            try {

                var dateComponents = dateString.split("T")[0].split("-");
                var year = dateComponents[0];
                var month = dateComponents[1];
                var day = dateComponents[2];

                return formattedDate = day + "/" + month + "/" + year;
            }
            catch (e) {
                return ''
            }
        }
        function saveKodPair(kw, ko, kp, val) {
            //kod vot yang belum search je
            //filter return yg sama, kalau sama ==0 then belum ada so add

            let found = false
            cacheKodPair.forEach(vp => {
                if (
                    vp.Kod_Kump_Wang === kw &&
                    vp.Kod_Operasi === ko &&
                    vp.Kod_Projek === kp
                ) {

                    vp.Jumlah_Perlu_Bayar += parseFloat(val)
                    found = true
                } else {

                }
            })
            if (!found)
                cacheKodPair.push(newKodPair(kw, ko, kp, parseFloat(val)))
        }
        function newKodPair(kw, ko, kp, val) {
            return {
                Kod_Kump_Wang: kw,
                Kod_Operasi: ko,
                Kod_Projek: kp,
                Jumlah_Perlu_Bayar: val
            }
        }
        $('.btnLulus').click(async function () {
            // check every required field
            //if ($('#ddlKategoriPenghutang').val() == "" || $('#ddlUrusniaga').val() == "" || $('#ddlPenghutang').val() == "" || $("input[name='inlineRadioOptions']:checked").val() == "" || $('#txtTujuan').val() == "") {
            // open modal makluman and show message
            //$('#maklumanModalBil').modal('toggle');
            //$('#detailMaklumanBil').html("Sila isi semua ruangan yang bertanda *");
            //} else {
            // open modal confirmation
            $('#confirmationModal').modal('toggle');
            //}
        })

        $('.btnYaLulus').click(async function () {

            //close modal confirmation
            $('#confirmationModal').modal('toggle');


            msg = "Anda pasti ingin meluluskan rekod ini?"

            
            let fulldata = cacheInvois
            let jumlah = 0; 
            let jumlah_cukai = 0; 
            let jumlah_diskaun = 0; 
            try {
                // Your code here
                tblTransaksi.rows().every(function () {
                    // Get the row data
                    var rowdata = this.data();

                    // Update the 'kuantiti' property of the rowdata with the value of the input field
                    rowdata.Kuantiti = $(".kuantiti", this.node()).val();
                    rowdata.Kadar_Harga = $(".kadar_harga", this.node()).val();
                    rowdata.Cukai = $(".cukai", this.node()).val();
                    rowdata.Diskaun = $(".diskaun", this.node()).val();
                    rowdata.Jumlah = $(".jumlah", this.node()).text().replace(/,/g, '');
                    rowdata.Petunjuk = $(".petunjuk", this.node()).val();
                    petunjuk = rowdata.Petunjuk
                    if (petunjuk != "0") {
                        if (petunjuk == "1") {
                            rowdata.Petunjuk = "+"
                        }else{
                            rowdata.Petunjuk = "-"
                        }
                    }
                    jumlah += parseFloat(NumDefault(rowdata.Jumlah.replace(/,/g, '')));
                    jumlah_cukai += parseFloat(NumDefault(rowdata.Cukai.replace(/,/g, '')));
                    jumlah_diskaun += parseFloat(NumDefault(rowdata.Diskaun.replace(/,/g, '')));
                });
                //console.log(jumlah)
                if (petunjuk != "0") {
                    if (petunjuk == "1") {
                        fulldata.Petunjuk = "ND"
                        fulldata.Jumlah_Besar = parseFloat((NumDefault(fulldata.Jumlah)) + parseFloat(NumDefault(jumlah)));
                    } else {
                        fulldata.Petunjuk = "NK"
                        fulldata.Jumlah_Besar = parseFloat((NumDefault(fulldata.Jumlah)) - parseFloat(NumDefault(jumlah)));
                    }
                }
                fulldata.Jumlah_Cukai = jumlah_cukai;
                fulldata.Jumlah_Diskaun = jumlah_diskaun;
                var tblTransaksiData = tblTransaksi.data().toArray();
                fulldata.details = tblTransaksiData;
                console.log(fulldata);
            } catch (error) {
                console.error("An error occurred:", error);
            }

            let res = await ajaxSaveOrder(fulldata).catch(function (err) {
                console.log(err)
            })
            //console.log(res)
            if (!res) {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Transaksi Tidak Berjaya.");
            } else {
                $('#maklumanModal').modal('toggle');
                $('#Senarai').modal('toggle');
                $('#detailMakluman').html("Transaksi berjaya.");
                $("#btnSearch").click()
                
                setTimeout(function () {
                    window.location.reload();
                }, 2000);
            }

        });

        async function ajaxSaveOrder(order) {
            return new Promise(function (resolve, reject) {
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/AKAUN PENERIMA/Pelarasan Nota Debit Nota Kredit/PelarasanWS.asmx/SaveMohon") %>',
                    method: "POST",
                    data: JSON.stringify({
                        "order": order
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        var jsondata = JSON.parse(data.d)
                        if (jsondata.Code == "200") {
                            //toggleEdit(false)
                            //clearForm()
                            resolve(true)
                        }
                        else {
                            reject(jsondata.Message)
                        }
                    }
                })
            })
        }

        async function ajaxRejectOrder(id) {

            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SenaraiKelulusanWS.asmx/RejectLulus',
                    method: 'POST',
                    data: JSON.stringify(id),
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
            //console.log("tst")
        }

    </script>
</asp:Content>


