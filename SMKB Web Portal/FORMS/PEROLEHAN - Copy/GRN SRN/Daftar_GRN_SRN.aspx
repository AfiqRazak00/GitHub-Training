<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Daftar_GRN_SRN.aspx.vb" Inherits="SMKB_Web_Portal.Daftar_GRN_SRN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    
    <style>
          .table-responsive {
            overflow-x: hidden ;
        }

        @media only screen and (max-width: 830px) {
       
            .table-responsive {
            overflow-x: auto !important;
            }
        }
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

        #pesananTable td:hover {
            cursor: pointer;
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
            /*color: #aaa;*/
            color: #000;
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
                font-size: 12px;
                color: black;
                font-weight: bold;
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
            font-size: 12px;
            color: black;
            font-weight: bold;
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


    <div class="tabcontent" style="display: block">

        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Carian GRN</h5>
                    </div>

                    <!-- Start Dropdown Filter -->
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
                    <!-- End Dropdown Filter -->

                    <div class=" -body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="pesananTable" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">No Mohon</th>
                                            <th scope="col">No Pesanan</th>
                                            <th scope="col">Nama Syarikat</th>
                                            <th scope="col">Tujuan</th>
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


        <!-- Modal -->
        <div class="modal fade" id="transaksi" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable"  style="max-width: 80%;" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">Paparan GRN</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>


                    <div class="modal-body">
                            <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="noPerolehan" id="noPerolehan" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="noPerolehan">No Perolehan</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="txtKategori" id="txtKategori" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtKategori">Kategori</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="txtKaedahPerolehan" id="txtKaedahPerolehan" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtKaedahPerolehan">Jenis Perolehan</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="txtNamaSyarikat" id="txtNamaSyarikat" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtNamaSyarikat">Pembekal :</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                                 <input class="input-group__input" name="txtNoPT" id="txtNoPT" type="hidden" readonly style="background-color: #f0f0f0" />
                                                <input class="input-group__input" name="txtNamaPemohon" id="txtNamaPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtNamaPemohon">Nama Pemohon :</label>
                                            </div>

                                             <div class="form-group col-md-2">
                                                 <input class="input-group__input" name="txtNoGrn" id="txtSample" type="hidden" readonly style="background-color: #f0f0f0" />
                                                <input class="input-group__input" name="txtTempoh" id="txtTempoh" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtTempoh">Tempoh :</label>
                                            </div>

                                            <div class="form-group col-md-2">
                                                <input class="input-group__input" name="txtJnsTempoh" id="txtJnsTempoh" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtJnsTempoh">Jenis Tempoh :</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-2">
                                                <input class="input-group__input" name="txtEmelPemohon" id="txtEmelPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtEmelPemohon">Emel :</label>
                                            </div>

                                            <div class="form-group col-md-2">
                                                <input class="input-group__input" name="txtNoTelefon" id="txtNoTelefon" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtNoTelefon">No Telefon :</label>
                                            </div>

                                                 <div class="form-group col-md-4">
                                                <input class="input-group__input" name="txtBekalSebelum" id="txtBekalSebelum" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtBekalSebelum">Bekal Sebelum :</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                             <input class="input-group__input" name="txtBekalKepada" id="txtBekalKepada" type="text" readonly style="background-color: #f0f0f0" />
                                             <input class="input-group__input" name="txtKodBekalKepada" id="txtKodBekalKepada" type="hidden" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtBekalKepada">Bekal Kepada :</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="col-md-12">
                                                <div class=" form-group">
                                                    <textarea class="input-group__input" id="tujuanValue" readonly style="background-color: #f0f0f0; height: auto" rows="3"></textarea>
                                                    <label class="input-group__label" for="tujuanValue">Tujuan :</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                             <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-2">
                                                <input type="hidden" id="idPembelian" >
                                                <input class="input-group__input" name="txtJumlah" id="txtJumlah" type="text" readonly style="background-color: #f0f0f0; text-align: right;" />
                                                <label class="input-group__label" for="txtJumlah">Jumlah (RM) :</label>
                                            </div>
                                            <%--<div class="form-group col-md-2">
                                                <input class="input-group__input" name="txtBekalSebelum" id="txtBekalSebelum" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="txtBekalSebelum">Jumlah :</label>
                                            </div>--%>
                                        </div>
                                    </div>
                                </div>



                                   <div class="card" style="margin: 30px 0px 0px 0px">
                                      <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Barang/Perkara</h6>
                                        <div class="card-body" style="margin: 20px 0px 0px 0px">
                                                <div class="col-md-12">
                                                    <div class="transaction-table table-responsive">
                                                        <table id="tblSenaraiGRNItem" class="table table-striped" style="width: 100%">
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col"><input type="checkbox" id="chkAll" class="chkAll"></th>
                                                                    <th scope="col">Hidden</th>
                                                                    <th scope="col">Bil</th>
                                                                    <th scope="col">Barang/Perkara</th>
                                                                    <th scope="col">Ukuran</th>
                                                                    <th scope="col">Pesan</th>
                                                                    <th scope="col">Selisih</th>
                                                                    <th scope="col">Terima</th>
                                                                    <th scope="col">Harga/Unit (RM)</th>
                                                                    <th scope="col">Jumlah (RM)</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>

                                 <div class="card" style="margin: 30px 0px 50px 0px">
                                      <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Maklumat Penghantaran Pesanan</h6>
                                        <div class="card-body" style="margin: 10px 0px 0px 0px">
                                               <div class="row">
                                                    <div class="col-md-12" >
                                                        <div class="form-row">
                                                           <div class="form-group col-md-4">
                                                                <input class="input-group__input" name="txtNoDO" id="txtNoDO" type="text" />
                                                                <input class="input-group__input" name="idSyarikat" id="idSyarikat" type="hidden" />
                                                                <label class="input-group__label" for="txtNoDO">No. D.O :</label>
                                                            </div>

                                                             <div class="form-group col-md-4">
                                                             <input class="input-group__input" name="txtFailDO" id="txtFailDO" type="text" />
                                                                <label class="input-group__label" for="txtFailDO">Rujukan Fail D.O :</label>
                                                          </div>

                                                            <div class="form-group col-md-4">
                                                                  <div class="card">
                                                                       <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px; font-weight: bold; font-size: smaller;">Rujukan D.O :</h6>
                                                                        <div class="form-group" style="margin-top: 10px; margin-left: 10px">
                                                                            <input type="file" id="uploadDokumen" class="form-control-file" />
                                                                        </div>
                                                                    </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12" >
                                                        <div class="form-row">
                                                           <div class="form-group col-md-4">
                                                                <input class="input-group__input" name="txtTkhTerimaDO" id="txtTkhTerimaDO" type="date"  />
                                                                <label class="input-group__label" for="txtTkhTerimaDO">Tarikh Terima D.O :</label>
                                                            </div>

                                                            <div class="form-group col-md-4">
                                                                <input class="input-group__input" name="txtTkhDO" id="txtTkhDO" type="date" />
                                                                <label class="input-group__label" for="txtTkhDO">Tarikh D.O :</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                             <div class="row">
                                                    <div class="col-md-12" >
                                                        <div class="form-row">
                                                            <div class="form-group col-md-4">
                                                                <textarea class="input-group__input" id="txtUlasanDO" height: auto" rows="3"></textarea>
                                                                <label class="input-group__label" for="txtUlasanDO">Ulasan :</label>
                                                          </div>
                                                        </div>
                                                    </div>
                                                </div>

                                             <div class="card" style="margin: 30px 0px 0px 0px">
                                              <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Penerimaan BARANG/SERVIS (GRN/SRN)</h6>
                                                <div class="card-body" style="margin: 20px 0px 0px 0px">
                                                        <div class="col-md-12">
                                                            <div class="transaction-table table-responsive">
                                                                 <table id="tblSenaraiGRNterdahulu2" class="table table-striped" style="width: 100%">
                                                                     <thead class="fix-hade">
                                                                        <tr style="background-color: #FFC83D">
                                                                           <th scope="col"></th>
                                                                           <th scope="col">Bil</th>
                                                                            <th scope="col">No. GRN/SRN</th>
                                                                            <th scope="col">No. PT/PO</th>
                                                                            <th scope="col">Kategori</th>
                                                                            <th scope="col">Tajuk</th>
                                                                            <th scope="col">Pembekal</th>
                                                                            <th scope="col">Status</th>
                                                                            <th scope="col"></th>
                                                                        </tr>
                                                                     </thead>
                                                                     <tbody id="tableID_Senarai" style="cursor:pointer;overflow:auto; ">
                                                                     </tbody>
                                                                  </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                            </div>
                                            </div>
                                         </div>
                                    </div>


                                <div class="form-row">
                                    <div class="form-group col-md-12" align="center">
                                        <button type="button" id="btnSimpanGrn" class="btn btn-secondary btnSimpanGrn" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                            Simpan
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    </div>



        <%--  modal lulus permohonan--%>
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
                        <button type="button" class="btn btn-secondary" id="registerGRN">Ya</button>
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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="relodePage()">Tutup</button>
                    </div>
                </div>
            </div>
        </div>




        <%--modal untuk kemaskini button--%>
         <div class="modal fade" id="saveConfirmationModal11" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="saveConfirmationModalLabel11">Ulasan</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                      <div class="row">
                          <div class="col-md-12">
                              <div class="form-row">
                                  <div class="form-group col-md-12">
                                      <textarea class="input-group__input js-group-one" id="txtUlasan" placeholder="&nbsp;" name="Tajuk / Tujuan" style="height:140px" ></textarea>
                                      <label class="input-group__label" for="Tajuk / Tujuan">Sila Masukkan Ulasan</label>
                                  </div>
                              </div>
                          </div>
                      </div>

                  </div>
                  <div class="modal-footer" style="padding:0px" >
                      <button type="button" class="btn btn-setsemula" data-dismiss="modal">Tutup</button>
                      <button type="button" class="btn btn-secondary" id="confirmSaveButton11">Hantar</button>
                  </div>
              </div>
          </div>
      </div>

      <!-- Modal Result Kemaskini -->
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
                      <p id="resultModalMessage11"></p>
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
                    <div class="modal-footer" style="padding:2px"> 
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

    <div class="modal fade" id="kuantitiTerlebihModal" tabindex="-1" role="dialog" aria-labelledby="kuantitiTerlebihModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="checkingtitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="checkingbody">
        <%--Kuantiti yang dimasukkan melebihi baki semasa. Sila semak semula.--%>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
      </div>
    </div>
  </div>
