<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Daftar_Jawatankuasa.aspx.vb" Inherits="SMKB_Web_Portal.Daftar_Jawatankuasa" %>

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

        .dropdown.disabled {
            opacity: unset !important;
        }
    </style>


    <contenttemplate>

        <div id="PermohonanTab" class="tabcontent" style="display: block">

            <ul class="nav nav-tabs" id="myTab" role="tablist">

                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="maklumatPO-tab" data-toggle="tab" data-target="#perolehan" type="button" role="tab">Daftar Jawatankuasa</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link btnSearchAm" id="spesifikasiAm-tab" data-toggle="tab" data-target="#spesifikasi-am" type="button" role="tab">Daftar Ahli Jawatankuasa</button>
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
                                        <h5>Daftar Jawatankuasa</h5>
                                    </div>

                                </div>
                                <hr />

                                <div class="card">
                                    <div class="card-body">

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-row">

                                                    <div class="form-group col-md-4">
                                                        <select class="input-group__select ui search dropdown" name="Mod Jawatankuasa" id="ddlMod" placeholder="&nbsp;">
                                                        </select>
                                                        <label class="input-group__label" for="Mod Jawatankuasa">Mod Jawatankuasa</label>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <select class="input-group__select ui search dropdown" name="Kategori Jawatankuasa" id="ddlKategori" placeholder="&nbsp;">
                                                        </select>
                                                        <label class="input-group__label" for="Kategori Jawatankuasa">Kategori Jawatankuasa</label>
                                                    </div>


                                                    <div class="form-group col-md-4">
                                                        <input class="input-group__input" name="Kod Jawatankuasa" id="txtKodJawatankuasa" type="text" readonly style="background-color: #f0f0f0" />
                                                        <label class="input-group__label" for="Kod Jawatankuasa">Kod Jawatankuasa</label>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-row">

                                                    <div class="form-group col-md-8">
                                                        <input class="input-group__input" name="Nama Jawatankuasa" id="txtNamaJawatankuasa" type="text" />
                                                        <label class="input-group__label" for="Nama Jawatankuasa">Nama Jawatankuasa</label>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-row">
                                                    <div class="form-group" style="margin-left: 7px">
                                                        <label style="margin-bottom: unset"><strong>Status:</strong></label>

                                                        <input type="radio" id="DokumenType_0" name="DokumenType" value="1" style="display: inline-block; margin-left: 10px">
                                                        <label style="font-weight: unset" for="html">Aktif</label>

                                                        <input type="radio" id="DokumenType_1" name="DokumenType" value="0" style="display: inline-block; margin-left: 10px">
                                                        <label style="font-weight: unset" for="css">Tidak Aktif</label>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group col-md-12" align="center">
                                                <button type="button" id="btnReset" class="btn btn-setsemula btnReset" data-toggle="tooltip" data-placement="bottom" title="Rekod Baru" style="width: 160px">
                                                    Rekod Baru
                                                </button>

                                                <button type="button" id="lbtnSimpanInfo" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Simpan" style="width: 160px">
                                                    Simpan
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                                <div class="card mt-4">
                                    <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Jawatankuasa</h6>
                                    <div class="card-body">

                                        <div class="col-md-12">
                                            <div class="transaction-table table-responsive">
                                                <table id="tblSenaraiJawatankuasa" class="table table-striped" style="width: 99%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Bil</th>
                                                            <th scope="col">Mod Jawatankuasa</th>
                                                            <th scope="col">Kod Jawatankuasa</th>
                                                            <th scope="col">Butiran</th>
                                                            <th scope="col">Status</th>
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
                        </div>
                    </div>

                </div>



                <!-- tab 2 (Maklumat Spesifikasi Am) -->
                <div class="tab-pane fade" id="spesifikasi-am" role="tabpanel">
                    <div class="modal-body">
                        <div>
                            <h5>Daftar Ahli Jawatankuasa</h5>
                            <hr />
                        </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-4">
                                                <select class="input-group__select ui search dropdown" name="Mod Jawatankuasa" id="ddlModJ" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Mod Jawatankuasa">Mod Jawatankuasa</label>
                                            </div>

                                            <div class="form-group col-md-8">
                                                <select class="input-group__select ui search dropdown" name="Kod Jawatankuasa" id="ddlKodJawatankuasa" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Kod Jawatankuasa">Kod Jawatankuasa</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>




                        <div class="card">
                            <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Tambah Senarai Ahli Jawatankuasa</h6>
                            <div class="card-body">

                              <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

