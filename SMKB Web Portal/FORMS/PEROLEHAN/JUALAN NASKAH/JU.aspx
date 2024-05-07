<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="JU.aspx.vb" Inherits="SMKB_Web_Portal.JU" %>


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
    </style>

    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Jualan Naskah Sebut Harga / Tender Universiti</h5>

                    </div>

                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Status :</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <select id="categoryFilter" class="custom-select">
                                            <option value="" selected="-SILA PILIH-">-SILA PILIH-</option>
                                            <option value="1">KESELURUHAN</option>
                                            <option value="2">LULUS PERMOHONAN PEMBELIAN</option>
                                            <option value="3">DFTAR JUALAN NASKAH</option>
                                            <option value="4">PROSES JUALN NASKAH</option>
                                            <option value="5">TERIMAAN DOKUMENN</option>
                                            <option value="6">BATAL JUALAN NASKAH</option>
                                        </select>
                                        <div class="input-group-append">
                                            <button id="btnSearchDT" runat="server" class="btn btn-outline btnSearchDT" type="button">
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

                    <div class=" -body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataNaskah_Jualan" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">No Perolehan</th>
                                            <th scope="col">Tujuan</th>
                                            <th scope="col">Kategori</th>
                                            <th scope="col">No Naskah Jualan</th>
                                            <th scope="col">Tarikh & Masa Mula Iklan</th>
                                            <th scope="col">Tarikh & Masa Tamat Perolehan</th>
                                            <th scope="col">Status</th>
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

        <!-- Modal -->

        <div class="modal fade" id="transaksi" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">Maklumat Jualan Naskah</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">


                        <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">

                            <li class="nav-item px-2 nav-show" style="display: none;" role="presentation">
                                <button class="nav-link active" id="maklumatPO-tab" data-toggle="tab" data-target="#perolehan" type="button" role="tab">Maklumat Iklan</button>
                            </li>
                            <li class="nav-item px-2 nav-show" style="display: none;" role="presentation">
                                <button class="nav-link btnSearchAm" id="spesifikasiAm-tab" data-toggle="tab" data-target="#spesifikasi-am" type="button" role="tab">Maklumat Lesen</button>
                            </li>
                            <li class="nav-item px-2" role="presentation">
                                <button class="nav-link" id="bajet-tab" data-toggle="tab" data-target="#bajet-dan-spesifikasi" type="button" role="tab">Pengesahan / Ringkasan</button>
                            </li>
                            <li class="nav-item px-2" role="presentation">
                        </ul>

                        <div class="tab-content" id="myTabContent">
                            <!-- tab 1 (Maklumat Perolehan) -->
                            <div class="tab-pane fade show active" id="perolehan" role="tabpanel">

                                <div class="">
                                    <div class="form-row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtNoNaskah_Jualan" type="text" placeholder="&nbsp;" name="No Permohonan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Permohonan">ID Naskah Jualan :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Mohon" type="text" placeholder="&nbsp;" name="Tarikh Mohon" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Tarikh Mohon">Tarikh Mohon:</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtStatus" type="text" placeholder="&nbsp;" name="Status" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Status">Status :</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtNo_Perolehan" type="text" placeholder="&nbsp;" name="No Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Perolehan">No Perolehan :	</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">

                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" id="txtTujuan" readonly style="background-color: #f0f0f0; height: auto" rows="3"></textarea>
                                                <label class="input-group__label" for="Tujuan">Tujuan :</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" id="txtSkop" readonly style="background-color: #f0f0f0; height: auto" rows="3"></textarea>
                                                <label class="input-group__label" for="Skop">Skop :</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtKategori_Perolehan" type="text" placeholder="&nbsp;" name="Kategori Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kategori Perolehan">Kategori Perolehan :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtKaedah_Perolehan" type="text" placeholder="&nbsp;" name="Kaedah Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kaedah Perolehan">Kaedah Perolehan :	</label>
                                            </div>

                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtPTJ_Mohon" type="text" placeholder="&nbsp;" name="Tarikh Keperluan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Tarikh Keperluan">PTJ Mohon:</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-6">
                                            <div class="child-container-checkbox" style="display: none; margin-left: 0px; margin-top: 0px;">
                                            <div class="form-row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <select class="input-group__select ui search dropdown JenTransaksi" name="txtVendo" id="txtVendo" placeholder="&nbsp;">
                                                        </select>
                                                        <label class="input-group__label" for="PanelJaw">Vendor  :</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                            <div class="form-group">
                                                <label class="ml-1" for="txtMasa_Tamat_Perolehan" style="color: #aaa;">Rundingan Terus :</label>
                                                <div class="custom-control custom-radio custom-control-inline mx-2">
                                                    <input class="form-check-input" type="checkbox" name="flexcheckbox" id="flexcheckbox">
                                                    <label class="form-check-label" for="flexcheckbox">Rundingan Terus</label>
                                                </div>
                                            </div>
                                            
                                        </div>
                                        <div class="col-md-6">
                                            <div id="CIDB_DIV" class="form-group">
                                                <select class="input-group__select ui search dropdown JenTransaksi" name="Gred CIDB" id="txtGred_CIDB" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Tarikh Keperluan">Gred CIDB :</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">

                                        <div class="col-md-5">

                                            <div class="form-group">
                                                <input class="input-group__input " id="txtHarga_Naska" type="number" placeholder="&nbsp;" name="Harga_Naska" style="background-color: white" />
                                                <label class="input-group__label" for="Pemohon">Harga Naskah :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtNo_SHT" type="text" placeholder="&nbsp;" name="PTJ" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="PTJ">No. Sebut Harga / Tendar :</label>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-row">

                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" id="txtTempat_Hantar" style="background-color: white; height: auto" rows="2"></textarea>
                                                <label class="input-group__label" for="Justifikasi Perolehan">Tempat Hantar :</label>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Mula_Iklan" type="date" min="" placeholder="&nbsp;" name="txtTarikh_Mula_Iklan" style="background-color: white" />
                                                <label class="input-group__label" for="txtTarikh_Mula_Iklan">Tarikh Mula Iklan :</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Mula_Perolehan" type="date" placeholder="&nbsp;" name="txtTarikh_Mula_Perolehan" style="background-color: white" />
                                                <label class="input-group__label" for="txtTarikh_Mula_Perolehan">Tarikh Mula Perolehan :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Tamat_Perolehan" type="date" placeholder="&nbsp;" name="txtTarikh_Tamat_Perolehan" style="background-color: white" />
                                                <label class="input-group__label" for="txtTarikh_Tamat_Perolehan">Tarikh Tamat Perolehan  :</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtMasa_Tamat_Perolehan" type="time" placeholder="&nbsp;" name="txtMasa_Tamat_Perolehan" style="background-color: white" />
                                                <label class="input-group__label" for="txtMasa_Tamat_Perolehan">Masa Tamat Perolehan  : </label>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="ml-1" for="txtMasa_Tamat_Perolehan" style="color: #aaa;">Lawatan Tapak :</label>
                                                <div class="custom-control custom-radio custom-control-inline mx-2">
                                                    <input class="form-check-input" type="radio" checked name="flexRadioDefault" id="flexRadioDefault1" value="Tidak">
                                                    <label class="form-check-label" for="flexRadioDefault1">
                                                        Tidak
                                                    </label>
                                                </div>
                                                <div class="custom-control custom-radio custom-control-inline mx-2">
                                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" value="Ye">
                                                    <label class="form-check-label" for="flexRadioDefault2">
                                                        Ya
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="child-container " style="display: none; margin-left: 15px; margin-top: -15px;">
                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <input class="input-group__input " id="txtTempat_Tapak" type="text" placeholder="&nbsp;" name="txtTempat_Tapak" style="background-color: white" />
                                                            <label class="input-group__label" for="txtTempat_Tapak">Tempat Tapak :</label>
                                                        </div>

                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <input class="input-group__input " id="txtTarikh_Lawatan" type="date" placeholder="&nbsp;" name="txtTarikh_Lawatan" style="background-color: white" />
                                                            <label class="input-group__label" for="txtTarikh_Lawatan">Tarikh Lawatan :</label>
                                                        </div>

                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <input class="input-group__input " id="txtMasa_Lawatan" type="time" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: white" />
                                                            <label class="input-group__label" for="txtMasa_Lawatan">Masa Lawatan:</label>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-row">

                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" id="txtUlasan" style="background-color: white; height: auto" rows="3"></textarea>
                                                <label class="input-group__label" for="Ulasan">Arahan dan Maklumat kepada Pembekal/ Kontraktor / Syarikat :</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col text-center m-3">
                                        <button type="button" id="btnSimpanIklan" class="btn btn-secondary " data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                                        <input hidden id="txtId_Pemohon" />
                                        <input hidden id="txtNo_PTj" />
                                    </div>
                                </div>


                            </div>
                            <!-- End of Maklumat Perolehan Tab -->


                            <!-- tab 2 (Maklumat Spesifikasi Am) -->
                            <div class="tab-pane fade" id="spesifikasi-am" role="tabpanel">

                                <div class="card card-body">
                                    <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Lesen Pendaftaran :</h6>
                                    <div class="form-row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <select class="input-group__select ui search dropdown JenTransaksi" name="KodPendaftaran" id="KodPendaftaran" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="PanelJaw">Kod Pendaftaran :</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" id="txtMaklumat_lanjut" style="background-color: white; height: auto" rows="3"></textarea>
                                                <label class="input-group__label" for="txtMaklumat_lanjut">Maklumat lanjut :</label>
                                            </div>
                                        </div>
                                        <div class="col text-center m-3">
                                            <button type="button" id="btnSimpanLesen" class="btn btn-secondary " data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                                            <%-- <input hidden id="txtId_Pemohon" />
                                                        <input hidden id="txtNo_PTj" />--%>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <div class="transaction-table table-responsive">
                                                <table id="tblDataSenarai_Lesen" class="table table-striped" style="width: 95%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Bil</th>
                                                            <th scope="col">Kod Pendaftaran</th>
                                                            <th scope="col">Lesen Pendaftaran</th>
                                                            <th scope="col">Maklumat lanjut</th>
                                                            <th scope="col"></th>
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
                            <!-- tab 2 (Maklumat Spesifikasi Am) -->


                            <!-- tab 3 (Maklumat Bajet dan Spesifikasi) -->
                            <div class="tab-pane fade" id="bajet-dan-spesifikasi" role="tabpanel">

                                <div class="">
                                    <div class="form-row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtNoNaskah_Jualan3" type="text" placeholder="&nbsp;" name="No Permohonan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Permohonan">ID Naskah Jualan :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Mohon3" type="text" placeholder="&nbsp;" name="Tarikh Mohon" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Tarikh Mohon">Tarikh Mohon:</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtStatus3" type="text" placeholder="&nbsp;" name="Status" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Status">Status :</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtNo_Perolehan3" type="text" placeholder="&nbsp;" name="No Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Perolehan">No Perolehan :	</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">

                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" id="txtTujuan3" readonly style="background-color: #f0f0f0; height: auto" rows="3"></textarea>
                                                <label class="input-group__label" for="Tujuan">Tujuan :</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" id="txtSkop3" readonly style="background-color: #f0f0f0; height: auto" rows="3"></textarea>
                                                <label class="input-group__label" for="Skop">Skop :</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtKategori_Perolehan3" type="text" placeholder="&nbsp;" name="Kategori Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kategori Perolehan">Kategori Perolehan :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtKaedah_Perolehan3" type="text" placeholder="&nbsp;" name="Kaedah Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kaedah Perolehan">Kaedah Perolehan :	</label>
                                            </div>

                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtPTJ_Mohon3" type="text" placeholder="&nbsp;" name="Tarikh Keperluan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Tarikh Keperluan">PTJ Mohon:</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="ml-1" for="txtMasa_Tamat_Perolehan" style="color: #aaa;">Rundingan Terus :</label>
                                                <div class="custom-control custom-radio custom-control-inline mx-2">
                                                    <input class="form-check-input" type="checkbox" name="flexcheckbox" id="flexcheckbox3" disabled>
                                                    <label class="form-check-label" for="flexcheckbox">Rundingan Terus</label>
                                                </div>
                                            </div>
                                            <div class="child-container-checkbox3" style="display: none; margin-left: 15px; margin-top: -15px;">
                                                <div class="form-row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <select class="input-group__select ui search dropdown JenTransaksi" name="txtVendo" id="txtVendo3" placeholder="&nbsp;" disabled style="background-color: #f0f0f0">
                                                            </select>
                                                            <label class="input-group__label" for="PanelJaw">Vendor  :</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <select class="input-group__select ui search dropdown JenTransaksi" name="Gred CIDB" id="txtGred_CIDB3" placeholder="&nbsp;" disabled style="background-color: #f0f0f0">
                                                </select>
                                                <label class="input-group__label" for="Tarikh Keperluan">Gred CIDB :</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">

                                        <div class="col-md-5">

                                            <div class="form-group">
                                                <input class="input-group__input " readonly id="txtHarga_Naska3" type="number" placeholder="&nbsp;" name="Harga_Naska" style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Pemohon">Harga Naska :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-7">
                                            <div class="form-group">
                                                <input class="input-group__input " readonly id="txtNo_SHT3" type="text" placeholder="&nbsp;" name="PTJ" style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="PTJ">No. Sebut Harga / Tendar :</label>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-row">

                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" readonly id="txtTempat_Hantar3" style="background-color: #f0f0f0; height: auto" rows="2"></textarea>
                                                <label class="input-group__label" for="Justifikasi Perolehan">Tempat Hantar :</label>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " readonly id="txtTarikh_Mula_Iklan3" type="date" placeholder="&nbsp;" name="txtTarikh_Mula_Iklan" style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtTarikh_Mula_Iklan">Tarikh Mula Iklan :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " readonly id="txtTarikh_Mula_Perolehan3" type="date" placeholder="&nbsp;" name="txtTarikh_Mula_Perolehan" style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtTarikh_Mula_Perolehan">Tarikh Mula Perolehan :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " readonly id="txtTarikh_Tamat_Perolehan3" type="date" placeholder="&nbsp;" name="txtTarikh_Tamat_Perolehan" style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtTarikh_Tamat_Perolehan">Tarikh Tamat Perolehan  :</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " readonly id="txtMasa_Tamat_Perolehan3" type="time" placeholder="&nbsp;" name="txtMasa_Tamat_Perolehan" style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtMasa_Tamat_Perolehan">Masa Tamat Perolehan  : </label>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="ml-1" for="txtMasa_Tamat_Perolehan" style="color: #aaa;">Lawatan Tapak :</label>
                                                <div class="custom-control custom-radio custom-control-inline mx-2">
                                                    <input class="form-check-input" type="radio" disabled checked name="flexRadioDefault" id="flexRadioDefault3" value="Tidak">
                                                    <label class="form-check-label" for="flexRadioDefault1">
                                                        Tidak
                                                    </label>
                                                </div>
                                                <div class="custom-control custom-radio custom-control-inline mx-2">
                                                    <input class="form-check-input" type="radio" disabled name="flexRadioDefault" id="flexRadioDefault4" value="Ye">
                                                    <label class="form-check-label" for="flexRadioDefault2">
                                                        Ya
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="child-container3 " style="display: none; margin-left: 15px; margin-top: -15px;">
                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <input class="input-group__input " readonly id="txtTempat_Tapak3" type="text" placeholder="&nbsp;" name="txtTempat_Tapak" style="background-color: #f0f0f0" />
                                                            <label class="input-group__label" for="txtTempat_Tapak">Tempat Tapak :</label>
                                                        </div>

                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <input class="input-group__input " readonly id="txtTarikh_Lawatan3" type="date" placeholder="&nbsp;" name="txtTarikh_Lawatan" style="background-color: #f0f0f0" />
                                                            <label class="input-group__label" for="txtTarikh_Lawatan">Tarikh Lawatan :</label>
                                                        </div>

                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <input class="input-group__input " readonly id="txtMasa_Lawatan3" type="time" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0" />
                                                            <label class="input-group__label" for="txtMasa_Lawatan">Masa Lawatan:</label>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-row">

                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" readonly id="txtUlasan3" style="background-color: #f0f0f0; height: auto" rows="3"></textarea>
                                                <label class="input-group__label" for="Ulasan">Arahan dan Maklumat kepada Pembekal/ Kontraktor / Syarikat :</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card card-body my-3">
                                        <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Lesen :</h6>

                                        <div class="form-row">
                                            <div class="col-md-12">
                                                <div class="transaction-table table-responsive">
                                                    <table id="tblDataSenarai_Lesen3" class="table table-striped" style="width: 100%">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Bil</th>
                                                                <th scope="col">Kod Pendaftaran</th>
                                                                <th scope="col">Lesen Pendaftaran</th>
                                                                <th scope="col">Maklumat lanjut</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>

                                                    </table>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card card-body my-3">
                                        <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Kod Bidang :</h6>

                                        <div class="form-row">
                                            <div class="col-md-12">
                                                <div class="transaction-table table-responsive">
                                                    <table id="tblDataKod_Bidang" class="table table-striped" style="width: 100%">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Bil</th>
                                                                <th scope="col">Kod Bidang</th>
                                                                <th scope="col">Bidang</th>
                                                                <th scope="col">Situasi Keperluan</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>

                                                    </table>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col text-center m-3">
                                        <button type="button" id="btnHantarProcess" class="btn btn-secondary " data-toggle="tooltip" data-placement="bottom" title="Draft">Hantar</button>
                                        <input hidden id="txtId_Pemohon3" />
                                        <input hidden id="txtNo_PTj3" />
                                    </div>
                                </div>

                            </div>
                            <!-- tab 3 (Maklumat Bajet dan Spesifikasi) -->

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

    </div>

    <%--Function to check if all input fields have data and enable the button accordingly--%>
    <script type="text/javascript">

        // Get references to the input fields and the button
        const txtHarga_Naska = document.getElementById('txtHarga_Naska');
        const txtTempat_Hantar = document.getElementById('txtTempat_Hantar');
        const txtTarikh_Mula_Iklan = document.getElementById('txtTarikh_Mula_Iklan');
        const txtTarikh_Mula_Perolehan = document.getElementById('txtTarikh_Mula_Perolehan');
        const txtTarikh_Tamat_Perolehan = document.getElementById('txtTarikh_Tamat_Perolehan');
        const txtMasa_Tamat_Perolehan = document.getElementById('txtMasa_Tamat_Perolehan');
        const txtUlasan = document.getElementById('txtUlasan');
        const txtMaklumat_lanjut = document.getElementById('txtMaklumat_lanjut');

        const txtGred_CIDB = document.getElementById('txtGred_CIDB');
        const btnSimpan = document.getElementById('btnSimpanIklan');
        const KodPendaftaran = document.getElementById('KodPendaftaran');
        const btnSimpanLesen = document.getElementById('btnSimpanLesen');


        btnSimpan.disabled = true;
        // btnSimpanLesen.disabled = true;


        const today = new Date().toISOString().split('T')[0];
        document.getElementById('txtTarikh_Mula_Iklan').min = today;

        document.getElementById('txtTarikh_Mula_Perolehan').min = today;

        function checkInputsDate() {
            const txtTarikh_Mula_PerolehanValue = txtTarikh_Mula_Perolehan.value.trim();

            // Add 1 day to the value
            const oneDayLater = new Date(txtTarikh_Mula_PerolehanValue);
            oneDayLater.setDate(oneDayLater.getDate() + 1);
            const oneDayLaterStr = oneDayLater.toISOString().split('T')[0]; // Get date in YYYY-MM-DD format

            //console.log('txtTarikh_Mula_PerolehanValue (original)', txtTarikh_Mula_PerolehanValue);
            //console.log('txtTarikh_Mula_PerolehanValue (1 day later)', oneDayLaterStr);

            document.getElementById('txtTarikh_Tamat_Perolehan').min = oneDayLaterStr;

        }
        txtTarikh_Mula_Perolehan.addEventListener('input', checkInputsDate);

        // Function to check if all input fields have data and enable the button accordingly
        function checkInputs() {

            const txtHarga_NaskaValue = txtHarga_Naska.value.trim();
            const txtTempat_HantarValue = txtTempat_Hantar.value.trim();
            const txtTarikh_Mula_IklanValue = txtTarikh_Mula_Iklan.value.trim();
            const txtTarikh_Mula_PerolehanValue = txtTarikh_Mula_Perolehan.value.trim();
            const txtTarikh_Tamat_PerolehanValue = txtTarikh_Tamat_Perolehan.value.trim();
            const txtMasa_Tamat_PerolehanValue = txtMasa_Tamat_Perolehan.value.trim();
            const txtUlasanValue = txtUlasan.value.trim();


            // If all fields have data, enable the button
            if (txtHarga_NaskaValue !== '' && txtTempat_HantarValue !== '' && txtTarikh_Mula_IklanValue !== '' && txtTarikh_Mula_PerolehanValue !== '' && txtTarikh_Tamat_PerolehanValue !== '' && txtMasa_Tamat_PerolehanValue !== '' && txtUlasanValue !== '') {
                btnSimpan.disabled = false;
            } else {
                btnSimpan.disabled = true;
            }
        }

        // Function to check if all input fields have data and enable the button accordingly
        //function checkInputsLesen() {

        //    const txtGred_CIDBValue = txtGred_CIDB.value.trim();

        //    console.log('txtGred_CIDBValue=', txtGred_CIDBValue)
        //    console.log('KodGred_CIDBValue=', KodGred_CIDB)
        //    // If all fields have data, enable the button
        //    if (txtGred_CIDBValue !== '' && KodGred_CIDB !== '') {
        //        btnSimpanLesen.disabled = false;
        //    } else {
        //        btnSimpanLesen.disabled = true;
        //    }
        //}

        // Add event listeners to input fields
        txtHarga_Naska.addEventListener('input', checkInputs);
        txtTempat_Hantar.addEventListener('input', checkInputs);
        txtTarikh_Mula_Iklan.addEventListener('input', checkInputs);
        txtTarikh_Mula_Perolehan.addEventListener('input', checkInputs);
        txtTarikh_Tamat_Perolehan.addEventListener('input', checkInputs);
        txtMasa_Tamat_Perolehan.addEventListener('input', checkInputs);
        txtUlasan.addEventListener('input', checkInputs);
        //txtMaklumat_lanjut.addEventListener('input', checkInputsLesen);

        txtGred_CIDB.addEventListener('change', checkInputs);
        //KodPendaftaran.addEventListener('change', checkInputsLesen);
    </script>


    <script type="text/javascript">

        var txtLawatanTempat = 'Tidak';
        var DtlSenarai_Lesen;
        var tblRingkasanCidb;
        var newNo_Perolehan = "";

        var category_filter;
        isClicked = false;

        var Status_Dok_main = '';

        //$("#KodPendaftaran").val('BP - BADAN PROFESIONAL');

        // Get all radio buttons with the class "form-check-input"
        var radioButtons = document.querySelectorAll('.form-check-input');

        // Loop through each radio button
        radioButtons.forEach(function (radioButton) {
            // Add an event listener for the 'change' event
            radioButton.addEventListener('change', function () {
                // Check if the radio button is checked
                if (this.checked) {
                    // Get the value of the checked radio button
                    var selectedValue = this.value;
                    txtLawatanTempat = this.value;
                    // Log or use the selected value as needed
                    console.log("Selected radioButton value: " + selectedValue);
                }
            });
        });





        var KodDetailLesen;
        var KodVendo;
        var KodGred_CIDB;

        $(document).ready(function () {
            // Dropdown Syarikat Bidang Utama
            $('#KodPendaftaran').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Get_Kod_Pendaftaran?q={query}") %>',
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
                                // Do something with the selected value
                                console.log("Selected Value:", kodValue);
                                console.log("Selected Text:", text);
                                console.log("Selected Item:", $selectedItem);

                                KodDetailLesen = kodValue;

                            

                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });


        })


        $(document).ready(function () {
            // Dropdown Syarikat Bidang Utama
            $('#txtGred_CIDB').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetCIDB_Gred?q={query}") %>',
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
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });

                        $(obj).dropdown('refresh');

                        // Handle selection change
                        $(obj).dropdown({
                            onChange: function (value, text, $selectedItem) {
                                // Do something with the selected value
                                console.log("Selected Value:", value);
                                console.log("Selected Text:", text);
                                console.log("Selected Item:", $selectedItem);

                                KodGred_CIDB = value;

                                

                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });


        })

        $(document).ready(function () {
            // Dropdown Syarikat Bidang Utama
            $('#txtVendo').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/Get_Syarikat_Master?q={query}") %>',
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
                                // Do something with the selected value
                                console.log("Selected Value:", kodValue);
                                console.log("Selected Text:", text);
                                console.log("Selected Item:", $selectedItem);

                                KodVendo = kodValue;


                            }
                        });
                        $(obj).dropdown('refresh');

                       
                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });
        })




        // Get radio button elements
        const parentRadios = document.querySelectorAll('input[name="flexRadioDefault"]');
        const childContainer = document.querySelector('.child-container');

        // Add event listeners to parent radio buttons
        parentRadios.forEach(parentRadio => {
            parentRadio.addEventListener('change', function () {
                // Hide or show the child options container based on the selected parent radio
                childContainer.style.display = (this.id === 'flexRadioDefault1' || this.id === 'flexRadioDefault3') ? 'none' : 'block';

                // If the parent is checked, also uncheck the child options
                if (this.checked) {
                    document.querySelectorAll('.RadioDefault').forEach(RadioDefault => {
                        RadioDefault.checked = false;
                    });
                }
            });
        });

        $(document).ready(function () {
            // Initially hide the child-container-checkbox
            $('.child-container-checkbox').hide();

            // Attach a change event listener to the checkbox
            $('#flexcheckbox').change(function () {
                // Check if the checkbox is checked
                if ($(this).is(':checked')) {
                    // If checked, show the child-container-checkbox
                    $('.child-container-checkbox').show();
                } else {
                    // If unchecked, hide the child-container-checkbox
                    $('.child-container-checkbox').hide();
                }
            });
        });

        // Get radio button elements
        const parentRadios3 = document.querySelectorAll('input[name="flexRadioDefault"]');
        const childContainer3 = document.querySelector('.child-container3');

        // Add event listeners to parent radio buttons
        parentRadios3.forEach(parentRadio3 => {
            parentRadio3.addEventListener('change', function () {
                // Hide or show the child options container based on the selected parent radio
                childContainer3.style.display = (this.id === 'flexRadioDefault3' || this.id === 'flexRadioDefault5') ? 'none' : 'block';

                // If the parent is checked, also uncheck the child options
                if (this.checked) {
                    document.querySelectorAll('.RadioDefault').forEach(RadioDefault => {
                        RadioDefault.checked = false;
                    });
                }
            });
        });


        $(document).ready(function () {
            // Initially hide the child-container-checkbox
            $('.child-container-checkbox3').hide();

            // Attach a change event listener to the checkbox
            $('#flexcheckbox3').change(function () {
                // Check if the checkbox is checked
                if ($(this).is(':checked')) {
                    // If checked, show the child-container-checkbox
                    $('.child-container-checkbox3').show();
                } else {
                    // If unchecked, hide the child-container-checkbox
                    $('.child-container-checkbox3').hide();
                }
            });
        });

        $(document).ready(function () {
            // Initially hide the child-container-checkbox
            $('.nav-show').show();

        });




        $('.btnSearchDT').off('click').on('click', async function () {

            load_loader();
            isClicked = true;


            category_filter = $('#categoryFilter').val();


            console.log("category_filter=", category_filter);
            tblNJ.ajax.reload();
            close_loader();
        })


        $(document).ready(function () {



            tblNJ = $("#tblDataNaskah_Jualan").DataTable({
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
                "ajax":
                {
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadNaskah_Jualan") %>',
                    type: 'POST',
                    data: function (d) {
                        return "{ category_filter: '" + category_filter + "' , isClick: '" + isClicked + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },



                "columns": [

                    {
                        "data": "Bil",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    {
                        "data": "No_Perolehan",
                        "width": "10%"
                    },
                    {
                        "data": "Tujuan",
                        "width": "20%"
                    },
                    {
                        "data": "ButiranB",
                        "width": "10%"
                    },
                    {
                        "data": "Id_Jualan",
                        "width": "10%"
                    },
                    {
                        "data": "Tarikh_Masa_Mula_Iklan",
                        "type": "date", // This is optional but helps with sorting
                        render: function (data, type, row) {
                            // Format the date using moment.js
                            if (data == null) {
                                return '-';
                            } else {
                                return moment(data).format('DD/MM/YYYY , h:mm a '); // Adjust the format as needed
                            }
                        },
                        "width": "10%"
                    },
                    {
                        "data": "Tarikh_Masa_Tamat_Perolehan",
                        "type": "date", // This is optional but helps with sorting
                        render: function (data, type, row) {
                            // Format the date using moment.js
                            if (data == null) {
                                return '-';
                            } else {
                                return moment(data).format('DD/MM/YYYY , h:mm a '); // Adjust the format as needed
                            }

                        },
                        "width": "10%"
                    },
                    {
                        "data": "status_dok_butiran",
                        "width": "10%"
                    },

                    //{
                    //    "data": null,
                    //    "defaultContent": '<i onclick="ShowPopup(1)" class="fa fa-ellipsis-h fa-lg"></i>',
                    //    "className": "text-center", // Center the icon within the cell
                    //    "width": "5%"
                    //}
                ],

                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    // Add click event
                    $(row).on("click", function () {

                        ShowPopup(1, data.No_Mohon);

                    });
                },
            });
        });

        var newIdJualan = '';
        var newNoMohon = '';
        var maklumatIklan
        var Id_MohonDtl = '';

        function ShowPopup(elm, No_MohonPS) {

            Id_MohonDtl = No_MohonPS;

            if (elm == "1") {

                loadMaklumatIklan();

                tblRingkasanCidb.ajax.reload();
                DtlSenarai_Lesen.ajax.reload();
                DtlSenarai_Lesen3.ajax.reload();
                tblNJ.ajax.reload();



                $('#transaksi').modal('toggle');


            }
            else if (elm == "2") {

                $(".modal-body div").val("");
                $('#transaksi').modal('toggle');

            }
        }

        function loadMaklumatIklan() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadMaklumat_Naskah_Jualan") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ IdMohon: Id_MohonDtl }), // Convert the data to a JSON string
                success: function (data) {
                    // Parse the JSON data
                    var jsonData = JSON.parse(data.d);
                    Status_Dok_main = jsonData[0].Status_Dok;
                    if (jsonData[0].Status_Dok == '35') {
                        // If Status_Dok is '35', hide perolehan tab content and set bajet-tab as active
                        $('.nav-show').hide();
                        $('#bajet-tab').addClass('active');
                        $('#perolehan').removeClass('active show');
                        $('#bajet-dan-spesifikasi').addClass('active show');
                        $('#bajet-tab').trigger('click');

                        const btnHantarProcess = document.getElementById('btnHantarProcess');
                        btnHantarProcess.disabled = true;
                    } else {
                        // If Status_Dok is not '35', show perolehan tab content and set maklumatPO-tab as active
                        $('.nav-show').show();
                        $('#bajet-tab').removeClass('active');
                        $('#maklumatPO-tab').addClass('active');
                        $('#bajet-dan-spesifikasi').removeClass('active show');
                        $('#perolehan').addClass('active show');
                        const btnHantarProcess = document.getElementById('btnHantarProcess');
                        btnHantarProcess.disabled = false;
                    }

                    const inputString = jsonData[0].No_Perolehan;;
                    const wordsArray = inputString.match(/[a-zA-Z]+/g);

                    if (wordsArray && wordsArray.length >= 1) {
                        newNo_Perolehan = wordsArray.slice(0, 2).join(' ');
                        console.log(newNo_Perolehan);
                    } else {
                        console.log("Not enough words in the input string.");
                    }


                    console.log("newNo_Perolehan=", newNo_Perolehan);

                    newIdJualan = jsonData[0].Id_Jualan;
                    newNoMohon = jsonData[0].No_Mohon;

                    if (jsonData[0].Jenis_Barang !== 'K') {
                        document.getElementById('CIDB_DIV').style.display = 'none';
                    } else {
                        document.getElementById('CIDB_DIV').style.display = 'block'; // or 'inline-block', depending on its original display style
                    }

                    $('#txtVendo').dropdown('clear');
                    $('#txtGred_CIDB').dropdown('clear');
                    $('#flexcheckbox').prop('checked', false);
                    $('.child-container-checkbox').hide();

                    $("#txtNoNaskah_Jualan").val(jsonData[0].Id_Jualan);
                    $("#txtStatus").val(jsonData[0].status_dok_butiran);
                    $("#txtNo_Perolehan").val(jsonData[0].No_Perolehan);
                    $("#txtTujuan").val(jsonData[0].Tujuan);
                    $("#txtSkop").val(jsonData[0].Skop);
                    $("#txtKategori_Perolehan").val(jsonData[0].ButiranB);
                    //$("txtKaedah_Perolehan").val(jsonData[0].Tujuan);
                    $("#txtPTJ_Mohon").val(jsonData[0].KP);
                    $("#txtHarga_Naska").val(jsonData[0].Harga);
                    $("#txtNo_SHT").val(jsonData[0].No_Sebut_Harga);
                    $("#txtTempat_Hantar").val(jsonData[0].Tempat_Hantar);
                    $("#txtTempat_Tapak").val(jsonData[0].Tempat_Lawatan_Tapak);
                    $("#txtId_Pemohon").val(jsonData[0].Id_Pemohon);
                    $("#txtNo_PTj").val(jsonData[0].Kod_Ptj_Mohon);
                    $("#txtUlasan").val(jsonData[0].Syarat_Perolehan);

                    checkInputs();

                    if (jsonData[0].Lawatan_Tapak == 'Ye') {

                        setRadioChecked1(false);
                        setRadioChecked2(true);
                        const childContainer = document.querySelector('.child-container');
                        childContainer.style.display = 'block';
                    } else {

                        setRadioChecked1(true);
                        setRadioChecked2(false);
                        const childContainer = document.querySelector('.child-container');
                        childContainer.style.display = 'none';

                    }

                    if (jsonData[0].Tarikh_Lawatan_Tapak == null) {
                        $("#txtTarikh_Lawatan").val();
                    } else {
                        $("#txtTarikh_Lawatan").val(jsonData[0].Tarikh_Lawatan_Tapak);
                    }


                    if (jsonData[0].Tarikh_Mohon == null) {
                        $("#txtTarikh_Mohon").val();
                    } else {
                        $("#txtTarikh_Mohon").val(jsonData[0].Tarikh_Mohon);
                    }

                    if (jsonData[0].Tarikh_Masa_Mula_Iklan == null) {
                        $("#txtTarikh_Mula_Iklan").val();
                    } else {
                        $("#txtTarikh_Mula_Iklan").val(jsonData[0].Tarikh_Masa_Mula_Iklan);
                    }


                    if (jsonData[0].Tarikh_Masa_Mula_Perolehan == null) {
                        $("#txtTarikh_Mula_Perolehan").val();
                    } else {
                        $("#txtTarikh_Mula_Perolehan").val(jsonData[0].Tarikh_Masa_Mula_Perolehan);
                    }

                    if (jsonData[0].Tarikh_Masa_Tamat_Perolehan == null) {
                        $("#txtTarikh_Tamat_Perolehan").val();
                    } else {
                        $("#txtTarikh_Tamat_Perolehan").val(jsonData[0].Tarikh_Tamat_Perolehan);
                    }

                    if (jsonData[0].Tarikh_Masa_Tamat_Perolehan == null) {
                        $("#txtMasa_Tamat_Perolehan").val();
                    } else {
                        const dateTimeTPM = new Date(jsonData[0].Tarikh_Masa_Tamat_Perolehan);
                        const timePart = dateTimeTPM.toTimeString().slice(0, 5);
                        $("#txtMasa_Tamat_Perolehan").val(timePart);
                    }

                    if (jsonData[0].Tarikh_Masa_Lawatan_Tapak == null) {
                        $("#txtMasa_Lawatan").val();
                    } else {
                        const dateTimeTPM = new Date(jsonData[0].Tarikh_Masa_Lawatan_Tapak);
                        const timePart = dateTimeTPM.toTimeString().slice(0, 5);
                        $("#txtMasa_Lawatan").val(timePart);
                    }
                    

                    // Populate dropdown select options
                    var selectOptions = '';
                    jsonData.forEach(function (item) {
                        selectOptions += '<option value="' + item.Gred_CIDB + '">' + item.Kod_Gred_butiran + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                    });
                    KodGred_CIDB = jsonData[0].Gred_CIDB

                    // Update dropdown select
                    if (jsonData[0].Gred_CIDB.trim() !== '') {
                        $('#txtGred_CIDB').html(selectOptions);
                    };

                    

                    // Populate dropdown select options
                    var selectOptionsVendo = '';
                    jsonData.forEach(function (item) {

                        selectOptionsVendo += '<option value="' + item.Kod_Vendo + '">' + item.Nama_Sykt_butiran + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                    });
                    KodVendo = jsonData[0].Kod_Vendo
                    // Update dropdown select
                    if (jsonData[0].Kod_Vendo.trim() !== '') {
                        $('#txtVendo').html(selectOptionsVendo);
                    };


                    // Function to check if txtVendo has data

                    if (jsonData[0].Kod_Vendo.trim() !== '') {
                        $('#flexcheckbox').prop('checked', true);
                        $('.child-container-checkbox').show();
                    } else {
                        $('#flexcheckbox').prop('checked', false);
                        $('.child-container-checkbox').hide();
                    }



                    showKaedahPerolehan(jsonData[0].No_Mohon);

                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        };

        function setRadioChecked1(value) {
            document.getElementById('flexRadioDefault1').checked = value;
        }

        function setRadioChecked2(value) {
            document.getElementById('flexRadioDefault2').checked = value;
        }

        function showKaedahPerolehan(noMohon) {
            //var noMohon = $('#txtNo_Permohonan').val();
            $.ajax({
                type: 'POST',
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetKaedahPerolehan") %>',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: JSON.stringify({ noMohon: noMohon }),
                success: function (result) {
                    result = JSON.parse(result.d)
                    $('#txtKaedah_Perolehan').val(result[0].Kategori_Perolehan);
                    $('#txtKaedah_Perolehan3').val(result[0].Kategori_Perolehan);
                },
                error: function (error) {
                    console.error('AJAX error:', error);
                }
            });
        }

        // Simpan  Permohonan ulasan
        $('#btnSimpanIklan').off('click').on('click', async function () {
            var msg = "Anda pasti ingin mengsimpan maklumat jualan naskah ini?";
            //console.log("txtMasa_Lawatan=", $('#txtMasa_Lawatan').val())
            $('#confirmationMessage10').text(msg);
            $('#saveConfirmationModal10').modal('show');
            //$('#maklumatPermohonanModal').modal('hide');


            $('#confirmSaveButton10').off('click').on('click', async function () {
                $('#saveConfirmationModal10').modal('hide');

                // Create a new Date object
                const currentDate = new Date();

                // Convert the date to ISO string format
                const sqlFormattedDate = currentDate.toISOString().slice(0, 19).replace('T', ' ');



                var newHantarNaskah_Jualan_Dtl = {

                    HantarNaskah_Jualan_Dtl: {

                        txtNoMohon: newNoMohon,
                        txtIdJualan: $("#txtNoNaskah_Jualan").val(),
                        txtTarikh_Daftar: sqlFormattedDate, // current date
                        txtNo_Sebut_Harga: $("#txtNo_SHT").val(),
                        //txtNo_Sebut_Harga:'UTeM/SH/002/2024',

                        txtHarga: $("#txtHarga_Naska").val() || '',
                        txtGred_CIDB: KodGred_CIDB || '',
                        ddlVendo: KodVendo || '',
                        txtLawatan_Tapak: txtLawatanTempat || '',
                        txtTempat_Lawatan_Tapak: $("#txtTempat_Tapak").val() || '',
                        txtTarikh_Masa_Lawatan_Tapak: $('#txtTarikh_Lawatan').val() + ' ' + $('#txtMasa_Lawatan').val()  || '',
                        txtTarikh_Masa_Mula_Iklan: $("#txtTarikh_Mula_Iklan").val() || '',
                        txtTarikh_Masa_Mula_Perolehan: $("#txtTarikh_Mula_Perolehan").val() || '',
                        txtTarikh_Masa_Tamat_Perolehan: $("#txtTarikh_Tamat_Perolehan").val() + ' ' + $("#txtMasa_Tamat_Perolehan").val() || '',
                        txtTempat_Hantar: $("#txtTempat_Hantar").val() || '',
                        txtNo_Staf: $("#txtId_Pemohon").val() || '',
                        txtSyarat_Perolehan: $("#txtUlasan").val() || '',
                        //txtStatus_Lanjut: $("#txtStatus").val(),
                        txtStatus_Lanjut: '01' || '',
                        txtStatus: 1 || '',
                        ddlKodPTj: $("#txtNo_PTj").val() || '',
                        ddlNo_Perolehan: newNo_Perolehan || '',
                        txtFlag_PenentuanTeknikal: 1 || '',
                        txtStatusDokH: 34 || '',
                    }

                };


                try {
                    var result = JSON.parse(await ajaxHantarMaklumatNaskahJualan(newHantarNaskah_Jualan_Dtl))

                    if (result.Status === true) {
                        showModal10("Success", result.Message, "success");
                        tblNJ.ajax.reload();
                        loadMaklumatIklan();

                        $('#txtNoNaskah_Jualan').val(result.Payload.txtIdJualan);
                        $('#txtTarikh_Mohon').val(result.Payload.txtTarikh_Daftar);
                        $("#txtNo_SHT").val(result.Payload.txtNo_Sebut_Harga);
                    } else {
                        showModal10("Error", result.Message, "error");
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }
            });
        });


        async function ajaxHantarMaklumatNaskahJualan(HantarNaskah_Jualan_Dtl) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadeUpdateMaklumat_Naskah_Jualan") %>',
                    method: 'POST',
                    data: JSON.stringify(HantarNaskah_Jualan_Dtl),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);

                        var jsonData = JSON.parse(data.d);

                        if (result1.Status === true) {
                            showModal10("Success", result.Message, "success");
                            //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                            tblNJ.ajax.reload();
                            loadMaklumatIklan();

                        } else {
                            showModal10("Error", result.Message, "error");
                        }

                        newIdJualan = jsonData[0].Id_Jualan;
                        newNoMohon = jsonData[0].No_Mohon;
                        newNo_Perolehan = jsonData[0].No_Perolehan;
                        console.log("newNo_Perolehan=", newNo_Perolehan)

                        $('#txtVendo').dropdown('clear');
                        $('#txtGred_CIDB').dropdown('clear');
                        $('#flexcheckbox').prop('checked', false);
                        $('.child-container-checkbox').hide();

                        $("#txtNoNaskah_Jualan").val(jsonData[0].Id_Jualan);
                        $("#txtStatus").val(jsonData[0].status_dok_butiran);
                        $("#txtNo_Perolehan").val(jsonData[0].No_Perolehan);
                        $("#txtTujuan").val(jsonData[0].Tujuan);
                        $("#txtSkop").val(jsonData[0].Skop);
                        $("#txtKategori_Perolehan").val(jsonData[0].ButiranB);
                        //$("txtKaedah_Perolehan").val(jsonData[0].Tujuan);
                        $("#txtPTJ_Mohon").val(jsonData[0].KP);
                        $("#txtHarga_Naska").val(jsonData[0].Harga);
                        $("#txtNo_SHT").val(jsonData[0].No_Sebut_Harga);
                        $("#txtTempat_Hantar").val(jsonData[0].Tempat_Hantar);
                        $("#txtTempat_Tapak").val(jsonData[0].Tempat_Lawatan_Tapak);
                        $("#txtId_Pemohon").val(jsonData[0].Id_Pemohon);
                        $("#txtNo_PTj").val(jsonData[0].Kod_Ptj_Mohon);
                        $("#txtUlasan").val(jsonData[0].Syarat_Perolehan);


                        if (jsonData[0].Lawatan_Tapak == 'Ye') {

                            setRadioChecked1(false);
                            setRadioChecked2(true);
                            const childContainer = document.querySelector('.child-container');
                            childContainer.style.display = 'block';
                        } else {

                            setRadioChecked1(true);
                            setRadioChecked2(false);
                            const childContainer = document.querySelector('.child-container');
                            childContainer.style.display = 'none';

                        }

                        if (jsonData[0].Tarikh_Masa_Lawatan_Tapak == null) {
                            $("#txtTarikh_Lawatan").val();
                            $("#txtMasa_Lawatan").val();
                        } else {
                            const dateTimeLT = new Date(jsonData[0].Tarikh_Masa_Lawatan_Tapak);
                            const datePartLT = dateTimeLT.toISOString().slice(0, 10);
                            const timePartLT = dateTimeLT.toTimeString().slice(0, 5);
                            $("#txtTarikh_Lawatan").val(datePartLT);
                            $("#txtMasa_Lawatan").val(timePartLT);
                        }


                        if (jsonData[0].Tarikh_Daftar == null) {
                            $("#txtTarikh_Mohon").val();
                        } else {
                            const dateTimeD = new Date(jsonData[0].Tarikh_Daftar);
                            const datePartD = dateTimeD.toISOString().slice(0, 10);
                            $("#txtTarikh_Mohon").val(datePartD);
                        }

                        if (jsonData[0].Tarikh_Masa_Mula_Iklan == null) {
                            $("#txtTarikh_Mula_Iklan").val();
                        } else {
                            const dateTimeMI = new Date(jsonData[0].Tarikh_Masa_Mula_Iklan);
                            const datePartMI = dateTimeMI.toISOString().slice(0, 10);
                            $("#txtTarikh_Mula_Iklan").val(datePartMI);
                        }


                        if (jsonData[0].Tarikh_Masa_Mula_Perolehan == null) {
                            $("#txtTarikh_Mula_Perolehan").val();
                        } else {
                            const dateTimeMP = new Date(jsonData[0].Tarikh_Masa_Mula_Perolehan);
                            const datePartMP = dateTimeMP.toISOString().slice(0, 10);
                            $("#txtTarikh_Mula_Perolehan").val(datePartMP);
                        }

                        if (jsonData[0].Tarikh_Masa_Tamat_Perolehan == null) {
                            $("#txtTarikh_Tamat_Perolehan").val();
                        } else {
                            const dateTimeTP = new Date(jsonData[0].Tarikh_Masa_Tamat_Perolehan);
                            const datePartTP = dateTimeTP.toISOString().slice(0, 10);
                            $("#txtTarikh_Tamat_Perolehan").val(datePartTP);
                        }

                        if (jsonData[0].Tarikh_Masa_Tamat_Perolehan == null) {
                            $("#txtMasa_Tamat_Perolehan").val();
                        } else {
                            const dateTimeTPM = new Date(jsonData[0].Tarikh_Masa_Tamat_Perolehan);
                            const timePart = dateTimeTPM.toTimeString().slice(0, 5);
                            $("#txtMasa_Tamat_Perolehan").val(timePart);
                        }

                        // Populate dropdown select options
                        var selectOptions = '';
                        jsonData.forEach(function (item) {

                            selectOptions += '<option value="' + item.Gred_CIDB + '">' + item.Kod_Gred_butiran + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                        });


                        // Update dropdown select
                        if (jsonData[0].Gred_CIDB.trim() !== '') {
                            $('#txtGred_CIDB').html(selectOptions);
                        };

                        // Populate dropdown select options
                        var selectOptionsVendo = '';
                        jsonData.forEach(function (item) {

                            selectOptionsVendo += '<option value="' + item.Kod_Vendo + '">' + item.Nama_Sykt_butiran + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                        });

                        // Update dropdown select
                        if (jsonData[0].Kod_Vendo.trim() !== '') {
                            $('#txtVendo').html(selectOptionsVendo);
                        };

                        // Function to check if txtVendo has data

                        if (jsonData[0].Kod_Vendo.trim() !== '') {
                            $('#flexcheckbox').prop('checked', true);
                            $('.child-container-checkbox').show();
                        } else {
                            $('#flexcheckbox').prop('checked', false);
                            $('.child-container-checkbox').hide();
                        }


                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            });
        }

        async function HantarStatus_Dok_Permohonan_Hd(HantarNaskah_Jualan_Dtl) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/HantarStatus_Dok_Permohonan_Hdr") %>',
                    method: 'POST',
                    data: JSON.stringify(HantarNaskah_Jualan_Dtl),
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





        $('#btnSimpanLesen').off('click').on('click', async function () {
            var msg = "Anda pasti ingin menghantar maklumat Lesen ini?";
            //console.log("txtMasa_Lawatan=", $('#txtMasa_Lawatan').val())
            $('#confirmationMessage10').text(msg);
            $('#saveConfirmationModal10').modal('show');
            //$('#maklumatPermohonanModal').modal('hide');


            $('#confirmSaveButton10').off('click').on('click', async function () {
                $('#saveConfirmationModal10').modal('hide');



                var newHantarLesen_Dtl = {

                    HantarHantarLesen_Dtl: {

                        txtNoMohon: newNoMohon,
                        txtIdJualan: newIdJualan,
                        txtKod_Lesen: KodDetailLesen,
                        txtStatus: 1,
                        txtMaklumat_lanjut: $("#txtMaklumat_lanjut").val(),
                    }

                };


                try {
                    var result = JSON.parse(await ajaxHantarMaklumatLesen(newHantarLesen_Dtl))

                    if (result.Status === true) {
                        showModal10("Success", result.Message, "success");

                        //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                    } else {
                        showModal10("Error", result.Message, "error");
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }
            });
        });

        async function ajaxHantarMaklumatLesen(HantarHantarLesen_Dtl) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/UpdatePerolehan_Lesen") %>',
                    method: 'POST',
                    data: JSON.stringify(HantarHantarLesen_Dtl),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);

                        DtlSenarai_Lesen.ajax.reload();
                        DtlSenarai_Lesen3.ajax.reload();
                        tblRingkasanCidb.ajax.reload();
                        tblNJ.ajax.reload();

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
            $('#resultModalMessage10').text(message);
            if (type === "success") {
                $('#resultModal10').removeClass("modal-error").addClass("modal-success");
            } else if (type === "error") {
                $('#resultModal10').removeClass("modal-success").addClass("modal-error");
            }
            $('#resultModal10').modal('show');
        }


        function setRadioChecked3(value) {
            document.getElementById('flexRadioDefault4').checked = value;
        }

        function setRadioChecked4(value) {
            document.getElementById('flexRadioDefault4').checked = value;
        }

        $('#bajet-tab').off('click').on('click', async function () {
            console.log("test data=", newNoMohon)
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadMaklumat_Naskah_Jualan") %>',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ IdMohon: newNoMohon }), // Convert the data to a JSON string
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);

                        newIdJualan = jsonData[0].Id_Jualan;
                        newNoMohon = jsonData[0].No_Mohon;
                        newNo_Perolehan = jsonData[0].No_Perolehan;
                        console.log("newNo_Perolehan=", newNo_Perolehan);




                        $('#txtVendo3').dropdown('clear');
                        $('#txtGred_CIDB3').dropdown('clear');
                        $('#flexcheckbox3').prop('checked', false);
                        $('.child-container-checkbox3').hide();

                        $("#txtNoNaskah_Jualan3").val(jsonData[0].Id_Jualan);
                        $("#txtStatus3").val(jsonData[0].status_dok_butiran);
                        $("#txtNo_Perolehan3").val(jsonData[0].No_Perolehan);
                        $("#txtTujuan3").val(jsonData[0].Tujuan);
                        $("#txtSkop3").val(jsonData[0].Skop);
                        $("#txtKategori_Perolehan3").val(jsonData[0].ButiranB);
                        //$("txtKaedah_Perolehan").val(jsonData[0].Tujuan);
                        $("#txtPTJ_Mohon3").val(jsonData[0].KP);
                        $("#txtHarga_Naska3").val(jsonData[0].Harga);
                        $("#txtNo_SHT3").val(jsonData[0].No_Sebut_Harga);
                        $("#txtTempat_Hantar3").val(jsonData[0].Tempat_Hantar);
                        $("#txtTempat_Tapak3").val(jsonData[0].Tempat_Lawatan_Tapak);
                        $("#txtId_Pemohon3").val(jsonData[0].Id_Pemohon);
                        $("#txtNo_PTj3").val(jsonData[0].Kod_Ptj_Mohon);
                        $("#txtUlasan3").val(jsonData[0].Syarat_Perolehan);


                        if (jsonData[0].Lawatan_Tapak == 'Ye') {

                            setRadioChecked3(false);
                            setRadioChecked4(true);
                            const childContainer = document.querySelector('.child-container3');
                            childContainer.style.display = 'block';
                        } else {

                            setRadioChecked3(true);
                            setRadioChecked4(false);
                            const childContainer = document.querySelector('.child-container3');
                            childContainer.style.display = 'none';

                        }

                        if (jsonData[0].Tarikh_Lawatan_Tapak == null) {
                            $("#txtTarikh_Lawatan3").val();
                        } else {
                            $("#txtTarikh_Lawatan3").val(jsonData[0].Tarikh_Lawatan_Tapak);
                        }


                        if (jsonData[0].Tarikh_Mohon == null) {
                            $("#txtTarikh_Mohon3").val();
                        } else {
                            $("#txtTarikh_Mohon3").val(jsonData[0].Tarikh_Mohon);
                        }

                        if (jsonData[0].Tarikh_Masa_Mula_Iklan == null) {
                            $("#txtTarikh_Mula_Iklan3").val();
                        } else {
                            $("#txtTarikh_Mula_Iklan3").val(jsonData[0].Tarikh_Masa_Mula_Iklan);
                        }


                        if (jsonData[0].Tarikh_Masa_Mula_Perolehan == null) {
                            $("#txtTarikh_Mula_Perolehan3").val();
                        } else {
                            $("#txtTarikh_Mula_Perolehan3").val(jsonData[0].Tarikh_Masa_Mula_Perolehan);
                        }

                        if (jsonData[0].Tarikh_Masa_Tamat_Perolehan == null) {
                            $("#txtTarikh_Tamat_Perolehan3").val();
                        } else {
                            $("#txtTarikh_Tamat_Perolehan3").val(jsonData[0].Tarikh_Tamat_Perolehan);
                        }

                        if (jsonData[0].Tarikh_Masa_Tamat_Perolehan == null) {
                            $("#txtMasa_Tamat_Perolehan3").val();
                        } else {
                            const dateTimeTPM = new Date(jsonData[0].Tarikh_Masa_Tamat_Perolehan);
                            const timePart = dateTimeTPM.toTimeString().slice(0, 5);
                            $("#txtMasa_Tamat_Perolehan3").val(timePart);
                        }

                        if (jsonData[0].Tarikh_Masa_Lawatan_Tapak == null) {
                            $("#txtMasa_Lawatan3").val();
                        } else {
                            const dateTimeTPM = new Date(jsonData[0].Tarikh_Masa_Lawatan_Tapak);
                            const timePart = dateTimeTPM.toTimeString().slice(0, 5);
                            $("#txtMasa_Lawatan3").val(timePart);
                        }

                        // Populate dropdown select options
                        var selectOptions = '';
                        jsonData.forEach(function (item) {

                            selectOptions += '<option value="' + item.Gred_CIDB + '">' + item.Kod_Gred_butiran + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                        });


                        // Update dropdown select
                        if (jsonData[0].Gred_CIDB.trim() !== '') {
                            $('#txtGred_CIDB3').html(selectOptions);
                        };

                        // Populate dropdown select options
                        var selectOptionsVendo = '';
                        jsonData.forEach(function (item) {

                            selectOptionsVendo += '<option value="' + item.Kod_Vendo + '">' + item.Nama_Sykt_butiran + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                        });

                        // Update dropdown select
                        if (jsonData[0].Kod_Vendo.trim() !== '') {
                            $('#txtVendo3').html(selectOptionsVendo);
                        };

                        // Function to check if txtVendo has data

                        if (jsonData[0].Kod_Vendo.trim() !== '') {
                            $('#flexcheckbox3').prop('checked', true);
                            $('.child-container-checkbox3').show();
                        } else {
                            $('#flexcheckbox3').prop('checked', false);
                            $('.child-container-checkbox3').hide();
                        }

                        tblRingkasanCidb.ajax.reload();
                        DtlSenarai_Lesen3.ajax.reload()
                        tblNJ.ajax.reload();
                        showKaedahPerolehan(jsonData[0].No_Mohon);

                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });
            });

        });

        $('#spesifikasiAm-tab').off('click').on('click', async function () {

            DtlSenarai_Lesen.ajax.reload();

        });




        $(document).ready(function () {

            console.log('newNoMohon=', newNoMohon);
            console.log('newIdJualan=', newIdJualan);
            console.log("newNo_Perolehan=", newNo_Perolehan)


            DtlSenarai_Lesen = $("#tblDataSenarai_Lesen").DataTable({
                "retrieve": true,
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
                "ajax":
                {
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPerolehan_Lesen") %>',
                    type: 'POST',
                    data: function (d) {
                        return "{ IdMohon: '" + newNoMohon + "', IdJualan: '" + newIdJualan + "' }"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },



                "columns": [

                    {
                        "data": "Bil",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    {
                        "data": "Kod_Lesen",
                        "width": "10%"
                    },
                    {
                        "data": "Butiran",
                        "width": "30%"
                    },
                    {
                        "data": "Maklumat_Lanjut",
                    },
                    {
                        "data": null,
                        "render": function (data, type, row) {
                            return `
                                <div class="row ">
                                    <div class="col-md-1">
                                        <button type="button" class="btn btnDeleteLesen" id="btnDeleteLesen"  style="padding:0px 0px 0px 0px" title="Papar">
                                            <i class="fa fa-trash btnDeleteLesen"></i>
                                        </button>
                                    </div>
                                </div>
                            `;
                        }
                    },
                    {
                        "data": "Id_Lesen",
                        "visible": false,
                    }

                ],

                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    // Add click event
                    $(row).on("click", function () {



                    });
                },
            });
        });


        $(document).ready(function () {


            DtlSenarai_Lesen3 = $("#tblDataSenarai_Lesen3").DataTable({
                "retrieve": true,
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
                "ajax":
                {
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPerolehan_Lesen") %>',
                    type: 'POST',
                    data: function (d) {
                        return "{ IdMohon: '" + newNoMohon + "', IdJualan: '" + newIdJualan + "' }"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },



                "columns": [

                    {
                        "data": "Bil",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    {
                        "data": "Kod_Lesen",
                        "width": "10%"
                    },
                    {
                        "data": "Butiran",
                        "width": "30%"
                    },
                    {
                        "data": "Maklumat_Lanjut",
                    },


                ],

                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    // Add click event
                    $(row).on("click", function () {



                    });
                },
            });
        });


        $("#tblDataSenarai_Lesen").off('click', '.btnDeleteLesen').on("click", ".btnDeleteLesen", function (event) {
            var row = $(this).closest('tr');
            var dataTable = $('#tblDataSenarai_Lesen').DataTable();

            var Id_Lesen_dt = dataTable.cell(row, 5).data(); //DELETE ROWS BASED ON THIS ID


            var msg = "Anda pasti ingin padam maklumat Lesen ini?";
            //console.log("txtMasa_Lawatan=", $('#txtMasa_Lawatan').val())
            $('#confirmationMessage10').text(msg);
            $('#saveConfirmationModal10').modal('show');
            //$('#maklumatPermohonanModal').modal('hide');


            $('#confirmSaveButton10').off('click').on('click', async function () {
                $('#saveConfirmationModal10').modal('hide');



                var newDeleteLesen_Dtl = {

                    DeleteLesen_Dtl: {

                        Id_Lesen_Dtl: $('#txtId_Lesen_Dtl').val(),
                    }

                };


                try {
                    var result = JSON.parse(await deleteDaftarLesen(Id_Lesen_dt))

                    if (result.Status === true) {
                        showModal10("Success", result.Message, "success");

                        //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                    } else {
                        showModal10("Error", result.Message, "error");
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }
            });
        });


        async function deleteDaftarLesen(Id_Lesen_dt) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/DeletePerolehan_Lesen") %>',
                    method: 'POST',
                    data: JSON.stringify({ Id_Lesen_Dtl: Id_Lesen_dt }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        DtlSenarai_Lesen.ajax.reload();
                        DtlSenarai_Lesen3.ajax.reload();
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            });
        }

        $(document).ready(function () {


            tblRingkasanCidb = $("#tblDataKod_Bidang").DataTable({
                "retrieve": true,
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
                "ajax":
                {
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_BidangMof") %>',
                    type: 'POST',
                    data: function (d) {
                        return "{ id: '" + newNoMohon + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },



                "columns": [

                    {
                        "data": "Bil",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    { "data": "Kod_Bidang" },
                    { "data": "Butiran" },
                    { "data": "Syarat" },

                ],

                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    // Add click event
                    $(row).on("click", function () {



                    });
                },
            });
        });


        $('#btnHantarProcess').off('click').on('click', async function () {
            var msg = "Anda pasti ingin menghantar maklumat jualan naskah ini?";
            //console.log("txtMasa_Lawatan=", $('#txtMasa_Lawatan').val())
            $('#confirmationMessage10').text(msg);
            $('#saveConfirmationModal10').modal('show');
            //$('#maklumatPermohonanModal').modal('hide');


            $('#confirmSaveButton10').off('click').on('click', async function () {
                $('#saveConfirmationModal10').modal('hide');



                var newHantarNaskah_Jualan_Dtl = {

                    HantarNaskah_Jualan_Dtl: {

                        txtNoMohon: newNoMohon,
                        txtIdJualan: $("#txtNoNaskah_Jualan").val(),
                        txtTarikh_Daftar: $("#txtTarikh_Mohon").val(),
                        txtNo_Sebut_Harga: $("#txtNo_SHT").val(),
                        //txtNo_Sebut_Harga:'UTeM/SH/002/2024',

                        txtHarga: $("#txtHarga_Naska").val(),
                        txtGred_CIDB: KodGred_CIDB,
                        txtLawatan_Tapak: txtLawatanTempat,
                        txtTempat_Lawatan_Tapak: $("#txtTempat_Tapak").val(),
                        txtTarikh_Masa_Lawatan_Tapak: $('#txtMasa_Lawatan').val(),
                        txtTarikh_Masa_Mula_Iklan: $("#txtTarikh_Mula_Iklan").val(),
                        txtTarikh_Masa_Mula_Perolehan: $("#txtTarikh_Mula_Perolehan").val(),
                        txtTarikh_Masa_Tamat_Perolehan: $("#txtTarikh_Tamat_Perolehan").val() + ' ' + $("#txtMasa_Tamat_Perolehan").val(),
                        txtTempat_Hantar: $("#txtTempat_Hantar").val(),
                        txtNo_Staf: $("#txtId_Pemohon").val(),
                        txtSyarat_Perolehan: $("#txtUlasan").val(),
                        //txtStatus_Lanjut: $("#txtStatus").val(),
                        txtStatus_Lanjut: '01',
                        txtStatus: 1,
                        ddlKodPTj: $("#txtNo_PTj").val(),
                        ddlNo_Perolehan: newNo_Perolehan,
                        txtFlag_PenentuanTeknikal: 1,
                        txtStatusDokH: 35,
                    }

                };


                try {
                    var result = JSON.parse(await HantarProcessJN(newHantarNaskah_Jualan_Dtl))

                    if (result.Status === true) {
                        showModal10("Success", result.Message, "success");
                        //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                        tblNJ.ajax.reload();
                        loadMaklumatIklan();
                    } else {
                        showModal10("Error", result.Message, "error");
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }
            });
        });


        async function HantarProcessJN(HantarNaskah_Jualan_Dtl) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadeUpdateMaklumat_JN_SD") %>',
                    method: 'POST',
                    data: JSON.stringify(HantarNaskah_Jualan_Dtl),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        tblNJ.ajax.reload();
                        loadMaklumatIklan();
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
