<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Permohonan_Viremen.aspx.vb" Inherits="SMKB_Web_Portal.Permohonan_Viremen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
        .tabcontent {
            padding: 0px 20px 20px 20px !important;
        }

        .table-title {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        .custom-table > tbody > tr:hover {
            background-color: #ffc83d !important;
        }

          #tblDataSenarai_trans td:hover {
            cursor: pointer;
        }


        .default-primary {
            background-color: #007bff !important;
            color: white;
        }


        /*start sticky table tbody tfoot*/
        table {
            overflow: scroll;
            border-collapse: collapse;
            color: white;
        }

        .secondaryContainer {
            overflow: scroll;
            border-collapse: collapse;
            height: 500px;
            border-radius: 10px;
        }

        .sticky-footer {
            position: sticky;
            bottom: 0;
            background-color: white;
            z-index: 2;
        }

            .sticky-footer th,
            .sticky-footer td {
                text-align: center; /* Center-align the content in footer cells */
                border-top: 1px solid #ddd; /* Add a border at the top to separate from data rows */
                padding: 10px; /* Adjust padding as needed */
            }

        #showModalButton:hover {
            background-color: #ffc107; /* Change background color on hover */
            color: #fff; /* Change text color on hover */
            border-color: #ffc107; /* Change border color on hover */
            cursor: pointer; /* Change cursor to indicate interactivity */
        }

        /*input CSS */
        .input-group {
            margin-bottom: 20px;
            position: relative;
        }

        .input-group__label {
            font-size: 12PX;
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
            line-height: 10px;
            color: #01080D;
            opacity: 1;
        }
    </style>



    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
        <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Papar Permohonan Viremen</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
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

                                        <div class="input-group-append">
                                            <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button">
                                                <i class="fa fa-search"></i>
                                                Cari
                                            </button>
                                        </div>
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
                                    <div class="form-row">
                                        <div class="form-group col-md-1">
                                            <label id="lblMula" style="text-align: right; display: none;">Mula: </label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display: none;" class="form-control date-range-filter">
                                        </div>
                                        <div class="form-group col-md-1">
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label id="lblTamat" style="text-align: right; display: none;">Tamat: </label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display: none;" class="form-control date-range-filter">
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
  

                    <div class="modal-body">

                        <div class="transaction-table table-responsive">
                            <div class="col-md-12">
                                <table id="tblDataSenarai_trans" class="table table-striped" style="width: 95%" >
                                    <thead>
                                        <tr>
                                            <th scope="col" colspan="8" style="text-align:center">Viremen Keluar</th>
                                            <th scope="col" colspan="6" style="text-align:center">Viremen Masuk</th>
                                        </tr>
                                        <tr>
                                            
                                            <th scope="col">No. Viremen</th>
                                            <th scope="col">Ruj. Surat Mohon</th>
                                            <th scope="col">Kumpulan Wang</th>
                                            <th scope="col">Operasi</th>
                                            <th scope="col">Projek</th>
                                            <th scope="col">PTj</th>
                                            <th scope="col">Vot</th>
                                            <th scope="col">Amaun (RM)</th>
                                            <th scope="col">Baki Semasa (RM)</th>
                                            <th scope="col">Kumpulan Wang</th>
                                            <th scope="col">Operasi</th>
                                            <th scope="col">Projek</th>
                                            <th scope="col">PTj</th>
                                            <th scope="col">Vot</th>
                                            <th scope="col">Amaun (RM)</th>
                                            <th scope="col">Baki Semasa (RM)</th>

                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans">
                                    </tbody>

                                </table>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-body">
            <div class="table-title">
                <h5>Permohonan Viremen</h5>
                <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                    Senarai Permohonan Viremen  
                </div>

            </div>

            <hr>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="lblNoViremen" type="text" placeholder="&nbsp;" name="No. Viremen" readonly style="background-color: #f0f0f0"/>
                            <label class="input-group__label" for="No. Viremen">No. Viremen</label>
                        </div>
                        <div class="form-group col-md-9">
                            <input class="input-group__input" id="lblTujuan" type="text" placeholder="&nbsp;" name="No. Mohon" />
                            <label class="input-group__label" for="Tujuan">Tujuan</label>
                        </div>

                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <input class="input-group__input" id="lblRujukan" type="text" placeholder="&nbsp;" name="Rujukan Surat Mohon" />
                            <label class="input-group__label" for="Rujukan Surat Mohon">Rujukan Surat Mohon</label>
                        </div>
                        <div class="form-group col-md-6">
                            <input class="input-group__input" style="width: 20%; text-align: right;" id="lblJumlah" name="lblJumlah" type="number" placeholder="&nbsp;" name="Jumlah Viremen (RM)" value="0.00" />
                            <label class="input-group__label" for="Jumlah Viremen  (RM)">Jumlah Viremen  (RM)</label>
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label><u>Daripada</u></label>
                        </div>
                        <div>
                            <label><u>Kepada</u></label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <select class="ui search dropdown input-group__input" name="ddlCOA_Drpd" id="ddlCOA_Drpd"></select>
                            <label class="input-group__label" for="ddlCOA_Drpd">Daripada COA</label>
                        </div>

                        <div class="form-group col-md-6">
                            <select class="ui search dropdown input-group__input" name="ddlCOA_Kpd" id="ddlCOA_Kpd"></select>
                            <label class="input-group__label" for="ddlCOA_Kpd">Kepada COA</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <input class="input-group__input" id="txtKW_Drpd" type="text" placeholder="&nbsp;" name="Kumpulan Wang" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Kumpulan Wangt">Kumpulan Wang</label>
                        </div>
                        <div class="form-group col-md-6">
                            <input class="input-group__input" id="txtKW_Kpd" type="text" placeholder="&nbsp;" name="Kumpulan Wang" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Kumpulan Wang">Kumpulan Wang</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtKO_Drpd" type="text" placeholder="&nbsp;" name="Operasi / Komited" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Operasi / Komited">Operasi / Komited</label>
                        </div>
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtKP_Drpd" type="text" placeholder="&nbsp;" name="Projek" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Projek">Projek</label>
                        </div>
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtKO_Kpd" type="text" placeholder="&nbsp;" name="Operasi / Komited" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Operasi / Komited">Operasi / Komited</label>
                        </div>
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtKP_Kpd" type="text" placeholder="&nbsp;" name="Projek" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Projek">Projek</label>
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <input class="input-group__input" id="txtPtj_Drpd" type="text" placeholder="&nbsp;" name="Jabatan/Fakulti" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Jabatan/Fakulti">Jabatan/Fakulti</label>
                        </div>
                        <div class="form-group col-md-6">
                            <input class="input-group__input" id="txtPtj_Kpd" type="text" placeholder="&nbsp;" name="Jabatan/Fakulti" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Jabatan/Fakulti">Jabatan/Fakulti</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <input class="input-group__input" id="txtVot_Drpd" type="text" placeholder="&nbsp;" name="Objek Sebagai" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Objek Sebagai">Objek Sebagai</label>
                        </div>
                        <div class="form-group col-md-6">
                            <input class="input-group__input" id="txtVot_Kpd" type="text" placeholder="&nbsp;" name="Objek Sebagai" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Objek Sebagai">Objek Sebagai</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12" style="visibility: visible">
                    <div class="form-row">
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtBakiSemasa_Drpd" type="text" placeholder="&nbsp;" name="Baki Semasa (RM)" readonly  style="background-color: #f0f0f0; text-align: right;" />
                            <label class="input-group__label" for="Baki Semasa (RM)">Baki Semasa (RM)</label>
                        </div>
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtBakiSlpsVire_Drpd" type="text" placeholder="&nbsp;" name="Baki Selepas Viremen (RM)" readonly style="background-color: #f0f0f0 ; text-align: right;" />
                            <label class="input-group__label" for="Baki Selepas Viremen (RM)">Baki Selepas Viremen (RM)</label>
                        </div>
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtBakiSemasa_Kpd" type="text" placeholder="&nbsp;" name="Baki Semasa (RM)" readonly style="background-color: #f0f0f0 ; text-align: right;" />
                            <label class="input-group__label" for="Baki Semasa (RM)">Baki Semasa (RM)</label>
                        </div>

                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtBakiSlpsVire_Kpd" type="text" placeholder="&nbsp;" name="Baki Selepas Viremen (RM)" readonly style="background-color: #f0f0f0 ; text-align: right;" />
                            <label class="input-group__label" for="Baki Selepas Viremen (RM)">Baki Selepas Viremen (RM)</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="sticky-footer">
            <br />
            <div class="form-row">
                <div class="form-group col-md-12">

                    <div class="float-right">
                        <button type="button" class="btn btn-setsemula btnSet">Rekod Baru</button>
                        <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Simpan Draft">Simpan</button>
                        <button type="button" class="btn btn-success btnHantar" data-toggle="tooltip" data-placement="bottom" title="Simpan dan Hantar">Hantar</button>
                    </div>


                </div>
            </div>
        </div>


        <!-- Confirmation Modal  -->
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
                        <button type="button" class="btn default-primary btnYa" runat="server">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Confirmation Modal Hantar  -->
        <div class="modal fade" id="confirmationModal_Hantar" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabelHantar" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabel_Hantar">Pengesahan</h5>
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
                        <button id="EmailJurnal3" runat="server" type="button" class="btn default-primary btnYa_Hantar">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Makluman Modal Bil -->
        <div class="modal fade" id="maklumanModalBil" tabindex="-1" role="dialog"
            aria-labelledby="maklumanModalLabelBil" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="maklumanModalLabelBil">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span id="detailMaklumanBil"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn default-primary" id="tutupMaklumanBil"
                            data-dismiss="modal">
                            Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Makluman Modal Bil -->
        <div class="modal fade" id="maklumanModalBil_Hantar" tabindex="-1" role="dialog"
            aria-labelledby="maklumanModalLabelBil_Hantar" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="maklumanModalLabelBil_Hantar">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span id="detailMaklumanBil_Hantar"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn default-primary" id="tutupMaklumanBil_Hantar"
                            data-dismiss="modal">
                            Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Message Box -->
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Tolong Sahkan?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Adakah anda pasti mahu menambah modul?
                               
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" data-toggle="modal"
                            data-target="#ModulForm" data-dismiss="modal">
                            Ya</button>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <script type="text/javascript">


        function ShowPopup(elm) {
          
            if (elm == "1") {

                $('#permohonan').modal('toggle');

            }
            else if (elm == "2") {

                $(".modal-body div").val("");
                $('#permohonan').modal('toggle');

            }
        }


        var tbl = null
        var isClicked = false;

        $(document).ready(function () {
            $("#lblJumlah").keyup(function () {
               // console.log("a");

                //var curTR = $(this).closest("tr");

                //var debit_ = $(curTR).find("td > .Debit");
                //var kredit_ = $(curTR).find("td > .Kredit"); // Added missing line to select the Kredit element

                //var totalDebit = NumDefault(debit_.val());
                //var totalKredit = NumDefault(kredit_.val());

                // Perform SQL-related operations or any other logic with totalDebit and totalKredit here

            });
        });


        $(document).ready(function () {

            tbl = $("#tblDataSenarai_trans").DataTable({
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
                    "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax": {
                    "url": "ViremenWS.asmx/LoadOrderRecord_SenaraiTransaksiViremen",
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
                        rowClickHandler(data.No_Viremen);

                    });
                },
                "columns": [
                    {
                        "data": "No_Viremen",
                        render: function (data, type, row, meta) {

                            if (type !== "display") {
                                return data;
                            }

                            var link = `<td style="width: 10%" >
                                                <label id="lblNo" name="lblNo" class="lblNo" value="${data}" >${data}</label>
                                                <input type ="hidden" class = "lblNo" value="${data}"/>
                                            </td>`;
                            return link;
                        }
                    },
                    { "data": "Ruj_Surat" },
                    { "data": "kw_K" },
                    { "data": "ko_K" },
                    { "data": "kp_K" },
                    { "data": "ptj_K" },
                    { "data": "vot_K" },
                    { "data": "Amaun" },
                    { "data": "bakisms_K" },
                    { "data": "kw_M" },
                    { "data": "ko_M" },
                    { "data": "kp_M" },
                    { "data": "ptj_M" },
                    { "data": "vot_M" },
                    { "data": "Amaun" },
                    { "data": "bakisms_M" }



                ]

            });


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
        });

        $('.btnPapar').click(async function () {
            tbl.ajax.reload();
        });


        var searchQuery = "";
        var oldSearchQuery = "";
        var curNumObject = 0;
        var tableID = "#tblData";
        var tableID_Senarai = "#tblDataSenarai_trans";
        var shouldPop = true;
        var totalID = "#totalBeza";

        var totalDebit = "#totalDbt";
        var totalKredit = "#totalKt";

        var totalJumlah = "#totalJumlah";

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




        $('.btnSearch').click(async function () {
            // show_loader();
            isClicked = true;
            tbl.ajax.reload();
            //close_loader();

        })

        //$(document).ready(function () {
        //    // alert("test")
        //    $('#categoryFilter').dropdown({
        //        fullTextSearch: false,
        //        apiSettings: {
        //            url: 'Transaksi_WS.asmx/GetJenisStatus?q={query}',
        //            method: 'POST',
        //            dataType: "json",
        //            contentType: 'application/json; charset=utf-8',
        //            cache: false,
        //            beforeSend: function (settings) {
        //                // Replace {query} placeholder in data with user-entered search term
        //                settings.data = JSON.stringify({ q: settings.urlData.query });
        //                searchQuery = settings.urlData.query;
        //                return settings;
        //            },
        //            onSuccess: function (response) {
        //                // Clear existing dropdown options
        //                var obj = $(this);

        //                var objItem = $(this).find('.menu');
        //                $(objItem).html('');

        //                // Add new options to dropdown
        //                if (response.d.length === 0) {
        //                    $(obj.dropdown("clear"));
        //                    return false;
        //                }

        //                var listOptions = JSON.parse(response.d);

        //                $.each(listOptions, function (index, option) {
        //                    $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
        //                });

        //                //if (searchQuery !== oldSearchQuery) {
        //                // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
        //                //}

        //                //oldSearchQuery = searchQuery;

        //                // Refresh dropdown
        //                $(obj).dropdown('refresh');

        //                if (shouldPop === true) {
        //                    $(obj).dropdown('show');
        //                }
        //            }
        //        }
        //    });
        //});
        $(function () {
            $('.btnAddRow.five').click();
        });

        $('.btnHantar').click(async function () {
            // console.log("test")
            $('#confirmationModal_Hantar').modal('toggle');




        });

        $('.btnYa_Hantar').click(async function () {

            $('#confirmationModal_Hantar').modal('toggle');

            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
            var newOrder = {
                order: {

                    OrderID: $('#lblNoViremen').val(),
                    Tujuan: $('#lblTujuan').val(),
                    Rujukan: $('#lblRujukan').val(),
                    Jumlah: $('#lblJumlah').val(),

                    KW_Drpd: $('#txtKW_Drpd').val(),
                    KO_Drpd: $('#txtKO_Drpd').val(),
                    KP_Drpd: $('#txtKP_Drpd').val(),
                    Ptj_Drpd: $('#txtPtj_Drpd').val(),
                    Vot_Drpd: $('#txtVot_Drpd').val(),

                    KW_Kpd: $('#txtKW_Kpd').val(),
                    KO_Kpd: $('#txtKO_Kpd').val(),
                    KP_Kpd: $('#txtKP_Kpd').val(),
                    Ptj_Kpd: $('#txtPtj_Kpd').val(),
                    Vot_Kpd: $('#txtVot_Kpd').val()
                }

            }


            var result = JSON.parse(await ajaxSaveOrder_Hantar(newOrder));

            if (result.Status !== "Failed") {
                //$('#modalPenghutang').modal('toggle');
                // open modal makluman and show message
                $('#maklumanModalBil_Hantar').modal('toggle');
                $('#detailMaklumanBil_Hantar').html(result.Message);
                //clearAllFields();


                // refresh page after 2 seconds


                setTimeout(function () {
                    tbl.ajax.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModalBil_Hantar').modal('toggle');
                $('#detailMaklumanBil_Hantar').html(result.Message);


            }



        });

        $('.btnSet').click(async function () {
            //$('#lblNoJurnal').val("");
            //$('#ddlJenTransaksi').dropdown('clear');
            //$('#ddlJenTransaksi').dropdown('refresh');
            clearVire()
            //await clearAllRows();
            //await clearAllRowsHdr();
            //await clearHiddenButton();
            //AddRow(5);
        })



        $('.btnSimpan').click(async function () {

            $('#confirmationModal').modal('toggle');

        })

        $('.btnYa').click(async function () {

            $('#confirmationModal').modal('toggle');

            if ($('#txtBakiSlpsVire_Drpd').val().replace(/,/g, '') > 0) {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                var newOrder = {
                    order: {
                        OrderID: $('#lblNoViremen').val(),
                        Tujuan: $('#lblTujuan').val(),
                        Rujukan: $('#lblRujukan').val(),
                        Jumlah: $('#lblJumlah').val(),

                        KW_Drpd: $('#txtKW_Drpd').val(),
                        KO_Drpd: $('#txtKO_Drpd').val(),
                        KP_Drpd: $('#txtKP_Drpd').val(),
                        Ptj_Drpd: $('#txtPtj_Drpd').val(),
                        Vot_Drpd: $('#txtVot_Drpd').val(),
                        BakiSemasa_Drpd: $('#txtBakiSemasa_Drpd').val().replace(/,/g, ''),
                        BakiSlpsVire_Drpd: $('#txtBakiSlpsVire_Drpd').val().replace(/,/g, ''),

                        KW_Kpd: $('#txtKW_Kpd').val(),
                        KO_Kpd: $('#txtKO_Kpd').val(),
                        KP_Kpd: $('#txtKP_Kpd').val(),
                        Ptj_Kpd: $('#txtPtj_Kpd').val(),
                        Vot_Kpd: $('#txtVot_Kpd').val(),
                        BakiSemasa_Kpd: $('#txtBakiSemasa_Kpd').val().replace(/,/g, ''),
                        BakiSlpsVire_Kpd: $('#txtBakiSlpsVire_Kpd').val().replace(/,/g, '')
                    }

                }


                var result = JSON.parse(await ajaxSaveOrder(newOrder));


                if (result.Status !== "Failed") {
                    //$('#modalPenghutang').modal('toggle');
                    // open modal makluman and show message
                    $('#maklumanModalBil').modal('toggle');
                    $('#detailMaklumanBil').html(result.Message);
                    //clearAllFields();

                    clearVire()
                    // refresh page after 2 seconds

                    setTimeout(function () {
                        tbl.ajax.reload();
                    }, 2000);
                } else {
                    // open modal makluman and show message
                    $('#maklumanModalBil').modal('toggle');
                    $('#detailMaklumanBil').html(result.Message);



                }

            }
            else {
                $('#ddlCOA_Drpd').dropdown('clear'),
                    $('#ddlCOA_Drpd').dropdown('refresh'),
                    $('#txtKW_Drpd').val(""),
                    $('#txtKO_Drpd').val(""),
                    $('#txtKP_Drpd').val(""),
                    $('#txtPtj_Drpd').val(""),
                    $('#txtVot_Drpd').val(""),
                    $('#txtBakiSemasa_Drpd').val(""),
                    $('#txtBakiSlpsVire_Drpd').val("")

                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html("Maaf baki tidak mencukupi. Permohonan tidak berjaya disimpan.");

            }

            })
            

        ;



        $('.btnLoad').on('click', async function () {
            loadExistingRecords();
        });

        async function loadExistingRecords() {
            var record = await AjaxLoadOrderRecord($('#lblNoMohon').val());
            await clearAllRows();
            await AddRow(null, record);
        }

        async function clearAllRows() {
            $(tableID + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
            $(totalJumlah).val("0.00");

        }

        async function clearVire() {

                $('#ddlCOA_Drpd').dropdown('clear'),
                $('#ddlCOA_Drpd').dropdown('refresh'),

                $('#ddlCOA_Kpd').dropdown('clear'),
                $('#ddlCOA_Kpd').dropdown('refresh'),
                $('#lblNoViremen').val(""),

                $('#lblTujuan').val(""),
                $('#lblRujukan').val(""),
                $('#lblJumlah').val(""),

                $('#txtKW_Drpd').val(""),
                $('#txtKO_Drpd').val(""),
                $('#txtKP_Drpd').val(""),
                $('#txtPtj_Drpd').val(""),
                $('#txtVot_Drpd').val(""),
                $('#txtBakiSemasa_Drpd').val(""),
                $('#txtBakiSlpsVire_Drpd').val(""),

                $('#txtKW_Kpd').val(""),
                $('#txtKO_Kpd').val(""),
                $('#txtKP_Kpd').val(""),
                $('#txtPtj_Kpd').val(""),
                $('#txtVot_Kpd').val("")
            $('#txtBakiSemasa_Kpd').val(""),
                $('#txtBakiSlpsVire_Kpd').val("")

        }

        async function clearAllRowsHdr() {

            $('#lblNoMohon').val("");
            $('#ddlBahagian').dropdown('clear');
            $('#ddlBahagian').dropdown('refresh');

            $('#ddlUnit').dropdown('clear');
            $('#ddlUnit').dropdown('refresh')

            $('#ddlPTJPusat').dropdown('clear');
            $('#ddlPTJPusat').dropdown('refresh')

            $('#ddlDasar').dropdown('clear');
            $('#ddlDasar').dropdown('refresh')

            $('#ddlKW').dropdown('clear');
            $('#ddlKW').dropdown('refresh')

            $('#ddlKO').dropdown('clear');
            $('#ddlKO').dropdown('refresh')

            $('#ddlKP').dropdown('clear');
            $('#ddlKP').dropdown('refresh')
                ;
            $('#txtProgram').val("");
            $('#txtJustifikasi').val("");
            $('#txtPerihal').val("");


        }

        async function clearHiddenButton() {

            $('.btnSimpan').show();
            $('.btnHantar').show();
            $('.btnAddRow').show();

        }

        async function clearAllRows_senarai() {
            $(tableID_Senarai + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
        }

        $(tableID).on('click', '.btnDelete', async function () {
            event.preventDefault();
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .data-id");
            var bool = true;
            var id = setDefault(recordID.val());

            if (id !== "") {
                bool = await DelRecord(id);
            }

            if (bool === true) {
                curTR.remove();
            }

            calculateGrandTotal();
            return false;
        })

        async function ajaxSubmitOrder(order) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Transaksi_WS.asmx/SubmitOrders',
                    method: 'POST',
                    data: JSON.stringify(order),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        //alert(resolve(data.d));
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                });
            })

        }

        async function ajaxSaveOrder(order) {
            //console.log(order)
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'ViremenWS.asmx/SaveOrders_Viremen',
                    method: 'POST',
                    data: JSON.stringify(order),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        //alert(resolve(data.d));
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                });
            })

        }

        async function ajaxSaveOrder_Hantar(order) {
            //console.log(order)
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'ViremenWS.asmx/HantarPermohonan_MohonViremen',
                    method: 'POST',
                    data: JSON.stringify(order),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        //alert(resolve(data.d));
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                });
            })

        }

        async function ajaxDeleteOrder(id) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Transaksi_WS.asmx/DeleteOrder',
                    method: 'POST',
                    data: JSON.stringify({ id: id }),
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
        async function AjaxDelete(id) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Transaksi_WS.asmx/DeleteRecord',
                    method: 'POST',
                    data: JSON.stringify({ id: id }),
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

        async function AjaxLoadOrderRecord(id) {

            try {
                const response = await fetch('Transaksi_WS.asmx/LoadOrderRecord', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: id })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        async function AjaxLoadOrderRecord_Senarai(id) {

            try {
                const response = await fetch('Transaksi_WS.asmx/LoadOrderRecord_SenaraiTransaksiJurnal', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: id })
                });

                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }
        async function DelRecord(id) {
            var bool = false;
            var result = JSON.parse(await AjaxDelete(id));

            if (result.Code === "00") {
                bool = true;
            }

            return bool;
        }


        $(tableID).on('keyup', '.Jumlah', async function () {


            var curTR = $(this).closest("tr");

            var debit_ = $(curTR).find("td > .Jumlah");
            var totalDebit = NumDefault(debit_.val())



            calculateGrandTotal();

            //START BIL COUNT DATATABLE...
            var columnIndexToCount = 3; // Change this to the desired column index (0-based)
            var rowCount = 0;

            $("#tableID").find("tr").each(function () {
                var cellValue = $(this).find("td:eq(" + columnIndexToCount + ")").text();

                // Check if the cell has data
                if (cellValue.trim() !== "") {
                    rowCount++;
                }
            });

            //console.log("Number of rows with data in column " + columnIndexToCount + ": " + rowCount);
            document.getElementById('result').textContent = rowCount + " Item :";

            //END BIL COUNT


        });

        async function calculateGrandTotal() {

            //Jumlah
            var grandTotal_Dt = $(totalJumlah);

            var curTotal_Dt = 0;

            $('.Jumlah').each(function (index, obj) {
                curTotal_Dt += parseFloat(NumDefault($(obj).val()));
            });


            grandTotal_Dt.val(formatPrice(curTotal_Dt));


        }


        //async function calculateGrandBeza() {
        //    var grandTotal = $(totalID);

        //    var totalDebit = 0;
        //    var totalKredit = 0;

        //    var curTR = $(this).closest("tr");

        //    var debit_ = $(curTR).find("td > .totalDbt");
        //    var totalDebit = parseFloat(NumDefault(debit_.val()));


        //    var kredit_ = $(curTR).find("td > .totalKt");
        //    var totalKredit = parseFloat(NumDefault(kredit_.val()));

        //    alert("a " + totalDebit)
        //    grandTotal.val(totalDebit - totalKredit);

        //}

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

        async function initDropdownKw(id, idVot) {

            $('#' + id).dropdown({
                fullTextSearch: true,
                apiSettings: {
                    url: 'Transaksi_WS.asmx/GetKWList?q={query}&kodkw={kodkw}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term

                        var kodVot = $('#' + idVot).dropdown("get value");
                        settings.urlData.kodkw = kodVot;
                        settings.data = JSON.stringify({ q: settings.urlData.query, kodkw: settings.urlData.kodkw });
                        searchQuery = settings.urlData.query;
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

                        //if (searchQuery !== oldSearchQuery) {
                        // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

        async function initDropdownKo(id, idKw) {


            $('#' + id).dropdown({
                fullTextSearch: true,
                apiSettings: {
                    url: 'Transaksi_WS.asmx/GetKoList?q={query}&kodko={kodko}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        var kodkw = $('#' + idKw).dropdown("get value");
                        settings.urlData.kodko = kodkw;
                        settings.data = JSON.stringify({ q: settings.urlData.query, kodko: settings.urlData.kodko });
                        searchQuery = settings.urlData.query;
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

                        //if (searchQuery !== oldSearchQuery) {
                        // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

        async function initDropdownKp(id, idKo) {

            $('#' + id).dropdown({
                fullTextSearch: true,
                apiSettings: {
                    url: 'Transaksi_WS.asmx/GetKpList?q={query}&kodko={kodko}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {

                        var kodkp = $('#' + idKo).dropdown("get value");
                        settings.urlData.kodko = kodkp;
                        settings.data = JSON.stringify({ q: settings.urlData.query, kodko: settings.urlData.kodko });
                        searchQuery = settings.urlData.query;
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

                        //if (searchQuery !== oldSearchQuery) {
                        // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

        async function initDropdownVot(id, idPtj) {

            $('#' + id).dropdown({
                fullTextSearch: true,
                apiSettings: {
                    url: 'Transaksi_WS.asmx/GetVotList?q={query}&kodVot={kodVot}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term

                        var kodPtj = $('#' + idPtj).dropdown("get value");
                        settings.urlData.kodVot = kodPtj;
                        settings.data = JSON.stringify({ q: settings.urlData.query, kodVot: settings.urlData.kodVot });
                        searchQuery = settings.urlData.query;
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

                        //if (searchQuery !== oldSearchQuery) {
                        // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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
        async function initDropdownObjAm(id) {

            $('#' + id).dropdown({
                fullTextSearch: true,
                onChange: function (value, text, $selectedItem) {

                    //console.log($selectedItem);

                    var curTR = $(this).closest("tr");

                    var recordIDVotHd = curTR.find("td > .Hid-objAm-list");

                },
                apiSettings: {
                    url: 'Awal_Tahun_WS.asmx/GetObjAm?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    fields: {

                        value: "value",      // specify which column is for data
                        name: "text"      // specify which column is for text


                    },
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term

                        //settings.urlData.param2 = "secondvalue";

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
                            //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });


                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }



            });
        }



        async function initDropdownPtj(id) {

            $('#' + id).dropdown({
                fullTextSearch: true,
                apiSettings: {
                    url: 'Transaksi_WS.asmx/GetVotPTJ?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({ q: settings.urlData.query });
                        searchQuery = settings.urlData.query;
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

                        //if (searchQuery !== oldSearchQuery) {
                        // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

        $('.btnAddRow').click(async function () {
            var totalClone = $(this).data("val");

            await AddRow(totalClone);
        });

        async function AddRow(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblData');

            if (objOrder !== null && objOrder !== undefined) {
                //totalClone = objOrder.Payload.OrderDetails.length;
                totalClone = objOrder.Payload.length;

                //if (totalClone < 5) {
                //    totalClone = 5;
                //}
            }
            //console.log("aa" +objOrder)
            while (counter <= totalClone) {

                curNumObject += 1;

                var newId_coa = "ddlObjAm" + curNumObject;


                var row = $('#tblData tbody>tr:first').clone();

                var dropdown5 = $(row).find(".ObjAm-list").attr("id", newId_coa);


                row.attr("style", "");
                var val = "";

                $('#tblData tbody').append(row);

                await initDropdownObjAm(newId_coa)
                $(newId_coa).api("query");


                if (objOrder !== null && objOrder !== undefined) {
                    //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
                    if (counter <= objOrder.Payload.length) {
                        //console.log("aa" + objOrder.Payload[counter - 1])
                        await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);

                    }
                }
                counter += 1;
            }
        }

        async function paparSenarai(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblDataSenarai');

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;

            }
            // console.log(objOrder)

            while (counter <= totalClone) {


                var row = $('#tblDataSenarai tbody>tr:first').clone();
                row.attr("style", "");
                var val = "";

                $('#tblDataSenarai tbody').append(row);

                if (objOrder !== null && objOrder !== undefined) {

                    if (counter <= objOrder.Payload.length) {
                        await setValueToRow(row, objOrder.Payload[counter - 1]);
                    }
                }

                counter += 1;
            }


        }

        async function setValueToRow_HdrBajet(orderDetail) {

            $("#ddlCOA_Drpd").dropdown('clear');
            $("#ddlCOA_Kpd").dropdown('clear');

            $('#lblNoViremen').val(orderDetail.No_Viremen);
            $('#lblRujukan').val(orderDetail.Ruj_Surat);
            $('#lblTujuan').val(orderDetail.Tujuan);
            $('#lblJumlah').val(orderDetail.Amaun);

            $('#txtKW_Drpd').val(orderDetail.kw_K);
            $('#txtKO_Drpd').val(orderDetail.ko_K);
            $('#txtKP_Drpd').val(orderDetail.kp_K);
            $('#txtPtj_Drpd').val(orderDetail.ptj_K);
            $('#txtVot_Drpd').val(orderDetail.vot_K);

            $('#txtBakiSemasa_Drpd').val(orderDetail.bakisms_K);

            // Get the numeric value of jumlah
            var bakiBersihValue = parseFloat(orderDetail.bakisms_K);
            var jumlah = parseFloat(orderDetail.Amaun);

            // Subtract bakiBersihValue from jumlah
            var result_Drpd = bakiBersihValue - jumlah;
            //alert(bakiBersihValue + " " + jumlah)
            // Assuming you want to update lblJumlah with the result
            $('#txtBakiSlpsVire_Drpd').val(result_Drpd);


            $('#txtKW_Kpd').val(orderDetail.kw_M);
            $('#txtKO_Kpd').val(orderDetail.ko_M);
            $('#txtKP_Kpd').val(orderDetail.kp_M);
            $('#txtPtj_Kpd').val(orderDetail.ptj_M);
            $('#txtVot_Kpd').val(orderDetail.vot_M);

            $('#txtBakiSemasa_Kpd').val(orderDetail.bakisms_M);

            // Get the numeric value of jumlah
            var bakiBersihValue = parseFloat(orderDetail.bakisms_M);
            var jumlah = parseFloat(orderDetail.Amaun);

            // Subtract bakiBersihValue from jumlah
            var result_Kpd = bakiBersihValue + jumlah;
            //alert(bakiBersihValue + " " + jumlah)
            // Assuming you want to update lblJumlah with the result
            $('#txtBakiSlpsVire_Kpd').val(result_Kpd);

       }

        async function setValueToRow(row, orderDetail) {


            var no = $(row).find("td > .lblNo");
            var no1 = $(row).find("td > .lblNo");
            var rujukan = $(row).find("td > .lblRujukan");
            var butiran = $(row).find("td > .lblButiran");
            var jumlah = $(row).find("td > .lblJumlah");
            var tarikh = $(row).find("td > .lblTkh");
            var statusDok = $(row).find("td > .lblStatusDok");


            no.html(orderDetail.No_Jurnal);
            no1.val(orderDetail.No_Jurnal);
            rujukan.html(orderDetail.No_Rujukan);
            butiran.html(orderDetail.Butiran);
            jumlah.html(orderDetail.Jumlah);
            tarikh.html(orderDetail.Tkh_Transaksi);
            statusDok.html(orderDetail.Kod_Status_Dok);


        }

        async function setValueToRow_Transaksi(row, orderDetail) {


            var ddl = $(row).find("td > .ObjAm-list");
            var ddlSearch = $(row).find("td > .ObjAm-list > .search");
            var ddlText = $(row).find("td > .ObjAm-list > .text");
            var selectObj = $(row).find("td > .ObjAm-list > select");
            $(ddl).dropdown('set selected', orderDetail.ddlObjAm);
            selectObj.append("<option value = '" + orderDetail.ddlObjAm + "'>" + orderDetail.ddlObjAm + ' - ' + orderDetail.ButiranVot + "</option>")


            //var butirptj = $(row).find("td > .label-ptj-list");
            //butirptj.html(orderDetail.ButiranPTJ);


            var jumlah = $(row).find("td > .Jumlah");
            jumlah.val(orderDetail.Jumlah.toFixed(2));

            var Butiran = $(row).find("td > .Butiran");
            Butiran.val(orderDetail.Butiran);


            await calculateGrandTotal();

        }

        async function initDropdownCOA_trans(id) {

            $('#' + id).dropdown({
                fullTextSearch: true,

                apiSettings: {
                    url: 'ViremenWS.asmx/GetVotCOA?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    fields: {

                        value: "value",      // specify which column is for data
                        name: "text"      // specify which column is for text


                    },
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term

                        //settings.urlData.param2 = "secondvalue";

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
                            //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                            $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }


            });
        }

        // add clickable event in DataTable row
        async function rowClickHandler(id) {
            
            if (id !== "") {
                // modal dismiss
                $('#permohonan').modal('toggle');

                //BACA HEADER JURNAL
                var recordHdr = await AjaxGetRecordHdrBajet(id);
                //console.log("aa " + recordHdr);
                await AddRowHeader(null, recordHdr);



            }
        }


        async function AddRowHeader(totalClone, objOrder) {
            var counter = 1;
            //var table = $('#tblDataSenarai');

            //console.log(" counter " + objOrder)

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;

                //console.log("AddRowHeader 1" + objOrder.Payload.length);
            }


            if (counter <= objOrder.Payload.length) {
                
                await setValueToRow_HdrBajet(objOrder.Payload[counter - 1]);

                //console.log("AddRowHeader2");
            }

        }


        async function AjaxGetRecordBajet(id) {

            try {

                const response = await fetch('Awal_Tahun_WS.asmx/LoadRecordBajet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: id })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        async function AjaxGetRecordHdrBajet(id) {
            //console.log("id "+id)
            try {

                const response = await fetch('ViremenWS.asmx/LoadHdrViremen', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: id })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        function getDateNow() {
            //Cara Pertama

            fetch('Awal_Tahun_WS.asmx/LoadDateNow', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setDateNow(data.d))

        }

        function setDateNow(data) {

            data = JSON.parse(data);

            if (data.curDateNow === "") {
                alert("Tiada data");
                return false;
            }

            document.getElementById("txtTarikh").value = data[0].curDateNow;

        }

        function getPTJ_Kpd(id) {
            //Cara Pertama

            fetch('ViremenWS.asmx/LoadPTJ', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                body: JSON.stringify({ id: id })
                //body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setPTJ_Kpd(data.d))

        }

        function setPTJ_Kpd(data) {

            data = JSON.parse(data);

            if (data.KodPejPBU === "") {
                alert("Tiada data");
                return false;
            }

            document.getElementById("txtPtj_Kpd").value = data[0].KodPejPBU + " - " + data[0].Pejabat;
           
        }

        function getPTJ_Drpd(id) {
            //Cara Pertama

            fetch('ViremenWS.asmx/LoadPTJ', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                body: JSON.stringify({ id: id })
                //body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setPTJ_Drpd(data.d))

        }

        function setPTJ_Drpd(data) {

            data = JSON.parse(data);

            if (data.KodPejPBU === "") {
                alert("Tiada data");
                return false;
            }

            document.getElementById("txtPtj_Drpd").value = data[0].KodPejPBU + " - " + data[0].Pejabat;

        }

        function getPTJ_Pusat() {
            //Cara Pertama

            fetch('Awal_Tahun_WS.asmx/LoadPTJ', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setPTJ_Pusat(data.d))

        }

        function setPTJ_Pusat(data) {

            data = JSON.parse(data);

            if (data.KodPejPBU === "") {
                alert("Tiada data");
                return false;
            }

            else {
                return data[0].KodPejPBU;
            }


        }

        $('#ddlCOA_Drpd').dropdown({
            fullTextSearch: true,
            onChange: function (value, text, $selectedItem) {
                // Set the value of the input text field based on the selected option

                console.log($selectedItem)
                //daripada
                var kumpWang = $($selectedItem).data("colhidkw") + " - " + $($selectedItem).data("colkw");
                $('#txtKW_Drpd').val(kumpWang);

                var ko = $($selectedItem).data("colhidko") + " - " + $($selectedItem).data("colko");
                $('#txtKO_Drpd').val(ko);

                var kp = $($selectedItem).data("colhidkp") + " - " + $($selectedItem).data("colkp");
                $('#txtKP_Drpd').val(kp);

                var ptj = $($selectedItem).data("colhidptj") + " - " + $($selectedItem).data("colptj");
                $('#txtPtj_Drpd').val(ptj);

                var vot = $($selectedItem).data("value") + " - " + $($selectedItem).data("colhidvot");
                $('#txtVot_Drpd').val(vot);

                //var resulta = 3200.00 
                //var formattedResulta = resulta.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });


                var today = new Date();

                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();

                today = yyyy + '-' + mm + '-' + dd;



                    var BakiBajet = getBakiBajet(yyyy, today, $($selectedItem).data("colhidkw"), $($selectedItem).data("colhidko"), $($selectedItem).data("colhidptj"), $($selectedItem).data("colhidkp"), $($selectedItem).data("value"))
                    //dapatkan baki bajet
                    $('#txtBakiSemasa_Drpd').val(BakiBajet);
                

                //$('#txtBakiSemasa_Drpd').val(formattedResulta);
                
                //var result = $('#txtBakiSemasa_Drpd').val(BakiBajet); - parseFloat($('#lblJumlah').val());
                //var formattedResult = result.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

                //$('#txtBakiSlpsVire_Drpd').val(formattedResult);


            },
            apiSettings: {
                //url: '<%= ResolveUrl("~/FORMS/JURNAL/JURNAL KEWANGAN/Transaksi_WS.asmx/GetVotCOA") %>' + '?q={query}',
                url: 'ViremenWS.asmx/GetVotCOA?q={query}',
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                beforeSend: function (settings) {
                    // Replace {query} placeholder in data with user-entered search term
                    settings.data = JSON.stringify({ q: settings.urlData.query });
                    searchQuery = settings.urlData.query;
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
                        $(objItem).append($('<div class="item" data-value="' + option.value + '"data-colhidvot="' + option.colhidvot + '"data-colhidkw="' + option.colhidkw + '" data-colKW="' + option.colKW + '" data-colhidko="' + option.colhidko + '" data-colKo="' + option.colKO + '" data-colhidkp="' + option.colhidkp + '" data-colKp="' + option.colKp + '" data-colhidptj="' + option.colhidptj + '" data-colptj="' + option.colPTJ + '">').html(option.text));

                    });



                    // Refresh dropdown
                    $(obj).dropdown('refresh');

                    if (shouldPop === true) {
                        $(obj).dropdown('show');
                    }
                }
            }
        });


        // Check txtKW_Kpd before ddlCOA_Kpd is selected
        $('#ddlCOA_Kpd').on('click', function () {
            
            if ($('#txtKW_Drpd').val() === null || $('#txtKW_Drpd').val() === '') {
                // Handle the case when txtKW_Kpd is null or empty before ddlCOA_Kpd is selected
                console.log('txtKW_Kpd is null or empty');
                return false; // prevent the dropdown from opening
            }

            else {
          
              $('#ddlCOA_Kpd').dropdown({
                    fullTextSearch: true,
                    onChange: function (value, text, $selectedItem) {
                        // Set the value of the input text field based on the selected option

                      
                        //daripada
                        var kumpWang = $($selectedItem).data("colhidkw") + " - " + $($selectedItem).data("colkw");
                        $('#txtKW_Kpd').val(kumpWang);

                        var ko = $($selectedItem).data("colhidko") + " - " + $($selectedItem).data("colko");
                        $('#txtKO_Kpd').val(ko);

                        var kp = $($selectedItem).data("colhidkp") + " - " + $($selectedItem).data("colkp");
                        $('#txtKP_Kpd').val(kp);

                        var ptj = $($selectedItem).data("colhidptj") + " - " + $($selectedItem).data("colptj");
                        $('#txtPtj_Kpd').val(ptj);

                        var vot = $($selectedItem).data("value") + " - " + $($selectedItem).data("colhidvot");
                        $('#txtVot_Kpd').val(vot);

                        //var resulta_ = 560.02
                        //var formattedResulta_ = resulta_.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        //$('#txtBakiSemasa_Kpd').val(formattedResulta_);

                        //var resulta_1 = 560.02 + parseFloat($('#lblJumlah').val());
                        //var formattedResulta_1 = resulta_1.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                        //$('#txtBakiSlpsVire_Kpd').val(formattedResulta_1);

                        var today = new Date();

                        var dd = String(today.getDate()).padStart(2, '0');
                        var mm = String(today.getMonth() + 1).padStart(2, '0');
                        var yyyy = today.getFullYear();

                        today = yyyy + '-' + mm + '-' + dd;

                        var BakiBajet = getBakiBajet_Kpd(yyyy, today, $($selectedItem).data("colhidkw"), $($selectedItem).data("colhidko"), $($selectedItem).data("colhidptj"), $($selectedItem).data("colhidkp"), $($selectedItem).data("value"))

                        //dapatkan baki bajet
                        $('#txtBakiSemasa_Kpd').val(BakiBajet);
                     


                    },
                    apiSettings: {
                        url: 'ViremenWS.asmx/GetVotCOA_Kpd?q={query}&kwDrpd={kodkw}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term

                            var kodkwDrpd = $("#txtKW_Drpd").val()
                            settings.urlData.kodkw = kodkwDrpd;

                            settings.data = JSON.stringify({ q: settings.urlData.query, kwDrpd: settings.urlData.kodkw });
                            searchQuery = settings.urlData.query;
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
                                $(objItem).append($('<div class="item" data-value="' + option.value + '" data-colhidvot="' + option.colhidvot + '" data-colhidkw="' + option.colhidkw + '" data-colkw="' + option.colKW + '" data-colhidko="' + option.colhidko + '" data-colko="' + option.colKO + '" data-colhidkp="' + option.colhidkp + '" data-colkp="' + option.colKp + '" data-colhidptj="' + option.colhidptj + '" data-colptj="' + option.colPTJ + '">').html(option.text));
                            });



                            // Refresh dropdown
                            $(obj).dropdown('refresh');

                            if (shouldPop === true) {
                                $(obj).dropdown('show');
                            }
                        }
                    }
                });
            }
        });


   


        function getKW(id) {
            //Cara Pertama

            fetch('ViremenWS.asmx/LoadKW', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                body: JSON.stringify({ id: id })
                //body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setKW(data.d))

        }

        function setKW(data) {

            data = JSON.parse(data);
            console(data)
            //if (data.KodPejPBU === "") {
            //    alert("Tiada data");
            //    return false;
            //}

            document.getElementById("txtKW_Drpd").value = data[0].Kod_Kump_Wang + " - " + data[0].Butiran;

        }


        function getBakiBajet(yyyy, today, kod_KW, kod_Operasi, kod_PTj, kod_Projek, kod_coa_vot) {
            //Cara Pertama

            // Specify the URL you want to fetch data from
            const url = '<%= ResolveClientUrl("~/FORMS/BAJET/PERUNTUKAN TK/TambahKurangWS.asmx/fGetBakiSebenar") %>';

                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': "application/json"
                    },
                    //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                    body: JSON.stringify({
                        year: yyyy,
                        tarikh: today,
                        ptj: kod_PTj,
                        kw: kod_KW,
                        ko: kod_Operasi,
                        kp: kod_Projek,
                        vot: kod_coa_vot
                    })
                })
                .then(response => response.json())
                .then(data => setInfoBajet(data.d))

        }

        function setInfoBajet(data) {

            if (data === "") {
                Notification("Tiada data");
                return false;
            }
            var formattedBakiBersih = data.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true });
            var formattedBakiBersihWithoutRM = formattedBakiBersih.replace('RM', ''); // Remove "RM"
            $('#txtBakiSemasa_Drpd').val(formattedBakiBersihWithoutRM);

            //var jumlah = $('#lblJumlah').val() 
            //$('#txtBakiSlpsVire_Drpd').val(formattedBakiBersihWithoutRM - parseFloat($('#lblJumlah').val()));
           // alert(parseFloat($('#lblJumlah').val()))
            //var result = $('#txtBakiSemasa_Drpd').val(parseFloat(data) - parseFloat($('#lblJumlah').val()));
            //var formattedResult = result.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            //alert(result)

            // Convert formattedBakiBersihWithoutRM to a numeric value
            var bakiBersihValue = parseFloat(formattedBakiBersihWithoutRM.replace(/,/g, ''));

            // Get the numeric value of jumlah
            var jumlah = parseFloat($('#lblJumlah').val());

            // Subtract bakiBersihValue from jumlah
            var result = bakiBersihValue - jumlah ;
            //alert(bakiBersihValue + " " + jumlah)
            // Assuming you want to update lblJumlah with the result
            $('#txtBakiSlpsVire_Drpd').val(result);

           // $('#txtBakiSlpsVire_Drpd').val(result);



        }

        function getBakiBajet_Kpd(yyyy, today, kod_KW, kod_Operasi, kod_PTj, kod_Projek, kod_coa_vot) {
            //Cara Pertama
           // alert(yyyy + " " + today + " " + kod_KW + " " + kod_Operasi + " " + kod_PTj + " " + kod_Projek + " " +  kod_coa_vot)
            // Specify the URL you want to fetch data from
            const url = '<%= ResolveClientUrl("~/FORMS/BAJET/PERUNTUKAN TK/TambahKurangWS.asmx/fGetBakiSebenar") %>';

                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': "application/json"
                    },
                    //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                    body: JSON.stringify({
                        year: yyyy,
                        tarikh: today,
                        ptj: kod_PTj,
                        kw: kod_KW,
                        ko: kod_Operasi,
                        kp: kod_Projek,
                        vot: kod_coa_vot
                    })
                })
                .then(response => response.json())
                    .then(data => setInfoBajet_Kpd(data.d))

        }

        function setInfoBajet_Kpd(data) {

            if (data === "") {
                Notification("Tiada data");
                return false;
            }
            var formattedBakiBersih = data.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true });
            var formattedBakiBersihWithoutRM = formattedBakiBersih.replace('RM', ''); // Remove "RM"
            $('#txtBakiSemasa_Kpd').val(formattedBakiBersihWithoutRM);

            //var jumlah = $('#lblJumlah').val() 
            //$('#txtBakiSlpsVire_Drpd').val(formattedBakiBersihWithoutRM - parseFloat($('#lblJumlah').val()));
            // alert(parseFloat($('#lblJumlah').val()))
            //var result = $('#txtBakiSemasa_Drpd').val(parseFloat(data) - parseFloat($('#lblJumlah').val()));
            //var formattedResult = result.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            //alert(result)

            // Convert formattedBakiBersihWithoutRM to a numeric value
            var bakiBersihValue = parseFloat(formattedBakiBersihWithoutRM.replace(/,/g, ''));

            // Get the numeric value of jumlah
            var jumlah = parseFloat($('#lblJumlah').val());

            // Subtract bakiBersihValue from jumlah
            var result = bakiBersihValue + jumlah;
            //alert(bakiBersihValue + " " + jumlah)
            // Assuming you want to update lblJumlah with the result
            $('#txtBakiSlpsVire_Kpd').val(result);

            // $('#txtBakiSlpsVire_Drpd').val(result);



        }


    </script>

</asp:Content>