<%--                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="No Lantikan" id="no_lantikan" type="text" readonly style="background-color: #f0f0f0"/>
                                            <label class="input-group__label" for="No Lantikan">No Lantikan</label>
                                        </div>--%>

                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="Tarikh Mula" id="txtTarikhMula" type="date" />
                                            <label class="input-group__label" for="Tarikh Mula">Tarikh Mula</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="Tarikh Tamat" id="txtTarikhTamat" type="date" readonly style="background-color: #f0f0f0"/>
                                            <label class="input-group__label" for="Tarikh Tamat">Tarikh Tamat</label>
                                        </div>


                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                          <div class="form-group col-md-6">
                                              <select class="input-group__select ui search dropdown" name="PTJ" id="ddlPtj" placeholder="&nbsp;">
                                              </select>
                                              <label class="input-group__label" for="PTJ">PTJ</label>
                                          </div>

                                          <div class="form-group col-md-6">
                                              <select class="input-group__select ui search dropdown" name="Nama Staf" id="ddlStaf" placeholder="&nbsp;">
                                              </select>
                                              <label class="input-group__label" for="Nama Staf">Nama Staf</label>
                                          </div>


                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-3">
                                                <select class="input-group__select ui search dropdown cddl" name="Jawatan Jawatankuasa" id="ddlJawatan" placeholder="&nbsp;">
                                                <option value="" selected>-- Sila Pilih -- </option>
                                                <option value="PENGERUSI">PENGERUSI</option>
                                                <option value="PENGERUSI GANTI">PENGERUSI GANTI</option>
                                                <option value="SETIAUSAHA">SETIAUSAHA</option>
                                                <option value="AHLI">AHLI</option>
                                                </select>
                                                <label class="input-group__label" for="Jawatan Jawatankuasa">Jawatan Jawatankuasa</label>
                                            </div>


                                        </div>
                                    </div>
                                </div>


                                <div class="form-row">
                                    <div class="form-group col-md-12" align="center">

                                        <button type="button" id="btnSimpanJawatan" class="btn btn-secondary btnSimpanJawatan" data-toggle="tooltip" data-placement="bottom" title="Simpan" style="width: 160px">
                                            Simpan
                                        </button>
                                    </div>
                                </div>




  
                            </div>
                        </div>


                        <div class="card mt-3">
                            <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Ahli Jawatankuasa</h6>
                            <div class="card-body">

                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblSenaraiAhliJawatankuasa" class="table table-striped" style="width: 99%">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Bil</th>
                                                    <th scope="col">No Staf</th>
                                                    <th scope="col">Nama</th>
                                                    <th scope="col">PTJ</th>
                                                    <th scope="col">Jawatan</th>
                                                    <th scope="col">Jawatankuasa</th>
                                                    <th scope="col">Jawatan Jawatankuasa</th>
                                                    <th scope="col">Tarikh Mula</th>
                                                    <th scope="col">Tarikh Tamat</th>

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
                </div>
            </div>
        </div>




        <div class="modal fade" id="saveConfirmationModal10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel10">Simpan Jawatankuasa</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage10"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="simpanJawatankuasa">Ya</button>
                    </div>
                </div>
            </div>
        </div>

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
                        <div id="resultModalMessage10">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>



        <div class="modal fade" id="senaraiJawatankuasa" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">Senarai Jawatankuasa</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>


                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">


                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Mod Jawatankuasa" id="ddlModT" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Mod Jawatankuasa">Mod Jawatankuasa</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Kategori Jawatankuasa" id="ddlKategoriT" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Kategori Jawatankuasa">Kategori Jawatankuasa</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Kod Jawatankuasa" id="txtKodJawatankuasaT" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Kod Jawatankuasa">Kod Jawatankuasa</label>
                                    </div>


                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-8">
                                        <input class="input-group__input" name="Nama Jawatankuasa" id="txtNamaJawatankuasaT" type="text" />
                                        <label class="input-group__label" for="Nama Jawatankuasa">Nama Jawatankuasa</label>
                                    </div>


                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group" style="margin-left: 7px">
                                        <label style="margin-bottom: unset"><strong>Status:</strong></label>

                                        <input type="radio" id="DokumenTypeT_0" name="DokumenTypeT" value="1" style="display: inline-block; margin-left: 10px">
                                        <label style="font-weight: unset" for="html">Aktif</label>

                                        <input type="radio" id="DokumenTypeT_1" name="DokumenTypeT" value="0" style="display: inline-block; margin-left: 10px">
                                        <label style="font-weight: unset" for="css">Tidak Aktif</label>
                                    </div>

                                </div>
                            </div>
                        </div>





                    </div>

                    <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">
                        <button type="button" class="btn btn-setsemula" data-toggle="tooltip" data-placement="bottom">Tutup</button>
                        <button type="button" class="btn btn-secondary btnUpdateJawatankuasa" data-toggle="tooltip" data-placement="bottom">Simpan</button>
                    </div>

                </div>
            </div>
        </div>



        <div class="modal fade" id="saveConfirmationModal11" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel11">Daftar Bidaan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage11"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="updateJawatankuasa">Ya</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="resultModal11" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="resultModalLabel11">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="resultModalMessage11">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>



            <div class="modal fade" id="saveConfirmationModal12" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabel12">Daftar Ahli Jawatankuasa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessage12"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="simpanAhliJawatankuasa">Ya</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="resultModal12" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabel12">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="resultModalMessage12">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>



        <div class="modal fade" id="senaraiAjk" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">Maklumat Ahli Jawatankuasa</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>


                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <%-- <div class="form-group col-md-4">
                                            <input class="input-group__input" name="No Lantikan" id="no_lantikan" type="text" readonly style="background-color: #f0f0f0"/>
                                            <label class="input-group__label" for="No Lantikan">No Lantikan</label>
                                    </div>--%>
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Tarikh Mula" id="txtTarikhMulaR" type="date" />
                                        <label class="input-group__label" for="Tarikh Mula">Tarikh Mula</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Tarikh Tamat" id="txtTarikhTamatR" type="date" />
                                        <label class="input-group__label" for="Tarikh Tamat">Tarikh Tamat</label>
                                    </div>


                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-6">
                                        <input class="input-group__input" name="PTJ" id="ddlPtjR" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="PTJ">PTJ</label>
                                    </div>

                                    <div class="form-group col-md-6">
                                        <input class="input-group__input" name="Nama Staf" id="ddlStafR" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Nama Staf">Nama Staf</label>
                                    </div>

                                    <input type="hidden" id="noIdAjk" />


