<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Sijil_Pendaftaran.aspx.vb" Inherits="SMKB_Web_Portal.Sijil_Pendaftaran" %>

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
    </style>

    <div id="SijilPendaftaranTab" class="tabcontent" style="display: block">

        <ul class="nav nav-tabs" id="myTabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#ssm">SSM</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#mof">MOF</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#cidb">CIDB</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#lainLain">LAIN-LAIN</a>
            </li>
        </ul>

        <div class="tab-content">
            <div class="panel-heading col-md-12">
                <br />
                <div class="row">
                    <h6 class="panel-title" id="title">Maklumat Sijil Pendaftaran Perniagaan</h6>
                    <label id="KodDaftar" style="visibility: hidden;">SSM</label>
                    <label id="IdDaftar" style="visibility: hidden;"></label>
                </div>
            </div>

            <div class="form-group col-md-6">
                <div class="form-group input-group" id="JenDaftar" style="display: none;">
                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlJenDaftar" id="ddlJenDaftar">
                    </select>
                    <label class="input-group__label">Jenis Pendaftaran</label>
                </div>
            </div>
            <div class="form-group col-md-6">
                <div class="form-group input-group">
                    <input type="text" class="input-group__input form-control input-sm " placeholder="" name="noDaftar" id="noDaftar">
                    <label class="input-group__label">Nombor Pendaftaran</label>
                </div>
            </div>
            <div class="form-group row col-md-12">
                <div class="form-group col-md-2">
                    <div class="form-group input-group">
                        <input type="text" class=" input-group__input form-control input-sm" onfocus="(this.type='date')" placeholder="" name="tkhMulaKuasa" id="tkhMulaKuasa">
                        <label class="input-group__label">Tarikh Berkuatkuasa</label>
                    </div>
                </div>
                <div class="form-group col-md-2">
                    <div class="form-group input-group">
                        <input type="text" class=" input-group__input form-control input-sm" onfocus="(this.type='date')" placeholder="" name="tkhTamatKuasa" id="tkhTamatKuasa">
                        <label class="input-group__label">Hingga</label>
                    </div>
                </div>
            </div>

            <div class="form-group col-md-6" id="fileSijilLain" style="display: none;">
                <label for="UploadSurat">Dokumen Perakuan Pendaftaran Lain-lain  <a style="color: red">*</a> : </label>
                <div class="form-inline">

                    <input type="file" id="fileInputLain" />
                    <%--<input type="button" id="uploadButtonLain" value="Upload" onclick="uploadFileLain()" />--%>
                    <span id="uploadedFileNameLabelLain" style="display: inline;"></span>
                    <span id="">&nbsp</span>
                    <span id="progressContainerLain"></span>
                    <input type="hidden" class="form-control" id="hidJenDokLain" style="width: 300px" readonly="readonly" />
                    <input type="hidden" class="form-control" id="hidFileNameLain" style="width: 300px" readonly="readonly" />

                </div>
            </div>

            <div class="form-group col-md-6" id="fileSijilSSM">
                <label for="UploadSurat">Dokumen Perakuan Pendaftaran SSM <a style="color: red">*</a> : </label>
                <div class="form-inline">

                    <input type="file" id="fileInputSSM" />
                    <%-- <input type="button" id="uploadButtonSSM" value="Upload" onclick="uploadFileSSM()" />--%>
                    <span id="uploadedFileNameLabelSSM" style="display: inline;"></span>
                    <span id="">&nbsp</span>
                    <span id="progressContainerSSM"></span>
                    <input type="hidden" class="form-control" id="hidJenDokSSM" style="width: 300px" readonly="readonly" />
                    <input type="hidden" class="form-control" id="hidFileNameSSM" style="width: 300px" readonly="readonly" />

                </div>
            </div>
            <div class="form-group col-md-6" id="fileSijilMOF" style="display: none;">
                <label for="UploadSurat">Dokumen Perakuan Pendaftaran MOF<a style="color: red">*</a> : </label>
                <div class="form-inline">

                    <input type="file" id="fileInputMOF" />
                    <%-- <input type="button" id="uploadButtonMOF" value="Upload" onclick="uploadFileMOF()" />--%>
                    <span id="uploadedFileNameLabelMOF" style="display: inline;"></span>
                    <span id="">&nbsp</span>
                    <span id="progressContainerMOF"></span>
                    <input type="hidden" class="form-control" id="hidJenDokMOF" style="width: 300px" readonly="readonly" />
                    <input type="hidden" class="form-control" id="hidFileNameMOF" style="width: 300px" readonly="readonly" />

                </div>
            </div>
            <div class="form-group col-md-6" id="fileSijilCIDB" style="display: none;">
                <label for="UploadSurat">Dokumen Perakuan Pendaftaran CIDB <a style="color: red">*</a> : </label>
                <div class="form-inline">

                    <input type="file" id="fileInputCIDB" />
                    <%--<input type="button" id="uploadButtonCIDB" value="Upload" onclick="uploadFileCIDB()" />--%>
                    <span id="uploadedFileNameLabelCIDB" style="display: inline;"></span>
                    <span id="">&nbsp</span>
                    <span id="progressContainerCIDB"></span>
                    <input type="hidden" class="form-control" id="hidJenDokCIDB" style="width: 300px" readonly="readonly" />
                    <input type="hidden" class="form-control" id="hidFileNameCIDB" style="width: 300px" readonly="readonly" />

                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-12" align="right">
                    <%--<button type="button" class="btn btn-danger btnPadamSya">Padam</button>--%>
                    <button type="button" class="btn btn-primary btnRekodBaru" data-toggle="tooltip" data-placement="bottom" title="Rekod Baharu" style="display: none;">Rekod Baharu</button>
                    <button type="button" class="btn btn-danger btnDaftarSijilBatal" data-toggle="tooltip" data-placement="bottom" title="Batal" style="display: none;">Batal</button>
                    <button type="button" class="btn btn-danger btnDaftarSijilLainBatal" data-toggle="tooltip" data-placement="bottom" title="Batal" style="display: none;">Batal</button>
                    <button type="button" class="btn btn-secondary btnSimpanSSM" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                </div>
            </div>

            <div class="tab-pane fade show active" id="ssm">

                <ul class="nav nav-tabs" id="myTabSSM">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#mklmtSSM">Maklumat SSM</a>
                    </li>
                </ul>

                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblDataMklmtSSM" class="table table-striped" style="width: 95%">
                            <thead>
                                <tr>
                                    <th scope="col">Bil</th>
                                    <th scope="col">Kod Daftar</th>
                                    <th scope="col">No Pendaftaran</th>
                                    <th scope="col">Tarikh Berkuatkuasa</th>
                                    <th scope="col">Tarikh Tamat</th>
                                    <th scope="col">Lampiran</th>
                                    <th scope="col">Tindakan</th>

                                </tr>
                            </thead>
                            <tbody id="tableID_Senarai_SSM">
                            </tbody>

                        </table>

                    </div>
                </div>

            </div>

            <div class="tab-pane fade" id="mof">

                <ul class="nav nav-tabs" id="myTabMOF">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#mklmtMOF">Maklumat MOF</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#BidangUtama">Bidang Utama</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#PegDaftarSijil">Maklumat Nama Pada Pendaftaran Sijil MOF</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#TarafBumi">Taraf Bumiputera</a>
                    </li>
                </ul>

                <div class="tab-content">

                    <div class="tab-pane fade show active" id="mklmtMOF">
                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat MOF</h6>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataMklmtMOF" class="table table-striped" style="width: 95%">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bil</th>
                                                <th scope="col">Kod Daftar</th>
                                                <th scope="col">No Pendaftaran</th>
                                                <th scope="col">Tarikh Berkuatkuasa</th>
                                                <th scope="col">Tarikh Tamat</th>
                                                <th scope="col">Lampiran</th>
                                                <th scope="col">Tindakan</th>

                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai_MOF">
                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="BidangUtama">

                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Bidang Utama</h6>
                        </div>
                        <br />

                        <div class="form-group row col-md-12">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlBidang" id="ddlBidang">
                                    </select>
                                    <label class="input-group__label">Bidang Utama Bekalan & Perkhidmatan (MOF)</label>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                                <div class="form-group input-group">
                                    <input type="hidden" id="selectedBidangIdsInput" name="selectedBidangIds">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlSubBidang" id="ddlSubBidang">
                                    </select>
                                    <label class="input-group__label">Sub Bidang</label>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataBidangMOF" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Kod Bidang</th>
                                            <th scope="col">BIdang</th>
                                            <th scope="col">Tindakan</th>

                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Bidang_MOF">
                                    </tbody>

                                </table>

                            </div>
                        </div>

                        <div class="modal-footer">
                            <%-- <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>--%>
                            <button type="button" runat="server" id="Button2" class="btn btn-secondary lbtnSimpanBidang">Simpan</button>
                        </div>

                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataListBidang" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Kod Bidang</th>
                                            <th scope="col">BIdang</th>
                                            <th scope="col">Tindakan</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_List_Bidang">
                                    </tbody>

                                </table>

                            </div>
                        </div>

                    </div>

                    <div class="tab-pane fade" id="PegDaftarSijil">

                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat Individu Diberi Kuasa</h6>
                        </div>
                        <br />

                        <div class="form-group row col-md-12">
                            <div class="col-md-4">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="gelaranPegMOF" id="gelaranPegMOF">
                                    <label class="input-group__label">Gelaran</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="namaPegMOF" id="namaPegMOF">
                                    <label class="input-group__label">Nama Pegawai</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="noIcPegMOF" id="noIcPegMOF">
                                    <label class="input-group__label">No. Kad Pengenalan/Passport</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="jwtPegMOF" id="jwtPegMOF">
                                    <label class="input-group__label">Jawatan</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="noPhonePegMOF" id="noPhonePegMOF">
                                    <label class="input-group__label">Nombor Telefon</label>
                                </div>
                            </div>
                        </div>

                        <!-- Button -->
                        <div class="modal-footer">
                            <%--<button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>--%>
                            <button type="button" runat="server" id="btnPicMofBatal" class="btn btn-danger btnPicMofBatal" style="display: none;">Batal</button>
                            <button type="button" runat="server" id="Button6" class="btn btn-secondary lbtnSimpanPIC">Simpan</button>
                        </div>

                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataPICSijilMOF" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Gelaran</th>
                                            <th scope="col">Nama</th>
                                            <th scope="col">No. Kad Pengenalan/Passport</th>
                                            <th scope="col">Jawatan</th>
                                            <th scope="col">No. Telefon</th>
                                            <th scope="col">Tindakan</th>

                                        </tr>
                                    </thead>
                                    <tbody id="tableID_PIC_MOF">
                                    </tbody>

                                </table>

                            </div>
                        </div>

                    </div>

                    <div class="tab-pane fade" id="TarafBumi">
                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat Taraf Bumiputera</h6>
                            <label id="idDaftarBumi" style="visibility: hidden;"></label>
                        </div>
                        <br />

                        <div class="form-group row col-md-12">
                            <div id="statBumi" class="form-group col-md-6">
                                <label for="lblStatBumi">Status Bumiputera <a style="color: red">*</a> : </label>
                                <div class="form-check-inline col-md-12">
                                    <label class="form-check-label col-md-6">
                                        <input type="checkbox" class="form-check-input" id="chckBukanBumi" name="chckStatBumi">Bukan Bumiputera
                                    </label>
                                    &nbsp;
                                    <label class="form-check-label col-md-4">
                                        <input type="checkbox" class="form-check-input" id="chckBumi" name="chckStatBumi">Bumiputera
                                    </label>
                                    &nbsp;
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="noSjilBumi" id="noSjilBumi">
                                    <label class="input-group__label">No. Sijil Bumiputera</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" onfocus="(this.type='date')" placeholder="" name="tkhMulaBumi" id="tkhMulaBumi">
                                    <label class="input-group__label">Tarikh Berkuatkuasa</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" onfocus="(this.type='date')" placeholder="" name="tkhTamatBumi" id="tkhTamatBumi">
                                    <label class="input-group__label">Hingga</label>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="UploadSurat">Dokumen Sijil Akuan Pendaftaran Syarikat Bumiputera  <a style="color: red">*</a> : </label>
                                <div class="form-inline">

                                    <input type="file" id="fileInputSijilBumi" />
                                    <%--<input type="button" id="uploadButton" value="Upload" onclick="uploadFileSijilBumi()" />--%>
                                    <span id="uploadedFileNameLabel" style="display: inline;"></span>
                                    <span id="">&nbsp</span>
                                    <span id="progressContainer"></span>
                                    <input type="hidden" class="form-control" id="hidJenDokBumi" style="width: 300px" readonly="readonly" />
                                    <input type="hidden" class="form-control" id="hidFileNameBumi" style="width: 300px" readonly="readonly" />
                                </div>
                            </div>
                        </div>

                        <!-- Button -->
                        <div class="modal-footer">
                            <button type="button" runat="server" id="btnBatalBumi" class="btn btn-danger btnBatalBumi" style="display: none;">Batal</button>
                            <button type="button" runat="server" id="Button4" class="btn btn-secondary lbtnSimpanTarafBumi">Simpan</button>
                        </div>

                        <!-- TableData Taraf Bumi -->
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataMklmtBumi" class="table table-striped" style="width: 95%">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bil</th>
                                                <th scope="col">Status Bumiputera</th>
                                                <th scope="col">No. Sijil Pendaftaran</th>
                                                <th scope="col">Tarikh BerkuatKuasa</th>
                                                <th scope="col">Tarikh Tamat</th>
                                                <th scope="col">Lampiran</th>
                                                <th scope="col">Tindakan</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Mklmt_Bumi">
                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

            <!-- CIDB -->

            <div class="tab-pane fade" id="cidb">

                <ul class="nav nav-tabs" id="myTabCIDB">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#mklmtCIDB">Senarai CIDB</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#kategoriCIDB">Kategori</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#PegTauliahCIDB">Pegawai Ditauliahkan</a>
                    </li>
                </ul>

                <div class="tab-content">

                    <div class="tab-pane fade show active" id="mklmtCIDB">
                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat CIDB</h6>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataMklmtCIDB" class="table table-striped" style="width: 95%">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bil</th>
                                                <th scope="col">Kod Daftar</th>
                                                <th scope="col">No Pendaftaran</th>
                                                <th scope="col">Tarikh Berkuatkuasa</th>
                                                <th scope="col">Tarikh Tamat</th>
                                                <th scope="col">Lampiran</th>
                                                <th scope="col">Tindakan</th>

                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai_CIDB">
                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="kategoriCIDB">

                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Kategori</h6>
                        </div>
                        <br />

                        <div class="form-group row col-md-12">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlGredKerja" id="ddlGredKerja">
                                    </select>
                                    <label class="input-group__label">Gred Kerja</label>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                                <div class="form-group input-group">
                                    <input type="hidden" id="selectedKhususIdsInput" name="selectedKhususIdsInput">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlKategori" id="ddlKategori">
                                    </select>
                                    <label class="input-group__label">Kategori</label>
                                </div>
                            </div>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataPengkhususan" class="table table-striped" style="width: 95%">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bil</th>
                                                <th scope="col">Kod Khusus</th>
                                                <th scope="col">Pengkhususan</th>
                                                <th scope="col">Tindakan</th>

                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai_Pengkhususan">
                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <%--<button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>--%>
                            <button type="button" runat="server" id="Button1" class="btn btn-secondary lbtnSimpanKhusus">Simpan</button>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataListKat" class="table table-striped" style="width: 95%">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bil</th>
                                                <th scope="col">Gred Kerja</th>
                                                <th scope="col">kategori</th>
                                                <th scope="col">Kod Khusus</th>
                                                <th scope="col">Pengkhususan</th>
                                                <th scope="col">Tindakan</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableID_List_Kat">
                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="tab-pane fade" id="PegTauliahCIDB">
                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat Nama Pada Pendaftaran Sijil CIDB</h6>
                        </div>

                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="gelPegCIDB" name="gelPegCIDB" />
                                        <label class="input-group__label">Gelaran</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="namaPegCIDB" name="namaPegCIDB" />
                                        <label class="input-group__label">Nama Pegawai</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="icPegCIDB" name="icPegCIDB" />
                                        <label class="input-group__label">No. Kad Pengenalan/Passport</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="jwtPegCIDB" name="jwtPegCIDB" />
                                        <label class="input-group__label">Jawatan</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="noTelPegCIDB" name="noTelPegCIDB" />
                                        <label class="input-group__label">Nombor Telefon</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" runat="server" id="btnBatalPicCidb" class="btn btn-danger btnBatalPicCidb" style="display: none;">Batal</button>
                            <button type="button" runat="server" id="Button5" class="btn btn-secondary btnSimpanPegCIDB">Simpan</button>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataPegCIDB" class="table table-striped" style="width: 95%">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bil</th>
                                                <th scope="col">Gelaran</th>
                                                <th scope="col">Nama</th>
                                                <th scope="col">No. Kad Pengenalan/Passport</th>
                                                <th scope="col">Jawatan</th>
                                                <th scope="col">No. Telefon</th>
                                                <th scope="col">Tindakan</th>

                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai_PegCIDB">
                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

            <div class="tab-pane fade" id="lainLain">

                <ul class="nav nav-tabs" id="myTabLain">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#mklmtLain">Maklumat Pendaftaran Sijil lain</a>
                    </li>
                </ul>

                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataMklmtLain" class="table table-striped" style="width: 95%">
                                <thead>
                                    <tr>
                                        <th scope="col">Bil</th>
                                        <th scope="col">Kod Daftar</th>
                                        <th scope="col">No Pendaftaran</th>
                                        <th scope="col">Tarikh Berkuatkuasa</th>
                                        <th scope="col">Tarikh Tamat</th>
                                        <th scope="col">Lampiran</th>
                                        <th scope="col">Tindakan</th>

                                    </tr>
                                </thead>
                                <tbody id="tableID_Senarai_Lain">
                                </tbody>

                            </table>

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
                <div class="modal-body">
                    Anda pasti ingin menyimpan rekod ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger"
                        data-dismiss="modal">
                        Tidak</button>
                    <button type="button" class="btn btn-secondary btnYa">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaBidang">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaPicMOF">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaBumi">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaKhusus">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaPicCidb">Ya</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="confirmationModalDelete" tabindex="-1" role="dialog"
        aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalDeleteLabel">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Anda pasti ingin memadam rekod ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger"
                        data-dismiss="modal">
                        Tidak</button>
                    <button type="button" class="btn btn-secondary btnYaDeleteSSM">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaDeleteMOF">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaDeleteCIDB">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaDeleteLain">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaDeleteBidang">Ya </button>
                    <button type="button" class="btn btn-secondary btnYaDeletePicMOF">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaDeleteBumi">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaDeleteKhusus">Ya</button>
                    <button type="button" class="btn btn-secondary btnYaDeletePicCidb">Ya</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal Bidang -->
    <div class="modal fade" id="confirmationModalBidang" tabindex="-1" role="dialog"
        aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabelBidang">Pengesahan</h5>
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
                    <button type="button" class="btn btn-secondary btnYaBidang">Ya</button>
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

        var tblMklmtSSM
        var tblMklmtMOF
        var tblListBidang
        var tblPicMOF
        var tblMklmtBumi
        var tblMklmtCIDB
        var tblListKat
        var tblPicCIDB
        var tblMklmtLain

        $(document).ready(function () {
            $('#tkhMulaKuasa').change(function () {
                var startDate = $(this).val();
                $('#tkhTamatKuasa').rules('add', {
                    max: function () {
                        $(this).val(startDate);
                    }
                });
            });

            $('#tkhTamatKuasa').change(function () {
                var endDate = $(this).val();
                $('#tkhMulaKuasa').rules('add', {
                    max: function () {
                        $(this).val(endDate);
                    }
                });
            });
        });

        // input validation

        $('#noDaftar').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase());
        });

        $('#noPhonePegMOF').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#namaPegMOF').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase());
        });

        $('#jwtPegMOF').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#gelaranPegMOF').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#noIcPegMOF').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        // input validation
        $('#noTelPegCIDB').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#namaPegCIDB').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#jwtPegCIDB').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#gelPegCIDB').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#icPegCIDB').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $(document).ready(function () {
            $("input[name='chckStatBumi']").click(function () {
                if ($("#chckBumi").is(":checked")) {
                    $("input[name='chckStatBumi']").val("BUMI")
                    $("#chckBukanBumi").prop('disabled', true);
                    enableAllFieldsBumi();
                    //console.log("Status Bumi Is Checked: ", $("input[name='chckStatBumi']").val());
                } else if ($("#chckBukanBumi").is(":checked")) {
                    $("input[name='chckStatBumi']").val("BUKAN BUMI")
                    $("#chckBumi").prop('disabled', true);
                    disableAllFieldsBumi();
                    //console.log("Status Bumi Is Not Bumi; ", $("input[name='chckStatBumi']").val());
                } else {
                    $("input[name='chckStatBumi']").prop('checked', false);
                    $("#chckBukanBumi").prop('disabled', false);
                    $("#chckBumi").prop('disabled', false);
                    enableAllFieldsBumi();
                }
            });
        });

        let activeTab = '#ssm';

        $(document).ready(function () {
            $('#myTabs').on('shown.bs.tab', async function (e) {
                // Get the currently active tab (e.target)
                activeTab = $(e.target).attr('href');

                if (activeTab === "#ssm") {
                    clearAllFieldsDaftar();
                    $('#title').text("Maklumat Sijil Pendaftaran Perniagaan");
                    $('#KodDaftar').html("SSM");
                    $('#JenDaftar').hide();
                    $('#fileSijilSSM').show();
                    $('#fileSijilMOF').hide();
                    $('#fileSijilCIDB').hide();
                    $('#fileSijilLain').hide()
                    await LoadDataDaftar(activeTab);
                    tblMklmtSSM.ajax.reload();
                } else if (activeTab === "#mof") {
                    clearAllFieldsDaftar();
                    $('#KodDaftar').html("KEW");
                    $('#title').text("Maklumat Bidang Perlolehan Bekalan & Perkhidmatan (MOF)");
                    $('#JenDaftar').hide();
                    $('#fileSijilSSM').hide();
                    $('#fileSijilMOF').show();
                    $('#fileSijilCIDB').hide();
                    $('#fileSijilLain').hide();
                    await LoadDataDaftar(activeTab);
                    tblMklmtMOF.ajax.reload();
                } else if (activeTab === "#cidb") {
                    clearAllFieldsDaftar();
                    $('#title').text("Maklumat Khusus Perolehan Kerja (CIDB)");
                    $('#KodDaftar').html("CIDB");
                    $('#JenDaftar').hide();
                    $('#fileSijilSSM').hide();
                    $('#fileSijilMOF').hide();
                    $('#fileSijilCIDB').show();
                    $('#fileSijilLain').hide();
                    await LoadDataDaftar(activeTab);
                    tblMklmtCIDB.ajax.reload();
                } else if (activeTab === "#lainLain") {
                    clearAllFieldsDaftar();
                    $('#title').text("Lain-Lain");
                    $('#KodDaftar').html("");
                    $('#IdDaftar').html("");
                    $('#JenDaftar').show();
                    $('#fileSijilSSM').hide();
                    $('#fileSijilMOF').hide();
                    $('#fileSijilCIDB').hide();
                    $('#fileSijilLain').show();
                    await LoadDataDaftar(activeTab);
                    tblMklmtLain.ajax.reload();
                }
            });

            LoadDataDaftar(activeTab);
        });

        let activeTabsMOF = '#mklmtMOF';
        // Load Mklmt DataTable MOF
        $(document).ready(function () {
            $('#myTabMOF').on('shown.bs.tab', async function (e) {
                activeTabsMOF = $(e.target).attr('href');

                if (activeTabsMOF === "#mklmtMOF") {
                    $('#KodDaftar').html("KEW");
                    tblMklmtMOF.ajax.reload();
                } else if (activeTabsMOF === "#BidangUtama") {
                    tblListBidang.ajax.reload();
                } else if (activeTabsMOF === "#PegDaftarSijil") {
                    $('#KodDaftar').html("KEW");
                    tblPicMOF.ajax.reload();
                } else if (activeTabsMOF === "#TarafBumi") {
                    //LoadDataBumiById();
                    $('#KodDaftar').html("BUMI");
                    tblMklmtBumi.ajax.reload();
                }
            });
        });

        let activeTabsCIDB = '#mklmtCIDB';
        // Load Mklmt DataTable CIDB
        $(document).ready(function () {
            $('#myTabCIDB').on('shown.bs.tab', async function (e) {
                activeTabsCIDB = $(e.target).attr('href');

                if (activeTabsCIDB === "#mklmtCIDB") {
                    /*$('#tblDataMklmtMOF').ajax.reload();*/
                    tblMklmtCIDB.ajax.reload();
                } else if (activeTabsCIDB === "#kategoriCIDB") {
                    tblListKat.ajax.reload();
                } else if (activeTabsCIDB === "#PegTauliahCIDB") {
                    /*$('#tblDataPICMOF').ajax.reload();*/
                    tblPicCIDB.ajax.reload();
                }
            });
        });


        async function LoadDataDaftar(activeTab) {
            var IdSya = '<%=Session("ssusrID")%>';

            if (IdSya !== "") {
                var KodDaftar = $('#KodDaftar').html();
                var RecordDaftar = await AjaxGetRecordDaftar(IdSya, KodDaftar, activeTab);

                if (RecordDaftar.length === 0) {
                    $('.btnRekodBaru').hide();
                    $('.btnDaftarSijilBatal').hide();
                    $('#IdDaftar').html("");
                    enableAllFieldsDaftar();
                } else {
                    const validTabs = ["#ssm", "#mof", "#cidb", "#lainlain"];

                    if (validTabs.includes(activeTab)) {
                        await setValue_DaftarSijil(RecordDaftar);
                        disableAllFieldsDaftar(activeTab);
                        $('.btnRekodBaru').show();
                        $('.btnDaftarSijilBatal').hide();

                        if (activeTab === "#lainlain") {
                            await setValue_DaftarSijilLain(RecordDaftar);
                            disableAllFieldsDaftar(activeTab);
                            $('.btnRekodBaru').show();
                            $('.btnDaftarSijilBatal').hide();
                        }
                    } else {
                        enableAllFieldsDaftar();
                        $('.btnRekodBaru').hide();
                    }
                }
            }
        }


        function setValue_DaftarSijil(RecordDaftar) {

            /*console.log("SetValue Data: ", RecordDaftar);*/
            var dataDaftar = RecordDaftar[0];
            $('#IdDaftar').html(dataDaftar.ID_Daftar);

            $('#noDaftar').val(dataDaftar.NoDaftar);
            $('#tkhMulaKuasa').val(dataDaftar.TkhMula);
            $('#tkhTamatKuasa').val(dataDaftar.TkhTamat);
        }

        function setValue_DaftarSijilLain(RecordDaftar) {

            //var dataDaftar = RecordDaftar[0];
            console.log("SetValue_DaftarSijilLain: ", RecordDaftar);
            $('#IdDaftar').html(RecordDaftar[0].IdDaftar);

            var ddlJenDaftar = $('#ddlJenDaftar');
            var selectObj_JenDaftar = $('#ddlJenDaftar');
            $(ddlJenDaftar).dropdown('set selected', RecordDaftar[0].KodDaftar);
            selectObj_JenDaftar.append("<option value = '" + RecordDaftar[0].KodDaftar + "'>" + RecordDaftar[0].ButiranJenDaftar + "</option>")

            $('#noDaftar').val(RecordDaftar[0].NoDaftar);
            $('#tkhMulaKuasa').val(RecordDaftar[0].TkhMula);
            $('#tkhTamatKuasa').val(RecordDaftar[0].TkhTamat);
        }

        async function AjaxGetRecordDaftar(IdSya, kodDaftar, tabs) {
            try {

                const response = await fetch('Pendaftaran_WS.asmx/LoadData_DaftarSijil', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        IdSya: IdSya,
                        KodDaftar: kodDaftar,
                        ActiveTabs: tabs,
                    })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        async function LoadDataDaftarById(idDaftar) {
            var IdSya = '<%=Session("ssusrID")%>';

            if (IdSya !== "") {
                var KodDaftar = $('#KodDaftar').html();
                var RecordDaftar = await AjaxGetRecordDaftarById(idDaftar, KodDaftar);

                if (RecordDaftar.length === 0) {
                    $('.btnRekodBaru').hide();
                    $('.btnDaftarSijilBatal').hide();
                    enableAllFieldsDaftar();
                } else {
                    const validTabs = ["#ssm", "#mof", "#cidb", "#lainlain"];
                    if (validTabs.includes(activeTab)) {
                        await setValue_DaftarSijil(RecordDaftar);
                    } else {
                        enableAllFieldsDaftar();
                        await setValue_DaftarSijilLain(RecordDaftar);
                        $('.btnDaftarSijilLainBatal').show();
                        $('.btnRekodBaru').hide();
                    }
                }

            }
        }

        function setValue_DaftarSijilById(RecordDaftar) {

            /*console.log("SetValue Data: ", RecordDaftar);*/
            var dataDaftar = RecordDaftar[0];
            $('#IdDaftar').html(dataDaftar.IdDaftar);
            //var ddlJenDaftar = $('#ddlJenDaftar');
            //var selectObj_JenDaftar = $('#ddlJenDaftar');
            //$(ddlJenDaftar).dropdown('set selected', RecordDaftar.Kod_Daftar);
            //selectObj_JenDaftar.append("<option value = '" + RecordDaftar.kod_Daftar + "'>" + RecordDaftar.ButiranJenDaftar + "</option>")

            $('#noDaftar').val(dataDaftar.NoDaftar);
            //console.log("RecordDaftar.NoDaftar : ", dataDaftar.NoDaftar);
            //console.log("RecordDaftar.TkhMula : ", dataDaftar.TkhMula);
            $('#tkhMulaKuasa').val(dataDaftar.TkhMula);
            $('#tkhTamatKuasa').val(dataDaftar.TkhTamat);
        }

        async function AjaxGetRecordDaftarById(IdDaftar) {
            try {

                const response = await fetch('Pendaftaran_WS.asmx/LoadData_DaftarSijilById', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        IdDaftar: IdDaftar,
                    })
                });
                const data = await response.json();
                //console.log("data Load Daftar Sijil Ajax: ", data);
                //if (data.length > 0) {

                //}
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        $('#ddlJenDaftar').on('change', function () {
            var valueJenDaftar

            valueJenDaftar = $('#ddlJenDaftar').val();

            // Update the HTML content of #KodDaftar
            $('#KodDaftar').html(valueJenDaftar);

            var ajaxUrl = "Pendaftaran_WS.asmx/LoadList_MklmtSijilLain";
            var ajaxData = {
                idSya: '<%=Session("ssusrID")%>',
                kodDaftar: $("#KodDaftar").val() // Add the selected value to the data
            };

            // Reload the DataTable with the updated URL and data
            $('#tblDataMklmtLain').DataTable().ajax.url(ajaxUrl).load(ajaxData);
            //tblMklmtLain.ajax.reload();
        });

        async function clearAllFieldsDaftar() {
            $("#IdDaftar").html("");
            $('#noDaftar').val("");
            $('#tkhMulaKuasa').val("");
            $('#tkhTamatKuasa').val("");
        }

        async function clearAllFieldsSijilLain() {

            $("#IdDaftar").html("");
            //$('#ddlJenDaftar').val("");
            $('#ddlJenDaftar').dropdown('clear');
            // Set the value to an empty string
            $('#ddlJenDaftar').dropdown('set selected', '');
            $('#noDaftar').val("");
            $('#tkhMulaKuasa').val("");
            $('#tkhTamatKuasa').val("");
            $('#fileInputLain').val("");
        }

        async function disableAllFieldsDaftar(activeTab) {
            $('#ddlJenDaftar').prop('disabled', true);
            $('#noDaftar').prop('disabled', true);
            $('#tkhMulaKuasa').prop('disabled', true);
            $('#tkhTamatKuasa').prop('disabled', true);

            /*$('#fileInputMOF').prop('disabled', true);*/

            if (activeTab === "#ssm") {
                $('#fileInputSSM').prop('disabled', true);
            } else if (activeTab === "#mof") {
                $('#fileInputMOF').prop('disabled', true);
            } else if (activeTab === "#cidb") {
                $('#fileInputCIDB').prop('disabled', true);
            } else if (activeTab === "#lain") {
                $('#fileInputLain').prop('disabled', true);
            }

        }

        async function enableAllFieldsDaftar() {
            $('#ddlJenDaftar').prop('disable', false);
            $('#noDaftar').prop('disabled', false);
            $('#tkhMulaKuasa').prop('disabled', false);
            $('#tkhTamatKuasa').prop('disabled', false);

            if (activeTab === "#ssm") {
                $('#fileInputSSM').prop('disabled', false);
            } else if (activeTab === "#mof") {
                $('#fileInputMOF').prop('disabled', false);
            } else if (activeTab === "#cidb") {
                $('#fileInputCIDB').prop('disabled', false);
            } else if (activeTab === "#lain") {
                $('#fileInputLain').prop('disabled', false);
            }
        }

        var IdDokSSM;
        var BilSijilSSM;

        $(document).ready(function () {
            /* show_loader();*/
            tblMklmtSSM = $("#tblDataMklmtSSM").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_MklmtSSM",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        var dataJson = JSON.parse(json.d);
                        console.log(dataJson);

                        if (dataJson.length > 0) {
                            // Assuming ID_Dok is a property directly present in each row
                            var bilFromResponse = dataJson[0].Bil || '';

                            // Modify the data to include ID_Dok in each row
                            dataJson = dataJson.map(function (row) {
                                row.Bil = bilFromResponse;
                                return row;
                            });

                            return dataJson;
                        } else {
                            return false;
                        }

                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: '<%=Session("ssusrID")%>',
                            kodDaftar: 'SSM'
                        })
                        //akhir sini
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
                    { "data": "Kod_Daftar" },
                    { "data": "No_Daftar" },
                    { "data": "TkhMula" },
                    { "data": "TkhTamat" },
                    {
                        "data": "Lampiran",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            BilSijilSSM = row.Bil;

                            var link = `<a href="#" onclick="OpenFileSSM('${fileName}', '${BilSijilSSM}'); return false;">${fileName}</a>`;
                            return link;
                        }
                    },
                    {
                        className: "btnEdit",
                        "data": "ID_Daftar", // Confirmation ID
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditSSM" runat="server" class="btn btnEditSSM" type="button" style="color: blue" data-dismiss="modal" data-id="${data}" title="Kemaskini">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteSSM" runat="server" class="btn btnDeleteSSM" type="button" style="color: red" data-dismiss="modal" data-id="${data}" title="Padam">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        function OpenFileSSM(fileName) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/SSM/") %>' + '<%=Session("ssusrID")%>' + '/' + BilSijilSSM + '/' + fileName;
            window.open(path, '_blank');
            console.log("Bil: ", BilSijilSSM);
        }

        var BilSijilMOF;

        $(document).ready(function () {
            /* show_loader();*/
            tblMklmtMOF = $("#tblDataMklmtMOF").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_MklmtMOF",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        var dataJson = JSON.parse(json.d);
                        console.log(dataJson);

                        if (dataJson.length > 0) {
                            // Assuming ID_Dok is a property directly present in each row
                            var bilFromResponse = dataJson[0].Bil || '';

                            // Modify the data to include ID_Dok in each row
                            dataJson = dataJson.map(function (row) {
                                row.Bil = bilFromResponse;
                                return row;
                            });

                            return dataJson;
                        } else {
                            return false;
                        }

                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: '<%=Session("ssusrID")%>',
                            kodDaftar: 'KEW'
                        })
                        //akhir sini
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
                    { "data": "Kod_Daftar" },
                    { "data": "No_Daftar" },
                    { "data": "TkhMula" },
                    { "data": "TkhTamat" },
                    {
                        "data": "Lampiran",
                        "render": function (data, type, row) {

                            var fileName = data;
                            BilSijilMOF = row.Bil;

                            var link = `<a href="#" onclick="OpenFileMOF('${fileName}', '${BilSijilMOF}'); return false;">${fileName}</a>`;
                            return link;
                        }
                    },
                    {
                        className: "btnEdit",
                        "data": "ID_Daftar", // Confirmation ID
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditMOF" runat="server" class="btn btnEditMOF" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteMOF" runat="server" class="btn btnDeleteMOF" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        function OpenFileMOF(fileName) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/MOF/") %>' + '<%=Session("ssusrID")%>' + '/' + BilSijilMOF + '/' + fileName;
            window.open(path, '_blank');
            console.log("Bil: ", BilSijilMOF);
        }

        $(document).ready(function () {
            /* show_loader();*/

            tblListBidang = $("#tblDataListBidang").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_Bidang",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: '<%=Session("ssusrID")%>',
                        })
                        //akhir sini
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
                    { "data": "Kod_Bidang" },
                    { "data": "Butiran" },
                    {
                        className: "btnEdit",
                        "data": "Kod_Bidang", // Confirmation ID
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnDeleteBidang" runat="server" class="btn btnDeleteBidang" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        $(document).ready(function () {
            /* show_loader();*/
            tblPicMOF = $("#tblDataPICSijilMOF").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_PicMof",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            noDaftar: $("#noDaftar").val(),
                        })
                        //akhir sini
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
                    { "data": "Kod_Gelaran" },
                    { "data": "Nama" },
                    { "data": "No_Kad_Pengenalan" },
                    { "data": "Jawatan" },
                    { "data": "Tel_Bimbit" },
                    {
                        className: "btnEdit",
                        "data": "ID_Rujukan", //Confirmation id
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditPicMof" runat="server" class="btn btnEditPicMof" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeletePicMof" runat="server" class="btn btnDeletePicMof" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        var BilSijilBumi;

        $(document).ready(function () {
            /* show_loader();*/
            tblMklmtBumi = $("#tblDataMklmtBumi").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_MklmtBumi",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        var dataJson = JSON.parse(json.d);
                        console.log(dataJson);

                        if (dataJson.length > 0) {
                            // Assuming ID_Dok is a property directly present in each row
                            var bilFromResponse = dataJson[0].Bil || '';

                            // Modify the data to include ID_Dok in each row
                            dataJson = dataJson.map(function (row) {
                                row.Bil = bilFromResponse;
                                return row;
                            });

                            return dataJson;
                        } else {
                            return false;
                        }

                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: '<%=Session("ssusrID")%>'
                        })
                        //akhir sini
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
                    { "data": "Kod_Daftar" },
                    { "data": "No_Daftar" },
                    { "data": "Tkh_Mula" },
                    { "data": "Tkh_Tamat" },
                    {
                        "data": "Nama_Dok",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            BilSijilBumi = row.Bil;

                            var link = `<a href="#" onclick="OpenFileBumi('${fileName}', '${BilSijilBumi}'); return false;">${fileName}</a>`;
                            return link;
                        }
                    },
                    {
                        className: "btnEdit",
                        "data": "ID_Daftar", //Confirmation id
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditBumi" runat="server" class="btn btnEditBumi" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteBumi" runat="server" class="btn btnDeleteBumi" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        function OpenFileBumi(fileName) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/BUMI/") %>' + '<%=Session("ssusrID")%>' + '/' + BilSijilBumi + '/' + fileName;
            window.open(path, '_blank');
            console.log("Bil: ", BilSijilBumi);
        }

        var BilSijilCIDB;
        $(document).ready(function () {
            /* show_loader();*/
            tblMklmtCIDB = $("#tblDataMklmtCIDB").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_MklmtCIDB",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        var dataJson = JSON.parse(json.d);
                        console.log(dataJson);

                        if (dataJson.length > 0) {
                            // Assuming ID_Dok is a property directly present in each row
                            var bilFromResponse = dataJson[0].Bil || '';

                            // Modify the data to include ID_Dok in each row
                            dataJson = dataJson.map(function (row) {
                                row.Bil = bilFromResponse;
                                return row;
                            });

                            return dataJson;
                        } else {
                            return false;
                        }

                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: '<%=Session("ssusrID")%>',
                            kodDaftar: 'CIDB'
                        })
                        //akhir sini
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
                    { "data": "Kod_Daftar" },
                    { "data": "No_Daftar" },
                    { "data": "TkhMula" },
                    { "data": "TkhTamat" },
                    {
                        "data": "Lampiran",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            BilSijilCIDB = row.Bil;

                            var link = `<a href="#" onclick="OpenFileCIDB('${fileName}', '${BilSijilCIDB}'); return false;">${fileName}</a>`;
                            return link;
                        }
                    },
                    {
                        className: "btnEdit",
                        "data": "ID_Daftar", // Confirmation id
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditCIDB" runat="server" class="btn btnEditCIDB" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteCIDB" runat="server" class="btn btnDeleteCIDB" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        function OpenFileCIDB(fileName) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/CIDB/") %>' + '<%=Session("ssusrID")%>' + '/' + BilSijilCIDB + '/' + fileName;
            window.open(path, '_blank');
            console.log("Bil: ", BilSijilCIDB);
        }


        $(document).ready(function () {
            /* show_loader();*/
            tblPicCIDB = $("#tblDataPegCIDB").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_PicCidb",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            noDaftar: $("#noDaftar").val(),
                        })
                        //akhir sini
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
                    { "data": "Kod_Gelaran" },
                    { "data": "Nama" },
                    { "data": "No_Kad_Pengenalan" },
                    { "data": "Jawatan" },
                    { "data": "Tel_Bimbit" },
                    {
                        className: "btnEdit",
                        "data": "ID_Rujukan", //Confirmation id
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditPicCidb" runat="server" class="btn btnEditPicCidb" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeletePicCidb" runat="server" class="btn btnDeletePicCidb" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        var BilSijilLain;

        $(document).ready(function () {
            /* show_loader();*/
            tblMklmtLain = $("#tblDataMklmtLain").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_MklmtSijilLain",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        var dataJson = JSON.parse(json.d);
                        console.log(dataJson);

                        if (dataJson.length > 0) {
                            // Assuming ID_Dok is a property directly present in each row
                            var bilFromResponse = dataJson[0].Bil || '';

                            // Modify the data to include ID_Dok in each row
                            dataJson = dataJson.map(function (row) {
                                row.Bil = bilFromResponse;
                                return row;
                            });

                            return dataJson;
                        } else {
                            return false;
                        }

                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: '<%=Session("ssusrID")%>',
                            kodDaftar: $("#KodDaftar").val()
                        })
                        //akhir sini
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
                    { "data": "Kod_Daftar" },
                    { "data": "No_Daftar" },
                    { "data": "TkhMula" },
                    { "data": "TkhTamat" },
                    {
                        "data": "Lampiran",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            BilSijilLain = row.Bil;

                            var link = `<a href="#" onclick="OpenFileLain('${fileName}', '${BilSijilLain}'); return false;">${fileName}</a>`;
                            return link;
                        }
                    },
                    {
                        className: "btnEdit",
                        "data": "ID_Daftar", //Confirmation id
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEditLain" runat="server" class="btn btnEditLain" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDeleteLain" runat="server" class="btn btnDeleteLain" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        function OpenFileLain(fileName) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/LAIN/") %>' + '<%=Session("ssusrID")%>' + '/' + BilSijilLain + '/' + fileName;
            window.open(path, '_blank');
            console.log("Bil: ", BilSijilLain);
        }

        var selectedBidangValue;

        $(document).ready(function () {
            // alert("test")
            $('#ddlBidang').dropdown({
                selectOnKeyDown: true,
                fullTextSearch: false,
                apiSettings: {
                    url: 'Pendaftaran_WS.asmx/GetBidang?q={query}',
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

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        /*if (shouldPop === true)*/ {
                            $(obj).dropdown('show');
                        }
                    }
                },
                onChange: function (value, text, $selectedItem) {
                    selectedBidangValue = value;
                    console.log(selectedBidangValue);
                }
            });
        });

        var selectedSubBdgValue;
        var tblBidang;

        $(document).ready(function () {
            // alert("test")
            $('#ddlSubBidang').dropdown({
                selectOnKeyDown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'Pendaftaran_WS.asmx/GetSubBidang?q={query}&p=' + selectedBidangValue,
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({ q: settings.urlData.query, p: selectedBidangValue });
                        searchQuery = settings.urlData.query;
                        //console.log("Before AJAX request: q =", settings.urlData.query, ", p =", selectedBidangValue);

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

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        /*if (shouldPop === true)*/ {
                            $(obj).dropdown('show');
                        }
                    }
                },
                onChange: function (value, text, $selectedItem) {
                    selectedSubBdgValue = value;
                    console.log(selectedSubBdgValue);

                    if (tblBidang) {
                        tblBidang.destroy();
                    }

                    if (selectedSubBdgValue) {
                        tblBidang = $("#tblDataBidangMOF").DataTable({
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
                                "url": "Pendaftaran_WS.asmx/LoadList_SenaraiBidang",
                                "method": 'POST',
                                "contentType": "application/json; charset=utf-8",
                                "dataType": "json",
                                "dataSrc": function (json) {
                                    return JSON.parse(json.d);
                                },
                                "data": function () {

                                    return JSON.stringify({
                                        kodSubBdg: selectedSubBdgValue,

                                    })
                                    //akhir sini
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
                                { "data": "KodBidang" },
                                { "data": "Butiran" },
                                {
                                    className: "btnEdit",
                                    "data": "KodBidang", // Confirmation id
                                    render: function (data, type, row, meta) {
                                        if (type !== "display") {
                                            return data;
                                        }

                                        var link = `<input type="checkbox" class="form-check-input BidangSelector" style="align:center;" data-id="${data}" name="chckBidang">`;

                                        return link;

                                    },

                                }

                            ]
                        });
                    } else {
                        //alert("Sub Bidang Tidak Dipilih")
                        displayMaklumanModal("Sub Bidang Tidak Dipilih");
                    }

                    //tblBidang.ajax.reload();
                }
            });

        });

        var selectedBidangIds = []; // Array to store selected IDs

        $(document).on('change', '.BidangSelector', function () {
            var id = $(this).data('id');
            if (this.checked) {
                // Checkbox is checked, add ID to the selectedBidangIds array
                selectedBidangIds.push(id);

            } else {
                // Checkbox is unchecked, remove ID from the selectedBidangIds array
                var index = selectedBidangIds.indexOf(id);
                if (index !== -1) {
                    selectedBidangIds.splice(index, 1);
                }
            }
            // Convert the array to a comma-separated string
            var selectedBidangIdsString = selectedBidangIds.join(',');

            var Kod_Bidang = selectedBidangIdsString.split(",");

            $('#selectedBidangIdsInput').val(Kod_Bidang);

        });

        $('.lbtnSimpanBidang').click(async function () {
            if ($('#ddlBidang').val() == "", $('#ddlSubBidang').val() == "", $('#selectedBidangIdsInput').val() == "") {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila pilih sekurang-kurangya satu bidang");
            } else {

                $('#confirmationModal').modal('toggle');
                $('.btnYaPicMOF').hide();
                $('.btnYa').hide();
                $('.btnYaBidang').show();
                $('.btnYaBumi').hide();
                $('.btnYaKhusus').hide();
                $('.btnYaPicCidb').hide();
            }
        });

        $('.btnYaBidang').click(async function () {
            $('#confirmationModal').modal('toggle');

            debugger;

            let selectedBidangIdsString = $("#selectedBidangIdsInput").val();
            console.log("selectedBidangIdsString : ", selectedBidangIdsString);

            let KodBidang = selectedBidangIdsString.split(',');

            let newBidangArray = KodBidang.map(function (value) {
                return {
                    NoDaftar: $('#noDaftar').val(),
                    Bil: "",
                    KodBidang: value
                };
            });

            console.log("save KodBidang: ", KodBidang);

            var result = JSON.parse(await ajaxSaveBidangMOF(newBidangArray));
            if (result.Status !== "Failed") {
                selectedBidangIds = [];
                $('#selectedBidangIdsInput').val("");
                tblBidang.rows().nodes().to$().find('.btnEdit .BidangSelector').prop('checked', false);
                newBidangArray.splice(0, newBidangArray.length);
                tblListBidang.ajax.reload();
                console.log("selectedBidangIdsString selepas : ", selectedBidangIdsString);
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
                /*clearAllFields();*/
            } else {
                //tblBidang.rows().nodes().to$().find('.btnEdit .BidangSelector').prop('checked', false);
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
            }

        });

        async function ajaxSaveBidangMOF(newBidang) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SaveBidangMOF',
                    method: 'POST',
                    data: JSON.stringify({ mklmtBidangList: newBidang }),
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

        $('.btnPicMofBatal').click(async function () {
            clearAllFieldsPicMof();
            //disableAllFieldsPicMof();
            $('.btnPicMofBatal').hide();
        });

        //DeletePicMof
        $('#tblDataPICSijilMOF').on('click', '.btnDeletePicMof', async function (event) {
            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var IdRujukan = $(this).data("id");
            var IdSya = '<%=Session("ssusrID")%>';

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').hide();
            $('.btnYaDeleteMOF').hide();
            $('.btnYaDeleteCIDB').hide();
            $('.btnYaDeleteLain').hide();
            $('.btnYaDeleteBidang').hide();
            $('.btnYaDeletePicMOF').show();
            $('.btnYaDeleteBumi').hide();
            $('.btnYaDeleteKhusus').hide();
            $('.btnYaDeletePicCidb').hide();

            $('.btnYaDeletePicMOF').click(async function () {
                if (IdRujukan !== "") {
                    bool = await DelPicMof(IdRujukan, IdSya);
                }

                if (bool === true) {
                    $('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                }

                $('#confirmationModalDelete').modal('toggle');
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                tblPicMOF.ajax.reload();

                return false;
            });
        });

        async function DelPicMof(IdRujukan, IdSya) {
            var bool = false;
            var result = JSON.parse(await AjaxDeletePicMof(IdRujukan, IdSya));

            if (result.Code === "00") {
                bool = true;
            }
            return bool;
        }

        async function AjaxDeletePicMof(IdRujukan, IdSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Pendaftaran_WS.asmx/DeleteRecordPicMof',
                    method: 'POST',
                    data: JSON.stringify({
                        IdRujukan: IdRujukan,
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

        //EditPicMof
        $("#tblDataPICSijilMOF").on('click', '.btnEditPicMof', async function (event) {
            event.stopPropagation();
            var idRujukan = $(this).attr("data-id");

            $('.lbtnSimpanPIC').show();
            $('.btnPicMofBatal').show();

            enableAllFieldsPicMof();
            clearAllFieldsPicMof();
            ////Load And Set data in the form
            LoadDataPicMofById(idRujukan);
            //console.log(idDaftar);
        });

        async function LoadDataPicMofById(idRujukan) {
            var idSya = '<%=Session("ssusrID")%>';

            if (idRujukan !== "") {
                var RecordPicMof = await AjaxGetRecordPicMof(idRujukan, idSya);

                if (RecordPicMof.length === 0) {
                    $('.btnPicMofBatal').hide();
                    disableAllFieldsPicMof();
                } else {
                    await setValue_PicMof(RecordPicMof);
                    //$('#btnPicMofBatal').show();
                }
            }
        }

        async function AjaxGetRecordPicMof(idRujukan, idSya) {
            try {

                const response = await fetch('Pendaftaran_WS.asmx/LoadData_PicMof', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        IdRujukan: idRujukan,
                        IdSya: idSya
                    })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        async function setValue_PicMof(RecordPicMof) {
            $('#gelaranPegMOF').val(RecordPicMof[0].Kod_Gelaran);
            $('#namaPegMOF').val(RecordPicMof[0].Nama);
            $('#noIcPegMOF').val(RecordPicMof[0].No_Kad_Pengenalan);
            $('#jwtPegMOF').val(RecordPicMof[0].Jawatan);
            $('#noPhonePegMOF').val(RecordPicMof[0].Tel_Bimbit);
        }

        async function disableAllFieldsPicMof() {
            $('#gelaranPegMOF').prop('disabled', true);
            $('#namaPegMOF').prop('disabled', true);
            $('#noIcPegMOF').prop('disabled', true);
            $('#jwtPegMOF').prop('disabled', true);
            $('#noPhonePegMOF').prop('disabled', true);
        }

        async function enableAllFieldsPicMof() {
            $('#gelaranPegMOF').prop('disable', false);
            $('#namaPegMOF').prop('disabled', false);
            $('#noIcPegMOF').prop('disabled', false);
            $('#jwtPegMOF').prop('disabled', false);
            $('#noPhonePegMOF').prop('disabled', false);
        }

        async function clearAllFieldsPicMof() {
            $('#gelaranPegMOF').val("");
            $('#namaPegMOF').val("");
            $('#noIcPegMOF').val("");
            $('#jwtPegMOF').val("");
            $('#noPhonePegMOF').val("");
        }

        $('.lbtnSimpanPIC').click(async function () {
            if ($('#gelaranPegMOF').val() == "" || $('#namaPegMOF').val() == "" || $('#noIcPegMOF').val() == "" || $('#jwtPegMOF').val() == "" || $('#noPhonePegMOF').val() == "") {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila Isi Maklumat Yang Diperlukan");
            } else {
                $('#confirmationModal').modal('toggle');
                $('.btnYaPicMOF').show();
                $('.btnYa').hide();
                $('.btnYaBidang').hide();
                $('.btnYaBumi').hide();
                $('.btnYaKhusus').hide();
                $('.btnYaPicCidb').hide();
            }
        });

        $('.btnYaPicMOF').click(async function () {
            $('#confirmationModal').modal('toggle');

            var newMklmtPicMof = {
                mklmtPicMof: {
                    IdSya: '<%=Session("ssusrID")%>',
                    Gelaran: $('#gelaranPegMOF').val(),
                    NamaPegMof: $('#namaPegMOF').val(),
                    NoICPegMof: $('#noIcPegMOF').val(),
                    JawatanMof: $('#jwtPegMOF').val(),
                    NoTelPegMof: $('#noPhonePegMOF').val(),
                    IdRujukan: $('#noDaftar').val()
                }
            }

            console.log(newMklmtPicMof);
            var result = JSON.parse(await ajaxSavePicMof(newMklmtPicMof));

            if (result.Status !== "Failed") {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
                tblPicMOF.ajax.reload();
                clearAllFields();
            } else {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
            }
        });

        async function ajaxSavePicMof(newMklmtPicMof) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SavePicSijilMOF',
                    method: 'POST',
                    data: JSON.stringify(newMklmtPicMof),
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


        async function LoadDataBumiById(IdDaftar) {
            var idSya = '<%=Session("ssusrID")%>';

            if (IdDaftar !== "") {
                var RecordBumi = await AjaxGetRecordBumi(IdDaftar, idSya);

                if (RecordBumi.length === 0) {
                    // $('.btnPicMofBatal').hide();
                    // disableAllFieldsPicMof();
                } else {
                    await setValue_Bumi(RecordBumi);
                    //$('#btnPicMofBatal').show();
                }
            }
        }

        async function AjaxGetRecordBumi(IdDaftar, idSya) {
            try {

                const response = await fetch('Pendaftaran_WS.asmx/LoadData_Bumi', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        IdDaftar: IdDaftar,
                        IdSya: idSya
                    })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        async function setValue_Bumi(RecordBumi) {

            console.log("value in SetValueBumi: ", RecordBumi);

            $('#idDaftarBumi').html(RecordBumi[0].ID_Daftar);

            if (RecordBumi[0].Kod_Daftar === "BUMI") {
                //$("#chckBumi").is(":checked");
                $('#chckBumi').prop('checked', true);
                $("input[name='chckStatBumi']").val("BUMI");
                $('#chckBukanBumi').prop('disabled', true);
            } else if (RecordBumi[0].Kod_Daftar === "BUKAN BUMI") {
                $("#chckBukanBumi").prop('checked', true);
                $("input[name='chckStatBumi']").val("BUKAN BUMI");
                $("#chckBumi").prop('disabled', true);
            }

            $('#noSjilBumi').val(RecordBumi[0].No_Daftar);
            $('#tkhMulaBumi').val(RecordBumi[0].Tkh_Mula);
            $('#tkhTamatBumi').val(RecordBumi[0].Tkh_Tamat);
            //$('#fileInputSijilBumi').val(RecordBumi[0].Jawatan);
        }

        async function disableAllFieldsBumi() {
            // $("input[name='chckStatBumi']").prop('disabled', true);
            $('#noSjilBumi').prop('disabled', true);
            $('#tkhMulaBumi').prop('disabled', true);
            $('#tkhTamatBumi').prop('disabled', true);
            $('#fileInputSijilBumi').prop('disabled', true);
        }

        async function enableAllFieldsBumi() {
            $("input[name='chckStatBumi']").prop('disable', false);
            $('#noSjilBumi').prop('disabled', false);
            $('#tkhMulaBumi').prop('disabled', false);
            $('#tkhTamatBumi').prop('disabled', false);
            $('#fileInputSijilBumi').prop('disabled', false);
        }

        async function clearAllFieldsBumi() {
            $("input[name='chckStatBumi']").prop('checked', false);
            $('#noSjilBumi').val("");
            $('#tkhMulaBumi').val("");
            $('#tkhTamatBumi').val("");
            $('#fileInputSijilBumi').val("");
        }

        $('.btnBatalBumi').click(async function () {
            clearAllFieldsBumi();
            //disableAllFieldsPicMof();
            $('.btnBatalBumi').hide();
            $('#idDaftarBumi').html("");
        });

        $('#noSjilBumi').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('.lbtnSimpanTarafBumi').click(async function () {
            debugger;

            var statBumi = $("input[name='chckStatBumi']").val();
            console.log("StatBUmi: ", statBumi);

            if ($("input[name='chckStatBumi']").val() !== "") {

                if ($("input[name='chckStatBumi']").val() == "BUKAN BUMI") {
                    $('#confirmationModal').modal('toggle');
                    $('.btnYaBumi').show();
                    $('.btnYaPicMOF').hide();
                    $('.btnYa').hide();
                    $('.btnYaBidang').hide();
                    $('.btnYaKhusus').hide();
                    $('.btnYaPicCidb').hide();
                } else {

                    if ($("input[name='chckStatBumi']").val() == "" || $('#noSijilBumi').val() == "" || $('#TkhMulaBumi').val() == "" || $('#TkhTamatBumi').val() == "" || $('#fileInputSijilBumi').val() == "") {
                        $('#maklumanModal').modal('toggle');
                        $('#detailMakluman').html("Sila Isi Maklumat Yang Diperlukan");
                    } else {
                        $('#confirmationModal').modal('toggle');
                        $('.btnYaBumi').show();
                        $('.btnYaPicMOF').hide();
                        $('.btnYa').hide();
                        $('.btnYaBidang').hide();
                        $('.btnYaKhusus').hide();
                        $('.btnYaPicCidb').hide();
                    }

                }
            } else {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila Isi Maklumat Yang Diperlukan");
            }
        })

        $('.btnYaBumi').click(async function () {
            $('#confirmationModal').modal('toggle');

            debugger;

            if ($("input[name='chckStatBumi']").val() == "BUKAN BUMI") {
                var newMklmtBumi = {
                    mklmtBumi: {
                        IdDaftar: $('#idDaftarBumi').html(),
                        IdSya: '<%=Session("ssusrID")%>',
                        StatBumi: $("input[name='chckStatBumi']").val(),
                        NoDaftar: '000000',
                        TkhMula: '',
                        TkhTamat: '',
                    }
                }

                var result = JSON.parse(await ajaxSaveTarafBumi(newMklmtBumi));

                if (result.Status !== "Failed") {
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html(result.Message);
                    tblMklmtBumi.ajax.reload();
                    /*clearAllFields();*/
                } else {
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html(result.Message);
                }

            } else {
                var form = $(this).closest('form');
                //File BUmi
                var fileName = await getFileName(form.find('#fileInputSijilBumi'));
                var fileExtension = await getFileExtension(form.find('#fileInputSijilBumi'));

                var ListFile = [
                    {
                        /*IdDok: null,*/
                        IdSya: '<%=Session("ssusrID")%>',
                        NoRujukan: '',
                        JenDok: "BUMI",
                        FileName: fileName,
                        Bil: '',
                        FilePath: '~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/BUMI/',
                        JenFile: fileExtension,
                    }
                ];

                var newMklmtBumi = {
                    mklmtBumi: {
                        IdDaftar: $('#idDaftarBumi').html(),
                        IdSya: '<%=Session("ssusrID")%>',
                        StatBumi: $("input[name='chckStatBumi']").val(),
                        //Bumi: $('#chckBumi').val(),
                        //BukanBumi: $('#chckBukanBumi').val(),
                        NoDaftar: $('#noSjilBumi').val(),
                        TkhMula: $('#tkhMulaBumi').val(),
                        TkhTamat: $('#tkhTamatBumi').val(),
                        ListFile: ListFile
                    }
                }

                console.log("MklmtBumi", newMklmtBumi);
                var result = JSON.parse(await ajaxSaveTarafBumi(newMklmtBumi));

                if (result.Status !== "Failed") {

                    try {
                        var messageFile;
                        messageFile = uploadFileBumi();
                        console.log("Value MessageFile: ", messageFile);

                        if (messageFile.message !== "OK") {
                            displayMaklumanModal(messageFile);
                            return;
                        }
                    } catch (error) {
                        console.error("Error during file upload:", error);
                        displayMaklumanModal("Gagal Memuatnaik Fail");
                        return;
                    }
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html(result.Message);
                    tblMklmtBumi.ajax.reload();
                    clearAllFieldsBumi();
                } else {
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html(result.Message);
                }
            }

        });

        async function ajaxSaveTarafBumi(newMklmtBumi) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SaveTarafBumi',
                    method: 'POST',
                    data: JSON.stringify(newMklmtBumi),
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

        var selectedKatCIDB;
        var tblKhusus;

        $(document).ready(function () {
            // alert("test")
            $('#ddlKategori').dropdown({
                selectOnKeyDown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'Pendaftaran_WS.asmx/GetKatCIDB?q={query}',
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

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        /*if (shouldPop === true)*/ {
                            $(obj).dropdown('show');
                        }
                    }
                },
                onChange: function (value, text, $selectedItem) {
                    selectedKatCIDB = value;
                    console.log(selectedKatCIDB);

                    if (tblKhusus) {
                        tblKhusus.destroy();
                    }

                    if (selectedKatCIDB) {
                        tblKhusus = $("#tblDataPengkhususan").DataTable({
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
                                "url": "Pendaftaran_WS.asmx/LoadList_Khusus",
                                "method": 'POST',
                                "contentType": "application/json; charset=utf-8",
                                "dataType": "json",
                                "dataSrc": function (json) {
                                    return JSON.parse(json.d);
                                },
                                "data": function () {

                                    return JSON.stringify({
                                        kodKat: selectedKatCIDB,

                                    })
                                    //akhir sini
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
                                { "data": "KodKhusus" },
                                { "data": "Butiran" },
                                {
                                    className: "btnEdit",
                                    "data": "KodKhusus", // Confirmation id
                                    render: function (data, type, row, meta) {
                                        if (type !== "display") {
                                            return data;
                                        }

                                        var link = `<input type="checkbox" class="form-check-input KhususSelector" style="align:center;" data-id="${data}" name="chckKhusus">`;

                                        return link;

                                    },

                                }

                            ]
                        });
                    } else {
                        alert("Sub Bidang Tidak Dipilih")
                    }
                }
            });
        });

        $(document).ready(function () {
            /* show_loader();*/
            tblListKat = $("#tblDataListKat").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_Pengkhusus",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: '<%=Session("ssusrID")%>',
                        })
                        //akhir sini
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
                    { "data": "ID_Daftar" },
                    { "data": "KodGred" },
                    { "data": "Kod_Khusus" },
                    { "data": "ButiranKhusus" },
                    {
                        className: "btnEdit",
                        "data": "Kod_Khusus", //Confirmation id
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = ` <button id="btnDeleteKhusus" runat="server" class="btn btnDeleteKhusus" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        var selectedKatCIDBIds = []; // Array to store selected IDs

        $(document).on('change', '.KhususSelector', function () {
            var id = $(this).data('id');
            if (this.checked) {
                selectedKatCIDBIds.push(id);

            } else {
                var index = selectedKatCIDBIds.indexOf(id);
                if (index !== -1) {
                    selectedKatCIDBIds.splice(index, 1);
                }
            }
            // Convert the array to a comma-separated string
            var selectedKhususIdsString = selectedKatCIDBIds.join(',');

            var Kod_Khusus = selectedKhususIdsString.split(",");

            $('#selectedKhususIdsInput').val(Kod_Khusus);

            console.log(Kod_Khusus);
        });

        $('.lbtnSimpanKhusus').click(async function () {
            if ($('#ddlGredKerja').val() == "" || $('#ddlKategori').val() == "" || $('#selectedKhususIdsInput').val() == "") {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila pilih sekurang-kurangya satu pengkhususan");
            } else {
                // simpan data ke dalam data table or database
                $('#confirmationModal').modal('toggle');
                $('.btnYaKhusus').show();
                $('.btnYaPicMOF').hide();
                $('.btnYa').hide();
                $('.btnYaBidang').hide();
                $('.btnYaBumi').hide();
                $('.btnYaPicCidb').hide();

                //var valueBidang = $('#selectedKhususIdsInput').val();
                //alert(valueBidang);
            }
        });

        $('.btnYaKhusus').click(async function () {
            $('#confirmationModal').modal('toggle');

            let selectedKhususIdsString = $("#selectedKhususIdsInput").val();

            let KodKhusus = selectedKhususIdsString.split(',');

            let newKhususArray = KodKhusus.map(function (value) {
                return {
                    NoDaftar: $('#noDaftar').val(),
                    Bil: "",
                    KodKategori: $('#ddlKategori').val(),
                    KodKhusus: value,
                    KodGred: $('#ddlGredKerja').val()
                };
            });

            console.log("Mklmt Khusus: ", newKhususArray);

            var result = JSON.parse(await ajaxSaveKatCIDB(newKhususArray));
            if (result.Status !== "Failed") {
                if (result.Status !== "Failed") {
                    selectedKatCIDBIds = [];
                    debugger;
                    $("#selectedKhususIdsInput").val("");
                    tblKhusus.rows().nodes().to$().find('.btnEdit .KhususSelector').prop('checked', false);
                    newKhususArray.splice(0, newKhususArray.length);
                    tblListKat.ajax.reload();
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html(result.Message);
                    /*clearAllFields();*/
                } else {
                    tblKhusus.rows().nodes().to$().find('.btnEdit .KhususSelector').prop('checked', false);
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html(result.Message);
                }
            }
        });

        async function ajaxSaveKatCIDB(newKhusus) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SavekatCIDB',
                    method: 'POST',
                    data: JSON.stringify({ KhususList: newKhusus }),
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

        $(document).ready(function () {
            // alert("test")
            $('#ddlGredKerja').dropdown({
                selectOnKeyDown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'Pendaftaran_WS.asmx/GetGredKerja?q={query}',
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

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        /*if (shouldPop === true)*/ {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });
        });

        $(document).ready(async function () {
            // alert("test")
            $('#ddlJenDaftar').dropdown({
                selectOnKeyDown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'Pendaftaran_WS.asmx/GetJenDaftar?q={query}',
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

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        /*if (shouldPop === true)*/ {
                            $(obj).dropdown('show');
                        }

                    }
                }
            });
        });

        $('.btnSimpanPegCIDB').click(async function () {
            if ($('#gelPegCIDB').val() == "" || $('#namaPegCIDB').val() == "" || $('#icPegCIDB').val() == "" || $('#jwtPegCIDB').val() == "" || $('#noTelPegCIDB').val() == "") {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila isi semua ruangan yang diperlukan");
            } else {
                // open modal confirmation
                $('#confirmationModal').modal('toggle');
                $('.btnYaKhusus').hide();
                $('.btnYaPicMOF').hide();
                $('.btnYa').hide();
                $('.btnYaBidang').hide();
                $('.btnYaBumi').hide();
                $('.btnYaPicCidb').show();
            }
        });

        $('.btnYaPicCidb').click(async function () {
            $('#confirmationModal').modal('toggle');

            var newMklmtPegCidb = {
                mklmtPicCIDB: {
                    IdSya:'<%=Session("ssusrID")%>',
                    Gelaran: $('#gelPegCIDB').val(),
                    NamaPeg: $('#namaPegCIDB').val(),
                    NoICPeg: $('#icPegCIDB').val(),
                    Jawatan: $('#jwtPegCIDB').val(),
                    NoTelPeg: $('#noTelPegCIDB').val(),
                    IdRujukan: $('#noDaftar').val()
                }
            }

            console.log(newMklmtPegCidb);
            var result = JSON.parse(await ajaxSavePegCidb(newMklmtPegCidb));

            if (result.Status !== "Failed") {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
                tblPicCIDB.ajax.reload();
                clearAllFieldsPicCidb();
            } else {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
            }
        });

        async function clearAllFieldsPicCidb() {
            $('#gelPegCIDB').val("");
            $('#namaPegCIDB').val("");
            $('#icPegCIDB').val("");
            $('#jwtPegCIDB').val("");
            $('#noTelPegCIDB').val("");
        }

        $('#tblDataPegCIDB').on('click', '.btnEditPicCidb', async function (event) {
            event.stopPropagation();
            var idRujukan = $(this).attr("data-id");

            $('.btnBatalPicCidb').show()

            clearAllFieldsPicCidb();
            //Load And Set data in the form
            LoadDataPicCidbById(idRujukan);
            console.log(idRujukan);
        });

        async function LoadDataPicCidbById(IdRujukan) {

            var IdSya = '<%=Session("ssusrID")%>';
            if (IdRujukan !== "") {
                var RecordPicCidb = await AjaxGetRecordPicCidb(IdRujukan, IdSya);

                if (RecordPicCidb.length === 0) {
                    $('.btnBatalPicCidb').hide();
                    return false;
                } else {
                    await setValue_PicCidb(RecordPicCidb);
                    $('.btnBatalPicCidb').show();
                }
            } else {
                return false;
            }
        }

        async function setValue_PicCidb(RecordPicCidb) {
            $('#gelPegCIDB').val(RecordPicCidb[0].Kod_Gelaran);
            $('#namaPegCIDB').val(RecordPicCidb[0].Nama);
            $('#icPegCIDB').val(RecordPicCidb[0].No_Kad_Pengenalan);
            $('#jwtPegCIDB').val(RecordPicCidb[0].Jawatan);
            $('#noTelPegCIDB').val(RecordPicCidb[0].Tel_Bimbit);
        }

        async function AjaxGetRecordPicCidb(IdRujukan, IdSya) {
            try {

                const response = await fetch('Pendaftaran_WS.asmx/LoadData_PicCidb', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        IdRujukan: IdRujukan,
                        IdSya: IdSya
                    })
                });
                const data = await response.json();
                console.log("data Load Daftar Sijil Ajax: ", data);
                //if (data.length > 0) {

                //}
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        async function ajaxSavePegCidb(newMklmtPegCidb) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SavePicSijilCIDB',
                    method: 'POST',
                    data: JSON.stringify(newMklmtPegCidb),
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

        $('.btnBatalPicCidb').click(async function () {
            clearAllFieldsPicCidb()
            $('.btnBatalPicCidb').hide();
        });

        $('#tblDataPegCIDB').on('click', '.btnDeletePicCidb', async function (event) {

            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var IdRujukan = $(this).data("id");
            var IdSya = '<%=Session("ssusrID")%>';

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').hide();
            $('.btnYaDeleteMOF').hide();
            $('.btnYaDeleteCIDB').hide();
            $('.btnYaDeleteLain').hide();
            $('.btnYaDeleteBidang').hide();
            $('.btnYaDeletePicMOF').hide();
            $('.btnYaDeleteBumi').hide();
            $('.btnYaDeleteKhusus').hide();
            $('.btnYaDeletePicCidb').show();

            $('.btnYaDeletePicCidb').click(async function () {
                if (IdRujukan !== "") {
                    bool = await DelPicCidb(IdRujukan, IdSya);
                }

                if (bool === true) {
                    $('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                }

                tblPicCIDB.ajax.reload();

                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                return false;
            });

        });

        async function DelPicCidb(IdRujukan, IdSya) {
            var bool = false;
            var result = JSON.parse(await AjaxDeletePicCidb(IdRujukan, IdSya));

            if (result.Code === "00") {
                bool = true;
            }
            return bool;
        }

        async function AjaxDeletePicCidb(IdRujukan, IdSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Pendaftaran_WS.asmx/DeleteRecordPicCidb',
                    method: 'POST',
                    data: JSON.stringify({
                        IdRujukan: IdRujukan,
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

        function uploadFileSSM() {

            var fileInputId = "fileInputSSM";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/SSM/";
            var hidJenDokId = "hidJenDokSSM";
            var hidFileNameId = "hidFileNameSSM";
            var progressContainerId = "progressContainerSSM";
            var uploadedFileNameLabelId = "uploadedFileNameLabelSSM";
            var wsMethod = "Pendaftaran_WS.asmx/UploadFileSijilSSM";
            var idDokSSM = idDokSSM;
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod);

            return result;
        }

        function uploadFileMOF() {

            var fileInputId = "fileInputMOF";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/MOF/";
            var hidJenDokId = "hidJenDokMOF";
            var hidFileNameId = "hidFileNameMOF";
            var progressContainerId = "progressContainerMOF";
            var uploadedFileNameLabelId = "uploadedFileNameLabelMOF";
            var wsMethod = "Pendaftaran_WS.asmx/UploadFileSijilMOF";
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod);

            return result;
        }

        function uploadFileCIDB() {

            var fileInputId = "fileInputCIDB";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/CIDB/";
            var hidJenDokId = "hidJenDokCIDB";
            var hidFileNameId = "hidFileNameCIDB";
            var progressContainerId = "progressContainerCIDB";
            var uploadedFileNameLabelId = "uploadedFileNameLabelCIDB";
            var wsMethod = "Pendaftaran_WS.asmx/UploadFileSijilCIDB";
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod);

            return result;
        }

        function uploadFileLain() {

            var fileInputId = "fileInputLain";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/LAIN/";
            var hidJenDokId = "hidJenDokLain";
            var hidFileNameId = "hidFileNameLain";
            var progressContainerId = "progressContainerLain";
            var uploadedFileNameLabelId = "uploadedFileNameLabelLain";
            var wsMethod = "Pendaftaran_WS.asmx/UploadFileSijilLain";
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod);

            return result;
        }

        function uploadFileBumi() {

            var fileInputId = "fileInputSijilBumi";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/BUMI/";
            var hidJenDokId = "hidJenDokBumi";
            var hidFileNameId = "hidFileNameBumi";
            var progressContainerId = "progressContainer";
            var uploadedFileNameLabelId = "uploadedFileNameLabel";
            var wsMethod = "Pendaftaran_WS.asmx/UploadFileSijilBumi";
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod);

            return result;
        }


        function uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod) {
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
                var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (3MB)

                if (fileSize <= maxSize) {
                    // File size is within the allowed limit
                    var fileName = file.name;
                    var fileExtension = fileName.split('.').pop().toLowerCase();

                    // Check if the file extension is PDF or Excel
                    if (['pdf', 'xlsx', 'xls'].includes(fileExtension)) {
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
                            frmData.append("kodDaftar", $('#KodDaftar').html());

                            console.log("frmData: ", frmData);

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
                                    // Show the uploaded file name on the screen
                                    //var fileLink = document.createElement("a");
                                    //fileLink.href = requestData.resolvedUrl + fileName;
                                    //fileLink.textContent = fileName;

                                    //var uploadedFileNameLabel = document.getElementById(uploadedFileNameLabelId);
                                    //uploadedFileNameLabel.appendChild(fileLink);

                                    /* fileLinkToLocal(requestData.resolvedUrl + fileName);*/

                                    /*$(`#${uploadedFileNameLabelId}`).show();*/
                                    // Clear the file input
                                    /*$(`#${fileInputId}`).val("");*/
                                    /* $(`#${progressContainerId}`).text("File uploaded successfully.");*/
                                    /*displayFileLink(fileName);*/
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
                        /*displayMaklumanModal("Only PDF and Excel files are allowed.");*/
                        result.message = "Only PDF and Excel files are allowed.";

                    }
                } else {
                    // File size exceeds the allowed limit
                    /*displayMaklumanModal("File size exceeds the maximum limit of 3MB");*/
                    result.message = "File size exceeds the maximum limit of 5MB";

                }
            } else {
                // No file selected
                /*displayMaklumanModal("Please select a file to upload");*/
                result.message = "Please select a file to upload"

            }

            return result;
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
                /*lampiranProfilSya.appendChild(fileLink);*/

                $("LampiranProfilSya").html(lampiranProfilSya);
            }
        }

        // Action btnRekodBaru
        $('.btnRekodBaru').click(async function () {
            clearAllFieldsDaftar();
            enableAllFieldsDaftar();
            $('.btnRekodBaru').hide();
            $('.btnDaftarSijilBatal').show();
            $('#IdDaftar').html("");
        });// last Action btnRekodBaru

        /* btnBatal Rekod Baru Sijil ACTION*/
        $('.btnDaftarSijilBatal').click(async function () {
            LoadDataDaftar(activeTab);
            disableAllFieldsDaftar();
            $('.btnbtnDaftarSijilBatal').hide();
            $('.btnRekodBaru').show();
        }); // last btnBatalSijil Action

        $('.btnDaftarSijilLainBatal').click(async function () {
            clearAllFieldsSijilLain();
            $('.btnDaftarSijilLainBatal').hide();
        });

        //Simpan Sijil With Input validation
        $('.btnSimpanSSM').click(async function () {

            var form = $(this).closest('form');
            var fileInputs = {
                "#ssm": form.find('#fileInputSSM').val(),
                "#mof": form.find('#fileInputMOF').val(),
                "#cidb": form.find('#fileInputCIDB').val(),
                "#lainLain": form.find('#fileInputLain').val()
            };

            var confirmationRequired = true;

            if (form.find('#noDaftar').val() == "" || form.find('#tkhMulaKuasa').val() == "" || form.find('#tkhTamatKuasa').val() == "" || form.find('#ddlJenDaftar').val() == "") {
                for (var tabId in fileInputs) {
                    if (activeTab === tabId && fileInputs[tabId] === "") {
                        errorMessage = "Sila Isi Semua Maklumat Sijil " + tabId.substring(1).toUpperCase();
                        confirmationRequired = false;
                        console.log(fileInputs[tabId]);
                        break;
                    }
                }
            } else {
                if (fileInputs[activeTab] == "") {
                    errorMessage = "Sila Upload Maklumat Sijil " + activeTab.substring(1).toUpperCase();
                    confirmationRequired = false;
                }
            }

            if (confirmationRequired) {
                $('#confirmationModal').modal('toggle');
                $('.btnYaKhusus').hide();
                $('.btnYaPicMOF').hide();
                $('.btnYa').show();
                $('.btnYaBidang').hide();
                $('.btnYaBumi').hide();
                $('.btnYaPicCidb').hide();
            } else {
                displayMaklumanModal(errorMessage);
            }

        }); // last Simpan and input validation

        $('.btnYa').click(async function () {
            $('#confirmationModal').modal('toggle');

            var form = $(this).closest('form');

            var fileNameSSM = await getFileName(form.find('#fileInputSSM'));
            var fileExtentionSSM = await getFileExtension(form.find('#fileInputSSM'));
            var fileNameMOF = await getFileName(form.find('#fileInputMOF'));
            var fileExtensionMOF = await getFileExtension(form.find('#fileInputMOF'));
            var fileNameCIDB = await getFileName(form.find('#fileInputCIDB'));
            var fileExtensionCIDB = await getFileExtension(form.find('#fileInputCIDB'));
            var fileNameLain = await getFileName(form.find('#fileInputLain'));
            var fileExtensionLain = await getFileExtension(form.find('#fileInputLain'));

            var fileInputs = {
                "#ssm": {
                    name: fileNameSSM,
                    extension: fileExtentionSSM,
                    path: '~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/SSM/'
                },
                "#mof": {
                    name: fileNameMOF,
                    extension: fileExtensionMOF,
                    path: '~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/MOF/'
                },
                "#cidb": {
                    name: fileNameCIDB,
                    extension: fileExtensionCIDB,
                    path: '~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/CIDB/'
                },
                "#lainLain": {
                    name: fileNameLain,
                    extension: fileExtensionLain,
                    path: '~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/Lain/'
                }
            };

            console.log("fileInputs: ", fileInputs);

            var fileData = fileInputs[activeTab];
            //console.log("fileInputs faile Data: ", fileData.name);

            var ListFile = [{
                IdSya: '<%=Session("ssusrID")%>',
                NoRujukan: '',
                JenDok: $('#KodDaftar').html(),
                FileName: fileData.name,
                Bil: '',
                FilePath: fileData.path,
                JenFile: fileData.extension,
            }];

            var newMklmtSijil = {
                mklmtSijil: {
                    IdDaftar: $('#IdDaftar').html(),
                    IdSya: '<%=Session("ssusrID")%>',
                    KodDaftar: $('#KodDaftar').html(),
                    NoDaftar: $('#noDaftar').val(),
                    TkhMula: $('#tkhMulaKuasa').val(),
                    TkhTamat: $('#tkhTamatKuasa').val(),
                    ListFile: ListFile
                }
            }

            console.log(newMklmtSijil);
            var result = JSON.parse(await ajaxSaveMklmtSijil(newMklmtSijil));

            if (result.Status !== "Failed") {

                try {
                    var messageFile;

                    switch (activeTab) {
                        case "#ssm":
                            messageFile = uploadFileSSM();
                            break;
                        case "#mof":
                            messageFile = uploadFileMOF();
                            break;
                        case "#cidb":
                            messageFile = uploadFileCIDB();
                            break;
                        case "#lainLain":
                            messageFile = uploadFileLain();
                            break;
                        default:
                            displayMaklumanModal("Invalid active tab");
                            return;
                    }

                    console.log("Value MessageFile: ", messageFile);

                    if (messageFile.message !== "OK") {
                        displayMaklumanModal(messageFile);
                        return;
                    }
                } catch (error) {
                    console.error("Error during file upload:", error);
                    displayMaklumanModal("Gagal Memuatnaik Fail" + activeTab.substring(1).toUpperCase());
                    return;
                }

                if (activeTab === "#ssm") {
                    disableAllFieldsDaftar(activeTab);
                    tblMklmtSSM.ajax.reload();
                } else if (activeTab === "#mof") {
                    disableAllFieldsDaftar(activeTab);
                    tblMklmtMOF.ajax.reload();
                } else if (activeTab === "#cidb") {
                    disableAllFieldsDaftar(activeTab);
                    tblMklmtCIDB.ajax.reload();
                } else if (activeTab === "#lainLain") {
                    //disableAllFieldsDaftar(activeTab);
                    $('.btnDaftarSijilLainBatal').hide();
                    clearAllFieldsSijilLain();
                    tblMklmtLain.ajax.reload();
                } else {
                    return false;
                }
                tblMklmtBumi.ajax.reload();

                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);

            } else {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
            }
        });

        async function ajaxSaveMklmtSijil(newMklmtSijil) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SaveMklmtSijil',
                    method: 'POST',
                    data: JSON.stringify(newMklmtSijil),
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
        } // Last Save Maklumat Sijil

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

        $('#tblDataMklmtSSM').on('click', '.btnEditSSM', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).attr("data-id");

            $('.btnRekodBaru').hide();
            $('.btnDaftarSijilBatal').show()

            enableAllFieldsDaftar();
            clearAllFieldsDaftar();
            //Load And Set data in the form
            LoadDataDaftarById(idDaftar);
            console.log(idDaftar);
        });

        $('#tblDataMklmtMOF').on('click', '.btnEditMOF', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).attr("data-id");

            $('.btnRekodBaru').hide();
            $('.btnDaftarSijilBatal').show()

            enableAllFieldsDaftar();
            clearAllFieldsDaftar();
            //Load And Set data in the form
            LoadDataDaftarById(idDaftar);
            console.log(idDaftar);
        });

        $('#tblDataMklmtCIDB').on('click', '.btnEditCIDB', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).attr("data-id");

            $('.btnRekodBaru').hide();
            $('.btnDaftarSijilBatal').show()

            enableAllFieldsDaftar();
            clearAllFieldsDaftar();
            //Load And Set data in the form
            LoadDataDaftarById(idDaftar);
            console.log(idDaftar);
        });

        $('#tblDataMklmtLain').on('click', '.btnEditLain', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).attr("data-id");

            $('.btnRekodBaru').hide();
            $('.btnDaftarSijilBatal').hide()

            enableAllFieldsDaftar();
            clearAllFieldsDaftar();
            //Load And Set data in the form
            LoadDataDaftarById(idDaftar);
            console.log(idDaftar);
        });

        $('#tblDataMklmtBumi').on('click', '.btnEditBumi', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).attr("data-id");

            //$('.btnRekodBaru').hide();
            clearAllFieldsBumi();
            $('.btnBatalBumi').show()

            //enableAllFields();
            //clearAllFieldsDaftar();
            //Load And Set data in the form
            LoadDataBumiById(idDaftar);
        });

        //Delete Mklmt Sijil SSM
        $('#tblDataMklmtSSM').on('click', '.btnDeleteSSM', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).data("id");

            var curTR = $(this).closest("tr");
            var bool = true;

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').show();
            $('.btnYaDeleteMOF').hide();
            $('.btnYaDeleteCIDB').hide();
            $('.btnYaDeleteLain').hide();
            $('.btnYaDeleteBidang').hide();
            $('.btnYaDeletePicMOF').hide();
            $('.btnYaDeleteBumi').hide();
            $('.btnYaDeleteKhusus').hide();
            $('.btnYaDeletePicCidb').hide();

            $('.btnYaDeleteSSM').click(async function () {
                if (idDaftar !== "") {
                    bool = await DelMklmtSijil(idDaftar);
                }

                if (bool === true) {
                    $('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                }

                clearAllFieldsDaftar();
                enableAllFieldsDaftar();
                tblMklmtSSM.ajax.reload();
                $('#btnRekodBaru').hide();

                $('#confirmationModalDelete').modal('toggle');
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                return false;
            });
        });

        $('#tblDataMklmtMOF').on('click', '.btnDeleteMOF', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).data("id");

            var curTR = $(this).closest("tr");
            var bool = true;

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').hide();
            $('.btnYaDeleteMOF').show();
            $('.btnYaDeleteCIDB').hide();
            $('.btnYaDeleteLain').hide();
            $('.btnYaDeleteBidang').hide();
            $('.btnYaDeletePicMOF').hide();
            $('.btnYaDeleteBumi').hide();
            $('.btnYaDeleteKhusus').hide();
            $('.btnYaDeletePicCidb').hide();

            $('.btnYaDeleteMOF').click(async function () {
                if (idDaftar !== "") {
                    bool = await DelMklmtSijil(idDaftar);
                }

                if (bool === true) {
                    $('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                }

                clearAllFieldsDaftar();
                enableAllFieldsDaftar();
                tblMklmtMOF.ajax.reload();
                $('#btnRekodBaru').hide();

                $('#confirmationModalDelete').modal('toggle');
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                return false;

            });
        });

        $('#tblDataMklmtCIDB').on('click', '.btnDeleteCIDB', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).data("id");

            var curTR = $(this).closest("tr");
            var bool = true;

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').hide();
            $('.btnYaDeleteMOF').hide();
            $('.btnYaDeleteCIDB').show();
            $('.btnYaDeleteLain').hide();
            $('.btnYaDeleteBidang').hide();
            $('.btnYaDeletePicMOF').hide();
            $('.btnYaDeleteBumi').hide();
            $('.btnYaDeleteKhusus').hide();
            $('.btnYaDeletePicCidb').hide();

            $('.btnYaDeleteCIDB').click(async function () {
                if (idDaftar !== "") {
                    bool = await DelMklmtSijil(idDaftar);
                }

                if (bool === true) {
                    $('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                }

                clearAllFieldsDaftar();
                enableAllFieldsDaftar();
                tblMklmtCIDB.ajax.reload();
                $('#btnRekodBaru').hide();

                $('#confirmationModalDelete').modal('toggle');
                LoadDataDaftarById(idDaftar);
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                return false;
            });
        });

        $('#tblDataMklmtLain').on('click', '.btnDeleteLain', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).data("id");

            var curTR = $(this).closest("tr");
            var bool = true;

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').hide();
            $('.btnYaDeleteMOF').hide();
            $('.btnYaDeleteCIDB').hide();
            $('.btnYaDeleteLain').show();
            $('.btnYaDeleteBidang').hide();
            $('.btnYaDeletePicMOF').hide();
            $('.btnYaDeleteBumi').hide();
            $('.btnYaDeleteKhusus').hide();
            $('.btnYaDeletePicCidb').hide();

            $('.btnYaDeleteLain').click(async function () {
                debugger;
                if (idDaftar !== "") {
                    bool = await DelMklmtSijil(idDaftar);
                }

                if (bool === true) {
                    //$('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                }

                clearAllFieldsDaftar();
                enableAllFieldsDaftar();
                tblMklmtLain.ajax.reload();
                $('#btnRekodBaru').hide();

                $('#confirmationModalDelete').modal('toggle');
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                return false;
            });
        });

        $('#tblDataMklmtBumi').on('click', '.btnDeleteBumi', async function (event) {
            event.stopPropagation();
            var idDaftar = $(this).data("id");

            var curTR = $(this).closest("tr");
            var bool = true;

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').hide();
            $('.btnYaDeleteMOF').hide();
            $('.btnYaDeleteCIDB').hide();
            $('.btnYaDeleteLain').hide();
            $('.btnYaDeleteBidang').hide();
            $('.btnYaDeletePicMOF').hide();
            $('.btnYaDeleteBumi').show();
            $('.btnYaDeleteKhusus').hide();
            $('.btnYaDeletePicCidb').hide();

            $('.btnYaDeleteBumi').click(async function () {
                if (idDaftar !== "") {
                    bool = await DelMklmtSijil(idDaftar);
                }

                if (bool === true) {
                    $('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                }

                clearAllFieldsDaftar();
                enableAllFieldsDaftar();
                tblMklmtBumi.ajax.reload();
                $('#btnRekodBaru').hide();

                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                return false;
            });
        });

        async function DelMklmtSijil(idDaftar) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteMklmtSijil(idDaftar));

            if (result.Code === "00") {
                bool = true;
            }
            return bool;
        }

        async function AjaxDeleteMklmtSijil(idDaftar) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Pendaftaran_WS.asmx/DeleteRecordDaftar',
                    method: 'POST',
                    data: JSON.stringify({ idDaftar: idDaftar }),
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

        //Delete Mklmt Sijil MOF
        //$('#tblDataMklmtMOF').on('click', '.btnDeleteMOF', async function (event) {
        //    event.stopPropagation();
        //    var idDaftar = $(this).data("id");

        //    var curTR = $(this).closest("tr");
        //    var bool = true;

        //    if (idDaftar !== "") {
        //        bool = await DelMklmtSijil(idDaftar);
        //    }

        //    if (bool === true) {
        //        curTR.remove();
        //    }

        //    clearAllFieldsDaftar();
        //    enableAllFieldsDaftar();
        //    $('#btnRekodBaru').hide();
        //    tblMklmtMOF.ajax.reload();

        //    $('#maklumanModal').modal('toggle');
        //    $('#detailMakluman').html("Maklumat Berjaya Dipadam");

        //    return false;
        //});

        ////Delete Mklmt Sijil CIDB
        //$('#tblDataMklmtCIDB').on('click', '.btnDeleteCIDB', async function (event) {
        //    event.stopPropagation();
        //    var idDaftar = $(this).data("id");

        //    var curTR = $(this).closest("tr");
        //    var bool = true;

        //    if (idDaftar !== "") {
        //        bool = await DelMklmtSijil(idDaftar);
        //    }

        //    if (bool === true) {
        //        curTR.remove();
        //    }

        //    clearAllFieldsDaftar();
        //    enableAllFieldsDaftar();
        //    $('#btnRekodBaru').hide();
        //    tblMklmtCIDB.ajax.reload();

        //    $('#maklumanModal').modal('toggle');
        //    $('#detailMakluman').html("Maklumat Berjaya Dipadam");

        //    return false;
        //});

        ////Delete Mklmt Sijil lain
        //$('#tblDataMklmtLain').on('click', '.btnDeleteLain', async function (event) {
        //    event.stopPropagation();
        //    var idDaftar = $(this).data("id");

        //    var curTR = $(this).closest("tr");
        //    var bool = true;

        //    if (idDaftar !== "") {
        //        bool = await DelMklmtSijil(idDaftar);
        //    }

        //    if (bool === true) {
        //        curTR.remove();
        //    }

        //    clearAllFieldsDaftar();
        //    enableAllFieldsDaftar();
        //    $('#btnRekodBaru').hide();
        //    tblMklmtLain.ajax.reload();

        //    $('#maklumanModal').modal('toggle');
        //    $('#detailMakluman').html("Maklumat Berjaya Dipadam");

        //    return false;
        //});

        //// Delete Mkllmt Sijil Bumi
        //$('#tblDataMklmtBumi').on('click', '.btnDeleteBumi', async function (event) {
        //    event.stopPropagation();
        //    var idDaftar = $(this).data("id");

        //    var curTR = $(this).closest("tr");
        //    var bool = true;

        //    if (idDaftar !== "") {
        //        bool = await DelMklmtSijil(idDaftar);
        //    }

        //    if (bool === true) {
        //        curTR.remove();
        //    }

        //    clearAllFieldsDaftar();
        //    enableAllFieldsDaftar();
        //    $('#btnRekodBaru').hide();
        //    tblMklmtBumi.ajax.reload();

        //    $('#maklumanModal').modal('toggle');
        //    $('#detailMakluman').html("Maklumat Berjaya Dipadam");

        //    return false;
        //});

        // Delete List Bidang
        $('#tblDataListBidang').on('click', '.btnDeleteBidang', async function (event) {

            event.stopPropagation();
            let curTR = $(this).closest("tr");
            let bool = true;
            let kodBidang1 = $(this).data("id");
            let noDaftar = $('#noDaftar').val();

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').hide();
            $('.btnYaDeleteMOF').hide();
            $('.btnYaDeleteCIDB').hide();
            $('.btnYaDeleteLain').hide();
            $('.btnYaDeleteBidang').show();
            $('.btnYaDeletePicMOF').hide();
            $('.btnYaDeleteBumi').hide();
            $('.btnYaDeleteKhusus').hide();
            $('.btnYaDeletePicCidb').hide();

            // Remove previous click event handler
            $('.btnYaDeleteBidang').off('click');

            $('.btnYaDeleteBidang').click(async function () {
                $('#confirmationModalDelete').modal("toggle");

                if (kodBidang1 !== "") {
                    console.log("KodBidang1: ", kodBidang1);
                    bool = await DelBidang(kodBidang1, noDaftar);
                } else {
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html("Kod Bidang Tidak Sah");
                }

                if (bool === true) {
                    //$('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                } else {
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html("Bidang Gagal Dipadam");
                }

                //$('#confirmationModalDelete').modal('toggle');
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                tblListBidang.ajax.reload();
            });
        });

        async function DelBidang(kodBidang, noDaftar) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteBidang(kodBidang, noDaftar));

            if (result.Code === "00") {
                bool = true;
            }
            return bool;
        }

        async function AjaxDeleteBidang(kodBidang, noDaftar) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Pendaftaran_WS.asmx/DeleteRecordBidang',
                    method: 'POST',
                    data: JSON.stringify({
                        KodBidang: kodBidang,
                        NoDaftar: noDaftar
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
        // last delete bidang

        //Delete List Khusus
        $('#tblDataListKat').on('click', '.btnDeleteKhusus', async function (event) {

            event.stopPropagation();
            let curTR = $(this).closest("tr");
            let bool = true;
            let KodKhusus1 = $(this).data("id");
            let noDaftar = $('#noDaftar').val();

            $('#confirmationModalDelete').modal('toggle');
            $('.btnYaDeleteSSM').hide();
            $('.btnYaDeleteMOF').hide();
            $('.btnYaDeleteCIDB').hide();
            $('.btnYaDeleteLain').hide();
            $('.btnYaDeleteBidang').hide();
            $('.btnYaDeletePicMOF').hide();
            $('.btnYaDeleteBumi').hide();
            $('.btnYaDeleteKhusus').show();
            $('.btnYaDeletePicCidb').hide();

            $('.btnYaDeleteKhusus').off('click');

            $('.btnYaDeleteKhusus').click(async function () {
                $('#confirmationModalDelete').modal("toggle");

                debugger;

                if (KodKhusus1 !== "") {
                    bool = await DelKhusus(KodKhusus1, noDaftar);
                } else {
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html("Kod Penkhususan Tidak Sah");
                }

                if (bool === true) {
                    //$('#confirmationModalDelete').modal('toggle');
                    curTR.remove();
                } else {
                    $('#maklumanModal').modal('toggle');
                    $('#detailMakluman').html("Pengkhususan Gagal Dipadam");
                }

                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                tblListKat.ajax.reload();
            });

        });

        async function DelKhusus(KodKhusus, noDaftar) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteKhusus(KodKhusus, noDaftar));
            console.log(result);
            if (result.Code === "00") {
                bool = true;
            }
            return bool;
        }

        async function AjaxDeleteKhusus(KodKhusus, noDaftar) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Pendaftaran_WS.asmx/DeleteRecordKhusus',
                    method: 'POST',
                    data: JSON.stringify({
                        kodKhusus: KodKhusus,
                        noDaftar: noDaftar
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
        //Last Delete List Khusus

        // Function Display Makluman Modal
        function displayMaklumanModal(message) {
            $('#maklumanModal').modal('toggle');
            $('#detailMakluman').html(message);
        }
        // Last Function Display Makluman Modal

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

