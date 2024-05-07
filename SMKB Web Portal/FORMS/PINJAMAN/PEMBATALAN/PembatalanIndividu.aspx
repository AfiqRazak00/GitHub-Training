<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PembatalanIndividu.aspx.vb" Inherits="SMKB_Web_Portal.PembatalanIndividu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <style>
        input[readonly] {
            background-color: #e5e5e5;
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

        #tblisting td:hover {
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
            max-width: 1200px;
            margin: auto;
        }

        .form-group {
            max-width: 100%;
        }

        #permohonan .modal-body {
            max-height: 60vh; /* Adjust height as needed to fit your layout */
            min-height: 50vh;
        }

        #detailTotal .modal-body {
            max-height: 20vh; /* Adjust height as needed for #detailTotal */
            min-height: 20vh;
        }
        .codx {
              display: none;
              visibility: hidden;
         }
    </style>
    <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
    <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
    <contenttemplate>
        <!------------------------------------------------------------------- CODE START --------------------------------------------------------------------------->
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div class="modal-body">
                <div class="form-group row col-md-6 align-middle">
                    <label for="inputEmail3" class="col-sm-3 col-form-label" style="text-align: right">Carian :</label>
                    <div class="col-sm-6">
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
                    <div class="col-md-3">
                        <div class="form-row">
                            <div class="form-group col-md-5">
                                <br />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-11">
                        <div class="form-row">
                            <div class="form-group col-md-2"></div>
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
                <div class="col-md-13">
                    <div class="transaction-table table-responsive">
                        <span style="display: inline-block; height: 100%;"></span>
                        <table id="tblisting" class="table table-striped">
                            <thead>
                                <tr style="width: 100%">
                                    <th scope="col">Bil</th>
                                    <th scope="col">No. Pembiayaan</th>
                                    <th scope="col">Tarikh Mohon</th>
                                    <th scope="col">Butiran</th>
                                    <th scope="col">Status Pembiayaan</th>
                                    <th scope="col">Status</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade bd-example-modal-xl " id="mdlSlctdRow" tabindex="-1" role="document"
            aria-labelledby="mdlSlctdRow" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content modal-xl">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="form-group col-md-2"></div>
                                <div class="form-group col-md-8">
                                    <br />
                                    <input class="input-group__input text-center mx-auto nodannama" name="Maklumat Permohonan" type="text" readonly style="background-color: #f0f0f0" value="" placeholder="Nama Pemohon" />
                                </div>
                                <div class="form-group col-md-2" style="padding-right: 20px; padding-top: 10px;">
                                    <button id="refreshButton" type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <ul class="nav nav-tabs" id="myTab">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active text-uppercase" data-toggle="tab" href="#infopemohon">Info Pemohon</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link text-uppercase" data-toggle="tab" href="#infopinj">Info Pembiayaan</a>
                        </li>
                        <li class="nav-item codx" role="presentation">
                            <a class="nav-link text-uppercase" data-toggle="tab" id="tabinfokend" href="#infokend">Info Kenderaan</a>
                        </li>
                        <li class="nav-item codx" role="presentation">
                            <a class="nav-link text-uppercase" data-toggle="tab" id="tabinfokomp" href="#infokomp">Info Komputer/Telefon Pintar</a>
                        </li>
                        <li class="nav-item codx" role="presentation">
                            <a class="nav-link text-uppercase" data-toggle="tab" id="tabinfosukan" href="#infosukan">Info Peralatan Sukan</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link text-uppercase" data-toggle="tab" href="#potongan">Info Potongan Gaji</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent" style="height: 450px; overflow-y: auto;">
                        <!-- ~~~ TAB 2 START ~~~-->
                        <div class="tab-pane fade show active" id="infopemohon" role="tabpanel">
                            <div class="modal-body">
                                <div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <h5>Info Pemohon</h5>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="noStaf" id="noStaf" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="No Staf">No Staf</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="No. K/P" id="kadPengenalan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="No. K/P">No. K/P</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Kumpulan" id="kumpulan" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Kumpulan">Kumpulan</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Taraf" id="tarafKhidmat" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="Taraf">Taraf</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Gred Gaji" id="gredGaji" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Gred Gaji">Gred Gaji</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Umur Pada Tarikh Memohon" id="umur" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Umur Pada Tarikh Memohon">Umur Pada Tarikh Memohon</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Tarikh Lahir" id="tarikhLahir" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Tarikh Lahir">Tarikh Lahir</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Tarikh Lantikan" id="tarikhLantikan" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Tarikh Lantikan">Tarikh Lantikan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Tarikh Sah" id="tarikhSah" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Tarikh Sah">Tarikh Sah</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input text-right" name="Gaji Pokok (RM)" id="gajiPokok" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Gaji Pokok (RM)">Gaji Pokok (RM)</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Sambungan Tel." id="sambunganTelifon" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Sambungan Tel.">Sambungan Tel.</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-8">
                                                    <input class="input-group__input" name="Jawatan" id="jawatan" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Jawatan">Jawatan</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-8">
                                                    <input class="input-group__input" name="Jabatan" id="jabatan" type="text" readonly style="background-color: #f0f0f0" />
                                                    <label class="input-group__label" for="Jabatan">Jabatan</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ~~~ TAB 2 END   ~~~-->
                        <!-- ~~~ TAB 3 START ~~~-->
                        <div class="tab-pane fade" id="infopinj" role="tabpanel">
                            <div id="divTab3" runat="server" visible="true">
                                <div class="modal-body">
                                    <div>
                                        <div class="row">
                                            <div class="col-md-8">
                                                <h5>Info Pembiayaan</h5>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <input class="input-group__input" name="Kategori Pinjaman" id="kategoriPinjaman" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                        <label class="input-group__label" for="Kategori Pinjaman">Kategori Pembiayaan</label>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <input class="input-group__input" name="Jenis Pinjaman2" id="jenisPinjaman2" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                        <label class="input-group__label" for="Jenis Pinjaman2">Jenis Pembiayaan</label>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <input class="input-group__input text-right" name="Amaun Mohon (RM)" id="amaunMohon" type="text" readonly style="background-color: #f0f0f0" />
                                                        <label class="input-group__label" for="Amaun Mohon (RM)">Amaun Mohon (RM)</label>
                                                    </div>
                                                    <div class="form-group col-md-4" style="display: none;">
                                                        <input class="input-group__input" name="Amaun Mohon (RM)" id="amaunMohon2" type="text" readonly style="background-color: #f0f0f0" />
                                                        <label class="input-group__label" for="Amaun Mohon (RM)">Amaun Mohon (RM)</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <input class="input-group__input" name="Tarikh Mohon" id="tarikhMohon" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                        <label class="input-group__label" for="Tarikh Mohon">Tarikh Mohon</label>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <input class="input-group__input" name="Kelayakan" id="kelayakan" type="text" readonly style="background-color: #f0f0f0" />
                                                        <label class="input-group__label" for="Kelayakan">Kelayakan</label>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <input class="input-group__input text-right" name="Ansuran Bulan (RM)" id="ansuran" type="text" readonly style="background-color: #f0f0f0" />
                                                        <label class="input-group__label" for="Ansuran Bulan (RM)">Ansuran Bulan (RM)</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <input class="input-group__input" name="Tempoh" id="tempohPinjaman2" type="text" readonly style="background-color: #f0f0f0" />
                                                        <label class="input-group__label" for="Tempoh">Tempoh</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ~~~ TAB 3 END   ~~~-->
                        <!-- ~~~ TAB 4 START ~~~-->
                        <div class="tab-pane fade" id="infokend" role="tabpanel">
                            <div class="modal-body">
                                <div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <h5>Info Kenderaan</h5>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Model" id="modelKenderaan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="Model">Model</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Buatan" id="buatanKenderaan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="Buatan">Buatan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input text-right" name="Harga Bersih" id="hargaBersih" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="Harga Bersih">Harga Bersih(RM)</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="Sukatan Silinder" id="sukatanSilinder" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="Sukatan Silinder">Sukatan Silinder</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="No Chasis" id="noCasis" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="No Chasis">No. Chasis</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" name="No Enjin" id="noEnjin" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label" for="No Enjin">No. Enjin</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ~~~ TAB 4 END   ~~~-->
                        <!-- ~~~ TAB 5 START ~~~-->
                        <div class="tab-pane fade" id="infokomp" role="tabpanel">
                            <div class="modal-body">
                                <div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <h5>Info Komputer/Telefon Pintar</h5>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="jenispinjkomp" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenis Peranti</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="jenamakomp" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenama Komputer/Telefon Pintar</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="kapasiticakera" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Kapasiti Cakera Keras (Hardisk)</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="ram" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Ingatan (RAM)</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="jenamamonitor" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenama Monitor</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="jenamapencetak" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenama Pencetak</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="papankekunci" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenis Papan Kekunci</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="jenamamodem" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenama Modem</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="kadbunyi" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenama Kad Bunyi (Sound Card)</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="pemacucakera" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenama Pemacu Cakera (CD/DVD-ROM)</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input" id="tetikus" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenama Tetikus (Mouse)</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input text-right" id="hargakomp" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Harga Komputer/Telefon Pintar (RM)</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ~~~ TAB 5 END   ~~~-->
                         <!-- ~~~ TAB 5 START ~~~-->
                        <div class="tab-pane fade" id="infosukan" role="tabpanel">
                            <div class="modal-body">
                                <div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <h5>Info Peralatan Sukan</h5>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input"id="jenispinjsukan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Jenis Pembiayaan Sukan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input class="input-group__input text-right" id="hargasukan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                    <label class="input-group__label">Harga (RM)</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ~~~ TAB 5 END   ~~~-->
                        <!-- ~~~ TAB 7 START ~~~-->
                        <div class="tab-pane fade" id="potongan" role="tabpanel">
                            <div class="modal-body">
                                <div>
                                    <h5>Info Potongan Gaji</h5>
                                    <div>
                                        <span style="display: inline-block; height: 100%;"></span>
                                        <table id="tblpotongan" class="table table-striped ">
                                            <thead>
                                                <tr style="width: 100%">
                                                    <th scope="col">Bil</th>
                                                    <th scope="col">Jenis Pembiayaan/Perkara</th>
                                                    <th scope="col">Harga Potongan (RM)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="sticky-footer">
                                <br>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <div class="float-right">
                                            <button type="button" class="btn" id="showModalButton">
                                                <i class="fas fa-angle-up"></i>
                                            </button>
                                            <span style="font-family: roboto!important; font-size: 16px!important"><b>Jumlah
                         :RM
                         <span id="totalPotongan" style="margin-right: 25px"></span></b></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--~~~ MODAL TAB 7 END   ~~~-->
                    </div>
                    <div align="right" style="padding-bottom: 20px; padding-right: 20px;">
                        <button type="button" class="btn btn-danger" data-dismiss="modal" id="btnPadam">Batal Pembiayaan</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="detailTotal" tabindex="-1" aria-labelledby="showDetails"
            aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row justify-content-end mt-2">
                            <div class="col-md-6 text-right">
                                <label class="col-form-label ">Butiran Hutang/Potongan (RM)</label>
                            </div>
                            <div class="col-md-6">
                                <input class="form-control  underline-input" id="totalPotongan2"
                                    style="text-align: right; font-size: medium; font-weight: bold"
                                    placeholder="0.00" readonly />
                            </div>
                        </div>
                        <div class="row justify-content-end mt-2">
                            <div class="col-md-6 text-right">
                                <label class="col-form-label ">Jumlah Gaji (RM)</label>
                            </div>
                            <div class="col-md-6">
                                <input class="form-control  underline-input" id="totalPotongan3" name="TotalTax"
                                    style="text-align: right; font-size: medium; font-weight: bold"
                                    placeholder="0.00" readonly />
                            </div>
                        </div>
                        <div class="row justify-content-end mt-2">
                            <div class="col-md-6 text-right">
                                <label class="col-form-label ">Peratus Potongan (%)</label>
                            </div>
                            <div class="col-md-6">
                                <input class="form-control  underline-input" id="totalPotongan4"
                                    name="TotalDiskaun"
                                    style="text-align: right; font-size: medium; font-weight: bold"
                                    placeholder="0.00" readonly />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ~~~ Modal 1 PENGESAHAN YA START   ~~~ -->
        <div class="modal fade" id="saveConfirmationModal" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p class="pt-3" id="confirmationMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="confirmSaveButton">Ya</button>
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
        <script>
            var isClicked7 = false;
            var tempPinj = '';

            $(document).ready(function () {

                init();

                function init() {
                    loadSenarai();
                }

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

                dttable = $("#tblisting").DataTable({
                    "responsive": true,
                    "searching": true,
                    "info": false,
                    "sPaginationType": "full_numbers",
                    "oLanguage": {
                        "oPaginate": {
                            "sNext": '<i class="fa fa-forward"></i>',
                            "sPrevious": '<i class="fa fa-backward"></i>',
                            "sFirst": '<i class="fa fa-step-backward"></i>',
                            "sLast": '<i class="fa fa-step-forward"></i>'
                        },
                        "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                        "sInfo": "Menunjukkan END dari TOTAL rekod",
                        "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                        "sInfoFiltered": "(ditapis dari MAX jumlah rekod)",
                        "sEmptyTable": "Tiada rekod.",
                        "sSearch": "Carian"
                    },
                    "rowCallback": function (row, data) {
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });

                        $(row).on("click", function () {
                            ajaxPost("PmbtlnIndividuWS.asmx/GetSelectedPermohonan", {TargetId: data.NoPinj}, true, rdatalisting)
                        });
                    },
                    "columns": [
                        { "data": "RowNum" },
                        { "data": "NoPinj" },
                        { "data": "TkhMohon" },
                        { "data": "TxtKatPinj" },
                        { "data": "StatusDok" },
                        { "data": "StatusPinj" }
                    ]
                });

                var dttable2 = $("#tblpotongan").DataTable({
                    responsive: true,
                    searching: false,
                    info: false,
                    lengthChange: false,
                    paging: false,
                    ordering: false,
                    "columnDefs": [
                        // Header center align
                        { className: "dt-head-left", targets: [0, 1] },
                        { className: "dt-head-right", targets: [2] },
                        // Amaun semua right align
                        { className: "dt-body-right", targets: [2] },
                        // Col yg bukan butiran center align
                        //{ className: "dt-body-center", targets: [0, 4, 6, 8] },
                    ],
                    "columns": [
                        { "data": "RowNum" },
                        { "data": "Butiran" },
                        { "data": "Amaun" },
                    ]
                });


                async function loadSenarai() {
                    var startDate = $('#txtTarikhStart').val();
                    var endDate = $('#txtTarikhEnd').val();

                    var postDt = {
                        category_filter: $('#categoryFilter').val(),
                        isClicked7: isClicked7,
                        tkhMula: startDate,
                        tkhTamat: endDate
                    }

                    var data = await ajaxPost("PmbtlnIndividuWS.asmx/FetchSenarai", postDt, true);

                    if (isSet(data)) {
                        dttable.clear();
                        dttable.rows.add(data.Payload).draw();
                        //var rowCount = tbl.rows().count();
                    }
                }

                async function rdatalisting(data) {
                    if (data.Status) {
                        var dt = data.Payload[0];
                        //Tab 1 - Info Pemohon
                        tempPinj = dt.NoPinjaman;
                        $(".nodannama").val("" + (dt.NoPinjaman || ' - ') + '        ' + (dt.NamaPeminjam || ' - '));
                        $("#noStaf").val(dt.NoStaf || ' - ');
                        $("#kadPengenalan").val(dt.KadPengenalan || ' - ');
                        $("#tarafKhidmat").val(dt.TarafKhidmat || ' - ');
                        $("#gredGaji").val(dt.GredGaji || ' - ');
                        $("#umur").val(dt.Umur || ' - ');
                        $("#tarikhLahir").val(dt.TarikhLahir || ' - ');
                        $("#tarikhLantikan").val(dt.TarikhLantikan || ' - ');
                        $("#tarikhSah").val(dt.TarikhSah || ' - ');
                        $("#gajiPokok").val(dt.GajiPokok || ' - ');
                        $("#sambunganTelifon").val(dt.SambunganTelifon || ' - ');
                        $("#jawatan").val(dt.Jawatan || ' - ');
                        $("#jabatan").val(dt.Jabatan || ' - ');
                        $("#kumpulan").val(dt.Kumpulan || ' - ');

                        //Tab 2 - Info Pinjaman
                        $("#kategoriPinjaman").val(dt.KategoriPinjaman || ' - ');
                        $("#jenisPinjaman2").val(dt.JenisPinjaman2 || ' - ');
                        $("#amaunMohon").val(dt.AmaunMohon || ' - ');
                        $("#tarikhMohon").val(dt.TarikhMohon || ' - ');
                        $("#kelayakan").val(dt.Kelayakan || ' Belum Ada Kelayakan ');
                        $("#ansuran").val(dt.Ansuran || ' - ');
                        $("#tempohPinjaman2").val(dt.TempohPinjaman2.toUpperCase() || ' - ');

                        var katpinj = dt.KategoriPinjaman2;

                        if (katpinj == 'K00001') {
                            $("#tabinfokend").parent().removeClass("codx")
                            $("#tabinfosukan").parent().addClass("codx")
                            $("#tabinfokomp").parent().addClass("codx")
                        } else if (katpinj == 'K00002') {
                            $("#tabinfokend").parent().addClass("codx")
                            $("#tabinfosukan").parent().addClass("codx")
                            $("#tabinfokomp").parent().removeClass("codx")
                            extractInfo(tempPinj, katpinj);
                        } else if (katpinj == 'K00003') {
                            $("#tabinfokend").parent().addClass("codx")
                            $("#tabinfosukan").parent().removeClass("codx")
                            $("#tabinfokomp").parent().addClass("codx")
                            extractInfo(tempPinj, katpinj);
                        }

                        //Tab 3 - Info Kenderaan
                        $("#modelKenderaan").val(dt.ModelKenderaan || ' - ');
                        $("#buatanKenderaan").val(dt.BuatanKenderaan || ' - ');
                        $("#hargaBersih").val(dt.HargaBersih || ' - ');
                        $("#sukatanSilinder").val(dt.SukatanSilinder || ' - ');
                        $("#noCasis").val(dt.NoCasis || ' - ');
                        $("#noEnjin").val(dt.NoEnjin || ' - ');

                        //Tab 6 - Info Potongan
                        var dttab6 = await ajaxPost("PmbtlnIndividuWS.asmx/Get_SecondTableData", {}, false);

                        if (isSet(dttab6)) {
                            if (dttab6.Status) {
                                var dt3 = dttab6.Payload;
                                dttable2.clear();
                                dttable2.rows.add(dt3).draw();
                                $("#totalPotongan").text(dt3[0].TotalAmaun);
                                $("#totalPotongan2").val(dt3[0].TotalAmaun);
                                $("#totalPotongan3").val(dt3[0].GajiPlusElaun);
                                $("#totalPotongan4").val(dt3[0].PeratusPotongan);
                            }
                        }

                        $('#mdlSlctdRow').modal('toggle');
                    } else {

                    }
                }

                async function extractInfo(noPinj, katpinj ) {
                    var dttab4 = await ajaxPost("PmbtlnIndividuWS.asmx/GetInfoSpecs", { NoPinj: noPinj, KatPinj: katpinj }, false);

                    if (isSet(dttab4)) {
                        if (dttab4.Status) {
                            var dt2 = dttab4.Payload[0];
                            $("#jenispinjkomp").val(dt2.jenispinjkomp || ' - ');
                            //Tab 4  - Info Komputer
                            $("#jenamakomp").val(dt2.jenamakomp || ' - ');
                            $("#kapasiticakera").val(dt2.kapasiticakera || ' - ');
                            $("#ram").val(dt2.ram || ' - ');
                            $("#jenamamonitor").val(dt2.jenamamonitor || ' - ');
                            $("#jenamapencetak").val(dt2.jenamapencetak || ' - ');
                            $("#papankekunci").val(dt2.papankekunci || ' - ');
                            $("#jenamamodem").val(dt2.jenamamodem || ' - ');
                            $("#pemacucakera").val(dt2.pemacucakera || ' - ');
                            $("#tetikus").val(dt2.tetikus || ' - ');
                            $("#hargakomp").val(dt2.hargakomp || ' - ');

                            //Tab 5 - Info Sukan
                            $("#jenispinjsukan").val(dt2.jenispinjsukan || ' - ');
                            $("#hargasukan").val(dt2.hargasukan || ' - ');
                        }
                    }
                }

                $("#confirmSaveButton").off('click').on('click', async function () {
                    $("#saveConfirmationModal").modal('toggle');
                    var data = await ajaxPost("PmbtlnIndividuWS.asmx/BatalPermohonan", { NoPinj: tempPinj }, false);

                    if (data.Status) {
                        //Reload Table
                        loadSenarai();

                        $("#detailMakluman").text(data.Message);
                        $("#maklumanModal").modal('show');
                    } else {
                        $("#detailMakluman").text(data.Message);
                        $("#maklumanModal").modal('show');
                    }
                });

                $("#btnPadam").off('click').on('click', function () {
                    var msg = "Adakah anda ingin membatalkan permohonan ini?"
                    $("#confirmationMessage").text(msg);
                    $("#saveConfirmationModal").modal('toggle');
                });
                 
                $('.btnSearch').click(async function () {
                    isClicked7 = true;
                    loadSenarai();
                })

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

                $('#mdlSlctdRow').on('hidden.bs.modal', function () {
                    //On close modal 
                    $('#myTab a:first').tab('show'); //Active on first tab
                });

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

                function buildDdl(id, kodVal, txtVal) {
                    if (isSet(kodVal) && isSet(txtVal)) {
                        $("#" + id).html("<option value = '" + kodVal + "'>" + txtVal + "</option>")
                        $("#" + id).dropdown('set selected', kodVal);
                    }
                }

                function isSet(value) {
                    if (value === null || value === '' || value === undefined) {
                        return false;
                    } else {
                        return true;
                    }
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


            });
        </script>
    </contenttemplate>
</asp:Content>