<%--                                    <div class="form-group col-md-6">
                                        <select class="input-group__select ui search dropdown" name="PTJ" id="ddlPtjR" placeholder="&nbsp;">
                                        </select>
                                        <label class="input-group__label" for="PTJ">PTJ</label>
                                    </div>

                                    <div class="form-group col-md-6">
                                        <select class="input-group__select ui search dropdown" name="Nama Staf" id="ddlStafR" placeholder="&nbsp;">
                                        </select>
                                        <label class="input-group__label" for="Nama Staf">Nama Staf</label>
                                    </div--%>


                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-3">
                                        <select class="input-group__select ui search dropdown cddl" name="Jawatan Jawatankuasa" id="ddlJawatanR" placeholder="&nbsp;">                                          
                                            <option value="PENGERUSI">PENGERUSI</option>
                                            <option value="PENGERUSI GANTI">PENGERUSI GANTI</option>
                                            <option value="SETIAUSAHA">SETIAUSAHA</option>
                                            <option value="AHLI">AHLI</option>
                                        </select>
                                        <label class="input-group__label" for="Jawatan Jawatankuasa">Jawatan Jawatankuasa</label>
                                    </div>
                                    <input type="hidden" id="noLantikanR" />

                                </div>
                            </div>
                        </div>


                    </div>

                    <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">
                        <button type="button" class="btn btn-setsemula" data-toggle="tooltip" data-placement="bottom">Tutup</button>
                        <button type="button" class="btn btn-secondary btnUpdateAhli" data-toggle="tooltip" data-placement="bottom">Simpan</button>
                    </div>

                </div>
            </div>
        </div>



           <div class="modal fade" id="saveConfirmationModal13" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
       <div class="modal-dialog " role="document">
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title" id="saveConfirmationModalLabel13">Simpan Jawatankuasa</h5>
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                       <span aria-hidden="true">&times;</span>
                   </button>
               </div>
               <div class="modal-body">
                   <p id="confirmationMessage13"></p>
               </div>
               <div class="modal-footer">
                   <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                   <button type="button" class="btn btn-secondary" id="updateAJK">Ya</button>
               </div>
           </div>
       </div>
   </div>

   <div class="modal fade" id="resultModal13" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
       <div class="modal-dialog" role="document">
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title" id="resultModalLabel13">Makluman</h5>
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                       <span aria-hidden="true">&times;</span>
                   </button>
               </div>
               <div class="modal-body">
                   <div id="resultModalMessage13">
                   </div>
               </div>
               <div class="modal-footer">
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
               </div>
           </div>
       </div>
   </div>


        <script type="text/javascript">

            $(".cddl").dropdown({
                fullTextSearch: true
            });


            $('#ddlMod').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Mod_Jawatankuasa?q={query}") %>',
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

                        $(obj).dropdown('show');
                    }
                }
            });

            $('#ddlMod').change(function () {
                $('#ddlKategori').dropdown("clear");
                $('#ddlKategori').closest(".dropdown").removeClass("disabled");
            })


            $('#ddlKategori').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Kod_Jawatankuasa?q={query}&kodmof={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlMod').dropdown("get value") });
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

                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');
                    }
                }
            });

            $('.btnSimpan').off('click').on('click', async function () {

                var msg = "Anda pasti untuk menyimpan maklumat ini?";
                $('#confirmationMessage10').text(msg);
                $('#senaraiJawatankuasa').modal('hide');
                $('#saveConfirmationModal10').modal('show');

                $('#simpanJawatankuasa').off('click').on('click', async function () {
                    $('#saveConfirmationModal10').modal('hide');

                    var newJawatanDaftar = {
                        SaveJawatan: {
                            ddlMod: $('#ddlMod').val(),
                            ddlKategori: $('#ddlKategori').val(),
                            txtKodJawatankuasa: $('#txtKodJawatankuasa').val(),
                            txtNamaJawatankuasa: $('#txtNamaJawatankuasa').val(),
                            DokumenType: $('input[name="DokumenType"]:checked').val()
                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxSimpanJawatankuasa(newJawatanDaftar));
                        if (result.Status === true) {
                            showModal10("Success", result.Message, "success");
                            $('#txtKodJawatankuasa').val(result.Payload.txtKodJawatankuasa);
                            tbl.ajax.reload();

                        } else {
                            showModal10("Error", result.Message, "error");
                        }
                    }
                    catch (error) {
                        console.error('Error:', error);
                        showModal10("Error", "An error occurred during the request.", "error");
                    }
                });
            });

            async function ajaxSimpanJawatankuasa(SaveJawatan) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Simpan_Jawatankuasa") %>',
                        method: 'POST',
                        data: JSON.stringify(SaveJawatan),
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
                $('#resultModalMessage10').html(message);
                if (type === "success") {
                    $('#resultModal10').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal10').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal10').modal('show');
            }


            $('#btnReset').click(function () {
                $('#txtKodJawatankuasa').val("");
                $('#txtNamaJawatankuasa').val("");
                $('input[name="DokumenType"]').prop('checked', false);

                //dropdown clear
                $('#ddlMod').dropdown('clear');
                $('#ddlMod').dropdown('refresh');
                $('#ddlKategori').dropdown('clear');
                $('#ddlKategori').dropdown('refresh');

            });


     <%--       generate_dropdownObj({
                id: 'ddlKategori',
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Kod_Jawatankuasa?q={query}&kodmof={query}") %>',
            })--%>

