<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="MohonKenderaan.aspx.vb" Inherits="SMKB_Web_Portal.MohonKenderaan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <style>
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

        input[readonly] {
            background-color: #e5e5e5; /* Adjust the color as needed */
        }

        .nav-tabs .nav-link {
            padding: 0.25rem 0.5rem;
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

        #tblSenaraiPerolehan td:hover {
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

        .modal-content2 {
            border-top: 5px solid #ddd;
        }

        .form-group.border.p-3 {
            padding: 20px;
        }

        .modal-content {
            max-width: 1200px; /* Set the maximum width for the modal content */
            margin: auto; /* Center the modal horizontally */
        }

        .form-group {
            /* Optionally, adjust the width of the form elements if needed */
            max-width: 100%; /* Set the maximum width for the form elements */
        }

        .codx {
            display: none;
            visibility: hidden;
        }

        .file-upload-container {
            position: relative;
        }

        .delete-button {
            cursor: pointer;
            color: red;
        }

        .file-name-label {
            margin-top: 5px;
            cursor: pointer;
        }

        .disableDdlIcon {
            pointer-events: none;
        }

        @keyframes blink {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0.5;
            }

            100% {
                opacity: 1;
            }
        }

        .blink_badge {
            animation: blink 1s infinite;
        }

        .incolor {
            background-color: #e9ecef;
            color: #ffffff;
        }
    </style>
    <link rel="stylesheet" href="../style.css" />
    <contenttemplate>
        <div class="modal-body">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link text-uppercase active" id="home-tab" data-toggle="tab" href="#tab1" role="tab" aria-controls="home" aria-selected="false">Maklumat Pemohon / Butir - Butir Pembelian</a>
                </li>
                <li class="nav-item codx">
                    <a class="nav-link text-uppercase" id="penjamin-tab" data-toggle="tab" href="#tab2" role="tab" aria-controls="penjamin" aria-selected="false">Maklumat Penjamin</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-uppercase" id="semak-tab" data-toggle="tab" href="#tab3" role="tab" aria-controls="semak" aria-selected="false">SENARAI SEMAK</a>
                </li>
                <li class="nav-item ml-auto">
                    <div class="text-uppercase btn btn-primary" role="tab" data-toggle="modal" data-target="#mdlSenPemohonan">Senarai Permohonan <span id="snraiMhnBadge" class="badge badge-danger blink_badge codx">-</span></div>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="tab1" role="tabpanel" aria-labelledby="home-tab">
                    <div class="table-title">
                        <h6 class="font-weight-bold">Maklumat Pemohon <i class="fas fa-info-circle fa-lg text-primary" data-toggle="modal" data-target="#modalB1"></i></h6>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="col-lg-5 col-md-6">
                                    <div class="form-group input-group">
                                        <input id="noPinjaman" type="text" class=" input-group__input" placeholder="" readonly disabled />
                                        <label class="input-group__label">No. Pembiayaan</label>
                                    </div>
                                </div>
                                <div class="col-md-12"></div>
                                <div class="col-lg-5 col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class="id_nama input-group__input" placeholder="" name="" value="" readonly disabled />
                                        <label class="input-group__label">Nama Penuh</label>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class="id_kp input-group__input " placeholder="" name="" value="" readonly disabled />
                                        <label class="input-group__label">No. Kad Pengenalan</label>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class="id_staff input-group__input" placeholder="" name="" value="" readonly disabled />
                                        <label class="input-group__label">No. Pekerja</label>
                                    </div>
                                </div>
                                <div class="col-md-12"></div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="form-group input-group">
                                        <input type="date" class=" input-group__input" placeholder="" id="tkhTmtLesen" />
                                        <label class="input-group__label">
                                            Tarikh Tamat Lesen Memandu <span style="color: red">*</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="table-title pt-3">
                        <h6 class="font-weight-bold">Butir - Butir Pembelian</h6>
                    </div>
                    <div id="divbutirpembelian" class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="col-lg-3 col-md-6">
                                    <div class="form-group">
                                        <div class="form-group input-group">
                                            <select class="input-group__select ui search dropdown" placeholder="" name="ddlJnsPnjmn" id="ddlJnsPnjmn">
                                            </select>
                                            <label class="input-group__label" for="ddlJnsPnjmn">Jenis Pembiayaan <span style="color: red">*</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="form-group">
                                        <div class="form-group input-group">
                                            <select class="input-group__select ui search dropdown" placeholder="" name="ddlTmpoByrBalik" id="ddlTmpoByrBalik">
                                            </select>
                                            <label class="input-group__label" for="ddlTmpoByrBalik">
                                                Tempoh Pembayaran Balik (Bulan) <span style="color: red">*</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="form-group">
                                        <div class="form-group input-group">
                                            <select class="input-group__select ui search dropdown" placeholder="" name="ddlJumlahMhn" id="ddlJumlahMhn" maxlength="20">
                                            </select>
                                            <label class="input-group__label" for="ddlJumlahMhn">
                                                Jumlah yang dipohon (RM) <span style="color: red">*</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-12">
                                    <div id="btn_semak" class="btn btn-primary"><small class="font-weight-bold">Semak Kelayakan</small></div>
                                    <div id="btnButiranHtg" class="btn btn-primary"><small class="font-weight-bold">Butiran Hutang/Potongan</small></div>
                                </div>
                            </div>
                            <div class="p-2"></div>
                            <fieldset class="form-group border p-3" style="border-radius: 5px;">
                                <legend class="w-auto px-2 h6 font-weight-bold">Butiran Kenderaan</legend>
                                <div class="form-row">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group">
                                            <div class="form-group input-group">
                                                <select class="input-group__select ui search dropdown" placeholder="" name="ddlJnmaKend" id="ddlJnmaKend">
                                                </select>
                                                <label class="input-group__label" for="ddlJnmaKend">
                                                    Jenama <span style="color: red">*</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group">
                                            <div class="form-group input-group">
                                                <select class="input-group__select ui search dropdown" placeholder="" name="ddlMdlKend" id="ddlMdlKend">
                                                </select>
                                                <label class="input-group__label" for="ddlMdlKend">
                                                    Model <span style="color: red">*</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input" placeholder="" id="noPndftrn" maxlength="100" />
                                            <label class="input-group__label">No. Pendaftaran</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group">
                                            <div class="form-group input-group">
                                                <select class="input-group__select ui search dropdown" placeholder="" name="ddlKlsKend" id="ddlKlsKend">
                                                </select>
                                                <label class="input-group__label" for="ddlKlsKend">Kelas Kenderaan</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group input-group">
                                            <input type="text" class="input-group__input" placeholder="" id="thnDibuat" maxlength="4" />
                                            <label class="input-group__label">Tahun Dibuat</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group">
                                            <div class="form-group input-group">
                                                <select class="input-group__select ui search dropdown" placeholder="" name="ddlSktSilinder" id="ddlSktSilinder">
                                                </select>
                                                <label class="input-group__label" label="ddlSktSilinder">
                                                    Sukatan silinder (s.s) <span style="color: red">*</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group input-group">
                                            <input type="text" class="input-group__input" placeholder="" id="noEnjin" maxlength="10" />
                                            <label class="input-group__label">No. Enjin</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input" placeholder="" id="noChasis" maxlength="30" />
                                            <label class="input-group__label">No. Chasis</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group">
                                            <div class="form-group input-group">
                                                <select class="input-group__select ui search dropdown" placeholder="" name="ddlBhnBakar" id="ddlBhnBakar">
                                                </select>
                                                <label class="input-group__label" for="ddlBhnBakar">Bahan Bakar</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group">
                                            <div class="form-group input-group">
                                                <select class="input-group__select ui search dropdown" placeholder="" name="ddlBdnKend" id="ddlBdnKend">
                                                </select>
                                                <label class="input-group__label" for="ddlBdnKend">Badan Kenderaan</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input" placeholder="" id="hrgaBrsih" maxlength="10" />
                                            <label class="input-group__label">
                                                Harga Bersih (RM) <span style="color: red">*</span>
                                            </label>
                                        </div>
                                        <p class="blockquote-footer font-italic">(tidak termasuk cukai jalan, insuran dan lain -lain alat yang ditambah kemudiannya)</p>
                                    </div>
                                </div>
                            </fieldset>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <textarea class="input-group__input" rows="2" placeholder="" data-enable-grammarly="false" id="kendSediaAda" maxlength="250"></textarea>
                                        <label class="input-group__label">Jenis kenderaan yang digunakan sekarang semasa menjalankan tugas rasmi</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <textarea class="input-group__input" rows="2" placeholder="" data-enable-grammarly="false" id="jwtnPerluKend" maxlength="300"></textarea>
                                        <label class="input-group__label">Tugas jawatan yang menunjukkan perlu menggunakan kenderaan sendiri </label>
                                    </div>
                                </div>
                            </div>
                            <fieldset class="form-group border p-3" style="border-radius: 5px;">
                                <legend class="w-auto px-2 h6 font-weight-bold">Butiran Pembekal <i class="fas fa-info-circle fa-lg text-primary codx infosyarikat" data-toggle="modal" data-target="#modalPembekal"></i></legend>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="col-lg-5 col-md-6">
                                                <div class="form-group">
                                                    <div class="form-group input-group">
                                                        <select class="input-group__select ui search dropdown" placeholder="" name="ddlSyarikat" id="ddlSyarikat">
                                                        </select>
                                                        <label class="input-group__label" for="ddlSyarikat">
                                                            Nama Syarikat <span style="color: red">*</span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-6">
                                                <div class="form-group input-group">
                                                    <input type="text" class="noSykt input-group__input" placeholder="" id="" name="" disabled readonly />
                                                    <label class="input-group__label">
                                                        No. Syarikat
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <!-- <p class="blockquote-footer font-italic">Ruangan Bertanda <span class="text-danger">*</span> Wajib Diisikan Sebelum Permohonan Disimpan Jika nama syarikat tiada dalam senarai, sila hubungi Unit Gaji & Pembiayaan. </p> -->
                        </div>
                        <%--Modal - Papar Maklumat Pembekal--%>
                        <div class="modal fade" id="modalPembekal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static">
                            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Butiran Pembekal</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body" style="padding: 30px;">
                                        <div class="row pb-2">
                                            <label for="input1" class="col-md-4 control-label">Nama Syarikat</label>
                                            <div class="col-md-8">
                                                <input type="text" class="mmSykt input-group__input form-control" placeholder="-" readonly disabled>
                                            </div>
                                        </div>
                                        <div class="row pb-2">
                                            <label for="input2" class="col-md-4 control-label">No. Syarikat</label>
                                            <div class="col-md-8">
                                                <input type="text" class="noSykt input-group__input form-control" placeholder="-" readonly disabled>
                                            </div>
                                        </div>
                                        <div class="row pb-1">
                                            <label for="" class="col-md-4 control-label">Alamat Syarikat</label>
                                            <div class="col-md-8">
                                                <textarea class="almtSyrkt input-group__input" rows="2" placeholder="-" data-enable-grammarly="false" readonly disabled></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="tab2" role="tabpanel" aria-labelledby="penjamin-tab">
                    <div class="table-title pt-3">
                        <h6 class="font-weight-bold">Maklumat Penjamin</h6>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div id="divpenjamin" class="form-row">
                                <div class="col-md-2">
                                    <div class="form-group input-group">
                                        <input type="text" class="input-group__input" placeholder="" id="noStafPenjamin" value="" readonly disabled />
                                        <label class="input-group__label">No. Staff</label>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="form-group">
                                        <div class="form-group input-group">
                                            <select class="input-group__select ui search dropdown" placeholder="" name="" id="ddlPenjamin">
                                            </select>
                                            <label class="input-group__label" for="ddlPenjamin">Nama Penjamin</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- <p class="blockquote-footer font-italic">
                     <span class="text-danger">*</span> Pemohon berjawatan Tetap dalam percubaan dan kontrak wajib isi bahagian ini.
                  </p> -->
                            <table id="tablePenjamin" class="table table-bordered codx" width="100%" border="0" cellspacing="0" cellpadding="1">
                                <tbody>
                                    <tr class="box table-warning">
                                        <td width="31%">No Kad Pengenalan </td>
                                        <td width="69%"><strong id="pjmnKp">&nbsp;-</strong>
                                        </td>
                                    </tr>
                                    <tr class="box table-warning">
                                        <td>No Pekerja </td>
                                        <td id="pjmnNoPekerja"></td>
                                    </tr>
                                    <tr class="box table-warning">
                                        <td>Tarikh Lahir </td>
                                        <td id="pjmnTkhLhr"></td>
                                    </tr>
                                    <tr class="box table-warning">
                                        <td>Alamat Penuh Tempat Kerja </td>
                                        <td id="pnmnAlamat"></td>
                                    </tr>
                                    <tr class="box table-warning">
                                        <td>Jawatan</td>
                                        <td id="pjmnJawatan">: &nbsp;-</td>
                                    </tr>
                                    <tr class="box table-warning">
                                        <td>Tarikh Disahkan Dalam Jawatan </td>
                                        <td id="pjmnSahJawatan"></td>
                                    </tr>
                                    <tr class="box table-warning">
                                        <td>Tindakan</td>
                                        <td>
                                            <button id="btnTambah" type="button" class="btn btn-light">Tambah</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table id="tblSenaraiPenjamin" class="table table-bordered" width="100%" border="0" cellspacing="0" cellpadding="1">
                                <thead>
                                    <tr align="center">
                                        <th width="4%">
                                            <span class="style2">Bil</span>
                                        </th>
                                        <th width="20%">
                                            <span class="style2">No Staf </span>
                                        </th>
                                        <th width="49%">
                                            <span class="style2">Nama Penjamin </span>
                                        </th>
                                        <th width="27%">
                                            <span class="style2">Status</span>
                                        </th>
                                        <th width="27%">
                                            <span class="style2">Tindakan</span>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Your table data goes here -->
                                    <!-- Add more rows as needed -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="tab3" role="tabpanel" aria-labelledby="semak-tab">
                    <div class="table-responsive">
                        <table id="tbsnraismk" class="table table-bordered" width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tbody>
                                <tr>
                                    <td colspan="3">
                                        <strong>SENARAI SEMAK</strong>
                                        <br>
                                        Sila pastikan dokumen sokongan tersebut dihantar bersama semasa Permohonan Pembiayaan.
                                    </td>
                                </tr>
                                <tr class="theader table-warning">
                                    <td>Bil</td>
                                    <td>Perkara</td>
                                    <td>Hantar</td>
                                </tr>
                                <tr align="center">
                                    <td colspan="3">Tiada Rekod. Sila Lengkapkan Maklumat Pemohon / Butir-butir Pembelian Terlebih Dahulu.</td>
                                </tr>
                                <%--tambah senarai semak dari backend--%>
                                <!-- Add similar rows for other files -->
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="sticky-footer">
                    <br>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <div id="showBtn" class="float-right">
                                <button id="btnreset" type="button" class="btn btn-setsemula">Permohonan Baru</button>
                                <button id="btnSimpanDraf" type="button" class="btn btn-secondary">Simpan Draf</button>
                                <button id="btnSimpan" type="button" class="btn btn-success codx">Simpan dan Hantar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--Modal - Papar Maklumat Pemohon--%>
        <div class="modal fade" id="modalB1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Maklumat Pemohon</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" style="padding: 30px;">
                        <div class="row pb-2">
                            <label for="input1" class="col-md-4 control-label">Nama Penuh</label>
                            <div class="col-md-8">
                                <input type="text" class="id_nama form-control" placeholder="Nama Penuh" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="input2" class="col-md-4 control-label">No. Kad Pengenalan</label>
                            <div class="col-md-8">
                                <input type="text" class="id_kp form-control" placeholder="No. Kad Pengenalan" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Tarikh Lahir</label>
                            <div class="col-md-8">
                                <input type="text" class="id_tkhlahir form-control" placeholder="Tarikh Lahir" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Umur Pada Tarikh Memohon</label>
                            <div class="col-md-8">
                                <input type="text" class="id_umur form-control" placeholder="Umur Pada Tarikh Memohon" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Tarikh Perlantikan</label>
                            <div class="col-md-8">
                                <input type="text" class="id_tkhLantikan form-control" placeholder="Tarikh Perlantikan" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Tarikh Pengesahan Perkhidmatan</label>
                            <div class="col-md-8">
                                <input type="text" class="tkhpngshn form-control" placeholder="Tarikh Pengesahan Perkhidmatan" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="input4" class="col-md-4 control-label">
                                Taraf Pegawai <small class="text-muted">(samada dalam percubaan/tetap/kontrak)</small>
                            </label>
                            <div class="col-md-8">
                                <input type="text" class="id_taraf form-control" placeholder="Taraf Pegawai" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Gred Jawatan</label>
                            <div class="col-md-8">
                                <input type="text" class="gredjaw form-control" placeholder="Gred Jawatan" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Jawatan Sekarang</label>
                            <div class="col-md-8">
                                <textarea type="text" class="id_jwtn form-control" rows="2" placeholder="Jawatan Sekarang" data-enable-grammarly="false" readonly disabled></textarea>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Fakulti/ Jabatan</label>
                            <div class="col-md-8">
                                <textarea type="text" class="id_fakulti form-control" rows="2" placeholder="Fakulti/ Jabatan" data-enable-grammarly="false" readonly disabled></textarea>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Alamat Jabatan</label>
                            <div class="col-md-8">
                                <textarea type="text" class="almtJbtn form-control" rows="2" placeholder="Alamat Jabatan" data-enable-grammarly="false" readonly disabled></textarea>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="input5" class="col-md-4 control-label">
                                Jawatan lain yang disandang <small class="text-muted">(*Dekan/Timbalan Dekan/Ketua Jabatan dll)</small>
                            </label>
                            <div class="col-md-8">
                                <input type="text" class="form-control" placeholder="Jawatan lain yang disandang" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2 justify-content-end">
                            <label for="" class="control-label">Mulai</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control" id="" placeholder="-" readonly disabled>
                            </div>
                            &nbsp &nbsp &nbsp
                            <label for="" class="control-label">Hingga</label>
                            <div class="col-md-3">
                                <input type="text" class="form-control" id="" placeholder="-" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Gaji Bulanan (Pokok)</label>
                            <div class="col-md-8">
                                <input type="text" class="id_gajisbln form-control" placeholder="Gaji Bulanan (Pokok)" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Elaun Memangku (jika ada)</label>
                            <div class="col-md-8">
                                <input type="text" class="form-control" id="" placeholder="Elaun Memangku (jika ada)" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">No. Telefon Bimbit</label>
                            <div class="col-md-8">
                                <input type="text" class="noHp form-control" placeholder="No. Telefon Bimbit" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Samb. Tel</label>
                            <div class="col-md-8">
                                <input type="text" class="noTel form-control" placeholder="Samb. Tel" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Nombor Lesen Memandu</label>
                            <div class="col-md-8">
                                <input type="text" class="id_nolesen form-control" placeholder="Nombor Lesen Memandu" readonly disabled>
                            </div>
                        </div>
                        <div class="row pb-2">
                            <label for="" class="col-md-4 control-label">Kelas Memandu</label>
                            <div class="col-md-8">
                                <input type="text" class="id_klslesen form-control" placeholder="Kelas Memandu" readonly disabled>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--Modal - Senarai Permohonan--%>
        <div class="modal fade" id="mdlSenPemohonan" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" style="min-width: 80%" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <%--               <div class="search-filter">
                  <div class="form-row justify-content-center">
                     <div class="form-group row col-md-6">
                        <label for="inputEmail3" class="col-sm-2 col-form-label"
                           style="text-align: right">Carian :</label>
                        <div class="col-sm-8">
                           <div class="input-group">
                              <select id="invoisDateFilter" class="custom-select"
                                 onchange="dateFilterHandler(event)">
                                 <option value="all">SEMUA</option>
                                 <option value="0" selected="selected">Hari Ini</option>
                                 <option value="1">Semalam</option>
                                 <option value="7">7 Hari Lepas</option>
                                 <option value="30">30 Hari Lepas</option>
                                 <option value="60">60 Hari Lepas</option>
                                 <option value="select">Pilih Tarikh</option>
                              </select>
                              <button id="btnSearch" class="btn btnSearch btn-outline"
                                 type="button" onclick="loadInvois()">
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
                        <div class="col-md-11" id="specificDateFilter" style="display: none">
                           <div class="form-row">
                              <div class="form-group col-md-1">
                                 <label id="lblMula" style="text-align: right;">Mula:</label>
                              </div>
                              <div class="form-group col-md-4">
                                 <input type="date" id="txtTarikhStart" name="txtTarikhStart"
                                    class="date-range-filter">
                              </div>
                              <div class="form-group col-md-1">
                              </div>
                              <div class="form-group col-md-1">
                                 <label id="lblTamat"
                                    style="text-align: right;">Tamat:</label>
                              </div>
                              <div class="form-group col-md-4">
                                 <input type="date" id="txtTarikhEnd" name="txtTarikhEnd"
                                    class="date-range-filter">
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  </div>--%>
                        <div class="col-md-12 ">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblSenPemohon" class="table table-striped"
                                            style="width: 99%">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Bil.</th>
                                                    <th scope="col">Tarikh Mohon</th>
                                                    <th scope="col">No. Pembiayaan</th>
                                                    <th scope="col">Jenis Pembiayaan</th>
                                                    <th scope="col">Status Permohonan</th>
                                                    <th scope="col">Status Layak</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableID_Senarai">
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
        <!-- Confirmation Modal Submit Bil -->
        <div class="modal fade" id="confirmationModalSubmit" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabelSubmit" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabelSubmit">Pengesahan</h5>
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
                        <button id="btnYaSubmit" type="button" class="btn default-primary">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Confirmation Modal Submit Bil -->
        <div class="modal fade" id="pengesahanBuang" tabindex="-1" role="dialog"
            aria-labelledby="pengesahanBuangLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="pengesahanBuangLabel">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Anda pasti ingin membuang fail ini?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">
                            Tidak</button>
                        <button id="btnyabuang" type="button" class="btn default-primary">Ya</button>
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
        <%--Modal - Semak Kelayakan--%>
        <div class="modal fade" id="mdlSmkKlykn" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Semak Kelayakan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered" width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tbody>
                                <tr class="box">
                                    <td>Kelayakan Skim Maksima</td>
                                    <td><strong id="semak1"></strong></td>
                                </tr>
                                <tr class="box">
                                    <td>Jumlah Ansuran</td>
                                    <td><strong id="semak2"></strong></td>
                                </tr>
                                <tr class="box table-warning">
                                    <td>Status Kelayakan</td>
                                    <td><strong id="semak3"></strong></td>
                                </tr>
                            </tbody>
                        </table>
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
        <!-- Modal Potongan -->
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Butiran Hutang/ Potongan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table id="tblSenaraiPotongan" class="table table-bordered" width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tbody>
                                <%--<tr class="theader table-warning"><td>&nbsp;Bil</td><td>&nbsp;Jenis Pembiayaan/ Perkara</td><td>&nbsp;Jumlah Potongan</td></tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="../../../Content/js/SharedFunction.js"></script>
        <script type="text/javascript" src="../../../Content/js/xlsx.full.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                /*generateDropdown("id", "path", "place holder", "flag send data to web services or either", "parent dropdown (dependable)","function after ajax success");*/
                generateDropdown("ddlBdnKend", "GeneralWS.asmx/GetBadanKenderaan", "Pilih Badan Kenderaan", false, null);
                generateDropdown("ddlBhnBakar", "GeneralWS.asmx/GetBahanBakar", "Pilih Bahan Bakar", false, null);
                generateDropdown("ddlJnsPnjmn", "GeneralWS.asmx/GetJenisPinjaman", "Pilih Jenis Pembiayaan", false, null, clearDdlTempohJmlhPohon);
                generateDropdown("ddlSktSilinder", "GeneralWS.asmx/GetSukatSilinder", "Pilih Sukatan Silinder", false, null);
                generateDropdown("ddlKlsKend", "GeneralWS.asmx/GetKelasKenderaan", "Pilih Kelas Kenderaan", false, null);
                generateDropdown("ddlJnmaKend", "GeneralWS.asmx/GetJenamaKenderaan", "Pilih Jenama Kenderaan", true, "ddlJnsPnjmn", clearDdlModelKend);
                generateDropdown("ddlMdlKend", "GeneralWS.asmx/GetModelKenderaan", "Pilih Model Kenderaan", true, "ddlJnmaKend");
                generateDropdown("ddlTmpoByrBalik", "GeneralWS.asmx/GetTempohBayarBalik", "Pilih Tempoh", true, "ddlJnsPnjmn");
                generateDropdown("ddlJumlahMhn", "GeneralWS.asmx/GetJumlahMohon", "Pilih Jumlah", true, "ddlJnsPnjmn");
                generateDropdown("ddlSyarikat", "GeneralWS.asmx/GetSyarikat", "Pilih Syarikat", false, null);
                generateDropdown("ddlPenjamin", "GeneralWS.asmx/GetPenjamin", "Pilih Penjamin", false, null);
            });

            var shouldPop = true, searchQuery = "", oldSearchQuery = "", tempNoPinjaman = "", navId = '', delDataId = '', withStatus = false, ttlCklist = 0, curCklist = 0;
            var tempArrChecklist = {}, tempArrPnjmin = [], tempSenaraiSemak = [];

            /*init function*/
            init();

            function init() {
                //Mulakan loader
                show_loader();
                getUserDetails();
                getJabatan();
                //Stop loader dlm function akhir - loadSenaraiP
                loadSenaraiP();
            }

            function formatNumber(number) {
                return new Intl.NumberFormat('en-US', {
                    style: 'decimal',
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                }).format(number);
            }

            $("#btn_semak").click(function () {
                var ddlA = $("#ddlJnsPnjmn").val();
                var ddlB = $("#ddlJumlahMhn").val();
                var ddlC = $("#ddlTmpoByrBalik").val();

                if ((ddlA !== '' && ddlA !== null) && (ddlB !== '' && ddlB !== null && ddlB !== "0") && (ddlC !== '' && ddlC !== null && ddlC !== "0")) {
                    var param = {
                        JenisPinj: ddlA,
                        AmaunMohon: ddlB,
                        TempohByrBalik: ddlC,
                        kodTrfKhidmat: sessionStorage.getItem('kodTrfKhidmat'),
                        kodKump: sessionStorage.getItem('kodKump'),
                        gajiS: sessionStorage.getItem('gajiS')
                    }
                    semakKelayakan(JSON.stringify(param));
                } else {
                    var txtresult = '';
                    var txt = "<h6 class='text-dark'>Sila isi ruangan:<h6/>";
                    if (ddlA === null || ddlA === '') {
                        txtresult += "Jenis Pembiayaan<br/>"
                    }
                    if (ddlC === null || ddlC === '') {
                        txtresult += "Tempoh Pembayaran Balik (Bulan)<br/>"
                    }
                    if (ddlB === null || ddlB === '') {
                        txtresult += "Jumlah yang dipohon (RM)<br/>"
                    }
                    if (txtresult != '') {
                        $('#maklumanModalBil').modal('toggle');
                        $('#detailMaklumanBil').html("<span class='text-danger'>" + txt + txtresult + "</span>");
                    }
                }
            });
            async function semakKelayakan(param) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: "MohonKenderaanWS.asmx/SemakKelayakan",
                        type: "POST",
                        data: JSON.stringify({ postData: param }),
                        dataType: "json", //expected data from server
                        contentType: 'application/json; charset=utf-8', //expected format of parameter send to server",
                        success: function (result) {
                            var jsData = JSON.parse(result.d);
                            $("#semak1").html('RM ' + formatNumber(jsData[0].skimMksm));
                            $("#semak2").html((jsData[0].jmlhAnsrn != '-') ? 'RM ' + formatNumber(jsData[0].jmlhAnsrn) : '-');
                            $("#semak3").html(jsData[0].stsPrmhnan);
                            $("#mdlSmkKlykn").modal('show');
                            resolve(jsData);
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            reject();
                        }
                    });
                });
            }
            //$("#btn-seterusnya").click(function () {
            //    var navId = $('.tab-content .show').attr('id');
            //    if (navId == "tab1") {
            //        $('.nav-tabs a[href="#tab2"]').tab('show');
            //    } else if (navId == "tab2") {
            //        $('.nav-tabs a[href="#tab3"]').tab('show');
            //        $("#btn-seterusnya").addClass("codx");
            //    }
            //});


            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                navId = $(e.target).attr('href');
                if (navId == "#tab1") {
                    $("#btnreset").removeClass("codx");
                    $("#btnSimpan").addClass("codx");
                } else if (navId == "#tab2") {
                    $("#btnreset").addClass("codx");
                    $("#btnSimpan").addClass("codx");
                } else if (navId == "#tab3") {
                    $("#btnreset").addClass("codx");
                    $("#btnSimpan").removeClass("codx");
                }
            });

            tblPjmn = $("#tblSenaraiPenjamin").DataTable({
                "responsive": true,
                "searching": true,
                "sPaginationType": "full_numbers",
                "oLanguage": {
                    "oPaginate": {
                        "sNext": ' <i class="fa fa-forward"></i>',
                        "sPrevious": ' <i class="fa fa-backward"></i>',
                        "sFirst": ' <i class="fa fa-step-backward"></i>',
                        "sLast": ' <i class="fa fa-step-forward"></i>'
                    },
                    "sLengthMenu": "Tunjuk _MENU_ rekod",
                    "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                    "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                    "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
            });

            $('#tbsnraismk').on('change', '.file-input', function () {
                var fileInput = $(this);
                var deleteButton = fileInput.siblings('.delete-button');
                var fileNameLabel = fileInput.siblings('.file-name-label');

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
                                frmData.append("File", file);
                                frmData.append("NamaFile", fileName);
                                frmData.append("SizeFile", fileSize);
                                frmData.append("CheckListId", $(this).data('type'));
                                frmData.append("NoPinjaman", tempNoPinjaman);

                                var checklistid = $(this).data('type');

                                if (!(checklistid in tempArrChecklist)) {
                                    tempArrChecklist[checklistid] = frmData;
                                    fileInput.addClass("selected");
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

            $('#tbsnraismk').on('click', '.delete-button', function () {
                var target = $(this);
                var fileInput = target.siblings('input[type="file"]');
                var fileNameLabel = target.siblings('.file-name-label');
                var type = target.siblings('.file-input');

                delDataId = $(this).attr('id');
                $("#pengesahanBuang").modal('show');
            });

            $("#btnyabuang").off('click').on('click', async function () {
                $("#pengesahanBuang").modal('hide');

                var target = $('#' + delDataId);
                var fileInput = target.siblings('input[type="file"]');
                var fileNameLabel = target.siblings('.file-name-label');
                var type = target.siblings('.file-input');

                var postDt = {
                    CheckListId: type.data('type'),
                    NoPinjaman: tempNoPinjaman
                };
                var result = await ajaxPost('MohonKenderaanWS.asmx/PadamSenaraiSemak', postDt, true);

                if (result.Status) {
                    //Berjaya Dibuang
                    delete tempArrChecklist[type.data('type')]
                    fileInput.val(null); // Clear the file input
                    fileInput.removeClass("codx"); // Show the "Choose File" button
                    fileNameLabel.html('').addClass("codx"); // Clear and hide the file name label
                    fileNameLabel.attr('href', '');
                    target.addClass("codx"); // Hide the delete button
                    fileInput.removeClass("selected");

                    $("#lblMessageModal").html(result.Message);
                    $("#MessageModal").modal('show');
                } else {
                    //Berjaya Dibuang
                    delete tempArrChecklist[type.data('type')]
                    fileInput.val(null); // Clear the file input
                    fileInput.removeClass("codx"); // Show the "Choose File" button
                    fileNameLabel.html('').addClass("codx"); // Clear and hide the file name label
                    fileNameLabel.attr('href', '');
                    target.addClass("codx"); // Hide the delete button
                    fileInput.removeClass("selected");
                }
            })

            //$('#exampleModalCenter').on('shown.bs.modal', function () {
            //    /*if modal show, then trigger this code*/
            //});
            $("#btnButiranHtg").click(async function () {
                var postDt = {}
                var data = await ajaxPost('GeneralWS.asmx/GetSenaraiPotonganStaf', postDt, false);
                console.log(data)
                if (data.Status) {
                    var targetblbody = $("#tblSenaraiPotongan tbody");
                    targetblbody.html('');
                    var newRow = '<tr class="theader table-warning"><td>&nbsp;Bil</td><td>&nbsp;Jenis Pembiayaan/ Perkara</td><td>&nbsp;Jumlah Potongan (RM)</td></tr>';
                    targetblbody.append(newRow);
                    var arrData = data.Payload.ArrData;
                    var totalAmaun = formatNumber(data.Payload.TotalAmaun);
                    var i = 0;
                    $.each(arrData, function (index, value) {
                        i++;
                        newRow = '<tr><td>&nbsp;' + i + '</td><td>&nbsp;' + value.Butiran + '</td><td><div align="right">' + formatNumber(value.Amaun) + '</div></td></tr>';
                        targetblbody.append(newRow);
                    });
                    newRow = '<tr><td colspan="2"><b>Jumlah Hutang/ Potongan<b/></td><td><div align="right"><b>' + totalAmaun + '</b></div></td></tr>'
                    targetblbody.append(newRow);
                    $('#exampleModalCenter').modal('show');
                }
            });

            tbl = $("#tblSenPemohon").DataTable({
                "responsive": true,
                "searching": true,
                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
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
                    { targets: [5], className: 'text-center' }
                ],
                "columns": [
                    { "data": "row_num" },
                    { "data": "Tkh_Mohon" },
                    { "data": "No_Pinj" },
                    { "data": "Jenis_Pinj" },
                    { "data": "StatusDok" },
                    { "data": "StatusLyk" },
                ],
                createdRow: function (row, data, dataIndex) {
                    // row.dataset.jenisinvois = data["Jenis_Invois"];
                    row.dataset.target = data["No_Pinj"]
                    row.onclick = slctTblRow
                }

            });

            function slctTblRow(e) {
                var target = e.target
                while (target.tagName != "TR") {
                    target = target.parentElement
                }

                var postDt = {
                    noPinjaman: target.dataset.target
                }

                ajaxPost('MohonKenderaanWS.asmx/FetchSelectedPermohonan', postDt, false, slctdPermohonanProses);
            }

            async function loadSenaraiP() {

                var data = await ajaxPost('<%= ResolveUrl("~/FORMS/PINJAMAN/MOHON/MohonKenderaanWS.asmx/fetchSenaraiPermohonan") %>', {}, false);

                if (isSet(data)) {
                    tbl.clear();
                    tbl.rows.add(data.Payload).draw();
                    var rowCount = tbl.rows().count();

                    // Check if there are rows
                    if (rowCount > 0) {
                        $("#snraiMhnBadge").html(rowCount);
                        $("#snraiMhnBadge").removeClass('codx');
                    } else {
                        $("#snraiMhnBadge").addClass('codx');
                    }

                    close_loader();
                }
            }

            async function getUserDetails() {

                var data = await ajaxPost('<%= ResolveUrl("~/FORMS/PINJAMAN/MOHON/GeneralWS.asmx/fetchUserDetails") %>', {}, false);

                if (isSet(data)) {
                    $(".id_nama").val(data[0].Nama);
                    $(".id_kp").val(data[0].NoKp);
                    $(".id_staff").val(data[0].NoStaf);
                    $(".id_tkhlahir").val(data[0].TkhLahir); ''
                    $(".id_taraf").val(data[0].TarafKhidmat);
                    $(".id_tkhLantikan").val(data[0].TkhLantik);
                    $(".id_jwtn").val(data[0].JawGiliran);
                    $(".id_gajisbln").val("RM " + formatNumber(data[0].GajiS));
                    $(".id_fakulti").val(data[0].Pejabat);
                    $(".id_nolesen").val(data[0].NoLesen);
                    $(".id_klslesen").val(data[0].KelasLesen);
                    $(".id_pekerja").val(data[0].NoStaf);
                    $(".tkhpngshn").val(data[0].TkhSah);
                    $(".gredjaw").val(data[0].GredGajiS);
                    $(".noTel").val(data[0].NoTel);
                    $(".noHp").val(data[0].NoHp);
                    $(".id_umur").val(data[0].AgeYear + " Tahun, " + data[0].AgeMonth + " Bulan");
                    resizeTextarea(".id_fakulti");
                    sessionStorage.setItem('kodTrfKhidmat', data[0].KodTarafKhidmat)
                    sessionStorage.setItem('kodKump', data[0].Kumpulan)
                    sessionStorage.setItem('gajiS', data[0].GajiS)

                    //Semak Taraf Khidmat
                    if (isNeedPnjmin(data[0].KodTarafKhidmat)) {
                        $("#penjamin-tab").parent().removeClass("codx")
                    } else {
                        $("#penjamin-tab").parent().addClass("codx")
                        $("#tab2").html('');
                    }

                    isNeedPnjmin(data[0].KodTarafKhidmat)
                }
            }

            async function getJabatan() {
                var data = await ajaxPost('<%= ResolveUrl("~/FORMS/PINJAMAN/MOHON/MohonKenderaanWS.asmx/fetchJabatan") %>', {}, false);

                if (isSet(data)) {
                    var text = data[0].Nama + "\n" + data[0].Almt1 + "\n" + ((data[0].Almt2 != '-') ? data[0].Almt2 + "\n" : '') + data[0].Poskod + ", " + data[0].Bandar + "\n" + data[0].Negeri;
                    $(".almtJbtn").val(text);
                    resizeTextarea('.almtJbtn');
                }
            }

            function clearDdlModelKend() {
                $("#ddlMdlKend").dropdown("clear");
            }

            function clearDdlTempohJmlhPohon() {
                $("#ddlTmpoByrBalik").dropdown("clear");
                $("#ddlJumlahMhn").dropdown("clear");
                $("#ddlJnmaKend").dropdown("clear");
                $("#ddlMdlKend").dropdown("clear");
            }

            $("#ddlJnsPnjmn").on('change', function () {
                if (isSet(tempNoPinjaman)) {
                    getSenaraiSemakSelected()
                } else {
                    getSenaraiSemak();
                }
            });

            async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {

                var param = '';
                (sendData !== null && sendData !== undefined) ? param = '' : param = '?q={query}';

                $('#' + id).dropdown({
                    fullTextSearch: true,
                    placeholder: plchldr,
                    apiSettings: {
                        url: url + param,
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        //onChange: function (value, text, $selectedItem) {
                        //    if (fn !== null && fn !== undefined) {
                        //        return fn();
                        //    }
                        //},
                        beforeSend: function (settings) {
                            if (send2ws) {
                                settings.data = JSON.stringify({
                                    q: settings.urlData.query,
                                    data: $('#' + sendData).val()
                                });
                                searchQuery = settings.urlData.query;
                                return settings;
                            } else {
                                // Replace {query} placeholder in data with user-entered search term
                                settings.data = JSON.stringify({ q: settings.urlData.query });
                                searchQuery = settings.urlData.query;
                                return settings;
                            }
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

                            if (fn !== null && fn !== undefined) {
                                fn();
                            }

                            /*dependable ddl if sendata value == empty clear all option*/
                            if (sendData !== null && sendData !== undefined) {
                                var tempDt = $('#' + sendData).val();
                                if (tempDt == null && tempDt == undefined) {
                                    $('#' + id + ' .dropdown').addClass("disableDdlIcon");
                                    return false;
                                }
                            }

                            //if (searchQuery !== oldSearchQuery) {
                            //$(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

            function resizeTextarea(target) {
                var textarea = $(target);
                var text = textarea.val();
                var textLength = text.length;
                var spaces = (text.match(/ /g) || []).length; // Count spaces in the text
                var minRows = 2; // Minimum number of rows
                var maxRows = 10; // Maximum number of rows
                var charsPerRow = 20; // Adjust this value based on your layout

                // Calculate the number of rows based on text length and spaces
                var rows = Math.ceil((textLength + spaces) / charsPerRow);

                // Ensure the number of rows is within the specified range
                rows = Math.max(minRows, Math.min(maxRows, rows));

                // Set the textarea rows
                textarea.attr('rows', rows);
            }

            $("#ddlSyarikat").change(function () {
                var targetId = $(this).val();
                if (isSet(targetId)) {
                    /*Dptkn mklmt syrkt pnjmn*/
                    let url = '<%= ResolveUrl("~/FORMS/PINJAMAN/MOHON/GeneralWS.asmx/GetMaklumatSyarikat") %>'
               $.ajax({
                   url: url,
                   method: "POST",
                   dataType: "json",
                   data: JSON.stringify({ id: targetId }),
                   contentType: "application/json;charset=utf-8",
                   success: function (data) {
                       data = JSON.parse(data.d);
                       //no syarikat
                       $(".noSykt").val(data[0].NoSykt);
                       //nama syarikat
                       $(".mmSykt").val(data[0].NmSykt);
                       //alamat syarikat
                       var text = data[0].Almt1 + " " + ((data[0].Almt2 != '-') ? data[0].Almt2 + "\n" : '') + data[0].Poskod + ", " + data[0].Bandar + "\n" + data[0].Negeri;
                       $(".almtSyrkt").val(text);
                       resizeTextarea('.almtSyrkt');
                       //show info syarikat
                       $(".infosyarikat").removeClass("codx");
                   },
                   error: function (xhr, status, error) {
                       console.error(error);
                       close_loader();
                   }
               });
           }
       });

            $("#ddlPenjamin").change(function () {
                var ttlRow = tblPjmn.rows().count();

                //Check jumlah samasa senarai penjamin jika < 2 org
                if (ttlRow < 2) {
                    $("#tablePenjamin").addClass("codx");
                    var targetId = $(this).val();
                    /*Dptkn mklmt syrkt pnjmn*/
                    let url = '<%= ResolveUrl("~/FORMS/PINJAMAN/MOHON/GeneralWS.asmx/GetMaklumatPenjamin") %>'
              $.ajax({
                  url: url,
                  method: "POST",
                  dataType: "json",
                  data: JSON.stringify({ id: targetId }),
                  contentType: "application/json;charset=utf-8",
                  success: function (data) {
                      data = JSON.parse(data.d);
                      // No kp
                      $("#pjmnKp").html(data[0].NoKp);
                      // No Pekerja
                      $("#pjmnNoPekerja").html(targetId);
                      // Tarikh Lahir
                      $("#pjmnTkhLhr").html(data[0].TkhLahir);
                      // Alamat UTEM
                      $("#pnmnAlamat").html(data[0].Alamat);
                      // Jawatan
                      $("#pjmnJawatan").html(data[0].Jawatan);
                      // Tarikh Sah dlm Jawatan
                      $("#pjmnSahJawatan").html(data[0].TkhSah); noStafPenjamin
                      $("#noStafPenjamin").val(targetId);

                      //Simpan pada session storage
                      sessionStorage.setItem('snraiPnjmin',
                          JSON.stringify({
                              nama: data[0].Nama,
                              nopkj: targetId
                          }));

                      $("#tablePenjamin").removeClass("codx");
                  },
                  error: function (xhr, status, error) {
                      console.error(error);
                  }
              });
          } else {
              //alert kpd user
              $("#lblMessageModal").html("HANYA 2 ORANG PENJAMIN SAHAJA YANG DIPERLUKAN");
              $("#MessageModal").modal('show');
          }

      });

            $("#btnTambah").click(function () {
                var ttlRow = tblPjmn.rows().count();
                var data = JSON.parse(sessionStorage.getItem('snraiPnjmin'))
                if (ttlRow < 2) {
                    if (!tempArrPnjmin.includes(data.nopkj)) {
                        tempArrPnjmin.push(data.nopkj);
                        var newData = [ttlRow + 1, data.nopkj, data.nama, 'TIADA', '<div class="btn btn-light text-center btn-padam">Padam</div>'];
                        tblPjmn.row.add(newData).draw();
                    }
                }

                $("#tablePenjamin").addClass("codx");

                //Reset dropdownlist dan no staff penjamin
                $("#noStafPenjamin").val('');


            });

            $("#tblSenaraiPenjamin").on('click', '.btn-padam', function () {
                var row = $(this).closest('tr');

                // Get the row number
                var rowNumber = tblPjmn.row(row).index();

                // Delete row tempArrPnjmin
                tempArrPnjmin.splice(rowNumber, 1);

                // Delete row
                tblPjmn.row(row).remove().draw()
            });

            $("#showBtn").off('click', "#btnSimpanDraf").on('click', "#btnSimpanDraf", async function () {
                //Dptkan no tab
                var navId = $('.tab-content .show').attr('id');
                var jumlahFail = $("#tbsnraismk .file-input.selected").length;
                if (navId == "tab1") {
                    saveTab1()
                } else if (navId == "tab2") {
                    saveTab2()
                } else if (navId == "tab3") {
                    if (jumlahFail > 0) {
                        withStatus = false;
                        saveTab3()
                    }
                }
            });

            $("#showBtn").off('click', "#btnSimpan").on('click', "#btnSimpan", async function () {
                //Check data
                var kodTaraf = sessionStorage.getItem('kodTrfKhidmat');
                var ttlSnraiSemak = tempSenaraiSemak.length;
                var jumlahFail = $("#tbsnraismk .file-input.selected").length;
                console.log(jumlahFail)
                if (isSet(tempNoPinjaman)) {
                    if (ttlSnraiSemak == jumlahFail) {
                        if (isNeedPnjmin(kodTaraf)) {
                            if (tempArrPnjmin.length == 2) {
                                withStatus = true
                                saveTab3();
                            } else {
                                $("#lblMessageModal").html("SILA LENGKAPKAN MAKLUMAT PENJAMIN TERLEBIH DAHULU");
                                $("#MessageModal").modal('show');
                            }
                        } else {
                            withStatus = true
                            saveTab3();
                        }
                    } else {
                        $("#lblMessageModal").html("SILA LENGKAPKAN KESEMUA " + ttlSnraiSemak + " SENARAI SEMAK");
                        $("#MessageModal").modal('show');
                    }
                } else {
                    //alert kpd user
                    $("#lblMessageModal").html("SILA LENGKAPKAN MAKLUMAT PEMOHON / BUTIR-BUTIR PEMBELIAN TERLEBIH DAHULU");
                    $("#MessageModal").modal('show');
                }
            });

            $("#showBtn").on("click", "#btnreset", function () {
                //Dptkan no tab
                var navId = $('.tab-content .show').attr('id');
                if (navId == "tab1") {
                    //
                    tempNoPinjaman = '';
                    $('#noPinjaman').val('');
                    $("#tkhTmtLesen").val('');
                    $('#divbutirpembelian .input-group__select select').each(function () {
                        var tempSlctr = $(this).val();
                        if (isSet(tempSlctr)) {
                            $(this).dropdown("clear");
                        }
                    });
                    $('#divbutirpembelian .input-group__input').each(function () {
                        $(this).val(''); // Set the value to an empty string
                    });
                    //hide info syarikat
                    $(".infosyarikat").addClass("codx");


                    //TAB 2
                    //Clear table tblPjmn
                    tblPjmn.clear().draw();
                    //Clear array tempArrPnjmin
                    tempArrPnjmin = [];

                    $('#divpenjamin .input-group__select').each(function () {
                        $(this).dropdown("clear");
                    });
                    $('#divpenjamin .input-group__input').each(function () {
                        $(this).val(''); // Set the value to an empty string
                    });

                    //TAB3
                    //Clear input file, label name, del button 
                    tempArrChecklist = {};
                    $('#tbsnraismk .delete-button').each(function () {
                        var fileInput = $(this).siblings('input[type="file"]');
                        var fileNameLabel = $(this).siblings('.file-name-label');
                        var type = $(this).siblings('.file-input');

                        delete tempArrChecklist[type.data('type')]
                        fileInput.val(null); // Clear the file input
                        fileInput.removeClass("codx"); // Show the "Choose File" button
                        fileNameLabel.html('').addClass("codx"); // Clear and hide the file name label
                        fileNameLabel.attr('href', '');
                        $(this).addClass("codx"); // Hide the delete button
                        fileInput.removeClass("selected");
                    });

                    enableEdit();
                }
            });

            function disableEdit() {
                $("#tkhTmtLesen").prop('disabled', true).prop('readonly', true);
                $('#divbutirpembelian .input-group__select select').each(function () {
                    $(this).parent().addClass('disabled');
                    $(this).parent().parent().addClass('incolor')
                });
                $('#divbutirpembelian .input-group__input').each(function () {
                    $(this).prop('disabled', true).prop('readonly', true);
                });

                $('#divpenjamin .input-group__select').each(function () {
                    $(this).parent().addClass('disabled');
                    $(this).parent().parent().addClass('incolor')
                });
                $('#divpenjamin .input-group__input').each(function () {
                    $(this).prop('disabled', true).prop('readonly', true);
                });

                $('#tbsnraismk .delete-button').each(function () {
                    var fileInput = $(this).siblings('input[type="file"]');
                    fileInput.prop('disabled', true).prop('readonly', true);
                });

                $(".btn-padam").addClass("codx");
                $(".delete-button").addClass("codx");
                $("#showBtn").html('');
            }

            function enableEdit() {
                $("#tkhTmtLesen").prop('disabled', false).prop('readonly', false);
                $('#divbutirpembelian .input-group__select select').each(function () {
                    $(this).parent().removeClass('disabled');
                    $(this).parent().parent().removeClass('incolor')
                });
                $('#divbutirpembelian .input-group__input').each(function () {
                    $(this).prop('disabled', false).prop('readonly', false);
                });

                $('#divpenjamin .input-group__select').each(function () {
                    $(this).parent().removeClass('disabled');
                    $(this).parent().parent().removeClass('incolor')
                });
                $('#divpenjamin .input-group__input').each(function () {
                    $(this).prop('disabled', false).prop('readonly', false);
                });

                $('#tbsnraismk .delete-button').each(function () {
                    var fileInput = $(this).siblings('input[type="file"]');
                    fileInput.prop('disabled', false).prop('readonly', false);
                });

                $(".btn-padam").removeClass("codx");
                $(".delete-button").each(function () {
                    var fileNameLabel = $(this).siblings('.file-name-label');
                    var hrefLink = fileNameLabel.attr('href');
                    //check href 
                    if (isSet(hrefLink)) {
                        $(this).removeClass("codx");
                    } else {
                        $(this).addClass("codx");
                    }
                });

                $("#showBtn").html('<button id="btnreset" type="button" class="btn btn-setsemula">Permohonan Baru</button> <button id = "btnSimpanDraf" type = "button" class="btn btn-secondary" >Simpan Draf</button > <button id="btnSimpan" type="button" class="btn btn-success codx">Simpan dan Hantar</button>');

                if (navId == "#tab1") {
                    $("#btnreset").removeClass("codx");
                    $("#btnSimpan").addClass("codx");
                } else if (navId == "#tab2") {
                    $("#btnreset").addClass("codx");
                    $("#btnSimpan").addClass("codx");
                } else if (navId == "#tab3") {
                    $("#btnreset").addClass("codx");
                    $("#btnSimpan").removeClass("codx");
                }

                $(".noSykt").prop('disabled', true).prop('readonly', true);
            }

            $('#btnYaSubmit').off('click').on('click', async function () {
                var navId = $('.tab-content .show').attr('id');
                if (navId == "tab1") {
                    yaSimpan1()
                } else if (navId == "tab2") {
                    yaSimpan2()
                } else if (navId == "tab3") {
                    yaSimpan3()
                }
            });

            async function getSenaraiSemakSelected() {
                var postDt = {
                    Jenis_Pinj: $("#ddlJnsPnjmn").val(),
                    noPinjaman: tempNoPinjaman,
                    KodTarafK: sessionStorage.getItem('kodTrfKhidmat')
                };
                var data = await ajaxPost('MohonKenderaanWS.asmx/GetSenaraiSemakSelected', postDt, false);
                if (isSet(data)) {
                    if (data.Status) {

                        var tempData1, tempData2 = '';
                        var dt1, dt2 = '';

                        if (isSet(data.Payload.Data1)) {
                            tempData1 = JSON.parse(data.Payload.Data1);
                            dt1 = tempData1
                        }
                        if (isSet(data.Payload.Data2)) {
                            tempData2 = JSON.parse(data.Payload.Data2);
                            dt2 = tempData2
                        }

                        var arrSenaraiSemak = [];
                        tempSenaraiSemak = [];
                        arrSenaraiSemak = dt1;

                        $('#tbsnraismk tbody').html('');
                        //default header
                        newRow = '<tr><td colspan="3"><strong>SENARAI SEMAK</strong><br>Sila pastikan dokumen sokongan tersebut dihantar bersama semasa Permohonan Pembiayaan.</td></tr><tr class="theader table-warning"><td>Bil</td><td>Perkara</td><td>Hantar</td></tr>';

                        arrSenaraiSemak.forEach(function (element, index) {
                            tempSenaraiSemak.push(element.ID_CheckList);
                            newRow += '<tr><td>&nbsp;' + (index + 1) + '</td><td>&nbsp;' + element.Butiran + '</td><td><div class="file-upload-container"><input name="fileHantar' + (index + 1) + '" type="file" id="fileInput' + (index + 1) + '" data-type="' + element.ID_CheckList + '" accept=".pdf, .doc, .docx" class="file-input"><a class="file-name-label" id="fileNameLabel' + (index + 1) + '"></a><span class="ml-3 delete-button codx" id="deleteButton' + element.ID_CheckList + '"><i class="far fa-trash-alt fa-lg"></i></span></div></td></tr>'
                        });

                        $("#tbsnraismk tbody").append(newRow);

                        //To display

                        //Clear Listing Senarai Semak
                        tempArrChecklist = {};
                        $('#tbsnraismk .delete-button').each(function () {
                            var fileInput = $(this).siblings('input[type="file"]');
                            var fileNameLabel = $(this).siblings('.file-name-label');
                            var type = $(this).siblings('.file-input');

                            delete tempArrChecklist[type.data('type')]
                            fileInput.val(null); // Clear the file input
                            fileInput.removeClass("codx"); // Show the "Choose File" button
                            fileNameLabel.html('').addClass("codx"); // Clear and hide the file name label
                            fileNameLabel.attr('href', '');
                            $(this).addClass("codx"); // Hide the delete button
                            fileInput.removeClass('selected');
                        });

                        if (isSet(dt2)) {
                            // Using a regular loop to iterate over the tempArrChecklist keys
                            tempSenaraiSemak.forEach(function (element, index) {
                                var checklistid = element;
                                var item = dt2.find(function (item) {
                                    return item.ID_CheckList === checklistid;
                                });

                                if (item) {
                                    var targetRow = $('#deleteButton' + checklistid);
                                    var fileInput = targetRow.siblings('input[type="file"]');
                                    var fileNameLabel = targetRow.siblings('.file-name-label');

                                    //temporary URL
                                    var url = '<%= ResolveUrl("~/Upload/Document/PINJAMAN/MOHON/") %>' + item.Nama_Fail;
                   // Now you can use this url to view the file
                   fileNameLabel.attr('href', url);
                   //tag to open a link in a new tab
                   fileNameLabel.attr('target', '_blank');
                   //This is to prevent a type of phishing known as tabnabbing1
                   fileNameLabel.attr('rel', 'noopener noreferrer');
                   // File is selected, show delete button
                   fileInput.addClass('codx');
                   targetRow.removeClass('codx');
                   fileNameLabel.html('<i class="far fa-eye fa-lg"></i> ' + item.Nama_Fail).removeClass('codx');
                   fileInput.addClass('selected');
               }
           });
                        }
                    }
                }
            }

            async function getSenaraiSemak() {

                var postDt = {
                    Jenis_Pinj: $("#ddlJnsPnjmn").val(),
                    KodTarafK: sessionStorage.getItem('kodTrfKhidmat')
                };
                var data = await ajaxPost('MohonKenderaanWS.asmx/GetSenaraiSemak', postDt, false);
                if (isSet(data)) {
                    if (data.Status) {
                        var arrSenaraiSemak = [];
                        tempSenaraiSemak = [];
                        arrSenaraiSemak = data.Payload;

                        $('#tbsnraismk tbody').html('');
                        //default header
                        newRow = '<tr><td colspan="3"><strong>SENARAI SEMAK</strong><br>Sila pastikan dokumen sokongan tersebut dihantar bersama semasa Permohonan Pembiayaan.</td></tr><tr class="theader table-warning"><td>Bil</td><td>Perkara</td><td>Hantar</td></tr>';

                        arrSenaraiSemak.forEach(function (element, index) {
                            tempSenaraiSemak.push(element.ID_CheckList);
                            newRow += '<tr><td>&nbsp;' + (index + 1) + '</td><td>&nbsp;' + element.Butiran + '</td><td><div class="file-upload-container"><input name="fileHantar' + (index + 1) + '" type="file" id="fileInput' + (index + 1) + '" data-type="' + element.ID_CheckList + '" accept=".pdf, .doc, .docx" class="file-input"><a class="file-name-label" id="fileNameLabel' + (index + 1) + '"></a><span class="ml-3 delete-button codx" id="deleteButton' + element.ID_CheckList + '"><i class="far fa-trash-alt fa-lg"></i></span></div></td></tr>'
                        });

                        $("#tbsnraismk tbody").append(newRow);
                    }
                }
            }

            //BUTANG YA SIMPAN
            function yaSimpan1() {
                //Butiran Maklumat Pemohon

                //tutup modal
                $('#confirmationModalSubmit').modal('hide');
                var statusDok = sessionStorage.getItem("statusDok");
                var canSave;
                if (isSet(statusDok)) {
                    if (statusDok == '05') {
                        canSave = false
                    } else {
                        canSave = true;
                    }
                } else {
                    canSave = true;
                }

                if (canSave) {
                    if (isSet(tempNoPinjaman)) {
                        //Update Data
                        var postDt = {
                            NoPinjaman: viewDt(tempNoPinjaman, 'text'),
                            TkhTamatLesen: viewDt($("#tkhTmtLesen").val(), 'text'),
                            JenisPinj: viewDt($("#ddlJnsPnjmn").val(), 'text'),
                            TempohByrBalik: viewDt($("#ddlTmpoByrBalik").val(), 'int'),
                            AmaunMohon: viewDt($("#ddlJumlahMhn").val(), 'double'),
                            JenamaKend: viewDt($("#ddlJnmaKend").val(), 'text'),
                            MdlKend: viewDt($("#ddlMdlKend").val(), 'text'),
                            NoPendaftaran: viewDt($("#noPndftrn").val(), 'text'),
                            KelasKend: viewDt($("#ddlKlsKend").val(), 'text'),
                            TahunBuat: viewDt($("#thnDibuat").val(), 'int'),
                            SukatSilinder: viewDt($("#ddlSktSilinder").val(), 'double'),
                            NoEnjin: viewDt($("#noEnjin").val(), 'text'),
                            NoChasis: viewDt($("#noChasis").val(), 'text'),
                            BhnBakar: viewDt($("#ddlBhnBakar").val(), 'text'),
                            BdnKend: viewDt($("#ddlBdnKend").val(), 'text'),
                            HargaBersih: viewDt($("#hrgaBrsih").val().replace(',', ''), 'double'),
                            KendSediaAda: viewDt($("#kendSediaAda").val(), 'text'),
                            JwtnPerluKend: viewDt($("#jwtnPerluKend").val(), 'text'),
                            IdSyarikat: viewDt($("#ddlSyarikat").val(), 'text'),
                        };
                        ajaxPost('MohonKenderaanWS.asmx/KemaskiniPermohonanKenderaan', postDt, true, kemaskiniPermohonanBerjaya);
                    } else {
                        //Insert Data
                        var postDt = {
                            TkhTamatLesen: viewDt($("#tkhTmtLesen").val(), 'text'),
                            JenisPinj: viewDt($("#ddlJnsPnjmn").val(), 'text'),
                            TempohByrBalik: viewDt($("#ddlTmpoByrBalik").val(), 'int'),
                            AmaunMohon: viewDt($("#ddlJumlahMhn").val(), 'double'),
                            JenamaKend: viewDt($("#ddlJnmaKend").val(), 'text'),
                            MdlKend: viewDt($("#ddlMdlKend").val(), 'text'),
                            NoPendaftaran: viewDt($("#noPndftrn").val(), 'text'),
                            KelasKend: viewDt($("#ddlKlsKend").val(), 'text'),
                            TahunBuat: viewDt($("#thnDibuat").val(), 'int'),
                            SukatSilinder: viewDt($("#ddlSktSilinder").val(), 'double'),
                            NoEnjin: viewDt($("#noEnjin").val(), 'text'),
                            NoChasis: viewDt($("#noChasis").val(), 'text'),
                            BhnBakar: viewDt($("#ddlBhnBakar").val(), 'text'),
                            BdnKend: viewDt($("#ddlBdnKend").val(), 'text'),
                            HargaBersih: viewDt($("#hrgaBrsih").val().replace(',', ''), 'double'),
                            KendSediaAda: viewDt($("#kendSediaAda").val(), 'text'),
                            JwtnPerluKend: viewDt($("#jwtnPerluKend").val(), 'text'),
                            IdSyarikat: viewDt($("#ddlSyarikat").val(), 'text'),
                            KodTarafKhidmat: sessionStorage.getItem('kodTrfKhidmat'),
                            NoLesen: viewDt($(".id_nolesen").val(), 'text'),
                            KelasMemandu: viewDt($(".id_klslesen").val(), 'text'),
                        };
                        ajaxPost('MohonKenderaanWS.asmx/SubmitPermohonanKenderaan', postDt, true, permohonanBerjaya);
                    }
                }
            }

            function yaSimpan2() {

                //tutup modal
                $('#confirmationModalSubmit').modal('hide');

                var statusDok = sessionStorage.getItem("statusDok");
                var canSave;
                if (isSet(statusDok)) {
                    if (statusDok == '05') {
                        canSave = false
                    } else {
                        canSave = true;
                    }
                } else {
                    canSave = true;
                }

                if (canSave) {
                    // check table row
                    var ttlRow = tblPjmn.rows().count();
                    if (ttlRow > 0) {
                        var postDt = {
                            DataPenjamin: JSON.stringify(tempArrPnjmin),
                            NoPinjaman: tempNoPinjaman
                        };

                        ajaxPost('MohonKenderaanWS.asmx/SubmitPenjamin', postDt, true, tmbhPenjaminBerjaya);
                    } else {
                        var postDt = {
                            NoPinjaman: tempNoPinjaman
                        }

                        ajaxPost('MohonKenderaanWS.asmx/ClearPenjamin', postDt, true, clearPenjaminBerjaya);
                    }
                }
            }

            async function yaSimpan3() {
                // tutup modal
                $('#confirmationModalSubmit').modal('hide');

                var statusDok = sessionStorage.getItem("statusDok");
                var canSave;
                if (isSet(statusDok)) {
                    if (statusDok == '05') {
                        canSave = false
                    } else {
                        canSave = true;
                    }
                } else {
                    canSave = true;
                }

                if (canSave) {
                    // ambil input file
                    show_loader();
                    curCklist = 0;
                    ttlCklist = Object.keys(tempArrChecklist).length;

                    // Creating a Promise
                    var loopPromise = $.Deferred().resolve().promise();

                    // Using a regular loop to iterate over the tempArrChecklist keys
                    for (const key in tempArrChecklist) {
                        if (tempArrChecklist.hasOwnProperty(key)) {
                            // Using await inside an async function
                            await ajaxPostFile('MohonKenderaanWS.asmx/SubmitCheckList', tempArrChecklist[key], false, uploadCklistBerjaya);
                        }
                    }

                    // Attaching a callback using the Promise
                    loopPromise.done(async function () {
                        if (withStatus) {
                            var postDt = {
                                NoPinjaman: tempNoPinjaman
                            };
                            var rdata = await ajaxPost('MohonKenderaanWS.asmx/PermohonanLengkap', postDt, false);
                            console.log(rdata)
                            if (rdata.Status) {
                                close_loader();
                                $("#lblMessageModal").html(rdata.Message);
                                $("#MessageModal").modal('show');
                                $("#showBtn").html('');
                                loadSenaraiP();
                                disableEdit();
                            } else {
                                close_loader();
                                $("#lblMessageModal").html(rdata.Message);
                                $("#MessageModal").modal('show');
                            }
                        } else {
                            if (curCklist === ttlCklist) {
                                close_loader();
                                $("#lblMessageModal").html("Fail berjaya dimuat naik");
                                $("#MessageModal").modal('show');
                            }
                        }
                    });
                }
            }

            function permohonanBerjaya(data) {
                //check status post
                if (data.Status) {
                    //assign kepada var temp_noPinjaman
                    tempNoPinjaman = data.Payload.nopinjaman
                    $("#lblMessageModal").html(data.Message);
                    $("#MessageModal").modal('show');
                    $("#noPinjaman").val(tempNoPinjaman);
                    loadSenaraiP();
                } else {
                    $("#lblMessageModal").html(data.Message);
                    $("#MessageModal").modal('show');
                }
            }

            function kemaskiniPermohonanBerjaya(data) {
                //check status post
                if (data.Status) {
                    $("#lblMessageModal").html(data.Message);
                    $("#MessageModal").modal('show');
                    loadSenaraiP();
                } else {
                    $("#lblMessageModal").html(data.Message);
                    $("#MessageModal").modal('show');
                }
            }

            function tmbhPenjaminBerjaya(data) {
                console.log(data)
                if (data.Status) {
                    $("#lblMessageModal").html(data.Message);
                    $("#MessageModal").modal('show');
                } else {
                    $("#lblMessageModal").html(data.Message);
                    $("#MessageModal").modal('show');
                }
            }

            function clearPenjaminBerjaya(data) {
                console.log(data)
                if (data.Status) {
                    $("#lblMessageModal").html(data.Message);
                    $("#MessageModal").modal('show');
                } else {
                    $("#lblMessageModal").html(data.Message);
                    $("#MessageModal").modal('show');
                }
            }

            function uploadCklistBerjaya(data) {
                if (data.success) {
                    curCklist = curCklist + 1;
                }
            }

            function slctdPermohonanProses(data) {
                if (data.Status) {
                    //assing to tab1 input field
                    var tempData, tempData2, tempData3 = '';
                    var dt, dt2, dt3 = '';
                    var statusDok = '';

                    if (isSet(data.Payload.DataTab1)) {
                        tempData = JSON.parse(data.Payload.DataTab1);
                        dt = tempData[0]
                    }

                    if (isSet(data.Payload.DataTab2)) {
                        tempData2 = JSON.parse(data.Payload.DataTab2);
                        dt2 = tempData2
                    }

                    if (isSet(data.Payload.DataTab3)) {
                        tempData3 = JSON.parse(data.Payload.DataTab3);
                        dt3 = tempData3
                    }

                    if (isSet(dt)) {
                        tempNoPinjaman = dt.No_Pinj;
                        statusDok = dt.Status_Dok;
                        $("#noPinjaman").val(dt.No_Pinj);
                        $("#tkhTmtLesen").val(dt.TkhTmtLesen);
                        $("#noPndftrn").val(dt.No_Pendaftaran);
                        $("#thnDibuat").val(dt.TahunBuat);
                        $("#noEnjin").val(dt.No_Enjin);
                        $("#noChasis").val(dt.No_Casis);
                        $("#hrgaBrsih").val(dt.Harga_Bersih.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                        $("#kendSediaAda").val(dt.KendSediaAda);
                        $("#jwtnPerluKend").val(dt.JwtnPerluKend);
                        $(".noSykt ").val(dt.NoSykt);

                        buildDdl('ddlJnsPnjmn', dt.KodJenisPinj, dt.TxtJenisPinj);
                        buildDdl('ddlTmpoByrBalik', dt.Tempoh_Pinj, dt.Tempoh_Pinj);
                        buildDdl('ddlJumlahMhn', dt.Amaun_Mohon, dt.Amaun_Mohon.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                        buildDdl('ddlJnmaKend', dt.KodJenama, dt.TxtJenama);
                        buildDdl('ddlMdlKend', dt.KodModel, dt.TxtModel);
                        buildDdl('ddlKlsKend', dt.KodKelasKend, dt.TxtKelasKend);
                        buildDdl('ddlSktSilinder', dt.KodSukatSldr, dt.TxtSukatSldr);
                        buildDdl('ddlBhnBakar', dt.KodBhnBkr, dt.TxtBhnBkr);
                        buildDdl('ddlSyarikat', dt.IdSykt, dt.NamaSykt);
                        buildDdl('ddlBdnKend', dt.KodBdnKend, dt.TxtBdnKend);
                    }

                    getSenaraiSemakSelected();

                    //TAB 2
                    //Clear table tblPjmn
                    tblPjmn.clear().draw();
                    //Clear array tempArrPnjmin
                    tempArrPnjmin = [];
                    if (isSet(dt2)) {
                        $.each(dt2, function (index, value) {
                            if (!tempArrPnjmin.includes(value.No_Staf)) {
                                tempArrPnjmin.push(value.No_Staf);
                                var ckSetuju = '';
                                var setuju = value.Setuju;
                                if (!setuju == '1') {
                                    //Checking bagi yg setuju xbleh papar btn delete
                                    ckSetuju = '<div class="btn btn-light text-center btn-padam">Padam</div>';
                                }
                                var newData = [value.Bil, value.No_Staf, value.NamaPenjamin, '-', ckSetuju];
                                tblPjmn.row.add(newData).draw();
                            }
                        });
                    }

                    //Clear Listing Senarai Semak
                    tempArrChecklist = {};
                    $('#tbsnraismk .delete-button').each(function () {
                        var fileInput = $(this).siblings('input[type="file"]');
                        var fileNameLabel = $(this).siblings('.file-name-label');
                        var type = $(this).siblings('.file-input');

                        delete tempArrChecklist[type.data('type')]
                        fileInput.val(null); // Clear the file input
                        fileInput.removeClass("codx"); // Show the "Choose File" button
                        fileNameLabel.html('').addClass("codx"); // Clear and hide the file name label
                        fileNameLabel.attr('href', '');
                        $(this).addClass("codx"); // Hide the delete button
                        fileInput.removeClass('selected');
                    });
                    if (isSet(dt3)) {
                        // Using a regular loop to iterate over the tempArrChecklist keys
                        tempSenaraiSemak.forEach(function (element, index) {
                            var checklistid = element;
                            var item = dt3.find(function (item) {
                                return item.ID_CheckList === checklistid;
                            });

                            if (item) {
                                var targetRow = $('#deleteButton' + checklistid);
                                var fileInput = targetRow.siblings('input[type="file"]');
                                var fileNameLabel = targetRow.siblings('.file-name-label');

                                //temporary URL
                                var url = '<%= ResolveUrl("~/Upload/Document/PINJAMAN/MOHON/") %>' + item.Nama_Fail;
               // Now you can use this url to view the file
               fileNameLabel.attr('href', url);
               //tag to open a link in a new tab
               fileNameLabel.attr('target', '_blank');
               //This is to prevent a type of phishing known as tabnabbing1
               fileNameLabel.attr('rel', 'noopener noreferrer');
               // File is selected, show delete button
               fileInput.addClass('codx');
               targetRow.removeClass('codx');
               fileNameLabel.html('<i class="far fa-eye fa-lg"></i> ' + item.Nama_Fail).removeClass('codx');
               fileInput.addClass('selected');
           }
       });
                    }

                    sessionStorage.setItem("statusDok", statusDok)

                    if (isSet(statusDok)) {
                        //Check status permohonan
                        if (statusDok == '28') {
                            //Permohonan Belum Lulus
                            enableEdit();
                        } else {
                            //Permohonan Lulus
                            disableEdit();
                        }
                    } else {
                        enableEdit();
                    }
                }

                $("#mdlSenPemohonan").modal("toggle");
            }

            function buildDdl(id, kodVal, txtVal) {
                if (isSet(kodVal) && isSet(txtVal)) {
                    $("#" + id).html("<option value = '" + kodVal + "'>" + txtVal + "</option>")
                    $("#" + id).dropdown('set selected', kodVal);
                }
            }

            function statusKelayakan(data) {
                console.log(data)
                data = data[0];
                if (data.status) {
                    // open modal confirmation
                    $('#confirmationModalSubmit').modal('toggle');
                } else {
                    $('#maklumanModalBil').modal('toggle');
                    $('#detailMaklumanBil').html("Untuk makluman, permohonan ini tidak boleh disimpan kerana semakan kami mendapati anda tidak layak untuk membuat permohonan.");
                }
            }

            //BUTANG SIMPAN
            function saveTab1() { //Butiran Maklumat Pemohon
                // check every required field
                var ddlJnsPnjmn = isSet($('#ddlJnsPnjmn').val());
                var ddlJnmaKend = isSet($('#ddlJnmaKend').val());
                var tkhTmtLesen = isSet($('#tkhTmtLesen').val());
                var ddlMdlKend = isSet($('#ddlMdlKend').val());
                var hrgaBrsih = isSet($('#hrgaBrsih').val());
                var ddlSktSilinder = isSet($('#ddlSktSilinder').val());
                var ddlSyarikat = isSet($('#ddlSyarikat').val());
                var ddlTmpoByrBalik = isSet($('#ddlTmpoByrBalik').val());
                var ddlJumlahMhn = isSet($('#ddlJumlahMhn').val());

                if (ddlJnsPnjmn && ddlJnmaKend && tkhTmtLesen && ddlMdlKend && hrgaBrsih && ddlSktSilinder && ddlSyarikat && ddlTmpoByrBalik && ddlJumlahMhn) {
                    if ($("#ddlTmpoByrBalik").val() == '0' || $("#ddlJumlahMhn").val() == '0') {
                        $('#maklumanModalBil').modal('toggle');
                        $('#detailMaklumanBil').html("Untuk makluman, permohonan tidak boleh disimpan kerana semakan kami mendapati anda tidak layak untuk membuat permohonan.");
                    } else {
                        //check kelayakan di web services
                        //var postDt = {
                        //    jnsPnjmn: $('#ddlJnsPnjmn').val(),
                        //    amaun: $('#ddlJumlahMhn').val(),
                        //    tempoh: $('#ddlTmpoByrBalik').val(),
                        //    kodTrfKhidmat: sessionStorage.getItem('kodTrfKhidmat'),
                        //    kodKump: sessionStorage.getItem('kodKump'),
                        //    gajiS: sessionStorage.getItem('gajiS')
                        //}

                        // open modal confirmation
                        $('#confirmationModalSubmit').modal('toggle');
                    }
                } else {// open modal makluman and show message
                    $('#maklumanModalBil').modal('toggle');
                    $('#detailMaklumanBil').html("Sila isi semua ruangan yang bertanda <span class='text-danger'>*</span>");
                }
            }

            function saveTab2() {
                // check tab 1 dgn mengguna no pinjaman
                if (isSet(tempNoPinjaman)) {
                    if (tempArrPnjmin.length == 2) {
                        $('#confirmationModalSubmit').modal('toggle');
                    } else {
                        $("#lblMessageModal").html("2 ORANG PENJAMIN DIPERLUKAN");
                        $("#MessageModal").modal('show');
                    }
                } else {
                    //alert kpd user
                    $("#lblMessageModal").html("SILA LENGKAPKAN MAKLUMAT PEMOHON / BUTIR-BUTIR PEMBELIAN TERLEBIH DAHULU");
                    $("#MessageModal").modal('show');
                }
            }

            function saveTab3() {
                // check tab 1 dgn mengguna no pinjaman
                if (isSet(tempNoPinjaman)) {
                    $('#confirmationModalSubmit').modal('toggle');
                } else {
                    //alert kpd user
                    $("#lblMessageModal").html("SILA LENGKAPKAN MAKLUMAT PEMOHON / BUTIR-BUTIR PEMBELIAN TERLEBIH DAHULU");
                    $("#MessageModal").modal('show');
                }
            }

            function isSet(value) {
                if (value === null || value === '' || value === undefined) {
                    return false;
                } else {
                    return true;
                }
            }

            function isNeedPnjmin(kodtarafk) {
                if (kodtarafk == '02') {
                    //tak perlu penjamin
                    return false;
                } else if (kodtarafk == '01' || kodtarafk == '10') {
                    //perlu penjamin
                    return true;
                }
            }

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

            function viewIntDt(value) {
                var result = '';
                (isSet(value)) ? result = value : result = '0'
                return result;
            }

            function viewFltDt(value) {
                var result = '';
                (isSet(value)) ? result = value : result = '0.00'
                return result;
            }

            $("#hrgaBrsih").on('input', function (e) {
                if (String.fromCharCode(e.keyCode).match(/[^0-9]/g)) return false;
            });

            $("#thnDibuat").on('input', function (e) {
                if (String.fromCharCode(e.keyCode).match(/[^0-9]/g)) return false;
            });

            //NUMERIC INPUT Text
            $("#hrgaBrsih").on('input', function (e) {
                if (e.which >= 37 && e.which <= 40) return;
                $(this).val(function (index, value) {
                    return value
                        // Keep only digits and decimal points:
                        .replace(/[^\d.]/g, "")
                        // Remove duplicated decimal point, if one exists:
                        .replace(/^(\d*\.)(.*)\.(.*)$/, '$1$2$3')
                        // Keep only two digits past the decimal point:
                        .replace(/\.(\d{2})\d+/, '.$1')
                        // Add thousands separators:
                        .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                });
            });

            $('#hrgaBrsih').on('blur', function () {
                $(this).val(function (index, value) {
                    if (isSet(value)) {
                        if (/\./.test(value)) {
                            return value;
                        } else {
                            return (value + ".00");
                        }
                    } else {
                        return "";
                    }
                });
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

            async function ajaxPostFile(url, formData, enableLoader, fn) {

                if (enableLoader) show_loader();

                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: url,
                        data: formData,
                        cache: false,
                        contentType: false,
                        type: 'POST',
                        processData: false,
                        success: function (data) {
                            result = JSON.parse(data.querySelector("string").textContent);
                            if (fn !== null && fn !== undefined) {
                                fn(result);
                            }
                            if (enableLoader) close_loader();
                            resolve(true);
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
