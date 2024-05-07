<%@ Page Title="" Async="true" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Daftar_Pesanan_Belian.aspx.vb" Inherits="SMKB_Web_Portal.Daftar_Pesanan_Belian" %>

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
                        <h5 class="modal-title" id="exampleModalCenterTitle">Pendaftaran Pesanan Belian</h5>

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
                                            <option value="2">DAFTAR PESANAN BELIAN</option>
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
                                            <th scope="col">Tarikh Mohon</th>
                                            <th scope="col">Tarikh Lulus</th>
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
                        <h5 class="modal-title">Maklumat Pesanan Belian (PO)</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">


                        <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">

                            <li class="nav-item px-2 nav-show" style="display: none;" role="presentation">
                                <button class="nav-link active" id="maklumatPO-tab" data-toggle="tab" data-target="#perolehan" type="button" role="tab">Maklumat Perolehan</button>
                            </li>
                            <li class="nav-item px-2 nav-show" style="display: none;" role="presentation">
                                <button class="nav-link btnSearchAm" id="spesifikasiAm-tab" data-toggle="tab" data-target="#spesifikasi-am" type="button" role="tab">Lampiran Pesanan Belian</button>
                            </li>
                            <li class="nav-item px-2" role="presentation">
                                <button class="nav-link" id="bajet-tab" data-toggle="tab" data-target="#bajet-dan-spesifikasi" type="button" role="tab">Maklumat Tambahan</button>
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
                                                <input class="input-group__input " id="txtIdPembelian" type="text" placeholder="&nbsp;" name="No Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Perolehan">Id Pembelian :	</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtNo_Perolehan" type="text" placeholder="&nbsp;" name="No Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Perolehan">No Perolehan :	</label>
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

                                    </div>
                                    <div class="form-row">

                                        <div class="col-md-12">
                                            <div class=" form-group">
                                                <textarea class="input-group__input" id="txtTujuan" readonly style="background-color: #f0f0f0; height: auto" rows="3"></textarea>
                                                <label class="input-group__label" for="Tujuan">Tujuan Perolehan :</label>
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
                                                <input class="input-group__input " id="txtPTJ_Mohon" type="text" placeholder="&nbsp;" name="txtPTJ_Mohon" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtPTJ_Mohon">PTJ Mohon:</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtPemohon_Name" type="text" placeholder="&nbsp;" name="txtPemohon_Name" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtPemohon_Name">Pemohon :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtJawatan_Pemohon" type="text" placeholder="&nbsp;" name="txtJawatan_Pemohon" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtJawatan_Pemohon">Jawatan :</label>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-6">
                                            <div>
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
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Mula_Perolehan" type="date" placeholder="&nbsp;" name="txtTarikh_Mula_Perolehan" style="background-color: white" />
                                                <label class="input-group__label" for="txtTarikh_Mula_Perolehan">Tarikh Mula:</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Tamat_Perolehan" type="date" placeholder="&nbsp;" name="txtTarikh_Tamat_Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtTarikh_Tamat_Perolehan">Tarikh Tamat:</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-6">
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTempoh" type="number" placeholder="&nbsp;" name="txtTempoh" style="background-color: white" />
                                                <label class="input-group__label" for="txtTempoh">Tempoh Bekal/Siap :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-3">
                                            <div>
                                                <div class="form-row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <select class="input-group__select ui search dropdown JenTransaksi" name="txtJenis_tempoh" id="txtJenis_tempoh" placeholder="&nbsp;">
                                                            </select>
                                                            <label class="input-group__label" for="txtJenis_tempoh"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <div class="transaction-table table-responsive">
                                                <table id="tblDataPerolehanDtl" class="table table-striped" style="width: 99%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Id_Mohon_Dtl</th>
                                                            <th scope="col">Bil</th>
                                                            <th scope="col">KW</th>
                                                            <th scope="col">KO</th>
                                                            <th scope="col">PTJ</th>
                                                            <th scope="col">KP</th>
                                                            <th scope="col">Vot</th>
                                                            <th scope="col">Barang / Perkara</th>
                                                            <th scope="col">Ang. Harga (RM)</th>
                                                            <th scope="col">Jenama</th>
                                                            <th scope="col">Model</th>
                                                            <th scope="col">Negara Pembuat</th>
                                                            <th scope="col">Kuantiti</th>
                                                            <th scope="col">Ukuran</th>
                                                            <th scope="col">Negara Pembuat</th>
                                                            <th scope="col">Anggaran Harga Seunit (RM)</th>
                                                            <th scope="col">Inclusive SST? Kadar: 0%</th>
                                                            <th scope="col">Harga SST (RM)</th>
                                                            <th scope="col">Jum. Harga (Tampa SST) (RM)</th>
                                                            <th scope="col">Jum. Harga (Termasuk SST) (RM)</th>
                                                            <th scope="col">Tindakan</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <th colspan="20" style="text-align: right; white-space: nowrap;">Jumlah:</th>
                                                        </tr>
                                                    </tfoot>

                                                </table>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col text-center m-3">
                                        <button type="button" id="btnSinpanHdr" class="btn btn-secondary " data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                                        <input hidden  id="txtKod_Ptj" />
                                        
                                    </div>
                                </div>


                            </div>
                            <!-- End of Maklumat Perolehan Tab -->


                            <!-- tab 2 (Maklumat Spesifikasi Am) -->
                            <div class="tab-pane fade" id="spesifikasi-am" role="tabpanel">

                                <div class="card card-body">
                                    <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Lampiran Pesanan Belian :</h6>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">

                                                <div class="form-group" style="margin-left: 7px">
                                                    <p style="margin-bottom: unset"><strong>Jenis-jenis dokumen:</strong> </p>
                                                    <input type="radio" id="DokumenType_0" name="DokumenType" value="X">
                                                    <label style="margin-bottom: unset; font-weight: unset" for="html">Maklumat Kajian Pasaran</label>
                                                    <br>
                                                    <input type="radio" id="DokumenType_1" name="DokumenType" value="K">
                                                    <label style="margin-bottom: unset; font-weight: unset" for="css">Gambar/Katalog</label>
                                                    <br>
                                                    <input type="radio" id="DokumenType_2" name="DokumenType" value="L">
                                                    <label style="margin-bottom: unset; font-weight: unset" for="javascript">Lain-Lain</label>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="card">
                                                <div class="form-group" style="margin-top: 10px; margin-left: 10px">
                                                    <input type="file" id="uploadDokumen" class="form-control-file" />
                                                    <small class="form-text text-muted">Jenis fail yang dibenarkan: .pdf only (Saiz Maksimum: 5MB)</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-md-6 mt-3">
                                            <input class="input-group__input" name="namaFail" id="namaFail" type="text" placeholder="&nbsp;" />
                                            <label class="input-group__label" for="namaFail" style="left: unset">Nama Fail</label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-md-6 mt-3">
                                            <button class="btn btn-secondary" id="savedokumen">Muat Naik</button>
                                        </div>
                                    </div>
                                </div>


                                <p>Lampiran</p>
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblSimpanUpload" class="table table-striped" style="width: 99%">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Id_Upload</th>
                                                    <th scope="col">File Path</th>
                                                    <th scope="col">Bil</th>
                                                    <th scope="col">Nama Fail</th>
                                                    <th scope="col">Tindakan</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>


                            </div>
                            <!-- tab 2 (Maklumat Spesifikasi Am) -->


                            <!-- tab 3 (Maklumat Bajet dan Spesifikasi) -->
                            <div class="tab-pane fade" id="bajet-dan-spesifikasi" role="tabpanel">

                                <div class="">
                                    <div class="form-row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtNo_Pesanan_Belian3" type="text" placeholder="&nbsp;" name="No Permohonan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Permohonan">No Pesanan Belian (PO) :</label>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Daftar3" type="date" placeholder="&nbsp;" name="Tarikh Daftar" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Tarikh Daftar">Tarikh Daftar PO :</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtTarikh_Lulus3" type="date" placeholder="&nbsp;" name="txtTarikh_Lulus3" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtTarikh_Lulus3">Tarikh Lulus PO :</label>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-row">

                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <select class="input-group__select ui search dropdown JenTransaksi" name="Pelulus PO" id="txtPelulus_PO3" placeholder="&nbsp;" style="background-color: white">
                                                </select>
                                                <label class="input-group__label" for="Tarikh Keperluan">Pelulus PO :</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input class="input-group__input " id="txtJawGiliran3" type="text" placeholder="&nbsp;" name="txtJawGiliran3" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtJawGiliran3"></label>
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

        <!-- Modal Update tblDataPerolehanDtl        name id: updateTblPoDtl -->
        <div class="modal fade" id="updateTblPoDtl" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Kemaskini Maklumat </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-lg-12">
                                        <label>COA</label>
                                        <div class="responsive">
                                            <select class="form-control ui search dropdown" name="ddlCOA_update" id="ddlCOA_update" disabled>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-lg-3">
                                        <label>Kod PTj</label>
                                        <input type="text" class="form-control" placeholder="Kod PTj" id="ddlPTj_update" name="ddlPTj_update" readonly />
                                    </div>

                                    <div class="form-group col-lg-3">
                                        <label>Kumpulan Wang</label>
                                        <input type="text" class="form-control" placeholder="Kumpulan Wang" id="ddlKW_update" name="ddlKW_update" readonly />
                                    </div>

                                    <div class="form-group col-lg-3">
                                        <label>Kod Operasi</label>
                                        <input type="text" class="form-control" placeholder="Kod Operasi" id="ddlKodOperasi_update" name="ddlKodOperasi_update" readonly />
                                    </div>

                                    <div class="form-group col-lg-3">
                                        <label>Kod Projek</label>
                                        <input type="text" class="form-control" placeholder="Kod Projek" id="ddlKodProjek_update" name="ddlKodProjek_update" readonly />
                                    </div>



                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label>Barang / Perkara</label>
                                        <textarea class="form-control" placeholder="Barang / Perkara" id="txtPerkara_update" name="txtPerkara_update" readonly></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-lg-3">
                                        <label>Kuantiti</label>
                                        <input type="text" class="form-control" placeholder="Kuantiti" id="txtKuantiti_update" name="txtKuantiti_update" oninput="formatInput(this)" readonly />
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <label>Ukuran</label>
                                        <div class="responsive">
                                            <select class="form-control ui search dropdown" name="ddlUkuran_update" id="ddlUkuran_update" disabled>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <label>Anggaran Harga Seunit</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">RM</div>
                                            </div>
                                            <input type="text" class="form-control" placeholder="Anggaran Harga Seunit" id="txtAngHrgSeunit_update" name="txtAngHrgSeunit_update" oninput="formatInput(this)" readonly />
                                        </div>
                                    </div>
                                    <div class="form-group col-lg-4">
                                        <!-- jumlah anggaran harga kena add function tarik value duit from db and format value tu dalam bentuk duit -->
                                        <label>Jumlah Anggaran Harga</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">RM</div>
                                            </div>
                                            <input type="text" class="form-control" placeholder="Jumlah Anggaran Harga" id="txtJumAngHrg_update" name="txtJumAngHrg_update" oninput="formatInput(this)" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-4">
                                        <label>Jenama</label>
                                        <input type="text" class="form-control" placeholder="Jenama" id="txtJenama_update" name="txtJenama_update" oninput="formatInput(this)" />
                                    </div>

                                    <div class="form-group col-lg-4">
                                        <label>Model</label>
                                        <input type="text" class="form-control" placeholder="Model" id="txtModal_update" name="txtModal_update" oninput="formatInput(this)" />

                                    </div>
                                    <div class="form-group col-lg-4">
                                        <label>Negara Pembuat</label>
                                        <div class="responsive">
                                            <select class="form-control ui search dropdown" name="ddlNegara_Pembuat_update" id="ddlNegara_Pembuat_update">
                                            </select>
                                        </div>
                                    </div>
                                    <%--<div class="form-group col-lg-3">
                                        <label>Kadar SST (%):</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">%</div>
                                            </div>
                                            <input type="text" class="form-control" placeholder="txtKadar_SST_update" id="txtKadar_SST_update" name="txtKadar_SST_update" oninput="formatInput(this)">
                                        </div>
                                    </div>--%>
                                </div>
                                <div class="form-row">

                                    <div class="form-group col-lg-6">
                                        <!-- jumlah anggaran harga kena add function tarik value duit from db and format value tu dalam bentuk duit -->
                                        <label>Harga Seunit (Tanpa SST) (RM)</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">RM</div>
                                            </div>
                                            <input type="text" class="form-control" placeholder="Harga Seunit" id="txtHarga_Seunit_Tanpa_GST_update" name="txtHarga_Seunit_Tanpa_GST_update" oninput="formatInput(this)">
                                        </div>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>Inclusive SST? Kadar: 0%</label>
                                        <div class="responsive">
                                            <select id="txtFlag_sst" class="custom-select">
                                                <option value="" selected="-SILA PILIH-">-SILA PILIH-</option>
                                                <option value="Ya">Ya</option>
                                                <option value="Tidak">Tidak</option>

                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <%--<button type="button" class="btn btn-danger btnReset" data-placement="bottom" title="Padam">Padam</button>--%>
                        <!-- reset -->
                        <button type="button" class="btn btn-secondary btnKemaskini" data-placement="bottom" title="Kemaskini">Kemaskini</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Modal Update Pengesahan-->
    <div class="modal fade" id="saveConfirmationModalUpdate3" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabelUpdate3">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessageUpdate3"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="confirmSaveButtonUpdate3">Ya</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Update Result -->
    <div class="modal fade" id="resultModalUpdate3" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabelUpdate3">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="resultModalMessageUpdate3"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Update Pengesahan-->
    <div class="modal fade" id="saveConfirmationModalUpdate10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabelUpdate10">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessageUpdate10"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="confirmSaveButtonUpdate10">Ya</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Update Result -->
    <div class="modal fade" id="resultModalUpdate10" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabelUpdate10">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="resultModalMessageUpdate10"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

      <!-- Modal Update Pengesahan-->
  <div class="modal fade" id="saveConfirmationModalUpdate11" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
      <div class="modal-dialog " role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title" id="saveConfirmationModalLabelUpdate11">Pengesahan</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <div class="modal-body">
                  <p id="confirmationMessageUpdate11"></p>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                  <button type="button" class="btn btn-secondary" id="confirmSaveButtonUpdate11">Ya</button>
              </div>
          </div>
      </div>
  </div>
  <!-- Modal Update Result -->
  <div class="modal fade" id="resultModalUpdate11" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title" id="resultModalLabelUpdate11">Makluman</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <div class="modal-body">
                  <p id="resultModalMessageUpdate11"></p>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
              </div>
          </div>
      </div>
  </div>

    <div class="modal fade" id="formatSimpanLampiran" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center" id="lampirantitle"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="lampiranbody"></p>
                </div>
                <div class="modal-footer" style="padding: 2px">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Delete Lampiran-->
    <div class="modal fade" id="saveConfirmationModalDeleteLampiran" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabelDeleteLampiran">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessageDeleteLampiran"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="confirmSaveButtonDeleteLampiran">Ya</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Delete Result Lampiran -->
    <div class="modal fade" id="resultModalDeleteLampiran" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabelDeleteLampiran">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="resultModalMessageDeleteLampiran"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    
    <%--Function to check if all input fields have data and enable the button accordingly--%>
    <script type="text/javascript">

        // Get references to the input fields and the button
        const txtTarikh_Mula_Perolehan = document.getElementById('txtTarikh_Mula_Perolehan');
        const txtTempoh = document.getElementById('txtTempoh');
       

        const selecttxtVendo = document.getElementById('txtVendo');
        const selecttxtJenis_tempoh = document.getElementById('txtJenis_tempoh');
        const btnSimpan = document.getElementById('btnSinpanHdr');
        

        btnSimpan.disabled = true;
        


        // Function to check if all input fields have data and enable the button accordingly
        function checkInputs() {

            const txtTarikh_Mula_PerolehanValue = txtTarikh_Mula_Perolehan.value.trim();
            const txtTempohValue = txtTempoh.value.trim();



            // If all fields have data, enable the button
            if (txtTarikh_Mula_PerolehanValue !== '' && txtTempohValue !== ''  && KodVendo !== '' && KodJenis_tempoh !=='') {
                btnSimpan.disabled = false;
            } else {
                btnSimpan.disabled = true;
            }
        }

        // Add event listeners to input fields
        txtTarikh_Mula_Perolehan.addEventListener('input', checkInputs);
        txtTempoh.addEventListener('input', checkInputs);
        txtTempat.addEventListener('input', checkInputs);

        selecttxtVendo.addEventListener('change', checkInputs);
        selecttxtJenis_tempoh.addEventListener('change', checkInputs);
    </script>



    <script type="text/javascript">

        var txtLawatanTempat = '';
        var DtlSenarai_Lesen;
        var tblRingkasanCidb;
        var newNo_Perolehan = "";

        var category_filter;
        isClicked = false;

        var tblPerolehanDtl = null;

        var Id_Mohon_Dtl_PB_Data = '';
        var NewKod_PTj = "";

        var kodNo_skyt = "";
        var rowDataArray = [];

        document.getElementById('txtTempoh').addEventListener('input', updateEndDate);
        document.getElementById('txtTarikh_Mula_Perolehan').addEventListener('input', updateEndDate);
        
        function updateEndDate() {

            let startDate = new Date(document.getElementById('txtTarikh_Mula_Perolehan').value);
            let tempoh = parseInt(document.getElementById('txtTempoh').value);
            let jenisTempoh = KodJenis_tempoh;

            //console.log("startDate =", startDate);
            //console.log("tempoh =", tempoh );
            //console.log("jenisTempoh=", jenisTempoh);

            if (!isNaN(tempoh) && startDate instanceof Date && !isNaN(startDate.getTime())) {
                let endDate = new Date(startDate);

                switch (jenisTempoh) {
                    case '01':
                        endDate.setDate(endDate.getDate() + tempoh);
                        break;
                    case '02':
                        endDate.setDate(endDate.getDate() + (tempoh * 7));
                        break;
                    case '03':
                        endDate.setMonth(endDate.getMonth() + tempoh);
                        break;
                    case '04':
                        endDate.setFullYear(endDate.getFullYear() + tempoh);
                        break;
                    default:
                        break;
                }

                document.getElementById('txtTarikh_Tamat_Perolehan').value = endDate.toISOString().split('T')[0];
            }
        }

        $(document).ready(function () {
            tblPerolehanDtl = $("#tblDataPerolehanDtl").DataTable({
                "responsive": true,
                "searching": false,
                "info": false,
                "paging": false,
                "ordering": false,
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadOrderRecord_Maklumat_PerolehanDtl") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ id: Id_MohonDtl })
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }
                },


                footerCallback: function (row, data, start, end, display) {
                    let api = this.api();

                    // Remove the formatting to get integer data for summation
                    let intVal = function (i) {
                        return typeof i === 'string'
                            ? i.replace(/[\$,]/g, '') * 1
                            : typeof i === 'number'
                                ? i
                                : 0;
                    };

                    // Total over all pages
                    total = api
                        .column(19)
                        .data()
                        .reduce((a, b) => intVal(a) + intVal(b), 0);

                    // Total over this page
                    pageTotal = api
                        .column(19, { page: 'current' })
                        .data()
                        .reduce((a, b) => intVal(a) + intVal(b), 0);


                    // Update footer
                    api.column(19).footer().innerHTML =
                        'RM' + pageTotal.toFixed(2);
                },


                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "columns": [
                    { "data": "Id_Mohon_Dtl", "title": "Id_Mohon_Dtl" }, //Hidden
                    { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                    { "data": "Kod_Kump_Wang", "title": "KW" },
                    { "data": "Kod_Operasi", "title": "KO" },
                    { "data": "Kod_Ptj", "title": "PTJ" },
                    { "data": "Kod_Projek", "title": "KP" },
                    { "data": "Kod_Vot", "title": "Vot" },
                    { "data": "Butiran", "title": "Barang / Perkara" },
                    { "data": "Kadar_Harga", "title": "Ang. Harga (RM)" },
                    { "data": "Kuantiti", "title": "Kuantiti" },
                    { "data": "Ukuran", "title": "Ukuran" },
                    {
                        "data": "Jumlah_Harga_A",
                        "title": "Jumlah Anggaran Harga (RM)"
                    },
                    { "data": "Jenama", "title": "Jenama" },
                    { "data": "Model", "title": "Model" },
                    { "data": "Kod_Negara_Pembuat", "title": "Negara Pembuat" },
                    { "data": "Harga_Seunit_B", "title": " Harga Seunit (Tampa SST) (RM)" },
                    { "data": "Flag_SST", "title": " Inclusive SST? Kadar: 0%" },
                    {"data": "Syor_Harga","title": " Harga SST (RM)" },
                    {
                        "data": "Jumlah_Harga_B",
                        "title": " Jum. Harga (Tampa SST) (RM)"
                    },
                    { "data": "Jumlah_Harga_Bercukai_B", "title": " Jum. Harga (Termasuk SST) (RM)" },
                    { "data": null, "title": "Tindakan" }
                ],
                "columnDefs": [
                    {
                        "targets": 0,
                        visible: false,
                        searchable: false
                    },
                    {
                        "targets": 1,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                    {
                        "targets": -1, // Target the last column (Delete column)
                        "data": null,
                        "render": function (data, type, row) {
                            return `
                    <div class="row">
                        <div class="col-md-2">
                            <button type="button" class="btn editBtn" style="padding:0px 0px 0px 0px" title="Kemaskini" data-toggle="modal" data-target="#updateTblPoDtl">
                            <i class="far fa-edit fa-lg"></i>
                            </button>
                        </div>
                    </div>`;
                        }
                    }
                ]
            });



            // Event listener for Update & Edit button on tblDataPerolehanDtl
            $("#tblDataPerolehanDtl").off('click', '.editBtn').on("click", ".editBtn", function (event) {
                //Get row id
                var row = $(this).closest('tr');
                var dataTable = $('#tblDataPerolehanDtl').DataTable();

                id_mohon_dtl_hidden = dataTable.cell(row, 0).data(); //EDIT & UPDATE ROWS BASED ON THIS ID
                console.log('id_mohon_dtl_hidden=', id_mohon_dtl_hidden)
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPoDtlMaklumat_PerolehanDtl") %>',
                    //url: "PermohonanPoWS.asmx/LoadPoDtlRowData",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ id: id_mohon_dtl_hidden }),
                    success: function (data) {
                        var jsonData = JSON.parse(data.d);

                        //Get the data from LoadPoDtlRowData and assign it's values
                        var dropdownCoaVot = $("#ddlCOA_update");
                        var selectObjectCoaVot = $("#ddlCOA_update");
                        selectObjectCoaVot.empty();
                        $(dropdownCoaVot).dropdown('active selected', jsonData[0].Kod_Vot); //Make dropdown select based on ukuran value from query
                        selectObjectCoaVot.append("<option value= '" + jsonData[0].Kod_Vot + " '>" + jsonData[0].Kod_Vot + ' - ' + jsonData[0].Butiran_vot + "</option>"); //Display the ukuran dropdown
                        kod_coa_vot = jsonData[0].Kod_Vot;
                        kod_PTj = jsonData[0].Kod_Ptj;
                        kod_KW = jsonData[0].Kod_Kump_Wang;
                        kod_Operasi = jsonData[0].Kod_Operasi;
                        kod_Projek = jsonData[0].Kod_Projek;
                        Id_Mohon_Dtl_PB_Data = jsonData[0].Id_Mohon_Dtl_PB

                        $("#ddlPTj_update").val(jsonData[0].Butiran_ptj);
                        $("#ddlKW_update").val(jsonData[0].Butiran_kw);
                        $("#ddlKodOperasi_update").val(jsonData[0].Butiran_ko);
                        $("#ddlKodProjek_update").val(jsonData[0].Butiran_kp);
                        $("#txtBakiPeruntukan_update").val(jsonData[0].Baki_Peruntukan);
                        $("#txtPerkara_update").val(jsonData[0].Butiran);
                        $("#txtKuantiti_update").val(jsonData[0].Kuantiti);

                        var dropdownUkuran = $("#ddlUkuran_update");
                        var selectObjectUkuran = $("#ddlUkuran_update");
                        selectObjectUkuran.empty();
                        $(dropdownUkuran).dropdown('active selected', jsonData[0].Ukuran); //Make dropdown select based on ukuran value from query
                        selectObjectUkuran.append("<option value= '" + jsonData[0].Ukuran + " '>" + jsonData[0].Butiran_ukuran + "</option>"); //Display the ukuran dropdown
                        ukuranValue = jsonData[0].Ukuran;


                        $('#ddlNegara_Pembuat_update').dropdown('clear');
                        var selectOptionsNegara = '';
                        jsonData.forEach(function (item) {
                            selectOptionsNegara += '<option value="' + item.Kod_Negara_Pembuat + '">' + item.Negara_Pembuat + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                        });
                        // Update dropdown select
                        if (jsonData[0].Kod_Negara_Pembuat !== '' || jsonData[0].Kod_Negara_Pembuat !== null) {
                            $('#ddlNegara_Pembuat_update').html(selectOptionsNegara);
                            KodNegara = jsonData[0].Kod_Negara_Pembuat;
                        };



                        $("#txtAngHrgSeunit_update").val(jsonData[0].Kadar_Harga_A);

                        if (jsonData[0].Jumlah_Harga_PB !== '' || jsonData[0].Jumlah_Harga_PB !== null) {
                            $("#txtJumAngHrg_update").val(jsonData[0].Jumlah_Harga_PB);
                        } else {
                            $("#txtJumAngHrg_update").val(jsonData[0].Jumlah_Harga_A);
                        };
                        

                        $('#txtFlag_sst').val(jsonData[0].Flag_SST),

                        $('#txtHarga_Seunit_Tanpa_GST_update').val(jsonData[0].Harga_Seunit_PB),
                        $('#txtModal_update').val(jsonData[0].Model),
                        $('#txtJenama_update').val(jsonData[0].Jenama)
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });

            });


        });

        //Insert data with bootstrap modal
        $('.btnKemaskini').off('click').on('click', async function () {
            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
            // Remove commas from the input value 
            //var txtBakiPeruntukanDecimal = $('#txtBakiPeruntukan_update').val().replace(/,/g, '');
            var txtKuantitiDecimal = $('#txtKuantiti_update').val().replace(/,/g, '');
            //var txtAngHrgSeunitDecimal = $('#txtAngHrgSeunit_update').val().replace(/,/g, '');
            var txtJumAngHrgDecimal = $('#txtHarga_Seunit_Tanpa_GST_update').val().replace(/,/g, '') * $('#txtKuantiti_update').val().replace(/,/g, '');
            var percentage = 8 / 100; // 8% as a decimal

            if ($('#txtFlag_sst').val() === 'Ya') {
                var txtJumAngHrgSST = (txtJumAngHrgDecimal * percentage) * 1 + (txtJumAngHrgDecimal) * 1;
                var txtAngHrgSeunitSST = ($('#txtHarga_Seunit_Tanpa_GST_update').val().replace(/,/g, '') * percentage) * 1 + ($('#txtHarga_Seunit_Tanpa_GST_update').val().replace(/,/g, '')) * 1;
            } else {
                var txtJumAngHrgSST = txtJumAngHrgDecimal;
                var txtAngHrgSeunitSST =$('#txtHarga_Seunit_Tanpa_GST_update').val().replace(/,/g, '');
            }
            
            // Set message in the modal
            console.log("txtJumAngHrgDecimal", txtJumAngHrgDecimal)
            console.log("txtJumAngHrgSST", txtJumAngHrgSST)
            console.log("txtAngHrgSeunitSST", txtAngHrgSeunitSST)
            var msg = "Anda pasti ingin mengemaskini rekod ini? ";
            $('#confirmationMessageUpdate3').text(msg);
            // Open the Bootstrap modal
            $('#saveConfirmationModalUpdate3').modal('show');

            $('#confirmSaveButtonUpdate3').off('click').on('click', async function () {
                $('#saveConfirmationModalUpdate3').modal('hide'); // Hide the modal

                //var sst = ($('#txtKadar_SST_update').val() / 100);
                //var hguSST = ((txtAngHrgSeunitDecimal * sst)*1 + (txtAngHrgSeunitDecimal)*1 )
                //console.log('sst=', sst);
                //console.log("hguSST",hguSST)

                var newPembelianPoDtl = {
                    pembelianPoDetail: {
                        id_mohonDtl: id_mohon_dtl_hidden || '',
                        id_MohonDTL_PB: Id_Mohon_Dtl_PB_Data || '',
                        coa_vot: kod_coa_vot || '',
                        ddlPTj: kod_PTj || '',
                        ddlKW: kod_KW || '',
                        ddlKodOperasi: kod_Operasi || '',
                        ddlKodProjek: kod_Projek || '',
                        //txtBakiPeruntukan: txtBakiPeruntukanDecimal,
                        txtPerkara: $('#txtPerkara_update').val(),
                        txtKuantiti: txtKuantitiDecimal || '',
                        ddlUkuran: ukuranValue || '',
                        txtAngHrgSeunit: $('#txtHarga_Seunit_Tanpa_GST_update').val() || '',
                        txtJumAngHrg: txtJumAngHrgDecimal || '',
                        txtKadar_SST_update: $('#txtKadar_SST_update').val(),
                        txtModal_update: $('#txtModal_update').val(),
                        txtJenama_update: $('#txtJenama_update').val(),
                        ddlNegara_Pembuat_update: KodNegara || '',
                        txtFlag_sst: $('#txtFlag_sst').val() || '',
                        txtHarga_Seunit_Tanpa_GST_update: $('#txtHarga_Seunit_Tanpa_GST_update').val(),
                        ddlId_Pembelian: $("#txtIdPembelian").val() || '',
                        txtAngHrgSeunitSST: txtAngHrgSeunitSST,
                        txtJumAngHrgSST: txtJumAngHrgSST,

                    }
                }


                var result = JSON.parse(await ajaxUpdate_PembelianDtl(newPembelianPoDtl));
                if (result.Status === "success") {
                    showModalUpdate3("Success", result.Message, "success");
                } else {
                    showModalUpdate3("Error", result.Message, "error");
                }
                tbl.ajax.reload(); //Reload datatable
            });
        });
        async function ajaxUpdate_PembelianDtl(pembelianPoDetail) {

            return new Promise((resolve, reject) => {

                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/UpdatePO_Pesanan_belian") %>',
                    //url: 'PermohonanPoWS.asmx/UpdatePO_BajetSpesifikasi',
                    method: 'POST',
                    data: JSON.stringify(pembelianPoDetail),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        tblPerolehanDtl.ajax.reload();
                        $('#updateTblPoDtl').modal('toggle');
                        //$('#transaksi').modal('toggle');

                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            })
            console.log("tst")
        }

        //Insert 
        $('#btnSinpanHdr').off('click').on('click', async function () {

            var msg = "";

            // Set message in the modal
            var msg = "Anda pasti ingin mengemaskini rekod ini? ";
            $('#confirmationMessageUpdate10').text(msg);
            // Open the Bootstrap modal
            $('#saveConfirmationModalUpdate10').modal('show');

            $('#confirmSaveButtonUpdate10').off('click').on('click', async function () {
                $('#saveConfirmationModalUpdate10').modal('hide'); // Hide the modal

                const currentDate = new Date().toISOString().split('T')[0];

                tblPerolehanDtl.rows().every(function (index, element) {
                    var rowData = this.data();
                    var Kod_Kump_Wang = rowData.Kod_Kump_Wang;
                    var Kod_Operasi = rowData.Kod_Operasi;
                    var Kod_Ptj = rowData.Kod_Ptj;
                    var Kod_Projek = rowData.Kod_Projek;
                    var Kod_Vot = rowData.Kod_Vot;
                    var Jumlah_Harga = rowData.Jumlah_Harga_Bercukai_B

                    var rowObject = {
                        Kod_Kump_Wang: Kod_Kump_Wang,
                        Kod_Operasi: Kod_Operasi,
                        Kod_Ptj: Kod_Ptj,
                        Kod_Projek: Kod_Projek,
                        Kod_Vot: Kod_Vot,
                        Jumlah_Harga: Jumlah_Harga,
                    };
                    rowDataArray.push(rowObject);
                });


                var newPembelianPoHdr = {
                    pembelianPoHeder: {

                        ddlKod_Pemiutang: Kod_Pemiutang || '',
                        ddlId_Pembelian: $("#txtIdPembelian").val() || '',
                        ddlNo_Mohon: newNoMohon || '',
                        ddlKod_Syarikat: kodNo_skyt || '',
                        ddlTarikh_Beli: currentDate || '',
                        ddlTempoh: $('#txtTempoh').val() || '',
                        ddlJenis_Tempoh: KodJenis_tempoh || '',
                        ddlTarikh_Terima: $('#txtTarikh_Mula_Perolehan').val() || '',
                        ddlTarikh_Hantar: $('#txtTarikh_Tamat_Perolehan').val() || '',
                        ddlID_Syarikat: KodVendo || '',
                        txtPTJ_Mohon: $('#txtKod_Ptj').val() || '',
                        ddlPelulus_PO: KodPelulus || '',
                    },
                }


                var result = JSON.parse(await ajaxUpdate_PembelianHdr(newPembelianPoHdr, rowDataArray));
                if (result.Status === "success") {
                    showModalUpdate3("Success", result.Message, "success");
                    tblPerolehanDtl.ajax.reload();
                    loadMaklumatIklan();
                } else {
                    showModalUpdate3("Error", result.Message, "error");
                }
                tbl.ajax.reload(); //Reload datatable
            });
        });
        async function ajaxUpdate_PembelianHdr(pembelianPoHeder, rowDataArray) {

            return new Promise((resolve, reject) => {

                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/UpdatePO_Pesanan_belian_Hdr") %>',
                    //url: 'PermohonanPoWS.asmx/UpdatePO_BajetSpesifikasi',
                    method: 'POST',
                    data: JSON.stringify({
                        "pembelianPoHeder": pembelianPoHeder.pembelianPoHeder,
                        "rowDataArray": rowDataArray
                    }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        tblPerolehanDtl.ajax.reload();
                        loadMaklumatIklan();

                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            })
            console.log("tst")
        }


        $('#btnHantarProcess').off('click').on('click', async function () {

            var msg = "";

            // Set message in the modal
            var msg = "Anda pasti ingin mengemaskini rekod ini? ";
            $('#confirmationMessageUpdate11').text(msg);
            // Open the Bootstrap modal
            $('#saveConfirmationModalUpdate11').modal('show');

            $('#confirmSaveButtonUpdate11').off('click').on('click', async function () {
                $('#saveConfirmationModalUpdate11').modal('hide'); // Hide the modal

                const currentDate = new Date().toISOString().split('T')[0];

                tblPerolehanDtl.rows().every(function (index, element) {
                    var rowData = this.data();
                    var Kod_Kump_Wang = rowData.Kod_Kump_Wang;
                    var Kod_Operasi = rowData.Kod_Operasi;
                    var Kod_Ptj = rowData.Kod_Ptj;
                    var Kod_Projek = rowData.Kod_Projek;
                    var Kod_Vot = rowData.Kod_Vot;
                    var Jumlah_Harga = rowData.Jumlah_Harga_Bercukai_B

                    var rowObject = {
                        Kod_Kump_Wang: Kod_Kump_Wang,
                        Kod_Operasi: Kod_Operasi,
                        Kod_Ptj: Kod_Ptj,
                        Kod_Projek: Kod_Projek,
                        Kod_Vot: Kod_Vot,
                        Jumlah_Harga: Jumlah_Harga,
                    };
                    rowDataArray.push(rowObject);
                });


                var newPembelianPoHdr = {
                    pembelianPoHeder: {

                        ddlKod_Pemiutang: Kod_Pemiutang || '',
                        ddlId_Pembelian: $("#txtIdPembelian").val() || '',
                        ddlNo_Mohon: newNoMohon || '',
                        ddlKod_Syarikat: kodNo_skyt || '',
                        ddlTarikh_Beli: currentDate || '',
                        ddlTempoh: $('#txtTempoh').val() || '',
                        ddlJenis_Tempoh: KodJenis_tempoh || '',
                        ddlTarikh_Terima: $('#txtTarikh_Mula_Perolehan').val() || '',
                        ddlTarikh_Hantar: $('#txtTarikh_Tamat_Perolehan').val() || '',
                        ddlID_Syarikat: KodVendo || '',
                        txtPTJ_Mohon: $('#txtKod_Ptj').val() || '',
                        ddlPelulus_PO: KodPelulus || '',
                    },
                }

                var mainResult = await ajaxUpdateHantar_Pesanan_belian_Hdr(newPembelianPoHdr, rowDataArray);
                var result0 = JSON.parse(mainResult.Result);
                console.log(result0);
                if (result0.Status === "success") {
                    showModalUpdate3("Success", result0.Message, "success");
                    tblPerolehanDtl.ajax.reload();
                    $('#transaksi').modal('toggle');

                } else {
                    showModalUpdate3("Error", result0.Message, "error");
                }
                tbl.ajax.reload(); //Reload datatable
            });
        });

        async function ajaxUpdateHantar_Pesanan_belian_Hdr(pembelianPoHeder, rowDataArray) {

            return new Promise((resolve, reject) => {

                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/UpdateHantar_Pesanan_belian_Hdr") %>',
            //url: 'PermohonanPoWS.asmx/UpdatePO_BajetSpesifikasi',
            method: 'POST',
            data: JSON.stringify({
                "pembelianPoHeder": pembelianPoHeder.pembelianPoHeder,
                "rowDataArray": rowDataArray
            }),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                resolve(data.d);
                tblPerolehanDtl.ajax.reload();
                $('#transaksi').modal('toggle');
            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }
        });
    })
    console.log("tst")
        }

        

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
                    console.log("Selected value: " + selectedValue);
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

                                console.log("+ KodDetailLesen", KodDetailLesen)

                                beginSearch();

                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });


        })

        var KodNegara = "";

        $(document).ready(function () {
            // Dropdown Negara Bidang Utama
            $('#ddlNegara_Pembuat_update').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetNegara?q={query}") %>',
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

                                KodNegara = kodValue;


                                beginSearch();

                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });


        })

        var KodJenis_tempoh = "";

        $(document).ready(function () {
            // Dropdown txtJenis_tempoh
            $('#txtJenis_tempoh').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetJenis_Tempoh?q={query}") %>',
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

                                KodJenis_tempoh = kodValue;

                                updateEndDate();

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
                            $(objItem).append($('<div class="item" data-value="' + option.kodValue + ',' + option.kodNo + '">').html(option.text));
                        });

                        $(obj).dropdown('refresh');

                        // Handle selection change
                        $(obj).dropdown({
                            onChange: function (kodValue, text, $selectedItem) {
                                // Do something with the selected value
                                console.log("Selected Value:", kodValue);
                                console.log("Selected Text:", text);
                                console.log("Selected Item:", $selectedItem);

                                kodValueParts = kodValue.split(",");
                                KodVendo = kodValueParts[0];
                                kodNo_skyt = kodValueParts[1];

                                console.log("Selected KodVendo:", KodVendo);
                                console.log("Selected kodNo_skyt:", kodNo_skyt);


                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });
        })

        var KodPelulus = "";




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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPesanan_Pembelian") %>',
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
                        "data": "No_Mohon",
                        "width": "10%"
                    },
                    {
                        "data": "Tujuan",
                        "width": "20%"
                    },
                    {
                        "data": "Kategori",
                        "width": "10%"
                    },
                    {
                        "data": "Tarikh_Mohon",
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
                        "data": "Tarikh_Perlu",
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
                        "data": "Status_Dtl",
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
        var Kod_Pemiutang = '';

        function ShowPopup(elm, No_MohonPS) {

            Id_MohonDtl = No_MohonPS;
            newNoMohon = No_MohonPS;

            if (elm == "1") {

                tblLampiran.ajax.reload();
                loadMaklumatIklan();
                tblPerolehanDtl.ajax.reload();
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
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadMaklumat_Pesanan_Pembelian") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ IdMohon: Id_MohonDtl }), // Convert the data to a JSON string
                success: function (data) {
                    // Parse the JSON data
                    var jsonData = JSON.parse(data.d);

                    if (jsonData[0].Status_Dok == '35') {
                        // If Status_Dok is '35', hide perolehan tab content and set bajet-tab as active
                        $('.nav-show').hide();
                        $('#bajet-tab').addClass('active');
                        $('#perolehan').removeClass('active show');
                        $('#bajet-dan-spesifikasi').addClass('active show');
                        $('#bajet-tab').trigger('click');
                    } else {
                        // If Status_Dok is not '35', show perolehan tab content and set maklumatPO-tab as active
                        $('.nav-show').show();
                        $('#bajet-tab').removeClass('active');
                        $('#maklumatPO-tab').addClass('active');
                        $('#bajet-dan-spesifikasi').removeClass('active show');
                        $('#perolehan').addClass('active show');
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
                    newNoMohon = jsonData[0].NoMohonUN;
                    Kod_Pemiutang = jsonData[0].Kod_Pemiutang;

                    $('#txtVendo').dropdown('clear');
                    $('#txtGred_CIDB').dropdown('clear');
                    $('#flexcheckbox').prop('checked', false);
                    $('.child-container-checkbox').hide();

                    $("#txtPemohon_Name").val(jsonData[0].Nama);
                    $("#txtStatus").val(jsonData[0].status_dok_butiran);
                    $("#txtNo_Perolehan").val(jsonData[0].No_Perolehan);
                    $("#txtTujuan").val(jsonData[0].Tujuan);
                    $("#txtSkop").val(jsonData[0].Skop);
                    $("#txtKategori_Perolehan").val(jsonData[0].ButiranB);
                    $("#txtJawatan_Pemohon").val(jsonData[0].JawGiliran);
                    $("#txtPTJ_Mohon").val(jsonData[0].KP);
                    $("#txtKod_Ptj").val(jsonData[0].Kod_Ptj_Mohon);
                    $("#txtTempat_Hantar").val(jsonData[0].Tempat_Hantar);
                    $("#txtTempat_Tapak").val(jsonData[0].Tempat_Lawatan_Tapak);
                    $("#txtId_Pemohon").val(jsonData[0].Id_Pemohon);
                    $("#txtNo_PTj").val(jsonData[0].Kod_Ptj_Mohon);
                    $("#txtUlasan").val(jsonData[0].Syarat_Perolehan);
                    $("#txtTempoh").val(jsonData[0].Tempoh);
                    $("#txtIdPembelian").val(jsonData[0].Id_Pembelian);

                    $("#txtJawGiliran3").val(jsonData[0].JawatanPelulus);
                    

                    KodJenis_tempoh = jsonData[0].Jenis_Tempoh;
                    NewKod_PTj = jsonData[0].Kod_Ptj_Mohon;
                    KodVendo = jsonData[0].ID_Syarikat;
                    kodNo_skyt = jsonData[0].KodSykt;

                    $("#txtTarikh_Mula_Perolehan").val(jsonData[0].Tarikh_Mula);
                    $("#txtTarikh_Tamat_Perolehan").val(jsonData[0].Tarikh_Tamat);

                    if (jsonData[0].Tarikh_Mohon == null) {
                        $("#txtTarikh_Mohon").val();
                    } else {
                        var formattedDate = moment(jsonData[0].Tarikh_Mohon).format("YYYY/MM/DD");
                        $("#txtTarikh_Mohon").val(formattedDate);
                    }

                    //if (jsonData[0].Tarikh_Mula == null) {
                    //    $("#txtTarikh_Mula_Perolehan").val();
                    //} else {
                    //    const dateTimeMI = new Date(jsonData[0].Tarikh_Mula);
                    //    const datePartMI = dateTimeMI.toISOString().slice(0, 10);
                    //    $("#txtTarikh_Mula_Perolehan").val(datePartMI);
                    //}
                    

                    //if (jsonData[0].Tarikh_Tamat == null) {
                    //    $("#txtTarikh_Tamat_Perolehan").val();
                    //} else {
                    //    const dateTimeMI = new Date(jsonData[0].Tarikh_Tamat);
                    //    const datePartMI = dateTimeMI.toISOString().slice(0, 10);
                    //    $("#txtTarikh_Tamat_Perolehan").val(PH.Tarikh_Tamat);
                    //}

                    updateEndDate();

                    // Populate dropdown select options
                    var selectOptionsJenis_tempoh = '';
                    jsonData.forEach(function (item) {

                        selectOptionsJenis_tempoh += '<option value="' + item.Jenis_Tempoh + '">' + item.Nama_Jenis_Tempoh + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                    });

                    $('#txtJenis_tempoh').html(selectOptionsJenis_tempoh);

                    // Populate dropdown select options
                    var selectOptionsVendo = '';
                    jsonData.forEach(function (item) {

                        selectOptionsVendo += '<option value="' + item.ID_Syarikat + '">' + item.Nama_Sykt_butiran + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                    });

                    $('#txtVendo').html(selectOptionsVendo);



                    // Populate dropdown select options
                    var selectOptionsPelulus = '';
                    jsonData.forEach(function (item) {
                        KodPelulus = item.Pelulus_PO;
                        if (item.Nama_Pelulus == null) {
                            selectOptionsPelulus += '<option value=""></option>'; // Replace SomeValue and SomeText with actual property names from your data
                        } else {
                            selectOptionsPelulus += '<option value="' + item.Pelulus_PO + '">' + item.Nama_Pelulus + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                        }
                    });

                    $('#txtPelulus_PO3').html(selectOptionsPelulus);



                    //tap 3
                    $("#txtNo_Pesanan_Belian3").val(jsonData[0].Id_Pembelian);

                    const btnHantarProcess = document.getElementById('btnHantarProcess');
                    btnHantarProcess.disabled = true;
                    const Id_PembelianVal = jsonData[0].Id_Pembelian
                    if (Id_PembelianVal.trim() !== '') {
                        btnSimpan.disabled = false;
                    } else {
                        btnSimpan.disabled = true;
                    }
                    

                    if (jsonData[0].Tarikh_Beli == null) {
                        $("#txtTarikh_Daftar3").val();
                    } else {
                        const dateTimeD = new Date(jsonData[0].Tarikh_Beli);
                        const datePartD = dateTimeD.toISOString().slice(0, 10);
                        $("#txtTarikh_Daftar3").val(datePartD);
                    }


                    $(document).ready(function () {
                        // Dropdown txtJenis_tempoh
                        var Kod_PTj = NewKod_PTj.substring(0, 2);
                        console.log('Kod_PTj=', Kod_PTj)
                        $('#txtPelulus_PO3').dropdown({
                            selectOnKeydown: true,
                            fullTextSearch: true,
                            apiSettings: {
                                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetPelulus?q={query}") %>',
                                method: 'POST',
                                dataType: "json",
                                contentType: 'application/json; charset=utf-8',
                                cache: false,
                                beforeSend: function (settings) {
                                    settings.data = JSON.stringify({ q: settings.urlData.query, Kod_Perjabat: Kod_PTj });
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
                                        $(objItem).append($('<div class="item" data-value="' + option.kodValue + "," + option.Jawatan + '">').html(option.text));
                                    });

                                    $(obj).dropdown('refresh');

                                    // Handle selection change
                                    $(obj).dropdown({
                                        onChange: function (kodValue, text, $selectedItem) {
                                            // Do something with the selected value
                                            console.log("Selected Value:", kodValue);
                                            console.log("Selected Text:", text);
                                            console.log("Selected Item:", $selectedItem);

                                            var kodValueParts = kodValue.split(",");
                                            KodPelulus = kodValueParts[0];
                                            $("#txtJawGiliran3").val(kodValueParts[1]);

                                            updateEndDate();

                                        }
                                    });

                                    // Show dropdown
                                    $(obj).dropdown('show');
                                }
                            }
                        });


                    })

                    showKaedahPerolehan(jsonData[0].No_Mohon);

                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        };



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

                        if (jsonData[0].Tarikh_Masa_Lawatan_Tapak == null) {
                            $("#txtTarikh_Lawatan3").val();
                            $("#txtMasa_Lawatan3").val();
                        } else {
                            const dateTimeLT = new Date(jsonData[0].Tarikh_Masa_Lawatan_Tapak);
                            const datePartLT = dateTimeLT.toISOString().slice(0, 10);
                            const timePartLT = dateTimeLT.toTimeString().slice(0, 5);
                            $("#txtTarikh_Lawatan3").val(datePartLT);
                            $("#txtMasa_Lawatan3").val(timePartLT);
                        }


                        if (jsonData[0].Tarikh_Daftar == null) {
                            $("#txtTarikh_Mohon3").val();
                        } else {
                            const dateTimeD = new Date(jsonData[0].Tarikh_Daftar);
                            const datePartD = dateTimeD.toISOString().slice(0, 10);
                            $("#txtTarikh_Mohon3").val(datePartD);
                        }

                        if (jsonData[0].Tarikh_Masa_Mula_Iklan == null) {
                            $("#txtTarikh_Mula_Iklan3").val();
                        } else {
                            const dateTimeMI = new Date(jsonData[0].Tarikh_Masa_Mula_Iklan);
                            const datePartMI = dateTimeMI.toISOString().slice(0, 10);
                            $("#txtTarikh_Mula_Iklan3").val(datePartMI);
                        }


                        if (jsonData[0].Tarikh_Masa_Mula_Perolehan == null) {
                            $("#txtTarikh_Mula_Perolehan3").val();
                        } else {
                            const dateTimeMP = new Date(jsonData[0].Tarikh_Masa_Mula_Perolehan);
                            const datePartMP = dateTimeMP.toISOString().slice(0, 10);
                            $("#txtTarikh_Mula_Perolehan3").val(datePartMP);
                        }

                        if (jsonData[0].Tarikh_Masa_Tamat_Perolehan == null) {
                            $("#txtTarikh_Tamat_Perolehan3").val();
                        } else {
                            const dateTimeTP = new Date(jsonData[0].Tarikh_Masa_Tamat_Perolehan);
                            const datePartTP = dateTimeTP.toISOString().slice(0, 10);
                            $("#txtTarikh_Tamat_Perolehan3").val(datePartTP);
                        }

                        if (jsonData[0].Tarikh_Masa_Tamat_Perolehan == null) {
                            $("#txtMasa_Tamat_Perolehan3").val();
                        } else {
                            const dateTimeTPM = new Date(jsonData[0].Tarikh_Masa_Tamat_Perolehan);
                            const timePart = dateTimeTPM.toTimeString().slice(0, 5);
                            $("#txtMasa_Tamat_Perolehan3").val(timePart);
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_Cidb") %>',
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
                    { "data": "Kod_Kategori" },
                    { "data": "Syarat" },
                    { "data": "Butiran" },

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

        function showModalLampiran(header, body) {
            $('#lampirantitle').text(header);
            $('#lampiranbody').text(body);
            $('#formatSimpanLampiran').modal('show');
        }

        $("#savedokumen").on("click", function (evt) {
            evt.preventDefault();
            saveAndUploadFile();

        });

        function saveAndUploadFile() {

            if ($('#txtNoMohon').val() === "") {
                $('#pilihpermohonan').modal('show');
                return false;
            }

            var dokumenType = $("input[name='DokumenType']:checked").val();

            var namaFail = $("#namaFail").val();

            if (!dokumenType || !namaFail) {
                showModalLampiran("Maklumat tidak lengkap", "Sila masukkan semua maklumat sebelum simpan.");
                return;
            }

            var fileInput = document.getElementById("uploadDokumen");
            var file = fileInput.files[0];

            if (!file) {
                showModalLampiran("Muatnaik fail", "Sila pilih fail yang hendak dimuatnaik.");
                return;
            }

            var fileSize = file.size;
            var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (5MB)

            if (fileSize > maxSize) {
                showModalLampiran("Saiz Fail Besar", "Saiz fail melebihi had maksimum 5MB.");
                return;
            }

            var fileName = file.name;
            var fileExtension = fileName.split('.').pop().toLowerCase();

            if (fileExtension !== 'pdf') {
                showModalLampiran("Fail Salah Format", "Hanya format PDF sahaja dibenarkan.");
                return;
            }

            var requestData = {
                dokumenType: dokumenType,
                namaFail: namaFail,
                // fileData: "test", 
                fileName: fileName,
            };

            var formData = new FormData();
            formData.append("namaFail", namaFail);
            formData.append("file", file);
            formData.append("fileName", fileName);
            formData.append("dokumenType", dokumenType);
            formData.append("nomohon", newNoMohon);

            $.ajax({
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SaveAndUploadFile") %>',
                data: formData,
                cache: false,
                contentType: false,
                type: 'POST',
                processData: false,
                success: function (response) {
                    showModalLampiran("Berjaya Simpan", "Fail berjaya disimpan di pangkalan data.");
                    tblLampiran.ajax.reload();
                },
                error: function () {
                    showModalLampiran("Tidak Berjaya Simpan", "Sila cuba simpan semula.");
                }
            });
        }


        var tblLampiran = null;
        var isClickedTabLampiran = false;

        $(document).ready(function () {
            console.log("inside lampiran=", newNoMohon);
            tblLampiran = $("#tblSimpanUpload").DataTable({
                "responsive": true,
                "searching": false,
                "info": false,
                "paging": false,
                "ordering": false,
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_Lampiran") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ id: newNoMohon });
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "columns": [
                    { "data": "Id_Lampiran" }, //Hidden  
                    { "data": "Nama_Fail" }, //Hidden  
                    { "data": "Bil" }, // Empty column for index/bil
                    { "data": "Lampiran" },
                    { "data": null, "title": "Tindakan" }
                ],
                "columnDefs": [
                    {
                        "targets": 0,
                        visible: false,
                        searchable: false
                    },
                    {
                        "targets": 1,
                        visible: false,
                        searchable: false
                    },
                    {
                        "targets": 2,
                        visible: true,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                    {
                        "targets": 4, // Target the last column (Delete column)
                        "data": null,
                        "render": function (data, type, row) {
                            return `
                <div class="row">
                    <div class="col-md-1">
                        <button type="button" class="btn viewLampiran" style="padding:0px 0px 0px 0px" title="Papar">
                            <i class="fa fa-eye "></i>
                        </button>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn deleteBtnLampiran" style="padding:0px 0px 0px 0px" title="Padam">
                            <i class="far fa-trash-alt fa-lg"></i>
                        </button>
                    </div>
                </div>`;
                        }
                    }
                ]
            });

            $('.btnSearchUpload').click(async function () {
                // load_loader();
                isClickedTabLampiran = true;
                tblLampiran.ajax.reload();
                // close_loader();
            });
        });

        $("#tblSimpanUpload").off('click', '.viewLampiran').on("click", ".viewLampiran", function (event) {
            var data = tblLampiran.row($(this).parents('tr')).data();
            var fileName = data.Nama_Fail;
            var nomohon = $("#txtNoMohon").val();

            // Call a function to open the PDF in a new tab
            openPDFInNewTab(fileName, nomohon);
        });

        function openPDFInNewTab(fileName, nomohon) {
            var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/PEROLEHAN/PERMOHONAN/") %>' + nomohon + '/' + fileName;
            window.open(pdfPath, '_blank');
        }

        //Proses Delete Lampiran
        $("#tblSimpanUpload").off('click', '.deleteBtnLampiran').on("click", ".deleteBtnLampiran", function (event) {
            var row = $(this).closest('tr');
            var dataTable = $('#tblSimpanUpload').DataTable();

            Id_Lampiran_Hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID
            var nomohon = newNoMohon;
            Nama_Fail_Pdf = dataTable.cell(row, 1).data();


            var msg = "Anda pasti ingin memadam rekod ini?";
            $('#confirmationMessageDeleteLampiran').text(msg);
            $('#saveConfirmationModalDeleteLampiran').modal('show');

            $('#confirmSaveButtonDeleteLampiran').off('click').on('click', async function () {
                $('#saveConfirmationModalDeleteLampiran').modal('hide'); // Hide the modal
                var result = JSON.parse(await ajaxdeleteLampiran(Id_Lampiran_Hidden, nomohon, Nama_Fail_Pdf));
                if (result.Status === true) {
                    showModalDeleteLampiran("Success", result.Message, "success");
                }
                else {
                    showModalDeleteLampiran("Error", result.Message, "error");
                }

                tblLampiran.ajax.reload();
            });
        });

        async function ajaxdeleteLampiran(Id_Lampiran_Hidden, nomohon, Nama_Fail_Pdf) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/DeleteLampiran") %>',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ id: Id_Lampiran_Hidden, nomohon1: nomohon, NamaFailPdf: Nama_Fail_Pdf }),
                    success: function (data) {
                        resolve(data.d);
                        tblLampiran.ajax.reload();
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                        reject(false);
                    }
                });
            })
        }



    </script>



</asp:Content>