<%--            generate_dropdown('ddlKategori',
                '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Kod_Jawatankuasa?q={query}&kodmof={query}") %>', function () {
                    return {
                        kod_jawatankuasa: $('#ddlMod').dropdown("get value")
                    }
            }, function (value, text, obj) {
                    if (value === "") {
                        return;
                    }
                    var kod_jawatankuasa = $('#ddlMod').val();
                    var kod_kategori = value;

                    //BUAT AJAX DAPATKAN KOD JAWATANKUASA KEMUDIAN SET PADA INPUT
                    //alert(kod_jawatankuasa);
                    //alert(kod_kategori);
                //
            })--%>

            <%--$('#ddlKategori').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Kod_Jawatankuasa?q={query}&kodmof={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlMod').dropdown("get value") });
                        return settings;
                    },
                    onResponse: function (response) {
                        var responsex = {
                            success: true,
                            results: []
                        };
                        users = JSON.parse(response.d)
                        $.each(users, function (index, item) {
                            responsex.results.push({
                                text: item.text,
                                value: item.value
                            });
                        });
                        return responsex;
                    },
                    cache: false,
                    //dataType: "json",
                    //contentType: 'application/json; charset=utf-8'
                },
                filterRemoteData: true,
                fields: {
                    name: 'text',
                    value: 'value'
                },
            })--%>

            //function generate_dropdown(id, urlDropdown, paramToSend, onchange) {
            //    $('#' + id).dropdown({
            //        selectOnKeydown: true,
            //        fullTextSearch: true,
            //        placeholder: '-- Sila Pilih --',
            //        onChange: function (value, text, obj) {
            //            if (typeof onchange === "function") {
            //                onchange(value, text, obj);
            //            }
            //        },
            //        apiSettings: {
            //            url: urlDropdown,
            //            method: 'POST',
            //            dataType: "json",
            //            contentType: 'application/json; charset=utf-8',
            //            beforeSend: function (settings) {
            //                var defaultParam = {
            //                    q: settings.urlData.query
            //                }
            //                if (typeof paramToSend === "function") {
            //                    var newParam = paramToSend();
            //                    $.extend(defaultParam, newParam);
            //                }

            //                settings.data = JSON.stringify(defaultParam);
            //                return settings;
            //            },
            //            onResponse: function (response) {
            //                var responsex = {
            //                    success: true,
            //                    results: []
            //                };
            //                users = JSON.parse(response.d)
            //                $.each(users, function (index, item) {
            //                    responsex.results.push({
            //                        text: item.text,
            //                        value: item.value
            //                    });
            //                });
            //                return responsex;
            //            },
            //            cache: false,
            //            //dataType: "json",
            //            //contentType: 'application/json; charset=utf-8'
            //        },
            //        filterRemoteData: true,
            //        fields: {
            //            name: 'text',
            //            value: 'value'
            //        },
            //    })


            //function generate_dropdownObj(param) {
            //    $('#' + param.id).dropdown({
            //        selectOnKeydown: true,
            //        fullTextSearch: true,
            //        placeholder: '-- Sila Pilih --',
            //        onChange: function (value, text, obj) {
            //            if (typeof param.onchange === "function") {
            //                param.onchange(value, text, obj);
            //            }
            //        },
            //        apiSettings: {
            //            url: param.url,
            //            method: 'POST',
            //            dataType: "json",
            //            contentType: 'application/json; charset=utf-8',
            //            beforeSend: function (settings) {
            //                var defaultParam = {
            //                    q: settings.urlData.query
            //                }
            //                if (typeof param.paramToSend === "function") {
            //                    var newParam = param.paramToSend();
            //                    $.extend(defaultParam, newParam);
            //                }

            //                settings.data = JSON.stringify(defaultParam);
            //                return settings;
            //            },
            //            onResponse: function (response) {
            //                var responsex = {
            //                    success: true,
            //                    results: []
            //                };
            //                users = JSON.parse(response.d)
            //                $.each(users, function (index, item) {
            //                    responsex.results.push({
            //                        text: item.text,
            //                        value: item.value
            //                    });
            //                });
            //                return responsex;
            //            },
            //            cache: false,
            //            //dataType: "json",
            //            //contentType: 'application/json; charset=utf-8'
            //        },
            //        filterRemoteData: true,
            //        fields: {
            //            name: 'text',
            //            value: 'value'
            //        },
            //    })
            //}

            $('#ddlKategori').closest(".dropdown").addClass("disabled");
            $('#ddlKodJawatankuasa').closest(".dropdown").addClass("disabled");




            var tbl = null;

            $(document).ready(function () {
                tbl = $("#tblSenaraiJawatankuasa").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/LoadJawatankuasa") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify();
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

                        // Add click event
                        $(row).on("click", function () {

                            $("#ddlModT").val(data.Mod_JawatankuasaD);
                            $("#ddlKategoriT").val(data.KategoriD);
                            $("#txtKodJawatankuasaT").val(data.Kod_Jawatankuasa);
                            $("#txtNamaJawatankuasaT").val(data.Butiran);

                            // Set the value of radio buttons based on the value of data.DokumenType
                            if (data.Status === "aktif") {
                                $("#DokumenTypeT_0").prop("checked", true);
                            } else if (data.Status === "tidak aktif") {
                                $("#DokumenTypeT_1").prop("checked", true);
                            }

                            $('#senaraiJawatankuasa').modal('show');
                        });
                    },


                    "columns": [
                        { "data": null },
                        { "data": "Mod_Jawatankuasa" },
                        { "data": "Kod_Jawatankuasa" },
                        { "data": "Butiran" },
                        { "data": "Status" },

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


            $('.btnUpdateJawatankuasa').off('click').on('click', async function () {

                var msg = "Anda pasti untuk mengemaskini maklumat ini?";
                $('#confirmationMessage11').text(msg);
                $('#senaraiJawatankuasa').modal('hide');
                $('#saveConfirmationModal11').modal('show');

                $('#updateJawatankuasa').off('click').on('click', async function () {
                    $('#saveConfirmationModal11').modal('hide');

                    var newJawatanUpdate = {
                        UpdateJawatan: {
                            ddlMod: $('#ddlModT').val(),
                            ddlKategori: $('#ddlKategoriT').val(),
                            txtKodJawatankuasa: $('#txtKodJawatankuasaT').val(),
                            txtNamaJawatankuasa: $('#txtNamaJawatankuasaT').val(),
                            DokumenType: $('input[name="DokumenTypeT"]:checked').val()
                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxUpdateJawatankuasa(newJawatanUpdate));
                        if (result.Status === true) {
                            showModal11("Success", result.Message, "success");
                            tbl.ajax.reload();

                        } else {
                            showModal11("Error", result.Message, "error");
                        }
                    }
                    catch (error) {
                        console.error('Error:', error);
                        showModal11("Error", "An error occurred during the request.", "error");
                    }
                });
            });

            async function ajaxUpdateJawatankuasa(UpdateJawatan) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Update_Jawatankuasa") %>',
                        method: 'POST',
                        data: JSON.stringify(UpdateJawatan),
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

            function showModal11(title, message, type) {
                $('#resultModalTitle11').text(title);
                $('#resultModalMessage11').html(message);
                if (type === "success") {
                    $('#resultModal11').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal11').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal11').modal('show');
            }



            // set 2 years end date
            var startDateInput = document.getElementById('txtTarikhMula');
            var endDateInput = document.getElementById('txtTarikhTamat');

            startDateInput.addEventListener('change', function () {
                var startDate = new Date(startDateInput.value);

                var endDate = new Date(startDate.getFullYear() + 2, startDate.getMonth(), startDate.getDate());
                var formattedEndDate = endDate.toISOString().slice(0, 10);
                endDateInput.value = formattedEndDate;
            });


            $('#ddlModJ').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Mod_Jawatankuasa?q={query}") %>',
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

                                    $(obj).dropdown('show');
                                }
                            }
                        });

            $('#ddlModJ').change(function () {
                $('#ddlKodJawatankuasa').dropdown("clear");
                $('#ddlKodJawatankuasa').closest(".dropdown").removeClass("disabled");
                $('#ddlPtj').dropdown("clear");
                $('#ddlPtj').closest(".dropdown").removeClass("disabled");


            })


            $('#ddlKodJawatankuasa').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/GetKodJawatanK?q={query}&kodmof={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlModJ').dropdown("get value") });
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

                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');
                    }
                }
            });

            $('#ddlPtj').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Ptj?q={query}") %>',
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

                        $(obj).dropdown('show');
                    }
                }
            });

            $('#ddlStaf').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/GetStaf?q={query}&kod_jawatankuasa={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlPtj').dropdown("get value") });
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

                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');
                    }
                }
            });

            $('#ddlPtj').change(function () {
                $('#ddlStaf').dropdown("clear");
                $('#ddlStaf').closest(".dropdown").removeClass("disabled");
            })
            $('#ddlStaf').closest(".dropdown").addClass("disabled");






            var tbl1 = null;

            $(document).ready(function () {
                tbl1 = $("#tblSenaraiAhliJawatankuasa").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/LoadAhliJawatankuasa") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify();
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

                        // Add click event
                        $(row).on("click", function () {

                            $("#txtTarikhMulaR").val(data.TarikhKuatkuasa);
                            $("#txtTarikhTamatR").val(data.TarikhTamat);
                            $("#ddlPtjR").val(data.Pejabat);
                            $("#ddlStafR").val(data.MS01_Nama);
                            $("#ddlJawatanR").val(data.Jawatan);
                            $("#noLantikanR").val(data.No_Lantikan);
                            $("#noIdAjk").val(data.ID);


                            

                            $('#senaraiAjk').modal('show');
                            
                        });
                    },


                    "columns": [
                        { "data": null },
                        { "data": "No_Staf" },
                        { "data": "MS01_Nama" },
                        { "data": "Pejabat" },
                        { "data": "JawGiliran" },
                        { "data": "newbutiran" },
                        { "data": "Jawatan" },

                        {
                            "data": "TarikhKuatkuasa",
                            "type": "date", 
                            render: function (data, type, row) {
                                // Format the date using moment.js
                                if (data == null) {
                                    return '-';
                                } else {
                                    return moment(data).format('DD/MM/YYYY'); 
                                }

                            },
                            "width": "10%"
                        },

                        {
                            "data": "TarikhTamat",
                            "type": "date",
                            render: function (data, type, row) {
                                // Format the date using moment.js
                                if (data == null) {
                                    return '-';
                                } else {
                                    return moment(data).format('DD/MM/YYYY');
                                }

                            },
                            "width": "10%"
                        },



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



            $('.btnSimpanJawatan').off('click').on('click', async function () {

                var msg = "Anda pasti untuk menyimpan maklumat ini?";
                $('#confirmationMessage12').text(msg);
                $('#saveConfirmationModal12').modal('show');

                $('#simpanAhliJawatankuasa').off('click').on('click', async function () {
                    $('#saveConfirmationModal12').modal('hide');

                    var newAhliJawatanDaftar = {
                        SaveAhliJawatan: {
                            ddlMod: $('#ddlModJ').val(),
                            ddlKodJawatankuasa: $('#ddlKodJawatankuasa').val(),
                            no_lantikan: $('#no_lantikan').val(),
                            txtTarikhMula: $('#txtTarikhMula').val(),
                            txtTarikhTamat: $('#txtTarikhTamat').val(),
                            ddlPtj: $('#ddlPtj').val(),
                            ddlStaf: $('#ddlStaf').val(),
                            ddlJawatan: $('#ddlJawatan').val(),


                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxSimpanAhliJawatankuasa(newAhliJawatanDaftar));
                        if (result.Status === true) {
                            showModal10("Success", result.Message, "success");
                            $('#no_lantikan').val(result.Payload.no_lantikan);
                            tbl.ajax.reload();
                            tbl1.ajax.reload();

                        } else {
                            showModal10("Error", result.Message, "error");
                        }
                    }
                    catch (error) {
                        console.error('Error:', error);
                        showModal10("Error", "An error occurred during the request.", "error");
                    }
                });
            });

            async function ajaxSimpanAhliJawatankuasa(SaveAhliJawatan) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Simpan_AhliJawatankuasa") %>',
                        method: 'POST',
                        data: JSON.stringify(SaveAhliJawatan),
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
                $('#resultModalMessage10').html(message);
                if (type === "success") {
                    $('#resultModal10').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal10').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal10').modal('show');
            }




            $('.btnUpdateAhli').off('click').on('click', async function () {

                var msg = "Anda pasti untuk mengemaskini maklumat ini?";
                $('#confirmationMessage13').text(msg);
                $('#senaraiAjk').modal('hide');
                $('#saveConfirmationModal13').modal('show');

                $('#updateAJK').off('click').on('click', async function () {
                    $('#saveConfirmationModal13').modal('hide');

                    var newUpdateAhli = {
                        SaveUpdateAhli: {
                            txtTarikhMulaR: $('#txtTarikhMulaR').val(),
                            txtTarikhTamatR: $('#txtTarikhTamatR').val(),
                            ddlPtjR: $('#ddlPtjR').val(),
                            ddlStafR: $('#ddlStafR').val(),
                            ddlJawatanR: $('#ddlJawatanR').val(),
                            noLantikanR: $('#noLantikanR').val(),
                            id : $("#noIdAjk").val()


                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxUpdateAhliJawatankuasa2(newUpdateAhli));
                        if (result.Status === true) {
                            showModal13("Success", result.Message, "success");
                            $('#txtKodJawatankuasa').val(result.Payload.txtKodJawatankuasa);

                        } else {
                            showModal13("Error", result.Message, "error");
                        }
                    }
                    catch (error) {
                        console.error('Error:', error);
                        showModal13("Error", "An error occurred during the request.", "error");
                    }
                });
            });

            async function ajaxUpdateAhliJawatankuasa2(SaveUpdateAhli) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                     "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/UpdateAJKDetail") %>',
                     method: 'POST',
                     data: JSON.stringify(SaveUpdateAhli),
                     dataType: 'json',
                     contentType: 'application/json; charset=utf-8',
                     success: function (data) {
                         resolve(data.d);
                         tbl1.ajax.reload();
                     },
                     error: function (xhr, textStatus, errorThrown) {
                         console.error('Error:', errorThrown);
                         reject(false);
                     }
                 });
             });
         }

            function showModal13(title, message, type) {
                $('#resultModalTitle13').text(title);
                $('#resultModalMessage13').html(message);
                if (type === "success") {
                    $('#resultModal13').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal13').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal13').modal('show');
            }

        </script>



    </contenttemplate>
</asp:Content>
