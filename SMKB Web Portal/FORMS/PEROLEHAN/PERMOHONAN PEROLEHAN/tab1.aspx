<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="tab1.aspx.vb" Inherits="SMKB_Web_Portal.tab1" %>

<asp:Content ID="FormContents" ContentPlaceHolderID="FormContents" runat="server">

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


        .table-common {
            border-collapse: collapse;
            width: 100%;
        }

            .table-common th,
            .table-common td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            .table-common th {
                background-color: #f2f2f2;
            }

        .error-message {
            display: none;
        }

            .error-message.err-active {
                display: inline;
            }
    </style>


    <contenttemplate>



        <div id="PermohonanTab" class="tabcontent" style="display: block">

            <ul class="nav nav-tabs" id="myTab" role="tablist">

                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="maklumatPO-tab" data-toggle="tab" data-target="#perolehan" type="button" role="tab">Maklumat Perolehan</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link btnSearchAm" id="spesifikasiAm-tab" data-toggle="tab" data-target="#spesifikasi-am" type="button" role="tab">Maklumat Spesifikasi Umum</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="bajet-tab" data-toggle="tab" data-target="#bajet-dan-spesifikasi" type="button" role="tab">Maklumat Bajet dan Spesifikasi Teknikal</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link btnSearchMof" id="mof-tab" data-toggle="tab" data-target="#mof" type="button" role="tab">Maklumat Bidang Perolehan</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link btnSearchCidb" id="cidb-tab" data-toggle="tab" data-target="#cidb" type="button" role="tab">Maklumat Kategori Kerja</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link btnSearchUpload" id="upload-tab" data-toggle="tab" data-target="#upload" type="button" role="tab">Muat Naik Dokumen</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link btnSearchRingkasan" id="ringkasan-tab" data-target="#ringkasan" type="button" role="tab">Ringkasan</button>
                </li>

            </ul>

            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="perolehan" role="tabpanel">
                    <!-- tab 1 (Maklumat Perolehan) -->

                    <div id="divpendaftaraninv" runat="server" visible="true">
                        <div class="modal-body">
                            <div>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <h5>Maklumat Perolehan</h5>
                                    </div>

                                    <div class="col-sm-4">
                                    </div>

                                    <div class="col-sm-4 d-flex justify-content-end">
                                        <div class="btn btn-secondary" onclick="clearPermohonan()" style="margin-right: 5px">
                                            + Permohonan  
                                        </div>

                                        <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                                            Senarai Permohonan  
                                        </div>
                                    </div>

                                </div>
                                <hr />



                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="No Permohonan" id="txtNoMohon" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Permohonan">No Permohonan</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="Tarikh" id="lblTarikhPO" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Tarikh">Tarikh</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="Status" id="lblStatus1" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Status">Status</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="No Perolehan" id="txtNoPO" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="No Perolehan">No Perolehan</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <select class="input-group__select ui search dropdown" name="Tahun Perolehan" id="ddlTahun" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Tahun Perolehan">Tahun Perolehan</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <textarea class="input-group__input js-group-one" id="txtTujuan" placeholder="&nbsp;" name="Tajuk / Tujuan" style="height: 60px"></textarea>
                                                <label class="input-group__label" for="Tajuk / Tujuan">Tajuk / Tujuan</label>
                                                <div class="error-message" style="">Sila masukkan Tujuan</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <textarea class="input-group__input js-group-one" id="txtSkop" placeholder="&nbsp;" name="Skop" style="height: 60px"></textarea>
                                                <label class="input-group__label" for="Skop">Skop</label>
                                                <div class="error-message" style="">Sila masukkan Skop</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-4">
                                                <select class="input-group__select ui search dropdown" name="Kategori Perolehan" id="ddlkategoriPO" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Kategori Perolehan">Kategori Perolehan</label>
                                                <div class="error-message" style="">Sila pilih kategori perolehan.</div>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <select class="input-group__select ui search dropdown" name="Bekal Kepada" id="ddlListPtj" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Bekal Kepada">Bekal Kepada</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-8">
                                                <input class="input-group__input" name="Pemohon" id="txtPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Pemohon">Pemohon</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="PTJ" id="ddlPTJPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="PTJ">PTJ</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-3">
                                                <input class="input-group__input " id="txtTarikh_Mula_Perolehan" type="date" placeholder="&nbsp;" name="txtTarikh_Mula_Perolehan" style="background-color: white" />
                                                <label class="input-group__label" for="txtTarikh_Mula_Perolehan">Anggaran Tarikh Mula</label>
                                            </div>

                                            <div class="form-group col-md-1">
                                                <input class="input-group__input " id="txtTempoh" type="number" placeholder="&nbsp;" name="txtTempoh" style="background-color: white" />
                                                <label class="input-group__label" for="txtTempoh">Tempoh</label>
                                            </div>

                                            <div class="form-group col-md-2">
                                                <select class="input-group__select ui search dropdown JenTransaksi" name="txtJenis_tempoh" id="txtJenis_tempoh" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="txtJenis_tempoh">Tempoh</label>
                                            </div>

                                            <div class="form-group col-md-3">
                                                <input class="input-group__input " id="txtTarikh_Tamat_Perolehan" type="date" placeholder="&nbsp;" name="txtTarikh_Tamat_Perolehan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtTarikh_Tamat_Perolehan">Anggaran Bekal Sebelum</label>
                                            </div>


                                        </div>
                                    </div>
                                </div>




                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">


                                            <%--                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" id="txtTkh" type="date" name="Tarikh Transaksi" placeholder="&nbsp;" />
                                                <label class="input-group__label" for="Tarikh Keperluan">Tarikh Keperluan</label>
                                            </div>--%>

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input text-right" id="txtAmaun" placeholder="&nbsp;" name="Rekod Perolehan Terdahulu" oninput="formatInput(this)" />
                                                <label class="input-group__label" for="Rekod Perolehan Terdahulu">Rekod Perolehan Terdahulu (RM)</label>
                                            </div>
                                            <input type="hidden" id="tahapPerolehan" value="uni" />

                                        </div>
                                    </div>
                                </div>



                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <textarea class="input-group__input" id="txtJustifikasi" placeholder="&nbsp;" name="Justifikasi Perolehan" style="height: 60px"></textarea>
                                                <label class="input-group__label" for="Justifikasi Perolehan">Justifikasi Perolehan</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12" align="center">
                                        <button type="button" id="lbtnSimpanInfo" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                            Simpan
                                        </button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>



                    <!-- Modal Result -->
                    <div class="modal fade" id="resultModal1" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">

                                <div class="modal-header">
                                    <h5 class="modal-title" id="resultModalLabel1">Makluman</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>

                                <div class="modal-body">
                                    <div id="resultModalMessage1">
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <!-- End of Maklumat Perolehan Tab -->





                <!-- tab 2 (Maklumat Spesifikasi Am) -->
                <div class="tab-pane fade" id="spesifikasi-am" role="tabpanel">
                    <div class="modal-body">
                        <div>
                            <h5>Maklumat Spesifikasi Umum</h5>
                            <hr />
                        </div>
                        <table id="spekfikasi-table" class="table table-striped" border="1" width="95%">
                            <thead>
                                <tr>
                                    <th>Perkara</th>
                                    <th>Item Dan Wajaran</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>

                    <!-- Modal List Speksifikasi Item-->
                    <div class="modal fade" id="speksifikasiModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
                            <div class="modal-content">
                                <div class="modal-header modal-header--sticky">
                                    <h5 class="modal-title">Speksifikasi</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <table id="listSpekItem" border="1" style="width: 80%">
                                        <thead>
                                            <tr style="background-color: #FFC83D">
                                                <th style="width: 5%"></th>
                                                <th style="width: 75%; text-align: center">Perkara</th>
                                                <th class="wajaran" style="width: 25%; text-align: center">Wajaran</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>

                                </div>
                                <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">
                                    <button type="button" class="btn btn-secondary" id="simpanSpekModal">Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Manual Add Speksifikasi Item-->
                    <div class="modal fade" id="spekAddManual" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Speksifikasi</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group col-md-12">
                                        <textarea class="input-group__input" id="txtManualPerkaraSpek" style="height: 100px" placeholder="&nbsp;" name="Perkara"></textarea>
                                        <label class="input-group__label" id="txtManualPerkaraSpek2" style="left: unset!important" for="Perkara">Perkara</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" id="txtManualWajaran" placeholder="&nbsp;" name="wajaran" />
                                        <label class="input-group__label" id="txtManualWajaran2" style="left: unset!important" for="wajaran">Wajaran</label>
                                    </div>

                                </div>
                                <div class="modal-footer" style="padding: 0px!important">
                                    <button type="button" class="btn btn-secondary btnSimpanWajaran" id="simpanMwajaran">Simpan</button>
                                    <input type="hidden" id="hidKodSpek" />
                                    <input type="hidden" id="hidIDSpek" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Pengesahan-->
                    <div class="modal fade" id="saveConfirmationModal2" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                        <div class="modal-dialog " role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="saveConfirmationModalLabel2">Pengesahan</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="confirmationMessage2"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                    <button type="button" class="btn btn-secondary" id="confirmSaveButton2">Ya</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Result -->
                    <div class="modal fade" id="resultModal2" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="resultModalLabel2">Makluman</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="resultModalMessage2"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>


                <div class="modal fade" id="saveConfirmationModalDelete5" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                    <div class="modal-dialog " role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="saveConfirmationModalLabelDelete5">Pengesahan</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p id="confirmationMessageDelete5"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                <button type="button" class="btn btn-secondary" id="confirmSaveButtonDelete5">Ya</button>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- Modal Delete Result -->
                <div class="modal fade" id="resultModalDelete5" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="resultModalLabelDelete5">Makluman</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p id="resultModalMessageDelete5"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>






                <div class="tab-pane fade" id="bajet-dan-spesifikasi" role="tabpanel">
                    <!-- tab 3 (Maklumat Bajet dan Spesifikasi) -->

                    <div id="divTab3" runat="server" visible="true">
                        <div class="modal-body">
                            <div>
                                <h5>Maklumat Bajet</h5>
                                <hr />
                                <div class="row">
                                    <div class="form-group col-md-8">
                                        <select class="input-group__select ui search dropdown" name="COA" id="ddlCOA" placeholder="&nbsp;">
                                        </select>
                                        <label class="input-group__label" for="COA">COA</label>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md">
                                                <input class="input-group__input" name="Kod PTj" id="ddlPTj" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kod PTj">Kod PTj</label>
                                            </div>

                                            <div class="form-group col-md">
                                                <input class="input-group__input" name="Kumpulan Wang" id="ddlKW" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kumpulan Wang">Kumpulan Wang</label>
                                            </div>

                                            <div class="form-group col-md">
                                                <input class="input-group__input" name="Kod Operasi" id="ddlKodOperasi" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kod Operasi">Kod Operasi</label>
                                            </div>


                                            <div class="form-group col-md">
                                                <input class="input-group__input" name="Kod Projek" id="ddlKodProjek" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kod Projek">Kod Projek</label>
                                            </div>


                                            <div class="form-group col-md">
                                                <input class="input-group__input text-right" id="txtBakiPeruntukan" name="Baki Peruntukan" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Baki Peruntukan">Baki Peruntukan (RM)</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-12">
                                                <textarea class="input-group__input" id="txtPerkara" placeholder="&nbsp;" name="Barang / Perkara" style="height: 60px"></textarea>
                                                <label class="input-group__label" for="Barang / Perkara">Barang / Perkara</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-3">
                                                <input class="input-group__input" name="Kuantiti" id="txtKuantiti" type="text" placeholder="&nbsp;" />
                                                <label class="input-group__label" for="Kuantiti">Kuantiti</label>
                                            </div>

                                            <div class="form-group col-md-3">
                                                <select class="input-group__select ui search dropdown" name="Ukuran" id="ddlUkuran" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Ukuran">Ukuran</label>
                                            </div>

                                            <div class="form-group col-md-3">
                                                <input class="input-group__input text-right" id="txtAngHrgSeunit" placeholder="&nbsp;" name="Anggaran Harga Seunit" oninput="formatInput(this)" />
                                                <label class="input-group__label" for="Anggaran Harga Seunit">Anggaran Harga Seunit (RM)</label>
                                            </div>


                                            <div class="form-group col-md-3">
                                                <input class="input-group__input text-right" id="txtJumAngHrg" placeholder="&nbsp;" name="Jumlah Anggaran Harga" oninput="formatInput(this)" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Jumlah Anggaran Harga">Jumlah Anggaran Harga (RM)</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>


                                <div class="form-group col-md-12" align="center">
                                    <%--                                    <button type="button" class="btn btn-danger btnReset" data-placement="bottom" title="Padam">Padam</button>--%>
                                    <!-- reset -->
                                    <button type="button" class="btn btn-secondary btnTambah" data-placement="bottom" title="Tambah">Tambah</button>
                                </div>
                                &nbsp;&nbsp;
                                <h5>Spesifikasi Teknikal</h5>
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
                                                    <th scope="col" class="text-right">Baki Peruntukan (RM)</th>
                                                    <th scope="col">Barang / Perkara</th>
                                                    <th scope="col">Kuantiti</th>
                                                    <th scope="col">Ukuran</th>
                                                    <th scope="col" class="text-right">Anggaran Harga Seunit (RM)</th>
                                                    <th scope="col" class="text-right">Jumlah Anggaran Harga (RM)</th>
                                                    <th scope="col">Tindakan</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th colspan="12" style="text-align: right; white-space: nowrap;">Jumlah:</th>
                                                    <th class="text-right"></th>
                                                    <th class="text-right"></th>
                                                </tr>
                                            </tfoot>

                                        </table>

                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>

                    <!-- Modal Delete Pengesahan-->
                    <!-- Modal Pengesahan-->
                    <div class="modal fade" id="saveConfirmationModal3" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                        <div class="modal-dialog " role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="saveConfirmationModalLabel3">Pengesahan</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="confirmationMessage3"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                    <button type="button" class="btn btn-secondary" id="confirmSaveButton3">Ya</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal Result -->
                    <div class="modal fade" id="resultModal3" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="resultModalLabel3">Makluman</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="resultModalMessage3"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </div>
                    </div>



                    <!-- Modal Delete Pengesahan-->
                    <div class="modal fade" id="saveConfirmationModalDelete3" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                        <div class="modal-dialog " role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="saveConfirmationModalLabelDelete3">Pengesahan</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="confirmationMessageDelete3"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                    <button type="button" class="btn btn-secondary" id="confirmSaveButtonDelete3">Ya</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal Delete Result -->
                    <div class="modal fade" id="resultModalDelete3" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="resultModalLabelDelete3">Makluman</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="resultModalMessageDelete3"></p>
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
                                    <h5 class="modal-title">Kemaskini Maklumat Bajet dan Spesifikasi</h5>
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
                                                        <select class="form-control ui search dropdown" name="ddlCOA_update" id="ddlCOA_update">
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">

                                                <div class="form-group col-lg-2">
                                                    <label>Kod PTj</label>
                                                    <input type="text" class="form-control" placeholder="Kod PTj" id="ddlPTj_update" name="ddlPTj_update" readonly />
                                                </div>

                                                <div class="form-group col-lg-2">
                                                    <label>Kumpulan Wang</label>
                                                    <input type="text" class="form-control" placeholder="Kumpulan Wang" id="ddlKW_update" name="ddlKW_update" readonly />
                                                </div>

                                                <div class="form-group col-lg-2">
                                                    <label>Kod Operasi</label>
                                                    <input type="text" class="form-control" placeholder="Kod Operasi" id="ddlKodOperasi_update" name="ddlKodOperasi_update" readonly />
                                                </div>

                                                <div class="form-group col-lg-2">
                                                    <label>Kod Projek</label>
                                                    <input type="text" class="form-control" placeholder="Kod Projek" id="ddlKodProjek_update" name="ddlKodProjek_update" readonly />
                                                </div>

                                                <div class="form-group col-lg-4">
                                                    <!-- baki peruntukan kena add function tarik value duit from db and format value tu dalam bentuk duit -->
                                                    <label>Baki Peruntukan</label>
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <div class="input-group-text">RM</div>
                                                        </div>
                                                        <input type="text" class="form-control" placeholder="Baki Peruntukan" id="txtBakiPeruntukan_update" name="txtBakiPeruntukan_update" oninput="formatInput(this)" readonly />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-12">
                                                    <label>Barang / Perkara</label>
                                                    <textarea class="form-control" placeholder="Barang / Perkara" id="txtPerkara_update" name="txtPerkara_update"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-lg-3">
                                                    <label>Kuantiti</label>
                                                    <input type="text" class="form-control" placeholder="Kuantiti" id="txtKuantiti_update" name="txtKuantiti_update" oninput="formatInput(this)" />
                                                </div>
                                                <div class="form-group col-lg-3">
                                                    <label>Ukuran</label>
                                                    <div class="responsive">
                                                        <select class="form-control ui search dropdown" name="ddlUkuran_update" id="ddlUkuran_update">
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group col-lg-3">
                                                    <label>Anggaran Harga Seunit</label>
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <div class="input-group-text">RM</div>
                                                        </div>
                                                        <input type="text" class="form-control" placeholder="Anggaran Harga Seunit" id="txtAngHrgSeunit_update" name="txtAngHrgSeunit_update" oninput="formatInput(this)" />
                                                    </div>
                                                </div>
                                                <div class="form-group col-lg-3">
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
                                        </div>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger btnReset" data-placement="bottom" title="Padam">Padam</button>
                                    <!-- reset -->
                                    <button type="button" class="btn btn-secondary btnKemaskini" data-placement="bottom" title="Kemaskini">Kemaskini</button>
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




                    <!-- Modal Spesifikasi Teknikal(Tab 3) -->
                    <div class="modal fade" id="spekTeknikalModal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-xl">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Maklumat Spesifikasi Teknikal</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">

                                    <div class="container">
                                        <div class="form-group row">
                                            <label for="butiran" class="col-sm-2 col-form-label">Butiran:</label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="butiran" name="butiran" rows="3" readonly></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="spesifikasi" class="col-sm-2 col-form-label">Spesifikasi:</label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="spesifikasi" name="spesifikasi" rows="3"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row" id="wajaranHideKerja">
                                            <label for="wajaran" class="col-sm-2 col-form-label">Wajaran:</label>
                                            <div class="col-sm-10">
                                                <input type="number" class="form-control" id="wajaran" name="wajaran">
                                            </div>
                                        </div>
                                        <div class="form-group text-center">
                                            <!-- Center the button -->
                                            <button type="button" class="btn btn-secondary btnTambah2">Tambah</button>

                                            <button type="button" style="display: none" class="btn btn-danger btnUndo2">Undo</button>
                                            <button type="button" style="display: none" class="btn btn-secondary btnKemaskini2">Kemaskini</button>
                                        </div>
                                    </div>

                                    <div class="container">
                                        <div class="transaction-table table-responsive">
                                            <table id="tblSpekTeknikal" class="table table-striped" style="width: 99%">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">Id_Teknikal</th>
                                                        <th scope="col">Bil</th>
                                                        <th scope="col">Barang / Perkara</th>
                                                        <th scope="col">Wajaran</th>
                                                        <th scope="col">Tindakan</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Modal Pengesahan SpekTeknikal-->
                    <div class="modal fade" id="saveConfirmationModal3SpekTeknikal" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                        <div class="modal-dialog " role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="saveConfirmationModalLabel3SpekTeknikal">Pengesahan</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="confirmationMessage3SpekTeknikal"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                    <button type="button" class="btn btn-secondary" id="confirmSaveButton3SpekTeknikal">Ya</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal Result SpekTeknikal-->
                    <div class="modal fade" id="resultModal3SpekTeknikal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="resultModalLabel3SpekTeknikal">Makluman</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="resultModalMessage3SpekTeknikal"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Delete Pengesahan SpekTeknikal-->
                    <div class="modal fade" id="saveConfirmationModalDeleteSpekTek3" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                        <div class="modal-dialog " role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="saveConfirmationModalLabelDeleteSpekTek3">Pengesahan</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="confirmationMessageDeleteSpekTek3"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                    <button type="button" class="btn btn-secondary" id="confirmSaveButtonDeleteSpekTek3">Ya</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal Delete Result SpekTeknikal -->
                    <div class="modal fade" id="resultModalDeleteSpekTek3" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="resultModalLabelDeleteSpekTek3">Makluman</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="resultModalMessageDeleteSpekTek3"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Update Pengesahan (Spek Teknikal) -->
                    <div class="modal fade" id="saveConfirmationModalUpdateSpekTeknikal" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                        <div class="modal-dialog " role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="saveConfirmationModalLabelUpdateSpekTeknikal">Pengesahan</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="confirmationMessageUpdateSpekTeknikal"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                    <button type="button" class="btn btn-secondary" id="confirmSaveButtonUpdateSpekTeknikal">Ya</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal Update Result (Spek Teknikal) -->
                    <div class="modal fade" id="resultModalUpdateSpekTeknikal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="resultModalLabelUpdateSpekTeknikal">Makluman</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p id="resultModalMessageUpdateSpekTeknikal"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>



                <div class="tab-pane fade" id="mof" role="tabpanel">
                    <!-- tab 4 (Maklumat Bidang Perolehan) -->
                    <div class="modal-body">
                        <div>
                            <h5>Maklumat Bidang Bekalan Dan Perkhidmatan (MOF)</h5>
                            <hr />
                            &nbsp;&nbsp;
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-3">
                                            <select class="input-group__select ui search dropdown" name="Bidang Utama" id="bidang_mof" placeholder="&nbsp;">
                                            </select>
                                            <label class="input-group__label" for="Bidang Utama">Bidang Utama</label>
                                        </div>

                                        <div class="form-group col-md-3">
                                            <select class="input-group__select ui search dropdown" name="Situasi Keperluan" id="sub_bidang_mof" placeholder="&nbsp;">
                                            </select>
                                            <label class="input-group__label" for="Situasi Keperluan">Sub Bidang</label>
                                        </div>

                                        <div class="form-group col-md-3">
                                            <select class="input-group__select ui search dropdown" name="Situasi Keperluan" id="keperluan_mof" placeholder="&nbsp;">
                                                <option value="">-- Sila Pilih --</option>
                                                <option value="1">dan</option>
                                                <option value="2">atau</option>
                                                <option value="0">Terakhir</option>
                                            </select>
                                            <label class="input-group__label" for="Situasi Keperluan">Situasi Keperluan</label>
                                        </div>

                                    </div>

                                </div>
                            </div>

                            <p>Bidang:</p>
                            <div class="table-responsive">

                                <table id="bidang_mof_table" class="table table-striped" border="1" width="75%" style="display: none;">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%;">Pilih</th>
                                            <th style="width: 20%;">Kod Bidang</th>
                                            <th style="width: 50%;">Bidang</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>

                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-12" align="left">
                                    <button type="button" id="btnSimpanMof" class="btn btn-secondary btnSimpanMof" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        Simpan
                                    </button>
                                </div>
                            </div>
                            &nbsp;&nbsp;
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblMof" class="table table-striped" style="width: 99%">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Id_Jualan</th>
                                                    <th scope="col">Bil</th>
                                                    <th scope="col">Kod Bidang</th>
                                                    <th scope="col">Bidang</th>
                                                    <th scope="col">Situasi Keperluan</th>
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

                            <div>
                                <br />
                                <p><strong>Pernyataan Kod Bidang :</strong></p>
                                <label id="displayKodBidang1" style="font-weight: unset"></label>
                                <br />
                                <label id="displayKodBidang2" style="font-weight: unset"></label>

                            </div>

                        </div>
                    </div>
                </div>



                <!-- Modal Delete Pengesahan-->
                <div class="modal fade" id="saveConfirmationModalDelete4" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                    <div class="modal-dialog " role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="saveConfirmationModalLabelDelete4">Pengesahan</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p id="confirmationMessageDelete4"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                <button type="button" class="btn btn-secondary" id="confirmSaveButtonDelete4">Ya</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Delete Result -->
                <div class="modal fade" id="resultModalDelete4" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="resultModalLabelDelete4">Makluman</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p id="resultModalMessageDelete4"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>



                <!-- Modal Pengesahan Bidang Mof-->
                <div class="modal fade" id="saveConfirmationModal4" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                    <div class="modal-dialog " role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="saveConfirmationModalLabel4">Pengesahan</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p id="confirmationMessage4"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                <button type="button" class="btn btn-secondary" id="confirmSaveButton4">Ya</button>
                            </div>
                        </div>
                    </div>
                </div>



                <!-- Modal Result -->
                <div class="modal fade" id="resultModal4" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="resultModalLabel4">Makluman</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p id="resultModalMessage4"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="tab-pane fade" id="cidb" role="tabpanel">
                    <!-- tab 5 (Maklumat Kategori Kerja) -->
                    <div class="modal-body">
                        <div>
                            <h5>Maklumat Kategori Kerja (CIDB)</h5>
                            <hr />
                            &nbsp;&nbsp;
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-3">
                                            <select class="input-group__select ui search dropdown" name="KategoriCidb" id="kategoriCidb" placeholder="&nbsp;">
                                            </select>
                                            <label class="input-group__label" for="KategoriCidb">Kategori</label>
                                        </div>

                                        <div class="form-group col-md-3">
                                            <select class="input-group__select ui search dropdown" name="Situasi Keperluan" id="situasiCidb" placeholder="&nbsp;">
                                                <option value="">-- Sila Pilih --</option>
                                                <option value="1">dan</option>
                                                <option value="2">atau</option>
                                                <option value="0">Terakhir</option>
                                            </select>
                                            <label class="input-group__label" for="Situasi Keperluan">Situasi Keperluan</label>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div id="pengkhususan">
                                <p>Bidang:</p>
                                <div class="table-responsive">

                                    <table id="cidb_table" class="table table-striped" border="1" width="75%" style="display: none">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%;">Pilih</th>
                                                <th style="width: 20%;">Kod Khusus</th>
                                                <th style="width: 40%;">Pengkhususan</th>
                                                <th style="width: 10%;">Kod Kategori</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>

                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-12" align="left">
                                    <button type="button" id="btnSimpanCidb" class="btn btn-secondary btnSimpanCidb" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                        Simpan
                                    </button>
                                </div>
                            </div>



                            &nbsp;&nbsp;
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblCidb" class="table table-striped" style="width: 99%">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Id_KerjaCidb</th>
                                                    <th scope="col">Bil</th>
                                                    <th scope="col">Kod Kategori</th>
                                                    <th scope="col">Kod Khusus</th>
                                                    <th scope="col">Pengkhususan</th>
                                                    <th scope="col">Situasi Keperluan</th>
                                                    <th scope="col">Tindakan</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                            </tfoot>
                                        </table>
                                    </div>

                                    <div>
                                        <br />
                                        <p><strong>Pernyataan Kod Pengkhususan :</strong></p>
                                        <label id="displayKodBidang3" style="font-weight: unset"></label>
                                        <br />
                                        <label id="displayKodBidang4" style="font-weight: unset"></label>

                                    </div>
                                </div>


                        </div>
                    </div>
                </div>


                <!-- tab 6 (Upload Dokumen) -->
                <div class="tab-pane fade" id="upload" role="tabpanel">
                    <div class="modal-body">
                        <div>
                            <h5>Lampiran Dokumen Sokongan</h5>
                            <hr />
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

                            <button class="btn btn-secondary" id="savedokumen">Muat Naik</button>
                        </div>


                        <br />
                        <br />
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
                </div>

                <!-- end tab 6 (Upload Dokumen) -->




                <!-- tab 7 (Ringakasan) -->
                <div class="tab-pane fade" id="ringkasan" role="tabpanel">
                    <div class="modal-body">
                        <div>
                            <h5>Ringkasan Maklumat Permohonan Perolehan</h5>
                            <hr />

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="No Permohonan" id="txtNoMohonR" type="text" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="No Permohonan">No Permohonan</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="Tarikh" id="lblTarikhPOR" type="text" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="Tarikh">Tarikh Permohonan</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="Status" id="lblStatus1R" type="text" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="Status">Status</label>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="No Perolehan" id="txtNoPOR" type="text" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="No Perolehan">No Perolehan</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <textarea class="input-group__input" id="txtTujuanR" placeholder="&nbsp;" name="Tajuk / Tujuan" readonly style="background-color: #f0f0f0; height: 60px"></textarea>
                                            <label class="input-group__label" for="Tajuk / Tujuan">Tajuk / Tujuan</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <textarea class="input-group__input" id="txtSkopR" placeholder="&nbsp;" name="Tajuk / Tujuan" readonly style="background-color: #f0f0f0; height: 60px"></textarea>
                                            <label class="input-group__label" for="Skop">Skop</label>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <select class="input-group__select ui search dropdown" name="Kategori Perolehan" id="ddlkategoriPOR" placeholder="&nbsp;" disabled style="background-color: #f0f0f0; opacity: 1; border-radius: 5px; color: black">
                                            </select>
                                            <label class="input-group__label" for="Kategori Perolehan">Kategori Perolehan</label>
                                            <div class="error-message" style="">Sila pilih kategori perolehan.</div>
                                        </div>
                                        <div class="form-group col-md-4">

                                            <select class="input-group__select ui search dropdown" name="Bekal Kepada" id="ddlListPtjR" placeholder="&nbsp;" disabled style="background-color: #f0f0f0; opacity: 1; border-radius: 5px; color: black">
                                            </select>
                                            <label class="input-group__label" for="Bekal Kepada">Bekal Kepada</label>
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-8">
                                            <input class="input-group__input" name="Pemohon" id="txtPemohonR" type="text" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="Pemohon">Pemohon</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="PTJ" id="ddlPTJPemohonR" type="text" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="PTJ">PTJ</label>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-3">
                                            <input class="input-group__input " id="txtTarikh_Mula_PerolehanR" type="date" placeholder="&nbsp;" name="txtTarikh_Mula_Perolehan" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="txtTarikh_Mula_Perolehan">Anggaran Tarikh Mula</label>
                                        </div>

                                        <div class="form-group col-md-1">
                                            <input class="input-group__input " id="txtTempohR" type="number" placeholder="&nbsp;" name="txtTempoh" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="txtTempoh">Tempoh</label>
                                        </div>

                                        <div class="form-group col-md-2">
                                            <select class="input-group__select ui search dropdown" name="txtJenis_tempoh" id="txtJenis_tempohR" placeholder="&nbsp;" disabled style="background-color: #f0f0f0; opacity: 1; border-radius: 5px; color: black">
                                            </select>
                                            <label class="input-group__label" for="txtJenis_tempoh">Tempoh</label>
                                        </div>

                                        <div class="form-group col-md-3">
                                            <input class="input-group__input " id="txtTarikh_Tamat_PerolehanR" type="date" placeholder="&nbsp;" name="txtTarikh_Tamat_Perolehan" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="txtTarikh_Tamat_Perolehan">Anggaran Bekal Sebelum</label>
                                        </div>


                                    </div>
                                </div>
                            </div>




                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">


                                        <%--                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" id="txtTkh" type="date" name="Tarikh Transaksi" placeholder="&nbsp;" />
                                                <label class="input-group__label" for="Tarikh Keperluan">Tarikh Keperluan</label>
                                            </div>--%>

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input text-right" id="txtAmaunR" placeholder="&nbsp;" name="Rekod Perolehan Terdahulu" oninput="formatInput(this)" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="Rekod Perolehan Terdahulu">Rekod Perolehan Terdahulu (RM)</label>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <textarea class="input-group__input" id="txtJustifikasiR" placeholder="&nbsp;" name="Justifikasi Perolehan" readonly style="background-color: #f0f0f0; height: 60px"></textarea>
                                            <label class="input-group__label" for="Justifikasi Perolehan">Justifikasi Perolehan</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <p><strong>Kod Bidang</strong></p>
                            <div>
                                <div class="table-responsive">
                                    <table id="tblRingkasan1" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <%--<th scope="col">Id_Upload</th>--%>
                                                <th scope="col">Bil</th>
                                                <th scope="col">Kod Bidang</th>
                                                <th scope="col">Bidang</th>
                                                <th scope="col">Situasi Keperluan</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                        <tfoot>
                                        </tfoot>
                                    </table>
                                </div>
                                <br />
                                <p><strong>PERNYATAAN KOD BIDANG :</strong></p>
                                <label id="ringkasanL1" style="font-weight: unset"></label>
                                <label id="ringkasanL2" style="font-weight: unset"></label>
                                <br />
                            </div>
                            <br />
                            <p><strong>Pengkhususan</strong></p>
                            <div>
                                <div class="table-responsive">
                                    <table id="tblRingkasan2" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <%--<th scope="col">Id_Upload</th>--%>
                                                <th scope="col">Bil</th>
                                                <th scope="col">Kod Kategori</th>
                                                <th scope="col">Kod Khusus</th>
                                                <th scope="col">Pengkhususan</th>
                                                <th scope="col">Situasi Keperluan</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                        <tfoot>
                                        </tfoot>
                                    </table>
                                </div>
                                <br />
                                <p><strong>PERNYATAAN KOD KHUSUS :</strong></p>
                                <label id="ringkasanL3" style="font-weight: unset"></label>
                                <br />
                                <label id="ringkasanL4" style="font-weight: unset"></label>
                                <br />
                            </div>

                            <br />

                            <div class="transaction-table table-responsive">
                                <table id="tblSimpanUploadR" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
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
                            <br />
                            <br />
                            <label style="margin-right: 10px">Spesifikasi :</label>
                            <%--                         <button class="lihat-spek-am" id="spekAm">Lihat Spesifikasi Am</button>
                             <button class="lihat-spek-teknikal" id="spekTeknikal">Lihat Spesifikasi Teknikal</button>
                            --%>
                            <span class="badge badge-info p-2 m-1 lihat-spek-am" style="border-radius: 5px; cursor: pointer">
                                <i class="fa fa-file" style="font-size: 14px"></i>
                                <label style="margin-left: 5px; margin-bottom: 0px; font-size: 14px; cursor: pointer">Lihat Spesifikasi Am</label>
                            </span>

                            <span class="badge badge-info p-2 m-1 lihat-spek-teknikal" style="border-radius: 5px; cursor: pointer">
                                <i class="fa fa-file" style="font-size: 14px"></i>
                                <label style="margin-left: 5px; margin-bottom: 0px; font-size: 14px; cursor: pointer">Lihat Spesifikasi Teknikal</label>
                            </span>

                            <br />
                            <br />


                            <div class="text-center">
                                <button type="button" id="ringkasanHantar" class="btn btn-secondary ringkasanHantar" data-toggle="tooltip" data-placement="bottom" title="Hantar">Hantar</button>
                            </div>

                        </div>

                        <br />
                        <br />
                        <br />
                    </div>
                </div>

                <!-- end tab 7 (Ringkasan Dokumen) -->





            </div>
        </div>



        <!-- Modal Pengesahan Cidb-->
        <div class="modal fade" id="saveConfirmationModal6" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel6">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage6"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="confirmSaveButton6">Ya</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- Modal Result -->
        <div class="modal fade" id="resultModal6" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="resultModalLabel6">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="resultModalMessage6"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal Delete Pengesahan-->
        <div class="modal fade" id="saveConfirmationModalDelete6" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabelDelete6">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessageDelete6"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="confirmSaveButtonDelete6">Ya</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Delete Result -->
        <div class="modal fade" id="resultModalDelete6" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="resultModalLabelDelete6">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="resultModalMessageDelete6"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>





        <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" style="min-width: 80%" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

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
                                                <button id="btnSearch4" runat="server" class="btn btn-outline btnSearch4" type="button">
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
                        <div class="col-md-12 ">

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblSenaraiPerolehan" class="table table-striped" style="width: 99%">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th scope="col">No Perolehan</th>
                                                    <th scope="col">Tarikh Mohon</th>
                                                    <th scope="col">Kategori</th>
                                                    <th scope="col">Tujuan</th>
                                                    <th scope="col">Status</th>
                                                    <%-- <th scope="col">Anggaran Perbelanjaan (RM)</th>--%>
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

        <!-- Modal Pengesahan-->
        <div class="modal fade" id="saveConfirmationModal1" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel1">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage1"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="confirmSaveButton1">Ya</button>
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


        <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorModalLabel">Sila isikan maklumat pada medan yang diperlukan.</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="errorModalBody">
                    </div>
                    <div class="modal-footer" style="padding: unset">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>



        <%--modal tab 7 hantar--%>

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


        <!-- Confirmation Modal  -->
        <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-labelledby="confirmationModalLabel" aria-hidden="true">
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


        <!-- Modal Result -->
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


        <div class="modal fade" id="pilihpermohonan" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Sila pilih no permohonan pada tab pertama.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>



        <div id="myModalCheck" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Maklumat Tidak Lengkap</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p id="modalMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="myModalCheckJumlah" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Makluman</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p id="modalMessageJumlah"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <table id="tblSpekTeknikalLVL" style="display: none;">
            <thead>
                <tr>
                    <th scope="col" class="text-center">BIL</th>
                    <th scope="col" class="text-center">SPESIFIKASI AM/ TEKNIKAL/ FAKULTI/ JABATAN</th>
                </tr>
                <tr>
                    <th scope="col">2.0</th>
                    <th scope="col" class="text-center">TECHNICAL SPECIFICATION</th>
                </tr>
            </thead>

            <tbody>
            </tbody>

        </table>

        <table id="tblSpekAmLVL" style="display: none;">
            <thead>
                <tr>
                    <th scope="col" class="text-center">BIL</th>
                    <th scope="col" class="text-center">SPESIFIKASI AM/ TEKNIKAL/ FAKULTI/ JABATAN</th>
                </tr>
                <tr>
                    <th scope="col">1.0</th>
                    <th scope="col" class="text-center">GENERAL REQUIREMENT</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
            </tfoot>
        </table>

        <script type="text/javascript">
            var tabStatus1 = false;
            var tabStatus2 = false;
            var tabStatus3 = false;
            var tabStatus4 = false;
            var tabStatus5 = false;

            var jumlahSebenar = '0';
            var errorMessageJumlah = '';
            var currencyPageTotal = '0'

            document.getElementById('txtTempoh').addEventListener('input', updateEndDate);

            function updateJumlah() {

                // Get the value of the input field
                var inputValue = document.getElementById('txtJumAngHrg').value;

                // Remove commas and decimals
                var cleanedValue = inputValue.replace(/[,]/g, '');

                // Convert the cleaned value to an integer
                var jumlahTotal = parseInt(cleanedValue);

                jumlahSebenar = (jumlahTotal) * 1 + (currencyPageTotal) * 1;

                
            }

            function updateEndDate() {

                let startDate = new Date(document.getElementById('txtTarikh_Mula_Perolehan').value);
                let tempoh = parseInt(document.getElementById('txtTempoh').value);
                let jenisTempoh = KodJenis_tempoh;


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

            var tblLVL = null;
            var tblAM = null;

            var KodJenis_tempoh = "";

            $(document).ready(function () {
                $('#txtJenis_tempoh').dropdown({
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

                            //if (response.d.length === 0) {
                            //    $(obj.dropdown("clear"));
                            //    return false;
                            //}

                            var listOptions = JSON.parse(response.d);

                            if (listOptions.length === 0) {
                                $(objItem).html('<div class="message">No results found.</div>');
                                //$(obj.dropdown("clear"));
                                return false;
                            }

                            $.each(listOptions, function (index, option) {
                                $(objItem).append($('<div class="item" data-value="' + option.kodValue + '">').html(option.text));
                            });

                            $(obj).dropdown('refresh');
                            //$(obj).dropdown('show');
                        }
                    },
                    onChange: function (kodValue, text, $selectedItem) {
                        KodJenis_tempoh = kodValue;
                        updateEndDate()

                    }
                }).dropdown("queryRemote", '', function () {
                    setTimeout(function () {
                        $("#txtJenis_tempoh").dropdown('set selected', '03');
                    }, 50)
                });
            })


            document.addEventListener('DOMContentLoaded', function () {
                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();

                today = yyyy + '-' + mm + '-' + dd;
                document.getElementById('txtTarikh_Mula_Perolehan').value = today;
            });


            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('txtTempoh').value = "0";
            });



            var prevRow = null;
            var childTable = null;
            /* ===============================================================================================================================================================================
                js function 
            =============================================================================================================================================================================== */

            function formatInput(input) {

                const cleanedValue = input.value.replace(/[^0-9.]/g, '');
                const parts = cleanedValue.split('.');
                parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');

                if (parts[1] && parts[1].length > 2) {
                    parts[1] = parts[1].substring(0, 2);
                }

                input.value = parts.join('.');
            }

            /* ===============================================================================================================================================================================
                js function for tab 1 (Maklumat Perolehan)
            =============================================================================================================================================================================== */

            //Dapatkan tarikh semasa
            var todaydate = new Date();
            var day = todaydate.getDate();
            var month = (todaydate.getMonth() + 1).toString().padStart(2, '0');
            var year = todaydate.getFullYear();
            var datestring = day + "/" + month + "/" + year;
            window.onload = function () {
                //Dapatkan tarikh semasa
                document.getElementById("lblTarikhPO").value = datestring;
                document.getElementById("txtTarikh_Mula_Perolehan").value = datestring;
                document.getElementById("txtTarikh_Tamat_Perolehan").value = datestring;


                document.getElementById("txtPemohon").value = '<%= Session("ssusrName") %>';  //ssusrName
                //document.getElementById("txtPemohon").value = <//%= Session("ssusrKodPTj") %>;   //ssusrName
            };


            //Dropdown Tarikh Perolehan
            var myselect = document.getElementById("ddlTahun"),
                startYear = new Date().getFullYear()
            count = 2;
            (function (select, val, count) {
                do {
                    select.add(new Option(val, val), null);
                    val++;
                    count--;
                } while (count);
            })(myselect, startYear, count);


            //Display status
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/displayStatusPO") %>',
                    //url: "PermohonanPoWS.asmx/displayStatusPO",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);

                        $("#lblStatus1").val(jsonData[0].Butiran);
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });

                $('#keperluan_mof').dropdown();
                $('#situasiCidb').dropdown();
                $('#ddlTahun').dropdown();

            });

            var katPerolehan = "";
            //Dropdown Kategori Perolehan
            $('#ddlkategoriPO').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetKategoriPO?q={query}") %>',
                    //url: 'PermohonanPoWs.asmx/GetKategoriPO?q={query}',
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
                        //if (response.d.length === 0) {
                        //    $(obj.dropdown("clear"));
                        //    return false;
                        //}

                        var listOptions = JSON.parse(response.d);

                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">No results found.</div>');
                            //$(obj.dropdown("clear"));
                            return false;
                        }

                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        //if (shouldPop === true) {
                        $(obj).dropdown('show');
                        //}
                    }
                }
            });

            //Dropdown Senarai PTJ
            $('#ddlListPtj').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SenaraiPejabat?q={query}") %>',
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

                        //if (response.d.length === 0) {
                        //    $(obj.dropdown("clear"));
                        //    return false;
                        //}

                        var listOptions = JSON.parse(response.d);

                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">No results found.</div>');
                            //$(obj.dropdown("clear"));
                            return false;
                        }

                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });

                        $(obj).dropdown('refresh');
                        $(obj).dropdown('show');
                    }
                }
            });



            //Display PTj
            $(document).ready(function () {
                var ssusrKodPTj = '<%= Session("ssusrKodPTj") %>';
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetPTjPO") %>',
                    //url: "PermohonanPoWS.asmx/GetPTjPO",
                    data: JSON.stringify({ ssusrKodPTj: ssusrKodPTj }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        // Parse the JSON data
                        var jsonData = JSON.parse(data.d);
                        $("#ddlPTJPemohon").val(jsonData[0].text);
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });
            });

            //Simpan Tab 1 Permohonan
            $('.btnSimpan').off('click').on('click', async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";

                //Split the ddlPTJPemohon value to get kod
                var ddlPTJPemohonValue = $('#ddlPTJPemohon').val();
                var ddlPTJPemohon_kod = ddlPTJPemohonValue.split(' - ')[0];

                // Remove commas from the input value 
                var txtAmaunDecimal = $('#txtAmaun').val().replace(/,/g, '');

                // Convert date format from "dd/MM/yyyy" to "yyyy-MM-dd"
                var lblTarikhPOValue = $('#lblTarikhPO').val();
                var parts = lblTarikhPOValue.split('/');
                var lblTarikhPOFormatted = parts[2] + '-' + parts[1] + '-' + parts[0];


                var lblTarikhMulaValue = $('#txtTarikh_Mula_Perolehan').val();
                var parts1 = lblTarikhMulaValue.split('/');
                var lblTarikhMulaValueFormatted = parts1[2] + '-' + parts1[1] + '-' + parts1[0];

                var lblTarikhTamatValue = $('#txtTarikh_Tamat_Perolehan').val();
                var parts2 = lblTarikhTamatValue.split('/');
                var lblTarikhTamatValueFormatted = parts2[2] + '-' + parts2[1] + '-' + parts2[0];


                /*check input dah isi ke belum*/
                //var statusError = 0;
                //var collectionMessage = "";
                //$('.js-group-one').each(function (ind, obj) {
                //    var err = $(obj).siblings(".error-message");
                //    if ($(obj).val() === "") {

                //        err.addClass("err-active");
                //        statusError = 1
                //    } else {
                //        err.removeClass("err-active");
                //    }
                //})

                //if (statusError === 1) {
                //    $('.error-message.err-active').each(function (ind, obj) {
                //        console.log(obj);
                //        collectionMessage += $(obj).html() + "\n";
                //    })

                //    $('#errorModalBody').html(collectionMessage);
                //    $('#errorModal').modal('show');
                //}
                //return false;


                // Set message in the modal
                var msg = "Anda pasti ingin menyimpan rekod ini?(maklumat perolehan)";
                $('#confirmationMessage1').text(msg);
                $('#saveConfirmationModal1').modal('show');


                $('#confirmSaveButton1').off('click').on('click', async function () {
                    $('#saveConfirmationModal1').modal('hide');
                    var newPermohonanPoHdr = {
                        mohonPoHeader: {
                            txtNoMohon: $('#txtNoMohon').val(),
                            lblTarikhPO: lblTarikhPOFormatted,
                            lblStatus1: $('#lblStatus1').val(),
                            txtNoPO: $('#txtNoPO').val(),
                            ddlTahun: $('#ddlTahun').val(),
                            txtTujuan: $('#txtTujuan').val(),
                            txtSkop: $('#txtSkop').val(),
                            ddlkategoriPO: $('#ddlkategoriPO').val(),
                            ddlPTJPemohon: ddlPTJPemohon_kod,


                            txtTarikh_Mula_Perolehan: $('#txtTarikh_Mula_Perolehan').val(),
                            txtTempoh: $('#txtTempoh').val(),
                            txtJenis_tempoh: KodJenis_tempoh,
                            txtTarikh_Tamat_Perolehan: $('#txtTarikh_Tamat_Perolehan').val(),

                            txtAmaun: txtAmaunDecimal,
                            txtJustifikasi: $('#txtJustifikasi').val(),
                            ddlListPtj: $('#ddlListPtj').val(),
                            tahapPerolehan: $('#tahapPerolehan').val(),
                        }
                    }
                    // txtTkh: $('#txtTkh').val(),

                    var result = JSON.parse(await ajaxSavePermohonanPo(newPermohonanPoHdr));

                    if (result.Status === true) {
                        showModal1("Success", result.Message, "success");
                        $('#txtNoMohon').val(result.Payload.txtNoMohon);
                        $('#txtNoPO').val(result.Payload.txtNoPO);
                    } else {
                        showModal1("Error", result.Message, "error");
                    }

                    sessionStorage.setItem("nombor_mohon", result.Payload.txtNoMohon);

                });
            });

            async function ajaxSavePermohonanPo(mohonPoHeader) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SavePermohonanPo") %>',
                        method: 'POST',
                        data: JSON.stringify(mohonPoHeader),
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
                console.log("tst")
            }

            function showModal1(title, message, type) {
                $('#resultModalTitle1').text(title);
                $('#resultModalMessage1').html(message);
                if (type === "success") {
                    $('#resultModal1').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal1').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal1').modal('show');
            }


            /* ===============================================================================================================================================================================
                js function for tab 2 (Maklumat Spesifikasi Am)
            =============================================================================================================================================================================== */
            var tbl_tab2 = null
            var isClicked = false;
            var $tblListSpek = null;
            var kodSpek = "";


            $(document).ready(function () {
                tbl_tab2 = $("#spekfikasi-table").DataTable({
                    "responsive": true,
                    "searching": false,
                    "paging": false,
                    "ordering": false,
                    "info": false,
                    stateSave: true,
                    "ajax": {
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetSpeksifikasi") %>',
                        "method": 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ nomohon: $('#txtNoMohon').val() });
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
                                return `<button class="btnDetails btndt${data.kod}" data-level="2" data-kod = "' + data + '"><i class="fas fa-plus"></i></button>
                                <label class="lblNo1 spacekanan">${data.butiran}</label>
                                <button class="add-perkara" data-kod="${data.kod}"><i class="fas fa-plus"></i> Sedia Ada</button>
                                <button class="add-perkara-manual" data-kod="${data.kod}"><i class="fas fa-plus"></i> Baru</button>`;

                            },

                        },

                        {
                            data: null,
                            "width": "25%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                return `<label class="spacekanan jumlah"> Item : ${data.Jumlah}</label>
                                        <label class = "jumwajaran"> Jumlah Wajaran : ${data.JumWajaran}</label >`;
                            },
                        },

                    ]
                });

                function openPageInModal(obj) {
                    /*<a href="#" data-url="${data.URL}">${data.NamaFail}</a>*/
                    $('#iframe').src($(obj).data("url"))
                    //bukak modal
                }




                $tblListSpek = $("#listSpekItem").DataTable({
                    "responsive": true,
                    "searching": false,
                    "paging": false,
                    "ordering": false,
                    "info": false,
                    "ajax": {
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetSpeksifikasiDetail") %>',
                        "method": 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ kod: kodSpek });
                        },
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        }
                    },
                    "columns": [
                        {
                            "data": null,
                            "width": "5%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                return `<input type = 'checkbox' class = 'chkpilihSpekDetail' data-kod='${data.Kod}'/> `;
                            },
                        },
                        {
                            "data": null,
                            "width": "70%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                return `<textarea class = 'txtButiranSpekDetail speksize'>${data.Butiran}</textarea>`;
                            },

                        },

                        {
                            data: null,
                            width: "25%",
                            render: function (data, type, row, meta) {
                                if ($('#ddlkategoriPO').val() === "K") {
                                    return "";
                                } else {
                                    if (type !== "display") {
                                        return data;
                                    }
                                    return `<input type='text' class='txtWajaranSpekDetail'/>`;
                                }
                            },
                        }]
                });




                $('#simpanSpekModal').click(async function (evt) {
                    evt.preventDefault();
                    $('#speksifikasiModal').modal('hide');

                    var tmpKodSpek = "";
                    var param = {
                        spekList: [],
                        nomohon: ""
                    };

                    $('.chkpilihSpekDetail').each(function (ind, obj) {
                        if (obj.checked === false) {
                            return;
                        }
                        param.spekList.push({
                            butiran: $('.txtButiranSpekDetail').eq(ind).val(),
                            wajaran: $('.txtWajaranSpekDetail').eq(ind).val(),
                            kodspek: $(obj).data("kod"),
                            kategoriPo: $('#ddlkategoriPO').val()
                        })

                        tmpKodSpek = $(obj).data("kod");
                    });

                    param.nomohon = $('#txtNoMohon').val();

                    var result = await beginSaveSpekDetail(param);

                    if (result.Code === "00") {
                        //console.log(childTable);
                        if (childTable !== null && childTable !== undefined) {
                            childTable.ajax.reload();
                        } else {
                            tbl_tab2.ajax.reload(function () {
                                $('.btndt' + tmpKodSpek).click()
                            });
                        }
                        //refresh
                    }
                    if (result.Status === "success") {
                        showModal4("Success", result.Message, "success");
                    } else {
                        showModal4("Error", result.Message, "error");
                    }
                })


                $('#simpanMwajaran').click(async function (evt) {
                    evt.preventDefault();

                    $('#spekAddManual').modal('hide');

                    var param = {
                        nomohon: $('#txtNoMohon').val(),
                        butiran: $('#txtManualPerkaraSpek').val(),
                        wajaran: $('#txtManualWajaran').val(),
                        kodspek: $('#hidKodSpek').val(),
                        id: $('#hidIDSpek').val(),
                        kategoriPo: $('#ddlkategoriPO').val(),
                    };

                    var result = await beginSaveManual(param);

                    if (result.Code === "00") {
                        if (childTable !== null && childTable !== undefined) {
                            childTable.ajax.reload();
                        } else {
                            tbl_tab2.ajax.reload(function () {
                                $('.btndt' + param.kodspek).click()
                            });
                        }

                    }
                    if (result.Status === "success") {
                        showModal4("Success", result.Message, "success");
                    } else {
                        showModal4("Error", result.Message, "error");
                    }
                });

            });

            async function beginSaveSpekDetail(param) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SimpanSpekDetail") %>',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify(param),
                        success: function (data) {
                            resolve(JSON.parse(data.d));
                        },
                        error: function (error) {
                            console.log("Error: " + error);
                            reject(false);
                        }
                    });
                })
            }

            async function beginSaveManual(param) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SimpanSpekManual") %>',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify(param),
                        success: function (data) {
                            resolve(JSON.parse(data.d));
                        },
                        error: function (error) {
                            console.log("Error: " + error);
                            reject(false);
                        }
                    });
                });
            }


            $("#spekfikasi-table").on('click', '.add-perkara', function (evt) {
                evt.preventDefault();

                if ($('#ddlkategoriPO').val() !== "K") {
                    $tblListSpek.column(2).visible(true);
                } else {
                    $tblListSpek.column(2).visible(false);
                }

                $btn = $(this);
                kodSpek = $btn.data("kod");
                $tblListSpek.ajax.reload();
                $('#speksifikasiModal').modal("show");

            });

            //$("#spekfikasi-table").on('click', '.btnDetails', function (evt) {
            //    evt.preventDefault();

            //   if ($('#ddlkategoriPO').val() !== "K") {
            //        childTable.column(1).visible(true);
            //    } else {
            //        childTable.column(1).visible(false);
            //    }

            //});

            $("#spekfikasi-table").on('click', '.btneditspek', function (evt) {
                evt.preventDefault();

                if ($('#ddlkategoriPO').val() !== "K") {
                    $('#txtManualWajaran').show();
                    $('#txtManualWajaran2').show();

                } else {
                    $('#txtManualWajaran').hide();
                    $('#txtManualWajaran2').hide();

                }

                $btn = $(this);

                var $tr = $btn.closest("tr");

                $('#txtManualPerkaraSpek').val($tr.find("td:eq(0)").html());
                $('#txtManualWajaran').val($tr.find("td:eq(1)").html());

                kodSpek = $btn.data("kod");
                idSpek = $btn.data("id");

                $('#hidKodSpek').val(kodSpek);
                $('#hidIDSpek').val(idSpek);

                $('#spekAddManual').modal("show");
            });



            $("#spekfikasi-table").on('click', '.add-perkara-manual', function (evt) {
                evt.preventDefault();
                $btn = $(this);
                kodSpek = $btn.data("kod");

                if ($('#ddlkategoriPO').val() !== "K") {
                    $('#txtManualWajaran').show();
                    $('#txtManualWajaran2').show();
                } else {
                    $('#txtManualWajaran').hide();
                    $('#txtManualWajaran2').hide();
                }

                $('#txtManualPerkaraSpek').val("");
                $('#txtManualWajaran').val("");
                $('#hidIDSpek').val("");

                $('#hidKodSpek').val(kodSpek);
                $('#spekAddManual').modal("show");
            });


            $('.btnSearchAm').click(async function () {
                // load_loader();
                isClicked = true;
                tbl_tab2.ajax.reload();
                // close_loader();
            })



            /* ===============================================================================================================================================================================
                js function for tab 3 (Maklumat Bajet dan Spesifikasi)
            =============================================================================================================================================================================== */

            var kod_coa_vot = "";
            var kod_PTj = "";
            var kod_KW = "";
            var kod_Operasi = "";
            var kod_Projek = "";

            var ukuranValue = "";
            var ukuranText = "";

            var tblModal = "";
            var id_mohon_dtl_hidden = "";
            var id_teknikal_hidden = "";

            //Dropdown VOT/COA
            $(document).ready(function () {
                $('#ddlCOA').dropdown({
                    selectOnKeydown: true,
                    fullTextSearch: true,
                    apiSettings: {
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetVot_COA?q={query}") %>',
                        //url: 'PermohonanPoWs.asmx/GetVot_COA?q={query}',
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
                                $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                            });

                            // Using data-coltambah to display on input type text
                            $('.item', objItem).on('click', function () {
                                var selectedOption = $(this);

                                var butir_ptj = selectedOption.data('coltambah1')
                                var butir_kw = selectedOption.data('coltambah2')
                                var butir_ko = selectedOption.data('coltambah3')
                                var butir_kp = selectedOption.data('coltambah4')
                                var vot = selectedOption.data('value')
                                var id_ptj = selectedOption.data('coltambah5')
                                var id_kw = selectedOption.data('coltambah6')
                                var id_ko = selectedOption.data('coltambah7')
                                var id_kp = selectedOption.data('coltambah8')

                                var today = new Date();

                                var dd = String(today.getDate()).padStart(2, '0');
                                var mm = String(today.getMonth() + 1).padStart(2, '0');
                                var yyyy = todaydate.getFullYear();

                                today = yyyy + '-' + mm + '-' + dd;

                                // Assign data-coltambah to variables to be used during insert into
                                kod_coa_vot = vot;
                                kod_PTj = id_ptj;
                                kod_KW = id_kw;
                                kod_Operasi = id_ko;
                                kod_Projek = id_kp;


                                $('#ddlPTj').val(butir_ptj);
                                $('#ddlKW').val(butir_kw);
                                $('#ddlKodOperasi').val(butir_ko);
                                $('#ddlKodProjek').val(butir_kp);
                                $('#txtBakiPeruntukan').val(BakiBajet);

                                var BakiBajet = getBakiBajet(yyyy, today, id_kw, id_ko, id_ptj, id_kp, vot)


                                //console.log("data:" + bp);


                            });

                            // Refresh dropdown
                            $(obj).dropdown('refresh');

                            //if (shouldPop === true) {
                            $(obj).dropdown('show');
                            //}
                        }
                    }
                });
            });

            function getBakiBajet(yyyy, today, kod_KW, kod_Operasi, kod_PTj, kod_Projek, kod_coa_vot) {
                //Cara Pertama

                // Specify the URL you want to fetch data from
                const url = '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/fGetBakiSebenar") %>';

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
                $('#txtBakiPeruntukan').val(formattedBakiBersihWithoutRM);
                $('#txtBakiPeruntukan_update').val(formattedBakiBersihWithoutRM);

            }


            //Dropdown VOT/COA
            $(document).ready(function () {
                $('#ddlCOA_update').dropdown({
                    selectOnKeydown: true,
                    fullTextSearch: true,
                    apiSettings: {
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetVot_COA?q={query}") %>',
                        //url: 'PermohonanPoWs.asmx/GetVot_COA?q={query}',
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
                                $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                            });

                            // Using data-coltambah to display on input type text
                            $('.item', objItem).on('click', function () {
                                var selectedOption = $(this);

                                var butir_ptj = selectedOption.data('coltambah1')
                                var butir_kw = selectedOption.data('coltambah2')
                                var butir_ko = selectedOption.data('coltambah3')
                                var butir_kp = selectedOption.data('coltambah4')
                                var vot = selectedOption.data('value')
                                var id_ptj = selectedOption.data('coltambah5')
                                var id_kw = selectedOption.data('coltambah6')
                                var id_ko = selectedOption.data('coltambah7')
                                var id_kp = selectedOption.data('coltambah8')

                                var today = new Date();

                                var dd = String(today.getDate()).padStart(2, '0');
                                var mm = String(today.getMonth() + 1).padStart(2, '0');
                                var yyyy = todaydate.getFullYear();

                                today = yyyy + '-' + mm + '-' + dd;

                                // Assign data-coltambah to variables to be used during insert into
                                kod_coa_vot = vot;
                                kod_PTj = id_ptj;
                                kod_KW = id_kw;
                                kod_Operasi = id_ko;
                                kod_Projek = id_kp;


                                $('#ddlPTj_update').val(butir_ptj);
                                $('#ddlKW_update').val(butir_kw);
                                $('#ddlKodOperasi_update').val(butir_ko);
                                $('#ddlKodProjek_update').val(butir_kp);
                                $('#txtBakiPeruntukan_update').val(BakiBajet);

                                var BakiBajet = getBakiBajet(yyyy, today, id_kw, id_ko, id_ptj, id_kp, vot)


                                //console.log("data:" + bp);


                            });

                            // Refresh dropdown
                            $(obj).dropdown('refresh');

                            //if (shouldPop === true) {
                            $(obj).dropdown('show');
                            //}
                        }
                    }
                });
            });


            //Dropdown Ukuran
            $('#ddlUkuran').dropdown({
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
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        //if (shouldPop === true) {
                        $(obj).dropdown('show');
                        //}
                    }
                }
            });

            //Dropdown Ukuran (update modal)
            $('#ddlUkuran_update').dropdown({
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
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        //if (shouldPop === true) {
                        $(obj).dropdown('show');
                        //}
                    }
                }
            });


            //Kira kira
            $(document).ready(function () {
                // Attach event listener to other elements (e.g., buttons) to trigger multiplication
                $('.other-element').on('click', function () {
                    performMultiplication();
                });

                // Attach event listeners to txtKuantiti and txtAngHrgSeunit
                $('#txtKuantiti, #txtAngHrgSeunit').on('input', function () {
                    formatInput(this);
                    performMultiplication(); // Perform multiplication and update txtJumAngHrg
                });

                $('#txtKuantiti_update, #txtAngHrgSeunit_update').on('input', function () {
                    formatInput(this);
                    performMultiplication(); // Perform multiplication and update txtJumAngHrg
                });
            });
            function performMultiplication() {
                const kuantitiValue = parseFloat($('#txtKuantiti').val().replace(/,/g, '')) || 0; // Remove all commas
                const angHrgSeunitValue = parseFloat($('#txtAngHrgSeunit').val().replace(/,/g, '')) || 0; // Remove all commas
                const result = kuantitiValue * angHrgSeunitValue;
                $('#txtJumAngHrg').val(result.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')); // Update txtJumAngHrg


                updateJumlah();

                const kuantitiValue2 = parseFloat($('#txtKuantiti_update').val().replace(/,/g, '')) || 0; // Remove all commas
                const angHrgSeunitValue2 = parseFloat($('#txtAngHrgSeunit_update').val().replace(/,/g, '')) || 0; // Remove all commas
                const result2 = kuantitiValue2 * angHrgSeunitValue2;
                $('#txtJumAngHrg_update').val(result2.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')); // Update txtJumAngHrg
            }



            //DataTable for Maklumat Bajet dan Spesifikasi
            var tbl = null;
            $(document).ready(function () {
                tbl = $("#tblDataPerolehanDtl").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadOrderRecord_PerolehanDtl") %>',
                        //"url": "PermohonanPoWS.asmx/LoadOrderRecord_PerolehanDtl",
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: $('#txtNoMohon').val() })
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
                            .column(12)
                            .data()
                            .reduce((a, b) => intVal(a) + intVal(b), 0);

                        // Total over this page
                        pageTotal = api
                            .column(12, { page: 'current' })
                            .data()
                            .reduce((a, b) => intVal(a) + intVal(b), 0);

                        currencyPageTotal = pageTotal;

                        // Update footer
                        api.column(12).footer().innerHTML =
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
                        {
                            "data": "Baki_Peruntukan",
                            "title": "Baki Peruntukan (RM)",
                            "render": function (data, type, row) {
                                if (type === 'display' || type === 'filter') {
                                    return '<div class="text-right">' + parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                }
                                return data;
                            }
                        },
                        { "data": "Butiran", "title": "Barang / Perkara" },
                        { "data": "Kuantiti", "title": "Kuantiti" },
                        { "data": "Ukuran", "title": "Ukuran" },
                        //{
                        //"data": "Ukuran",
                        //"title": "Ukuran",
                        //"render": function (data, type, row) {
                        //return ukuranText;
                        //}
                        //},
                        {
                            "data": "Kadar_Harga",
                            "title": "Anggaran Harga Seunit (RM)",
                            "render": function (data, type, row) {
                                if (type === 'display' || type === 'filter') {
                                    return '<div class="text-right">' + parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                }
                                return data;
                            }
                        },

                        {
                            "data": "Jumlah_Harga",
                            "title": "Jumlah Anggaran Harga (RM)",
                            "render": function (data, type, row) {
                                if (type === 'display' || type === 'filter') {
                                    return '<div class="text-right">' + parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                }
                                return data;
                            }
                        },
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
                                    <div class="col-md-2">
                                        <button type="button" class= "btn deleteBtn" style="padding:0px 0px 0px 0px" title="Padam">
                                        <i class="far fa-trash-alt fa-lg"></i>
                                        </button>
                                    </div>
                                <div class="col-md-2">
                                        <button type="button" class="btn modalSpekTeknikalBtn" style="padding:0px 0px 0px 0px" title="Maklumat Spekfikasi Teknikal" data-toggle="modal" data-target="#spekTeknikalModal">
                                        <i class="far fa-file-alt fa-lg"></i>
                                        </button>
                                </div>

                                </div>`;
                            }
                        }
                    ]
                });


                // Event listener for Delete button on tblDataPerolehanDtl
                $("#tblDataPerolehanDtl").off('click', '.deleteBtn').on("click", ".deleteBtn", function (event) {
                    var row = $(this).closest('tr');
                    var dataTable = $('#tblDataPerolehanDtl').DataTable();

                    id_mohon_dtl_hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID

                    var msg = "Anda pasti ingin memadam rekod ini? (maklumat bajet dan spesifikasi)";
                    $('#confirmationMessageDelete3').text(msg);
                    $('#saveConfirmationModalDelete3').modal('show'); // Open the Bootstrap modal

                    $('#confirmSaveButtonDelete3').off('click').on('click', async function () {
                        $('#saveConfirmationModalDelete3').modal('hide'); // Hide the modal
                        var result = JSON.parse(await ajaxdeletePoDtl(id_mohon_dtl_hidden));
                        if (result.Status === "success") {
                            showModalDelete3("Success", result.Message, "success");
                        } else {
                            showModalDelete3("Error", result.Message, "error");
                        }
                        tbl.ajax.reload(); //Reload datatable
                    });
                });
                async function ajaxdeletePoDtl(id_mohon_dtl_hidden) {

                    return new Promise((resolve, reject) => {
                        $.ajax({
                            type: "POST",
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/DeletePoDtl") %>',
                            //url: "PermohonanPoWS.asmx/DeletePoDtl",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: JSON.stringify({ id: id_mohon_dtl_hidden }),
                            success: function (data) {
                                resolve(data.d);
                            },
                            error: function (error) {
                                console.log("Error: " + error);
                                reject(false);
                            }
                        });
                    })
                    console.log("tst")
                }
                function showModalDelete3(title, message, type) {
                    $('#resultModalTitleDelete3').text(title);
                    $('#resultModalMessageDelete3').text(message);
                    if (type === "success") {
                        $('#resultModalDelete3').removeClass("modal-error").addClass("modal-success");
                    } else if (type === "error") {
                        $('#resultModalDelete3').removeClass("modal-success").addClass("modal-error");
                    }
                    $('#resultModalDelete3').modal('show');
                }



                // Event listener for Update & Edit button on tblDataPerolehanDtl
                $("#tblDataPerolehanDtl").off('click', '.editBtn').on("click", ".editBtn", function (event) {
                    //Get row id
                    var row = $(this).closest('tr');
                    var dataTable = $('#tblDataPerolehanDtl').DataTable();

                    id_mohon_dtl_hidden = dataTable.cell(row, 0).data(); //EDIT & UPDATE ROWS BASED ON THIS ID
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPoDtlRowData") %>',
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

                            $("#txtAngHrgSeunit_update").val(jsonData[0].Kadar_Harga);
                            $("#txtJumAngHrg_update").val(jsonData[0].Jumlah_Harga);
                        },
                        error: function (error) {
                            console.log("Error: " + error);
                        }
                    });

                });



                //Get butiran(Barang/Perkara) for display on spesifikasi teknikal modal
                $("#tblDataPerolehanDtl").on("click", ".modalSpekTeknikalBtn", function () {

                    var row = $(this).closest('tr');

                    if ($('#ddlkategoriPO').val() !== "K") {
                        $('#wajaranHideKerja').show();

                    } else {
                        $('#wajaranHideKerja').hide();
                        //tblModal.column(2).visible(false);

                    }

                    var dataTable = $('#tblDataPerolehanDtl').DataTable();

                    $(".btnTambah2").show();
                    $(".btnUndo2").hide();
                    $(".btnKemaskini2").hide();

                    $('#butiran').val('');
                    $('#spesifikasi').val('');
                    $('#wajaran').val('');





                    id_mohon_dtl_hidden = dataTable.cell(row, 0).data();
                    var barang_perkara = dataTable.cell(row, 8).data();

                    console.log(id_mohon_dtl_hidden + "             " + barang_perkara);
                    $('#spekTeknikalModal #butiran').val(barang_perkara);

                    //Datatable Spesifikasi Teknikal Modal
                    $(document).ready(function () {
                        tblModal = $('#tblSpekTeknikal').DataTable({
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
                                "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadOrderRecord_SpekTeknikal") %>',
                                //"url": "PermohonanPoWS.asmx/LoadOrderRecord_SpekTeknikal",
                                type: 'POST',
                                "contentType": "application/json; charset=utf-8",
                                "dataType": "json",
                                data: function (d) {
                                    return JSON.stringify({
                                        id: $('#txtNoMohon').val(), //haha5
                                        hidden: id_mohon_dtl_hidden
                                    })
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
                                { "data": "Id_Teknikal", "title": "Id_Teknikal" }, //Hidden
                                { "data": "", "width": "10%", "title": "Bil" }, // Empty column for index/bil
                                { "data": "Butiran", "width": "60%", "title": "Spesifikasi Teknikal" },
                                { "data": "Wajaran", "width": "15%", "title": "Wajaran" },
                                { "data": null, "width": "15%", "title": "Tindakan" }
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
                                    "targets": 4, // Target the last column (Delete column)
                                    "data": null,
                                    "render": function (data, type, row) {
                                        return `
                                <div class="row">
                                    <div class="col-md-2">
                                        <button type="button" class="btn editBtn2" style="padding:0px 0px 0px 0px" title="Kemaskini"><i class="far fa-edit fa-lg"></i></button>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="button" class= "btn deleteBtn2" style="padding:0px 0px 0px 0px" title="Padam"><i class="far fa-trash-alt fa-lg"></i></button>
                                    </div>
                                </div>`;
                                    }
                                }
                            ],
                            "autoWidth": false

                        });





                        // Event listener for Delete button on tblSpekTeknikal
                        $('#tblSpekTeknikal').off('click').on("click", ".deleteBtn2", function () {
                            var row = $(this).closest("tr");
                            var dataTable = $('#tblSpekTeknikal').DataTable();

                            id_teknikal_hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID
                            console.log(id_teknikal_hidden);

                            var msg = "Anda pasti ingin memadam rekod ini? (Maklumat Spesifikasi Teknikal)";
                            $('#confirmationMessageDeleteSpekTek3').text(msg);
                            $('#saveConfirmationModalDeleteSpekTek3').modal('show'); // Open the Bootstrap modal

                            $('#confirmSaveButtonDeleteSpekTek3').off('click').on('click', async function () {
                                $('#saveConfirmationModalDeleteSpekTek3').modal('hide'); // Hide the modal
                                var result = JSON.parse(await ajaxdeletePoSpekTeknikal(id_teknikal_hidden));
                                if (result.Status === "success") {
                                    showModalDeleteSpekTek3("Success", result.Message, "success");
                                } else {
                                    showModalDeleteSpekTek3("Error", result.Message, "error");
                                }
                                tblModal.ajax.reload(); //Reload datatable
                            });
                        });
                        async function ajaxdeletePoSpekTeknikal(id_teknikal_hidden) {

                            return new Promise((resolve, reject) => {
                                $.ajax({
                                    type: "POST",
                                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/DeletePoSpekTeknikal") %>',
                                    //url: "PermohonanPoWS.asmx/DeletePoSpekTeknikal",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: JSON.stringify({ id: id_teknikal_hidden }),
                                    success: function (data) {
                                        resolve(data.d);
                                    },
                                    error: function (error) {
                                        console.log("Error: " + error);
                                        reject(false);
                                    }
                                });
                            })
                            console.log("tst")
                        }
                        function showModalDeleteSpekTek3(title, message, type) {
                            $('#resultModalTitleDeleteSpekTek3').text(title);
                            $('#resultModalMessageDeleteSpekTek3').text(message);
                            if (type === "success") {
                                $('#resultModalDeleteSpekTek3').removeClass("modal-error").addClass("modal-success");
                            } else if (type === "error") {
                                $('#resultModalDeleteSpekTek3').removeClass("modal-success").addClass("modal-error");
                            }
                            $('#resultModalDeleteSpekTek3').modal('show');
                        }


                        // Event listener for Update & Edit button on tblSpekTeknikal
                        $("#tblSpekTeknikal").off('click', '.editBtn2').on("click", ".editBtn2", function (event) {
                            // Hide the "Tambah" button
                            $(".btnTambah2").hide();
                            // Display both "Undo" and "Kemaskini" buttons
                            $(".btnUndo2").show();
                            $(".btnKemaskini2").show();

                            //Get row id
                            var row = $(this).closest('tr');
                            var dataTable = $('#tblSpekTeknikal').DataTable();

                            id_teknikal_hidden = dataTable.cell(row, 0).data(); //EDIT & UPDATE ROWS BASED ON THIS ID
                            console.log(id_teknikal_hidden);
                            $.ajax({
                                type: "POST",
                                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadSpekTekRowData") %>',
                                //url: "PermohonanPoWS.asmx/LoadSpekTekRowData",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: JSON.stringify({ id: id_teknikal_hidden }),
                                success: function (data) {
                                    var jsonData = JSON.parse(data.d);

                                    $("#spesifikasi").val(jsonData[0].Butiran);
                                    $("#wajaran").val(jsonData[0].Wajaran);
                                },
                                error: function (error) {
                                    console.log("Error: " + error);
                                }
                            });

                        });

                        if ($('#ddlkategoriPO').val() !== "K") {
                            tblModal.column(3).visible(true);

                        } else {
                            tblModal.column(3).visible(false);
                        }

                    });
                });
            });

            //Destroy DataTable inside modal if the modal is closed
            $('#spekTeknikalModal').on('hidden.bs.modal', function () {
                // Function to Destroy DataTable
                if ($.fn.DataTable.isDataTable('#tblSpekTeknikal')) {
                    $('#tblSpekTeknikal').DataTable().destroy();
                }
            });

            // When the "Undo" button is clicked
            $(".btnUndo2").click(function () {
                // Show the "Tambah" button
                $(".btnTambah2").show();
                // Hide both "Undo" and "Kemaskini" buttons
                $(".btnUndo2").hide();
                $(".btnKemaskini2").hide();
            });


            //Insert data with bootstrap modal
            $('.btnTambah').off('click').on('click', async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";

                if ($('#txtNoMohon').val() === "") {
                    $('#pilihpermohonan').modal('show');
                    return false;
                }

                var txtBakiPeruntukanDecimal = $('#txtBakiPeruntukan').val().replace(/,/g, '');
                var txtKuantitiDecimal = $('#txtKuantiti').val().replace(/,/g, '');
                var txtAngHrgSeunitDecimal = $('#txtAngHrgSeunit').val().replace(/,/g, '');
                var txtJumAngHrgDecimal = $('#txtJumAngHrg').val().replace(/,/g, '');
                // Set message in the modal
                var msg = "Anda pasti ingin menyimpan rekod ini? (maklumat bajet dan spesifikasi)";
                $('#confirmationMessage3').text(msg);
                // Open the Bootstrap modal
                $('#saveConfirmationModal3').modal('show');

                $('#confirmSaveButton3').off('click').on('click', async function () {
                    $('#saveConfirmationModal3').modal('hide'); // Hide the modal

                    var newPermohonanPoDtl = {
                        mohonPoDetail: {
                            //bilangan: kod_coa_vot,       NANTI UBAH BILANGAN
                            No_MohonDTL: $('#txtNoMohon').val(),  //haha2
                            coa_vot: kod_coa_vot,
                            ddlPTj: kod_PTj,
                            ddlKW: kod_KW,
                            ddlKodOperasi: kod_Operasi,
                            ddlKodProjek: kod_Projek,
                            txtBakiPeruntukan: txtBakiPeruntukanDecimal,
                            txtPerkara: $('#txtPerkara').val(),
                            txtKuantiti: txtKuantitiDecimal,
                            ddlUkuran: ukuranValue,
                            txtAngHrgSeunit: txtAngHrgSeunitDecimal,
                            txtJumAngHrg: txtJumAngHrgDecimal
                        }
                    }


                    if (jumlahSebenar < 50000 ) {
                        // Display a warning or take necessary action
                        errorMessageJumlah = "Jumlah Permohonan Kurang RM50,000.00"
                        showModalJumlah(errorMessageJumlah);
                    } 

                    var result = JSON.parse(await ajaxSavePO_BajetSpesifikasi(newPermohonanPoDtl));
                    if (result.Status === true) {
                        showModal3("Success", result.Message, "success");
                        clearInputTab3();

                    } else {
                        showModal3("Error", result.Message, "error");
                    }
                    tbl.ajax.reload();

                });
            });



            async function ajaxSavePO_BajetSpesifikasi(mohonPoDetail) {

                return new Promise((resolve, reject) => {

                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SavePO_BajetSpesifikasi") %>',
                        //url: 'PermohonanPoWS.asmx/SavePO_BajetSpesifikasi',
                        method: 'POST',
                        data: JSON.stringify(mohonPoDetail),
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

            function showModal3(title, message, type) {
                $('#resultModalTitle3').text(title);
                $('#resultModalMessage3').html(message);
                if (type === "success") {
                    $('#resultModal3').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal3').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal3').modal('show');
            }

            function clearInputTab3() {

                $('#ddlCOA').dropdown('clear');

                $('#ddlPTj').val('');
                $('#ddlKW').val('');
                $('#ddlKodOperasi').val('');
                $('#ddlKodProjek').val('');
                $('#txtBakiPeruntukan').val('');
                $('#txtPerkara').val('');
                $('#txtKuantiti').val('');
                $('#ddlUkuran').dropdown('clear');
                $('#txtAngHrgSeunit').val('');
                $('#txtJumAngHrg').val('');
            }

            //Insert data with bootstrap modal
            $('.btnKemaskini').off('click').on('click', async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";

                // Remove commas from the input value 
                var txtBakiPeruntukanDecimal = $('#txtBakiPeruntukan_update').val().replace(/,/g, '');
                var txtKuantitiDecimal = $('#txtKuantiti_update').val().replace(/,/g, '');
                var txtAngHrgSeunitDecimal = $('#txtAngHrgSeunit_update').val().replace(/,/g, '');
                var txtJumAngHrgDecimal = $('#txtJumAngHrg_update').val().replace(/,/g, '');
                // Set message in the modal
                var msg = "Anda pasti ingin mengemaskini rekod ini? (maklumat bajet dan spesifikasi)";
                $('#confirmationMessageUpdate3').text(msg);
                // Open the Bootstrap modal
                $('#saveConfirmationModalUpdate3').modal('show');

                $('#confirmSaveButtonUpdate3').off('click').on('click', async function () {
                    $('#saveConfirmationModalUpdate3').modal('hide'); // Hide the modal

                    var newPermohonanPoDtl = {
                        mohonPoDetail: {
                            id_mohonDtl: id_mohon_dtl_hidden,
                            No_MohonDTL: $('#txtNoMohon').val(),  //Haha3
                            coa_vot: kod_coa_vot,
                            ddlPTj: kod_PTj,
                            ddlKW: kod_KW,
                            ddlKodOperasi: kod_Operasi,
                            ddlKodProjek: kod_Projek,
                            txtBakiPeruntukan: txtBakiPeruntukanDecimal,
                            txtPerkara: $('#txtPerkara_update').val(),
                            txtKuantiti: txtKuantitiDecimal,
                            ddlUkuran: ukuranValue,
                            txtAngHrgSeunit: txtAngHrgSeunitDecimal,
                            txtJumAngHrg: txtJumAngHrgDecimal
                        }
                    }


                    var result = JSON.parse(await ajaxUpdatePO_BajetSpesifikasi(newPermohonanPoDtl));
                    if (result.Status === "success") {
                        showModalUpdate3("Success", result.Message, "success");
                    } else {
                        showModalUpdate3("Error", result.Message, "error");
                    }
                    tbl.ajax.reload(); //Reload datatable
                });
            });
            async function ajaxUpdatePO_BajetSpesifikasi(mohonPoDetail) {

                return new Promise((resolve, reject) => {

                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/UpdatePO_BajetSpesifikasi") %>',
                        //url: 'PermohonanPoWS.asmx/UpdatePO_BajetSpesifikasi',
                        method: 'POST',
                        data: JSON.stringify(mohonPoDetail),
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
                console.log("tst")
            }


            function showModalUpdate3(title, message, type) {
                $('#resultModalTitleUpdate3').text(title);
                $('#resultModalMessageUpdate3').text(message);
                if (type === "success") {
                    $('#resultModalUpdate3').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModalUpdate3').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModalUpdate3').modal('show');
            }


            //Insert data 2 with bootstrap modal
            $('.btnTambah2').off('click').on('click', async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";

                // Set message in the modal
                var msg = "Anda pasti ingin menyimpan rekod ini? (Maklumat Spesifikasi Teknikal)";
                $('#confirmationMessage3SpekTeknikal').text(msg);
                // Open the Bootstrap modal
                $('#saveConfirmationModal3SpekTeknikal').modal('show');

                $('#confirmSaveButton3SpekTeknikal').off('click').on('click', async function () {
                    $('#saveConfirmationModal3SpekTeknikal').modal('hide');

                    var newPermohonanPoSpekTeknikal = {
                        mohonPoSpekTeknikal: {

                            no_MohonSpekTeknikal: $('#txtNoMohon').val(),
                            id_mohon_dtl: id_mohon_dtl_hidden,
                            butiran: $('#spesifikasi').val(),
                            wajaran: $('#wajaran').val(),
                            katPerolehan: $('#ddlkategoriPO').val()
                        }
                    }

                    var result = JSON.parse(await ajaxSavePO_SpekTeknikal(newPermohonanPoSpekTeknikal));
                    if (result.Status === true) {
                        showModal3SpekTeknikal("Success", result.Message, "success");
                        tblModal.ajax.reload();
                        clearWajaranTab3();

                    } else {
                        showModal3SpekTeknikal("Error", result.Message, "error");
                    }
                });
            });



            async function ajaxSavePO_SpekTeknikal(mohonPoSpekTeknikal) {

                return new Promise((resolve, reject) => {

                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SavePO_SpekTeknikal") %>',
                        //url: 'PermohonanPoWS.asmx/SavePO_SpekTeknikal',
                        method: 'POST',
                        data: JSON.stringify(mohonPoSpekTeknikal),
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

            function showModal3SpekTeknikal(title, message, type) {
                $('#resultModalTitle3SpekTeknikal').text(title);
                $('#resultModalMessage3SpekTeknikal').html(message);
                if (type === "success") {
                    $('#resultModal3SpekTeknikal').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal3SpekTeknikal').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal3SpekTeknikal').modal('show');
            }


            function clearWajaranTab3() {
                $('#spesifikasi').val('');
                $('#wajaran').val('');
            }


            //Update data 2 with bootstrap modal
            $('.btnKemaskini2').off('click').on('click', async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                // Set message in the modal
                var msg = "Anda pasti ingin mengemaskini rekod ini? (Maklumat Spesifikasi Teknikal)";
                $('#confirmationMessageUpdateSpekTeknikal').text(msg);
                // Open the Bootstrap modal
                $('#saveConfirmationModalUpdateSpekTeknikal').modal('show');

                $('#confirmSaveButtonUpdateSpekTeknikal').off('click').on('click', async function () {
                    $('#saveConfirmationModalUpdateSpekTeknikal').modal('hide'); // Hide the modal

                    var newPermohonanPoSpekTeknikal = {
                        mohonPoSpekTeknikal: {
                            idTeknikal: id_teknikal_hidden,
                            butiran: $('#spesifikasi').val(),
                            wajaran: $('#wajaran').val()
                        }
                    }


                    var result = JSON.parse(await ajaxUpdatePO_SpekTeknikal(newPermohonanPoSpekTeknikal));
                    if (result.Status === true) {
                        showModalUpdateSpekTeknikal("Success", result.Message, "success");
                        $(".btnTambah2").show();
                        $(".btnUndo2").hide();
                        $(".btnKemaskini2").hide();
                        $('#spesifikasi').val('');
                        $('#wajaran').val('');
                        tblModal.ajax.reload();

                    } else {
                        showModalUpdateSpekTeknikal("Error", result.Message, "error");
                    }

                });
            });


            async function ajaxUpdatePO_SpekTeknikal(mohonPoSpekTeknikal) {

                return new Promise((resolve, reject) => {

                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/UpdatePO_SpekTeknikal") %>',
                        method: 'POST',
                        data: JSON.stringify(mohonPoSpekTeknikal),
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
                console.log("tst")
            }
            function showModalUpdateSpekTeknikal(title, message, type) {
                $('#resultModalTitleUpdateSpekTeknikal').text(title);
                $('#resultModalMessageUpdateSpekTeknikal').text(message);
                if (type === "success") {
                    $('#resultModalUpdateSpekTeknikal').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModalUpdateSpekTeknikal').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModalUpdateSpekTeknikal').modal('show');
            }


            /* ===============================================================================================================================================================================
                js function for tab 4 (Maklumat Bidang Perolehan)
            =============================================================================================================================================================================== */

            var tbl8 = null;
            var isClickedTab4 = false;

            function generateTableMof(id, type) {
                var col = null;
                var colDef = null;
                if (type === "view") {
                    col = [
                        { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                        { "data": "Kod_Bidang", "title": "Kod_Bidang" },
                        { "data": "Butiran", "title": "Butiran" },
                        { "data": "Syarat", "title": "Syarat" },
                    ]

                    colDef = [
                        {
                            "targets": 0,
                            visible: true,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                    ]
                } else {
                    col = [
                        { "data": "Id_Jualan", "title": "Id_Jualan" }, //Hidden  
                        { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                        { "data": "Kod_Bidang", "title": "Kod_Bidang" },
                        { "data": "Butiran", "title": "Butiran" },
                        { "data": "Syarat", "title": "Syarat" },
                        { "data": null, "title": "Tindakan" }
                    ]

                    colDef = [
                        {
                            "targets": 0,
                            visible: false,
                            searchable: false
                        },
                        {
                            "targets": 1,
                            visible: false,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                        {
                            "targets": 5, // Target the last column (Delete column)
                            "data": null,
                            "render": function (data, type, row) {
                                return `
                            <div class="row">
                                <div class="col-md-2">
                                    <button type="button" class="btn deleteBtn4" style="padding:0px 0px 0px 0px" title="Padam">
                                        <i class="far fa-trash-alt fa-lg"></i>
                                    </button>
                                </div>
                            </div>`;
                            }
                        }
                    ];
                }

                return $("#" + id).DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_BidangMof") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: $('#txtNoMohon').val() });
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
                    "columns": col,
                    "columnDefs": colDef
                });
            }

            $('.tablinks').click(async function (evt) {
                await ClearSessionNoMohon();
            });

            async function ClearSessionNoMohon() {
                try {

                                const response = await fetch('<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/ClearSessionNoMohon") %>', {
                         method: 'POST',
                         headers: {
                             'Content-Type': 'application/json'
                         },
                     });
                     const data = await response.json();
                     return JSON.parse(data.d);
                 } catch (error) {
                     console.error('Error:', error);
                     return false;
                 }
             }

            var tblRingkasan = null;
            $(document).ready(function () {
                tbl8 = generateTableMof("tblMof");
                tblRingkasan = generateTableMof("tblRingkasan1", "view");

                <%--tbl8 = $("#tblMof").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_BidangMof") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: $('#txtNoMohon').val() });
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
                        { "data": "Id_Jualan", "title": "Id_Jualan" }, //Hidden  
                        { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                        { "data": "Kod_Bidang", "title": "Kod_Bidang" },
                        { "data": "Butiran", "title": "Butiran" },
                        { "data": "Syarat", "title": "Syarat" },
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
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                        {
                            "targets": 5, // Target the last column (Delete column)
                            "data": null,
                            "render": function (data, type, row) {
                                return `
                        <div class="row">
                            <div class="col-md-2">
                                <button type="button" class="btn deleteBtn4" style="padding:0px 0px 0px 0px" title="Padam">
                                    <i class="far fa-trash-alt fa-lg"></i>
                                </button>
                            </div>
                        </div>`;
                            }
                        }
                    ]
                });--%>

                $('.btnSearchMof').click(async function () {
                    // load_loader();
                    isClickedTab4 = true;
                    tbl8.ajax.reload();
                    getBidangKod();
                    getBidangKod2();
                    // close_loader();
                });

                $('.btnSearchRingkasan').click(async function () {

                    var flag = true;
                    if (flag === true) {
                        $('.nav-link.active').removeClass("active");
                        $(this).addClass("active");
                        $(".tab-pane.fade.active.show").removeClass("active show")
                        $(".tab-pane.fade.active.show").removeClass("active show")
                        $('#ringkasan').addClass("active show")
                        LoadRingkasan();

                    } else {
                        alert("Sila lengkapkan permohonan.");
                    }


                })
            });

            //const txtTarikh = document.getElementById('txtTarikh');
            //txtTarikh.addEventListener('input', checkInputs);

            async function LoadRingkasan() {
                show_loader();
                tabStatus1 = false
                tabStatus2 = false
                tabStatus3 = false
                tabStatus4 = false
                tabStatus5 = false

                countCall = 0

                getMaklumatPemohon($('#txtNoMohon').val(), "view")

                tblRingkasan.ajax.reload(function () {
                    tabStatus1 = true;
                    callData();
                });

                tblRingkasanCidb.ajax.reload(function () {
                    tabStatus2 = true;
                    callData();
                });

                tblLVL.ajax.reload(function () {
                    tabStatus3 = true;
                    callData();
                });
                tblAM.ajax.reload(function () {
                    tabStatus4 = true;
                    callData();
                });

                tblLampiranR.ajax.reload(function () {
                    tabStatus5 = true;
                    callData();
                });


                isClickedTabLampiranR = true;
                isClickedRingkasanCidb = true;

                getBidangKod();
                getBidangKod2();
                getBidangKod3();
                getBidangKod4();
                showKaedahPerolehan()

                //while (tabStatus1 === false || tabStatus2 === false || tabStatus3 === false || tabStatus4 === false || tabStatus5 === false || tabStatus6 === false) {

                //}



                //setTimeout(async function () {


                //    var tab3DataLength = tbl.data().toArray().length;
                //    var tab4DataLength = tblRingkasan.data().toArray().length;
                //    var ddlkategoriPOValue = $('#ddlkategoriPO').val();
                //    var tab5DataLength = tblRingkasanCidb.data().toArray().length;
                //    var tblLvlLength = tblLVL.data().toArray().length;
                //    var tblAMLength = tblAM.data().toArray().length;
                //    var errorMessage = "";

                //    var btnHantar = document.getElementById('ringkasanHantar');
                //    btnHantar.disabled = true;

                //    console.log("tblLvlLength=", tblLvlLength, " array=", tblRingkasanCidb.data().toArray());

                //    if (tab3DataLength === 0) {
                //        errorMessage += "Sila lengkapkan pada tab 3 <br/>";
                //    }

                //    if (tab4DataLength === 0) {
                //        errorMessage += "Sila isi maklumat pada tab 4 <br/>";
                //    }

                //    if (tblLvlLength === 0) {
                //        errorMessage += "Sila isi maklumat Maklumat Spesifikasi Teknikal <br/>";
                //    }

                //    if (tblAMLength === 0) {
                //        errorMessage += "Sila isi maklumat Maklumat Maklumat Spesifikasi Am <br/>";
                //    }

                //    if (ddlkategoriPOValue === "K" && tab5DataLength === 0) {
                //        errorMessage += "Sila isi maklumat pada tab 5 <br/>";
                //    }

                //    if (errorMessage) {
                //        showModal(errorMessage);
                //    }

                //    if (ddlkategoriPOValue === "K" && tab5DataLength === 0 || tblAMLength === 0 || tblLvlLength === 0 || tab4DataLength === 0 || tab3DataLength === 0 ) {
                //        btnHantar.disabled = true;
                //        console.log("true")
                //    } else {
                //        btnHantar.disabled = false;
                //        console.log("false")
                //    }

                //    close_loader();

                //}, 100);
            }

            function showModal(message) {
                if (message) {
                    $('#modalMessage').html(message);
                    $('#myModalCheck').modal('show');
                }
            }

            function showModalJumlah(message) {
                if (message) {
                    $('#modalMessageJumlah').html(message);
                    $('#myModalCheckJumlah').modal('show');
                }
            }

            var countCall = 0;

            function callData() {
                if (tabStatus1 === false || tabStatus2 === false || tabStatus3 === false || tabStatus4 === false || tabStatus5 === false) {
                    return;
                }

                countCall += 1;
                if (countCall > 1) {
                    return;
                }

                var tab3DataLength = tbl.data().toArray().length;
                var tab4DataLength = tblRingkasan.data().toArray().length;
                var ddlkategoriPOValue = $('#ddlkategoriPO').val();
                var tab5DataLength = tblRingkasanCidb.data().toArray().length;
                var tblLvlLength = tblLVL.data().toArray().length;
                var tblAMLength = tblAM.data().toArray().length;
                var tblLampiranLength = tblLampiran.data().toArray().length;

                var errorMessage = "";

                var btnHantar = document.getElementById('ringkasanHantar');
                btnHantar.disabled = true;

                console.log("tblLvlLength=", tblLvlLength, " array=", tblRingkasanCidb.data().toArray());

                if ($('#txtNoMohon').val() === '') {
                    errorMessage += "Sila lengkapkan pada tab 1. <br/>";
                }

                if (tblAMLength === 0) {
                    errorMessage += "Sila lengkapkan pada tab 2. <br/>";
                }

                if (tab3DataLength === 0) {
                    errorMessage += "Sila lengkapkan pada tab 3 (Maklumat Bajet).<br/>";
                }

                if (tblLvlLength === 0) {
                    errorMessage += "Sila lengkapkan pada tab 3. (Spesifikasi Teknikal).<br/>";
                }

                if (tab4DataLength === 0) {
                    errorMessage += "Sila isi maklumat pada tab 4 <br/>";
                }

                if (ddlkategoriPOValue === "K" && tab5DataLength === 0) {
                    errorMessage += "Sila isi maklumat pada tab 5 <br/>";
                }

                //if (tblLampiranLength === 0) {
                //    errorMessage += "Sila isi maklumat pada tab 6. <br/>";
                //}

                if (currencyPageTotal <= 50000) {
                    errorMessage += "Jumlah Permohonan Kurang RM50,000.00. Sila tambah Jumlah Permohonan di Tab 2. <br/>";
                }

                if (errorMessage) {
                    showModal(errorMessage);
                }

                

                if (ddlkategoriPOValue === "K" && tab5DataLength === 0 || tblAMLength === 0 || tblLvlLength === 0 || tab4DataLength === 0 || tab3DataLength === 0 ) {
                    btnHantar.disabled = true;
                } else {
                    btnHantar.disabled = false;
                }



                close_loader();
            }



            //Proses Delete Bidang Mof
            $("#tblMof").off('click', '.deleteBtn4').on("click", ".deleteBtn4", function (event) {
                var row = $(this).closest('tr');
                var dataTable = $('#tblMof').DataTable();

                Id_Jualan_Hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID

                var msg = "Anda pasti ingin memadam rekod ini? (maklumat bajet dan spesifikasi)";
                $('#confirmationMessageDelete4').text(msg);
                $('#saveConfirmationModalDelete4').modal('show'); // Open the Bootstrap modal

                $('#confirmSaveButtonDelete4').off('click').on('click', async function () {
                    $('#saveConfirmationModalDelete4').modal('hide'); // Hide the modal
                    var result = JSON.parse(await ajaxdeleteBidang(Id_Jualan_Hidden));
                    if (result.Status === true) {
                        getBidangKod();
                        getBidangKod2();
                        showModalDelete4("Success", result.Message, "success");
                    } else {
                        showModalDelete4("Error", result.Message, "error");
                    }

                    tbl8.ajax.reload(); //Reload datatable
                });
            });
            async function ajaxdeleteBidang(Id_Jualan_Hidden) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/DeleteBidangMof2") %>',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify({ id: Id_Jualan_Hidden }),
                        success: function (data) {
                            resolve(data.d);
                        },
                        error: function (error) {
                            console.log("Error: " + error);
                            reject(false);
                        }
                    });
                })
                console.log("test delete bidang mof")
            }
            function showModalDelete4(title, message, type) {
                $('#resultModalTitleDelete4').text(title);
                $('#resultModalMessageDelete4').text(message);
                if (type === "success") {
                    $('#resultModalDelete4').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModalDelete4').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModalDelete4').modal('show');
            }


            //button simpan bidang MOF  btnSimpanMof SaveBidangMof
            $('.btnSimpanMof').off('click').on('click', async function () {

                if ($('#txtNoMohon').val() === "") {
                    $('#pilihpermohonan').modal('show');
                    return false;
                }

                var msg = "";
                var $selectedRadio = $('.selectionBidang:checked');

                if ($selectedRadio === null || $selectedRadio === undefined) {
                    return false;
                }

                //console.log($selectedRadio.data("kodbidang"));
                //console.log($('input[name="selectionBidang"]:checked').attr("data-kodbidang"));

                var kodBidang = $('.selectionBidang:checked').closest("tr").find("td:eq(1)").html();

                var msg = "Anda pasti ingin menyimpan rekod ini? (Bidang MOF)";
                $('#confirmationMessage4').text(msg);
                $('#saveConfirmationModal4').modal('show');

                $('#confirmSaveButton4').off('click').on('click', async function () {
                    $('#saveConfirmationModal4').modal('hide'); // Hide the modal

                    // Include selected values in the object
                    var newBidangMof = {
                        bidangMofHeader: {
                            noMohon: $('#txtNoMohon').val(),
                            syarat: $('#keperluan_mof').val(),
                            kodBidang: kodBidang
                        }
                    }

                    var result = JSON.parse(await ajaxSaveBidangMof(newBidangMof));

                    if (result.Status === true) {
                        showModal4("Success", result.Message, "success");
                        getBidangKod();
                        getBidangKod2();
                    }
                    else {
                        showModal4("Error", result.Message, "error");
                    }
                    tbl8.ajax.reload();
                    // Save No_Mohon which will be used later on other tabs
                    //sessionStorage.setItem("nombor_mohon", result.Payload.txtNoMohon);
                });
            });

            async function ajaxSaveBidangMof(bidangMofHeader) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SaveBidangMof") %>',
                        method: 'POST',
                        data: JSON.stringify(bidangMofHeader),
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

            function showModal4(title, message, type) {
                $('#resultModalTitle4').text(title);
                $('#resultModalMessage4').text(message);
                if (type === "success") {
                    $('#resultModal4').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal4').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal4').modal('show');
            }


            function getBidangKod() {
                var noMohon = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusBidang") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon: noMohon }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        console.log(result);
                        $('#displayKodBidang1').html(result.Payload);
                        $('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                    }
                });
            }

            getBidangKod();

            function getBidangKod2() {
                var noMohon2 = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusBidangDescription") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon2: noMohon2 }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        console.log(result);
                        $('#displayKodBidang2').html(result.Payload);
                        $('#ringkasanL2').html(result.Payload);

                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                    }
                });
            }
            getBidangKod2();




            /* ===============================================================================================================================================================================
                js function for tab 5 (Maklumat Kategori Kerja)
            =============================================================================================================================================================================== */

            var tbl9 = null;
            var isClickedTab9 = false;

            $(document).ready(function () {
                tbl9 = $("#tblCidb").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_Cidb") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: $('#txtNoMohon').val() });
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
                        { "data": "Id_Jualan" }, //Hidden  
                        { "data": "Bil" }, // Empty column for index/bil
                        { "data": "Kod_Kategori" },
                        { "data": "Kod_Khusus" },
                        { "data": "Butiran" },
                        { "data": "Syarat" },
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
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                        {
                            "targets": 6, // Target the last column (Delete column)
                            "data": null,
                            "render": function (data, type, row) {
                                return `
                        <div class="row">
                            <div class="col-md-2">
                                <button type="button" class="btn deleteBtn5" style="padding:0px 0px 0px 0px" title="Padam">
                                    <i class="far fa-trash-alt fa-lg"></i>
                                </button>
                            </div>
                        </div>`;
                            }
                        }
                    ]
                });

                $('.btnSearchCidb').click(async function () {
                    // load_loader();
                    isClickedTab9 = true;
                    tbl9.ajax.reload();
                    getBidangKod3();
                    getBidangKod4();
                    // close_loader();
                });
            });



            //button simpan CIDB
            $('.btnSimpanCidb').off('click').on('click', async function () {

                if ($('#txtNoMohon').val() === "") {
                    $('#pilihpermohonan').modal('show');
                    return false;
                }

                var msg = "";
                var $selectedRadio = $('.selectionBidangCidb:checked');

                if ($selectedRadio === null || $selectedRadio === undefined) {
                    return false;
                }

                var kodkhusus = $('.selectionBidangCidb:checked').closest("tr").find("td:eq(1)").html();
                var kodkategori = $('.selectionBidangCidb:checked').closest("tr").find("td:eq(3)").html();

                var msg = "Anda pasti ingin menyimpan rekod ini? (Kategori Kerja (CIDB))";
                $('#confirmationMessage6').text(msg);
                $('#saveConfirmationModal6').modal('show');

                $('#confirmSaveButton6').off('click').on('click', async function () {
                    $('#saveConfirmationModal6').modal('hide'); // Hide the modal

                    // Include selected values in the object
                    var newBidangCidb = {
                        bidangCidbHeader: {
                            noMohon: $('#txtNoMohon').val(),
                            syarat: $('#situasiCidb').val(),
                            kodkhusus: kodkhusus,
                            kodkategori: kodkategori
                        }
                    }

                    var result = JSON.parse(await ajaxSaveBidangCidb(newBidangCidb));

                    if (result.Status === true) {
                        showModal6("Success", result.Message, "success");
                        getBidangKod3();
                        getBidangKod4();
                    }
                    else {
                        showModal6("Error", result.Message, "error");
                    }
                    tbl9.ajax.reload();
                    // Save No_Mohon which will be used later on other tabs
                    //sessionStorage.setItem("nombor_mohon", result.Payload.txtNoMohon);
                });
            });

            async function ajaxSaveBidangCidb(bidangCidbHeader) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SaveBidangCidb") %>',
                        method: 'POST',
                        data: JSON.stringify(bidangCidbHeader),
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

            function showModal6(title, message, type) {
                $('#resultModalTitle6').text(title);
                $('#resultModalMessage6').text(message);
                if (type === "success") {
                    $('#resultModal6').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal6').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal6').modal('show');
            }


            //Proses Delete CIDB
            $("#tblCidb").off('click', '.deleteBtn5').on("click", ".deleteBtn5", function (event) {
                var row = $(this).closest('tr');
                var dataTable = $('#tblCidb').DataTable();

                Id_Jualan_Hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID

                var msg = "Anda pasti ingin memadam rekod ini?";
                $('#confirmationMessageDelete6').text(msg);
                $('#saveConfirmationModalDelete6').modal('show');

                $('#confirmSaveButtonDelete6').off('click').on('click', async function () {
                    $('#saveConfirmationModalDelete6').modal('hide'); // Hide the modal
                    var result = JSON.parse(await ajaxdeleteCidb(Id_Jualan_Hidden));
                    if (result.Status === true) {
                        getBidangKod3();
                        getBidangKod4();
                        showModalDelete6("Success", result.Message, "success");
                    } else {
                        showModalDelete6("Error", result.Message, "error");
                    }

                    tbl9.ajax.reload(); //Reload datatable
                });
            });
            async function ajaxdeleteCidb(Id_Jualan_Hidden) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/DeleteCidb") %>',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify({ id: Id_Jualan_Hidden }),
                        success: function (data) {
                            resolve(data.d);
                        },
                        error: function (error) {
                            console.log("Error: " + error);
                            reject(false);
                        }
                    });
                })
            }

            function showModalDelete6(title, message, type) {
                $('#resultModalTitleDelete6').text(title);
                $('#resultModalMessageDelete6').text(message);
                if (type === "success") {
                    $('#resultModalDelete6').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModalDelete6').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModalDelete6').modal('show');
            }

            function getBidangKod3() {
                var noMohon = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusCidb") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json', // Expecting plain text from the server
                    data: JSON.stringify({ noMohon: noMohon }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        console.log(result);
                        $('#displayKodBidang3').html(result.Payload);
                        $('#ringkasanL3').html(result.Payload);

                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                    }
                });
            }
            getBidangKod3();

            function getBidangKod4() {
                var noMohon = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusCidbDescription") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon: noMohon }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        console.log(result);
                        $('#displayKodBidang4').html(result.Payload);
                        $('#ringkasanL4').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                    }
                });
            }
            getBidangKod4();




            //Dropdown Syarikat Bidang Utama
            $('#bidang_mof').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Get_Syarikat_Bidang_Utama?q={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query });
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

                        //if (shouldPop === true) {
                        $(obj).dropdown('show');
                        //}
                    }
                }
            });

            $('#bidang_mof').change(function () {
                $('#sub_bidang_mof').dropdown("clear");
            })

            $('#sub_bidang_mof').change(function (evt) {
                var tableBody = $('#bidang_mof_table tbody');
                tableBody.html("");
                return getTableData();
            })

            function getTableData() {
                var id_sub_bidang = $('#sub_bidang_mof').val();

                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Show_Table_Bidang_Utama") %>',
                    method: 'POST',
                    data: JSON.stringify({ kod_sub_bidang: id_sub_bidang }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        if (data === "") {
                            return false;
                        }
                        data = JSON.parse(data.d);
                        var tableBody = $('#bidang_mof_table tbody');
                        $.each(data, function (index, item) {
                            var row = '<tr>' +
                                '<td><input type="radio" data-kodbidang = "' + item.kodbidang + '" name="selectionBidang" class = "selectionBidang"></td>' +      //haha99
                                '<td>' + item.kodbidang + '</td>' +
                                '<td>' + item.butiran + '</td>' +
                                '</tr>';
                            tableBody.append(row);
                        });

                        //$('#bidang_mof_table').DataTable();
                        $('#bidang_mof_table').attr("style", "");
                        //$('#btnSimpanMof').attr("style","")  //ubah
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                    }

                });
            }

            //Dropdown Sub Syarikat Bidang Utama
            $('#sub_bidang_mof').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Get_Sub_Bidang_Utama?q={query}&kodmof={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({ q: settings.urlData.query, kodmof: $('#bidang_mof').dropdown("get value") });
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
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        //if (shouldPop === true) {
                        $(obj).dropdown('show');
                        //}
                    }
                }
            });


            $('#kategoriCidb').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetKodCidb?q={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query });
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

                        //if (shouldPop === true) {
                        $(obj).dropdown('show');
                    }
                }
            });

            $('#kategoriCidb').change(function (evt) {
                var tableBody = $('#cidb_table tbody');
                tableBody.html("");
                return getTableData2();
            })

            function getTableData2() {
                var id_cidb = $('#kategoriCidb').val();

                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Show_Table_Cidb") %>',
                    method: 'POST',
                    data: JSON.stringify({ kod_kategori: id_cidb }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        if (data === "") {
                            return false;
                        }
                        data = JSON.parse(data.d);
                        var tableBody = $('#cidb_table tbody');
                        $.each(data, function (index, item) {
                            var row = '<tr>' +
                                '<td><input type="radio" data-kodkhusus="' + item.kodkhusus + '" data-kodkategori="' + item.kodkategori + '" name="selectionBidangCidb" class="selectionBidangCidb"></td>' +      //haha99
                                '<td>' + item.kodkhusus + '</td>' +
                                '<td>' + item.butiran + '</td>' +
                                '<td>' + item.kodkategori + '</td>' +
                                '</tr>';
                            tableBody.append(row);
                        });

                        //$('#bidang_mof_table').DataTable();
                        $('#cidb_table').attr("style", "");
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                    }

                });
            }


            function ShowPopup(elm) {

                //alert("test");
                if (elm == "1") {

                    $('#permohonan').modal('toggle');


                }
                else if (elm == "2") {

                    $(".modal-body div").val("");
                    $('#permohonan').modal('toggle');

                    //    tbl.clear().draw()
                }
            }

            var tbl5 = null
            var isClicked5 = false;
            var selectedNoMohon = "";
            $(document).ready(async function () {

                selectedNoMohon = "<%=Session("nomohon")%>";
                if (selectedNoMohon !== "") {
                    await getMaklumatPemohon(selectedNoMohon);
                }

                tbl5 = $("#tblSenaraiPerolehan").DataTable({

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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_SenaraiPerolehan") %>',
                        method: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        },
                        "data": function () {

                            var startDate = $('#txtTarikhStart').val()
                            var endDate = $('#txtTarikhEnd').val()

                            return JSON.stringify({
                                category_filter: $('#categoryFilter').val(),
                                isClicked5: isClicked5,
                                tkhMula: startDate,
                                tkhTamat: endDate
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
                            rowClickHandler(data.No_Mohon);
                        });
                    },

                    "columns": [
                        {
                            data: "Bil",
                        },
                        {
                            "data": "No_Mohon",
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
                        { "data": "Tarikh_Mohon" },
                        { "data": "kategori_butiran" },
                        { "data": "Tujuan" },
                        { "data": "Butiran" },


                    ],
                    columnDefs: [
                        { targets: [0], visible: false },
                    ],
                });
            });


            $('.btnSearch4').click(async function () {
                show_loader();
                isClicked5 = true;
                tbl5.ajax.reload();
                close_loader();
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



            // add clickable event in DataTable row
            async function rowClickHandler(id) {
                if (id !== "") {
                    // modal dismiss
                    $('#permohonan').modal('toggle');
                    await getMaklumatPemohon(id);
                }
            }

            async function getMaklumatPemohon(id, type) {
                //BACA HEADER PEROLEHAN
                var recordHdr = await AjaxGetRecordHdrPerolehan(id);
                await AddRowHeader(null, recordHdr, type);
            }

            async function clearAllRowsHdr() {

                $('#txtNoPO').val("");
                $('#txtTujuan').val("");
                $('#txtSkop').val("");
                $("#ddlKategoriPO").empty();
                $('#ddlListPtj').empty();

            }

            async function AjaxGetRecordHdrPerolehan(id) {
                try {

                    const response = await fetch('<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadHdrPerolehan") %>', {
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

            async function AddRowHeader(totalClone, objOrder, type) {
                var counter = 1;
                if (objOrder !== null && objOrder !== undefined) {
                    totalClone = objOrder.Payload.length;
                }

                if (counter <= objOrder.Payload.length) {
                    await setValueToRow_HdrPerolehan(objOrder.Payload[counter - 1], type);
                }
            }

            async function setValueToRow_HdrPerolehan(orderDetail, type) {
                var inputType = "";

                if (type === "view") {
                    inputType = "R"
                }
                else {
                    await clearAllRowsHdr();
                }

                $('#txtNoMohon' + inputType).val(orderDetail.No_Mohon)
                $('#lblTarikhPO' + inputType).val(orderDetail.Tarikh_Mohon)
                $('#lblStatus1' + inputType).val(orderDetail.status_dok)

                $('#txtNoPO' + inputType).val(orderDetail.No_Mohon)
                // Dropdown ddlTahun
                $('#ddlTahun' + inputType).dropdown('set selected', orderDetail.Tahun_Perolehan);
                // $('#ddlTahun' + inputType).append("<option value = '" + orderDetail.Tahun_Perolehan + "'>" + orderDetail.Tahun_Perolehan + "</option>")

                $('#txtTujuan' + inputType).val(orderDetail.Tujuan)
                $('#txtSkop' + inputType).val(orderDetail.Skop)


                $('#txtTarikh_Mula_Perolehan' + inputType).val(orderDetail.Tarikh_Mula)
                $('#txtTempoh' + inputType).val(orderDetail.Tempoh)
                $('#txtTarikh_Tamat_Perolehan' + inputType).val(orderDetail.Bekal_Sebelum)

                if (type === "view") {
                    $('#txtJenis_tempoh' + inputType).append("<option value = '" + orderDetail.Jenis_Tempoh + "'>" + orderDetail.B_JenisTempoh + "</option>")
                } else {
                    $('#txtJenis_tempoh')
                        .dropdown('setup menu', {
                            values: [
                                {
                                    value: orderDetail.Jenis_Tempoh,
                                    text: orderDetail.B_JenisTempoh,
                                    name: orderDetail.B_JenisTempoh
                                }
                            ]
                        })
                        .dropdown('set selected', orderDetail.Jenis_Tempoh)
                }



                if (type === "view") {
                    $('#ddlkategoriPO' + inputType).append("<option value = '" + orderDetail.Jenis_Barang + "'>" + orderDetail.Butiran + "</option>")
                } else {
                    $('#ddlkategoriPO')
                        .dropdown('setup menu', {
                            values: [
                                {
                                    value: orderDetail.Jenis_Barang,
                                    text: orderDetail.Butiran,
                                    name: orderDetail.Butiran
                                }
                            ]
                        })
                        .dropdown('set selected', orderDetail.Jenis_Barang)
                }


                if (type === "view") {
                    $('#ddlListPtj' + inputType).append("<option value = '" + orderDetail.Bekal_Kepada + "'>" + orderDetail.ButiranPtj + "</option>")
                } else {
                    $('#ddlListPtj')
                        .dropdown('setup menu', {
                            values: [
                                {
                                    value: orderDetail.Bekal_Kepada,
                                    text: orderDetail.ButiranPtj,
                                    name: orderDetail.ButiranPtj
                                }
                            ]
                        })
                        .dropdown('set selected', orderDetail.Bekal_Kepada)
                }



                $('#ddlPTJPemohon' + inputType).val(orderDetail.Kod_Ptj_Mohon)
                $('#txtPemohon' + inputType).val('<%= Session("ssusrname") %>')

                //var originalDate = orderDetail.Tarikh_Perlu;
                //var parts = originalDate.split('/');
                //var tarikhperlu = parts[2] + '-' + parts[1] + '-' + parts[0];
                //$('#txtTkh' + inputType).val(tarikhperlu);

                var orderAmount = orderDetail.Perolehan_Terdahulu;
                $('#txtAmaun' + inputType).val(ThousandSeparator(orderAmount));
                $('#txtJustifikasi' + inputType).val(orderDetail.Justifikasi)

                katPerolehan = orderDetail.Jenis_Barang

                if (type !== "view") {
                    tbl.ajax.reload();
                }
                updateEndDate();
            }

            //function ThousandSeparator(number) {
            //    return number.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
            //}

            function ThousandSeparator(number) {
                return number.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            }


            var classSelectedSpekDetails = "";

            // keluarkan detail Speksifikasi Am
            $('#spekfikasi-table').on('click', '.btnDetails', function (evt) {
                evt.preventDefault();

                classSelectedSpekDetails = $(this).attr("class")
                var tr = $(this).closest('tr');
                var row = tbl_tab2.row(tr);
                var rowData = row.data();

                var pickedKodvot = rowData.kod;
                if (row.child.isShown()) {
                    // This row is already open - close it
                    row.child.hide();
                    tr.removeClass('shown');
                    $(this).html('<i class="fas fa-plus"></i>');
                    // Destroy the Child Datatable
                    childTable = null;
                    $('#cl' + pickedKodvot).DataTable().destroy();
                }
                else {

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
                    //var id = rowData.kod;

                    //if ($('#ddlkategoriPO').val() !== "K") {
                    //    childTable.column(2).visible(true);
                    //} else {
                    //    childTable.column(2).visible(false);
                    //}

                    childTable = $('#cl' + pickedKodvot).DataTable({
                        paging: false,
                        searching: false,
                        ajax: {
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadOrderRecord_PNLDetail") %>',
                            type: 'POST',
                            data: function (d) {
                                return "{ no_mohon: '" + $('#txtNoPO').val() + "',kod: '" + pickedKodvot + "'}"
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
                                "width": "0%",
                            },

                            {
                                "data": "butiran",
                                "width": "80%",
                            },

                            {
                                data: "wajaran",
                                "width": "10%",
                                "className": "text-center",

                            },

                            {
                                data: null,
                                "width": "10%",
                                "render": function (data, type, row) {
                                    return `<Button class="btneditspek" data-id = '${data.id_am}' data-kod = '${data.kod_spesifikasi}'><i class="far fa-edit fa-lg"></i></button>
                                            <Button class="btndeletespek" data-id = '${data.id_am}'><i class="far fa-trash-alt fa-lg"></i></button>`;
                                },
                            },

                        ],
                        columnDefs: [
                            {
                                "targets": [0],
                                visible: false,
                                searchable: false
                            },
                        ],
                        select: false,
                    });

                    childTable.on('draw.dt', function () {
                        //console.log(childTable.rows());
                        var $parentTotalItem = $('#spekfikasi-table').find("tbody tr").eq(prevRow[0][0]);
                        var $parentTotalWajaran = $(prevRow).find(".jumwajaran");

                        var jumlah = 0;
                        var jumwajaran = 0;
                        $(prevId).find("tbody tr").each(function (ind, obj) {

                            jumwajaran += $(tr).eq(1);
                            jumlah += 1;
                        });
                        $parentTotalItem.find(".jumlah").html("Jumlah : " + jumlah)
                        $parentTotalWajaran.find(".jumwajaran").html("Jumlah Wajaran : " + jumwajaran)

                    });

                    tr.addClass('shown');


                }

                if ($('#ddlkategoriPO').val() !== "K") {
                    childTable.column(2).visible(true);

                } else {
                    childTable.column(2).visible(false);
                }

                return false;
            });

            // Delete Bidang MOF
            $("#spekfikasi-table").off('click', '.btndeletespek').on("click", ".btndeletespek", function (event) {
                event.preventDefault();
                var row = $(this).closest('tr');
                //var dataTable = $('#childTable').DataTable();

                id_am_hidden = $(this).data("id"); //DELETE ROWS BASED ON THIS ID

                var msg = "Anda pasti ingin memadam rekod ini? (Maklumat Speksifikasi Am)";
                $('#confirmationMessageDelete5').text(msg);
                $('#saveConfirmationModalDelete5').modal('show'); // Open the Bootstrap modal

                $('#confirmSaveButtonDelete5').off('click').on('click', async function () {
                    $('#saveConfirmationModalDelete5').modal('hide'); // Hide the modal
                    var result = JSON.parse(await ajaxdeleteSpeksifikasi(id_am_hidden));
                    if (result.Status === "success") {
                        showModalDelete5("Success", result.Message, "success");
                    } else {
                        showModalDelete5("Error", result.Message, "error");
                    }
                    childTable.ajax.reload(); //Reload datatable
                });
            });
            async function ajaxdeleteSpeksifikasi(id_am_hidden) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/DeleteSpeksifikasiAm") %>',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify({ id: id_am_hidden }),
                        success: function (data) {
                            resolve(data.d);
                        },
                        error: function (error) {
                            console.log("Error: " + error);
                            reject(false);
                        }
                    });
                })
                console.log("tst")
            }

            function showModalDelete5(title, message, type) {
                $('#resultModalTitleDelete5').text(title);
                $('#resultModalMessageDelete5').text(message);
                if (type === "success") {
                    $('#resultModalDelete5').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModalDelete5').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModalDelete5').modal('show');
            }


            function recalculateActiveSpekItemWajaran() {
                if (prevRow === null) {
                    return;
                }

                console.log(prevRow);
            }

            function format(id) {
                childTable = '<table id="cl' + id + '" class="" width="100%">' +
                    `<thead style="">
                        <tr>
                            <th>Id_Am</th>
                            <th>Sub Perkara</th>
                            <th>Wajaran</th>
                            <th>Tindakan</th>
                        </tr>
                    </thead >` +
                    '</table>';
                return $(childTable).toArray();
            }




            //tab6
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
                formData.append("nomohon", $('#txtNoMohon').val());

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
                            return JSON.stringify({ id: $('#txtNoMohon').val() });
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
                var nomohon = $("#txtNoMohon").val();
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
                        },
                        error: function (error) {
                            console.log("Error: " + error);
                            reject(false);
                        }
                    });
                })
            }

            function showModalDeleteLampiran(title, message, type) {
                $('#resultModalTitleDeleteLampiran').text(title);
                $('#resultModalMessageDeleteLampiran').text(message);
                if (type === "success") {
                    $('#resultModalDeleteLampiran').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModalDeleteLampiran').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModalDeleteLampiran').modal('show');
            }



            //tab 7 tblRingkasan2
            var tblRingkasanCidb = null;
            var isClickedRingkasanCidb = false;

            $(document).ready(function () {
                $('.lihat-spek-am').click(async function (evt) {
                    evt.preventDefault();
                    var result = await setMohonID();
                    if (result) {
                        window.open("Spesifikasi_Am.aspx", "_blank");
                    }
                })

                $('.lihat-spek-teknikal').click(async function (evt) {
                    evt.preventDefault();
                    var result = await setMohonID();
                    if (result) {
                        window.open("Spesifikasi_Teknikal.aspx", "_blank");
                    }
                })


                async function setMohonID() {
                    return new Promise((resolve, reject) => {
                        $.ajax({
                            type: 'POST',
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SetNoMohon") %>',
                            data: JSON.stringify({ IdMohon: $('#txtNoMohon').val() }),
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (response) {
                                resolve(response.d)
                            },
                            error: function (error) {
                            }
                        });
                    })
                }

                tblRingkasanCidb = $("#tblRingkasan2").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_Cidb") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: $('#txtNoMohon').val() });
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
                        { "data": "Bil" },
                        { "data": "Kod_Kategori" },
                        { "data": "Kod_Khusus" },
                        { "data": "Butiran" },
                        { "data": "Syarat" },
                    ],
                    "columnDefs": [
                        {
                            "targets": 0,
                            visible: true,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                    ]
                });


            });

            function clearPermohonan() {
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadHdrPerolehan") %>',
                    data: JSON.stringify({ id: '' }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        location.reload();
                    },
                    error: function (error) {
                    }
                });
            }

            var tblLampiranR = null;
            var isClickedTabLampiranR = false;

            $(document).ready(function () {
                tblLampiranR = $("#tblSimpanUploadR").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_Lampiran") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: $('#txtNoMohon').val() });
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
                        { "data": "Bil" }, // Empty column for index/bil
                        { "data": "Lampiran" },
                        { "data": null, "title": "Tindakan" }
                    ],
                    "columnDefs": [
                        {
                            "targets": 0,
                            visible: true,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                        {
                            "targets": 2, // Target the last column (Delete column)
                            "data": null,
                            "render": function (data, type, row) {
                                return `
                            <div class="row">
                                <div class="col-md-1">
                                    <button type="button" class="btn viewLampiran" style="padding:0px 0px 0px 0px" title="Papar">
                                        <i class="fa fa-eye "></i>
                                    </button>
                                </div>
                            </div>`;
                            }
                        }
                    ]
                });


            });

            $("#tblSimpanUploadR").off('click', '.viewLampiran').on("click", ".viewLampiran", function (event) {
                var data = tblLampiranR.row($(this).parents('tr')).data();
                var fileName = data.Nama_Fail;
                var nomohon = $("#txtNoMohon").val();

                // Call a function to open the PDF in a new tab
                openPDFInNewTab(fileName, nomohon);
            });


            function showKaedahPerolehan() {
                var noMohon = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetKaedahPerolehan") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon: noMohon }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        $('#txtKaedahPerolehan').val(result[0].Kategori_Perolehan);
                    },
                    error: function (error) {
                        console.error('AJAX error:', error);
                    }
                });
            }



            // Simpan Tab 1 Permohonan
            $('.ringkasanHantar').off('click').on('click', async function () {
                var msg = "Anda pasti ingin menghantar permohonan perolehan ini?";
                $('#confirmationMessage10').text(msg);
                //$('#transaksi').modal('hide');
                $('#saveConfirmationModal10').modal('show');

                $('#confirmSaveButton10').off('click').on('click', async function () {
                    $('#saveConfirmationModal10').modal('hide');

                    var UpdateStatusHantar = {
                        txtNoMohonR: $('#txtNoMohonR').val()
                    };

                    try {
                        var result = JSON.parse(await ajaxHantarPermohonan(UpdateStatusHantar));
                        if (result.Status === true) {
                            showModal10("Success", result.Message, "success");
                            LoadRingkasan();
                            //$('#lblStatus1R').val(result.Payload.MessageStatus);
                            //    location.reload(true);
                        } else {
                            showModal10("Error", result.Message, "error");
                        }
                    } catch (error) {
                        console.error('Error:', error);
                        showModal1("Error", "An error occurred during the request.", "error");
                    }

                });
            });

            async function ajaxHantarPermohonan(UpdateStatusHantar) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/HantarPermohonan") %>',
                        method: 'POST',
                        data: JSON.stringify(UpdateStatusHantar),
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



            $(document).ready(function () {
                tblLVL = $("#tblSpekTeknikalLVL").DataTable({
                    "responsive": true,
                    "searching": false,
                    "info": false,
                    "paging": false,
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadSpekTeknikalLVL") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: $('#txtNoMohon').val() });
                        },
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        }
                    },

                    "columns": [
                        {
                            "data": null,
                            "width": "8%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                if (data.Level === 1) {
                                    return `<b>${data.Bil}<b/>`;
                                }

                                return `<div style="text-align:right">${data.Bil}</div>`;
                            },
                        },

                        {
                            "data": null,
                            "width": "92%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                if (data.Level === 1) {
                                    return `<b>${data.Butiran}<b/>`;
                                }

                                return `${data.Butiran}`;
                            },
                        },

                    ],

                });

            });



            $(document).ready(function () {
                tblAM = $("#tblSpekAmLVL").DataTable({
                    "responsive": true,
                    "searching": false,
                    "info": false,
                    "paging": false,
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadSpekAmLVL") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: $('#txtNoMohon').val() });

                        },
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        }
                    },

                    "columns": [
                        {
                            "data": null,
                            "width": "8%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                if (data.Level === 1) {
                                    return `<b>${data.Bil}<b/>`;
                                }

                                return `<div style="text-align:right">${data.Bil}</div>`;
                            },



                        },
                        {
                            "data": null,
                            "width": "92%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                console.log(data.Level);
                                if (data.Level === 1) {
                                    return `<b>${data.Butiran}<b/>`;
                                }

                                return `${data.Butiran}`;
                            },
                        },

                    ],

                });

            });


        </script>



    </contenttemplate>
</asp:Content>