</div>





        <script type="text/javascript">

            function relodePage() {
                location.reload();
            }

            // Get today's date
            var today = new Date();
            var formattedDate = today.toISOString().split('T')[0];
            document.getElementById('txtTkhTerimaDO').value = formattedDate;

            var idPembelian = "";
            var idSyarikat = "";
            var txtNoGrn = "";

            var tblItemGRN = null;
            var tbl = null;
         
            function testmasuk() {
                var idPembelian = $('#idPembelian').val();
                var idSyarikat = ''; // You need to define idSyarikat
                loadItemGrn(idPembelian, idSyarikat);
            }


            $(document).ready(function () {
                var setujuButton = document.querySelector(".btnSimpanGrn");
                var checkbox = document.getElementById("chkItem");
                tblItemGRN = $("#tblSenaraiGRNItem").DataTable({
                    "responsive": true,
                    "searching": false,
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
                        //"url": '/%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/#") %>',
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/GetRecord_ItemGrn") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            console.log("Sending AJAX request kodSyarikat idPembelian:", idPembelian);
                            console.log("Sending AJAX request kodSyarikat idSyarikat:", idSyarikat);
                            console.log("Sending AJAX request kodSyarikat txtNoPT:", txtNoPT);
                            return JSON.stringify({ idPembelian: idPembelian, idSyarikat: idSyarikat, txtNoPT: txtNoPT });
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
                            var rowData = data;
                            idMohonDtl = rowData.Id_Mohon_Dtl;
                            txtNoGrn = rowData.No_GRN;
                            txtJumlah = rowData.Total_Jumlah_Harga;
                            amaunTerkumpul = rowData.Amaun_Terkumpul;
                            console.log("id mohon detail apa", idMohonDtl);
                            console.log("id grn apa", txtNoGrn);
                            console.log("id txtJumlah apa", txtJumlah);
                            console.log("id amaunTerkumpul apa", amaunTerkumpul);
                            $("#txtNoGrn").val(data.No_GRN);
                            $("#txtJumlah").val(data.Total_Jumlah_Harga);
                            showJumlahHarga();
                        });

                    },

                    "columns": [
                        {
                            "data": null,
                            "render": function (data, type, row) {
                                if (data.Kuantiti_Selisih == '0') {
                                    return '<input type="checkbox" disabled class="chkItem" id="chkItem">';
                                } else {
                                    return '<input type="checkbox" class="chkItem" id="chkItem">';
                                }
                            }
                        },
                        { "data": "Id_Mohon_Dtl" }, //Hidden
                        /*{ "data": "No_GRN" }, //Hidden*/
                        {   //BIL
                            data: null,
                            "render": function (data, type, row, meta) {
                                return meta.row + 1;
                            },
                        },
                        {
                            "data": null,
                            "render": function (data, type, row, meta) {
                                return `<input class = 'idMohonDtl' type="hidden" value='${data.Id_Mohon_Dtl}'/><input class = 'hargaSeunit' id='hargaSeunit' type="hidden" value='${data.Harga_Seunit}'/>${data.Butiran}`;
                            },
                        },
                        { "data": "text" },
                        {
                            "data": null,
                            "render": function (data, type, row, meta) {
                                return `<input class = 'itemKuantiti' type="hidden" value='${data.Kuantiti}'/><input class = 'txtSample' id='txtNo_GRN' type="hidden" value='${data.No_GRN}'/>${data.Kuantiti}`;
                            },
                        },
                        {
                            "data": null,
                            "render": function (data, type, row, meta) {

                                return `<input class='itemBakiTinggal' id='itemBakiTinggal' type="hidden" value=''/><input class='test' id='test' type="hidden" value=''/><input class='amaunGRNTerima' id='amaunGRNTerima' type="hidden" value=''/><input class = 'beza' type="hidden" value='${data.Kuantiti_Selisih}'/>${data.Kuantiti_Selisih ? data.Kuantiti_Selisih : 0}`;
                            }
                        },
                        {
                            "data": null, "className": "text-center",
                            "render": function (data, type, row, meta) {
                                if (data.Kuantiti_Selisih == '0') {
                                    return `<input id="itemTerima" disabled class="itemTerima sequence form-control underline-input Debit m-1 itemTerima" minlength="1" maxlength="4" size="1" name="itemTerima" value='' type="text" style="width: 60%;"/>`;
                                } else {
                                    return `<input id="itemTerima" class="itemTerima sequence form-control underline-input Debit m-1 itemTerima" minlength="1" maxlength="4" size="1" name="itemTerima" value='' type="text" style="width: 60%;"/>`;

                                }
                            },
                        },
                        {
                            "data": "Harga_Seunit", "className": "text-right",
                            "render": function (data) {
                               // return parseFloat(data).toFixed(2);
                                return parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                            }
                        },
                        {
                            "data": "Amaun",
                            "className": "text-right",
                            "render": function (data) {
                                // Check if data is NaN or empty
                                if (isNaN(parseFloat(data)) || data === "") {
                                    return "0.00"; // If NaN or empty, return 0
                                } else {
                                    return parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                }
                            }
                        },
                    ],
                    "columnDefs": [
                        {
                            "targets": 1,
                            visible: false,
                            searchable: false
                        },
                    ],
                    "footerCallback": function (row, data, start, end, display) {
                        var api = this.api();

                        // Remove the formatting to get integer data for summation
                        var intVal = function (i) {
                            return typeof i === 'string' ?
                                i.replace(/[\$,]/g, '') * 1 :
                                typeof i === 'number' ?
                                    i : 0;
                        };

                        // Total over all pages
                        total = api
                            .column(9)
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);

                        // Format the total value
                       // var formattedTotal = parseFloat(total).toFixed(2);
                        var formattedTotal = parseFloat(total).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');

                        // Update footer
                        $(api.column(9).footer()).html(
                            'Jumlah Besar (RM): ' + formattedTotal
                        );

                        // Add the formatted total to the tfoot element
                        $('#tblSenaraiGRNItem tfoot tr').html('<td></td><td colspan="7" style="text-align: right; font-weight: bold;">Jumlah Besar (RM):</td><td style="text-align: right; font-weight: bold;">' + formattedTotal + '</td>');

                    }
                });

                // Add a tfoot element to the table
                $('#tblSenaraiGRNItem').append('<tfoot><tr><th colspan="1" style="text-align:right">Jumlah Besar (RM):</th></tr></tfoot>');

                // Check/uncheck all checkboxes
                $('#chkAll').change(function () {
                    $('.chkItem').prop('checked', this.checked);
                });

                // Check if all checkboxes are checked and update chkAll accordingly
                $('.chkItem').change(function () {
                    var allChecked = true;
                    $('.chkItem').each(function () {
                        if (!this.checked) {
                            allChecked = false;
                        }
                    });
                    $('#chkAll').prop('checked', allChecked);
                });

                // Assuming you have a button with id "loadDataButton" to trigger loading data
                $('#loadDataButton').on('click', function () {
                    testmasuk(); // Trigger the testmasuk function to load data
                });

                $('#tblSenaraiGRNItem').on('input', '.itemKuantiti, .itemTerima', function () {
                    var $row = $(this).closest('tr');
                    var rowData = tblItemGRN.row($row).data();
                    var $inputKuantiti = $row.find('.itemKuantiti');
                    var $inputTerima = $row.find('.itemTerima');
                    var $inputBakiTinggal = $row.find('.itemBakiTinggal');
                    var $inputGRN = $row.find('.amaunGRNTerima');
                    var $inputHargaSeunit = $row.find('.hargaSeunit');

                    var $inputBeza = $row.find('.beza');
                    var $inputTest = $row.find('.test');

                    var kuantiti = parseFloat($inputKuantiti.val()) || 0;
                    var terima = parseFloat($inputTerima.val()) || 0;
                    var seunit = parseFloat($inputHargaSeunit.val()) || 0;
                    var beza = parseFloat($inputBeza.val()) || 0;
                    var test = parseFloat($inputTest.val()) || 0;

                    console.log("Kuantiti: " + kuantiti);
                    console.log("Terima: " + terima);

                    var bakiTinggal = kuantiti - terima;
                    var amaun = seunit * terima;
                    var test1 = beza -  terima;

                    console.log("Baki Tinggal: " + bakiTinggal);
                    console.log("amaun: " + amaun);
                    console.log("test1: " + test1);

                    $inputBakiTinggal.val(bakiTinggal);
                    $inputGRN.val(amaun);
                    $inputTest.val(test1);

                    // Check conditions to enable/disable the button   4
                    if (beza === 0) {
                        if (terima > rowData.Kuantiti) {
                            //setujuButton.disabled = true;
                            //$('#kuantitiTerlebihModal').modal('show');
                            showModalCheckingKuantiti("Peringatan", "Kuantiti terima melebihi kuantiti order. Sila semak semula.");
                        } else {
                            //setujuButton.disabled = false;
                            //$('#kuantitiTerlebihModal').modal('hide');
                        }
                    } else if (terima > beza) {
                        // If terima is greater than beza, disable the button
                        //setujuButton.disabled = true;
                        //$('#kuantitiTerlebihModal').modal('show');
                        showModalCheckingKuantiti("Peringatan", "Kuantiti terima melebihi kuantiti order. Sila semak semula.");
                    } else {
                        // Otherwise, enable the button
                        //setujuButton.disabled = false;
                        //$('#kuantitiTerlebihModal').modal('hide');
                    }

                });

            });


            var tblTerima = null;

            var tblGRN = null;
            var isClicked = false;

            $(document).ready(function () {

                tblGRN = $("#pesananTable").DataTable({

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
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/SenaraiGRN") %>',
                        method: 'POST',
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
                                isClicked5: isClicked,
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
                            noMohonValue = data.No_Mohon;
                            noMohon = data.No_Mohon;
                            noSyarikat = data.No_Sykt;
                            idSyarikat = data.ID_Sykt;
                            idPembelian = data.Id_Pembelian;
                            txtNoPT = data.No_Pesanan;
                            $("#txtNoPT").val(data.No_Pesanan);
                            $("#noMohonValue").val(data.No_Mohon);
                            $("#noPerolehan").val(data.No_Perolehan);
                            $("#txtEmelPemohon").val(data.Emel_Semasa);
                            $("#txtNoTelefon").val(data.Tel_Bimbit_Semasa);
                            $("#tujuanValue").val(data.Tujuan);
                            $("#idSyarikat").val(data.ID_Sykt);
                            $("#idPembelian").val(data.Id_Pembelian);
                            console.log("test pa tuh", idPembelian);

                            var dateString = data.Bekal_Sebelum; // Assign the date string to a variable

                            // Create a Date object from the date string
                            var date = new Date(dateString);

                            // Format the date as "dd/mm/yyyy hh:mm:ss"
                            var formattedDate = ('0' + date.getDate()).slice(-2) + '/' + ('0' + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();

                            // Set the formatted date to the input field with id "txtBekalSebelum"
                            $("#txtBekalSebelum").val(formattedDate);
                            //$("#txtBekalSebelum").val(data.Bekal_Sebelum);
                            $("#txtBekalKepada").val(data.text);
                            $("#txtKodBekalKepada").val(data.Bekal_Kepada);
                            $("#txtTempoh").val(data.Tempoh);
                            $("#txtJnsTempoh").val(data.Butiran);
                            //$("#txtKaedahPerolehan").val(data.No_Mohon);
                            $("#txtNamaSyarikat").val(data.Nama_Sykt);
                            $("#txtNamaPemohon").val(data.Nama);
                            $("#txtKategori").val(data.kategori_butiran);
                            $("#txtKaedahPerolehan").val(data.Kaedah);

                            $('#transaksi').modal('show'); //modal

                            tblItemGRN.ajax.reload();
                            tblGRNLepas.ajax.reload();
                            showJumlahHarga();

                        });
                    },


                    "columns": [
                        { "data": "No_Perolehan" },
                        { "data": "No_Pesanan" },
                        { "data": "Nama_Sykt" },
                        { "data": "Tujuan" },
                    ],
                    "columnDefs": [
                        {
                            "targets": 0,
                            visible: false,
                            searchable: false
                        },

                    ],
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

            //------------------------------------------------------

            var newGRNDtl = [];

            $('.btnSearch').click(async function () {

                load_loader();
                isClicked = true;
                tblGRN.ajax.reload();
                close_loader();
            })

            //--okay for 25 apr 24
            $('.btnSimpanGrn').off('click').on('click', async function (evt) {
                $('#transaksi').modal('hide');
                $('#saveConfirmationModal10').modal('show');

                var msg = "Anda pasti ingin menyimpan rekod ini?";
                $('#confirmationMessage10').text(msg);

                $('#registerGRN').off('click').on('click', async function () {
                    $('#saveConfirmationModal10').modal('hide');

                    var newGRNHdr = {
                        DaftarGRN: {
                            txtNoGrn: $('#txtSample').val(),
                            txtNoPT: $('#txtNoPT').val(),
                            txtKodBekalKepada: $('#txtKodBekalKepada').val(),
                            txtTkhTerimaDO: $('#txtTkhTerimaDO').val(),
                            txtTkhDO: $('#txtTkhDO').val(),
                            txtNoDO: $('#txtNoDO').val(),
                            txtUlasanDO: $('#txtUlasanDO').val(),
                            idSyarikat: $('#idSyarikat').val(),
                        }
                    };

                    //evt.preventDefault();
                    //saveAndUploadFile();

                    var canProceed = true;
                    var data = [];

                    $('.chkItem').each(async function (ind, obj) {
                        if (!obj.checked) return;

                        var txtNoGrnValue = $('#txtNo_GRN').eq(ind).val();
                        var itemTerimaValue = $('.itemTerima').eq(ind).val();
                        var idMohonDtlValue = $('.idMohonDtl').eq(ind).val();
                        var itemBakiTinggalValue = $('.itemBakiTinggal').eq(ind).val();
                        var itemKuantitiValue = $('.itemKuantiti').eq(ind).val();
                        var amaunGRNTerimaValue = $('.amaunGRNTerima').eq(ind).val();
                        var bezaValue = $('.test').eq(ind).val();
                        var selisihValue = $('.beza').eq(ind).val();
                        var beza2Value = $('.test').eq(ind).val();

                        var DaftarGRNDtl = {
                            txtNoGrn: txtNoGrnValue,
                            itemTerima: itemTerimaValue,
                            idMohonDtl: idMohonDtlValue,
                            itemKuantiti: itemKuantitiValue,
                            itemBakiTinggal: itemBakiTinggalValue,
                            amaunGRNTerima: amaunGRNTerimaValue,
                            beza: bezaValue,
                            selisih: selisihValue,
                            beza2: beza2Value,
                        };

                        //saveAndUploadFile(); // part afiq

                        if (parseInt(DaftarGRNDtl.itemTerima) > parseInt(DaftarGRNDtl.itemKuantiti)) {
                            canProceed = false;
                            return false;
                        }

                        if (parseInt(DaftarGRNDtl.selisih) !== 0) {
                            if (parseInt(DaftarGRNDtl.itemTerima) > parseInt(DaftarGRNDtl.selisih)) {
                                canProceed = false;
                                return false;
                            }
                        }

                        data.push(DaftarGRNDtl);
                    });

                    //if (canProceed) {
                    //    evt.preventDefault();
                    //    saveAndUploadFile();
                    //    /*console.log('namaFailnamaFail,', namaFail)*/

                    //    //if (uploadDokumenData.value !== '' && canProceed === true) {
                    //    //    var result = JSON.parse(await ajaxSaveGRN_Hdr(newGRNHdr));
                    //    //} else {
                    //    //    showModalLampiran("Makluman", "Sila muat naik dokumen.");
                    //    //}
                        
                    //    console.log("result=,", result)
                    //    console.log("result111=,", newGRNHdr)

                    //    if (result.Status === true) {
                    //        showModal10("Success", result.Message, "success");
                    //        ///tblGRN.ajax.reload();

                    //        try {
                    //            const saveResponse = await ajaxSaveGRN_Dtl(data);
                    //            //alert('Data saved successfully!');
                    //            tblGRN.ajax.reload();
                    //        } catch (error) {
                    //            alert('Error saving data!\n\nError: ' + error);
                    //        }
                    //    } else {
                    //        showModal10("Error", result.Message, "error");
                    //    }
                    //} else {
                    //    showModalCheckingKuantiti("Peringatan", "Kuantiti terima melebihi kuantiti order. Sila semak semula.");
                    //    //alert("Kuantiti terima melebihi kuantiti order. Sila semak semula.");
                    //    tblGRN.ajax.reload();

                    //}

                    if (canProceed) {
                        evt.preventDefault();
                        saveAndUploadFile();
                        var result = JSON.parse(await ajaxSaveGRN_Hdr(newGRNHdr));
                        console.log("result=,", result)
                        console.log("result111=,", newGRNHdr)

                        if (result.Status === true) {
                            showModal10("Success", result.Message, "success");
                            ///tblGRN.ajax.reload();

                            try {
                                const saveResponse = await ajaxSaveGRN_Dtl(data);
                                //alert('Data saved successfully!');
                                tblGRN.ajax.reload();
                            } catch (error) {
                                alert('Error saving data!\n\nError: ' + error);
                            }
                        } else {
                            showModal10("Error", result.Message, "error");
                        }
                    } else {
                        showModalCheckingKuantiti("Peringatan", "Kuantiti terima melebihi kuantiti order. Sila semak semula.");
                        //alert("Kuantiti terima melebihi kuantiti order. Sila semak semula.");
                        tblGRN.ajax.reload();
                    }
                   

                });
            });

            //var btnSimpan = document.getElementById('btnSimpanGrn');
            //var txtFailDO = document.getElementById('txtFailDO');
            //var uploadDokumenData = document.getElementById('uploadDokumen');
            
            document.addEventListener("DOMContentLoaded", function () {
                var fileInput = document.getElementById("uploadDokumen");
                var setujuButton = document.getElementById("btnSimpanGrn");

                // Disable "Setuju" button initially
                setujuButton.disabled = true;

                // Add event listener to file input
                fileInput.addEventListener("change", function () {
                    // Check if file is selected
                    if (fileInput.files.length > 0) {
                        // Enable "Setuju" button if file is selected
                        setujuButton.disabled = false;
                    } else {
                        // Disable "Setuju" button if no file is selected
                        setujuButton.disabled = true;
                    }
                });
            });
            //txtFailDO.addEventListener('input', checkInputs);
            //uploadDokumenData.addEventListener('click', saveAndUploadFile);

            //function checkInputs() {
            //    console.log('fileeeee,', fileInput.value)
            //    // If all fields have data, enable the button
            //    if (txtFailDO.value !== '' && uploadDokumenData.value !== '') {
            //        btnSimpan.disabled = false;
            //    } else {
            //        btnSimpan.disabled = true;
            //    }

            //}

            //// Simpan GRN    //  yang ni test mcm okay
            //$('.btnSimpanGrn').off('click').on('click', async function (evt) {

            //    $('#transaksi').modal('hide');
            //    $('#saveConfirmationModal10').modal('show');

            //    var msg = "Anda pasti ingin menyimpan rekod ini?";
            //    $('#confirmationMessage10').text(msg);
            //    // Open the Bootstrap modal

            //    $('#registerGRN').off('click').on('click', async function () {
            //        $('#saveConfirmationModal10').modal('hide'); // Hide the modal

            //        var newGRNHdr = {
            //            DaftarGRN: {
            //                txtNoGrn: $('#txtSample').val(),

            //                txtNoPT: $('#txtNoPT').val(),
            //                txtKodBekalKepada: $('#txtKodBekalKepada').val(),
            //                txtTkhTerimaDO: $('#txtTkhTerimaDO').val(),
            //                txtTkhDO: $('#txtTkhDO').val(),
            //                txtNoDO: $('#txtNoDO').val(),
            //                txtUlasanDO: $('#txtUlasanDO').val(),
            //                idSyarikat: $('#idSyarikat').val(),

            //            }
            //        }

            //        evt.preventDefault();
            //        saveAndUploadFile();
                     
            //        var result = JSON.parse(await ajaxSaveGRN_Hdr(newGRNHdr));
            //        console.log("result=,", result)
            //        console.log("result111=,", newGRNHdr)
            //        if (result.Status === true) {

            //            showModal10("Success", result.Message, "success");
            //            tblGRN.ajax.reload(); //hidekejap
            //            //console.log("Grn ID=", result.Payload.txtNoGrn)

            //            var canProceed = true;
            //            var data = [];
            //            $('.chkItem').each(async function (ind, obj) {
            //               /* var DaftarGRNDtl = {};*/
            //                //if (obj.checked === false) {
            //                //    return;
            //                //}
            //                if (!obj.checked) return;

            //                var txtNoGrnValue = $('#txtNo_GRN').eq(ind).val();
            //                var itemTerimaValue = $('.itemTerima').eq(ind).val();
            //                var idMohonDtlValue = $('.idMohonDtl').eq(ind).val();
            //                var itemBakiTinggalValue = $('.itemBakiTinggal').eq(ind).val();
            //                var itemKuantitiValue = $('.itemKuantiti').eq(ind).val();
            //                var amaunGRNTerimaValue = $('.amaunGRNTerima').eq(ind).val();
            //                var bezaValue = $('.test').eq(ind).val();
            //                var selisihValue = $('.beza').eq(ind).val();
            //                var beza2Value = $('.test').eq(ind).val();

            //                var DaftarGRNDtl = {
            //                    txtNoGrn: txtNoGrnValue,
            //                    itemTerima: itemTerimaValue,
            //                    idMohonDtl: idMohonDtlValue,
            //                    itemKuantiti: itemKuantitiValue,
            //                    itemBakiTinggal: itemBakiTinggalValue,
            //                    amaunGRNTerima: amaunGRNTerimaValue,
            //                    beza: bezaValue,
            //                    selisih: selisihValue,
            //                    beza2: beza2Value,
            //                };

            //               //if (parseInt(DaftarGRNDtl.itemTerima) > parseInt(DaftarGRNDtl.itemKuantiti)) {
            //               //     canProceed = false;
            //               //     alert("Kuantiti terima melebihi kuantiti order. Sila semak semula.");
            //               //     console.log("itemTerimaValue:", DaftarGRNDtl.itemTerima, "itemKuantitiValue:", DaftarGRNDtl.itemKuantiti);
            //               // }

            //                if (parseInt(DaftarGRNDtl.itemTerima) > parseInt(DaftarGRNDtl.itemKuantiti)) {
            //                    canProceed = false;
            //                    return false;
            //                }

            //                if (parseInt(DaftarGRNDtl.selisih) !== 0) {
            //                    if (parseInt(DaftarGRNDtl.itemTerima) > parseInt(DaftarGRNDtl.selisih)) {
            //                        canProceed = false;
            //                        return false; // Exit the loop early
            //                    }
            //                }


            //                data.push(DaftarGRNDtl);
            //                console.log("rowData:", DaftarGRNDtl);
            //                console.log("itemTerima:", itemTerima);
            //                console.log("itemKuantiti:", itemKuantiti);
            //            });

            //            if (canProceed) {
            //                console.log("Data to be sent:", data);
            //                try {
            //                    const saveResponse = await ajaxSaveGRN_Dtl(data);
            //                    alert('Data saved successfully!');
            //                } catch (error) {
            //                    //console.error("Error saving data:", error);
            //                    alert('Error saving data!\n\n' +
            //                        'Error: ' + error);
            //                }
            //            } else {
            //                alert("Kuantiti terima melebihi kuantiti order. Sila semak semula.");
            //            }
            //            } else {
            //                showModal10("Error", result.Message, "error");
            //            }

            //        });

            //    });


            //Simpan GRN ORIGINAL CODE
            //$('.btnSimpanGrn').off('click').on('click', async function (evt) {

            //    $('#transaksi').modal('hide');
            //    $('#saveConfirmationModal10').modal('show');

            //    var msg = "Anda pasti ingin menyimpan rekod ini?";
            //    $('#confirmationMessage10').text(msg);
            //    // Open the Bootstrap modal


            //    $('#registerGRN').off('click').on('click', async function () {
            //        $('#saveConfirmationModal10').modal('hide'); // Hide the modal



            //        var newGRNHdr = {
            //            DaftarGRN: {
            //                txtNoGrn: $('#txtSample').val(),

            //                txtNoPT: $('#txtNoPT').val(),
            //                txtKodBekalKepada: $('#txtKodBekalKepada').val(),
            //                txtTkhTerimaDO: $('#txtTkhTerimaDO').val(),
            //                txtTkhDO: $('#txtTkhDO').val(),
            //                txtNoDO: $('#txtNoDO').val(),
            //                txtUlasanDO: $('#txtUlasanDO').val(),
            //                idSyarikat: $('#idSyarikat').val(),

            //            }
            //        }

            //        evt.preventDefault();
            //        saveAndUploadFile();

            //        var result = JSON.parse(await ajaxSaveGRN_Hdr(newGRNHdr));
            //        console.log("result=,", result)
            //        console.log("result111=,", newGRNHdr)
            //        if (result.Status === true) {

            //            showModal10("Success", result.Message, "success");
            //            tblGRN.ajax.reload();
            //            console.log("Grn ID=", result.Payload.txtNoGrn)
            //        } else {
            //            showModal10("Error", result.Message, "error");
            //        }

            //        $('.chkItem').each(async function (ind, obj) {
            //            if (obj.checked === false) {
            //                return;
            //            }

            //            // Retrieve 
            //            var txtNoGrnValue = $('#txtNo_GRN').eq(ind).val();
            //            var itemTerimaValue = $('.itemTerima').eq(ind).val();
            //            var idMohonDtlValue = $('.idMohonDtl').eq(ind).val();
            //            var itemBakiTinggalValue = $('.itemBakiTinggal').eq(ind).val();
            //            var itemKuantitiValue = $('.itemKuantiti').eq(ind).val();
            //            var amaunGRNTerimaValue = $('.amaunGRNTerima').eq(ind).val();
            //            var bezaValue = $('.test').eq(ind).val();
            //            var beza2Value = $('.test').eq(ind).val();




            //            var newGRNDtl = {
            //                DaftarGRNDtl: {
            //                    txtNoGrn: txtNoGrnValue,
            //                    itemTerima: itemTerimaValue,
            //                    idMohonDtl: idMohonDtlValue,
            //                    itemKuantiti: itemKuantitiValue,
            //                    itemBakiTinggal: itemBakiTinggalValue,
            //                    amaunGRNTerima: amaunGRNTerimaValue,
            //                    beza: bezaValue,
            //                    beza2: beza2Value,

            //                }
            //            }


            //            // ------------------------ CHECKING PROSES  ------------------ START --------

            //            // ------------------------ CHECKING PROSES  ------------------ END --------


            //            var result2 = JSON.parse(await ajaxSaveGRN_Dtl(newGRNDtl));
            //            console.log("result=,", result2)
            //            console.log("result111=,", newGRNDtl)
            //            if (result2.Status === true) {

            //                showModal10("Success", result.Message, "success");
            //                tblGRN.ajax.reload();

            //            } else {
            //                showModal10("Error", result.Message, "error");
            //            }

            //        });

            //    });

            //});


            async function ajaxSaveGRN_Hdr(DaftarGRN) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/SaveDaftarGrn_Hdr") %>',
                        method: 'POST',
                        data: JSON.stringify(DaftarGRN),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            resolve(data.d);
                            console.log("ajax here");
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            console.log("ajax gagal");
                            reject(false);
                        }
                    });
                })
                console.log("tst")
            }

            async function ajaxSaveGRN_Dtl(DaftarGRNDtl) {
                try {
                    const response = await $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/SaveDaftarGrn_Dtl") %>',
                        method: 'POST',
                        data: JSON.stringify({ DaftarGRNDtl: DaftarGRNDtl }),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8'
                    });
                        console.log("ajax success");
                        return response.d;
                    }   catch (error) {
                        //console.error('Error:', error);
                        console.log("ajax failed");
                        throw error;
                    }
            }

           <%-- async function ajaxSaveGRN_Dtl(DaftarGRNDtl) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/SaveDaftarGrn_Dtl") %>',
                        method: 'POST',
                        data: JSON.stringify(DaftarGRNDtl),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            resolve(data.d);
                            console.log("ajax here");
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            console.log("ajax gagal");
                            reject(false);
                        }
                    });
                })
                console.log("tst")
            }--%>
            var namaFail = '';
            var fileCheck = true;
            function saveAndUploadFile() {

                namaFail = $("#txtFailDO").val();

                var fileInput = document.getElementById("uploadDokumen");
                var file = fileInput.files[0];


                if (!file) {
                    showModalLampiran("Makluman", "Sila muat naik dokumen.");
                    return; // Exit the function
                }

                var fileSize = file.size;
                var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (5MB)

                if (fileSize > maxSize) {
                    showModalLampiran("Saiz Fail Besar", "Saiz fail melebihi had maksimum 5MB.");
                    return;
                }

                var fileName = file.name;
                var fileExtension = fileName.split('.').pop().toLowerCase();

                if (!['pdf', 'png', 'jpg', 'jpeg'].includes(fileExtension)) {
                    showModalLampiran("Fail Salah Format", "Hanya format PDF, PNG, JPG, dan JPEG sahaja dibenarkan.");
                    return;
                }

                var requestData = {
                    namaFail: namaFail,
                    // fileData: "test", 
                    fileName: fileName,
                };

                var formData = new FormData();
                formData.append("namaFail", namaFail);
                formData.append("file", file);
                formData.append("fileName", fileName);
                formData.append("txtNoGrn", $('#txtNoGrn').val());
                formData.append("sessiontxtNoGrn", '<%= Session("sessiontxtNoGrn") %>');


                //if (fileName !== '' && canProceed === true) {
                 
                //}

                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/SaveAndUploadFile") %>',
                       data: formData,
                       cache: false,
                       contentType: false,
                       type: 'POST',
                       processData: false,
                       success: function (response) {
                           //showModalLampiran("Berjaya Simpan", "Fail berjaya disimpan di pangkalan data.");
                           tblGRN.ajax.reload();//hidekejap
                       },
                       error: function () {
                           //showModalLampiran("Tidak Berjaya Simpan", "Sila cuba simpan semula.");
                       }
                   });
            }

                function showModal10(title, message, type) {
                $('#resultModalTitle10').text(title);
                $('#resultModalMessage10').text(message);
                if (type === "success") {
                    $('#resultModal10').removeClass("modal-error").addClass("modal-success");
                    tblGRN.ajax.reload(); //hidekejap
                } else if (type === "error") {
                    $('#resultModal10').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal10').modal('show');
               
            }

            function showModalLampiran(header, body) {
                $('#lampirantitle').text(header);
                $('#lampiranbody').text(body);
                $('#formatSimpanLampiran').modal('show');
            }

            function showModalCheckingKuantiti(header, body) {
                $('#checkingtitle').text(header);
                $('#checkingbody').text(body);
                $('#kuantitiTerlebihModal').modal('show');
            }


            function showModal11(title, message, type) {
                $('#resultModalTitle11').text(title);
                $('#resultModalMessage11').text(message);
                if (type === "success") {
                    $('#resultModal11').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal11').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal11').modal('show');
               
            }


            //-------------------//
            var tblGRNLepas = null;
            var classSelectedSpekDetails = "";
            var prevRow = null;
            var childTable = null;
            $(document).ready(function () {
                tblGRNLepas = $("#tblSenaraiGRNterdahulu2").DataTable({
                    "responsive": true,
                    "searching": false,
                    "paging": false,
                    "ordering": false,
                    "info": false,
                    stateSave: true,
                    "ajax": {
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/GetLoad_ItemGrnTerima") %>',
                        "method": 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            console.log("Sending AJAX request grn test:", idPembelian);
                            console.log("Sending AJAX request grn test:", idSyarikat);
                            return JSON.stringify({ idPembelian: idPembelian, idSyarikat: idSyarikat});
                        },
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        },
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
                            var rowData = data;
                            idPembelian = rowData.Id_Pembelian;
                            idSyarikat = rowData.ID_Sykt;
                        });
                    },
                    "columns": [
                        {
                            "data": null,
                            "width": "25%", "className": "text-center smaller-font",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                return `<button class="btnDetails btndt${data.kod}" data-level="2" data-kod = "' + data + '"><i class="fas fa-plus"></i></button>`;

                            },
                        },
                        {   //BIL
                            data: null,
                            "render": function (data, type, row, meta) {
                                return meta.row + 1;
                            },
                        },
                        { "data": "No_GRN" },
                        { "data": "No_Pesanan" },
                        { "data": "kategori_butiran" },
                        { "data": "Tujuan" },
                        { "data": "Nama_Sykt" },
                        {
                            "data": "grnStatus",
                            "render": function (data, type, row) {
                                if (data === '1') {
                                    return '<span style="color:blue;">DALAM PROSES</span>';
                                } else if (data === '2') {
                                    return '<span style="color:green;">SELESAI BAYAR BALIK</span>';
                                } else {
                                    return '<span style="color:red;">TIADA REKOD</span>';
                                }
                            }
                        },
                        { "data": null, "className": "text-center", "title": "Tindakan" }
                    ],
                    "columnDefs": [
                        {
                            "targets": 8, // Target the last column (Delete column)
                            "data": null,
                            "render": function (data, type, row) {
                                return `
                            <div class="row justify-content-center">
                                <div class="col-md-1">
                                    <button type="button" class="btn viewDO" style="padding:0px 0px 0px 0px" title="Papar">
                                       <i class="fa fa-eye "></i>
                                    </button>
                                </div>
                            </div>`;
                            }
                        }
                    ]
                });

                $("#tblSenaraiGRNterdahulu2").off('click', '.viewDO').on("click", ".viewDO", function (event) {
                    var data = tblGRNLepas.row($(this).parents('tr')).data();
                    var fileName = data.Content_Type;
                    var txtNoGrn = data.No_GRN;

                    // Call a function to open the PDF in a new tab
                    openPDFInNewTabFailDO(fileName, txtNoGrn);
                });

                function openPDFInNewTabFailDO(fileName, txtNoGrn) {
                    var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/PEROLEHAN/GRNSRN/") %>' + txtNoGrn + '/' + fileName;
                    window.open(pdfPath, '_blank');
                }

            });

            $('#tblSenaraiGRNterdahulu2').on('click', '.btnDetails', function (evt) {

                evt.preventDefault();
                classSelectedSpekDetails = $(this).attr("class")
                var tr = $(this).closest('tr');
                var row = tblGRNLepas.row(tr);
                var rowData = row.data();

                var pickedIdPembelian = rowData.Id_Pembelian;
                var pickedIDSyarikat = rowData.ID_Sykt;
                var pickedNoNoPT = rowData.No_Pesanan;
                var pickedGRN = rowData.No_GRN;

                if (row.child.isShown()) {
                    // This row is already open - close it
                    row.child.hide();
                    tr.removeClass('shown');
                    $(this).html('<i class="fas fa-plus"></i>');
                    // Destroy the Child Datatable
                    childTable = null;
                    $('#childtbl' + pickedNoNoPT).DataTable().destroy();
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
                    prevId = '#childtbl' + pickedIDSyarikat;
                    //prevId = '#childtbl';
                    prevRow = row;

                    $(this).html('<i class="fas fa-minus"></i>');

                    row.child(format(pickedNoNoPT)).show();


                    childTable = $('#childtbl' + pickedNoNoPT).DataTable({
                        dom: "t",
                        paging: false,
                        ajax: {
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/GetRecord_ItemGrnChild") %>',
                            type: 'POST',
                            data: function (d) {
                                return JSON.stringify({ idPembelian: pickedIdPembelian, idSyarikat: pickedIDSyarikat, txtNoPT: pickedNoNoPT, txtNoGrn: pickedGRN  });
                            },
                            "contentType": "application/json; charset=utf-8",
                            "dataType": "json",
                            "dataSrc": function (json) {
                                return JSON.parse(json.d);

                            }
                        },
                        columns: [
                            {   //bil
                                data: null,
                                "width": "5%",
                            },
                            {   //bil
                                data: null,
                                "width": "5%",
                                "render": function (data, type, row, meta) {
                                    return meta.row + 1;
                                },
                            },
                            {   //ID MOHON DTL
                                "data": "Id_Mohon_Dtl",
                                "width": "5%", "className": "text-center",
                            },

                            {    //BUTIRAN
                                "data": "Butiran",
                                "width": "5%", "className": "text-center",
                            },

                            {    //KUANTITI
                                "data": "Kuantiti",
                                "width": "5%", "className": "text-center",
                            },

                            {    //KUANTITI TERIMA
                                "data": "Kuantiti_Terima",
                                "width": "5%", "className": "text-center",
                            },

                            {   //HARGAS SEUNIT
                                "data": "Harga_Seunit",
                                "width": "5%", "className": "text-right",
                                "render": function (data) {
                                        //return parseFloat(data).toFixed(2);
                                    return parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                }

                            },

                            {    //AMAUN
                                "data": "Amaun",
                                "width": "5%", "className": "text-right",
                                "render": function (data) {
                                    if (isNaN(parseFloat(data)) || data === "") {
                                        return "0.00"; 
                                    } else {
                                        //return parseFloat(data).toFixed(2);
                                        return parseFloat(data).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
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
                            {
                                "targets": 2,
                                visible: false,
                                searchable: false
                            },

                        ],
                        footerCallback: function (row, data, start, end, display) {
                            console.log("Footer callback called");
                            var api = this.api();
                            //console.log("API instance:", api);

                            var total = api.column(6, { page: 'current' }).data().reduce(function (a, b) {
                                return parseFloat(a) + parseFloat(b);
                            }, 0);

                            var total2 = api.column(7, { page: 'current' }).data().reduce(function (a, b) {
                                return parseFloat(a) + parseFloat(b);
                            }, 0);

                            $(api.column(6).footer()).html(
                                '<b>' + total.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + '</b>'
                            );

                            $(api.column(7).footer()).html(
                                '<b>' + total2.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + '</b>'
                            );
                        },

                    });

                    tr.addClass('shown');

                }

                return false;

            });


            function format(id) {
                childTable = '<table id="childtbl' + id + '" class="compact w-100" width="100%">' +
                    '<thead style="color: black">' +
                    '<tr>' +
                    '<td></td>' + //EMPTY CELL
                    '<td></td>' +
                    '<td>Bil</td>' +
                    '<td>Butiran</td>' +
                    '<td>Pesan</td>' +
                    '<td>Terima</td>' +
                    '<td>Harga Seunit (RM)</td>' +
                    '<td>Jumlah (RM)</td>' +
                    '</tr>' +
                    '</thead>' +
                    '<tfoot>' +
                    '<tr>' +
                    '<td colspan="5"></td>' + // Empty cells for the first 6 columns
                    '<td style="text-align: right; font-weight: bold;">Jumlah Besar (RM) :</td>' + // Label for the total
                    '<td style="text-align: right; font-weight: bold;">Jumlah Besar (RM) :</td>' + // Label for the total
                    '<td></td>' + // Placeholder for the total amount, will be filled dynamically
                    '</tr>' +
                    '</tfoot>' + // Footer section
                    '</table>';
                return $(childTable).toArray();
            }
            //-------------------//

            function showJumlahHarga() {
                var idPembelian = $('#idPembelian').val();
                //console.log("test ididPembelian", idPembelian)
                console.log("showJumlahHarga function called");
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/GRN SRN/GrnSrn.asmx/GetRecord_TotalHarga") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ idPembelian: idPembelian }), // Remove $('#idPembelian').val() from here
                    success: function (result) {
                        result = JSON.parse(result.d);
                        var formattedTotal = parseFloat(result[0].Total_Jumlah_Harga).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                        $('#txtJumlah').val('RM ' + formattedTotal);
                    },
                    error: function (error) {
                        console.error('AJAX error:', error);
                    }
                });
            }


        </script>
    
  
</asp:Content>
