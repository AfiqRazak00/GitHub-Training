<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Maklumat_Syarikat.aspx.vb" Inherits="SMKB_Web_Portal.Maklumat_Syarikat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script src="../../../Content/script/d_loader.js"></script>

    <style>
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
    </style>

    <div id="PendaftaranSyaTab" class="tabcontent" style="display: block">

        <ul class="nav nav-tabs" id="myTabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#mklmtSya">Maklumat Syarikat</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#almtPerniagaan">Alamat Perniagaan</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#mklmtPeg">Pegawai</a>
            </li>
        </ul>

        <div class="tab-content">

            <div class="tab-pane fade show active" id="mklmtSya">
                <div class="form-group row col-md-12">
                    <div class="form-group row col-md-6">
                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat Syarikat</h6>
                        </div>

                        <!-- checkbox Perniagaan utama -->
                        <div class="form-group col-md-12">
                            <label for="lblPerniagaanUtama">Perniagaan Utama <a style="color: red">*</a> : </label>
                            <div class="form-check-inline col-md-12">
                                <label class="form-check-label col-md-2">
                                    <input type="checkbox" class="form-check-input" id="chckBekalan">Bekalan
                                </label>
                                <label class="form-check-label col-md-4">
                                    <input type="checkbox" class="form-check-input" id="chckPerkhidmatan">Perkhidmatan
                                </label>
                                <label class="form-check-label col-md-3">
                                    <input type="checkbox" class="form-check-input" id="chckKerja">Kerja
                                </label>
                            </div>
                        </div>
                        <!-- CheckBox Katergori Syarikat -->
                        <div id="katSya" class="form-group col-md-12">
                            <label for="lblKatSya">Kategori Syarikat <a style="color: red">*</a> : </label>
                            <div class="form-check-inline col-md-12">
                                <label class="form-check-label col-md-4">
                                    <input type="checkbox" class="form-check-input" id="chckKatSyaE" name="chckKatSya">Enterprise / Trading
                                </label>
                                &nbsp;
                                    <label class="form-check-label col-md-4">
                                        <input type="checkbox" class="form-check-input" id="chckKatSyaS" name="chckKatSya">Sdn. Bhd. / Bhd.
                                    </label>
                                &nbsp;
                            </div>
                        </div>
                        <!-- File Profile Syarikat -->
                        <div class="form-group col-md-6">
                            <label for="UploadSurat">Profil Syarikat  <a style="color: red">*</a> : </label>
                            <div class="form-inline">

                                <input type="file" id="fileInputProfil" />
                                <span id="uploadedFileNameLabel" style="display: inline;"></span>
                                <span id="">&nbsp</span>
                                <span id="progressContainer"></span>
                                <input type="hidden" class="form-control" id="hidJenDok" style="width: 300px" readonly="readonly" />
                                <input type="hidden" class="form-control" id="hidFileName" style="width: 300px" readonly="readonly" />
                                <%--<label for="ProfileSya" id="LampiranProfilSya">Lampiran</label>--%>
                            </div>
                        </div>
                    </div>

                    <!-- Maklumat Bank -->
                    <div class="col-md-6">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Bank</h6>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <select class=" input-group__input form-control input_sm ui search dropdown ddlKodBank " name="ddlKodBank" id="ddlKodBank">
                                    </select>
                                    <label class="input-group__label">Kod bank</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class="input-group__input form-control input-sm " placeholder="" id="txtNoAkaun" name="txtNoAkaun" />
                                    <label class="input-group__label">Nombor Akaun</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="UploadPenyataBank">Muka Hadapan Penyata Akaun  <a style="color: red">*</a> : </label>
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
                </div>


                <div class="form-row">
                    <div class="form-group col-md-12" align="right">
                        <%--<button type="button" class="btn btn-danger btnPadamSya">Padam</button>--%>
                        <button type="button" class="btn btn-danger btnBatal" data-toggle="bottom" title="Batal" style="display: none;">Batal</button>
                        <button type="button" class="btn btn-secondary btnSimpanSya" data-toggle="tooltip" data-placement="bottom" title="Simpan">Simpan</button>
                        <button type="button" class="btn btn-secondary btnKemaskini" data-toggle="tooltip" data-placement="bottom" title="Kemaskini" style="display: none;">Kemaskini</button>
                        <%--<button type="button" id="Button2" runat="server" class="btn btn-success btnHantarSya" data-toggle="tooltip" data-placement="bottom" title="Simpan dan Hantar">Hantar</button>--%>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="almtPerniagaan">
                <div class="panel-heading">
                    <br />
                    <h6 class="panel-title">Alamat Perniagaan</h6>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <textarea id="txtAlmtPerniagaan1" class="input-group__input form-control" name="txtAlmtPerniagaan1" rows="1" placeholder=""></textarea>
                                    <label class="input-group__label">Alamat Baris Pertama</label>
                                </div>
                                <div class="form-group input-group">
                                    <textarea id="txtAlmtPerniagaan2" class="input-group__input form-control" name="txtAlmtPerniagaan2" rows="1" placeholder=""></textarea>
                                    <label class="input-group__label">Alamat Baris Kedua</label>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlPoskod" id="ddlPoskod">
                                    </select>
                                    <label class="input-group__label">Poskod</label>
                                </div>
                                <div class="form-group input-group">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlBandar" id="ddlBandar">
                                    </select>
                                    <label class="input-group__label">Bandar</label>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegeri" id="ddlNegeri">
                                    </select>
                                    <label class="input-group__label">Negeri</label>
                                </div>
                                <div class="form-group input-group">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegara" id="ddlNegara">
                                    </select>
                                    <label class="input-group__label">Negara</label>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtWebURL" id="txtWebURL">
                                    <label class="input-group__label">Laman Web URL</label>
                                </div>
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailSya" id="txtEmailSya">
                                    <label class="input-group__label">Emel Syarikat</label>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtTelBimbit" id="txtTelBimbit">
                                    <label class="input-group__label">Nombor Telefon Bimbit</label>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtTelPej" id="txtTelPej">
                                    <label class="input-group__label">Nombor Telefon Pejabat</label>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoFax" id="txtNoFax">
                                    <label class="input-group__label">Nombor Faksimili</label>
                                </div>
                            </div>

                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-12" align="right">
                                <button type="button" class="btn btn-secondary btnSimpanAlmt" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Maklumat Pegawai untuk dihunbungi -->
            <div class="tab-pane fade" id="mklmtPeg">
                <div class="form-group row col-md-12">
                    <div class="form-group col-md-6">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Pegawai untuk Dihubungi Pertama</h6>
                            <label id="IdPeg1" style="visibility: hidden;"></label>
                        </div>
                        <div class="form-group row col-md-12">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNamaPegawai1" id="txtNamaPegawai1">
                                    <label class="input-group__label">Nama</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtJwtPegawai1" id="txtJwtPegawai1">
                                    <label class="input-group__label">Jawatan</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailPegawai1" id="txtEmailPegawai1">
                                    <label class="input-group__label">Emel</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPeg1" id="txtNoTelPeg1">
                                    <label class="input-group__label">Nombor Telefon Bimbit</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPejPeg1" id="txtNoTelPejPeg1">
                                    <label class="input-group__label">Nombor Telefon Pejabat</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row col-md-6">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Pegawai untuk Dihubungi Kedua</h6>
                            <label id="IdPeg2" style="visibility: hidden;"></label>
                        </div>
                        <div class="form-group row col-md-12">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNamaPegawai2" id="txtNamaPegawai2">
                                    <label class="input-group__label">Nama</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtJwtPegawai2" id="txtJwtPegawai2">
                                    <label class="input-group__label">Jawatan</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailPegawai2" id="txtEmailPegawai2">
                                    <label class="input-group__label">Emel</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPeg2" id="txtNoTelPeg2">
                                    <label class="input-group__label">Nombor Telefon Bimbit</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPejPeg2" id="txtNoTelPejPeg2">
                                    <label class="input-group__label">Nombor Telefon Pejabat</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                </div>

                <!-- Button -->
                <div class="form-row">
                    <div class="form-group col-md-12" align="right">
                        <button type="button" class="btn btn-secondary btnSimpanPeg" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
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
                    <button type="button" class="btn btn-secondary" id="tutupMakluman" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        var activeTab = '#mklmtSya';
        $(document).ready(function () {
            $('#myTabs').on('shown.bs.tab', async function (e) {
                activeTab = $(e.target).attr('href');
                console.log("activeTab", activeTab);
                if (activeTab === "#mklmtSya") {
                    await LoadDataSya();
                } else if (activeTab === "#almtPerniagaan") {
                    await LoadDataAlmtSya();
                } else if (activeTab === "#mklmtPeg") {
                    await LoadDataPegSya();
                } else {
                    LoadDataSya();
                }
            });
            LoadDataSya();

            var FlagSah = sessionStorage.getItem("FlagSah");
            var StatAktif = sessionStorage.getItem("StatAktif")

            if (FlagSah == "1") {
                $('.btnKemaskini').hide();
                $('.btnSimpanSya').hide();
                $('.btnSimpanAlmt').hide();
                $('.btnSimpanPeg').hide();
                disableInput();
            } else {
                $('.btnKemaskini').hide();
                $('.btnSimpanSya').show();
                $('.btnSimpanAlmt').show();
                $('.btnSimpanPeg').show();
            }

            if (StatAktif == "00") {
                $('#btnKemaskini').hide();
            } else {
                $('#btnKemaskini').show();
            }

            
        });

        async function LoadDataSya() {
            var IdSya = '<%=Session("ssusrID")%>';

            if (IdSya !== "") {
                var RecordSya = JSON.parse(await AjaxGetDataSya(IdSya));
                //console.log("RecordSya[0].IdSya: ", RecordSya[0].ID_Sykt);
                console.log("RecordSya: ", RecordSya);

                if (RecordSya.length === 0) {
                    return false;
                } else {

                    sessionStorage.setItem("FlagSah", RecordSya[0].Flag_Sah);
                    sessionStorage.setItem("StatAktif", RecordSya[0].Status_Aktif);

                    var selectObj_Bank = $('#ddlKodBank');

                    sessionStorage.setItem('IdSya', RecordSya[0].IdSya);

                    if (RecordSya[0].Bekalan === "true" || RecordSya[0].Bekalan === true) {
                        $('#chckBekalan').prop('checked', true);
                    } else {
                        $('#chckBekalan').prop('checked', false);
                    }

                    if (RecordSya[0].Perkhidmatan === "true" || RecordSya[0].Perkhidmatan === true) {
                        $('#chckPerkhidmatan').prop('checked', true);
                    } else {
                        $('#chckPerkhidmatan').prop('checked', false);
                    }

                    if (RecordSya[0].Kerja === "true") {
                        /*$('#chckKerja').is(":checked");*/
                        $('#chckKerja').prop('checked', true);
                    } else {
                        $('#chckKerja').prop('checked', false);
                    }

                    if (RecordSya[0].KatSya === "E") {
                        $("#chckKatSyaE").prop('checked', true);
                        $("#chckKatSyaS").prop('disabled', true);
                    } else if (RecordSya[0].KatSya === "s" || RecordSya[0].KatSya === "S") {
                        $("#chckKatSyaS").prop('checked', true);
                        $("#chckKatSyaE").prop('disabled', true);
                    }

                    // Create links
                    createLink('fileInputProfil', RecordSya[0]);
                    createLink('fileInputBank', RecordSya[1]);

                    //$('#IdPeg1').html(dataSyarikat.IdPeg);
                    // $('#IdPeg2').html(dataSyarikat1.IdPeg);
                    $('#ddlKodBank').dropdown('set selected', RecordSya[0].kodBank);
                    selectObj_Bank.append("<option value = '" + RecordSya[0].kodBank + "'>" + RecordSya[0].ButiranBank + "</option>");
                    $('#txtNoAkaun').val(RecordSya[0].NoAkaun);
                }
            }
        }

        function createLink(inputId, data) {
            var fileInput = document.getElementById(inputId);
            var linkContainer = fileInput.nextElementSibling;

            // Remove existing link if present
            if (linkContainer && linkContainer.tagName === 'A') {
                linkContainer.remove();
            }

            // Create new link
            var link = document.createElement("a");
            link.href = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/") %>' + '<%=Session("ssusrID")%>' + '/' + data.Bil + '/' + data.Nama_Dok;
            link.target = "_blank"; // Open the link in a new tab
            link.textContent = data.Nama_Dok; // Text to display for the link

            // Append the anchor element
            fileInput.insertAdjacentElement('afterend', link);
        }

        async function LoadDataAlmtSya() {
            var IdSya = '<%=Session("ssusrID")%>';

             if (IdSya !== "") {
                 var RecordAlmtSya = JSON.parse(await AjaxGetDataAlmtSya(IdSya));
                 console.log("RecordSya[0].IdSya: ", RecordAlmtSya[0].Almt1);
                 console.log("RecordSya: ", RecordAlmtSya);

                 if (RecordAlmtSya.length === 0) {
                     return false;
                 } else {
                     var selectObj_Bandar = $('#ddlBandar');
                     var selectObj_Negeri = $('#ddlNegeri');
                     var selectObj_Negara = $('#ddlNegara');
                     var selectObj_Poskod = $('#ddlPoskod');

                     $('#txtAlmtPerniagaan1').val(RecordAlmtSya[0].Almt1);
                     $('#txtAlmtPerniagaan2').val(RecordAlmtSya[0].Almt2);
                     $('#ddlPoskod').dropdown('set selected', RecordAlmtSya[0].Poskod);
                     selectObj_Poskod.append("<option value ='" + RecordAlmtSya[0].Poskod + "'>" + RecordAlmtSya[0].Poskod + "</option>");
                     $('#ddlBandar').dropdown('set selected', RecordAlmtSya[0].KodBandar);
                     selectObj_Bandar.append("<option value ='" + RecordAlmtSya[0].KodBandar + "'>" + RecordAlmtSya[0].ButiranBandar + "</option>");
                     $('#ddlNegeri').dropdown('set selected', RecordAlmtSya[0].Negeri);
                     selectObj_Negeri.append("<option value ='" + RecordAlmtSya[0].kodNegeri + "'>" + RecordAlmtSya[0].ButiranNegeri + "</option>");
                     $('#ddlNegara').dropdown('set selected', RecordAlmtSya[0].Negara);
                     selectObj_Negara.append("<option value ='" + RecordAlmtSya[0].KodNegara + "'>" + RecordAlmtSya[0].ButiranNegara + "</option>");
                     $('#txtWebURL').val(RecordAlmtSya[0].Web);
                     $('#txtEmailSya').val(RecordAlmtSya[0].EmailSya);
                     $('#txtTelBimbit').val(RecordAlmtSya[0].TelBimbit);
                     $('#txtTelPej').val(RecordAlmtSya[0].TelPejSya);
                     $('#txtNoFax').val(RecordAlmtSya[0].NoFaxSya);
                 }
             }
        }

        async function LoadDataPegSya() {
            var IdSya = '<%=Session("ssusrID")%>';

            if (IdSya !== "") {
                var RecordPegSya = JSON.parse(await AjaxGetDataPegSya(IdSya));
                console.log("RecordSya[0].IdSya: ", RecordPegSya[0].ID_Sykt);
                console.log("RecordSya: ", RecordPegSya);

                if (RecordPegSya.length === 0) {
                    return false;
                } else {
                    $('#txtNamaPegawai1').val(RecordPegSya[0].NamaPegawai1);
                    $('#txtJwtPegawai1').val(RecordPegSya[0].JwtPegawai1);
                    $('#txtEmailPegawai1').val(RecordPegSya[0].EmailPeg1);
                    $('#txtNoTelPeg1').val(RecordPegSya[0].TelPeg1);
                    $('#txtNoTelPejPeg1').val(RecordPegSya[0].TelPejPeg1);
                    $('#txtNamaPegawai2').val(RecordPegSya[1].NamaPegawai1);
                    $('#txtJwtPegawai2').val(RecordPegSya[1].JwtPegawai1);
                    $('#txtEmailPegawai2').val(RecordPegSya[1].EmailPeg1);
                    $('#txtNoTelPeg2').val(RecordPegSya[1].TelPeg1);
                    $('#txtNoTelPejPeg2').val(RecordPegSya[1].TelPejPeg1);
                }
            }
        }


        async function AjaxGetDataSya(IdSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'DaftarSyarikat_WS.asmx/LoadDataSya',
                    method: 'POST',
                    data: JSON.stringify({ IdSya: IdSya }),
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

        async function AjaxGetDataAlmtSya(IdSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'DaftarSyarikat_WS.asmx/LoadDataAlmtSya',
                    method: 'POST',
                    data: JSON.stringify({ IdSya: IdSya }),
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
        async function AjaxGetDataPegSya(IdSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'DaftarSyarikat_WS.asmx/LoadDataPegSya',
                    method: 'POST',
                    data: JSON.stringify({ IdSya: IdSya }),
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

        // validate no akaun bank with right format
        $('#txtNoAkaun').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{12,14}$]/gi;
            this.value = this.value.replace(regex, "");
        });
        // validate alamat
        $('#txtAlmtPerniagaan1').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtAlmtPerniagaan2').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        // validate email

        // validate phone number
        $('#txtTelBimbit').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtTelPej').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtNoTelPeg1').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtNoTelPejPeg1').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtNoTelPeg2').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtNoTelPejPeg2').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        // validate no fax
        $('#txtNoFax').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        // validate txtbox nama peg1, peg2
        $('#txtNamaPegawai1').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtNamaPegawai2').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtJwtPegawai1').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtJwtPegawai2').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        async function disableInput() {
            $('#chckBekalan').prop('disabled', true);
            $('#chckPerkhidmatan').prop('disabled', true);
            $('#chckKerja').prop('disabled', true);
            $("input[name='chckKatSya']").prop('disabled', true);
            /*$('#ddlKodBank').prop('disabled', true);*/
            /*$('#ddlKodBank').dropdown('set disabled');*/
            /*$('#ddlKodBank').addClass('disabled');*/
            /*$('#ddlKodBank').dropdown('set active');*/
            //$("input[name='ddlKodBank']").prop('disabled',true);
            $('.search').prop('disabled', true);
            $('#ddlKodBank').prop('disabled', true);
            $('#txtNoAkaun').prop('disabled', true);
            $('#txtAlmtPerniagaan1').prop('disabled', true);
            $('#txtAlmtPerniagaan2').prop('disabled', true);
            $('#ddlPoskod').prop('disabled', true);
            $('#ddlBandar').prop('disabled', true);
            $('#ddlNegeri').prop('disabled', true);
            $('#ddlNegara').prop('disabled', true);
            $('#txtWebURL').prop('disabled', true);
            $('#txtEmailSya').prop('disabled', true);
            $('#txtTelBimbit').prop('disabled', true);
            $('#txtTelPej').prop('disabled', true);
            $('#txtNoFax').prop('disabled', true);
            $('#txtNamaPegawai1').prop('disabled', true);
            $('#txtJwtPegawai1').prop('disabled', true);
            $('#txtEmailPegawai1').prop('disabled', true);
            $('#txtNoTelPeg1').prop('disabled', true);
            $('#txtNoTelPejPeg1').prop('disabled', true);
            $('#txtNamaPegawai2').prop('disabled', true);
            $('#txtJwtPegawai2').prop('disabled', true);
            $('#txtEmailPegawai2').prop('disabled', true);
            $('#txtNoTelPeg2').prop('disabled', true);
            $('#txtNoTelPejPeg2').prop('disabled', true);
            $('#uploadButton').prop('disabled', true);
            $('#fileInputProfil').prop('disabled', true);
            $('#uploadButtonBank').prop('disabled', true);
            $('#fileInputBank').prop('disabled', true);
        }

        async function enableInputField() {
            $('#chckBekalan').prop('disabled', false);
            $('#chckPerkhidmatan').prop('disabled', false);
            $('#chckKerja').prop('disabled', false);
            $("input[name='chckKatSya']").prop('disabled', false);
            $('.search').prop('disabled', false);
            $('#ddlKodBank').prop('disabled', false);
            $('#txtNoAkaun').prop('disabled', false);
            $('#txtAlmtPerniagaan1').prop('disabled', false);
            $('#txtAlmtPerniagaan2').prop('disabled', false);
            $('#ddlPoskod').prop('disabled', false);
            $('#ddlBandar').prop('disabled', false);
            $('#ddlNegeri').prop('disabled', false);
            $('#ddlNegara').prop('disabled', false);
            $('#txtWebURL').prop('disabled', false);
            $('#txtEmailSya').prop('disabled', false);
            $('#txtTelBimbit').prop('disabled', false);
            $('#txtTelPej').prop('disabled', false);
            $('#txtNoFax').prop('disabled', false);
            $('#txtNamaPegawai1').prop('disabled', false);
            $('#txtJwtPegawai1').prop('disabled', false);
            $('#txtEmailPegawai1').prop('disabled', false);
            $('#txtNoTelPeg1').prop('disabled', false);
            $('#txtNoTelPejPeg1').prop('disabled', false);
            $('#txtNamaPegawai2').prop('disabled', false);
            $('#txtJwtPegawai2').prop('disabled', false);
            $('#txtEmailPegawai2').prop('disabled', false);
            $('#txtNoTelPeg2').prop('disabled', false);
            $('#txtNoTelPejPeg2').prop('disabled', false);
            $('#uploadButton').prop('disabled', false);
            $('#fileInputProfil').prop('disabled', false);
            $('#uploadButtonBank').prop('disabled', false);
            $('#fileInputBank').prop('disabled', false);
        }

        $(document).ready(function () {
            setupDropdown('#ddlKodBank', 'Pendaftaran_WS.asmx/GetCodeBank', false);
            setupDropdown('#ddlBandar', 'Pendaftaran_WS.asmx/GetBandar', true);
            setupDropdown('#ddlNegeri', 'Pendaftaran_WS.asmx/GetNegeri', false);
            setupDropdown('#ddlNegara', 'Pendaftaran_WS.asmx/GetNegara', false);
            setupDropdown('#ddlPoskod', 'Pendaftaran_WS.asmx/GetPoskod', false);
        });

        function setupDropdown(selector, url, fullTextSearch) {
            $(selector).dropdown({
                selectOnKeyDown: true,
                fullTextSearch: fullTextSearch,
                apiSettings: {
                    url: url + '?q={query}',
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
                        objItem.html('');

                        if (response.d.length === 0) {
                            obj.dropdown("clear");
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);
                        $.each(listOptions, function (index, option) {
                            objItem.append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });

                        obj.dropdown('refresh').dropdown('show');
                    }
                }
            });
        }

        $(document).ready(function () {
            $("input[name='chckKatSya']").click(function () {
                if ($("#chckKatSyaE").is(":checked")) {
                    $("input[name='chckKatSya']").val("E");
                    $("#chckKatSyaS").prop('disabled', true);
                } else if ($("#chckKatSyaS").is(":checked")) {
                    $("input[name='chckKatSya']").val("S");
                    $("#chckKatSyaE").prop('disabled', true);
                } else {
                    $("input[name='chckKatSya']").prop('checked', false);
                    $("#chckKatSyaS").prop('disabled', false);
                    $("#chckKatSyaE").prop('disabled', false);
                }
            });
        });

        async function uploadFileProfilSya() {

            var fileInputId = "fileInputProfil";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/MS/";
            var hidJenDokId = "hidJenDok";
            var hidFileNameId = "hidFileName";
            var progressContainerId = "progressContainer";
            var uploadedFileNameLabelId = "uploadedFileNameLabel";
            var wsMethod = "DaftarSyarikat_WS.asmx/UploadFileProfilSya";
            var KodDaftar = "PS";
            var result = await uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar);

            return result;
        }

        async function uploadFileBank() {
            var fileInputId = "fileInputBank";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/BANK/";
            var hidJenDokId = "hidJenDokBank";
            var hidFileNameId = "hidFileNameBank";
            var progressContainerId = "progressContainerBank";
            var uploadedFileNameLabelId = "uploadedFileNameLabelBank";
            var wsMethod = "DaftarSyarikat_WS.asmx/UploadFileBank";
            var KodDaftar = "PB";
            var result = await uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar);

            return result;
        }

        function uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar) {
            return new Promise((resolve, reject) => {
                var fileInput = document.getElementById(fileInputId);
                var file = fileInput.files[0];
                var result = {
                    status: "",
                    message: ""
                };

                if (file) {
                    var fileSize = file.size; // File size in bytes
                    var maxSize = 3 * 1024 * 1024; // Maximum size in bytes (3MB)

                    if (fileSize <= maxSize) {
                        var fileName = file.name;
                        var fileExtension = fileName.split('.').pop().toLowerCase();

                        if (['pdf', 'xlsx', 'xls'].includes(fileExtension)) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var fileData = e.target.result;

                                var requestData = {
                                    fileData: fileData,
                                    fileName: fileName,
                                    resolvedUrl: resolveAppUrl(resolvedUrl)
                                };

                                var frmData = new FormData();
                                frmData.append("fileSurat", file);
                                frmData.append("fileName", fileName);
                                frmData.append("fileSize", fileSize);
                                frmData.append("fileExtension", fileExtension)
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
                                        var fileLink = document.createElement("a");
                                        fileLink.href = requestData.resolvedUrl + fileName;
                                        fileLink.textContent = fileName;

                                        var uploadedFileNameLabel = document.getElementById(uploadedFileNameLabelId);
                                        uploadedFileNameLabel.appendChild(fileLink);

                                        fileLinkToLocal(requestData.resolvedUrl + fileName);

                                        $(`#${uploadedFileNameLabelId}`).show();
                                        $(`#${fileInputId}`).val("");
                                        $(`#${progressContainerId}`).text("File uploaded successfully.");

                                        var jsonResponse = JSON.parse($(response).find('anyType').text());
                                        result.status = jsonResponse.Code;
                                        result.message = jsonResponse.Message;

                                        // Resolve the promise with the result
                                        resolve(result);
                                    },
                                    error: function () {
                                        $(`#${progressContainerId}`).text("Error uploading file.");

                                        // Reject the promise with an error
                                        reject(new Error("Error uploading file."));
                                    }
                                });
                            };

                            reader.readAsArrayBuffer(file);
                        } else {
                            result.status = 500;
                            result.message = "Only PDF and Excel files are allowed.";

                            // Reject the promise with an error
                            reject(new Error(result.message));
                        }
                    } else {
                        result.status = 500;
                        result.message = "File size exceeds the maximum limit of 3MB";

                        // Reject the promise with an error
                        reject(new Error(result.message));
                    }
                } else {
                    result.status = 500;
                    result.message = "Please select a file to upload";

                    // Reject the promise with an error
                    reject(new Error(result.message));
                }
            });
        }


        function fileLinkToLocal(fileName) {
            localStorage.setItem("fileLink", fileName);
        }

        function getFileLinkFromLocal() {
            return localStorage.getItem("fileLink");
        }

        function displayFileLink(fileName) {
            var fileName = getFileLinkFromLocal();
            if (fileName) {
                var fileLink = document.createElement("a");
                fileLink.href = fileName;
                fileLink.textContent = "Download File";

                var lampiranProfilSya = document.getElementById("LampiranProfilSya");
                lampiranProfilSya.appendChild(fileLink);

                $("LampiranProfilSya").html(lampiranProfilSya);
            }
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

        var bekalan = false;
        var perkhidmatan = false;
        var kerja = false;
        var katSya = false;
        var kodBank = "";
        var noAkaun = "";

        $('.btnSimpanSya').click(async function () {
            //check every required field
            if ($("input[name='chckKatSya']").val() == "" || $('#ddlKodBank').val() == "" || $('#txtNoAkaun').val() == "" || $('#fileInputProfil').val() == "" || $('#fileInputBank').val() == "") {
                displayMaklumanModal("Sila Isi Semua Ruang Yang Bertanda *");
            } else {

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");

                if (!confirm) {
                    return false;
                } else {

                    try {
                        var messageFile;
                        var messageFileBank;

                        messageFile = await uploadFileProfilSya();
                        console.log("messageFile: ", messageFile);
                        if (messageFile.status !== "200") {
                            displayMaklumanModal("Gagal MemuatNaik Fail Profil Syarikat");
                            return;
                        }

                        messageFileBank = await uploadFileBank();
                        console.log("messageFileBank: ", messageFileBank);
                        if (messageFileBank.status !== "200") {
                            displayMaklumanModal("Gagal MemuatNaik Fail Penyata Bank");
                            return;
                        }

                        var chckBekalan = $('#chckBekalan').is(' :checked');
                        bekalan = chckBekalan.toString();
                        var chckPerkhidmatan = $('#chckPerkhidmatan').is(' :checked');
                        perkhidmatan = chckPerkhidmatan.toString();
                        var chckKerja = $('#chckKerja').is(' :checked');
                        kerja = chckKerja.toString();

                        var newMklmtSya = {
                            mklmtSya: {
                                NoSya: '<%=Session("ssusrID")%>',
                                IdSya: '<%=Session("ssusrID")%>',
                                Bekalan: bekalan,
                                Perkhidmatan: perkhidmatan,
                                Kerja: kerja,
                                KatSya: $("input[name='chckKatSya']").val(),
                                KodBank: $('#ddlKodBank').val(),
                                NoAkaun: $('#txtNoAkaun').val(),
                            }
                        };

                        console.log("mklmtSya: ", newMklmtSya);
                        var result = JSON.parse(await AjaxSaveSyarikat(newMklmtSya));
                        if (result.Status !== "Failed") {
                            displayMaklumanModal(result.Message);
                            $('a[href="#almtPerniagaan"]').click();
                        } else {
                            displayMaklumanModal(result.Message);
                            return false;
                        }

                    } catch (error) {
                        console.error("Error during file upload:", error);
                        displayMaklumanModal("Gagal Memuatnaik Fail" + activeTab.substring(1).toUpperCase());
                        return;
                    }
                }
            }
        });

        async function AjaxSaveSyarikat(mklmtSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'DaftarSyarikat_WS.asmx/SaveMklmtSya',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(mklmtSya),
                    success: function (result) {
                        resolve(result.d);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        var regexEmail = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
        var regexEmail2 = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

        $('.btnSimpanAlmt').click(async function () {
            if ($('#txtAlmtPerniagaan1').val() == "" || $('#txtAlmtPerniagaan2').val() == "" || $('#ddlBandar').val() == "" || $('#ddlPoskod').val() == "" ||
                $('#ddlNegeri').val() == "" || $('#ddlNegara').val() == "" || $('#txtTelPej').val() == "" || $('#txtTelBimbit').val() == "" || $('#txtNoFax').val() == "" ||
                $('#txtWebURL').val() == "" || $('#txtEmailSya').val() == "") {
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila isi semua ruangan yang bertanda *");
            } else {

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");

                if (!confirm) {
                    return false;
                } else {

                    var EmailSya = "";
                    var emailSya = $('#txtEmailSya').val();
                    const isValidEmailSya = regexEmail.test(emailSya);

                    if (isValidEmailSya) {
                        EmailSya = emailSya;
                    } else {
                        displayMaklumanModal("Sila Masukkan Emel yang Sesuai");
                        return false;
                    }

                    var newAlmtSya = {
                        almtSya: {
                            Almt1: $('#txtAlmtPerniagaan1').val(),
                            Almt2: $('#txtAlmtPerniagaan2').val(),
                            Bandar: $('#ddlBandar').val(),
                            Poskod: $('#ddlPoskod').val(),
                            Negeri: $('#ddlNegeri').val(),
                            Negara: $('#ddlNegara').val(),
                            Web: $('#txtWebURL').val(),
                            EmailSya: EmailSya,
                            TelBimbitSya: $('#txtTelBimbit').val(),
                            TelPejSya: $('#txtTelPej').val(),
                            NoFaxSya: $('#txtNoFax').val(),
                        }
                    }

                    console.log("newAlmtSya: ", newAlmtSya);
                    var result = JSON.parse(await AjaxSaveAlmtSya(newAlmtSya));

                    if (result.Status !== "Failed") {
                        displayMaklumanModal(result.Message);
                        $('a[href="#mklmtPeg"]').click();
                    } else {
                        displayMaklumanModal(result.Message);
                        return false;
                    }
                }
            }
        });

        async function AjaxSaveAlmtSya(almtSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'DaftarSyarikat_WS.asmx/SaveAlmtSya',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(almtSya),
                    success: function (result) {
                        resolve(result.d);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        var EmailPeg1 = "";
        var EmailPeg2 = "";
        var emailPeg1 = "";
        var emailPeg2 = "";
        var idPeg1 = "";
        var idPeg2 = "";

        $('.btnSimpanPeg').click(async function () {
            if ($('#txtNamaPegawai1').val() == "" || $('#txtJwtPegawai1').val() == "" || $('#txtNoTelPeg1').val() == "") {
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila isi semua ruangan yang bertanda *");
            } else {

                let confirm = false;
                confirm = await DisplayPegesahanModal("Anda Pasti Ingin Menyimpan Rekod Ini?");

                if (!confirm) {
                    return false;
                } else {

                    debugger;
                    emelPeg1 = $('#txtEmailPegawai1').val();
                    emelPeg2 = $('#txtEmailPegawai2').val();

                    if ($('#txtEmailPegawai1').val() !== '' && $('#txtEmailPegawai2').val() == '') {
                        const isValidEmailPeg1 = regexEmail.test(emelPeg1);
                        emailPeg2 = $('#txtEmailPegawai2').val();
                        if (isValidEmailPeg1) {
                            //$('#confirmationModal').modal('toggle');
                            EmailPeg1 = emailPeg1;
                        } else {
                            displayMaklumanModal("Sila Masukkan Emel yang Sesuai Untuk Pegawai Pertama");
                            return false;
                        }
                    } else if ($('#txtEmailPegawai1').val() == '' && $('#txtEmailPegawai2').val() !== '') {
                        const isValidEmailPeg2 = regexEmail.test(emelPeg2);
                        emailPeg1 = $('#txtEmailPegawai1').val();
                        if (isValidEmailPeg2) {
                            //$('#confirmationModal').modal('toggle');
                            EmailPeg2 = emailPeg2;
                        } else {
                            displayMaklumanModal("Sila Masukkan Emel yang Sesuai Untuk Pegawai Kedua");
                            return false;
                        }
                    } else if ($('#txtEmailPegawai1').val() !== "" || $('#txtEmailPegawai2').val() !== "") {
                        var isValidEmailPeg1 = regexEmail.test(emelPeg1);
                        var isValidEmailPeg2 = regexEmail2.test(emelPeg2);

                        if (!isValidEmailPeg1) {
                            displayMaklumanModal("Sila Masukkan Emel yang Sesuai Untuk Pegawai Pertama");
                            return false;
                        } else if (!isValidEmailPeg2) {
                            displayMaklumanModal("Sila Masukkan Emel yang Sesuai Untuk Pegawai Kedua");
                            return false;
                        } else if (isValidEmailPeg1 && isValidEmailPeg2) {
                            EmailPeg1 = $('#txtEmailPegawai1').val();
                            EmailPeg2 = $('#txtEmailPegawai2').val();
                        } else {
                            displayMaklumanModal("Sila Masukkan Emel yang Sesuai");
                            return false;
                        }
                    } else {
                        EmailPeg1 = $('#txtEmailPegawai1').val();
                        EmailPeg2 = $('#txtEmailPegawai2').val();
                    }
                }

                var ListPegawai = [
                    {
                        IdPeg: idPeg1,
                        KatPegawai: 'P1',
                        NamaPegawai: $('#txtNamaPegawai1').val(),
                        JwtPegawai: $('#txtJwtPegawai1').val(),
                        EmailPegawai: EmailPeg1,
                        NoTelPeg: $('#txtNoTelPeg1').val(),
                        NoTelPejPeg: $('#txtNoTelPejPeg1').val()
                    },
                    {
                        IdPeg: idPeg2,
                        KatPegawai: 'P2',
                        NamaPegawai: $('#txtNamaPegawai2').val(),
                        JwtPegawai: $('#txtJwtPegawai2').val(),
                        EmailPegawai: EmailPeg2,
                        NoTelPeg: $('#txtNoTelPeg2').val(),
                        NoTelPejPeg: $('#txtNoTelPejPeg2').val()
                    }
                ];

                var newPegSya = {
                    pegSya: {
                        IdSya: '<%=Session("ssusrID")%>',
                        NoSya: '<%=Session("ssusrID")%>',
                        IdCaw: '01',
                        ListPegawai: ListPegawai,
                    }
                }

                console.log("newPegSya: ", newPegSya);

                var result = JSON.parse(await AjaxSavePegSya(newPegSya));

                if (result.Status !== "Failed") {
                    displayMaklumanModal(result.Message);
                } else {
                    displayMaklumanModal(result.Message);
                    return false;
                }
            }
        });

        async function AjaxSavePegSya(pegSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'DaftarSyarikat_WS.asmx/SavePegSya',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(pegSya),
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

        $('.btnKemaskini').click(async function () {
            enableInputField();
            $('.btnKemaskini').hide();
            $('.btnSimpanSya').show();
            $('.btnSimpanAlmt').show();
            $('.btnSimpanPeg').show();
            $('.btnBatal').show();
        });

        $('.btnHantar').click(async function () {
            //check every required field
            if ($("input[name='chckKatSya']").val() == "" || $('#ddlKodBank').val() == "" || $('#txtNoAkaun').val() == "" ||
                $('#txtAlmtPerniagaan1').val() == "" || $('#txtAlmtPerniagaan2').val() == "" || $('#ddlBandar').val() == "" ||
                $('#ddlPoskod').val() == "" || $('#ddlNegeri').val() == "" || $('#ddlNegara').val() == "" || $('#txtTelPej').val() == "" ||
                $('#txtTelBimbit').val() == "" || $('#txtNoFax').val() == "" || $('#txtWebURL').val() == "" || $('#txtEmailSya').val() == "") {
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila isi semua ruangan yang bertanda *");
            } else {
                // open modal confirmation
                $('#confirmationModal').modal('toggle');
            }
        });

        //Button Batal
        $('.btnBatal').click(async function () {
            disableInput();
            $('.btnBatal').hide();
            $('.btnSimpanSya').hide();
            $('.btnSimpanAlmt').hide();
            $('.btnSimpanPeg').hide();
            $('.btnKemaskini').show();
        });

        async function getFileName(fileInput) {
            var file = fileInput[0].files;

            if (file.length > 0) {
                var fileName = file[0].name;

                return fileName;;
            } else {
                return null;
            }

        }

        async function getFileExtension(fileInput) {
            var file = fileInput[0].files;
            if (file.length > 0) {
                var fileName = file[0].name;
                var fileExtension = fileName.split('.').pop().toLowerCase();

                return fileExtension;
            } else {
                return null;
            }
        }

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


    </script>
</asp:Content>
