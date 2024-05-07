<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Maklumat_ePO.aspx.vb" Inherits="SMKB_Web_Portal.Maklumat_ePO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <style>
        .centered-content {
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 10vh; /* Optional: Set height to the viewport height for full-screen effect */
        }

        .flip-clock-wrapper ul li a div.down {
            border-bottom-left-radius: 0px !important;
            border-bottom-right-radius: 0px !important;
        }

        .clock.flip-clock-wrapper ul li a div div.inn {
            font-size: 11px !important;
            line-height: 25px !important;
        }

        ul.flip {
            padding: 0px 10px !important;
        }

        .clock.flip-clock-wrapper ul {
            width: 15px !important;
            height: 25px !important;
        }

            .clock.flip-clock-wrapper ul li a div.up:after {
                top: 12px !important;
            }

        .flip-clock-wrapper ul.flip.flip:nth-child(even) {
            margin: 0px 10px 0px 0px !important;
            border-radius: 0px 6px 6px 0px !important;
        }

        .flip-clock-wrapper ul.flip:nth-child(even) li a div div.inn {
            background-color: #080606 !important;
            border-radius: 0px 6px 6px 0px !important;
        }

        .flip-clock-wrapper ul.flip.flip:nth-child(odd) {
            margin: 0px !important;
            border-radius: 6px 0px 0px 6px !important;
        }

        .flip-clock-wrapper ul.flip:nth-child(odd) li a div div.inn {
            background-color: #080606 !important;
            border-radius: 6px 0px 0px 6px !important;
        }


        .nospn {
            -moz-appearance: textfield;
        }

            .nospn::-webkit-outer-spin-button,
            .nospn::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }



        #permohonan .modal-body {
            max-height: 70vh; /* Adjust height as needed to fit your layout */
            min-height: 70vh;
            overflow-y: scroll;
            scrollbar-width: thin;
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

        #showModalButton:hover {
            /* Add your hover styles here */
            background-color: #ffc107; /* Change background color on hover */
            color: #fff; /* Change text color on hover */
            border-color: #ffc107; /* Change border color on hover */
            cursor: pointer; /* Change cursor to indicate interactivity */
        }

        td.details-control {
            background: url('../resources/details_open.png') no-repeat center center;
            cursor: pointer;
        }

        tr.shown td.details-control {
            background: url('../resources/details_close.png') no-repeat center center;
        }

        .hidden-column {
            display: none;
        }

        #ddlTahun {
            display: none;
        }

        #jadualHargaModal .modal-dialog {
            max-width: 1500px; /* Adjust the width as per your requirement */
            height: 600px; /* Adjust the height as per your requirement */
        }

        .codx {
            display: none;
            visibility: hidden;
        }

        .file-upload-container {
            position: relative;
        }
    </style>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flipclock/0.7.8/flipclock.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flipclock/0.7.8/flipclock.js"></script>


    <div id="MklmtEPerolehanTab" class="tabcontent" style="display: block">

        <div class="centered-content mt-2">
            <h3>Tempoh Tawaran Iklan Tamat</h3>
            <div class="centered-content">
                <div class="ml-4">
                    <div class="flipclock" id="flipclock-1"></div>
                </div>
            </div>
        </div>

        <div class="col-md-12 mt-4">
            <div class="row">
                <div class="col-md-6" align="left">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleMklmtPerolehan">Maklumat Perolehan Sebut Harga</h5>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group col-md-12 mt-1" align="right">
                        <button type="button" class="btn btn-primary btnViewNaskah" title="Lihat Naskah"><i class="fa fa-eye"></i>Naskah</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="col-md-12">
                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="NoDaftarSya" name="NoDaftarSya" readonly />
                            <label class="input-group__label">No. Pendaftaran Syarikat</label>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="NoPerolehan" name="NoPerolehan" readonly />
                            <label class="input-group__label">No Perolehan</label>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="KatPerolehan" name="KatPerolehan" readonly />
                            <label class="input-group__label">Kategori Perolehan</label>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <input type="number" class="form-control input-group__input" id="biltempoh" name="biltempoh" onchange="handleInputChange('',this.value,'','')">
                                <label class="input-group__label" for="biltempoh">Tempoh</label>
                            </div>
                            <div class="form-group col-md-6">
                                <select class="input-group__select ui search dropdown" name="ddlTermBayar" id="ddlTermBayar" onchange="handleInputChange('','',this.value,'')"></select>
                                <label class="input-group__label" for="ddlTermBayar">Jenis Tempoh</label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="row">

                        <div class="col-md-12">
                            <div class="form-group input-group">
                                <textarea class="input-group__input form-control input-sm" placeholder="" id="tajuk" name="tajuk" rows="3" readonly></textarea>
                                <label class="input-group__label">A.Tajuk</label>
                            </div>

                        </div>
                        <div class="col-md-12">
                            <div class="form-group input-group">
                                <textarea class="input-group__input form-control input-sm " placeholder="" id="skop" name="skop" rows="4" readonly></textarea>
                                <label class="input-group__label">B.Skop</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- btnSimpanMklmtPerolehan -->
            <div class="col-md-12 mt-3" align="center">
                <div class="form-group col-md-8" style="align-items: flex-start">
                    <button type="button" class="btn btn-secondary btnSimpanMklmtPerolehan" title="Simpan"><i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                </div>
            </div>

        </div>

        <div class="modal-body">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Buku 1</h6>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblbuku1" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr data-id="">
                                                <th scope="col" style="width: 10%;">Bil</th>
                                                <th scope="col" style="width: 70%;">Senarai Semak</th>
                                                <th scope="col" style="width: 20%;">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody id="">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Buku 2</h6>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblbuku2" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr data-id="">
                                                <th scope="col" style="width: 10%;">Bil</th>
                                                <th scope="col" style="width: 70%;">Senarai Semak</th>
                                                <th scope="col" style="width: 20%;">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody id="">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Button Kembali dan Hantar -->
        <div class="form-group col-md-12">
            <div class="row">
                <div class="col-md-6" align="left">
                    <!-- Button semak(kanan) and kembali(kiri) -->
                    <button type="button" class="btn btn-primary btnKembali" data-toggle="tooltip" data-placement="bottom" title="Kembali">
                        <i class="fa fa-arrow-left" aria-hidden="true"></i>Kembali</button>
                </div>
                <div class="col-md-6" align="right">
                    <button type="button" class="btn btn-success btnHantar" data-toggle="tooltip" data-placement="bottom" title="Hantar">
                        <i class="fa fa-check" aria-hidden="true"></i>Hantar</button>
                </div>
            </div>
        </div>

        <!-- Modal Profil Syarikat -->
        <div class="modal fade" id="profilSyaModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleMklmtCawangan">Profile Syarikat</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <!-- Table -->
                            <div class="form-group">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblDataProfilSya" class="table table-striped" style="width: 100%">
                                            <thead>
                                                <tr data-id="">
                                                    <th scope="col" style="width: 10%;">Bil</th>
                                                    <th scope="col" style="width: 80%;">Lampiran</th>
                                                    <th scope="col" style="width: 10%;">Tindakan</th>
                                                </tr>
                                            </thead>
                                            <tbody id="">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pengesahan & CheckBox -->
                        <div class="form-group" style="text-align: center;">
                            <div class="col-md-12">
                                <div class="panel-heading">
                                    <br />
                                    <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-check form-check-inline">
                                    <input type="checkbox" class="form-check-input" id="chckProfil" name="chckProfil">
                                    <label class="form-check-label" for="chckProfil">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-md-12 mt-3">
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <button type="button" class="btn btn-secondary btnSimpanProfil" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Syarat Am -->

        <div class="modal fade" id="syaratAmModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleSyaratAm">Syarat-Syarat Am</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <p>Tertakluk kepada apa-apa syarat khas yang lain didalam pelawaan ini, syarat-syarat am yang dinyatakan seperti berikut hendaklah terpakai kepada pembekal.</p>
                            <%--<strong>1.0 BORANG SEBUT HARGA</strong>
                            <p>Sebarang identiti, pengenalan, tanda atau cap pembida adalah <strong>TIDAK DIBENARKAN </strong>dipamer dalam setiap helaian <strong>BUKU 2 </strong>. Sekiranya berlaku, UTeM berhak untuk <strong>MEMBATALKAN</strong> sebut harga dari pembida tersebut</p>--%>
                            <div class="card" style="border: solid;">
                                <div class="card-body">
                                    <h6 class="card-title">1.0 BORANG SEBUT HARGA</h6>
                                    <p class="card-text">
                                        Sebarang identiti, pengenalan, tanda atau cap pembida adalah
                                        <strong>TIDAK DIBENARKAN </strong>dipamer dalam setiap helaian
                                        <strong>BUKU 2 </strong>. Sekiranya berlaku, UTeM berhak untuk
                                        <strong>MEMBATALKAN</strong> sebut harga dari pembida tersebut
                                    </p>
                                    <h6 class="card-title">2.0 KEADAAN BARANG</h6>
                                    <p class="card-text">
                                        Semua barangan hendaklah dalam keadaan selamat.
                                    </p>
                                    <h6 class="card-title">3.0 HARGA</h6>
                                    <p class="card-text">
                                        Sebut harga yang ditawarkan adalah harga bersih termasuk semua diskaun dan kos tambahan yang berkaitan. Jumlah sebut harga yang ditawarkan mestilah tidak melebihi RM500,000.00
                                    </p>
                                    <h6 class="card-title">4.0 SEBUT HARGA SEBAHAGIAN</h6>
                                    <ul class="card-text">
                                        <li>4.1 Sebut harga boleh ditawarkan bagi semua bilangan item atau sebahagian bilangan item.</li>
                                        <li>4.2 UTeM tidak terikat untuk menerima tawaran terendah atau mana-mana tawaran. UTeM berhak untuk menerima sebahagian tawaran daripada mana-mana petender/penyebutharga.</li>
                                        <li>4.3 Petender/Penyebutharga boleh menawarkan tawaran untuk semua item atau sebahagian item. Setiap tawaran untuk setiap item akan dianggap sebagai tawaran berasingan.</li>
                                    </ul>

                                    <h6 class="card-title">5.0 BARANG-BARANG SETARA</h6>
                                    <p class="card-text">
                                        Sebut harga boleh ditawarkan bagi barang-barang setara yang sesuai dengan syarat butir-butir penuh barang-barang setara diberikan
                                    </p>
                                </div>
                            </div>
                            <br />
                            <div class="col-md-12" style="text-align: center">
                                <p>Saya/kami dengan ini menawarkan pembekalan / perkhidmatan diatas dengan harga dan syarat-syarat yang dinyatakan.</p>
                            </div>
                            <div class="col-md-12" style="text-align: center">
                                <strong>PENGESAHAN SYARIKAT</strong>
                                <div class="col-md-12">
                                    <div class="form-check form-check-inline mt-3">
                                        <input type="checkbox" class="form-check-input" id="chckSyaratAm" name="chckSyaratAm">
                                        <label class="form-check-label" for="chckSyaratAm">Saya Bersetuju.</label>
                                    </div>
                                </div>
                                <div class="form-group col-md-12 mt-3">
                                    <div class="row">
                                        <div class="col-md-12" align="center">
                                            <button type="button" class="btn btn-secondary btnSimpanSyaratAm" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                                <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Jadual Harga -->
        <div class="modal fade" id="jadualHargaModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleJadualHarga">Borang Jadual Harga</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataJadualHarga" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr data-id="" style="width: 100%; text-align: center;">
                                            <th scope="col" style="width: 5%">Bil</th>
                                            <th scope="col" style="width: 12%">Spesifikasi Teknikal Fakulti/Jabatan</th>
                                            <th scope="col" style="width: 10%">Jenama</th>
                                            <th scope="col" style="width: 10%">Model</th>
                                            <th scope="col" style="width: 12%">Negara Pembuat</th>
                                            <th scope="col" style="width: 8%">Kuantiti</th>
                                            <th scope="col" style="width: 5%">Pembungkusan</th>
                                            <th scope="col" style="width: 8%">Harga Seunit Bercukai [B] (RM)</th>
                                            <th scope="col" style="width: 8%">Harga Seunit Tanpa Cukai(FOB) [C] (RM)</th>
                                            <th scope="col" style="width: 10%">Jumlah Harga Bercukai(RM)</th>
                                            <th scope="col" style="width: 12%">Jumlah Harga Tanpa Cukai (RM)</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblRowJadualHarga" style="overflow: auto; height: 50px;">
                                        <tr style="display: none; width: 100%; overflow: auto">
                                            <td>
                                                <!-- Bil -->
                                                <label id="trBil" name="trBil" class="trBil"></label>
                                                <input type="hidden" class="data-id" name="hdid"
                                                    id="hdid" value="" />
                                            </td>
                                            <td>
                                                <label id="lblSpekFakulti" name="lblSpekFakulti"
                                                    class="label-lblSpekFakulti-list">
                                                </label>
                                                <label id="HidlblSpekFakulti" name="HidlblSpekFakulti"
                                                    class="Hid-lblSpekFakulti-list"
                                                    style="visibility: hidden; display: none;">
                                                </label>
                                            </td>
                                            <td>
                                                <input type="text" class=" input-group__input form-control input-sm JenamaJH"
                                                    placeholder="" id="jhJenama" name="jhJenama" />
                                            </td>
                                            <td>
                                                <input type="text" class=" input-group__input form-control input-sm ModelJH"
                                                    placeholder="" id="jhModel" name="jhModel" />
                                            </td>
                                            <td>
                                                <select class="ui search dropdown negara-carian-list"
                                                    name="ddljhNegara" id="ddljhNegara">
                                                </select>

                                                <input type="hidden" class="data-id" name="hdKodNegara"
                                                    id="hdKodNegara" value="" />
                                            </td>
                                            <td>
                                                <input type="text" class=" input-group__input form-control input-sm KuantitiJH"
                                                    placeholder="" id="KuantitiJH" name="KuantitiJH" />

                                            </td>
                                            <td>
                                                <label id="lbljhBungkus" name="lbljhBungkus"
                                                    class="label-lbljhBungkus-list">
                                                </label>
                                                <label id="HidlbljhBungkus" name="HidlbljhBungkus"
                                                    class="Hid-lbljhBungkus-list"
                                                    style="visibility: hidden; display: none;">
                                                </label>
                                            </td>
                                            <td>
                                                <input type="number"
                                                    class="form-control underline-input multi jhHargaUnit"
                                                    placeholder="0.00" id="price" name="price"
                                                    style="text-align: right" />
                                            </td>
                                            <td>
                                                <input type="number"
                                                    class="form-control underline-input multi jhHargaUnitC"
                                                    placeholder="0.00" id="jhHargaBercukai" name="price"
                                                    style="text-align: right" />
                                            </td>
                                            <td>
                                                <label id="lblJumHarga" name="lblJumHarga"
                                                    class="label-lblJumHarga-list">
                                                </label>
                                                <label id="HidlblJumHarga" name="HidlblJumHarga"
                                                    class="Hid-lblJumHarga-list"
                                                    style="visibility: hidden; display: none;">
                                                </label>
                                            </td>
                                            <td>
                                                <label id="lbljhJumHargaC" name="lbljhJumHargaC"
                                                    class="label-lbljhJumHargaC-list">
                                                </label>
                                                <label id="HidlbljhJumHargaC" name="HidlbljhJumHargaC"
                                                    class="Hid-lbljhJumHargaC-list"
                                                    style="visibility: hidden; display: none;">
                                                </label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="sticky-footer">
                                    <br />
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <%--<div class="btn-group float-left">
                                                <button type="button"
                                                    class="btn btn-warning btnAddRow" data-val="1"
                                                    value="1">
                                                    <b>+ Tambah</b></button>
                                                <button type="button"
                                                    class="btn btn-warning dropdown-toggle dropdown-toggle-split"
                                                    data-toggle="dropdown" aria-haspopup="true"
                                                    aria-expanded="false">
                                                    <span class="sr-only">Toggle Dropdown</span>
                                                </button>
                                                <div class="dropdown-menu">
                                                    <a class="dropdown-item btnAddRow five"
                                                        value="5" data-val="5" id="btnAdd5">Tambah 5</a>
                                                    <a class="dropdown-item btnAddRow" value="10"
                                                        data-val="10">Tambah 10</a>
                                                </div>

                                            </div>--%>
                                            <div class="float-right">
                                                <span style="font-family: roboto!important; font-size: 18px!important"><b>Jumlah (<span id="stickyJumlahItem" style="margin-right: 5px">0</span> item) :RM <span id="stickyJumlah" style="margin-right: 5px">0.00</span></b></span>
                                                <button type="button" class="btn" id="showModalButton"><i class="fas fa-angle-up"></i></button>
                                                <%-- <button type="button" class="btn btn-setsemula btnPadamJh ">Rekod Baru</button>--%>
                                                <button type="button" class="btn btn-secondary btnSimpanJh">Simpan</button>
                                                <%--<button type="button" class="btn btn-success btnHantarJh">Hantar</button>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="form-group" style="text-align: center;">
                            <div class="col-md-12">
                                <div class="panel-heading">
                                    <br />
                                    <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                                </div>
                            </div>
                            <div class="col-md-12 mb-2 mt-3">
                                <div class="form-check form-check-inline">
                                    <input type="checkbox" class="form-check-input" id="chckJadualHarga" name="chckJadualHarga">
                                    <label class="form-check-label" for="chckJadualHarga">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                                </div>
                            </div>
                            <div class="form-group col-md-12 mt-3">
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <button type="button" class="btn btn-secondary btnSimpanSahJH" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                            <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Detail Total Modal -->
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
                                    <input class="form-control underline-input"
                                        id="totalwoCukai" name="totalwoCukai"
                                        style="text-align: right; font-size: medium; font-weight: bold"
                                        placeholder="0.00" readonly />
                                </td>
                            </tr>

                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: medium;">Jumlah
                                Cukai</td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input"
                                        id="TotalTax" name="TotalTax"
                                        style="text-align: right; font-size: medium; font-weight: bold"
                                        placeholder="0.00" readonly />
                                </td>
                            </tr>

                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: medium;">Pelarasan Bundaran</td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input"
                                        id="rounding" name="rounding"
                                        style="text-align: right; font-size: medium; font-weight: bold"
                                        placeholder="0.00" readonly />
                                </td>
                            </tr>


                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: large">JUMLAH (RM)
                                </td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="total"
                                        name="total"
                                        style="text-align: right; font-size: medium; font-weight: bold"
                                        placeholder="0.00" readonly />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal Jaminan Pembekal -->
        <div class="modal fade" id="jaminanModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleJaminan">Jaminan Pembekal</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- gambar Logo Utem n Nama Center -->
                        <div class="form-group col-md-12">
                            <center>
                                <img src="../../../Images/logo.png" id="logoUtem1" alt="Logo Utem" />
                                <h4>UNIVERSITI TEKNIKAL MALAYSIA MELAKA</h4>
                            </center>
                        </div>
                        <div class="col-md-12">
                            <label id="noPerolehanJaminan"></label>
                        </div>
                        <div class="col-md-12">
                            <label id="tajukPerolehanJaminan"></label>
                        </div>
                        <div class="col-md-12">
                            <p>
                                Saya dengan ini menawarkan untuk melaksanaan perolehan tersebut dengan segala penentuan dalam dokumen sebut harga dengan:
                            </p>
                            <ul>
                                <li>1. Tawaran sebanyak RM  (Ringgit Malaysia: )</li>
                                <li>2. Saya bersetuju untuk menyiapkan perolehan ini dalam tempoh  dari tarikh Surat Setuju Terima ditandatangani.</li>
                                <li>3. Saya bersetuju bahawa tempoh sah laku sebut harga ini akan dibuka selama 90 hari daripada tarikh sebut harga ini ditutup.</li>
                            </ul>

                        </div>
                        <div class="col-md-12" style="text-align: center">
                            <strong>PENGESAHAN SYARIKAT</strong>
                            <div class="col-md-12">
                                <div class="form-check form-check-inline mt-3">
                                    <input type="checkbox" class="form-check-input" id="chckJaminan" name="chckJaminan">
                                    <label class="form-check-label" for="chckJaminan">Saya Bersetuju.</label>
                                </div>
                            </div>
                            <div class="form-group col-md-12 mt-3">
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <button type="button" class="btn btn-secondary btnSimpanJaminan" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                            <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Surat Akaun Pembida -->
        <div class="modal fade" id="suratPembidaModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleAkaunPembida">Surat Akaun Pembida</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- gambar Logo Utem n Nama Center -->
                        <div class="form-group col-md-12">
                            <center>
                                <img src="../../../Images/logo.png" id="logoUtem2" alt="Logo Utem" />
                                <h4>UNIVERSITI TEKNIKAL MALAYSIA MELAKA</h4>
                            </center>
                        </div>

                        <div class="col-md-12">
                            <label id="noPerolehan"></label>
                        </div>
                        <div class="col-md-12">
                            <label id="tajukPerolehan"></label>
                        </div>
                        <div class="col-md-12">
                            <p>
                                Saya <strong>
                                    <label id="namaPeg1"></label>
                                </strong>yang mewakili syarikat <strong>
                                    <label id="namaSya"></label>
                                </strong>
                                bernombor pendaftaran <strong>
                                    <label id="noDaftar"></label>
                                </strong>dengan dengan ini mengisytiharkan bahawa saya atau mana-mana individu yang mewakili syarikat ini tidak akan menawar atau memberi rasuah kepada mana-mana individu dalam
                               <strong>Universiti Teknikal Malaysia Melaka </strong>atau mana-mana individu lain sebagai ganjaran mendapatkan sebut harga seperti diatas. Bersama-sama ini dilampirkan Surat Perwakilan Kuasa bagi saya mewakili syarikat seperti tercatat diatas untuk membuat pengisytiharan ini.
                            </p>
                            <ul>
                                <li>i) Penarikan balik tawaran kontrak bagi sebut harga diatas; atau</li>
                                <li>ii) Penamatan kontrak bagi sebut harga diatas; dan</li>
                                <li>iii) Lain-lain tindakan tatatertib mengikut peraturan perolehan Kerajaan</li>
                            </ul>

                            <p>
                                Sekiranya terdapat mana-mana individu cuba meminta rasuah daripada saya atau mana-mana individu yang berkaitan dengan syarikat ini sebagai ganjaran mendapatkan sebut harga* seperti diatas, maka saya berjanji akan dengan segera melaporkan perbuatan tersebut kepada pejabat Suruhanjaya Perkhidmatan Rasuah Malaysia(SPRM) atau balai polis yang berhampiran.
                            </p>
                        </div>
                        <div class="col-md-12" style="text-align: center">
                            <strong>PENGESAHAN SYARIKAT</strong>
                            <div class="col-md-12">
                                <div class="form-check form-check-inline mt-3">
                                    <input type="checkbox" class="form-check-input" id="chckSuratAkuan" name="chckSuratAkuan">
                                    <label class="form-check-label" for="chckSuratAkuan">Saya Bersetuju.</label>
                                </div>
                            </div>
                            <div class="form-group col-md-12 mt-3">
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <button type="button" class="btn btn-secondary btnSimpanSuratAkuan" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                            <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!--Borang Pengalaman  -->
    <div class="modal fade" id="BorangPengalaman" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleBorangPengalaman">Borang Pengalaman Vendor</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Pengalaman Vendor</h6>
                        </div>
                    </div>
                    <!-- Form Pengalaman -->
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="noDaftarPengalaman" name="noDaftarPengalaman" readonly />
                                    <label class="input-group__label">No Pendaftaran Syarikat</label>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtTajukPerolehan" name="txtTajukPerolehan" />
                                    <label class="input-group__label">Tajuk Perolehan</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtSyaPerolehan" name="txtSyaPerolehan" />
                                    <label class="input-group__label">Jabatan / Institusi</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" onfocus="(this.type='date')" placeholder="" name="tkhMula" id="tkhMula">
                                    <label class="input-group__label">Tarikh Mula Projek</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" onfocus="(this.type='date')" placeholder="" name="tkhTamat" id="tkhTamat">
                                    <label class="input-group__label">Tarikh Tamat Projek</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtNilaiProjek" name="txtNilaiProjek" />
                                    <label class="input-group__label">Nilai Projek (RM)</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="row">
                            <div class="col-md-12" align="center">
                                <button type="button" class="btn btn-secondary btnSimpanDataPengalaman" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                    <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                <button type="button" class="btn btn-danger btnBatalPengalaman" data-toggle="tooltip" data-placement="bottom" title="Simpan" style="display: none;">
                                    <i class="fa fa-cancel" aria-hidden="true"></i>Batal</button>
                            </div>
                        </div>
                    </div>

                    <!-- TblListPengalaman -->
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblListPengalaman" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Tajuk Projek</th>
                                        <th scope="col">Syarikat Yang Menawarkan Kerja</th>
                                        <th scope="col">Tarikh Mula</th>
                                        <th scope="col">Tarikh Tamat</th>
                                        <th scope="col">Nilai Tawaran</th>
                                        <th scope="col">Tindakan</th>
                                    </tr>
                                </thead>
                                <tbody id="">
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="form-group" style="text-align: center;">
                        <div class="col-md-12">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-check form-check-inline mt-3">
                                <input type="checkbox" class="form-check-input" id="chckPengalaman" name="chckPengalaman">
                                <label class="form-check-label" for="chckPengalaman">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                            </div>
                        </div>
                        <div class="form-group col-md-12 mt-3">
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <button type="button" class="btn btn-secondary btnSimpanPengalaman" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Borang Multimodal -->
    <div class="modal fade" id="borangMultimodal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleMultimodal">Multimodal Transport Operator [MTO]</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="form-group col-md-12">
                        <center>
                            <img src="../../../Images/logo.png" id="logoUtem" alt="Logo Utem" />
                            <h4>UNIVERSITI TEKNIKAL MALAYSIA MELAKA</h4>
                        </center>
                    </div>

                    <div class="col-md-12">
                        <label id="noPerolehanMTO"></label>
                    </div>

                    <div class="col-md-12">
                        <label style="color: blue;">(Jika Berkaitan Sahaja)</label>
                    </div>

                    <div class="col-md-12">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Berhubungan Barangan import Yang Ditawarkan Dalam Sebut Harga</h6>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <div id="LesenEksport" class="form-group">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <label for="lblStatLulus">Memerlukan Lesen Eksport: </label>
                                            <div class="form-check-inline">
                                                <label class="form-check-label col-md-3">
                                                    <input type="radio" class="form-check-input" id="radioYa" name="radioLesenEksport">Ya
                                                </label>
                                                &nbsp;
                                            <label class="form-check-label col-md-4">
                                                <input type="radio" class="form-check-input" id="radioTidak" name="radioLesenEksport">Tidak
                                            </label>
                                                &nbsp;
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <input type="number" class="form-control input-group__input" id="bilHantar" name="bilHantar" onchange="handleInputChange('',this.value,'','')">
                                    <label class="input-group__label" for="bilHantar">Bilangan Penghantaran</label>
                                </div>
                            </div>
                        </div>
                        <div class="row"></div>
                        <div class="row"></div>
                        <div class="row"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Sijil Terkini -->
    <div class="modal fade" id="sijilTerkini" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleSijilTerkini">Salinan Sijil Terkini Syarikat</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="UploadPenyataBank">Penyata Akaun Bank 3 Bulan Terakhir  <a style="color: red">*</a> : </label>
                                    <div class="form-inline">

                                        <input type="file" id="fileInputBank" />
                                        <span id="uploadedFileNameLabelBank" style="display: inline;"></span>
                                        <span id="">&nbsp</span>
                                        <span id="progressContainerBank"></span>
                                        <input type="hidden" class="form-control" id="hidJenDokBank" style="width: 300px" readonly="readonly" />
                                        <input type="hidden" class="form-control" id="hidFileNameBank" style="width: 300px" readonly="readonly" />

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group">
                                    <div class="row">
                                        <div align="left">
                                            <button type="button" class="btn btn-secondary btnUploadSijil" data-toggle="tooltip" data-placement="bottom" title="Muat Naik">
                                                <i class="fa fa-upload" aria-hidden="true"></i>Upload</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblListPenyataBank" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Nama Dokumen</th>
                                        <th scope="col">Tindakan</th>
                                    </tr>
                                </thead>
                                <tbody id="">
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="form-group" style="text-align: center;">
                        <div class="col-md-12">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-check form-check-inline mt-3">
                                <input type="checkbox" class="form-check-input" id="chckBank" name="chckBank">
                                <label class="form-check-label" for="chckJadualHarga">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                            </div>
                        </div>
                        <div class="form-group col-md-12 mt-3">
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <button type="button" class="btn btn-secondary btnSimpanBank" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Borang Penentuan Teknikal -->
    <div class="modal fade" id="borangTeknikal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleBorangTeknikal">Borang Penentuan Teknikal</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <ul class="nav nav-tabs" id="myTabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#spekAm">Maklumat Spesifikasi Am</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#spekTeknikal">Maklumat Spesifikasi Teknikal</a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="spekAm">
                            <div class="col-md-12">
                                <div class="panel-heading">
                                    <br />
                                    <h6 class="panel-title">Maklumat Spesifikasi Am</h6>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <!-- TblDataSpekAm-->
                                <div class="modal-body">
                                    <table id="spekfikasi-table-am" class="table table-striped" border="1" width="95%">
                                        <thead>
                                            <tr>
                                                <th>Perkara</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td>
                                                    <div class="float-right">
                                                        <button type="button" id="btnSimpanJwpnAm" name="btnSimpanJwpnAm" class="btn btn-secondary btnSimpanJwpnAm">Simpan</button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>

                            <div class="form-group" style="text-align: center;">
                                <div class="col-md-12">
                                    <div class="panel-heading">
                                        <br />
                                        <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-check form-check-inline mt-3">
                                        <input type="checkbox" class="form-check-input" id="chckJwpnAm" name="chckJwpnAm">
                                        <label class="form-check-label" for="chckJwpnAm">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                                    </div>
                                </div>
                                <div class="form-group col-md-12 mt-3">
                                    <div class="row">
                                        <div class="col-md-12" align="center">
                                            <button type="button" class="btn btn-secondary btnSimpanSahAm" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                                <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <!-- Borang Penentuan Teknikal -->
                        <div class="tab-pane fade" id="spekTeknikal">
                            <div class="col-md-12">
                                <div class="panel-heading">
                                    <br />
                                    <h6 class="panel-title">Maklumat Spesifikasi Teknikal</h6>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <%-- <div id="divSpekTeknikal">
                                    <table class="table table-striped" id="tblDataTxn" style="width: 100%;">
                                        <thead>
                                            <tr style="width: 100%; text-align: center">
                                                <th scope="col" style="width: 20%">Barang</th>
                                                <th scope="col" style="width: 20%">Jenama</th>
                                                <th scope="col" style="width: 10%">Model</th>
                                                <th scope="col" style="width: 10%">Negara</th>
                                                <th scope="col" style="width: 25%">Pembekal</th>
                                                <th scope="col" style="width: 5%">Tindakan</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr id="rowSpekTeknikal">

                                            </tr>
                                            <tr id="spekTeknikalDtl">
                                                <div class="accordion" id="accordionExample">
                                                    <div class="accordion-item">
                                                        <h2 class="accordion-header" id="headingOne">
                                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                                Accordion Item #1
                                                            </button>
                                                        </h2>
                                                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                                                            <div class="accordion-body">
                                                                <strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
                                                            </div>
                                                        </div>
                                                    </div>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>--%>

                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <div style="max-height: 500px; overflow-y: auto;">
                                            <table id="spekfikasi-table-teknikal" class="table table-striped" border="1" width="100%">
                                                <thead>
                                                    <tr style="">
                                                        <th style="width: 5%"></th>
                                                        <th style="width: 25%; text-align: center">Bil</th>
                                                        <th style="width: 25%; text-align: center">Barang</th>
                                                        <th style="width: 55%; text-align: center">Jenama</th>
                                                        <th style="width: 25%; text-align: center">Modal</th>
                                                        <th style="width: 55%; text-align: center">Negara</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="6">
                                                            <div class="float-right">
                                                                <button type="button" id="btnSimpanJwpnTeknikal" name="btnSimpanJwpnTeknikal" class="btn btn-secondary btnSimpanJwpnTeknikal">Simpan</button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group" style="text-align: center;">
                                    <div class="col-md-12">
                                        <div class="panel-heading">
                                            <br />
                                            <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-check form-check-inline mt-3">
                                            <input type="checkbox" class="form-check-input" id="chckJwpnTeknikal" name="chckJwpnTeknikal">
                                            <label class="form-check-label" for="chckJwpnTeknikal">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-12 mt-3">
                                        <div class="row">
                                            <div class="col-md-12" align="center">
                                                <button type="button" class="btn btn-secondary btnSimpanSahTeknikal" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                                    <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Jadual Perancangan Kerja Penbekal -->
    <div class="modal fade" id="jadualKerja" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleJadualKerja">Jadual Perancangan Kerja Pembekal</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="UploadJadualKerja">Jadual Perancangan Kerja  <a style="color: red">*</a> : </label>
                                    <div class="form-inline">

                                        <input type="file" id="fileInputJadualKerja" />
                                        <span id="uploadedFileNameLabelJadual" style="display: inline;"></span>
                                        <span id="">&nbsp</span>
                                        <span id="progressContainerJadual"></span>
                                        <input type="hidden" class="form-control" id="hidJenDokJadual" style="width: 300px" readonly="readonly" />
                                        <input type="hidden" class="form-control" id="hidFileNameJadual" style="width: 300px" readonly="readonly" />

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group">
                                    <div class="row">
                                        <div align="left">
                                            <button type="button" class="btn btn-secondary btnUploadJadual" data-toggle="tooltip" data-placement="bottom" title="Muat Naik">
                                                <i class="fa fa-upload" aria-hidden="true"></i>Upload</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblListJadualKerja" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Nama Dokumen</th>
                                        <th scope="col">Tindakan</th>
                                    </tr>
                                </thead>
                                <tbody id="">
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="form-group" style="text-align: center;">
                        <div class="col-md-12">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                            </div>
                        </div>
                        <div class="col-md-12 mt-3">
                            <div class="form-check form-check-inline">
                                <input type="checkbox" class="form-check-input" id="chckJadualKerja" name="chckJadualKerja">
                                <label class="form-check-label" for="chckJadualHarga">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                            </div>
                        </div>
                        <div class="form-group col-md-12 mt-3">
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <button type="button" class="btn btn-secondary btnJadualKerja" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Authorization Letter Dari Pembekal -->
    <div class="modal fade" id="authLetter" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleAuthLetter">Authorization Letter Daripada Pembekal</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Salinan Sijil Terkini Syarikat</h6>
                        </div>
                        <p>Dokumen (Surat Tawaran/ Surat Perakuan Siap & lain-lain):</p>
                        <div class="row">
                            <%--<div class="col-md-4">
                                <div class="form-group input-group">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlTajukProjek" id="ddlTajukProjek"></select>
                                    <label class="input-group__label">Tajuk Projek </label>
                                </div>
                            </div>--%>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="UploadJadualKerja">Dokumen : </label>
                                    <div class="form-inline">

                                        <input type="file" id="fileInputSijil" />
                                        <span id="uploadedFileNameLabelSijil" style="display: inline;"></span>
                                        <span id="">&nbsp</span>
                                        <span id="progressContainerSijil"></span>
                                        <input type="hidden" class="form-control" id="hidJenDokSijil" style="width: 300px" readonly="readonly" />
                                        <input type="hidden" class="form-control" id="hidFileNameSijil" style="width: 300px" readonly="readonly" />

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="row">
                                        <div align="left">
                                            <button type="button" class="btn btn-secondary btnUploadAL" data-toggle="tooltip" data-placement="bottom" title="Muat Naik">
                                                <i class="fa fa-upload" aria-hidden="true"></i>Upload</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblListSijil" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Nama Dokumen</th>
                                        <th scope="col">Tindakan</th>
                                    </tr>
                                </thead>
                                <tbody id="">
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Pengesahan Sijil -->
                    <div class="form-group" style="text-align: center;">
                        <div class="col-md-12">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                            </div>
                        </div>
                        <div class="col-md-12 mt-3">
                            <div class="form-check form-check-inline">
                                <input type="checkbox" class="form-check-input" id="chckSijil" name="chckSijil">
                                <label class="form-check-label" for="chckPengalaman">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                            </div>
                        </div>
                        <div class="form-group col-md-12 mt-3">
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <button type="button" class="btn btn-secondary btnSimpanSijil" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Katalog -->
    <div class="modal fade" id="katalog" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleKatalog">Katalog</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <%--<div class="col-md-12">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="UploadKatalog">Katalog <a style="color: red">*</a> : </label>
                                    <div class="form-inline">

                                        <input type="file" id="fileInputKatalog" />
                                        <span id="uploadedFileNameLabelKatalog" style="display: inline;"></span>
                                        <span id="">&nbsp</span>
                                        <span id="progressContainerKatalog"></span>
                                        <input type="hidden" class="form-control" id="hidJenDokkatalog" style="width: 300px" readonly="readonly" />
                                        <input type="hidden" class="form-control" id="hidFileNameKatalog" style="width: 300px" readonly="readonly" />

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group">
                                    <div class="row">
                                        <div align="left">
                                            <button type="button" class="btn btn-secondary btnUploadKatalog" data-toggle="tooltip" data-placement="bottom" title="Muat Naik">
                                                <i class="fa fa-upload" aria-hidden="true"></i>Upload</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>--%>

                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblLisKatalog" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Spesifikasi Barang/Perkara</th>
                                        <th scope="col">Penentuan Teknikal Syarikat</th>
                                        <th scope="col">Katalog</th>
                                    </tr>
                                </thead>
                                <tbody id="">
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Pengesahan Sijil -->
                    <div class="form-group" style="text-align: center;">
                        <div class="col-md-12">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                            </div>
                        </div>
                        <div class="col-md-12 mt-3">
                            <div class="form-check form-check-inline">
                                <input type="checkbox" class="form-check-input" id="chckKatalog" name="chckKatalog">
                                <label class="form-check-label" for="chckKatalog">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                            </div>
                        </div>
                        <div class="form-group col-md-12 mt-3">
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <button type="button" class="btn btn-secondary btnSimpanKatalog" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Sample -->
    <div class="modal fade" id="sample" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleSample">Sample</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblLisSample" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Spesifikasi Barang/Perkara</th>
                                        <th scope="col">Penentuan Teknikal Syarikat</th>
                                        <th scope="col">Sample</th>
                                    </tr>
                                </thead>
                                <tbody id="">
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <br />

                    <!-- Pengesahan Sijil -->
                    <div class="form-group" style="text-align: center;">
                        <div class="col-md-12">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">PENGESAHAN SYARIKAT</h6>
                            </div>
                        </div>
                        <div class="col-md-12 mt-3">
                            <div class="form-check form-check-inline">
                                <input type="checkbox" class="form-check-input" id="chckSample" name="chckSample">
                                <label class="form-check-label" for="chckSample">Saya dengan ini mengesahkan dan mengaku bahawa segala maklumat yang saya berikan adalah benar dan lengkap.</label>
                            </div>
                        </div>
                        <div class="form-group col-md-12 mt-3">
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <button type="button" class="btn btn-secondary btnSimpanSample" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        <i class="fa fa-save" aria-hidden="true"></i>Simpan</button>
                                </div>
                            </div>
                        </div>

                    </div>
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
                    <%--<button type="button" class="btn btn-secondary btnYaDelete">Ya</button>--%>
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

    <script type="text/javascript">

        //document.addEventListener('keydown', function (event) {
        //    if (event.key === 'Enter') {
        //        event.preventDefault(); // Prevent the default action
        //        // Add your custom logic here
        //    }
        //});

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

        /* ===============================================================================================================================================================================
            js function for Tab 1 (Maklumat Tawaran Iklan)
        =============================================================================================================================================================================== */

        $('.btnKembali').click(async function () {
            var Url = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/EPerolehan.aspx")%>'
            location.replace(Url, '_blank');
        });

        $('.btnViewNaskah').on('click', function () {
            // $('#maklumanModal').modal('toggle');
            //$('#NaskahModal').modal('toggle');
            var mode = "ePO"
            var No = "1"
            var IdJualan = $(this).attr('data-id');
            var Url = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/Naskah.aspx")%>?mode=' + mode + '&IdNaskah=' + IdJualan + '&no=' + No;
            location.replace(Url, '_blank');
        });

        $(document).ready(function () {
            const searchParams = new URLSearchParams(window.location.search);
            let EndDate = searchParams.get('EndDate');
            var IdPembelian = searchParams.get('IdPembelian');

            // Convert StartDate and EndDate to JavaScript Date objects
            //var startDate = new Date(StartDate);
            var startDate = new Date;
            var endDate = new Date(EndDate);

            // Calculate the time difference in seconds
            var timeDifference = (endDate.getTime() / 1000) - (startDate.getTime() / 1000);

            if (timeDifference < 0) {
                // If the time difference is negative, set a default value and display the makluman modal
                timeDifference = 0;
                $('#detailMakluman').html('Tawaran Iklan Telah Tamat');
                $('#maklumanModal').modal('show');
                $('.btnHantar').prop('disabled', true);
            }

            var labels = {
                years: 'Tahun',
                months: 'Bulan',
                days: 'Hari',
                hours: 'Jam',
                minutes: 'Minit',
                seconds: 'Saizan'
            };

            // Iterate through FlipClock elements and replace labels
            $('.flipclock .flip-clock-label').each(function () {
                var originalText = $(this).text().toLowerCase();
                if (labels.hasOwnProperty(originalText)) {
                    $(this).text(labels[originalText]);
                }
            });

            var clock2;

            clock2 = $('.flipclock').FlipClock({
                clockFace: 'DailyCounter',
                autoStart: false,
                callbacks: {
                    stop: function () {
                        $('#detailMakluman').html('Tawaran Iklan Telah Tamat');
                        $('#maklumanModal').modal('show');
                        $('.btnHantar').prop('disabled', true);
                    }
                }
            });

            // Set the countdown time and start the clock
            clock2.setTime(timeDifference);
            clock2.setCountdown(true);
            clock2.start();
            //$("span.flip-clock-divider").remove();
            //addFlipClockLabels();

            LoadDataPO(IdPembelian);
        });

        async function LoadDataPO(IdPembelian) {

            if (IdPembelian == "") {
                displayMaklumanModal("ID Pembelian Tidak Sah");
            } else {
                var result = JSON.parse(await AjaxLoadDataPerolehan(IdPembelian));
                SetvalueToFrom(result);
            }
        }

        async function AjaxLoadDataPerolehan(IdPembelian) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'EPerolehan_WS.asmx/LoadDataPerolehan',
                    method: 'POST',
                    data: JSON.stringify({ IdPembelian: IdPembelian }),
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

        async function SetvalueToFrom(DataPO) {

            $('#NoDaftarSya').val(DataPO[0].No_Sykt);
            $('#NoPerolehan').val(DataPO[0].No_Perolehan);
            $('#KatPerolehan').val(DataPO[0].ButiranKatSya);
            $('#biltempoh').val(DataPO[0].Tempoh);

            if (DataPO[0].Jenis_Tempoh == null) {
                $('#ddlTermBayar').dropdown('set selected', false);
            } else {
                var selectObj_JenTempoh = $('#ddlTermBayar');
                $('#ddlTermBayar').dropdown('set selected', DataPO[0].Jenis_Tempoh);
                selectObj_JenTempoh.append("<option value ='" + DataPO[0].Jenis_Tempoh + "'>" + DataPO[0].ButiranTempoh + "</option>");
            }
            //$('#ddlTermBayar').val(DataPO[0].Jenis_Tempoh);
            $('#tajuk').val(DataPO[0].Tujuan);
            $('#skop').val(DataPO[0].Skop);

            $('.btnViewNaskah').attr("data-id", DataPO[0].Id_Jualan);
        }

        $('#ddlTermBayar').dropdown({
            fullTextSearch: true,
            apiSettings: {
                url: '<%=ResolveClientUrl("~/FORMS/AKAUN PENERIMA/Invois/InvoisWS.asmx/GetTempohBayaran?q={query}")%>',
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
                    //$(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
                    //}

                    //oldSearchQuery = searchQuery;

                    // Refresh dropdown
                    $(obj).dropdown('refresh');

                    //if (shouldPop === true) {
                    //    $(obj).dropdown('show');
                    //}
                }
            }
        });

        var tblbuku1 = null
        $(document).ready(function () {
            const searchParams = new URLSearchParams(window.location.search);
            var IdPembelian = searchParams.get('IdPembelian');
            /* show_loader();*/
            tblbuku1 = $("#tblbuku1").DataTable({
                "responsive": true,
                "searching": false,
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
                    "url": "EPerolehan_WS.asmx/GetListBuku1",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            IdPembelian: IdPembelian,
                        })
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
                        openPopupForm(data);
                    });
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
                    { "data": "ButiranDokumen" },
                    {
                        "data": "Status_Simpan",
                        "render": function (data, type, row, meta) {
                            if (data === "1") {
                                return '<i class="fas fa-check-circle circle-icon" style="font-size: 48px; color:green;"></i>';
                            } else {
                                return '<i class="far fa-times-circle" style="font-size: 48px; color:red;"></i>';
                            }
                        }
                    },
                ]
            });
        });

        var tblbuku2 = null
        $(document).ready(function () {
            const searchParams = new URLSearchParams(window.location.search);
            var IdPembelian = searchParams.get('IdPembelian');
            /* show_loader();*/
            tblbuku2 = $("#tblbuku2").DataTable({
                "responsive": true,
                "searching": false,
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
                    "url": "EPerolehan_WS.asmx/GetListBuku2",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            IdPembelian: IdPembelian,
                        })
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
                        openPopupForm2(data);
                    });
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
                    { "data": "ButiranDokumen" },
                    {
                        "data": "Status_Simpan",
                        "render": function (data, type, row, meta) {
                            if (data === "1") {
                                return '<i class="fas fa-check-circle circle-icon" style="font-size: 48px; color:green;"></i>';
                            } else {
                                return '<i class="far fa-times-circle" style="font-size: 48px; color:red;"></i>';
                            }
                        }
                    },
                ]
            });
        });

        async function AjaxGetDataBuku1(KodDokumen) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'EPerolehan_WS.asmx/GetKodBuku1',
                    method: 'POST',
                    data: JSON.stringify({ KodDokumen: KodDokumen }),
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

        async function AjaxGetDataBuku2(KodDokumen) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'EPerolehan_WS.asmx/GetKodBuku2',
                    method: 'POST',
                    data: JSON.stringify({ KodDokumen: KodDokumen }),
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

        //Open modal buku 1
        async function openPopupForm(data) {

            const searchParams = new URLSearchParams(window.location.search);
            var IdPembelian = searchParams.get('IdPembelian');

            if (data.length < 0) {
                displayMaklumanModal("Tiada Data");
            }

            var dataBuku1 = JSON.parse(await AjaxGetDataBuku1(data.Kod_Dokumen));

            if (dataBuku1.length > 0) {
                DataBuku1 = dataBuku1[0];
            } else {
                displayMaklumanModal("Tiada Maklumat");
            }

            if ($('#biltempoh').val() == "" || $('#ddlTermBayar').val() == null) {
                displayMaklumanModal("Sila Isi Tempoh Di Bahagian Yang Disediakan");
                return false;
            }

            if (data.Kod_Dokumen === DataBuku1.Kod_Dokumen && DataBuku1.Keutamaan == "1") {
                loadDataProfile(data.Kod_Dokumen, IdPembelian);
                $('#profilSyaModal').modal('toggle');

            }

            if (data.Kod_Dokumen === DataBuku1.Kod_Dokumen && DataBuku1.Keutamaan == "2") {
                $('#syaratAmModal').modal('toggle');
                loadDataSyaratAm(data.Kod_Dokumen, IdPembelian);
            }

            if (data.Kod_Dokumen === DataBuku1.Kod_Dokumen && DataBuku1.Keutamaan == "3") {
                $('#jadualHargaModal').modal('toggle');
                LoadDataJadualHarga(IdPembelian);
            }

            if (data.Kod_Dokumen === DataBuku1.Kod_Dokumen && DataBuku1.Keutamaan == "4") {
                $('#jaminanModal').modal('toggle');
                loadDataJaminan(data.Kod_Dokumen, IdPembelian);
            }

            if (data.Kod_Dokumen === DataBuku1.Kod_Dokumen && DataBuku1.Keutamaan == "5") {
                $('#suratPembidaModal').modal('toggle');
                loadDataSuratAkaun(data.Kod_Dokumen, IdPembelian);

            }

            if (data.Kod_Dokumen === DataBuku1.Kod_Dokumen && DataBuku1.Keutamaan == "6") {
                $('#BorangPengalaman').modal('show');
                loadDataPengalaman(data.Kod_Dokumen, IdPembelian);
            }

            if (data.Kod_Dokumen === DataBuku1.Kod_Dokumen && DataBuku1.Keutamaan == "7") {
                $('#borangMultimodal').modal('toggle');
            }

            if (data.Kod_Dokumen === DataBuku1.Kod_Dokumen && DataBuku1.Keutamaan == "8") {
                $('#sijilTerkini').modal('toggle');
                loadDataSijilTerkini(data.Kod_Dokumen, IdPembelian)
            }
        }

        //Open modal Buku 2
        async function openPopupForm2(data) {

            if (data.length < 0) {
                displayMaklumanModal("Tiada Data");
            }

            var dataBuku2 = JSON.parse(await AjaxGetDataBuku2(data.Kod_Dokumen));

            if (dataBuku2.length > 0) {
                DataBuku2 = dataBuku2[0];
            } else {
                displayMaklumanModal("Tiada Maklumat");
            }

            if ($('#biltempoh').val() == "" && $('#ddlTermBayar').val() == null) {
                displayMaklumanModal("Sila Isi Tempoh Di Bahagian Yang Disediakan");
                return false;
            }

            if (data.Kod_Dokumen === DataBuku2.Kod_Dokumen && DataBuku2.Keutamaan == "13") {
                $('#borangTeknikal').modal('toggle');
                loadDataTeknikal(data.Kod_Dokumen, IdPembelian);
                loadDataAM(data.Kod_Dokumen, IdPembelian);
            }

            if (data.Kod_Dokumen === DataBuku2.Kod_Dokumen && DataBuku2.Keutamaan == "9") {
                $('#jadualKerja').modal('toggle');
                loadDataJK(data.Kod_Dokumen, IdPembelian);
            }

            if (data.Kod_Dokumen === DataBuku2.Kod_Dokumen && DataBuku2.Keutamaan == "10") {
                $('#authLetter').modal('toggle');
                loadDataAL(data.Kod_Dokumen, IdPembelian);
            }

            if (data.Kod_Dokumen === DataBuku2.Kod_Dokumen && DataBuku2.Keutamaan == "11") {
                $('#katalog').modal('toggle');
                loadDataKatalog(data.Kod_Dokumen, IdPembelian);
            }

            if (data.Kod_Dokumen === DataBuku2.Kod_Dokumen && DataBuku2.Keutamaan == "12") {
                $('#sample').modal('toggle');
                loadDataSample(data.Kod_Dokumen, IdPembelian);
            }
        }

        $('.btnSimpanMklmtPerolehan').on('click', async function () {

            const searchParams = new URLSearchParams(window.location.search);
            var IdPembelian = searchParams.get('IdPembelian');

            if ($('#biltempoh').val() == "" || $('#ddlTermBayar').val() == null) {
                displayMaklumanModal("Sila Isi Tempoh Di Bahagian Yang Disediakan");
                return false;
            }

            if (IdPembelian == "") {
                displayMaklumanModal("IdPembelian Tidak Sah");
                return false;
            }

            var newMklmtPO = {
                mklmtPO: {
                    IdPembelian: IdPembelian,
                    BilTempoh: $("#biltempoh").val(),
                    JenTempoh: $("#ddlTermBayar").val()
                }
            }

            var ResultSimpan = JSON.parse(await AjaxSaveMklmtPO(newMklmtPO));

            if (ResultSimpan.Status !== "Failed") {
                displayMaklumanModal(ResultSimpan.Message);

            } else {
                displayMaklumanModal(ResultSimpan.Message);
            }

            //alert("btnSimpanMklmtPerolehan Clicked");
            //return false;
        });

        async function AjaxSaveMklmtPO(mklmtPO) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'EPerolehan_WS.asmx/SaveMklmtPO',
                    method: 'POST',
                    data: JSON.stringify(mklmtPO),
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

        $('.btnHantar').on('click', async function () {

            const searchParams = new URLSearchParams(window.location.search);
            var IdPembelian = searchParams.get('IdPembelian');

            if (IdPembelian == "") {
                displayMaklumanModal("IdPembelian Tidak Sah");
                return false;
            }

            var StatHantar = JSON.parse(await AjaxHantarJawapan(IdPembelian));

            if (StatHantar.Code == "00") {
                displayMaklumanModal(StatHantar.Message);
            } else {
                displayMaklumanModal(StatHantar.Message);
            }

        });

        async function AjaxHantarJawapan(IdPembelian) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SaveJawapan',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ IdPembelian: IdPembelian }),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        async function AjaxLoadDataSah(KodDok, IdPembelian) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/GetSahDok',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({
                        KodDok: KodDok,
                        IdPembelian: IdPembelian
                    }),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        /* ===============================================================================================================================================================================
                js function for Buku 1 (Maklumat Profil Syarikat)
          =============================================================================================================================================================================== */

        var tblProfilSya = null;
        $(document).ready(function () {
            /* show_loader();*/
            tblProfilSya = $("#tblDataProfilSya").DataTable({
                "responsive": true,
                "searching": false,
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
                    "url": "EPerolehan_WS.asmx/GetProfilSyarikat",
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
                    { "data": "Nama_Dok" },
                    {
                        "data": "Nama_Dok",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            Bil = row.Bil;

                            //var link = `<a href="#" onclick="OpenFilePS('${fileName}', '${Bil}'); return false;">${fileName}</a>`;
                            var link = `<button id="btnViewPS" class="btn btnViewPS" onclick="OpenFilePS('${fileName}','${Bil}'); return false;"><i class="fa fa-eye"></i></button>`;
                            ;
                            return link;
                        }
                    },
                ]
            });
        });

        function OpenFilePS(fileName, Bil) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/MS/") %>' + '<%=Session("ssusrID")%>' + '/' + Bil + '/' + fileName;
            window.open(path, '_blank');

        }

        const searchParams = new URLSearchParams(window.location.search);
        var IdPembelian = searchParams.get('IdPembelian');

        $(document).ready(function () {
            $("input[name='chckProfil']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });


        $('.btnSimpanProfil').on('click', async function (simpan = false) {
            if ($("#chckProfil").val() == "on" || $("#chckProfil").val() == "false" || $("#chckProfil").val() == "0") {
                console.log("value checkbox: ", $('#chckProfil').val());
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {
                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '01',
                            KodBuku: 'BK1',
                            ValueSah: $('#chckProfil').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#profilSyaModal').modal("hide");
                        displayMaklumanModal(result.Message);
                        tblbuku1.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataProfile(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckProfil').prop('checked', true);
                } else {
                    $('#chckProfil').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
               js function for Buku 1 (Syarat Am)
           =============================================================================================================================================================================== */

        //const searchParams = new URLSearchParams(window.location.search);
        //var IdPembelian = searchParams.get('IdPembelian');

        $(document).ready(function () {
            $("input[name='chckSyaratAm']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });


        $('.btnSimpanSyaratAm').on('click', async function (simpan = false) {
            if ($("#chckSyaratAm").val() == "on" || $("#chckSyaratAm").val() == "false" || $("#chckSyaratAm").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {
                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '02',
                            KodBuku: 'BK1',
                            ValueSah: $('#chckSyaratAm').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#syaratAmModal').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku1.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataSyaratAm(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckSyaratAm').prop('checked', true);
                } else {
                    $('#chckSyaratAm').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
                js function for Buku 1 (Maklumat Jadual harga)
            =============================================================================================================================================================================== */
        var tableID = "#tblDataJadualHarga";

        async function CheckFormatHarga() {

            $(".jhHargaUnit").change(function () {
                var InputValue = $(this).val();
                if (InputValue === "") {
                    $(this).val("0.00");
                } else {
                    FormatedValue = parseFloat(InputValue).toFixed(2)
                    $(this).val((FormatedValue).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }));
                }
            });


            $(".jhHargaUnitC").change(function () {
                var inputValue = $(this).val().trim();
                if (inputValue === "") {
                    $(this).val("0.00");
                } else {
                    FormatedValue = parseFloat(inputValue).toFixed(2)
                    $(this).val(FormatedValue).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                }
            });


            $(".label-lblJumHarga-list").change(function () {
                if ($(this).val() === "") {
                    $(this).val("0.00");
                } else {
                    $(this).val(parseFloat($(this).val()).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                }
            });

            $(".label-lbljhJumHargaC-list").change(function () {
                if ($(this).val() === "") {
                    $(this).val("0.00");
                } else {
                    $(this).val(parseFloat($(this).val()).toLocaleString('es-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                }
            });
        }




        $(document).ready(function () {
            var tblDataJadualHarga = "#tblDataJadualHarga";
            var totalID = "#total";
            var totalCukai = "#TotalTax";
            var totalDiskaun = "#TotalDiskaun";
            var totalwoCukai = "#totalwoCukai";
            var totalRows = 0;
            var totalItem = 0;
            var curNumObject = 0;

            $(tblDataJadualHarga).on('keyup', '.KuantitiJH, .jhHargaUnit, .jhHargaUnitC, .label-lblJumHarga-list, .label-lbljhJumHargaC-list', async function () {

                var curTR = $(this).closest("tr");
                var Kuantiti = $(curTR).find("td > .KuantitiJH");
                var HargaUnit = $(curTR).find("td > .jhHargaUnit");
                var HergaUnitCukai = $(curTR).find("td > .jhHargaUnitC");
                var amountHarga = $(curTR).find("td > .label-lblJumHarga-list");
                var amountHargaCukai = $(curTR).find("td > .label-lbljhJumHargaC-list");

                var JumHargaUnit = NumDefault(Kuantiti.val()) * NumDefault(HargaUnit.val());
                var JumHargaUnitCukai = NumDefault(Kuantiti.val()) * NumDefault(HergaUnitCukai.val());

                //HargaUnit.val().toFixed(2);
                //HargaUnitCukai.val().toFixed(2);

                amountHarga.html((JumHargaUnit).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));
                amountHargaCukai.html((JumHargaUnitCukai).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));

                calculateGrandTotal();

                //START BIL COUNT DATATABLE...
                var columnIndexToCount = 0; // Change this to the desired column index (0-based)
                var rowCount = 0;

                $("#tblRowJadualHarga").find("tr").each(function () {
                    var cellValue = $(this).find("td:eq(" + columnIndexToCount + ")").text();
                    console.log("Start DataTable Row");
                    // Check if the cell has data
                    if (cellValue.trim() !== "") {
                        rowCount++;
                        CheckFormatHarga();
                    }
                });

                totalItems = rowCount;

                $('#stickyJumlahItem').text(totalItems);
                //END BIL COUNT
            });
        });

        var totalID = "#total";
        var totalCukai = "#TotalTax";
        var totalDiskaun = "#TotalDiskaun";
        var totalwoCukai = "#totalwoCukai";

        async function calculateGrandTotal() {
            var grandTotal = $(totalID);
            var totalCukai_ = $(totalCukai);
            var totalDiskaun_ = $(totalDiskaun);
            var totalwoCukai_ = $(totalwoCukai);
            var curTotal = 0;
            var curCukai = 0;
            var curDiskaun = 0;
            var curwoCukai = 0;

            $('.amount').each(function (index, obj) {
                curTotal += parseFloat(NumDefault($(obj).val()));
            });
            $('.JUMcukai').each(function (index, obj) {
                curCukai += parseFloat(NumDefault($(obj).val()));
            });

            $('.JUMdiskaun').each(function (index, obj) {
                curDiskaun += parseFloat(NumDefault($(obj).val()));
            });

            $('.amountwocukai').each(function (index, obj) {
                curwoCukai += parseFloat(NumDefault($(obj).val()));
            });



            //$("[id*=TotalCoreProd]").html(TotalCoreProd.toFixed(2));
            totalCukai_.val(curCukai.toFixed(2));
            totalDiskaun_.val(curDiskaun.toFixed(2));
            totalwoCukai_.val(curwoCukai.toFixed(2));

            curTotal = roundCurrency(curTotal);

            grandTotal.val(curTotal.toFixed(2));

            //STICKYJUMLAH
            document.getElementById('stickyJumlah').textContent = curTotal.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
            //document.getElementById('jumBayaran').textContent = curTotal.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
            //document.getElementById('jumTerimaan').textContent = curTotal.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
            $('#jumBayaran').val(curTotal);
            $('#jumTerimaan').val(curTotal);
        }

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

        async function initNegara(id) {
            $('#' + id).dropdown({
                fullTextSearch: true,
                onChange: function (value, text, $selectedItem) {

                    console.log("aa");

                    var curTR = $(this).closest("tr");

                    var recordIDVotHd = curTR.find("td > .negara-carian-list");

                },
                apiSettings: {

                    url: 'EPerolehan_WS.asmx/GetNegara?q={query}',
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

                        //if (shouldPop === true) {
                        //    $(obj).dropdown('show');
                        //}
                    }
                }



            });
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

        var curNumObject = 0;
        async function AddRow(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblDataJadualHarga');

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;
            }

            totalItems = 0;

            while (counter <= totalClone) {
                curNumObject += 1;

                //var newCarianVot = "ddlVotCarian" + curNumObject;
                var newNegara = "ddljhNegara" + curNumObject

                var row = $('#tblDataJadualHarga tbody>tr:first').clone();
                //var votcarianlist = $(row).find(".vot-carian-list").attr("id", newCarianVot);

                $(row).find(".negara-carian-list").attr("id", newNegara);

                row.attr("style", "");
                var val = "";

                $('#tblDataJadualHarga tbody').append(row);

                await initNegara(newNegara);

                $(newNegara).api("query");

                if (objOrder !== null && objOrder !== undefined) {
                    if (counter <= objOrder.Payload.length) {
                        await setValueToRow_JadualHarga(row, objOrder.Payload[counter - 1]);
                        totalItems += 1;
                    }
                }

                counter += 1;
            }

            $('#stickyJumlahItem').text(totalItems);
        }

        async function setValueToRow_JadualHarga(row, JadualDetail) {

            console.log("Jadualdetail", JadualDetail.Kod_Negara_Pembuat);
            if (JadualDetail) {
                var Bil = $(row).find('td > .trBil');
                Bil.html($(row).index());

                var id = $(row).find('td > .data-id');
                id.val(JadualDetail.Id_Mohon_Dtl);

                var butirBarang = $(row).find('td > .label-lblSpekFakulti-list');
                butirBarang.html(JadualDetail.Butiran);

                var Jenama = $(row).find('td > .JenamaJH')
                Jenama.val(JadualDetail.Jenama);

                var Model = $(row).find('td > .ModelJH')
                Model.val(JadualDetail.Model);

                if (JadualDetail.Kod_Negara_Pembuat != "" && JadualDetail.Kod_Negara_Pembuat !== null) {
                    var ddlNegara = $(row).find('td > .negara-carian-list')
                    var selectObj_Negara = $(row).find('td > .negara-carian-list > select');
                    $(ddlNegara).dropdown('set selected', JadualDetail.Kod_Negara_Pembuat);
                    selectObj_Negara.append("<option value = '" + JadualDetail.Kod_Negara_Pembuat + "'>" + JadualDetail.ButiranNegara + "</option>");
                } else {
                    $('#ddljhNegara').dropdown('clear');
                }

                var Kuantiti = $(row).find('td > .KuantitiJH');
                Kuantiti.val(JadualDetail.Kuantiti || "0");

                var butirUkuran = $(row).find('td > .label-lbljhBungkus-list');
                butirUkuran.html(JadualDetail.ButiranUkuran);

                var KodUkuran = $(row).find('td > .Hid-lbljhBungkus-list');
                KodUkuran.html(JadualDetail.Ukuran);

                var HargaUnit = $(row).find('td > .jhHargaUnit');
                HargaUnit.val((JadualDetail.Harga_Seunit || 0).toFixed(2));

                var HargaUnitCukai = $(row).find('td > .jhHargaUnitC');
                HargaUnitCukai.val((JadualDetail.Harga_Seunit_Bercukai || 0).toFixed(2));

                var JumHarga = $(row).find('td > .label-lblJumHarga-list');
                JumHarga.html((JadualDetail.Jumlah_Harga || 0).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));

                var JumHargaBercukai = $(row).find('td > .label-lbljhJumHargaC-list');
                JumHargaBercukai.html((JadualDetail.Jumlah_Harga_Bercukai || 0).toLocaleString('ms-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 }));

            }
        }

        async function LoadDataJadualHarga(IdPembelian) {
            if (IdPembelian !== "") {
                var result = await AjaxFetchDataJadual(IdPembelian);

                if (result.Payload.length > 0) {
                    await ClearAllRows();
                    await AddRow(null, result);
                } else {
                    displayMaklumanModal("Tiada data");
                }
            }
        }

        async function ClearAllRows() {
            var tableID = "#tblDataJadualHarga";
            $(tableID + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    $(obj).remove(); // Wrap obj with $ to make it a jQuery object
                }
            });

            // Reset the value in the detailModal
            //$(totalID).val("0.00");
            //$(totalCukai).val("0.00");
            //$(totalDiskaun).val("0.00");
            //$(totalwoCukai).val("0.00");
        }

        async function AjaxFetchDataJadual(IdPembelian) {
            try {

                const response = await fetch('EPerolehan_WS.asmx/GetDataJadual', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ IdPembelian: IdPembelian })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        function checkInputFields() {

            var allFieldsFilled = true;

            // Iterate over each row in the table body
            $('#tblDataJadualHarga tbody tr').each(function () {
                var row = $(this);
                // Find all input fields within the current row
                var inputFields = row.find('input');

                // Check if any input field within the row is empty
                inputFields.each(function () {
                    if ($(this).val() === "") {
                        allFieldsFilled = false;
                        return false; // Exit the loop early if an empty field is found
                    }
                });

                // Check if any dropdown within the row is empty
                var selectFields = row.find('select');
                selectFields.each(function () {
                    if ($(this).val() === "") {
                        allFieldsFilled = false;
                        return false; // Exit the loop early if an empty field is found
                    }
                });

                // If an empty field is found, exit the loop over rows
                if (!allFieldsFilled) {
                    return false;
                }
            });

            return allFieldsFilled;
        }

        $('#btnSimpan').on('click', function () {
            // Check if all input fields are filled before proceeding
            if (checkInputFields()) {
                // Proceed with the save action
                console.log('All input fields are filled. Proceeding with save action.');
                // Add your save action code here
            } else {
                // Prompt the user to fill in all input fields
                console.log('Please fill in all input fields before saving.');
                // You can also show a modal or alert to notify the user
            }
        });

        var IsComplete = 0;
        $('.btnSimpanJh').on('click', async function () {
            /*if (checkInputFields()) {*/
            let confirm = false;
            var acceptRecord = 0;
            confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
            console.log("value confirm: ", confirm);

            if (!confirm) {
                return false;
            } else {

                var DataJadual = {
                    Jadual: {
                        IdSya: '<%=Session("ssusrID")%>',
                        JadualDetail: []
                    }
                }

                $('.negara-carian-list').each(function (index, obj) {
                    console.log("Index: ", index);
                    console.log("obj: ", obj);

                    if (index > 0) {
                        var rawJumHarga = $('.label-lblJumHarga-list').eq(index).html();
                        var rawJumHargaCukai = $('.label-lbljhJumHargaC-list').eq(index).html();
                        var tcell = $(obj).closest("td");
                        var JadualDetails = {
                            IdDtl: $(tcell).find(".data-id").val(),
                            Jenama: $('.JenamaJH').eq(index).val(),
                            Model: $('.ModelJH').eq(index).val(),
                            Negara: $(obj).dropdown("get value"),
                            Kuantiti: $('.KuantitiJH').eq(index).val(),
                            HargaUnit: $('.jhHargaUnit').eq(index).val(),
                            HargaUnitCukai: $('.jhHargaUnitC').eq(index).val(),
                            JumHarga: parseFloat(rawJumHarga.replace(/[^\d.-]/g, '')),
                            JumHargaCukai: parseFloat(rawJumHargaCukai.replace(/[^\d.-]/g, '')),
                        }

                        if (JadualDetails.IdDtl === "" || JadualDetails.Jenama === "" || JadualDetails.Model === ""
                            || JadualDetails.Negara === "" || JadualDetails.Kuantiti === "" || JadualDetails.HargaUnit === ""
                            || JadualDetails.HargaUnitCukai === "" || JadualDetails.JumHarga === "" || JadualDetails.JumHargaCukai === "") {
                            displayMaklumanModal("Sila Lengkapkan Setiap Ruang Jawapan Yang Disediakan");
                            return;
                        }

                        acceptRecord += 1
                        DataJadual.Jadual.JadualDetail.push(JadualDetails);
                    }
                });
            }

            console.log("DataJadual: ", DataJadual);
            var result = JSON.parse(await AjaxSaveJadual(DataJadual));

            if (result.Status !== "Failed") {
                //$('#jadualHargaModal').modal("toggle");
                displayMaklumanModal(result.Message);
                IsComplete = 1;
                tblbuku1.ajax.reload();
            } else {
                displayMaklumanModal(result.Message);
            }
        });

        async function AjaxSaveJadual(Jadual) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SaveDataJadual',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(Jadual),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        $(document).ready(function () {
            $("input[name='chckJadualHarga']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $('.btnSimpanSahJH').on('click', async function () {
            if ($("#chckJadualHarga").val() == "on" || $("#chckJadualHarga").val() == "false" || $("#chckJadualHarga").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {
                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");

                if (!confirm) {
                    return false;
                } else {

                    if (IsComplete == 0) {
                        displayMaklumanModal("Sila Lengkapkan Jadual Harga Dengan Lengkap");
                        return false;
                    }

                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '03',
                            KodBuku: 'BK1',
                            ValueSah: $('#chckJadualHarga').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#jadualHargaModal').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku1.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataJH(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckSyaratAm').prop('checked', true);
                } else {
                    $('#chckSyaratAm').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
              js function for Buku 1 (Jaminan Pembekal)
          =============================================================================================================================================================================== */

        $(document).ready(function () {
            $("input[name='chckJaminan']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });


        $('.btnSimpanJaminan').on('click', async function (simpan = false) {
            if ($("#chckJaminan").val() == "on" || $("#chckJaminan").val() == "false" || $("#chckJaminan").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {
                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '04',
                            KodBuku: 'BK1',
                            ValueSah: $('#chckJaminan').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#jaminanModal').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku1.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataJaminan(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckJaminan').prop('checked', true);
                } else {
                    $('#chckJaminan').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
              js function for Buku 1 (Surat Akaun Pembida) 
          =============================================================================================================================================================================== */

        $(document).ready(function () {
            $("input[name='chckSuratAkuan']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });


        $('.btnSimpanSuratAkuan').on('click', async function (simpan = false) {
            if ($("#chckSuratAkuan").val() == "on" || $("#chckSuratAkuan").val() == "false" || $("#chckSuratAkuan").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {
                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '05',
                            KodBuku: 'BK1',
                            ValueSah: $('#chckSuratAkuan').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#suratPembidaModal').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku1.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataSuratAkaun(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckSuratAkuan').prop('checked', true);
                } else {
                    $('#chckSuratAkuan').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
                js function for Buku 1 (Maklumat Pengalaman)
        =============================================================================================================================================================================== */

        var tblPengalaman = null;
        $(document).ready(function () {
            /* show_loader();*/
            tblPengalaman = $("#tblListPengalaman").DataTable({
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
                    "url": "EPerolehan_WS.asmx/LoadList_SenaraiPengalaman",
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
                    { "data": "TajukProjek" },
                    { "data": "NamaSyarikat" },
                    { "data": "TarikhMula" },
                    { "data": "TarikhTamat" },
                    { "data": "NilaiJualan" },
                    {
                        className: "btnEdit",
                        "data": "IdPengalaman",
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditPengalaman" runat="server" class="btn btnEditPengalaman" type="button" style="color: blue" data-id="${data}">
                                 <i class="fa fa-edit"></i>
                     </button>
                     <button id="btnDeletePengalaman" runat="server" class="btn btnDeletePengalaman" type="button" style="color: red" data-id="${data}">
                                 <i class="fa fa-trash"></i>
                     </button>`;

                            return link;
                        }
                    }
                ]
            });
        });

        $('#tblListPengalaman').on('click', '.btnEditPengalaman', async function (event) {
            //event.stopPropagation();
            var idPengalaman = $(this).data("id");
            var IdSya = '<%=Session("ssusrID")%>';

            if (idPengalaman !== "") {
                var Record = JSON.parse(await AjaxLoadDataPengalaman(IdSya, idPengalaman));
                if (Record.length > 0) {
                    RecordPengalaman = Record[0];
                    setValue_ToForm(RecordPengalaman);
                    $('.btnBatalPengalaman').show()
                } else {
                    console.log("Problem data Ajax Pengalman");
                }
            } else {
                displayMaklumanModal("Tiada Maklumat Bilangan");
            }

        });

        $('.btnBatalPengalaman').click(async function () {
            clearAllfieldsPengalaman();
            $('.btnBatalPengalaman').hide();
        });
        $('#noDaftarPengalaman').val('<%=Session("ssusrID")%>');
        async function setValue_ToForm(RecordPengalaman) {
            $('#noDaftarPengalaman').val('<%=Session("ssusrID")%>');
            $('#txtTajukPerolehan').val(RecordPengalaman.TajukProjek);
            $('#txtSyaPerolehan').val(RecordPengalaman.NamaSyarikat);
            $('#tkhMula').val(RecordPengalaman.TarikhMula);
            $('#tkhTamat').val(RecordPengalaman.TarikhTamat);
            $('#txtNilaiProjek').val(RecordPengalaman.NilaiJualan);
        }

        async function clearAllfieldsPengalaman() {
            $('#txtTajukPerolehan').val("");
            $('#txtSyaPerolehan').val("");
            $('#tkhMula').val("");
            $('#tkhTamat').val("");
            $('#txtNilaiProjek').val("");
        }

        async function AjaxLoadDataPengalaman(IdSya, IdPengalaman) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: '<%= ResolveClientUrl("~/FORMS/E-VENDOR/PENDAFTARAN/PENDAFTARAN_WS.ASMX/LoadDataPengalaman")%>',
                    method: 'POST',
                    data: JSON.stringify({
                        IdSya: IdSya,
                        idPengalaman: IdPengalaman
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

        $('.btnSimpanDataPengalaman').click(async function () {
            if ($('#txtTajukPerolehan').val() == "" || $('#txtSyaPerolehan').val() == "" || $('#tkhMula').val() == "" || $("#tkhTamat").val() == "" || $('#txtNilaiProjek').val() == "") {
                displayMaklumanModal("Sila Lengkapkan Maklumat Yang Diperlukan");
            } else {
                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");

                if (!confirm) {
                    return false;
                } else {
                    var newPengalaman = {
                        pengalaman: {
                            IdPengalaman: '',
                            IdSemSya: '<%=Session("ssusrID")%>',
                            Tajuk: $('#txtTajukPerolehan').val(),
                            NamaSyarikat: $('#txtSyaPerolehan').val(),
                            TkhMula: $('#tkhMula').val(),
                            TkhTamat: $("#tkhTamat").val(),
                            NilaiProjek: $('#txtNilaiProjek').val(),
                            OrderID: 'MA12345',
                        }
                    }

                    var result = JSON.parse(await AjaxSavePengalaman(newPengalaman));

                    if (result.Status !== "Failed") {
                        clearAllfieldsPengalaman();
                        displayMaklumanModal(result.Message);
                        tblPengalaman.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function AjaxSavePengalaman(pengalaman) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: '<%= ResolveClientUrl("~/FORMS/E-VENDOR/PENDAFTARAN/PENDAFTARAN_WS.ASMX/SavePengalaman")%>',
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
            });
        }

        $(document).ready(function () {
            $("input[name='chckPengalaman']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });


        $('.btnSimpanPengalaman').on('click', async function (simpan = false) {
            if ($("#chckPengalaman").val() == "on" || $("#chckPengalaman").val() == "false" || $("#chckPengalaman").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {
                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '06',
                            KodBuku: 'BK1',
                            ValueSah: $('#chckPengalaman').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#BorangPengalaman').modal("show");
                        displayMaklumanModal(result.Message);
                        tblbuku1.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataPengalaman(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckPengalaman').prop('checked', true);
                } else {
                    $('#chckPengalaman').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
               js function for Buku 1 (Maklumat MTO)
       =============================================================================================================================================================================== */

        //Save Data MTO

        //Save Pengesahan

        /* ===============================================================================================================================================================================
                js function for Buku 1 (Salinan Sijil Terkini)
        =============================================================================================================================================================================== */

        //LoadDataFile To be Update or not
        //Upload File - Update Latest File

        $(document).ready(function () {
            $("input[name='chckBank']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        var tblSalinanSijil = null;
        $(document).ready(function () {
            /* show_loader();*/
            tblSalinanSijil = $("#tblListPenyataBank").DataTable({
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
                    "url": "EPerolehan_WS.asmx/GetSijilBank",
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
                    { "data": "Nama_Dok" },
                    {
                        "data": "Nama_Dok",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            Bil = row.Bil;

                            //var link = `<a href="#" onclick="OpenFilePS('${fileName}', '${Bil}'); return false;">${fileName}</a>`;
                            var link = `<button id="btnViewPS" class="btn btnViewPS" onclick="OpenFileBank('${fileName}','${Bil}'); return false;"><i class="fa fa-eye"></i></button>`;
                            ;
                            return link;
                        }
                    },
                ]
            });
        });

        function OpenFileBank(fileName, Bil) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/MS/") %>' + '<%=Session("ssusrID")%>' + '/' + Bil + '/' + fileName;
            window.open(path, '_blank');

        }

        $('.btnUploadSijil').on('click', async function () {
            var inputFileBank = $('#fileInputBank');
            var fileInputValue = inputFileBank.val();
            console.log("Input File:", inputFileBank);

            if (fileInputValue == "") {
                displayMaklumanModal("Sila Muat Naik Sijil Tekini Penyata Bank");
                return;
            }

            var fileNameBank = await getFileName($('#fileInputBank'));
            var fileExtentionBank = await getFileExtension(inputFileBank);

            var fileInputBank = {
                name: fileNameBank,
                extension: fileExtentionBank,
                path: '~/UPLOAD/DOCUMENT/E-VENDOR/BANK/'
            };

            var fileBank = {
                Bank: {
                    IdPembelian: IdPembelian,
                    ListFile: []
                }
            }

            var ListFile = {
                IdSya: '<%=Session("ssusrID")%>',
                NoRujukan: IdPembelian,
                JenDok: 'BANK',
                FileName: fileInputBank.name,
                Bil: '',
                FilePath: fileInputBank.path,
                JenFile: fileInputBank.extension,

            }

            fileBank.Bank.ListFile.push(ListFile);

            console.log(fileBank);
            var result = JSON.parse(await AjaxSaveBank(fileBank));

            if (result.Status !== "failed") {
                debugger;
                try {
                    var messageFile;
                    messageFile = await uploadBank();
                    console.log("messageFile: ", messageFile)

                    if (messageFile.message !== "OK") {
                        displayMaklumanModal("Gagal Muat Naik!");
                        return;
                    }

                } catch (error) {
                    console.error("Error during file upload:", error);
                    displayMaklumanModal("Gagal Memuatnaik Fail Jadual Kerja");
                    return;
                }

                displayMaklumanModal("File Berjaya Di Muat Naik");
                tblSalinanSijil.ajax.reload()
            } else {
                displayMaklumanModal("File Gagal Di Muat Naik");
            }
        });

        async function uploadBank() {
            var fileInputId = "fileInputBank";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/BANK/";
            var hidJenDokId = "hidJenDokBank";
            var hidFileNameId = "hidFileNameBank";
            var progressContainerId = "progressContainerBank";
            var uploadedFileNameLabelId = "uploadedFileNameLabelBank";
            var KodDaftar = "BANK"
            var wsMethod = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/EPerolehan_WS.asmx/UploadFileBank")%>';
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar);

            return result;
        }

        async function AjaxSaveBank(JK) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SaveSijilBank',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(JK),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        //Pengesahan - 08
        $('.btnSimpanBank').on('click', async function () {

            if ($("#chckBank").val() == "on" || $("#chckBank").val() == "false" || $("#chckBank").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {

                if (tblSalinanSijil.rows().count() <= 0) {
                    displayMaklumanModal("Sila Upload Jadual Perancangan Kerja Syarikat");
                    return false;
                }

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '08',
                            KodBuku: 'BK1',
                            ValueSah: $('#chckBank').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#sijilTerkini').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku1.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        })

        async function loadDataSijilTerkini(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckBank').prop('checked', true);
                } else {
                    $('#chckBank').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
                js function for Buku 2 (Maklumat Spesifikasi Teknikal)
            =============================================================================================================================================================================== */

        var IdPembelian = searchParams.get('IdPembelian');
        var tblJawapanTeknikal = null;
        $(document).ready(function () {
            tblJawapanTeknikal = $('#spekfikasi-table-teknikal').DataTable({
                "responsive": true,
                "searching": false,
                "paging": false,
                "ordering": false,
                "info": false,
                stateSave: true,
                "ajax": {
                    "url": 'EPerolehan_WS.asmx/GetHdrSpekTeknikal',
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ IdPembelian: IdPembelian });
                    },
                    "dataSrc": function (json) {
                        //console.log("test spekfikasi");
                        return JSON.parse(json.d);
                    }
                },
                "columns": [
                    {
                        "data": null,
                        "width": "10%",
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            sessionStorage.setItem('NoMohon', data.No_Mohon);
                            sessionStorage.setItem('IdMohonDtl', data.Id_Mohon_Dtl);

                            return `<button class="btnDetailsTeknikal btndt${data.Id_Mohon_Dtl}" data-level="2" data-kod = "' + data + '"><i class="fas fa-plus"></i></button>`;
                        },
                    },
                    {
                        "data": null,
                        "width": "10%",
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        },
                    },
                    {
                        "data": "Butiran"
                    },
                    {
                        "data": "Jenama"
                    },
                    {
                        "data": "Model"
                    },
                    {
                        "data": "ButiranNegara"
                    },
                ],
                "initComplete": function (settings, json) {
                    // This function will be called after the DataTable has successfully loaded the data.
                    console.log(json);
                    var Data = JSON.parse(json.d);
                    console.log("DataTable initialized successfully");
                    //generateChildTableTeknikal(Data.Id_Mohon_Dtl);
                    // Add your "on success" functionality here
                    // For example, you can execute some code or trigger an event
                }
            });
        });

        var classSelectedSpekDetailsTeknikal = "";
        var prevRowTeknikal = null;
        var childTableTeknikal = null;
        //console.log('hello world 1');
        $('#spekfikasi-table-teknikal').on('click', '.btnDetailsTeknikal', function (evt) {
            evt.preventDefault();
            classSelectedSpekDetailsTeknikal = $(this).attr("class"); //console.log("classSelectedSpekDetailsTeknikal: ", classSelectedSpekDetailsTeknikal);
            var trTeknikal = $(this).closest('tr'); //console.log("trTeknikal: ", trTeknikal);
            var rowTeknikal = tblJawapanTeknikal.row(trTeknikal); //console.log("rowTeknikal: ", rowTeknikal);
            var rowDataTeknikal = rowTeknikal.data(); //console.log("rowDataTeknikal: ", rowDataTeknikal);
            var pickedKodTeknikal = rowDataTeknikal.Id_Mohon_Dtl; //console.log("pickedKodTeknikal: ", pickedKodTeknikal);
            var pickedKodTest = rowDataTeknikal.No_Mohon; //console.log("pickKodTest: ", pickedKodTest);

            if (rowTeknikal.child.isShown()) {
                // This row is already open - close it
                rowTeknikal.child.hide();
                trTeknikal.removeClass('shown');
                $(this).html('<i class="fas fa-plus"></i>');
                // Destroy the Child Datatable
                childTableTeknikal = null;
                $('#cl' + pickedKodTest).DataTable().destroy();
            } else {
                if (prevRowTeknikal !== null) {
                    // This row is already open - close it
                    prevRowTeknikal.child.hide();
                    prevTrTeknikal.removeClass('shown');
                    prevBtnTeknikal.html('<i class="fas fa-plus"></i>');
                    // Destroy the Child Datatable
                    $(prevIdTeknikal).DataTable().destroy();
                }

                prevBtnTeknikal = $(this);
                prevTrTeknikal = trTeknikal;
                prevIdTeknikal = '#cl' + pickedKodTest;
                prevRowTeknikal = rowTeknikal;

                $(this).html('<i class="fas fa-minus"></i>');

                rowTeknikal.child(formatTeknikal(pickedKodTest)).show();
                trTeknikal.addClass('shown');

                generateChildTableTeknikal(pickedKodTest, pickedKodTeknikal);
            }

            return false;
        });

        function generateChildTableTeknikal(pickedKodTest, pickedKodTeknikal) {
            var NoMohon = sessionStorage.getItem('NoMohon');
            //var IdMohonDtl = sessionStorage.getItem('IdMohonDtl');
            //console.log('hello world 2: ', IdMohonDtl);

            childTableTeknikal = $('#cl' + pickedKodTest).DataTable({
                dom: "t",
                paging: false,
                ajax: {
                    url: 'EPerolehan_WS.asmx/LoadData_ListDetailTeknikal',
                    type: 'POST',
                    data: function (d) {
                        // console.log('hello world');
                        return "{ no_mohon: '" + NoMohon + "',kod: '" + pickedKodTeknikal + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }
                },
                columns: [
                    {
                        "data": "Id_Teknikal",
                    },
                    {
                        "data": "Butiran",
                        "width": "60%"
                    },
                    {
                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (data.Jawapan === null) {
                                return '<textarea class =" input-group__input form-control input-sm txtJawapanTeknikal" data-id="' + data.Id_Teknikal + '"></textarea>';
                            } else {
                                return '<textarea class =" input-group__input form-control input-sm txtJawapanTeknikal" data-id="' + data.Id_Teknikal + '" readonly> ' + data.Jawapan + '</textarea>';
                            }
                        }
                    },
                    {
                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (data.Sampel === null || data.Sampel === "0") {
                                return '<input type="checkbox" class="input-group__input form-control input-sm chckSampleYa" name="chckSampleTeknikal' + row.Id_Teknikal + '" data-id="' + row.Id_Teknikal + '" style="display: inline-block; margin-right: 10px;"/>';
                            } else {
                                return '<input type="checkbox" class="input-group__input form-control input-sm chckSampleYa" name="chckSampleTeknikal' + row.Id_Teknikal + '" data-id="' + row.Id_Teknikal + '" style="display: inline-block; margin-right: 10px;" checked/>';
                            }
                        }
                    },
                    {
                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (data.Katalog === null || data.Katalog === "0") {
                                return '<input type="checkbox" class="input-group__input form-control input-sm chckKatalogYa" name="chckkatalogTeknikal' + row.Id_Teknikal + '" data-id="' + row.Id_Teknikal + '" style="display: inline-block; margin-right: 10px;"/>';
                            } else {
                                return '<input type="checkbox" class="input-group__input form-control input-sm chckKatalogYa" name="chckkatalogTeknikal' + row.Id_Teknikal + '" data-id="' + row.Id_Teknikal + '" style="display: inline-block; margin-right: 10px;" checked/>';
                            }
                        }
                    },
                ],
                columnDefs: [
                    {
                        "targets": 0,
                        visible: false,
                        searchable: false
                    },
                ],
                select: false,
            });

            childTableTeknikal.on('draw.dt', function () {
                var $parentTotalItem = $('#spekfikasi-table-teknikal').find("tbody tr").eq(prevRowTeknikal.index());
                var jumlah = childTableTeknikal.rows().count();
                $parentTotalItem.find(".jumlah").html("Jumlah : " + jumlah);
            });
        }

        function formatTeknikal(id) {
            var childTableHTML = '<table id="cl' + id + '" class="compact w-100" width="100%">' +
                '<thead>' +
                '<tr>' +
                '<td style="display: none;">Id_Teknikal</td>' +
                '<td class="jawapan-IdAm">Butiran</td>' +
                '<td class="jawapan-IdAm">Jawapan</td>' +
                '<td class="jawapan-IdAm">Sample</td>' +
                '<td class="jawapan-IdAm">Katalog</td>' +
                '<td></td>' +
                '</tr>' +
                '</thead>' +
                '</table>';
            return childTableHTML;
        }

        function checkAllFieldsFilled() {
            var allFieldsFilled = true;
            $('.txtJawapanTeknikal').each(function () {
                if ($(this).val().trim() === '') {
                    allFieldsFilled = false;
                    return false; // Exit the loop early if any field is empty
                }
            });

            return allFieldsFilled;
        }

        $(document).ready(function () {
            $("input[name='chckSampleTeknikal']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $(document).ready(function () {
            $("input[name='chckkatalogTeknikal']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $('.btnSimpanJwpnTeknikal').on('click', async function (simpan = false) {

            if (IdPembelian == "") {
                displayMaklumanModal("Maklumat Id Pembelian Tidak Sah");
                return;
            } else {
                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");

                if (!confirm) {
                    return false;
                } else {
                    var isValid = true;
                    var jawapanTeknikalDtlArray = [];

                    $('#spekfikasi-table-teknikal .txtJawapanTeknikal').each(function (index, obj) {
                        var IdTeknikal = $(obj).attr('data-id');
                        var jawapanTeknikal = $(obj).val();

                        // Check if any field is empty
                        if (IdTeknikal.trim() === "" || jawapanTeknikal.trim() == "") {
                            displayMaklumanModal("Sila Lengkapkan Setiap Ruang Jawapan Yang Disediakan");
                            isValid = false;
                            return false; // Exit the loop early
                        }

                        // Detect sampel checkbox value
                        var sampelCheckbox = $(obj).closest('tr').find('.chckSampleYa');
                        var sampel = sampelCheckbox.prop('checked') ? 1 : 0;

                        // Detect katalog checkbox value
                        var katalogCheckbox = $(obj).closest('tr').find('.chckKatalogYa');
                        var katalog = katalogCheckbox.prop('checked') ? 1 : 0;

                        // Push data to array
                        jawapanTeknikalDtlArray.push({
                            IdTeknikal: IdTeknikal,
                            JawapanTeknikal: jawapanTeknikal,
                            Sampel: sampel,
                            Katalog: katalog
                        });
                    });

                    if (!isValid) {
                        return; // Exit function if data is not valid
                    }

                    if (jawapanTeknikalDtlArray.length <= 0) {
                        displayMaklumanModal("Sila Berikan Jawapan di bahagia yang disediakan");
                        return;
                    }
                    // Proceed with the data, as it's all valid
                    var newJawapanTeknikal = {
                        DataJawapanTeknikal: {
                            IdPembelian: IdPembelian,
                            JawapanTeknikalDetail: jawapanTeknikalDtlArray
                        }
                    };

                    console.log("DataJadual: ", newJawapanTeknikal);
                    var result = JSON.parse(await AjaxSaveJawapanTeknikal(newJawapanTeknikal));

                    if (result.Status !== "Failed") {
                        $('#borangTeknikal').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblKatalog.ajax.reload();
                        tblSampel.ajax.reload();
                        tblbuku2.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });


        async function AjaxSaveJawapanTeknikal(DataJawapanTeknikal) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SaveJawapanTeknikal',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(DataJawapanTeknikal),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        $(document).ready(function () {
            $("input[name='chckJwpnTeknikal']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $('.btnSimpanSahTeknikal').on('click', async function () {

            if ($("#chckJwpnTeknikal").val() == "on" || $("#chckJwpnTeknikal").val() == "false" || $("#chckJwpnTeknikal").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {

                // Check jawapan value in child table
                //if (tblJadualKerja.rows().count() <= 0) {
                //    displayMaklumanModal("Sila Upload Jadual Perancangan Kerja Syarikat");
                //    return false;
                //}

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '13',
                            KodBuku: 'BK2',
                            ValueSah: $('#chckJwpnTeknikal').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#borangTeknikal').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku2.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataTeknikal(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckJwpnTeknikal').prop('checked', true);
                } else {
                    $('#chckJwpnTeknikal').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
                js function for Buku 2 (Maklumat Spesifikasi Am)
            =============================================================================================================================================================================== */

        var IdPembelian = searchParams.get('IdPembelian');

        $(document).ready(function () {
            tbl_tab2 = $("#spekfikasi-table-am").DataTable({
                "responsive": true,
                "searching": false,
                "paging": false,
                "ordering": false,
                "info": false,
                stateSave: true,
                "ajax": {
                    "url": 'EPerolehan_WS.asmx/GetHdrSpekAm',
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ IdPembelian: IdPembelian });
                    },
                    "dataSrc": function (json) {
                        console.log("test spekfikasi");
                        return JSON.parse(json.d);
                    }
                },
                "columns": [
                    {
                        "data": null,
                        "width": "70%",
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            sessionStorage.setItem('NoMohon', data.No_Mohon);

                            return `<button class="btnDetails btndt${data.kod_Spesifikasi}" data-level="2" data-kod = "' + data + '"><i class="fas fa-plus"></i></button>
                        <label class="lblNo1 spacekanan">${data.Butiran}</label>`;
                        },
                    },
                ],
                "initComplete": function (settings, json) {
                    // This function will be called after the DataTable has successfully loaded the data.
                    console.log(json);
                    var Data = JSON.parse(json.d);
                    console.log("DataTable initialized successfully");
                    generateChildTable(Data.Kod_Spesifikasi);
                    // Add your "on success" functionality here
                    // For example, you can execute some code or trigger an event
                }
            });
        });

        var classSelectedSpekDetails = "";
        var prevRow = null;
        var childTable = null;

        $('#spekfikasi-table-am').on('click', '.btnDetails', function (evt) {
            evt.preventDefault();

            classSelectedSpekDetails = $(this).attr("class");
            var tr = $(this).closest('tr');
            var row = tbl_tab2.row(tr);
            var rowData = row.data();
            var pickedKodvot = rowData.Kod_Spesifikasi;

            if (row.child.isShown()) {
                // This row is already open - close it
                row.child.hide();
                tr.removeClass('shown');
                $(this).html('<i class="fas fa-plus"></i>');
                // Destroy the Child Datatable
                childTable = null;
                $('#cl' + pickedKodvot).DataTable().destroy();
            } else {
                if (prevRow !== null) {
                    // This row is already open - close it
                    prevRow.child.hide();
                    prevTr.removeClass('shown');
                    prevBtn.html('<i class="fas fa-plus"></i>');
                    // Destroy the Child Datatable
                    $(prevId).DataTable().destroy();
                }

                prevBtn = $(this);
                prevTr = tr;
                prevId = '#cl' + pickedKodvot;
                prevRow = row;

                $(this).html('<i class="fas fa-minus"></i>');

                row.child(format(pickedKodvot)).show();
                tr.addClass('shown');

                generateChildTable(pickedKodvot);
            }

            return false;
        });

        function generateChildTable(pickedKodvot) {
            var NoMohon = sessionStorage.getItem('NoMohon');

            childTable = $('#cl' + pickedKodvot).DataTable({
                dom: "t",
                paging: false,
                ajax: {
                    url: 'EPerolehan_WS.asmx/LoadData_ListDetailAm',
                    type: 'POST',
                    data: function (d) {
                        return "{ no_mohon: '" + NoMohon + "',kod: '" + pickedKodvot + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }
                },
                columns: [
                    {
                        "data": "id_am",
                        "width": "10%",
                    },
                    {
                        "data": "butiran",
                        "width": "65%",
                    },
                    {
                        "data": null,
                        "render": function (data, type, row, meta) {
                            if (data.Jawapan === null) {
                                return '<textarea class="input-group__input form-control input-sm txtJawapanAm" data-id="' + data.id_am + '" value="' + data.Jawapan + '" onchange="saveJawapanAm(this.value, \'' + data.id_am + '\')" AutoPostBack="true"></textarea>';

                            } else {
                                return '<textarea class =" input-group__input form-control input-sm txtJawapanAm" data-id="' + data.id_am + '" readonly> ' + data.Jawapan + ' </textarea>';
                            }
                        }
                    },
                ],
                columnDefs: [
                    {
                        "targets": 0,
                        visible: false,
                        searchable: false
                    },
                ],
                select: false,
            });

            childTable.on('draw.dt', function () {
                var $parentTotalItem = $('#spekfikasi-table-am').find("tbody tr").eq(prevRow.index());
                var jumlah = childTable.rows().count();
                $parentTotalItem.find(".jumlah").html("Jumlah : " + jumlah);
            });
        }

        function format(id) {
            var childTableHTML = '<table id="cl' + id + '" class="compact w-100" width="100%">' +
                '<thead>' +
                '<tr>' +
                '<td style="display: none;">Id_Am</td>' +
                '<td >Butiran</td>' +
                '<td class="jawapan-IdAm">Jawapan</td>' +
                '<td></td>' +
                '</tr>' +
                '</thead>' +
                '</table>';
            return childTableHTML;
        }

        async function saveJawapanAm(updatedValue, IdAm) {

            //var idTeknikal = $('.idTeknikal').val();

            //console.log("vvv " + updatedValue, idTeknikal);
            // Perform AJAX request to update Skor value in the server

            var newJawapanAm = {
                DataJawapanAm: {
                    IdPembelian: IdPembelian,
                    IdAm: IdAm,
                    JawapanAm: updatedValue
                }
            }

            try {
                var Result = JSON.parse(await AjaxSaveJawapanAm(newJawapanAm));

                if (Result.Status == "Failed") {
                    displayMaklumanModal("Maaf, jawapan tidak dapat disimpan");
                    return false;
                }
                return true; // Assuming successful saving
            } catch (error) {
                console.error("Error:", error);
                return false; // Indicate failure
            }
        }

        $('.btnSimpanJwpnAm').on('click', async function (simpan = false) {
            if (IdPembelian == "") {
                displayMaklumanModal("Maklumat Id Pembelian Tidak Sah");
                return;
            } else {
                let confirm = false;
                var acceptRecord = 0;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {

                    var newJawapanAm = {
                        DataJawapanAm: {
                            IdPembelian: IdPembelian,
                            JawapanAmDtl: []
                        }
                    }

                    var isValid = true;
                    var jawapanAmDtlArray = [];

                    $('#spekfikasi-table-am .txtJawapanAm').each(function (index, obj) {
                        var idAm = $(obj).attr('data-id');
                        var jawapanAm = $(obj).val();

                        // Check if any field is empty
                        if (idAm.trim() === "" || jawapanAm.trim() == "") {
                            displayMaklumanModal("Sila Lengkapkan Setiap Ruang Jawapan Yang Disediakan");
                            isValid = false;
                            return false; // Exit the loop early
                        }

                        // Push data to array
                        jawapanAmDtlArray.push({
                            IdAm: idAm,
                            JawapanAm: jawapanAm
                        });
                    });

                    if (!isValid) {
                        return; // Exit function if data is not valid
                    }

                    if (jawapanAmDtlArray.length <= 0) {
                        displayMaklumanModal("Sila Berikan Jawapan di bahagia yang disediakan");
                        return;
                    }
                    // Proceed with the data, as it's all valid
                    var newJawapanAm = {
                        DataJawapanAm: {
                            IdPembelian: IdPembelian,
                            JawapanAmDetail: jawapanAmDtlArray
                        }
                    };

                }

                console.log("DataJadual: ", newJawapanAm);
                var result = JSON.parse(await AjaxSaveJawapanAm(newJawapanAm));

                if (result.Status !== "Failed") {
                    //$('#borangTeknikal').modal("toggle");
                    displayMaklumanModal(result.Message);
                    tblbuku1.ajax.reload();
                } else {
                    displayMaklumanModal(result.Message);
                }
            }
        });

        async function AjaxSaveJawapanAm(DataJawapanAm) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SaveJawapanAM',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(DataJawapanAm),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        $(document).ready(function () {
            $("input[name='chckJwpnAm']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $('.btnSimpanSahAm').on('click', async function () {
            console.log("CHAAAAAAA")
            if ($("#chckJwpnAm").val() == "on" || $("#chckJwpnAm").val() == "false" || $("#chckJwpnAm").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {

                // Check jawapan value in child table
                //if (tblJadualKerja.rows().count() <= 0) {
                //    displayMaklumanModal("Sila Upload Jadual Perancangan Kerja Syarikat");
                //    return false;
                //}

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '13',
                            KodBuku: 'BK2',
                            ValueSah: $('#chckJwpnAm').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        //$('#borangTeknikal').modal("toggle");
                        displayMaklumanModal(result.Message);
                        //tblbuku2.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataAM(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckJwpnAm').prop('checked', true);
                } else {
                    $('#chckJwpnAm').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
                js function for Buku 2 (Jadual Perancangan Kerja)
            =============================================================================================================================================================================== */

        var IdPembelian = searchParams.get('IdPembelian');

        //Load DataTable
        var tblJadualKerja = null;
        $(document).ready(function () {
            /* show_loader();*/
            tblJadualKerja = $("#tblListJadualKerja").DataTable({
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
                    "url": "EPerolehan_WS.asmx/GetJadualKerja",
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
                            IdPembelian: IdPembelian
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
                    { "data": "Nama_Dok" },
                    {
                        "data": "Nama_Dok",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            Bil = row.Bil;

                            //var link = `<a href="#" onclick="OpenFilePS('${fileName}', '${Bil}'); return false;">${fileName}</a>`;
                            var link = `<button id="btnViewJadualKerja" class="btn btnViewJadualKerja" onclick="OpenFileJadualKerja('${fileName}','${Bil}'); return false;"><i class="fa fa-eye"></i></button>`;
                            ;
                            return link;
                        }
                    },
                ]
            });
        });

        function OpenFileJadualKerja(fileName, Bil) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/JK/") %>' + '<%=Session("ssusrID")%>' + '/' + Bil + '/' + fileName;
            window.open(path, '_blank');

        }

        //Upload Lampiran
        $('.btnUploadJadual').on('click', async function () {

            var inputFileJK = $('#fileInputJadualKerja');
            var fileInputValue = inputFileJK.val();
            console.log("Input File:", inputFileJK);

            if (fileInputValue == "") {
                displayMaklumanModal("Sila Muat Naik Jadual Kerja");
                return;
            }

            var fileNameJK = await getFileName($('#fileInputJadualKerja'));
            var fileExtentionJK = await getFileExtension(inputFileJK);

            var fileInputJK = {
                name: fileNameJK,
                extension: fileExtentionJK,
                path: '~/UPLOAD/DOCUMENT/E-VENDOR/JK/'
            };

            var fileJadualKerja = {
                JK: {
                    IdPembelian: IdPembelian,
                    ListFile: []
                }
            }

            var ListFile = {
                IdSya: '<%=Session("ssusrID")%>',
                NoRujukan: IdPembelian,
                JenDok: 'JK',
                FileName: fileInputJK.name,
                Bil: '',
                FilePath: fileInputJK.path,
                JenFile: fileInputJK.extension,

            }

            fileJadualKerja.JK.ListFile.push(ListFile);

            console.log(fileJadualKerja);
            var result = JSON.parse(await AjaxSaveJK(fileJadualKerja));

            if (result.Status !== "failed") {
                try {
                    var messageFile;
                    messageFile = await uploadJadualKerja();
                    console.log("messageFile: ", messageFile)

                    if (messageFile.message !== "OK") {
                        displayMaklumanModal("Gagal Muat Naik!");
                        return;
                    }

                } catch (error) {
                    console.error("Error during file upload:", error);
                    displayMaklumanModal("Gagal Memuatnaik Fail Jadual Kerja");
                    return;
                }

                displayMaklumanModal("File Berjaya Di Muat Naik");
                tblJadualKerja.ajax.reload()
            } else {
                displayMaklumanModal("File Gagal Di Muat Naik");
            }
        });

        async function uploadJadualKerja() {
            debugger;
            var fileInputId = "fileInputJadualKerja";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/JK/";
            var hidJenDokId = "hidJenDokJadual";
            var hidFileNameId = "hidFileNameJadual";
            var progressContainerId = "progressContainerJadual";
            var uploadedFileNameLabelId = "uploadedFileNameLabelJadual";
            var KodDaftar = "JK"
            var wsMethod = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/EPerolehan_WS.asmx/UploadFileJK")%>';
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar);

            return result;
        }

        async function AjaxSaveJK(JK) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SaveJadualKerja',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(JK),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        //save pengesahan -09

        $(document).ready(function () {
            $("input[name='chckJadualKerja']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $('.btnJadualKerja').on('click', async function () {

            if ($("#chckJadualKerja").val() == "on" || $("#chckJadualKerja").val() == "false" || $("#chckJadualKerja").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {

                if (tblJadualKerja.rows().count() <= 0) {
                    displayMaklumanModal("Sila Upload Jadual Perancangan Kerja Syarikat");
                    return false;
                }

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '09',
                            KodBuku: 'BK2',
                            ValueSah: $('#chckJadualKerja').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#jadualKerja').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku2.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataJK(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckJadualKerja').prop('checked', true);
                } else {
                    $('#chckJadualKerja').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
            js function for Buku 2 (Authorization Letter Pembekal)
        =============================================================================================================================================================================== */

        var IdPembelian = searchParams.get('IdPembelian');

        //Load DataTable
        var tblAuthoLetter = null;
        $(document).ready(function () {
            /* show_loader();*/
            tblAuthoLetter = $("#tblListSijil").DataTable({
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
                    "url": "EPerolehan_WS.asmx/GetAL",
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
                            IdPembelian: IdPembelian,
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
                    {
                        "data": "Nama_Dok"
                    },
                    {
                        "data": "Nama_Dok",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            Bil = row.Bil;

                            //var link = `<a href="#" onclick="OpenFilePS('${fileName}', '${Bil}'); return false;">${fileName}</a>`;
                            var link = `<button id="btnViewAL" class="btn btnViewAL" onclick="OpenFileAL('${fileName}','${Bil}'); return false;"><i class="fa fa-eye"></i></button>`;
                            ;
                            return link;
                        }
                    },
                ]
            });
        });

        function OpenFileAL(fileName, Bil) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/AL/") %>' + '<%=Session("ssusrID")%>' + '/' + Bil + '/' + fileName;
            window.open(path, '_blank');

        }

        //Upload Lampiran
        $('.btnUploadAL').on('click', async function () {
            var inputFileAL = $('#fileInputSijil');
            var fileInputValueAL = inputFileAL.val();
            console.log("Input File:", inputFileAL);

            if (fileInputValueAL == "") {
                displayMaklumanModal("Sila Muat Naik Jadual Kerja");
                return;
            }

            var fileNameAL = await getFileName($('#fileInputSijil'));
            var fileExtentionAL = await getFileExtension(inputFileAL);

            var fileInputAL = {
                name: fileNameAL,
                extension: fileExtentionAL,
                path: '~/UPLOAD/DOCUMENT/E-VENDOR/AL/'
            };

            var fileAuhtorLetter = {
                AL: {
                    IdPembelian: IdPembelian,
                    ListFile: []
                }
            }

            var ListFile = {
                IdSya: '<%=Session("ssusrID")%>',
                NoRujukan: IdPembelian,
                JenDok: 'AL',
                FileName: fileInputAL.name,
                Bil: '',
                FilePath: fileInputAL.path,
                JenFile: fileInputAL.extension,

            }

            fileAuhtorLetter.AL.ListFile.push(ListFile);

            console.log(fileAuhtorLetter);
            var result = JSON.parse(await AjaxSaveAL(fileAuhtorLetter));

            if (result.Status !== "Failed") {
                try {
                    var messageFile;
                    messageFile = await uploadSijil();
                    console.log("messageFile: ", messageFile)

                    if (messageFile.message !== "OK") {
                        displayMaklumanModal("Gagal Muat Naik!");
                        return;
                    }

                } catch (error) {
                    console.error("Error during file upload:", error);
                    displayMaklumanModal("Gagal Memuatnaik Authorization Letter");
                    return;
                }

                displayMaklumanModal("File Berjaya Di Muat Naik");
                tblAuthoLetter.ajax.reload()
            } else {
                displayMaklumanModal("File Gagal Di Muat Naik");
            }
        });

        async function uploadSijil() {
            var fileInputId = "fileInputSijil";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/AL/";
            var hidJenDokId = "hidJenDokSijil";
            var hidFileNameId = "hidFileNameSijil";
            var progressContainerId = "progressContainerSijil";
            var uploadedFileNameLabelId = "uploadedFileNameLabelSijil";
            var KodDaftar = "AL"
            var wsMethod = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/EPerolehan_WS.asmx/UploadFileAL")%>';
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar);

            return result;
        }

        async function AjaxSaveAL(JK) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SaveAL',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(JK),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        //Save Pengesahan -10
        $(document).ready(function () {
            $("input[name='chckSijil']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $('.btnSimpanSijil').on('click', async function () {

            if ($("#chckSijil").val() == "on" || $("#chckSijil").val() == "false" || $("#chckSijil").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {

                if (tblAuthoLetter.rows().count() <= 0) {
                    displayMaklumanModal("Sila Upload Jadual Perancangan Kerja Syarikat");
                    return false;
                }

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '10',
                            KodBuku: 'BK2',
                            ValueSah: $('#chckSijil').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#authLetter').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku2.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataAL(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckSijil').prop('checked', true);
                } else {
                    $('#chckSijil').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
            js function for Buku 2 (Katalog)
        =============================================================================================================================================================================== */

        var IdPembelian = searchParams.get('IdPembelian');
        var shouldPop = true, searchQuery = "", oldSearchQuery = "", tempNoJwpnTeknikal = "", navId = '', delDataId = '', withStatus = false, jumlahFail = 0, ttlCklist = 0, curCklist = 0;
        var tempArrChecklist = {}, tempArrPnjmin = [], tempSenaraiSemak = [];

        var tblKatalog = null;
        $(document).ready(function () {
            /* show_loader();*/
            tblKatalog = $("#tblLisKatalog").DataTable({
                "responsive": true,
                "searching": false,
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
                    "url": "EPerolehan_WS.asmx/GetKatalog",
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
                            IdPembelian: IdPembelian
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
                    { "data": "Butiran" },
                    { "data": "Jawapan" },
                    {
                        "data": null,
                        "render": function (data, type, row) {
                            if (data.Katalog != "1") {
                                return '<i>Tiada</i>';
                            } else {
                                if (data.Nama_Dok == null || data.Nama_Dok == "") {
                                    return '<td><div class="file-upload-container"><input name="fileHantar' + data.Id_Jawapan_Teknikal + '" type="file" id="fileInput' + data.Id_Jawapan_Teknikal + '" data-type="' + data.Id_Teknikal + '" accept=".pdf, .doc, .docx" class="file-input"><a class="file-name-label" id="fileNameLabel' + data.Id_Jawapan_Teknikal + '"></a><span type="button" class="ml-3 delete-button codx" id="deleteButton' + data.Id_Jawapan_Teknikal + '" data-id="' + data.Id_Jawapan_Teknikal + '"><i class="far fa-trash-alt fa-lg" style="color: red;"></i></span></div></td>';
                                } else {
                                    var link = '<button id="btnViewKatalog" class="btn btnViewKatalog" onclick="OpenFileKatalog(\'' + data.Nama_Dok + '\',\'' + data.Id_Teknikal + '\'); return false;"><i class="fa fa-eye">' + data.Nama_Dok + '</i></button> <span type="button" class="ml-3 delete-button" id="deleteButton' + data.Id_Jawapan_Teknikal + '" data-id="' + data.Id_Jawapan_Teknikal + '"><i class="far fa-trash-alt fa-lg" style="color: red;"></i></span></div></td>';
                                    return link;
                                }
                            }
                        }
                    }

                ]
            });
        });

        async function OpenFileKatalog(fileName, idTeknikal) {
            // Remove spaces and colons from idTeknikal
            var idTeknikalTrimmed = idTeknikal.replace(/[\s:]/g, '');

            // Construct the path
            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/KATALOG/") %>' + '<%=Session("ssusrID")%>' + '/' + idTeknikalTrimmed + '/' + fileName;

            // Open the file in a new tab
            window.open(path, '_blank');
        }

        <%--async function OpenFileKatalog(fileName, idTeknikal) {
            // Parse and format idTeknikal
            var dateTime = new Date(idTeknikal);
            var formattedDateTime = dateTime.getFullYear() + "-" +
                ('0' + (dateTime.getMonth() + 1)).slice(-2) + "-" +
                ('0' + dateTime.getDate()).slice(-2) +
                ('0' + dateTime.getHours()).slice(-2) +
                ('0' + dateTime.getMinutes()).slice(-2) +
                ('0' + dateTime.getSeconds()).slice(-2) +
                ('00' + dateTime.getMilliseconds()).slice(-3) +
                "0000"; // Additional zeros for milliseconds

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/KATALOG/") %>' + '<%=Session("ssusrID")%>' + '/' + formattedDateTime + '/' + fileName;
            window.open(path, '_blank');
        }--%>



        $('#tblLisKatalog').on('change', '.file-input', function () {
            var fileInput = $(this);
            var deleteButton = fileInput.siblings('.delete-button');
            var fileNameLabel = fileInput.siblings('.file-name-label');
            var IdJawapanTeknikal = $(this).data('type');
            console.log("id_jawapan_Teknikal: ", IdJawapanTeknikal);

            if (fileInput.length > 0) {
                //temporary URL
                var url = URL.createObjectURL(fileInput[0].files[0]);
                // Now you can use this url to view the file
                fileNameLabel.attr('href', url);
                //tag to open a link in a new tab
                fileNameLabel.attr('target', '_blank');
                //This is to prevent a type of phishing known as tabnabbing1
                fileNameLabel.attr('rel', 'noopener noreferrer');
                // File is selected, show delete button
                fileInput.addClass('codx');
                deleteButton.removeClass('codx');
                fileNameLabel.html('<i class="far fa-eye fa-lg"></i> ' + fileInput[0].files[0].name).removeClass('codx');

                var file = fileInput[0].files[0];
                //Buat checking untuk file
                if (file) {
                    var fileSize = file.size; // File size in bytes
                    var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (5MB)

                    // File size is within the allowed limit
                    if (fileSize <= maxSize) {
                        var fileName = file.name;
                        var fileExtension = fileName.split('.').pop().toLowerCase();

                        // Check if the file extension is PDF or Excel
                        if (['pdf'].includes(fileExtension)) {

                            var frmData = new FormData();
                            frmData.append("fileSurat", file);
                            frmData.append("fileName", fileName);
                            frmData.append("fileSize", fileSize);
                            frmData.append("kodDaftar", "KATALOG");
                            frmData.append("IdPembelian", IdPembelian);
                            frmData.append("IdJawapanTeknikal", IdJawapanTeknikal);

                            var checklistid = $(this).data('type');

                            console.log("Type Value: ", checklistid);

                            if (!(checklistid in tempArrChecklist)) {
                                tempArrChecklist[checklistid] = frmData;
                                jumlahFail++;
                                //fileInput.addClass("new");
                            }

                        } else {
                            // Invalid file type
                            fileInput.val(null);
                            fileInput.removeClass('codx');
                            deleteButton.addClass('codx');
                            fileNameLabel.addClass('codx');
                            $("#lblMessageModal").html("Hanya fail PDF sahaja dibenarkan.");
                            $("#MessageModal").modal('show');
                        }
                    } else {
                        // File size exceeds the allowed limit
                        fileInput.val(null);
                        fileInput.removeClass('codx');
                        deleteButton.addClass('codx');
                        fileNameLabel.addClass('codx');
                        $("#lblMessageModal").html("Saiz fail melebihi had maksimum 5MB.");
                        $("#MessageModal").modal('show');
                    }
                }
            } else {
                // No file selected, hide delete button
                fileInput.removeClass('codx');
                deleteButton.addClass('codx');
                fileNameLabel.addClass('codx');
            }
        });

        $('#tblLisKatalog').on('click', '.delete-button', async function () {
            var target = $(this);
            var fileInput = target.siblings('input[type="file"]');
            var fileNameLabel = target.siblings('.file-name-label');
            var type = target.siblings('.file-input');

            var DelId = $(this).data('id');
            var DelIdtype = $(this).attr('type');

            let confirm = false;
            confirm = await DisplayPegesahanModal("Anda Pasti Ingin Memadam Fail Ini?");

            if (!confirm) {
                return false;
            } else {
                var target = $('#' + DelIdtype);
                var fileInput = target.siblings('input[type="file"]');
                var fileNameLabel = target.siblings('.file-name-label');
                var type = target.siblings('.file-input');

                var postDt = {
                    dataFile: {
                        IdPembelian: IdPembelian,
                        IdTeknikal: DelId
                    }
                };

                console.log("postDT", postDt);
                var result = JSON.parse(await AjaxDelKatalog(postDt));

                if (result.Status !== "Failed") {
                    $('#katalog').modal("toggle");
                    delete tempArrChecklist[type.data('type')]
                    fileInput.val(null); // Clear the file input
                    fileInput.removeClass("codx"); // Show the "Choose File" button
                    fileNameLabel.html('').addClass("codx"); // Clear and hide the file name label
                    fileNameLabel.attr('href', '');
                    target.addClass("codx"); // Hide the delete button
                    fileInput.removeClass("selected");
                    $("#lblMessageModal").html(result.Message);
                    $("#MessageModal").modal('show');
                    displayMaklumanModal(result.Message);
                    tblbuku2.ajax.reload();
                } else {
                    //Berjaya Dibuang
                    delete tempArrChecklist[type.data('type')]
                    fileInput.val(null); // Clear the file input
                    fileInput.removeClass("codx"); // Show the "Choose File" button
                    fileNameLabel.html('').addClass("codx"); // Clear and hide the file name label
                    fileNameLabel.attr('href', '');
                    target.addClass("codx"); // Hide the delete button
                    fileInput.removeClass("selected");
                    displayMaklumanModal(result.Message);
                }
            }
        });

        <%--function OpenFileKatalog(fileName, Bil) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/KATALAOG/") %>' + '<%=Session("ssusrID")%>' + '/' + Bil + '/' + fileName;
            window.open(path, '_blank');

        }--%>

        //Upload Katalog

        //Save Pengesahan -11
        $(document).ready(function () {
            $("input[name='chckKatalog']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $('.btnSimpanKatalog').on('click', async function () {
            if ($("#chckKatalog").val() == "on" || $("#chckKatalog").val() == "false" || $("#chckKatalog").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {
                if (tblKatalog.rows().count() <= 0) {
                    displayMaklumanModal("Sila Upload Jadual Perancangan Kerja Syarikat");
                    return false;
                }

                let confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    curCklist = 0;
                    ttlCklist = Object.keys(tempArrChecklist).length;

                    console.log("TempArray:", tempArrChecklist);
                    debugger;
                    // Creating a Promise
                    var loopPromise = $.Deferred().resolve().promise();

                    // Using a regular loop to iterate over the tempArrChecklist keys
                    for (const key in tempArrChecklist) {
                        if (tempArrChecklist.hasOwnProperty(key)) {
                            // Using await inside an async function
                            //await ajaxPostFile('BasikalWS.asmx/SubmitCheckList', tempArrChecklist[key], false, uploadCklistBerjaya);
                            await AjaxSaveKatalog(tempArrChecklist[key])
                        }
                    }

                    loopPromise.done(async function () {
                        var newSahKatalog = {
                            MklmtSahKatalog: {
                                IdSya: '<%=Session("ssusrID")%>',
                                IdPembelian: IdPembelian,
                                KodDokumen: '11',
                                KodBuku: 'BK2',
                                ValueSah: $('#chckKatalog').val(), // Assuming this value is retrieved correctly
                            }
                        };

                        console.log("newSahKatalog: ", newSahKatalog);
                        var result = JSON.parse(await AjaxPengesahanKatalog(newSahKatalog));

                        if (result.Status !== "Failed") {
                            $('#katalog').modal("toggle");
                            displayMaklumanModal(result.Message);
                            tblbuku2.ajax.reload();
                        } else {
                            displayMaklumanModal(result.Message);
                        }

                    })

                    // Iterate over each row in the DataTable
                   <%-- tblKatalog.rows().every(function () {
                        var data = this.data();

                        // Get file input element in the current row
                        var fileInput = $(this.node()).find('input[type="file"]')[0];
                        if (fileInput && fileInput.files.length > 0) {
                            // If file input exists and has files selected
                            var file = fileInput.files[0];
                            // Push file data to ListFiles array
                            ListFiles = {
                                IdSya: '<%=Session("ssusrID")%>',
                                NoRujukan: IdPembelian,
                                JenDok: 'KATALOG',
                                FileName: file.name,
                                FilePath: '~/UPLOAD/DOCUMENT/E-VENDOR/KATALOG/',
                                JenFile: file.extension
                            };

                            newSahKatalog.MklmtSahKatalog.ListFile.push(ListFiles);
                        }
                    });--%>
                }
            }
        });

        async function uploadKatalog() {
            var fileInputId = "fileInputBank";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/BANK/";
            var hidJenDokId = "hidJenDokBank";
            var hidFileNameId = "hidFileNameBank";
            var progressContainerId = "progressContainerBank";
            var uploadedFileNameLabelId = "uploadedFileNameLabelBank";
            var KodDaftar = "KATALOG"
            var wsMethod = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/EPerolehan_WS.asmx/UploadFileKatalog")%>';
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar);

            return result;
        }

        async function AjaxSaveKatalog(frmData) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'EPerolehan_WS.asmx/SaveKatalog',
                    data: frmData,
                    cache: false,
                    contentType: false,
                    type: 'POST',
                    processData: false,
                    success: function (data) {
                        result = JSON.parse(data.querySelector("string").textContent);
                        //if (fn !== null && fn !== undefined) {
                        //    fn(result);
                        //}
                        resolve(true);
                    },

                    error: function (xhr, status, error) {
                        console.error("Error fetching details:" + error);
                        reject(false);
                    }
                });
            })
        }

        async function AjaxDelKatalog(dataFile) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/PadamFileKatalog',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(dataFile),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }


        async function AjaxPengesahanKatalog(MklmtSahKatalog) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SavePengesahanKatalog',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(MklmtSahKatalog),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        async function loadDataKatalog(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckKatalog').prop('checked', true);
                } else {
                    $('#chckKatalog').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        /* ===============================================================================================================================================================================
            js function for Buku 2 (Sample)
        =============================================================================================================================================================================== */
        //Save Pengesahan -12

        var IdPembelian = searchParams.get('IdPembelian');

        var tblSampel = null;
        $(document).ready(function () {
            /* show_loader();*/
            tblSampel = $("#tblLisSample").DataTable({
                "responsive": true,
                "searching": false,
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
                    "url": "EPerolehan_WS.asmx/GetSampel",
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
                            IdPembelian: IdPembelian
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
                    { "data": "Butiran" },
                    { "data": "Jawapan" },
                    {
                        "data": null,
                        "render": function (data, type, row) {

                            if (data.Sampel != "1") {
                                return "Ada";
                            } else {
                                return "Tiada"
                            }
                            //var fileName = data;
                            ////IdDokSSM = row.ID_Dok;
                            //Bil = row.Bil;

                            ////var link = `<a href="#" onclick="OpenFilePS('${fileName}', '${Bil}'); return false;">${fileName}</a>`;
                            //var link = `<button id="btnViewJadualKerja" class="btn btnViewJadualKerja" onclick="OpenFileKatalog('${fileName}','${Bil}'); return false;"><i class="fa fa-eye"></i></button>`;
                            //;
                            //return link;
                        }
                    },
                ]
            });
        });

        $(document).ready(function () {
            $("input[name='chckSample']").click(function () {
                if ($(this).is(":checked")) {
                    $(this).val("1");
                } else {
                    $(this).val("0");
                }
            });
        });

        $('.btnSimpanSample').on('click', async function () {

            if ($("#chckSample").val() == "on" || $("#chckSample").val() == "false" || $("#chckSample").val() == "0") {
                displayMaklumanModal("Sila Tandakan Pengesahan Sebelum Menyimpan Rekod");
            } else {

                if (tblSampel.rows().count() <= 0) {
                    displayMaklumanModal("Sila Upload Jadual Perancangan Kerja Syarikat");
                    return false;
                }

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");
                console.log("value confirm: ", confirm);

                if (!confirm) {
                    return false;
                } else {
                    var newSahProfil = {
                        MklmtSah: {
                            IdSya: '<%=Session("ssusrID")%>',
                            IdPembelian: IdPembelian,
                            KodDokumen: '12',
                            KodBuku: 'BK2',
                            ValueSah: $('#chckSample').val(),
                        }
                    }

                    var result = JSON.parse(await AjaxPengesahan(newSahProfil));

                    if (result.Status !== "Failed") {
                        $('#sample').modal("toggle");
                        displayMaklumanModal(result.Message);
                        tblbuku2.ajax.reload();
                    } else {
                        displayMaklumanModal(result.Message);
                    }
                }
            }
        });

        async function loadDataSample(kodDok, IdPembelian) {

            if (kodDok == "" || kodDok == null) {
                return false;
            }

            let result = JSON.parse(await AjaxLoadDataSah(kodDok, IdPembelian))
            console.log("Result: ", result[0].Status_Simpan);
            if (result.length !== 0) {
                if (result[0].Status_Simpan === "1") {
                    $('#chckSample').prop('checked', true);
                } else {
                    $('#chckSample').prop('checked', false);
                }
            } else {
                displayMaklumanModal("Maaf, Tiada Maklumat");
            }
        }

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        function displayMaklumanModal(message) {
            $('#detailMakluman').html(message);
            $('#maklumanModal').modal('toggle');
        }

        async function DisplayPegesahanModal(msg) {
            $('#confirmContent').html(msg);

            var decision = false;
            return new Promise(function (resolve) {
                $('.btnYa').click(function () {
                    decision = true;
                    $('#confirmationModal').modal('toggle');
                });

                $("#confirmationModal").on('hidden.bs.modal', function () {
                    resolve(decision);
                });

                $('#confirmationModal').modal('toggle');
            });
        }

        async function AjaxPengesahan(MklmtSah) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/SavePengesahan',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(MklmtSah),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        async function getFileName(fileInput) {
            var file = fileInput[0].files;
            console.log("file: ", file);

            if (file.length > 0) {
                var fileName = file[0].name;

                return fileName;
            } else {
                return null;
            }

        }

        async function getFileExtension(fileInput) {
            var file = fileInput[0].files; // Changed fileInput[0].files to fileInput.files
            if (file.length > 0) {
                var fileName = file[0].name;
                var fileExtension = fileName.split('.').pop().toLowerCase();

                return fileExtension;
            } else {
                return null;
            }
        }

        //var responseFile = "";
        //function uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod) {
        //    var fileInput = document.getElementById(fileInputId);
        //    var file = fileInput.files[0];
        //    var result = {
        //        fileExtension: "",
        //        fileName: "",
        //        message: "",
        //        url: ""
        //    };

        //    if (file) {
        //        debugger;
        //        var fileSize = file.size; // File size in bytes
        //        var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (3MB)

        //        if (fileSize <= maxSize) {
        //            // File size is within the allowed limit
        //            var fileName = file.name;
        //            var fileExtension = fileName.split('.').pop().toLowerCase();

        //            // Check if the file extension is PDF or Excel
        //            if (['pdf', 'xlsx', 'xls'].includes(fileExtension)) {
        //                var reader = new FileReader();
        //                reader.onload = function (e) {
        //                    var fileData = e.target.result; // Base64 string representation of the file data

        //                    var requestData = {
        //                        fileData: fileData,
        //                        fileName: fileName,
        //                        resolvedUrl: resolveAppUrl(resolvedUrl),
        //                    };

        //                    var frmData = new FormData();
        //                    frmData.append("fileSurat", file);
        //                    frmData.append("fileName", fileName);
        //                    frmData.append("fileSize", fileSize);

        //                    $(`#${hidJenDokId}`).val(fileExtension);
        //                    $(`#${hidFileNameId}`).val(fileName);

        //                    $.ajax({
        //                        url: wsMethod,
        //                        type: 'POST',
        //                        data: frmData,
        //                        cache: false,
        //                        contentType: false,
        //                        processData: false,
        //                        success: function (response) {
        //                            alert(response);
        //                            responseFile = JSON.parse(response);
        //                            // Show the uploaded file name on the screen
        //                            //var fileLink = document.createElement("a");
        //                            //fileLink.href = requestData.resolvedUrl + fileName;
        //                            //fileLink.textContent = fileName;

        //                            //var uploadedFileNameLabel = document.getElementById(uploadedFileNameLabelId);
        //                            //uploadedFileNameLabel.appendChild(fileLink);

        //                            /* fileLinkToLocal(requestData.resolvedUrl + fileName);*/

        //                            /*$(`#${uploadedFileNameLabelId}`).show();*/
        //                            // Clear the file input
        //                            /*$(`#${fileInputId}`).val("");*/
        //                            /* $(`#${progressContainerId}`).text("File uploaded successfully.");*/
        //                            /*displayFileLink(fileName);*/
        //                        },
        //                        error: function () {
        //                            $(`#${progressContainerId}`).text("Error uploading file.");
        //                        }
        //                    });
        //                };

        //                reader.readAsArrayBuffer(file);

        //                if (response == "OK") {
        //                    result.fileName = fileName;
        //                    result.fileExtension = fileExtension;
        //                    result.message = "OK";
        //                    result.url = resolvedUrl;
        //                } else {
        //                    displayMaklumanModal("Ajax Return !==0");
        //                    result.fileName = fileName;
        //                    result.fileExtension = fileExtension;
        //                    result.message = "X";
        //                    result.url = resolvedUrl;
        //                }

        //            } else {
        //                // Invalid file type
        //                /*displayMaklumanModal("Only PDF and Excel files are allowed.");*/
        //                result.message = "Only PDF and Excel files are allowed.";

        //            }
        //        } else {
        //            // File size exceeds the allowed limit
        //            /*displayMaklumanModal("File size exceeds the maximum limit of 3MB");*/
        //            result.message = "File size exceeds the maximum limit of 5MB";

        //        }
        //    } else {
        //        // No file selected
        //        /*displayMaklumanModal("Please select a file to upload");*/
        //        result.message = "Please select a file to upload"

        //    }

        //    return result;
        //}

        var responseFile = "";

        function uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar) {
            var fileInput = document.getElementById(fileInputId);
            var file = fileInput.files[0];
            var result = {
                fileExtension: "",
                fileName: "",
                message: "",
                url: ""
            };

            if (file) {
                var fileSize = file.size; // File size in bytes
                var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (5MB)

                if (fileSize <= maxSize) {
                    // File size is within the allowed limit
                    var fileName = file.name;
                    var fileExtension = fileName.split('.').pop().toLowerCase();

                    // Check if the file extension is PDF or Excel
                    if (['pdf', 'xlsx', 'xls'].includes(fileExtension)) {
                        debugger;
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var fileData = e.target.result; // Base64 string representation of the file data

                            var requestData = {
                                fileData: fileData,
                                fileName: fileName,
                                resolvedUrl: resolveAppUrl(resolvedUrl),
                            };

                            var frmData = new FormData();
                            frmData.append("fileSurat", file);
                            frmData.append("fileName", fileName);
                            frmData.append("fileSize", fileSize);
                            frmData.append("kodDaftar", KodDaftar);

                            $(`#${hidJenDokId}`).val(fileExtension);
                            $(`#${hidFileNameId}`).val(fileName);

                            $.ajax({
                                url: wsMethod,
                                type: 'POST',
                                data: frmData,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (response) {
                                    //alert(response);
                                    responseFile = JSON.parse(response);
                                    if (responseFile.message === "OK") {
                                        result.fileName = fileName;
                                        result.fileExtension = fileExtension;
                                        result.message = "OK";
                                        result.url = resolvedUrl;
                                    } else {
                                        displayMaklumanModal("Ajax Return !==0");
                                        result.fileName = fileName;
                                        result.fileExtension = fileExtension;
                                        result.message = "X";
                                        result.url = resolvedUrl;
                                    }
                                },
                                error: function () {
                                    $(`#${progressContainerId}`).text("Error uploading file.");
                                }
                            });
                        };

                        reader.readAsArrayBuffer(file);
                        result.fileName = fileName;
                        result.fileExtension = fileExtension;
                        result.message = "OK";
                        result.url = resolvedUrl;

                    } else {
                        // Invalid file type
                        result.message = "Only PDF and Excel files are allowed.";
                    }
                } else {
                    // File size exceeds the allowed limit
                    result.message = "File size exceeds the maximum limit of 5MB";
                }
            } else {
                // No file selected
                result.message = "Please select a file to upload";
            }

            return result;
        }

        function resolveAppUrl(relativeUrl) {
            var resolvedUrl = "";
            $.ajax({
                type: "POST",
                url: "Pendaftaran_WS.asmx/ResolveAppUrl",
                data: JSON.stringify({ relativeUrl: relativeUrl }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false, // Ensure synchronous execution for simplicity
                success: function (response) {
                    resolvedUrl = response.d;
                }
            });
            return resolvedUrl;
        }


    </script>

</asp:Content>
