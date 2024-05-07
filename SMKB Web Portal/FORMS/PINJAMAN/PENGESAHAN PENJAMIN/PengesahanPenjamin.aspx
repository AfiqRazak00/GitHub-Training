<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PengesahanPenjamin.aspx.vb" Inherits="SMKB_Web_Portal.PengesahanPenjamin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
   <script type="text/javascript">
       function ShowPopup(elm) {

           if (elm == "1") {
               $('#permohonan').modal('toggle');

           }
           else if (elm == "2") {

               $(".modal-body div").val("");
               $('#permohonan2').modal('toggle');

               $('#txtTarikhStart').val("");
               $('#txtTarikhEnd').val("");
               $('#divDatePicker').removeClass("d-flex").addClass("d-none");

               $('#categoryFilter').val("");

               $('.btnSearch').click();

               $('.btnEmel').show();
               $('.btnCetak').show();
           }
       }
   </script>
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
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
      max-width: 1200px; /* Set the maximum width for the modal content */
      margin: auto; /* Center the modal horizontally */
      }
      .form-group {
      /* Optionally, adjust the width of the form elements if needed */
      max-width: 100%; /* Set the maximum width for the form elements */
      }
   </style>
   <!-------------------------------------------------------------------  STYLE END  -------------------------------------------------------------------------->
   <!------------------------------------------------------------------- CODE START  -------------------------------------------------------------------------->
   <contenttemplate>
      <div id="PermohonanTab" class="tabcontent" style="display: block">
         <div class="modal-body">
            <div class="table-title">
               <h5>Pengesahan Penjamin</h5>
            </div>
            <div class="modal-body">
               <div class="col-md-13">
                  <div class="transaction-table table-responsive">
                     <span style="display: inline-block; height: 100%;"></span>
                     <table id="tblPenjamin" class="table table-striped">
                        <thead>
                           <tr style="width: 100%">
                              <th scope="col" style="width: 5%">Bil</th>
                              <th scope="col" style="width: 25%">No. Pinjaman</th>
                              <th scope="col" style="width: 25%">Nama Pemohon</th>
                              <th scope="col" style="width: 25%">Tarikh Mohon</th>
                              <th scope="col" style="width: 25%">Jenis Pinjaman</th>
                           </tr>
                        </thead>
                        <tbody id="" onclick="ShowPopup('1')">
                           <tr style="width: 100%" class="table-list">
                              <td style="width: 10%"></td>
                              <td style="width: 15%"></td>
                              <td style="width: 30%"></td>
                              <td style="width: 25%"></td>
                              <td style="width: 15%"></td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 START ~~~-->
         <div class="modal fade bd-example-modal-xl" id="permohonan" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl"  role="document">
               <div class="modal-content modal-xl">
                  <div class="modal-header">
                     <div class="modal-title">
                        <h6>Info Pembiayaan</h6>
                     </div>
                     <div class="d-flex justify-content-end">
                        <button id="btnHome" name="btnHome" type="button" class="close" data-dismiss="modal" style="visibility: hidden" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                        <button id="btnSignOut" name="btnSignOut" type="button" class="close" data-dismiss="modal" style="visibility: hidden" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                        <button id="btnClose" name="btnClose" type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                  </div>
                  <div class="modal-body">
                     <fieldset class="form-group border p-3">
                        <legend class="w-auto px-2" style="font-size: 16px; font-weight: bold;">Info Pemohon</legend>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="nostafPeminjam" placeholder="&nbsp;" name="nostafPeminjam" readonly />
                                    <label class="input-group__label" for="nostafPeminjam">No Staf</label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="namastafPinjaman" placeholder="&nbsp;" name="namastafPinjaman" readonly/>
                                    <label class="input-group__label" for="namastafPinjaman">Nama Staf</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="jawatanPinjaman" placeholder="&nbsp;" name="jawatanPinjaman" readonly/>
                                    <label class="input-group__label" for="jawatanPinjaman">Jawatan</label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="jabatanPinjaman" placeholder="&nbsp;" name="jabatanPinjaman" readonly/>
                                    <label class="input-group__label" for="jabatanPinjaman">Jabatan</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </fieldset>
                     <!-- ~~~ KENDERAAN START ~~~-->
                     <fieldset id="infoKenderaanFieldset" class="form-group border p-3" style="display: none;">
                        <legend class="w-auto px-2" style="font-size: 16px; font-weight: bold;">Info Kenderaan</legend>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="kategoriPinjaman" placeholder="&nbsp;" name="kategoriPinjaman" readonly />
                                    <label class="input-group__label" for="kategoriPinjaman">Kategori Pinjaman</label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="jenisPinjaman" placeholder="&nbsp;" name="jenisPinjaman" readonly />
                                    <label class="input-group__label" for="jenisPinjaman">Jenis Pinjaman</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="modelPinjaman" placeholder="&nbsp;" name="modelPinjaman" readonly/>
                                    <label class="input-group__label" for="modelPinjaman">Model Kenderaan</label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="buatanPinjaman" placeholder="&nbsp;" name="buatanPinjaman" readonly/>
                                    <label class="input-group__label" for="buatanPinjaman">Buatan</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="sukatanPinjaman" placeholder="&nbsp;" name="sukatanPinjaman" readonly/>
                                    <label class="input-group__label" for="sukatanPinjaman">Sukatan Slinder</label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="chasisPinjaman" placeholder="&nbsp;" name="chasisPinjaman" readonly/>
                                    <label class="input-group__label" for="chasisPinjaman">No. Chasis</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="enjinPinjaman" placeholder="&nbsp;" name="enjinPinjaman" readonly />
                                    <label class="input-group__label" for="enjinPinjaman">No. Enjin</label>
                                 </div>
                                 <div class="form-group col-md-6" style="display: none;">
                                    <input class="input-group__input" id="hargaKenderaan" placeholder="&nbsp;" name="hargaKenderaan" hidden />
                                    <label class="input-group__label" for="hargaKenderaan">Harga Mohon (RM)</label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="hargaMohon1" placeholder="&nbsp;" name="hargaMohon" readonly />
                                    <label class="input-group__label" for="hargaMohon">Harga Mohon (RM)</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </fieldset>
                     <!-- ~~~ KENDERTAAN END ~~~-->
                     <!-- ~~~ KOMPUTER START ~~~-->
                     <fieldset id="infoKomputerFieldset" class="form-group border p-3" style="display: none;">
                        <legend class="w-auto px-2" style="font-size: 16px; font-weight: bold;">Info Komputer</legend>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="kategoriPinjaman2" placeholder="&nbsp;" name="kategoriPinjaman" readonly />
                                    <label class="input-group__label" for="kategoriPinjaman">Kategori Pinjaman</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="jenisPinjaman2" placeholder="&nbsp;" name="jenisPinjaman" readonly />
                                    <label class="input-group__label" for="jenisPinjaman">Jenis Pinjaman</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="jenamaPinjaman" placeholder="&nbsp;" name="jenamaPinjaman" readonly />
                                    <label class="input-group__label" for="jenamaPinjaman">Jenama Komputer</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="ingatanPinjaman" placeholder="&nbsp;" name="ingatanPinjaman" readonly />
                                    <label class="input-group__label" for="ingatanPinjaman">Ingatan</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="pemacucakeraPinjaman" placeholder="&nbsp;" name="pemacucakeraPinjaman" readonly />
                                    <label class="input-group__label" for="pemacucakeraPinjaman">Pemacu Cakera</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="modemPinjaman" placeholder="&nbsp;" name="modemPinjaman" readonly />
                                    <label class="input-group__label" for="modemPinjaman">Modem</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="kadbunyiPinjaman" placeholder="&nbsp;" name="kadbunyiPinjaman" readonly />
                                    <label class="input-group__label" for="kadbunyiPinjaman">Kad Bunyi</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="tetikusPinjaman" placeholder="&nbsp;" name="tetikusPinjaman" readonly />
                                    <label class="input-group__label" for="tetikusPinjaman">Pemacu Cakera</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="nosirikomputerPinjaman" placeholder="&nbsp;" name="nosirikomputerPinjaman" readonly />
                                    <label class="input-group__label" for="nosirikomputerPinjaman">No. Siri</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="monitorPinjaman" placeholder="&nbsp;" name="monitorPinjaman" readonly />
                                    <label class="input-group__label" for="monitorPinjaman">Monitor</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="namapencetakPinjaman" placeholder="&nbsp;" name="namapencetakPinjaman" readonly />
                                    <label class="input-group__label" for="namapencetakPinjaman">Nama Pencetak</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="papankekunciPinjaman" placeholder="&nbsp;" name="papankekunciPinjaman" readonly />
                                    <label class="input-group__label" for="papankekunciPinjaman">Papan Kekunci</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="cakerakerasPinjaman" placeholder="&nbsp;" name="cakerakerasPinjaman" readonly />
                                    <label class="input-group__label" for="cakerakerasPinjaman">Cakera Keras</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="jenispinjkompPinjaman" placeholder="&nbsp;" name="jenispinjkompPinjaman" readonly />
                                    <label class="input-group__label" for="jenispinjkompPinjaman">Jenis Pinjaman</label>
                                 </div>
                                 <div class="form-group col-md-4" style="display: none;">
                                    <input class="input-group__input" id="hargaKomputer" placeholder="&nbsp;" name="hargaKomputer" hidden />
                                    <label class="input-group__label" for="hargaKomputer">Harga Mohon (RM)</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="hargaMohon2" placeholder="&nbsp;" name="hargaMohon" readonly />
                                    <label class="input-group__label" for="hargaMohon">Harga Mohon (RM)</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </fieldset>
                     <!-- ~~~ KOMPUTER END ~~~-->
                     <!-- ~~~ SUKAN START ~~~-->
                     <fieldset id="infoSukanFieldset" class="form-group border p-3" style="display: none;">
                        <legend class="w-auto px-2" style="font-size: 16px; font-weight: bold;">Info Sukan</legend>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="kategoriPinjaman3" placeholder="&nbsp;" name="kategoriPinjaman" readonly />
                                    <label class="input-group__label" for="kategoriPinjaman">Kategori Pinjaman</label>
                                 </div>
                                 <div class="form-group col-md-4">
                                    <input class="input-group__input" id="jenissukanPinjaman" placeholder="&nbsp;" name="jenissukanPinjaman" readonly />
                                    <label class="input-group__label" for="jenissukanPinjaman">Jenis Sukan</label>
                                 </div>
                                 <div class="form-group col-md-4" style="display: none;">
                                    <input class="input-group__input" id="hargaSukan" placeholder="&nbsp;" name="hargaSukan" readonly />
                                    <label class="input-group__label" for="hargaSukan">Harga Mohon (RM)</label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="hargaMohon3" placeholder="&nbsp;" name="hargaMohon" readonly />
                                    <label class="input-group__label" for="hargaMohon">Harga Mohon (RM)</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </fieldset>
                     <!-- ~~~ SUKAN END ~~~-->
                     <fieldset id="desclaimerFieldset" class="form-group border p-3">
                        <legend class="w-auto px-2" style="font-size: 16px; font-weight: bold;">Pengesahan</legend>
                        <div class="form-check" style="margin-left: 5%;">
                           <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" onchange="handleCheckboxChange()">
                           <label class="form-check-label" for="flexCheckDefault" style="padding-left: 1%; margin-bottom: 3%;">
                           Saya bersetuju dan bertanggungjawab atas permohonan pembiayaan <span id="kategoriPinjamanLabel"></span> <span id="namastafPinjamanLabel"></span>.<br> Saya lampirkan salinan kad pengenalan seperti berikut.
                           </label>
                        </div>
                        <div class="form-inline d-flex align-items-center justify-content-center">
                           <div class="text-center">
                              <%--                                  <label style="font-weight: normal;">Salinan Kad Pengenalan</label>--%>
                              <input type="file" id="uploadDokumen" class="form-control-file" accept=".pdf" disabled>
                              <small id="fileErrorMessage" class="form-text text-muted" style="color: red;">Jenis fail yang dibenarkan: .pdf only</small>
                              <input type="hidden" id="namaFail" name="namaFail" />
                           </div>
                           <br />
                        </div>
                     </fieldset>
                     <div align="right">
                        <button type="button" class="btn btn-secondary  btnSimpan1" id="btnSimpan1"
                           data-toggle="tooltip" data-placement="bottom" data-dismiss="modal"
                           title="Setuju" value="1">
                        Setuju</button>
                        <button type="button" class="btn btn-danger btnPadam btnSimpan2" data-dismiss="modal" value="0" id="btnSimpan2" title="Tidak Setuju">Tidak Setuju</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 END   ~~~ -->
         <!-- ~~~ Modal 1 PENGESAHAN YA START   ~~~ -->
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
                     <button type="button" class="btn btn-secondary" id="confirmSaveButton1" value="1">Ya</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 PENGESAHAN YA END    ~~~ -->
         <!-- ~~~ Modal 1 PENGESAHAN TIDAK START   ~~~ -->
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
                     <button type="button" class="btn btn-secondary" id="confirmSaveButton2" value="0">Ya</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 PENGESAHAN TIDAK END     ~~~ -->
         <!-- ~~~ Modal SELESAI START      ~~~ -->
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
                     <p id="resultModalMessage1"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal  CONFIRM END        ~~~ -->
      </div>
      <!----------------------------------------------------------------  CODE END  --------------------------------------------------------------------------->
      <!------------------------------------------------------------------- SCRIPT START ------------------------------------------------------------------------->
      <Script>
          // ---------------------- UNTUK TABLE START -----------------------
          var tbl11 = null;
          var isClicked6 = false;

          $(document).ready(function () {
              show_loader();

              tbl11 = $("#tblPenjamin").DataTable({
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
                      "sLengthMenu": "Tunjuk _MENU_ rekod",
                      "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                      "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                      "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                      "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                      "sEmptyTable": "Tiada rekod.",
                      "sSearch": "Carian"
                  },
                  "ajax": {
                      url: 'PengesahanPenjamin_WS.asmx/LoadPengesahanPenjaminData',
                      //"url": "Invois.asmx/LoadMesyPH",
                      "method": 'POST',
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
                              isClicked6: isClicked6,
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
                      // Add click event ---> untuk baca/get data dari db
                      $(row).on("click", function () {
                          console.log(data);
                          var rowData = data;
                          debugger


                          no_mohon = rowData.No_Mohon;
                          // Update the modal content with the No_Mohon and Tujuan values
                          $("#nostafPinjaman").val(rowData.NoStaf || ' - ');
                          $("#nostafPeminjam").val(rowData.NoStafPeminjam || ' - ');
                          $("#namastafPinjaman").val(rowData.NamaPeminjam || ' - ');
                          $("#jawatanPinjaman").val(rowData.Jawatan || ' - ');
                          $("#jabatanPinjaman").val(rowData.Jabatan || ' - ');
                          $("#jenisPinjaman").val(rowData.Butiran || ' - ');
                          $("#jenisPinjaman2").val(rowData.Butiran || ' - ');
                          $("#kategoriPinjaman").val(rowData.KategoriPinjaman || ' - ');
                          $("#kategoriPinjaman2").val(rowData.KategoriPinjaman || ' - ');
                          $("#kategoriPinjaman3").val(rowData.KategoriPinjaman || ' - ');
                          $("#modelPinjaman").val(rowData.ModelKenderaan || ' - ');
                          $("#sukatanPinjaman").val(rowData.SukatanSilinder || ' - ');
                          $("#chasisPinjaman").val(rowData.NoCasis || ' - ');
                          $("#buatanPinjaman").val(rowData.BuatanKenderaan || ' - ');
                          $("#enjinPinjaman").val(rowData.NoEnjin || ' - ');
                          $("#jenamaPinjaman").val(rowData.Jenama || ' - ');
                          $("#ingatanPinjaman").val(rowData.Ingatan || ' - ');
                          $("#pemacucakeraPinjaman").val(rowData.PemacuCakera || ' - ');
                          $("#modemPinjaman").val(rowData.Modem || ' - ');
                          $("#kadbunyiPinjaman").val(rowData.KadBunyi || ' - ');
                          $("#tetikusPinjaman").val(rowData.Tetikus || ' - ');
                          $("#nosirikomputerPinjaman").val(rowData.NoSiriKomputer || ' - ');
                          $("#monitorPinjaman").val(rowData.Monitor || ' - ');
                          $("#namapencetakPinjaman").val(rowData.NamaPencetak || ' - ');
                          $("#papankekunciPinjaman").val(rowData.PapanKekunci || ' - ');
                          $("#cakerakerasPinjaman").val(rowData.CakeraKeras || ' - ');
                          $("#jenispinjkompPinjaman").val(rowData.JenisPinjamanKomputer || ' - ');
                          $("#jenissukanPinjaman").val(rowData.JenisSukan || ' - ');
                          $("#hargaKenderaan").val(rowData.HargaKenderaan);
                          $("#hargaKomputer").val(rowData.HargaKomputer);
                          $("#hargaSukan").val(rowData.HargaSukan);
                          $("#hargaMohon1").val(rowData.HargaMohon);
                          $("#hargaMohon2").val(rowData.HargaMohon);
                          $("#hargaMohon3").val(rowData.HargaMohon);
                          $("#namastafPinjamanLabel").text(rowData.NamaPeminjam || ' - ');
                          $("#kategoriPinjamanLabel").text(rowData.KategoriPinjaman2 || ' - ');
                          sessionStorage.setItem('nopinjPinjaman', rowData.NoPinjaman2)
                          sessionStorage.setItem('bilPinjaman', rowData.Bilangan)
                          sessionStorage.setItem('emailPinjaman', rowData.EmailPeminjam)
                          sessionStorage.setItem('butiranPinjaman', rowData.Butiran)
                          toggleFieldsetVisibility();
                          toggleFieldsetVisibility2();

                          console.log(rowData);
                          // Set radio button based on 'Status' column
                          if (rowData.Status === '1') {
                              $('#rdYa2').prop('checked', true);
                              $('#rdTidak2').prop('checked', false);
                          } else if (rowData.Status === '0') {
                              $('#rdYa2').prop('checked', false);
                              $('#rdTidak2').prop('checked', true);
                          }
                      });

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
                          "data": "NoPinjaman",
                          "width": "10%"
                      },
                      {
                          "data": "NamaPeminjam",
                          "width": "20%"
                      },
                      {
                          "data": "TarikhMohon",
                          "width": "20%"
                      },
                      {
                          "data": "Butiran",
                          "width": "20%"
                      }
                  ]
              });
              close_loader();
              $('.btnSearch').click(async function () {

                  isClicked6 = true;
                  tbl11.ajax.reload();

              })
          });

          async function rowClickHandler(id) {
              debugger
              if (id !== "") {
                  console.log(id)
              }
          }

          function toggleFieldsetVisibility() {
              var kategoriPinjamanValue = document.getElementById('kategoriPinjaman').value;
              var fieldset = document.getElementById('infoKenderaanFieldset');

              // Check if kategoriPinjaman data is 'KENDERAAN'
              if (kategoriPinjamanValue.trim().toUpperCase() === 'KENDERAAN') {
                  fieldset.style.display = 'block'; // Show the fieldset
              } else {
                  fieldset.style.display = 'none'; // Hide the fieldset
              }
          }
          function toggleFieldsetVisibility2() {
              var hargaKenderaan = document.getElementById('hargaKenderaan').value;
              var hargaKomputer = document.getElementById('hargaKomputer').value;
              var hargaSukan = document.getElementById('hargaSukan').value;

              var infoKenderaanFieldset = document.getElementById('infoKenderaanFieldset');
              var infoKomputerFieldset = document.getElementById('infoKomputerFieldset');
              var infoSukanFieldset = document.getElementById('infoSukanFieldset');

              // Check conditions and adjust fieldsets visibility accordingly
              if (hargaKenderaan.trim() !== '') {
                  infoKenderaanFieldset.style.display = 'block';
              } else {
                  infoKenderaanFieldset.style.display = 'none';
              }

              if (hargaKomputer.trim() !== '') {
                  infoKomputerFieldset.style.display = 'block';
              } else {
                  infoKomputerFieldset.style.display = 'none';
              }

              if (hargaSukan.trim() !== '') {
                  infoSukanFieldset.style.display = 'block';
              } else {
                  infoSukanFieldset.style.display = 'none';
              }
          }
          // ---------------------- UNTUK TABLE END -------------------------
          // ---------------------- UNTUK SETUJU START ----------------------
          function getCurrentDateTime() {
              var now = new Date();
              var year = now.getFullYear();
              var month = (now.getMonth() + 1).toString().padStart(2, '0');
              var day = now.getDate().toString().padStart(2, '0');
              var hours = now.getHours().toString().padStart(2, '0');
              var minutes = now.getMinutes().toString().padStart(2, '0');
              var seconds = now.getSeconds().toString().padStart(2, '0');

              return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
          }

          $('.btnSimpan1').off('click').on('click', async function () {

              var msg = "";

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function (evt) {
                  console.log("Button clicked");
                  evt.preventDefault();
                  saveAndUploadFilePembuka();
                  $('#saveConfirmationModal1').modal('hide'); // Hide the modal

                  // Include selected values in the object
                  var newPengesahan = {
                      mohonPengesahan: {
                          setujuPengesahan: $('#confirmSaveButton1').val(),
                          tarikhPengesahan: getCurrentDateTime(),
                          namapinjPengesahan: $('#namastafPinjaman').val(),
                          nopinjPengesahan: sessionStorage.getItem('nopinjPinjaman'),
                          bilPengesahan: sessionStorage.getItem('bilPinjaman'),
                          emailPengesahan: sessionStorage.getItem('emailPinjaman'),
                          butiranPengesahan: sessionStorage.getItem('butiranPinjaman'),
                          //kategoriPengesahan: sessionStorage.getItem('kategoriPinjaman'),
                          kategoriPengesahan: $('#kategoriPinjaman').val(),
                          NoStafPeminjam: $('#nostafPeminjam').val(),
                      }
                  }

                  var result = JSON.parse(await ajaxSavePengesahan(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      tbl11.ajax.reload();
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
              });

              function saveAndUploadFilePembuka() {

                  var fileInput = document.getElementById("uploadDokumen");
                  var file = fileInput.files[0];

                  console.log("file:", file);

                  var fileSize = file.size;
                  var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (5MB)

                  if (fileSize > maxSize) {
                      showModalLampiran("Saiz Fail Besar", "Saiz fail melebihi had maksimum 5MB.");
                      return;
                  }

                  var fileName = file.name;
                  var fileExtension = fileName.split('.').pop().toLowerCase();
                  console.log("fileName:", fileName);

                  var formData = new FormData();
                  debugger;
                  formData.append("file", file);
                  formData.append("fileName", fileName);
                  formData.append("nopinjPengesahan", sessionStorage.getItem('nopinjPinjaman'));
                  formData.append("butiranPengesahan", $('#jenisPinjaman').val()),
                      formData.append("nostafPengesahan", $('#nostafPinjaman').val()),
                      formData.append("bilanganPengesahan", sessionStorage.getItem('bilPinjaman'));

                  $.ajax({
                      url: '<%= ResolveClientUrl("~/FORMS/PINJAMAN/PENGESAHAN PENJAMIN/PengesahanPenjamin_WS.asmx/SaveAndUploadFileUlasan") %>',
                     data: formData,
                     cache: false,
                     contentType: false,
                     type: 'POST',
                     processData: false,
                     success: function (response) {
                         tbl11.ajax.reload();
                     },
                     error: function () {
                     }
                 });
             }

         });

          async function ajaxSavePengesahan(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'PengesahanPenjamin_WS.asmx/Save_Pengesahan',
                      method: 'POST',
                      data: JSON.stringify(mohonPengesahan),
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

          function showModal1(title, message, type) {
              $('#resultModalTitle1').text(title);
              $('#resultModalMessage1').text(message);
              if (type === "success") {
                  $('#resultModal1').removeClass("modal-error").addClass("modal-success");
              } else if (type === "error") {
                  $('#resultModal1').removeClass("modal-success").addClass("modal-error");
              }
              $('#resultModal1').modal('show');
          }
          // ---------------------- UNTUK SETUJU END ------------------------
          // ---------------------- UNTUK TIDAK SETUJU START ----------------
          function getCurrentDateTime() {
              var now = new Date();
              var year = now.getFullYear();
              var month = (now.getMonth() + 1).toString().padStart(2, '0');
              var day = now.getDate().toString().padStart(2, '0');
              var hours = now.getHours().toString().padStart(2, '0');
              var minutes = now.getMinutes().toString().padStart(2, '0');
              var seconds = now.getSeconds().toString().padStart(2, '0');

              return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
          }

          $('.btnSimpan2').off('click').on('click', async function () {
              var msg = "";

              var msg = "Anda pasti ingin untuk tidak bersutuju?";
              $('#confirmationMessage2').text(msg);
              $('#saveConfirmationModal2').modal('show');

              $('#confirmSaveButton2').off('click').on('click', async function () {
                  $('#saveConfirmationModal2').modal('hide'); // Hide the modal

                  // Include selected values in the object
                  var newPengesahan = {
                      mohonPengesahan: {
                          setujuPengesahan: $('#confirmSaveButton2').val(),
                          tarikhPengesahan: getCurrentDateTime(),
                          namapinjPengesahan: $('#namastafPinjaman').val(),
                          nopinjPengesahan: sessionStorage.getItem('nopinjPinjaman'),
                          bilPengesahan: sessionStorage.getItem('bilPinjaman'),
                          emailPengesahan: sessionStorage.getItem('emailPinjaman'),
                          butiranPengesahan: sessionStorage.getItem('Butiran'),
                          kategoriPengesahan: $('#kategoriPinjaman').val(),
                      }
                  }

                  var result = JSON.parse(await ajaxSavePengesahan(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
                  tbl11.ajax.reload();
                  // Save No_Mohon which will be used later on other tabs
                  //sessionStorage.setItem("nombor_mohon", result.Payload.txtNoMohon);
              });
          });

          async function ajaxSavePengesahan(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'PengesahanPenjamin_WS.asmx/Save_Pengesahan',
                      method: 'POST',
                      data: JSON.stringify(mohonPengesahan),
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

          function showModal1(title, message, type) {
              $('#resultModalTitle1').text(title);
              $('#resultModalMessage1').text(message);
              if (type === "success") {
                  $('#resultModal1').removeClass("modal-error").addClass("modal-success");
              } else if (type === "error") {
                  $('#resultModal1').removeClass("modal-success").addClass("modal-error");
              }
              $('#resultModal1').modal('show');
          }
          // ---------------------- UNTUK TIDAK SETUJU END ------------------
          function showModalAndReadSessionData() {



              var modalElement = document.getElementById('permohonan');
              var modal = new bootstrap.Modal(modalElement, {
                  backdrop: 'static',
                  dataBackdrop: 'false'
              });


              btnHome.style.visibility = 'visible';
              btnSignOut.style.visibility = 'visible';
              btnClose.style.visibility = 'hidden';


              var iconElement = document.createElement('i');

              iconElement.classList.add("fa", "fa-home");

              // Clear the existing content of btnModalLulus and append the iconElement
              btnHome.innerHTML = '';
              btnHome.appendChild(iconElement);
              // Set visibility of btnHome to 'visible'
              btnHome.style.visibility = 'visible';


              var iconElement2 = document.createElement('i');

              iconElement2.classList.add("fa", "fa-sign-out");


              // Clear the existing content of btnModalLulus and append the iconElement
              btnSignOut.innerHTML = '';
              btnSignOut.appendChild(iconElement2);

              modalElement.classList.add('modal-background');
              modal.show();

              // Call the function to read session data
              readSessionData();
          }
          function readSessionData() {
              $.ajax({
                  type: "POST",
                  url: '<%= ResolveUrl("~/FORMS/JURNAL/JURNAL KEWANGAN/Transaksi_WS.asmx/GetSessionData") %>',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     //console.log("Session data:", response.d);

                     var id = response.d;

                     // Find the DataTable instance
                     var table = $("#tblPenjamin").DataTable();
                     // tbl.ajax.reload()
                     // Search for the row with the matching No_Mohon value
                     var matchedRow = table.rows().data().filter(function (row) {
                         //alert("id " + id)
                         return row.NoPinjaman2 === id;


                     });
                     debugger
                     if (matchedRow.length > 0) {
                         // Access the first matched row's data
                         var rowData = matchedRow[0];

                         // Update the modal content with the No_Mohon and Tujuan values
                         $("#nostafPinjaman").val(rowData.NoStaf || ' - ');
                         $("#nostafPeminjam").val(rowData.NoStafPeminjam || ' - ');
                         $("#namastafPinjaman").val(rowData.NamaPeminjam || ' - ');
                         $("#jawatanPinjaman").val(rowData.Jawatan || ' - ');
                         $("#jabatanPinjaman").val(rowData.Jabatan || ' - ');
                         $("#jenisPinjaman").val(rowData.Butiran || ' - ');
                         $("#jenisPinjaman2").val(rowData.Butiran || ' - ');
                         $("#kategoriPinjaman").val(rowData.KategoriPinjaman || ' - ');
                         $("#kategoriPinjaman2").val(rowData.KategoriPinjaman || ' - ');
                         $("#kategoriPinjaman3").val(rowData.KategoriPinjaman || ' - ');
                         $("#modelPinjaman").val(rowData.ModelKenderaan || ' - ');
                         $("#sukatanPinjaman").val(rowData.SukatanSilinder || ' - ');
                         $("#chasisPinjaman").val(rowData.NoCasis || ' - ');
                         $("#buatanPinjaman").val(rowData.BuatanKenderaan || ' - ');
                         $("#enjinPinjaman").val(rowData.NoEnjin || ' - ');
                         $("#jenamaPinjaman").val(rowData.Jenama || ' - ');
                         $("#ingatanPinjaman").val(rowData.Ingatan || ' - ');
                         $("#pemacucakeraPinjaman").val(rowData.PemacuCakera || ' - ');
                         $("#modemPinjaman").val(rowData.Modem || ' - ');
                         $("#kadbunyiPinjaman").val(rowData.KadBunyi || ' - ');
                         $("#tetikusPinjaman").val(rowData.Tetikus || ' - ');
                         $("#nosirikomputerPinjaman").val(rowData.NoSiriKomputer || ' - ');
                         $("#monitorPinjaman").val(rowData.Monitor || ' - ');
                         $("#namapencetakPinjaman").val(rowData.NamaPencetak || ' - ');
                         $("#papankekunciPinjaman").val(rowData.PapanKekunci || ' - ');
                         $("#cakerakerasPinjaman").val(rowData.CakeraKeras || ' - ');
                         $("#jenispinjkompPinjaman").val(rowData.JenisPinjamanKomputer || ' - ');
                         $("#jenissukanPinjaman").val(rowData.JenisSukan || ' - ');
                         $("#hargaKenderaan").val(rowData.HargaKenderaan);
                         $("#hargaKomputer").val(rowData.HargaKomputer);
                         $("#hargaSukan").val(rowData.HargaSukan);
                         $("#hargaMohon1").val(rowData.HargaMohon);
                         $("#hargaMohon2").val(rowData.HargaMohon);
                         $("#hargaMohon3").val(rowData.HargaMohon);
                         $("#namastafPinjamanLabel").text(rowData.NamaPeminjam || ' - ');
                         $("#kategoriPinjamanLabel").text(rowData.KategoriPinjaman || ' - ');
                         sessionStorage.setItem('nopinjPinjaman', rowData.NoPinjaman2)
                         sessionStorage.setItem('bilPinjaman', rowData.Bilangan)
                         sessionStorage.setItem('emailPinjaman', rowData.EmailPeminjam)
                         toggleFieldsetVisibility();
                         toggleFieldsetVisibility2();

                     } else {
                         console.log("No row found with ID:", id);
                     }

                     //$('#tblDataSenarai_trans').dataTable().fnDestroy();

                     // Handle the session data received from the server as needed
                 },
                 error: function (xhr, status, error) {
                     console.error("Error reading session:", error);
                     // Handle errors
                 }
             });
          }



          function handleCheckboxChange() {
              var checkbox = document.getElementById("flexCheckDefault");
              var fileInput = document.getElementById("uploadDokumen");
              var fileErrorMessage = document.getElementById("fileErrorMessage");

              if (checkbox.checked) {
                  fileInput.disabled = false;
                  fileErrorMessage.textContent = "Jenis fail yang dibenarkan: .pdf only";
                  fileErrorMessage.textContent = "Jenis fail yang dibenarkan: .pdf only";
              } else {
                  fileInput.disabled = true;
                  fileInput.value = ''; // Clear file input
                  fileErrorMessage.textContent = "Anda mesti bersetuju untuk memuat naik salinan kad pengenalan";
              }
          }
          document.addEventListener("DOMContentLoaded", function () {
              var fileInput = document.getElementById("uploadDokumen");
              var setujuButton = document.getElementById("btnSimpan1");

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
      </Script>

      <script>
         $('#btnHome').click(async function () {
             var resolvedUrl = '<%= ResolveClientUrl("~/index.aspx") %>';
         window.location.href = resolvedUrl;
         })     
         $('#btnSignOut').click(async function () {
         var resolvedUrl = '<%= ResolveClientUrl("~/FORMS/Logout.aspx") %>';
             window.location.href = resolvedUrl;
         })
      </script>
   </contenttemplate>
</asp:Content>